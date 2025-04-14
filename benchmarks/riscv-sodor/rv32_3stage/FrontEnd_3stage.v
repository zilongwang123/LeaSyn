module FrontEnd_3stage(
  input         clock,
  input         reset,
  input         io_cpu_req_valid,
  input  [31:0] io_cpu_req_bits_pc,
  input         io_cpu_resp_ready,
  output        io_cpu_resp_valid,
  output [31:0] io_cpu_resp_bits_pc,
  output [31:0] io_cpu_resp_bits_inst,
  input         io_cpu_exe_kill,
  input         io_imem_req_ready,
  output        io_imem_req_valid,
  output [31:0] io_imem_req_bits_addr,
  input         io_imem_resp_valid,
  input  [31:0] io_imem_resp_bits_data,
  input  [31:0] io_reset_vector
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  if_buffer_out_clock; // @[Decoupled.scala 361:21]
  wire  if_buffer_out_reset; // @[Decoupled.scala 361:21]
  wire  if_buffer_out_io_enq_ready; // @[Decoupled.scala 361:21]
  wire  if_buffer_out_io_enq_valid; // @[Decoupled.scala 361:21]
  wire [31:0] if_buffer_out_io_enq_bits_data; // @[Decoupled.scala 361:21]
  wire  if_buffer_out_io_deq_ready; // @[Decoupled.scala 361:21]
  wire  if_buffer_out_io_deq_valid; // @[Decoupled.scala 361:21]
  wire [31:0] if_buffer_out_io_deq_bits_data; // @[Decoupled.scala 361:21]
  wire [31:0] _if_reg_pc_T_1 = io_reset_vector - 32'h4; // @[frontend.scala 89:48]
  reg [31:0] if_reg_pc; // @[frontend.scala 89:31]
  reg  exe_reg_valid; // @[frontend.scala 91:31]
  reg [31:0] exe_reg_pc; // @[frontend.scala 92:27]
  reg [31:0] exe_reg_inst; // @[frontend.scala 93:27]
  wire [31:0] if_pc_plus4 = if_reg_pc + 32'h4; // @[frontend.scala 101:33]
  reg  if_redirected; // @[frontend.scala 104:31]
  reg [31:0] if_redirected_pc; // @[frontend.scala 105:30]
  wire  _if_val_next_T = ~io_imem_resp_valid; // @[frontend.scala 111:63]
  wire  if_buffer_in_ready = if_buffer_out_io_enq_ready; // @[frontend.scala 108:27 Decoupled.scala 365:17]
  wire  if_val_next = io_cpu_resp_ready | if_buffer_in_ready & ~io_imem_resp_valid; // @[frontend.scala 111:37]
  wire  _GEN_0 = io_cpu_req_valid | if_redirected; // @[frontend.scala 118:4 120:21 104:31]
  reg  if_reg_pc_responded; // @[frontend.scala 129:37]
  wire  if_pc_responsed = if_reg_pc_responded | io_imem_resp_valid; // @[frontend.scala 130:46]
  wire  _T_6 = io_cpu_resp_ready & io_imem_req_ready & if_pc_responsed; // @[frontend.scala 131:49]
  wire  _T_7 = ~io_cpu_req_valid; // @[frontend.scala 135:13]
  wire  _GEN_4 = io_imem_resp_valid | if_reg_pc_responded; // @[frontend.scala 140:4 141:27 129:37]
  Queue_21_3stage if_buffer_out ( // @[Decoupled.scala 361:21]
    .clock(if_buffer_out_clock),
    .reset(if_buffer_out_reset),
    .io_enq_ready(if_buffer_out_io_enq_ready),
    .io_enq_valid(if_buffer_out_io_enq_valid),
    .io_enq_bits_data(if_buffer_out_io_enq_bits_data),
    .io_deq_ready(if_buffer_out_io_deq_ready),
    .io_deq_valid(if_buffer_out_io_deq_valid),
    .io_deq_bits_data(if_buffer_out_io_deq_bits_data)
  );
  assign io_cpu_resp_valid = exe_reg_valid; // @[frontend.scala 167:26]
  assign io_cpu_resp_bits_pc = exe_reg_pc; // @[frontend.scala 169:26]
  assign io_cpu_resp_bits_inst = exe_reg_inst; // @[frontend.scala 168:26]
  assign io_imem_req_valid = if_val_next & _T_7; // @[frontend.scala 146:41]
  assign io_imem_req_bits_addr = if_redirected ? if_redirected_pc : if_pc_plus4; // @[frontend.scala 116:15 124:4 125:18]
  assign if_buffer_out_clock = clock;
  assign if_buffer_out_reset = reset;
  assign if_buffer_out_io_enq_valid = io_imem_resp_valid; // @[frontend.scala 108:27 109:23]
  assign if_buffer_out_io_enq_bits_data = io_imem_resp_bits_data; // @[frontend.scala 108:27 110:22]
  assign if_buffer_out_io_deq_ready = io_cpu_resp_ready; // @[frontend.scala 152:24]
  always @(posedge clock) begin
    if (reset) begin // @[frontend.scala 89:31]
      if_reg_pc <= _if_reg_pc_T_1; // @[frontend.scala 89:31]
    end else if (_T_6) begin // @[frontend.scala 132:4]
      if (if_redirected) begin // @[frontend.scala 124:4]
        if_reg_pc <= if_redirected_pc; // @[frontend.scala 125:18]
      end else begin
        if_reg_pc <= if_pc_plus4; // @[frontend.scala 116:15]
      end
    end
    if (reset) begin // @[frontend.scala 91:31]
      exe_reg_valid <= 1'h0; // @[frontend.scala 91:31]
    end else if (io_cpu_exe_kill) begin // @[frontend.scala 154:4]
      exe_reg_valid <= 1'h0; // @[frontend.scala 155:21]
    end else if (io_cpu_resp_ready) begin // @[frontend.scala 158:4]
      exe_reg_valid <= if_buffer_out_io_deq_valid & _T_7 & ~if_redirected; // @[frontend.scala 159:21]
    end
    if (!(io_cpu_exe_kill)) begin // @[frontend.scala 154:4]
      if (io_cpu_resp_ready) begin // @[frontend.scala 158:4]
        exe_reg_pc <= if_reg_pc; // @[frontend.scala 160:21]
      end
    end
    if (!(io_cpu_exe_kill)) begin // @[frontend.scala 154:4]
      if (io_cpu_resp_ready) begin // @[frontend.scala 158:4]
        exe_reg_inst <= if_buffer_out_io_deq_bits_data; // @[frontend.scala 161:21]
      end
    end
    if (reset) begin // @[frontend.scala 104:31]
      if_redirected <= 1'h0; // @[frontend.scala 104:31]
    end else if (_T_6) begin // @[frontend.scala 132:4]
      if (_T_7) begin // @[frontend.scala 136:7]
        if_redirected <= 1'h0; // @[frontend.scala 137:24]
      end else begin
        if_redirected <= _GEN_0;
      end
    end else begin
      if_redirected <= _GEN_0;
    end
    if (io_cpu_req_valid) begin // @[frontend.scala 118:4]
      if_redirected_pc <= io_cpu_req_bits_pc; // @[frontend.scala 121:24]
    end
    if (reset) begin // @[frontend.scala 129:37]
      if_reg_pc_responded <= 1'h0; // @[frontend.scala 129:37]
    end else if (_T_6) begin // @[frontend.scala 132:4]
      if_reg_pc_responded <= 1'h0; // @[frontend.scala 133:27]
    end else begin
      if_reg_pc_responded <= _GEN_4;
    end
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(if_buffer_in_ready | _if_val_next_T) & ~reset) begin
          $fatal; // @[frontend.scala 112:10]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~(if_buffer_in_ready | _if_val_next_T)) begin
          $fwrite(32'h80000002,
            "Assertion failed: Inst buffer overflow\n    at frontend.scala:112 assert(if_buffer_in.ready || !if_buffer_in.valid, \"Inst buffer overflow\")\n"
            ); // @[frontend.scala 112:10]
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
  if_reg_pc = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  exe_reg_valid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  exe_reg_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  exe_reg_inst = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  if_redirected = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  if_redirected_pc = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  if_reg_pc_responded = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule