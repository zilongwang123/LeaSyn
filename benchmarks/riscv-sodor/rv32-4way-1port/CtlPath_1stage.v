module CtlPath_1stage(
  input         io_dat_imiss,
  input         io_dat_csr_interrupt,
  input         io_dat_inst_misaligned,
  output        io_ctl_stall,
  output        io_ctl_dmiss,
  output [2:0]  io_ctl_pc_sel,
  output        io_ctl_exception,
  output [31:0] io_ctl_exception_cause,
  output [2:0]  io_ctl_pc_sel_no_xept
);
  wire [2:0] ctrl_pc_sel_no_xept = io_dat_csr_interrupt ? 3'h4 : 3'h0; // @[cpath.scala 120:34]
  wire [2:0] _io_ctl_exception_cause_T_1 = io_dat_inst_misaligned ? 3'h0 : 3'h4; // @[cpath.scala 184:34]
  assign io_ctl_stall = io_dat_imiss | io_ctl_dmiss; // @[cpath.scala 145:30]
  assign io_ctl_dmiss = 1'h0; // @[cpath.scala 144:20]
  assign io_ctl_pc_sel = io_ctl_exception ? 3'h4 : ctrl_pc_sel_no_xept; // @[cpath.scala 131:25]
  assign io_ctl_exception = io_dat_inst_misaligned; // @[cpath.scala 182:58]
  assign io_ctl_exception_cause = {{29'd0}, _io_ctl_exception_cause_T_1}; // @[cpath.scala 183:27]
  assign io_ctl_pc_sel_no_xept = io_dat_csr_interrupt ? 3'h4 : 3'h0; // @[cpath.scala 120:34]
endmodule
