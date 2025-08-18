// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_branch_predict (
	clk_i,
	rst_ni,
	fetch_rdata_i,
	fetch_pc_i,
	fetch_valid_i,
	predict_branch_taken_o,
	predict_branch_pc_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_branch_predict.sv:21:3
	input wire clk_i;
	// Trace: core/rtl/ibex_branch_predict.sv:22:3
	input wire rst_ni;
	// Trace: core/rtl/ibex_branch_predict.sv:25:3
	input wire [31:0] fetch_rdata_i;
	// Trace: core/rtl/ibex_branch_predict.sv:26:3
	input wire [31:0] fetch_pc_i;
	// Trace: core/rtl/ibex_branch_predict.sv:27:3
	input wire fetch_valid_i;
	// Trace: core/rtl/ibex_branch_predict.sv:30:3
	output wire predict_branch_taken_o;
	// Trace: core/rtl/ibex_branch_predict.sv:31:3
	output wire [31:0] predict_branch_pc_o;
	// Trace: core/rtl/ibex_branch_predict.sv:33:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_branch_predict.sv:35:3
	wire [31:0] imm_j_type;
	// Trace: core/rtl/ibex_branch_predict.sv:36:3
	wire [31:0] imm_b_type;
	// Trace: core/rtl/ibex_branch_predict.sv:37:3
	wire [31:0] imm_cj_type;
	// Trace: core/rtl/ibex_branch_predict.sv:38:3
	wire [31:0] imm_cb_type;
	// Trace: core/rtl/ibex_branch_predict.sv:40:3
	reg [31:0] branch_imm;
	// Trace: core/rtl/ibex_branch_predict.sv:42:3
	wire [31:0] instr;
	// Trace: core/rtl/ibex_branch_predict.sv:44:3
	wire instr_j;
	// Trace: core/rtl/ibex_branch_predict.sv:45:3
	wire instr_b;
	// Trace: core/rtl/ibex_branch_predict.sv:46:3
	wire instr_cj;
	// Trace: core/rtl/ibex_branch_predict.sv:47:3
	wire instr_cb;
	// Trace: core/rtl/ibex_branch_predict.sv:49:3
	wire instr_b_taken;
	// Trace: core/rtl/ibex_branch_predict.sv:52:3
	assign instr = fetch_rdata_i;
	// Trace: core/rtl/ibex_branch_predict.sv:58:3
	assign imm_j_type = {{12 {instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
	// Trace: core/rtl/ibex_branch_predict.sv:59:3
	assign imm_b_type = {{19 {instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
	// Trace: core/rtl/ibex_branch_predict.sv:62:3
	assign imm_cj_type = {{20 {instr[12]}}, instr[12], instr[8], instr[10:9], instr[6], instr[7], instr[2], instr[11], instr[5:3], 1'b0};
	// Trace: core/rtl/ibex_branch_predict.sv:65:3
	assign imm_cb_type = {{23 {instr[12]}}, instr[12], instr[6:5], instr[2], instr[11:10], instr[4:3], 1'b0};
	// Trace: core/rtl/ibex_branch_predict.sv:71:3
	// removed localparam type ibex_pkg_opcode_e
	assign instr_b = instr[6:0] == 7'h63;
	// Trace: core/rtl/ibex_branch_predict.sv:72:3
	assign instr_j = instr[6:0] == 7'h6f;
	// Trace: core/rtl/ibex_branch_predict.sv:75:3
	assign instr_cb = (instr[1:0] == 2'b01) & ((instr[15:13] == 3'b110) | (instr[15:13] == 3'b111));
	// Trace: core/rtl/ibex_branch_predict.sv:76:3
	assign instr_cj = (instr[1:0] == 2'b01) & ((instr[15:13] == 3'b101) | (instr[15:13] == 3'b001));
	// Trace: core/rtl/ibex_branch_predict.sv:79:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_branch_predict.sv:80:5
		branch_imm = imm_b_type;
		// Trace: core/rtl/ibex_branch_predict.sv:82:5
		(* full_case, parallel_case *)
		case (1'b1)
			instr_j:
				// Trace: core/rtl/ibex_branch_predict.sv:83:18
				branch_imm = imm_j_type;
			instr_b:
				// Trace: core/rtl/ibex_branch_predict.sv:84:18
				branch_imm = imm_b_type;
			instr_cj:
				// Trace: core/rtl/ibex_branch_predict.sv:85:18
				branch_imm = imm_cj_type;
			instr_cb:
				// Trace: core/rtl/ibex_branch_predict.sv:86:18
				branch_imm = imm_cb_type;
			default:
				;
		endcase
	end
	// Trace: core/rtl/ibex_branch_predict.sv:94:3
	assign instr_b_taken = (instr_b & imm_b_type[31]) | (instr_cb & imm_cb_type[31]);
	// Trace: core/rtl/ibex_branch_predict.sv:97:3
	assign predict_branch_taken_o = fetch_valid_i & ((instr_j | instr_cj) | instr_b_taken);
	// Trace: core/rtl/ibex_branch_predict.sv:99:3
	assign predict_branch_pc_o = fetch_pc_i + branch_imm;
	initial _sv2v_0 = 0;
endmodule
