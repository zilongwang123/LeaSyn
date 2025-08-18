// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_decoder (
	clk_i,
	rst_ni,
	illegal_insn_o,
	ebrk_insn_o,
	mret_insn_o,
	dret_insn_o,
	ecall_insn_o,
	wfi_insn_o,
	jump_set_o,
	branch_taken_i,
	icache_inval_o,
	instr_first_cycle_i,
	instr_rdata_i,
	instr_rdata_alu_i,
	illegal_c_insn_i,
	imm_a_mux_sel_o,
	imm_b_mux_sel_o,
	bt_a_mux_sel_o,
	bt_b_mux_sel_o,
	imm_i_type_o,
	imm_s_type_o,
	imm_b_type_o,
	imm_u_type_o,
	imm_j_type_o,
	zimm_rs1_type_o,
	rf_wdata_sel_o,
	rf_we_o,
	rf_raddr_a_o,
	rf_raddr_b_o,
	rf_waddr_o,
	rf_ren_a_o,
	rf_ren_b_o,
	alu_operator_o,
	alu_op_a_mux_sel_o,
	alu_op_b_mux_sel_o,
	alu_multicycle_o,
	mult_en_o,
	div_en_o,
	mult_sel_o,
	div_sel_o,
	multdiv_operator_o,
	multdiv_signed_mode_o,
	csr_access_o,
	csr_op_o,
	data_req_o,
	data_we_o,
	data_type_o,
	data_sign_extension_o,
	jump_in_dec_o,
	branch_in_dec_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_decoder.sv:17:15
	parameter [0:0] RV32E = 0;
	// Trace: core/rtl/ibex_decoder.sv:18:15
	// removed localparam type ibex_pkg_rv32m_e
	parameter integer RV32M = 32'sd2;
	// Trace: core/rtl/ibex_decoder.sv:19:15
	// removed localparam type ibex_pkg_rv32b_e
	parameter integer RV32B = 32'sd0;
	// Trace: core/rtl/ibex_decoder.sv:20:15
	parameter [0:0] BranchTargetALU = 0;
	// Trace: core/rtl/ibex_decoder.sv:22:5
	input wire clk_i;
	// Trace: core/rtl/ibex_decoder.sv:23:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_decoder.sv:26:5
	output wire illegal_insn_o;
	// Trace: core/rtl/ibex_decoder.sv:27:5
	output reg ebrk_insn_o;
	// Trace: core/rtl/ibex_decoder.sv:28:5
	output reg mret_insn_o;
	// Trace: core/rtl/ibex_decoder.sv:30:5
	output reg dret_insn_o;
	// Trace: core/rtl/ibex_decoder.sv:31:5
	output reg ecall_insn_o;
	// Trace: core/rtl/ibex_decoder.sv:32:5
	output reg wfi_insn_o;
	// Trace: core/rtl/ibex_decoder.sv:33:5
	output reg jump_set_o;
	// Trace: core/rtl/ibex_decoder.sv:34:5
	input wire branch_taken_i;
	// Trace: core/rtl/ibex_decoder.sv:35:5
	output reg icache_inval_o;
	// Trace: core/rtl/ibex_decoder.sv:38:5
	input wire instr_first_cycle_i;
	// Trace: core/rtl/ibex_decoder.sv:39:5
	input wire [31:0] instr_rdata_i;
	// Trace: core/rtl/ibex_decoder.sv:40:5
	input wire [31:0] instr_rdata_alu_i;
	// Trace: core/rtl/ibex_decoder.sv:43:5
	input wire illegal_c_insn_i;
	// Trace: core/rtl/ibex_decoder.sv:46:5
	// removed localparam type ibex_pkg_imm_a_sel_e
	output reg imm_a_mux_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:47:5
	// removed localparam type ibex_pkg_imm_b_sel_e
	output reg [2:0] imm_b_mux_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:48:5
	// removed localparam type ibex_pkg_op_a_sel_e
	output reg [1:0] bt_a_mux_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:49:5
	output reg [2:0] bt_b_mux_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:50:5
	output wire [31:0] imm_i_type_o;
	// Trace: core/rtl/ibex_decoder.sv:51:5
	output wire [31:0] imm_s_type_o;
	// Trace: core/rtl/ibex_decoder.sv:52:5
	output wire [31:0] imm_b_type_o;
	// Trace: core/rtl/ibex_decoder.sv:53:5
	output wire [31:0] imm_u_type_o;
	// Trace: core/rtl/ibex_decoder.sv:54:5
	output wire [31:0] imm_j_type_o;
	// Trace: core/rtl/ibex_decoder.sv:55:5
	output wire [31:0] zimm_rs1_type_o;
	// Trace: core/rtl/ibex_decoder.sv:58:5
	// removed localparam type ibex_pkg_rf_wd_sel_e
	output reg rf_wdata_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:59:5
	output wire rf_we_o;
	// Trace: core/rtl/ibex_decoder.sv:60:5
	output wire [4:0] rf_raddr_a_o;
	// Trace: core/rtl/ibex_decoder.sv:61:5
	output wire [4:0] rf_raddr_b_o;
	// Trace: core/rtl/ibex_decoder.sv:62:5
	output wire [4:0] rf_waddr_o;
	// Trace: core/rtl/ibex_decoder.sv:63:5
	output reg rf_ren_a_o;
	// Trace: core/rtl/ibex_decoder.sv:64:5
	output reg rf_ren_b_o;
	// Trace: core/rtl/ibex_decoder.sv:67:5
	// removed localparam type ibex_pkg_alu_op_e
	output reg [5:0] alu_operator_o;
	// Trace: core/rtl/ibex_decoder.sv:68:5
	output reg [1:0] alu_op_a_mux_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:70:5
	// removed localparam type ibex_pkg_op_b_sel_e
	output reg alu_op_b_mux_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:72:5
	output reg alu_multicycle_o;
	// Trace: core/rtl/ibex_decoder.sv:75:5
	output wire mult_en_o;
	// Trace: core/rtl/ibex_decoder.sv:76:5
	output wire div_en_o;
	// Trace: core/rtl/ibex_decoder.sv:77:5
	output reg mult_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:78:5
	output reg div_sel_o;
	// Trace: core/rtl/ibex_decoder.sv:80:5
	// removed localparam type ibex_pkg_md_op_e
	output reg [1:0] multdiv_operator_o;
	// Trace: core/rtl/ibex_decoder.sv:81:5
	output reg [1:0] multdiv_signed_mode_o;
	// Trace: core/rtl/ibex_decoder.sv:84:5
	output reg csr_access_o;
	// Trace: core/rtl/ibex_decoder.sv:85:5
	// removed localparam type ibex_pkg_csr_op_e
	output reg [1:0] csr_op_o;
	// Trace: core/rtl/ibex_decoder.sv:88:5
	output reg data_req_o;
	// Trace: core/rtl/ibex_decoder.sv:89:5
	output reg data_we_o;
	// Trace: core/rtl/ibex_decoder.sv:90:5
	output reg [1:0] data_type_o;
	// Trace: core/rtl/ibex_decoder.sv:92:5
	output reg data_sign_extension_o;
	// Trace: core/rtl/ibex_decoder.sv:96:5
	output reg jump_in_dec_o;
	// Trace: core/rtl/ibex_decoder.sv:97:5
	output reg branch_in_dec_o;
	// Trace: core/rtl/ibex_decoder.sv:100:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_decoder.sv:102:3
	reg illegal_insn;
	// Trace: core/rtl/ibex_decoder.sv:103:3
	wire illegal_reg_rv32e;
	// Trace: core/rtl/ibex_decoder.sv:104:3
	reg csr_illegal;
	// Trace: core/rtl/ibex_decoder.sv:105:3
	reg rf_we;
	// Trace: core/rtl/ibex_decoder.sv:107:3
	wire [31:0] instr;
	// Trace: core/rtl/ibex_decoder.sv:108:3
	wire [31:0] instr_alu;
	// Trace: core/rtl/ibex_decoder.sv:109:3
	wire [9:0] unused_instr_alu;
	// Trace: core/rtl/ibex_decoder.sv:111:3
	wire [4:0] instr_rs1;
	// Trace: core/rtl/ibex_decoder.sv:112:3
	wire [4:0] instr_rs2;
	// Trace: core/rtl/ibex_decoder.sv:113:3
	wire [4:0] instr_rs3;
	// Trace: core/rtl/ibex_decoder.sv:114:3
	wire [4:0] instr_rd;
	// Trace: core/rtl/ibex_decoder.sv:116:3
	reg use_rs3_d;
	// Trace: core/rtl/ibex_decoder.sv:117:3
	reg use_rs3_q;
	// Trace: core/rtl/ibex_decoder.sv:119:3
	reg [1:0] csr_op;
	// Trace: core/rtl/ibex_decoder.sv:121:3
	// removed localparam type ibex_pkg_opcode_e
	reg [6:0] opcode;
	// Trace: core/rtl/ibex_decoder.sv:122:3
	reg [6:0] opcode_alu;
	// Trace: core/rtl/ibex_decoder.sv:127:3
	assign instr = instr_rdata_i;
	// Trace: core/rtl/ibex_decoder.sv:128:3
	assign instr_alu = instr_rdata_alu_i;
	// Trace: core/rtl/ibex_decoder.sv:135:3
	assign imm_i_type_o = {{20 {instr[31]}}, instr[31:20]};
	// Trace: core/rtl/ibex_decoder.sv:136:3
	assign imm_s_type_o = {{20 {instr[31]}}, instr[31:25], instr[11:7]};
	// Trace: core/rtl/ibex_decoder.sv:137:3
	assign imm_b_type_o = {{19 {instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
	// Trace: core/rtl/ibex_decoder.sv:138:3
	assign imm_u_type_o = {instr[31:12], 12'b000000000000};
	// Trace: core/rtl/ibex_decoder.sv:139:3
	assign imm_j_type_o = {{12 {instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
	// Trace: core/rtl/ibex_decoder.sv:142:3
	assign zimm_rs1_type_o = {27'b000000000000000000000000000, instr_rs1};
	// Trace: core/rtl/ibex_decoder.sv:144:3
	generate
		if (RV32B != 32'sd0) begin : gen_rs3_flop
			// Trace: core/rtl/ibex_decoder.sv:146:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_decoder.sv:147:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_decoder.sv:148:9
					use_rs3_q <= 1'b0;
				else
					// Trace: core/rtl/ibex_decoder.sv:150:9
					use_rs3_q <= use_rs3_d;
		end
		else begin : gen_no_rs3_flop
			// Trace: core/rtl/ibex_decoder.sv:155:5
			wire [1:1] sv2v_tmp_12378;
			assign sv2v_tmp_12378 = use_rs3_d;
			always @(*) use_rs3_q = sv2v_tmp_12378;
		end
	endgenerate
	// Trace: core/rtl/ibex_decoder.sv:159:3
	assign instr_rs1 = instr[19:15];
	// Trace: core/rtl/ibex_decoder.sv:160:3
	assign instr_rs2 = instr[24:20];
	// Trace: core/rtl/ibex_decoder.sv:161:3
	assign instr_rs3 = instr[31:27];
	// Trace: core/rtl/ibex_decoder.sv:162:3
	assign rf_raddr_a_o = (use_rs3_q & ~instr_first_cycle_i ? instr_rs3 : instr_rs1);
	// Trace: core/rtl/ibex_decoder.sv:163:3
	assign rf_raddr_b_o = instr_rs2;
	// Trace: core/rtl/ibex_decoder.sv:166:3
	assign instr_rd = instr[11:7];
	// Trace: core/rtl/ibex_decoder.sv:167:3
	assign rf_waddr_o = instr_rd;
	// Trace: core/rtl/ibex_decoder.sv:172:3
	generate
		if (RV32E) begin : gen_rv32e_reg_check_active
			// Trace: core/rtl/ibex_decoder.sv:173:5
			assign illegal_reg_rv32e = ((rf_raddr_a_o[4] & (alu_op_a_mux_sel_o == 2'd0)) | (rf_raddr_b_o[4] & (alu_op_b_mux_sel_o == 1'd0))) | (rf_waddr_o[4] & rf_we);
		end
		else begin : gen_rv32e_reg_check_inactive
			// Trace: core/rtl/ibex_decoder.sv:177:5
			assign illegal_reg_rv32e = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_decoder.sv:183:3
	always @(*) begin : csr_operand_check
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_decoder.sv:184:5
		csr_op_o = csr_op;
		// Trace: core/rtl/ibex_decoder.sv:188:5
		if (((csr_op == 2'd2) || (csr_op == 2'd3)) && (instr_rs1 == {5 {1'sb0}}))
			// Trace: core/rtl/ibex_decoder.sv:190:7
			csr_op_o = 2'd0;
	end
	// Trace: core/rtl/ibex_decoder.sv:198:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_decoder.sv:199:5
		jump_in_dec_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:200:5
		jump_set_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:201:5
		branch_in_dec_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:202:5
		icache_inval_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:204:5
		multdiv_operator_o = 2'd0;
		// Trace: core/rtl/ibex_decoder.sv:205:5
		multdiv_signed_mode_o = 2'b00;
		// Trace: core/rtl/ibex_decoder.sv:207:5
		rf_wdata_sel_o = 1'd0;
		// Trace: core/rtl/ibex_decoder.sv:208:5
		rf_we = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:209:5
		rf_ren_a_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:210:5
		rf_ren_b_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:212:5
		csr_access_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:213:5
		csr_illegal = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:214:5
		csr_op = 2'd0;
		// Trace: core/rtl/ibex_decoder.sv:216:5
		data_we_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:217:5
		data_type_o = 2'b11;
		// Trace: core/rtl/ibex_decoder.sv:218:5
		data_sign_extension_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:219:5
		data_req_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:221:5
		illegal_insn = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:222:5
		ebrk_insn_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:223:5
		mret_insn_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:224:5
		dret_insn_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:225:5
		ecall_insn_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:226:5
		wfi_insn_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:228:5
		opcode = instr[6:0];
		// Trace: core/rtl/ibex_decoder.sv:230:5
		(* full_case, parallel_case *)
		case (opcode)
			7'h6f: begin
				// Trace: core/rtl/ibex_decoder.sv:237:9
				jump_in_dec_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:239:9
				if (instr_first_cycle_i) begin
					// Trace: core/rtl/ibex_decoder.sv:241:11
					rf_we = BranchTargetALU;
					// Trace: core/rtl/ibex_decoder.sv:242:11
					jump_set_o = 1'b1;
				end
				else
					// Trace: core/rtl/ibex_decoder.sv:245:11
					rf_we = 1'b1;
			end
			7'h67: begin
				// Trace: core/rtl/ibex_decoder.sv:250:9
				jump_in_dec_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:252:9
				if (instr_first_cycle_i) begin
					// Trace: core/rtl/ibex_decoder.sv:254:11
					rf_we = BranchTargetALU;
					// Trace: core/rtl/ibex_decoder.sv:255:11
					jump_set_o = 1'b1;
				end
				else
					// Trace: core/rtl/ibex_decoder.sv:258:11
					rf_we = 1'b1;
				if (instr[14:12] != 3'b000)
					// Trace: core/rtl/ibex_decoder.sv:261:11
					illegal_insn = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:264:9
				rf_ren_a_o = 1'b1;
			end
			7'h63: begin
				// Trace: core/rtl/ibex_decoder.sv:268:9
				branch_in_dec_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:270:9
				(* full_case, parallel_case *)
				case (instr[14:12])
					3'b000, 3'b001, 3'b100, 3'b101, 3'b110, 3'b111:
						// Trace: core/rtl/ibex_decoder.sv:276:20
						illegal_insn = 1'b0;
					default:
						// Trace: core/rtl/ibex_decoder.sv:277:20
						illegal_insn = 1'b1;
				endcase
				// Trace: core/rtl/ibex_decoder.sv:280:9
				rf_ren_a_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:281:9
				rf_ren_b_o = 1'b1;
			end
			7'h23: begin
				// Trace: core/rtl/ibex_decoder.sv:289:9
				rf_ren_a_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:290:9
				rf_ren_b_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:291:9
				data_req_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:292:9
				data_we_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:294:9
				if (instr[14])
					// Trace: core/rtl/ibex_decoder.sv:295:11
					illegal_insn = 1'b1;
				(* full_case, parallel_case *)
				case (instr[13:12])
					2'b00:
						// Trace: core/rtl/ibex_decoder.sv:300:20
						data_type_o = 2'b10;
					2'b01:
						// Trace: core/rtl/ibex_decoder.sv:301:20
						data_type_o = 2'b01;
					2'b10:
						// Trace: core/rtl/ibex_decoder.sv:302:20
						data_type_o = 2'b00;
					default:
						// Trace: core/rtl/ibex_decoder.sv:303:20
						illegal_insn = 1'b1;
				endcase
			end
			7'h03: begin
				// Trace: core/rtl/ibex_decoder.sv:308:9
				rf_ren_a_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:309:9
				data_req_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:310:9
				data_type_o = 2'b00;
				// Trace: core/rtl/ibex_decoder.sv:313:9
				data_sign_extension_o = ~instr[14];
				// Trace: core/rtl/ibex_decoder.sv:316:9
				(* full_case, parallel_case *)
				case (instr[13:12])
					2'b00:
						// Trace: core/rtl/ibex_decoder.sv:317:18
						data_type_o = 2'b10;
					2'b01:
						// Trace: core/rtl/ibex_decoder.sv:318:18
						data_type_o = 2'b01;
					2'b10: begin
						// Trace: core/rtl/ibex_decoder.sv:320:13
						data_type_o = 2'b00;
						// Trace: core/rtl/ibex_decoder.sv:321:13
						if (instr[14])
							// Trace: core/rtl/ibex_decoder.sv:322:15
							illegal_insn = 1'b1;
					end
					default:
						// Trace: core/rtl/ibex_decoder.sv:326:13
						illegal_insn = 1'b1;
				endcase
			end
			7'h37:
				// Trace: core/rtl/ibex_decoder.sv:336:9
				rf_we = 1'b1;
			7'h17:
				// Trace: core/rtl/ibex_decoder.sv:340:9
				rf_we = 1'b1;
			7'h13: begin
				// Trace: core/rtl/ibex_decoder.sv:344:9
				rf_ren_a_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:345:9
				rf_we = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:347:9
				(* full_case, parallel_case *)
				case (instr[14:12])
					3'b000, 3'b010, 3'b011, 3'b100, 3'b110, 3'b111:
						// Trace: core/rtl/ibex_decoder.sv:353:19
						illegal_insn = 1'b0;
					3'b001:
						// Trace: core/rtl/ibex_decoder.sv:356:13
						(* full_case, parallel_case *)
						case (instr[31:27])
							5'b00000:
								// Trace: core/rtl/ibex_decoder.sv:357:26
								illegal_insn = (instr[26:25] == 2'b00 ? 1'b0 : 1'b1);
							5'b00100, 5'b01001, 5'b00101, 5'b01101:
								// Trace: core/rtl/ibex_decoder.sv:361:26
								illegal_insn = (RV32B != 32'sd0 ? 1'b0 : 1'b1);
							5'b00001:
								if (instr[26] == 1'b0)
									// Trace: core/rtl/ibex_decoder.sv:363:17
									illegal_insn = (RV32B == 32'sd2 ? 1'b0 : 1'b1);
								else
									// Trace: core/rtl/ibex_decoder.sv:365:17
									illegal_insn = 1'b1;
							5'b01100:
								// Trace: core/rtl/ibex_decoder.sv:368:17
								(* full_case, parallel_case *)
								case (instr[26:20])
									7'b0000000, 7'b0000001, 7'b0000010, 7'b0000100, 7'b0000101:
										// Trace: core/rtl/ibex_decoder.sv:373:32
										illegal_insn = (RV32B != 32'sd0 ? 1'b0 : 1'b1);
									7'b0010000, 7'b0010001, 7'b0010010, 7'b0011000, 7'b0011001, 7'b0011010:
										// Trace: core/rtl/ibex_decoder.sv:379:32
										illegal_insn = (RV32B == 32'sd2 ? 1'b0 : 1'b1);
									default:
										// Trace: core/rtl/ibex_decoder.sv:381:28
										illegal_insn = 1'b1;
								endcase
							default:
								// Trace: core/rtl/ibex_decoder.sv:384:25
								illegal_insn = 1'b1;
						endcase
					3'b101:
						// Trace: core/rtl/ibex_decoder.sv:389:13
						if (instr[26])
							// Trace: core/rtl/ibex_decoder.sv:390:15
							illegal_insn = (RV32B != 32'sd0 ? 1'b0 : 1'b1);
						else
							// Trace: core/rtl/ibex_decoder.sv:392:15
							(* full_case, parallel_case *)
							case (instr[31:27])
								5'b00000, 5'b01000:
									// Trace: core/rtl/ibex_decoder.sv:394:28
									illegal_insn = (instr[26:25] == 2'b00 ? 1'b0 : 1'b1);
								5'b00100, 5'b01100, 5'b01001:
									// Trace: core/rtl/ibex_decoder.sv:398:28
									illegal_insn = (RV32B != 32'sd0 ? 1'b0 : 1'b1);
								5'b01101:
									// Trace: core/rtl/ibex_decoder.sv:401:19
									if (RV32B == 32'sd2)
										// Trace: core/rtl/ibex_decoder.sv:402:21
										illegal_insn = 1'b0;
									else
										// Trace: core/rtl/ibex_decoder.sv:404:21
										(* full_case, parallel_case *)
										case (instr[24:20])
											5'b11111, 5'b11000:
												// Trace: core/rtl/ibex_decoder.sv:406:33
												illegal_insn = (RV32B == 32'sd1 ? 1'b0 : 1'b1);
											default:
												// Trace: core/rtl/ibex_decoder.sv:408:32
												illegal_insn = 1'b1;
										endcase
								5'b00101:
									// Trace: core/rtl/ibex_decoder.sv:413:19
									if (RV32B == 32'sd2)
										// Trace: core/rtl/ibex_decoder.sv:414:21
										illegal_insn = 1'b0;
									else if (instr[24:20] == 5'b00111)
										// Trace: core/rtl/ibex_decoder.sv:416:21
										illegal_insn = (RV32B == 32'sd1 ? 1'b0 : 1'b1);
									else
										// Trace: core/rtl/ibex_decoder.sv:418:21
										illegal_insn = 1'b1;
								5'b00001:
									// Trace: core/rtl/ibex_decoder.sv:422:19
									if (instr[26] == 1'b0)
										// Trace: core/rtl/ibex_decoder.sv:423:21
										illegal_insn = (RV32B == 32'sd2 ? 1'b0 : 1'b1);
									else
										// Trace: core/rtl/ibex_decoder.sv:425:21
										illegal_insn = 1'b1;
								default:
									// Trace: core/rtl/ibex_decoder.sv:429:26
									illegal_insn = 1'b1;
							endcase
					default:
						// Trace: core/rtl/ibex_decoder.sv:434:20
						illegal_insn = 1'b1;
				endcase
			end
			7'h33: begin
				// Trace: core/rtl/ibex_decoder.sv:439:9
				rf_ren_a_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:440:9
				rf_ren_b_o = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:441:9
				rf_we = 1'b1;
				// Trace: core/rtl/ibex_decoder.sv:442:9
				if ({instr[26], instr[13:12]} == 3'b101)
					// Trace: core/rtl/ibex_decoder.sv:443:11
					illegal_insn = (RV32B != 32'sd0 ? 1'b0 : 1'b1);
				else
					// Trace: core/rtl/ibex_decoder.sv:445:11
					(* full_case, parallel_case *)
					case ({instr[31:25], instr[14:12]})
						10'b0000000000, 10'b0100000000, 10'b0000000010, 10'b0000000011, 10'b0000000100, 10'b0000000110, 10'b0000000111, 10'b0000000001, 10'b0000000101, 10'b0100000101:
							// Trace: core/rtl/ibex_decoder.sv:456:36
							illegal_insn = 1'b0;
						10'b0100000111, 10'b0100000110, 10'b0100000100, 10'b0010000001, 10'b0010000101, 10'b0110000001, 10'b0110000101, 10'b0000101100, 10'b0000101101, 10'b0000101110, 10'b0000101111, 10'b0000100100, 10'b0100100100, 10'b0000100111, 10'b0100100001, 10'b0010100001, 10'b0110100001, 10'b0100100101, 10'b0100100111:
							// Trace: core/rtl/ibex_decoder.sv:479:36
							illegal_insn = (RV32B != 32'sd0 ? 1'b0 : 1'b1);
						10'b0100100110, 10'b0000100110, 10'b0110100101, 10'b0010100101, 10'b0000100001, 10'b0000100101, 10'b0000101001, 10'b0000101010, 10'b0000101011:
							// Trace: core/rtl/ibex_decoder.sv:491:36
							illegal_insn = (RV32B == 32'sd2 ? 1'b0 : 1'b1);
						10'b0000001000: begin
							// Trace: core/rtl/ibex_decoder.sv:495:15
							multdiv_operator_o = 2'd0;
							// Trace: core/rtl/ibex_decoder.sv:496:15
							multdiv_signed_mode_o = 2'b00;
							// Trace: core/rtl/ibex_decoder.sv:497:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						10'b0000001001: begin
							// Trace: core/rtl/ibex_decoder.sv:500:15
							multdiv_operator_o = 2'd1;
							// Trace: core/rtl/ibex_decoder.sv:501:15
							multdiv_signed_mode_o = 2'b11;
							// Trace: core/rtl/ibex_decoder.sv:502:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						10'b0000001010: begin
							// Trace: core/rtl/ibex_decoder.sv:505:15
							multdiv_operator_o = 2'd1;
							// Trace: core/rtl/ibex_decoder.sv:506:15
							multdiv_signed_mode_o = 2'b01;
							// Trace: core/rtl/ibex_decoder.sv:507:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						10'b0000001011: begin
							// Trace: core/rtl/ibex_decoder.sv:510:15
							multdiv_operator_o = 2'd1;
							// Trace: core/rtl/ibex_decoder.sv:511:15
							multdiv_signed_mode_o = 2'b00;
							// Trace: core/rtl/ibex_decoder.sv:512:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						10'b0000001100: begin
							// Trace: core/rtl/ibex_decoder.sv:515:15
							multdiv_operator_o = 2'd2;
							// Trace: core/rtl/ibex_decoder.sv:516:15
							multdiv_signed_mode_o = 2'b11;
							// Trace: core/rtl/ibex_decoder.sv:517:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						10'b0000001101: begin
							// Trace: core/rtl/ibex_decoder.sv:520:15
							multdiv_operator_o = 2'd2;
							// Trace: core/rtl/ibex_decoder.sv:521:15
							multdiv_signed_mode_o = 2'b00;
							// Trace: core/rtl/ibex_decoder.sv:522:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						10'b0000001110: begin
							// Trace: core/rtl/ibex_decoder.sv:525:15
							multdiv_operator_o = 2'd3;
							// Trace: core/rtl/ibex_decoder.sv:526:15
							multdiv_signed_mode_o = 2'b11;
							// Trace: core/rtl/ibex_decoder.sv:527:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						10'b0000001111: begin
							// Trace: core/rtl/ibex_decoder.sv:530:15
							multdiv_operator_o = 2'd3;
							// Trace: core/rtl/ibex_decoder.sv:531:15
							multdiv_signed_mode_o = 2'b00;
							// Trace: core/rtl/ibex_decoder.sv:532:15
							illegal_insn = (RV32M == 32'sd0 ? 1'b1 : 1'b0);
						end
						default:
							// Trace: core/rtl/ibex_decoder.sv:535:15
							illegal_insn = 1'b1;
					endcase
			end
			7'h0f:
				// Trace: core/rtl/ibex_decoder.sv:546:9
				(* full_case, parallel_case *)
				case (instr[14:12])
					3'b000:
						// Trace: core/rtl/ibex_decoder.sv:549:13
						rf_we = 1'b0;
					3'b001: begin
						// Trace: core/rtl/ibex_decoder.sv:556:13
						jump_in_dec_o = 1'b1;
						// Trace: core/rtl/ibex_decoder.sv:558:13
						rf_we = 1'b0;
						// Trace: core/rtl/ibex_decoder.sv:560:13
						if (instr_first_cycle_i) begin
							// Trace: core/rtl/ibex_decoder.sv:561:15
							jump_set_o = 1'b1;
							// Trace: core/rtl/ibex_decoder.sv:562:15
							icache_inval_o = 1'b1;
						end
					end
					default:
						// Trace: core/rtl/ibex_decoder.sv:566:13
						illegal_insn = 1'b1;
				endcase
			7'h73:
				// Trace: core/rtl/ibex_decoder.sv:572:9
				if (instr[14:12] == 3'b000) begin
					// Trace: core/rtl/ibex_decoder.sv:574:11
					(* full_case, parallel_case *)
					case (instr[31:20])
						12'h000:
							// Trace: core/rtl/ibex_decoder.sv:577:15
							ecall_insn_o = 1'b1;
						12'h001:
							// Trace: core/rtl/ibex_decoder.sv:581:15
							ebrk_insn_o = 1'b1;
						12'h302:
							// Trace: core/rtl/ibex_decoder.sv:584:15
							mret_insn_o = 1'b1;
						12'h7b2:
							// Trace: core/rtl/ibex_decoder.sv:587:15
							dret_insn_o = 1'b1;
						12'h105:
							// Trace: core/rtl/ibex_decoder.sv:590:15
							wfi_insn_o = 1'b1;
						default:
							// Trace: core/rtl/ibex_decoder.sv:593:15
							illegal_insn = 1'b1;
					endcase
					if ((instr_rs1 != 5'b00000) || (instr_rd != 5'b00000))
						// Trace: core/rtl/ibex_decoder.sv:598:13
						illegal_insn = 1'b1;
				end
				else begin
					// Trace: core/rtl/ibex_decoder.sv:602:11
					csr_access_o = 1'b1;
					// Trace: core/rtl/ibex_decoder.sv:603:11
					rf_wdata_sel_o = 1'd1;
					// Trace: core/rtl/ibex_decoder.sv:604:11
					rf_we = 1'b1;
					// Trace: core/rtl/ibex_decoder.sv:606:11
					if (~instr[14])
						// Trace: core/rtl/ibex_decoder.sv:607:13
						rf_ren_a_o = 1'b1;
					(* full_case, parallel_case *)
					case (instr[13:12])
						2'b01:
							// Trace: core/rtl/ibex_decoder.sv:611:22
							csr_op = 2'd1;
						2'b10:
							// Trace: core/rtl/ibex_decoder.sv:612:22
							csr_op = 2'd2;
						2'b11:
							// Trace: core/rtl/ibex_decoder.sv:613:22
							csr_op = 2'd3;
						default:
							// Trace: core/rtl/ibex_decoder.sv:614:22
							csr_illegal = 1'b1;
					endcase
					// Trace: core/rtl/ibex_decoder.sv:617:11
					illegal_insn = csr_illegal;
				end
			default:
				// Trace: core/rtl/ibex_decoder.sv:622:9
				illegal_insn = 1'b1;
		endcase
		if (illegal_c_insn_i)
			// Trace: core/rtl/ibex_decoder.sv:628:7
			illegal_insn = 1'b1;
		if (illegal_insn) begin
			// Trace: core/rtl/ibex_decoder.sv:637:7
			rf_we = 1'b0;
			// Trace: core/rtl/ibex_decoder.sv:638:7
			data_req_o = 1'b0;
			// Trace: core/rtl/ibex_decoder.sv:639:7
			data_we_o = 1'b0;
			// Trace: core/rtl/ibex_decoder.sv:640:7
			jump_in_dec_o = 1'b0;
			// Trace: core/rtl/ibex_decoder.sv:641:7
			jump_set_o = 1'b0;
			// Trace: core/rtl/ibex_decoder.sv:642:7
			branch_in_dec_o = 1'b0;
			// Trace: core/rtl/ibex_decoder.sv:643:7
			csr_access_o = 1'b0;
		end
	end
	// Trace: core/rtl/ibex_decoder.sv:651:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_decoder.sv:652:5
		alu_operator_o = 6'd38;
		// Trace: core/rtl/ibex_decoder.sv:653:5
		alu_op_a_mux_sel_o = 2'd3;
		// Trace: core/rtl/ibex_decoder.sv:654:5
		alu_op_b_mux_sel_o = 1'd1;
		// Trace: core/rtl/ibex_decoder.sv:656:5
		imm_a_mux_sel_o = 1'd1;
		// Trace: core/rtl/ibex_decoder.sv:657:5
		imm_b_mux_sel_o = 3'd0;
		// Trace: core/rtl/ibex_decoder.sv:659:5
		bt_a_mux_sel_o = 2'd2;
		// Trace: core/rtl/ibex_decoder.sv:660:5
		bt_b_mux_sel_o = 3'd0;
		// Trace: core/rtl/ibex_decoder.sv:663:5
		opcode_alu = instr_alu[6:0];
		// Trace: core/rtl/ibex_decoder.sv:665:5
		use_rs3_d = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:666:5
		alu_multicycle_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:667:5
		mult_sel_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:668:5
		div_sel_o = 1'b0;
		// Trace: core/rtl/ibex_decoder.sv:670:5
		(* full_case, parallel_case *)
		case (opcode_alu)
			7'h6f: begin
				// Trace: core/rtl/ibex_decoder.sv:677:9
				if (BranchTargetALU) begin
					// Trace: core/rtl/ibex_decoder.sv:678:11
					bt_a_mux_sel_o = 2'd2;
					// Trace: core/rtl/ibex_decoder.sv:679:11
					bt_b_mux_sel_o = 3'd4;
				end
				if (instr_first_cycle_i && !BranchTargetALU) begin
					// Trace: core/rtl/ibex_decoder.sv:685:11
					alu_op_a_mux_sel_o = 2'd2;
					// Trace: core/rtl/ibex_decoder.sv:686:11
					alu_op_b_mux_sel_o = 1'd1;
					// Trace: core/rtl/ibex_decoder.sv:687:11
					imm_b_mux_sel_o = 3'd4;
					// Trace: core/rtl/ibex_decoder.sv:688:11
					alu_operator_o = 6'd0;
				end
				else begin
					// Trace: core/rtl/ibex_decoder.sv:691:11
					alu_op_a_mux_sel_o = 2'd2;
					// Trace: core/rtl/ibex_decoder.sv:692:11
					alu_op_b_mux_sel_o = 1'd1;
					// Trace: core/rtl/ibex_decoder.sv:693:11
					imm_b_mux_sel_o = 3'd5;
					// Trace: core/rtl/ibex_decoder.sv:694:11
					alu_operator_o = 6'd0;
				end
			end
			7'h67: begin
				// Trace: core/rtl/ibex_decoder.sv:699:9
				if (BranchTargetALU) begin
					// Trace: core/rtl/ibex_decoder.sv:700:11
					bt_a_mux_sel_o = 2'd0;
					// Trace: core/rtl/ibex_decoder.sv:701:11
					bt_b_mux_sel_o = 3'd0;
				end
				if (instr_first_cycle_i && !BranchTargetALU) begin
					// Trace: core/rtl/ibex_decoder.sv:707:11
					alu_op_a_mux_sel_o = 2'd0;
					// Trace: core/rtl/ibex_decoder.sv:708:11
					alu_op_b_mux_sel_o = 1'd1;
					// Trace: core/rtl/ibex_decoder.sv:709:11
					imm_b_mux_sel_o = 3'd0;
					// Trace: core/rtl/ibex_decoder.sv:710:11
					alu_operator_o = 6'd0;
				end
				else begin
					// Trace: core/rtl/ibex_decoder.sv:713:11
					alu_op_a_mux_sel_o = 2'd2;
					// Trace: core/rtl/ibex_decoder.sv:714:11
					alu_op_b_mux_sel_o = 1'd1;
					// Trace: core/rtl/ibex_decoder.sv:715:11
					imm_b_mux_sel_o = 3'd5;
					// Trace: core/rtl/ibex_decoder.sv:716:11
					alu_operator_o = 6'd0;
				end
			end
			7'h63: begin
				// Trace: core/rtl/ibex_decoder.sv:722:9
				(* full_case, parallel_case *)
				case (instr_alu[14:12])
					3'b000:
						// Trace: core/rtl/ibex_decoder.sv:723:20
						alu_operator_o = 6'd23;
					3'b001:
						// Trace: core/rtl/ibex_decoder.sv:724:20
						alu_operator_o = 6'd24;
					3'b100:
						// Trace: core/rtl/ibex_decoder.sv:725:20
						alu_operator_o = 6'd19;
					3'b101:
						// Trace: core/rtl/ibex_decoder.sv:726:20
						alu_operator_o = 6'd21;
					3'b110:
						// Trace: core/rtl/ibex_decoder.sv:727:20
						alu_operator_o = 6'd20;
					3'b111:
						// Trace: core/rtl/ibex_decoder.sv:728:20
						alu_operator_o = 6'd22;
					default:
						;
				endcase
				if (BranchTargetALU) begin
					// Trace: core/rtl/ibex_decoder.sv:733:11
					bt_a_mux_sel_o = 2'd2;
					// Trace: core/rtl/ibex_decoder.sv:735:11
					bt_b_mux_sel_o = (branch_taken_i ? 3'd2 : 3'd5);
				end
				if (instr_first_cycle_i) begin
					// Trace: core/rtl/ibex_decoder.sv:742:11
					alu_op_a_mux_sel_o = 2'd0;
					// Trace: core/rtl/ibex_decoder.sv:743:11
					alu_op_b_mux_sel_o = 1'd0;
				end
				else begin
					// Trace: core/rtl/ibex_decoder.sv:746:11
					alu_op_a_mux_sel_o = 2'd2;
					// Trace: core/rtl/ibex_decoder.sv:747:11
					alu_op_b_mux_sel_o = 1'd1;
					// Trace: core/rtl/ibex_decoder.sv:749:11
					imm_b_mux_sel_o = (branch_taken_i ? 3'd2 : 3'd5);
					// Trace: core/rtl/ibex_decoder.sv:750:11
					alu_operator_o = 6'd0;
				end
			end
			7'h23: begin
				// Trace: core/rtl/ibex_decoder.sv:759:9
				alu_op_a_mux_sel_o = 2'd0;
				// Trace: core/rtl/ibex_decoder.sv:760:9
				alu_op_b_mux_sel_o = 1'd0;
				// Trace: core/rtl/ibex_decoder.sv:761:9
				alu_operator_o = 6'd0;
				// Trace: core/rtl/ibex_decoder.sv:763:9
				if (!instr_alu[14]) begin
					// Trace: core/rtl/ibex_decoder.sv:765:11
					imm_b_mux_sel_o = 3'd1;
					// Trace: core/rtl/ibex_decoder.sv:766:11
					alu_op_b_mux_sel_o = 1'd1;
				end
			end
			7'h03: begin
				// Trace: core/rtl/ibex_decoder.sv:771:9
				alu_op_a_mux_sel_o = 2'd0;
				// Trace: core/rtl/ibex_decoder.sv:774:9
				alu_operator_o = 6'd0;
				// Trace: core/rtl/ibex_decoder.sv:775:9
				alu_op_b_mux_sel_o = 1'd1;
				// Trace: core/rtl/ibex_decoder.sv:776:9
				imm_b_mux_sel_o = 3'd0;
			end
			7'h37: begin
				// Trace: core/rtl/ibex_decoder.sv:784:9
				alu_op_a_mux_sel_o = 2'd3;
				// Trace: core/rtl/ibex_decoder.sv:785:9
				alu_op_b_mux_sel_o = 1'd1;
				// Trace: core/rtl/ibex_decoder.sv:786:9
				imm_a_mux_sel_o = 1'd1;
				// Trace: core/rtl/ibex_decoder.sv:787:9
				imm_b_mux_sel_o = 3'd3;
				// Trace: core/rtl/ibex_decoder.sv:788:9
				alu_operator_o = 6'd0;
			end
			7'h17: begin
				// Trace: core/rtl/ibex_decoder.sv:792:9
				alu_op_a_mux_sel_o = 2'd2;
				// Trace: core/rtl/ibex_decoder.sv:793:9
				alu_op_b_mux_sel_o = 1'd1;
				// Trace: core/rtl/ibex_decoder.sv:794:9
				imm_b_mux_sel_o = 3'd3;
				// Trace: core/rtl/ibex_decoder.sv:795:9
				alu_operator_o = 6'd0;
			end
			7'h13: begin
				// Trace: core/rtl/ibex_decoder.sv:799:9
				alu_op_a_mux_sel_o = 2'd0;
				// Trace: core/rtl/ibex_decoder.sv:800:9
				alu_op_b_mux_sel_o = 1'd1;
				// Trace: core/rtl/ibex_decoder.sv:801:9
				imm_b_mux_sel_o = 3'd0;
				// Trace: core/rtl/ibex_decoder.sv:803:9
				(* full_case, parallel_case *)
				case (instr_alu[14:12])
					3'b000:
						// Trace: core/rtl/ibex_decoder.sv:804:19
						alu_operator_o = 6'd0;
					3'b010:
						// Trace: core/rtl/ibex_decoder.sv:805:19
						alu_operator_o = 6'd37;
					3'b011:
						// Trace: core/rtl/ibex_decoder.sv:806:19
						alu_operator_o = 6'd38;
					3'b100:
						// Trace: core/rtl/ibex_decoder.sv:807:19
						alu_operator_o = 6'd2;
					3'b110:
						// Trace: core/rtl/ibex_decoder.sv:808:19
						alu_operator_o = 6'd3;
					3'b111:
						// Trace: core/rtl/ibex_decoder.sv:809:19
						alu_operator_o = 6'd4;
					3'b001:
						// Trace: core/rtl/ibex_decoder.sv:812:13
						if (RV32B != 32'sd0)
							// Trace: core/rtl/ibex_decoder.sv:813:15
							(* full_case, parallel_case *)
							case (instr_alu[31:27])
								5'b00000:
									// Trace: core/rtl/ibex_decoder.sv:814:28
									alu_operator_o = 6'd10;
								5'b00100:
									// Trace: core/rtl/ibex_decoder.sv:815:28
									alu_operator_o = 6'd12;
								5'b01001:
									// Trace: core/rtl/ibex_decoder.sv:816:28
									alu_operator_o = 6'd44;
								5'b00101:
									// Trace: core/rtl/ibex_decoder.sv:817:28
									alu_operator_o = 6'd43;
								5'b01101:
									// Trace: core/rtl/ibex_decoder.sv:818:28
									alu_operator_o = 6'd45;
								5'b00001:
									if (instr_alu[26] == 0)
										// Trace: core/rtl/ibex_decoder.sv:820:52
										alu_operator_o = 6'd17;
								5'b01100:
									// Trace: core/rtl/ibex_decoder.sv:822:19
									(* full_case, parallel_case *)
									case (instr_alu[26:20])
										7'b0000000:
											// Trace: core/rtl/ibex_decoder.sv:823:34
											alu_operator_o = 6'd34;
										7'b0000001:
											// Trace: core/rtl/ibex_decoder.sv:824:34
											alu_operator_o = 6'd35;
										7'b0000010:
											// Trace: core/rtl/ibex_decoder.sv:825:34
											alu_operator_o = 6'd36;
										7'b0000100:
											// Trace: core/rtl/ibex_decoder.sv:826:34
											alu_operator_o = 6'd32;
										7'b0000101:
											// Trace: core/rtl/ibex_decoder.sv:827:34
											alu_operator_o = 6'd33;
										7'b0010000:
											// Trace: core/rtl/ibex_decoder.sv:829:23
											if (RV32B == 32'sd2) begin
												// Trace: core/rtl/ibex_decoder.sv:830:25
												alu_operator_o = 6'd53;
												// Trace: core/rtl/ibex_decoder.sv:831:25
												alu_multicycle_o = 1'b1;
											end
										7'b0010001:
											// Trace: core/rtl/ibex_decoder.sv:835:23
											if (RV32B == 32'sd2) begin
												// Trace: core/rtl/ibex_decoder.sv:836:25
												alu_operator_o = 6'd55;
												// Trace: core/rtl/ibex_decoder.sv:837:25
												alu_multicycle_o = 1'b1;
											end
										7'b0010010:
											// Trace: core/rtl/ibex_decoder.sv:841:23
											if (RV32B == 32'sd2) begin
												// Trace: core/rtl/ibex_decoder.sv:842:25
												alu_operator_o = 6'd57;
												// Trace: core/rtl/ibex_decoder.sv:843:25
												alu_multicycle_o = 1'b1;
											end
										7'b0011000:
											// Trace: core/rtl/ibex_decoder.sv:847:23
											if (RV32B == 32'sd2) begin
												// Trace: core/rtl/ibex_decoder.sv:848:25
												alu_operator_o = 6'd54;
												// Trace: core/rtl/ibex_decoder.sv:849:25
												alu_multicycle_o = 1'b1;
											end
										7'b0011001:
											// Trace: core/rtl/ibex_decoder.sv:853:23
											if (RV32B == 32'sd2) begin
												// Trace: core/rtl/ibex_decoder.sv:854:25
												alu_operator_o = 6'd56;
												// Trace: core/rtl/ibex_decoder.sv:855:25
												alu_multicycle_o = 1'b1;
											end
										7'b0011010:
											// Trace: core/rtl/ibex_decoder.sv:859:23
											if (RV32B == 32'sd2) begin
												// Trace: core/rtl/ibex_decoder.sv:860:25
												alu_operator_o = 6'd58;
												// Trace: core/rtl/ibex_decoder.sv:861:25
												alu_multicycle_o = 1'b1;
											end
										default:
											;
									endcase
								default:
									;
							endcase
						else
							// Trace: core/rtl/ibex_decoder.sv:871:15
							alu_operator_o = 6'd10;
					3'b101:
						// Trace: core/rtl/ibex_decoder.sv:876:13
						if (RV32B != 32'sd0) begin
							begin
								// Trace: core/rtl/ibex_decoder.sv:877:15
								if (instr_alu[26] == 1'b1) begin
									// Trace: core/rtl/ibex_decoder.sv:878:17
									alu_operator_o = 6'd42;
									// Trace: core/rtl/ibex_decoder.sv:879:17
									alu_multicycle_o = 1'b1;
									// Trace: core/rtl/ibex_decoder.sv:880:17
									if (instr_first_cycle_i)
										// Trace: core/rtl/ibex_decoder.sv:881:19
										use_rs3_d = 1'b1;
									else
										// Trace: core/rtl/ibex_decoder.sv:883:19
										use_rs3_d = 1'b0;
								end
								else
									// Trace: core/rtl/ibex_decoder.sv:886:17
									(* full_case, parallel_case *)
									case (instr_alu[31:27])
										5'b00000:
											// Trace: core/rtl/ibex_decoder.sv:887:30
											alu_operator_o = 6'd9;
										5'b01000:
											// Trace: core/rtl/ibex_decoder.sv:888:30
											alu_operator_o = 6'd8;
										5'b00100:
											// Trace: core/rtl/ibex_decoder.sv:889:30
											alu_operator_o = 6'd11;
										5'b01001:
											// Trace: core/rtl/ibex_decoder.sv:890:30
											alu_operator_o = 6'd46;
										5'b01100: begin
											// Trace: core/rtl/ibex_decoder.sv:892:21
											alu_operator_o = 6'd13;
											// Trace: core/rtl/ibex_decoder.sv:893:21
											alu_multicycle_o = 1'b1;
										end
										5'b01101:
											// Trace: core/rtl/ibex_decoder.sv:895:30
											alu_operator_o = 6'd15;
										5'b00101:
											// Trace: core/rtl/ibex_decoder.sv:896:30
											alu_operator_o = 6'd16;
										5'b00001:
											// Trace: core/rtl/ibex_decoder.sv:899:21
											if (RV32B == 32'sd2) begin
												begin
													// Trace: core/rtl/ibex_decoder.sv:900:23
													if (instr_alu[26] == 1'b0)
														// Trace: core/rtl/ibex_decoder.sv:900:50
														alu_operator_o = 6'd18;
												end
											end
										default:
											;
									endcase
							end
						end
						else
							// Trace: core/rtl/ibex_decoder.sv:908:15
							if (instr_alu[31:27] == 5'b00000)
								// Trace: core/rtl/ibex_decoder.sv:909:17
								alu_operator_o = 6'd9;
							else if (instr_alu[31:27] == 5'b01000)
								// Trace: core/rtl/ibex_decoder.sv:911:17
								alu_operator_o = 6'd8;
					default:
						;
				endcase
			end
			7'h33: begin
				// Trace: core/rtl/ibex_decoder.sv:921:9
				alu_op_a_mux_sel_o = 2'd0;
				// Trace: core/rtl/ibex_decoder.sv:922:9
				alu_op_b_mux_sel_o = 1'd0;
				// Trace: core/rtl/ibex_decoder.sv:924:9
				if (instr_alu[26]) begin
					begin
						// Trace: core/rtl/ibex_decoder.sv:925:11
						if (RV32B != 32'sd0)
							// Trace: core/rtl/ibex_decoder.sv:926:13
							(* full_case, parallel_case *)
							case ({instr_alu[26:25], instr_alu[14:12]})
								5'b11001: begin
									// Trace: core/rtl/ibex_decoder.sv:928:17
									alu_operator_o = 6'd40;
									// Trace: core/rtl/ibex_decoder.sv:929:17
									alu_multicycle_o = 1'b1;
									// Trace: core/rtl/ibex_decoder.sv:930:17
									if (instr_first_cycle_i)
										// Trace: core/rtl/ibex_decoder.sv:931:19
										use_rs3_d = 1'b1;
									else
										// Trace: core/rtl/ibex_decoder.sv:933:19
										use_rs3_d = 1'b0;
								end
								5'b11101: begin
									// Trace: core/rtl/ibex_decoder.sv:937:17
									alu_operator_o = 6'd39;
									// Trace: core/rtl/ibex_decoder.sv:938:17
									alu_multicycle_o = 1'b1;
									// Trace: core/rtl/ibex_decoder.sv:939:17
									if (instr_first_cycle_i)
										// Trace: core/rtl/ibex_decoder.sv:940:19
										use_rs3_d = 1'b1;
									else
										// Trace: core/rtl/ibex_decoder.sv:942:19
										use_rs3_d = 1'b0;
								end
								5'b10001: begin
									// Trace: core/rtl/ibex_decoder.sv:946:17
									alu_operator_o = 6'd41;
									// Trace: core/rtl/ibex_decoder.sv:947:17
									alu_multicycle_o = 1'b1;
									// Trace: core/rtl/ibex_decoder.sv:948:17
									if (instr_first_cycle_i)
										// Trace: core/rtl/ibex_decoder.sv:949:19
										use_rs3_d = 1'b1;
									else
										// Trace: core/rtl/ibex_decoder.sv:951:19
										use_rs3_d = 1'b0;
								end
								5'b10101: begin
									// Trace: core/rtl/ibex_decoder.sv:955:17
									alu_operator_o = 6'd42;
									// Trace: core/rtl/ibex_decoder.sv:956:17
									alu_multicycle_o = 1'b1;
									// Trace: core/rtl/ibex_decoder.sv:957:17
									if (instr_first_cycle_i)
										// Trace: core/rtl/ibex_decoder.sv:958:19
										use_rs3_d = 1'b1;
									else
										// Trace: core/rtl/ibex_decoder.sv:960:19
										use_rs3_d = 1'b0;
								end
								default:
									;
							endcase
					end
				end
				else
					// Trace: core/rtl/ibex_decoder.sv:967:11
					(* full_case, parallel_case *)
					case ({instr_alu[31:25], instr_alu[14:12]})
						10'b0000000000:
							// Trace: core/rtl/ibex_decoder.sv:969:36
							alu_operator_o = 6'd0;
						10'b0100000000:
							// Trace: core/rtl/ibex_decoder.sv:970:36
							alu_operator_o = 6'd1;
						10'b0000000010:
							// Trace: core/rtl/ibex_decoder.sv:971:36
							alu_operator_o = 6'd37;
						10'b0000000011:
							// Trace: core/rtl/ibex_decoder.sv:972:36
							alu_operator_o = 6'd38;
						10'b0000000100:
							// Trace: core/rtl/ibex_decoder.sv:973:36
							alu_operator_o = 6'd2;
						10'b0000000110:
							// Trace: core/rtl/ibex_decoder.sv:974:36
							alu_operator_o = 6'd3;
						10'b0000000111:
							// Trace: core/rtl/ibex_decoder.sv:975:36
							alu_operator_o = 6'd4;
						10'b0000000001:
							// Trace: core/rtl/ibex_decoder.sv:976:36
							alu_operator_o = 6'd10;
						10'b0000000101:
							// Trace: core/rtl/ibex_decoder.sv:977:36
							alu_operator_o = 6'd9;
						10'b0100000101:
							// Trace: core/rtl/ibex_decoder.sv:978:36
							alu_operator_o = 6'd8;
						10'b0010000001:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:981:60
								alu_operator_o = 6'd12;
						10'b0010000101:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:982:60
								alu_operator_o = 6'd11;
						10'b0110000001:
							// Trace: core/rtl/ibex_decoder.sv:984:15
							if (RV32B != 32'sd0) begin
								// Trace: core/rtl/ibex_decoder.sv:985:17
								alu_operator_o = 6'd14;
								// Trace: core/rtl/ibex_decoder.sv:986:17
								alu_multicycle_o = 1'b1;
							end
						10'b0110000101:
							// Trace: core/rtl/ibex_decoder.sv:990:15
							if (RV32B != 32'sd0) begin
								// Trace: core/rtl/ibex_decoder.sv:991:17
								alu_operator_o = 6'd13;
								// Trace: core/rtl/ibex_decoder.sv:992:17
								alu_multicycle_o = 1'b1;
							end
						10'b0000101100:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:996:60
								alu_operator_o = 6'd25;
						10'b0000101101:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:997:60
								alu_operator_o = 6'd27;
						10'b0000101110:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:998:60
								alu_operator_o = 6'd26;
						10'b0000101111:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:999:60
								alu_operator_o = 6'd28;
						10'b0000100100:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1001:60
								alu_operator_o = 6'd29;
						10'b0100100100:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1002:60
								alu_operator_o = 6'd30;
						10'b0000100111:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1003:60
								alu_operator_o = 6'd31;
						10'b0100000100:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1005:60
								alu_operator_o = 6'd5;
						10'b0100000110:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1006:60
								alu_operator_o = 6'd6;
						10'b0100000111:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1007:60
								alu_operator_o = 6'd7;
						10'b0100100001:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1010:60
								alu_operator_o = 6'd44;
						10'b0010100001:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1011:60
								alu_operator_o = 6'd43;
						10'b0110100001:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1012:60
								alu_operator_o = 6'd45;
						10'b0100100101:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1013:60
								alu_operator_o = 6'd46;
						10'b0100100111:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1016:60
								alu_operator_o = 6'd49;
						10'b0110100101:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1019:60
								alu_operator_o = 6'd15;
						10'b0010100101:
							if (RV32B != 32'sd0)
								// Trace: core/rtl/ibex_decoder.sv:1020:60
								alu_operator_o = 6'd16;
						10'b0000100001:
							if (RV32B == 32'sd2)
								// Trace: core/rtl/ibex_decoder.sv:1021:60
								alu_operator_o = 6'd17;
						10'b0000100101:
							if (RV32B == 32'sd2)
								// Trace: core/rtl/ibex_decoder.sv:1022:60
								alu_operator_o = 6'd18;
						10'b0000101001:
							if (RV32B == 32'sd2)
								// Trace: core/rtl/ibex_decoder.sv:1025:60
								alu_operator_o = 6'd50;
						10'b0000101010:
							if (RV32B == 32'sd2)
								// Trace: core/rtl/ibex_decoder.sv:1026:60
								alu_operator_o = 6'd51;
						10'b0000101011:
							if (RV32B == 32'sd2)
								// Trace: core/rtl/ibex_decoder.sv:1027:60
								alu_operator_o = 6'd52;
						10'b0100100110:
							// Trace: core/rtl/ibex_decoder.sv:1031:15
							if (RV32B == 32'sd2) begin
								// Trace: core/rtl/ibex_decoder.sv:1032:17
								alu_operator_o = 6'd48;
								// Trace: core/rtl/ibex_decoder.sv:1033:17
								alu_multicycle_o = 1'b1;
							end
						10'b0000100110:
							// Trace: core/rtl/ibex_decoder.sv:1037:15
							if (RV32B == 32'sd2) begin
								// Trace: core/rtl/ibex_decoder.sv:1038:17
								alu_operator_o = 6'd47;
								// Trace: core/rtl/ibex_decoder.sv:1039:17
								alu_multicycle_o = 1'b1;
							end
						10'b0000001000: begin
							// Trace: core/rtl/ibex_decoder.sv:1045:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1046:15
							mult_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						10'b0000001001: begin
							// Trace: core/rtl/ibex_decoder.sv:1049:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1050:15
							mult_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						10'b0000001010: begin
							// Trace: core/rtl/ibex_decoder.sv:1053:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1054:15
							mult_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						10'b0000001011: begin
							// Trace: core/rtl/ibex_decoder.sv:1057:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1058:15
							mult_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						10'b0000001100: begin
							// Trace: core/rtl/ibex_decoder.sv:1061:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1062:15
							div_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						10'b0000001101: begin
							// Trace: core/rtl/ibex_decoder.sv:1065:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1066:15
							div_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						10'b0000001110: begin
							// Trace: core/rtl/ibex_decoder.sv:1069:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1070:15
							div_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						10'b0000001111: begin
							// Trace: core/rtl/ibex_decoder.sv:1073:15
							alu_operator_o = 6'd0;
							// Trace: core/rtl/ibex_decoder.sv:1074:15
							div_sel_o = (RV32M == 32'sd0 ? 1'b0 : 1'b1);
						end
						default:
							;
					endcase
			end
			7'h0f:
				// Trace: core/rtl/ibex_decoder.sv:1087:9
				(* full_case, parallel_case *)
				case (instr_alu[14:12])
					3'b000: begin
						// Trace: core/rtl/ibex_decoder.sv:1090:13
						alu_operator_o = 6'd0;
						// Trace: core/rtl/ibex_decoder.sv:1091:13
						alu_op_a_mux_sel_o = 2'd0;
						// Trace: core/rtl/ibex_decoder.sv:1092:13
						alu_op_b_mux_sel_o = 1'd1;
					end
					3'b001:
						// Trace: core/rtl/ibex_decoder.sv:1096:13
						if (BranchTargetALU) begin
							// Trace: core/rtl/ibex_decoder.sv:1097:15
							bt_a_mux_sel_o = 2'd2;
							// Trace: core/rtl/ibex_decoder.sv:1098:15
							bt_b_mux_sel_o = 3'd5;
						end
						else begin
							// Trace: core/rtl/ibex_decoder.sv:1100:15
							alu_op_a_mux_sel_o = 2'd2;
							// Trace: core/rtl/ibex_decoder.sv:1101:15
							alu_op_b_mux_sel_o = 1'd1;
							// Trace: core/rtl/ibex_decoder.sv:1102:15
							imm_b_mux_sel_o = 3'd5;
							// Trace: core/rtl/ibex_decoder.sv:1103:15
							alu_operator_o = 6'd0;
						end
					default:
						;
				endcase
			7'h73:
				// Trace: core/rtl/ibex_decoder.sv:1111:9
				if (instr_alu[14:12] == 3'b000) begin
					// Trace: core/rtl/ibex_decoder.sv:1113:11
					alu_op_a_mux_sel_o = 2'd0;
					// Trace: core/rtl/ibex_decoder.sv:1114:11
					alu_op_b_mux_sel_o = 1'd1;
				end
				else begin
					// Trace: core/rtl/ibex_decoder.sv:1117:11
					alu_op_b_mux_sel_o = 1'd1;
					// Trace: core/rtl/ibex_decoder.sv:1118:11
					imm_a_mux_sel_o = 1'd0;
					// Trace: core/rtl/ibex_decoder.sv:1119:11
					imm_b_mux_sel_o = 3'd0;
					// Trace: core/rtl/ibex_decoder.sv:1121:11
					if (instr_alu[14])
						// Trace: core/rtl/ibex_decoder.sv:1123:13
						alu_op_a_mux_sel_o = 2'd3;
					else
						// Trace: core/rtl/ibex_decoder.sv:1125:13
						alu_op_a_mux_sel_o = 2'd0;
				end
			default:
				;
		endcase
	end
	// Trace: core/rtl/ibex_decoder.sv:1135:3
	assign mult_en_o = (illegal_insn ? 1'b0 : mult_sel_o);
	// Trace: core/rtl/ibex_decoder.sv:1136:3
	assign div_en_o = (illegal_insn ? 1'b0 : div_sel_o);
	// Trace: core/rtl/ibex_decoder.sv:1140:3
	assign illegal_insn_o = illegal_insn | illegal_reg_rv32e;
	// Trace: core/rtl/ibex_decoder.sv:1143:3
	assign rf_we_o = rf_we & ~illegal_reg_rv32e;
	// Trace: core/rtl/ibex_decoder.sv:1146:3
	assign unused_instr_alu = {instr_alu[19:15], instr_alu[11:7]};
	initial _sv2v_0 = 0;
endmodule
