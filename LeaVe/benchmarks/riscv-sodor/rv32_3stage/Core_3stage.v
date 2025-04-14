module Core_3stage(
  input         clock,
  input         reset,
  input         io_imem_req_ready,
  output        io_imem_req_valid,
  output [31:0] io_imem_req_bits_addr,
  input         io_imem_resp_valid,
  input  [31:0] io_imem_resp_bits_data,
  input         io_dmem_req_ready,
  output        io_dmem_req_valid,
  output [31:0] io_dmem_req_bits_addr,
  output [31:0] io_dmem_req_bits_data,
  output        io_dmem_req_bits_fcn,
  output [2:0]  io_dmem_req_bits_typ,
  input         io_dmem_resp_valid,
  input  [31:0] io_dmem_resp_bits_data,
  input         io_interrupt_debug,
  input         io_interrupt_mtip,
  input         io_interrupt_msip,
  input         io_interrupt_meip,
  input         io_hartid,
  input  [31:0] io_reset_vector
);
  wire  frontend_clock; // @[core.scala 30:24]
  wire  frontend_reset; // @[core.scala 30:24]
  wire  frontend_io_cpu_req_valid; // @[core.scala 30:24]
  wire [31:0] frontend_io_cpu_req_bits_pc; // @[core.scala 30:24]
  wire  frontend_io_cpu_resp_ready; // @[core.scala 30:24]
  wire  frontend_io_cpu_resp_valid; // @[core.scala 30:24]
  wire [31:0] frontend_io_cpu_resp_bits_pc; // @[core.scala 30:24]
  wire [31:0] frontend_io_cpu_resp_bits_inst; // @[core.scala 30:24]
  wire  frontend_io_cpu_exe_kill; // @[core.scala 30:24]
  wire  frontend_io_imem_req_ready; // @[core.scala 30:24]
  wire  frontend_io_imem_req_valid; // @[core.scala 30:24]
  wire [31:0] frontend_io_imem_req_bits_addr; // @[core.scala 30:24]
  wire  frontend_io_imem_resp_valid; // @[core.scala 30:24]
  wire [31:0] frontend_io_imem_resp_bits_data; // @[core.scala 30:24]
  wire [31:0] frontend_io_reset_vector; // @[core.scala 30:24]
  wire  cpath_clock; // @[core.scala 31:22]
  wire  cpath_reset; // @[core.scala 31:22]
  wire  cpath_io_imem_req_valid; // @[core.scala 31:22]
  wire  cpath_io_imem_resp_valid; // @[core.scala 31:22]
  wire [31:0] cpath_io_imem_resp_bits_inst; // @[core.scala 31:22]
  wire  cpath_io_imem_exe_kill; // @[core.scala 31:22]
  wire  cpath_io_dat_br_eq; // @[core.scala 31:22]
  wire  cpath_io_dat_br_lt; // @[core.scala 31:22]
  wire  cpath_io_dat_br_ltu; // @[core.scala 31:22]
  wire  cpath_io_dat_inst_misaligned; // @[core.scala 31:22]
  wire  cpath_io_dat_data_misaligned; // @[core.scala 31:22]
  wire  cpath_io_dat_wb_hazard_stall; // @[core.scala 31:22]
  wire  cpath_io_dat_csr_eret; // @[core.scala 31:22]
  wire  cpath_io_dat_csr_interrupt; // @[core.scala 31:22]
  wire  cpath_io_ctl_exe_kill; // @[core.scala 31:22]
  wire [2:0] cpath_io_ctl_pc_sel; // @[core.scala 31:22]
  wire  cpath_io_ctl_brjmp_sel; // @[core.scala 31:22]
  wire [1:0] cpath_io_ctl_op1_sel; // @[core.scala 31:22]
  wire [1:0] cpath_io_ctl_op2_sel; // @[core.scala 31:22]
  wire [3:0] cpath_io_ctl_alu_fun; // @[core.scala 31:22]
  wire [1:0] cpath_io_ctl_wb_sel; // @[core.scala 31:22]
  wire  cpath_io_ctl_rf_wen; // @[core.scala 31:22]
  wire  cpath_io_ctl_bypassable; // @[core.scala 31:22]
  wire [2:0] cpath_io_ctl_csr_cmd; // @[core.scala 31:22]
  wire  cpath_io_ctl_dmem_val; // @[core.scala 31:22]
  wire  cpath_io_ctl_dmem_fcn; // @[core.scala 31:22]
  wire [2:0] cpath_io_ctl_dmem_typ; // @[core.scala 31:22]
  wire  cpath_io_ctl_exception; // @[core.scala 31:22]
  wire [31:0] cpath_io_ctl_exception_cause; // @[core.scala 31:22]
  wire  dpath_clock; // @[core.scala 32:22]
  wire  dpath_reset; // @[core.scala 32:22]
  wire [31:0] dpath_io_imem_req_bits_pc; // @[core.scala 32:22]
  wire  dpath_io_imem_resp_ready; // @[core.scala 32:22]
  wire  dpath_io_imem_resp_valid; // @[core.scala 32:22]
  wire [31:0] dpath_io_imem_resp_bits_pc; // @[core.scala 32:22]
  wire [31:0] dpath_io_imem_resp_bits_inst; // @[core.scala 32:22]
  wire  dpath_io_dmem_req_ready; // @[core.scala 32:22]
  wire  dpath_io_dmem_req_valid; // @[core.scala 32:22]
  wire [31:0] dpath_io_dmem_req_bits_addr; // @[core.scala 32:22]
  wire [31:0] dpath_io_dmem_req_bits_data; // @[core.scala 32:22]
  wire  dpath_io_dmem_req_bits_fcn; // @[core.scala 32:22]
  wire [2:0] dpath_io_dmem_req_bits_typ; // @[core.scala 32:22]
  wire  dpath_io_dmem_resp_valid; // @[core.scala 32:22]
  wire [31:0] dpath_io_dmem_resp_bits_data; // @[core.scala 32:22]
  wire  dpath_io_ctl_exe_kill; // @[core.scala 32:22]
  wire [2:0] dpath_io_ctl_pc_sel; // @[core.scala 32:22]
  wire  dpath_io_ctl_brjmp_sel; // @[core.scala 32:22]
  wire [1:0] dpath_io_ctl_op1_sel; // @[core.scala 32:22]
  wire [1:0] dpath_io_ctl_op2_sel; // @[core.scala 32:22]
  wire [3:0] dpath_io_ctl_alu_fun; // @[core.scala 32:22]
  wire [1:0] dpath_io_ctl_wb_sel; // @[core.scala 32:22]
  wire  dpath_io_ctl_rf_wen; // @[core.scala 32:22]
  wire  dpath_io_ctl_bypassable; // @[core.scala 32:22]
  wire [2:0] dpath_io_ctl_csr_cmd; // @[core.scala 32:22]
  wire  dpath_io_ctl_dmem_val; // @[core.scala 32:22]
  wire  dpath_io_ctl_dmem_fcn; // @[core.scala 32:22]
  wire [2:0] dpath_io_ctl_dmem_typ; // @[core.scala 32:22]
  wire  dpath_io_ctl_exception; // @[core.scala 32:22]
  wire [31:0] dpath_io_ctl_exception_cause; // @[core.scala 32:22]
  wire  dpath_io_dat_br_eq; // @[core.scala 32:22]
  wire  dpath_io_dat_br_lt; // @[core.scala 32:22]
  wire  dpath_io_dat_br_ltu; // @[core.scala 32:22]
  wire  dpath_io_dat_inst_misaligned; // @[core.scala 32:22]
  wire  dpath_io_dat_data_misaligned; // @[core.scala 32:22]
  wire  dpath_io_dat_wb_hazard_stall; // @[core.scala 32:22]
  wire  dpath_io_dat_csr_eret; // @[core.scala 32:22]
  wire  dpath_io_dat_csr_interrupt; // @[core.scala 32:22]
  wire  dpath_io_interrupt_debug; // @[core.scala 32:22]
  wire  dpath_io_interrupt_mtip; // @[core.scala 32:22]
  wire  dpath_io_interrupt_msip; // @[core.scala 32:22]
  wire  dpath_io_interrupt_meip; // @[core.scala 32:22]
  wire  dpath_io_hartid; // @[core.scala 32:22]
  FrontEnd_3stage frontend ( // @[core.scala 30:24]
    .clock(frontend_clock),
    .reset(frontend_reset),
    .io_cpu_req_valid(frontend_io_cpu_req_valid),
    .io_cpu_req_bits_pc(frontend_io_cpu_req_bits_pc),
    .io_cpu_resp_ready(frontend_io_cpu_resp_ready),
    .io_cpu_resp_valid(frontend_io_cpu_resp_valid),
    .io_cpu_resp_bits_pc(frontend_io_cpu_resp_bits_pc),
    .io_cpu_resp_bits_inst(frontend_io_cpu_resp_bits_inst),
    .io_cpu_exe_kill(frontend_io_cpu_exe_kill),
    .io_imem_req_ready(frontend_io_imem_req_ready),
    .io_imem_req_valid(frontend_io_imem_req_valid),
    .io_imem_req_bits_addr(frontend_io_imem_req_bits_addr),
    .io_imem_resp_valid(frontend_io_imem_resp_valid),
    .io_imem_resp_bits_data(frontend_io_imem_resp_bits_data),
    .io_reset_vector(frontend_io_reset_vector)
  );
  CtlPath_3stage cpath ( // @[core.scala 31:22]
    .clock(cpath_clock),
    .reset(cpath_reset),
    .io_imem_req_valid(cpath_io_imem_req_valid),
    .io_imem_resp_valid(cpath_io_imem_resp_valid),
    .io_imem_resp_bits_inst(cpath_io_imem_resp_bits_inst),
    .io_imem_exe_kill(cpath_io_imem_exe_kill),
    .io_dat_br_eq(cpath_io_dat_br_eq),
    .io_dat_br_lt(cpath_io_dat_br_lt),
    .io_dat_br_ltu(cpath_io_dat_br_ltu),
    .io_dat_inst_misaligned(cpath_io_dat_inst_misaligned),
    .io_dat_data_misaligned(cpath_io_dat_data_misaligned),
    .io_dat_wb_hazard_stall(cpath_io_dat_wb_hazard_stall),
    .io_dat_csr_eret(cpath_io_dat_csr_eret),
    .io_dat_csr_interrupt(cpath_io_dat_csr_interrupt),
    .io_ctl_exe_kill(cpath_io_ctl_exe_kill),
    .io_ctl_pc_sel(cpath_io_ctl_pc_sel),
    .io_ctl_brjmp_sel(cpath_io_ctl_brjmp_sel),
    .io_ctl_op1_sel(cpath_io_ctl_op1_sel),
    .io_ctl_op2_sel(cpath_io_ctl_op2_sel),
    .io_ctl_alu_fun(cpath_io_ctl_alu_fun),
    .io_ctl_wb_sel(cpath_io_ctl_wb_sel),
    .io_ctl_rf_wen(cpath_io_ctl_rf_wen),
    .io_ctl_bypassable(cpath_io_ctl_bypassable),
    .io_ctl_csr_cmd(cpath_io_ctl_csr_cmd),
    .io_ctl_dmem_val(cpath_io_ctl_dmem_val),
    .io_ctl_dmem_fcn(cpath_io_ctl_dmem_fcn),
    .io_ctl_dmem_typ(cpath_io_ctl_dmem_typ),
    .io_ctl_exception(cpath_io_ctl_exception),
    .io_ctl_exception_cause(cpath_io_ctl_exception_cause)
  );
  DatPath_3stage dpath ( // @[core.scala 32:22]
    .clock(dpath_clock),
    .reset(dpath_reset),
    .io_imem_req_bits_pc(dpath_io_imem_req_bits_pc),
    .io_imem_resp_ready(dpath_io_imem_resp_ready),
    .io_imem_resp_valid(dpath_io_imem_resp_valid),
    .io_imem_resp_bits_pc(dpath_io_imem_resp_bits_pc),
    .io_imem_resp_bits_inst(dpath_io_imem_resp_bits_inst),
    .io_dmem_req_ready(dpath_io_dmem_req_ready),
    .io_dmem_req_valid(dpath_io_dmem_req_valid),
    .io_dmem_req_bits_addr(dpath_io_dmem_req_bits_addr),
    .io_dmem_req_bits_data(dpath_io_dmem_req_bits_data),
    .io_dmem_req_bits_fcn(dpath_io_dmem_req_bits_fcn),
    .io_dmem_req_bits_typ(dpath_io_dmem_req_bits_typ),
    .io_dmem_resp_valid(dpath_io_dmem_resp_valid),
    .io_dmem_resp_bits_data(dpath_io_dmem_resp_bits_data),
    .io_ctl_exe_kill(dpath_io_ctl_exe_kill),
    .io_ctl_pc_sel(dpath_io_ctl_pc_sel),
    .io_ctl_brjmp_sel(dpath_io_ctl_brjmp_sel),
    .io_ctl_op1_sel(dpath_io_ctl_op1_sel),
    .io_ctl_op2_sel(dpath_io_ctl_op2_sel),
    .io_ctl_alu_fun(dpath_io_ctl_alu_fun),
    .io_ctl_wb_sel(dpath_io_ctl_wb_sel),
    .io_ctl_rf_wen(dpath_io_ctl_rf_wen),
    .io_ctl_bypassable(dpath_io_ctl_bypassable),
    .io_ctl_csr_cmd(dpath_io_ctl_csr_cmd),
    .io_ctl_dmem_val(dpath_io_ctl_dmem_val),
    .io_ctl_dmem_fcn(dpath_io_ctl_dmem_fcn),
    .io_ctl_dmem_typ(dpath_io_ctl_dmem_typ),
    .io_ctl_exception(dpath_io_ctl_exception),
    .io_ctl_exception_cause(dpath_io_ctl_exception_cause),
    .io_dat_br_eq(dpath_io_dat_br_eq),
    .io_dat_br_lt(dpath_io_dat_br_lt),
    .io_dat_br_ltu(dpath_io_dat_br_ltu),
    .io_dat_inst_misaligned(dpath_io_dat_inst_misaligned),
    .io_dat_data_misaligned(dpath_io_dat_data_misaligned),
    .io_dat_wb_hazard_stall(dpath_io_dat_wb_hazard_stall),
    .io_dat_csr_eret(dpath_io_dat_csr_eret),
    .io_dat_csr_interrupt(dpath_io_dat_csr_interrupt),
    .io_interrupt_debug(dpath_io_interrupt_debug),
    .io_interrupt_mtip(dpath_io_interrupt_mtip),
    .io_interrupt_msip(dpath_io_interrupt_msip),
    .io_interrupt_meip(dpath_io_interrupt_meip),
    .io_hartid(dpath_io_hartid)
  );
  assign io_imem_req_valid = frontend_io_imem_req_valid; // @[core.scala 35:20]
  assign io_imem_req_bits_addr = frontend_io_imem_req_bits_addr; // @[core.scala 35:20]
  assign io_dmem_req_valid = dpath_io_dmem_req_valid; // @[core.scala 45:17]
  assign io_dmem_req_bits_addr = dpath_io_dmem_req_bits_addr; // @[core.scala 45:17]
  assign io_dmem_req_bits_data = dpath_io_dmem_req_bits_data; // @[core.scala 45:17]
  assign io_dmem_req_bits_fcn = dpath_io_dmem_req_bits_fcn; // @[core.scala 45:17]
  assign io_dmem_req_bits_typ = dpath_io_dmem_req_bits_typ; // @[core.scala 45:17]
  assign frontend_clock = clock;
  assign frontend_reset = reset;
  assign frontend_io_cpu_req_valid = cpath_io_imem_req_valid; // @[core.scala 38:29]
  assign frontend_io_cpu_req_bits_pc = dpath_io_imem_req_bits_pc; // @[core.scala 37:19]
  assign frontend_io_cpu_resp_ready = dpath_io_imem_resp_ready; // @[core.scala 37:19]
  assign frontend_io_cpu_exe_kill = cpath_io_imem_exe_kill; // @[core.scala 39:28]
  assign frontend_io_imem_req_ready = io_imem_req_ready; // @[core.scala 35:20]
  assign frontend_io_imem_resp_valid = io_imem_resp_valid; // @[core.scala 35:20]
  assign frontend_io_imem_resp_bits_data = io_imem_resp_bits_data; // @[core.scala 35:20]
  assign frontend_io_reset_vector = io_reset_vector; // @[core.scala 34:28]
  assign cpath_clock = clock;
  assign cpath_reset = reset;
  assign cpath_io_imem_resp_valid = frontend_io_cpu_resp_valid; // @[core.scala 36:19]
  assign cpath_io_imem_resp_bits_inst = frontend_io_cpu_resp_bits_inst; // @[core.scala 36:19]
  assign cpath_io_dat_br_eq = dpath_io_dat_br_eq; // @[core.scala 42:17]
  assign cpath_io_dat_br_lt = dpath_io_dat_br_lt; // @[core.scala 42:17]
  assign cpath_io_dat_br_ltu = dpath_io_dat_br_ltu; // @[core.scala 42:17]
  assign cpath_io_dat_inst_misaligned = dpath_io_dat_inst_misaligned; // @[core.scala 42:17]
  assign cpath_io_dat_data_misaligned = dpath_io_dat_data_misaligned; // @[core.scala 42:17]
  assign cpath_io_dat_wb_hazard_stall = dpath_io_dat_wb_hazard_stall; // @[core.scala 42:17]
  assign cpath_io_dat_csr_eret = dpath_io_dat_csr_eret; // @[core.scala 42:17]
  assign cpath_io_dat_csr_interrupt = dpath_io_dat_csr_interrupt; // @[core.scala 42:17]
  assign dpath_clock = clock;
  assign dpath_reset = reset;
  assign dpath_io_imem_resp_valid = frontend_io_cpu_resp_valid; // @[core.scala 37:19]
  assign dpath_io_imem_resp_bits_pc = frontend_io_cpu_resp_bits_pc; // @[core.scala 37:19]
  assign dpath_io_imem_resp_bits_inst = frontend_io_cpu_resp_bits_inst; // @[core.scala 37:19]
  assign dpath_io_dmem_req_ready = io_dmem_req_ready; // @[core.scala 45:17]
  assign dpath_io_dmem_resp_valid = io_dmem_resp_valid; // @[core.scala 45:17]
  assign dpath_io_dmem_resp_bits_data = io_dmem_resp_bits_data; // @[core.scala 45:17]
  assign dpath_io_ctl_exe_kill = cpath_io_ctl_exe_kill; // @[core.scala 41:17]
  assign dpath_io_ctl_pc_sel = cpath_io_ctl_pc_sel; // @[core.scala 41:17]
  assign dpath_io_ctl_brjmp_sel = cpath_io_ctl_brjmp_sel; // @[core.scala 41:17]
  assign dpath_io_ctl_op1_sel = cpath_io_ctl_op1_sel; // @[core.scala 41:17]
  assign dpath_io_ctl_op2_sel = cpath_io_ctl_op2_sel; // @[core.scala 41:17]
  assign dpath_io_ctl_alu_fun = cpath_io_ctl_alu_fun; // @[core.scala 41:17]
  assign dpath_io_ctl_wb_sel = cpath_io_ctl_wb_sel; // @[core.scala 41:17]
  assign dpath_io_ctl_rf_wen = cpath_io_ctl_rf_wen; // @[core.scala 41:17]
  assign dpath_io_ctl_bypassable = cpath_io_ctl_bypassable; // @[core.scala 41:17]
  assign dpath_io_ctl_csr_cmd = cpath_io_ctl_csr_cmd; // @[core.scala 41:17]
  assign dpath_io_ctl_dmem_val = cpath_io_ctl_dmem_val; // @[core.scala 41:17]
  assign dpath_io_ctl_dmem_fcn = cpath_io_ctl_dmem_fcn; // @[core.scala 41:17]
  assign dpath_io_ctl_dmem_typ = cpath_io_ctl_dmem_typ; // @[core.scala 41:17]
  assign dpath_io_ctl_exception = cpath_io_ctl_exception; // @[core.scala 41:17]
  assign dpath_io_ctl_exception_cause = cpath_io_ctl_exception_cause; // @[core.scala 41:17]
  assign dpath_io_interrupt_debug = io_interrupt_debug; // @[core.scala 50:22]
  assign dpath_io_interrupt_mtip = io_interrupt_mtip; // @[core.scala 50:22]
  assign dpath_io_interrupt_msip = io_interrupt_msip; // @[core.scala 50:22]
  assign dpath_io_interrupt_meip = io_interrupt_meip; // @[core.scala 50:22]
  assign dpath_io_hartid = io_hartid; // @[core.scala 51:19]
endmodule