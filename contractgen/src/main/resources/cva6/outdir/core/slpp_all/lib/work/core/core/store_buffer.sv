// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Date: 25.04.2017
// Description: Store queue persists store requests and pushes them to memory
//              if they are no longer speculative


module store_buffer import ariane_pkg::*; #(
    parameter ariane_pkg::cva6_cfg_t CVA6Cfg = ariane_pkg::cva6_cfg_empty
) (
    input logic          clk_i,           // Clock
    input logic          rst_ni,          // Asynchronous reset active low
    input logic          flush_i,         // if we flush we need to pause the transactions on the memory
                                          // otherwise we will run in a deadlock with the memory arbiter
    input  logic         stall_st_pending_i, // Stall issuing non-speculative request
    output logic         no_st_pending_o, // non-speculative queue is empty (e.g.: everything is committed to the memory hierarchy)
    output logic         store_buffer_empty_o, // there is no store pending in neither the speculative unit or the non-speculative queue

    input  logic [11:0]  page_offset_i,         // check for the page offset (the last 12 bit if the current load matches them)
    output logic         page_offset_matches_o, // the above input page offset matches -> let the store buffer drain

    input  logic         commit_i,        // commit the instruction which was placed there most recently
    output logic         commit_ready_o,  // commit queue is ready to accept another commit request
    output logic         ready_o,         // the store queue is ready to accept a new request
                                          // it is only ready if it can unconditionally commit the instruction, e.g.:
                                          // the commit buffer needs to be empty
    input  logic         valid_i,         // this is a valid store
    input  logic         valid_without_flush_i, // just tell if the address is valid which we are current putting and do not take any further action

    input  logic [riscv::PLEN-1:0]  paddr_i,         // physical address of store which needs to be placed in the queue
    output [riscv::PLEN-1:0]        mem_paddr_o,
    input   logic [riscv::XLEN-1:0]             data_i,          // data which is placed in the queue
    input  logic [(riscv::XLEN/8)-1:0]   be_i,            // byte enable in
    input  logic [1:0]   data_size_i,     // type of request we are making (e.g.: bytes to write)

    // D$ interface
    input  dcache_req_o_t req_port_i,
    output dcache_req_i_t req_port_o
);
    localparam ENTRY_WIDTH = (riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2 + 1);

    // the store queue has two parts:
    // 1. Speculative queue
    // 2. Commit queue which is non-speculative, e.g.: the store will definitely happen.
    //struct packed {
    //    logic [riscv::PLEN-1:0]      address;
    //    logic [riscv::XLEN-1:0]      data;
    //    logic [(riscv::XLEN/8)-1:0]  be;
    //    logic [1:0]                  data_size;
    //    logic                        valid;     // this entry is valid, we need this for checking if the address offset matches
    //} speculative_queue_n [DEPTH_SPEC-1:0], speculative_queue_q [DEPTH_SPEC-1:0],
    //  commit_queue_n [DEPTH_COMMIT-1:0],    commit_queue_q [DEPTH_COMMIT-1:0];
	  
	logic [(ENTRY_WIDTH * DEPTH_SPEC)-1:0] speculative_queue_n;
	logic [(ENTRY_WIDTH * DEPTH_SPEC)-1:0] speculative_queue_q;
	
	logic [(ENTRY_WIDTH * DEPTH_COMMIT)-1:0] commit_queue_n;
	logic [(ENTRY_WIDTH * DEPTH_COMMIT)-1:0] commit_queue_q;
	
	logic [(riscv::PLEN * DEPTH_COMMIT)-1:0] temp_addresses_commit;
    always_comb begin : temp_c
        for (int i = 0; i < DEPTH_COMMIT; i++) begin
            temp_addresses_commit[((i + 1) * riscv::PLEN) - 1 : i * riscv::PLEN] = commit_queue_q[(i * ENTRY_WIDTH) + riscv::PLEN - 1: (i * ENTRY_WIDTH)];
        end
    end
    logic [(riscv::PLEN * DEPTH_SPEC)-1:0]      temp_addresses_spec;
    always_comb begin : temp_s    
        for (int i = 0; i < DEPTH_SPEC; i++) begin
            temp_addresses_spec[((i + 1) * riscv::PLEN) - 1 : i * riscv::PLEN] = speculative_queue_q[(i * ENTRY_WIDTH) + riscv::PLEN - 1: (i * ENTRY_WIDTH)];
        end
    end	
	
    // keep a status count for both buffers
    logic [$clog2(DEPTH_SPEC):0] speculative_status_cnt_n, speculative_status_cnt_q;
    logic [$clog2(DEPTH_COMMIT):0] commit_status_cnt_n, commit_status_cnt_q;
    // Speculative queue
    logic [$clog2(DEPTH_SPEC)-1:0] speculative_read_pointer_n,  speculative_read_pointer_q;
    logic [$clog2(DEPTH_SPEC)-1:0] speculative_write_pointer_n, speculative_write_pointer_q;
    // Commit Queue
    logic [$clog2(DEPTH_COMMIT)-1:0] commit_read_pointer_n,  commit_read_pointer_q;
    logic [$clog2(DEPTH_COMMIT)-1:0] commit_write_pointer_n, commit_write_pointer_q;

    assign store_buffer_empty_o = (speculative_status_cnt_q == 0) & no_st_pending_o;
    // ----------------------------------------
    // Speculative Queue - Core Interface
    // ----------------------------------------
    always_comb begin : core_if
        automatic logic [$clog2(DEPTH_SPEC):0] speculative_status_cnt;
        speculative_status_cnt = speculative_status_cnt_q;

        // we are ready if the speculative and the commit queue have a space left
        ready_o = (speculative_status_cnt_q < (DEPTH_SPEC - 1)) || commit_i;
        // default assignments
        speculative_status_cnt_n    = speculative_status_cnt_q;
        speculative_read_pointer_n  = speculative_read_pointer_q;
        speculative_write_pointer_n = speculative_write_pointer_q;
        speculative_queue_n         = speculative_queue_q;
        // LSU interface
        // we are ready to accept a new entry and the input data is valid
        if (valid_i) begin
            speculative_queue_n[(speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN - 1 : (speculative_write_pointer_q * ENTRY_WIDTH)]   = paddr_i;
            speculative_queue_n[(speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN - 1 : (speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN]      = data_i;
            speculative_queue_n[(speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) - 1 : (speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN]        = be_i;
            speculative_queue_n[(speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2 - 1 : (speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8)] = data_size_i;
            speculative_queue_n[(speculative_write_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2]   = 1'b1;
            // advance the write pointer
            speculative_write_pointer_n = speculative_write_pointer_q + 1'b1;
            speculative_status_cnt++;
        end

        // evict the current entry out of this queue, the commit queue will thankfully take it and commit it
        // to the memory hierarchy
        if (commit_i) begin
            // invalidate
            speculative_queue_n[(speculative_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2] = 1'b0;
            // advance the read pointer
            speculative_read_pointer_n = speculative_read_pointer_q + 1'b1;
            speculative_status_cnt--;
        end

        speculative_status_cnt_n = speculative_status_cnt;

        // when we flush evict the speculative stores
        if (flush_i) begin
            // reset all valid flags
            for (int unsigned i = 0; i < DEPTH_SPEC; i++)
                speculative_queue_n[(i * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2] = 1'b0;

            speculative_write_pointer_n = speculative_read_pointer_q;
            // also reset the status count
            speculative_status_cnt_n = 'b0;
        end
    end

    // ----------------------------------------
    // Commit Queue - Memory Interface
    // ----------------------------------------

    // we will never kill a request in the store buffer since we already know that the translation is valid
    // e.g.: a kill request will only be necessary if we are not sure if the requested memory address will result in a TLB fault
    assign req_port_o.kill_req  = 1'b0;
    assign req_port_o.data_we   = 1'b1; // we will always write in the store queue
    assign req_port_o.tag_valid = 1'b0;

    // we do not require an acknowledgement for writes, thus we do not need to identify uniquely the responses
    assign req_port_o.data_id       = '0;
    // those signals can directly be output to the memory
    //assign req_port_o.address_index = commit_queue_q[commit_read_pointer_q].address[ariane_pkg::DCACHE_INDEX_WIDTH-1:0];
    assign req_port_o.address_index = temp_addresses_commit[(commit_read_pointer_q * riscv::PLEN) + ariane_pkg::DCACHE_INDEX_WIDTH - 1 : (commit_read_pointer_q * riscv::PLEN)];
    // if we got a new request we already saved the tag from the previous cycle
    //assign req_port_o.address_tag   = commit_queue_q[commit_read_pointer_q].address[ariane_pkg::DCACHE_TAG_WIDTH     +
    //                                                                                ariane_pkg::DCACHE_INDEX_WIDTH-1 :
    //                                                                                ariane_pkg::DCACHE_INDEX_WIDTH];
    assign req_port_o.address_tag   = temp_addresses_commit[(commit_read_pointer_q * riscv::PLEN) + ariane_pkg::DCACHE_TAG_WIDTH + ariane_pkg::DCACHE_INDEX_WIDTH - 1 : (commit_read_pointer_q * riscv::PLEN) + ariane_pkg::DCACHE_INDEX_WIDTH];
    assign req_port_o.data_wdata    = commit_queue_q[(commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN - 1 : (commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN];
    assign req_port_o.data_be       = commit_queue_q[(commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) - 1 : (commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN];
    assign req_port_o.data_size     = commit_queue_q[(commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2 - 1 : (commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8)];

    assign mem_paddr_o              = commit_queue_n[(commit_read_pointer_n * ENTRY_WIDTH) + riscv::PLEN - 1 : (commit_read_pointer_n * ENTRY_WIDTH)];

	logic [ENTRY_WIDTH - 1 : 0] spec_queue_entry;
	assign spec_queue_entry = speculative_queue_q[(ENTRY_WIDTH * (commit_read_pointer_q + 1)) - 1 : (ENTRY_WIDTH * commit_read_pointer_q)];
	
    always_comb begin : store_if
        automatic logic [$clog2(DEPTH_COMMIT):0] commit_status_cnt;
        commit_status_cnt = commit_status_cnt_q;

        commit_ready_o = (commit_status_cnt_q < DEPTH_COMMIT);
        // no store is pending if we don't have any element in the commit queue e.g.: it is empty
        no_st_pending_o         = (commit_status_cnt_q == 0);
        // default assignments
        commit_read_pointer_n   = commit_read_pointer_q;
        commit_write_pointer_n  = commit_write_pointer_q;

        commit_queue_n = commit_queue_q;

        req_port_o.data_req     = 1'b0;

        // there should be no commit when we are flushing
        // if the entry in the commit queue is valid and not speculative anymore we can issue this instruction
        if (commit_queue_q[(commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2] && !stall_st_pending_i) begin
            req_port_o.data_req = 1'b1;
            if (req_port_i.data_gnt) begin
                // we can evict it from the commit buffer
                commit_queue_n[(commit_read_pointer_q * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2] = 1'b0;
                // advance the read_pointer
                commit_read_pointer_n = commit_read_pointer_q + 1'b1;
                commit_status_cnt--;
            end
        end
        // we ignore the rvalid signal for now as we assume that the store
        // happened if we got a grant

        // shift the store request from the speculative buffer to the non-speculative
        if (commit_i) begin
			commit_queue_n[((commit_write_pointer_q + 1) * ENTRY_WIDTH) - 1 : commit_write_pointer_q * ENTRY_WIDTH] = spec_queue_entry;
            commit_write_pointer_n = commit_write_pointer_n + 1'b1;
            commit_status_cnt++;
        end

        commit_status_cnt_n     = commit_status_cnt;
    end

    // ------------------
    // Address Checker
    // ------------------
    // The load should return the data stored by the most recent store to the
    // same physical address.  The most direct way to implement this is to
    // maintain physical addresses in the store buffer.

    // Of course, there are other micro-architectural techniques to accomplish
    // the same thing: you can interlock and wait for the store buffer to
    // drain if the load VA matches any store VA modulo the page size (i.e.
    // bits 11:0).  As a special case, it is correct to bypass if the full VA
    // matches, and no younger stores' VAs match in bits 11:0.
    //
    // checks if the requested load is in the store buffer
    // page offsets are virtually and physically the same
	
    always_comb begin : address_checker
        page_offset_matches_o = 1'b0;

        // check if the LSBs are identical and the entry is valid
        for (int unsigned i = 0; i < DEPTH_COMMIT; i++) begin
            //temp_address = commit_queue_q[i].address;
            // Check if the page offset matches and whether the entry is valid, for the commit queue
            if ((page_offset_i[11:3] == temp_addresses_commit[(i * riscv::PLEN) + 11 : (i * riscv::PLEN) + 3]) && commit_queue_q[(i * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2]) begin
                page_offset_matches_o = 1'b1;
                break;
            end
        end

        for (int unsigned i = 0; i < DEPTH_SPEC; i++) begin
            //temp_address = speculative_queue_q[i].address;
            // do the same for the speculative queue
            if ((page_offset_i[11:3] == temp_addresses_spec[(i * riscv::PLEN) + 11 : (i * riscv::PLEN) + 3]) && speculative_queue_q[(i * ENTRY_WIDTH) + riscv::PLEN + riscv::XLEN + (riscv::XLEN / 8) + 2]) begin
                page_offset_matches_o = 1'b1;
                break;
            end
        end
        // or it matches with the entry we are currently putting into the queue
        if ((page_offset_i[11:3] == paddr_i[11:3]) && valid_without_flush_i) begin
            page_offset_matches_o = 1'b1;
        end
    end


    // registers
    always_ff @(posedge clk_i or negedge rst_ni) begin : p_spec
        if (~rst_ni) begin
            speculative_queue_q         <= '{default: 0};
            speculative_read_pointer_q  <= '0;
            speculative_write_pointer_q <= '0;
            speculative_status_cnt_q    <= '0;
        end else begin
            speculative_queue_q         <= speculative_queue_n;
            speculative_read_pointer_q  <= speculative_read_pointer_n;
            speculative_write_pointer_q <= speculative_write_pointer_n;
            speculative_status_cnt_q    <= speculative_status_cnt_n;
        end
     end

    // registers
    always_ff @(posedge clk_i or negedge rst_ni) begin : p_commit
        if (~rst_ni) begin
            commit_queue_q              <= '{default: 0};
            commit_read_pointer_q       <= '0;
            commit_write_pointer_q      <= '0;
            commit_status_cnt_q         <= '0;
        end else begin
            commit_queue_q              <= commit_queue_n;
            commit_read_pointer_q       <= commit_read_pointer_n;
            commit_write_pointer_q      <= commit_write_pointer_n;
            commit_status_cnt_q         <= commit_status_cnt_n;
        end
     end

///////////////////////////////////////////////////////
// assertions
///////////////////////////////////////////////////////

    


















endmodule



