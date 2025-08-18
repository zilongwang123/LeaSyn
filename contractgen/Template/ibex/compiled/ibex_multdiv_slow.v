// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_multdiv_slow (
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
	// Trace: core/rtl/ibex_multdiv_slow.sv:16:5
	input wire clk_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:17:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_multdiv_slow.sv:18:5
	input wire mult_en_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:19:5
	input wire div_en_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:20:5
	input wire mult_sel_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:21:5
	input wire div_sel_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:22:5
	// removed localparam type ibex_pkg_md_op_e
	input wire [1:0] operator_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:23:5
	input wire [1:0] signed_mode_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:24:5
	input wire [31:0] op_a_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:25:5
	input wire [31:0] op_b_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:26:5
	input wire [33:0] alu_adder_ext_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:27:5
	input wire [31:0] alu_adder_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:28:5
	input wire equal_to_zero_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:29:5
	input wire data_ind_timing_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:31:5
	output reg [32:0] alu_operand_a_o;
	// Trace: core/rtl/ibex_multdiv_slow.sv:32:5
	output reg [32:0] alu_operand_b_o;
	// Trace: core/rtl/ibex_multdiv_slow.sv:34:5
	input wire [67:0] imd_val_q_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:35:5
	output wire [67:0] imd_val_d_o;
	// Trace: core/rtl/ibex_multdiv_slow.sv:36:5
	output wire [1:0] imd_val_we_o;
	// Trace: core/rtl/ibex_multdiv_slow.sv:38:5
	input wire multdiv_ready_id_i;
	// Trace: core/rtl/ibex_multdiv_slow.sv:40:5
	output wire [31:0] multdiv_result_o;
	// Trace: core/rtl/ibex_multdiv_slow.sv:42:5
	output wire valid_o;
	// Trace: core/rtl/ibex_multdiv_slow.sv:45:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_multdiv_slow.sv:47:3
	// removed localparam type md_fsm_e
	// Trace: core/rtl/ibex_multdiv_slow.sv:50:3
	reg [2:0] md_state_q;
	reg [2:0] md_state_d;
	// Trace: core/rtl/ibex_multdiv_slow.sv:52:3
	wire [32:0] accum_window_q;
	reg [32:0] accum_window_d;
	// Trace: core/rtl/ibex_multdiv_slow.sv:53:3
	wire unused_imd_val0;
	// Trace: core/rtl/ibex_multdiv_slow.sv:54:3
	wire [1:0] unused_imd_val1;
	// Trace: core/rtl/ibex_multdiv_slow.sv:56:3
	wire [32:0] res_adder_l;
	// Trace: core/rtl/ibex_multdiv_slow.sv:57:3
	wire [32:0] res_adder_h;
	// Trace: core/rtl/ibex_multdiv_slow.sv:59:3
	reg [4:0] multdiv_count_q;
	reg [4:0] multdiv_count_d;
	// Trace: core/rtl/ibex_multdiv_slow.sv:60:3
	reg [32:0] op_b_shift_q;
	reg [32:0] op_b_shift_d;
	// Trace: core/rtl/ibex_multdiv_slow.sv:61:3
	reg [32:0] op_a_shift_q;
	reg [32:0] op_a_shift_d;
	// Trace: core/rtl/ibex_multdiv_slow.sv:62:3
	wire [32:0] op_a_ext;
	wire [32:0] op_b_ext;
	// Trace: core/rtl/ibex_multdiv_slow.sv:63:3
	wire [32:0] one_shift;
	// Trace: core/rtl/ibex_multdiv_slow.sv:64:3
	wire [32:0] op_a_bw_pp;
	wire [32:0] op_a_bw_last_pp;
	// Trace: core/rtl/ibex_multdiv_slow.sv:65:3
	wire [31:0] b_0;
	// Trace: core/rtl/ibex_multdiv_slow.sv:66:3
	wire sign_a;
	wire sign_b;
	// Trace: core/rtl/ibex_multdiv_slow.sv:67:3
	wire [32:0] next_quotient;
	// Trace: core/rtl/ibex_multdiv_slow.sv:68:3
	wire [31:0] next_remainder;
	// Trace: core/rtl/ibex_multdiv_slow.sv:69:3
	wire [31:0] op_numerator_q;
	reg [31:0] op_numerator_d;
	// Trace: core/rtl/ibex_multdiv_slow.sv:70:3
	wire is_greater_equal;
	// Trace: core/rtl/ibex_multdiv_slow.sv:71:3
	wire div_change_sign;
	wire rem_change_sign;
	// Trace: core/rtl/ibex_multdiv_slow.sv:72:3
	reg div_by_zero_d;
	reg div_by_zero_q;
	// Trace: core/rtl/ibex_multdiv_slow.sv:73:3
	reg multdiv_hold;
	// Trace: core/rtl/ibex_multdiv_slow.sv:74:3
	wire multdiv_en;
	// Trace: core/rtl/ibex_multdiv_slow.sv:77:3
	assign res_adder_l = alu_adder_ext_i[32:0];
	// Trace: core/rtl/ibex_multdiv_slow.sv:79:3
	assign res_adder_h = alu_adder_ext_i[33:1];
	// Trace: core/rtl/ibex_multdiv_slow.sv:86:3
	assign imd_val_d_o[34+:34] = {1'b0, accum_window_d};
	// Trace: core/rtl/ibex_multdiv_slow.sv:87:3
	assign imd_val_we_o[0] = ~multdiv_hold;
	// Trace: core/rtl/ibex_multdiv_slow.sv:88:3
	assign accum_window_q = imd_val_q_i[66-:33];
	// Trace: core/rtl/ibex_multdiv_slow.sv:89:3
	assign unused_imd_val0 = imd_val_q_i[67];
	// Trace: core/rtl/ibex_multdiv_slow.sv:91:3
	assign imd_val_d_o[0+:34] = {2'b00, op_numerator_d};
	// Trace: core/rtl/ibex_multdiv_slow.sv:92:3
	assign imd_val_we_o[1] = multdiv_en;
	// Trace: core/rtl/ibex_multdiv_slow.sv:93:3
	assign op_numerator_q = imd_val_q_i[31-:32];
	// Trace: core/rtl/ibex_multdiv_slow.sv:94:3
	assign unused_imd_val1 = imd_val_q_i[33-:2];
	// Trace: core/rtl/ibex_multdiv_slow.sv:96:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_multdiv_slow.sv:97:5
		alu_operand_a_o = accum_window_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:99:5
		(* full_case, parallel_case *)
		case (operator_i)
			2'd0:
				// Trace: core/rtl/ibex_multdiv_slow.sv:102:9
				alu_operand_b_o = op_a_bw_pp;
			2'd1:
				// Trace: core/rtl/ibex_multdiv_slow.sv:106:9
				alu_operand_b_o = (md_state_q == 3'd4 ? op_a_bw_last_pp : op_a_bw_pp);
			2'd2, 2'd3:
				// Trace: core/rtl/ibex_multdiv_slow.sv:111:9
				(* full_case, parallel_case *)
				case (md_state_q)
					3'd0: begin
						// Trace: core/rtl/ibex_multdiv_slow.sv:114:13
						alu_operand_a_o = 33'h000000001;
						// Trace: core/rtl/ibex_multdiv_slow.sv:115:13
						alu_operand_b_o = {~op_b_i, 1'b1};
					end
					3'd1: begin
						// Trace: core/rtl/ibex_multdiv_slow.sv:119:13
						alu_operand_a_o = 33'h000000001;
						// Trace: core/rtl/ibex_multdiv_slow.sv:120:13
						alu_operand_b_o = {~op_a_i, 1'b1};
					end
					3'd2: begin
						// Trace: core/rtl/ibex_multdiv_slow.sv:124:13
						alu_operand_a_o = 33'h000000001;
						// Trace: core/rtl/ibex_multdiv_slow.sv:125:13
						alu_operand_b_o = {~op_b_i, 1'b1};
					end
					3'd5: begin
						// Trace: core/rtl/ibex_multdiv_slow.sv:129:13
						alu_operand_a_o = 33'h000000001;
						// Trace: core/rtl/ibex_multdiv_slow.sv:130:13
						alu_operand_b_o = {~accum_window_q[31:0], 1'b1};
					end
					default: begin
						// Trace: core/rtl/ibex_multdiv_slow.sv:134:13
						alu_operand_a_o = {accum_window_q[31:0], 1'b1};
						// Trace: core/rtl/ibex_multdiv_slow.sv:135:13
						alu_operand_b_o = {~op_b_shift_q[31:0], 1'b1};
					end
				endcase
			default: begin
				// Trace: core/rtl/ibex_multdiv_slow.sv:140:9
				alu_operand_a_o = accum_window_q;
				// Trace: core/rtl/ibex_multdiv_slow.sv:141:9
				alu_operand_b_o = {~op_b_shift_q[31:0], 1'b1};
			end
		endcase
	end
	// Trace: core/rtl/ibex_multdiv_slow.sv:147:3
	assign b_0 = {32 {op_b_shift_q[0]}};
	// Trace: core/rtl/ibex_multdiv_slow.sv:148:3
	assign op_a_bw_pp = {~(op_a_shift_q[32] & op_b_shift_q[0]), op_a_shift_q[31:0] & b_0};
	// Trace: core/rtl/ibex_multdiv_slow.sv:149:3
	assign op_a_bw_last_pp = {op_a_shift_q[32] & op_b_shift_q[0], ~(op_a_shift_q[31:0] & b_0)};
	// Trace: core/rtl/ibex_multdiv_slow.sv:152:3
	assign sign_a = op_a_i[31] & signed_mode_i[0];
	// Trace: core/rtl/ibex_multdiv_slow.sv:153:3
	assign sign_b = op_b_i[31] & signed_mode_i[1];
	// Trace: core/rtl/ibex_multdiv_slow.sv:155:3
	assign op_a_ext = {sign_a, op_a_i};
	// Trace: core/rtl/ibex_multdiv_slow.sv:156:3
	assign op_b_ext = {sign_b, op_b_i};
	// Trace: core/rtl/ibex_multdiv_slow.sv:163:3
	assign is_greater_equal = (accum_window_q[31] == op_b_shift_q[31] ? ~res_adder_h[31] : accum_window_q[31]);
	// Trace: core/rtl/ibex_multdiv_slow.sv:166:3
	assign one_shift = 33'b000000000000000000000000000000001 << multdiv_count_q;
	// Trace: core/rtl/ibex_multdiv_slow.sv:168:3
	assign next_remainder = (is_greater_equal ? res_adder_h[31:0] : accum_window_q[31:0]);
	// Trace: core/rtl/ibex_multdiv_slow.sv:169:3
	assign next_quotient = (is_greater_equal ? op_a_shift_q | one_shift : op_a_shift_q);
	// Trace: core/rtl/ibex_multdiv_slow.sv:171:3
	assign div_change_sign = (sign_a ^ sign_b) & ~div_by_zero_q;
	// Trace: core/rtl/ibex_multdiv_slow.sv:172:3
	assign rem_change_sign = sign_a;
	// Trace: core/rtl/ibex_multdiv_slow.sv:174:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_multdiv_slow.sv:175:5
		multdiv_count_d = multdiv_count_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:176:5
		accum_window_d = accum_window_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:177:5
		op_b_shift_d = op_b_shift_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:178:5
		op_a_shift_d = op_a_shift_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:179:5
		op_numerator_d = op_numerator_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:180:5
		md_state_d = md_state_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:181:5
		multdiv_hold = 1'b0;
		// Trace: core/rtl/ibex_multdiv_slow.sv:182:5
		div_by_zero_d = div_by_zero_q;
		// Trace: core/rtl/ibex_multdiv_slow.sv:183:5
		if (mult_sel_i || div_sel_i)
			// Trace: core/rtl/ibex_multdiv_slow.sv:184:7
			(* full_case, parallel_case *)
			case (md_state_q)
				3'd0: begin
					// Trace: core/rtl/ibex_multdiv_slow.sv:186:11
					(* full_case, parallel_case *)
					case (operator_i)
						2'd0: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:188:15
							op_a_shift_d = op_a_ext << 1;
							// Trace: core/rtl/ibex_multdiv_slow.sv:189:15
							accum_window_d = {~(op_a_ext[32] & op_b_i[0]), op_a_ext[31:0] & {32 {op_b_i[0]}}};
							// Trace: core/rtl/ibex_multdiv_slow.sv:191:15
							op_b_shift_d = op_b_ext >> 1;
							// Trace: core/rtl/ibex_multdiv_slow.sv:193:15
							md_state_d = (!data_ind_timing_i && ((op_b_ext >> 1) == 0) ? 3'd4 : 3'd3);
						end
						2'd1: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:196:15
							op_a_shift_d = op_a_ext;
							// Trace: core/rtl/ibex_multdiv_slow.sv:197:15
							accum_window_d = {1'b1, ~(op_a_ext[32] & op_b_i[0]), op_a_ext[31:1] & {31 {op_b_i[0]}}};
							// Trace: core/rtl/ibex_multdiv_slow.sv:199:15
							op_b_shift_d = op_b_ext >> 1;
							// Trace: core/rtl/ibex_multdiv_slow.sv:200:15
							md_state_d = 3'd3;
						end
						2'd2: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:207:15
							accum_window_d = {33 {1'b1}};
							// Trace: core/rtl/ibex_multdiv_slow.sv:208:15
							md_state_d = (!data_ind_timing_i && equal_to_zero_i ? 3'd6 : 3'd1);
							// Trace: core/rtl/ibex_multdiv_slow.sv:211:15
							div_by_zero_d = equal_to_zero_i;
						end
						2'd3: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:218:15
							accum_window_d = op_a_ext;
							// Trace: core/rtl/ibex_multdiv_slow.sv:219:15
							md_state_d = (!data_ind_timing_i && equal_to_zero_i ? 3'd6 : 3'd1);
						end
						default:
							;
					endcase
					// Trace: core/rtl/ibex_multdiv_slow.sv:223:11
					multdiv_count_d = 5'd31;
				end
				3'd1: begin
					// Trace: core/rtl/ibex_multdiv_slow.sv:228:11
					op_a_shift_d = 1'sb0;
					// Trace: core/rtl/ibex_multdiv_slow.sv:230:11
					op_numerator_d = (sign_a ? alu_adder_i : op_a_i);
					// Trace: core/rtl/ibex_multdiv_slow.sv:231:11
					md_state_d = 3'd2;
				end
				3'd2: begin
					// Trace: core/rtl/ibex_multdiv_slow.sv:236:11
					accum_window_d = {32'h00000000, op_numerator_q[31]};
					// Trace: core/rtl/ibex_multdiv_slow.sv:238:11
					op_b_shift_d = (sign_b ? {1'b0, alu_adder_i} : {1'b0, op_b_i});
					// Trace: core/rtl/ibex_multdiv_slow.sv:239:11
					md_state_d = 3'd3;
				end
				3'd3: begin
					// Trace: core/rtl/ibex_multdiv_slow.sv:243:11
					multdiv_count_d = multdiv_count_q - 5'h01;
					// Trace: core/rtl/ibex_multdiv_slow.sv:244:11
					(* full_case, parallel_case *)
					case (operator_i)
						2'd0: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:246:15
							accum_window_d = res_adder_l;
							// Trace: core/rtl/ibex_multdiv_slow.sv:247:15
							op_a_shift_d = op_a_shift_q << 1;
							// Trace: core/rtl/ibex_multdiv_slow.sv:248:15
							op_b_shift_d = op_b_shift_q >> 1;
							// Trace: core/rtl/ibex_multdiv_slow.sv:251:15
							md_state_d = ((!data_ind_timing_i && (op_b_shift_d == 0)) || (multdiv_count_q == 5'd1) ? 3'd4 : 3'd3);
						end
						2'd1: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:255:15
							accum_window_d = res_adder_h;
							// Trace: core/rtl/ibex_multdiv_slow.sv:256:15
							op_a_shift_d = op_a_shift_q;
							// Trace: core/rtl/ibex_multdiv_slow.sv:257:15
							op_b_shift_d = op_b_shift_q >> 1;
							// Trace: core/rtl/ibex_multdiv_slow.sv:258:15
							md_state_d = (multdiv_count_q == 5'd1 ? 3'd4 : 3'd3);
						end
						2'd2, 2'd3: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:262:15
							accum_window_d = {next_remainder[31:0], op_numerator_q[multdiv_count_d]};
							// Trace: core/rtl/ibex_multdiv_slow.sv:263:15
							op_a_shift_d = next_quotient;
							// Trace: core/rtl/ibex_multdiv_slow.sv:264:15
							md_state_d = (multdiv_count_q == 5'd1 ? 3'd4 : 3'd3);
						end
						default:
							;
					endcase
				end
				3'd4:
					// Trace: core/rtl/ibex_multdiv_slow.sv:271:11
					(* full_case, parallel_case *)
					case (operator_i)
						2'd0: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:273:15
							accum_window_d = res_adder_l;
							// Trace: core/rtl/ibex_multdiv_slow.sv:276:15
							md_state_d = 3'd0;
							// Trace: core/rtl/ibex_multdiv_slow.sv:277:15
							multdiv_hold = ~multdiv_ready_id_i;
						end
						2'd1: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:280:15
							accum_window_d = res_adder_l;
							// Trace: core/rtl/ibex_multdiv_slow.sv:281:15
							md_state_d = 3'd0;
							// Trace: core/rtl/ibex_multdiv_slow.sv:284:15
							md_state_d = 3'd0;
							// Trace: core/rtl/ibex_multdiv_slow.sv:285:15
							multdiv_hold = ~multdiv_ready_id_i;
						end
						2'd2: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:290:15
							accum_window_d = next_quotient;
							// Trace: core/rtl/ibex_multdiv_slow.sv:291:15
							md_state_d = 3'd5;
						end
						2'd3: begin
							// Trace: core/rtl/ibex_multdiv_slow.sv:295:15
							accum_window_d = {1'b0, next_remainder[31:0]};
							// Trace: core/rtl/ibex_multdiv_slow.sv:296:15
							md_state_d = 3'd5;
						end
						default:
							;
					endcase
				3'd5: begin
					// Trace: core/rtl/ibex_multdiv_slow.sv:303:11
					md_state_d = 3'd6;
					// Trace: core/rtl/ibex_multdiv_slow.sv:304:11
					(* full_case, parallel_case *)
					case (operator_i)
						2'd2:
							// Trace: core/rtl/ibex_multdiv_slow.sv:306:15
							accum_window_d = (div_change_sign ? {1'b0, alu_adder_i} : accum_window_q);
						2'd3:
							// Trace: core/rtl/ibex_multdiv_slow.sv:308:15
							accum_window_d = (rem_change_sign ? {1'b0, alu_adder_i} : accum_window_q);
						default:
							;
					endcase
				end
				3'd6: begin
					// Trace: core/rtl/ibex_multdiv_slow.sv:315:11
					md_state_d = 3'd0;
					// Trace: core/rtl/ibex_multdiv_slow.sv:316:11
					multdiv_hold = ~multdiv_ready_id_i;
				end
				default:
					// Trace: core/rtl/ibex_multdiv_slow.sv:320:11
					md_state_d = 3'd0;
			endcase
	end
	// Trace: core/rtl/ibex_multdiv_slow.sv:330:3
	assign multdiv_en = (mult_en_i | div_en_i) & ~multdiv_hold;
	// Trace: core/rtl/ibex_multdiv_slow.sv:332:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_multdiv_slow.sv:333:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_multdiv_slow.sv:334:7
			multdiv_count_q <= 5'h00;
			// Trace: core/rtl/ibex_multdiv_slow.sv:335:7
			op_b_shift_q <= 33'h000000000;
			// Trace: core/rtl/ibex_multdiv_slow.sv:336:7
			op_a_shift_q <= 33'h000000000;
			// Trace: core/rtl/ibex_multdiv_slow.sv:337:7
			md_state_q <= 3'd0;
			// Trace: core/rtl/ibex_multdiv_slow.sv:338:7
			div_by_zero_q <= 1'b0;
		end
		else if (multdiv_en) begin
			// Trace: core/rtl/ibex_multdiv_slow.sv:340:7
			multdiv_count_q <= multdiv_count_d;
			// Trace: core/rtl/ibex_multdiv_slow.sv:341:7
			op_b_shift_q <= op_b_shift_d;
			// Trace: core/rtl/ibex_multdiv_slow.sv:342:7
			op_a_shift_q <= op_a_shift_d;
			// Trace: core/rtl/ibex_multdiv_slow.sv:343:7
			md_state_q <= md_state_d;
			// Trace: core/rtl/ibex_multdiv_slow.sv:344:7
			div_by_zero_q <= div_by_zero_d;
		end
	// Trace: core/rtl/ibex_multdiv_slow.sv:352:3
	assign valid_o = (md_state_q == 3'd6) | ((md_state_q == 3'd4) & ((operator_i == 2'd0) | (operator_i == 2'd1)));
	// Trace: core/rtl/ibex_multdiv_slow.sv:357:3
	assign multdiv_result_o = (div_en_i ? accum_window_q[31:0] : res_adder_l[31:0]);
	initial _sv2v_0 = 0;
endmodule
