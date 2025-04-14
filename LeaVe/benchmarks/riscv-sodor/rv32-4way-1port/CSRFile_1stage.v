module CSRFile_1stage(
  input         clock,
  input         reset,
  input         io_ungated_clock,
  input         io_interrupts_debug,
  output        io_csr_stall,
  output        io_singleStep,
  output        io_status_cease,
  output [31:0] io_evec,
  input         io_exception,
  input         io_retire,
  input  [31:0] io_cause,
  output [31:0] io_time,
  output        io_interrupt,
  output [31:0] io_interrupt_cause
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  reg_debug; // @[CSR.scala 449:22]
  reg  reg_singleStepped; // @[CSR.scala 453:30]
  reg [2:0] reg_mcountinhibit; // @[CSR.scala 547:34]
  wire  x86 = ~io_csr_stall; // @[CSR.scala 551:56]
  reg [5:0] small_1; // @[Counters.scala 45:37]
  wire [5:0] _GEN_35 = {{5'd0}, x86}; // @[Counters.scala 46:33]
  wire [6:0] nextSmall_1 = small_1 + _GEN_35; // @[Counters.scala 46:33]
  wire  _T_15 = ~reg_mcountinhibit[0]; // @[Counters.scala 47:9]
  wire [6:0] _GEN_2 = ~reg_mcountinhibit[0] ? nextSmall_1 : {{1'd0}, small_1}; // @[Counters.scala 47:{19,27} 45:37]
  reg [57:0] large_1; // @[Counters.scala 50:27]
  wire [57:0] _large_r_T_3 = large_1 + 58'h1; // @[Counters.scala 51:55]
  wire [63:0] value_1 = {large_1,small_1}; // @[Cat.scala 31:58]
  wire [14:0] d_interrupts = {io_interrupts_debug, 14'h0}; // @[CSR.scala 572:42]
  wire  anyInterrupt = d_interrupts[14] | d_interrupts[13] | d_interrupts[12] | d_interrupts[11] | d_interrupts[3] |
    d_interrupts[7] | d_interrupts[9] | d_interrupts[1] | d_interrupts[5] | d_interrupts[10] | d_interrupts[2] |
    d_interrupts[6] | d_interrupts[8] | d_interrupts[0] | d_interrupts[4]; // @[CSR.scala 1534:90]
  wire [3:0] _which_T_112 = d_interrupts[0] ? 4'h0 : 4'h4; // @[Mux.scala 47:70]
  wire [3:0] _which_T_113 = d_interrupts[8] ? 4'h8 : _which_T_112; // @[Mux.scala 47:70]
  wire [3:0] _which_T_114 = d_interrupts[6] ? 4'h6 : _which_T_113; // @[Mux.scala 47:70]
  wire [3:0] _which_T_115 = d_interrupts[2] ? 4'h2 : _which_T_114; // @[Mux.scala 47:70]
  wire [3:0] _which_T_116 = d_interrupts[10] ? 4'ha : _which_T_115; // @[Mux.scala 47:70]
  wire [3:0] _which_T_117 = d_interrupts[5] ? 4'h5 : _which_T_116; // @[Mux.scala 47:70]
  wire [3:0] _which_T_118 = d_interrupts[1] ? 4'h1 : _which_T_117; // @[Mux.scala 47:70]
  wire [3:0] _which_T_119 = d_interrupts[9] ? 4'h9 : _which_T_118; // @[Mux.scala 47:70]
  wire [3:0] _which_T_120 = d_interrupts[7] ? 4'h7 : _which_T_119; // @[Mux.scala 47:70]
  wire [3:0] _which_T_121 = d_interrupts[3] ? 4'h3 : _which_T_120; // @[Mux.scala 47:70]
  wire [3:0] _which_T_122 = d_interrupts[11] ? 4'hb : _which_T_121; // @[Mux.scala 47:70]
  wire [3:0] _which_T_123 = d_interrupts[12] ? 4'hc : _which_T_122; // @[Mux.scala 47:70]
  wire [3:0] _which_T_124 = d_interrupts[13] ? 4'hd : _which_T_123; // @[Mux.scala 47:70]
  wire [3:0] whichInterrupt = d_interrupts[14] ? 4'he : _which_T_124; // @[Mux.scala 47:70]
  wire [31:0] _GEN_40 = {{28'd0}, whichInterrupt}; // @[CSR.scala 582:67]
  wire  _io_interrupt_T = ~io_singleStep; // @[CSR.scala 583:36]
  wire  _io_decode_0_read_illegal_T_16 = ~reg_debug; // @[CSR.scala 861:45]
  wire [7:0] cause_lsbs = io_cause[7:0]; // @[CSR.scala 895:25]
  wire  _causeIsDebugInt_T_1 = cause_lsbs == 8'he; // @[CSR.scala 896:53]
  wire  causeIsDebugInt = io_cause[31] & cause_lsbs == 8'he; // @[CSR.scala 896:39]
  wire  causeIsDebugTrigger = ~io_cause[31] & _causeIsDebugInt_T_1; // @[CSR.scala 897:44]
  wire  trapToDebug = reg_singleStepped | causeIsDebugInt | causeIsDebugTrigger | reg_debug; // @[CSR.scala 899:123]
  wire [11:0] debugTVec = reg_debug ? 12'h808 : 12'h800; // @[CSR.scala 902:22]
  wire [1:0] _T_216 = {{1'd0}, io_exception}; // @[Bitwise.scala 48:55]
  wire [2:0] _T_218 = {{1'd0}, _T_216}; // @[Bitwise.scala 48:55]
  wire  _T_222 = ~reset; // @[CSR.scala 954:9]
  wire  _GEN_48 = io_retire | io_exception | reg_singleStepped; // @[CSR.scala 453:30 960:{36,56}]
  wire  _GEN_51 = _io_decode_0_read_illegal_T_16 | reg_debug; // @[CSR.scala 969:25 971:19 449:22]
  wire [31:0] _GEN_315 = {{29'd0}, reg_mcountinhibit}; // @[CSR.scala 1148:18 547:34]
  wire [63:0] _GEN_316 = {{57'd0}, _GEN_2}; // @[CSR.scala 1148:18]
  assign io_csr_stall = io_status_cease; // @[CSR.scala 1091:27]
  assign io_singleStep = 1'h0; // @[CSR.scala 934:34]
  assign io_status_cease = 1'h0; // @[CSR.scala 1092:19]
  assign io_evec = trapToDebug ? {{20'd0}, debugTVec} : 32'h0; // @[CSR.scala 928:17]
  assign io_time = value_1[31:0]; // @[CSR.scala 1090:11]
  assign io_interrupt = (anyInterrupt & ~io_singleStep | reg_singleStepped) & ~(reg_debug | io_status_cease); // @[CSR.scala 583:73]
  assign io_interrupt_cause = 32'h80000000 + _GEN_40; // @[CSR.scala 582:67]
  always @(posedge clock) begin
    if (reset) begin // @[CSR.scala 449:22]
      reg_debug <= 1'h0; // @[CSR.scala 449:22]
    end else if (io_exception) begin // @[CSR.scala 967:20]
      if (trapToDebug) begin // @[CSR.scala 968:24]
        reg_debug <= _GEN_51;
      end
    end
    if (_io_interrupt_T) begin // @[CSR.scala 961:25]
      reg_singleStepped <= 1'h0; // @[CSR.scala 961:45]
    end else begin
      reg_singleStepped <= _GEN_48;
    end
    if (reset) begin // @[CSR.scala 547:34]
      reg_mcountinhibit <= 3'h0; // @[CSR.scala 547:34]
    end else begin
      reg_mcountinhibit <= _GEN_315[2:0];
    end
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_T_218 <= 3'h1) & ~reset) begin
          $fatal; // @[CSR.scala 954:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~(_T_218 <= 3'h1)) begin
          $fwrite(32'h80000002,
            "Assertion failed: these conditions must be mutually exclusive\n    at CSR.scala:954 assert(PopCount(insn_ret :: insn_call :: insn_break :: io.exception :: Nil) <= 1, \"these conditions must be mutually exclusive\")\n"
            ); // @[CSR.scala 954:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(~reg_singleStepped | ~io_retire) & _T_222) begin
          $fatal; // @[CSR.scala 963:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_222 & ~(~reg_singleStepped | ~io_retire)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at CSR.scala:963 assert(!reg_singleStepped || io.retire === UInt(0))\n"); // @[CSR.scala 963:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
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
  reg_debug = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_singleStepped = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  reg_mcountinhibit = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  small_1 = _RAND_3[5:0];
  _RAND_4 = {2{`RANDOM}};
  large_1 = _RAND_4[57:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule