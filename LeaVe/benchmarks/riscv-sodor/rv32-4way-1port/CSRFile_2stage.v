module CSRFile_2stage(
  input         clock,
  input         reset,
  input         io_ungated_clock,
  input         io_interrupts_debug,
  output        io_csr_stall,
  output        io_singleStep,
  output        io_status_cease,
  input         io_exception,
  input         io_retire,
  output [31:0] io_time,
  output        io_interrupt
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] reg_mcountinhibit; // @[CSR.scala 547:34]
  wire  x86 = ~io_csr_stall; // @[CSR.scala 551:56]
  reg [5:0] small_1; // @[Counters.scala 45:37]
  wire [5:0] _GEN_34 = {{5'd0}, x86}; // @[Counters.scala 46:33]
  wire [6:0] nextSmall_1 = small_1 + _GEN_34; // @[Counters.scala 46:33]
  wire  _T_15 = ~reg_mcountinhibit[0]; // @[Counters.scala 47:9]
  wire [6:0] _GEN_2 = ~reg_mcountinhibit[0] ? nextSmall_1 : {{1'd0}, small_1}; // @[Counters.scala 47:{19,27} 45:37]
  reg [57:0] large_1; // @[Counters.scala 50:27]
  wire [57:0] _large_r_T_3 = large_1 + 58'h1; // @[Counters.scala 51:55]
  wire [63:0] value_1 = {large_1,small_1}; // @[Cat.scala 31:58]
  wire [14:0] d_interrupts = {io_interrupts_debug, 14'h0}; // @[CSR.scala 572:42]
  wire  anyInterrupt = d_interrupts[14] | d_interrupts[13] | d_interrupts[12] | d_interrupts[11] | d_interrupts[3] |
    d_interrupts[7] | d_interrupts[9] | d_interrupts[1] | d_interrupts[5] | d_interrupts[10] | d_interrupts[2] |
    d_interrupts[6] | d_interrupts[8] | d_interrupts[0] | d_interrupts[4]; // @[CSR.scala 1534:90]
  wire [31:0] _GEN_315 = {{29'd0}, reg_mcountinhibit}; // @[CSR.scala 1148:18 547:34]
  wire [63:0] _GEN_316 = {{57'd0}, _GEN_2}; // @[CSR.scala 1148:18]
  assign io_csr_stall = io_status_cease; // @[CSR.scala 1091:27]
  assign io_singleStep = 1'h0; // @[CSR.scala 934:34]
  assign io_status_cease = 1'h0; // @[CSR.scala 1092:19]
  assign io_time = value_1[31:0]; // @[CSR.scala 1090:11]
  assign io_interrupt = anyInterrupt & ~io_singleStep & ~io_status_cease; // @[CSR.scala 583:73]
  always @(posedge clock) begin
    if (reset) begin // @[CSR.scala 547:34]
      reg_mcountinhibit <= 3'h0; // @[CSR.scala 547:34]
    end else begin
      reg_mcountinhibit <= _GEN_315[2:0];
    end
  end
  always @(posedge io_ungated_clock) begin
    if (reset) begin // @[Counters.scala 45:37]
      small_1 <= 6'h0; // @[Counters.scala 45:37]
    end else begin
      small_1 <= _GEN_316[5:0];
    end
    if (reset) begin // @[Counters.scala 50:27]
      large_1 <= 58'h0; // @[Counters.scala 50:27]
    end else if (nextSmall_1[6] & _T_15) begin // @[Counters.scala 51:46]
      large_1 <= _large_r_T_3; // @[Counters.scala 51:50]
    end
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
  reg_mcountinhibit = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  small_1 = _RAND_1[5:0];
  _RAND_2 = {2{`RANDOM}};
  large_1 = _RAND_2[57:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule