// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_core (
	clk_i,
	rst_ni,
	test_en_i,
	hart_id_i,
	boot_addr_i,
	instr_req_o,
	instr_gnt_i,
	instr_rvalid_i,
	instr_addr_o,
	instr_rdata_i,
	instr_err_i,
	data_req_o,
	data_gnt_i,
	data_rvalid_i,
	data_we_o,
	data_be_o,
	data_addr_o,
	data_wdata_o,
	data_rdata_i,
	data_err_i,
	irq_software_i,
	irq_timer_i,
	irq_external_i,
	irq_fast_i,
	irq_nm_i,
	irq_x_i,
	irq_x_ack_o,
	irq_x_ack_id_o,
	external_perf_i,
	debug_req_i,
	rvfi_valid,
	rvfi_order,
	rvfi_insn,
	rvfi_trap,
	rvfi_halt,
	rvfi_intr,
	rvfi_mode,
	rvfi_ixl,
	rvfi_rs1_addr,
	rvfi_rs2_addr,
	rvfi_rs3_addr,
	rvfi_rs1_rdata,
	rvfi_rs2_rdata,
	rvfi_rs3_rdata,
	rvfi_rd_addr,
	rvfi_rd_wdata,
	rvfi_pc_rdata,
	rvfi_pc_wdata,
	rvfi_mem_addr,
	rvfi_mem_rmask,
	rvfi_mem_wmask,
	rvfi_mem_rdata,
	rvfi_mem_wdata,
	fetch_enable_i,
	alert_minor_o,
	alert_major_o,
	core_sleep_o,
	fetch_o,
	retire_o,
	retire_instr_o,
	regfile_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_core.sv:16:15
	parameter [0:0] PMPEnable = 1'b0;
	// Trace: core/rtl/ibex_core.sv:17:15
	parameter [31:0] PMPGranularity = 0;
	// Trace: core/rtl/ibex_core.sv:18:15
	parameter [31:0] PMPNumRegions = 4;
	// Trace: core/rtl/ibex_core.sv:19:15
	parameter [31:0] MHPMCounterNum = 0;
	// Trace: core/rtl/ibex_core.sv:20:15
	parameter [31:0] MHPMCounterWidth = 40;
	// Trace: core/rtl/ibex_core.sv:21:15
	parameter [0:0] RV32E = 1'b0;
	// Trace: core/rtl/ibex_core.sv:22:15
	// removed localparam type ibex_pkg_rv32m_e
	parameter integer RV32M = 32'sd2;
	// Trace: core/rtl/ibex_core.sv:23:15
	// removed localparam type ibex_pkg_rv32b_e
	parameter integer RV32B = 32'sd0;
	// Trace: core/rtl/ibex_core.sv:24:15
	// removed localparam type ibex_pkg_regfile_e
	parameter integer RegFile = 32'sd0;
	// Trace: core/rtl/ibex_core.sv:25:15
	parameter [0:0] BranchTargetALU = 1'b0;
	// Trace: core/rtl/ibex_core.sv:26:15
	parameter [0:0] WritebackStage = 1'b0;
	// Trace: core/rtl/ibex_core.sv:27:15
	parameter [0:0] ICache = 1'b0;
	// Trace: core/rtl/ibex_core.sv:28:15
	parameter [0:0] ICacheECC = 1'b0;
	// Trace: core/rtl/ibex_core.sv:29:15
	parameter [0:0] BranchPredictor = 1'b0;
	// Trace: core/rtl/ibex_core.sv:30:15
	parameter [0:0] DbgTriggerEn = 1'b0;
	// Trace: core/rtl/ibex_core.sv:31:15
	parameter [31:0] DbgHwBreakNum = 1;
	// Trace: core/rtl/ibex_core.sv:32:15
	parameter [0:0] SecureIbex = 1'b0;
	// Trace: core/rtl/ibex_core.sv:33:15
	parameter [31:0] DmHaltAddr = 32'h1a110800;
	// Trace: core/rtl/ibex_core.sv:34:15
	parameter [31:0] DmExceptionAddr = 32'h1a110808;
	// Trace: core/rtl/ibex_core.sv:37:5
	input wire clk_i;
	// Trace: core/rtl/ibex_core.sv:38:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_core.sv:40:5
	input wire test_en_i;
	// Trace: core/rtl/ibex_core.sv:42:5
	input wire [31:0] hart_id_i;
	// Trace: core/rtl/ibex_core.sv:43:5
	input wire [31:0] boot_addr_i;
	// Trace: core/rtl/ibex_core.sv:46:5
	output wire instr_req_o;
	// Trace: core/rtl/ibex_core.sv:47:5
	input wire instr_gnt_i;
	// Trace: core/rtl/ibex_core.sv:48:5
	input wire instr_rvalid_i;
	// Trace: core/rtl/ibex_core.sv:49:5
	output wire [31:0] instr_addr_o;
	// Trace: core/rtl/ibex_core.sv:50:5
	input wire [31:0] instr_rdata_i;
	// Trace: core/rtl/ibex_core.sv:51:5
	input wire instr_err_i;
	// Trace: core/rtl/ibex_core.sv:54:5
	output wire data_req_o;
	// Trace: core/rtl/ibex_core.sv:55:5
	input wire data_gnt_i;
	// Trace: core/rtl/ibex_core.sv:56:5
	input wire data_rvalid_i;
	// Trace: core/rtl/ibex_core.sv:57:5
	output wire data_we_o;
	// Trace: core/rtl/ibex_core.sv:58:5
	output wire [3:0] data_be_o;
	// Trace: core/rtl/ibex_core.sv:59:5
	output wire [31:0] data_addr_o;
	// Trace: core/rtl/ibex_core.sv:60:5
	output wire [31:0] data_wdata_o;
	// Trace: core/rtl/ibex_core.sv:61:5
	input wire [31:0] data_rdata_i;
	// Trace: core/rtl/ibex_core.sv:62:5
	input wire data_err_i;
	// Trace: core/rtl/ibex_core.sv:65:5
	input wire irq_software_i;
	// Trace: core/rtl/ibex_core.sv:66:5
	input wire irq_timer_i;
	// Trace: core/rtl/ibex_core.sv:67:5
	input wire irq_external_i;
	// Trace: core/rtl/ibex_core.sv:68:5
	input wire [14:0] irq_fast_i;
	// Trace: core/rtl/ibex_core.sv:69:5
	input wire irq_nm_i;
	// Trace: core/rtl/ibex_core.sv:70:5
	input wire [31:0] irq_x_i;
	// Trace: core/rtl/ibex_core.sv:71:5
	output wire irq_x_ack_o;
	// Trace: core/rtl/ibex_core.sv:72:5
	output wire [4:0] irq_x_ack_id_o;
	// Trace: core/rtl/ibex_core.sv:75:5
	input wire [15:0] external_perf_i;
	// Trace: core/rtl/ibex_core.sv:78:5
	input wire debug_req_i;
	// Trace: core/rtl/ibex_core.sv:84:5
	output wire rvfi_valid;
	// Trace: core/rtl/ibex_core.sv:85:5
	output wire [63:0] rvfi_order;
	// Trace: core/rtl/ibex_core.sv:86:5
	output wire [31:0] rvfi_insn;
	// Trace: core/rtl/ibex_core.sv:87:5
	output wire rvfi_trap;
	// Trace: core/rtl/ibex_core.sv:88:5
	output wire rvfi_halt;
	// Trace: core/rtl/ibex_core.sv:89:5
	output wire rvfi_intr;
	// Trace: core/rtl/ibex_core.sv:90:5
	output wire [1:0] rvfi_mode;
	// Trace: core/rtl/ibex_core.sv:91:5
	output wire [1:0] rvfi_ixl;
	// Trace: core/rtl/ibex_core.sv:92:5
	output wire [4:0] rvfi_rs1_addr;
	// Trace: core/rtl/ibex_core.sv:93:5
	output wire [4:0] rvfi_rs2_addr;
	// Trace: core/rtl/ibex_core.sv:94:5
	output wire [4:0] rvfi_rs3_addr;
	// Trace: core/rtl/ibex_core.sv:95:5
	output wire [31:0] rvfi_rs1_rdata;
	// Trace: core/rtl/ibex_core.sv:96:5
	output wire [31:0] rvfi_rs2_rdata;
	// Trace: core/rtl/ibex_core.sv:97:5
	output wire [31:0] rvfi_rs3_rdata;
	// Trace: core/rtl/ibex_core.sv:98:5
	output wire [4:0] rvfi_rd_addr;
	// Trace: core/rtl/ibex_core.sv:99:5
	output wire [31:0] rvfi_rd_wdata;
	// Trace: core/rtl/ibex_core.sv:100:5
	output wire [31:0] rvfi_pc_rdata;
	// Trace: core/rtl/ibex_core.sv:101:5
	output wire [31:0] rvfi_pc_wdata;
	// Trace: core/rtl/ibex_core.sv:102:5
	output wire [31:0] rvfi_mem_addr;
	// Trace: core/rtl/ibex_core.sv:103:5
	output wire [3:0] rvfi_mem_rmask;
	// Trace: core/rtl/ibex_core.sv:104:5
	output wire [3:0] rvfi_mem_wmask;
	// Trace: core/rtl/ibex_core.sv:105:5
	output wire [31:0] rvfi_mem_rdata;
	// Trace: core/rtl/ibex_core.sv:106:5
	output wire [31:0] rvfi_mem_wdata;
	// Trace: core/rtl/ibex_core.sv:110:5
	input wire fetch_enable_i;
	// Trace: core/rtl/ibex_core.sv:111:5
	output wire alert_minor_o;
	// Trace: core/rtl/ibex_core.sv:112:5
	output wire alert_major_o;
	// Trace: core/rtl/ibex_core.sv:113:5
	output wire core_sleep_o;
	// Trace: core/rtl/ibex_core.sv:116:5
	output wire fetch_o;
	// Trace: core/rtl/ibex_core.sv:117:5
	output wire retire_o;
	// Trace: core/rtl/ibex_core.sv:118:5
	output wire [31:0] retire_instr_o;
	// Trace: core/rtl/ibex_core.sv:119:5
	localparam [0:0] RegFileECC = SecureIbex;
	localparam [31:0] RegFileDataWidth = (RegFileECC ? 39 : 32);
	output wire [((2 ** (RV32E ? 4 : 5)) * RegFileDataWidth) - 1:0] regfile_o;
	// Trace: core/rtl/ibex_core.sv:123:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_core.sv:125:3
	localparam [31:0] PMP_NUM_CHAN = 2;
	// Trace: core/rtl/ibex_core.sv:126:3
	localparam [0:0] DataIndTiming = SecureIbex;
	// Trace: core/rtl/ibex_core.sv:127:3
	localparam [0:0] DummyInstructions = SecureIbex;
	// Trace: core/rtl/ibex_core.sv:128:3
	localparam [0:0] PCIncrCheck = SecureIbex;
	// Trace: core/rtl/ibex_core.sv:129:3
	localparam [0:0] ShadowCSR = SecureIbex;
	// Trace: core/rtl/ibex_core.sv:134:3
	localparam [0:0] SpecBranch = PMPEnable & (PMPNumRegions == 16);
	// Trace: core/rtl/ibex_core.sv:135:3
	// Trace: core/rtl/ibex_core.sv:136:3
	// Trace: core/rtl/ibex_core.sv:139:3
	wire dummy_instr_id;
	// Trace: core/rtl/ibex_core.sv:140:3
	wire instr_valid_id;
	// Trace: core/rtl/ibex_core.sv:141:3
	wire instr_new_id;
	// Trace: core/rtl/ibex_core.sv:142:3
	wire [31:0] instr_rdata_id;
	// Trace: core/rtl/ibex_core.sv:143:3
	wire [31:0] instr_rdata_alu_id;
	// Trace: core/rtl/ibex_core.sv:145:3
	wire [15:0] instr_rdata_c_id;
	// Trace: core/rtl/ibex_core.sv:146:3
	wire instr_is_compressed_id;
	// Trace: core/rtl/ibex_core.sv:147:3
	wire instr_perf_count_id;
	// Trace: core/rtl/ibex_core.sv:148:3
	wire instr_bp_taken_id;
	// Trace: core/rtl/ibex_core.sv:149:3
	wire instr_fetch_err;
	// Trace: core/rtl/ibex_core.sv:150:3
	wire instr_fetch_err_plus2;
	// Trace: core/rtl/ibex_core.sv:151:3
	wire illegal_c_insn_id;
	// Trace: core/rtl/ibex_core.sv:152:3
	wire [31:0] pc_if;
	// Trace: core/rtl/ibex_core.sv:153:3
	wire [31:0] pc_id;
	// Trace: core/rtl/ibex_core.sv:154:3
	wire [31:0] pc_wb;
	// Trace: core/rtl/ibex_core.sv:155:3
	wire [67:0] imd_val_d_ex;
	// Trace: core/rtl/ibex_core.sv:156:3
	wire [67:0] imd_val_q_ex;
	// Trace: core/rtl/ibex_core.sv:157:3
	wire [1:0] imd_val_we_ex;
	// Trace: core/rtl/ibex_core.sv:159:3
	wire data_ind_timing;
	// Trace: core/rtl/ibex_core.sv:160:3
	wire dummy_instr_en;
	// Trace: core/rtl/ibex_core.sv:161:3
	wire [2:0] dummy_instr_mask;
	// Trace: core/rtl/ibex_core.sv:162:3
	wire dummy_instr_seed_en;
	// Trace: core/rtl/ibex_core.sv:163:3
	wire [31:0] dummy_instr_seed;
	// Trace: core/rtl/ibex_core.sv:164:3
	wire icache_enable;
	// Trace: core/rtl/ibex_core.sv:165:3
	wire icache_inval;
	// Trace: core/rtl/ibex_core.sv:166:3
	wire pc_mismatch_alert;
	// Trace: core/rtl/ibex_core.sv:167:3
	wire csr_shadow_err;
	// Trace: core/rtl/ibex_core.sv:169:3
	wire instr_first_cycle_id;
	// Trace: core/rtl/ibex_core.sv:170:3
	wire instr_valid_clear;
	// Trace: core/rtl/ibex_core.sv:171:3
	wire pc_set;
	// Trace: core/rtl/ibex_core.sv:172:3
	wire pc_set_spec;
	// Trace: core/rtl/ibex_core.sv:173:3
	wire nt_branch_mispredict;
	// Trace: core/rtl/ibex_core.sv:174:3
	// removed localparam type ibex_pkg_pc_sel_e
	wire [2:0] pc_mux_id;
	// Trace: core/rtl/ibex_core.sv:175:3
	// removed localparam type ibex_pkg_exc_pc_sel_e
	wire [2:0] exc_pc_mux_id;
	// Trace: core/rtl/ibex_core.sv:176:3
	// removed localparam type ibex_pkg_exc_cause_e
	wire [5:0] exc_cause;
	// Trace: core/rtl/ibex_core.sv:178:3
	wire lsu_load_err;
	// Trace: core/rtl/ibex_core.sv:179:3
	wire lsu_store_err;
	// Trace: core/rtl/ibex_core.sv:182:3
	wire lsu_addr_incr_req;
	// Trace: core/rtl/ibex_core.sv:183:3
	wire [31:0] lsu_addr_last;
	// Trace: core/rtl/ibex_core.sv:186:3
	wire [31:0] branch_target_ex;
	// Trace: core/rtl/ibex_core.sv:187:3
	wire branch_decision;
	// Trace: core/rtl/ibex_core.sv:190:3
	wire ctrl_busy;
	// Trace: core/rtl/ibex_core.sv:191:3
	wire if_busy;
	// Trace: core/rtl/ibex_core.sv:192:3
	wire lsu_busy;
	// Trace: core/rtl/ibex_core.sv:193:3
	wire core_busy_d;
	reg core_busy_q;
	// Trace: core/rtl/ibex_core.sv:196:3
	wire [4:0] rf_raddr_a;
	// Trace: core/rtl/ibex_core.sv:197:3
	wire [31:0] rf_rdata_a;
	// Trace: core/rtl/ibex_core.sv:198:3
	wire [4:0] rf_raddr_b;
	// Trace: core/rtl/ibex_core.sv:199:3
	wire [31:0] rf_rdata_b;
	// Trace: core/rtl/ibex_core.sv:200:3
	wire rf_ren_a;
	// Trace: core/rtl/ibex_core.sv:201:3
	wire rf_ren_b;
	// Trace: core/rtl/ibex_core.sv:202:3
	wire [4:0] rf_waddr_wb;
	// Trace: core/rtl/ibex_core.sv:203:3
	wire [31:0] rf_wdata_wb;
	// Trace: core/rtl/ibex_core.sv:206:3
	wire [31:0] rf_wdata_fwd_wb;
	// Trace: core/rtl/ibex_core.sv:207:3
	wire [31:0] rf_wdata_lsu;
	// Trace: core/rtl/ibex_core.sv:208:3
	wire rf_we_wb;
	// Trace: core/rtl/ibex_core.sv:209:3
	wire rf_we_lsu;
	// Trace: core/rtl/ibex_core.sv:211:3
	wire [((2 ** (RV32E ? 4 : 5)) * RegFileDataWidth) - 1:0] rf_regfile;
	// Trace: core/rtl/ibex_core.sv:214:3
	wire [4:0] rf_waddr_id;
	// Trace: core/rtl/ibex_core.sv:215:3
	wire [31:0] rf_wdata_id;
	// Trace: core/rtl/ibex_core.sv:216:3
	wire rf_we_id;
	// Trace: core/rtl/ibex_core.sv:217:3
	wire rf_rd_a_wb_match;
	// Trace: core/rtl/ibex_core.sv:218:3
	wire rf_rd_b_wb_match;
	// Trace: core/rtl/ibex_core.sv:221:3
	// removed localparam type ibex_pkg_alu_op_e
	wire [5:0] alu_operator_ex;
	// Trace: core/rtl/ibex_core.sv:222:3
	wire [31:0] alu_operand_a_ex;
	// Trace: core/rtl/ibex_core.sv:223:3
	wire [31:0] alu_operand_b_ex;
	// Trace: core/rtl/ibex_core.sv:225:3
	wire [31:0] bt_a_operand;
	// Trace: core/rtl/ibex_core.sv:226:3
	wire [31:0] bt_b_operand;
	// Trace: core/rtl/ibex_core.sv:228:3
	wire [31:0] alu_adder_result_ex;
	// Trace: core/rtl/ibex_core.sv:229:3
	wire [31:0] result_ex;
	// Trace: core/rtl/ibex_core.sv:232:3
	wire mult_en_ex;
	// Trace: core/rtl/ibex_core.sv:233:3
	wire div_en_ex;
	// Trace: core/rtl/ibex_core.sv:234:3
	wire mult_sel_ex;
	// Trace: core/rtl/ibex_core.sv:235:3
	wire div_sel_ex;
	// Trace: core/rtl/ibex_core.sv:236:3
	// removed localparam type ibex_pkg_md_op_e
	wire [1:0] multdiv_operator_ex;
	// Trace: core/rtl/ibex_core.sv:237:3
	wire [1:0] multdiv_signed_mode_ex;
	// Trace: core/rtl/ibex_core.sv:238:3
	wire [31:0] multdiv_operand_a_ex;
	// Trace: core/rtl/ibex_core.sv:239:3
	wire [31:0] multdiv_operand_b_ex;
	// Trace: core/rtl/ibex_core.sv:240:3
	wire multdiv_ready_id;
	// Trace: core/rtl/ibex_core.sv:243:3
	wire csr_access;
	// Trace: core/rtl/ibex_core.sv:244:3
	// removed localparam type ibex_pkg_csr_op_e
	wire [1:0] csr_op;
	// Trace: core/rtl/ibex_core.sv:245:3
	wire csr_op_en;
	// Trace: core/rtl/ibex_core.sv:246:3
	// removed localparam type ibex_pkg_csr_num_e
	wire [11:0] csr_addr;
	// Trace: core/rtl/ibex_core.sv:247:3
	wire [31:0] csr_rdata;
	// Trace: core/rtl/ibex_core.sv:248:3
	wire [31:0] csr_wdata;
	// Trace: core/rtl/ibex_core.sv:249:3
	wire illegal_csr_insn_id;
	// Trace: core/rtl/ibex_core.sv:254:3
	wire lsu_we;
	// Trace: core/rtl/ibex_core.sv:255:3
	wire [1:0] lsu_type;
	// Trace: core/rtl/ibex_core.sv:256:3
	wire lsu_sign_ext;
	// Trace: core/rtl/ibex_core.sv:257:3
	wire lsu_req;
	// Trace: core/rtl/ibex_core.sv:258:3
	wire [31:0] lsu_wdata;
	// Trace: core/rtl/ibex_core.sv:259:3
	wire lsu_req_done;
	// Trace: core/rtl/ibex_core.sv:262:3
	wire id_in_ready;
	// Trace: core/rtl/ibex_core.sv:263:3
	wire ex_valid;
	// Trace: core/rtl/ibex_core.sv:265:3
	wire lsu_resp_valid;
	// Trace: core/rtl/ibex_core.sv:266:3
	wire lsu_resp_err;
	// Trace: core/rtl/ibex_core.sv:269:3
	wire instr_req_int;
	// Trace: core/rtl/ibex_core.sv:272:3
	wire en_wb;
	// Trace: core/rtl/ibex_core.sv:273:3
	// removed localparam type ibex_pkg_wb_instr_type_e
	wire [1:0] instr_type_wb;
	// Trace: core/rtl/ibex_core.sv:274:3
	wire ready_wb;
	// Trace: core/rtl/ibex_core.sv:275:3
	wire rf_write_wb;
	// Trace: core/rtl/ibex_core.sv:276:3
	wire outstanding_load_wb;
	// Trace: core/rtl/ibex_core.sv:277:3
	wire outstanding_store_wb;
	// Trace: core/rtl/ibex_core.sv:280:3
	wire irq_pending;
	// Trace: core/rtl/ibex_core.sv:281:3
	wire nmi_mode;
	// Trace: core/rtl/ibex_core.sv:282:3
	// removed localparam type ibex_pkg_irqs_t
	wire [17:0] irqs;
	// Trace: core/rtl/ibex_core.sv:283:3
	wire [31:0] irqs_x;
	// Trace: core/rtl/ibex_core.sv:284:3
	wire csr_mstatus_mie;
	// Trace: core/rtl/ibex_core.sv:285:3
	wire [31:0] csr_mepc;
	wire [31:0] csr_depc;
	// Trace: core/rtl/ibex_core.sv:288:3
	wire [(PMPNumRegions * 34) - 1:0] csr_pmp_addr;
	// Trace: core/rtl/ibex_core.sv:289:3
	// removed localparam type ibex_pkg_pmp_cfg_mode_e
	// removed localparam type ibex_pkg_pmp_cfg_t
	wire [(PMPNumRegions * 6) - 1:0] csr_pmp_cfg;
	// Trace: core/rtl/ibex_core.sv:290:3
	wire [0:1] pmp_req_err;
	// Trace: core/rtl/ibex_core.sv:291:3
	wire instr_req_out;
	// Trace: core/rtl/ibex_core.sv:292:3
	wire data_req_out;
	// Trace: core/rtl/ibex_core.sv:294:3
	wire csr_save_if;
	// Trace: core/rtl/ibex_core.sv:295:3
	wire csr_save_id;
	// Trace: core/rtl/ibex_core.sv:296:3
	wire csr_save_wb;
	// Trace: core/rtl/ibex_core.sv:297:3
	wire csr_restore_mret_id;
	// Trace: core/rtl/ibex_core.sv:298:3
	wire csr_restore_dret_id;
	// Trace: core/rtl/ibex_core.sv:299:3
	wire csr_save_cause;
	// Trace: core/rtl/ibex_core.sv:300:3
	wire csr_mtvec_init;
	// Trace: core/rtl/ibex_core.sv:301:3
	wire [31:0] csr_mtvec;
	// Trace: core/rtl/ibex_core.sv:302:3
	wire [31:0] csr_mtvecx;
	// Trace: core/rtl/ibex_core.sv:303:3
	wire [31:0] csr_mtval;
	// Trace: core/rtl/ibex_core.sv:304:3
	wire csr_mstatus_tw;
	// Trace: core/rtl/ibex_core.sv:305:3
	// removed localparam type ibex_pkg_priv_lvl_e
	wire [1:0] priv_mode_id;
	// Trace: core/rtl/ibex_core.sv:306:3
	wire [1:0] priv_mode_if;
	// Trace: core/rtl/ibex_core.sv:307:3
	wire [1:0] priv_mode_lsu;
	// Trace: core/rtl/ibex_core.sv:310:3
	wire debug_mode;
	// Trace: core/rtl/ibex_core.sv:311:3
	// removed localparam type ibex_pkg_dbg_cause_e
	wire [2:0] debug_cause;
	// Trace: core/rtl/ibex_core.sv:312:3
	wire debug_csr_save;
	// Trace: core/rtl/ibex_core.sv:313:3
	wire debug_single_step;
	// Trace: core/rtl/ibex_core.sv:314:3
	wire debug_ebreakm;
	// Trace: core/rtl/ibex_core.sv:315:3
	wire debug_ebreaku;
	// Trace: core/rtl/ibex_core.sv:316:3
	wire trigger_match;
	// Trace: core/rtl/ibex_core.sv:320:3
	wire instr_id_done;
	// Trace: core/rtl/ibex_core.sv:321:3
	wire instr_done_wb;
	// Trace: core/rtl/ibex_core.sv:323:3
	wire [31:0] instr_done_rdata_wb;
	// Trace: core/rtl/ibex_core.sv:326:3
	wire perf_instr_ret_wb;
	// Trace: core/rtl/ibex_core.sv:327:3
	wire perf_instr_ret_compressed_wb;
	// Trace: core/rtl/ibex_core.sv:328:3
	wire perf_iside_wait;
	// Trace: core/rtl/ibex_core.sv:329:3
	wire perf_dside_wait;
	// Trace: core/rtl/ibex_core.sv:330:3
	wire perf_mul_wait;
	// Trace: core/rtl/ibex_core.sv:331:3
	wire perf_div_wait;
	// Trace: core/rtl/ibex_core.sv:332:3
	wire perf_jump;
	// Trace: core/rtl/ibex_core.sv:333:3
	wire perf_branch;
	// Trace: core/rtl/ibex_core.sv:334:3
	wire perf_tbranch;
	// Trace: core/rtl/ibex_core.sv:335:3
	wire perf_load;
	// Trace: core/rtl/ibex_core.sv:336:3
	wire perf_store;
	// Trace: core/rtl/ibex_core.sv:339:3
	wire illegal_insn_id;
	wire unused_illegal_insn_id;
	// Trace: core/rtl/ibex_core.sv:343:3
	wire rvfi_instr_new_wb;
	// Trace: core/rtl/ibex_core.sv:344:3
	wire rvfi_intr_d;
	// Trace: core/rtl/ibex_core.sv:345:3
	reg rvfi_intr_q;
	// Trace: core/rtl/ibex_core.sv:346:3
	reg rvfi_set_trap_pc_d;
	// Trace: core/rtl/ibex_core.sv:347:3
	reg rvfi_set_trap_pc_q;
	// Trace: core/rtl/ibex_core.sv:348:3
	reg [31:0] rvfi_insn_id;
	// Trace: core/rtl/ibex_core.sv:349:3
	reg [4:0] rvfi_rs1_addr_d;
	// Trace: core/rtl/ibex_core.sv:350:3
	reg [4:0] rvfi_rs1_addr_q;
	// Trace: core/rtl/ibex_core.sv:351:3
	reg [4:0] rvfi_rs2_addr_d;
	// Trace: core/rtl/ibex_core.sv:352:3
	reg [4:0] rvfi_rs2_addr_q;
	// Trace: core/rtl/ibex_core.sv:353:3
	reg [4:0] rvfi_rs3_addr_d;
	// Trace: core/rtl/ibex_core.sv:354:3
	reg [31:0] rvfi_rs1_data_d;
	// Trace: core/rtl/ibex_core.sv:355:3
	reg [31:0] rvfi_rs1_data_q;
	// Trace: core/rtl/ibex_core.sv:356:3
	reg [31:0] rvfi_rs2_data_d;
	// Trace: core/rtl/ibex_core.sv:357:3
	reg [31:0] rvfi_rs2_data_q;
	// Trace: core/rtl/ibex_core.sv:358:3
	reg [31:0] rvfi_rs3_data_d;
	// Trace: core/rtl/ibex_core.sv:359:3
	wire [4:0] rvfi_rd_addr_wb;
	// Trace: core/rtl/ibex_core.sv:360:3
	reg [4:0] rvfi_rd_addr_q;
	// Trace: core/rtl/ibex_core.sv:361:3
	reg [4:0] rvfi_rd_addr_d;
	// Trace: core/rtl/ibex_core.sv:362:3
	wire [31:0] rvfi_rd_wdata_wb;
	// Trace: core/rtl/ibex_core.sv:363:3
	reg [31:0] rvfi_rd_wdata_d;
	// Trace: core/rtl/ibex_core.sv:364:3
	reg [31:0] rvfi_rd_wdata_q;
	// Trace: core/rtl/ibex_core.sv:365:3
	wire rvfi_rd_we_wb;
	// Trace: core/rtl/ibex_core.sv:366:3
	reg [3:0] rvfi_mem_mask_int;
	// Trace: core/rtl/ibex_core.sv:367:3
	reg [31:0] rvfi_mem_rdata_d;
	// Trace: core/rtl/ibex_core.sv:368:3
	reg [31:0] rvfi_mem_rdata_q;
	// Trace: core/rtl/ibex_core.sv:369:3
	reg [31:0] rvfi_mem_wdata_d;
	// Trace: core/rtl/ibex_core.sv:370:3
	reg [31:0] rvfi_mem_wdata_q;
	// Trace: core/rtl/ibex_core.sv:371:3
	reg [31:0] rvfi_mem_addr_d;
	// Trace: core/rtl/ibex_core.sv:372:3
	reg [31:0] rvfi_mem_addr_q;
	// Trace: core/rtl/ibex_core.sv:379:3
	wire clk;
	// Trace: core/rtl/ibex_core.sv:381:3
	wire clock_en;
	// Trace: core/rtl/ibex_core.sv:385:3
	assign core_busy_d = (ctrl_busy | if_busy) | lsu_busy;
	// Trace: core/rtl/ibex_core.sv:387:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_core.sv:388:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_core.sv:389:7
			core_busy_q <= 1'b0;
		else
			// Trace: core/rtl/ibex_core.sv:391:7
			core_busy_q <= core_busy_d;
	// Trace: core/rtl/ibex_core.sv:395:3
	reg fetch_enable_q;
	// Trace: core/rtl/ibex_core.sv:396:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_core.sv:397:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_core.sv:398:7
			fetch_enable_q <= 1'b0;
		else if (fetch_enable_i)
			// Trace: core/rtl/ibex_core.sv:400:7
			fetch_enable_q <= 1'b1;
	// Trace: core/rtl/ibex_core.sv:404:3
	assign clock_en = fetch_enable_q & (((core_busy_q | debug_req_i) | irq_pending) | irq_nm_i);
	// Trace: core/rtl/ibex_core.sv:405:3
	assign core_sleep_o = ~clock_en;
	// Trace: core/rtl/ibex_core.sv:410:3
	tc_clk_gating core_clock_gate_i(
		.clk_i(clk_i),
		.en_i(clock_en),
		.test_en_i(test_en_i),
		.clk_o(clk)
	);
	// Trace: core/rtl/ibex_core.sv:421:3
	localparam [31:0] ibex_pkg_PMP_I = 0;
	ibex_if_stage #(
		.DmHaltAddr(DmHaltAddr),
		.DmExceptionAddr(DmExceptionAddr),
		.DummyInstructions(DummyInstructions),
		.ICache(ICache),
		.ICacheECC(ICacheECC),
		.PCIncrCheck(PCIncrCheck),
		.BranchPredictor(BranchPredictor)
	) if_stage_i(
		.clk_i(clk),
		.rst_ni(rst_ni),
		.boot_addr_i(boot_addr_i),
		.req_i(instr_req_int),
		.instr_req_o(instr_req_out),
		.instr_addr_o(instr_addr_o),
		.instr_gnt_i(instr_gnt_i),
		.instr_rvalid_i(instr_rvalid_i),
		.instr_rdata_i(instr_rdata_i),
		.instr_err_i(instr_err_i),
		.instr_pmp_err_i(pmp_req_err[ibex_pkg_PMP_I]),
		.instr_valid_id_o(instr_valid_id),
		.instr_new_id_o(instr_new_id),
		.instr_rdata_id_o(instr_rdata_id),
		.instr_rdata_alu_id_o(instr_rdata_alu_id),
		.instr_rdata_c_id_o(instr_rdata_c_id),
		.instr_is_compressed_id_o(instr_is_compressed_id),
		.instr_bp_taken_o(instr_bp_taken_id),
		.instr_fetch_err_o(instr_fetch_err),
		.instr_fetch_err_plus2_o(instr_fetch_err_plus2),
		.illegal_c_insn_id_o(illegal_c_insn_id),
		.dummy_instr_id_o(dummy_instr_id),
		.pc_if_o(pc_if),
		.pc_id_o(pc_id),
		.instr_valid_clear_i(instr_valid_clear),
		.pc_set_i(pc_set),
		.pc_set_spec_i(pc_set_spec),
		.pc_mux_i(pc_mux_id),
		.nt_branch_mispredict_i(nt_branch_mispredict),
		.exc_pc_mux_i(exc_pc_mux_id),
		.exc_cause(exc_cause),
		.dummy_instr_en_i(dummy_instr_en),
		.dummy_instr_mask_i(dummy_instr_mask),
		.dummy_instr_seed_en_i(dummy_instr_seed_en),
		.dummy_instr_seed_i(dummy_instr_seed),
		.icache_enable_i(icache_enable),
		.icache_inval_i(icache_inval),
		.branch_target_ex_i(branch_target_ex),
		.csr_mepc_i(csr_mepc),
		.csr_depc_i(csr_depc),
		.csr_mtvec_i(csr_mtvec),
		.csr_mtvecx_i(csr_mtvecx),
		.csr_mtvec_init_o(csr_mtvec_init),
		.id_in_ready_i(id_in_ready),
		.pc_mismatch_alert_o(pc_mismatch_alert),
		.if_busy_o(if_busy)
	);
	// Trace: core/rtl/ibex_core.sv:494:3
	assign perf_iside_wait = id_in_ready & ~instr_valid_id;
	// Trace: core/rtl/ibex_core.sv:497:3
	assign instr_req_o = instr_req_out & ~pmp_req_err[ibex_pkg_PMP_I];
	// Trace: core/rtl/ibex_core.sv:503:3
	ibex_id_stage #(
		.RV32E(RV32E),
		.RV32M(RV32M),
		.RV32B(RV32B),
		.BranchTargetALU(BranchTargetALU),
		.DataIndTiming(DataIndTiming),
		.SpecBranch(SpecBranch),
		.WritebackStage(WritebackStage),
		.BranchPredictor(BranchPredictor)
	) id_stage_i(
		.clk_i(clk),
		.rst_ni(rst_ni),
		.ctrl_busy_o(ctrl_busy),
		.illegal_insn_o(illegal_insn_id),
		.instr_valid_i(instr_valid_id),
		.instr_rdata_i(instr_rdata_id),
		.instr_rdata_alu_i(instr_rdata_alu_id),
		.instr_rdata_c_i(instr_rdata_c_id),
		.instr_is_compressed_i(instr_is_compressed_id),
		.instr_bp_taken_i(instr_bp_taken_id),
		.branch_decision_i(branch_decision),
		.instr_first_cycle_id_o(instr_first_cycle_id),
		.instr_valid_clear_o(instr_valid_clear),
		.id_in_ready_o(id_in_ready),
		.instr_req_o(instr_req_int),
		.pc_set_o(pc_set),
		.pc_set_spec_o(pc_set_spec),
		.pc_mux_o(pc_mux_id),
		.nt_branch_mispredict_o(nt_branch_mispredict),
		.exc_pc_mux_o(exc_pc_mux_id),
		.exc_cause_o(exc_cause),
		.icache_inval_o(icache_inval),
		.instr_fetch_err_i(instr_fetch_err),
		.instr_fetch_err_plus2_i(instr_fetch_err_plus2),
		.illegal_c_insn_i(illegal_c_insn_id),
		.pc_id_i(pc_id),
		.ex_valid_i(ex_valid),
		.lsu_resp_valid_i(lsu_resp_valid),
		.alu_operator_ex_o(alu_operator_ex),
		.alu_operand_a_ex_o(alu_operand_a_ex),
		.alu_operand_b_ex_o(alu_operand_b_ex),
		.imd_val_q_ex_o(imd_val_q_ex),
		.imd_val_d_ex_i(imd_val_d_ex),
		.imd_val_we_ex_i(imd_val_we_ex),
		.bt_a_operand_o(bt_a_operand),
		.bt_b_operand_o(bt_b_operand),
		.mult_en_ex_o(mult_en_ex),
		.div_en_ex_o(div_en_ex),
		.mult_sel_ex_o(mult_sel_ex),
		.div_sel_ex_o(div_sel_ex),
		.multdiv_operator_ex_o(multdiv_operator_ex),
		.multdiv_signed_mode_ex_o(multdiv_signed_mode_ex),
		.multdiv_operand_a_ex_o(multdiv_operand_a_ex),
		.multdiv_operand_b_ex_o(multdiv_operand_b_ex),
		.multdiv_ready_id_o(multdiv_ready_id),
		.csr_access_o(csr_access),
		.csr_op_o(csr_op),
		.csr_op_en_o(csr_op_en),
		.csr_save_if_o(csr_save_if),
		.csr_save_id_o(csr_save_id),
		.csr_save_wb_o(csr_save_wb),
		.csr_restore_mret_id_o(csr_restore_mret_id),
		.csr_restore_dret_id_o(csr_restore_dret_id),
		.csr_save_cause_o(csr_save_cause),
		.csr_mtval_o(csr_mtval),
		.priv_mode_i(priv_mode_id),
		.csr_mstatus_tw_i(csr_mstatus_tw),
		.illegal_csr_insn_i(illegal_csr_insn_id),
		.data_ind_timing_i(data_ind_timing),
		.lsu_req_o(lsu_req),
		.lsu_we_o(lsu_we),
		.lsu_type_o(lsu_type),
		.lsu_sign_ext_o(lsu_sign_ext),
		.lsu_wdata_o(lsu_wdata),
		.lsu_req_done_i(lsu_req_done),
		.lsu_addr_incr_req_i(lsu_addr_incr_req),
		.lsu_addr_last_i(lsu_addr_last),
		.lsu_load_err_i(lsu_load_err),
		.lsu_store_err_i(lsu_store_err),
		.csr_mstatus_mie_i(csr_mstatus_mie),
		.irq_pending_i(irq_pending),
		.irqs_i(irqs),
		.irq_nm_i(irq_nm_i),
		.nmi_mode_o(nmi_mode),
		.irqs_x_i(irqs_x),
		.irq_x_ack_o(irq_x_ack_o),
		.irq_x_ack_id_o(irq_x_ack_id_o),
		.debug_mode_o(debug_mode),
		.debug_cause_o(debug_cause),
		.debug_csr_save_o(debug_csr_save),
		.debug_req_i(debug_req_i),
		.debug_single_step_i(debug_single_step),
		.debug_ebreakm_i(debug_ebreakm),
		.debug_ebreaku_i(debug_ebreaku),
		.trigger_match_i(trigger_match),
		.result_ex_i(result_ex),
		.csr_rdata_i(csr_rdata),
		.rf_raddr_a_o(rf_raddr_a),
		.rf_rdata_a_i(rf_rdata_a),
		.rf_raddr_b_o(rf_raddr_b),
		.rf_rdata_b_i(rf_rdata_b),
		.rf_ren_a_o(rf_ren_a),
		.rf_ren_b_o(rf_ren_b),
		.rf_waddr_id_o(rf_waddr_id),
		.rf_wdata_id_o(rf_wdata_id),
		.rf_we_id_o(rf_we_id),
		.rf_rd_a_wb_match_o(rf_rd_a_wb_match),
		.rf_rd_b_wb_match_o(rf_rd_b_wb_match),
		.rf_waddr_wb_i(rf_waddr_wb),
		.rf_wdata_fwd_wb_i(rf_wdata_fwd_wb),
		.rf_write_wb_i(rf_write_wb),
		.en_wb_o(en_wb),
		.instr_type_wb_o(instr_type_wb),
		.instr_perf_count_id_o(instr_perf_count_id),
		.ready_wb_i(ready_wb),
		.outstanding_load_wb_i(outstanding_load_wb),
		.outstanding_store_wb_i(outstanding_store_wb),
		.perf_jump_o(perf_jump),
		.perf_branch_o(perf_branch),
		.perf_tbranch_o(perf_tbranch),
		.perf_dside_wait_o(perf_dside_wait),
		.perf_mul_wait_o(perf_mul_wait),
		.perf_div_wait_o(perf_div_wait),
		.instr_id_done_o(instr_id_done)
	);
	// Trace: core/rtl/ibex_core.sv:663:3
	assign unused_illegal_insn_id = illegal_insn_id;
	// Trace: core/rtl/ibex_core.sv:665:3
	ibex_ex_block #(
		.RV32M(RV32M),
		.RV32B(RV32B),
		.BranchTargetALU(BranchTargetALU)
	) ex_block_i(
		.clk_i(clk),
		.rst_ni(rst_ni),
		.alu_operator_i(alu_operator_ex),
		.alu_operand_a_i(alu_operand_a_ex),
		.alu_operand_b_i(alu_operand_b_ex),
		.alu_instr_first_cycle_i(instr_first_cycle_id),
		.bt_a_operand_i(bt_a_operand),
		.bt_b_operand_i(bt_b_operand),
		.multdiv_operator_i(multdiv_operator_ex),
		.mult_en_i(mult_en_ex),
		.div_en_i(div_en_ex),
		.mult_sel_i(mult_sel_ex),
		.div_sel_i(div_sel_ex),
		.multdiv_signed_mode_i(multdiv_signed_mode_ex),
		.multdiv_operand_a_i(multdiv_operand_a_ex),
		.multdiv_operand_b_i(multdiv_operand_b_ex),
		.multdiv_ready_id_i(multdiv_ready_id),
		.data_ind_timing_i(data_ind_timing),
		.imd_val_we_o(imd_val_we_ex),
		.imd_val_d_o(imd_val_d_ex),
		.imd_val_q_i(imd_val_q_ex),
		.alu_adder_result_ex_o(alu_adder_result_ex),
		.result_ex_o(result_ex),
		.branch_target_o(branch_target_ex),
		.branch_decision_o(branch_decision),
		.ex_valid_o(ex_valid)
	);
	// Trace: core/rtl/ibex_core.sv:714:3
	localparam [31:0] ibex_pkg_PMP_D = 1;
	assign data_req_o = data_req_out & ~pmp_req_err[ibex_pkg_PMP_D];
	// Trace: core/rtl/ibex_core.sv:715:3
	assign lsu_resp_err = lsu_load_err | lsu_store_err;
	// Trace: core/rtl/ibex_core.sv:717:3
	ibex_load_store_unit load_store_unit_i(
		.clk_i(clk),
		.rst_ni(rst_ni),
		.data_req_o(data_req_out),
		.data_gnt_i(data_gnt_i),
		.data_rvalid_i(data_rvalid_i),
		.data_err_i(data_err_i),
		.data_pmp_err_i(pmp_req_err[ibex_pkg_PMP_D]),
		.data_addr_o(data_addr_o),
		.data_we_o(data_we_o),
		.data_be_o(data_be_o),
		.data_wdata_o(data_wdata_o),
		.data_rdata_i(data_rdata_i),
		.lsu_we_i(lsu_we),
		.lsu_type_i(lsu_type),
		.lsu_wdata_i(lsu_wdata),
		.lsu_sign_ext_i(lsu_sign_ext),
		.lsu_rdata_o(rf_wdata_lsu),
		.lsu_rdata_valid_o(rf_we_lsu),
		.lsu_req_i(lsu_req),
		.lsu_req_done_o(lsu_req_done),
		.adder_result_ex_i(alu_adder_result_ex),
		.addr_incr_req_o(lsu_addr_incr_req),
		.addr_last_o(lsu_addr_last),
		.lsu_resp_valid_o(lsu_resp_valid),
		.load_err_o(lsu_load_err),
		.store_err_o(lsu_store_err),
		.busy_o(lsu_busy),
		.perf_load_o(perf_load),
		.perf_store_o(perf_store)
	);
	// Trace: core/rtl/ibex_core.sv:763:3
	ibex_wb_stage #(.WritebackStage(WritebackStage)) wb_stage_i(
		.clk_i(clk),
		.rst_ni(rst_ni),
		.en_wb_i(en_wb),
		.instr_type_wb_i(instr_type_wb),
		.pc_id_i(pc_id),
		.instr_rdata_id_i(instr_rdata_id),
		.instr_is_compressed_id_i(instr_is_compressed_id),
		.instr_perf_count_id_i(instr_perf_count_id),
		.ready_wb_o(ready_wb),
		.rf_write_wb_o(rf_write_wb),
		.outstanding_load_wb_o(outstanding_load_wb),
		.outstanding_store_wb_o(outstanding_store_wb),
		.pc_wb_o(pc_wb),
		.perf_instr_ret_wb_o(perf_instr_ret_wb),
		.perf_instr_ret_compressed_wb_o(perf_instr_ret_compressed_wb),
		.rf_waddr_id_i(rf_waddr_id),
		.rf_wdata_id_i(rf_wdata_id),
		.rf_we_id_i(rf_we_id),
		.rf_wdata_lsu_i(rf_wdata_lsu),
		.rf_we_lsu_i(rf_we_lsu),
		.rf_wdata_fwd_wb_o(rf_wdata_fwd_wb),
		.rf_waddr_wb_o(rf_waddr_wb),
		.rf_wdata_wb_o(rf_wdata_wb),
		.rf_we_wb_o(rf_we_wb),
		.lsu_resp_valid_i(lsu_resp_valid),
		.lsu_resp_err_i(lsu_resp_err),
		.instr_done_wb_o(instr_done_wb),
		.instr_done_rdata_wb_o(instr_done_rdata_wb)
	);
	// Trace: core/rtl/ibex_core.sv:811:3
	wire [RegFileDataWidth - 1:0] rf_wdata_wb_ecc;
	// Trace: core/rtl/ibex_core.sv:812:3
	wire [RegFileDataWidth - 1:0] rf_rdata_a_ecc;
	// Trace: core/rtl/ibex_core.sv:813:3
	wire [RegFileDataWidth - 1:0] rf_rdata_b_ecc;
	// Trace: core/rtl/ibex_core.sv:814:3
	wire rf_ecc_err_comb;
	// Trace: core/rtl/ibex_core.sv:816:3
	generate
		if (RegFileECC) begin : gen_regfile_ecc
			// Trace: core/rtl/ibex_core.sv:818:5
			wire [1:0] rf_ecc_err_a;
			wire [1:0] rf_ecc_err_b;
			// Trace: core/rtl/ibex_core.sv:819:5
			wire rf_ecc_err_a_id;
			wire rf_ecc_err_b_id;
			// Trace: core/rtl/ibex_core.sv:822:5
			prim_secded_39_32_enc regfile_ecc_enc(
				.in(rf_wdata_wb),
				.out(rf_wdata_wb_ecc)
			);
			// Trace: core/rtl/ibex_core.sv:828:5
			prim_secded_39_32_dec regfile_ecc_dec_a(
				.in(rf_rdata_a_ecc),
				.d_o(),
				.syndrome_o(),
				.err_o(rf_ecc_err_a)
			);
			// Trace: core/rtl/ibex_core.sv:834:5
			prim_secded_39_32_dec regfile_ecc_dec_b(
				.in(rf_rdata_b_ecc),
				.d_o(),
				.syndrome_o(),
				.err_o(rf_ecc_err_b)
			);
			// Trace: core/rtl/ibex_core.sv:842:5
			assign rf_rdata_a = rf_rdata_a_ecc[31:0];
			// Trace: core/rtl/ibex_core.sv:843:5
			assign rf_rdata_b = rf_rdata_b_ecc[31:0];
			// Trace: core/rtl/ibex_core.sv:846:5
			assign rf_ecc_err_a_id = (|rf_ecc_err_a & rf_ren_a) & ~rf_rd_a_wb_match;
			// Trace: core/rtl/ibex_core.sv:847:5
			assign rf_ecc_err_b_id = (|rf_ecc_err_b & rf_ren_b) & ~rf_rd_b_wb_match;
			// Trace: core/rtl/ibex_core.sv:850:5
			assign rf_ecc_err_comb = instr_valid_id & (rf_ecc_err_a_id | rf_ecc_err_b_id);
		end
		else begin : gen_no_regfile_ecc
			// Trace: core/rtl/ibex_core.sv:853:5
			wire unused_rf_ren_a;
			wire unused_rf_ren_b;
			// Trace: core/rtl/ibex_core.sv:854:5
			wire unused_rf_rd_a_wb_match;
			wire unused_rf_rd_b_wb_match;
			// Trace: core/rtl/ibex_core.sv:856:5
			assign unused_rf_ren_a = rf_ren_a;
			// Trace: core/rtl/ibex_core.sv:857:5
			assign unused_rf_ren_b = rf_ren_b;
			// Trace: core/rtl/ibex_core.sv:858:5
			assign unused_rf_rd_a_wb_match = rf_rd_a_wb_match;
			// Trace: core/rtl/ibex_core.sv:859:5
			assign unused_rf_rd_b_wb_match = rf_rd_b_wb_match;
			// Trace: core/rtl/ibex_core.sv:860:5
			assign rf_wdata_wb_ecc = rf_wdata_wb;
			// Trace: core/rtl/ibex_core.sv:861:5
			assign rf_rdata_a = rf_rdata_a_ecc;
			// Trace: core/rtl/ibex_core.sv:862:5
			assign rf_rdata_b = rf_rdata_b_ecc;
			// Trace: core/rtl/ibex_core.sv:863:5
			assign rf_ecc_err_comb = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_core.sv:866:3
	generate
		if (RegFile == 32'sd0) begin : gen_regfile_ff
			// Trace: core/rtl/ibex_core.sv:867:5
			ibex_register_file_ff #(
				.RV32E(RV32E),
				.DataWidth(RegFileDataWidth),
				.DummyInstructions(DummyInstructions)
			) register_file_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.test_en_i(test_en_i),
				.dummy_instr_id_i(dummy_instr_id),
				.raddr_a_i(rf_raddr_a),
				.rdata_a_o(rf_rdata_a_ecc),
				.raddr_b_i(rf_raddr_b),
				.rdata_b_o(rf_rdata_b_ecc),
				.waddr_a_i(rf_waddr_wb),
				.wdata_a_i(rf_wdata_wb_ecc),
				.we_a_i(rf_we_wb),
				.regfile_o(rf_regfile)
			);
		end
		else if (RegFile == 32'sd1) begin : gen_regfile_fpga
			// Trace: core/rtl/ibex_core.sv:890:5
			ibex_register_file_fpga #(
				.RV32E(RV32E),
				.DataWidth(RegFileDataWidth),
				.DummyInstructions(DummyInstructions)
			) register_file_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.test_en_i(test_en_i),
				.dummy_instr_id_i(dummy_instr_id),
				.raddr_a_i(rf_raddr_a),
				.rdata_a_o(rf_rdata_a_ecc),
				.raddr_b_i(rf_raddr_b),
				.rdata_b_o(rf_rdata_b_ecc),
				.waddr_a_i(rf_waddr_wb),
				.wdata_a_i(rf_wdata_wb_ecc),
				.we_a_i(rf_we_wb)
			);
		end
		else if (RegFile == 32'sd2) begin : gen_regfile_latch
			// Trace: core/rtl/ibex_core.sv:910:5
			ibex_register_file_latch #(
				.RV32E(RV32E),
				.DataWidth(RegFileDataWidth),
				.DummyInstructions(DummyInstructions)
			) register_file_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.test_en_i(test_en_i),
				.dummy_instr_id_i(dummy_instr_id),
				.raddr_a_i(rf_raddr_a),
				.rdata_a_o(rf_rdata_a_ecc),
				.raddr_b_i(rf_raddr_b),
				.rdata_b_o(rf_rdata_b_ecc),
				.waddr_a_i(rf_waddr_wb),
				.wdata_a_i(rf_wdata_wb_ecc),
				.we_a_i(rf_we_wb)
			);
		end
	endgenerate
	// Trace: core/rtl/ibex_core.sv:937:3
	assign alert_minor_o = 1'b0;
	// Trace: core/rtl/ibex_core.sv:940:3
	assign alert_major_o = (rf_ecc_err_comb | pc_mismatch_alert) | csr_shadow_err;
	// Trace: core/rtl/ibex_core.sv:988:3
	assign rvfi_rd_addr_wb = rf_waddr_wb;
	// Trace: core/rtl/ibex_core.sv:989:3
	assign rvfi_rd_wdata_wb = (rf_we_wb ? rf_wdata_wb : rf_wdata_lsu);
	// Trace: core/rtl/ibex_core.sv:990:3
	assign rvfi_rd_we_wb = rf_we_wb | rf_we_lsu;
	// Trace: core/rtl/ibex_core.sv:998:3
	assign csr_wdata = alu_operand_a_ex;
	// Trace: core/rtl/ibex_core.sv:999:3
	function automatic [11:0] sv2v_cast_12;
		input reg [11:0] inp;
		sv2v_cast_12 = inp;
	endfunction
	assign csr_addr = sv2v_cast_12((csr_access ? alu_operand_b_ex[11:0] : 12'b000000000000));
	// Trace: core/rtl/ibex_core.sv:1001:3
	ibex_cs_registers #(
		.DbgTriggerEn(DbgTriggerEn),
		.DbgHwBreakNum(DbgHwBreakNum),
		.DataIndTiming(DataIndTiming),
		.DummyInstructions(DummyInstructions),
		.ShadowCSR(ShadowCSR),
		.ICache(ICache),
		.MHPMCounterNum(MHPMCounterNum),
		.MHPMCounterWidth(MHPMCounterWidth),
		.PMPEnable(PMPEnable),
		.PMPGranularity(PMPGranularity),
		.PMPNumRegions(PMPNumRegions),
		.RV32E(RV32E),
		.RV32M(RV32M),
		.RV32B(RV32B)
	) cs_registers_i(
		.clk_i(clk),
		.rst_ni(rst_ni),
		.hart_id_i(hart_id_i),
		.priv_mode_id_o(priv_mode_id),
		.priv_mode_if_o(priv_mode_if),
		.priv_mode_lsu_o(priv_mode_lsu),
		.csr_mtvec_o(csr_mtvec),
		.csr_mtvecx_o(csr_mtvecx),
		.csr_mtvec_init_i(csr_mtvec_init),
		.boot_addr_i(boot_addr_i),
		.csr_access_i(csr_access),
		.csr_addr_i(csr_addr),
		.csr_wdata_i(csr_wdata),
		.csr_op_i(csr_op),
		.csr_op_en_i(csr_op_en),
		.csr_rdata_o(csr_rdata),
		.irq_software_i(irq_software_i),
		.irq_timer_i(irq_timer_i),
		.irq_external_i(irq_external_i),
		.irq_fast_i(irq_fast_i),
		.irq_x_i(irq_x_i),
		.nmi_mode_i(nmi_mode),
		.irq_pending_o(irq_pending),
		.irqs_o(irqs),
		.irqs_x_o(irqs_x),
		.csr_mstatus_mie_o(csr_mstatus_mie),
		.csr_mstatus_tw_o(csr_mstatus_tw),
		.csr_mepc_o(csr_mepc),
		.csr_pmp_cfg_o(csr_pmp_cfg),
		.csr_pmp_addr_o(csr_pmp_addr),
		.csr_depc_o(csr_depc),
		.debug_mode_i(debug_mode),
		.debug_cause_i(debug_cause),
		.debug_csr_save_i(debug_csr_save),
		.debug_single_step_o(debug_single_step),
		.debug_ebreakm_o(debug_ebreakm),
		.debug_ebreaku_o(debug_ebreaku),
		.trigger_match_o(trigger_match),
		.pc_if_i(pc_if),
		.pc_id_i(pc_id),
		.pc_wb_i(pc_wb),
		.data_ind_timing_o(data_ind_timing),
		.dummy_instr_en_o(dummy_instr_en),
		.dummy_instr_mask_o(dummy_instr_mask),
		.dummy_instr_seed_en_o(dummy_instr_seed_en),
		.dummy_instr_seed_o(dummy_instr_seed),
		.icache_enable_o(icache_enable),
		.csr_shadow_err_o(csr_shadow_err),
		.csr_save_if_i(csr_save_if),
		.csr_save_id_i(csr_save_id),
		.csr_save_wb_i(csr_save_wb),
		.csr_restore_mret_i(csr_restore_mret_id),
		.csr_restore_dret_i(csr_restore_dret_id),
		.csr_save_cause_i(csr_save_cause),
		.csr_mcause_i(exc_cause),
		.csr_mtval_i(csr_mtval),
		.illegal_csr_insn_o(illegal_csr_insn_id),
		.instr_ret_i(perf_instr_ret_wb),
		.instr_ret_compressed_i(perf_instr_ret_compressed_wb),
		.iside_wait_i(perf_iside_wait),
		.jump_i(perf_jump),
		.branch_i(perf_branch),
		.branch_taken_i(perf_tbranch),
		.mem_load_i(perf_load),
		.mem_store_i(perf_store),
		.dside_wait_i(perf_dside_wait),
		.mul_wait_i(perf_mul_wait),
		.div_wait_i(perf_div_wait),
		.external_perf_i(external_perf_i)
	);
	// Trace: core/rtl/ibex_core.sv:1114:3
	// removed localparam type ibex_pkg_pmp_req_e
	generate
		if (PMPEnable) begin : g_pmp
			// Trace: core/rtl/ibex_core.sv:1115:5
			wire [67:0] pmp_req_addr;
			// Trace: core/rtl/ibex_core.sv:1116:5
			wire [3:0] pmp_req_type;
			// Trace: core/rtl/ibex_core.sv:1117:5
			wire [3:0] pmp_priv_lvl;
			// Trace: core/rtl/ibex_core.sv:1119:5
			assign pmp_req_addr[34+:34] = {2'b00, instr_addr_o[31:0]};
			// Trace: core/rtl/ibex_core.sv:1120:5
			assign pmp_req_type[2+:2] = 2'b00;
			// Trace: core/rtl/ibex_core.sv:1121:5
			assign pmp_priv_lvl[2+:2] = priv_mode_if;
			// Trace: core/rtl/ibex_core.sv:1122:5
			assign pmp_req_addr[0+:34] = {2'b00, data_addr_o[31:0]};
			// Trace: core/rtl/ibex_core.sv:1123:5
			assign pmp_req_type[0+:2] = (data_we_o ? 2'b01 : 2'b10);
			// Trace: core/rtl/ibex_core.sv:1124:5
			assign pmp_priv_lvl[0+:2] = priv_mode_lsu;
			// Trace: core/rtl/ibex_core.sv:1126:5
			ibex_pmp #(
				.PMPGranularity(PMPGranularity),
				.PMPNumChan(PMP_NUM_CHAN),
				.PMPNumRegions(PMPNumRegions)
			) pmp_i(
				.clk_i(clk),
				.rst_ni(rst_ni),
				.csr_pmp_cfg_i(csr_pmp_cfg),
				.csr_pmp_addr_i(csr_pmp_addr),
				.priv_mode_i(pmp_priv_lvl),
				.pmp_req_addr_i(pmp_req_addr),
				.pmp_req_type_i(pmp_req_type),
				.pmp_req_err_o(pmp_req_err)
			);
		end
		else begin : g_no_pmp
			// Trace: core/rtl/ibex_core.sv:1144:5
			wire [1:0] unused_priv_lvl_if;
			wire [1:0] unused_priv_lvl_ls;
			// Trace: core/rtl/ibex_core.sv:1145:5
			wire [(PMPNumRegions * 34) - 1:0] unused_csr_pmp_addr;
			// Trace: core/rtl/ibex_core.sv:1146:5
			wire [(PMPNumRegions * 6) - 1:0] unused_csr_pmp_cfg;
			// Trace: core/rtl/ibex_core.sv:1147:5
			assign unused_priv_lvl_if = priv_mode_if;
			// Trace: core/rtl/ibex_core.sv:1148:5
			assign unused_priv_lvl_ls = priv_mode_lsu;
			// Trace: core/rtl/ibex_core.sv:1149:5
			assign unused_csr_pmp_addr = csr_pmp_addr;
			// Trace: core/rtl/ibex_core.sv:1150:5
			assign unused_csr_pmp_cfg = csr_pmp_cfg;
			// Trace: core/rtl/ibex_core.sv:1153:5
			assign pmp_req_err[ibex_pkg_PMP_I] = 1'b0;
			// Trace: core/rtl/ibex_core.sv:1154:5
			assign pmp_req_err[ibex_pkg_PMP_D] = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_core.sv:1164:3
	localparam signed [31:0] RVFI_STAGES = (WritebackStage ? 2 : 1);
	// Trace: core/rtl/ibex_core.sv:1166:3
	reg rvfi_stage_valid [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1167:3
	reg [63:0] rvfi_stage_order [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1168:3
	reg [31:0] rvfi_stage_insn [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1169:3
	reg rvfi_stage_trap [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1170:3
	reg rvfi_stage_halt [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1171:3
	reg rvfi_stage_intr [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1172:3
	reg [1:0] rvfi_stage_mode [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1173:3
	reg [1:0] rvfi_stage_ixl [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1174:3
	reg [4:0] rvfi_stage_rs1_addr [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1175:3
	reg [4:0] rvfi_stage_rs2_addr [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1176:3
	reg [4:0] rvfi_stage_rs3_addr [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1177:3
	reg [31:0] rvfi_stage_rs1_rdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1178:3
	reg [31:0] rvfi_stage_rs2_rdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1179:3
	reg [31:0] rvfi_stage_rs3_rdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1180:3
	reg [4:0] rvfi_stage_rd_addr [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1181:3
	reg [31:0] rvfi_stage_rd_wdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1182:3
	reg [31:0] rvfi_stage_pc_rdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1183:3
	reg [31:0] rvfi_stage_pc_wdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1184:3
	reg [31:0] rvfi_stage_mem_addr [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1185:3
	reg [3:0] rvfi_stage_mem_rmask [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1186:3
	reg [3:0] rvfi_stage_mem_wmask [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1187:3
	reg [31:0] rvfi_stage_mem_rdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1188:3
	reg [31:0] rvfi_stage_mem_wdata [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1190:3
	wire rvfi_stage_valid_d [0:RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1192:3
	assign rvfi_valid = rvfi_stage_valid[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1193:3
	assign rvfi_order = rvfi_stage_order[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1194:3
	assign rvfi_insn = rvfi_stage_insn[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1195:3
	assign rvfi_trap = rvfi_stage_trap[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1196:3
	assign rvfi_halt = rvfi_stage_halt[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1197:3
	assign rvfi_intr = rvfi_stage_intr[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1198:3
	assign rvfi_mode = rvfi_stage_mode[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1199:3
	assign rvfi_ixl = rvfi_stage_ixl[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1200:3
	assign rvfi_rs1_addr = rvfi_stage_rs1_addr[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1201:3
	assign rvfi_rs2_addr = rvfi_stage_rs2_addr[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1202:3
	assign rvfi_rs3_addr = rvfi_stage_rs3_addr[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1203:3
	assign rvfi_rs1_rdata = rvfi_stage_rs1_rdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1204:3
	assign rvfi_rs2_rdata = rvfi_stage_rs2_rdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1205:3
	assign rvfi_rs3_rdata = rvfi_stage_rs3_rdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1206:3
	assign rvfi_rd_addr = rvfi_stage_rd_addr[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1207:3
	assign rvfi_rd_wdata = rvfi_stage_rd_wdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1208:3
	assign rvfi_pc_rdata = rvfi_stage_pc_rdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1209:3
	assign rvfi_pc_wdata = rvfi_stage_pc_wdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1210:3
	assign rvfi_mem_addr = rvfi_stage_mem_addr[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1211:3
	assign rvfi_mem_rmask = rvfi_stage_mem_rmask[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1212:3
	assign rvfi_mem_wmask = rvfi_stage_mem_wmask[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1213:3
	assign rvfi_mem_rdata = rvfi_stage_mem_rdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1214:3
	assign rvfi_mem_wdata = rvfi_stage_mem_wdata[RVFI_STAGES - 1];
	// Trace: core/rtl/ibex_core.sv:1216:3
	generate
		if (WritebackStage) begin : gen_rvfi_wb_stage
			// Trace: core/rtl/ibex_core.sv:1217:5
			wire unused_instr_new_id;
			// Trace: core/rtl/ibex_core.sv:1219:5
			assign unused_instr_new_id = instr_new_id;
			// Trace: core/rtl/ibex_core.sv:1225:5
			assign rvfi_stage_valid_d[0] = (instr_id_done & ~dummy_instr_id) | (rvfi_stage_valid[0] & ~instr_done_wb);
			// Trace: core/rtl/ibex_core.sv:1229:5
			assign rvfi_stage_valid_d[1] = instr_done_wb;
			// Trace: core/rtl/ibex_core.sv:1232:5
			reg rvfi_instr_new_wb_q;
			// Trace: core/rtl/ibex_core.sv:1234:5
			assign rvfi_instr_new_wb = rvfi_instr_new_wb_q;
			// Trace: core/rtl/ibex_core.sv:1236:5
			always @(posedge clk or negedge rst_ni)
				// Trace: core/rtl/ibex_core.sv:1237:7
				if (~rst_ni)
					// Trace: core/rtl/ibex_core.sv:1238:9
					rvfi_instr_new_wb_q <= 0;
				else
					// Trace: core/rtl/ibex_core.sv:1240:9
					rvfi_instr_new_wb_q <= instr_id_done;
		end
		else begin : gen_rvfi_no_wb_stage
			// Trace: core/rtl/ibex_core.sv:1246:5
			assign rvfi_stage_valid_d[0] = instr_id_done & ~dummy_instr_id;
			// Trace: core/rtl/ibex_core.sv:1249:5
			assign rvfi_instr_new_wb = instr_new_id;
		end
	endgenerate
	// Trace: core/rtl/ibex_core.sv:1252:3
	genvar _gv_i_1;
	localparam [1:0] ibex_pkg_CSR_MISA_MXL = 2'd1;
	function automatic [63:0] sv2v_cast_64;
		input reg [63:0] inp;
		sv2v_cast_64 = inp;
	endfunction
	generate
		for (_gv_i_1 = 0; _gv_i_1 < RVFI_STAGES; _gv_i_1 = _gv_i_1 + 1) begin : g_rvfi_stages
			localparam i = _gv_i_1;
			// Trace: core/rtl/ibex_core.sv:1253:5
			always @(posedge clk or negedge rst_ni)
				// Trace: core/rtl/ibex_core.sv:1254:7
				if (!rst_ni) begin
					// Trace: core/rtl/ibex_core.sv:1255:9
					rvfi_stage_halt[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1256:9
					rvfi_stage_trap[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1257:9
					rvfi_stage_intr[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1258:9
					rvfi_stage_order[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1259:9
					rvfi_stage_insn[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1260:9
					rvfi_stage_mode[i] <= 2'b11;
					// Trace: core/rtl/ibex_core.sv:1261:9
					rvfi_stage_ixl[i] <= ibex_pkg_CSR_MISA_MXL;
					// Trace: core/rtl/ibex_core.sv:1262:9
					rvfi_stage_rs1_addr[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1263:9
					rvfi_stage_rs2_addr[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1264:9
					rvfi_stage_rs3_addr[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1265:9
					rvfi_stage_pc_rdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1266:9
					rvfi_stage_pc_wdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1267:9
					rvfi_stage_mem_rmask[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1268:9
					rvfi_stage_mem_wmask[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1269:9
					rvfi_stage_valid[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1270:9
					rvfi_stage_rs1_rdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1271:9
					rvfi_stage_rs2_rdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1272:9
					rvfi_stage_rs3_rdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1273:9
					rvfi_stage_rd_wdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1274:9
					rvfi_stage_rd_addr[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1275:9
					rvfi_stage_mem_rdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1276:9
					rvfi_stage_mem_wdata[i] <= 1'sb0;
					// Trace: core/rtl/ibex_core.sv:1277:9
					rvfi_stage_mem_addr[i] <= 1'sb0;
				end
				else begin
					// Trace: core/rtl/ibex_core.sv:1279:9
					rvfi_stage_valid[i] <= rvfi_stage_valid_d[i];
					// Trace: core/rtl/ibex_core.sv:1281:9
					if (i == 0) begin
						begin
							// Trace: core/rtl/ibex_core.sv:1282:11
							if (instr_id_done) begin
								// Trace: core/rtl/ibex_core.sv:1283:13
								rvfi_stage_halt[i] <= 1'sb0;
								// Trace: core/rtl/ibex_core.sv:1284:13
								rvfi_stage_trap[i] <= illegal_insn_id;
								// Trace: core/rtl/ibex_core.sv:1285:13
								rvfi_stage_intr[i] <= rvfi_intr_d;
								// Trace: core/rtl/ibex_core.sv:1286:13
								rvfi_stage_order[i] <= rvfi_stage_order[i] + sv2v_cast_64(rvfi_stage_valid_d[i]);
								// Trace: core/rtl/ibex_core.sv:1287:13
								rvfi_stage_insn[i] <= rvfi_insn_id;
								// Trace: core/rtl/ibex_core.sv:1288:13
								rvfi_stage_mode[i] <= {priv_mode_id};
								// Trace: core/rtl/ibex_core.sv:1289:13
								rvfi_stage_ixl[i] <= ibex_pkg_CSR_MISA_MXL;
								// Trace: core/rtl/ibex_core.sv:1290:13
								rvfi_stage_rs1_addr[i] <= rvfi_rs1_addr_d;
								// Trace: core/rtl/ibex_core.sv:1291:13
								rvfi_stage_rs2_addr[i] <= rvfi_rs2_addr_d;
								// Trace: core/rtl/ibex_core.sv:1292:13
								rvfi_stage_rs3_addr[i] <= rvfi_rs3_addr_d;
								// Trace: core/rtl/ibex_core.sv:1293:13
								rvfi_stage_pc_rdata[i] <= pc_id;
								// Trace: core/rtl/ibex_core.sv:1294:13
								rvfi_stage_pc_wdata[i] <= (pc_set ? branch_target_ex : pc_if);
								// Trace: core/rtl/ibex_core.sv:1295:13
								rvfi_stage_mem_rmask[i] <= rvfi_mem_mask_int;
								// Trace: core/rtl/ibex_core.sv:1296:13
								rvfi_stage_mem_wmask[i] <= (data_we_o ? rvfi_mem_mask_int : 4'b0000);
								// Trace: core/rtl/ibex_core.sv:1297:13
								rvfi_stage_rs1_rdata[i] <= rvfi_rs1_data_d;
								// Trace: core/rtl/ibex_core.sv:1298:13
								rvfi_stage_rs2_rdata[i] <= rvfi_rs2_data_d;
								// Trace: core/rtl/ibex_core.sv:1299:13
								rvfi_stage_rs3_rdata[i] <= rvfi_rs3_data_d;
								// Trace: core/rtl/ibex_core.sv:1300:13
								rvfi_stage_rd_addr[i] <= rvfi_rd_addr_d;
								// Trace: core/rtl/ibex_core.sv:1301:13
								rvfi_stage_rd_wdata[i] <= rvfi_rd_wdata_d;
								// Trace: core/rtl/ibex_core.sv:1302:13
								rvfi_stage_mem_rdata[i] <= rvfi_mem_rdata_d;
								// Trace: core/rtl/ibex_core.sv:1303:13
								rvfi_stage_mem_wdata[i] <= rvfi_mem_wdata_d;
								// Trace: core/rtl/ibex_core.sv:1304:13
								rvfi_stage_mem_addr[i] <= rvfi_mem_addr_d;
							end
						end
					end
					else
						// Trace: core/rtl/ibex_core.sv:1307:11
						if (instr_done_wb) begin
							// Trace: core/rtl/ibex_core.sv:1308:13
							rvfi_stage_halt[i] <= rvfi_stage_halt[i - 1];
							// Trace: core/rtl/ibex_core.sv:1309:13
							rvfi_stage_trap[i] <= rvfi_stage_trap[i - 1];
							// Trace: core/rtl/ibex_core.sv:1310:13
							rvfi_stage_intr[i] <= rvfi_stage_intr[i - 1];
							// Trace: core/rtl/ibex_core.sv:1311:13
							rvfi_stage_order[i] <= rvfi_stage_order[i - 1];
							// Trace: core/rtl/ibex_core.sv:1312:13
							rvfi_stage_insn[i] <= rvfi_stage_insn[i - 1];
							// Trace: core/rtl/ibex_core.sv:1313:13
							rvfi_stage_mode[i] <= rvfi_stage_mode[i - 1];
							// Trace: core/rtl/ibex_core.sv:1314:13
							rvfi_stage_ixl[i] <= rvfi_stage_ixl[i - 1];
							// Trace: core/rtl/ibex_core.sv:1315:13
							rvfi_stage_rs1_addr[i] <= rvfi_stage_rs1_addr[i - 1];
							// Trace: core/rtl/ibex_core.sv:1316:13
							rvfi_stage_rs2_addr[i] <= rvfi_stage_rs2_addr[i - 1];
							// Trace: core/rtl/ibex_core.sv:1317:13
							rvfi_stage_rs3_addr[i] <= rvfi_stage_rs3_addr[i - 1];
							// Trace: core/rtl/ibex_core.sv:1318:13
							rvfi_stage_pc_rdata[i] <= rvfi_stage_pc_rdata[i - 1];
							// Trace: core/rtl/ibex_core.sv:1319:13
							rvfi_stage_pc_wdata[i] <= rvfi_stage_pc_wdata[i - 1];
							// Trace: core/rtl/ibex_core.sv:1320:13
							rvfi_stage_mem_rmask[i] <= rvfi_stage_mem_rmask[i - 1];
							// Trace: core/rtl/ibex_core.sv:1321:13
							rvfi_stage_mem_wmask[i] <= rvfi_stage_mem_wmask[i - 1];
							// Trace: core/rtl/ibex_core.sv:1322:13
							rvfi_stage_rs1_rdata[i] <= rvfi_stage_rs1_rdata[i - 1];
							// Trace: core/rtl/ibex_core.sv:1323:13
							rvfi_stage_rs2_rdata[i] <= rvfi_stage_rs2_rdata[i - 1];
							// Trace: core/rtl/ibex_core.sv:1324:13
							rvfi_stage_rs3_rdata[i] <= rvfi_stage_rs3_rdata[i - 1];
							// Trace: core/rtl/ibex_core.sv:1325:13
							rvfi_stage_mem_wdata[i] <= rvfi_stage_mem_wdata[i - 1];
							// Trace: core/rtl/ibex_core.sv:1326:13
							rvfi_stage_mem_addr[i] <= rvfi_stage_mem_addr[i - 1];
							// Trace: core/rtl/ibex_core.sv:1332:13
							rvfi_stage_rd_addr[i] <= rvfi_rd_addr_d;
							// Trace: core/rtl/ibex_core.sv:1333:13
							rvfi_stage_rd_wdata[i] <= rvfi_rd_wdata_d;
							// Trace: core/rtl/ibex_core.sv:1334:13
							rvfi_stage_mem_rdata[i] <= rvfi_mem_rdata_d;
						end
				end
		end
	endgenerate
	// Trace: core/rtl/ibex_core.sv:1343:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_core.sv:1344:5
		if (instr_first_cycle_id) begin
			// Trace: core/rtl/ibex_core.sv:1345:7
			rvfi_mem_addr_d = alu_adder_result_ex;
			// Trace: core/rtl/ibex_core.sv:1346:7
			rvfi_mem_wdata_d = lsu_wdata;
		end
		else begin
			// Trace: core/rtl/ibex_core.sv:1348:7
			rvfi_mem_addr_d = rvfi_mem_addr_q;
			// Trace: core/rtl/ibex_core.sv:1349:7
			rvfi_mem_wdata_d = rvfi_mem_wdata_q;
		end
	end
	// Trace: core/rtl/ibex_core.sv:1354:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_core.sv:1355:5
		if (lsu_resp_valid)
			// Trace: core/rtl/ibex_core.sv:1356:7
			rvfi_mem_rdata_d = rf_wdata_lsu;
		else
			// Trace: core/rtl/ibex_core.sv:1358:7
			rvfi_mem_rdata_d = rvfi_mem_rdata_q;
	end
	// Trace: core/rtl/ibex_core.sv:1362:3
	always @(posedge clk or negedge rst_ni)
		// Trace: core/rtl/ibex_core.sv:1363:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_core.sv:1364:7
			rvfi_mem_addr_q <= 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1365:7
			rvfi_mem_rdata_q <= 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1366:7
			rvfi_mem_wdata_q <= 1'sb0;
		end
		else begin
			// Trace: core/rtl/ibex_core.sv:1368:7
			rvfi_mem_addr_q <= rvfi_mem_addr_d;
			// Trace: core/rtl/ibex_core.sv:1369:7
			rvfi_mem_rdata_q <= rvfi_mem_rdata_d;
			// Trace: core/rtl/ibex_core.sv:1370:7
			rvfi_mem_wdata_q <= rvfi_mem_wdata_d;
		end
	// Trace: core/rtl/ibex_core.sv:1374:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_core.sv:1375:5
		(* full_case, parallel_case *)
		case (lsu_type)
			2'b00:
				// Trace: core/rtl/ibex_core.sv:1376:16
				rvfi_mem_mask_int = 4'b1111;
			2'b01:
				// Trace: core/rtl/ibex_core.sv:1377:16
				rvfi_mem_mask_int = 4'b0011;
			2'b10:
				// Trace: core/rtl/ibex_core.sv:1378:16
				rvfi_mem_mask_int = 4'b0001;
			default:
				// Trace: core/rtl/ibex_core.sv:1379:16
				rvfi_mem_mask_int = 4'b0000;
		endcase
	end
	// Trace: core/rtl/ibex_core.sv:1383:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_core.sv:1384:5
		if (instr_is_compressed_id)
			// Trace: core/rtl/ibex_core.sv:1385:7
			rvfi_insn_id = {16'b0000000000000000, instr_rdata_c_id};
		else
			// Trace: core/rtl/ibex_core.sv:1387:7
			rvfi_insn_id = instr_rdata_id;
	end
	// Trace: core/rtl/ibex_core.sv:1393:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_core.sv:1394:5
		if (instr_first_cycle_id) begin
			// Trace: core/rtl/ibex_core.sv:1395:7
			rvfi_rs1_data_d = (rf_ren_a ? multdiv_operand_a_ex : {32 {1'sb0}});
			// Trace: core/rtl/ibex_core.sv:1396:7
			rvfi_rs1_addr_d = (rf_ren_a ? rf_raddr_a : {5 {1'sb0}});
			// Trace: core/rtl/ibex_core.sv:1397:7
			rvfi_rs2_data_d = (rf_ren_b ? multdiv_operand_b_ex : {32 {1'sb0}});
			// Trace: core/rtl/ibex_core.sv:1398:7
			rvfi_rs2_addr_d = (rf_ren_b ? rf_raddr_b : {5 {1'sb0}});
			// Trace: core/rtl/ibex_core.sv:1399:7
			rvfi_rs3_data_d = 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1400:7
			rvfi_rs3_addr_d = 1'sb0;
		end
		else begin
			// Trace: core/rtl/ibex_core.sv:1402:7
			rvfi_rs1_data_d = rvfi_rs1_data_q;
			// Trace: core/rtl/ibex_core.sv:1403:7
			rvfi_rs1_addr_d = rvfi_rs1_addr_q;
			// Trace: core/rtl/ibex_core.sv:1404:7
			rvfi_rs2_data_d = rvfi_rs2_data_q;
			// Trace: core/rtl/ibex_core.sv:1405:7
			rvfi_rs2_addr_d = rvfi_rs2_addr_q;
			// Trace: core/rtl/ibex_core.sv:1406:7
			rvfi_rs3_data_d = multdiv_operand_a_ex;
			// Trace: core/rtl/ibex_core.sv:1407:7
			rvfi_rs3_addr_d = rf_raddr_a;
		end
	end
	// Trace: core/rtl/ibex_core.sv:1410:3
	always @(posedge clk or negedge rst_ni)
		// Trace: core/rtl/ibex_core.sv:1411:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_core.sv:1412:7
			rvfi_rs1_data_q <= 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1413:7
			rvfi_rs1_addr_q <= 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1414:7
			rvfi_rs2_data_q <= 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1415:7
			rvfi_rs2_addr_q <= 1'sb0;
		end
		else begin
			// Trace: core/rtl/ibex_core.sv:1418:7
			rvfi_rs1_data_q <= rvfi_rs1_data_d;
			// Trace: core/rtl/ibex_core.sv:1419:7
			rvfi_rs1_addr_q <= rvfi_rs1_addr_d;
			// Trace: core/rtl/ibex_core.sv:1420:7
			rvfi_rs2_data_q <= rvfi_rs2_data_d;
			// Trace: core/rtl/ibex_core.sv:1421:7
			rvfi_rs2_addr_q <= rvfi_rs2_addr_d;
		end
	// Trace: core/rtl/ibex_core.sv:1425:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_core.sv:1426:5
		if (rvfi_rd_we_wb) begin
			// Trace: core/rtl/ibex_core.sv:1428:7
			rvfi_rd_addr_d = rvfi_rd_addr_wb;
			// Trace: core/rtl/ibex_core.sv:1430:7
			if (rvfi_rd_addr_wb == 5'b00000)
				// Trace: core/rtl/ibex_core.sv:1431:9
				rvfi_rd_wdata_d = 1'sb0;
			else
				// Trace: core/rtl/ibex_core.sv:1433:9
				rvfi_rd_wdata_d = rvfi_rd_wdata_wb;
		end
		else if (rvfi_instr_new_wb) begin
			// Trace: core/rtl/ibex_core.sv:1438:7
			rvfi_rd_addr_d = 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1439:7
			rvfi_rd_wdata_d = 1'sb0;
		end
		else begin
			// Trace: core/rtl/ibex_core.sv:1442:7
			rvfi_rd_addr_d = rvfi_rd_addr_q;
			// Trace: core/rtl/ibex_core.sv:1443:7
			rvfi_rd_wdata_d = rvfi_rd_wdata_q;
		end
	end
	// Trace: core/rtl/ibex_core.sv:1449:3
	always @(posedge clk or negedge rst_ni)
		// Trace: core/rtl/ibex_core.sv:1450:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_core.sv:1451:7
			rvfi_rd_addr_q <= 1'sb0;
			// Trace: core/rtl/ibex_core.sv:1452:7
			rvfi_rd_wdata_q <= 1'sb0;
		end
		else begin
			// Trace: core/rtl/ibex_core.sv:1454:7
			rvfi_rd_addr_q <= rvfi_rd_addr_d;
			// Trace: core/rtl/ibex_core.sv:1455:7
			rvfi_rd_wdata_q <= rvfi_rd_wdata_d;
		end
	// Trace: core/rtl/ibex_core.sv:1462:3
	assign rvfi_intr_d = (instr_first_cycle_id ? rvfi_set_trap_pc_q : rvfi_intr_q);
	// Trace: core/rtl/ibex_core.sv:1464:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_core.sv:1465:5
		rvfi_set_trap_pc_d = rvfi_set_trap_pc_q;
		// Trace: core/rtl/ibex_core.sv:1467:5
		if ((pc_set && (pc_mux_id == 3'd2)) && ((exc_pc_mux_id == 3'd0) || (exc_pc_mux_id == 3'd1)))
			// Trace: core/rtl/ibex_core.sv:1470:7
			rvfi_set_trap_pc_d = 1'b1;
		else if (rvfi_set_trap_pc_q && instr_id_done)
			// Trace: core/rtl/ibex_core.sv:1473:7
			rvfi_set_trap_pc_d = 1'b0;
	end
	// Trace: core/rtl/ibex_core.sv:1477:3
	always @(posedge clk or negedge rst_ni)
		// Trace: core/rtl/ibex_core.sv:1478:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_core.sv:1479:7
			rvfi_set_trap_pc_q <= 1'b0;
			// Trace: core/rtl/ibex_core.sv:1480:7
			rvfi_intr_q <= 1'b0;
		end
		else begin
			// Trace: core/rtl/ibex_core.sv:1482:7
			rvfi_set_trap_pc_q <= rvfi_set_trap_pc_d;
			// Trace: core/rtl/ibex_core.sv:1483:7
			rvfi_intr_q <= rvfi_intr_d;
		end
	// Trace: core/rtl/ibex_core.sv:1497:3
	reg granted = 0;
	// Trace: core/rtl/ibex_core.sv:1498:3
	always @(posedge clk)
		// Trace: core/rtl/ibex_core.sv:1499:5
		granted <= instr_gnt_i;
	// Trace: core/rtl/ibex_core.sv:1501:3
	assign fetch_o = granted;
	// Trace: core/rtl/ibex_core.sv:1502:3
	assign retire_o = instr_done_wb;
	// Trace: core/rtl/ibex_core.sv:1503:3
	assign retire_instr_o = instr_done_rdata_wb;
	// Trace: core/rtl/ibex_core.sv:1504:3
	assign regfile_o = rf_regfile;
	initial _sv2v_0 = 0;
endmodule
