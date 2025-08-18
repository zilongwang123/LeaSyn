// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_controller (
	clk_i,
	rst_ni,
	ctrl_busy_o,
	illegal_insn_i,
	ecall_insn_i,
	mret_insn_i,
	dret_insn_i,
	wfi_insn_i,
	ebrk_insn_i,
	csr_pipe_flush_i,
	instr_valid_i,
	instr_i,
	instr_compressed_i,
	instr_is_compressed_i,
	instr_bp_taken_i,
	instr_fetch_err_i,
	instr_fetch_err_plus2_i,
	pc_id_i,
	instr_valid_clear_o,
	id_in_ready_o,
	controller_run_o,
	instr_req_o,
	pc_set_o,
	pc_set_spec_o,
	pc_mux_o,
	nt_branch_mispredict_o,
	exc_pc_mux_o,
	exc_cause_o,
	lsu_addr_last_i,
	load_err_i,
	store_err_i,
	wb_exception_o,
	branch_set_i,
	branch_set_spec_i,
	branch_not_set_i,
	jump_set_i,
	csr_mstatus_mie_i,
	irq_pending_i,
	irqs_i,
	irq_nm_i,
	nmi_mode_o,
	irqs_x_i,
	irq_x_ack_o,
	irq_x_ack_id_o,
	debug_req_i,
	debug_cause_o,
	debug_csr_save_o,
	debug_mode_o,
	debug_single_step_i,
	debug_ebreakm_i,
	debug_ebreaku_i,
	trigger_match_i,
	csr_save_if_o,
	csr_save_id_o,
	csr_save_wb_o,
	csr_restore_mret_id_o,
	csr_restore_dret_id_o,
	csr_save_cause_o,
	csr_mtval_o,
	priv_mode_i,
	csr_mstatus_tw_i,
	stall_id_i,
	stall_wb_i,
	flush_id_o,
	ready_wb_i,
	perf_jump_o,
	perf_tbranch_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_controller.sv:13:15
	parameter [0:0] WritebackStage = 0;
	// Trace: core/rtl/ibex_controller.sv:14:15
	parameter [0:0] BranchPredictor = 0;
	// Trace: core/rtl/ibex_controller.sv:16:5
	input wire clk_i;
	// Trace: core/rtl/ibex_controller.sv:17:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_controller.sv:19:5
	output reg ctrl_busy_o;
	// Trace: core/rtl/ibex_controller.sv:22:5
	input wire illegal_insn_i;
	// Trace: core/rtl/ibex_controller.sv:23:5
	input wire ecall_insn_i;
	// Trace: core/rtl/ibex_controller.sv:24:5
	input wire mret_insn_i;
	// Trace: core/rtl/ibex_controller.sv:25:5
	input wire dret_insn_i;
	// Trace: core/rtl/ibex_controller.sv:26:5
	input wire wfi_insn_i;
	// Trace: core/rtl/ibex_controller.sv:27:5
	input wire ebrk_insn_i;
	// Trace: core/rtl/ibex_controller.sv:28:5
	input wire csr_pipe_flush_i;
	// Trace: core/rtl/ibex_controller.sv:31:5
	input wire instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:32:5
	input wire [31:0] instr_i;
	// Trace: core/rtl/ibex_controller.sv:33:5
	input wire [15:0] instr_compressed_i;
	// Trace: core/rtl/ibex_controller.sv:34:5
	input wire instr_is_compressed_i;
	// Trace: core/rtl/ibex_controller.sv:35:5
	input wire instr_bp_taken_i;
	// Trace: core/rtl/ibex_controller.sv:36:5
	input wire instr_fetch_err_i;
	// Trace: core/rtl/ibex_controller.sv:37:5
	input wire instr_fetch_err_plus2_i;
	// Trace: core/rtl/ibex_controller.sv:38:5
	input wire [31:0] pc_id_i;
	// Trace: core/rtl/ibex_controller.sv:41:5
	output wire instr_valid_clear_o;
	// Trace: core/rtl/ibex_controller.sv:42:5
	output wire id_in_ready_o;
	// Trace: core/rtl/ibex_controller.sv:43:5
	output reg controller_run_o;
	// Trace: core/rtl/ibex_controller.sv:47:5
	output reg instr_req_o;
	// Trace: core/rtl/ibex_controller.sv:48:5
	output reg pc_set_o;
	// Trace: core/rtl/ibex_controller.sv:49:5
	output reg pc_set_spec_o;
	// Trace: core/rtl/ibex_controller.sv:50:5
	// removed localparam type ibex_pkg_pc_sel_e
	output reg [2:0] pc_mux_o;
	// Trace: core/rtl/ibex_controller.sv:52:5
	output reg nt_branch_mispredict_o;
	// Trace: core/rtl/ibex_controller.sv:54:5
	// removed localparam type ibex_pkg_exc_pc_sel_e
	output reg [2:0] exc_pc_mux_o;
	// Trace: core/rtl/ibex_controller.sv:55:5
	// removed localparam type ibex_pkg_exc_cause_e
	output reg [5:0] exc_cause_o;
	// Trace: core/rtl/ibex_controller.sv:58:5
	input wire [31:0] lsu_addr_last_i;
	// Trace: core/rtl/ibex_controller.sv:59:5
	input wire load_err_i;
	// Trace: core/rtl/ibex_controller.sv:60:5
	input wire store_err_i;
	// Trace: core/rtl/ibex_controller.sv:61:5
	output wire wb_exception_o;
	// Trace: core/rtl/ibex_controller.sv:64:5
	input wire branch_set_i;
	// Trace: core/rtl/ibex_controller.sv:66:5
	input wire branch_set_spec_i;
	// Trace: core/rtl/ibex_controller.sv:68:5
	input wire branch_not_set_i;
	// Trace: core/rtl/ibex_controller.sv:69:5
	input wire jump_set_i;
	// Trace: core/rtl/ibex_controller.sv:72:5
	input wire csr_mstatus_mie_i;
	// Trace: core/rtl/ibex_controller.sv:73:5
	input wire irq_pending_i;
	// Trace: core/rtl/ibex_controller.sv:74:5
	// removed localparam type ibex_pkg_irqs_t
	input wire [17:0] irqs_i;
	// Trace: core/rtl/ibex_controller.sv:76:5
	input wire irq_nm_i;
	// Trace: core/rtl/ibex_controller.sv:77:5
	output wire nmi_mode_o;
	// Trace: core/rtl/ibex_controller.sv:78:5
	input wire [31:0] irqs_x_i;
	// Trace: core/rtl/ibex_controller.sv:80:5
	output reg irq_x_ack_o;
	// Trace: core/rtl/ibex_controller.sv:81:5
	output reg [4:0] irq_x_ack_id_o;
	// Trace: core/rtl/ibex_controller.sv:84:5
	input wire debug_req_i;
	// Trace: core/rtl/ibex_controller.sv:85:5
	// removed localparam type ibex_pkg_dbg_cause_e
	output reg [2:0] debug_cause_o;
	// Trace: core/rtl/ibex_controller.sv:86:5
	output reg debug_csr_save_o;
	// Trace: core/rtl/ibex_controller.sv:87:5
	output wire debug_mode_o;
	// Trace: core/rtl/ibex_controller.sv:88:5
	input wire debug_single_step_i;
	// Trace: core/rtl/ibex_controller.sv:89:5
	input wire debug_ebreakm_i;
	// Trace: core/rtl/ibex_controller.sv:90:5
	input wire debug_ebreaku_i;
	// Trace: core/rtl/ibex_controller.sv:91:5
	input wire trigger_match_i;
	// Trace: core/rtl/ibex_controller.sv:93:5
	output reg csr_save_if_o;
	// Trace: core/rtl/ibex_controller.sv:94:5
	output reg csr_save_id_o;
	// Trace: core/rtl/ibex_controller.sv:95:5
	output reg csr_save_wb_o;
	// Trace: core/rtl/ibex_controller.sv:96:5
	output reg csr_restore_mret_id_o;
	// Trace: core/rtl/ibex_controller.sv:97:5
	output reg csr_restore_dret_id_o;
	// Trace: core/rtl/ibex_controller.sv:98:5
	output reg csr_save_cause_o;
	// Trace: core/rtl/ibex_controller.sv:99:5
	output reg [31:0] csr_mtval_o;
	// Trace: core/rtl/ibex_controller.sv:100:5
	// removed localparam type ibex_pkg_priv_lvl_e
	input wire [1:0] priv_mode_i;
	// Trace: core/rtl/ibex_controller.sv:101:5
	input wire csr_mstatus_tw_i;
	// Trace: core/rtl/ibex_controller.sv:104:5
	input wire stall_id_i;
	// Trace: core/rtl/ibex_controller.sv:105:5
	input wire stall_wb_i;
	// Trace: core/rtl/ibex_controller.sv:106:5
	output wire flush_id_o;
	// Trace: core/rtl/ibex_controller.sv:107:5
	input wire ready_wb_i;
	// Trace: core/rtl/ibex_controller.sv:110:5
	output reg perf_jump_o;
	// Trace: core/rtl/ibex_controller.sv:112:5
	output reg perf_tbranch_o;
	// Trace: core/rtl/ibex_controller.sv:115:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_controller.sv:118:3
	// removed localparam type ctrl_fsm_e
	// Trace: core/rtl/ibex_controller.sv:123:3
	reg [3:0] ctrl_fsm_cs;
	reg [3:0] ctrl_fsm_ns;
	// Trace: core/rtl/ibex_controller.sv:125:3
	reg nmi_mode_q;
	reg nmi_mode_d;
	// Trace: core/rtl/ibex_controller.sv:126:3
	reg debug_mode_q;
	reg debug_mode_d;
	// Trace: core/rtl/ibex_controller.sv:127:3
	reg load_err_q;
	wire load_err_d;
	// Trace: core/rtl/ibex_controller.sv:128:3
	reg store_err_q;
	wire store_err_d;
	// Trace: core/rtl/ibex_controller.sv:129:3
	reg exc_req_q;
	wire exc_req_d;
	// Trace: core/rtl/ibex_controller.sv:130:3
	reg illegal_insn_q;
	wire illegal_insn_d;
	// Trace: core/rtl/ibex_controller.sv:134:3
	reg instr_fetch_err_prio;
	// Trace: core/rtl/ibex_controller.sv:135:3
	reg illegal_insn_prio;
	// Trace: core/rtl/ibex_controller.sv:136:3
	reg ecall_insn_prio;
	// Trace: core/rtl/ibex_controller.sv:137:3
	reg ebrk_insn_prio;
	// Trace: core/rtl/ibex_controller.sv:138:3
	reg store_err_prio;
	// Trace: core/rtl/ibex_controller.sv:139:3
	reg load_err_prio;
	// Trace: core/rtl/ibex_controller.sv:141:3
	wire stall;
	// Trace: core/rtl/ibex_controller.sv:142:3
	reg halt_if;
	// Trace: core/rtl/ibex_controller.sv:143:3
	reg retain_id;
	// Trace: core/rtl/ibex_controller.sv:144:3
	reg flush_id;
	// Trace: core/rtl/ibex_controller.sv:145:3
	wire illegal_dret;
	// Trace: core/rtl/ibex_controller.sv:146:3
	wire illegal_umode;
	// Trace: core/rtl/ibex_controller.sv:147:3
	wire exc_req_lsu;
	// Trace: core/rtl/ibex_controller.sv:148:3
	wire special_req_all;
	// Trace: core/rtl/ibex_controller.sv:149:3
	wire special_req_branch;
	// Trace: core/rtl/ibex_controller.sv:150:3
	wire enter_debug_mode;
	// Trace: core/rtl/ibex_controller.sv:151:3
	wire ebreak_into_debug;
	// Trace: core/rtl/ibex_controller.sv:152:3
	wire handle_irq;
	// Trace: core/rtl/ibex_controller.sv:154:3
	reg [3:0] mfip_id;
	// Trace: core/rtl/ibex_controller.sv:155:3
	wire unused_irq_timer;
	// Trace: core/rtl/ibex_controller.sv:157:3
	reg [4:0] irq_x_id;
	// Trace: core/rtl/ibex_controller.sv:159:3
	wire ecall_insn;
	// Trace: core/rtl/ibex_controller.sv:160:3
	wire mret_insn;
	// Trace: core/rtl/ibex_controller.sv:161:3
	wire dret_insn;
	// Trace: core/rtl/ibex_controller.sv:162:3
	wire wfi_insn;
	// Trace: core/rtl/ibex_controller.sv:163:3
	wire ebrk_insn;
	// Trace: core/rtl/ibex_controller.sv:164:3
	wire csr_pipe_flush;
	// Trace: core/rtl/ibex_controller.sv:165:3
	wire instr_fetch_err;
	// Trace: core/rtl/ibex_controller.sv:185:3
	assign load_err_d = load_err_i;
	// Trace: core/rtl/ibex_controller.sv:186:3
	assign store_err_d = store_err_i;
	// Trace: core/rtl/ibex_controller.sv:189:3
	assign ecall_insn = ecall_insn_i & instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:190:3
	assign mret_insn = mret_insn_i & instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:191:3
	assign dret_insn = dret_insn_i & instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:192:3
	assign wfi_insn = wfi_insn_i & instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:193:3
	assign ebrk_insn = ebrk_insn_i & instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:194:3
	assign csr_pipe_flush = csr_pipe_flush_i & instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:195:3
	assign instr_fetch_err = instr_fetch_err_i & instr_valid_i;
	// Trace: core/rtl/ibex_controller.sv:199:3
	assign illegal_dret = dret_insn & ~debug_mode_q;
	// Trace: core/rtl/ibex_controller.sv:202:3
	assign illegal_umode = (priv_mode_i != 2'b11) & (mret_insn | (csr_mstatus_tw_i & wfi_insn));
	// Trace: core/rtl/ibex_controller.sv:211:3
	assign illegal_insn_d = ((illegal_insn_i | illegal_dret) | illegal_umode) & (ctrl_fsm_cs != 4'd6);
	// Trace: core/rtl/ibex_controller.sv:218:3
	assign exc_req_d = (((ecall_insn | ebrk_insn) | illegal_insn_d) | instr_fetch_err) & (ctrl_fsm_cs != 4'd6);
	// Trace: core/rtl/ibex_controller.sv:222:3
	assign exc_req_lsu = store_err_i | load_err_i;
	// Trace: core/rtl/ibex_controller.sv:237:3
	assign special_req_all = ((((mret_insn | dret_insn) | wfi_insn) | csr_pipe_flush) | exc_req_d) | exc_req_lsu;
	// Trace: core/rtl/ibex_controller.sv:242:3
	assign special_req_branch = instr_fetch_err & (ctrl_fsm_cs != 4'd6);
	// Trace: core/rtl/ibex_controller.sv:251:3
	generate
		if (WritebackStage) begin : g_wb_exceptions
			// Trace: core/rtl/ibex_controller.sv:252:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_controller.sv:253:7
				instr_fetch_err_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:254:7
				illegal_insn_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:255:7
				ecall_insn_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:256:7
				ebrk_insn_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:257:7
				store_err_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:258:7
				load_err_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:263:7
				if (store_err_q)
					// Trace: core/rtl/ibex_controller.sv:264:9
					store_err_prio = 1'b1;
				else if (load_err_q)
					// Trace: core/rtl/ibex_controller.sv:266:9
					load_err_prio = 1'b1;
				else if (instr_fetch_err)
					// Trace: core/rtl/ibex_controller.sv:268:9
					instr_fetch_err_prio = 1'b1;
				else if (illegal_insn_q)
					// Trace: core/rtl/ibex_controller.sv:270:9
					illegal_insn_prio = 1'b1;
				else if (ecall_insn)
					// Trace: core/rtl/ibex_controller.sv:272:9
					ecall_insn_prio = 1'b1;
				else if (ebrk_insn)
					// Trace: core/rtl/ibex_controller.sv:274:9
					ebrk_insn_prio = 1'b1;
			end
			// Trace: core/rtl/ibex_controller.sv:279:5
			assign wb_exception_o = ((load_err_q | store_err_q) | load_err_i) | store_err_i;
		end
		else begin : g_no_wb_exceptions
			// Trace: core/rtl/ibex_controller.sv:281:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_controller.sv:282:7
				instr_fetch_err_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:283:7
				illegal_insn_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:284:7
				ecall_insn_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:285:7
				ebrk_insn_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:286:7
				store_err_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:287:7
				load_err_prio = 0;
				// Trace: core/rtl/ibex_controller.sv:289:7
				if (instr_fetch_err)
					// Trace: core/rtl/ibex_controller.sv:290:9
					instr_fetch_err_prio = 1'b1;
				else if (illegal_insn_q)
					// Trace: core/rtl/ibex_controller.sv:292:9
					illegal_insn_prio = 1'b1;
				else if (ecall_insn)
					// Trace: core/rtl/ibex_controller.sv:294:9
					ecall_insn_prio = 1'b1;
				else if (ebrk_insn)
					// Trace: core/rtl/ibex_controller.sv:296:9
					ebrk_insn_prio = 1'b1;
				else if (store_err_q)
					// Trace: core/rtl/ibex_controller.sv:298:9
					store_err_prio = 1'b1;
				else if (load_err_q)
					// Trace: core/rtl/ibex_controller.sv:300:9
					load_err_prio = 1'b1;
			end
			// Trace: core/rtl/ibex_controller.sv:303:5
			assign wb_exception_o = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_controller.sv:325:3
	assign enter_debug_mode = ((debug_req_i | (debug_single_step_i & instr_valid_i)) | trigger_match_i) & ~debug_mode_q;
	// Trace: core/rtl/ibex_controller.sv:330:3
	assign ebreak_into_debug = (priv_mode_i == 2'b11 ? debug_ebreakm_i : (priv_mode_i == 2'b00 ? debug_ebreaku_i : 1'b0));
	// Trace: core/rtl/ibex_controller.sv:338:3
	assign handle_irq = (~debug_mode_q & ~nmi_mode_q) & (irq_nm_i | (irq_pending_i & csr_mstatus_mie_i));
	// Trace: core/rtl/ibex_controller.sv:342:3
	always @(*) begin : gen_mfip_id
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_controller.sv:343:5
		if (irqs_i[14])
			// Trace: core/rtl/ibex_controller.sv:343:35
			mfip_id = 4'd14;
		else if (irqs_i[13])
			// Trace: core/rtl/ibex_controller.sv:344:35
			mfip_id = 4'd13;
		else if (irqs_i[12])
			// Trace: core/rtl/ibex_controller.sv:345:35
			mfip_id = 4'd12;
		else if (irqs_i[11])
			// Trace: core/rtl/ibex_controller.sv:346:35
			mfip_id = 4'd11;
		else if (irqs_i[10])
			// Trace: core/rtl/ibex_controller.sv:347:35
			mfip_id = 4'd10;
		else if (irqs_i[9])
			// Trace: core/rtl/ibex_controller.sv:348:35
			mfip_id = 4'd9;
		else if (irqs_i[8])
			// Trace: core/rtl/ibex_controller.sv:349:35
			mfip_id = 4'd8;
		else if (irqs_i[7])
			// Trace: core/rtl/ibex_controller.sv:350:35
			mfip_id = 4'd7;
		else if (irqs_i[6])
			// Trace: core/rtl/ibex_controller.sv:351:35
			mfip_id = 4'd6;
		else if (irqs_i[5])
			// Trace: core/rtl/ibex_controller.sv:352:35
			mfip_id = 4'd5;
		else if (irqs_i[4])
			// Trace: core/rtl/ibex_controller.sv:353:35
			mfip_id = 4'd4;
		else if (irqs_i[3])
			// Trace: core/rtl/ibex_controller.sv:354:35
			mfip_id = 4'd3;
		else if (irqs_i[2])
			// Trace: core/rtl/ibex_controller.sv:355:35
			mfip_id = 4'd2;
		else if (irqs_i[1])
			// Trace: core/rtl/ibex_controller.sv:356:35
			mfip_id = 4'd1;
		else
			// Trace: core/rtl/ibex_controller.sv:357:35
			mfip_id = 4'd0;
	end
	// Trace: core/rtl/ibex_controller.sv:360:3
	assign unused_irq_timer = irqs_i[16];
	// Trace: core/rtl/ibex_controller.sv:363:3
	always @(*) begin : gen_irq_x_id
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_controller.sv:364:5
		if (irqs_x_i[31])
			// Trace: core/rtl/ibex_controller.sv:364:28
			irq_x_id = 5'd31;
		else if (irqs_x_i[30])
			// Trace: core/rtl/ibex_controller.sv:365:28
			irq_x_id = 5'd30;
		else if (irqs_x_i[29])
			// Trace: core/rtl/ibex_controller.sv:366:28
			irq_x_id = 5'd29;
		else if (irqs_x_i[28])
			// Trace: core/rtl/ibex_controller.sv:367:28
			irq_x_id = 5'd28;
		else if (irqs_x_i[27])
			// Trace: core/rtl/ibex_controller.sv:368:28
			irq_x_id = 5'd27;
		else if (irqs_x_i[26])
			// Trace: core/rtl/ibex_controller.sv:369:28
			irq_x_id = 5'd26;
		else if (irqs_x_i[25])
			// Trace: core/rtl/ibex_controller.sv:370:28
			irq_x_id = 5'd25;
		else if (irqs_x_i[24])
			// Trace: core/rtl/ibex_controller.sv:371:28
			irq_x_id = 5'd24;
		else if (irqs_x_i[23])
			// Trace: core/rtl/ibex_controller.sv:372:28
			irq_x_id = 5'd23;
		else if (irqs_x_i[22])
			// Trace: core/rtl/ibex_controller.sv:373:28
			irq_x_id = 5'd22;
		else if (irqs_x_i[21])
			// Trace: core/rtl/ibex_controller.sv:374:28
			irq_x_id = 5'd21;
		else if (irqs_x_i[20])
			// Trace: core/rtl/ibex_controller.sv:375:28
			irq_x_id = 5'd20;
		else if (irqs_x_i[19])
			// Trace: core/rtl/ibex_controller.sv:376:28
			irq_x_id = 5'd19;
		else if (irqs_x_i[18])
			// Trace: core/rtl/ibex_controller.sv:377:28
			irq_x_id = 5'd18;
		else if (irqs_x_i[17])
			// Trace: core/rtl/ibex_controller.sv:378:28
			irq_x_id = 5'd17;
		else if (irqs_x_i[16])
			// Trace: core/rtl/ibex_controller.sv:379:28
			irq_x_id = 5'd16;
		else if (irqs_x_i[15])
			// Trace: core/rtl/ibex_controller.sv:380:28
			irq_x_id = 5'd15;
		else if (irqs_x_i[14])
			// Trace: core/rtl/ibex_controller.sv:381:28
			irq_x_id = 5'd14;
		else if (irqs_x_i[13])
			// Trace: core/rtl/ibex_controller.sv:382:28
			irq_x_id = 5'd13;
		else if (irqs_x_i[12])
			// Trace: core/rtl/ibex_controller.sv:383:28
			irq_x_id = 5'd12;
		else if (irqs_x_i[11])
			// Trace: core/rtl/ibex_controller.sv:384:28
			irq_x_id = 5'd11;
		else if (irqs_x_i[10])
			// Trace: core/rtl/ibex_controller.sv:385:28
			irq_x_id = 5'd10;
		else if (irqs_x_i[9])
			// Trace: core/rtl/ibex_controller.sv:386:28
			irq_x_id = 5'd9;
		else if (irqs_x_i[8])
			// Trace: core/rtl/ibex_controller.sv:387:28
			irq_x_id = 5'd8;
		else if (irqs_x_i[7])
			// Trace: core/rtl/ibex_controller.sv:388:28
			irq_x_id = 5'd7;
		else if (irqs_x_i[6])
			// Trace: core/rtl/ibex_controller.sv:389:28
			irq_x_id = 5'd6;
		else if (irqs_x_i[5])
			// Trace: core/rtl/ibex_controller.sv:390:28
			irq_x_id = 5'd5;
		else if (irqs_x_i[4])
			// Trace: core/rtl/ibex_controller.sv:391:28
			irq_x_id = 5'd4;
		else if (irqs_x_i[3])
			// Trace: core/rtl/ibex_controller.sv:392:28
			irq_x_id = 5'd3;
		else if (irqs_x_i[2])
			// Trace: core/rtl/ibex_controller.sv:393:28
			irq_x_id = 5'd2;
		else if (irqs_x_i[1])
			// Trace: core/rtl/ibex_controller.sv:394:28
			irq_x_id = 5'd1;
		else
			// Trace: core/rtl/ibex_controller.sv:395:28
			irq_x_id = 5'd0;
	end
	// Trace: core/rtl/ibex_controller.sv:402:3
	function automatic [5:0] sv2v_cast_6;
		input reg [5:0] inp;
		sv2v_cast_6 = inp;
	endfunction
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_controller.sv:404:5
		instr_req_o = 1'b1;
		// Trace: core/rtl/ibex_controller.sv:406:5
		csr_save_if_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:407:5
		csr_save_id_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:408:5
		csr_save_wb_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:409:5
		csr_restore_mret_id_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:410:5
		csr_restore_dret_id_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:411:5
		csr_save_cause_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:412:5
		csr_mtval_o = 1'sb0;
		// Trace: core/rtl/ibex_controller.sv:418:5
		pc_mux_o = 3'd0;
		// Trace: core/rtl/ibex_controller.sv:419:5
		pc_set_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:420:5
		pc_set_spec_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:421:5
		nt_branch_mispredict_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:423:5
		exc_pc_mux_o = 3'd1;
		// Trace: core/rtl/ibex_controller.sv:424:5
		exc_cause_o = 6'h00;
		// Trace: core/rtl/ibex_controller.sv:426:5
		ctrl_fsm_ns = ctrl_fsm_cs;
		// Trace: core/rtl/ibex_controller.sv:428:5
		ctrl_busy_o = 1'b1;
		// Trace: core/rtl/ibex_controller.sv:430:5
		halt_if = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:431:5
		retain_id = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:432:5
		flush_id = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:434:5
		debug_csr_save_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:435:5
		debug_cause_o = 3'h1;
		// Trace: core/rtl/ibex_controller.sv:436:5
		debug_mode_d = debug_mode_q;
		// Trace: core/rtl/ibex_controller.sv:437:5
		nmi_mode_d = nmi_mode_q;
		// Trace: core/rtl/ibex_controller.sv:439:5
		perf_tbranch_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:440:5
		perf_jump_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:442:5
		controller_run_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:444:5
		irq_x_ack_o = 1'b0;
		// Trace: core/rtl/ibex_controller.sv:445:5
		irq_x_ack_id_o = 5'b00000;
		// Trace: core/rtl/ibex_controller.sv:447:5
		(* full_case, parallel_case *)
		case (ctrl_fsm_cs)
			4'd0: begin
				// Trace: core/rtl/ibex_controller.sv:449:9
				instr_req_o = 1'b0;
				// Trace: core/rtl/ibex_controller.sv:450:9
				pc_mux_o = 3'd0;
				// Trace: core/rtl/ibex_controller.sv:451:9
				pc_set_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:452:9
				pc_set_spec_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:453:9
				ctrl_fsm_ns = 4'd1;
			end
			4'd1: begin
				// Trace: core/rtl/ibex_controller.sv:458:9
				instr_req_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:459:9
				pc_mux_o = 3'd0;
				// Trace: core/rtl/ibex_controller.sv:460:9
				pc_set_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:461:9
				pc_set_spec_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:463:9
				ctrl_fsm_ns = 4'd4;
			end
			4'd2: begin
				// Trace: core/rtl/ibex_controller.sv:467:9
				ctrl_busy_o = 1'b0;
				// Trace: core/rtl/ibex_controller.sv:468:9
				instr_req_o = 1'b0;
				// Trace: core/rtl/ibex_controller.sv:469:9
				halt_if = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:470:9
				flush_id = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:471:9
				ctrl_fsm_ns = 4'd3;
			end
			4'd3: begin
				// Trace: core/rtl/ibex_controller.sv:477:9
				instr_req_o = 1'b0;
				// Trace: core/rtl/ibex_controller.sv:478:9
				halt_if = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:479:9
				flush_id = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:483:9
				if ((((irq_nm_i || irq_pending_i) || debug_req_i) || debug_mode_q) || debug_single_step_i)
					// Trace: core/rtl/ibex_controller.sv:484:11
					ctrl_fsm_ns = 4'd4;
				else
					// Trace: core/rtl/ibex_controller.sv:487:11
					ctrl_busy_o = 1'b0;
			end
			4'd4: begin
				// Trace: core/rtl/ibex_controller.sv:493:9
				if (id_in_ready_o)
					// Trace: core/rtl/ibex_controller.sv:494:11
					ctrl_fsm_ns = 4'd5;
				if (handle_irq) begin
					// Trace: core/rtl/ibex_controller.sv:503:11
					ctrl_fsm_ns = 4'd7;
					// Trace: core/rtl/ibex_controller.sv:504:11
					halt_if = 1'b1;
				end
				if (enter_debug_mode) begin
					// Trace: core/rtl/ibex_controller.sv:509:11
					ctrl_fsm_ns = 4'd8;
					// Trace: core/rtl/ibex_controller.sv:512:11
					halt_if = 1'b1;
				end
			end
			4'd5: begin
				// Trace: core/rtl/ibex_controller.sv:523:9
				controller_run_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:528:9
				pc_mux_o = 3'd1;
				// Trace: core/rtl/ibex_controller.sv:532:9
				if (special_req_all) begin
					// Trace: core/rtl/ibex_controller.sv:536:11
					retain_id = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:544:11
					if (ready_wb_i | wb_exception_o)
						// Trace: core/rtl/ibex_controller.sv:545:13
						ctrl_fsm_ns = 4'd6;
				end
				if (!special_req_branch) begin
					// Trace: core/rtl/ibex_controller.sv:550:11
					if (branch_set_i || jump_set_i) begin
						// Trace: core/rtl/ibex_controller.sv:552:13
						pc_set_o = (BranchPredictor ? ~instr_bp_taken_i : 1'b1);
						// Trace: core/rtl/ibex_controller.sv:554:13
						perf_tbranch_o = branch_set_i;
						// Trace: core/rtl/ibex_controller.sv:555:13
						perf_jump_o = jump_set_i;
					end
					if (BranchPredictor) begin
						begin
							// Trace: core/rtl/ibex_controller.sv:559:13
							if (instr_bp_taken_i & branch_not_set_i)
								// Trace: core/rtl/ibex_controller.sv:562:15
								nt_branch_mispredict_o = 1'b1;
						end
					end
				end
				if ((branch_set_spec_i || jump_set_i) && !special_req_branch)
					// Trace: core/rtl/ibex_controller.sv:571:11
					pc_set_spec_o = (BranchPredictor ? ~instr_bp_taken_i : 1'b1);
				if ((enter_debug_mode || handle_irq) && stall)
					// Trace: core/rtl/ibex_controller.sv:578:11
					halt_if = 1'b1;
				if (!stall && !special_req_all) begin
					begin
						// Trace: core/rtl/ibex_controller.sv:582:11
						if (enter_debug_mode) begin
							// Trace: core/rtl/ibex_controller.sv:584:13
							ctrl_fsm_ns = 4'd8;
							// Trace: core/rtl/ibex_controller.sv:587:13
							halt_if = 1'b1;
						end
						else if (handle_irq) begin
							// Trace: core/rtl/ibex_controller.sv:590:13
							ctrl_fsm_ns = 4'd7;
							// Trace: core/rtl/ibex_controller.sv:596:13
							halt_if = 1'b1;
						end
					end
				end
			end
			4'd7: begin
				// Trace: core/rtl/ibex_controller.sv:603:9
				pc_mux_o = 3'd2;
				// Trace: core/rtl/ibex_controller.sv:604:9
				exc_pc_mux_o = 3'd1;
				// Trace: core/rtl/ibex_controller.sv:606:9
				if (handle_irq) begin
					// Trace: core/rtl/ibex_controller.sv:607:11
					pc_set_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:608:11
					pc_set_spec_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:610:11
					csr_save_if_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:611:11
					csr_save_cause_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:614:11
					if (irq_nm_i && !nmi_mode_q) begin
						// Trace: core/rtl/ibex_controller.sv:615:13
						exc_cause_o = 6'h3f;
						// Trace: core/rtl/ibex_controller.sv:616:13
						nmi_mode_d = 1'b1;
					end
					else if (irqs_x_i != 32'b00000000000000000000000000000000) begin
						// Trace: core/rtl/ibex_controller.sv:620:13
						exc_cause_o = sv2v_cast_6({1'b1, irq_x_id});
						// Trace: core/rtl/ibex_controller.sv:621:13
						exc_pc_mux_o = 3'd2;
						// Trace: core/rtl/ibex_controller.sv:622:13
						irq_x_ack_o = 1'b1;
						// Trace: core/rtl/ibex_controller.sv:623:13
						irq_x_ack_id_o = irq_x_id;
					end
					else if (irqs_i[14-:15] != 15'b000000000000000)
						// Trace: core/rtl/ibex_controller.sv:629:13
						exc_cause_o = sv2v_cast_6({2'b11, mfip_id});
					else if (irqs_i[15])
						// Trace: core/rtl/ibex_controller.sv:631:13
						exc_cause_o = 6'h2b;
					else if (irqs_i[17])
						// Trace: core/rtl/ibex_controller.sv:633:13
						exc_cause_o = 6'h23;
					else
						// Trace: core/rtl/ibex_controller.sv:635:13
						exc_cause_o = 6'h27;
				end
				// Trace: core/rtl/ibex_controller.sv:639:9
				ctrl_fsm_ns = 4'd5;
			end
			4'd8: begin
				// Trace: core/rtl/ibex_controller.sv:643:9
				pc_mux_o = 3'd2;
				// Trace: core/rtl/ibex_controller.sv:644:9
				exc_pc_mux_o = 3'd3;
				// Trace: core/rtl/ibex_controller.sv:648:9
				if ((debug_single_step_i || debug_req_i) || trigger_match_i) begin
					// Trace: core/rtl/ibex_controller.sv:649:11
					flush_id = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:650:11
					pc_set_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:651:11
					pc_set_spec_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:653:11
					csr_save_if_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:654:11
					debug_csr_save_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:656:11
					csr_save_cause_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:657:11
					if (trigger_match_i)
						// Trace: core/rtl/ibex_controller.sv:658:13
						debug_cause_o = 3'h2;
					else if (debug_single_step_i)
						// Trace: core/rtl/ibex_controller.sv:660:13
						debug_cause_o = 3'h4;
					else
						// Trace: core/rtl/ibex_controller.sv:662:13
						debug_cause_o = 3'h3;
					// Trace: core/rtl/ibex_controller.sv:666:11
					debug_mode_d = 1'b1;
				end
				// Trace: core/rtl/ibex_controller.sv:669:9
				ctrl_fsm_ns = 4'd5;
			end
			4'd9: begin
				// Trace: core/rtl/ibex_controller.sv:680:9
				flush_id = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:681:9
				pc_mux_o = 3'd2;
				// Trace: core/rtl/ibex_controller.sv:682:9
				pc_set_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:683:9
				pc_set_spec_o = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:684:9
				exc_pc_mux_o = 3'd3;
				// Trace: core/rtl/ibex_controller.sv:687:9
				if (ebreak_into_debug && !debug_mode_q) begin
					// Trace: core/rtl/ibex_controller.sv:690:11
					csr_save_cause_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:691:11
					csr_save_id_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:694:11
					debug_csr_save_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:695:11
					debug_cause_o = 3'h1;
				end
				// Trace: core/rtl/ibex_controller.sv:699:9
				debug_mode_d = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:701:9
				ctrl_fsm_ns = 4'd5;
			end
			4'd6: begin
				// Trace: core/rtl/ibex_controller.sv:706:9
				halt_if = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:707:9
				flush_id = 1'b1;
				// Trace: core/rtl/ibex_controller.sv:708:9
				ctrl_fsm_ns = 4'd5;
				// Trace: core/rtl/ibex_controller.sv:715:9
				if ((exc_req_q || store_err_q) || load_err_q) begin
					// Trace: core/rtl/ibex_controller.sv:716:11
					pc_set_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:717:11
					pc_set_spec_o = 1'b1;
					// Trace: core/rtl/ibex_controller.sv:718:11
					pc_mux_o = 3'd2;
					// Trace: core/rtl/ibex_controller.sv:719:11
					exc_pc_mux_o = (debug_mode_q ? 3'd4 : 3'd0);
					// Trace: core/rtl/ibex_controller.sv:721:11
					if (WritebackStage) begin : g_writeback_mepc_save
						// Trace: core/rtl/ibex_controller.sv:725:13
						csr_save_id_o = ~(store_err_q | load_err_q);
						// Trace: core/rtl/ibex_controller.sv:726:13
						csr_save_wb_o = store_err_q | load_err_q;
					end
					else begin : g_no_writeback_mepc_save
						// Trace: core/rtl/ibex_controller.sv:728:13
						csr_save_id_o = 1'b0;
					end
					// Trace: core/rtl/ibex_controller.sv:731:11
					csr_save_cause_o = 1'b1;
					(* full_case, parallel_case *)
					case (1'b1)
						instr_fetch_err_prio: begin
							// Trace: core/rtl/ibex_controller.sv:736:17
							exc_cause_o = 6'h01;
							// Trace: core/rtl/ibex_controller.sv:737:17
							csr_mtval_o = (instr_fetch_err_plus2_i ? pc_id_i + 32'd2 : pc_id_i);
						end
						illegal_insn_prio: begin
							// Trace: core/rtl/ibex_controller.sv:740:15
							exc_cause_o = 6'h02;
							// Trace: core/rtl/ibex_controller.sv:741:15
							csr_mtval_o = (instr_is_compressed_i ? {16'b0000000000000000, instr_compressed_i} : instr_i);
						end
						ecall_insn_prio:
							// Trace: core/rtl/ibex_controller.sv:744:15
							exc_cause_o = (priv_mode_i == 2'b11 ? 6'h0b : 6'h08);
						ebrk_insn_prio:
							// Trace: core/rtl/ibex_controller.sv:748:15
							if (debug_mode_q | ebreak_into_debug) begin
								// Trace: core/rtl/ibex_controller.sv:762:17
								pc_set_o = 1'b0;
								// Trace: core/rtl/ibex_controller.sv:763:17
								pc_set_spec_o = 1'b0;
								// Trace: core/rtl/ibex_controller.sv:764:17
								csr_save_id_o = 1'b0;
								// Trace: core/rtl/ibex_controller.sv:765:17
								csr_save_cause_o = 1'b0;
								// Trace: core/rtl/ibex_controller.sv:766:17
								ctrl_fsm_ns = 4'd9;
								// Trace: core/rtl/ibex_controller.sv:767:17
								flush_id = 1'b0;
							end
							else
								// Trace: core/rtl/ibex_controller.sv:778:17
								exc_cause_o = 6'h03;
						store_err_prio: begin
							// Trace: core/rtl/ibex_controller.sv:782:15
							exc_cause_o = 6'h07;
							// Trace: core/rtl/ibex_controller.sv:783:15
							csr_mtval_o = lsu_addr_last_i;
						end
						load_err_prio: begin
							// Trace: core/rtl/ibex_controller.sv:786:15
							exc_cause_o = 6'h05;
							// Trace: core/rtl/ibex_controller.sv:787:15
							csr_mtval_o = lsu_addr_last_i;
						end
						default:
							;
					endcase
				end
				else
					// Trace: core/rtl/ibex_controller.sv:793:11
					if (mret_insn) begin
						// Trace: core/rtl/ibex_controller.sv:794:13
						pc_mux_o = 3'd3;
						// Trace: core/rtl/ibex_controller.sv:795:13
						pc_set_o = 1'b1;
						// Trace: core/rtl/ibex_controller.sv:796:13
						pc_set_spec_o = 1'b1;
						// Trace: core/rtl/ibex_controller.sv:797:13
						csr_restore_mret_id_o = 1'b1;
						// Trace: core/rtl/ibex_controller.sv:798:13
						if (nmi_mode_q)
							// Trace: core/rtl/ibex_controller.sv:799:15
							nmi_mode_d = 1'b0;
					end
					else if (dret_insn) begin
						// Trace: core/rtl/ibex_controller.sv:802:13
						pc_mux_o = 3'd4;
						// Trace: core/rtl/ibex_controller.sv:803:13
						pc_set_o = 1'b1;
						// Trace: core/rtl/ibex_controller.sv:804:13
						pc_set_spec_o = 1'b1;
						// Trace: core/rtl/ibex_controller.sv:805:13
						debug_mode_d = 1'b0;
						// Trace: core/rtl/ibex_controller.sv:806:13
						csr_restore_dret_id_o = 1'b1;
					end
					else if (wfi_insn)
						// Trace: core/rtl/ibex_controller.sv:808:13
						ctrl_fsm_ns = 4'd2;
					else if (csr_pipe_flush && handle_irq)
						// Trace: core/rtl/ibex_controller.sv:811:13
						ctrl_fsm_ns = 4'd7;
				if (enter_debug_mode && !(ebrk_insn_prio && ebreak_into_debug))
					// Trace: core/rtl/ibex_controller.sv:825:11
					ctrl_fsm_ns = 4'd8;
			end
			default: begin
				// Trace: core/rtl/ibex_controller.sv:830:9
				instr_req_o = 1'b0;
				// Trace: core/rtl/ibex_controller.sv:831:9
				ctrl_fsm_ns = 4'd0;
			end
		endcase
	end
	// Trace: core/rtl/ibex_controller.sv:836:3
	assign flush_id_o = flush_id;
	// Trace: core/rtl/ibex_controller.sv:839:3
	assign debug_mode_o = debug_mode_q;
	// Trace: core/rtl/ibex_controller.sv:842:3
	assign nmi_mode_o = nmi_mode_q;
	// Trace: core/rtl/ibex_controller.sv:851:3
	assign stall = stall_id_i | stall_wb_i;
	// Trace: core/rtl/ibex_controller.sv:854:3
	assign id_in_ready_o = (~stall & ~halt_if) & ~retain_id;
	// Trace: core/rtl/ibex_controller.sv:861:3
	assign instr_valid_clear_o = ~(stall | retain_id) | flush_id;
	// Trace: core/rtl/ibex_controller.sv:864:3
	always @(posedge clk_i or negedge rst_ni) begin : update_regs
		// Trace: core/rtl/ibex_controller.sv:865:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_controller.sv:866:7
			ctrl_fsm_cs <= 4'd0;
			// Trace: core/rtl/ibex_controller.sv:867:7
			nmi_mode_q <= 1'b0;
			// Trace: core/rtl/ibex_controller.sv:868:7
			debug_mode_q <= 1'b0;
			// Trace: core/rtl/ibex_controller.sv:869:7
			load_err_q <= 1'b0;
			// Trace: core/rtl/ibex_controller.sv:870:7
			store_err_q <= 1'b0;
			// Trace: core/rtl/ibex_controller.sv:871:7
			exc_req_q <= 1'b0;
			// Trace: core/rtl/ibex_controller.sv:872:7
			illegal_insn_q <= 1'b0;
		end
		else begin
			// Trace: core/rtl/ibex_controller.sv:874:7
			ctrl_fsm_cs <= ctrl_fsm_ns;
			// Trace: core/rtl/ibex_controller.sv:875:7
			nmi_mode_q <= nmi_mode_d;
			// Trace: core/rtl/ibex_controller.sv:876:7
			debug_mode_q <= debug_mode_d;
			// Trace: core/rtl/ibex_controller.sv:877:7
			load_err_q <= load_err_d;
			// Trace: core/rtl/ibex_controller.sv:878:7
			store_err_q <= store_err_d;
			// Trace: core/rtl/ibex_controller.sv:879:7
			exc_req_q <= exc_req_d;
			// Trace: core/rtl/ibex_controller.sv:880:7
			illegal_insn_q <= illegal_insn_d;
		end
	end
	initial _sv2v_0 = 0;
endmodule
