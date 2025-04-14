module DatPath_3stage(
  input         clock,
  input         reset,
  output [31:0] io_imem_req_bits_pc,
  output        io_imem_resp_ready,
  input         io_imem_resp_valid,
  input  [31:0] io_imem_resp_bits_pc,
  input  [31:0] io_imem_resp_bits_inst,
  input         io_dmem_req_ready,
  output        io_dmem_req_valid,
  output [31:0] io_dmem_req_bits_addr,
  output [31:0] io_dmem_req_bits_data,
  output        io_dmem_req_bits_fcn,
  output [2:0]  io_dmem_req_bits_typ,
  input         io_dmem_resp_valid,
  input  [31:0] io_dmem_resp_bits_data,
  input         io_ctl_exe_kill,
  input  [2:0]  io_ctl_pc_sel,
  input         io_ctl_brjmp_sel,
  input  [1:0]  io_ctl_op1_sel,
  input  [1:0]  io_ctl_op2_sel,
  input  [3:0]  io_ctl_alu_fun,
  input  [1:0]  io_ctl_wb_sel,
  input         io_ctl_rf_wen,
  input         io_ctl_bypassable,
  input  [2:0]  io_ctl_csr_cmd,
  input         io_ctl_dmem_val,
  input         io_ctl_dmem_fcn,
  input  [2:0]  io_ctl_dmem_typ,
  input         io_ctl_exception,
  input  [31:0] io_ctl_exception_cause,
  output        io_dat_br_eq,
  output        io_dat_br_lt,
  output        io_dat_br_ltu,
  output        io_dat_inst_misaligned,
  output        io_dat_data_misaligned,
  output        io_dat_wb_hazard_stall,
  output        io_dat_csr_eret,
  output        io_dat_csr_interrupt,
  input         io_interrupt_debug,
  input         io_interrupt_mtip,
  input         io_interrupt_msip,
  input         io_interrupt_meip,
  input         io_hartid
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regfile [0:31]; // @[dpath.scala 135:21]
  wire  regfile_io_ddpath_rdata_MPORT_en; // @[dpath.scala 135:21]
  wire [4:0] regfile_io_ddpath_rdata_MPORT_addr; // @[dpath.scala 135:21]
  wire [31:0] regfile_io_ddpath_rdata_MPORT_data; // @[dpath.scala 135:21]
  wire  regfile_rf_rs1_data_MPORT_en; // @[dpath.scala 135:21]
  wire [4:0] regfile_rf_rs1_data_MPORT_addr; // @[dpath.scala 135:21]
  wire [31:0] regfile_rf_rs1_data_MPORT_data; // @[dpath.scala 135:21]
  wire  regfile_rf_rs2_data_MPORT_en; // @[dpath.scala 135:21]
  wire [4:0] regfile_rf_rs2_data_MPORT_addr; // @[dpath.scala 135:21]
  wire [31:0] regfile_rf_rs2_data_MPORT_data; // @[dpath.scala 135:21]
  wire [31:0] regfile_MPORT_data; // @[dpath.scala 135:21]
  wire [4:0] regfile_MPORT_addr; // @[dpath.scala 135:21]
  wire  regfile_MPORT_mask; // @[dpath.scala 135:21]
  wire  regfile_MPORT_en; // @[dpath.scala 135:21]
  wire [31:0] regfile_MPORT_1_data; // @[dpath.scala 135:21]
  wire [4:0] regfile_MPORT_1_addr; // @[dpath.scala 135:21]
  wire  regfile_MPORT_1_mask; // @[dpath.scala 135:21]
  wire  regfile_MPORT_1_en; // @[dpath.scala 135:21]
  wire [3:0] alu_io_fn; // @[dpath.scala 190:20]
  wire [31:0] alu_io_in2; // @[dpath.scala 190:20]
  wire [31:0] alu_io_in1; // @[dpath.scala 190:20]
  wire [31:0] alu_io_out; // @[dpath.scala 190:20]
  wire [31:0] alu_io_adder_out; // @[dpath.scala 190:20]
  wire  csr_clock; // @[dpath.scala 259:20]
  wire  csr_reset; // @[dpath.scala 259:20]
  wire  csr_io_ungated_clock; // @[dpath.scala 259:20]
  wire  csr_io_interrupts_debug; // @[dpath.scala 259:20]
  wire  csr_io_interrupts_mtip; // @[dpath.scala 259:20]
  wire  csr_io_interrupts_msip; // @[dpath.scala 259:20]
  wire  csr_io_interrupts_meip; // @[dpath.scala 259:20]
  wire  csr_io_hartid; // @[dpath.scala 259:20]
  wire [11:0] csr_io_rw_addr; // @[dpath.scala 259:20]
  wire [2:0] csr_io_rw_cmd; // @[dpath.scala 259:20]
  wire [31:0] csr_io_rw_rdata; // @[dpath.scala 259:20]
  wire [31:0] csr_io_rw_wdata; // @[dpath.scala 259:20]
  wire  csr_io_csr_stall; // @[dpath.scala 259:20]
  wire  csr_io_eret; // @[dpath.scala 259:20]
  wire  csr_io_singleStep; // @[dpath.scala 259:20]
  wire  csr_io_status_debug; // @[dpath.scala 259:20]
  wire  csr_io_status_cease; // @[dpath.scala 259:20]
  wire  csr_io_status_wfi; // @[dpath.scala 259:20]
  wire [31:0] csr_io_status_isa; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_dprv; // @[dpath.scala 259:20]
  wire  csr_io_status_dv; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_prv; // @[dpath.scala 259:20]
  wire  csr_io_status_v; // @[dpath.scala 259:20]
  wire  csr_io_status_sd; // @[dpath.scala 259:20]
  wire [22:0] csr_io_status_zero2; // @[dpath.scala 259:20]
  wire  csr_io_status_mpv; // @[dpath.scala 259:20]
  wire  csr_io_status_gva; // @[dpath.scala 259:20]
  wire  csr_io_status_mbe; // @[dpath.scala 259:20]
  wire  csr_io_status_sbe; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_sxl; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_uxl; // @[dpath.scala 259:20]
  wire  csr_io_status_sd_rv32; // @[dpath.scala 259:20]
  wire [7:0] csr_io_status_zero1; // @[dpath.scala 259:20]
  wire  csr_io_status_tsr; // @[dpath.scala 259:20]
  wire  csr_io_status_tw; // @[dpath.scala 259:20]
  wire  csr_io_status_tvm; // @[dpath.scala 259:20]
  wire  csr_io_status_mxr; // @[dpath.scala 259:20]
  wire  csr_io_status_sum; // @[dpath.scala 259:20]
  wire  csr_io_status_mprv; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_xs; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_fs; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_mpp; // @[dpath.scala 259:20]
  wire [1:0] csr_io_status_vs; // @[dpath.scala 259:20]
  wire  csr_io_status_spp; // @[dpath.scala 259:20]
  wire  csr_io_status_mpie; // @[dpath.scala 259:20]
  wire  csr_io_status_ube; // @[dpath.scala 259:20]
  wire  csr_io_status_spie; // @[dpath.scala 259:20]
  wire  csr_io_status_upie; // @[dpath.scala 259:20]
  wire  csr_io_status_mie; // @[dpath.scala 259:20]
  wire  csr_io_status_hie; // @[dpath.scala 259:20]
  wire  csr_io_status_sie; // @[dpath.scala 259:20]
  wire  csr_io_status_uie; // @[dpath.scala 259:20]
  wire [31:0] csr_io_evec; // @[dpath.scala 259:20]
  wire  csr_io_exception; // @[dpath.scala 259:20]
  wire  csr_io_retire; // @[dpath.scala 259:20]
  wire [31:0] csr_io_cause; // @[dpath.scala 259:20]
  wire [31:0] csr_io_pc; // @[dpath.scala 259:20]
  wire [31:0] csr_io_tval; // @[dpath.scala 259:20]
  wire [31:0] csr_io_time; // @[dpath.scala 259:20]
  wire  csr_io_interrupt; // @[dpath.scala 259:20]
  wire [31:0] csr_io_interrupt_cause; // @[dpath.scala 259:20]
  reg [31:0] wb_reg_inst; // @[dpath.scala 61:34]
  reg  wb_reg_valid; // @[dpath.scala 62:34]
  reg [1:0] wb_reg_ctrl_wb_sel; // @[dpath.scala 63:30]
  reg  wb_reg_ctrl_rf_wen; // @[dpath.scala 63:30]
  reg  wb_reg_ctrl_bypassable; // @[dpath.scala 63:30]
  reg [2:0] wb_reg_ctrl_csr_cmd; // @[dpath.scala 63:30]
  reg [31:0] wb_reg_pc; // @[dpath.scala 64:30]
  reg [31:0] wb_reg_alu; // @[dpath.scala 65:30]
  reg [4:0] wb_reg_wbaddr; // @[dpath.scala 67:30]
  reg [31:0] wb_reg_target_pc; // @[dpath.scala 68:30]
  reg  wb_reg_mem; // @[dpath.scala 69:34]
  wire [4:0] exe_rs1_addr = io_imem_resp_bits_inst[19:15]; // @[dpath.scala 105:31]
  wire  _wb_hazard_stall_T_1 = exe_rs1_addr != 5'h0; // @[dpath.scala 128:77]
  wire  _wb_hazard_stall_T_3 = wb_reg_wbaddr == exe_rs1_addr & exe_rs1_addr != 5'h0 & wb_reg_ctrl_rf_wen; // @[dpath.scala 128:86]
  wire  _wb_hazard_stall_T_4 = ~wb_reg_ctrl_bypassable; // @[dpath.scala 128:111]
  wire [4:0] exe_rs2_addr = io_imem_resp_bits_inst[24:20]; // @[dpath.scala 106:31]
  wire  _wb_hazard_stall_T_7 = exe_rs2_addr != 5'h0; // @[dpath.scala 129:77]
  wire  _wb_hazard_stall_T_9 = wb_reg_wbaddr == exe_rs2_addr & exe_rs2_addr != 5'h0 & wb_reg_ctrl_rf_wen; // @[dpath.scala 129:86]
  wire  _wb_hazard_stall_T_11 = wb_reg_wbaddr == exe_rs2_addr & exe_rs2_addr != 5'h0 & wb_reg_ctrl_rf_wen &
    _wb_hazard_stall_T_4; // @[dpath.scala 129:108]
  wire  wb_hazard_stall = wb_reg_wbaddr == exe_rs1_addr & exe_rs1_addr != 5'h0 & wb_reg_ctrl_rf_wen & ~
    wb_reg_ctrl_bypassable | _wb_hazard_stall_T_11; // @[dpath.scala 128:136]
  wire  _io_imem_resp_ready_T = ~wb_hazard_stall; // @[dpath.scala 80:26]
  wire  wb_dmiss_stall = ~io_dmem_req_ready & io_dmem_req_valid | wb_reg_mem & ~io_dmem_resp_valid; // @[dpath.scala 227:64]
  wire  _io_imem_resp_ready_T_1 = ~wb_dmiss_stall; // @[dpath.scala 80:46]
  wire  _take_pc_T_1 = io_ctl_pc_sel == 3'h3; // @[dpath.scala 84:36]
  wire [31:0] exe_jump_reg_target = alu_io_adder_out & 32'hfffffffe; // @[dpath.scala 201:44]
  wire [19:0] imm_j = {io_imem_resp_bits_inst[31],io_imem_resp_bits_inst[19:12],io_imem_resp_bits_inst[20],
    io_imem_resp_bits_inst[30:21]}; // @[Cat.scala 31:58]
  wire [10:0] _imm_j_sext_T_2 = imm_j[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_j_sext = {_imm_j_sext_T_2,io_imem_resp_bits_inst[31],io_imem_resp_bits_inst[19:12],
    io_imem_resp_bits_inst[20],io_imem_resp_bits_inst[30:21],1'h0}; // @[Cat.scala 31:58]
  wire [11:0] imm_b = {io_imem_resp_bits_inst[31],io_imem_resp_bits_inst[7],io_imem_resp_bits_inst[30:25],
    io_imem_resp_bits_inst[11:8]}; // @[Cat.scala 31:58]
  wire [18:0] _imm_b_sext_T_2 = imm_b[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_b_sext = {_imm_b_sext_T_2,io_imem_resp_bits_inst[31],io_imem_resp_bits_inst[7],io_imem_resp_bits_inst[
    30:25],io_imem_resp_bits_inst[11:8],1'h0}; // @[Cat.scala 31:58]
  wire [31:0] imm_brjmp = io_ctl_brjmp_sel ? imm_j_sext : imm_b_sext; // @[dpath.scala 199:23]
  wire [31:0] exe_brjmp_target = io_imem_resp_bits_pc + imm_brjmp; // @[dpath.scala 200:31]
  wire [31:0] _take_pc_T_2 = io_ctl_pc_sel == 3'h3 ? exe_jump_reg_target : exe_brjmp_target; // @[dpath.scala 84:21]
  wire [31:0] exception_target = csr_io_evec; // @[dpath.scala 270:21 78:34]
  wire  _io_dat_inst_misaligned_T_9 = |exe_jump_reg_target[1:0] & _take_pc_T_1; // @[dpath.scala 91:62]
  wire  _io_dat_inst_misaligned_T_10 = |exe_brjmp_target[1:0] & (io_ctl_pc_sel == 3'h1 | io_ctl_pc_sel == 3'h2) |
    _io_dat_inst_misaligned_T_9; // @[dpath.scala 90:118]
  wire [4:0] exe_wbaddr = io_imem_resp_bits_inst[11:7]; // @[dpath.scala 107:31]
  wire  _T_3 = wb_reg_ctrl_rf_wen & wb_reg_wbaddr != 5'h0 & _io_imem_resp_ready_T_1; // @[dpath.scala 144:56]
  wire  _T_4 = ~io_ctl_exception; // @[dpath.scala 144:78]
  wire  _wb_wbdata_T = wb_reg_ctrl_wb_sel == 2'h0; // @[dpath.scala 301:39]
  wire  _wb_wbdata_T_1 = wb_reg_ctrl_wb_sel == 2'h1; // @[dpath.scala 302:39]
  wire  _wb_wbdata_T_2 = wb_reg_ctrl_wb_sel == 2'h2; // @[dpath.scala 303:39]
  wire  _wb_wbdata_T_3 = wb_reg_ctrl_wb_sel == 2'h3; // @[dpath.scala 304:39]
  wire [31:0] _wb_wbdata_T_4 = _wb_wbdata_T_3 ? csr_io_rw_rdata : wb_reg_alu; // @[Mux.scala 101:16]
  wire [31:0] _wb_wbdata_T_5 = _wb_wbdata_T_2 ? io_imem_resp_bits_pc : _wb_wbdata_T_4; // @[Mux.scala 101:16]
  wire [31:0] _wb_wbdata_T_6 = _wb_wbdata_T_1 ? io_dmem_resp_bits_data : _wb_wbdata_T_5; // @[Mux.scala 101:16]
  wire [31:0] wb_wbdata = _wb_wbdata_T ? wb_reg_alu : _wb_wbdata_T_6; // @[Mux.scala 101:16]
  wire [31:0] rf_rs1_data = _wb_hazard_stall_T_1 ? regfile_rf_rs1_data_MPORT_data : 32'h0; // @[dpath.scala 149:25]
  wire [31:0] rf_rs2_data = _wb_hazard_stall_T_7 ? regfile_rf_rs2_data_MPORT_data : 32'h0; // @[dpath.scala 150:25]
  wire [11:0] imm_i = io_imem_resp_bits_inst[31:20]; // @[dpath.scala 154:24]
  wire [11:0] imm_s = {io_imem_resp_bits_inst[31:25],exe_wbaddr}; // @[Cat.scala 31:58]
  wire [31:0] imm_u = {io_imem_resp_bits_inst[31:12],12'h0}; // @[Cat.scala 31:58]
  wire [19:0] _imm_i_sext_T_2 = imm_i[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_i_sext = {_imm_i_sext_T_2,imm_i}; // @[Cat.scala 31:58]
  wire [19:0] _imm_s_sext_T_2 = imm_s[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_s_sext = {_imm_s_sext_T_2,io_imem_resp_bits_inst[31:25],exe_wbaddr}; // @[Cat.scala 31:58]
  wire  _exe_rs1_data_T_4 = _wb_hazard_stall_T_3 & wb_reg_ctrl_bypassable; // @[dpath.scala 171:110]
  wire [31:0] exe_rs1_data = _exe_rs1_data_T_4 ? wb_reg_alu : rf_rs1_data; // @[Mux.scala 101:16]
  wire  _exe_rs2_data_T_4 = _wb_hazard_stall_T_9 & wb_reg_ctrl_bypassable; // @[dpath.scala 174:110]
  wire [31:0] exe_rs2_data = _exe_rs2_data_T_4 ? wb_reg_alu : rf_rs2_data; // @[Mux.scala 101:16]
  wire [31:0] _exe_alu_op1_T_2 = io_ctl_op1_sel == 2'h1 ? imm_u : exe_rs1_data; // @[dpath.scala 180:25]
  wire [31:0] _exe_alu_op2_T_3 = io_ctl_op2_sel == 2'h2 ? imm_s_sext : exe_rs2_data; // @[dpath.scala 185:25]
  wire [31:0] _exe_alu_op2_T_4 = io_ctl_op2_sel == 2'h3 ? io_imem_resp_bits_pc : _exe_alu_op2_T_3; // @[dpath.scala 184:25]
  wire [31:0] _io_dat_br_lt_T = _exe_rs1_data_T_4 ? wb_reg_alu : rf_rs1_data; // @[dpath.scala 206:41]
  wire [31:0] _io_dat_br_lt_T_1 = _exe_rs2_data_T_4 ? wb_reg_alu : rf_rs2_data; // @[dpath.scala 206:65]
  wire [2:0] mem_address_low = alu_io_out[2:0]; // @[dpath.scala 211:37]
  wire [2:0] _misaligned_mask_T_1 = io_ctl_dmem_typ - 3'h1; // @[dpath.scala 213:54]
  wire [5:0] _misaligned_mask_T_3 = 6'h7 << _misaligned_mask_T_1[1:0]; // @[dpath.scala 213:34]
  wire [5:0] _misaligned_mask_T_4 = ~_misaligned_mask_T_3; // @[dpath.scala 213:23]
  wire [2:0] misaligned_mask = _misaligned_mask_T_4[2:0]; // @[dpath.scala 212:30 213:20]
  wire [2:0] _io_dat_data_misaligned_T = misaligned_mask & mem_address_low; // @[dpath.scala 214:47]
  wire  _T_9 = wb_hazard_stall | io_ctl_exe_kill | ~io_imem_resp_valid; // @[dpath.scala 232:48]
  wire  _csr_io_tval_T = io_ctl_exception_cause == 32'h2; // @[dpath.scala 276:43]
  wire  _csr_io_tval_T_1 = io_ctl_exception_cause == 32'h0; // @[dpath.scala 277:43]
  wire  _csr_io_tval_T_2 = io_ctl_exception_cause == 32'h6; // @[dpath.scala 278:43]
  wire  _csr_io_tval_T_3 = io_ctl_exception_cause == 32'h4; // @[dpath.scala 279:43]
  wire [31:0] _csr_io_tval_T_4 = _csr_io_tval_T_3 ? wb_reg_alu : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _csr_io_tval_T_5 = _csr_io_tval_T_2 ? wb_reg_alu : _csr_io_tval_T_4; // @[Mux.scala 101:16]
  wire [31:0] _csr_io_tval_T_6 = _csr_io_tval_T_1 ? wb_reg_target_pc : _csr_io_tval_T_5; // @[Mux.scala 101:16]
  reg  reg_interrupt_flag; // @[dpath.scala 283:36]
  reg [31:0] debug_wb_inst; // @[dpath.scala 310:31]
  wire [31:0] _T_10 = csr_io_time; // @[dpath.scala 313:18]
  reg [4:0] REG; // @[dpath.scala 319:14]
  reg [31:0] REG_1; // @[dpath.scala 320:14]
  reg [4:0] REG_2; // @[dpath.scala 321:14]
  reg [31:0] REG_3; // @[dpath.scala 322:14]
  wire [7:0] _T_11 = io_ctl_exe_kill ? 8'h4b : 8'h20; // @[Mux.scala 101:16]
  wire [7:0] _T_12 = wb_hazard_stall ? 8'h48 : _T_11; // @[Mux.scala 101:16]
  wire [7:0] _T_14 = 3'h1 == io_ctl_pc_sel ? 8'h42 : 8'h3f; // @[Mux.scala 81:58]
  wire [7:0] _T_16 = 3'h2 == io_ctl_pc_sel ? 8'h4a : _T_14; // @[Mux.scala 81:58]
  wire [7:0] _T_18 = 3'h3 == io_ctl_pc_sel ? 8'h52 : _T_16; // @[Mux.scala 81:58]
  wire [7:0] _T_20 = 3'h4 == io_ctl_pc_sel ? 8'h45 : _T_18; // @[Mux.scala 81:58]
  wire [7:0] _T_22 = 3'h0 == io_ctl_pc_sel ? 8'h20 : _T_20; // @[Mux.scala 81:58]
  wire [7:0] _T_23 = csr_io_exception ? 8'h58 : 8'h20; // @[dpath.scala 333:10]
  ALU_3stage alu ( // @[dpath.scala 190:20]
    .io_fn(alu_io_fn),
    .io_in2(alu_io_in2),
    .io_in1(alu_io_in1),
    .io_out(alu_io_out),
    .io_adder_out(alu_io_adder_out)
  );
  CSRFile_3stage csr ( // @[dpath.scala 259:20]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_ungated_clock(csr_io_ungated_clock),
    .io_interrupts_debug(csr_io_interrupts_debug),
    .io_interrupts_mtip(csr_io_interrupts_mtip),
    .io_interrupts_msip(csr_io_interrupts_msip),
    .io_interrupts_meip(csr_io_interrupts_meip),
    .io_hartid(csr_io_hartid),
    .io_rw_addr(csr_io_rw_addr),
    .io_rw_cmd(csr_io_rw_cmd),
    .io_rw_rdata(csr_io_rw_rdata),
    .io_rw_wdata(csr_io_rw_wdata),
    .io_csr_stall(csr_io_csr_stall),
    .io_eret(csr_io_eret),
    .io_singleStep(csr_io_singleStep),
    .io_status_debug(csr_io_status_debug),
    .io_status_cease(csr_io_status_cease),
    .io_status_wfi(csr_io_status_wfi),
    .io_status_isa(csr_io_status_isa),
    .io_status_dprv(csr_io_status_dprv),
    .io_status_dv(csr_io_status_dv),
    .io_status_prv(csr_io_status_prv),
    .io_status_v(csr_io_status_v),
    .io_status_sd(csr_io_status_sd),
    .io_status_zero2(csr_io_status_zero2),
    .io_status_mpv(csr_io_status_mpv),
    .io_status_gva(csr_io_status_gva),
    .io_status_mbe(csr_io_status_mbe),
    .io_status_sbe(csr_io_status_sbe),
    .io_status_sxl(csr_io_status_sxl),
    .io_status_uxl(csr_io_status_uxl),
    .io_status_sd_rv32(csr_io_status_sd_rv32),
    .io_status_zero1(csr_io_status_zero1),
    .io_status_tsr(csr_io_status_tsr),
    .io_status_tw(csr_io_status_tw),
    .io_status_tvm(csr_io_status_tvm),
    .io_status_mxr(csr_io_status_mxr),
    .io_status_sum(csr_io_status_sum),
    .io_status_mprv(csr_io_status_mprv),
    .io_status_xs(csr_io_status_xs),
    .io_status_fs(csr_io_status_fs),
    .io_status_mpp(csr_io_status_mpp),
    .io_status_vs(csr_io_status_vs),
    .io_status_spp(csr_io_status_spp),
    .io_status_mpie(csr_io_status_mpie),
    .io_status_ube(csr_io_status_ube),
    .io_status_spie(csr_io_status_spie),
    .io_status_upie(csr_io_status_upie),
    .io_status_mie(csr_io_status_mie),
    .io_status_hie(csr_io_status_hie),
    .io_status_sie(csr_io_status_sie),
    .io_status_uie(csr_io_status_uie),
    .io_evec(csr_io_evec),
    .io_exception(csr_io_exception),
    .io_retire(csr_io_retire),
    .io_cause(csr_io_cause),
    .io_pc(csr_io_pc),
    .io_tval(csr_io_tval),
    .io_time(csr_io_time),
    .io_interrupt(csr_io_interrupt),
    .io_interrupt_cause(csr_io_interrupt_cause)
  );
  assign regfile_io_ddpath_rdata_MPORT_en = 1'h1;
  assign regfile_io_ddpath_rdata_MPORT_addr = 5'h0;
  assign regfile_io_ddpath_rdata_MPORT_data = regfile[regfile_io_ddpath_rdata_MPORT_addr]; // @[dpath.scala 135:21]
  assign regfile_rf_rs1_data_MPORT_en = 1'h1;
  assign regfile_rf_rs1_data_MPORT_addr = io_imem_resp_bits_inst[19:15];
  assign regfile_rf_rs1_data_MPORT_data = regfile[regfile_rf_rs1_data_MPORT_addr]; // @[dpath.scala 135:21]
  assign regfile_rf_rs2_data_MPORT_en = 1'h1;
  assign regfile_rf_rs2_data_MPORT_addr = io_imem_resp_bits_inst[24:20];
  assign regfile_rf_rs2_data_MPORT_data = regfile[regfile_rf_rs2_data_MPORT_addr]; // @[dpath.scala 135:21]
  assign regfile_MPORT_data = 32'h0;
  assign regfile_MPORT_addr = 5'h0;
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = 1'h0;
  assign regfile_MPORT_1_data = _wb_wbdata_T ? wb_reg_alu : _wb_wbdata_T_6;
  assign regfile_MPORT_1_addr = wb_reg_wbaddr;
  assign regfile_MPORT_1_mask = 1'h1;
  assign regfile_MPORT_1_en = _T_3 & _T_4;
  assign io_imem_req_bits_pc = io_ctl_pc_sel == 3'h4 ? exception_target : _take_pc_T_2; // @[dpath.scala 83:21]
  assign io_imem_resp_ready = ~wb_hazard_stall & ~wb_dmiss_stall; // @[dpath.scala 80:43]
  assign io_dmem_req_valid = io_ctl_dmem_val & ~io_dat_data_misaligned & _io_imem_resp_ready_T; // @[dpath.scala 217:72]
  assign io_dmem_req_bits_addr = alu_io_out; // @[dpath.scala 223:26]
  assign io_dmem_req_bits_data = _exe_rs2_data_T_4 ? wb_reg_alu : rf_rs2_data; // @[Mux.scala 101:16]
  assign io_dmem_req_bits_fcn = io_ctl_dmem_fcn & _io_imem_resp_ready_T & io_imem_resp_valid; // @[dpath.scala 221:67]
  assign io_dmem_req_bits_typ = io_ctl_dmem_typ; // @[dpath.scala 222:26]
  assign io_dat_br_eq = exe_rs1_data == exe_rs2_data; // @[dpath.scala 205:35]
  assign io_dat_br_lt = $signed(_io_dat_br_lt_T) < $signed(_io_dat_br_lt_T_1); // @[dpath.scala 206:44]
  assign io_dat_br_ltu = exe_rs1_data < exe_rs2_data; // @[dpath.scala 207:44]
  assign io_dat_inst_misaligned = _io_dat_inst_misaligned_T_10 & io_imem_resp_valid; // @[dpath.scala 91:91]
  assign io_dat_data_misaligned = |_io_dat_data_misaligned_T & io_ctl_dmem_val; // @[dpath.scala 214:70]
  assign io_dat_wb_hazard_stall = wb_reg_wbaddr == exe_rs1_addr & exe_rs1_addr != 5'h0 & wb_reg_ctrl_rf_wen & ~
    wb_reg_ctrl_bypassable | _wb_hazard_stall_T_11; // @[dpath.scala 128:136]
  assign io_dat_csr_eret = csr_io_eret; // @[dpath.scala 271:20]
  assign io_dat_csr_interrupt = csr_io_interrupt & ~reg_interrupt_flag; // @[dpath.scala 284:42]
  assign alu_io_fn = io_ctl_alu_fun; // @[dpath.scala 194:18]
  assign alu_io_in2 = io_ctl_op2_sel == 2'h1 ? imm_i_sext : _exe_alu_op2_T_4; // @[dpath.scala 183:25]
  assign alu_io_in1 = io_ctl_op1_sel == 2'h2 ? {{27'd0}, exe_rs1_addr} : _exe_alu_op1_T_2; // @[dpath.scala 179:25]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_ungated_clock = clock; // @[dpath.scala 290:25]
  assign csr_io_interrupts_debug = io_interrupt_debug; // @[dpath.scala 286:22]
  assign csr_io_interrupts_mtip = io_interrupt_mtip; // @[dpath.scala 286:22]
  assign csr_io_interrupts_msip = io_interrupt_msip; // @[dpath.scala 286:22]
  assign csr_io_interrupts_meip = io_interrupt_meip; // @[dpath.scala 286:22]
  assign csr_io_hartid = io_hartid; // @[dpath.scala 287:18]
  assign csr_io_rw_addr = wb_reg_inst[31:20]; // @[dpath.scala 262:35]
  assign csr_io_rw_cmd = wb_dmiss_stall ? 3'h0 : wb_reg_ctrl_csr_cmd; // @[dpath.scala 264:27]
  assign csr_io_rw_wdata = wb_reg_alu; // @[dpath.scala 263:21]
  assign csr_io_exception = io_ctl_exception; // @[dpath.scala 268:21]
  assign csr_io_retire = wb_reg_valid & _T_4; // @[dpath.scala 267:37]
  assign csr_io_cause = io_ctl_exception ? io_ctl_exception_cause : csr_io_interrupt_cause; // @[dpath.scala 289:23]
  assign csr_io_pc = wb_reg_pc; // @[dpath.scala 269:21]
  assign csr_io_tval = _csr_io_tval_T ? wb_reg_inst : _csr_io_tval_T_6; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    if (regfile_MPORT_en & regfile_MPORT_mask) begin
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[dpath.scala 135:21]
    end
    if (regfile_MPORT_1_en & regfile_MPORT_1_mask) begin
      regfile[regfile_MPORT_1_addr] <= regfile_MPORT_1_data; // @[dpath.scala 135:21]
    end
    if (reset) begin // @[dpath.scala 61:34]
      wb_reg_inst <= 32'h4033; // @[dpath.scala 61:34]
    end else if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (_T_9) begin // @[dpath.scala 233:7]
        wb_reg_inst <= 32'h4033; // @[dpath.scala 234:32]
      end else begin
        wb_reg_inst <= io_imem_resp_bits_inst; // @[dpath.scala 243:22]
      end
    end
    if (reset) begin // @[dpath.scala 62:34]
      wb_reg_valid <= 1'h0; // @[dpath.scala 62:34]
    end else if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (_T_9) begin // @[dpath.scala 233:7]
        wb_reg_valid <= 1'h0; // @[dpath.scala 235:32]
      end else begin
        wb_reg_valid <= io_imem_resp_valid; // @[dpath.scala 244:23]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (!(_T_9)) begin // @[dpath.scala 233:7]
        wb_reg_ctrl_wb_sel <= io_ctl_wb_sel; // @[dpath.scala 245:22]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (_T_9) begin // @[dpath.scala 233:7]
        wb_reg_ctrl_rf_wen <= 1'h0; // @[dpath.scala 236:32]
      end else begin
        wb_reg_ctrl_rf_wen <= io_ctl_rf_wen; // @[dpath.scala 245:22]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (!(_T_9)) begin // @[dpath.scala 233:7]
        wb_reg_ctrl_bypassable <= io_ctl_bypassable; // @[dpath.scala 245:22]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (_T_9) begin // @[dpath.scala 233:7]
        wb_reg_ctrl_csr_cmd <= 3'h0; // @[dpath.scala 237:32]
      end else begin
        wb_reg_ctrl_csr_cmd <= io_ctl_csr_cmd; // @[dpath.scala 245:22]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (!(_T_9)) begin // @[dpath.scala 233:7]
        wb_reg_pc <= io_imem_resp_bits_pc; // @[dpath.scala 246:20]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (!(_T_9)) begin // @[dpath.scala 233:7]
        wb_reg_alu <= alu_io_out; // @[dpath.scala 247:26]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (!(_T_9)) begin // @[dpath.scala 233:7]
        wb_reg_wbaddr <= exe_wbaddr; // @[dpath.scala 248:26]
      end
    end
    if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (!(_T_9)) begin // @[dpath.scala 233:7]
        if (io_ctl_pc_sel == 3'h3) begin // @[dpath.scala 84:21]
          wb_reg_target_pc <= exe_jump_reg_target;
        end else begin
          wb_reg_target_pc <= exe_brjmp_target;
        end
      end
    end
    if (reset) begin // @[dpath.scala 69:34]
      wb_reg_mem <= 1'h0; // @[dpath.scala 69:34]
    end else if (_io_imem_resp_ready_T_1) begin // @[dpath.scala 231:4]
      if (_T_9) begin // @[dpath.scala 233:7]
        wb_reg_mem <= 1'h0; // @[dpath.scala 240:32]
      end else begin
        wb_reg_mem <= io_dmem_req_valid; // @[dpath.scala 251:21]
      end
    end
    if (reset) begin // @[dpath.scala 283:36]
      reg_interrupt_flag <= 1'h0; // @[dpath.scala 283:36]
    end else begin
      reg_interrupt_flag <= csr_io_interrupt; // @[dpath.scala 283:36]
    end
    if (_T_9) begin // @[dpath.scala 310:35]
      debug_wb_inst <= 32'h4033;
    end else begin
      debug_wb_inst <= io_imem_resp_bits_inst;
    end
    REG <= io_imem_resp_bits_inst[19:15]; // @[dpath.scala 105:31]
    if (io_ctl_op1_sel == 2'h2) begin // @[dpath.scala 179:25]
      REG_1 <= {{27'd0}, exe_rs1_addr};
    end else if (io_ctl_op1_sel == 2'h1) begin // @[dpath.scala 180:25]
      REG_1 <= imm_u;
    end else if (_exe_rs1_data_T_4) begin // @[Mux.scala 101:16]
      REG_1 <= wb_reg_alu;
    end else if (_wb_hazard_stall_T_1) begin // @[dpath.scala 149:25]
      REG_1 <= regfile_rf_rs1_data_MPORT_data;
    end else begin
      REG_1 <= 32'h0;
    end
    REG_2 <= io_imem_resp_bits_inst[24:20]; // @[dpath.scala 106:31]
    if (io_ctl_op2_sel == 2'h1) begin // @[dpath.scala 183:25]
      REG_3 <= imm_i_sext;
    end else if (io_ctl_op2_sel == 2'h3) begin // @[dpath.scala 184:25]
      REG_3 <= io_imem_resp_bits_pc;
    end else if (io_ctl_op2_sel == 2'h2) begin // @[dpath.scala 185:25]
      REG_3 <= imm_s_sext;
    end else if (_exe_rs2_data_T_4) begin // @[Mux.scala 101:16]
      REG_3 <= wb_reg_alu;
    end else begin
      REG_3 <= rf_rs2_data;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,
            "Cyc= %d [%d] pc=[%x] W[r%d=%x][%d] Op1=[r%d][%x] Op2=[r%d][%x] inst=[%x] %c%c%c DASM(%x)\n",_T_10,
            csr_io_retire,wb_reg_pc,wb_reg_wbaddr,wb_wbdata,wb_reg_ctrl_rf_wen,REG,REG_1,REG_2,REG_3,debug_wb_inst,_T_12
            ,_T_22,_T_23,debug_wb_inst); // @[dpath.scala 312:10]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regfile[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  wb_reg_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  wb_reg_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  wb_reg_ctrl_wb_sel = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  wb_reg_ctrl_rf_wen = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  wb_reg_ctrl_bypassable = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  wb_reg_ctrl_csr_cmd = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  wb_reg_pc = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  wb_reg_alu = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  wb_reg_wbaddr = _RAND_9[4:0];
  _RAND_10 = {1{`RANDOM}};
  wb_reg_target_pc = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  wb_reg_mem = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  reg_interrupt_flag = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  debug_wb_inst = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  REG = _RAND_14[4:0];
  _RAND_15 = {1{`RANDOM}};
  REG_1 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  REG_2 = _RAND_16[4:0];
  _RAND_17 = {1{`RANDOM}};
  REG_3 = _RAND_17[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule