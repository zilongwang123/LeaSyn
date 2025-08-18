module ctr_decode (
	instr_i,
	format_o,
	op_o,
	funct_3_o,
	funct_7_o,
	rd_o,
	rs1_o,
	rs2_o,
	imm_o
);
	// Trace: core/ctr_decode.v:48:5
	input [31:0] instr_i;
	// Trace: core/ctr_decode.v:49:5
	output wire [2:0] format_o;
	// Trace: core/ctr_decode.v:50:5
	output wire [6:0] op_o;
	// Trace: core/ctr_decode.v:51:5
	output wire [2:0] funct_3_o;
	// Trace: core/ctr_decode.v:52:5
	output wire [6:0] funct_7_o;
	// Trace: core/ctr_decode.v:53:5
	output wire [4:0] rd_o;
	// Trace: core/ctr_decode.v:54:5
	output wire [4:0] rs1_o;
	// Trace: core/ctr_decode.v:55:5
	output wire [4:0] rs2_o;
	// Trace: core/ctr_decode.v:56:5
	output wire [31:0] imm_o;
	// Trace: core/ctr_decode.v:59:5
	assign op_o = instr_i[6:0];
	// Trace: core/ctr_decode.v:60:5
	assign funct_3_o = instr_i[14:12];
	// Trace: core/ctr_decode.v:61:5
	assign funct_7_o = instr_i[31:25];
	// Trace: core/ctr_decode.v:62:5
	assign format_o = ((((((((((op_o == 7'b0110011) || (op_o == 7'b0110011)) || (op_o == 7'b0110011)) || (op_o == 7'b0110011)) || (op_o == 7'b0110011)) || (op_o == 7'b0110011)) || (op_o == 7'b0110011)) || (op_o == 7'b0110011)) || (op_o == 7'b0110011)) || (op_o == 7'b0110011) ? 3'd0 : (((((((((((((((op_o == 7'b0010011) || (op_o == 7'b0010011)) || (op_o == 7'b0010011)) || (op_o == 7'b1100111)) || (op_o == 7'b0000011)) || (op_o == 7'b0000011)) || (op_o == 7'b0000011)) || (op_o == 7'b0000011)) || (op_o == 7'b0000011)) || (op_o == 7'b0010011)) || (op_o == 7'b0010011)) || (op_o == 7'b0010011)) || (op_o == 7'b0010011)) || (op_o == 7'b0010011)) || (op_o == 7'b0010011) ? 3'd1 : (((op_o == 7'b0100011) || (op_o == 7'b0100011)) || (op_o == 7'b0100011) ? 3'd2 : ((((((op_o == 7'b1100011) || (op_o == 7'b1100011)) || (op_o == 7'b1100011)) || (op_o == 7'b1100011)) || (op_o == 7'b1100011)) || (op_o == 7'b1100011) ? 3'd3 : ((op_o == 7'b0110111) || (op_o == 7'b0010111) ? 3'd4 : (op_o == 7'b1101111 ? 3'd5 : 3'd6))))));
	// Trace: core/ctr_decode.v:119:5
	assign rd_o = instr_i[11:7];
	// Trace: core/ctr_decode.v:120:5
	assign rs1_o = instr_i[19:15];
	// Trace: core/ctr_decode.v:121:5
	assign rs2_o = instr_i[24:20];
	// Trace: core/ctr_decode.v:122:5
	assign imm_o = (format_o == 3'd0 ? 32'b00000000000000000000000000000000 : (format_o == 3'd1 ? {20'b00000000000000000000, instr_i[31:20]} : (format_o == 3'd2 ? {20'b00000000000000000000, instr_i[31:25], instr_i[11:7]} : (format_o == 3'd3 ? {19'b0000000000000000000, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:6], 1'b0} : (format_o == 3'd4 ? {instr_i[31:12], 12'b000000000000} : (format_o == 3'd5 ? {12'b000000000000, instr_i[31], instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0} : 32'b00000000000000000000000000000000))))));
endmodule
