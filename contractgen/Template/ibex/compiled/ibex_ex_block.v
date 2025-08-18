// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_ex_block (
	clk_i,
	rst_ni,
	alu_operator_i,
	alu_operand_a_i,
	alu_operand_b_i,
	alu_instr_first_cycle_i,
	bt_a_operand_i,
	bt_b_operand_i,
	multdiv_operator_i,
	mult_en_i,
	div_en_i,
	mult_sel_i,
	div_sel_i,
	multdiv_signed_mode_i,
	multdiv_operand_a_i,
	multdiv_operand_b_i,
	multdiv_ready_id_i,
	data_ind_timing_i,
	imd_val_we_o,
	imd_val_d_o,
	imd_val_q_i,
	alu_adder_result_ex_o,
	result_ex_o,
	branch_target_o,
	branch_decision_o,
	ex_valid_o
);
	// Trace: core/rtl/ibex_ex_block.sv:12:15
	// removed localparam type ibex_pkg_rv32m_e
	parameter integer RV32M = 32'sd2;
	// Trace: core/rtl/ibex_ex_block.sv:13:15
	// removed localparam type ibex_pkg_rv32b_e
	parameter integer RV32B = 32'sd0;
	// Trace: core/rtl/ibex_ex_block.sv:14:15
	parameter [0:0] BranchTargetALU = 0;
	// Trace: core/rtl/ibex_ex_block.sv:16:5
	input wire clk_i;
	// Trace: core/rtl/ibex_ex_block.sv:17:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_ex_block.sv:20:5
	// removed localparam type ibex_pkg_alu_op_e
	input wire [5:0] alu_operator_i;
	// Trace: core/rtl/ibex_ex_block.sv:21:5
	input wire [31:0] alu_operand_a_i;
	// Trace: core/rtl/ibex_ex_block.sv:22:5
	input wire [31:0] alu_operand_b_i;
	// Trace: core/rtl/ibex_ex_block.sv:23:5
	input wire alu_instr_first_cycle_i;
	// Trace: core/rtl/ibex_ex_block.sv:27:5
	input wire [31:0] bt_a_operand_i;
	// Trace: core/rtl/ibex_ex_block.sv:28:5
	input wire [31:0] bt_b_operand_i;
	// Trace: core/rtl/ibex_ex_block.sv:31:5
	// removed localparam type ibex_pkg_md_op_e
	input wire [1:0] multdiv_operator_i;
	// Trace: core/rtl/ibex_ex_block.sv:32:5
	input wire mult_en_i;
	// Trace: core/rtl/ibex_ex_block.sv:33:5
	input wire div_en_i;
	// Trace: core/rtl/ibex_ex_block.sv:34:5
	input wire mult_sel_i;
	// Trace: core/rtl/ibex_ex_block.sv:35:5
	input wire div_sel_i;
	// Trace: core/rtl/ibex_ex_block.sv:36:5
	input wire [1:0] multdiv_signed_mode_i;
	// Trace: core/rtl/ibex_ex_block.sv:37:5
	input wire [31:0] multdiv_operand_a_i;
	// Trace: core/rtl/ibex_ex_block.sv:38:5
	input wire [31:0] multdiv_operand_b_i;
	// Trace: core/rtl/ibex_ex_block.sv:39:5
	input wire multdiv_ready_id_i;
	// Trace: core/rtl/ibex_ex_block.sv:40:5
	input wire data_ind_timing_i;
	// Trace: core/rtl/ibex_ex_block.sv:43:5
	output wire [1:0] imd_val_we_o;
	// Trace: core/rtl/ibex_ex_block.sv:44:5
	output wire [67:0] imd_val_d_o;
	// Trace: core/rtl/ibex_ex_block.sv:45:5
	input wire [67:0] imd_val_q_i;
	// Trace: core/rtl/ibex_ex_block.sv:48:5
	output wire [31:0] alu_adder_result_ex_o;
	// Trace: core/rtl/ibex_ex_block.sv:49:5
	output wire [31:0] result_ex_o;
	// Trace: core/rtl/ibex_ex_block.sv:50:5
	output wire [31:0] branch_target_o;
	// Trace: core/rtl/ibex_ex_block.sv:51:5
	output wire branch_decision_o;
	// Trace: core/rtl/ibex_ex_block.sv:53:5
	output wire ex_valid_o;
	// Trace: core/rtl/ibex_ex_block.sv:56:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_ex_block.sv:58:3
	wire [31:0] alu_result;
	wire [31:0] multdiv_result;
	// Trace: core/rtl/ibex_ex_block.sv:60:3
	wire [32:0] multdiv_alu_operand_b;
	wire [32:0] multdiv_alu_operand_a;
	// Trace: core/rtl/ibex_ex_block.sv:61:3
	wire [33:0] alu_adder_result_ext;
	// Trace: core/rtl/ibex_ex_block.sv:62:3
	wire alu_cmp_result;
	wire alu_is_equal_result;
	// Trace: core/rtl/ibex_ex_block.sv:63:3
	wire multdiv_valid;
	// Trace: core/rtl/ibex_ex_block.sv:64:3
	wire multdiv_sel;
	// Trace: core/rtl/ibex_ex_block.sv:65:3
	wire [63:0] alu_imd_val_q;
	// Trace: core/rtl/ibex_ex_block.sv:66:3
	wire [63:0] alu_imd_val_d;
	// Trace: core/rtl/ibex_ex_block.sv:67:3
	wire [1:0] alu_imd_val_we;
	// Trace: core/rtl/ibex_ex_block.sv:68:3
	wire [67:0] multdiv_imd_val_d;
	// Trace: core/rtl/ibex_ex_block.sv:69:3
	wire [1:0] multdiv_imd_val_we;
	// Trace: core/rtl/ibex_ex_block.sv:76:3
	generate
		if (RV32M != 32'sd0) begin : gen_multdiv_m
			// Trace: core/rtl/ibex_ex_block.sv:77:5
			assign multdiv_sel = mult_sel_i | div_sel_i;
		end
		else begin : gen_multdiv_no_m
			// Trace: core/rtl/ibex_ex_block.sv:79:5
			assign multdiv_sel = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_ex_block.sv:83:3
	assign imd_val_d_o[34+:34] = (multdiv_sel ? multdiv_imd_val_d[34+:34] : {2'b00, alu_imd_val_d[32+:32]});
	// Trace: core/rtl/ibex_ex_block.sv:84:3
	assign imd_val_d_o[0+:34] = (multdiv_sel ? multdiv_imd_val_d[0+:34] : {2'b00, alu_imd_val_d[0+:32]});
	// Trace: core/rtl/ibex_ex_block.sv:85:3
	assign imd_val_we_o = (multdiv_sel ? multdiv_imd_val_we : alu_imd_val_we);
	// Trace: core/rtl/ibex_ex_block.sv:87:3
	assign alu_imd_val_q = {imd_val_q_i[65-:32], imd_val_q_i[31-:32]};
	// Trace: core/rtl/ibex_ex_block.sv:89:3
	assign result_ex_o = (multdiv_sel ? multdiv_result : alu_result);
	// Trace: core/rtl/ibex_ex_block.sv:92:3
	assign branch_decision_o = alu_cmp_result;
	// Trace: core/rtl/ibex_ex_block.sv:94:3
	generate
		if (BranchTargetALU) begin : g_branch_target_alu
			// Trace: core/rtl/ibex_ex_block.sv:95:5
			wire [32:0] bt_alu_result;
			// Trace: core/rtl/ibex_ex_block.sv:96:5
			wire unused_bt_carry;
			// Trace: core/rtl/ibex_ex_block.sv:98:5
			assign bt_alu_result = bt_a_operand_i + bt_b_operand_i;
			// Trace: core/rtl/ibex_ex_block.sv:100:5
			assign unused_bt_carry = bt_alu_result[32];
			// Trace: core/rtl/ibex_ex_block.sv:101:5
			assign branch_target_o = bt_alu_result[31:0];
		end
		else begin : g_no_branch_target_alu
			// Trace: core/rtl/ibex_ex_block.sv:104:5
			wire [31:0] unused_bt_a_operand;
			wire [31:0] unused_bt_b_operand;
			// Trace: core/rtl/ibex_ex_block.sv:106:5
			assign unused_bt_a_operand = bt_a_operand_i;
			// Trace: core/rtl/ibex_ex_block.sv:107:5
			assign unused_bt_b_operand = bt_b_operand_i;
			// Trace: core/rtl/ibex_ex_block.sv:109:5
			assign branch_target_o = alu_adder_result_ex_o;
		end
	endgenerate
	// Trace: core/rtl/ibex_ex_block.sv:116:3
	ibex_alu #(.RV32B(RV32B)) alu_i(
		.operator_i(alu_operator_i),
		.operand_a_i(alu_operand_a_i),
		.operand_b_i(alu_operand_b_i),
		.instr_first_cycle_i(alu_instr_first_cycle_i),
		.imd_val_q_i(alu_imd_val_q),
		.imd_val_we_o(alu_imd_val_we),
		.imd_val_d_o(alu_imd_val_d),
		.multdiv_operand_a_i(multdiv_alu_operand_a),
		.multdiv_operand_b_i(multdiv_alu_operand_b),
		.multdiv_sel_i(multdiv_sel),
		.adder_result_o(alu_adder_result_ex_o),
		.adder_result_ext_o(alu_adder_result_ext),
		.result_o(alu_result),
		.comparison_result_o(alu_cmp_result),
		.is_equal_result_o(alu_is_equal_result)
	);
	// Trace: core/rtl/ibex_ex_block.sv:140:3
	generate
		if (RV32M == 32'sd1) begin : gen_multdiv_slow
			// Trace: core/rtl/ibex_ex_block.sv:141:5
			ibex_multdiv_slow multdiv_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.mult_en_i(mult_en_i),
				.div_en_i(div_en_i),
				.mult_sel_i(mult_sel_i),
				.div_sel_i(div_sel_i),
				.operator_i(multdiv_operator_i),
				.signed_mode_i(multdiv_signed_mode_i),
				.op_a_i(multdiv_operand_a_i),
				.op_b_i(multdiv_operand_b_i),
				.alu_adder_ext_i(alu_adder_result_ext),
				.alu_adder_i(alu_adder_result_ex_o),
				.equal_to_zero_i(alu_is_equal_result),
				.data_ind_timing_i(data_ind_timing_i),
				.valid_o(multdiv_valid),
				.alu_operand_a_o(multdiv_alu_operand_a),
				.alu_operand_b_o(multdiv_alu_operand_b),
				.imd_val_q_i(imd_val_q_i),
				.imd_val_d_o(multdiv_imd_val_d),
				.imd_val_we_o(multdiv_imd_val_we),
				.multdiv_ready_id_i(multdiv_ready_id_i),
				.multdiv_result_o(multdiv_result)
			);
		end
		else if ((RV32M == 32'sd2) || (RV32M == 32'sd3)) begin : gen_multdiv_fast
			// Trace: core/rtl/ibex_ex_block.sv:166:5
			ibex_multdiv_fast #(.RV32M(RV32M)) multdiv_i(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.mult_en_i(mult_en_i),
				.div_en_i(div_en_i),
				.mult_sel_i(mult_sel_i),
				.div_sel_i(div_sel_i),
				.operator_i(multdiv_operator_i),
				.signed_mode_i(multdiv_signed_mode_i),
				.op_a_i(multdiv_operand_a_i),
				.op_b_i(multdiv_operand_b_i),
				.alu_operand_a_o(multdiv_alu_operand_a),
				.alu_operand_b_o(multdiv_alu_operand_b),
				.alu_adder_ext_i(alu_adder_result_ext),
				.alu_adder_i(alu_adder_result_ex_o),
				.equal_to_zero_i(alu_is_equal_result),
				.data_ind_timing_i(data_ind_timing_i),
				.imd_val_q_i(imd_val_q_i),
				.imd_val_d_o(multdiv_imd_val_d),
				.imd_val_we_o(multdiv_imd_val_we),
				.multdiv_ready_id_i(multdiv_ready_id_i),
				.valid_o(multdiv_valid),
				.multdiv_result_o(multdiv_result)
			);
		end
		else begin : gen_multdiv_none
			// Trace: core/rtl/ibex_ex_block.sv:194:5
			assign multdiv_alu_operand_a = 33'b000000000000000000000000000000000;
			// Trace: core/rtl/ibex_ex_block.sv:195:5
			assign multdiv_alu_operand_b = 33'b000000000000000000000000000000000;
		end
	endgenerate
	// Trace: core/rtl/ibex_ex_block.sv:201:3
	assign ex_valid_o = (multdiv_sel ? multdiv_valid : ~(|alu_imd_val_we));
endmodule
