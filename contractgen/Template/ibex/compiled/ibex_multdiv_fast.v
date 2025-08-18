// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_multdiv_fast (
	clk_i,
	rst_ni,
	mult_en_i,
	div_en_i,
	mult_sel_i,
	div_sel_i,
	operator_i,
	signed_mode_i,
	op_a_i,
	op_b_i,
	alu_adder_ext_i,
	alu_adder_i,
	equal_to_zero_i,
	data_ind_timing_i,
	alu_operand_a_o,
	alu_operand_b_o,
	imd_val_q_i,
	imd_val_d_o,
	imd_val_we_o,
	multdiv_ready_id_i,
	multdiv_result_o,
	valid_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_multdiv_fast.sv:18:15
	// removed localparam type ibex_pkg_rv32m_e
	parameter integer RV32M = 32'sd2;
	// Trace: core/rtl/ibex_multdiv_fast.sv:20:5
	input wire clk_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:21:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_multdiv_fast.sv:22:5
	input wire mult_en_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:23:5
	input wire div_en_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:24:5
	input wire mult_sel_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:25:5
	input wire div_sel_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:26:5
	// removed localparam type ibex_pkg_md_op_e
	input wire [1:0] operator_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:27:5
	input wire [1:0] signed_mode_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:28:5
	input wire [31:0] op_a_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:29:5
	input wire [31:0] op_b_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:30:5
	input wire [33:0] alu_adder_ext_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:31:5
	input wire [31:0] alu_adder_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:32:5
	input wire equal_to_zero_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:33:5
	input wire data_ind_timing_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:35:5
	output reg [32:0] alu_operand_a_o;
	// Trace: core/rtl/ibex_multdiv_fast.sv:36:5
	output reg [32:0] alu_operand_b_o;
	// Trace: core/rtl/ibex_multdiv_fast.sv:38:5
	input wire [67:0] imd_val_q_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:39:5
	output wire [67:0] imd_val_d_o;
	// Trace: core/rtl/ibex_multdiv_fast.sv:40:5
	output wire [1:0] imd_val_we_o;
	// Trace: core/rtl/ibex_multdiv_fast.sv:42:5
	input wire multdiv_ready_id_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:44:5
	output wire [31:0] multdiv_result_o;
	// Trace: core/rtl/ibex_multdiv_fast.sv:45:5
	output wire valid_o;
	// Trace: core/rtl/ibex_multdiv_fast.sv:48:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_multdiv_fast.sv:51:3
	wire signed [34:0] mac_res_signed;
	// Trace: core/rtl/ibex_multdiv_fast.sv:52:3
	wire [34:0] mac_res_ext;
	// Trace: core/rtl/ibex_multdiv_fast.sv:53:3
	reg [33:0] accum;
	// Trace: core/rtl/ibex_multdiv_fast.sv:54:3
	reg sign_a;
	reg sign_b;
	// Trace: core/rtl/ibex_multdiv_fast.sv:55:3
	reg mult_valid;
	// Trace: core/rtl/ibex_multdiv_fast.sv:56:3
	wire signed_mult;
	// Trace: core/rtl/ibex_multdiv_fast.sv:59:3
	reg [33:0] mac_res_d;
	reg [33:0] op_remainder_d;
	// Trace: core/rtl/ibex_multdiv_fast.sv:61:3
	wire [33:0] mac_res;
	// Trace: core/rtl/ibex_multdiv_fast.sv:64:3
	wire div_sign_a;
	wire div_sign_b;
	// Trace: core/rtl/ibex_multdiv_fast.sv:65:3
	reg is_greater_equal;
	// Trace: core/rtl/ibex_multdiv_fast.sv:66:3
	wire div_change_sign;
	wire rem_change_sign;
	// Trace: core/rtl/ibex_multdiv_fast.sv:67:3
	wire [31:0] one_shift;
	// Trace: core/rtl/ibex_multdiv_fast.sv:68:3
	wire [31:0] op_denominator_q;
	// Trace: core/rtl/ibex_multdiv_fast.sv:69:3
	reg [31:0] op_numerator_q;
	// Trace: core/rtl/ibex_multdiv_fast.sv:70:3
	reg [31:0] op_quotient_q;
	// Trace: core/rtl/ibex_multdiv_fast.sv:71:3
	reg [31:0] op_denominator_d;
	// Trace: core/rtl/ibex_multdiv_fast.sv:72:3
	reg [31:0] op_numerator_d;
	// Trace: core/rtl/ibex_multdiv_fast.sv:73:3
	reg [31:0] op_quotient_d;
	// Trace: core/rtl/ibex_multdiv_fast.sv:74:3
	wire [31:0] next_remainder;
	// Trace: core/rtl/ibex_multdiv_fast.sv:75:3
	wire [32:0] next_quotient;
	// Trace: core/rtl/ibex_multdiv_fast.sv:76:3
	wire [31:0] res_adder_h;
	// Trace: core/rtl/ibex_multdiv_fast.sv:77:3
	reg div_valid;
	// Trace: core/rtl/ibex_multdiv_fast.sv:78:3
	reg [4:0] div_counter_q;
	reg [4:0] div_counter_d;
	// Trace: core/rtl/ibex_multdiv_fast.sv:79:3
	wire multdiv_en;
	// Trace: core/rtl/ibex_multdiv_fast.sv:80:3
	reg mult_hold;
	// Trace: core/rtl/ibex_multdiv_fast.sv:81:3
	reg div_hold;
	// Trace: core/rtl/ibex_multdiv_fast.sv:82:3
	reg div_by_zero_d;
	reg div_by_zero_q;
	// Trace: core/rtl/ibex_multdiv_fast.sv:84:3
	wire mult_en_internal;
	// Trace: core/rtl/ibex_multdiv_fast.sv:85:3
	wire div_en_internal;
	// Trace: core/rtl/ibex_multdiv_fast.sv:87:3
	// removed localparam type md_fsm_e
	// Trace: core/rtl/ibex_multdiv_fast.sv:90:3
	reg [2:0] md_state_q;
	reg [2:0] md_state_d;
	// Trace: core/rtl/ibex_multdiv_fast.sv:92:3
	wire unused_mult_sel_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:93:3
	assign unused_mult_sel_i = mult_sel_i;
	// Trace: core/rtl/ibex_multdiv_fast.sv:95:3
	assign mult_en_internal = mult_en_i & ~mult_hold;
	// Trace: core/rtl/ibex_multdiv_fast.sv:96:3
	assign div_en_internal = div_en_i & ~div_hold;
	// Trace: core/rtl/ibex_multdiv_fast.sv:98:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_multdiv_fast.sv:99:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_multdiv_fast.sv:100:7
			div_counter_q <= 1'sb0;
			// Trace: core/rtl/ibex_multdiv_fast.sv:101:7
			md_state_q <= 3'd0;
			// Trace: core/rtl/ibex_multdiv_fast.sv:102:7
			op_numerator_q <= 1'sb0;
			// Trace: core/rtl/ibex_multdiv_fast.sv:103:7
			op_quotient_q <= 1'sb0;
			// Trace: core/rtl/ibex_multdiv_fast.sv:104:7
			div_by_zero_q <= 1'sb0;
		end
		else if (div_en_internal) begin
			// Trace: core/rtl/ibex_multdiv_fast.sv:106:7
			div_counter_q <= div_counter_d;
			// Trace: core/rtl/ibex_multdiv_fast.sv:107:7
			op_numerator_q <= op_numerator_d;
			// Trace: core/rtl/ibex_multdiv_fast.sv:108:7
			op_quotient_q <= op_quotient_d;
			// Trace: core/rtl/ibex_multdiv_fast.sv:109:7
			md_state_q <= md_state_d;
			// Trace: core/rtl/ibex_multdiv_fast.sv:110:7
			div_by_zero_q <= div_by_zero_d;
		end
	// Trace: core/rtl/ibex_multdiv_fast.sv:118:3
	assign multdiv_en = mult_en_internal | div_en_internal;
	// Trace: core/rtl/ibex_multdiv_fast.sv:121:3
	assign imd_val_d_o[34+:34] = (div_sel_i ? op_remainder_d : mac_res_d);
	// Trace: core/rtl/ibex_multdiv_fast.sv:122:3
	assign imd_val_we_o[0] = multdiv_en;
	// Trace: core/rtl/ibex_multdiv_fast.sv:124:3
	assign imd_val_d_o[0+:34] = {2'b00, op_denominator_d};
	// Trace: core/rtl/ibex_multdiv_fast.sv:125:3
	assign imd_val_we_o[1] = div_en_internal;
	// Trace: core/rtl/ibex_multdiv_fast.sv:126:3
	assign op_denominator_q = imd_val_q_i[31-:32];
	// Trace: core/rtl/ibex_multdiv_fast.sv:127:3
	wire [1:0] unused_imd_val;
	// Trace: core/rtl/ibex_multdiv_fast.sv:128:3
	assign unused_imd_val = imd_val_q_i[33-:2];
	// Trace: core/rtl/ibex_multdiv_fast.sv:129:3
	wire unused_mac_res_ext;
	// Trace: core/rtl/ibex_multdiv_fast.sv:130:3
	assign unused_mac_res_ext = mac_res_ext[34];
	// Trace: core/rtl/ibex_multdiv_fast.sv:132:3
	assign signed_mult = signed_mode_i != 2'b00;
	// Trace: core/rtl/ibex_multdiv_fast.sv:133:3
	assign multdiv_result_o = (div_sel_i ? imd_val_q_i[65-:32] : mac_res_d[31:0]);
	// Trace: core/rtl/ibex_multdiv_fast.sv:137:3
	generate
		if (RV32M == 32'sd3) begin : gen_mult_single_cycle
			// Trace: core/rtl/ibex_multdiv_fast.sv:139:5
			// removed localparam type mult_fsm_e
			// Trace: core/rtl/ibex_multdiv_fast.sv:142:5
			reg mult_state_q;
			reg mult_state_d;
			// Trace: core/rtl/ibex_multdiv_fast.sv:144:5
			wire signed [33:0] mult1_res;
			wire signed [33:0] mult2_res;
			wire signed [33:0] mult3_res;
			// Trace: core/rtl/ibex_multdiv_fast.sv:145:5
			wire [33:0] mult1_res_uns;
			// Trace: core/rtl/ibex_multdiv_fast.sv:146:5
			wire [33:32] unused_mult1_res_uns;
			// Trace: core/rtl/ibex_multdiv_fast.sv:147:5
			wire [15:0] mult1_op_a;
			wire [15:0] mult1_op_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:148:5
			wire [15:0] mult2_op_a;
			wire [15:0] mult2_op_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:149:5
			reg [15:0] mult3_op_a;
			reg [15:0] mult3_op_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:150:5
			wire mult1_sign_a;
			wire mult1_sign_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:151:5
			wire mult2_sign_a;
			wire mult2_sign_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:152:5
			reg mult3_sign_a;
			reg mult3_sign_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:153:5
			reg [33:0] summand1;
			reg [33:0] summand2;
			reg [33:0] summand3;
			// Trace: core/rtl/ibex_multdiv_fast.sv:155:5
			assign mult1_res = $signed({mult1_sign_a, mult1_op_a}) * $signed({mult1_sign_b, mult1_op_b});
			// Trace: core/rtl/ibex_multdiv_fast.sv:156:5
			assign mult2_res = $signed({mult2_sign_a, mult2_op_a}) * $signed({mult2_sign_b, mult2_op_b});
			// Trace: core/rtl/ibex_multdiv_fast.sv:157:5
			assign mult3_res = $signed({mult3_sign_a, mult3_op_a}) * $signed({mult3_sign_b, mult3_op_b});
			// Trace: core/rtl/ibex_multdiv_fast.sv:159:5
			assign mac_res_signed = ($signed(summand1) + $signed(summand2)) + $signed(summand3);
			// Trace: core/rtl/ibex_multdiv_fast.sv:161:5
			assign mult1_res_uns = $unsigned(mult1_res);
			// Trace: core/rtl/ibex_multdiv_fast.sv:162:5
			assign mac_res_ext = $unsigned(mac_res_signed);
			// Trace: core/rtl/ibex_multdiv_fast.sv:163:5
			assign mac_res = mac_res_ext[33:0];
			// Trace: core/rtl/ibex_multdiv_fast.sv:165:5
			wire [1:1] sv2v_tmp_5ADA8;
			assign sv2v_tmp_5ADA8 = signed_mode_i[0] & op_a_i[31];
			always @(*) sign_a = sv2v_tmp_5ADA8;
			// Trace: core/rtl/ibex_multdiv_fast.sv:166:5
			wire [1:1] sv2v_tmp_C5449;
			assign sv2v_tmp_C5449 = signed_mode_i[1] & op_b_i[31];
			always @(*) sign_b = sv2v_tmp_C5449;
			// Trace: core/rtl/ibex_multdiv_fast.sv:170:5
			assign mult1_sign_a = 1'b0;
			// Trace: core/rtl/ibex_multdiv_fast.sv:171:5
			assign mult1_sign_b = 1'b0;
			// Trace: core/rtl/ibex_multdiv_fast.sv:172:5
			assign mult1_op_a = op_a_i[15:0];
			// Trace: core/rtl/ibex_multdiv_fast.sv:173:5
			assign mult1_op_b = op_b_i[15:0];
			// Trace: core/rtl/ibex_multdiv_fast.sv:176:5
			assign mult2_sign_a = 1'b0;
			// Trace: core/rtl/ibex_multdiv_fast.sv:177:5
			assign mult2_sign_b = sign_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:178:5
			assign mult2_op_a = op_a_i[15:0];
			// Trace: core/rtl/ibex_multdiv_fast.sv:179:5
			assign mult2_op_b = op_b_i[31:16];
			// Trace: core/rtl/ibex_multdiv_fast.sv:182:5
			wire [18:1] sv2v_tmp_6FF3F;
			assign sv2v_tmp_6FF3F = imd_val_q_i[67-:18];
			always @(*) accum[17:0] = sv2v_tmp_6FF3F;
			// Trace: core/rtl/ibex_multdiv_fast.sv:183:5
			wire [16:1] sv2v_tmp_A7770;
			assign sv2v_tmp_A7770 = {16 {signed_mult & imd_val_q_i[67]}};
			always @(*) accum[33:18] = sv2v_tmp_A7770;
			// Trace: core/rtl/ibex_multdiv_fast.sv:185:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_multdiv_fast.sv:189:7
				mult3_sign_a = sign_a;
				// Trace: core/rtl/ibex_multdiv_fast.sv:190:7
				mult3_sign_b = 1'b0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:191:7
				mult3_op_a = op_a_i[31:16];
				// Trace: core/rtl/ibex_multdiv_fast.sv:192:7
				mult3_op_b = op_b_i[15:0];
				// Trace: core/rtl/ibex_multdiv_fast.sv:194:7
				summand1 = {18'h00000, mult1_res_uns[31:16]};
				// Trace: core/rtl/ibex_multdiv_fast.sv:195:7
				summand2 = $unsigned(mult2_res);
				// Trace: core/rtl/ibex_multdiv_fast.sv:196:7
				summand3 = $unsigned(mult3_res);
				// Trace: core/rtl/ibex_multdiv_fast.sv:199:7
				mac_res_d = {2'b00, mac_res[15:0], mult1_res_uns[15:0]};
				// Trace: core/rtl/ibex_multdiv_fast.sv:200:7
				mult_valid = mult_en_i;
				// Trace: core/rtl/ibex_multdiv_fast.sv:201:7
				mult_state_d = 1'd0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:203:7
				mult_hold = 1'b0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:205:7
				(* full_case, parallel_case *)
				case (mult_state_q)
					1'd0:
						// Trace: core/rtl/ibex_multdiv_fast.sv:208:11
						if (operator_i != 2'd0) begin
							// Trace: core/rtl/ibex_multdiv_fast.sv:209:13
							mac_res_d = mac_res;
							// Trace: core/rtl/ibex_multdiv_fast.sv:210:13
							mult_valid = 1'b0;
							// Trace: core/rtl/ibex_multdiv_fast.sv:211:13
							mult_state_d = 1'd1;
						end
						else
							// Trace: core/rtl/ibex_multdiv_fast.sv:213:13
							mult_hold = ~multdiv_ready_id_i;
					1'd1: begin
						// Trace: core/rtl/ibex_multdiv_fast.sv:219:11
						mult3_sign_a = sign_a;
						// Trace: core/rtl/ibex_multdiv_fast.sv:220:11
						mult3_sign_b = sign_b;
						// Trace: core/rtl/ibex_multdiv_fast.sv:221:11
						mult3_op_a = op_a_i[31:16];
						// Trace: core/rtl/ibex_multdiv_fast.sv:222:11
						mult3_op_b = op_b_i[31:16];
						// Trace: core/rtl/ibex_multdiv_fast.sv:223:11
						mac_res_d = mac_res;
						// Trace: core/rtl/ibex_multdiv_fast.sv:225:11
						summand1 = 1'sb0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:226:11
						summand2 = accum;
						// Trace: core/rtl/ibex_multdiv_fast.sv:227:11
						summand3 = mult3_res;
						// Trace: core/rtl/ibex_multdiv_fast.sv:229:11
						mult_state_d = 1'd0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:230:11
						mult_valid = 1'b1;
						// Trace: core/rtl/ibex_multdiv_fast.sv:232:11
						mult_hold = ~multdiv_ready_id_i;
					end
					default:
						// Trace: core/rtl/ibex_multdiv_fast.sv:236:11
						mult_state_d = 1'd0;
				endcase
			end
			// Trace: core/rtl/ibex_multdiv_fast.sv:242:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_multdiv_fast.sv:243:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_multdiv_fast.sv:244:9
					mult_state_q <= 1'd0;
				else
					// Trace: core/rtl/ibex_multdiv_fast.sv:246:9
					if (mult_en_internal)
						// Trace: core/rtl/ibex_multdiv_fast.sv:247:11
						mult_state_q <= mult_state_d;
			// Trace: core/rtl/ibex_multdiv_fast.sv:252:5
			assign unused_mult1_res_uns = mult1_res_uns[33:32];
		end
		else begin : gen_mult_fast
			// Trace: core/rtl/ibex_multdiv_fast.sv:260:5
			reg [15:0] mult_op_a;
			// Trace: core/rtl/ibex_multdiv_fast.sv:261:5
			reg [15:0] mult_op_b;
			// Trace: core/rtl/ibex_multdiv_fast.sv:263:5
			// removed localparam type mult_fsm_e
			// Trace: core/rtl/ibex_multdiv_fast.sv:266:5
			reg [1:0] mult_state_q;
			reg [1:0] mult_state_d;
			// Trace: core/rtl/ibex_multdiv_fast.sv:272:5
			assign mac_res_signed = ($signed({sign_a, mult_op_a}) * $signed({sign_b, mult_op_b})) + $signed(accum);
			// Trace: core/rtl/ibex_multdiv_fast.sv:274:5
			assign mac_res_ext = $unsigned(mac_res_signed);
			// Trace: core/rtl/ibex_multdiv_fast.sv:275:5
			assign mac_res = mac_res_ext[33:0];
			// Trace: core/rtl/ibex_multdiv_fast.sv:277:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_multdiv_fast.sv:278:7
				mult_op_a = op_a_i[15:0];
				// Trace: core/rtl/ibex_multdiv_fast.sv:279:7
				mult_op_b = op_b_i[15:0];
				// Trace: core/rtl/ibex_multdiv_fast.sv:280:7
				sign_a = 1'b0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:281:7
				sign_b = 1'b0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:282:7
				accum = imd_val_q_i[34+:34];
				// Trace: core/rtl/ibex_multdiv_fast.sv:283:7
				mac_res_d = mac_res;
				// Trace: core/rtl/ibex_multdiv_fast.sv:284:7
				mult_state_d = mult_state_q;
				// Trace: core/rtl/ibex_multdiv_fast.sv:285:7
				mult_valid = 1'b0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:286:7
				mult_hold = 1'b0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:288:7
				(* full_case, parallel_case *)
				case (mult_state_q)
					2'd0: begin
						// Trace: core/rtl/ibex_multdiv_fast.sv:292:11
						mult_op_a = op_a_i[15:0];
						// Trace: core/rtl/ibex_multdiv_fast.sv:293:11
						mult_op_b = op_b_i[15:0];
						// Trace: core/rtl/ibex_multdiv_fast.sv:294:11
						sign_a = 1'b0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:295:11
						sign_b = 1'b0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:296:11
						accum = 1'sb0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:297:11
						mac_res_d = mac_res;
						// Trace: core/rtl/ibex_multdiv_fast.sv:298:11
						mult_state_d = 2'd1;
					end
					2'd1: begin
						// Trace: core/rtl/ibex_multdiv_fast.sv:303:11
						mult_op_a = op_a_i[15:0];
						// Trace: core/rtl/ibex_multdiv_fast.sv:304:11
						mult_op_b = op_b_i[31:16];
						// Trace: core/rtl/ibex_multdiv_fast.sv:305:11
						sign_a = 1'b0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:306:11
						sign_b = signed_mode_i[1] & op_b_i[31];
						// Trace: core/rtl/ibex_multdiv_fast.sv:308:11
						accum = {18'b000000000000000000, imd_val_q_i[65-:16]};
						// Trace: core/rtl/ibex_multdiv_fast.sv:309:11
						if (operator_i == 2'd0)
							// Trace: core/rtl/ibex_multdiv_fast.sv:310:13
							mac_res_d = {2'b00, mac_res[15:0], imd_val_q_i[49-:16]};
						else
							// Trace: core/rtl/ibex_multdiv_fast.sv:313:13
							mac_res_d = mac_res;
						// Trace: core/rtl/ibex_multdiv_fast.sv:315:11
						mult_state_d = 2'd2;
					end
					2'd2: begin
						// Trace: core/rtl/ibex_multdiv_fast.sv:320:11
						mult_op_a = op_a_i[31:16];
						// Trace: core/rtl/ibex_multdiv_fast.sv:321:11
						mult_op_b = op_b_i[15:0];
						// Trace: core/rtl/ibex_multdiv_fast.sv:322:11
						sign_a = signed_mode_i[0] & op_a_i[31];
						// Trace: core/rtl/ibex_multdiv_fast.sv:323:11
						sign_b = 1'b0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:324:11
						if (operator_i == 2'd0) begin
							// Trace: core/rtl/ibex_multdiv_fast.sv:325:13
							accum = {18'b000000000000000000, imd_val_q_i[65-:16]};
							// Trace: core/rtl/ibex_multdiv_fast.sv:326:13
							mac_res_d = {2'b00, mac_res[15:0], imd_val_q_i[49-:16]};
							// Trace: core/rtl/ibex_multdiv_fast.sv:327:13
							mult_valid = 1'b1;
							// Trace: core/rtl/ibex_multdiv_fast.sv:330:13
							mult_state_d = 2'd0;
							// Trace: core/rtl/ibex_multdiv_fast.sv:331:13
							mult_hold = ~multdiv_ready_id_i;
						end
						else begin
							// Trace: core/rtl/ibex_multdiv_fast.sv:333:13
							accum = imd_val_q_i[34+:34];
							// Trace: core/rtl/ibex_multdiv_fast.sv:334:13
							mac_res_d = mac_res;
							// Trace: core/rtl/ibex_multdiv_fast.sv:335:13
							mult_state_d = 2'd3;
						end
					end
					2'd3: begin
						// Trace: core/rtl/ibex_multdiv_fast.sv:342:11
						mult_op_a = op_a_i[31:16];
						// Trace: core/rtl/ibex_multdiv_fast.sv:343:11
						mult_op_b = op_b_i[31:16];
						// Trace: core/rtl/ibex_multdiv_fast.sv:344:11
						sign_a = signed_mode_i[0] & op_a_i[31];
						// Trace: core/rtl/ibex_multdiv_fast.sv:345:11
						sign_b = signed_mode_i[1] & op_b_i[31];
						// Trace: core/rtl/ibex_multdiv_fast.sv:346:11
						accum[17:0] = imd_val_q_i[67-:18];
						// Trace: core/rtl/ibex_multdiv_fast.sv:347:11
						accum[33:18] = {16 {signed_mult & imd_val_q_i[67]}};
						// Trace: core/rtl/ibex_multdiv_fast.sv:349:11
						mac_res_d = mac_res;
						// Trace: core/rtl/ibex_multdiv_fast.sv:350:11
						mult_valid = 1'b1;
						// Trace: core/rtl/ibex_multdiv_fast.sv:353:11
						mult_state_d = 2'd0;
						// Trace: core/rtl/ibex_multdiv_fast.sv:354:11
						mult_hold = ~multdiv_ready_id_i;
					end
					default:
						// Trace: core/rtl/ibex_multdiv_fast.sv:357:11
						mult_state_d = 2'd0;
				endcase
			end
			// Trace: core/rtl/ibex_multdiv_fast.sv:362:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_multdiv_fast.sv:363:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_multdiv_fast.sv:364:9
					mult_state_q <= 2'd0;
				else
					// Trace: core/rtl/ibex_multdiv_fast.sv:366:9
					if (mult_en_internal)
						// Trace: core/rtl/ibex_multdiv_fast.sv:367:11
						mult_state_q <= mult_state_d;
		end
	endgenerate
	// Trace: core/rtl/ibex_multdiv_fast.sv:378:3
	assign res_adder_h = alu_adder_ext_i[32:1];
	// Trace: core/rtl/ibex_multdiv_fast.sv:379:3
	wire [1:0] unused_alu_adder_ext;
	// Trace: core/rtl/ibex_multdiv_fast.sv:380:3
	assign unused_alu_adder_ext = {alu_adder_ext_i[33], alu_adder_ext_i[0]};
	// Trace: core/rtl/ibex_multdiv_fast.sv:382:3
	assign next_remainder = (is_greater_equal ? res_adder_h[31:0] : imd_val_q_i[65-:32]);
	// Trace: core/rtl/ibex_multdiv_fast.sv:383:3
	assign next_quotient = (is_greater_equal ? {1'b0, op_quotient_q} | {1'b0, one_shift} : {1'b0, op_quotient_q});
	// Trace: core/rtl/ibex_multdiv_fast.sv:386:3
	assign one_shift = 32'b00000000000000000000000000000001 << div_counter_q;
	// Trace: core/rtl/ibex_multdiv_fast.sv:391:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_multdiv_fast.sv:392:5
		if ((imd_val_q_i[65] ^ op_denominator_q[31]) == 1'b0)
			// Trace: core/rtl/ibex_multdiv_fast.sv:393:7
			is_greater_equal = res_adder_h[31] == 1'b0;
		else
			// Trace: core/rtl/ibex_multdiv_fast.sv:395:7
			is_greater_equal = imd_val_q_i[65];
	end
	// Trace: core/rtl/ibex_multdiv_fast.sv:399:3
	assign div_sign_a = op_a_i[31] & signed_mode_i[0];
	// Trace: core/rtl/ibex_multdiv_fast.sv:400:3
	assign div_sign_b = op_b_i[31] & signed_mode_i[1];
	// Trace: core/rtl/ibex_multdiv_fast.sv:401:3
	assign div_change_sign = (div_sign_a ^ div_sign_b) & ~div_by_zero_q;
	// Trace: core/rtl/ibex_multdiv_fast.sv:402:3
	assign rem_change_sign = div_sign_a;
	// Trace: core/rtl/ibex_multdiv_fast.sv:405:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_multdiv_fast.sv:406:5
		div_counter_d = div_counter_q - 5'h01;
		// Trace: core/rtl/ibex_multdiv_fast.sv:407:5
		op_remainder_d = imd_val_q_i[34+:34];
		// Trace: core/rtl/ibex_multdiv_fast.sv:408:5
		op_quotient_d = op_quotient_q;
		// Trace: core/rtl/ibex_multdiv_fast.sv:409:5
		md_state_d = md_state_q;
		// Trace: core/rtl/ibex_multdiv_fast.sv:410:5
		op_numerator_d = op_numerator_q;
		// Trace: core/rtl/ibex_multdiv_fast.sv:411:5
		op_denominator_d = op_denominator_q;
		// Trace: core/rtl/ibex_multdiv_fast.sv:412:5
		alu_operand_a_o = 33'h000000001;
		// Trace: core/rtl/ibex_multdiv_fast.sv:413:5
		alu_operand_b_o = {~op_b_i, 1'b1};
		// Trace: core/rtl/ibex_multdiv_fast.sv:414:5
		div_valid = 1'b0;
		// Trace: core/rtl/ibex_multdiv_fast.sv:415:5
		div_hold = 1'b0;
		// Trace: core/rtl/ibex_multdiv_fast.sv:416:5
		div_by_zero_d = div_by_zero_q;
		// Trace: core/rtl/ibex_multdiv_fast.sv:418:5
		(* full_case, parallel_case *)
		case (md_state_q)
			3'd0: begin
				// Trace: core/rtl/ibex_multdiv_fast.sv:420:9
				if (operator_i == 2'd2) begin
					// Trace: core/rtl/ibex_multdiv_fast.sv:425:11
					op_remainder_d = 1'sb1;
					// Trace: core/rtl/ibex_multdiv_fast.sv:426:11
					md_state_d = (!data_ind_timing_i && equal_to_zero_i ? 3'd6 : 3'd1);
					// Trace: core/rtl/ibex_multdiv_fast.sv:429:11
					div_by_zero_d = equal_to_zero_i;
				end
				else begin
					// Trace: core/rtl/ibex_multdiv_fast.sv:435:11
					op_remainder_d = {2'b00, op_a_i};
					// Trace: core/rtl/ibex_multdiv_fast.sv:436:11
					md_state_d = (!data_ind_timing_i && equal_to_zero_i ? 3'd6 : 3'd1);
				end
				// Trace: core/rtl/ibex_multdiv_fast.sv:439:9
				alu_operand_a_o = 33'h000000001;
				// Trace: core/rtl/ibex_multdiv_fast.sv:440:9
				alu_operand_b_o = {~op_b_i, 1'b1};
				// Trace: core/rtl/ibex_multdiv_fast.sv:441:9
				div_counter_d = 5'd31;
			end
			3'd1: begin
				// Trace: core/rtl/ibex_multdiv_fast.sv:446:9
				op_quotient_d = 1'sb0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:448:9
				op_numerator_d = (div_sign_a ? alu_adder_i : op_a_i);
				// Trace: core/rtl/ibex_multdiv_fast.sv:449:9
				md_state_d = 3'd2;
				// Trace: core/rtl/ibex_multdiv_fast.sv:450:9
				div_counter_d = 5'd31;
				// Trace: core/rtl/ibex_multdiv_fast.sv:452:9
				alu_operand_a_o = 33'h000000001;
				// Trace: core/rtl/ibex_multdiv_fast.sv:453:9
				alu_operand_b_o = {~op_a_i, 1'b1};
			end
			3'd2: begin
				// Trace: core/rtl/ibex_multdiv_fast.sv:458:9
				op_remainder_d = {33'h000000000, op_numerator_q[31]};
				// Trace: core/rtl/ibex_multdiv_fast.sv:460:9
				op_denominator_d = (div_sign_b ? alu_adder_i : op_b_i);
				// Trace: core/rtl/ibex_multdiv_fast.sv:461:9
				md_state_d = 3'd3;
				// Trace: core/rtl/ibex_multdiv_fast.sv:462:9
				div_counter_d = 5'd31;
				// Trace: core/rtl/ibex_multdiv_fast.sv:464:9
				alu_operand_a_o = 33'h000000001;
				// Trace: core/rtl/ibex_multdiv_fast.sv:465:9
				alu_operand_b_o = {~op_b_i, 1'b1};
			end
			3'd3: begin
				// Trace: core/rtl/ibex_multdiv_fast.sv:469:9
				op_remainder_d = {1'b0, next_remainder[31:0], op_numerator_q[div_counter_d]};
				// Trace: core/rtl/ibex_multdiv_fast.sv:470:9
				op_quotient_d = next_quotient[31:0];
				// Trace: core/rtl/ibex_multdiv_fast.sv:471:9
				md_state_d = (div_counter_q == 5'd1 ? 3'd4 : 3'd3);
				// Trace: core/rtl/ibex_multdiv_fast.sv:473:9
				alu_operand_a_o = {imd_val_q_i[65-:32], 1'b1};
				// Trace: core/rtl/ibex_multdiv_fast.sv:474:9
				alu_operand_b_o = {~op_denominator_q[31:0], 1'b1};
			end
			3'd4: begin
				// Trace: core/rtl/ibex_multdiv_fast.sv:478:9
				if (operator_i == 2'd2)
					// Trace: core/rtl/ibex_multdiv_fast.sv:481:11
					op_remainder_d = {1'b0, next_quotient};
				else
					// Trace: core/rtl/ibex_multdiv_fast.sv:484:11
					op_remainder_d = {2'b00, next_remainder[31:0]};
				// Trace: core/rtl/ibex_multdiv_fast.sv:487:9
				alu_operand_a_o = {imd_val_q_i[65-:32], 1'b1};
				// Trace: core/rtl/ibex_multdiv_fast.sv:488:9
				alu_operand_b_o = {~op_denominator_q[31:0], 1'b1};
				// Trace: core/rtl/ibex_multdiv_fast.sv:490:9
				md_state_d = 3'd5;
			end
			3'd5: begin
				// Trace: core/rtl/ibex_multdiv_fast.sv:494:9
				md_state_d = 3'd6;
				// Trace: core/rtl/ibex_multdiv_fast.sv:495:9
				if (operator_i == 2'd2)
					// Trace: core/rtl/ibex_multdiv_fast.sv:496:11
					op_remainder_d = (div_change_sign ? {2'h0, alu_adder_i} : imd_val_q_i[34+:34]);
				else
					// Trace: core/rtl/ibex_multdiv_fast.sv:498:11
					op_remainder_d = (rem_change_sign ? {2'h0, alu_adder_i} : imd_val_q_i[34+:34]);
				// Trace: core/rtl/ibex_multdiv_fast.sv:501:9
				alu_operand_a_o = 33'h000000001;
				// Trace: core/rtl/ibex_multdiv_fast.sv:502:9
				alu_operand_b_o = {~imd_val_q_i[65-:32], 1'b1};
			end
			3'd6: begin
				// Trace: core/rtl/ibex_multdiv_fast.sv:508:9
				md_state_d = 3'd0;
				// Trace: core/rtl/ibex_multdiv_fast.sv:509:9
				div_hold = ~multdiv_ready_id_i;
				// Trace: core/rtl/ibex_multdiv_fast.sv:510:9
				div_valid = 1'b1;
			end
			default:
				// Trace: core/rtl/ibex_multdiv_fast.sv:514:9
				md_state_d = 3'd0;
		endcase
	end
	// Trace: core/rtl/ibex_multdiv_fast.sv:519:3
	assign valid_o = mult_valid | div_valid;
	initial _sv2v_0 = 0;
endmodule
