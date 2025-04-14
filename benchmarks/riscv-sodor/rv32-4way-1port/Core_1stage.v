module Core_1stage(
  input         clock,
  input         reset,
  input         io_interrupt_debug,
  input  [31:0] io_reset_vector
);
  wire  c_io_dat_imiss; // @[core.scala 41:18]
  wire  c_io_dat_csr_interrupt; // @[core.scala 41:18]
  wire  c_io_dat_inst_misaligned; // @[core.scala 41:18]
  wire  c_io_ctl_stall; // @[core.scala 41:18]
  wire  c_io_ctl_dmiss; // @[core.scala 41:18]
  wire [2:0] c_io_ctl_pc_sel; // @[core.scala 41:18]
  wire  c_io_ctl_exception; // @[core.scala 41:18]
  wire [31:0] c_io_ctl_exception_cause; // @[core.scala 41:18]
  wire [2:0] c_io_ctl_pc_sel_no_xept; // @[core.scala 41:18]
  wire  d_clock; // @[core.scala 42:18]
  wire  d_reset; // @[core.scala 42:18]
  wire  d_io_imem_req_valid; // @[core.scala 42:18]
  wire  d_io_ctl_stall; // @[core.scala 42:18]
  wire [2:0] d_io_ctl_pc_sel; // @[core.scala 42:18]
  wire  d_io_ctl_exception; // @[core.scala 42:18]
  wire [31:0] d_io_ctl_exception_cause; // @[core.scala 42:18]
  wire [2:0] d_io_ctl_pc_sel_no_xept; // @[core.scala 42:18]
  wire  d_io_dat_imiss; // @[core.scala 42:18]
  wire  d_io_dat_csr_interrupt; // @[core.scala 42:18]
  wire  d_io_dat_inst_misaligned; // @[core.scala 42:18]
  wire  d_io_interrupt_debug; // @[core.scala 42:18]
  wire [31:0] d_io_reset_vector; // @[core.scala 42:18]
  CtlPath_1stage CtlPath_1stage ( // @[core.scala 41:18]
    .io_dat_imiss(c_io_dat_imiss),
    .io_dat_csr_interrupt(c_io_dat_csr_interrupt),
    .io_dat_inst_misaligned(c_io_dat_inst_misaligned),
    .io_ctl_stall(c_io_ctl_stall),
    .io_ctl_dmiss(c_io_ctl_dmiss),
    .io_ctl_pc_sel(c_io_ctl_pc_sel),
    .io_ctl_exception(c_io_ctl_exception),
    .io_ctl_exception_cause(c_io_ctl_exception_cause),
    .io_ctl_pc_sel_no_xept(c_io_ctl_pc_sel_no_xept)
  );
  DatPath_1stage DatPath_1stage ( // @[core.scala 42:18]
    .clock(d_clock),
    .reset(d_reset),
    .io_imem_req_valid(d_io_imem_req_valid),
    .io_ctl_stall(d_io_ctl_stall),
    .io_ctl_pc_sel(d_io_ctl_pc_sel),
    .io_ctl_exception(d_io_ctl_exception),
    .io_ctl_exception_cause(d_io_ctl_exception_cause),
    .io_ctl_pc_sel_no_xept(d_io_ctl_pc_sel_no_xept),
    .io_dat_imiss(d_io_dat_imiss),
    .io_dat_csr_interrupt(d_io_dat_csr_interrupt),
    .io_dat_inst_misaligned(d_io_dat_inst_misaligned),
    .io_interrupt_debug(d_io_interrupt_debug),
    .io_reset_vector(d_io_reset_vector)
  );
  assign c_io_dat_imiss = d_io_dat_imiss; // @[core.scala 44:13]
  assign c_io_dat_csr_interrupt = d_io_dat_csr_interrupt; // @[core.scala 44:13]
  assign c_io_dat_inst_misaligned = d_io_dat_inst_misaligned; // @[core.scala 44:13]
  assign d_clock = clock;
  assign d_reset = reset;
  assign d_io_ctl_stall = c_io_ctl_stall; // @[core.scala 43:13]
  assign d_io_ctl_pc_sel = c_io_ctl_pc_sel; // @[core.scala 43:13]
  assign d_io_ctl_exception = c_io_ctl_exception; // @[core.scala 43:13]
  assign d_io_ctl_exception_cause = c_io_ctl_exception_cause; // @[core.scala 43:13]
  assign d_io_ctl_pc_sel_no_xept = c_io_ctl_pc_sel_no_xept; // @[core.scala 43:13]
  assign d_io_interrupt_debug = io_interrupt_debug; // @[core.scala 58:18]
  assign d_io_reset_vector = io_reset_vector; // @[core.scala 60:21]
endmodule