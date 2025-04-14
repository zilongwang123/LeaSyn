module CtlPath_2stage(
  input        io_dat_csr_interrupt,
  output [2:0] io_ctl_pc_sel,
  output       io_ctl_exception
);
  wire [2:0] ctrl_pc_sel_no_xept = io_dat_csr_interrupt ? 3'h4 : 3'h0; // @[cpath.scala 124:34]
  assign io_ctl_pc_sel = io_ctl_exception ? 3'h4 : ctrl_pc_sel_no_xept; // @[cpath.scala 135:25]
  assign io_ctl_exception = 1'h0; // @[cpath.scala 171:86]
endmodule