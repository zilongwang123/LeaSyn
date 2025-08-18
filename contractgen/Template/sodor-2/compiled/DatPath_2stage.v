module DatPath_2stage (
	clock,
	reset,
	io_imem_req_valid,
	io_imem_req_bits_addr,
	io_imem_resp_valid,
	io_imem_resp_bits_data,
	io_dmem_req_bits_addr,
	io_dmem_req_bits_data,
	io_dmem_resp_bits_data,
	io_ctl_stall,
	io_ctl_if_kill,
	io_ctl_pc_sel,
	io_ctl_op1_sel,
	io_ctl_op2_sel,
	io_ctl_alu_fun,
	io_ctl_wb_sel,
	io_ctl_rf_wen,
	io_ctl_csr_cmd,
	io_ctl_mem_val,
	io_ctl_mem_fcn,
	io_ctl_mem_typ,
	io_ctl_exception,
	io_ctl_exception_cause,
	io_ctl_pc_sel_no_xept,
	io_dat_if_valid_resp,
	io_dat_inst,
	io_dat_br_eq,
	io_dat_br_lt,
	io_dat_br_ltu,
	io_dat_inst_misaligned,
	io_dat_data_misaligned,
	io_dat_mem_store,
	io_dat_csr_eret,
	io_dat_csr_interrupt,
	io_interrupt_debug,
	io_interrupt_mtip,
	io_interrupt_msip,
	io_interrupt_meip,
	io_hartid,
	io_reset_vector,
	pc_retire,
	instr_ctr,
	io_dat_inst_ctr,
	io_ctl_alu_fun_ctr,
	io_ctl_op1_sel_ctr,
	io_ctl_op2_sel_ctr,
	io_dmem_req_bits_addr_ctr,
	io_dat_br_eq_ctr,
	io_dat_br_lt_ctr,
	io_dat_br_ltu_ctr,
	new_pc,
	exe_reg_pc,
	rvfi_regfile
);
	// Trace: core/DatPath_2stage.v:2:3
	input clock;
	// Trace: core/DatPath_2stage.v:3:3
	input reset;
	// Trace: core/DatPath_2stage.v:4:3
	output wire io_imem_req_valid;
	// Trace: core/DatPath_2stage.v:5:3
	output wire [31:0] io_imem_req_bits_addr;
	// Trace: core/DatPath_2stage.v:6:3
	input io_imem_resp_valid;
	// Trace: core/DatPath_2stage.v:7:3
	input [31:0] io_imem_resp_bits_data;
	// Trace: core/DatPath_2stage.v:8:3
	output wire [31:0] io_dmem_req_bits_addr;
	// Trace: core/DatPath_2stage.v:9:3
	output wire [31:0] io_dmem_req_bits_data;
	// Trace: core/DatPath_2stage.v:10:3
	input [31:0] io_dmem_resp_bits_data;
	// Trace: core/DatPath_2stage.v:11:3
	input io_ctl_stall;
	// Trace: core/DatPath_2stage.v:12:3
	input io_ctl_if_kill;
	// Trace: core/DatPath_2stage.v:13:3
	input [2:0] io_ctl_pc_sel;
	// Trace: core/DatPath_2stage.v:14:3
	input [1:0] io_ctl_op1_sel;
	// Trace: core/DatPath_2stage.v:15:3
	input [2:0] io_ctl_op2_sel;
	// Trace: core/DatPath_2stage.v:16:3
	input [4:0] io_ctl_alu_fun;
	// Trace: core/DatPath_2stage.v:17:3
	input [1:0] io_ctl_wb_sel;
	// Trace: core/DatPath_2stage.v:18:3
	input io_ctl_rf_wen;
	// Trace: core/DatPath_2stage.v:19:3
	input [2:0] io_ctl_csr_cmd;
	// Trace: core/DatPath_2stage.v:20:3
	input io_ctl_mem_val;
	// Trace: core/DatPath_2stage.v:21:3
	input [1:0] io_ctl_mem_fcn;
	// Trace: core/DatPath_2stage.v:22:3
	input [2:0] io_ctl_mem_typ;
	// Trace: core/DatPath_2stage.v:23:3
	input io_ctl_exception;
	// Trace: core/DatPath_2stage.v:24:3
	input [31:0] io_ctl_exception_cause;
	// Trace: core/DatPath_2stage.v:25:3
	input [2:0] io_ctl_pc_sel_no_xept;
	// Trace: core/DatPath_2stage.v:26:3
	output wire io_dat_if_valid_resp;
	// Trace: core/DatPath_2stage.v:27:3
	output wire [31:0] io_dat_inst;
	// Trace: core/DatPath_2stage.v:28:3
	output wire io_dat_br_eq;
	// Trace: core/DatPath_2stage.v:29:3
	output wire io_dat_br_lt;
	// Trace: core/DatPath_2stage.v:30:3
	output wire io_dat_br_ltu;
	// Trace: core/DatPath_2stage.v:31:3
	output wire io_dat_inst_misaligned;
	// Trace: core/DatPath_2stage.v:32:3
	output wire io_dat_data_misaligned;
	// Trace: core/DatPath_2stage.v:33:3
	output wire io_dat_mem_store;
	// Trace: core/DatPath_2stage.v:34:3
	output wire io_dat_csr_eret;
	// Trace: core/DatPath_2stage.v:35:3
	output wire io_dat_csr_interrupt;
	// Trace: core/DatPath_2stage.v:36:3
	input io_interrupt_debug;
	// Trace: core/DatPath_2stage.v:37:3
	input io_interrupt_mtip;
	// Trace: core/DatPath_2stage.v:38:3
	input io_interrupt_msip;
	// Trace: core/DatPath_2stage.v:39:3
	input io_interrupt_meip;
	// Trace: core/DatPath_2stage.v:40:3
	input io_hartid;
	// Trace: core/DatPath_2stage.v:41:3
	input [31:0] io_reset_vector;
	// Trace: core/DatPath_2stage.v:44:3
	output reg [31:0] pc_retire;
	// Trace: core/DatPath_2stage.v:45:3
	input wire [31:0] instr_ctr;
	// Trace: core/DatPath_2stage.v:46:3
	output wire [31:0] io_dat_inst_ctr;
	// Trace: core/DatPath_2stage.v:48:3
	input [4:0] io_ctl_alu_fun_ctr;
	// Trace: core/DatPath_2stage.v:49:3
	input [1:0] io_ctl_op1_sel_ctr;
	// Trace: core/DatPath_2stage.v:50:3
	input [2:0] io_ctl_op2_sel_ctr;
	// Trace: core/DatPath_2stage.v:52:3
	output wire [31:0] io_dmem_req_bits_addr_ctr;
	// Trace: core/DatPath_2stage.v:54:3
	output wire io_dat_br_eq_ctr;
	// Trace: core/DatPath_2stage.v:55:3
	output wire io_dat_br_lt_ctr;
	// Trace: core/DatPath_2stage.v:56:3
	output wire io_dat_br_ltu_ctr;
	// Trace: core/DatPath_2stage.v:58:3
	output wire [31:0] new_pc;
	// Trace: core/DatPath_2stage.v:59:3
	output reg [31:0] exe_reg_pc;
	// Trace: core/DatPath_2stage.v:60:3
	output reg [1023:0] rvfi_regfile;
	// Trace: core/DatPath_2stage.v:64:3
	wire _if_pc_next_T = io_ctl_pc_sel == 3'h0;
	wire _if_pc_next_T_1 = io_ctl_pc_sel == 3'h1;
	wire _if_pc_next_T_2 = io_ctl_pc_sel == 3'h2;
	wire _if_pc_next_T_3 = io_ctl_pc_sel == 3'h3;
	wire _if_pc_next_T_4 = io_ctl_pc_sel == 3'h4;
	wire [31:0] csr_io_evec;
	wire [31:0] exception_target = csr_io_evec;
	reg [31:0] if_reg_pc;
	wire [31:0] if_pc_plus4 = if_reg_pc + 32'h00000004;
	wire [31:0] _if_pc_next_T_5 = (_if_pc_next_T_4 ? exception_target : if_pc_plus4);
	reg [31:0] exe_reg_inst;
	wire [4:0] exe_rs1_addr = exe_reg_inst[19:15];
	wire [31:0] regfile_exe_rs1_data_MPORT_data;
	wire [31:0] exe_rs1_data = (exe_rs1_addr != 5'h00 ? regfile_exe_rs1_data_MPORT_data : 32'h00000000);
	wire [11:0] imm_i = exe_reg_inst[31:20];
	wire [19:0] _imm_i_sext_T_2 = (imm_i[11] ? 20'hfffff : 20'h00000);
	wire [31:0] imm_i_sext = {_imm_i_sext_T_2, imm_i};
	wire [31:0] _exe_jump_reg_target_T_1 = exe_rs1_data + imm_i_sext;
	wire [31:0] exe_jump_reg_target = _exe_jump_reg_target_T_1 & 32'hfffffffe;
	wire [31:0] _if_pc_next_T_6 = (_if_pc_next_T_3 ? exe_jump_reg_target : _if_pc_next_T_5);
	wire [19:0] imm_j = {exe_reg_inst[31], exe_reg_inst[19:12], exe_reg_inst[20], exe_reg_inst[30:21]};
	wire [10:0] _imm_j_sext_T_2 = (imm_j[19] ? 11'h7ff : 11'h000);
	wire [31:0] imm_j_sext = {_imm_j_sext_T_2, exe_reg_inst[31], exe_reg_inst[19:12], exe_reg_inst[20], exe_reg_inst[30:21], 1'h0};
	wire [31:0] exe_jmp_target = exe_reg_pc + imm_j_sext;
	wire [31:0] _if_pc_next_T_7 = (_if_pc_next_T_2 ? exe_jmp_target : _if_pc_next_T_6);
	wire [11:0] imm_b = {exe_reg_inst[31], exe_reg_inst[7], exe_reg_inst[30:25], exe_reg_inst[11:8]};
	wire [18:0] _imm_b_sext_T_2 = (imm_b[11] ? 19'h7ffff : 19'h00000);
	wire [31:0] imm_b_sext = {_imm_b_sext_T_2, exe_reg_inst[31], exe_reg_inst[7], exe_reg_inst[30:25], exe_reg_inst[11:8], 1'h0};
	wire [31:0] exe_br_target = exe_reg_pc + imm_b_sext;
	assign new_pc = (io_ctl_if_kill ? (_if_pc_next_T ? if_pc_plus4 : (_if_pc_next_T_1 ? exe_br_target : _if_pc_next_T_7)) : if_reg_pc);
	// Trace: core/DatPath_2stage.v:68:3
	// combined with instr_ctr
	// Trace: core/DatPath_2stage.v:69:3
	wire instr_ctr_resp_valid;
	// Trace: core/DatPath_2stage.v:70:3
	reg retire;
	assign instr_ctr_resp_valid = retire;
	// Trace: core/DatPath_2stage.v:71:3
	// combined with io_dat_inst_ctr
	// Trace: core/DatPath_2stage.v:72:3
	assign io_dat_inst_ctr = instr_ctr;
	// Trace: core/DatPath_2stage.v:75:3
	// combined with io_dmem_req_bits_addr_ctr
	// Trace: core/DatPath_2stage.v:76:3
	wire _exe_alu_op1_T_1_ctr = io_ctl_op1_sel_ctr == 2'h1;
	wire _exe_alu_op1_T_2_ctr = io_ctl_op1_sel_ctr == 2'h2;
	wire [4:0] exe_rs1_addr_ctr = instr_ctr[19:15];
	wire [31:0] imm_z_ctr = {27'h0000000, exe_rs1_addr_ctr};
	wire [31:0] _exe_alu_op1_T_3_ctr = (_exe_alu_op1_T_2_ctr ? imm_z_ctr : 32'h00000000);
	wire [19:0] imm_u_ctr = instr_ctr[31:12];
	wire [31:0] imm_u_sext_ctr = {imm_u_ctr, 12'h000};
	wire [31:0] _exe_alu_op1_T_4_ctr = (_exe_alu_op1_T_1_ctr ? imm_u_sext_ctr : _exe_alu_op1_T_3_ctr);
	wire _exe_alu_op1_T_ctr = io_ctl_op1_sel_ctr == 2'h0;
	wire [31:0] regfile_exe_rs1_data_MPORT_data_ctr;
	wire [31:0] exe_rs1_data_ctr = (exe_rs1_addr_ctr != 5'h00 ? regfile_exe_rs1_data_MPORT_data_ctr : 32'h00000000);
	wire [31:0] exe_alu_op1_ctr = (_exe_alu_op1_T_ctr ? exe_rs1_data_ctr : _exe_alu_op1_T_4_ctr);
	wire _exe_alu_op2_T_1_ctr = io_ctl_op2_sel_ctr == 3'h1;
	wire _exe_alu_op2_T_2_ctr = io_ctl_op2_sel_ctr == 3'h2;
	wire _exe_alu_op2_T_3_ctr = io_ctl_op2_sel_ctr == 3'h3;
	wire [4:0] exe_wbaddr_ctr = instr_ctr[11:7];
	wire [11:0] imm_s_ctr = {instr_ctr[31:25], exe_wbaddr_ctr};
	wire [19:0] _imm_s_sext_T_2_ctr = (imm_s_ctr[11] ? 20'hfffff : 20'h00000);
	wire [31:0] imm_s_sext_ctr = {_imm_s_sext_T_2_ctr, instr_ctr[31:25], exe_wbaddr_ctr};
	wire [31:0] _exe_alu_op2_T_4_ctr = (_exe_alu_op2_T_3_ctr ? imm_s_sext_ctr : 32'h00000000);
	wire [11:0] imm_i_ctr = instr_ctr[31:20];
	wire [19:0] _imm_i_sext_T_2_ctr = (imm_i_ctr[11] ? 20'hfffff : 20'h00000);
	wire [31:0] imm_i_sext_ctr = {_imm_i_sext_T_2_ctr, imm_i_ctr};
	wire [31:0] _exe_alu_op2_T_5_ctr = (_exe_alu_op2_T_2_ctr ? imm_i_sext_ctr : _exe_alu_op2_T_4_ctr);
	wire [31:0] _exe_alu_op2_T_6_ctr = (_exe_alu_op2_T_1_ctr ? pc_retire : _exe_alu_op2_T_5_ctr);
	wire _exe_alu_op2_T_ctr = io_ctl_op2_sel_ctr == 3'h0;
	wire [4:0] exe_rs2_addr_ctr = instr_ctr[24:20];
	wire [31:0] regfile_exe_rs2_data_MPORT_data_ctr;
	wire [31:0] exe_rs2_data_ctr = (exe_rs2_addr_ctr != 5'h00 ? regfile_exe_rs2_data_MPORT_data_ctr : 32'h00000000);
	wire [31:0] exe_alu_op2_ctr = (_exe_alu_op2_T_ctr ? exe_rs2_data_ctr : _exe_alu_op2_T_6_ctr);
	wire [31:0] _exe_alu_out_T_2_ctr = exe_alu_op1_ctr + exe_alu_op2_ctr;
	wire _exe_alu_out_T_10_ctr = io_ctl_alu_fun_ctr == 5'h08;
	wire [31:0] _exe_alu_out_T_11_ctr = exe_alu_op1_ctr ^ exe_alu_op2_ctr;
	wire _exe_alu_out_T_12_ctr = io_ctl_alu_fun_ctr == 5'h09;
	wire [31:0] _exe_alu_out_T_13_ctr = (_exe_alu_op1_T_ctr ? exe_rs1_data_ctr : _exe_alu_op1_T_4_ctr);
	wire [31:0] _exe_alu_out_T_14_ctr = (_exe_alu_op2_T_ctr ? exe_rs2_data_ctr : _exe_alu_op2_T_6_ctr);
	wire _exe_alu_out_T_15_ctr = $signed(_exe_alu_out_T_13_ctr) < $signed(_exe_alu_out_T_14_ctr);
	wire _exe_alu_out_T_16_ctr = io_ctl_alu_fun_ctr == 5'h0a;
	wire _exe_alu_out_T_17_ctr = exe_alu_op1_ctr < exe_alu_op2_ctr;
	wire _exe_alu_out_T_18_ctr = io_ctl_alu_fun_ctr == 5'h03;
	wire [62:0] _GEN_11_ctr = {31'd0, exe_alu_op1_ctr};
	wire [4:0] alu_shamt_ctr = exe_alu_op2_ctr[4:0];
	wire [62:0] _exe_alu_out_T_19_ctr = _GEN_11_ctr << alu_shamt_ctr;
	wire _exe_alu_out_T_21_ctr = io_ctl_alu_fun_ctr == 5'h05;
	wire [31:0] _exe_alu_out_T_24_ctr = $signed(_exe_alu_out_T_13_ctr) >>> alu_shamt_ctr;
	wire _exe_alu_out_T_25_ctr = io_ctl_alu_fun_ctr == 5'h04;
	wire [31:0] _exe_alu_out_T_26_ctr = exe_alu_op1_ctr >> alu_shamt_ctr;
	wire _exe_alu_out_T_27_ctr = io_ctl_alu_fun_ctr == 5'h0b;
	wire [31:0] _exe_alu_out_T_28_ctr = (_exe_alu_out_T_27_ctr ? exe_alu_op1_ctr : 32'h00000000);
	wire [31:0] _exe_alu_out_T_29_ctr = (_exe_alu_out_T_25_ctr ? _exe_alu_out_T_26_ctr : _exe_alu_out_T_28_ctr);
	wire [31:0] _exe_alu_out_T_30_ctr = (_exe_alu_out_T_21_ctr ? _exe_alu_out_T_24_ctr : _exe_alu_out_T_29_ctr);
	wire [31:0] _exe_alu_out_T_31_ctr = (_exe_alu_out_T_18_ctr ? _exe_alu_out_T_19_ctr[31:0] : _exe_alu_out_T_30_ctr);
	wire [31:0] _exe_alu_out_T_32_ctr = (_exe_alu_out_T_16_ctr ? {31'd0, _exe_alu_out_T_17_ctr} : _exe_alu_out_T_31_ctr);
	wire [31:0] _exe_alu_out_T_33_ctr = (_exe_alu_out_T_12_ctr ? {31'd0, _exe_alu_out_T_15_ctr} : _exe_alu_out_T_32_ctr);
	wire [31:0] _exe_alu_out_T_34_ctr = (_exe_alu_out_T_10_ctr ? _exe_alu_out_T_11_ctr : _exe_alu_out_T_33_ctr);
	wire _exe_alu_out_T_8_ctr = io_ctl_alu_fun_ctr == 5'h07;
	wire [31:0] _exe_alu_out_T_9_ctr = exe_alu_op1_ctr | exe_alu_op2_ctr;
	wire [31:0] _exe_alu_out_T_35_ctr = (_exe_alu_out_T_8_ctr ? _exe_alu_out_T_9_ctr : _exe_alu_out_T_34_ctr);
	wire _exe_alu_out_T_6_ctr = io_ctl_alu_fun_ctr == 5'h06;
	wire [31:0] _exe_alu_out_T_7_ctr = exe_alu_op1_ctr & exe_alu_op2_ctr;
	wire [31:0] _exe_alu_out_T_36_ctr = (_exe_alu_out_T_6_ctr ? _exe_alu_out_T_7_ctr : _exe_alu_out_T_35_ctr);
	wire _exe_alu_out_T_3_ctr = io_ctl_alu_fun_ctr == 5'h02;
	wire [31:0] _exe_alu_out_T_5_ctr = exe_alu_op1_ctr - exe_alu_op2_ctr;
	wire [31:0] _exe_alu_out_T_37_ctr = (_exe_alu_out_T_3_ctr ? _exe_alu_out_T_5_ctr : _exe_alu_out_T_36_ctr);
	wire _exe_alu_out_T_ctr = io_ctl_alu_fun_ctr == 5'h01;
	assign io_dmem_req_bits_addr_ctr = (_exe_alu_out_T_ctr ? _exe_alu_out_T_2_ctr : _exe_alu_out_T_37_ctr);
	// Trace: core/DatPath_2stage.v:77:3
	// Trace: core/DatPath_2stage.v:79:3
	// Trace: core/DatPath_2stage.v:80:3
	// Trace: core/DatPath_2stage.v:81:3
	// Trace: core/DatPath_2stage.v:82:3
	// Trace: core/DatPath_2stage.v:83:3
	// Trace: core/DatPath_2stage.v:84:3
	// Trace: core/DatPath_2stage.v:85:3
	// Trace: core/DatPath_2stage.v:86:3
	// Trace: core/DatPath_2stage.v:87:3
	// Trace: core/DatPath_2stage.v:88:3
	// Trace: core/DatPath_2stage.v:89:3
	// Trace: core/DatPath_2stage.v:90:3
	// Trace: core/DatPath_2stage.v:91:3
	// Trace: core/DatPath_2stage.v:92:3
	// Trace: core/DatPath_2stage.v:93:3
	// Trace: core/DatPath_2stage.v:94:3
	// Trace: core/DatPath_2stage.v:95:3
	// Trace: core/DatPath_2stage.v:96:3
	// Trace: core/DatPath_2stage.v:97:3
	// Trace: core/DatPath_2stage.v:98:3
	// Trace: core/DatPath_2stage.v:99:3
	// Trace: core/DatPath_2stage.v:100:3
	// Trace: core/DatPath_2stage.v:102:3
	// Trace: core/DatPath_2stage.v:103:3
	// Trace: core/DatPath_2stage.v:104:3
	// Trace: core/DatPath_2stage.v:105:3
	// Trace: core/DatPath_2stage.v:106:3
	// Trace: core/DatPath_2stage.v:107:3
	// Trace: core/DatPath_2stage.v:108:3
	// Trace: core/DatPath_2stage.v:109:3
	// Trace: core/DatPath_2stage.v:110:3
	// Trace: core/DatPath_2stage.v:111:3
	// Trace: core/DatPath_2stage.v:112:3
	// Trace: core/DatPath_2stage.v:113:3
	// Trace: core/DatPath_2stage.v:114:3
	// Trace: core/DatPath_2stage.v:115:3
	// Trace: core/DatPath_2stage.v:116:3
	// Trace: core/DatPath_2stage.v:117:3
	// Trace: core/DatPath_2stage.v:118:3
	// Trace: core/DatPath_2stage.v:119:3
	// Trace: core/DatPath_2stage.v:120:3
	// Trace: core/DatPath_2stage.v:121:3
	// Trace: core/DatPath_2stage.v:122:3
	// Trace: core/DatPath_2stage.v:123:3
	// Trace: core/DatPath_2stage.v:124:3
	// Trace: core/DatPath_2stage.v:125:3
	// Trace: core/DatPath_2stage.v:126:3
	// Trace: core/DatPath_2stage.v:127:3
	// Trace: core/DatPath_2stage.v:128:3
	// Trace: core/DatPath_2stage.v:129:3
	// Trace: core/DatPath_2stage.v:130:3
	// Trace: core/DatPath_2stage.v:131:3
	// Trace: core/DatPath_2stage.v:132:3
	// Trace: core/DatPath_2stage.v:133:3
	// Trace: core/DatPath_2stage.v:134:3
	// Trace: core/DatPath_2stage.v:136:3
	// Trace: core/DatPath_2stage.v:137:3
	// Trace: core/DatPath_2stage.v:138:3
	// Trace: core/DatPath_2stage.v:139:3
	// Trace: core/DatPath_2stage.v:140:3
	// Trace: core/DatPath_2stage.v:141:3
	// Trace: core/DatPath_2stage.v:142:3
	// Trace: core/DatPath_2stage.v:143:3
	reg [1023:0] regfile = 0;
	assign regfile_exe_rs1_data_MPORT_data_ctr = regfile[(31 - exe_rs1_addr_ctr) * 32+:32];
	// Trace: core/DatPath_2stage.v:144:3
	assign regfile_exe_rs2_data_MPORT_data_ctr = regfile[(31 - exe_rs2_addr_ctr) * 32+:32];
	// Trace: core/DatPath_2stage.v:146:3
	// Trace: core/DatPath_2stage.v:147:3
	// Trace: core/DatPath_2stage.v:148:3
	// Trace: core/DatPath_2stage.v:151:3
	assign io_dat_br_eq_ctr = exe_rs1_data_ctr == exe_rs2_data_ctr;
	// Trace: core/DatPath_2stage.v:152:3
	assign io_dat_br_lt_ctr = $signed(exe_rs1_data_ctr) < $signed(exe_rs2_data_ctr);
	// Trace: core/DatPath_2stage.v:153:3
	assign io_dat_br_ltu_ctr = exe_rs1_data_ctr < exe_rs2_data_ctr;
	// Trace: core/DatPath_2stage.v:172:3
	// Trace: core/DatPath_2stage.v:173:3
	wire regfile_io_ddpath_rdata_MPORT_en;
	// Trace: core/DatPath_2stage.v:174:3
	wire [4:0] regfile_io_ddpath_rdata_MPORT_addr;
	// Trace: core/DatPath_2stage.v:175:3
	wire [31:0] regfile_io_ddpath_rdata_MPORT_data;
	// Trace: core/DatPath_2stage.v:176:3
	wire regfile_exe_rs1_data_MPORT_en;
	// Trace: core/DatPath_2stage.v:177:3
	wire [4:0] regfile_exe_rs1_data_MPORT_addr;
	// Trace: core/DatPath_2stage.v:178:3
	// Trace: core/DatPath_2stage.v:179:3
	wire regfile_exe_rs2_data_MPORT_en;
	// Trace: core/DatPath_2stage.v:180:3
	wire [4:0] regfile_exe_rs2_data_MPORT_addr;
	// Trace: core/DatPath_2stage.v:181:3
	wire [31:0] regfile_exe_rs2_data_MPORT_data;
	// Trace: core/DatPath_2stage.v:182:3
	wire [31:0] regfile_MPORT_data;
	// Trace: core/DatPath_2stage.v:183:3
	wire [4:0] regfile_MPORT_addr;
	// Trace: core/DatPath_2stage.v:184:3
	wire regfile_MPORT_mask;
	// Trace: core/DatPath_2stage.v:185:3
	wire regfile_MPORT_en;
	// Trace: core/DatPath_2stage.v:186:3
	wire [31:0] regfile_MPORT_1_data;
	// Trace: core/DatPath_2stage.v:187:3
	wire [4:0] regfile_MPORT_1_addr;
	// Trace: core/DatPath_2stage.v:188:3
	wire regfile_MPORT_1_mask;
	// Trace: core/DatPath_2stage.v:189:3
	wire regfile_MPORT_1_en;
	// Trace: core/DatPath_2stage.v:190:3
	wire csr_clock;
	// Trace: core/DatPath_2stage.v:191:3
	wire csr_reset;
	// Trace: core/DatPath_2stage.v:192:3
	wire csr_io_ungated_clock;
	// Trace: core/DatPath_2stage.v:193:3
	wire csr_io_interrupts_debug;
	// Trace: core/DatPath_2stage.v:194:3
	wire csr_io_interrupts_mtip;
	// Trace: core/DatPath_2stage.v:195:3
	wire csr_io_interrupts_msip;
	// Trace: core/DatPath_2stage.v:196:3
	wire csr_io_interrupts_meip;
	// Trace: core/DatPath_2stage.v:197:3
	wire csr_io_hartid;
	// Trace: core/DatPath_2stage.v:198:3
	wire [11:0] csr_io_rw_addr;
	// Trace: core/DatPath_2stage.v:199:3
	wire [2:0] csr_io_rw_cmd;
	// Trace: core/DatPath_2stage.v:200:3
	wire [31:0] csr_io_rw_rdata;
	// Trace: core/DatPath_2stage.v:201:3
	wire [31:0] csr_io_rw_wdata;
	// Trace: core/DatPath_2stage.v:202:3
	wire csr_io_csr_stall;
	// Trace: core/DatPath_2stage.v:203:3
	wire csr_io_eret;
	// Trace: core/DatPath_2stage.v:204:3
	wire csr_io_singleStep;
	// Trace: core/DatPath_2stage.v:205:3
	wire csr_io_status_debug;
	// Trace: core/DatPath_2stage.v:206:3
	wire csr_io_status_cease;
	// Trace: core/DatPath_2stage.v:207:3
	wire csr_io_status_wfi;
	// Trace: core/DatPath_2stage.v:208:3
	wire [31:0] csr_io_status_isa;
	// Trace: core/DatPath_2stage.v:209:3
	wire [1:0] csr_io_status_dprv;
	// Trace: core/DatPath_2stage.v:210:3
	wire csr_io_status_dv;
	// Trace: core/DatPath_2stage.v:211:3
	wire [1:0] csr_io_status_prv;
	// Trace: core/DatPath_2stage.v:212:3
	wire csr_io_status_v;
	// Trace: core/DatPath_2stage.v:213:3
	wire csr_io_status_sd;
	// Trace: core/DatPath_2stage.v:214:3
	wire [22:0] csr_io_status_zero2;
	// Trace: core/DatPath_2stage.v:215:3
	wire csr_io_status_mpv;
	// Trace: core/DatPath_2stage.v:216:3
	wire csr_io_status_gva;
	// Trace: core/DatPath_2stage.v:217:3
	wire csr_io_status_mbe;
	// Trace: core/DatPath_2stage.v:218:3
	wire csr_io_status_sbe;
	// Trace: core/DatPath_2stage.v:219:3
	wire [1:0] csr_io_status_sxl;
	// Trace: core/DatPath_2stage.v:220:3
	wire [1:0] csr_io_status_uxl;
	// Trace: core/DatPath_2stage.v:221:3
	wire csr_io_status_sd_rv32;
	// Trace: core/DatPath_2stage.v:222:3
	wire [7:0] csr_io_status_zero1;
	// Trace: core/DatPath_2stage.v:223:3
	wire csr_io_status_tsr;
	// Trace: core/DatPath_2stage.v:224:3
	wire csr_io_status_tw;
	// Trace: core/DatPath_2stage.v:225:3
	wire csr_io_status_tvm;
	// Trace: core/DatPath_2stage.v:226:3
	wire csr_io_status_mxr;
	// Trace: core/DatPath_2stage.v:227:3
	wire csr_io_status_sum;
	// Trace: core/DatPath_2stage.v:228:3
	wire csr_io_status_mprv;
	// Trace: core/DatPath_2stage.v:229:3
	wire [1:0] csr_io_status_xs;
	// Trace: core/DatPath_2stage.v:230:3
	wire [1:0] csr_io_status_fs;
	// Trace: core/DatPath_2stage.v:231:3
	wire [1:0] csr_io_status_mpp;
	// Trace: core/DatPath_2stage.v:232:3
	wire [1:0] csr_io_status_vs;
	// Trace: core/DatPath_2stage.v:233:3
	wire csr_io_status_spp;
	// Trace: core/DatPath_2stage.v:234:3
	wire csr_io_status_mpie;
	// Trace: core/DatPath_2stage.v:235:3
	wire csr_io_status_ube;
	// Trace: core/DatPath_2stage.v:236:3
	wire csr_io_status_spie;
	// Trace: core/DatPath_2stage.v:237:3
	wire csr_io_status_upie;
	// Trace: core/DatPath_2stage.v:238:3
	wire csr_io_status_mie;
	// Trace: core/DatPath_2stage.v:239:3
	wire csr_io_status_hie;
	// Trace: core/DatPath_2stage.v:240:3
	wire csr_io_status_sie;
	// Trace: core/DatPath_2stage.v:241:3
	wire csr_io_status_uie;
	// Trace: core/DatPath_2stage.v:242:3
	// Trace: core/DatPath_2stage.v:243:3
	wire csr_io_exception;
	// Trace: core/DatPath_2stage.v:244:3
	wire csr_io_retire;
	// Trace: core/DatPath_2stage.v:245:3
	wire [31:0] csr_io_cause;
	// Trace: core/DatPath_2stage.v:246:3
	wire [31:0] csr_io_pc;
	// Trace: core/DatPath_2stage.v:247:3
	wire [31:0] csr_io_tval;
	// Trace: core/DatPath_2stage.v:248:3
	wire [31:0] csr_io_time;
	// Trace: core/DatPath_2stage.v:249:3
	wire csr_io_interrupt;
	// Trace: core/DatPath_2stage.v:250:3
	wire [31:0] csr_io_interrupt_cause;
	// Trace: core/DatPath_2stage.v:251:3
	// Trace: core/DatPath_2stage.v:252:3
	// combined with exe_reg_pc
	// Trace: core/DatPath_2stage.v:253:3
	reg [31:0] exe_reg_pc_plus4;
	// Trace: core/DatPath_2stage.v:254:3
	// Trace: core/DatPath_2stage.v:255:3
	reg exe_reg_valid;
	// Trace: core/DatPath_2stage.v:256:3
	wire _T = ~io_ctl_stall;
	// Trace: core/DatPath_2stage.v:257:3
	// Trace: core/DatPath_2stage.v:258:3
	// Trace: core/DatPath_2stage.v:259:3
	// Trace: core/DatPath_2stage.v:260:3
	// Trace: core/DatPath_2stage.v:261:3
	// Trace: core/DatPath_2stage.v:262:3
	// Trace: core/DatPath_2stage.v:264:3
	// Trace: core/DatPath_2stage.v:265:3
	// Trace: core/DatPath_2stage.v:266:3
	// Trace: core/DatPath_2stage.v:267:3
	// Trace: core/DatPath_2stage.v:268:3
	// Trace: core/DatPath_2stage.v:270:3
	// Trace: core/DatPath_2stage.v:271:3
	// Trace: core/DatPath_2stage.v:272:3
	// Trace: core/DatPath_2stage.v:273:3
	// Trace: core/DatPath_2stage.v:274:3
	// Trace: core/DatPath_2stage.v:275:3
	// Trace: core/DatPath_2stage.v:276:3
	// Trace: core/DatPath_2stage.v:277:3
	// Trace: core/DatPath_2stage.v:278:3
	// Trace: core/DatPath_2stage.v:279:3
	// Trace: core/DatPath_2stage.v:280:3
	// Trace: core/DatPath_2stage.v:281:3
	// Trace: core/DatPath_2stage.v:282:3
	// Trace: core/DatPath_2stage.v:283:3
	// Trace: core/DatPath_2stage.v:284:3
	reg [31:0] if_inst_buffer;
	// Trace: core/DatPath_2stage.v:285:3
	reg if_inst_buffer_valid;
	// Trace: core/DatPath_2stage.v:286:3
	wire _GEN_1 = io_imem_resp_valid | if_inst_buffer_valid;
	// Trace: core/DatPath_2stage.v:287:3
	wire _GEN_3 = io_ctl_stall & _GEN_1;
	// Trace: core/DatPath_2stage.v:288:3
	wire [4:0] exe_rs2_addr = exe_reg_inst[24:20];
	// Trace: core/DatPath_2stage.v:289:3
	wire [4:0] exe_wbaddr = exe_reg_inst[11:7];
	// Trace: core/DatPath_2stage.v:290:3
	wire exe_wben = io_ctl_rf_wen & ~io_ctl_exception;
	// Trace: core/DatPath_2stage.v:291:3
	wire _T_1 = exe_wbaddr != 5'h00;
	// Trace: core/DatPath_2stage.v:292:3
	wire _exe_wbdata_T = io_ctl_wb_sel == 2'h0;
	// Trace: core/DatPath_2stage.v:293:3
	wire _exe_alu_out_T = io_ctl_alu_fun == 5'h01;
	// Trace: core/DatPath_2stage.v:294:3
	wire _exe_alu_op1_T = io_ctl_op1_sel == 2'h0;
	// Trace: core/DatPath_2stage.v:295:3
	wire _exe_alu_op1_T_1 = io_ctl_op1_sel == 2'h1;
	// Trace: core/DatPath_2stage.v:296:3
	wire [19:0] imm_u = exe_reg_inst[31:12];
	// Trace: core/DatPath_2stage.v:297:3
	wire [31:0] imm_u_sext = {imm_u, 12'h000};
	// Trace: core/DatPath_2stage.v:298:3
	wire _exe_alu_op1_T_2 = io_ctl_op1_sel == 2'h2;
	// Trace: core/DatPath_2stage.v:299:3
	wire [31:0] imm_z = {27'h0000000, exe_rs1_addr};
	// Trace: core/DatPath_2stage.v:300:3
	wire [31:0] _exe_alu_op1_T_3 = (_exe_alu_op1_T_2 ? imm_z : 32'h00000000);
	// Trace: core/DatPath_2stage.v:301:3
	wire [31:0] _exe_alu_op1_T_4 = (_exe_alu_op1_T_1 ? imm_u_sext : _exe_alu_op1_T_3);
	// Trace: core/DatPath_2stage.v:302:3
	wire [31:0] exe_alu_op1 = (_exe_alu_op1_T ? exe_rs1_data : _exe_alu_op1_T_4);
	// Trace: core/DatPath_2stage.v:303:3
	wire _exe_alu_op2_T = io_ctl_op2_sel == 3'h0;
	// Trace: core/DatPath_2stage.v:304:3
	wire [31:0] exe_rs2_data = (exe_rs2_addr != 5'h00 ? regfile_exe_rs2_data_MPORT_data : 32'h00000000);
	// Trace: core/DatPath_2stage.v:305:3
	wire _exe_alu_op2_T_1 = io_ctl_op2_sel == 3'h1;
	// Trace: core/DatPath_2stage.v:306:3
	wire _exe_alu_op2_T_2 = io_ctl_op2_sel == 3'h2;
	// Trace: core/DatPath_2stage.v:307:3
	wire _exe_alu_op2_T_3 = io_ctl_op2_sel == 3'h3;
	// Trace: core/DatPath_2stage.v:308:3
	wire [11:0] imm_s = {exe_reg_inst[31:25], exe_wbaddr};
	// Trace: core/DatPath_2stage.v:309:3
	wire [19:0] _imm_s_sext_T_2 = (imm_s[11] ? 20'hfffff : 20'h00000);
	// Trace: core/DatPath_2stage.v:310:3
	wire [31:0] imm_s_sext = {_imm_s_sext_T_2, exe_reg_inst[31:25], exe_wbaddr};
	// Trace: core/DatPath_2stage.v:311:3
	wire [31:0] _exe_alu_op2_T_4 = (_exe_alu_op2_T_3 ? imm_s_sext : 32'h00000000);
	// Trace: core/DatPath_2stage.v:312:3
	wire [31:0] _exe_alu_op2_T_5 = (_exe_alu_op2_T_2 ? imm_i_sext : _exe_alu_op2_T_4);
	// Trace: core/DatPath_2stage.v:313:3
	wire [31:0] _exe_alu_op2_T_6 = (_exe_alu_op2_T_1 ? exe_reg_pc : _exe_alu_op2_T_5);
	// Trace: core/DatPath_2stage.v:314:3
	wire [31:0] exe_alu_op2 = (_exe_alu_op2_T ? exe_rs2_data : _exe_alu_op2_T_6);
	// Trace: core/DatPath_2stage.v:315:3
	wire [31:0] _exe_alu_out_T_2 = exe_alu_op1 + exe_alu_op2;
	// Trace: core/DatPath_2stage.v:316:3
	wire _exe_alu_out_T_3 = io_ctl_alu_fun == 5'h02;
	// Trace: core/DatPath_2stage.v:317:3
	wire [31:0] _exe_alu_out_T_5 = exe_alu_op1 - exe_alu_op2;
	// Trace: core/DatPath_2stage.v:318:3
	wire _exe_alu_out_T_6 = io_ctl_alu_fun == 5'h06;
	// Trace: core/DatPath_2stage.v:319:3
	wire [31:0] _exe_alu_out_T_7 = exe_alu_op1 & exe_alu_op2;
	// Trace: core/DatPath_2stage.v:320:3
	wire _exe_alu_out_T_8 = io_ctl_alu_fun == 5'h07;
	// Trace: core/DatPath_2stage.v:321:3
	wire [31:0] _exe_alu_out_T_9 = exe_alu_op1 | exe_alu_op2;
	// Trace: core/DatPath_2stage.v:322:3
	wire _exe_alu_out_T_10 = io_ctl_alu_fun == 5'h08;
	// Trace: core/DatPath_2stage.v:323:3
	wire [31:0] _exe_alu_out_T_11 = exe_alu_op1 ^ exe_alu_op2;
	// Trace: core/DatPath_2stage.v:324:3
	wire _exe_alu_out_T_12 = io_ctl_alu_fun == 5'h09;
	// Trace: core/DatPath_2stage.v:325:3
	wire [31:0] _exe_alu_out_T_13 = (_exe_alu_op1_T ? exe_rs1_data : _exe_alu_op1_T_4);
	// Trace: core/DatPath_2stage.v:326:3
	wire [31:0] _exe_alu_out_T_14 = (_exe_alu_op2_T ? exe_rs2_data : _exe_alu_op2_T_6);
	// Trace: core/DatPath_2stage.v:327:3
	wire _exe_alu_out_T_15 = $signed(_exe_alu_out_T_13) < $signed(_exe_alu_out_T_14);
	// Trace: core/DatPath_2stage.v:328:3
	wire _exe_alu_out_T_16 = io_ctl_alu_fun == 5'h0a;
	// Trace: core/DatPath_2stage.v:329:3
	wire _exe_alu_out_T_17 = exe_alu_op1 < exe_alu_op2;
	// Trace: core/DatPath_2stage.v:330:3
	wire _exe_alu_out_T_18 = io_ctl_alu_fun == 5'h03;
	// Trace: core/DatPath_2stage.v:331:3
	wire [4:0] alu_shamt = exe_alu_op2[4:0];
	// Trace: core/DatPath_2stage.v:332:3
	wire [62:0] _GEN_11 = {31'd0, exe_alu_op1};
	// Trace: core/DatPath_2stage.v:333:3
	wire [62:0] _exe_alu_out_T_19 = _GEN_11 << alu_shamt;
	// Trace: core/DatPath_2stage.v:334:3
	wire _exe_alu_out_T_21 = io_ctl_alu_fun == 5'h05;
	// Trace: core/DatPath_2stage.v:335:3
	wire [31:0] _exe_alu_out_T_24 = $signed(_exe_alu_out_T_13) >>> alu_shamt;
	// Trace: core/DatPath_2stage.v:336:3
	wire _exe_alu_out_T_25 = io_ctl_alu_fun == 5'h04;
	// Trace: core/DatPath_2stage.v:337:3
	wire [31:0] _exe_alu_out_T_26 = exe_alu_op1 >> alu_shamt;
	// Trace: core/DatPath_2stage.v:338:3
	wire _exe_alu_out_T_27 = io_ctl_alu_fun == 5'h0b;
	// Trace: core/DatPath_2stage.v:339:3
	wire [31:0] _exe_alu_out_T_28 = (_exe_alu_out_T_27 ? exe_alu_op1 : 32'h00000000);
	// Trace: core/DatPath_2stage.v:340:3
	wire [31:0] _exe_alu_out_T_29 = (_exe_alu_out_T_25 ? _exe_alu_out_T_26 : _exe_alu_out_T_28);
	// Trace: core/DatPath_2stage.v:341:3
	wire [31:0] _exe_alu_out_T_30 = (_exe_alu_out_T_21 ? _exe_alu_out_T_24 : _exe_alu_out_T_29);
	// Trace: core/DatPath_2stage.v:342:3
	wire [31:0] _exe_alu_out_T_31 = (_exe_alu_out_T_18 ? _exe_alu_out_T_19[31:0] : _exe_alu_out_T_30);
	// Trace: core/DatPath_2stage.v:343:3
	wire [31:0] _exe_alu_out_T_32 = (_exe_alu_out_T_16 ? {31'd0, _exe_alu_out_T_17} : _exe_alu_out_T_31);
	// Trace: core/DatPath_2stage.v:344:3
	wire [31:0] _exe_alu_out_T_33 = (_exe_alu_out_T_12 ? {31'd0, _exe_alu_out_T_15} : _exe_alu_out_T_32);
	// Trace: core/DatPath_2stage.v:345:3
	wire [31:0] _exe_alu_out_T_34 = (_exe_alu_out_T_10 ? _exe_alu_out_T_11 : _exe_alu_out_T_33);
	// Trace: core/DatPath_2stage.v:346:3
	wire [31:0] _exe_alu_out_T_35 = (_exe_alu_out_T_8 ? _exe_alu_out_T_9 : _exe_alu_out_T_34);
	// Trace: core/DatPath_2stage.v:347:3
	wire [31:0] _exe_alu_out_T_36 = (_exe_alu_out_T_6 ? _exe_alu_out_T_7 : _exe_alu_out_T_35);
	// Trace: core/DatPath_2stage.v:348:3
	wire [31:0] _exe_alu_out_T_37 = (_exe_alu_out_T_3 ? _exe_alu_out_T_5 : _exe_alu_out_T_36);
	// Trace: core/DatPath_2stage.v:349:3
	wire [31:0] exe_alu_out = (_exe_alu_out_T ? _exe_alu_out_T_2 : _exe_alu_out_T_37);
	// Trace: core/DatPath_2stage.v:350:3
	wire _exe_wbdata_T_1 = io_ctl_wb_sel == 2'h1;
	// Trace: core/DatPath_2stage.v:351:3
	wire _exe_wbdata_T_2 = io_ctl_wb_sel == 2'h2;
	// Trace: core/DatPath_2stage.v:352:3
	wire _exe_wbdata_T_3 = io_ctl_wb_sel == 2'h3;
	// Trace: core/DatPath_2stage.v:353:3
	wire [31:0] _exe_wbdata_T_4 = (_exe_wbdata_T_3 ? csr_io_rw_rdata : exe_alu_out);
	// Trace: core/DatPath_2stage.v:354:3
	wire [31:0] _exe_wbdata_T_5 = (_exe_wbdata_T_2 ? exe_reg_pc_plus4 : _exe_wbdata_T_4);
	// Trace: core/DatPath_2stage.v:355:3
	wire [31:0] _exe_wbdata_T_6 = (_exe_wbdata_T_1 ? io_dmem_resp_bits_data : _exe_wbdata_T_5);
	// Trace: core/DatPath_2stage.v:356:3
	wire [31:0] exe_wbdata = (_exe_wbdata_T ? exe_alu_out : _exe_wbdata_T_6);
	// Trace: core/DatPath_2stage.v:357:3
	wire _io_dat_inst_misaligned_T_2 = io_ctl_pc_sel_no_xept == 3'h1;
	// Trace: core/DatPath_2stage.v:358:3
	wire _io_dat_inst_misaligned_T_6 = io_ctl_pc_sel_no_xept == 3'h2;
	// Trace: core/DatPath_2stage.v:359:3
	wire _io_dat_inst_misaligned_T_7 = |exe_jmp_target[1:0] & (io_ctl_pc_sel_no_xept == 3'h2);
	// Trace: core/DatPath_2stage.v:360:3
	wire _io_dat_inst_misaligned_T_8 = (|exe_br_target[1:0] & (io_ctl_pc_sel_no_xept == 3'h1)) | _io_dat_inst_misaligned_T_7;
	// Trace: core/DatPath_2stage.v:361:3
	wire _io_dat_inst_misaligned_T_11 = io_ctl_pc_sel_no_xept == 3'h3;
	// Trace: core/DatPath_2stage.v:362:3
	wire _io_dat_inst_misaligned_T_12 = |exe_jump_reg_target[1:0] & (io_ctl_pc_sel_no_xept == 3'h3);
	// Trace: core/DatPath_2stage.v:363:3
	wire [31:0] _tval_inst_ma_T_3 = (_io_dat_inst_misaligned_T_11 ? exe_jump_reg_target : 32'h00000000);
	// Trace: core/DatPath_2stage.v:364:3
	wire [31:0] _tval_inst_ma_T_4 = (_io_dat_inst_misaligned_T_6 ? exe_jmp_target : _tval_inst_ma_T_3);
	// Trace: core/DatPath_2stage.v:365:3
	wire [31:0] tval_inst_ma = (_io_dat_inst_misaligned_T_2 ? exe_br_target : _tval_inst_ma_T_4);
	// Trace: core/DatPath_2stage.v:366:3
	wire _csr_io_tval_T = io_ctl_exception_cause == 32'h00000002;
	// Trace: core/DatPath_2stage.v:367:3
	wire _csr_io_tval_T_1 = io_ctl_exception_cause == 32'h00000000;
	// Trace: core/DatPath_2stage.v:368:3
	wire _csr_io_tval_T_2 = io_ctl_exception_cause == 32'h00000006;
	// Trace: core/DatPath_2stage.v:369:3
	wire _csr_io_tval_T_3 = io_ctl_exception_cause == 32'h00000004;
	// Trace: core/DatPath_2stage.v:370:3
	wire [31:0] _csr_io_tval_T_4 = (_csr_io_tval_T_3 ? exe_alu_out : 32'h00000000);
	// Trace: core/DatPath_2stage.v:371:3
	wire [31:0] _csr_io_tval_T_5 = (_csr_io_tval_T_2 ? exe_alu_out : _csr_io_tval_T_4);
	// Trace: core/DatPath_2stage.v:372:3
	wire [31:0] _csr_io_tval_T_6 = (_csr_io_tval_T_1 ? tval_inst_ma : _csr_io_tval_T_5);
	// Trace: core/DatPath_2stage.v:373:3
	reg reg_interrupt_handled;
	// Trace: core/DatPath_2stage.v:374:3
	wire [31:0] _io_dat_br_lt_T = (exe_rs1_addr != 5'h00 ? regfile_exe_rs1_data_MPORT_data : 32'h00000000);
	// Trace: core/DatPath_2stage.v:375:3
	wire [31:0] _io_dat_br_lt_T_1 = (exe_rs2_addr != 5'h00 ? regfile_exe_rs2_data_MPORT_data : 32'h00000000);
	// Trace: core/DatPath_2stage.v:376:3
	wire [2:0] _misaligned_mask_T_1 = io_ctl_mem_typ - 3'h1;
	// Trace: core/DatPath_2stage.v:377:3
	wire [5:0] _misaligned_mask_T_3 = 6'h07 << _misaligned_mask_T_1[1:0];
	// Trace: core/DatPath_2stage.v:378:3
	wire [5:0] _misaligned_mask_T_4 = ~_misaligned_mask_T_3;
	// Trace: core/DatPath_2stage.v:379:3
	wire [2:0] misaligned_mask = _misaligned_mask_T_4[2:0];
	// Trace: core/DatPath_2stage.v:380:3
	wire [2:0] _io_dat_data_misaligned_T_1 = misaligned_mask & exe_alu_out[2:0];
	// Trace: core/DatPath_2stage.v:381:3
	wire [31:0] _T_4 = csr_io_time;
	// Trace: core/DatPath_2stage.v:382:3
	wire [7:0] _T_5 = (io_ctl_if_kill ? 8'h4b : 8'h20);
	// Trace: core/DatPath_2stage.v:383:3
	wire [7:0] _T_6 = (io_ctl_stall ? 8'h53 : _T_5);
	// Trace: core/DatPath_2stage.v:384:3
	wire [7:0] _T_8 = (3'h1 == io_ctl_pc_sel ? 8'h42 : 8'h3f);
	// Trace: core/DatPath_2stage.v:385:3
	wire [7:0] _T_10 = (3'h2 == io_ctl_pc_sel ? 8'h4a : _T_8);
	// Trace: core/DatPath_2stage.v:386:3
	wire [7:0] _T_12 = (3'h3 == io_ctl_pc_sel ? 8'h52 : _T_10);
	// Trace: core/DatPath_2stage.v:387:3
	wire [7:0] _T_14 = (3'h4 == io_ctl_pc_sel ? 8'h45 : _T_12);
	// Trace: core/DatPath_2stage.v:388:3
	wire [7:0] _T_16 = (3'h0 == io_ctl_pc_sel ? 8'h20 : _T_14);
	// Trace: core/DatPath_2stage.v:389:3
	wire [7:0] _T_17 = (csr_io_exception ? 8'h58 : 8'h20);
	// Trace: core/DatPath_2stage.v:390:3
	CSRFile_2stage CSRFile_2stage(
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
	// Trace: core/DatPath_2stage.v:453:3
	assign regfile_io_ddpath_rdata_MPORT_en = 1'h1;
	// Trace: core/DatPath_2stage.v:454:3
	assign regfile_io_ddpath_rdata_MPORT_addr = 5'h00;
	// Trace: core/DatPath_2stage.v:455:3
	assign regfile_io_ddpath_rdata_MPORT_data = regfile[(31 - regfile_io_ddpath_rdata_MPORT_addr) * 32+:32];
	// Trace: core/DatPath_2stage.v:456:3
	assign regfile_exe_rs1_data_MPORT_en = 1'h1;
	// Trace: core/DatPath_2stage.v:457:3
	assign regfile_exe_rs1_data_MPORT_addr = exe_reg_inst[19:15];
	// Trace: core/DatPath_2stage.v:458:3
	assign regfile_exe_rs1_data_MPORT_data = regfile[(31 - regfile_exe_rs1_data_MPORT_addr) * 32+:32];
	// Trace: core/DatPath_2stage.v:459:3
	assign regfile_exe_rs2_data_MPORT_en = 1'h1;
	// Trace: core/DatPath_2stage.v:460:3
	assign regfile_exe_rs2_data_MPORT_addr = exe_reg_inst[24:20];
	// Trace: core/DatPath_2stage.v:461:3
	assign regfile_exe_rs2_data_MPORT_data = regfile[(31 - regfile_exe_rs2_data_MPORT_addr) * 32+:32];
	// Trace: core/DatPath_2stage.v:462:3
	assign regfile_MPORT_data = 32'h00000000;
	// Trace: core/DatPath_2stage.v:463:3
	assign regfile_MPORT_addr = 5'h00;
	// Trace: core/DatPath_2stage.v:464:3
	assign regfile_MPORT_mask = 1'h1;
	// Trace: core/DatPath_2stage.v:465:3
	assign regfile_MPORT_en = 1'h0;
	// Trace: core/DatPath_2stage.v:466:3
	assign regfile_MPORT_1_data = (_exe_wbdata_T ? exe_alu_out : _exe_wbdata_T_6);
	// Trace: core/DatPath_2stage.v:467:3
	assign regfile_MPORT_1_addr = exe_reg_inst[11:7];
	// Trace: core/DatPath_2stage.v:468:3
	assign regfile_MPORT_1_mask = 1'h1;
	// Trace: core/DatPath_2stage.v:469:3
	assign regfile_MPORT_1_en = exe_wben & _T_1;
	// Trace: core/DatPath_2stage.v:470:3
	assign io_imem_req_valid = ~if_inst_buffer_valid;
	// Trace: core/DatPath_2stage.v:471:3
	assign io_imem_req_bits_addr = if_reg_pc;
	// Trace: core/DatPath_2stage.v:472:3
	assign io_dmem_req_bits_addr = (_exe_alu_out_T ? _exe_alu_out_T_2 : _exe_alu_out_T_37);
	// Trace: core/DatPath_2stage.v:473:3
	assign io_dmem_req_bits_data = (exe_rs2_addr != 5'h00 ? regfile_exe_rs2_data_MPORT_data : 32'h00000000);
	// Trace: core/DatPath_2stage.v:474:3
	assign io_dat_if_valid_resp = if_inst_buffer_valid | io_imem_resp_valid;
	// Trace: core/DatPath_2stage.v:475:3
	assign io_dat_inst = exe_reg_inst;
	// Trace: core/DatPath_2stage.v:476:3
	assign io_dat_br_eq = exe_rs1_data == exe_rs2_data;
	// Trace: core/DatPath_2stage.v:477:3
	assign io_dat_br_lt = $signed(_io_dat_br_lt_T) < $signed(_io_dat_br_lt_T_1);
	// Trace: core/DatPath_2stage.v:478:3
	assign io_dat_br_ltu = exe_rs1_data < exe_rs2_data;
	// Trace: core/DatPath_2stage.v:479:3
	assign io_dat_inst_misaligned = _io_dat_inst_misaligned_T_8 | _io_dat_inst_misaligned_T_12;
	// Trace: core/DatPath_2stage.v:480:3
	assign io_dat_data_misaligned = |_io_dat_data_misaligned_T_1 & io_ctl_mem_val;
	// Trace: core/DatPath_2stage.v:481:3
	assign io_dat_mem_store = io_ctl_mem_fcn == 2'h1;
	// Trace: core/DatPath_2stage.v:482:3
	assign io_dat_csr_eret = csr_io_eret;
	// Trace: core/DatPath_2stage.v:483:3
	assign io_dat_csr_interrupt = csr_io_interrupt & ~reg_interrupt_handled;
	// Trace: core/DatPath_2stage.v:484:3
	assign csr_clock = clock;
	// Trace: core/DatPath_2stage.v:485:3
	assign csr_reset = reset;
	// Trace: core/DatPath_2stage.v:486:3
	assign csr_io_ungated_clock = clock;
	// Trace: core/DatPath_2stage.v:487:3
	assign csr_io_interrupts_debug = io_interrupt_debug;
	// Trace: core/DatPath_2stage.v:488:3
	assign csr_io_interrupts_mtip = io_interrupt_mtip;
	// Trace: core/DatPath_2stage.v:489:3
	assign csr_io_interrupts_msip = io_interrupt_msip;
	// Trace: core/DatPath_2stage.v:490:3
	assign csr_io_interrupts_meip = io_interrupt_meip;
	// Trace: core/DatPath_2stage.v:491:3
	assign csr_io_hartid = io_hartid;
	// Trace: core/DatPath_2stage.v:492:3
	assign csr_io_rw_addr = exe_reg_inst[31:20];
	// Trace: core/DatPath_2stage.v:493:3
	assign csr_io_rw_cmd = io_ctl_csr_cmd;
	// Trace: core/DatPath_2stage.v:494:3
	assign csr_io_rw_wdata = (_exe_alu_out_T ? _exe_alu_out_T_2 : _exe_alu_out_T_37);
	// Trace: core/DatPath_2stage.v:495:3
	assign csr_io_exception = io_ctl_exception;
	// Trace: core/DatPath_2stage.v:496:3
	assign csr_io_retire = exe_reg_valid & ~(io_ctl_stall | io_ctl_exception);
	// Trace: core/DatPath_2stage.v:497:3
	assign csr_io_cause = (io_ctl_exception ? io_ctl_exception_cause : csr_io_interrupt_cause);
	// Trace: core/DatPath_2stage.v:498:3
	assign csr_io_pc = exe_reg_pc;
	// Trace: core/DatPath_2stage.v:499:3
	assign csr_io_tval = (_csr_io_tval_T ? exe_reg_inst : _csr_io_tval_T_6);
	// Trace: core/DatPath_2stage.v:503:3
	wire io_ctl_if_kill_r = exe_reg_inst == 32'h00004033;
	// Trace: core/DatPath_2stage.v:506:3
	reg fetch_reg;
	// Trace: core/DatPath_2stage.v:507:3
	reg execute_reg;
	// Trace: core/DatPath_2stage.v:508:3
	wire filtered_fetch_reg = fetch_reg && io_ctl_if_kill;
	// Trace: core/DatPath_2stage.v:511:3
	reg _exe_wbdata_T_1_delay;
	// Trace: core/DatPath_2stage.v:512:3
	reg _exe_wbdata_T_delay;
	// Trace: core/DatPath_2stage.v:513:3
	reg [31:0] exe_reg_inst_delay;
	// Trace: core/DatPath_2stage.v:514:3
	// combined with pc_retire
	// Trace: core/DatPath_2stage.v:515:3
	// Trace: core/DatPath_2stage.v:517:3
	always @(posedge clock) begin
		// Trace: core/DatPath_2stage.v:518:5
		retire <= execute_reg;
		// Trace: core/DatPath_2stage.v:519:5
		pc_retire <= (io_ctl_if_kill_r ? pc_retire : exe_reg_pc);
		// Trace: core/DatPath_2stage.v:520:5
		exe_reg_inst_delay <= exe_reg_inst;
		// Trace: core/DatPath_2stage.v:521:5
		_exe_wbdata_T_delay <= _exe_wbdata_T;
		// Trace: core/DatPath_2stage.v:522:5
		_exe_wbdata_T_1_delay <= _exe_wbdata_T_1;
	end
	// Trace: core/DatPath_2stage.v:525:3
	wire execute = (reset ? 0 : (!io_ctl_stall ? (io_ctl_if_kill ? 0 : 1) : 0));
	// Trace: core/DatPath_2stage.v:527:3
	wire fetch = (reset ? 0 : (_T ? 1 : 0));
	// Trace: core/DatPath_2stage.v:530:3
	reg [31:0] if_reg_pc_delay;
	wire [31:0] filtered_if_reg_pc = (io_ctl_if_kill ? if_reg_pc_delay : if_reg_pc);
	// Trace: core/DatPath_2stage.v:531:3
	// Trace: core/DatPath_2stage.v:532:3
	always @(posedge clock) begin
		// Trace: core/DatPath_2stage.v:534:5
		if (regfile_MPORT_en & regfile_MPORT_mask)
			// Trace: core/DatPath_2stage.v:535:7
			regfile[(31 - regfile_MPORT_addr) * 32+:32] <= regfile_MPORT_data;
		if (regfile_MPORT_1_en & regfile_MPORT_1_mask)
			// Trace: core/DatPath_2stage.v:538:7
			regfile[(31 - regfile_MPORT_1_addr) * 32+:32] <= regfile_MPORT_1_data;
		if (reset) begin
			// Trace: core/DatPath_2stage.v:541:7
			if_reg_pc <= io_reset_vector;
			// Trace: core/DatPath_2stage.v:542:7
			fetch_reg <= 0;
		end
		else if (_T) begin
			// Trace: core/DatPath_2stage.v:544:7
			fetch_reg <= 1;
			// Trace: core/DatPath_2stage.v:545:7
			if_reg_pc_delay <= if_reg_pc;
			// Trace: core/DatPath_2stage.v:546:7
			if (_if_pc_next_T)
				// Trace: core/DatPath_2stage.v:547:9
				if_reg_pc <= if_pc_plus4;
			else if (_if_pc_next_T_1)
				// Trace: core/DatPath_2stage.v:549:9
				if_reg_pc <= exe_br_target;
			else
				// Trace: core/DatPath_2stage.v:551:9
				if_reg_pc <= _if_pc_next_T_7;
		end
		if (reset) begin
			// Trace: core/DatPath_2stage.v:555:7
			exe_reg_pc <= 32'h00000000;
			// Trace: core/DatPath_2stage.v:556:7
			execute_reg <= 0;
		end
		else if (!io_ctl_stall) begin
			begin
				// Trace: core/DatPath_2stage.v:558:7
				if (io_ctl_if_kill) begin
					// Trace: core/DatPath_2stage.v:559:9
					exe_reg_pc <= 32'h00000000;
					// Trace: core/DatPath_2stage.v:560:9
					execute_reg <= 0;
				end
				else begin
					// Trace: core/DatPath_2stage.v:562:9
					exe_reg_pc <= if_reg_pc;
					// Trace: core/DatPath_2stage.v:563:9
					execute_reg <= 1;
				end
			end
		end
		if (reset)
			// Trace: core/DatPath_2stage.v:567:7
			exe_reg_pc_plus4 <= 32'h00000000;
		else
			// Trace: core/DatPath_2stage.v:569:7
			exe_reg_pc_plus4 <= if_pc_plus4;
		if (reset)
			// Trace: core/DatPath_2stage.v:572:7
			exe_reg_inst <= 32'h00004033;
		else if (!io_ctl_stall) begin
			begin
				// Trace: core/DatPath_2stage.v:574:7
				if (io_ctl_if_kill)
					// Trace: core/DatPath_2stage.v:575:9
					exe_reg_inst <= 32'h00004033;
				else if (if_inst_buffer_valid)
					// Trace: core/DatPath_2stage.v:577:9
					exe_reg_inst <= if_inst_buffer;
				else
					// Trace: core/DatPath_2stage.v:579:9
					exe_reg_inst <= io_imem_resp_bits_data;
			end
		end
		if (reset)
			// Trace: core/DatPath_2stage.v:583:7
			exe_reg_valid <= 1'h0;
		else if (!io_ctl_stall) begin
			begin
				// Trace: core/DatPath_2stage.v:585:7
				if (io_ctl_if_kill)
					// Trace: core/DatPath_2stage.v:586:9
					exe_reg_valid <= 1'h0;
				else
					// Trace: core/DatPath_2stage.v:588:9
					exe_reg_valid <= 1'h1;
			end
		end
		if (reset)
			// Trace: core/DatPath_2stage.v:592:7
			if_inst_buffer <= 32'h00000000;
		else if (io_ctl_stall) begin
			begin
				// Trace: core/DatPath_2stage.v:594:7
				if (io_imem_resp_valid)
					// Trace: core/DatPath_2stage.v:595:9
					if_inst_buffer <= io_imem_resp_bits_data;
			end
		end
		else
			// Trace: core/DatPath_2stage.v:598:7
			if_inst_buffer <= 32'h00000000;
		if (reset)
			// Trace: core/DatPath_2stage.v:601:7
			if_inst_buffer_valid <= 1'h0;
		else
			// Trace: core/DatPath_2stage.v:603:7
			if_inst_buffer_valid <= _GEN_3;
		if (reset)
			// Trace: core/DatPath_2stage.v:606:7
			reg_interrupt_handled <= 1'h0;
		else if (_T)
			// Trace: core/DatPath_2stage.v:608:7
			reg_interrupt_handled <= csr_io_interrupt;
	end
	// Trace: core/DatPath_2stage.v:690:1
	integer i;
	// Trace: core/DatPath_2stage.v:691:1
	always @(*)
		// Trace: core/DatPath_2stage.v:692:3
		for (i = 0; i < 32; i = i + 1)
			begin
				// Trace: core/DatPath_2stage.v:693:5
				if ((i == regfile_MPORT_1_addr) & regfile_MPORT_1_en)
					// Trace: core/DatPath_2stage.v:694:7
					rvfi_regfile[(31 - i) * 32+:32] = regfile_MPORT_1_data;
				else
					// Trace: core/DatPath_2stage.v:696:7
					rvfi_regfile[(31 - i) * 32+:32] = regfile[(31 - i) * 32+:32];
			end
endmodule
