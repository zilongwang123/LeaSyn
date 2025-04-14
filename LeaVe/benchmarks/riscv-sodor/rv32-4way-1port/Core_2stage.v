module Core_2stage(
  input   clock,
  input   reset,
  input   io_interrupt_debug
);
  wire  c_io_dat_csr_interrupt; // @[core.scala 39:18]
  wire [2:0] c_io_ctl_pc_sel; // @[core.scala 39:18]
  wire  c_io_ctl_exception; // @[core.scala 39:18]
  wire  d_clock; // @[core.scala 40:18]
  wire  d_reset; // @[core.scala 40:18]
  wire [2:0] d_io_ctl_pc_sel; // @[core.scala 40:18]
  wire  d_io_dat_csr_interrupt; // @[core.scala 40:18]
  wire  d_io_interrupt_debug; // @[core.scala 40:18]
  CtlPath_2stage CtlPath_2stage ( // @[core.scala 39:18]
    .io_dat_csr_interrupt(c_io_dat_csr_interrupt),
    .io_ctl_pc_sel(c_io_ctl_pc_sel),
    .io_ctl_exception(c_io_ctl_exception)
  );
  DatPath_2stage DatPath_2stage ( // @[core.scala 40:18]
    .clock(d_clock),
    .reset(d_reset),
    .io_ctl_pc_sel(d_io_ctl_pc_sel),
    .io_dat_csr_interrupt(d_io_dat_csr_interrupt),
    .io_interrupt_debug(d_io_interrupt_debug)
  );
  assign c_io_dat_csr_interrupt = d_io_dat_csr_interrupt; // @[core.scala 43:13]
  assign d_clock = clock;
  assign d_reset = reset;
  assign d_io_ctl_pc_sel = c_io_ctl_pc_sel; // @[core.scala 42:13]
  assign d_io_interrupt_debug = io_interrupt_debug; // @[core.scala 57:18]
endmodule