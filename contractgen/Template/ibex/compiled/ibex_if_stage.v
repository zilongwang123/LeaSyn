// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_if_stage (
	clk_i,
	rst_ni,
	boot_addr_i,
	req_i,
	instr_req_o,
	instr_addr_o,
	instr_gnt_i,
	instr_rvalid_i,
	instr_rdata_i,
	instr_err_i,
	instr_pmp_err_i,
	instr_valid_id_o,
	instr_new_id_o,
	instr_rdata_id_o,
	instr_rdata_alu_id_o,
	instr_rdata_c_id_o,
	instr_is_compressed_id_o,
	instr_bp_taken_o,
	instr_fetch_err_o,
	instr_fetch_err_plus2_o,
	illegal_c_insn_id_o,
	dummy_instr_id_o,
	pc_if_o,
	pc_id_o,
	instr_valid_clear_i,
	pc_set_i,
	pc_set_spec_i,
	pc_mux_i,
	nt_branch_mispredict_i,
	exc_pc_mux_i,
	exc_cause,
	dummy_instr_en_i,
	dummy_instr_mask_i,
	dummy_instr_seed_en_i,
	dummy_instr_seed_i,
	icache_enable_i,
	icache_inval_i,
	branch_target_ex_i,
	csr_mepc_i,
	csr_depc_i,
	csr_mtvec_i,
	csr_mtvecx_i,
	csr_mtvec_init_o,
	id_in_ready_i,
	pc_mismatch_alert_o,
	if_busy_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_if_stage.sv:16:15
	parameter [31:0] DmHaltAddr = 32'h1a110800;
	// Trace: core/rtl/ibex_if_stage.sv:17:15
	parameter [31:0] DmExceptionAddr = 32'h1a110808;
	// Trace: core/rtl/ibex_if_stage.sv:18:15
	parameter [0:0] DummyInstructions = 1'b0;
	// Trace: core/rtl/ibex_if_stage.sv:19:15
	parameter [0:0] ICache = 1'b0;
	// Trace: core/rtl/ibex_if_stage.sv:20:15
	parameter [0:0] ICacheECC = 1'b0;
	// Trace: core/rtl/ibex_if_stage.sv:21:15
	parameter [0:0] PCIncrCheck = 1'b0;
	// Trace: core/rtl/ibex_if_stage.sv:22:15
	parameter [0:0] BranchPredictor = 1'b0;
	// Trace: core/rtl/ibex_if_stage.sv:24:5
	input wire clk_i;
	// Trace: core/rtl/ibex_if_stage.sv:25:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_if_stage.sv:27:5
	input wire [31:0] boot_addr_i;
	// Trace: core/rtl/ibex_if_stage.sv:28:5
	input wire req_i;
	// Trace: core/rtl/ibex_if_stage.sv:31:5
	output wire instr_req_o;
	// Trace: core/rtl/ibex_if_stage.sv:32:5
	output wire [31:0] instr_addr_o;
	// Trace: core/rtl/ibex_if_stage.sv:33:5
	input wire instr_gnt_i;
	// Trace: core/rtl/ibex_if_stage.sv:34:5
	input wire instr_rvalid_i;
	// Trace: core/rtl/ibex_if_stage.sv:35:5
	input wire [31:0] instr_rdata_i;
	// Trace: core/rtl/ibex_if_stage.sv:36:5
	input wire instr_err_i;
	// Trace: core/rtl/ibex_if_stage.sv:37:5
	input wire instr_pmp_err_i;
	// Trace: core/rtl/ibex_if_stage.sv:40:5
	output wire instr_valid_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:41:5
	output wire instr_new_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:42:5
	output reg [31:0] instr_rdata_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:43:5
	output reg [31:0] instr_rdata_alu_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:45:5
	output reg [15:0] instr_rdata_c_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:48:5
	output reg instr_is_compressed_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:50:5
	output wire instr_bp_taken_o;
	// Trace: core/rtl/ibex_if_stage.sv:52:5
	output reg instr_fetch_err_o;
	// Trace: core/rtl/ibex_if_stage.sv:53:5
	output reg instr_fetch_err_plus2_o;
	// Trace: core/rtl/ibex_if_stage.sv:54:5
	output reg illegal_c_insn_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:56:5
	output reg dummy_instr_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:57:5
	output wire [31:0] pc_if_o;
	// Trace: core/rtl/ibex_if_stage.sv:58:5
	output reg [31:0] pc_id_o;
	// Trace: core/rtl/ibex_if_stage.sv:61:5
	input wire instr_valid_clear_i;
	// Trace: core/rtl/ibex_if_stage.sv:62:5
	input wire pc_set_i;
	// Trace: core/rtl/ibex_if_stage.sv:63:5
	input wire pc_set_spec_i;
	// Trace: core/rtl/ibex_if_stage.sv:64:5
	// removed localparam type ibex_pkg_pc_sel_e
	input wire [2:0] pc_mux_i;
	// Trace: core/rtl/ibex_if_stage.sv:65:5
	input wire nt_branch_mispredict_i;
	// Trace: core/rtl/ibex_if_stage.sv:67:5
	// removed localparam type ibex_pkg_exc_pc_sel_e
	input wire [2:0] exc_pc_mux_i;
	// Trace: core/rtl/ibex_if_stage.sv:68:5
	// removed localparam type ibex_pkg_exc_cause_e
	input wire [5:0] exc_cause;
	// Trace: core/rtl/ibex_if_stage.sv:70:5
	input wire dummy_instr_en_i;
	// Trace: core/rtl/ibex_if_stage.sv:71:5
	input wire [2:0] dummy_instr_mask_i;
	// Trace: core/rtl/ibex_if_stage.sv:72:5
	input wire dummy_instr_seed_en_i;
	// Trace: core/rtl/ibex_if_stage.sv:73:5
	input wire [31:0] dummy_instr_seed_i;
	// Trace: core/rtl/ibex_if_stage.sv:74:5
	input wire icache_enable_i;
	// Trace: core/rtl/ibex_if_stage.sv:75:5
	input wire icache_inval_i;
	// Trace: core/rtl/ibex_if_stage.sv:78:5
	input wire [31:0] branch_target_ex_i;
	// Trace: core/rtl/ibex_if_stage.sv:81:5
	input wire [31:0] csr_mepc_i;
	// Trace: core/rtl/ibex_if_stage.sv:83:5
	input wire [31:0] csr_depc_i;
	// Trace: core/rtl/ibex_if_stage.sv:85:5
	input wire [31:0] csr_mtvec_i;
	// Trace: core/rtl/ibex_if_stage.sv:86:5
	input wire [31:0] csr_mtvecx_i;
	// Trace: core/rtl/ibex_if_stage.sv:87:5
	output wire csr_mtvec_init_o;
	// Trace: core/rtl/ibex_if_stage.sv:90:5
	input wire id_in_ready_i;
	// Trace: core/rtl/ibex_if_stage.sv:93:5
	output wire pc_mismatch_alert_o;
	// Trace: core/rtl/ibex_if_stage.sv:94:5
	output wire if_busy_o;
	// Trace: core/rtl/ibex_if_stage.sv:97:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_if_stage.sv:99:3
	wire instr_valid_id_d;
	reg instr_valid_id_q;
	// Trace: core/rtl/ibex_if_stage.sv:100:3
	wire instr_new_id_d;
	reg instr_new_id_q;
	// Trace: core/rtl/ibex_if_stage.sv:103:3
	wire prefetch_busy;
	// Trace: core/rtl/ibex_if_stage.sv:104:3
	wire branch_req;
	// Trace: core/rtl/ibex_if_stage.sv:105:3
	wire branch_spec;
	// Trace: core/rtl/ibex_if_stage.sv:106:3
	wire predicted_branch;
	// Trace: core/rtl/ibex_if_stage.sv:107:3
	reg [31:0] fetch_addr_n;
	// Trace: core/rtl/ibex_if_stage.sv:108:3
	wire unused_fetch_addr_n0;
	// Trace: core/rtl/ibex_if_stage.sv:110:3
	wire fetch_valid;
	// Trace: core/rtl/ibex_if_stage.sv:111:3
	wire fetch_ready;
	// Trace: core/rtl/ibex_if_stage.sv:112:3
	wire [31:0] fetch_rdata;
	// Trace: core/rtl/ibex_if_stage.sv:113:3
	wire [31:0] fetch_addr;
	// Trace: core/rtl/ibex_if_stage.sv:114:3
	wire fetch_err;
	// Trace: core/rtl/ibex_if_stage.sv:115:3
	wire fetch_err_plus2;
	// Trace: core/rtl/ibex_if_stage.sv:117:3
	wire if_instr_valid;
	// Trace: core/rtl/ibex_if_stage.sv:118:3
	wire [31:0] if_instr_rdata;
	// Trace: core/rtl/ibex_if_stage.sv:119:3
	wire [31:0] if_instr_addr;
	// Trace: core/rtl/ibex_if_stage.sv:120:3
	wire if_instr_err;
	// Trace: core/rtl/ibex_if_stage.sv:122:3
	reg [31:0] exc_pc;
	// Trace: core/rtl/ibex_if_stage.sv:124:3
	wire [5:0] irq_id;
	// Trace: core/rtl/ibex_if_stage.sv:125:3
	wire unused_irq_bit;
	// Trace: core/rtl/ibex_if_stage.sv:127:3
	wire if_id_pipe_reg_we;
	// Trace: core/rtl/ibex_if_stage.sv:130:3
	wire stall_dummy_instr;
	// Trace: core/rtl/ibex_if_stage.sv:131:3
	wire [31:0] instr_out;
	// Trace: core/rtl/ibex_if_stage.sv:132:3
	wire instr_is_compressed_out;
	// Trace: core/rtl/ibex_if_stage.sv:133:3
	wire illegal_c_instr_out;
	// Trace: core/rtl/ibex_if_stage.sv:134:3
	wire instr_err_out;
	// Trace: core/rtl/ibex_if_stage.sv:136:3
	wire predict_branch_taken;
	// Trace: core/rtl/ibex_if_stage.sv:137:3
	wire [31:0] predict_branch_pc;
	// Trace: core/rtl/ibex_if_stage.sv:139:3
	wire [2:0] pc_mux_internal;
	// Trace: core/rtl/ibex_if_stage.sv:141:3
	wire [7:0] unused_boot_addr;
	// Trace: core/rtl/ibex_if_stage.sv:142:3
	wire [7:0] unused_csr_mtvec;
	// Trace: core/rtl/ibex_if_stage.sv:143:3
	wire [7:0] unused_csr_mtvecx;
	// Trace: core/rtl/ibex_if_stage.sv:145:3
	assign unused_boot_addr = boot_addr_i[7:0];
	// Trace: core/rtl/ibex_if_stage.sv:146:3
	assign unused_csr_mtvec = csr_mtvec_i[7:0];
	// Trace: core/rtl/ibex_if_stage.sv:147:3
	assign unused_csr_mtvecx = csr_mtvecx_i[7:0];
	// Trace: core/rtl/ibex_if_stage.sv:150:3
	assign irq_id = {exc_cause};
	// Trace: core/rtl/ibex_if_stage.sv:151:3
	assign unused_irq_bit = irq_id[5];
	// Trace: core/rtl/ibex_if_stage.sv:154:3
	always @(*) begin : exc_pc_mux
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_if_stage.sv:155:5
		(* full_case, parallel_case *)
		case (exc_pc_mux_i)
			3'd0:
				// Trace: core/rtl/ibex_if_stage.sv:156:23
				exc_pc = {csr_mtvec_i[31:8], 8'h00};
			3'd1:
				// Trace: core/rtl/ibex_if_stage.sv:157:23
				exc_pc = {csr_mtvec_i[31:8], 1'b0, irq_id[4:0], 2'b00};
			3'd2:
				// Trace: core/rtl/ibex_if_stage.sv:158:23
				exc_pc = {csr_mtvecx_i[31:8], 1'b0, irq_id[4:0], 2'b00};
			3'd3:
				// Trace: core/rtl/ibex_if_stage.sv:159:23
				exc_pc = DmHaltAddr;
			3'd4:
				// Trace: core/rtl/ibex_if_stage.sv:160:23
				exc_pc = DmExceptionAddr;
			default:
				// Trace: core/rtl/ibex_if_stage.sv:161:23
				exc_pc = {csr_mtvec_i[31:8], 8'h00};
		endcase
	end
	// Trace: core/rtl/ibex_if_stage.sv:167:3
	assign pc_mux_internal = ((BranchPredictor && predict_branch_taken) && !pc_set_i ? 3'd5 : pc_mux_i);
	// Trace: core/rtl/ibex_if_stage.sv:171:3
	always @(*) begin : fetch_addr_mux
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_if_stage.sv:172:5
		(* full_case, parallel_case *)
		case (pc_mux_internal)
			3'd0:
				// Trace: core/rtl/ibex_if_stage.sv:173:16
				fetch_addr_n = {boot_addr_i[31:8], 8'h80};
			3'd1:
				// Trace: core/rtl/ibex_if_stage.sv:174:16
				fetch_addr_n = branch_target_ex_i;
			3'd2:
				// Trace: core/rtl/ibex_if_stage.sv:175:16
				fetch_addr_n = exc_pc;
			3'd3:
				// Trace: core/rtl/ibex_if_stage.sv:176:16
				fetch_addr_n = csr_mepc_i;
			3'd4:
				// Trace: core/rtl/ibex_if_stage.sv:177:16
				fetch_addr_n = csr_depc_i;
			3'd5:
				// Trace: core/rtl/ibex_if_stage.sv:180:16
				fetch_addr_n = (BranchPredictor ? predict_branch_pc : {boot_addr_i[31:8], 8'h80});
			default:
				// Trace: core/rtl/ibex_if_stage.sv:181:16
				fetch_addr_n = {boot_addr_i[31:8], 8'h80};
		endcase
	end
	// Trace: core/rtl/ibex_if_stage.sv:186:3
	assign csr_mtvec_init_o = (pc_mux_i == 3'd0) & pc_set_i;
	// Trace: core/rtl/ibex_if_stage.sv:188:3
	generate
		if (ICache) begin : gen_icache
			// Trace: core/rtl/ibex_if_stage.sv:190:5
			ibex_icache #(
				.BranchPredictor(BranchPredictor),
				.ICacheECC(ICacheECC)
			) icache_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.req_i(req_i),
				.branch_i(branch_req),
				.branch_spec_i(branch_spec),
				.predicted_branch_i(predicted_branch),
				.branch_mispredict_i(nt_branch_mispredict_i),
				.addr_i({fetch_addr_n[31:1], 1'b0}),
				.ready_i(fetch_ready),
				.valid_o(fetch_valid),
				.rdata_o(fetch_rdata),
				.addr_o(fetch_addr),
				.err_o(fetch_err),
				.err_plus2_o(fetch_err_plus2),
				.instr_req_o(instr_req_o),
				.instr_addr_o(instr_addr_o),
				.instr_gnt_i(instr_gnt_i),
				.instr_rvalid_i(instr_rvalid_i),
				.instr_rdata_i(instr_rdata_i),
				.instr_err_i(instr_err_i),
				.instr_pmp_err_i(instr_pmp_err_i),
				.icache_enable_i(icache_enable_i),
				.icache_inval_i(icache_inval_i),
				.busy_o(prefetch_busy)
			);
		end
		else begin : gen_prefetch_buffer
			// Trace: core/rtl/ibex_if_stage.sv:226:5
			ibex_prefetch_buffer #(.BranchPredictor(BranchPredictor)) prefetch_buffer_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.req_i(req_i),
				.branch_i(branch_req),
				.branch_spec_i(branch_spec),
				.predicted_branch_i(predicted_branch),
				.branch_mispredict_i(nt_branch_mispredict_i),
				.addr_i({fetch_addr_n[31:1], 1'b0}),
				.ready_i(fetch_ready),
				.valid_o(fetch_valid),
				.rdata_o(fetch_rdata),
				.addr_o(fetch_addr),
				.err_o(fetch_err),
				.err_plus2_o(fetch_err_plus2),
				.instr_req_o(instr_req_o),
				.instr_addr_o(instr_addr_o),
				.instr_gnt_i(instr_gnt_i),
				.instr_rvalid_i(instr_rvalid_i),
				.instr_rdata_i(instr_rdata_i),
				.instr_err_i(instr_err_i),
				.instr_pmp_err_i(instr_pmp_err_i),
				.busy_o(prefetch_busy)
			);
			// Trace: core/rtl/ibex_if_stage.sv:258:5
			wire unused_icen;
			wire unused_icinv;
			// Trace: core/rtl/ibex_if_stage.sv:259:5
			assign unused_icen = icache_enable_i;
			// Trace: core/rtl/ibex_if_stage.sv:260:5
			assign unused_icinv = icache_inval_i;
		end
	endgenerate
	// Trace: core/rtl/ibex_if_stage.sv:263:3
	assign unused_fetch_addr_n0 = fetch_addr_n[0];
	// Trace: core/rtl/ibex_if_stage.sv:265:3
	assign branch_req = pc_set_i | predict_branch_taken;
	// Trace: core/rtl/ibex_if_stage.sv:266:3
	assign branch_spec = pc_set_spec_i | predict_branch_taken;
	// Trace: core/rtl/ibex_if_stage.sv:268:3
	assign pc_if_o = if_instr_addr;
	// Trace: core/rtl/ibex_if_stage.sv:269:3
	assign if_busy_o = prefetch_busy;
	// Trace: core/rtl/ibex_if_stage.sv:276:3
	wire [31:0] instr_decompressed;
	// Trace: core/rtl/ibex_if_stage.sv:277:3
	wire illegal_c_insn;
	// Trace: core/rtl/ibex_if_stage.sv:278:3
	wire instr_is_compressed;
	// Trace: core/rtl/ibex_if_stage.sv:280:3
	ibex_compressed_decoder compressed_decoder_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.valid_i(fetch_valid & ~fetch_err),
		.instr_i(if_instr_rdata),
		.instr_o(instr_decompressed),
		.is_compressed_o(instr_is_compressed),
		.illegal_instr_o(illegal_c_insn)
	);
	// Trace: core/rtl/ibex_if_stage.sv:291:3
	generate
		if (DummyInstructions) begin : gen_dummy_instr
			// Trace: core/rtl/ibex_if_stage.sv:292:5
			wire insert_dummy_instr;
			// Trace: core/rtl/ibex_if_stage.sv:293:5
			wire [31:0] dummy_instr_data;
			// Trace: core/rtl/ibex_if_stage.sv:295:5
			ibex_dummy_instr dummy_instr_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.dummy_instr_en_i(dummy_instr_en_i),
				.dummy_instr_mask_i(dummy_instr_mask_i),
				.dummy_instr_seed_en_i(dummy_instr_seed_en_i),
				.dummy_instr_seed_i(dummy_instr_seed_i),
				.fetch_valid_i(fetch_valid),
				.id_in_ready_i(id_in_ready_i),
				.insert_dummy_instr_o(insert_dummy_instr),
				.dummy_instr_data_o(dummy_instr_data)
			);
			// Trace: core/rtl/ibex_if_stage.sv:309:5
			assign instr_out = (insert_dummy_instr ? dummy_instr_data : instr_decompressed);
			// Trace: core/rtl/ibex_if_stage.sv:310:5
			assign instr_is_compressed_out = (insert_dummy_instr ? 1'b0 : instr_is_compressed);
			// Trace: core/rtl/ibex_if_stage.sv:311:5
			assign illegal_c_instr_out = (insert_dummy_instr ? 1'b0 : illegal_c_insn);
			// Trace: core/rtl/ibex_if_stage.sv:312:5
			assign instr_err_out = (insert_dummy_instr ? 1'b0 : if_instr_err);
			// Trace: core/rtl/ibex_if_stage.sv:317:5
			assign stall_dummy_instr = insert_dummy_instr;
			// Trace: core/rtl/ibex_if_stage.sv:320:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_if_stage.sv:321:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_if_stage.sv:322:9
					dummy_instr_id_o <= 1'b0;
				else if (if_id_pipe_reg_we)
					// Trace: core/rtl/ibex_if_stage.sv:324:9
					dummy_instr_id_o <= insert_dummy_instr;
		end
		else begin : gen_no_dummy_instr
			// Trace: core/rtl/ibex_if_stage.sv:329:5
			wire unused_dummy_en;
			// Trace: core/rtl/ibex_if_stage.sv:330:5
			wire [2:0] unused_dummy_mask;
			// Trace: core/rtl/ibex_if_stage.sv:331:5
			wire unused_dummy_seed_en;
			// Trace: core/rtl/ibex_if_stage.sv:332:5
			wire [31:0] unused_dummy_seed;
			// Trace: core/rtl/ibex_if_stage.sv:334:5
			assign unused_dummy_en = dummy_instr_en_i;
			// Trace: core/rtl/ibex_if_stage.sv:335:5
			assign unused_dummy_mask = dummy_instr_mask_i;
			// Trace: core/rtl/ibex_if_stage.sv:336:5
			assign unused_dummy_seed_en = dummy_instr_seed_en_i;
			// Trace: core/rtl/ibex_if_stage.sv:337:5
			assign unused_dummy_seed = dummy_instr_seed_i;
			// Trace: core/rtl/ibex_if_stage.sv:338:5
			assign instr_out = instr_decompressed;
			// Trace: core/rtl/ibex_if_stage.sv:339:5
			assign instr_is_compressed_out = instr_is_compressed;
			// Trace: core/rtl/ibex_if_stage.sv:340:5
			assign illegal_c_instr_out = illegal_c_insn;
			// Trace: core/rtl/ibex_if_stage.sv:341:5
			assign instr_err_out = if_instr_err;
			// Trace: core/rtl/ibex_if_stage.sv:342:5
			assign stall_dummy_instr = 1'b0;
			// Trace: core/rtl/ibex_if_stage.sv:343:5
			wire [1:1] sv2v_tmp_C8A0C;
			assign sv2v_tmp_C8A0C = 1'b0;
			always @(*) dummy_instr_id_o = sv2v_tmp_C8A0C;
		end
	endgenerate
	// Trace: core/rtl/ibex_if_stage.sv:349:3
	assign instr_valid_id_d = ((if_instr_valid & id_in_ready_i) & ~pc_set_i) | (instr_valid_id_q & ~instr_valid_clear_i);
	// Trace: core/rtl/ibex_if_stage.sv:351:3
	assign instr_new_id_d = if_instr_valid & id_in_ready_i;
	// Trace: core/rtl/ibex_if_stage.sv:353:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_if_stage.sv:354:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_if_stage.sv:355:7
			instr_valid_id_q <= 1'b0;
			// Trace: core/rtl/ibex_if_stage.sv:356:7
			instr_new_id_q <= 1'b0;
		end
		else begin
			// Trace: core/rtl/ibex_if_stage.sv:358:7
			instr_valid_id_q <= instr_valid_id_d;
			// Trace: core/rtl/ibex_if_stage.sv:359:7
			instr_new_id_q <= instr_new_id_d;
		end
	// Trace: core/rtl/ibex_if_stage.sv:363:3
	assign instr_valid_id_o = instr_valid_id_q;
	// Trace: core/rtl/ibex_if_stage.sv:365:3
	assign instr_new_id_o = instr_new_id_q;
	// Trace: core/rtl/ibex_if_stage.sv:368:3
	assign if_id_pipe_reg_we = instr_new_id_d;
	// Trace: core/rtl/ibex_if_stage.sv:370:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_if_stage.sv:371:5
		if (if_id_pipe_reg_we) begin
			// Trace: core/rtl/ibex_if_stage.sv:372:7
			instr_rdata_id_o <= instr_out;
			// Trace: core/rtl/ibex_if_stage.sv:374:7
			instr_rdata_alu_id_o <= instr_out;
			// Trace: core/rtl/ibex_if_stage.sv:375:7
			instr_fetch_err_o <= instr_err_out;
			// Trace: core/rtl/ibex_if_stage.sv:376:7
			instr_fetch_err_plus2_o <= fetch_err_plus2;
			// Trace: core/rtl/ibex_if_stage.sv:377:7
			instr_rdata_c_id_o <= if_instr_rdata[15:0];
			// Trace: core/rtl/ibex_if_stage.sv:378:7
			instr_is_compressed_id_o <= instr_is_compressed_out;
			// Trace: core/rtl/ibex_if_stage.sv:379:7
			illegal_c_insn_id_o <= illegal_c_instr_out;
			// Trace: core/rtl/ibex_if_stage.sv:380:7
			pc_id_o <= pc_if_o;
		end
	// Trace: core/rtl/ibex_if_stage.sv:385:3
	generate
		if (PCIncrCheck) begin : g_secure_pc
			// Trace: core/rtl/ibex_if_stage.sv:386:5
			wire [31:0] prev_instr_addr_incr;
			// Trace: core/rtl/ibex_if_stage.sv:387:5
			reg prev_instr_seq_q;
			wire prev_instr_seq_d;
			// Trace: core/rtl/ibex_if_stage.sv:391:5
			assign prev_instr_seq_d = ((prev_instr_seq_q | instr_new_id_d) & ~branch_req) & ~stall_dummy_instr;
			// Trace: core/rtl/ibex_if_stage.sv:394:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_if_stage.sv:395:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_if_stage.sv:396:9
					prev_instr_seq_q <= 1'b0;
				else
					// Trace: core/rtl/ibex_if_stage.sv:398:9
					prev_instr_seq_q <= prev_instr_seq_d;
			// Trace: core/rtl/ibex_if_stage.sv:402:5
			assign prev_instr_addr_incr = pc_id_o + (instr_is_compressed_id_o && !instr_fetch_err_o ? 32'd2 : 32'd4);
			// Trace: core/rtl/ibex_if_stage.sv:406:5
			assign pc_mismatch_alert_o = prev_instr_seq_q & (pc_if_o != prev_instr_addr_incr);
		end
		else begin : g_no_secure_pc
			// Trace: core/rtl/ibex_if_stage.sv:409:5
			assign pc_mismatch_alert_o = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_if_stage.sv:412:3
	generate
		if (BranchPredictor) begin : g_branch_predictor
			// Trace: core/rtl/ibex_if_stage.sv:413:5
			reg [31:0] instr_skid_data_q;
			// Trace: core/rtl/ibex_if_stage.sv:414:5
			reg [31:0] instr_skid_addr_q;
			// Trace: core/rtl/ibex_if_stage.sv:415:5
			reg instr_skid_bp_taken_q;
			// Trace: core/rtl/ibex_if_stage.sv:416:5
			reg instr_skid_valid_q;
			wire instr_skid_valid_d;
			// Trace: core/rtl/ibex_if_stage.sv:417:5
			wire instr_skid_en;
			// Trace: core/rtl/ibex_if_stage.sv:418:5
			reg instr_bp_taken_q;
			wire instr_bp_taken_d;
			// Trace: core/rtl/ibex_if_stage.sv:420:5
			wire predict_branch_taken_raw;
			// Trace: core/rtl/ibex_if_stage.sv:423:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_if_stage.sv:424:7
				if (if_id_pipe_reg_we)
					// Trace: core/rtl/ibex_if_stage.sv:425:9
					instr_bp_taken_q <= instr_bp_taken_d;
			// Trace: core/rtl/ibex_if_stage.sv:437:5
			assign instr_skid_en = (predicted_branch & ~id_in_ready_i) & ~instr_skid_valid_q;
			// Trace: core/rtl/ibex_if_stage.sv:439:5
			assign instr_skid_valid_d = ((instr_skid_valid_q & ~id_in_ready_i) & ~stall_dummy_instr) | instr_skid_en;
			// Trace: core/rtl/ibex_if_stage.sv:442:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_if_stage.sv:443:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_if_stage.sv:444:9
					instr_skid_valid_q <= 1'b0;
				else
					// Trace: core/rtl/ibex_if_stage.sv:446:9
					instr_skid_valid_q <= instr_skid_valid_d;
			// Trace: core/rtl/ibex_if_stage.sv:450:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_if_stage.sv:451:7
				if (instr_skid_en) begin
					// Trace: core/rtl/ibex_if_stage.sv:452:9
					instr_skid_bp_taken_q <= predict_branch_taken;
					// Trace: core/rtl/ibex_if_stage.sv:453:9
					instr_skid_data_q <= fetch_rdata;
					// Trace: core/rtl/ibex_if_stage.sv:454:9
					instr_skid_addr_q <= fetch_addr;
				end
			// Trace: core/rtl/ibex_if_stage.sv:458:5
			ibex_branch_predict branch_predict_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.fetch_rdata_i(fetch_rdata),
				.fetch_pc_i(fetch_addr),
				.fetch_valid_i(fetch_valid),
				.predict_branch_taken_o(predict_branch_taken_raw),
				.predict_branch_pc_o(predict_branch_pc)
			);
			// Trace: core/rtl/ibex_if_stage.sv:473:5
			assign predict_branch_taken = (predict_branch_taken_raw & ~instr_skid_valid_q) & ~fetch_err;
			// Trace: core/rtl/ibex_if_stage.sv:476:5
			assign predicted_branch = predict_branch_taken & ~pc_set_i;
			// Trace: core/rtl/ibex_if_stage.sv:478:5
			assign if_instr_valid = fetch_valid | instr_skid_valid_q;
			// Trace: core/rtl/ibex_if_stage.sv:479:5
			assign if_instr_rdata = (instr_skid_valid_q ? instr_skid_data_q : fetch_rdata);
			// Trace: core/rtl/ibex_if_stage.sv:480:5
			assign if_instr_addr = (instr_skid_valid_q ? instr_skid_addr_q : fetch_addr);
			// Trace: core/rtl/ibex_if_stage.sv:484:5
			assign if_instr_err = ~instr_skid_valid_q & fetch_err;
			// Trace: core/rtl/ibex_if_stage.sv:485:5
			assign instr_bp_taken_d = (instr_skid_valid_q ? instr_skid_bp_taken_q : predict_branch_taken);
			// Trace: core/rtl/ibex_if_stage.sv:487:5
			assign fetch_ready = (id_in_ready_i & ~stall_dummy_instr) & ~instr_skid_valid_q;
			// Trace: core/rtl/ibex_if_stage.sv:489:5
			assign instr_bp_taken_o = instr_bp_taken_q;
		end
		else begin : g_no_branch_predictor
			// Trace: core/rtl/ibex_if_stage.sv:494:5
			assign instr_bp_taken_o = 1'b0;
			// Trace: core/rtl/ibex_if_stage.sv:495:5
			assign predict_branch_taken = 1'b0;
			// Trace: core/rtl/ibex_if_stage.sv:496:5
			assign predicted_branch = 1'b0;
			// Trace: core/rtl/ibex_if_stage.sv:497:5
			assign predict_branch_pc = 32'b00000000000000000000000000000000;
			// Trace: core/rtl/ibex_if_stage.sv:499:5
			assign if_instr_valid = fetch_valid;
			// Trace: core/rtl/ibex_if_stage.sv:500:5
			assign if_instr_rdata = fetch_rdata;
			// Trace: core/rtl/ibex_if_stage.sv:501:5
			assign if_instr_addr = fetch_addr;
			// Trace: core/rtl/ibex_if_stage.sv:502:5
			assign if_instr_err = fetch_err;
			// Trace: core/rtl/ibex_if_stage.sv:503:5
			assign fetch_ready = id_in_ready_i & ~stall_dummy_instr;
		end
	endgenerate
	// Trace: core/rtl/ibex_if_stage.sv:513:3
	initial _sv2v_0 = 0;
endmodule
