// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_prefetch_buffer (
	clk_i,
	rst_ni,
	req_i,
	branch_i,
	branch_spec_i,
	predicted_branch_i,
	branch_mispredict_i,
	addr_i,
	ready_i,
	valid_o,
	rdata_o,
	addr_o,
	err_o,
	err_plus2_o,
	instr_req_o,
	instr_gnt_i,
	instr_addr_o,
	instr_rdata_i,
	instr_err_i,
	instr_pmp_err_i,
	instr_rvalid_i,
	busy_o
);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:13:13
	parameter [0:0] BranchPredictor = 1'b0;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:15:5
	input wire clk_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:16:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:18:5
	input wire req_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:20:5
	input wire branch_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:21:5
	input wire branch_spec_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:22:5
	input wire predicted_branch_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:23:5
	input wire branch_mispredict_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:24:5
	input wire [31:0] addr_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:27:5
	input wire ready_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:28:5
	output wire valid_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:29:5
	output wire [31:0] rdata_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:30:5
	output wire [31:0] addr_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:31:5
	output wire err_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:32:5
	output wire err_plus2_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:36:5
	output wire instr_req_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:37:5
	input wire instr_gnt_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:38:5
	output wire [31:0] instr_addr_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:39:5
	input wire [31:0] instr_rdata_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:40:5
	input wire instr_err_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:41:5
	input wire instr_pmp_err_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:42:5
	input wire instr_rvalid_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:45:5
	output wire busy_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:48:3
	localparam [31:0] NUM_REQS = 2;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:50:3
	wire branch_suppress;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:51:3
	wire valid_new_req;
	wire valid_req;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:52:3
	wire valid_req_d;
	reg valid_req_q;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:53:3
	wire discard_req_d;
	reg discard_req_q;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:54:3
	wire gnt_or_pmp_err;
	wire rvalid_or_pmp_err;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:55:3
	wire [1:0] rdata_outstanding_n;
	wire [1:0] rdata_outstanding_s;
	reg [1:0] rdata_outstanding_q;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:56:3
	wire [1:0] branch_discard_n;
	wire [1:0] branch_discard_s;
	reg [1:0] branch_discard_q;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:57:3
	wire [1:0] rdata_pmp_err_n;
	wire [1:0] rdata_pmp_err_s;
	reg [1:0] rdata_pmp_err_q;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:58:3
	wire [1:0] rdata_outstanding_rev;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:60:3
	wire [31:0] stored_addr_d;
	reg [31:0] stored_addr_q;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:61:3
	wire stored_addr_en;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:62:3
	wire [31:0] fetch_addr_d;
	reg [31:0] fetch_addr_q;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:63:3
	wire fetch_addr_en;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:64:3
	wire [31:0] branch_mispredict_addr;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:65:3
	wire [31:0] instr_addr;
	wire [31:0] instr_addr_w_aligned;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:66:3
	wire instr_or_pmp_err;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:68:3
	wire fifo_valid;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:69:3
	wire [31:0] fifo_addr;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:70:3
	wire fifo_ready;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:71:3
	wire fifo_clear;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:72:3
	wire [1:0] fifo_busy;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:74:3
	wire valid_raw;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:76:3
	wire [31:0] addr_next;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:78:3
	wire branch_or_mispredict;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:84:3
	assign busy_o = |rdata_outstanding_q | instr_req_o;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:86:3
	assign branch_or_mispredict = branch_i | branch_mispredict_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:94:3
	assign instr_or_pmp_err = instr_err_i | rdata_pmp_err_q[0];
	// Trace: core/rtl/ibex_prefetch_buffer.sv:99:3
	assign fifo_clear = branch_or_mispredict;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:102:3
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < NUM_REQS; _gv_i_1 = _gv_i_1 + 1) begin : gen_rd_rev
			localparam i = _gv_i_1;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:103:5
			assign rdata_outstanding_rev[i] = rdata_outstanding_q[1 - i];
		end
	endgenerate
	// Trace: core/rtl/ibex_prefetch_buffer.sv:109:3
	assign fifo_ready = ~&(fifo_busy | rdata_outstanding_rev);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:111:3
	ibex_fetch_fifo #(.NUM_REQS(NUM_REQS)) fifo_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.clear_i(fifo_clear),
		.busy_o(fifo_busy),
		.in_valid_i(fifo_valid),
		.in_addr_i(fifo_addr),
		.in_rdata_i(instr_rdata_i),
		.in_err_i(instr_or_pmp_err),
		.out_valid_o(valid_raw),
		.out_ready_i(ready_i),
		.out_rdata_o(rdata_o),
		.out_addr_o(addr_o),
		.out_addr_next_o(addr_next),
		.out_err_o(err_o),
		.out_err_plus2_o(err_plus2_o)
	);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:139:3
	assign branch_suppress = branch_spec_i & ~branch_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:142:3
	assign valid_new_req = ((~branch_suppress & req_i) & (fifo_ready | branch_or_mispredict)) & ~rdata_outstanding_q[1];
	// Trace: core/rtl/ibex_prefetch_buffer.sv:145:3
	assign valid_req = valid_req_q | valid_new_req;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:150:3
	assign gnt_or_pmp_err = instr_gnt_i | instr_pmp_err_i;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:153:3
	assign rvalid_or_pmp_err = rdata_outstanding_q[0] & (instr_rvalid_i | rdata_pmp_err_q[0]);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:156:3
	assign valid_req_d = valid_req & ~gnt_or_pmp_err;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:159:3
	assign discard_req_d = valid_req_q & (branch_or_mispredict | discard_req_q);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:178:3
	assign stored_addr_en = (valid_new_req & ~valid_req_q) & ~gnt_or_pmp_err;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:181:3
	assign stored_addr_d = instr_addr;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:184:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_prefetch_buffer.sv:185:5
		if (stored_addr_en)
			// Trace: core/rtl/ibex_prefetch_buffer.sv:186:7
			stored_addr_q <= stored_addr_d;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:190:3
	generate
		if (BranchPredictor) begin : g_branch_predictor
			// Trace: core/rtl/ibex_prefetch_buffer.sv:194:5
			reg [31:0] branch_mispredict_addr_q;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:195:5
			wire branch_mispredict_addr_en;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:197:5
			assign branch_mispredict_addr_en = branch_i & predicted_branch_i;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:199:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_prefetch_buffer.sv:200:7
				if (branch_mispredict_addr_en)
					// Trace: core/rtl/ibex_prefetch_buffer.sv:201:9
					branch_mispredict_addr_q <= addr_next;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:205:5
			assign branch_mispredict_addr = branch_mispredict_addr_q;
		end
		else begin : g_no_branch_predictor
			// Trace: core/rtl/ibex_prefetch_buffer.sv:207:5
			wire unused_predicted_branch;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:208:5
			wire [31:0] unused_addr_next;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:210:5
			assign unused_predicted_branch = predicted_branch_i;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:211:5
			assign unused_addr_next = addr_next;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:213:5
			assign branch_mispredict_addr = 1'sb0;
		end
	endgenerate
	// Trace: core/rtl/ibex_prefetch_buffer.sv:219:3
	assign fetch_addr_en = branch_or_mispredict | (valid_new_req & ~valid_req_q);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:221:3
	assign fetch_addr_d = (branch_i ? addr_i : (branch_mispredict_i ? {branch_mispredict_addr[31:2], 2'b00} : {fetch_addr_q[31:2], 2'b00})) + {{29 {1'b0}}, valid_new_req & ~valid_req_q, 2'b00};
	// Trace: core/rtl/ibex_prefetch_buffer.sv:227:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_prefetch_buffer.sv:228:5
		if (fetch_addr_en)
			// Trace: core/rtl/ibex_prefetch_buffer.sv:229:7
			fetch_addr_q <= fetch_addr_d;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:234:3
	assign instr_addr = (valid_req_q ? stored_addr_q : (branch_spec_i ? addr_i : (branch_mispredict_i ? branch_mispredict_addr : fetch_addr_q)));
	// Trace: core/rtl/ibex_prefetch_buffer.sv:239:3
	assign instr_addr_w_aligned = {instr_addr[31:2], 2'b00};
	// Trace: core/rtl/ibex_prefetch_buffer.sv:245:3
	genvar _gv_i_2;
	generate
		for (_gv_i_2 = 0; _gv_i_2 < NUM_REQS; _gv_i_2 = _gv_i_2 + 1) begin : g_outstanding_reqs
			localparam i = _gv_i_2;
			if (i == 0) begin : g_req0
				// Trace: core/rtl/ibex_prefetch_buffer.sv:250:7
				assign rdata_outstanding_n[i] = (valid_req & gnt_or_pmp_err) | rdata_outstanding_q[i];
				// Trace: core/rtl/ibex_prefetch_buffer.sv:254:7
				assign branch_discard_n[i] = (((valid_req & gnt_or_pmp_err) & discard_req_d) | (branch_or_mispredict & rdata_outstanding_q[i])) | branch_discard_q[i];
				// Trace: core/rtl/ibex_prefetch_buffer.sv:258:7
				assign rdata_pmp_err_n[i] = ((valid_req & ~rdata_outstanding_q[i]) & instr_pmp_err_i) | rdata_pmp_err_q[i];
			end
			else begin : g_reqtop
				// Trace: core/rtl/ibex_prefetch_buffer.sv:265:7
				assign rdata_outstanding_n[i] = ((valid_req & gnt_or_pmp_err) & rdata_outstanding_q[i - 1]) | rdata_outstanding_q[i];
				// Trace: core/rtl/ibex_prefetch_buffer.sv:268:7
				assign branch_discard_n[i] = ((((valid_req & gnt_or_pmp_err) & discard_req_d) & rdata_outstanding_q[i - 1]) | (branch_or_mispredict & rdata_outstanding_q[i])) | branch_discard_q[i];
				// Trace: core/rtl/ibex_prefetch_buffer.sv:272:7
				assign rdata_pmp_err_n[i] = (((valid_req & ~rdata_outstanding_q[i]) & instr_pmp_err_i) & rdata_outstanding_q[i - 1]) | rdata_pmp_err_q[i];
			end
		end
	endgenerate
	// Trace: core/rtl/ibex_prefetch_buffer.sv:279:3
	assign rdata_outstanding_s = (rvalid_or_pmp_err ? {1'b0, rdata_outstanding_n[1:1]} : rdata_outstanding_n);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:281:3
	assign branch_discard_s = (rvalid_or_pmp_err ? {1'b0, branch_discard_n[1:1]} : branch_discard_n);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:283:3
	assign rdata_pmp_err_s = (rvalid_or_pmp_err ? {1'b0, rdata_pmp_err_n[1:1]} : rdata_pmp_err_n);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:287:3
	assign fifo_valid = rvalid_or_pmp_err & ~branch_discard_q[0];
	// Trace: core/rtl/ibex_prefetch_buffer.sv:289:3
	assign fifo_addr = (branch_i ? addr_i : branch_mispredict_addr);
	// Trace: core/rtl/ibex_prefetch_buffer.sv:295:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_prefetch_buffer.sv:296:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_prefetch_buffer.sv:297:7
			valid_req_q <= 1'b0;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:298:7
			discard_req_q <= 1'b0;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:299:7
			rdata_outstanding_q <= 'b0;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:300:7
			branch_discard_q <= 'b0;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:301:7
			rdata_pmp_err_q <= 'b0;
		end
		else begin
			// Trace: core/rtl/ibex_prefetch_buffer.sv:303:7
			valid_req_q <= valid_req_d;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:304:7
			discard_req_q <= discard_req_d;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:305:7
			rdata_outstanding_q <= rdata_outstanding_s;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:306:7
			branch_discard_q <= branch_discard_s;
			// Trace: core/rtl/ibex_prefetch_buffer.sv:307:7
			rdata_pmp_err_q <= rdata_pmp_err_s;
		end
	// Trace: core/rtl/ibex_prefetch_buffer.sv:315:3
	assign instr_req_o = valid_req;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:316:3
	assign instr_addr_o = instr_addr_w_aligned;
	// Trace: core/rtl/ibex_prefetch_buffer.sv:318:3
	assign valid_o = valid_raw & ~branch_mispredict_i;
endmodule
