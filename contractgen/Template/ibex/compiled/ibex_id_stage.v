// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_id_stage (
	clk_i,
	rst_ni,
	ctrl_busy_o,
	illegal_insn_o,
	instr_valid_i,
	instr_rdata_i,
	instr_rdata_alu_i,
	instr_rdata_c_i,
	instr_is_compressed_i,
	instr_bp_taken_i,
	instr_req_o,
	instr_first_cycle_id_o,
	instr_valid_clear_o,
	id_in_ready_o,
	icache_inval_o,
	branch_decision_i,
	pc_set_o,
	pc_set_spec_o,
	pc_mux_o,
	nt_branch_mispredict_o,
	exc_pc_mux_o,
	exc_cause_o,
	illegal_c_insn_i,
	instr_fetch_err_i,
	instr_fetch_err_plus2_i,
	pc_id_i,
	ex_valid_i,
	lsu_resp_valid_i,
	alu_operator_ex_o,
	alu_operand_a_ex_o,
	alu_operand_b_ex_o,
	imd_val_we_ex_i,
	imd_val_d_ex_i,
	imd_val_q_ex_o,
	bt_a_operand_o,
	bt_b_operand_o,
	mult_en_ex_o,
	div_en_ex_o,
	mult_sel_ex_o,
	div_sel_ex_o,
	multdiv_operator_ex_o,
	multdiv_signed_mode_ex_o,
	multdiv_operand_a_ex_o,
	multdiv_operand_b_ex_o,
	multdiv_ready_id_o,
	csr_access_o,
	csr_op_o,
	csr_op_en_o,
	csr_save_if_o,
	csr_save_id_o,
	csr_save_wb_o,
	csr_restore_mret_id_o,
	csr_restore_dret_id_o,
	csr_save_cause_o,
	csr_mtval_o,
	priv_mode_i,
	csr_mstatus_tw_i,
	illegal_csr_insn_i,
	data_ind_timing_i,
	lsu_req_o,
	lsu_we_o,
	lsu_type_o,
	lsu_sign_ext_o,
	lsu_wdata_o,
	lsu_req_done_i,
	lsu_addr_incr_req_i,
	lsu_addr_last_i,
	csr_mstatus_mie_i,
	irq_pending_i,
	irqs_i,
	irq_nm_i,
	nmi_mode_o,
	irqs_x_i,
	irq_x_ack_o,
	irq_x_ack_id_o,
	lsu_load_err_i,
	lsu_store_err_i,
	debug_mode_o,
	debug_cause_o,
	debug_csr_save_o,
	debug_req_i,
	debug_single_step_i,
	debug_ebreakm_i,
	debug_ebreaku_i,
	trigger_match_i,
	result_ex_i,
	csr_rdata_i,
	rf_raddr_a_o,
	rf_rdata_a_i,
	rf_raddr_b_o,
	rf_rdata_b_i,
	rf_ren_a_o,
	rf_ren_b_o,
	rf_waddr_id_o,
	rf_wdata_id_o,
	rf_we_id_o,
	rf_rd_a_wb_match_o,
	rf_rd_b_wb_match_o,
	rf_waddr_wb_i,
	rf_wdata_fwd_wb_i,
	rf_write_wb_i,
	en_wb_o,
	instr_type_wb_o,
	instr_perf_count_id_o,
	ready_wb_i,
	outstanding_load_wb_i,
	outstanding_store_wb_i,
	perf_jump_o,
	perf_branch_o,
	perf_tbranch_o,
	perf_dside_wait_o,
	perf_mul_wait_o,
	perf_div_wait_o,
	instr_id_done_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_id_stage.sv:20:15
	parameter [0:0] RV32E = 0;
	// Trace: core/rtl/ibex_id_stage.sv:21:15
	// removed localparam type ibex_pkg_rv32m_e
	parameter integer RV32M = 32'sd2;
	// Trace: core/rtl/ibex_id_stage.sv:22:15
	// removed localparam type ibex_pkg_rv32b_e
	parameter integer RV32B = 32'sd0;
	// Trace: core/rtl/ibex_id_stage.sv:23:15
	parameter [0:0] DataIndTiming = 1'b0;
	// Trace: core/rtl/ibex_id_stage.sv:24:15
	parameter [0:0] BranchTargetALU = 0;
	// Trace: core/rtl/ibex_id_stage.sv:25:15
	parameter [0:0] SpecBranch = 0;
	// Trace: core/rtl/ibex_id_stage.sv:26:15
	parameter [0:0] WritebackStage = 0;
	// Trace: core/rtl/ibex_id_stage.sv:27:15
	parameter [0:0] BranchPredictor = 0;
	// Trace: core/rtl/ibex_id_stage.sv:29:5
	input wire clk_i;
	// Trace: core/rtl/ibex_id_stage.sv:30:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_id_stage.sv:32:5
	output wire ctrl_busy_o;
	// Trace: core/rtl/ibex_id_stage.sv:33:5
	output wire illegal_insn_o;
	// Trace: core/rtl/ibex_id_stage.sv:36:5
	input wire instr_valid_i;
	// Trace: core/rtl/ibex_id_stage.sv:37:5
	input wire [31:0] instr_rdata_i;
	// Trace: core/rtl/ibex_id_stage.sv:38:5
	input wire [31:0] instr_rdata_alu_i;
	// Trace: core/rtl/ibex_id_stage.sv:39:5
	input wire [15:0] instr_rdata_c_i;
	// Trace: core/rtl/ibex_id_stage.sv:40:5
	input wire instr_is_compressed_i;
	// Trace: core/rtl/ibex_id_stage.sv:41:5
	input wire instr_bp_taken_i;
	// Trace: core/rtl/ibex_id_stage.sv:42:5
	output wire instr_req_o;
	// Trace: core/rtl/ibex_id_stage.sv:43:5
	output wire instr_first_cycle_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:44:5
	output wire instr_valid_clear_o;
	// Trace: core/rtl/ibex_id_stage.sv:45:5
	output wire id_in_ready_o;
	// Trace: core/rtl/ibex_id_stage.sv:46:5
	output wire icache_inval_o;
	// Trace: core/rtl/ibex_id_stage.sv:49:5
	input wire branch_decision_i;
	// Trace: core/rtl/ibex_id_stage.sv:52:5
	output wire pc_set_o;
	// Trace: core/rtl/ibex_id_stage.sv:53:5
	output wire pc_set_spec_o;
	// Trace: core/rtl/ibex_id_stage.sv:54:5
	// removed localparam type ibex_pkg_pc_sel_e
	output wire [2:0] pc_mux_o;
	// Trace: core/rtl/ibex_id_stage.sv:55:5
	output wire nt_branch_mispredict_o;
	// Trace: core/rtl/ibex_id_stage.sv:56:5
	// removed localparam type ibex_pkg_exc_pc_sel_e
	output wire [2:0] exc_pc_mux_o;
	// Trace: core/rtl/ibex_id_stage.sv:57:5
	// removed localparam type ibex_pkg_exc_cause_e
	output wire [5:0] exc_cause_o;
	// Trace: core/rtl/ibex_id_stage.sv:59:5
	input wire illegal_c_insn_i;
	// Trace: core/rtl/ibex_id_stage.sv:60:5
	input wire instr_fetch_err_i;
	// Trace: core/rtl/ibex_id_stage.sv:61:5
	input wire instr_fetch_err_plus2_i;
	// Trace: core/rtl/ibex_id_stage.sv:63:5
	input wire [31:0] pc_id_i;
	// Trace: core/rtl/ibex_id_stage.sv:66:5
	input wire ex_valid_i;
	// Trace: core/rtl/ibex_id_stage.sv:67:5
	input wire lsu_resp_valid_i;
	// Trace: core/rtl/ibex_id_stage.sv:69:5
	// removed localparam type ibex_pkg_alu_op_e
	output wire [5:0] alu_operator_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:70:5
	output wire [31:0] alu_operand_a_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:71:5
	output wire [31:0] alu_operand_b_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:74:5
	input wire [1:0] imd_val_we_ex_i;
	// Trace: core/rtl/ibex_id_stage.sv:75:5
	input wire [67:0] imd_val_d_ex_i;
	// Trace: core/rtl/ibex_id_stage.sv:76:5
	output wire [67:0] imd_val_q_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:79:5
	output reg [31:0] bt_a_operand_o;
	// Trace: core/rtl/ibex_id_stage.sv:80:5
	output reg [31:0] bt_b_operand_o;
	// Trace: core/rtl/ibex_id_stage.sv:83:5
	output wire mult_en_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:84:5
	output wire div_en_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:85:5
	output wire mult_sel_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:86:5
	output wire div_sel_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:87:5
	// removed localparam type ibex_pkg_md_op_e
	output wire [1:0] multdiv_operator_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:88:5
	output wire [1:0] multdiv_signed_mode_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:89:5
	output wire [31:0] multdiv_operand_a_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:90:5
	output wire [31:0] multdiv_operand_b_ex_o;
	// Trace: core/rtl/ibex_id_stage.sv:91:5
	output wire multdiv_ready_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:94:5
	output wire csr_access_o;
	// Trace: core/rtl/ibex_id_stage.sv:95:5
	// removed localparam type ibex_pkg_csr_op_e
	output wire [1:0] csr_op_o;
	// Trace: core/rtl/ibex_id_stage.sv:96:5
	output wire csr_op_en_o;
	// Trace: core/rtl/ibex_id_stage.sv:97:5
	output wire csr_save_if_o;
	// Trace: core/rtl/ibex_id_stage.sv:98:5
	output wire csr_save_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:99:5
	output wire csr_save_wb_o;
	// Trace: core/rtl/ibex_id_stage.sv:100:5
	output wire csr_restore_mret_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:101:5
	output wire csr_restore_dret_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:102:5
	output wire csr_save_cause_o;
	// Trace: core/rtl/ibex_id_stage.sv:103:5
	output wire [31:0] csr_mtval_o;
	// Trace: core/rtl/ibex_id_stage.sv:104:5
	// removed localparam type ibex_pkg_priv_lvl_e
	input wire [1:0] priv_mode_i;
	// Trace: core/rtl/ibex_id_stage.sv:105:5
	input wire csr_mstatus_tw_i;
	// Trace: core/rtl/ibex_id_stage.sv:106:5
	input wire illegal_csr_insn_i;
	// Trace: core/rtl/ibex_id_stage.sv:107:5
	input wire data_ind_timing_i;
	// Trace: core/rtl/ibex_id_stage.sv:110:5
	output wire lsu_req_o;
	// Trace: core/rtl/ibex_id_stage.sv:111:5
	output wire lsu_we_o;
	// Trace: core/rtl/ibex_id_stage.sv:112:5
	output wire [1:0] lsu_type_o;
	// Trace: core/rtl/ibex_id_stage.sv:113:5
	output wire lsu_sign_ext_o;
	// Trace: core/rtl/ibex_id_stage.sv:114:5
	output wire [31:0] lsu_wdata_o;
	// Trace: core/rtl/ibex_id_stage.sv:116:5
	input wire lsu_req_done_i;
	// Trace: core/rtl/ibex_id_stage.sv:121:5
	input wire lsu_addr_incr_req_i;
	// Trace: core/rtl/ibex_id_stage.sv:122:5
	input wire [31:0] lsu_addr_last_i;
	// Trace: core/rtl/ibex_id_stage.sv:125:5
	input wire csr_mstatus_mie_i;
	// Trace: core/rtl/ibex_id_stage.sv:126:5
	input wire irq_pending_i;
	// Trace: core/rtl/ibex_id_stage.sv:127:5
	// removed localparam type ibex_pkg_irqs_t
	input wire [17:0] irqs_i;
	// Trace: core/rtl/ibex_id_stage.sv:128:5
	input wire irq_nm_i;
	// Trace: core/rtl/ibex_id_stage.sv:129:5
	output wire nmi_mode_o;
	// Trace: core/rtl/ibex_id_stage.sv:130:5
	input wire [31:0] irqs_x_i;
	// Trace: core/rtl/ibex_id_stage.sv:131:5
	output wire irq_x_ack_o;
	// Trace: core/rtl/ibex_id_stage.sv:132:5
	output wire [4:0] irq_x_ack_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:134:5
	input wire lsu_load_err_i;
	// Trace: core/rtl/ibex_id_stage.sv:135:5
	input wire lsu_store_err_i;
	// Trace: core/rtl/ibex_id_stage.sv:138:5
	output wire debug_mode_o;
	// Trace: core/rtl/ibex_id_stage.sv:139:5
	// removed localparam type ibex_pkg_dbg_cause_e
	output wire [2:0] debug_cause_o;
	// Trace: core/rtl/ibex_id_stage.sv:140:5
	output wire debug_csr_save_o;
	// Trace: core/rtl/ibex_id_stage.sv:141:5
	input wire debug_req_i;
	// Trace: core/rtl/ibex_id_stage.sv:142:5
	input wire debug_single_step_i;
	// Trace: core/rtl/ibex_id_stage.sv:143:5
	input wire debug_ebreakm_i;
	// Trace: core/rtl/ibex_id_stage.sv:144:5
	input wire debug_ebreaku_i;
	// Trace: core/rtl/ibex_id_stage.sv:145:5
	input wire trigger_match_i;
	// Trace: core/rtl/ibex_id_stage.sv:148:5
	input wire [31:0] result_ex_i;
	// Trace: core/rtl/ibex_id_stage.sv:149:5
	input wire [31:0] csr_rdata_i;
	// Trace: core/rtl/ibex_id_stage.sv:152:5
	output wire [4:0] rf_raddr_a_o;
	// Trace: core/rtl/ibex_id_stage.sv:153:5
	input wire [31:0] rf_rdata_a_i;
	// Trace: core/rtl/ibex_id_stage.sv:154:5
	output wire [4:0] rf_raddr_b_o;
	// Trace: core/rtl/ibex_id_stage.sv:155:5
	input wire [31:0] rf_rdata_b_i;
	// Trace: core/rtl/ibex_id_stage.sv:156:5
	output wire rf_ren_a_o;
	// Trace: core/rtl/ibex_id_stage.sv:157:5
	output wire rf_ren_b_o;
	// Trace: core/rtl/ibex_id_stage.sv:160:5
	output wire [4:0] rf_waddr_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:161:5
	output reg [31:0] rf_wdata_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:162:5
	output wire rf_we_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:163:5
	output wire rf_rd_a_wb_match_o;
	// Trace: core/rtl/ibex_id_stage.sv:164:5
	output wire rf_rd_b_wb_match_o;
	// Trace: core/rtl/ibex_id_stage.sv:167:5
	input wire [4:0] rf_waddr_wb_i;
	// Trace: core/rtl/ibex_id_stage.sv:168:5
	input wire [31:0] rf_wdata_fwd_wb_i;
	// Trace: core/rtl/ibex_id_stage.sv:169:5
	input wire rf_write_wb_i;
	// Trace: core/rtl/ibex_id_stage.sv:171:5
	output wire en_wb_o;
	// Trace: core/rtl/ibex_id_stage.sv:172:5
	// removed localparam type ibex_pkg_wb_instr_type_e
	output wire [1:0] instr_type_wb_o;
	// Trace: core/rtl/ibex_id_stage.sv:173:5
	output wire instr_perf_count_id_o;
	// Trace: core/rtl/ibex_id_stage.sv:174:5
	input wire ready_wb_i;
	// Trace: core/rtl/ibex_id_stage.sv:175:5
	input wire outstanding_load_wb_i;
	// Trace: core/rtl/ibex_id_stage.sv:176:5
	input wire outstanding_store_wb_i;
	// Trace: core/rtl/ibex_id_stage.sv:179:5
	output wire perf_jump_o;
	// Trace: core/rtl/ibex_id_stage.sv:180:5
	output reg perf_branch_o;
	// Trace: core/rtl/ibex_id_stage.sv:181:5
	output wire perf_tbranch_o;
	// Trace: core/rtl/ibex_id_stage.sv:182:5
	output wire perf_dside_wait_o;
	// Trace: core/rtl/ibex_id_stage.sv:184:5
	output wire perf_mul_wait_o;
	// Trace: core/rtl/ibex_id_stage.sv:185:5
	output wire perf_div_wait_o;
	// Trace: core/rtl/ibex_id_stage.sv:186:5
	output wire instr_id_done_o;
	// Trace: core/rtl/ibex_id_stage.sv:189:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_id_stage.sv:192:3
	wire illegal_insn_dec;
	// Trace: core/rtl/ibex_id_stage.sv:193:3
	wire ebrk_insn;
	// Trace: core/rtl/ibex_id_stage.sv:194:3
	wire mret_insn_dec;
	// Trace: core/rtl/ibex_id_stage.sv:195:3
	wire dret_insn_dec;
	// Trace: core/rtl/ibex_id_stage.sv:196:3
	wire ecall_insn_dec;
	// Trace: core/rtl/ibex_id_stage.sv:197:3
	wire wfi_insn_dec;
	// Trace: core/rtl/ibex_id_stage.sv:199:3
	wire wb_exception;
	// Trace: core/rtl/ibex_id_stage.sv:201:3
	wire branch_in_dec;
	// Trace: core/rtl/ibex_id_stage.sv:202:3
	reg branch_spec;
	wire branch_set_spec;
	// Trace: core/rtl/ibex_id_stage.sv:203:3
	wire branch_set;
	reg branch_set_d;
	// Trace: core/rtl/ibex_id_stage.sv:204:3
	reg branch_not_set;
	// Trace: core/rtl/ibex_id_stage.sv:205:3
	wire branch_taken;
	// Trace: core/rtl/ibex_id_stage.sv:206:3
	wire jump_in_dec;
	// Trace: core/rtl/ibex_id_stage.sv:207:3
	wire jump_set_dec;
	// Trace: core/rtl/ibex_id_stage.sv:208:3
	reg jump_set;
	// Trace: core/rtl/ibex_id_stage.sv:210:3
	wire instr_first_cycle;
	// Trace: core/rtl/ibex_id_stage.sv:211:3
	wire instr_executing;
	// Trace: core/rtl/ibex_id_stage.sv:212:3
	wire instr_done;
	// Trace: core/rtl/ibex_id_stage.sv:213:3
	wire controller_run;
	// Trace: core/rtl/ibex_id_stage.sv:214:3
	wire stall_ld_hz;
	// Trace: core/rtl/ibex_id_stage.sv:215:3
	wire stall_mem;
	// Trace: core/rtl/ibex_id_stage.sv:216:3
	reg stall_multdiv;
	// Trace: core/rtl/ibex_id_stage.sv:217:3
	reg stall_branch;
	// Trace: core/rtl/ibex_id_stage.sv:218:3
	reg stall_jump;
	// Trace: core/rtl/ibex_id_stage.sv:219:3
	wire stall_id;
	// Trace: core/rtl/ibex_id_stage.sv:220:3
	wire stall_wb;
	// Trace: core/rtl/ibex_id_stage.sv:221:3
	wire flush_id;
	// Trace: core/rtl/ibex_id_stage.sv:222:3
	wire multicycle_done;
	// Trace: core/rtl/ibex_id_stage.sv:225:3
	wire [31:0] imm_i_type;
	// Trace: core/rtl/ibex_id_stage.sv:226:3
	wire [31:0] imm_s_type;
	// Trace: core/rtl/ibex_id_stage.sv:227:3
	wire [31:0] imm_b_type;
	// Trace: core/rtl/ibex_id_stage.sv:228:3
	wire [31:0] imm_u_type;
	// Trace: core/rtl/ibex_id_stage.sv:229:3
	wire [31:0] imm_j_type;
	// Trace: core/rtl/ibex_id_stage.sv:230:3
	wire [31:0] zimm_rs1_type;
	// Trace: core/rtl/ibex_id_stage.sv:232:3
	wire [31:0] imm_a;
	// Trace: core/rtl/ibex_id_stage.sv:233:3
	reg [31:0] imm_b;
	// Trace: core/rtl/ibex_id_stage.sv:237:3
	// removed localparam type ibex_pkg_rf_wd_sel_e
	wire rf_wdata_sel;
	// Trace: core/rtl/ibex_id_stage.sv:238:3
	wire rf_we_dec;
	reg rf_we_raw;
	// Trace: core/rtl/ibex_id_stage.sv:239:3
	wire rf_ren_a;
	wire rf_ren_b;
	// Trace: core/rtl/ibex_id_stage.sv:241:3
	assign rf_ren_a_o = rf_ren_a;
	// Trace: core/rtl/ibex_id_stage.sv:242:3
	assign rf_ren_b_o = rf_ren_b;
	// Trace: core/rtl/ibex_id_stage.sv:244:3
	wire [31:0] rf_rdata_a_fwd;
	// Trace: core/rtl/ibex_id_stage.sv:245:3
	wire [31:0] rf_rdata_b_fwd;
	// Trace: core/rtl/ibex_id_stage.sv:248:3
	wire [5:0] alu_operator;
	// Trace: core/rtl/ibex_id_stage.sv:249:3
	// removed localparam type ibex_pkg_op_a_sel_e
	wire [1:0] alu_op_a_mux_sel;
	wire [1:0] alu_op_a_mux_sel_dec;
	// Trace: core/rtl/ibex_id_stage.sv:250:3
	// removed localparam type ibex_pkg_op_b_sel_e
	wire alu_op_b_mux_sel;
	wire alu_op_b_mux_sel_dec;
	// Trace: core/rtl/ibex_id_stage.sv:251:3
	wire alu_multicycle_dec;
	// Trace: core/rtl/ibex_id_stage.sv:252:3
	reg stall_alu;
	// Trace: core/rtl/ibex_id_stage.sv:254:3
	reg [67:0] imd_val_q;
	// Trace: core/rtl/ibex_id_stage.sv:256:3
	wire [1:0] bt_a_mux_sel;
	// Trace: core/rtl/ibex_id_stage.sv:257:3
	// removed localparam type ibex_pkg_imm_b_sel_e
	wire [2:0] bt_b_mux_sel;
	// Trace: core/rtl/ibex_id_stage.sv:259:3
	// removed localparam type ibex_pkg_imm_a_sel_e
	wire imm_a_mux_sel;
	// Trace: core/rtl/ibex_id_stage.sv:260:3
	wire [2:0] imm_b_mux_sel;
	wire [2:0] imm_b_mux_sel_dec;
	// Trace: core/rtl/ibex_id_stage.sv:263:3
	wire mult_en_id;
	wire mult_en_dec;
	// Trace: core/rtl/ibex_id_stage.sv:264:3
	wire div_en_id;
	wire div_en_dec;
	// Trace: core/rtl/ibex_id_stage.sv:265:3
	wire multdiv_en_dec;
	// Trace: core/rtl/ibex_id_stage.sv:266:3
	wire [1:0] multdiv_operator;
	// Trace: core/rtl/ibex_id_stage.sv:267:3
	wire [1:0] multdiv_signed_mode;
	// Trace: core/rtl/ibex_id_stage.sv:270:3
	wire lsu_we;
	// Trace: core/rtl/ibex_id_stage.sv:271:3
	wire [1:0] lsu_type;
	// Trace: core/rtl/ibex_id_stage.sv:272:3
	wire lsu_sign_ext;
	// Trace: core/rtl/ibex_id_stage.sv:273:3
	wire lsu_req;
	wire lsu_req_dec;
	// Trace: core/rtl/ibex_id_stage.sv:274:3
	wire data_req_allowed;
	// Trace: core/rtl/ibex_id_stage.sv:277:3
	reg csr_pipe_flush;
	// Trace: core/rtl/ibex_id_stage.sv:279:3
	reg [31:0] alu_operand_a;
	// Trace: core/rtl/ibex_id_stage.sv:280:3
	wire [31:0] alu_operand_b;
	// Trace: core/rtl/ibex_id_stage.sv:287:3
	assign alu_op_a_mux_sel = (lsu_addr_incr_req_i ? 2'd1 : alu_op_a_mux_sel_dec);
	// Trace: core/rtl/ibex_id_stage.sv:288:3
	assign alu_op_b_mux_sel = (lsu_addr_incr_req_i ? 1'd1 : alu_op_b_mux_sel_dec);
	// Trace: core/rtl/ibex_id_stage.sv:289:3
	assign imm_b_mux_sel = (lsu_addr_incr_req_i ? 3'd6 : imm_b_mux_sel_dec);
	// Trace: core/rtl/ibex_id_stage.sv:296:3
	assign imm_a = (imm_a_mux_sel == 1'd0 ? zimm_rs1_type : {32 {1'sb0}});
	// Trace: core/rtl/ibex_id_stage.sv:299:3
	always @(*) begin : alu_operand_a_mux
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_id_stage.sv:300:5
		(* full_case, parallel_case *)
		case (alu_op_a_mux_sel)
			2'd0:
				// Trace: core/rtl/ibex_id_stage.sv:301:20
				alu_operand_a = rf_rdata_a_fwd;
			2'd1:
				// Trace: core/rtl/ibex_id_stage.sv:302:20
				alu_operand_a = lsu_addr_last_i;
			2'd2:
				// Trace: core/rtl/ibex_id_stage.sv:303:20
				alu_operand_a = pc_id_i;
			2'd3:
				// Trace: core/rtl/ibex_id_stage.sv:304:20
				alu_operand_a = imm_a;
			default:
				// Trace: core/rtl/ibex_id_stage.sv:305:20
				alu_operand_a = pc_id_i;
		endcase
	end
	// Trace: core/rtl/ibex_id_stage.sv:309:3
	generate
		if (BranchTargetALU) begin : g_btalu_muxes
			// Trace: core/rtl/ibex_id_stage.sv:311:5
			always @(*) begin : bt_operand_a_mux
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_id_stage.sv:312:7
				(* full_case, parallel_case *)
				case (bt_a_mux_sel)
					2'd0:
						// Trace: core/rtl/ibex_id_stage.sv:313:22
						bt_a_operand_o = rf_rdata_a_fwd;
					2'd2:
						// Trace: core/rtl/ibex_id_stage.sv:314:22
						bt_a_operand_o = pc_id_i;
					default:
						// Trace: core/rtl/ibex_id_stage.sv:315:22
						bt_a_operand_o = pc_id_i;
				endcase
			end
			// Trace: core/rtl/ibex_id_stage.sv:320:5
			always @(*) begin : bt_immediate_b_mux
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_id_stage.sv:321:7
				(* full_case, parallel_case *)
				case (bt_b_mux_sel)
					3'd0:
						// Trace: core/rtl/ibex_id_stage.sv:322:26
						bt_b_operand_o = imm_i_type;
					3'd2:
						// Trace: core/rtl/ibex_id_stage.sv:323:26
						bt_b_operand_o = imm_b_type;
					3'd4:
						// Trace: core/rtl/ibex_id_stage.sv:324:26
						bt_b_operand_o = imm_j_type;
					3'd5:
						// Trace: core/rtl/ibex_id_stage.sv:325:26
						bt_b_operand_o = (instr_is_compressed_i ? 32'h00000002 : 32'h00000004);
					default:
						// Trace: core/rtl/ibex_id_stage.sv:326:26
						bt_b_operand_o = (instr_is_compressed_i ? 32'h00000002 : 32'h00000004);
				endcase
			end
			// Trace: core/rtl/ibex_id_stage.sv:331:5
			always @(*) begin : immediate_b_mux
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_id_stage.sv:332:7
				(* full_case, parallel_case *)
				case (imm_b_mux_sel)
					3'd0:
						// Trace: core/rtl/ibex_id_stage.sv:333:26
						imm_b = imm_i_type;
					3'd1:
						// Trace: core/rtl/ibex_id_stage.sv:334:26
						imm_b = imm_s_type;
					3'd3:
						// Trace: core/rtl/ibex_id_stage.sv:335:26
						imm_b = imm_u_type;
					3'd5:
						// Trace: core/rtl/ibex_id_stage.sv:336:26
						imm_b = (instr_is_compressed_i ? 32'h00000002 : 32'h00000004);
					3'd6:
						// Trace: core/rtl/ibex_id_stage.sv:337:26
						imm_b = 32'h00000004;
					default:
						// Trace: core/rtl/ibex_id_stage.sv:338:26
						imm_b = 32'h00000004;
				endcase
			end
		end
		else begin : g_nobtalu
			// Trace: core/rtl/ibex_id_stage.sv:348:5
			wire [1:0] unused_a_mux_sel;
			// Trace: core/rtl/ibex_id_stage.sv:349:5
			wire [2:0] unused_b_mux_sel;
			// Trace: core/rtl/ibex_id_stage.sv:351:5
			assign unused_a_mux_sel = bt_a_mux_sel;
			// Trace: core/rtl/ibex_id_stage.sv:352:5
			assign unused_b_mux_sel = bt_b_mux_sel;
			// Trace: core/rtl/ibex_id_stage.sv:353:5
			wire [32:1] sv2v_tmp_1FCCD;
			assign sv2v_tmp_1FCCD = 1'sb0;
			always @(*) bt_a_operand_o = sv2v_tmp_1FCCD;
			// Trace: core/rtl/ibex_id_stage.sv:354:5
			wire [32:1] sv2v_tmp_B876E;
			assign sv2v_tmp_B876E = 1'sb0;
			always @(*) bt_b_operand_o = sv2v_tmp_B876E;
			// Trace: core/rtl/ibex_id_stage.sv:357:5
			always @(*) begin : immediate_b_mux
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_id_stage.sv:358:7
				(* full_case, parallel_case *)
				case (imm_b_mux_sel)
					3'd0:
						// Trace: core/rtl/ibex_id_stage.sv:359:26
						imm_b = imm_i_type;
					3'd1:
						// Trace: core/rtl/ibex_id_stage.sv:360:26
						imm_b = imm_s_type;
					3'd2:
						// Trace: core/rtl/ibex_id_stage.sv:361:26
						imm_b = imm_b_type;
					3'd3:
						// Trace: core/rtl/ibex_id_stage.sv:362:26
						imm_b = imm_u_type;
					3'd4:
						// Trace: core/rtl/ibex_id_stage.sv:363:26
						imm_b = imm_j_type;
					3'd5:
						// Trace: core/rtl/ibex_id_stage.sv:364:26
						imm_b = (instr_is_compressed_i ? 32'h00000002 : 32'h00000004);
					3'd6:
						// Trace: core/rtl/ibex_id_stage.sv:365:26
						imm_b = 32'h00000004;
					default:
						// Trace: core/rtl/ibex_id_stage.sv:366:26
						imm_b = 32'h00000004;
				endcase
			end
		end
	endgenerate
	// Trace: core/rtl/ibex_id_stage.sv:380:3
	assign alu_operand_b = (alu_op_b_mux_sel == 1'd1 ? imm_b : rf_rdata_b_fwd);
	// Trace: core/rtl/ibex_id_stage.sv:386:3
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < 2; _gv_i_1 = _gv_i_1 + 1) begin : gen_intermediate_val_reg
			localparam i = _gv_i_1;
			// Trace: core/rtl/ibex_id_stage.sv:387:5
			always @(posedge clk_i or negedge rst_ni) begin : intermediate_val_reg
				// Trace: core/rtl/ibex_id_stage.sv:388:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_id_stage.sv:389:9
					imd_val_q[(1 - i) * 34+:34] <= 1'sb0;
				else if (imd_val_we_ex_i[i])
					// Trace: core/rtl/ibex_id_stage.sv:391:9
					imd_val_q[(1 - i) * 34+:34] <= imd_val_d_ex_i[(1 - i) * 34+:34];
			end
		end
	endgenerate
	// Trace: core/rtl/ibex_id_stage.sv:396:3
	assign imd_val_q_ex_o = imd_val_q;
	// Trace: core/rtl/ibex_id_stage.sv:403:3
	assign rf_we_id_o = (rf_we_raw & instr_executing) & ~illegal_csr_insn_i;
	// Trace: core/rtl/ibex_id_stage.sv:406:3
	always @(*) begin : rf_wdata_id_mux
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_id_stage.sv:407:5
		(* full_case, parallel_case *)
		case (rf_wdata_sel)
			1'd0:
				// Trace: core/rtl/ibex_id_stage.sv:408:18
				rf_wdata_id_o = result_ex_i;
			1'd1:
				// Trace: core/rtl/ibex_id_stage.sv:409:18
				rf_wdata_id_o = csr_rdata_i;
			default:
				// Trace: core/rtl/ibex_id_stage.sv:410:18
				rf_wdata_id_o = result_ex_i;
		endcase
	end
	// Trace: core/rtl/ibex_id_stage.sv:418:3
	ibex_decoder #(
		.RV32E(RV32E),
		.RV32M(RV32M),
		.RV32B(RV32B),
		.BranchTargetALU(BranchTargetALU)
	) decoder_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.illegal_insn_o(illegal_insn_dec),
		.ebrk_insn_o(ebrk_insn),
		.mret_insn_o(mret_insn_dec),
		.dret_insn_o(dret_insn_dec),
		.ecall_insn_o(ecall_insn_dec),
		.wfi_insn_o(wfi_insn_dec),
		.jump_set_o(jump_set_dec),
		.branch_taken_i(branch_taken),
		.icache_inval_o(icache_inval_o),
		.instr_first_cycle_i(instr_first_cycle),
		.instr_rdata_i(instr_rdata_i),
		.instr_rdata_alu_i(instr_rdata_alu_i),
		.illegal_c_insn_i(illegal_c_insn_i),
		.imm_a_mux_sel_o(imm_a_mux_sel),
		.imm_b_mux_sel_o(imm_b_mux_sel_dec),
		.bt_a_mux_sel_o(bt_a_mux_sel),
		.bt_b_mux_sel_o(bt_b_mux_sel),
		.imm_i_type_o(imm_i_type),
		.imm_s_type_o(imm_s_type),
		.imm_b_type_o(imm_b_type),
		.imm_u_type_o(imm_u_type),
		.imm_j_type_o(imm_j_type),
		.zimm_rs1_type_o(zimm_rs1_type),
		.rf_wdata_sel_o(rf_wdata_sel),
		.rf_we_o(rf_we_dec),
		.rf_raddr_a_o(rf_raddr_a_o),
		.rf_raddr_b_o(rf_raddr_b_o),
		.rf_waddr_o(rf_waddr_id_o),
		.rf_ren_a_o(rf_ren_a),
		.rf_ren_b_o(rf_ren_b),
		.alu_operator_o(alu_operator),
		.alu_op_a_mux_sel_o(alu_op_a_mux_sel_dec),
		.alu_op_b_mux_sel_o(alu_op_b_mux_sel_dec),
		.alu_multicycle_o(alu_multicycle_dec),
		.mult_en_o(mult_en_dec),
		.div_en_o(div_en_dec),
		.mult_sel_o(mult_sel_ex_o),
		.div_sel_o(div_sel_ex_o),
		.multdiv_operator_o(multdiv_operator),
		.multdiv_signed_mode_o(multdiv_signed_mode),
		.csr_access_o(csr_access_o),
		.csr_op_o(csr_op_o),
		.data_req_o(lsu_req_dec),
		.data_we_o(lsu_we),
		.data_type_o(lsu_type),
		.data_sign_extension_o(lsu_sign_ext),
		.jump_in_dec_o(jump_in_dec),
		.branch_in_dec_o(branch_in_dec)
	);
	// Trace: core/rtl/ibex_id_stage.sv:499:3
	// removed localparam type ibex_pkg_csr_num_e
	always @(*) begin : csr_pipeline_flushes
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_id_stage.sv:500:5
		csr_pipe_flush = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:507:5
		if ((csr_op_en_o == 1'b1) && ((csr_op_o == 2'd1) || (csr_op_o == 2'd2))) begin
			begin
				// Trace: core/rtl/ibex_id_stage.sv:508:7
				if ((instr_rdata_i[31:20] == 12'h300) || (instr_rdata_i[31:20] == 12'h304))
					// Trace: core/rtl/ibex_id_stage.sv:510:9
					csr_pipe_flush = 1'b1;
			end
		end
		else if ((csr_op_en_o == 1'b1) && (csr_op_o != 2'd0)) begin
			begin
				// Trace: core/rtl/ibex_id_stage.sv:513:7
				if ((((instr_rdata_i[31:20] == 12'h7b0) || (instr_rdata_i[31:20] == 12'h7b1)) || (instr_rdata_i[31:20] == 12'h7b2)) || (instr_rdata_i[31:20] == 12'h7b3))
					// Trace: core/rtl/ibex_id_stage.sv:517:9
					csr_pipe_flush = 1'b1;
			end
		end
	end
	// Trace: core/rtl/ibex_id_stage.sv:526:3
	assign illegal_insn_o = instr_valid_i & (illegal_insn_dec | illegal_csr_insn_i);
	// Trace: core/rtl/ibex_id_stage.sv:528:3
	ibex_controller #(
		.WritebackStage(WritebackStage),
		.BranchPredictor(BranchPredictor)
	) controller_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.ctrl_busy_o(ctrl_busy_o),
		.illegal_insn_i(illegal_insn_o),
		.ecall_insn_i(ecall_insn_dec),
		.mret_insn_i(mret_insn_dec),
		.dret_insn_i(dret_insn_dec),
		.wfi_insn_i(wfi_insn_dec),
		.ebrk_insn_i(ebrk_insn),
		.csr_pipe_flush_i(csr_pipe_flush),
		.instr_valid_i(instr_valid_i),
		.instr_i(instr_rdata_i),
		.instr_compressed_i(instr_rdata_c_i),
		.instr_is_compressed_i(instr_is_compressed_i),
		.instr_bp_taken_i(instr_bp_taken_i),
		.instr_fetch_err_i(instr_fetch_err_i),
		.instr_fetch_err_plus2_i(instr_fetch_err_plus2_i),
		.pc_id_i(pc_id_i),
		.instr_valid_clear_o(instr_valid_clear_o),
		.id_in_ready_o(id_in_ready_o),
		.controller_run_o(controller_run),
		.instr_req_o(instr_req_o),
		.pc_set_o(pc_set_o),
		.pc_set_spec_o(pc_set_spec_o),
		.pc_mux_o(pc_mux_o),
		.nt_branch_mispredict_o(nt_branch_mispredict_o),
		.exc_pc_mux_o(exc_pc_mux_o),
		.exc_cause_o(exc_cause_o),
		.lsu_addr_last_i(lsu_addr_last_i),
		.load_err_i(lsu_load_err_i),
		.store_err_i(lsu_store_err_i),
		.wb_exception_o(wb_exception),
		.branch_set_i(branch_set),
		.branch_set_spec_i(branch_set_spec),
		.branch_not_set_i(branch_not_set),
		.jump_set_i(jump_set),
		.csr_mstatus_mie_i(csr_mstatus_mie_i),
		.irq_pending_i(irq_pending_i),
		.irqs_i(irqs_i),
		.irq_nm_i(irq_nm_i),
		.nmi_mode_o(nmi_mode_o),
		.irqs_x_i(irqs_x_i),
		.irq_x_ack_o(irq_x_ack_o),
		.irq_x_ack_id_o(irq_x_ack_id_o),
		.csr_save_if_o(csr_save_if_o),
		.csr_save_id_o(csr_save_id_o),
		.csr_save_wb_o(csr_save_wb_o),
		.csr_restore_mret_id_o(csr_restore_mret_id_o),
		.csr_restore_dret_id_o(csr_restore_dret_id_o),
		.csr_save_cause_o(csr_save_cause_o),
		.csr_mtval_o(csr_mtval_o),
		.priv_mode_i(priv_mode_i),
		.csr_mstatus_tw_i(csr_mstatus_tw_i),
		.debug_mode_o(debug_mode_o),
		.debug_cause_o(debug_cause_o),
		.debug_csr_save_o(debug_csr_save_o),
		.debug_req_i(debug_req_i),
		.debug_single_step_i(debug_single_step_i),
		.debug_ebreakm_i(debug_ebreakm_i),
		.debug_ebreaku_i(debug_ebreaku_i),
		.trigger_match_i(trigger_match_i),
		.stall_id_i(stall_id),
		.stall_wb_i(stall_wb),
		.flush_id_o(flush_id),
		.ready_wb_i(ready_wb_i),
		.perf_jump_o(perf_jump_o),
		.perf_tbranch_o(perf_tbranch_o)
	);
	// Trace: core/rtl/ibex_id_stage.sv:623:3
	assign multdiv_en_dec = mult_en_dec | div_en_dec;
	// Trace: core/rtl/ibex_id_stage.sv:625:3
	assign lsu_req = (instr_executing ? data_req_allowed & lsu_req_dec : 1'b0);
	// Trace: core/rtl/ibex_id_stage.sv:626:3
	assign mult_en_id = (instr_executing ? mult_en_dec : 1'b0);
	// Trace: core/rtl/ibex_id_stage.sv:627:3
	assign div_en_id = (instr_executing ? div_en_dec : 1'b0);
	// Trace: core/rtl/ibex_id_stage.sv:629:3
	assign lsu_req_o = lsu_req;
	// Trace: core/rtl/ibex_id_stage.sv:630:3
	assign lsu_we_o = lsu_we;
	// Trace: core/rtl/ibex_id_stage.sv:631:3
	assign lsu_type_o = lsu_type;
	// Trace: core/rtl/ibex_id_stage.sv:632:3
	assign lsu_sign_ext_o = lsu_sign_ext;
	// Trace: core/rtl/ibex_id_stage.sv:633:3
	assign lsu_wdata_o = rf_rdata_b_fwd;
	// Trace: core/rtl/ibex_id_stage.sv:638:3
	assign csr_op_en_o = (csr_access_o & instr_executing) & instr_id_done_o;
	// Trace: core/rtl/ibex_id_stage.sv:640:3
	assign alu_operator_ex_o = alu_operator;
	// Trace: core/rtl/ibex_id_stage.sv:641:3
	assign alu_operand_a_ex_o = alu_operand_a;
	// Trace: core/rtl/ibex_id_stage.sv:642:3
	assign alu_operand_b_ex_o = alu_operand_b;
	// Trace: core/rtl/ibex_id_stage.sv:644:3
	assign mult_en_ex_o = mult_en_id;
	// Trace: core/rtl/ibex_id_stage.sv:645:3
	assign div_en_ex_o = div_en_id;
	// Trace: core/rtl/ibex_id_stage.sv:647:3
	assign multdiv_operator_ex_o = multdiv_operator;
	// Trace: core/rtl/ibex_id_stage.sv:648:3
	assign multdiv_signed_mode_ex_o = multdiv_signed_mode;
	// Trace: core/rtl/ibex_id_stage.sv:649:3
	assign multdiv_operand_a_ex_o = rf_rdata_a_fwd;
	// Trace: core/rtl/ibex_id_stage.sv:650:3
	assign multdiv_operand_b_ex_o = rf_rdata_b_fwd;
	// Trace: core/rtl/ibex_id_stage.sv:656:3
	generate
		if (BranchTargetALU && !DataIndTiming) begin : g_branch_set_direct
			// Trace: core/rtl/ibex_id_stage.sv:659:5
			assign branch_set = branch_set_d;
			// Trace: core/rtl/ibex_id_stage.sv:660:5
			assign branch_set_spec = branch_spec;
		end
		else begin : g_branch_set_flop
			// Trace: core/rtl/ibex_id_stage.sv:664:5
			reg branch_set_q;
			// Trace: core/rtl/ibex_id_stage.sv:666:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_id_stage.sv:667:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_id_stage.sv:668:9
					branch_set_q <= 1'b0;
				else
					// Trace: core/rtl/ibex_id_stage.sv:670:9
					branch_set_q <= branch_set_d;
			// Trace: core/rtl/ibex_id_stage.sv:677:5
			assign branch_set = (BranchTargetALU && !data_ind_timing_i ? branch_set_d : branch_set_q);
			// Trace: core/rtl/ibex_id_stage.sv:679:5
			assign branch_set_spec = (BranchTargetALU && !data_ind_timing_i ? branch_spec : branch_set_q);
		end
	endgenerate
	// Trace: core/rtl/ibex_id_stage.sv:684:3
	generate
		if (DataIndTiming) begin : g_sec_branch_taken
			// Trace: core/rtl/ibex_id_stage.sv:685:5
			reg branch_taken_q;
			// Trace: core/rtl/ibex_id_stage.sv:687:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_id_stage.sv:688:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_id_stage.sv:689:9
					branch_taken_q <= 1'b0;
				else
					// Trace: core/rtl/ibex_id_stage.sv:691:9
					branch_taken_q <= branch_decision_i;
			// Trace: core/rtl/ibex_id_stage.sv:695:5
			assign branch_taken = ~data_ind_timing_i | branch_taken_q;
		end
		else begin : g_nosec_branch_taken
			// Trace: core/rtl/ibex_id_stage.sv:700:5
			assign branch_taken = 1'b1;
		end
	endgenerate
	// Trace: core/rtl/ibex_id_stage.sv:714:3
	// removed localparam type id_fsm_e
	// Trace: core/rtl/ibex_id_stage.sv:715:3
	reg id_fsm_q;
	reg id_fsm_d;
	// Trace: core/rtl/ibex_id_stage.sv:717:3
	always @(posedge clk_i or negedge rst_ni) begin : id_pipeline_reg
		// Trace: core/rtl/ibex_id_stage.sv:718:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_id_stage.sv:719:7
			id_fsm_q <= 1'd0;
		else
			// Trace: core/rtl/ibex_id_stage.sv:721:7
			id_fsm_q <= id_fsm_d;
	end
	// Trace: core/rtl/ibex_id_stage.sv:730:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_id_stage.sv:731:5
		id_fsm_d = id_fsm_q;
		// Trace: core/rtl/ibex_id_stage.sv:732:5
		rf_we_raw = rf_we_dec;
		// Trace: core/rtl/ibex_id_stage.sv:733:5
		stall_multdiv = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:734:5
		stall_jump = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:735:5
		stall_branch = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:736:5
		stall_alu = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:737:5
		branch_set_d = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:738:5
		branch_spec = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:739:5
		branch_not_set = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:740:5
		jump_set = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:741:5
		perf_branch_o = 1'b0;
		// Trace: core/rtl/ibex_id_stage.sv:743:5
		if (instr_executing)
			// Trace: core/rtl/ibex_id_stage.sv:744:7
			(* full_case, parallel_case *)
			case (id_fsm_q)
				1'd0:
					// Trace: core/rtl/ibex_id_stage.sv:746:11
					(* full_case, parallel_case *)
					case (1'b1)
						lsu_req_dec:
							// Trace: core/rtl/ibex_id_stage.sv:748:15
							if (!WritebackStage)
								// Trace: core/rtl/ibex_id_stage.sv:750:17
								id_fsm_d = 1'd1;
							else
								// Trace: core/rtl/ibex_id_stage.sv:752:17
								if (~lsu_req_done_i)
									// Trace: core/rtl/ibex_id_stage.sv:753:19
									id_fsm_d = 1'd1;
						multdiv_en_dec:
							// Trace: core/rtl/ibex_id_stage.sv:759:15
							if (~ex_valid_i) begin
								// Trace: core/rtl/ibex_id_stage.sv:762:17
								id_fsm_d = 1'd1;
								// Trace: core/rtl/ibex_id_stage.sv:763:17
								rf_we_raw = 1'b0;
								// Trace: core/rtl/ibex_id_stage.sv:764:17
								stall_multdiv = 1'b1;
							end
						branch_in_dec: begin
							// Trace: core/rtl/ibex_id_stage.sv:771:15
							id_fsm_d = (data_ind_timing_i || (!BranchTargetALU && branch_decision_i) ? 1'd1 : 1'd0);
							// Trace: core/rtl/ibex_id_stage.sv:773:15
							stall_branch = (~BranchTargetALU & branch_decision_i) | data_ind_timing_i;
							// Trace: core/rtl/ibex_id_stage.sv:774:15
							branch_set_d = branch_decision_i | data_ind_timing_i;
							// Trace: core/rtl/ibex_id_stage.sv:776:15
							if (BranchPredictor)
								// Trace: core/rtl/ibex_id_stage.sv:777:17
								branch_not_set = ~branch_decision_i;
							// Trace: core/rtl/ibex_id_stage.sv:781:15
							branch_spec = (SpecBranch ? 1'b1 : branch_decision_i);
							// Trace: core/rtl/ibex_id_stage.sv:782:15
							perf_branch_o = 1'b1;
						end
						jump_in_dec: begin
							// Trace: core/rtl/ibex_id_stage.sv:787:15
							id_fsm_d = (BranchTargetALU ? 1'd0 : 1'd1);
							// Trace: core/rtl/ibex_id_stage.sv:788:15
							stall_jump = ~BranchTargetALU;
							// Trace: core/rtl/ibex_id_stage.sv:789:15
							jump_set = jump_set_dec;
						end
						alu_multicycle_dec: begin
							// Trace: core/rtl/ibex_id_stage.sv:792:15
							stall_alu = 1'b1;
							// Trace: core/rtl/ibex_id_stage.sv:793:15
							id_fsm_d = 1'd1;
							// Trace: core/rtl/ibex_id_stage.sv:794:15
							rf_we_raw = 1'b0;
						end
						default:
							// Trace: core/rtl/ibex_id_stage.sv:797:15
							id_fsm_d = 1'd0;
					endcase
				1'd1: begin
					// Trace: core/rtl/ibex_id_stage.sv:803:11
					if (multdiv_en_dec)
						// Trace: core/rtl/ibex_id_stage.sv:804:13
						rf_we_raw = rf_we_dec & ex_valid_i;
					if (multicycle_done & ready_wb_i)
						// Trace: core/rtl/ibex_id_stage.sv:808:13
						id_fsm_d = 1'd0;
					else begin
						// Trace: core/rtl/ibex_id_stage.sv:810:13
						stall_multdiv = multdiv_en_dec;
						// Trace: core/rtl/ibex_id_stage.sv:811:13
						stall_branch = branch_in_dec;
						// Trace: core/rtl/ibex_id_stage.sv:812:13
						stall_jump = jump_in_dec;
					end
				end
				default:
					// Trace: core/rtl/ibex_id_stage.sv:817:11
					id_fsm_d = 1'd0;
			endcase
	end
	// Trace: core/rtl/ibex_id_stage.sv:824:3
	assign multdiv_ready_id_o = ready_wb_i;
	// Trace: core/rtl/ibex_id_stage.sv:829:3
	assign stall_id = ((((stall_ld_hz | stall_mem) | stall_multdiv) | stall_jump) | stall_branch) | stall_alu;
	// Trace: core/rtl/ibex_id_stage.sv:832:3
	assign instr_done = (~stall_id & ~flush_id) & instr_executing;
	// Trace: core/rtl/ibex_id_stage.sv:836:3
	assign instr_first_cycle = instr_valid_i & (id_fsm_q == 1'd0);
	// Trace: core/rtl/ibex_id_stage.sv:839:3
	assign instr_first_cycle_id_o = instr_first_cycle;
	// Trace: core/rtl/ibex_id_stage.sv:841:3
	generate
		if (WritebackStage) begin : gen_stall_mem
			// Trace: core/rtl/ibex_id_stage.sv:843:5
			wire rf_rd_a_wb_match;
			// Trace: core/rtl/ibex_id_stage.sv:844:5
			wire rf_rd_b_wb_match;
			// Trace: core/rtl/ibex_id_stage.sv:846:5
			wire rf_rd_a_hz;
			// Trace: core/rtl/ibex_id_stage.sv:847:5
			wire rf_rd_b_hz;
			// Trace: core/rtl/ibex_id_stage.sv:849:5
			wire outstanding_memory_access;
			// Trace: core/rtl/ibex_id_stage.sv:851:5
			wire instr_kill;
			// Trace: core/rtl/ibex_id_stage.sv:853:5
			assign multicycle_done = (lsu_req_dec ? ~stall_mem : ex_valid_i);
			// Trace: core/rtl/ibex_id_stage.sv:856:5
			assign outstanding_memory_access = (outstanding_load_wb_i | outstanding_store_wb_i) & ~lsu_resp_valid_i;
			// Trace: core/rtl/ibex_id_stage.sv:860:5
			assign data_req_allowed = ~outstanding_memory_access;
			// Trace: core/rtl/ibex_id_stage.sv:870:5
			assign instr_kill = (instr_fetch_err_i | wb_exception) | ~controller_run;
			// Trace: core/rtl/ibex_id_stage.sv:882:5
			assign instr_executing = ((instr_valid_i & ~instr_kill) & ~stall_ld_hz) & ~outstanding_memory_access;
			// Trace: core/rtl/ibex_id_stage.sv:895:5
			assign stall_mem = instr_valid_i & (outstanding_memory_access | (lsu_req_dec & ~lsu_req_done_i));
			// Trace: core/rtl/ibex_id_stage.sv:903:5
			assign rf_rd_a_wb_match = (rf_waddr_wb_i == rf_raddr_a_o) & |rf_raddr_a_o;
			// Trace: core/rtl/ibex_id_stage.sv:904:5
			assign rf_rd_b_wb_match = (rf_waddr_wb_i == rf_raddr_b_o) & |rf_raddr_b_o;
			// Trace: core/rtl/ibex_id_stage.sv:906:5
			assign rf_rd_a_wb_match_o = rf_rd_a_wb_match;
			// Trace: core/rtl/ibex_id_stage.sv:907:5
			assign rf_rd_b_wb_match_o = rf_rd_b_wb_match;
			// Trace: core/rtl/ibex_id_stage.sv:911:5
			assign rf_rd_a_hz = rf_rd_a_wb_match & rf_ren_a;
			// Trace: core/rtl/ibex_id_stage.sv:912:5
			assign rf_rd_b_hz = rf_rd_b_wb_match & rf_ren_b;
			// Trace: core/rtl/ibex_id_stage.sv:917:5
			assign rf_rdata_a_fwd = (rf_rd_a_wb_match & rf_write_wb_i ? rf_wdata_fwd_wb_i : rf_rdata_a_i);
			// Trace: core/rtl/ibex_id_stage.sv:918:5
			assign rf_rdata_b_fwd = (rf_rd_b_wb_match & rf_write_wb_i ? rf_wdata_fwd_wb_i : rf_rdata_b_i);
			// Trace: core/rtl/ibex_id_stage.sv:920:5
			assign stall_ld_hz = outstanding_load_wb_i & (rf_rd_a_hz | rf_rd_b_hz);
			// Trace: core/rtl/ibex_id_stage.sv:922:5
			assign instr_type_wb_o = (~lsu_req_dec ? 2'd2 : (lsu_we ? 2'd1 : 2'd0));
			// Trace: core/rtl/ibex_id_stage.sv:926:5
			assign instr_id_done_o = en_wb_o & ready_wb_i;
			// Trace: core/rtl/ibex_id_stage.sv:929:5
			assign stall_wb = en_wb_o & ~ready_wb_i;
			// Trace: core/rtl/ibex_id_stage.sv:931:5
			assign perf_dside_wait_o = (instr_valid_i & ~instr_kill) & (outstanding_memory_access | stall_ld_hz);
		end
		else begin : gen_no_stall_mem
			// Trace: core/rtl/ibex_id_stage.sv:935:5
			assign multicycle_done = (lsu_req_dec ? lsu_resp_valid_i : ex_valid_i);
			// Trace: core/rtl/ibex_id_stage.sv:937:5
			assign data_req_allowed = instr_first_cycle;
			// Trace: core/rtl/ibex_id_stage.sv:941:5
			assign stall_mem = instr_valid_i & (lsu_req_dec & (~lsu_resp_valid_i | instr_first_cycle));
			// Trace: core/rtl/ibex_id_stage.sv:944:5
			assign stall_ld_hz = 1'b0;
			// Trace: core/rtl/ibex_id_stage.sv:947:5
			assign instr_executing = (instr_valid_i & ~instr_fetch_err_i) & controller_run;
			// Trace: core/rtl/ibex_id_stage.sv:954:5
			assign rf_rdata_a_fwd = rf_rdata_a_i;
			// Trace: core/rtl/ibex_id_stage.sv:955:5
			assign rf_rdata_b_fwd = rf_rdata_b_i;
			// Trace: core/rtl/ibex_id_stage.sv:957:5
			assign rf_rd_a_wb_match_o = 1'b0;
			// Trace: core/rtl/ibex_id_stage.sv:958:5
			assign rf_rd_b_wb_match_o = 1'b0;
			// Trace: core/rtl/ibex_id_stage.sv:963:5
			wire unused_data_req_done_ex;
			// Trace: core/rtl/ibex_id_stage.sv:964:5
			wire [4:0] unused_rf_waddr_wb;
			// Trace: core/rtl/ibex_id_stage.sv:965:5
			wire unused_rf_write_wb;
			// Trace: core/rtl/ibex_id_stage.sv:966:5
			wire unused_outstanding_load_wb;
			// Trace: core/rtl/ibex_id_stage.sv:967:5
			wire unused_outstanding_store_wb;
			// Trace: core/rtl/ibex_id_stage.sv:968:5
			wire unused_wb_exception;
			// Trace: core/rtl/ibex_id_stage.sv:969:5
			wire [31:0] unused_rf_wdata_fwd_wb;
			// Trace: core/rtl/ibex_id_stage.sv:971:5
			assign unused_data_req_done_ex = lsu_req_done_i;
			// Trace: core/rtl/ibex_id_stage.sv:972:5
			assign unused_rf_waddr_wb = rf_waddr_wb_i;
			// Trace: core/rtl/ibex_id_stage.sv:973:5
			assign unused_rf_write_wb = rf_write_wb_i;
			// Trace: core/rtl/ibex_id_stage.sv:974:5
			assign unused_outstanding_load_wb = outstanding_load_wb_i;
			// Trace: core/rtl/ibex_id_stage.sv:975:5
			assign unused_outstanding_store_wb = outstanding_store_wb_i;
			// Trace: core/rtl/ibex_id_stage.sv:976:5
			assign unused_wb_exception = wb_exception;
			// Trace: core/rtl/ibex_id_stage.sv:977:5
			assign unused_rf_wdata_fwd_wb = rf_wdata_fwd_wb_i;
			// Trace: core/rtl/ibex_id_stage.sv:979:5
			assign instr_type_wb_o = 2'd2;
			// Trace: core/rtl/ibex_id_stage.sv:980:5
			assign stall_wb = 1'b0;
			// Trace: core/rtl/ibex_id_stage.sv:982:5
			assign perf_dside_wait_o = (instr_executing & lsu_req_dec) & ~lsu_resp_valid_i;
			// Trace: core/rtl/ibex_id_stage.sv:984:5
			assign instr_id_done_o = instr_done;
		end
	endgenerate
	// Trace: core/rtl/ibex_id_stage.sv:989:3
	assign instr_perf_count_id_o = (((~ebrk_insn & ~ecall_insn_dec) & ~illegal_insn_dec) & ~illegal_csr_insn_i) & ~instr_fetch_err_i;
	// Trace: core/rtl/ibex_id_stage.sv:994:3
	assign en_wb_o = instr_done;
	// Trace: core/rtl/ibex_id_stage.sv:996:3
	assign perf_mul_wait_o = stall_multdiv & mult_en_dec;
	// Trace: core/rtl/ibex_id_stage.sv:997:3
	assign perf_div_wait_o = stall_multdiv & div_en_dec;
	initial _sv2v_0 = 0;
endmodule
