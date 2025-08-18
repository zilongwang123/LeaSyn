// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_cs_registers (
	clk_i,
	rst_ni,
	hart_id_i,
	priv_mode_id_o,
	priv_mode_if_o,
	priv_mode_lsu_o,
	csr_mstatus_tw_o,
	csr_mtvec_o,
	csr_mtvecx_o,
	csr_mtvec_init_i,
	boot_addr_i,
	csr_access_i,
	csr_addr_i,
	csr_wdata_i,
	csr_op_i,
	csr_op_en_i,
	csr_rdata_o,
	irq_software_i,
	irq_timer_i,
	irq_external_i,
	irq_fast_i,
	irq_x_i,
	nmi_mode_i,
	irq_pending_o,
	irqs_o,
	irqs_x_o,
	csr_mstatus_mie_o,
	csr_mepc_o,
	csr_pmp_cfg_o,
	csr_pmp_addr_o,
	debug_mode_i,
	debug_cause_i,
	debug_csr_save_i,
	csr_depc_o,
	debug_single_step_o,
	debug_ebreakm_o,
	debug_ebreaku_o,
	trigger_match_o,
	pc_if_i,
	pc_id_i,
	pc_wb_i,
	data_ind_timing_o,
	dummy_instr_en_o,
	dummy_instr_mask_o,
	dummy_instr_seed_en_o,
	dummy_instr_seed_o,
	icache_enable_o,
	csr_shadow_err_o,
	csr_save_if_i,
	csr_save_id_i,
	csr_save_wb_i,
	csr_restore_mret_i,
	csr_restore_dret_i,
	csr_save_cause_i,
	csr_mcause_i,
	csr_mtval_i,
	illegal_csr_insn_o,
	instr_ret_i,
	instr_ret_compressed_i,
	iside_wait_i,
	jump_i,
	branch_i,
	branch_taken_i,
	mem_load_i,
	mem_store_i,
	dside_wait_i,
	mul_wait_i,
	div_wait_i,
	external_perf_i
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_cs_registers.sv:16:15
	parameter [0:0] DbgTriggerEn = 0;
	// Trace: core/rtl/ibex_cs_registers.sv:17:15
	parameter [31:0] DbgHwBreakNum = 1;
	// Trace: core/rtl/ibex_cs_registers.sv:18:15
	parameter [0:0] DataIndTiming = 1'b0;
	// Trace: core/rtl/ibex_cs_registers.sv:19:15
	parameter [0:0] DummyInstructions = 1'b0;
	// Trace: core/rtl/ibex_cs_registers.sv:20:15
	parameter [0:0] ShadowCSR = 1'b0;
	// Trace: core/rtl/ibex_cs_registers.sv:21:15
	parameter [0:0] ICache = 1'b0;
	// Trace: core/rtl/ibex_cs_registers.sv:22:15
	parameter [31:0] MHPMCounterNum = 10;
	// Trace: core/rtl/ibex_cs_registers.sv:23:15
	parameter [31:0] MHPMCounterWidth = 40;
	// Trace: core/rtl/ibex_cs_registers.sv:24:15
	parameter [0:0] PMPEnable = 0;
	// Trace: core/rtl/ibex_cs_registers.sv:25:15
	parameter [31:0] PMPGranularity = 0;
	// Trace: core/rtl/ibex_cs_registers.sv:26:15
	parameter [31:0] PMPNumRegions = 4;
	// Trace: core/rtl/ibex_cs_registers.sv:27:15
	parameter [0:0] RV32E = 0;
	// Trace: core/rtl/ibex_cs_registers.sv:28:15
	// removed localparam type ibex_pkg_rv32m_e
	parameter integer RV32M = 32'sd2;
	// Trace: core/rtl/ibex_cs_registers.sv:29:15
	// removed localparam type ibex_pkg_rv32b_e
	parameter integer RV32B = 32'sd0;
	// Trace: core/rtl/ibex_cs_registers.sv:32:5
	input wire clk_i;
	// Trace: core/rtl/ibex_cs_registers.sv:33:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_cs_registers.sv:36:5
	input wire [31:0] hart_id_i;
	// Trace: core/rtl/ibex_cs_registers.sv:39:5
	// removed localparam type ibex_pkg_priv_lvl_e
	output wire [1:0] priv_mode_id_o;
	// Trace: core/rtl/ibex_cs_registers.sv:40:5
	output wire [1:0] priv_mode_if_o;
	// Trace: core/rtl/ibex_cs_registers.sv:41:5
	output wire [1:0] priv_mode_lsu_o;
	// Trace: core/rtl/ibex_cs_registers.sv:42:5
	output wire csr_mstatus_tw_o;
	// Trace: core/rtl/ibex_cs_registers.sv:45:5
	output wire [31:0] csr_mtvec_o;
	// Trace: core/rtl/ibex_cs_registers.sv:46:5
	output wire [31:0] csr_mtvecx_o;
	// Trace: core/rtl/ibex_cs_registers.sv:47:5
	input wire csr_mtvec_init_i;
	// Trace: core/rtl/ibex_cs_registers.sv:48:5
	input wire [31:0] boot_addr_i;
	// Trace: core/rtl/ibex_cs_registers.sv:51:5
	input wire csr_access_i;
	// Trace: core/rtl/ibex_cs_registers.sv:52:5
	// removed localparam type ibex_pkg_csr_num_e
	input wire [11:0] csr_addr_i;
	// Trace: core/rtl/ibex_cs_registers.sv:53:5
	input wire [31:0] csr_wdata_i;
	// Trace: core/rtl/ibex_cs_registers.sv:54:5
	// removed localparam type ibex_pkg_csr_op_e
	input wire [1:0] csr_op_i;
	// Trace: core/rtl/ibex_cs_registers.sv:55:5
	input csr_op_en_i;
	// Trace: core/rtl/ibex_cs_registers.sv:56:5
	output wire [31:0] csr_rdata_o;
	// Trace: core/rtl/ibex_cs_registers.sv:59:5
	input wire irq_software_i;
	// Trace: core/rtl/ibex_cs_registers.sv:60:5
	input wire irq_timer_i;
	// Trace: core/rtl/ibex_cs_registers.sv:61:5
	input wire irq_external_i;
	// Trace: core/rtl/ibex_cs_registers.sv:62:5
	input wire [14:0] irq_fast_i;
	// Trace: core/rtl/ibex_cs_registers.sv:63:5
	input wire [31:0] irq_x_i;
	// Trace: core/rtl/ibex_cs_registers.sv:64:5
	input wire nmi_mode_i;
	// Trace: core/rtl/ibex_cs_registers.sv:65:5
	output wire irq_pending_o;
	// Trace: core/rtl/ibex_cs_registers.sv:66:5
	// removed localparam type ibex_pkg_irqs_t
	output wire [17:0] irqs_o;
	// Trace: core/rtl/ibex_cs_registers.sv:67:5
	output wire [31:0] irqs_x_o;
	// Trace: core/rtl/ibex_cs_registers.sv:68:5
	output wire csr_mstatus_mie_o;
	// Trace: core/rtl/ibex_cs_registers.sv:69:5
	output wire [31:0] csr_mepc_o;
	// Trace: core/rtl/ibex_cs_registers.sv:72:5
	// removed localparam type ibex_pkg_pmp_cfg_mode_e
	// removed localparam type ibex_pkg_pmp_cfg_t
	output wire [(PMPNumRegions * 6) - 1:0] csr_pmp_cfg_o;
	// Trace: core/rtl/ibex_cs_registers.sv:73:5
	output wire [(PMPNumRegions * 34) - 1:0] csr_pmp_addr_o;
	// Trace: core/rtl/ibex_cs_registers.sv:76:5
	input wire debug_mode_i;
	// Trace: core/rtl/ibex_cs_registers.sv:77:5
	// removed localparam type ibex_pkg_dbg_cause_e
	input wire [2:0] debug_cause_i;
	// Trace: core/rtl/ibex_cs_registers.sv:78:5
	input wire debug_csr_save_i;
	// Trace: core/rtl/ibex_cs_registers.sv:79:5
	output wire [31:0] csr_depc_o;
	// Trace: core/rtl/ibex_cs_registers.sv:80:5
	output wire debug_single_step_o;
	// Trace: core/rtl/ibex_cs_registers.sv:81:5
	output wire debug_ebreakm_o;
	// Trace: core/rtl/ibex_cs_registers.sv:82:5
	output wire debug_ebreaku_o;
	// Trace: core/rtl/ibex_cs_registers.sv:83:5
	output wire trigger_match_o;
	// Trace: core/rtl/ibex_cs_registers.sv:85:5
	input wire [31:0] pc_if_i;
	// Trace: core/rtl/ibex_cs_registers.sv:86:5
	input wire [31:0] pc_id_i;
	// Trace: core/rtl/ibex_cs_registers.sv:87:5
	input wire [31:0] pc_wb_i;
	// Trace: core/rtl/ibex_cs_registers.sv:90:5
	output wire data_ind_timing_o;
	// Trace: core/rtl/ibex_cs_registers.sv:91:5
	output wire dummy_instr_en_o;
	// Trace: core/rtl/ibex_cs_registers.sv:92:5
	output wire [2:0] dummy_instr_mask_o;
	// Trace: core/rtl/ibex_cs_registers.sv:93:5
	output wire dummy_instr_seed_en_o;
	// Trace: core/rtl/ibex_cs_registers.sv:94:5
	output wire [31:0] dummy_instr_seed_o;
	// Trace: core/rtl/ibex_cs_registers.sv:95:5
	output wire icache_enable_o;
	// Trace: core/rtl/ibex_cs_registers.sv:96:5
	output wire csr_shadow_err_o;
	// Trace: core/rtl/ibex_cs_registers.sv:99:5
	input wire csr_save_if_i;
	// Trace: core/rtl/ibex_cs_registers.sv:100:5
	input wire csr_save_id_i;
	// Trace: core/rtl/ibex_cs_registers.sv:101:5
	input wire csr_save_wb_i;
	// Trace: core/rtl/ibex_cs_registers.sv:102:5
	input wire csr_restore_mret_i;
	// Trace: core/rtl/ibex_cs_registers.sv:103:5
	input wire csr_restore_dret_i;
	// Trace: core/rtl/ibex_cs_registers.sv:104:5
	input wire csr_save_cause_i;
	// Trace: core/rtl/ibex_cs_registers.sv:105:5
	// removed localparam type ibex_pkg_exc_cause_e
	input wire [5:0] csr_mcause_i;
	// Trace: core/rtl/ibex_cs_registers.sv:106:5
	input wire [31:0] csr_mtval_i;
	// Trace: core/rtl/ibex_cs_registers.sv:107:5
	output wire illegal_csr_insn_o;
	// Trace: core/rtl/ibex_cs_registers.sv:111:5
	input wire instr_ret_i;
	// Trace: core/rtl/ibex_cs_registers.sv:112:5
	input wire instr_ret_compressed_i;
	// Trace: core/rtl/ibex_cs_registers.sv:113:5
	input wire iside_wait_i;
	// Trace: core/rtl/ibex_cs_registers.sv:114:5
	input wire jump_i;
	// Trace: core/rtl/ibex_cs_registers.sv:115:5
	input wire branch_i;
	// Trace: core/rtl/ibex_cs_registers.sv:116:5
	input wire branch_taken_i;
	// Trace: core/rtl/ibex_cs_registers.sv:117:5
	input wire mem_load_i;
	// Trace: core/rtl/ibex_cs_registers.sv:118:5
	input wire mem_store_i;
	// Trace: core/rtl/ibex_cs_registers.sv:119:5
	input wire dside_wait_i;
	// Trace: core/rtl/ibex_cs_registers.sv:120:5
	input wire mul_wait_i;
	// Trace: core/rtl/ibex_cs_registers.sv:121:5
	input wire div_wait_i;
	// Trace: core/rtl/ibex_cs_registers.sv:122:5
	input wire [15:0] external_perf_i;
	// Trace: core/rtl/ibex_cs_registers.sv:125:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_cs_registers.sv:127:3
	localparam [31:0] RV32BEnabled = (RV32B == 32'sd0 ? 0 : 1);
	// Trace: core/rtl/ibex_cs_registers.sv:128:3
	localparam [31:0] RV32MEnabled = (RV32M == 32'sd0 ? 0 : 1);
	// Trace: core/rtl/ibex_cs_registers.sv:129:3
	localparam [31:0] PMPAddrWidth = (PMPGranularity > 0 ? 33 - PMPGranularity : 32);
	// Trace: core/rtl/ibex_cs_registers.sv:132:3
	localparam [1:0] ibex_pkg_CSR_MISA_MXL = 2'd1;
	function automatic [31:0] sv2v_cast_32;
		input reg [31:0] inp;
		sv2v_cast_32 = inp;
	endfunction
	localparam [31:0] MISA_VALUE = (((((((((((0 | (RV32BEnabled << 1)) | 4) | 0) | (sv2v_cast_32(RV32E) << 4)) | 0) | (sv2v_cast_32(!RV32E) << 8)) | (RV32MEnabled << 12)) | 0) | 0) | 1048576) | 0) | (sv2v_cast_32(ibex_pkg_CSR_MISA_MXL) << 30);
	// Trace: core/rtl/ibex_cs_registers.sv:147:3
	// removed localparam type status_t
	// Trace: core/rtl/ibex_cs_registers.sv:155:3
	// removed localparam type status_stk_t
	// Trace: core/rtl/ibex_cs_registers.sv:160:3
	// removed localparam type ibex_pkg_x_debug_ver_e
	// removed localparam type dcsr_t
	// Trace: core/rtl/ibex_cs_registers.sv:179:3
	// removed localparam type cpu_ctrl_t
	// Trace: core/rtl/ibex_cs_registers.sv:187:3
	reg [31:0] exception_pc;
	// Trace: core/rtl/ibex_cs_registers.sv:190:3
	reg [1:0] priv_lvl_q;
	reg [1:0] priv_lvl_d;
	// Trace: core/rtl/ibex_cs_registers.sv:191:3
	wire [5:0] mstatus_q;
	reg [5:0] mstatus_d;
	// Trace: core/rtl/ibex_cs_registers.sv:192:3
	wire mstatus_err;
	// Trace: core/rtl/ibex_cs_registers.sv:193:3
	reg mstatus_en;
	// Trace: core/rtl/ibex_cs_registers.sv:194:3
	wire [17:0] mie_q;
	wire [17:0] mie_d;
	// Trace: core/rtl/ibex_cs_registers.sv:195:3
	reg mie_en;
	// Trace: core/rtl/ibex_cs_registers.sv:196:3
	wire [31:0] mscratch_q;
	// Trace: core/rtl/ibex_cs_registers.sv:197:3
	reg mscratch_en;
	// Trace: core/rtl/ibex_cs_registers.sv:198:3
	wire [31:0] mepc_q;
	reg [31:0] mepc_d;
	// Trace: core/rtl/ibex_cs_registers.sv:199:3
	reg mepc_en;
	// Trace: core/rtl/ibex_cs_registers.sv:200:3
	wire [5:0] mcause_q;
	reg [5:0] mcause_d;
	// Trace: core/rtl/ibex_cs_registers.sv:201:3
	reg mcause_en;
	// Trace: core/rtl/ibex_cs_registers.sv:202:3
	wire [31:0] mtval_q;
	reg [31:0] mtval_d;
	// Trace: core/rtl/ibex_cs_registers.sv:203:3
	reg mtval_en;
	// Trace: core/rtl/ibex_cs_registers.sv:204:3
	wire [31:0] mtvec_q;
	reg [31:0] mtvec_d;
	// Trace: core/rtl/ibex_cs_registers.sv:205:3
	wire mtvec_err;
	// Trace: core/rtl/ibex_cs_registers.sv:206:3
	reg mtvec_en;
	// Trace: core/rtl/ibex_cs_registers.sv:207:3
	wire [17:0] mip;
	// Trace: core/rtl/ibex_cs_registers.sv:208:3
	wire [31:0] dcsr_q;
	reg [31:0] dcsr_d;
	// Trace: core/rtl/ibex_cs_registers.sv:209:3
	reg dcsr_en;
	// Trace: core/rtl/ibex_cs_registers.sv:210:3
	wire [31:0] depc_q;
	reg [31:0] depc_d;
	// Trace: core/rtl/ibex_cs_registers.sv:211:3
	reg depc_en;
	// Trace: core/rtl/ibex_cs_registers.sv:212:3
	wire [31:0] dscratch0_q;
	// Trace: core/rtl/ibex_cs_registers.sv:213:3
	wire [31:0] dscratch1_q;
	// Trace: core/rtl/ibex_cs_registers.sv:214:3
	reg dscratch0_en;
	reg dscratch1_en;
	// Trace: core/rtl/ibex_cs_registers.sv:217:3
	wire [31:0] miex_q;
	// Trace: core/rtl/ibex_cs_registers.sv:218:3
	reg miex_en;
	// Trace: core/rtl/ibex_cs_registers.sv:219:3
	wire [31:0] mipx;
	// Trace: core/rtl/ibex_cs_registers.sv:220:3
	wire [31:0] mtvecx_q;
	reg [31:0] mtvecx_d;
	// Trace: core/rtl/ibex_cs_registers.sv:221:3
	wire mtvecx_err;
	// Trace: core/rtl/ibex_cs_registers.sv:222:3
	reg mtvecx_en;
	// Trace: core/rtl/ibex_cs_registers.sv:226:3
	wire [2:0] mstack_q;
	reg [2:0] mstack_d;
	// Trace: core/rtl/ibex_cs_registers.sv:227:3
	reg mstack_en;
	// Trace: core/rtl/ibex_cs_registers.sv:228:3
	wire [31:0] mstack_epc_q;
	reg [31:0] mstack_epc_d;
	// Trace: core/rtl/ibex_cs_registers.sv:229:3
	wire [5:0] mstack_cause_q;
	reg [5:0] mstack_cause_d;
	// Trace: core/rtl/ibex_cs_registers.sv:232:3
	localparam [31:0] ibex_pkg_PMP_MAX_REGIONS = 16;
	reg [31:0] pmp_addr_rdata [0:15];
	// Trace: core/rtl/ibex_cs_registers.sv:233:3
	localparam [31:0] ibex_pkg_PMP_CFG_W = 8;
	wire [7:0] pmp_cfg_rdata [0:15];
	// Trace: core/rtl/ibex_cs_registers.sv:234:3
	wire pmp_csr_err;
	// Trace: core/rtl/ibex_cs_registers.sv:237:3
	wire [31:0] mcountinhibit;
	// Trace: core/rtl/ibex_cs_registers.sv:239:3
	reg [MHPMCounterNum + 2:0] mcountinhibit_d;
	reg [MHPMCounterNum + 2:0] mcountinhibit_q;
	// Trace: core/rtl/ibex_cs_registers.sv:240:3
	reg mcountinhibit_we;
	// Trace: core/rtl/ibex_cs_registers.sv:245:3
	wire [63:0] mhpmcounter [0:31];
	// Trace: core/rtl/ibex_cs_registers.sv:246:3
	reg [31:0] mhpmcounter_we;
	// Trace: core/rtl/ibex_cs_registers.sv:247:3
	reg [31:0] mhpmcounterh_we;
	// Trace: core/rtl/ibex_cs_registers.sv:248:3
	reg [31:0] mhpmcounter_incr;
	// Trace: core/rtl/ibex_cs_registers.sv:249:3
	reg [31:0] mhpmevent [0:31];
	// Trace: core/rtl/ibex_cs_registers.sv:250:3
	wire [4:0] mhpmcounter_idx;
	// Trace: core/rtl/ibex_cs_registers.sv:251:3
	wire unused_mhpmcounter_we_1;
	// Trace: core/rtl/ibex_cs_registers.sv:252:3
	wire unused_mhpmcounterh_we_1;
	// Trace: core/rtl/ibex_cs_registers.sv:253:3
	wire unused_mhpmcounter_incr_1;
	// Trace: core/rtl/ibex_cs_registers.sv:256:3
	wire [31:0] tselect_rdata;
	// Trace: core/rtl/ibex_cs_registers.sv:257:3
	wire [31:0] tmatch_control_rdata;
	// Trace: core/rtl/ibex_cs_registers.sv:258:3
	wire [31:0] tmatch_value_rdata;
	// Trace: core/rtl/ibex_cs_registers.sv:261:3
	wire [5:0] cpuctrl_q;
	wire [5:0] cpuctrl_d;
	wire [5:0] cpuctrl_wdata;
	// Trace: core/rtl/ibex_cs_registers.sv:262:3
	reg cpuctrl_we;
	// Trace: core/rtl/ibex_cs_registers.sv:263:3
	wire cpuctrl_err;
	// Trace: core/rtl/ibex_cs_registers.sv:266:3
	reg [31:0] csr_wdata_int;
	// Trace: core/rtl/ibex_cs_registers.sv:267:3
	reg [31:0] csr_rdata_int;
	// Trace: core/rtl/ibex_cs_registers.sv:268:3
	wire csr_we_int;
	// Trace: core/rtl/ibex_cs_registers.sv:269:3
	wire csr_wreq;
	// Trace: core/rtl/ibex_cs_registers.sv:272:3
	reg illegal_csr;
	// Trace: core/rtl/ibex_cs_registers.sv:273:3
	wire illegal_csr_priv;
	// Trace: core/rtl/ibex_cs_registers.sv:274:3
	wire illegal_csr_write;
	// Trace: core/rtl/ibex_cs_registers.sv:276:3
	wire [7:0] unused_boot_addr;
	// Trace: core/rtl/ibex_cs_registers.sv:277:3
	wire [2:0] unused_csr_addr;
	// Trace: core/rtl/ibex_cs_registers.sv:279:3
	assign unused_boot_addr = boot_addr_i[7:0];
	// Trace: core/rtl/ibex_cs_registers.sv:285:3
	wire [11:0] csr_addr;
	// Trace: core/rtl/ibex_cs_registers.sv:286:3
	assign csr_addr = {csr_addr_i};
	// Trace: core/rtl/ibex_cs_registers.sv:287:3
	assign unused_csr_addr = csr_addr[7:5];
	// Trace: core/rtl/ibex_cs_registers.sv:288:3
	assign mhpmcounter_idx = csr_addr[4:0];
	// Trace: core/rtl/ibex_cs_registers.sv:291:3
	assign illegal_csr_priv = csr_addr[9:8] > {priv_lvl_q};
	// Trace: core/rtl/ibex_cs_registers.sv:292:3
	assign illegal_csr_write = (csr_addr[11:10] == 2'b11) && csr_wreq;
	// Trace: core/rtl/ibex_cs_registers.sv:293:3
	assign illegal_csr_insn_o = csr_access_i & ((illegal_csr | illegal_csr_write) | illegal_csr_priv);
	// Trace: core/rtl/ibex_cs_registers.sv:296:3
	assign mip[17] = irq_software_i;
	// Trace: core/rtl/ibex_cs_registers.sv:297:3
	assign mip[16] = irq_timer_i;
	// Trace: core/rtl/ibex_cs_registers.sv:298:3
	assign mip[15] = irq_external_i;
	// Trace: core/rtl/ibex_cs_registers.sv:299:3
	assign mip[14-:15] = irq_fast_i;
	// Trace: core/rtl/ibex_cs_registers.sv:302:3
	assign mipx = irq_x_i;
	// Trace: core/rtl/ibex_cs_registers.sv:305:3
	localparam [31:0] ibex_pkg_CSR_MEIX_BIT = 11;
	localparam [31:0] ibex_pkg_CSR_MFIX_BIT_HIGH = 30;
	localparam [31:0] ibex_pkg_CSR_MFIX_BIT_LOW = 16;
	localparam [31:0] ibex_pkg_CSR_MSIX_BIT = 3;
	localparam [31:0] ibex_pkg_CSR_MSTATUS_MIE_BIT = 3;
	localparam [31:0] ibex_pkg_CSR_MSTATUS_MPIE_BIT = 7;
	localparam [31:0] ibex_pkg_CSR_MSTATUS_MPP_BIT_HIGH = 12;
	localparam [31:0] ibex_pkg_CSR_MSTATUS_MPP_BIT_LOW = 11;
	localparam [31:0] ibex_pkg_CSR_MSTATUS_MPRV_BIT = 17;
	localparam [31:0] ibex_pkg_CSR_MSTATUS_TW_BIT = 21;
	localparam [31:0] ibex_pkg_CSR_MTIX_BIT = 7;
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_cs_registers.sv:306:5
		csr_rdata_int = 1'sb0;
		// Trace: core/rtl/ibex_cs_registers.sv:307:5
		illegal_csr = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:309:5
		(* full_case, parallel_case *)
		case (csr_addr_i)
			12'hf14:
				// Trace: core/rtl/ibex_cs_registers.sv:311:20
				csr_rdata_int = hart_id_i;
			12'h300: begin
				// Trace: core/rtl/ibex_cs_registers.sv:315:9
				csr_rdata_int = 1'sb0;
				// Trace: core/rtl/ibex_cs_registers.sv:316:9
				csr_rdata_int[ibex_pkg_CSR_MSTATUS_MIE_BIT] = mstatus_q[5];
				// Trace: core/rtl/ibex_cs_registers.sv:317:9
				csr_rdata_int[ibex_pkg_CSR_MSTATUS_MPIE_BIT] = mstatus_q[4];
				// Trace: core/rtl/ibex_cs_registers.sv:318:9
				csr_rdata_int[ibex_pkg_CSR_MSTATUS_MPP_BIT_HIGH:ibex_pkg_CSR_MSTATUS_MPP_BIT_LOW] = mstatus_q[3-:2];
				// Trace: core/rtl/ibex_cs_registers.sv:319:9
				csr_rdata_int[ibex_pkg_CSR_MSTATUS_MPRV_BIT] = mstatus_q[1];
				// Trace: core/rtl/ibex_cs_registers.sv:320:9
				csr_rdata_int[ibex_pkg_CSR_MSTATUS_TW_BIT] = mstatus_q[0];
			end
			12'h301:
				// Trace: core/rtl/ibex_cs_registers.sv:324:17
				csr_rdata_int = MISA_VALUE;
			12'h304: begin
				// Trace: core/rtl/ibex_cs_registers.sv:328:9
				csr_rdata_int = 1'sb0;
				// Trace: core/rtl/ibex_cs_registers.sv:329:9
				csr_rdata_int[ibex_pkg_CSR_MSIX_BIT] = mie_q[17];
				// Trace: core/rtl/ibex_cs_registers.sv:330:9
				csr_rdata_int[ibex_pkg_CSR_MTIX_BIT] = mie_q[16];
				// Trace: core/rtl/ibex_cs_registers.sv:331:9
				csr_rdata_int[ibex_pkg_CSR_MEIX_BIT] = mie_q[15];
				// Trace: core/rtl/ibex_cs_registers.sv:332:9
				csr_rdata_int[ibex_pkg_CSR_MFIX_BIT_HIGH:ibex_pkg_CSR_MFIX_BIT_LOW] = mie_q[14-:15];
			end
			12'h340:
				// Trace: core/rtl/ibex_cs_registers.sv:335:21
				csr_rdata_int = mscratch_q;
			12'h305:
				// Trace: core/rtl/ibex_cs_registers.sv:338:18
				csr_rdata_int = mtvec_q;
			12'h341:
				// Trace: core/rtl/ibex_cs_registers.sv:341:17
				csr_rdata_int = mepc_q;
			12'h342:
				// Trace: core/rtl/ibex_cs_registers.sv:344:19
				csr_rdata_int = {mcause_q[5], 26'b00000000000000000000000000, mcause_q[4:0]};
			12'h343:
				// Trace: core/rtl/ibex_cs_registers.sv:347:18
				csr_rdata_int = mtval_q;
			12'h344: begin
				// Trace: core/rtl/ibex_cs_registers.sv:351:9
				csr_rdata_int = 1'sb0;
				// Trace: core/rtl/ibex_cs_registers.sv:352:9
				csr_rdata_int[ibex_pkg_CSR_MSIX_BIT] = mip[17];
				// Trace: core/rtl/ibex_cs_registers.sv:353:9
				csr_rdata_int[ibex_pkg_CSR_MTIX_BIT] = mip[16];
				// Trace: core/rtl/ibex_cs_registers.sv:354:9
				csr_rdata_int[ibex_pkg_CSR_MEIX_BIT] = mip[15];
				// Trace: core/rtl/ibex_cs_registers.sv:355:9
				csr_rdata_int[ibex_pkg_CSR_MFIX_BIT_HIGH:ibex_pkg_CSR_MFIX_BIT_LOW] = mip[14-:15];
			end
			12'h3a0:
				// Trace: core/rtl/ibex_cs_registers.sv:359:22
				csr_rdata_int = {pmp_cfg_rdata[3], pmp_cfg_rdata[2], pmp_cfg_rdata[1], pmp_cfg_rdata[0]};
			12'h3a1:
				// Trace: core/rtl/ibex_cs_registers.sv:361:22
				csr_rdata_int = {pmp_cfg_rdata[7], pmp_cfg_rdata[6], pmp_cfg_rdata[5], pmp_cfg_rdata[4]};
			12'h3a2:
				// Trace: core/rtl/ibex_cs_registers.sv:363:22
				csr_rdata_int = {pmp_cfg_rdata[11], pmp_cfg_rdata[10], pmp_cfg_rdata[9], pmp_cfg_rdata[8]};
			12'h3a3:
				// Trace: core/rtl/ibex_cs_registers.sv:365:22
				csr_rdata_int = {pmp_cfg_rdata[15], pmp_cfg_rdata[14], pmp_cfg_rdata[13], pmp_cfg_rdata[12]};
			12'h3b0:
				// Trace: core/rtl/ibex_cs_registers.sv:367:22
				csr_rdata_int = pmp_addr_rdata[0];
			12'h3b1:
				// Trace: core/rtl/ibex_cs_registers.sv:368:22
				csr_rdata_int = pmp_addr_rdata[1];
			12'h3b2:
				// Trace: core/rtl/ibex_cs_registers.sv:369:22
				csr_rdata_int = pmp_addr_rdata[2];
			12'h3b3:
				// Trace: core/rtl/ibex_cs_registers.sv:370:22
				csr_rdata_int = pmp_addr_rdata[3];
			12'h3b4:
				// Trace: core/rtl/ibex_cs_registers.sv:371:22
				csr_rdata_int = pmp_addr_rdata[4];
			12'h3b5:
				// Trace: core/rtl/ibex_cs_registers.sv:372:22
				csr_rdata_int = pmp_addr_rdata[5];
			12'h3b6:
				// Trace: core/rtl/ibex_cs_registers.sv:373:22
				csr_rdata_int = pmp_addr_rdata[6];
			12'h3b7:
				// Trace: core/rtl/ibex_cs_registers.sv:374:22
				csr_rdata_int = pmp_addr_rdata[7];
			12'h3b8:
				// Trace: core/rtl/ibex_cs_registers.sv:375:22
				csr_rdata_int = pmp_addr_rdata[8];
			12'h3b9:
				// Trace: core/rtl/ibex_cs_registers.sv:376:22
				csr_rdata_int = pmp_addr_rdata[9];
			12'h3ba:
				// Trace: core/rtl/ibex_cs_registers.sv:377:22
				csr_rdata_int = pmp_addr_rdata[10];
			12'h3bb:
				// Trace: core/rtl/ibex_cs_registers.sv:378:22
				csr_rdata_int = pmp_addr_rdata[11];
			12'h3bc:
				// Trace: core/rtl/ibex_cs_registers.sv:379:22
				csr_rdata_int = pmp_addr_rdata[12];
			12'h3bd:
				// Trace: core/rtl/ibex_cs_registers.sv:380:22
				csr_rdata_int = pmp_addr_rdata[13];
			12'h3be:
				// Trace: core/rtl/ibex_cs_registers.sv:381:22
				csr_rdata_int = pmp_addr_rdata[14];
			12'h3bf:
				// Trace: core/rtl/ibex_cs_registers.sv:382:22
				csr_rdata_int = pmp_addr_rdata[15];
			12'h7b0: begin
				// Trace: core/rtl/ibex_cs_registers.sv:385:9
				csr_rdata_int = dcsr_q;
				// Trace: core/rtl/ibex_cs_registers.sv:386:9
				illegal_csr = ~debug_mode_i;
			end
			12'h7b1: begin
				// Trace: core/rtl/ibex_cs_registers.sv:389:9
				csr_rdata_int = depc_q;
				// Trace: core/rtl/ibex_cs_registers.sv:390:9
				illegal_csr = ~debug_mode_i;
			end
			12'h7b2: begin
				// Trace: core/rtl/ibex_cs_registers.sv:393:9
				csr_rdata_int = dscratch0_q;
				// Trace: core/rtl/ibex_cs_registers.sv:394:9
				illegal_csr = ~debug_mode_i;
			end
			12'h7b3: begin
				// Trace: core/rtl/ibex_cs_registers.sv:397:9
				csr_rdata_int = dscratch1_q;
				// Trace: core/rtl/ibex_cs_registers.sv:398:9
				illegal_csr = ~debug_mode_i;
			end
			12'h320:
				// Trace: core/rtl/ibex_cs_registers.sv:402:26
				csr_rdata_int = mcountinhibit;
			12'h323, 12'h324, 12'h325, 12'h326, 12'h327, 12'h328, 12'h329, 12'h32a, 12'h32b, 12'h32c, 12'h32d, 12'h32e, 12'h32f, 12'h330, 12'h331, 12'h332, 12'h333, 12'h334, 12'h335, 12'h336, 12'h337, 12'h338, 12'h339, 12'h33a, 12'h33b, 12'h33c, 12'h33d, 12'h33e, 12'h33f:
				// Trace: core/rtl/ibex_cs_registers.sv:411:9
				csr_rdata_int = mhpmevent[mhpmcounter_idx];
			12'hb00, 12'hb02, 12'hb03, 12'hb04, 12'hb05, 12'hb06, 12'hb07, 12'hb08, 12'hb09, 12'hb0a, 12'hb0b, 12'hb0c, 12'hb0d, 12'hb0e, 12'hb0f, 12'hb10, 12'hb11, 12'hb12, 12'hb13, 12'hb14, 12'hb15, 12'hb16, 12'hb17, 12'hb18, 12'hb19, 12'hb1a, 12'hb1b, 12'hb1c, 12'hb1d, 12'hb1e, 12'hb1f:
				// Trace: core/rtl/ibex_cs_registers.sv:424:9
				csr_rdata_int = mhpmcounter[mhpmcounter_idx][31:0];
			12'hb80, 12'hb82, 12'hb83, 12'hb84, 12'hb85, 12'hb86, 12'hb87, 12'hb88, 12'hb89, 12'hb8a, 12'hb8b, 12'hb8c, 12'hb8d, 12'hb8e, 12'hb8f, 12'hb90, 12'hb91, 12'hb92, 12'hb93, 12'hb94, 12'hb95, 12'hb96, 12'hb97, 12'hb98, 12'hb99, 12'hb9a, 12'hb9b, 12'hb9c, 12'hb9d, 12'hb9e, 12'hb9f:
				// Trace: core/rtl/ibex_cs_registers.sv:437:9
				csr_rdata_int = mhpmcounter[mhpmcounter_idx][63:32];
			12'h7a0: begin
				// Trace: core/rtl/ibex_cs_registers.sv:442:9
				csr_rdata_int = tselect_rdata;
				// Trace: core/rtl/ibex_cs_registers.sv:443:9
				illegal_csr = ~DbgTriggerEn;
			end
			12'h7a1: begin
				// Trace: core/rtl/ibex_cs_registers.sv:446:9
				csr_rdata_int = tmatch_control_rdata;
				// Trace: core/rtl/ibex_cs_registers.sv:447:9
				illegal_csr = ~DbgTriggerEn;
			end
			12'h7a2: begin
				// Trace: core/rtl/ibex_cs_registers.sv:450:9
				csr_rdata_int = tmatch_value_rdata;
				// Trace: core/rtl/ibex_cs_registers.sv:451:9
				illegal_csr = ~DbgTriggerEn;
			end
			12'h7a3: begin
				// Trace: core/rtl/ibex_cs_registers.sv:454:9
				csr_rdata_int = 1'sb0;
				// Trace: core/rtl/ibex_cs_registers.sv:455:9
				illegal_csr = ~DbgTriggerEn;
			end
			12'h7a8: begin
				// Trace: core/rtl/ibex_cs_registers.sv:458:9
				csr_rdata_int = 1'sb0;
				// Trace: core/rtl/ibex_cs_registers.sv:459:9
				illegal_csr = ~DbgTriggerEn;
			end
			12'h7aa: begin
				// Trace: core/rtl/ibex_cs_registers.sv:462:9
				csr_rdata_int = 1'sb0;
				// Trace: core/rtl/ibex_cs_registers.sv:463:9
				illegal_csr = ~DbgTriggerEn;
			end
			12'h7c0:
				// Trace: core/rtl/ibex_cs_registers.sv:468:9
				csr_rdata_int = {{26 {1'b0}}, cpuctrl_q};
			12'h7c1:
				// Trace: core/rtl/ibex_cs_registers.sv:473:9
				csr_rdata_int = 1'sb0;
			12'h7d0:
				// Trace: core/rtl/ibex_cs_registers.sv:477:19
				csr_rdata_int = miex_q;
			12'h7d2:
				// Trace: core/rtl/ibex_cs_registers.sv:478:19
				csr_rdata_int = mipx;
			12'h7d1:
				// Trace: core/rtl/ibex_cs_registers.sv:479:19
				csr_rdata_int = mtvecx_q;
			default:
				// Trace: core/rtl/ibex_cs_registers.sv:482:9
				illegal_csr = 1'b1;
		endcase
	end
	// Trace: core/rtl/ibex_cs_registers.sv:488:3
	function automatic [1:0] sv2v_cast_2;
		input reg [1:0] inp;
		sv2v_cast_2 = inp;
	endfunction
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_cs_registers.sv:489:5
		exception_pc = pc_id_i;
		// Trace: core/rtl/ibex_cs_registers.sv:491:5
		priv_lvl_d = priv_lvl_q;
		// Trace: core/rtl/ibex_cs_registers.sv:492:5
		mstatus_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:493:5
		mstatus_d = mstatus_q;
		// Trace: core/rtl/ibex_cs_registers.sv:494:5
		mie_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:495:5
		mscratch_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:496:5
		mepc_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:497:5
		mepc_d = {csr_wdata_int[31:1], 1'b0};
		// Trace: core/rtl/ibex_cs_registers.sv:498:5
		mcause_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:499:5
		mcause_d = {csr_wdata_int[31], csr_wdata_int[4:0]};
		// Trace: core/rtl/ibex_cs_registers.sv:500:5
		mtval_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:501:5
		mtval_d = csr_wdata_int;
		// Trace: core/rtl/ibex_cs_registers.sv:502:5
		mtvec_en = csr_mtvec_init_i;
		// Trace: core/rtl/ibex_cs_registers.sv:505:5
		mtvec_d = (csr_mtvec_init_i ? {boot_addr_i[31:8], 8'b00000001} : {csr_wdata_int[31:8], 8'b00000001});
		// Trace: core/rtl/ibex_cs_registers.sv:507:5
		dcsr_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:508:5
		dcsr_d = dcsr_q;
		// Trace: core/rtl/ibex_cs_registers.sv:509:5
		depc_d = {csr_wdata_int[31:1], 1'b0};
		// Trace: core/rtl/ibex_cs_registers.sv:510:5
		depc_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:511:5
		dscratch0_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:512:5
		dscratch1_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:514:5
		mstack_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:515:5
		mstack_d[2] = mstatus_q[4];
		// Trace: core/rtl/ibex_cs_registers.sv:516:5
		mstack_d[1-:2] = mstatus_q[3-:2];
		// Trace: core/rtl/ibex_cs_registers.sv:517:5
		mstack_epc_d = mepc_q;
		// Trace: core/rtl/ibex_cs_registers.sv:518:5
		mstack_cause_d = mcause_q;
		// Trace: core/rtl/ibex_cs_registers.sv:520:5
		mcountinhibit_we = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:521:5
		mhpmcounter_we = 1'sb0;
		// Trace: core/rtl/ibex_cs_registers.sv:522:5
		mhpmcounterh_we = 1'sb0;
		// Trace: core/rtl/ibex_cs_registers.sv:524:5
		cpuctrl_we = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:526:5
		miex_en = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:527:5
		mtvecx_en = csr_mtvec_init_i;
		// Trace: core/rtl/ibex_cs_registers.sv:530:5
		mtvecx_d = (csr_mtvec_init_i ? {boot_addr_i[31:8], 8'b00000001} : {csr_wdata_int[31:8], 8'b00000001});
		// Trace: core/rtl/ibex_cs_registers.sv:533:5
		if (csr_we_int)
			// Trace: core/rtl/ibex_cs_registers.sv:534:7
			(* full_case, parallel_case *)
			case (csr_addr_i)
				12'h300: begin
					// Trace: core/rtl/ibex_cs_registers.sv:537:11
					mstatus_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:538:11
					mstatus_d = {csr_wdata_int[ibex_pkg_CSR_MSTATUS_MIE_BIT], csr_wdata_int[ibex_pkg_CSR_MSTATUS_MPIE_BIT], sv2v_cast_2(csr_wdata_int[ibex_pkg_CSR_MSTATUS_MPP_BIT_HIGH:ibex_pkg_CSR_MSTATUS_MPP_BIT_LOW]), csr_wdata_int[ibex_pkg_CSR_MSTATUS_MPRV_BIT], csr_wdata_int[ibex_pkg_CSR_MSTATUS_TW_BIT]};
					// Trace: core/rtl/ibex_cs_registers.sv:546:11
					if ((mstatus_d[3-:2] != 2'b11) && (mstatus_d[3-:2] != 2'b00))
						// Trace: core/rtl/ibex_cs_registers.sv:547:13
						mstatus_d[3-:2] = 2'b11;
				end
				12'h304:
					// Trace: core/rtl/ibex_cs_registers.sv:552:18
					mie_en = 1'b1;
				12'h340:
					// Trace: core/rtl/ibex_cs_registers.sv:554:23
					mscratch_en = 1'b1;
				12'h341:
					// Trace: core/rtl/ibex_cs_registers.sv:557:19
					mepc_en = 1'b1;
				12'h342:
					// Trace: core/rtl/ibex_cs_registers.sv:560:21
					mcause_en = 1'b1;
				12'h343:
					// Trace: core/rtl/ibex_cs_registers.sv:563:20
					mtval_en = 1'b1;
				12'h305:
					// Trace: core/rtl/ibex_cs_registers.sv:566:20
					mtvec_en = 1'b1;
				12'h7b0: begin
					// Trace: core/rtl/ibex_cs_registers.sv:569:11
					dcsr_d = csr_wdata_int;
					// Trace: core/rtl/ibex_cs_registers.sv:570:11
					dcsr_d[31-:4] = 4'd4;
					// Trace: core/rtl/ibex_cs_registers.sv:572:11
					if ((dcsr_d[1-:2] != 2'b11) && (dcsr_d[1-:2] != 2'b00))
						// Trace: core/rtl/ibex_cs_registers.sv:573:13
						dcsr_d[1-:2] = 2'b11;
					// Trace: core/rtl/ibex_cs_registers.sv:577:11
					dcsr_d[8-:3] = dcsr_q[8-:3];
					// Trace: core/rtl/ibex_cs_registers.sv:580:11
					dcsr_d[3] = 1'b0;
					// Trace: core/rtl/ibex_cs_registers.sv:581:11
					dcsr_d[4] = 1'b0;
					// Trace: core/rtl/ibex_cs_registers.sv:582:11
					dcsr_d[10] = 1'b0;
					// Trace: core/rtl/ibex_cs_registers.sv:583:11
					dcsr_d[9] = 1'b0;
					// Trace: core/rtl/ibex_cs_registers.sv:586:11
					dcsr_d[5] = 1'b0;
					// Trace: core/rtl/ibex_cs_registers.sv:587:11
					dcsr_d[14] = 1'b0;
					// Trace: core/rtl/ibex_cs_registers.sv:588:11
					dcsr_d[27-:12] = 12'h000;
					// Trace: core/rtl/ibex_cs_registers.sv:589:11
					dcsr_en = 1'b1;
				end
				12'h7b1:
					// Trace: core/rtl/ibex_cs_registers.sv:593:18
					depc_en = 1'b1;
				12'h7b2:
					// Trace: core/rtl/ibex_cs_registers.sv:595:24
					dscratch0_en = 1'b1;
				12'h7b3:
					// Trace: core/rtl/ibex_cs_registers.sv:596:24
					dscratch1_en = 1'b1;
				12'h320:
					// Trace: core/rtl/ibex_cs_registers.sv:599:28
					mcountinhibit_we = 1'b1;
				12'hb00, 12'hb02, 12'hb03, 12'hb04, 12'hb05, 12'hb06, 12'hb07, 12'hb08, 12'hb09, 12'hb0a, 12'hb0b, 12'hb0c, 12'hb0d, 12'hb0e, 12'hb0f, 12'hb10, 12'hb11, 12'hb12, 12'hb13, 12'hb14, 12'hb15, 12'hb16, 12'hb17, 12'hb18, 12'hb19, 12'hb1a, 12'hb1b, 12'hb1c, 12'hb1d, 12'hb1e, 12'hb1f:
					// Trace: core/rtl/ibex_cs_registers.sv:611:11
					mhpmcounter_we[mhpmcounter_idx] = 1'b1;
				12'hb80, 12'hb82, 12'hb83, 12'hb84, 12'hb85, 12'hb86, 12'hb87, 12'hb88, 12'hb89, 12'hb8a, 12'hb8b, 12'hb8c, 12'hb8d, 12'hb8e, 12'hb8f, 12'hb90, 12'hb91, 12'hb92, 12'hb93, 12'hb94, 12'hb95, 12'hb96, 12'hb97, 12'hb98, 12'hb99, 12'hb9a, 12'hb9b, 12'hb9c, 12'hb9d, 12'hb9e, 12'hb9f:
					// Trace: core/rtl/ibex_cs_registers.sv:624:11
					mhpmcounterh_we[mhpmcounter_idx] = 1'b1;
				12'h7c0:
					// Trace: core/rtl/ibex_cs_registers.sv:627:22
					cpuctrl_we = 1'b1;
				12'h7d0:
					// Trace: core/rtl/ibex_cs_registers.sv:630:19
					miex_en = 1'b1;
				12'h7d1:
					// Trace: core/rtl/ibex_cs_registers.sv:631:21
					mtvecx_en = 1'b1;
				default:
					;
			endcase
		(* full_case, parallel_case *)
		case (1'b1)
			csr_save_cause_i: begin
				// Trace: core/rtl/ibex_cs_registers.sv:641:9
				(* full_case, parallel_case *)
				case (1'b1)
					csr_save_if_i:
						// Trace: core/rtl/ibex_cs_registers.sv:643:13
						exception_pc = pc_if_i;
					csr_save_id_i:
						// Trace: core/rtl/ibex_cs_registers.sv:646:13
						exception_pc = pc_id_i;
					csr_save_wb_i:
						// Trace: core/rtl/ibex_cs_registers.sv:649:13
						exception_pc = pc_wb_i;
					default:
						;
				endcase
				// Trace: core/rtl/ibex_cs_registers.sv:655:9
				priv_lvl_d = 2'b11;
				if (debug_csr_save_i) begin
					// Trace: core/rtl/ibex_cs_registers.sv:660:11
					dcsr_d[1-:2] = priv_lvl_q;
					// Trace: core/rtl/ibex_cs_registers.sv:661:11
					dcsr_d[8-:3] = debug_cause_i;
					// Trace: core/rtl/ibex_cs_registers.sv:662:11
					dcsr_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:663:11
					depc_d = exception_pc;
					// Trace: core/rtl/ibex_cs_registers.sv:664:11
					depc_en = 1'b1;
				end
				else if (!debug_mode_i) begin
					// Trace: core/rtl/ibex_cs_registers.sv:668:11
					mtval_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:669:11
					mtval_d = csr_mtval_i;
					// Trace: core/rtl/ibex_cs_registers.sv:670:11
					mstatus_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:671:11
					mstatus_d[5] = 1'b0;
					// Trace: core/rtl/ibex_cs_registers.sv:673:11
					mstatus_d[4] = mstatus_q[5];
					// Trace: core/rtl/ibex_cs_registers.sv:674:11
					mstatus_d[3-:2] = priv_lvl_q;
					// Trace: core/rtl/ibex_cs_registers.sv:675:11
					mepc_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:676:11
					mepc_d = exception_pc;
					// Trace: core/rtl/ibex_cs_registers.sv:677:11
					mcause_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:678:11
					mcause_d = {csr_mcause_i};
					// Trace: core/rtl/ibex_cs_registers.sv:680:11
					mstack_en = 1'b1;
				end
			end
			csr_restore_dret_i:
				// Trace: core/rtl/ibex_cs_registers.sv:685:9
				priv_lvl_d = dcsr_q[1-:2];
			csr_restore_mret_i: begin
				// Trace: core/rtl/ibex_cs_registers.sv:689:9
				priv_lvl_d = mstatus_q[3-:2];
				// Trace: core/rtl/ibex_cs_registers.sv:690:9
				mstatus_en = 1'b1;
				// Trace: core/rtl/ibex_cs_registers.sv:691:9
				mstatus_d[5] = mstatus_q[4];
				// Trace: core/rtl/ibex_cs_registers.sv:693:9
				if (nmi_mode_i) begin
					// Trace: core/rtl/ibex_cs_registers.sv:695:11
					mstatus_d[4] = mstack_q[2];
					// Trace: core/rtl/ibex_cs_registers.sv:696:11
					mstatus_d[3-:2] = mstack_q[1-:2];
					// Trace: core/rtl/ibex_cs_registers.sv:697:11
					mepc_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:698:11
					mepc_d = mstack_epc_q;
					// Trace: core/rtl/ibex_cs_registers.sv:699:11
					mcause_en = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:700:11
					mcause_d = mstack_cause_q;
				end
				else begin
					// Trace: core/rtl/ibex_cs_registers.sv:704:11
					mstatus_d[4] = 1'b1;
					// Trace: core/rtl/ibex_cs_registers.sv:705:11
					mstatus_d[3-:2] = 2'b00;
				end
			end
			default:
				;
		endcase
	end
	// Trace: core/rtl/ibex_cs_registers.sv:714:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_cs_registers.sv:715:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_cs_registers.sv:716:7
			priv_lvl_q <= 2'b11;
		else
			// Trace: core/rtl/ibex_cs_registers.sv:718:7
			priv_lvl_q <= priv_lvl_d;
	// Trace: core/rtl/ibex_cs_registers.sv:723:3
	assign priv_mode_id_o = priv_lvl_q;
	// Trace: core/rtl/ibex_cs_registers.sv:725:3
	assign priv_mode_if_o = priv_lvl_d;
	// Trace: core/rtl/ibex_cs_registers.sv:727:3
	assign priv_mode_lsu_o = (mstatus_q[1] ? mstatus_q[3-:2] : priv_lvl_q);
	// Trace: core/rtl/ibex_cs_registers.sv:730:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_cs_registers.sv:731:5
		(* full_case, parallel_case *)
		case (csr_op_i)
			2'd1:
				// Trace: core/rtl/ibex_cs_registers.sv:732:21
				csr_wdata_int = csr_wdata_i;
			2'd2:
				// Trace: core/rtl/ibex_cs_registers.sv:733:21
				csr_wdata_int = csr_wdata_i | csr_rdata_o;
			2'd3:
				// Trace: core/rtl/ibex_cs_registers.sv:734:21
				csr_wdata_int = ~csr_wdata_i & csr_rdata_o;
			2'd0:
				// Trace: core/rtl/ibex_cs_registers.sv:735:21
				csr_wdata_int = csr_wdata_i;
			default:
				// Trace: core/rtl/ibex_cs_registers.sv:736:21
				csr_wdata_int = csr_wdata_i;
		endcase
	end
	// Trace: core/rtl/ibex_cs_registers.sv:740:3
	assign csr_wreq = csr_op_en_i & |{csr_op_i == 2'd1, csr_op_i == 2'd2, csr_op_i == 2'd3};
	// Trace: core/rtl/ibex_cs_registers.sv:746:3
	assign csr_we_int = csr_wreq & ~illegal_csr_insn_o;
	// Trace: core/rtl/ibex_cs_registers.sv:748:3
	assign csr_rdata_o = csr_rdata_int;
	// Trace: core/rtl/ibex_cs_registers.sv:751:3
	assign csr_mepc_o = mepc_q;
	// Trace: core/rtl/ibex_cs_registers.sv:752:3
	assign csr_depc_o = depc_q;
	// Trace: core/rtl/ibex_cs_registers.sv:753:3
	assign csr_mtvec_o = mtvec_q;
	// Trace: core/rtl/ibex_cs_registers.sv:755:3
	assign csr_mstatus_mie_o = mstatus_q[5];
	// Trace: core/rtl/ibex_cs_registers.sv:756:3
	assign csr_mstatus_tw_o = mstatus_q[0];
	// Trace: core/rtl/ibex_cs_registers.sv:757:3
	assign debug_single_step_o = dcsr_q[2];
	// Trace: core/rtl/ibex_cs_registers.sv:758:3
	assign debug_ebreakm_o = dcsr_q[15];
	// Trace: core/rtl/ibex_cs_registers.sv:759:3
	assign debug_ebreaku_o = dcsr_q[12];
	// Trace: core/rtl/ibex_cs_registers.sv:763:3
	assign irqs_o = mip & mie_q;
	// Trace: core/rtl/ibex_cs_registers.sv:764:3
	assign irq_pending_o = |irqs_o | (|irqs_x_o);
	// Trace: core/rtl/ibex_cs_registers.sv:768:3
	assign irqs_x_o = mipx & miex_q;
	// Trace: core/rtl/ibex_cs_registers.sv:771:3
	assign csr_mtvecx_o = mtvecx_q;
	// Trace: core/rtl/ibex_cs_registers.sv:778:3
	localparam [5:0] MSTATUS_RST_VAL = 6'b010000;
	// Trace: core/rtl/ibex_cs_registers.sv:783:3
	ibex_csr #(
		.Width(6),
		.ShadowCopy(ShadowCSR),
		.ResetValue({MSTATUS_RST_VAL})
	) u_mstatus_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i({mstatus_d}),
		.wr_en_i(mstatus_en),
		.rd_data_o(mstatus_q),
		.rd_error_o(mstatus_err)
	);
	// Trace: core/rtl/ibex_cs_registers.sv:797:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_mepc_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(mepc_d),
		.wr_en_i(mepc_en),
		.rd_data_o(mepc_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:811:3
	assign mie_d[17] = csr_wdata_int[ibex_pkg_CSR_MSIX_BIT];
	// Trace: core/rtl/ibex_cs_registers.sv:812:3
	assign mie_d[16] = csr_wdata_int[ibex_pkg_CSR_MTIX_BIT];
	// Trace: core/rtl/ibex_cs_registers.sv:813:3
	assign mie_d[15] = csr_wdata_int[ibex_pkg_CSR_MEIX_BIT];
	// Trace: core/rtl/ibex_cs_registers.sv:814:3
	assign mie_d[14-:15] = csr_wdata_int[ibex_pkg_CSR_MFIX_BIT_HIGH:ibex_pkg_CSR_MFIX_BIT_LOW];
	// Trace: core/rtl/ibex_cs_registers.sv:815:3
	ibex_csr #(
		.Width(18),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_mie_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i({mie_d}),
		.wr_en_i(mie_en),
		.rd_data_o(mie_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:829:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_mscratch_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(csr_wdata_int),
		.wr_en_i(mscratch_en),
		.rd_data_o(mscratch_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:843:3
	ibex_csr #(
		.Width(6),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_mcause_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(mcause_d),
		.wr_en_i(mcause_en),
		.rd_data_o(mcause_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:857:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_mtval_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(mtval_d),
		.wr_en_i(mtval_en),
		.rd_data_o(mtval_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:871:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(ShadowCSR),
		.ResetValue(32'd1)
	) u_mtvec_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(mtvec_d),
		.wr_en_i(mtvec_en),
		.rd_data_o(mtvec_q),
		.rd_error_o(mtvec_err)
	);
	// Trace: core/rtl/ibex_cs_registers.sv:885:3
	localparam [31:0] DCSR_RESET_VAL = 32'h40000003;
	// Trace: core/rtl/ibex_cs_registers.sv:891:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue({DCSR_RESET_VAL})
	) u_dcsr_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i({dcsr_d}),
		.wr_en_i(dcsr_en),
		.rd_data_o(dcsr_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:905:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_depc_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(depc_d),
		.wr_en_i(depc_en),
		.rd_data_o(depc_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:919:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_dscratch0_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(csr_wdata_int),
		.wr_en_i(dscratch0_en),
		.rd_data_o(dscratch0_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:933:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_dscratch1_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(csr_wdata_int),
		.wr_en_i(dscratch1_en),
		.rd_data_o(dscratch1_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:947:3
	localparam [2:0] MSTACK_RESET_VAL = 3'b100;
	// Trace: core/rtl/ibex_cs_registers.sv:951:3
	ibex_csr #(
		.Width(3),
		.ShadowCopy(1'b0),
		.ResetValue({MSTACK_RESET_VAL})
	) u_mstack_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i({mstack_d}),
		.wr_en_i(mstack_en),
		.rd_data_o(mstack_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:965:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_mstack_epc_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(mstack_epc_d),
		.wr_en_i(mstack_en),
		.rd_data_o(mstack_epc_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:979:3
	ibex_csr #(
		.Width(6),
		.ShadowCopy(1'b0),
		.ResetValue(1'sb0)
	) u_mstack_cause_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(mstack_cause_d),
		.wr_en_i(mstack_en),
		.rd_data_o(mstack_cause_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:996:3
	localparam [11:0] ibex_pkg_CSR_OFF_PMP_ADDR = 12'h3b0;
	localparam [11:0] ibex_pkg_CSR_OFF_PMP_CFG = 12'h3a0;
	generate
		if (PMPEnable) begin : g_pmp_registers
			// Trace: core/rtl/ibex_cs_registers.sv:997:5
			wire [5:0] pmp_cfg [0:PMPNumRegions - 1];
			// Trace: core/rtl/ibex_cs_registers.sv:998:5
			reg [5:0] pmp_cfg_wdata [0:PMPNumRegions - 1];
			// Trace: core/rtl/ibex_cs_registers.sv:999:5
			wire [PMPAddrWidth - 1:0] pmp_addr [0:PMPNumRegions - 1];
			// Trace: core/rtl/ibex_cs_registers.sv:1000:5
			wire [PMPNumRegions - 1:0] pmp_cfg_we;
			// Trace: core/rtl/ibex_cs_registers.sv:1001:5
			wire [PMPNumRegions - 1:0] pmp_cfg_err;
			// Trace: core/rtl/ibex_cs_registers.sv:1002:5
			wire [PMPNumRegions - 1:0] pmp_addr_we;
			// Trace: core/rtl/ibex_cs_registers.sv:1003:5
			wire [PMPNumRegions - 1:0] pmp_addr_err;
			genvar _gv_i_1;
			for (_gv_i_1 = 0; _gv_i_1 < ibex_pkg_PMP_MAX_REGIONS; _gv_i_1 = _gv_i_1 + 1) begin : g_exp_rd_data
				localparam i = _gv_i_1;
				if (i < PMPNumRegions) begin : g_implemented_regions
					// Trace: core/rtl/ibex_cs_registers.sv:1009:9
					assign pmp_cfg_rdata[i] = {pmp_cfg[i][5], 2'b00, pmp_cfg[i][4-:2], pmp_cfg[i][2], pmp_cfg[i][1], pmp_cfg[i][0]};
					if (PMPGranularity == 0) begin : g_pmp_g0
						// Trace: core/rtl/ibex_cs_registers.sv:1016:11
						wire [32:1] sv2v_tmp_2683A;
						assign sv2v_tmp_2683A = pmp_addr[i];
						always @(*) pmp_addr_rdata[i] = sv2v_tmp_2683A;
					end
					else if (PMPGranularity == 1) begin : g_pmp_g1
						// Trace: core/rtl/ibex_cs_registers.sv:1020:11
						always @(*) begin
							if (_sv2v_0)
								;
							// Trace: core/rtl/ibex_cs_registers.sv:1021:13
							pmp_addr_rdata[i] = pmp_addr[i];
							// Trace: core/rtl/ibex_cs_registers.sv:1022:13
							if ((pmp_cfg[i][4-:2] == 2'b00) || (pmp_cfg[i][4-:2] == 2'b01))
								// Trace: core/rtl/ibex_cs_registers.sv:1023:15
								pmp_addr_rdata[i][PMPGranularity - 1:0] = 1'sb0;
						end
					end
					else begin : g_pmp_g2
						// Trace: core/rtl/ibex_cs_registers.sv:1029:11
						always @(*) begin
							if (_sv2v_0)
								;
							// Trace: core/rtl/ibex_cs_registers.sv:1031:13
							pmp_addr_rdata[i] = {pmp_addr[i], {PMPGranularity - 1 {1'b1}}};
							// Trace: core/rtl/ibex_cs_registers.sv:1033:13
							if ((pmp_cfg[i][4-:2] == 2'b00) || (pmp_cfg[i][4-:2] == 2'b01))
								// Trace: core/rtl/ibex_cs_registers.sv:1035:15
								pmp_addr_rdata[i][PMPGranularity - 1:0] = 1'sb0;
						end
					end
				end
				else begin : g_other_regions
					// Trace: core/rtl/ibex_cs_registers.sv:1042:9
					assign pmp_cfg_rdata[i] = 1'sb0;
					// Trace: core/rtl/ibex_cs_registers.sv:1043:9
					wire [32:1] sv2v_tmp_D50E5;
					assign sv2v_tmp_D50E5 = 1'sb0;
					always @(*) pmp_addr_rdata[i] = sv2v_tmp_D50E5;
				end
			end
			genvar _gv_i_2;
			for (_gv_i_2 = 0; _gv_i_2 < PMPNumRegions; _gv_i_2 = _gv_i_2 + 1) begin : g_pmp_csrs
				localparam i = _gv_i_2;
				// Trace: core/rtl/ibex_cs_registers.sv:1052:7
				assign pmp_cfg_we[i] = (csr_we_int & ~pmp_cfg[i][5]) & (csr_addr == (ibex_pkg_CSR_OFF_PMP_CFG + (i[11:0] >> 2)));
				// Trace: core/rtl/ibex_cs_registers.sv:1056:7
				wire [1:1] sv2v_tmp_8F287;
				assign sv2v_tmp_8F287 = csr_wdata_int[((i % 4) * ibex_pkg_PMP_CFG_W) + 7];
				always @(*) pmp_cfg_wdata[i][5] = sv2v_tmp_8F287;
				// Trace: core/rtl/ibex_cs_registers.sv:1058:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_cs_registers.sv:1059:9
					(* full_case, parallel_case *)
					case (csr_wdata_int[((i % 4) * ibex_pkg_PMP_CFG_W) + 3+:2])
						2'b00:
							// Trace: core/rtl/ibex_cs_registers.sv:1060:21
							pmp_cfg_wdata[i][4-:2] = 2'b00;
						2'b01:
							// Trace: core/rtl/ibex_cs_registers.sv:1061:21
							pmp_cfg_wdata[i][4-:2] = 2'b01;
						2'b10:
							// Trace: core/rtl/ibex_cs_registers.sv:1062:21
							pmp_cfg_wdata[i][4-:2] = (PMPGranularity == 0 ? 2'b10 : 2'b00);
						2'b11:
							// Trace: core/rtl/ibex_cs_registers.sv:1064:21
							pmp_cfg_wdata[i][4-:2] = 2'b11;
						default:
							// Trace: core/rtl/ibex_cs_registers.sv:1065:21
							pmp_cfg_wdata[i][4-:2] = 2'b00;
					endcase
				end
				// Trace: core/rtl/ibex_cs_registers.sv:1068:7
				wire [1:1] sv2v_tmp_45785;
				assign sv2v_tmp_45785 = csr_wdata_int[((i % 4) * ibex_pkg_PMP_CFG_W) + 2];
				always @(*) pmp_cfg_wdata[i][2] = sv2v_tmp_45785;
				// Trace: core/rtl/ibex_cs_registers.sv:1070:7
				wire [1:1] sv2v_tmp_1EAC9;
				assign sv2v_tmp_1EAC9 = &csr_wdata_int[(i % 4) * ibex_pkg_PMP_CFG_W+:2];
				always @(*) pmp_cfg_wdata[i][1] = sv2v_tmp_1EAC9;
				// Trace: core/rtl/ibex_cs_registers.sv:1071:7
				wire [1:1] sv2v_tmp_F1349;
				assign sv2v_tmp_F1349 = csr_wdata_int[(i % 4) * ibex_pkg_PMP_CFG_W];
				always @(*) pmp_cfg_wdata[i][0] = sv2v_tmp_F1349;
				// Trace: core/rtl/ibex_cs_registers.sv:1073:7
				ibex_csr #(
					.Width(6),
					.ShadowCopy(ShadowCSR),
					.ResetValue(1'sb0)
				) u_pmp_cfg_csr(
					.clk_i(clk_i),
					.rst_ni(rst_ni),
					.wr_data_i({pmp_cfg_wdata[i]}),
					.wr_en_i(pmp_cfg_we[i]),
					.rd_data_o(pmp_cfg[i]),
					.rd_error_o(pmp_cfg_err[i])
				);
				if (i < (PMPNumRegions - 1)) begin : g_lower
					// Trace: core/rtl/ibex_cs_registers.sv:1090:9
					assign pmp_addr_we[i] = ((csr_we_int & ~pmp_cfg[i][5]) & (~pmp_cfg[i + 1][5] | (pmp_cfg[i + 1][4-:2] != 2'b01))) & (csr_addr == (ibex_pkg_CSR_OFF_PMP_ADDR + i[11:0]));
				end
				else begin : g_upper
					// Trace: core/rtl/ibex_cs_registers.sv:1094:9
					assign pmp_addr_we[i] = (csr_we_int & ~pmp_cfg[i][5]) & (csr_addr == (ibex_pkg_CSR_OFF_PMP_ADDR + i[11:0]));
				end
				// Trace: core/rtl/ibex_cs_registers.sv:1098:7
				ibex_csr #(
					.Width(PMPAddrWidth),
					.ShadowCopy(ShadowCSR),
					.ResetValue(1'sb0)
				) u_pmp_addr_csr(
					.clk_i(clk_i),
					.rst_ni(rst_ni),
					.wr_data_i(csr_wdata_int[31-:PMPAddrWidth]),
					.wr_en_i(pmp_addr_we[i]),
					.rd_data_o(pmp_addr[i]),
					.rd_error_o(pmp_addr_err[i])
				);
				// Trace: core/rtl/ibex_cs_registers.sv:1111:7
				assign csr_pmp_cfg_o[((PMPNumRegions - 1) - i) * 6+:6] = pmp_cfg[i];
				// Trace: core/rtl/ibex_cs_registers.sv:1112:7
				assign csr_pmp_addr_o[((PMPNumRegions - 1) - i) * 34+:34] = {pmp_addr_rdata[i], 2'b00};
			end
			// Trace: core/rtl/ibex_cs_registers.sv:1115:5
			assign pmp_csr_err = |pmp_cfg_err | (|pmp_addr_err);
		end
		else begin : g_no_pmp_tieoffs
			genvar _gv_i_3;
			for (_gv_i_3 = 0; _gv_i_3 < ibex_pkg_PMP_MAX_REGIONS; _gv_i_3 = _gv_i_3 + 1) begin : g_rdata
				localparam i = _gv_i_3;
				// Trace: core/rtl/ibex_cs_registers.sv:1120:7
				wire [32:1] sv2v_tmp_D50E5;
				assign sv2v_tmp_D50E5 = 1'sb0;
				always @(*) pmp_addr_rdata[i] = sv2v_tmp_D50E5;
				// Trace: core/rtl/ibex_cs_registers.sv:1121:7
				assign pmp_cfg_rdata[i] = 1'sb0;
			end
			genvar _gv_i_4;
			for (_gv_i_4 = 0; _gv_i_4 < PMPNumRegions; _gv_i_4 = _gv_i_4 + 1) begin : g_outputs
				localparam i = _gv_i_4;
				// Trace: core/rtl/ibex_cs_registers.sv:1124:7
				assign csr_pmp_cfg_o[((PMPNumRegions - 1) - i) * 6+:6] = 6'b000000;
				// Trace: core/rtl/ibex_cs_registers.sv:1125:7
				assign csr_pmp_addr_o[((PMPNumRegions - 1) - i) * 34+:34] = 1'sb0;
			end
			// Trace: core/rtl/ibex_cs_registers.sv:1127:5
			assign pmp_csr_err = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_cs_registers.sv:1135:3
	always @(*) begin : mcountinhibit_update
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_cs_registers.sv:1136:5
		if (mcountinhibit_we == 1'b1)
			// Trace: core/rtl/ibex_cs_registers.sv:1138:7
			mcountinhibit_d = {csr_wdata_int[MHPMCounterNum + 2:2], 1'b0, csr_wdata_int[0]};
		else
			// Trace: core/rtl/ibex_cs_registers.sv:1140:7
			mcountinhibit_d = mcountinhibit_q;
	end
	// Trace: core/rtl/ibex_cs_registers.sv:1145:3
	always @(*) begin : gen_mhpmcounter_incr
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_cs_registers.sv:1148:5
		begin : sv2v_autoblock_1
			// Trace: core/rtl/ibex_cs_registers.sv:1148:10
			reg [31:0] i;
			// Trace: core/rtl/ibex_cs_registers.sv:1148:10
			for (i = 0; i < 32; i = i + 1)
				begin : gen_mhpmcounter_incr_inactive
					// Trace: core/rtl/ibex_cs_registers.sv:1149:7
					mhpmcounter_incr[i] = 1'b0;
				end
		end
		// Trace: core/rtl/ibex_cs_registers.sv:1157:5
		mhpmcounter_incr[0] = 1'b1;
		// Trace: core/rtl/ibex_cs_registers.sv:1158:5
		mhpmcounter_incr[1] = 1'b0;
		// Trace: core/rtl/ibex_cs_registers.sv:1159:5
		mhpmcounter_incr[2] = instr_ret_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1160:5
		mhpmcounter_incr[3] = dside_wait_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1161:5
		mhpmcounter_incr[4] = iside_wait_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1162:5
		mhpmcounter_incr[5] = mem_load_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1163:5
		mhpmcounter_incr[6] = mem_store_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1164:5
		mhpmcounter_incr[7] = jump_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1165:5
		mhpmcounter_incr[8] = branch_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1166:5
		mhpmcounter_incr[9] = branch_taken_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1167:5
		mhpmcounter_incr[10] = instr_ret_compressed_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1168:5
		mhpmcounter_incr[11] = mul_wait_i;
		// Trace: core/rtl/ibex_cs_registers.sv:1169:5
		mhpmcounter_incr[12] = div_wait_i;
		begin : sv2v_autoblock_2
			// Trace: core/rtl/ibex_cs_registers.sv:1171:10
			reg [31:0] i;
			// Trace: core/rtl/ibex_cs_registers.sv:1171:10
			for (i = 0; i < 16; i = i + 1)
				begin : gen_mhpmcounter_incr_external
					// Trace: core/rtl/ibex_cs_registers.sv:1172:7
					mhpmcounter_incr[13 + i] = external_perf_i[i];
				end
		end
	end
	// Trace: core/rtl/ibex_cs_registers.sv:1177:3
	always @(*) begin : gen_mhpmevent
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_cs_registers.sv:1180:5
		begin : sv2v_autoblock_3
			// Trace: core/rtl/ibex_cs_registers.sv:1180:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_cs_registers.sv:1180:10
			for (i = 0; i < 32; i = i + 1)
				begin : gen_mhpmevent_active
					// Trace: core/rtl/ibex_cs_registers.sv:1181:7
					mhpmevent[i] = 1'sb0;
					// Trace: core/rtl/ibex_cs_registers.sv:1182:7
					mhpmevent[i][i] = 1'b1;
				end
		end
		// Trace: core/rtl/ibex_cs_registers.sv:1186:5
		mhpmevent[1] = 1'sb0;
		begin : sv2v_autoblock_4
			// Trace: core/rtl/ibex_cs_registers.sv:1187:10
			reg [31:0] i;
			// Trace: core/rtl/ibex_cs_registers.sv:1187:10
			for (i = 3 + MHPMCounterNum; i < 32; i = i + 1)
				begin : gen_mhpmevent_inactive
					// Trace: core/rtl/ibex_cs_registers.sv:1188:7
					mhpmevent[i] = 1'sb0;
				end
		end
	end
	// Trace: core/rtl/ibex_cs_registers.sv:1193:3
	ibex_counter #(.CounterWidth(64)) mcycle_counter_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.counter_inc_i(mhpmcounter_incr[0] & ~mcountinhibit[0]),
		.counterh_we_i(mhpmcounterh_we[0]),
		.counter_we_i(mhpmcounter_we[0]),
		.counter_val_i(csr_wdata_int),
		.counter_val_o(mhpmcounter[0])
	);
	// Trace: core/rtl/ibex_cs_registers.sv:1206:3
	ibex_counter #(.CounterWidth(64)) minstret_counter_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.counter_inc_i(mhpmcounter_incr[2] & ~mcountinhibit[2]),
		.counterh_we_i(mhpmcounterh_we[2]),
		.counter_we_i(mhpmcounter_we[2]),
		.counter_val_i(csr_wdata_int),
		.counter_val_o(mhpmcounter[2])
	);
	// Trace: core/rtl/ibex_cs_registers.sv:1219:3
	assign mhpmcounter[1] = 1'sb0;
	// Trace: core/rtl/ibex_cs_registers.sv:1220:3
	assign unused_mhpmcounter_we_1 = mhpmcounter_we[1];
	// Trace: core/rtl/ibex_cs_registers.sv:1221:3
	assign unused_mhpmcounterh_we_1 = mhpmcounterh_we[1];
	// Trace: core/rtl/ibex_cs_registers.sv:1222:3
	assign unused_mhpmcounter_incr_1 = mhpmcounter_incr[1];
	// Trace: core/rtl/ibex_cs_registers.sv:1224:3
	genvar _gv_cnt_1;
	generate
		for (_gv_cnt_1 = 0; _gv_cnt_1 < 29; _gv_cnt_1 = _gv_cnt_1 + 1) begin : gen_cntrs
			localparam cnt = _gv_cnt_1;
			if (cnt < MHPMCounterNum) begin : gen_imp
				// Trace: core/rtl/ibex_cs_registers.sv:1226:7
				ibex_counter #(.CounterWidth(MHPMCounterWidth)) mcounters_variable_i(
					.clk_i(clk_i),
					.rst_ni(rst_ni),
					.counter_inc_i(mhpmcounter_incr[cnt + 3] & ~mcountinhibit[cnt + 3]),
					.counterh_we_i(mhpmcounterh_we[cnt + 3]),
					.counter_we_i(mhpmcounter_we[cnt + 3]),
					.counter_val_i(csr_wdata_int),
					.counter_val_o(mhpmcounter[cnt + 3])
				);
			end
			else begin : gen_unimp
				// Trace: core/rtl/ibex_cs_registers.sv:1238:7
				assign mhpmcounter[cnt + 3] = 1'sb0;
			end
		end
	endgenerate
	// Trace: core/rtl/ibex_cs_registers.sv:1242:3
	generate
		if (MHPMCounterNum < 29) begin : g_mcountinhibit_reduced
			// Trace: core/rtl/ibex_cs_registers.sv:1243:5
			wire [(29 - MHPMCounterNum) - 1:0] unused_mhphcounter_we;
			// Trace: core/rtl/ibex_cs_registers.sv:1244:5
			wire [(29 - MHPMCounterNum) - 1:0] unused_mhphcounterh_we;
			// Trace: core/rtl/ibex_cs_registers.sv:1245:5
			wire [(29 - MHPMCounterNum) - 1:0] unused_mhphcounter_incr;
			// Trace: core/rtl/ibex_cs_registers.sv:1247:5
			assign mcountinhibit = {{29 - MHPMCounterNum {1'b1}}, mcountinhibit_q};
			// Trace: core/rtl/ibex_cs_registers.sv:1249:5
			assign unused_mhphcounter_we = mhpmcounter_we[31:MHPMCounterNum + 3];
			// Trace: core/rtl/ibex_cs_registers.sv:1250:5
			assign unused_mhphcounterh_we = mhpmcounterh_we[31:MHPMCounterNum + 3];
			// Trace: core/rtl/ibex_cs_registers.sv:1251:5
			assign unused_mhphcounter_incr = mhpmcounter_incr[31:MHPMCounterNum + 3];
		end
		else begin : g_mcountinhibit_full
			// Trace: core/rtl/ibex_cs_registers.sv:1253:5
			assign mcountinhibit = mcountinhibit_q;
		end
	endgenerate
	// Trace: core/rtl/ibex_cs_registers.sv:1256:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_cs_registers.sv:1257:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_cs_registers.sv:1258:7
			mcountinhibit_q <= 1'sb0;
		else
			// Trace: core/rtl/ibex_cs_registers.sv:1260:7
			mcountinhibit_q <= mcountinhibit_d;
	// Trace: core/rtl/ibex_cs_registers.sv:1268:3
	generate
		if (DbgTriggerEn) begin : gen_trigger_regs
			// Trace: core/rtl/ibex_cs_registers.sv:1269:5
			localparam [31:0] DbgHwNumLen = (DbgHwBreakNum > 1 ? $clog2(DbgHwBreakNum) : 1);
			// Trace: core/rtl/ibex_cs_registers.sv:1271:5
			wire [DbgHwNumLen - 1:0] tselect_d;
			wire [DbgHwNumLen - 1:0] tselect_q;
			// Trace: core/rtl/ibex_cs_registers.sv:1272:5
			wire tmatch_control_d;
			// Trace: core/rtl/ibex_cs_registers.sv:1273:5
			wire [DbgHwBreakNum - 1:0] tmatch_control_q;
			// Trace: core/rtl/ibex_cs_registers.sv:1274:5
			wire [31:0] tmatch_value_d;
			// Trace: core/rtl/ibex_cs_registers.sv:1275:5
			wire [31:0] tmatch_value_q [0:DbgHwBreakNum - 1];
			// Trace: core/rtl/ibex_cs_registers.sv:1277:5
			wire tselect_we;
			// Trace: core/rtl/ibex_cs_registers.sv:1278:5
			wire [DbgHwBreakNum - 1:0] tmatch_control_we;
			// Trace: core/rtl/ibex_cs_registers.sv:1279:5
			wire [DbgHwBreakNum - 1:0] tmatch_value_we;
			// Trace: core/rtl/ibex_cs_registers.sv:1281:5
			wire [DbgHwBreakNum - 1:0] trigger_match;
			// Trace: core/rtl/ibex_cs_registers.sv:1284:5
			assign tselect_we = (csr_we_int & debug_mode_i) & (csr_addr_i == 12'h7a0);
			genvar _gv_i_5;
			for (_gv_i_5 = 0; _gv_i_5 < DbgHwBreakNum; _gv_i_5 = _gv_i_5 + 1) begin : g_dbg_tmatch_we
				localparam i = _gv_i_5;
				// Trace: core/rtl/ibex_cs_registers.sv:1286:7
				assign tmatch_control_we[i] = (((i[DbgHwNumLen - 1:0] == tselect_q) & csr_we_int) & debug_mode_i) & (csr_addr_i == 12'h7a1);
				// Trace: core/rtl/ibex_cs_registers.sv:1288:7
				assign tmatch_value_we[i] = (((i[DbgHwNumLen - 1:0] == tselect_q) & csr_we_int) & debug_mode_i) & (csr_addr_i == 12'h7a2);
			end
			// Trace: core/rtl/ibex_cs_registers.sv:1294:5
			assign tselect_d = (csr_wdata_int < DbgHwBreakNum ? csr_wdata_int[DbgHwNumLen - 1:0] : DbgHwBreakNum - 1);
			// Trace: core/rtl/ibex_cs_registers.sv:1297:5
			assign tmatch_control_d = csr_wdata_int[2];
			// Trace: core/rtl/ibex_cs_registers.sv:1298:5
			assign tmatch_value_d = csr_wdata_int[31:0];
			// Trace: core/rtl/ibex_cs_registers.sv:1301:5
			ibex_csr #(
				.Width(DbgHwNumLen),
				.ShadowCopy(1'b0),
				.ResetValue(1'sb0)
			) u_tselect_csr(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.wr_data_i(tselect_d),
				.wr_en_i(tselect_we),
				.rd_data_o(tselect_q),
				.rd_error_o()
			);
			genvar _gv_i_6;
			for (_gv_i_6 = 0; _gv_i_6 < DbgHwBreakNum; _gv_i_6 = _gv_i_6 + 1) begin : g_dbg_tmatch_reg
				localparam i = _gv_i_6;
				// Trace: core/rtl/ibex_cs_registers.sv:1315:7
				ibex_csr #(
					.Width(1),
					.ShadowCopy(1'b0),
					.ResetValue(1'sb0)
				) u_tmatch_control_csr(
					.clk_i(clk_i),
					.rst_ni(rst_ni),
					.wr_data_i(tmatch_control_d),
					.wr_en_i(tmatch_control_we[i]),
					.rd_data_o(tmatch_control_q[i]),
					.rd_error_o()
				);
				// Trace: core/rtl/ibex_cs_registers.sv:1328:7
				ibex_csr #(
					.Width(32),
					.ShadowCopy(1'b0),
					.ResetValue(1'sb0)
				) u_tmatch_value_csr(
					.clk_i(clk_i),
					.rst_ni(rst_ni),
					.wr_data_i(tmatch_value_d),
					.wr_en_i(tmatch_value_we[i]),
					.rd_data_o(tmatch_value_q[i]),
					.rd_error_o()
				);
			end
			// Trace: core/rtl/ibex_cs_registers.sv:1344:5
			localparam [31:0] TSelectRdataPadlen = (DbgHwNumLen >= 32 ? 0 : 32 - DbgHwNumLen);
			// Trace: core/rtl/ibex_cs_registers.sv:1345:5
			assign tselect_rdata = {{TSelectRdataPadlen {1'b0}}, tselect_q};
			// Trace: core/rtl/ibex_cs_registers.sv:1348:5
			assign tmatch_control_rdata = {29'h05000209, tmatch_control_q[tselect_q], 2'b00};
			// Trace: core/rtl/ibex_cs_registers.sv:1366:5
			assign tmatch_value_rdata = tmatch_value_q[tselect_q];
			genvar _gv_i_7;
			for (_gv_i_7 = 0; _gv_i_7 < DbgHwBreakNum; _gv_i_7 = _gv_i_7 + 1) begin : g_dbg_trigger_match
				localparam i = _gv_i_7;
				// Trace: core/rtl/ibex_cs_registers.sv:1371:7
				assign trigger_match[i] = tmatch_control_q[i] & (pc_if_i[31:0] == tmatch_value_q[i]);
			end
			// Trace: core/rtl/ibex_cs_registers.sv:1373:5
			assign trigger_match_o = |trigger_match;
		end
		else begin : gen_no_trigger_regs
			// Trace: core/rtl/ibex_cs_registers.sv:1376:5
			assign tselect_rdata = 'b0;
			// Trace: core/rtl/ibex_cs_registers.sv:1377:5
			assign tmatch_control_rdata = 'b0;
			// Trace: core/rtl/ibex_cs_registers.sv:1378:5
			assign tmatch_value_rdata = 'b0;
			// Trace: core/rtl/ibex_cs_registers.sv:1379:5
			assign trigger_match_o = 'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_cs_registers.sv:1387:3
	assign cpuctrl_wdata = csr_wdata_int[5:0];
	// Trace: core/rtl/ibex_cs_registers.sv:1390:3
	generate
		if (DataIndTiming) begin : gen_dit
			// Trace: core/rtl/ibex_cs_registers.sv:1391:5
			assign cpuctrl_d[1] = cpuctrl_wdata[1];
		end
		else begin : gen_no_dit
			// Trace: core/rtl/ibex_cs_registers.sv:1395:5
			wire unused_dit;
			// Trace: core/rtl/ibex_cs_registers.sv:1396:5
			assign unused_dit = cpuctrl_wdata[1];
			// Trace: core/rtl/ibex_cs_registers.sv:1399:5
			assign cpuctrl_d[1] = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_cs_registers.sv:1402:3
	assign data_ind_timing_o = cpuctrl_q[1];
	// Trace: core/rtl/ibex_cs_registers.sv:1405:3
	generate
		if (DummyInstructions) begin : gen_dummy
			// Trace: core/rtl/ibex_cs_registers.sv:1406:5
			assign cpuctrl_d[2] = cpuctrl_wdata[2];
			// Trace: core/rtl/ibex_cs_registers.sv:1407:5
			assign cpuctrl_d[5-:3] = cpuctrl_wdata[5-:3];
			// Trace: core/rtl/ibex_cs_registers.sv:1410:5
			assign dummy_instr_seed_en_o = csr_we_int && (csr_addr == 12'h7c1);
			// Trace: core/rtl/ibex_cs_registers.sv:1411:5
			assign dummy_instr_seed_o = csr_wdata_int;
		end
		else begin : gen_no_dummy
			// Trace: core/rtl/ibex_cs_registers.sv:1415:5
			wire unused_dummy_en;
			// Trace: core/rtl/ibex_cs_registers.sv:1416:5
			wire [2:0] unused_dummy_mask;
			// Trace: core/rtl/ibex_cs_registers.sv:1417:5
			assign unused_dummy_en = cpuctrl_wdata[2];
			// Trace: core/rtl/ibex_cs_registers.sv:1418:5
			assign unused_dummy_mask = cpuctrl_wdata[5-:3];
			// Trace: core/rtl/ibex_cs_registers.sv:1421:5
			assign cpuctrl_d[2] = 1'b0;
			// Trace: core/rtl/ibex_cs_registers.sv:1422:5
			assign cpuctrl_d[5-:3] = 3'b000;
			// Trace: core/rtl/ibex_cs_registers.sv:1423:5
			assign dummy_instr_seed_en_o = 1'b0;
			// Trace: core/rtl/ibex_cs_registers.sv:1424:5
			assign dummy_instr_seed_o = 1'sb0;
		end
	endgenerate
	// Trace: core/rtl/ibex_cs_registers.sv:1427:3
	assign dummy_instr_en_o = cpuctrl_q[2];
	// Trace: core/rtl/ibex_cs_registers.sv:1428:3
	assign dummy_instr_mask_o = cpuctrl_q[5-:3];
	// Trace: core/rtl/ibex_cs_registers.sv:1431:3
	generate
		if (ICache) begin : gen_icache_enable
			// Trace: core/rtl/ibex_cs_registers.sv:1432:5
			assign cpuctrl_d[0] = cpuctrl_wdata[0];
		end
		else begin : gen_no_icache
			// Trace: core/rtl/ibex_cs_registers.sv:1435:5
			wire unused_icen;
			// Trace: core/rtl/ibex_cs_registers.sv:1436:5
			assign unused_icen = cpuctrl_wdata[0];
			// Trace: core/rtl/ibex_cs_registers.sv:1439:5
			assign cpuctrl_d[0] = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_cs_registers.sv:1442:3
	assign icache_enable_o = cpuctrl_q[0];
	// Trace: core/rtl/ibex_cs_registers.sv:1444:3
	ibex_csr #(
		.Width(6),
		.ShadowCopy(ShadowCSR),
		.ResetValue(1'sb0)
	) u_cpuctrl_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i({cpuctrl_d}),
		.wr_en_i(cpuctrl_we),
		.rd_data_o(cpuctrl_q),
		.rd_error_o(cpuctrl_err)
	);
	// Trace: core/rtl/ibex_cs_registers.sv:1457:3
	assign csr_shadow_err_o = (((mstatus_err | mtvec_err) | mtvecx_err) | pmp_csr_err) | cpuctrl_err;
	// Trace: core/rtl/ibex_cs_registers.sv:1464:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(1'b0),
		.ResetValue({32 {1'b1}})
	) u_miex_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(csr_wdata_int),
		.wr_en_i(miex_en),
		.rd_data_o(miex_q),
		.rd_error_o()
	);
	// Trace: core/rtl/ibex_cs_registers.sv:1478:3
	ibex_csr #(
		.Width(32),
		.ShadowCopy(ShadowCSR),
		.ResetValue(32'd1)
	) u_mtvecx_csr(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.wr_data_i(mtvecx_d),
		.wr_en_i(mtvecx_en),
		.rd_data_o(mtvecx_q),
		.rd_error_o(mtvecx_err)
	);
	initial _sv2v_0 = 0;
endmodule
