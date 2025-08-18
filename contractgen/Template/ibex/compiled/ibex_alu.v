// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_alu (
	operator_i,
	operand_a_i,
	operand_b_i,
	instr_first_cycle_i,
	multdiv_operand_a_i,
	multdiv_operand_b_i,
	multdiv_sel_i,
	imd_val_q_i,
	imd_val_d_o,
	imd_val_we_o,
	adder_result_o,
	adder_result_ext_o,
	result_o,
	comparison_result_o,
	is_equal_result_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_alu.sv:10:13
	// removed localparam type ibex_pkg_rv32b_e
	parameter integer RV32B = 32'sd0;
	// Trace: core/rtl/ibex_alu.sv:12:5
	// removed localparam type ibex_pkg_alu_op_e
	input wire [5:0] operator_i;
	// Trace: core/rtl/ibex_alu.sv:13:5
	input wire [31:0] operand_a_i;
	// Trace: core/rtl/ibex_alu.sv:14:5
	input wire [31:0] operand_b_i;
	// Trace: core/rtl/ibex_alu.sv:16:5
	input wire instr_first_cycle_i;
	// Trace: core/rtl/ibex_alu.sv:18:5
	input wire [32:0] multdiv_operand_a_i;
	// Trace: core/rtl/ibex_alu.sv:19:5
	input wire [32:0] multdiv_operand_b_i;
	// Trace: core/rtl/ibex_alu.sv:21:5
	input wire multdiv_sel_i;
	// Trace: core/rtl/ibex_alu.sv:23:5
	input wire [63:0] imd_val_q_i;
	// Trace: core/rtl/ibex_alu.sv:24:5
	output reg [63:0] imd_val_d_o;
	// Trace: core/rtl/ibex_alu.sv:25:5
	output reg [1:0] imd_val_we_o;
	// Trace: core/rtl/ibex_alu.sv:27:5
	output wire [31:0] adder_result_o;
	// Trace: core/rtl/ibex_alu.sv:28:5
	output wire [33:0] adder_result_ext_o;
	// Trace: core/rtl/ibex_alu.sv:30:5
	output reg [31:0] result_o;
	// Trace: core/rtl/ibex_alu.sv:31:5
	output wire comparison_result_o;
	// Trace: core/rtl/ibex_alu.sv:32:5
	output wire is_equal_result_o;
	// Trace: core/rtl/ibex_alu.sv:34:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_alu.sv:36:3
	wire [31:0] operand_a_rev;
	// Trace: core/rtl/ibex_alu.sv:37:3
	wire [32:0] operand_b_neg;
	// Trace: core/rtl/ibex_alu.sv:40:3
	genvar _gv_k_1;
	generate
		for (_gv_k_1 = 0; _gv_k_1 < 32; _gv_k_1 = _gv_k_1 + 1) begin : gen_rev_operand_a
			localparam k = _gv_k_1;
			// Trace: core/rtl/ibex_alu.sv:41:5
			assign operand_a_rev[k] = operand_a_i[31 - k];
		end
	endgenerate
	// Trace: core/rtl/ibex_alu.sv:48:3
	reg adder_op_b_negate;
	// Trace: core/rtl/ibex_alu.sv:49:3
	wire [32:0] adder_in_a;
	reg [32:0] adder_in_b;
	// Trace: core/rtl/ibex_alu.sv:50:3
	wire [31:0] adder_result;
	// Trace: core/rtl/ibex_alu.sv:52:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:53:5
		adder_op_b_negate = 1'b0;
		// Trace: core/rtl/ibex_alu.sv:54:5
		(* full_case, parallel_case *)
		case (operator_i)
			6'd1, 6'd23, 6'd24, 6'd21, 6'd22, 6'd19, 6'd20, 6'd37, 6'd38, 6'd25, 6'd26, 6'd27, 6'd28:
				// Trace: core/rtl/ibex_alu.sv:66:27
				adder_op_b_negate = 1'b1;
			default:
				;
		endcase
	end
	// Trace: core/rtl/ibex_alu.sv:73:3
	assign adder_in_a = (multdiv_sel_i ? multdiv_operand_a_i : {operand_a_i, 1'b1});
	// Trace: core/rtl/ibex_alu.sv:76:3
	assign operand_b_neg = {operand_b_i, 1'b0} ^ {33 {1'b1}};
	// Trace: core/rtl/ibex_alu.sv:77:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:78:5
		(* full_case, parallel_case *)
		case (1'b1)
			multdiv_sel_i:
				// Trace: core/rtl/ibex_alu.sv:79:26
				adder_in_b = multdiv_operand_b_i;
			adder_op_b_negate:
				// Trace: core/rtl/ibex_alu.sv:80:26
				adder_in_b = operand_b_neg;
			default:
				// Trace: core/rtl/ibex_alu.sv:81:26
				adder_in_b = {operand_b_i, 1'b0};
		endcase
	end
	// Trace: core/rtl/ibex_alu.sv:86:3
	assign adder_result_ext_o = $unsigned(adder_in_a) + $unsigned(adder_in_b);
	// Trace: core/rtl/ibex_alu.sv:88:3
	assign adder_result = adder_result_ext_o[32:1];
	// Trace: core/rtl/ibex_alu.sv:90:3
	assign adder_result_o = adder_result;
	// Trace: core/rtl/ibex_alu.sv:96:3
	wire is_equal;
	// Trace: core/rtl/ibex_alu.sv:97:3
	reg is_greater_equal;
	// Trace: core/rtl/ibex_alu.sv:98:3
	reg cmp_signed;
	// Trace: core/rtl/ibex_alu.sv:100:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:101:5
		(* full_case, parallel_case *)
		case (operator_i)
			6'd21, 6'd19, 6'd37, 6'd25, 6'd27:
				// Trace: core/rtl/ibex_alu.sv:107:16
				cmp_signed = 1'b1;
			default:
				// Trace: core/rtl/ibex_alu.sv:109:16
				cmp_signed = 1'b0;
		endcase
	end
	// Trace: core/rtl/ibex_alu.sv:113:3
	assign is_equal = adder_result == 32'b00000000000000000000000000000000;
	// Trace: core/rtl/ibex_alu.sv:114:3
	assign is_equal_result_o = is_equal;
	// Trace: core/rtl/ibex_alu.sv:117:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:118:5
		if ((operand_a_i[31] ^ operand_b_i[31]) == 1'b0)
			// Trace: core/rtl/ibex_alu.sv:119:7
			is_greater_equal = adder_result[31] == 1'b0;
		else
			// Trace: core/rtl/ibex_alu.sv:121:7
			is_greater_equal = operand_a_i[31] ^ cmp_signed;
	end
	// Trace: core/rtl/ibex_alu.sv:138:3
	reg cmp_result;
	// Trace: core/rtl/ibex_alu.sv:140:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:141:5
		(* full_case, parallel_case *)
		case (operator_i)
			6'd23:
				// Trace: core/rtl/ibex_alu.sv:142:27
				cmp_result = is_equal;
			6'd24:
				// Trace: core/rtl/ibex_alu.sv:143:27
				cmp_result = ~is_equal;
			6'd21, 6'd22, 6'd27, 6'd28:
				// Trace: core/rtl/ibex_alu.sv:145:27
				cmp_result = is_greater_equal;
			6'd19, 6'd20, 6'd25, 6'd26, 6'd37, 6'd38:
				// Trace: core/rtl/ibex_alu.sv:148:27
				cmp_result = ~is_greater_equal;
			default:
				// Trace: core/rtl/ibex_alu.sv:150:16
				cmp_result = is_equal;
		endcase
	end
	// Trace: core/rtl/ibex_alu.sv:154:3
	assign comparison_result_o = cmp_result;
	// Trace: core/rtl/ibex_alu.sv:223:3
	reg shift_left;
	// Trace: core/rtl/ibex_alu.sv:224:3
	wire shift_ones;
	// Trace: core/rtl/ibex_alu.sv:225:3
	wire shift_arith;
	// Trace: core/rtl/ibex_alu.sv:226:3
	wire shift_funnel;
	// Trace: core/rtl/ibex_alu.sv:227:3
	wire shift_sbmode;
	// Trace: core/rtl/ibex_alu.sv:228:3
	reg [5:0] shift_amt;
	// Trace: core/rtl/ibex_alu.sv:229:3
	wire [5:0] shift_amt_compl;
	// Trace: core/rtl/ibex_alu.sv:231:3
	reg [31:0] shift_operand;
	// Trace: core/rtl/ibex_alu.sv:232:3
	reg [32:0] shift_result_ext;
	// Trace: core/rtl/ibex_alu.sv:233:3
	reg unused_shift_result_ext;
	// Trace: core/rtl/ibex_alu.sv:234:3
	reg [31:0] shift_result;
	// Trace: core/rtl/ibex_alu.sv:235:3
	reg [31:0] shift_result_rev;
	// Trace: core/rtl/ibex_alu.sv:238:3
	wire bfp_op;
	// Trace: core/rtl/ibex_alu.sv:239:3
	wire [4:0] bfp_len;
	// Trace: core/rtl/ibex_alu.sv:240:3
	wire [4:0] bfp_off;
	// Trace: core/rtl/ibex_alu.sv:241:3
	wire [31:0] bfp_mask;
	// Trace: core/rtl/ibex_alu.sv:242:3
	wire [31:0] bfp_mask_rev;
	// Trace: core/rtl/ibex_alu.sv:243:3
	wire [31:0] bfp_result;
	// Trace: core/rtl/ibex_alu.sv:246:3
	assign bfp_op = (RV32B != 32'sd0 ? operator_i == 6'd49 : 1'b0);
	// Trace: core/rtl/ibex_alu.sv:247:3
	assign bfp_len = {~(|operand_b_i[27:24]), operand_b_i[27:24]};
	// Trace: core/rtl/ibex_alu.sv:248:3
	assign bfp_off = operand_b_i[20:16];
	// Trace: core/rtl/ibex_alu.sv:249:3
	assign bfp_mask = (RV32B != 32'sd0 ? ~(32'hffffffff << bfp_len) : {32 {1'sb0}});
	// Trace: core/rtl/ibex_alu.sv:250:3
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < 32; _gv_i_1 = _gv_i_1 + 1) begin : gen_rev_bfp_mask
			localparam i = _gv_i_1;
			// Trace: core/rtl/ibex_alu.sv:251:5
			assign bfp_mask_rev[i] = bfp_mask[31 - i];
		end
	endgenerate
	// Trace: core/rtl/ibex_alu.sv:254:3
	assign bfp_result = (RV32B != 32'sd0 ? (~shift_result & operand_a_i) | ((operand_b_i & bfp_mask) << bfp_off) : {32 {1'sb0}});
	// Trace: core/rtl/ibex_alu.sv:259:3
	wire [1:1] sv2v_tmp_BA5F8;
	assign sv2v_tmp_BA5F8 = operand_b_i[5] & shift_funnel;
	always @(*) shift_amt[5] = sv2v_tmp_BA5F8;
	// Trace: core/rtl/ibex_alu.sv:260:3
	assign shift_amt_compl = 32 - operand_b_i[4:0];
	// Trace: core/rtl/ibex_alu.sv:262:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:263:5
		if (bfp_op)
			// Trace: core/rtl/ibex_alu.sv:264:7
			shift_amt[4:0] = bfp_off;
		else
			// Trace: core/rtl/ibex_alu.sv:266:7
			shift_amt[4:0] = (instr_first_cycle_i ? (operand_b_i[5] && shift_funnel ? shift_amt_compl[4:0] : operand_b_i[4:0]) : (operand_b_i[5] && shift_funnel ? operand_b_i[4:0] : shift_amt_compl[4:0]));
	end
	// Trace: core/rtl/ibex_alu.sv:273:3
	assign shift_sbmode = (RV32B != 32'sd0 ? ((operator_i == 6'd43) | (operator_i == 6'd44)) | (operator_i == 6'd45) : 1'b0);
	// Trace: core/rtl/ibex_alu.sv:284:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:285:5
		(* full_case, parallel_case *)
		case (operator_i)
			6'd10:
				// Trace: core/rtl/ibex_alu.sv:286:16
				shift_left = 1'b1;
			6'd12, 6'd49:
				// Trace: core/rtl/ibex_alu.sv:288:16
				shift_left = (RV32B != 32'sd0 ? 1'b1 : 1'b0);
			6'd14:
				// Trace: core/rtl/ibex_alu.sv:289:16
				shift_left = (RV32B != 32'sd0 ? instr_first_cycle_i : 0);
			6'd13:
				// Trace: core/rtl/ibex_alu.sv:290:16
				shift_left = (RV32B != 32'sd0 ? ~instr_first_cycle_i : 0);
			6'd41:
				// Trace: core/rtl/ibex_alu.sv:291:16
				shift_left = (RV32B != 32'sd0 ? (shift_amt[5] ? ~instr_first_cycle_i : instr_first_cycle_i) : 1'b0);
			6'd42:
				// Trace: core/rtl/ibex_alu.sv:293:16
				shift_left = (RV32B != 32'sd0 ? (shift_amt[5] ? instr_first_cycle_i : ~instr_first_cycle_i) : 1'b0);
			default:
				// Trace: core/rtl/ibex_alu.sv:295:16
				shift_left = 1'b0;
		endcase
		if (shift_sbmode)
			// Trace: core/rtl/ibex_alu.sv:298:7
			shift_left = 1'b1;
	end
	// Trace: core/rtl/ibex_alu.sv:302:3
	assign shift_arith = operator_i == 6'd8;
	// Trace: core/rtl/ibex_alu.sv:303:3
	assign shift_ones = (RV32B != 32'sd0 ? (operator_i == 6'd12) | (operator_i == 6'd11) : 1'b0);
	// Trace: core/rtl/ibex_alu.sv:305:3
	assign shift_funnel = (RV32B != 32'sd0 ? (operator_i == 6'd41) | (operator_i == 6'd42) : 1'b0);
	// Trace: core/rtl/ibex_alu.sv:309:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:312:5
		if (RV32B == 32'sd0)
			// Trace: core/rtl/ibex_alu.sv:313:7
			shift_operand = (shift_left ? operand_a_rev : operand_a_i);
		else
			// Trace: core/rtl/ibex_alu.sv:315:7
			(* full_case, parallel_case *)
			case (1'b1)
				bfp_op:
					// Trace: core/rtl/ibex_alu.sv:316:23
					shift_operand = bfp_mask_rev;
				shift_sbmode:
					// Trace: core/rtl/ibex_alu.sv:317:23
					shift_operand = 32'h80000000;
				default:
					// Trace: core/rtl/ibex_alu.sv:318:23
					shift_operand = (shift_left ? operand_a_rev : operand_a_i);
			endcase
		// Trace: core/rtl/ibex_alu.sv:322:5
		shift_result_ext = $unsigned($signed({shift_ones | (shift_arith & shift_operand[31]), shift_operand}) >>> shift_amt[4:0]);
		// Trace: core/rtl/ibex_alu.sv:326:5
		shift_result = shift_result_ext[31:0];
		// Trace: core/rtl/ibex_alu.sv:327:5
		unused_shift_result_ext = shift_result_ext[32];
		begin : sv2v_autoblock_1
			// Trace: core/rtl/ibex_alu.sv:329:10
			reg [31:0] i;
			// Trace: core/rtl/ibex_alu.sv:329:10
			for (i = 0; i < 32; i = i + 1)
				begin
					// Trace: core/rtl/ibex_alu.sv:330:7
					shift_result_rev[i] = shift_result[31 - i];
				end
		end
		// Trace: core/rtl/ibex_alu.sv:333:5
		shift_result = (shift_left ? shift_result_rev : shift_result);
	end
	// Trace: core/rtl/ibex_alu.sv:341:3
	wire bwlogic_or;
	// Trace: core/rtl/ibex_alu.sv:342:3
	wire bwlogic_and;
	// Trace: core/rtl/ibex_alu.sv:343:3
	wire [31:0] bwlogic_operand_b;
	// Trace: core/rtl/ibex_alu.sv:344:3
	wire [31:0] bwlogic_or_result;
	// Trace: core/rtl/ibex_alu.sv:345:3
	wire [31:0] bwlogic_and_result;
	// Trace: core/rtl/ibex_alu.sv:346:3
	wire [31:0] bwlogic_xor_result;
	// Trace: core/rtl/ibex_alu.sv:347:3
	reg [31:0] bwlogic_result;
	// Trace: core/rtl/ibex_alu.sv:349:3
	reg bwlogic_op_b_negate;
	// Trace: core/rtl/ibex_alu.sv:351:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:352:5
		(* full_case, parallel_case *)
		case (operator_i)
			6'd5, 6'd6, 6'd7:
				// Trace: core/rtl/ibex_alu.sv:356:17
				bwlogic_op_b_negate = (RV32B != 32'sd0 ? 1'b1 : 1'b0);
			6'd40:
				// Trace: core/rtl/ibex_alu.sv:357:17
				bwlogic_op_b_negate = (RV32B != 32'sd0 ? ~instr_first_cycle_i : 1'b0);
			default:
				// Trace: core/rtl/ibex_alu.sv:358:17
				bwlogic_op_b_negate = 1'b0;
		endcase
	end
	// Trace: core/rtl/ibex_alu.sv:362:3
	assign bwlogic_operand_b = (bwlogic_op_b_negate ? operand_b_neg[32:1] : operand_b_i);
	// Trace: core/rtl/ibex_alu.sv:364:3
	assign bwlogic_or_result = operand_a_i | bwlogic_operand_b;
	// Trace: core/rtl/ibex_alu.sv:365:3
	assign bwlogic_and_result = operand_a_i & bwlogic_operand_b;
	// Trace: core/rtl/ibex_alu.sv:366:3
	assign bwlogic_xor_result = operand_a_i ^ bwlogic_operand_b;
	// Trace: core/rtl/ibex_alu.sv:368:3
	assign bwlogic_or = (operator_i == 6'd3) | (operator_i == 6'd6);
	// Trace: core/rtl/ibex_alu.sv:369:3
	assign bwlogic_and = (operator_i == 6'd4) | (operator_i == 6'd7);
	// Trace: core/rtl/ibex_alu.sv:371:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:372:5
		(* full_case, parallel_case *)
		case (1'b1)
			bwlogic_or:
				// Trace: core/rtl/ibex_alu.sv:373:20
				bwlogic_result = bwlogic_or_result;
			bwlogic_and:
				// Trace: core/rtl/ibex_alu.sv:374:20
				bwlogic_result = bwlogic_and_result;
			default:
				// Trace: core/rtl/ibex_alu.sv:375:20
				bwlogic_result = bwlogic_xor_result;
		endcase
	end
	// Trace: core/rtl/ibex_alu.sv:379:3
	wire [5:0] bitcnt_result;
	// Trace: core/rtl/ibex_alu.sv:380:3
	wire [31:0] minmax_result;
	// Trace: core/rtl/ibex_alu.sv:381:3
	reg [31:0] pack_result;
	// Trace: core/rtl/ibex_alu.sv:382:3
	wire [31:0] sext_result;
	// Trace: core/rtl/ibex_alu.sv:383:3
	reg [31:0] singlebit_result;
	// Trace: core/rtl/ibex_alu.sv:384:3
	reg [31:0] rev_result;
	// Trace: core/rtl/ibex_alu.sv:385:3
	reg [31:0] shuffle_result;
	// Trace: core/rtl/ibex_alu.sv:386:3
	reg [31:0] butterfly_result;
	// Trace: core/rtl/ibex_alu.sv:387:3
	reg [31:0] invbutterfly_result;
	// Trace: core/rtl/ibex_alu.sv:388:3
	reg [31:0] clmul_result;
	// Trace: core/rtl/ibex_alu.sv:389:3
	reg [31:0] multicycle_result;
	// Trace: core/rtl/ibex_alu.sv:391:3
	generate
		if (RV32B != 32'sd0) begin : g_alu_rvb
			// Trace: core/rtl/ibex_alu.sv:402:5
			wire zbe_op;
			// Trace: core/rtl/ibex_alu.sv:403:5
			wire bitcnt_ctz;
			// Trace: core/rtl/ibex_alu.sv:404:5
			wire bitcnt_clz;
			// Trace: core/rtl/ibex_alu.sv:405:5
			wire bitcnt_cz;
			// Trace: core/rtl/ibex_alu.sv:406:5
			reg [31:0] bitcnt_bits;
			// Trace: core/rtl/ibex_alu.sv:407:5
			wire [31:0] bitcnt_mask_op;
			// Trace: core/rtl/ibex_alu.sv:408:5
			reg [31:0] bitcnt_bit_mask;
			// Trace: core/rtl/ibex_alu.sv:409:5
			reg [191:0] bitcnt_partial;
			// Trace: core/rtl/ibex_alu.sv:410:5
			wire [31:0] bitcnt_partial_lsb_d;
			// Trace: core/rtl/ibex_alu.sv:411:5
			wire [31:0] bitcnt_partial_msb_d;
			// Trace: core/rtl/ibex_alu.sv:414:5
			assign bitcnt_ctz = operator_i == 6'd35;
			// Trace: core/rtl/ibex_alu.sv:415:5
			assign bitcnt_clz = operator_i == 6'd34;
			// Trace: core/rtl/ibex_alu.sv:416:5
			assign bitcnt_cz = bitcnt_ctz | bitcnt_clz;
			// Trace: core/rtl/ibex_alu.sv:417:5
			assign bitcnt_result = bitcnt_partial[0+:6];
			// Trace: core/rtl/ibex_alu.sv:423:5
			assign bitcnt_mask_op = (bitcnt_clz ? operand_a_rev : operand_a_i);
			// Trace: core/rtl/ibex_alu.sv:425:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_alu.sv:426:7
				bitcnt_bit_mask = bitcnt_mask_op;
				// Trace: core/rtl/ibex_alu.sv:427:7
				bitcnt_bit_mask = bitcnt_bit_mask | (bitcnt_bit_mask << 1);
				// Trace: core/rtl/ibex_alu.sv:428:7
				bitcnt_bit_mask = bitcnt_bit_mask | (bitcnt_bit_mask << 2);
				// Trace: core/rtl/ibex_alu.sv:429:7
				bitcnt_bit_mask = bitcnt_bit_mask | (bitcnt_bit_mask << 4);
				// Trace: core/rtl/ibex_alu.sv:430:7
				bitcnt_bit_mask = bitcnt_bit_mask | (bitcnt_bit_mask << 8);
				// Trace: core/rtl/ibex_alu.sv:431:7
				bitcnt_bit_mask = bitcnt_bit_mask | (bitcnt_bit_mask << 16);
				// Trace: core/rtl/ibex_alu.sv:432:7
				bitcnt_bit_mask = ~bitcnt_bit_mask;
			end
			// Trace: core/rtl/ibex_alu.sv:435:5
			assign zbe_op = (operator_i == 6'd47) | (operator_i == 6'd48);
			// Trace: core/rtl/ibex_alu.sv:437:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_alu.sv:438:7
				case (1'b1)
					zbe_op:
						// Trace: core/rtl/ibex_alu.sv:439:22
						bitcnt_bits = operand_b_i;
					bitcnt_cz:
						// Trace: core/rtl/ibex_alu.sv:440:22
						bitcnt_bits = bitcnt_bit_mask & ~bitcnt_mask_op;
					default:
						// Trace: core/rtl/ibex_alu.sv:441:22
						bitcnt_bits = operand_a_i;
				endcase
			end
			// Trace: core/rtl/ibex_alu.sv:486:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_alu.sv:487:7
				bitcnt_partial = {32 {6'b000000}};
				// Trace: core/rtl/ibex_alu.sv:489:7
				begin : sv2v_autoblock_2
					// Trace: core/rtl/ibex_alu.sv:489:12
					reg [31:0] i;
					// Trace: core/rtl/ibex_alu.sv:489:12
					for (i = 1; i < 32; i = i + 2)
						begin
							// Trace: core/rtl/ibex_alu.sv:490:9
							bitcnt_partial[(31 - i) * 6+:6] = {5'h00, bitcnt_bits[i]} + {5'h00, bitcnt_bits[i - 1]};
						end
				end
				begin : sv2v_autoblock_3
					// Trace: core/rtl/ibex_alu.sv:493:12
					reg [31:0] i;
					// Trace: core/rtl/ibex_alu.sv:493:12
					for (i = 3; i < 32; i = i + 4)
						begin
							// Trace: core/rtl/ibex_alu.sv:494:9
							bitcnt_partial[(31 - i) * 6+:6] = bitcnt_partial[(33 - i) * 6+:6] + bitcnt_partial[(31 - i) * 6+:6];
						end
				end
				begin : sv2v_autoblock_4
					// Trace: core/rtl/ibex_alu.sv:497:12
					reg [31:0] i;
					// Trace: core/rtl/ibex_alu.sv:497:12
					for (i = 7; i < 32; i = i + 8)
						begin
							// Trace: core/rtl/ibex_alu.sv:498:9
							bitcnt_partial[(31 - i) * 6+:6] = bitcnt_partial[(35 - i) * 6+:6] + bitcnt_partial[(31 - i) * 6+:6];
						end
				end
				begin : sv2v_autoblock_5
					// Trace: core/rtl/ibex_alu.sv:501:12
					reg [31:0] i;
					// Trace: core/rtl/ibex_alu.sv:501:12
					for (i = 15; i < 32; i = i + 16)
						begin
							// Trace: core/rtl/ibex_alu.sv:502:9
							bitcnt_partial[(31 - i) * 6+:6] = bitcnt_partial[(39 - i) * 6+:6] + bitcnt_partial[(31 - i) * 6+:6];
						end
				end
				// Trace: core/rtl/ibex_alu.sv:505:7
				bitcnt_partial[0+:6] = bitcnt_partial[96+:6] + bitcnt_partial[0+:6];
				// Trace: core/rtl/ibex_alu.sv:509:7
				bitcnt_partial[48+:6] = bitcnt_partial[96+:6] + bitcnt_partial[48+:6];
				begin : sv2v_autoblock_6
					// Trace: core/rtl/ibex_alu.sv:512:12
					reg [31:0] i;
					// Trace: core/rtl/ibex_alu.sv:512:12
					for (i = 11; i < 32; i = i + 8)
						begin
							// Trace: core/rtl/ibex_alu.sv:513:9
							bitcnt_partial[(31 - i) * 6+:6] = bitcnt_partial[(35 - i) * 6+:6] + bitcnt_partial[(31 - i) * 6+:6];
						end
				end
				begin : sv2v_autoblock_7
					// Trace: core/rtl/ibex_alu.sv:517:12
					reg [31:0] i;
					// Trace: core/rtl/ibex_alu.sv:517:12
					for (i = 5; i < 32; i = i + 4)
						begin
							// Trace: core/rtl/ibex_alu.sv:518:9
							bitcnt_partial[(31 - i) * 6+:6] = bitcnt_partial[(33 - i) * 6+:6] + bitcnt_partial[(31 - i) * 6+:6];
						end
				end
				// Trace: core/rtl/ibex_alu.sv:521:7
				bitcnt_partial[186+:6] = {5'h00, bitcnt_bits[0]};
				begin : sv2v_autoblock_8
					// Trace: core/rtl/ibex_alu.sv:522:12
					reg [31:0] i;
					// Trace: core/rtl/ibex_alu.sv:522:12
					for (i = 2; i < 32; i = i + 2)
						begin
							// Trace: core/rtl/ibex_alu.sv:523:9
							bitcnt_partial[(31 - i) * 6+:6] = bitcnt_partial[(32 - i) * 6+:6] + {5'h00, bitcnt_bits[i]};
						end
				end
			end
			// Trace: core/rtl/ibex_alu.sv:531:5
			assign minmax_result = (cmp_result ? operand_a_i : operand_b_i);
			// Trace: core/rtl/ibex_alu.sv:537:5
			wire packu;
			// Trace: core/rtl/ibex_alu.sv:538:5
			wire packh;
			// Trace: core/rtl/ibex_alu.sv:539:5
			assign packu = operator_i == 6'd30;
			// Trace: core/rtl/ibex_alu.sv:540:5
			assign packh = operator_i == 6'd31;
			// Trace: core/rtl/ibex_alu.sv:542:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_alu.sv:543:7
				(* full_case, parallel_case *)
				case (1'b1)
					packu:
						// Trace: core/rtl/ibex_alu.sv:544:18
						pack_result = {operand_b_i[31:16], operand_a_i[31:16]};
					packh:
						// Trace: core/rtl/ibex_alu.sv:545:18
						pack_result = {16'h0000, operand_b_i[7:0], operand_a_i[7:0]};
					default:
						// Trace: core/rtl/ibex_alu.sv:546:18
						pack_result = {operand_b_i[15:0], operand_a_i[15:0]};
				endcase
			end
			// Trace: core/rtl/ibex_alu.sv:554:5
			assign sext_result = (operator_i == 6'd32 ? {{24 {operand_a_i[7]}}, operand_a_i[7:0]} : {{16 {operand_a_i[15]}}, operand_a_i[15:0]});
			// Trace: core/rtl/ibex_alu.sv:561:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_alu.sv:562:7
				(* full_case, parallel_case *)
				case (operator_i)
					6'd43:
						// Trace: core/rtl/ibex_alu.sv:563:20
						singlebit_result = operand_a_i | shift_result;
					6'd44:
						// Trace: core/rtl/ibex_alu.sv:564:20
						singlebit_result = operand_a_i & ~shift_result;
					6'd45:
						// Trace: core/rtl/ibex_alu.sv:565:20
						singlebit_result = operand_a_i ^ shift_result;
					default:
						// Trace: core/rtl/ibex_alu.sv:566:20
						singlebit_result = {31'h00000000, shift_result[0]};
				endcase
			end
			// Trace: core/rtl/ibex_alu.sv:578:5
			wire [4:0] zbp_shift_amt;
			// Trace: core/rtl/ibex_alu.sv:579:5
			wire gorc_op;
			// Trace: core/rtl/ibex_alu.sv:581:5
			assign gorc_op = operator_i == 6'd16;
			// Trace: core/rtl/ibex_alu.sv:582:5
			assign zbp_shift_amt[2:0] = (RV32B == 32'sd2 ? shift_amt[2:0] : {3 {&shift_amt[2:0]}});
			// Trace: core/rtl/ibex_alu.sv:583:5
			assign zbp_shift_amt[4:3] = (RV32B == 32'sd2 ? shift_amt[4:3] : {2 {&shift_amt[4:3]}});
			// Trace: core/rtl/ibex_alu.sv:585:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_alu.sv:586:7
				rev_result = operand_a_i;
				// Trace: core/rtl/ibex_alu.sv:588:7
				if (zbp_shift_amt[0])
					// Trace: core/rtl/ibex_alu.sv:589:9
					rev_result = ((gorc_op ? rev_result : 32'h00000000) | ((rev_result & 32'h55555555) << 1)) | ((rev_result & 32'haaaaaaaa) >> 1);
				if (zbp_shift_amt[1])
					// Trace: core/rtl/ibex_alu.sv:595:9
					rev_result = ((gorc_op ? rev_result : 32'h00000000) | ((rev_result & 32'h33333333) << 2)) | ((rev_result & 32'hcccccccc) >> 2);
				if (zbp_shift_amt[2])
					// Trace: core/rtl/ibex_alu.sv:601:9
					rev_result = ((gorc_op ? rev_result : 32'h00000000) | ((rev_result & 32'h0f0f0f0f) << 4)) | ((rev_result & 32'hf0f0f0f0) >> 4);
				if (zbp_shift_amt[3])
					// Trace: core/rtl/ibex_alu.sv:607:9
					rev_result = ((gorc_op & (RV32B == 32'sd2) ? rev_result : 32'h00000000) | ((rev_result & 32'h00ff00ff) << 8)) | ((rev_result & 32'hff00ff00) >> 8);
				if (zbp_shift_amt[4])
					// Trace: core/rtl/ibex_alu.sv:613:9
					rev_result = ((gorc_op & (RV32B == 32'sd2) ? rev_result : 32'h00000000) | ((rev_result & 32'h0000ffff) << 16)) | ((rev_result & 32'hffff0000) >> 16);
			end
			// Trace: core/rtl/ibex_alu.sv:619:5
			wire crc_hmode;
			// Trace: core/rtl/ibex_alu.sv:620:5
			wire crc_bmode;
			// Trace: core/rtl/ibex_alu.sv:621:5
			wire [31:0] clmul_result_rev;
			if (RV32B == 32'sd2) begin : gen_alu_rvb_full
				// Trace: core/rtl/ibex_alu.sv:629:7
				localparam [127:0] SHUFFLE_MASK_L = 128'h00ff00000f000f003030303044444444;
				// Trace: core/rtl/ibex_alu.sv:631:7
				localparam [127:0] SHUFFLE_MASK_R = 128'h0000ff0000f000f00c0c0c0c22222222;
				// Trace: core/rtl/ibex_alu.sv:634:7
				localparam [127:0] FLIP_MASK_L = 128'h22001100004400004411000011000000;
				// Trace: core/rtl/ibex_alu.sv:636:7
				localparam [127:0] FLIP_MASK_R = 128'h00880044000022000000882200000088;
				// Trace: core/rtl/ibex_alu.sv:639:7
				wire [31:0] SHUFFLE_MASK_NOT [0:3];
				genvar _gv_i_2;
				for (_gv_i_2 = 0; _gv_i_2 < 4; _gv_i_2 = _gv_i_2 + 1) begin : gen_shuffle_mask_not
					localparam i = _gv_i_2;
					// Trace: core/rtl/ibex_alu.sv:641:9
					assign SHUFFLE_MASK_NOT[i] = ~(SHUFFLE_MASK_L[(3 - i) * 32+:32] | SHUFFLE_MASK_R[(3 - i) * 32+:32]);
				end
				// Trace: core/rtl/ibex_alu.sv:644:7
				wire shuffle_flip;
				// Trace: core/rtl/ibex_alu.sv:645:7
				assign shuffle_flip = operator_i == 6'd18;
				// Trace: core/rtl/ibex_alu.sv:647:7
				reg [3:0] shuffle_mode;
				// Trace: core/rtl/ibex_alu.sv:649:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_alu.sv:650:9
					shuffle_result = operand_a_i;
					// Trace: core/rtl/ibex_alu.sv:652:9
					if (shuffle_flip) begin
						// Trace: core/rtl/ibex_alu.sv:653:11
						shuffle_mode[3] = shift_amt[0];
						// Trace: core/rtl/ibex_alu.sv:654:11
						shuffle_mode[2] = shift_amt[1];
						// Trace: core/rtl/ibex_alu.sv:655:11
						shuffle_mode[1] = shift_amt[2];
						// Trace: core/rtl/ibex_alu.sv:656:11
						shuffle_mode[0] = shift_amt[3];
					end
					else
						// Trace: core/rtl/ibex_alu.sv:658:11
						shuffle_mode = shift_amt[3:0];
					if (shuffle_flip)
						// Trace: core/rtl/ibex_alu.sv:662:11
						shuffle_result = ((((((((shuffle_result & 32'h88224411) | ((shuffle_result << 6) & FLIP_MASK_L[96+:32])) | ((shuffle_result >> 6) & FLIP_MASK_R[96+:32])) | ((shuffle_result << 9) & FLIP_MASK_L[64+:32])) | ((shuffle_result >> 9) & FLIP_MASK_R[64+:32])) | ((shuffle_result << 15) & FLIP_MASK_L[32+:32])) | ((shuffle_result >> 15) & FLIP_MASK_R[32+:32])) | ((shuffle_result << 21) & FLIP_MASK_L[0+:32])) | ((shuffle_result >> 21) & FLIP_MASK_R[0+:32]);
					if (shuffle_mode[3])
						// Trace: core/rtl/ibex_alu.sv:674:11
						shuffle_result = (shuffle_result & SHUFFLE_MASK_NOT[0]) | (((shuffle_result << 8) & SHUFFLE_MASK_L[96+:32]) | ((shuffle_result >> 8) & SHUFFLE_MASK_R[96+:32]));
					if (shuffle_mode[2])
						// Trace: core/rtl/ibex_alu.sv:679:11
						shuffle_result = (shuffle_result & SHUFFLE_MASK_NOT[1]) | (((shuffle_result << 4) & SHUFFLE_MASK_L[64+:32]) | ((shuffle_result >> 4) & SHUFFLE_MASK_R[64+:32]));
					if (shuffle_mode[1])
						// Trace: core/rtl/ibex_alu.sv:684:11
						shuffle_result = (shuffle_result & SHUFFLE_MASK_NOT[2]) | (((shuffle_result << 2) & SHUFFLE_MASK_L[32+:32]) | ((shuffle_result >> 2) & SHUFFLE_MASK_R[32+:32]));
					if (shuffle_mode[0])
						// Trace: core/rtl/ibex_alu.sv:689:11
						shuffle_result = (shuffle_result & SHUFFLE_MASK_NOT[3]) | (((shuffle_result << 1) & SHUFFLE_MASK_L[0+:32]) | ((shuffle_result >> 1) & SHUFFLE_MASK_R[0+:32]));
					if (shuffle_flip)
						// Trace: core/rtl/ibex_alu.sv:695:11
						shuffle_result = ((((((((shuffle_result & 32'h88224411) | ((shuffle_result << 6) & FLIP_MASK_L[96+:32])) | ((shuffle_result >> 6) & FLIP_MASK_R[96+:32])) | ((shuffle_result << 9) & FLIP_MASK_L[64+:32])) | ((shuffle_result >> 9) & FLIP_MASK_R[64+:32])) | ((shuffle_result << 15) & FLIP_MASK_L[32+:32])) | ((shuffle_result >> 15) & FLIP_MASK_R[32+:32])) | ((shuffle_result << 21) & FLIP_MASK_L[0+:32])) | ((shuffle_result >> 21) & FLIP_MASK_R[0+:32]);
				end
				// Trace: core/rtl/ibex_alu.sv:759:7
				reg [191:0] bitcnt_partial_q;
				genvar _gv_i_3;
				for (_gv_i_3 = 0; _gv_i_3 < 32; _gv_i_3 = _gv_i_3 + 1) begin : gen_bitcnt_reg_in_lsb
					localparam i = _gv_i_3;
					// Trace: core/rtl/ibex_alu.sv:764:9
					assign bitcnt_partial_lsb_d[i] = bitcnt_partial[(31 - i) * 6];
				end
				genvar _gv_i_4;
				for (_gv_i_4 = 0; _gv_i_4 < 16; _gv_i_4 = _gv_i_4 + 1) begin : gen_bitcnt_reg_in_b1
					localparam i = _gv_i_4;
					// Trace: core/rtl/ibex_alu.sv:768:9
					assign bitcnt_partial_msb_d[i] = bitcnt_partial[((31 - ((2 * i) + 1)) * 6) + 1];
				end
				genvar _gv_i_5;
				for (_gv_i_5 = 0; _gv_i_5 < 8; _gv_i_5 = _gv_i_5 + 1) begin : gen_bitcnt_reg_in_b2
					localparam i = _gv_i_5;
					// Trace: core/rtl/ibex_alu.sv:772:9
					assign bitcnt_partial_msb_d[16 + i] = bitcnt_partial[((31 - ((4 * i) + 3)) * 6) + 2];
				end
				genvar _gv_i_6;
				for (_gv_i_6 = 0; _gv_i_6 < 4; _gv_i_6 = _gv_i_6 + 1) begin : gen_bitcnt_reg_in_b3
					localparam i = _gv_i_6;
					// Trace: core/rtl/ibex_alu.sv:776:9
					assign bitcnt_partial_msb_d[24 + i] = bitcnt_partial[((31 - ((8 * i) + 7)) * 6) + 3];
				end
				genvar _gv_i_7;
				for (_gv_i_7 = 0; _gv_i_7 < 2; _gv_i_7 = _gv_i_7 + 1) begin : gen_bitcnt_reg_in_b4
					localparam i = _gv_i_7;
					// Trace: core/rtl/ibex_alu.sv:780:9
					assign bitcnt_partial_msb_d[28 + i] = bitcnt_partial[((31 - ((16 * i) + 15)) * 6) + 4];
				end
				// Trace: core/rtl/ibex_alu.sv:783:7
				assign bitcnt_partial_msb_d[30] = bitcnt_partial[5];
				// Trace: core/rtl/ibex_alu.sv:784:7
				assign bitcnt_partial_msb_d[31] = 1'b0;
				// Trace: core/rtl/ibex_alu.sv:788:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_alu.sv:789:9
					bitcnt_partial_q = {32 {6'b000000}};
					// Trace: core/rtl/ibex_alu.sv:791:9
					begin : sv2v_autoblock_9
						// Trace: core/rtl/ibex_alu.sv:791:14
						reg [31:0] i;
						// Trace: core/rtl/ibex_alu.sv:791:14
						for (i = 0; i < 32; i = i + 1)
							begin : gen_bitcnt_reg_out_lsb
								// Trace: core/rtl/ibex_alu.sv:792:11
								bitcnt_partial_q[(31 - i) * 6] = imd_val_q_i[32 + i];
							end
					end
					begin : sv2v_autoblock_10
						// Trace: core/rtl/ibex_alu.sv:795:14
						reg [31:0] i;
						// Trace: core/rtl/ibex_alu.sv:795:14
						for (i = 0; i < 16; i = i + 1)
							begin : gen_bitcnt_reg_out_b1
								// Trace: core/rtl/ibex_alu.sv:796:11
								bitcnt_partial_q[((31 - ((2 * i) + 1)) * 6) + 1] = imd_val_q_i[0 + i];
							end
					end
					begin : sv2v_autoblock_11
						// Trace: core/rtl/ibex_alu.sv:799:14
						reg [31:0] i;
						// Trace: core/rtl/ibex_alu.sv:799:14
						for (i = 0; i < 8; i = i + 1)
							begin : gen_bitcnt_reg_out_b2
								// Trace: core/rtl/ibex_alu.sv:800:11
								bitcnt_partial_q[((31 - ((4 * i) + 3)) * 6) + 2] = imd_val_q_i[16 + i];
							end
					end
					begin : sv2v_autoblock_12
						// Trace: core/rtl/ibex_alu.sv:803:14
						reg [31:0] i;
						// Trace: core/rtl/ibex_alu.sv:803:14
						for (i = 0; i < 4; i = i + 1)
							begin : gen_bitcnt_reg_out_b3
								// Trace: core/rtl/ibex_alu.sv:804:11
								bitcnt_partial_q[((31 - ((8 * i) + 7)) * 6) + 3] = imd_val_q_i[24 + i];
							end
					end
					begin : sv2v_autoblock_13
						// Trace: core/rtl/ibex_alu.sv:807:14
						reg [31:0] i;
						// Trace: core/rtl/ibex_alu.sv:807:14
						for (i = 0; i < 2; i = i + 1)
							begin : gen_bitcnt_reg_out_b4
								// Trace: core/rtl/ibex_alu.sv:808:11
								bitcnt_partial_q[((31 - ((16 * i) + 15)) * 6) + 4] = imd_val_q_i[28 + i];
							end
					end
					// Trace: core/rtl/ibex_alu.sv:811:9
					bitcnt_partial_q[5] = imd_val_q_i[30];
				end
				// Trace: core/rtl/ibex_alu.sv:814:7
				wire [31:0] butterfly_mask_l [0:4];
				// Trace: core/rtl/ibex_alu.sv:815:7
				wire [31:0] butterfly_mask_r [0:4];
				// Trace: core/rtl/ibex_alu.sv:816:7
				wire [31:0] butterfly_mask_not [0:4];
				// Trace: core/rtl/ibex_alu.sv:817:7
				wire [31:0] lrotc_stage [0:4];
				genvar _gv_stg_1;
				for (_gv_stg_1 = 0; _gv_stg_1 < 5; _gv_stg_1 = _gv_stg_1 + 1) begin : gen_butterfly_ctrl_stage
					localparam stg = _gv_stg_1;
					genvar _gv_seg_1;
					for (_gv_seg_1 = 0; _gv_seg_1 < (2 ** stg); _gv_seg_1 = _gv_seg_1 + 1) begin : gen_butterfly_ctrl
						localparam seg = _gv_seg_1;
						// Trace: core/rtl/ibex_alu.sv:827:11
						assign lrotc_stage[stg][((2 * (16 >> stg)) * (seg + 1)) - 1:(2 * (16 >> stg)) * seg] = {{16 >> stg {1'b0}}, {16 >> stg {1'b1}}} << bitcnt_partial_q[((32 - ((16 >> stg) * ((2 * seg) + 1))) * 6) + ($clog2(16 >> stg) >= 0 ? $clog2(16 >> stg) : ($clog2(16 >> stg) + ($clog2(16 >> stg) >= 0 ? $clog2(16 >> stg) + 1 : 1 - $clog2(16 >> stg))) - 1)-:($clog2(16 >> stg) >= 0 ? $clog2(16 >> stg) + 1 : 1 - $clog2(16 >> stg))];
						// Trace: core/rtl/ibex_alu.sv:831:11
						assign butterfly_mask_l[stg][((16 >> stg) * ((2 * seg) + 2)) - 1:(16 >> stg) * ((2 * seg) + 1)] = ~lrotc_stage[stg][((16 >> stg) * ((2 * seg) + 2)) - 1:(16 >> stg) * ((2 * seg) + 1)];
						// Trace: core/rtl/ibex_alu.sv:834:11
						assign butterfly_mask_r[stg][((16 >> stg) * ((2 * seg) + 1)) - 1:(16 >> stg) * (2 * seg)] = ~lrotc_stage[stg][((16 >> stg) * ((2 * seg) + 2)) - 1:(16 >> stg) * ((2 * seg) + 1)];
						// Trace: core/rtl/ibex_alu.sv:837:11
						assign butterfly_mask_l[stg][((16 >> stg) * ((2 * seg) + 1)) - 1:(16 >> stg) * (2 * seg)] = 1'sb0;
						// Trace: core/rtl/ibex_alu.sv:838:11
						assign butterfly_mask_r[stg][((16 >> stg) * ((2 * seg) + 2)) - 1:(16 >> stg) * ((2 * seg) + 1)] = 1'sb0;
					end
				end
				genvar _gv_stg_2;
				for (_gv_stg_2 = 0; _gv_stg_2 < 5; _gv_stg_2 = _gv_stg_2 + 1) begin : gen_butterfly_not
					localparam stg = _gv_stg_2;
					// Trace: core/rtl/ibex_alu.sv:844:9
					assign butterfly_mask_not[stg] = ~(butterfly_mask_l[stg] | butterfly_mask_r[stg]);
				end
				// Trace: core/rtl/ibex_alu.sv:848:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_alu.sv:849:9
					butterfly_result = operand_a_i;
					// Trace: core/rtl/ibex_alu.sv:851:9
					butterfly_result = ((butterfly_result & butterfly_mask_not[0]) | ((butterfly_result & butterfly_mask_l[0]) >> 16)) | ((butterfly_result & butterfly_mask_r[0]) << 16);
					// Trace: core/rtl/ibex_alu.sv:855:9
					butterfly_result = ((butterfly_result & butterfly_mask_not[1]) | ((butterfly_result & butterfly_mask_l[1]) >> 8)) | ((butterfly_result & butterfly_mask_r[1]) << 8);
					// Trace: core/rtl/ibex_alu.sv:859:9
					butterfly_result = ((butterfly_result & butterfly_mask_not[2]) | ((butterfly_result & butterfly_mask_l[2]) >> 4)) | ((butterfly_result & butterfly_mask_r[2]) << 4);
					// Trace: core/rtl/ibex_alu.sv:863:9
					butterfly_result = ((butterfly_result & butterfly_mask_not[3]) | ((butterfly_result & butterfly_mask_l[3]) >> 2)) | ((butterfly_result & butterfly_mask_r[3]) << 2);
					// Trace: core/rtl/ibex_alu.sv:867:9
					butterfly_result = ((butterfly_result & butterfly_mask_not[4]) | ((butterfly_result & butterfly_mask_l[4]) >> 1)) | ((butterfly_result & butterfly_mask_r[4]) << 1);
					// Trace: core/rtl/ibex_alu.sv:871:9
					butterfly_result = butterfly_result & operand_b_i;
				end
				// Trace: core/rtl/ibex_alu.sv:874:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_alu.sv:875:9
					invbutterfly_result = operand_a_i & operand_b_i;
					// Trace: core/rtl/ibex_alu.sv:877:9
					invbutterfly_result = ((invbutterfly_result & butterfly_mask_not[4]) | ((invbutterfly_result & butterfly_mask_l[4]) >> 1)) | ((invbutterfly_result & butterfly_mask_r[4]) << 1);
					// Trace: core/rtl/ibex_alu.sv:881:9
					invbutterfly_result = ((invbutterfly_result & butterfly_mask_not[3]) | ((invbutterfly_result & butterfly_mask_l[3]) >> 2)) | ((invbutterfly_result & butterfly_mask_r[3]) << 2);
					// Trace: core/rtl/ibex_alu.sv:885:9
					invbutterfly_result = ((invbutterfly_result & butterfly_mask_not[2]) | ((invbutterfly_result & butterfly_mask_l[2]) >> 4)) | ((invbutterfly_result & butterfly_mask_r[2]) << 4);
					// Trace: core/rtl/ibex_alu.sv:889:9
					invbutterfly_result = ((invbutterfly_result & butterfly_mask_not[1]) | ((invbutterfly_result & butterfly_mask_l[1]) >> 8)) | ((invbutterfly_result & butterfly_mask_r[1]) << 8);
					// Trace: core/rtl/ibex_alu.sv:893:9
					invbutterfly_result = ((invbutterfly_result & butterfly_mask_not[0]) | ((invbutterfly_result & butterfly_mask_l[0]) >> 16)) | ((invbutterfly_result & butterfly_mask_r[0]) << 16);
				end
				// Trace: core/rtl/ibex_alu.sv:959:7
				wire clmul_rmode;
				// Trace: core/rtl/ibex_alu.sv:960:7
				wire clmul_hmode;
				// Trace: core/rtl/ibex_alu.sv:961:7
				reg [31:0] clmul_op_a;
				// Trace: core/rtl/ibex_alu.sv:962:7
				reg [31:0] clmul_op_b;
				// Trace: core/rtl/ibex_alu.sv:963:7
				wire [31:0] operand_b_rev;
				// Trace: core/rtl/ibex_alu.sv:964:7
				wire [31:0] clmul_and_stage [0:31];
				// Trace: core/rtl/ibex_alu.sv:965:7
				wire [31:0] clmul_xor_stage1 [0:15];
				// Trace: core/rtl/ibex_alu.sv:966:7
				wire [31:0] clmul_xor_stage2 [0:7];
				// Trace: core/rtl/ibex_alu.sv:967:7
				wire [31:0] clmul_xor_stage3 [0:3];
				// Trace: core/rtl/ibex_alu.sv:968:7
				wire [31:0] clmul_xor_stage4 [0:1];
				// Trace: core/rtl/ibex_alu.sv:970:7
				wire [31:0] clmul_result_raw;
				genvar _gv_i_8;
				for (_gv_i_8 = 0; _gv_i_8 < 32; _gv_i_8 = _gv_i_8 + 1) begin : gen_rev_operand_b
					localparam i = _gv_i_8;
					// Trace: core/rtl/ibex_alu.sv:973:9
					assign operand_b_rev[i] = operand_b_i[31 - i];
				end
				// Trace: core/rtl/ibex_alu.sv:976:7
				assign clmul_rmode = operator_i == 6'd51;
				// Trace: core/rtl/ibex_alu.sv:977:7
				assign clmul_hmode = operator_i == 6'd52;
				// Trace: core/rtl/ibex_alu.sv:980:7
				localparam [31:0] CRC32_POLYNOMIAL = 32'h04c11db7;
				// Trace: core/rtl/ibex_alu.sv:981:7
				localparam [31:0] CRC32_MU_REV = 32'hf7011641;
				// Trace: core/rtl/ibex_alu.sv:983:7
				localparam [31:0] CRC32C_POLYNOMIAL = 32'h1edc6f41;
				// Trace: core/rtl/ibex_alu.sv:984:7
				localparam [31:0] CRC32C_MU_REV = 32'hdea713f1;
				// Trace: core/rtl/ibex_alu.sv:986:7
				wire crc_op;
				// Trace: core/rtl/ibex_alu.sv:988:7
				wire crc_cpoly;
				// Trace: core/rtl/ibex_alu.sv:990:7
				reg [31:0] crc_operand;
				// Trace: core/rtl/ibex_alu.sv:991:7
				wire [31:0] crc_poly;
				// Trace: core/rtl/ibex_alu.sv:992:7
				wire [31:0] crc_mu_rev;
				// Trace: core/rtl/ibex_alu.sv:994:7
				assign crc_op = (((((operator_i == 6'd58) | (operator_i == 6'd57)) | (operator_i == 6'd56)) | (operator_i == 6'd55)) | (operator_i == 6'd54)) | (operator_i == 6'd53);
				// Trace: core/rtl/ibex_alu.sv:998:7
				assign crc_cpoly = ((operator_i == 6'd58) | (operator_i == 6'd56)) | (operator_i == 6'd54);
				// Trace: core/rtl/ibex_alu.sv:1002:7
				assign crc_hmode = (operator_i == 6'd55) | (operator_i == 6'd56);
				// Trace: core/rtl/ibex_alu.sv:1003:7
				assign crc_bmode = (operator_i == 6'd53) | (operator_i == 6'd54);
				// Trace: core/rtl/ibex_alu.sv:1005:7
				assign crc_poly = (crc_cpoly ? CRC32C_POLYNOMIAL : CRC32_POLYNOMIAL);
				// Trace: core/rtl/ibex_alu.sv:1006:7
				assign crc_mu_rev = (crc_cpoly ? CRC32C_MU_REV : CRC32_MU_REV);
				// Trace: core/rtl/ibex_alu.sv:1008:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_alu.sv:1009:9
					(* full_case, parallel_case *)
					case (1'b1)
						crc_bmode:
							// Trace: core/rtl/ibex_alu.sv:1010:22
							crc_operand = {operand_a_i[7:0], 24'h000000};
						crc_hmode:
							// Trace: core/rtl/ibex_alu.sv:1011:22
							crc_operand = {operand_a_i[15:0], 16'h0000};
						default:
							// Trace: core/rtl/ibex_alu.sv:1012:22
							crc_operand = operand_a_i;
					endcase
				end
				// Trace: core/rtl/ibex_alu.sv:1017:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_alu.sv:1018:9
					if (crc_op) begin
						// Trace: core/rtl/ibex_alu.sv:1019:11
						clmul_op_a = (instr_first_cycle_i ? crc_operand : imd_val_q_i[32+:32]);
						// Trace: core/rtl/ibex_alu.sv:1020:11
						clmul_op_b = (instr_first_cycle_i ? crc_mu_rev : crc_poly);
					end
					else begin
						// Trace: core/rtl/ibex_alu.sv:1022:11
						clmul_op_a = (clmul_rmode | clmul_hmode ? operand_a_rev : operand_a_i);
						// Trace: core/rtl/ibex_alu.sv:1023:11
						clmul_op_b = (clmul_rmode | clmul_hmode ? operand_b_rev : operand_b_i);
					end
				end
				genvar _gv_i_9;
				for (_gv_i_9 = 0; _gv_i_9 < 32; _gv_i_9 = _gv_i_9 + 1) begin : gen_clmul_and_op
					localparam i = _gv_i_9;
					// Trace: core/rtl/ibex_alu.sv:1028:9
					assign clmul_and_stage[i] = (clmul_op_b[i] ? clmul_op_a << i : {32 {1'sb0}});
				end
				genvar _gv_i_10;
				for (_gv_i_10 = 0; _gv_i_10 < 16; _gv_i_10 = _gv_i_10 + 1) begin : gen_clmul_xor_op_l1
					localparam i = _gv_i_10;
					// Trace: core/rtl/ibex_alu.sv:1032:9
					assign clmul_xor_stage1[i] = clmul_and_stage[2 * i] ^ clmul_and_stage[(2 * i) + 1];
				end
				genvar _gv_i_11;
				for (_gv_i_11 = 0; _gv_i_11 < 8; _gv_i_11 = _gv_i_11 + 1) begin : gen_clmul_xor_op_l2
					localparam i = _gv_i_11;
					// Trace: core/rtl/ibex_alu.sv:1036:9
					assign clmul_xor_stage2[i] = clmul_xor_stage1[2 * i] ^ clmul_xor_stage1[(2 * i) + 1];
				end
				genvar _gv_i_12;
				for (_gv_i_12 = 0; _gv_i_12 < 4; _gv_i_12 = _gv_i_12 + 1) begin : gen_clmul_xor_op_l3
					localparam i = _gv_i_12;
					// Trace: core/rtl/ibex_alu.sv:1040:9
					assign clmul_xor_stage3[i] = clmul_xor_stage2[2 * i] ^ clmul_xor_stage2[(2 * i) + 1];
				end
				genvar _gv_i_13;
				for (_gv_i_13 = 0; _gv_i_13 < 2; _gv_i_13 = _gv_i_13 + 1) begin : gen_clmul_xor_op_l4
					localparam i = _gv_i_13;
					// Trace: core/rtl/ibex_alu.sv:1044:9
					assign clmul_xor_stage4[i] = clmul_xor_stage3[2 * i] ^ clmul_xor_stage3[(2 * i) + 1];
				end
				// Trace: core/rtl/ibex_alu.sv:1047:7
				assign clmul_result_raw = clmul_xor_stage4[0] ^ clmul_xor_stage4[1];
				genvar _gv_i_14;
				for (_gv_i_14 = 0; _gv_i_14 < 32; _gv_i_14 = _gv_i_14 + 1) begin : gen_rev_clmul_result
					localparam i = _gv_i_14;
					// Trace: core/rtl/ibex_alu.sv:1050:9
					assign clmul_result_rev[i] = clmul_result_raw[31 - i];
				end
				// Trace: core/rtl/ibex_alu.sv:1055:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_alu.sv:1056:9
					case (1'b1)
						clmul_rmode:
							// Trace: core/rtl/ibex_alu.sv:1057:24
							clmul_result = clmul_result_rev;
						clmul_hmode:
							// Trace: core/rtl/ibex_alu.sv:1058:24
							clmul_result = {1'b0, clmul_result_rev[31:1]};
						default:
							// Trace: core/rtl/ibex_alu.sv:1059:24
							clmul_result = clmul_result_raw;
					endcase
				end
			end
			else begin : gen_alu_rvb_notfull
				// Trace: core/rtl/ibex_alu.sv:1063:7
				wire [31:0] unused_imd_val_q_1;
				// Trace: core/rtl/ibex_alu.sv:1064:7
				assign unused_imd_val_q_1 = imd_val_q_i[0+:32];
				// Trace: core/rtl/ibex_alu.sv:1065:7
				wire [32:1] sv2v_tmp_4A308;
				assign sv2v_tmp_4A308 = 1'sb0;
				always @(*) shuffle_result = sv2v_tmp_4A308;
				// Trace: core/rtl/ibex_alu.sv:1066:7
				wire [32:1] sv2v_tmp_98122;
				assign sv2v_tmp_98122 = 1'sb0;
				always @(*) butterfly_result = sv2v_tmp_98122;
				// Trace: core/rtl/ibex_alu.sv:1067:7
				wire [32:1] sv2v_tmp_B39E0;
				assign sv2v_tmp_B39E0 = 1'sb0;
				always @(*) invbutterfly_result = sv2v_tmp_B39E0;
				// Trace: core/rtl/ibex_alu.sv:1068:7
				wire [32:1] sv2v_tmp_31DA6;
				assign sv2v_tmp_31DA6 = 1'sb0;
				always @(*) clmul_result = sv2v_tmp_31DA6;
				// Trace: core/rtl/ibex_alu.sv:1070:7
				assign bitcnt_partial_lsb_d = 1'sb0;
				// Trace: core/rtl/ibex_alu.sv:1071:7
				assign bitcnt_partial_msb_d = 1'sb0;
				// Trace: core/rtl/ibex_alu.sv:1072:7
				assign clmul_result_rev = 1'sb0;
				// Trace: core/rtl/ibex_alu.sv:1073:7
				assign crc_bmode = 1'sb0;
				// Trace: core/rtl/ibex_alu.sv:1074:7
				assign crc_hmode = 1'sb0;
			end
			// Trace: core/rtl/ibex_alu.sv:1084:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_alu.sv:1085:7
				(* full_case, parallel_case *)
				case (operator_i)
					6'd39: begin
						// Trace: core/rtl/ibex_alu.sv:1087:11
						multicycle_result = (operand_b_i == 32'h00000000 ? operand_a_i : imd_val_q_i[32+:32]);
						// Trace: core/rtl/ibex_alu.sv:1088:11
						imd_val_d_o = {operand_a_i, 32'h00000000};
						// Trace: core/rtl/ibex_alu.sv:1089:11
						if (instr_first_cycle_i)
							// Trace: core/rtl/ibex_alu.sv:1090:13
							imd_val_we_o = 2'b01;
						else
							// Trace: core/rtl/ibex_alu.sv:1092:13
							imd_val_we_o = 2'b00;
					end
					6'd40: begin
						// Trace: core/rtl/ibex_alu.sv:1097:11
						multicycle_result = imd_val_q_i[32+:32] | bwlogic_and_result;
						// Trace: core/rtl/ibex_alu.sv:1098:11
						imd_val_d_o = {bwlogic_and_result, 32'h00000000};
						// Trace: core/rtl/ibex_alu.sv:1099:11
						if (instr_first_cycle_i)
							// Trace: core/rtl/ibex_alu.sv:1100:13
							imd_val_we_o = 2'b01;
						else
							// Trace: core/rtl/ibex_alu.sv:1102:13
							imd_val_we_o = 2'b00;
					end
					6'd42, 6'd41, 6'd14, 6'd13: begin
						// Trace: core/rtl/ibex_alu.sv:1108:11
						if (shift_amt[4:0] == 5'h00)
							// Trace: core/rtl/ibex_alu.sv:1109:13
							multicycle_result = (shift_amt[5] ? operand_a_i : imd_val_q_i[32+:32]);
						else
							// Trace: core/rtl/ibex_alu.sv:1111:13
							multicycle_result = imd_val_q_i[32+:32] | shift_result;
						// Trace: core/rtl/ibex_alu.sv:1113:11
						imd_val_d_o = {shift_result, 32'h00000000};
						if (instr_first_cycle_i)
							// Trace: core/rtl/ibex_alu.sv:1115:13
							imd_val_we_o = 2'b01;
						else
							// Trace: core/rtl/ibex_alu.sv:1117:13
							imd_val_we_o = 2'b00;
					end
					6'd57, 6'd58, 6'd55, 6'd56, 6'd53, 6'd54:
						// Trace: core/rtl/ibex_alu.sv:1124:11
						if (RV32B == 32'sd2) begin
							// Trace: core/rtl/ibex_alu.sv:1125:13
							(* full_case, parallel_case *)
							case (1'b1)
								crc_bmode:
									// Trace: core/rtl/ibex_alu.sv:1126:26
									multicycle_result = clmul_result_rev ^ (operand_a_i >> 8);
								crc_hmode:
									// Trace: core/rtl/ibex_alu.sv:1127:26
									multicycle_result = clmul_result_rev ^ (operand_a_i >> 16);
								default:
									// Trace: core/rtl/ibex_alu.sv:1128:26
									multicycle_result = clmul_result_rev;
							endcase
							// Trace: core/rtl/ibex_alu.sv:1130:13
							imd_val_d_o = {clmul_result_rev, 32'h00000000};
							if (instr_first_cycle_i)
								// Trace: core/rtl/ibex_alu.sv:1132:15
								imd_val_we_o = 2'b01;
							else
								// Trace: core/rtl/ibex_alu.sv:1134:15
								imd_val_we_o = 2'b00;
						end
						else begin
							// Trace: core/rtl/ibex_alu.sv:1137:13
							imd_val_d_o = {operand_a_i, 32'h00000000};
							// Trace: core/rtl/ibex_alu.sv:1138:13
							imd_val_we_o = 2'b00;
							// Trace: core/rtl/ibex_alu.sv:1139:13
							multicycle_result = 1'sb0;
						end
					6'd47, 6'd48:
						// Trace: core/rtl/ibex_alu.sv:1144:11
						if (RV32B == 32'sd2) begin
							// Trace: core/rtl/ibex_alu.sv:1145:13
							multicycle_result = (operator_i == 6'd48 ? butterfly_result : invbutterfly_result);
							// Trace: core/rtl/ibex_alu.sv:1146:13
							imd_val_d_o = {bitcnt_partial_lsb_d, bitcnt_partial_msb_d};
							// Trace: core/rtl/ibex_alu.sv:1147:13
							if (instr_first_cycle_i)
								// Trace: core/rtl/ibex_alu.sv:1148:15
								imd_val_we_o = 2'b11;
							else
								// Trace: core/rtl/ibex_alu.sv:1150:15
								imd_val_we_o = 2'b00;
						end
						else begin
							// Trace: core/rtl/ibex_alu.sv:1153:13
							imd_val_d_o = {operand_a_i, 32'h00000000};
							// Trace: core/rtl/ibex_alu.sv:1154:13
							imd_val_we_o = 2'b00;
							// Trace: core/rtl/ibex_alu.sv:1155:13
							multicycle_result = 1'sb0;
						end
					default: begin
						// Trace: core/rtl/ibex_alu.sv:1160:11
						imd_val_d_o = {operand_a_i, 32'h00000000};
						// Trace: core/rtl/ibex_alu.sv:1161:11
						imd_val_we_o = 2'b00;
						// Trace: core/rtl/ibex_alu.sv:1162:11
						multicycle_result = 1'sb0;
					end
				endcase
			end
		end
		else begin : g_no_alu_rvb
			// Trace: core/rtl/ibex_alu.sv:1169:5
			wire [63:0] unused_imd_val_q;
			// Trace: core/rtl/ibex_alu.sv:1170:5
			assign unused_imd_val_q = imd_val_q_i;
			// Trace: core/rtl/ibex_alu.sv:1171:5
			wire [31:0] unused_butterfly_result;
			// Trace: core/rtl/ibex_alu.sv:1172:5
			assign unused_butterfly_result = butterfly_result;
			// Trace: core/rtl/ibex_alu.sv:1173:5
			wire [31:0] unused_invbutterfly_result;
			// Trace: core/rtl/ibex_alu.sv:1174:5
			assign unused_invbutterfly_result = invbutterfly_result;
			// Trace: core/rtl/ibex_alu.sv:1176:5
			assign bitcnt_result = 1'sb0;
			// Trace: core/rtl/ibex_alu.sv:1177:5
			assign minmax_result = 1'sb0;
			// Trace: core/rtl/ibex_alu.sv:1178:5
			wire [32:1] sv2v_tmp_A0513;
			assign sv2v_tmp_A0513 = 1'sb0;
			always @(*) pack_result = sv2v_tmp_A0513;
			// Trace: core/rtl/ibex_alu.sv:1179:5
			assign sext_result = 1'sb0;
			// Trace: core/rtl/ibex_alu.sv:1180:5
			wire [32:1] sv2v_tmp_75CE4;
			assign sv2v_tmp_75CE4 = 1'sb0;
			always @(*) singlebit_result = sv2v_tmp_75CE4;
			// Trace: core/rtl/ibex_alu.sv:1181:5
			wire [32:1] sv2v_tmp_FA09A;
			assign sv2v_tmp_FA09A = 1'sb0;
			always @(*) rev_result = sv2v_tmp_FA09A;
			// Trace: core/rtl/ibex_alu.sv:1182:5
			wire [32:1] sv2v_tmp_4A308;
			assign sv2v_tmp_4A308 = 1'sb0;
			always @(*) shuffle_result = sv2v_tmp_4A308;
			// Trace: core/rtl/ibex_alu.sv:1183:5
			wire [32:1] sv2v_tmp_98122;
			assign sv2v_tmp_98122 = 1'sb0;
			always @(*) butterfly_result = sv2v_tmp_98122;
			// Trace: core/rtl/ibex_alu.sv:1184:5
			wire [32:1] sv2v_tmp_B39E0;
			assign sv2v_tmp_B39E0 = 1'sb0;
			always @(*) invbutterfly_result = sv2v_tmp_B39E0;
			// Trace: core/rtl/ibex_alu.sv:1185:5
			wire [32:1] sv2v_tmp_31DA6;
			assign sv2v_tmp_31DA6 = 1'sb0;
			always @(*) clmul_result = sv2v_tmp_31DA6;
			// Trace: core/rtl/ibex_alu.sv:1186:5
			wire [32:1] sv2v_tmp_BC1B9;
			assign sv2v_tmp_BC1B9 = 1'sb0;
			always @(*) multicycle_result = sv2v_tmp_BC1B9;
			// Trace: core/rtl/ibex_alu.sv:1188:5
			wire [64:1] sv2v_tmp_42A49;
			assign sv2v_tmp_42A49 = {2 {32'b00000000000000000000000000000000}};
			always @(*) imd_val_d_o = sv2v_tmp_42A49;
			// Trace: core/rtl/ibex_alu.sv:1189:5
			wire [2:1] sv2v_tmp_0E15E;
			assign sv2v_tmp_0E15E = {2 {1'b0}};
			always @(*) imd_val_we_o = sv2v_tmp_0E15E;
		end
	endgenerate
	// Trace: core/rtl/ibex_alu.sv:1196:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_alu.sv:1197:5
		result_o = 1'sb0;
		// Trace: core/rtl/ibex_alu.sv:1199:5
		(* full_case, parallel_case *)
		case (operator_i)
			6'd2, 6'd5, 6'd3, 6'd6, 6'd4, 6'd7:
				// Trace: core/rtl/ibex_alu.sv:1203:27
				result_o = bwlogic_result;
			6'd0, 6'd1:
				// Trace: core/rtl/ibex_alu.sv:1206:26
				result_o = adder_result;
			6'd10, 6'd9, 6'd8, 6'd12, 6'd11:
				// Trace: core/rtl/ibex_alu.sv:1212:26
				result_o = shift_result;
			6'd17, 6'd18:
				// Trace: core/rtl/ibex_alu.sv:1215:29
				result_o = shuffle_result;
			6'd23, 6'd24, 6'd21, 6'd22, 6'd19, 6'd20, 6'd37, 6'd38:
				// Trace: core/rtl/ibex_alu.sv:1221:27
				result_o = {31'h00000000, cmp_result};
			6'd25, 6'd27, 6'd26, 6'd28:
				// Trace: core/rtl/ibex_alu.sv:1225:27
				result_o = minmax_result;
			6'd34, 6'd35, 6'd36:
				// Trace: core/rtl/ibex_alu.sv:1229:17
				result_o = {26'h0000000, bitcnt_result};
			6'd29, 6'd31, 6'd30:
				// Trace: core/rtl/ibex_alu.sv:1233:18
				result_o = pack_result;
			6'd32, 6'd33:
				// Trace: core/rtl/ibex_alu.sv:1236:29
				result_o = sext_result;
			6'd40, 6'd39, 6'd41, 6'd42, 6'd14, 6'd13, 6'd57, 6'd58, 6'd55, 6'd56, 6'd53, 6'd54, 6'd47, 6'd48:
				// Trace: core/rtl/ibex_alu.sv:1248:27
				result_o = multicycle_result;
			6'd43, 6'd44, 6'd45, 6'd46:
				// Trace: core/rtl/ibex_alu.sv:1252:29
				result_o = singlebit_result;
			6'd15, 6'd16:
				// Trace: core/rtl/ibex_alu.sv:1255:27
				result_o = rev_result;
			6'd49:
				// Trace: core/rtl/ibex_alu.sv:1258:16
				result_o = bfp_result;
			6'd50, 6'd51, 6'd52:
				// Trace: core/rtl/ibex_alu.sv:1262:19
				result_o = clmul_result;
			default:
				;
		endcase
	end
	// Trace: core/rtl/ibex_alu.sv:1268:3
	wire unused_shift_amt_compl;
	// Trace: core/rtl/ibex_alu.sv:1269:3
	assign unused_shift_amt_compl = shift_amt_compl[5];
	initial _sv2v_0 = 0;
endmodule
