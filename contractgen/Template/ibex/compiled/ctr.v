// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ctr (
	clk_i,
	retire_i,
	instr_1_i,
	instr_2_i,
	rd_1,
	rd_2,
	rs1_1,
	rs1_2,
	rs2_1,
	rs2_2,
	reg_rs1_1,
	reg_rs1_2,
	reg_rs2_1,
	reg_rs2_2,
	reg_rd_1,
	reg_rd_2,
	mem_addr_1,
	mem_addr_2,
	mem_r_data_1,
	mem_r_data_2,
	mem_r_mask_1,
	mem_r_mask_2,
	mem_w_data_1,
	mem_w_data_2,
	mem_w_mask_1,
	mem_w_mask_2,
	new_pc_1,
	new_pc_2,
	ctr_equiv_o
);
	// Trace: verif/ctr.sv:124:5
	input wire clk_i;
	// Trace: verif/ctr.sv:125:5
	input wire retire_i;
	// Trace: verif/ctr.sv:126:5
	input wire [31:0] instr_1_i;
	// Trace: verif/ctr.sv:127:5
	input wire [31:0] instr_2_i;
	// Trace: verif/ctr.sv:128:5
	input wire [4:0] rd_1;
	// Trace: verif/ctr.sv:129:5
	input wire [4:0] rd_2;
	// Trace: verif/ctr.sv:130:5
	input wire [4:0] rs1_1;
	// Trace: verif/ctr.sv:131:5
	input wire [4:0] rs1_2;
	// Trace: verif/ctr.sv:132:5
	input wire [4:0] rs2_1;
	// Trace: verif/ctr.sv:133:5
	input wire [4:0] rs2_2;
	// Trace: verif/ctr.sv:134:5
	input wire [31:0] reg_rs1_1;
	// Trace: verif/ctr.sv:135:5
	input wire [31:0] reg_rs1_2;
	// Trace: verif/ctr.sv:136:5
	input wire [31:0] reg_rs2_1;
	// Trace: verif/ctr.sv:137:5
	input wire [31:0] reg_rs2_2;
	// Trace: verif/ctr.sv:138:5
	input wire [31:0] reg_rd_1;
	// Trace: verif/ctr.sv:139:5
	input wire [31:0] reg_rd_2;
	// Trace: verif/ctr.sv:140:5
	input wire [31:0] mem_addr_1;
	// Trace: verif/ctr.sv:141:5
	input wire [31:0] mem_addr_2;
	// Trace: verif/ctr.sv:142:5
	input wire [31:0] mem_r_data_1;
	// Trace: verif/ctr.sv:143:5
	input wire [31:0] mem_r_data_2;
	// Trace: verif/ctr.sv:144:5
	input wire [3:0] mem_r_mask_1;
	// Trace: verif/ctr.sv:145:5
	input wire [3:0] mem_r_mask_2;
	// Trace: verif/ctr.sv:146:5
	input wire [31:0] mem_w_data_1;
	// Trace: verif/ctr.sv:147:5
	input wire [31:0] mem_w_data_2;
	// Trace: verif/ctr.sv:148:5
	input wire [3:0] mem_w_mask_1;
	// Trace: verif/ctr.sv:149:5
	input wire [3:0] mem_w_mask_2;
	// Trace: verif/ctr.sv:150:5
	input wire [31:0] new_pc_1;
	// Trace: verif/ctr.sv:151:5
	input wire [31:0] new_pc_2;
	// Trace: verif/ctr.sv:152:5
	output reg ctr_equiv_o;
	// Trace: verif/ctr.sv:155:5
	reg [5:0] old_rd_1_1 = 0;
	// Trace: verif/ctr.sv:156:5
	reg [5:0] old_rd_1_2 = 0;
	// Trace: verif/ctr.sv:157:5
	reg [5:0] old_rd_1_3 = 0;
	// Trace: verif/ctr.sv:158:5
	reg [5:0] old_rd_1_4 = 0;
	// Trace: verif/ctr.sv:159:5
	reg [5:0] old_rd_2_1 = 0;
	// Trace: verif/ctr.sv:160:5
	reg [5:0] old_rd_2_2 = 0;
	// Trace: verif/ctr.sv:161:5
	reg [5:0] old_rd_2_3 = 0;
	// Trace: verif/ctr.sv:162:5
	reg [5:0] old_rd_2_4 = 0;
	// Trace: verif/ctr.sv:163:5
	always @(negedge clk_i)
		// Trace: verif/ctr.sv:164:9
		if (retire_i == 1) begin
			// Trace: verif/ctr.sv:165:13
			old_rd_1_1 <= {1'b1, rd_1};
			// Trace: verif/ctr.sv:166:13
			old_rd_1_2 <= old_rd_1_1;
			// Trace: verif/ctr.sv:167:13
			old_rd_1_3 <= old_rd_1_2;
			// Trace: verif/ctr.sv:168:13
			old_rd_1_4 <= old_rd_1_3;
			// Trace: verif/ctr.sv:169:13
			old_rd_2_1 <= {1'b1, rd_2};
			// Trace: verif/ctr.sv:170:13
			old_rd_2_2 <= old_rd_2_1;
			// Trace: verif/ctr.sv:171:13
			old_rd_2_3 <= old_rd_2_2;
			// Trace: verif/ctr.sv:172:13
			old_rd_2_4 <= old_rd_2_3;
		end
	// Trace: verif/ctr.sv:176:5
	wire raw_rs1_1_1;
	// Trace: verif/ctr.sv:177:5
	assign raw_rs1_1_1 = {1'b1, rs1_1} == old_rd_1_1;
	// Trace: verif/ctr.sv:178:5
	wire raw_rs2_1_1;
	// Trace: verif/ctr.sv:179:5
	assign raw_rs2_1_1 = {1'b1, rs2_1} == old_rd_1_1;
	// Trace: verif/ctr.sv:180:5
	wire waw_1_1;
	// Trace: verif/ctr.sv:181:5
	assign waw_1_1 = {1'b1, rd_1} == old_rd_1_1;
	// Trace: verif/ctr.sv:183:5
	wire raw_rs1_1_2;
	// Trace: verif/ctr.sv:184:5
	assign raw_rs1_1_2 = {1'b1, rs1_2} == old_rd_2_1;
	// Trace: verif/ctr.sv:185:5
	wire raw_rs2_1_2;
	// Trace: verif/ctr.sv:186:5
	assign raw_rs2_1_2 = {1'b1, rs2_2} == old_rd_2_1;
	// Trace: verif/ctr.sv:187:5
	wire waw_1_2;
	// Trace: verif/ctr.sv:188:5
	assign waw_1_2 = {1'b1, rd_2} == old_rd_2_1;
	// Trace: verif/ctr.sv:190:5
	wire raw_rs1_2_1;
	// Trace: verif/ctr.sv:191:5
	assign raw_rs1_2_1 = {1'b1, rs1_1} == old_rd_1_2;
	// Trace: verif/ctr.sv:192:5
	wire raw_rs2_2_1;
	// Trace: verif/ctr.sv:193:5
	assign raw_rs2_2_1 = {1'b1, rs2_1} == old_rd_1_2;
	// Trace: verif/ctr.sv:194:5
	wire waw_2_1;
	// Trace: verif/ctr.sv:195:5
	assign waw_2_1 = {1'b1, rd_1} == old_rd_1_2;
	// Trace: verif/ctr.sv:197:5
	wire raw_rs1_2_2;
	// Trace: verif/ctr.sv:198:5
	assign raw_rs1_2_2 = {1'b1, rs1_2} == old_rd_2_2;
	// Trace: verif/ctr.sv:199:5
	wire raw_rs2_2_2;
	// Trace: verif/ctr.sv:200:5
	assign raw_rs2_2_2 = {1'b1, rs2_2} == old_rd_2_2;
	// Trace: verif/ctr.sv:201:5
	wire waw_2_2;
	// Trace: verif/ctr.sv:202:5
	assign waw_2_2 = {1'b1, rd_2} == old_rd_2_2;
	// Trace: verif/ctr.sv:204:5
	wire raw_rs1_3_1;
	// Trace: verif/ctr.sv:205:5
	assign raw_rs1_3_1 = {1'b1, rs1_1} == old_rd_1_3;
	// Trace: verif/ctr.sv:206:5
	wire raw_rs2_3_1;
	// Trace: verif/ctr.sv:207:5
	assign raw_rs2_3_1 = {1'b1, rs2_1} == old_rd_1_3;
	// Trace: verif/ctr.sv:208:5
	wire waw_3_1;
	// Trace: verif/ctr.sv:209:5
	assign waw_3_1 = {1'b1, rd_1} == old_rd_1_3;
	// Trace: verif/ctr.sv:211:5
	wire raw_rs1_3_2;
	// Trace: verif/ctr.sv:212:5
	assign raw_rs1_3_2 = {1'b1, rs1_2} == old_rd_2_3;
	// Trace: verif/ctr.sv:213:5
	wire raw_rs2_3_2;
	// Trace: verif/ctr.sv:214:5
	assign raw_rs2_3_2 = {1'b1, rs2_2} == old_rd_2_3;
	// Trace: verif/ctr.sv:215:5
	wire waw_3_2;
	// Trace: verif/ctr.sv:216:5
	assign waw_3_2 = {1'b1, rd_2} == old_rd_2_3;
	// Trace: verif/ctr.sv:218:5
	wire raw_rs1_4_1;
	// Trace: verif/ctr.sv:219:5
	assign raw_rs1_4_1 = {1'b1, rs1_1} == old_rd_1_4;
	// Trace: verif/ctr.sv:220:5
	wire raw_rs2_4_1;
	// Trace: verif/ctr.sv:221:5
	assign raw_rs2_4_1 = {1'b1, rs2_1} == old_rd_1_4;
	// Trace: verif/ctr.sv:222:5
	wire waw_4_1;
	// Trace: verif/ctr.sv:223:5
	assign waw_4_1 = {1'b1, rd_1} == old_rd_1_4;
	// Trace: verif/ctr.sv:225:5
	wire raw_rs1_4_2;
	// Trace: verif/ctr.sv:226:5
	assign raw_rs1_4_2 = {1'b1, rs1_2} == old_rd_2_4;
	// Trace: verif/ctr.sv:227:5
	wire raw_rs2_4_2;
	// Trace: verif/ctr.sv:228:5
	assign raw_rs2_4_2 = {1'b1, rs2_2} == old_rd_2_4;
	// Trace: verif/ctr.sv:229:5
	wire waw_4_2;
	// Trace: verif/ctr.sv:230:5
	assign waw_4_2 = {1'b1, rd_2} == old_rd_2_4;
	// Trace: verif/ctr.sv:232:5
	reg [317:0] ctr_observation_1;
	// Trace: verif/ctr.sv:254:5
	reg [317:0] ctr_observation_2;
	// Trace: verif/ctr.sv:277:5
	wire [6:0] op_1;
	// Trace: verif/ctr.sv:278:5
	wire [2:0] funct_3_1;
	// Trace: verif/ctr.sv:279:5
	wire [6:0] funct_7_1;
	// Trace: verif/ctr.sv:280:5
	wire [2:0] format_1;
	// Trace: verif/ctr.sv:281:5
	wire [31:0] imm_1;
	// Trace: verif/ctr.sv:283:5
	wire is_branch_1;
	// Trace: verif/ctr.sv:284:5
	wire branch_taken_1;
	// Trace: verif/ctr.sv:285:5
	wire is_aligned_1;
	// Trace: verif/ctr.sv:286:5
	wire is_half_aligned_1;
	// Trace: verif/ctr.sv:287:5
	assign is_branch_1 = ((op_1 == 7'b1101111) || (op_1 == 7'b1100111)) || (op_1 == 7'b1100011);
	// Trace: verif/ctr.sv:288:5
	assign branch_taken_1 = (((((((op_1 == 7'b1101111) || (op_1 == 7'b1100111)) || (((op_1 == 7'b1100011) && (funct_3_1 == 3'b000)) && (reg_rs1_1 == reg_rs2_1))) || (((op_1 == 7'b1100011) && (funct_3_1 == 3'b001)) && (reg_rs1_1 != reg_rs2_1))) || (((op_1 == 7'b1100011) && (funct_3_1 == 3'b100)) && ($signed(reg_rs1_1) < $signed(reg_rs2_1)))) || (((op_1 == 7'b1100011) && (funct_3_1 == 3'b101)) && ($signed(reg_rs1_1) >= $signed(reg_rs2_1)))) || (((op_1 == 7'b1100011) && (funct_3_1 == 3'b110)) && (reg_rs1_1 < reg_rs2_1))) || (((op_1 == 7'b1100011) && (funct_3_1 == 3'b111)) && (reg_rs1_1 >= reg_rs2_1));
	// Trace: verif/ctr.sv:297:5
	assign is_aligned_1 = mem_addr_1[1:0] == 2'b00;
	// Trace: verif/ctr.sv:298:5
	assign is_half_aligned_1 = mem_addr_1[1:0] != 2'b11;
	// Trace: verif/ctr.sv:300:5
	riscv_decoder decoder_1(
		.instr_i(instr_1_i),
		.format_o(format_1),
		.op_o(op_1),
		.funct_3_o(funct_3_1),
		.funct_7_o(funct_7_1),
		.rd_o(),
		.rs1_o(),
		.rs2_o(),
		.imm_o(imm_1)
	);
	// Trace: verif/ctr.sv:312:5
	wire [6:0] op_2;
	// Trace: verif/ctr.sv:313:5
	wire [2:0] funct_3_2;
	// Trace: verif/ctr.sv:314:5
	wire [6:0] funct_7_2;
	// Trace: verif/ctr.sv:315:5
	wire [2:0] format_2;
	// Trace: verif/ctr.sv:316:5
	wire [31:0] imm_2;
	// Trace: verif/ctr.sv:318:5
	wire is_branch_2;
	// Trace: verif/ctr.sv:319:5
	wire branch_taken_2;
	// Trace: verif/ctr.sv:320:5
	wire is_aligned_2;
	// Trace: verif/ctr.sv:321:5
	wire is_half_aligned_2;
	// Trace: verif/ctr.sv:322:5
	assign is_branch_2 = ((op_2 == 7'b1101111) || (op_2 == 7'b1100111)) || (op_2 == 7'b1100011);
	// Trace: verif/ctr.sv:323:5
	assign branch_taken_2 = (((((((op_2 == 7'b1101111) || (op_2 == 7'b1100111)) || (((op_2 == 7'b1100011) && (funct_3_2 == 3'b000)) && (reg_rs1_2 == reg_rs2_2))) || (((op_2 == 7'b1100011) && (funct_3_2 == 3'b001)) && (reg_rs1_2 != reg_rs2_2))) || (((op_2 == 7'b1100011) && (funct_3_2 == 3'b100)) && ($signed(reg_rs1_2) < $signed(reg_rs2_2)))) || (((op_2 == 7'b1100011) && (funct_3_2 == 3'b101)) && ($signed(reg_rs1_2) >= $signed(reg_rs2_2)))) || (((op_2 == 7'b1100011) && (funct_3_2 == 3'b110)) && (reg_rs1_2 < reg_rs2_2))) || (((op_2 == 7'b1100011) && (funct_3_2 == 3'b111)) && (reg_rs1_2 >= reg_rs2_2));
	// Trace: verif/ctr.sv:332:5
	assign is_aligned_2 = mem_addr_2[1:0] == 2'b00;
	// Trace: verif/ctr.sv:333:5
	assign is_half_aligned_2 = mem_addr_2[1:0] != 2'b11;
	// Trace: verif/ctr.sv:335:5
	riscv_decoder decoder_2(
		.instr_i(instr_2_i),
		.format_o(format_2),
		.op_o(op_2),
		.funct_3_o(funct_3_2),
		.funct_7_o(funct_7_2),
		.rd_o(),
		.rs1_o(),
		.rs2_o(),
		.imm_o(imm_2)
	);
	// Trace: verif/ctr.sv:347:5
	initial begin
		// Trace: verif/ctr.sv:347:13
		ctr_equiv_o <= 1;
	end
	// Trace: verif/ctr.sv:348:5
	initial begin
		// Trace: verif/ctr.sv:348:13
		ctr_observation_1 <= 448'h0;
	end
	// Trace: verif/ctr.sv:349:5
	initial begin
		// Trace: verif/ctr.sv:349:13
		ctr_observation_2 <= 448'h0;
	end
	// Trace: verif/ctr.sv:351:5
	integer i;
	// Trace: verif/ctr.sv:352:5
	wire [31:0] temp;
	// Trace: verif/ctr.sv:353:5
	always @(negedge clk_i)
		// Trace: verif/ctr.sv:354:9
		if (retire_i == 1)
			// Trace: verif/ctr.sv:358:13
			ctr_equiv_o <= ctr_equiv_o && (ctr_observation_1 == ctr_observation_2);
endmodule
