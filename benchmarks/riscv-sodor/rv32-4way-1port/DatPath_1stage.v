module DatPath_1stage(
  input         clock,
  input         reset,
  output        io_imem_req_valid,
  input         io_ctl_stall,
  input  [2:0]  io_ctl_pc_sel,
  input         io_ctl_exception,
  input  [31:0] io_ctl_exception_cause,
  input  [2:0]  io_ctl_pc_sel_no_xept,
  output        io_dat_imiss,
  output        io_dat_csr_interrupt,
  output        io_dat_inst_misaligned,
  input         io_interrupt_debug,
  input  [31:0] io_reset_vector
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  csr_clock; // @[dpath.scala 194:20]
  wire  csr_reset; // @[dpath.scala 194:20]
  wire  csr_io_ungated_clock; // @[dpath.scala 194:20]
  wire  csr_io_interrupts_debug; // @[dpath.scala 194:20]
  wire  csr_io_csr_stall; // @[dpath.scala 194:20]
  wire  csr_io_singleStep; // @[dpath.scala 194:20]
  wire  csr_io_status_cease; // @[dpath.scala 194:20]
  wire [31:0] csr_io_evec; // @[dpath.scala 194:20]
  wire  csr_io_exception; // @[dpath.scala 194:20]
  wire  csr_io_retire; // @[dpath.scala 194:20]
  wire [31:0] csr_io_cause; // @[dpath.scala 194:20]
  wire [31:0] csr_io_time; // @[dpath.scala 194:20]
  wire  csr_io_interrupt; // @[dpath.scala 194:20]
  wire [31:0] csr_io_interrupt_cause; // @[dpath.scala 194:20]
  wire  _pc_next_T = io_ctl_pc_sel == 3'h0; // @[dpath.scala 67:34]
  wire  _pc_next_T_1 = io_ctl_pc_sel == 3'h1; // @[dpath.scala 68:34]
  wire  _pc_next_T_2 = io_ctl_pc_sel == 3'h2; // @[dpath.scala 69:34]
  wire  _pc_next_T_3 = io_ctl_pc_sel == 3'h3; // @[dpath.scala 70:34]
  wire  _pc_next_T_4 = io_ctl_pc_sel == 3'h4; // @[dpath.scala 71:34]
  wire [31:0] exception_target = csr_io_evec; // @[dpath.scala 204:21 63:31]
  reg [31:0] pc_reg; // @[dpath.scala 74:24]
  wire [31:0] pc_plus4 = pc_reg + 32'h4; // @[dpath.scala 81:24]
  wire [31:0] _pc_next_T_5 = _pc_next_T_4 ? exception_target : pc_plus4; // @[Mux.scala 101:16]
  wire [31:0] _pc_next_T_6 = _pc_next_T_3 ? 32'h0 : _pc_next_T_5; // @[Mux.scala 101:16]
  wire [32:0] _jmp_target_T = {{1'd0}, pc_reg}; // @[dpath.scala 190:30]
  wire [31:0] jmp_target = _jmp_target_T[31:0]; // @[dpath.scala 190:30]
  wire [31:0] _pc_next_T_7 = _pc_next_T_2 ? jmp_target : _pc_next_T_6; // @[Mux.scala 101:16]
  wire  _T = ~io_ctl_stall; // @[dpath.scala 76:10]
  wire  _T_3 = ~reset; // @[dpath.scala 89:13]
  wire  _io_dat_inst_misaligned_T_1 = |jmp_target[1:0]; // @[dpath.scala 102:48]
  wire  _io_dat_inst_misaligned_T_7 = _io_dat_inst_misaligned_T_1 & io_ctl_pc_sel_no_xept == 3'h2; // @[dpath.scala 103:58]
  reg  reg_interrupt_edge; // @[dpath.scala 214:36]
  wire [31:0] _T_8 = csr_io_time; // @[dpath.scala 258:18]
  wire [7:0] _T_9 = io_ctl_stall ? 8'h53 : 8'h20; // @[dpath.scala 269:10]
  wire [7:0] _T_11 = 3'h1 == io_ctl_pc_sel ? 8'h42 : 8'h3f; // @[Mux.scala 81:58]
  wire [7:0] _T_13 = 3'h2 == io_ctl_pc_sel ? 8'h4a : _T_11; // @[Mux.scala 81:58]
  wire [7:0] _T_15 = 3'h3 == io_ctl_pc_sel ? 8'h52 : _T_13; // @[Mux.scala 81:58]
  wire [7:0] _T_17 = 3'h4 == io_ctl_pc_sel ? 8'h45 : _T_15; // @[Mux.scala 81:58]
  wire [7:0] _T_19 = 3'h0 == io_ctl_pc_sel ? 8'h20 : _T_17; // @[Mux.scala 81:58]
  wire [7:0] _T_20 = csr_io_exception ? 8'h58 : 8'h20; // @[dpath.scala 276:10]
  CSRFile_1stage CSRFile_1stage ( // @[dpath.scala 194:20]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_ungated_clock(csr_io_ungated_clock),
    .io_interrupts_debug(csr_io_interrupts_debug),
    .io_csr_stall(csr_io_csr_stall),
    .io_singleStep(csr_io_singleStep),
    .io_status_cease(csr_io_status_cease),
    .io_evec(csr_io_evec),
    .io_exception(csr_io_exception),
    .io_retire(csr_io_retire),
    .io_cause(csr_io_cause),
    .io_time(csr_io_time),
    .io_interrupt(csr_io_interrupt),
    .io_interrupt_cause(csr_io_interrupt_cause)
  );
  assign io_imem_req_valid = 1'h1; // @[dpath.scala 96:25]
  assign io_dat_imiss = io_imem_req_valid; // @[dpath.scala 85:39]
  assign io_dat_csr_interrupt = csr_io_interrupt & ~reg_interrupt_edge; // @[dpath.scala 218:39]
  assign io_dat_inst_misaligned = |jmp_target[1:0] & io_ctl_pc_sel_no_xept == 3'h1 | _io_dat_inst_misaligned_T_7; // @[dpath.scala 102:94]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_ungated_clock = clock; // @[dpath.scala 226:25]
  assign csr_io_interrupts_debug = io_interrupt_debug; // @[dpath.scala 222:22]
  assign csr_io_exception = io_ctl_exception; // @[dpath.scala 202:21]
  assign csr_io_retire = ~(io_ctl_stall | io_ctl_exception); // @[dpath.scala 201:24]
  assign csr_io_cause = io_ctl_exception ? io_ctl_exception_cause : csr_io_interrupt_cause; // @[dpath.scala 225:23]
  always @(posedge clock) begin
    if (reset) begin // @[dpath.scala 74:24]
      pc_reg <= io_reset_vector; // @[dpath.scala 74:24]
    end else if (_T) begin // @[dpath.scala 77:4]
      if (_pc_next_T) begin // @[Mux.scala 101:16]
        pc_reg <= pc_plus4;
      end else if (_pc_next_T_1) begin // @[Mux.scala 101:16]
        pc_reg <= jmp_target;
      end else begin
        pc_reg <= _pc_next_T_7;
      end
    end
    if (reset) begin // @[dpath.scala 214:36]
      reg_interrupt_edge <= 1'h0; // @[dpath.scala 214:36]
    end else if (_T) begin // @[dpath.scala 215:25]
      reg_interrupt_edge <= csr_io_interrupt; // @[dpath.scala 216:26]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_3) begin
          $fwrite(32'h80000002,
            "Cyc= %d [%d] pc=[%x] W[r%d=%x][%d] Op1=[r%d][%x] Op2=[r%d][%x] inst=[%x] %c%c%c DASM(%x)\n",_T_8,
            csr_io_retire,pc_reg,5'h0,32'h0,1'h0,5'h0,32'h0,5'h0,32'h0,32'h0,_T_9,_T_19,_T_20,32'h0); // @[dpath.scala 257:10]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_interrupt_edge = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule