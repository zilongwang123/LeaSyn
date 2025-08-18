// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_compressed_decoder (
	clk_i,
	rst_ni,
	valid_i,
	instr_i,
	instr_o,
	is_compressed_o,
	illegal_instr_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_compressed_decoder.sv:17:5
	input wire clk_i;
	// Trace: core/rtl/ibex_compressed_decoder.sv:18:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_compressed_decoder.sv:19:5
	input wire valid_i;
	// Trace: core/rtl/ibex_compressed_decoder.sv:20:5
	input wire [31:0] instr_i;
	// Trace: core/rtl/ibex_compressed_decoder.sv:21:5
	output reg [31:0] instr_o;
	// Trace: core/rtl/ibex_compressed_decoder.sv:22:5
	output wire is_compressed_o;
	// Trace: core/rtl/ibex_compressed_decoder.sv:23:5
	output reg illegal_instr_o;
	// Trace: core/rtl/ibex_compressed_decoder.sv:25:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_compressed_decoder.sv:29:3
	wire unused_valid;
	// Trace: core/rtl/ibex_compressed_decoder.sv:30:3
	assign unused_valid = valid_i;
	// Trace: core/rtl/ibex_compressed_decoder.sv:36:3
	// removed localparam type ibex_pkg_opcode_e
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_compressed_decoder.sv:38:5
		instr_o = instr_i;
		// Trace: core/rtl/ibex_compressed_decoder.sv:39:5
		illegal_instr_o = 1'b0;
		// Trace: core/rtl/ibex_compressed_decoder.sv:42:5
		(* full_case, parallel_case *)
		case (instr_i[1:0])
			2'b00:
				// Trace: core/rtl/ibex_compressed_decoder.sv:45:9
				(* full_case, parallel_case *)
				case (instr_i[15:13])
					3'b000: begin
						// Trace: core/rtl/ibex_compressed_decoder.sv:48:13
						instr_o = {2'b00, instr_i[10:7], instr_i[12:11], instr_i[5], instr_i[6], 12'h041, instr_i[4:2], 7'h13};
						// Trace: core/rtl/ibex_compressed_decoder.sv:50:13
						if (instr_i[12:5] == 8'b00000000)
							// Trace: core/rtl/ibex_compressed_decoder.sv:50:41
							illegal_instr_o = 1'b1;
					end
					3'b010:
						// Trace: core/rtl/ibex_compressed_decoder.sv:55:13
						instr_o = {5'b00000, instr_i[5], instr_i[12:10], instr_i[6], 4'b0001, instr_i[9:7], 5'b01001, instr_i[4:2], 7'h03};
					3'b110:
						// Trace: core/rtl/ibex_compressed_decoder.sv:61:13
						instr_o = {5'b00000, instr_i[5], instr_i[12], 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b010, instr_i[11:10], instr_i[6], 9'h023};
					3'b001, 3'b011, 3'b100, 3'b101, 3'b111:
						// Trace: core/rtl/ibex_compressed_decoder.sv:71:13
						illegal_instr_o = 1'b1;
					default:
						// Trace: core/rtl/ibex_compressed_decoder.sv:75:13
						illegal_instr_o = 1'b1;
				endcase
			2'b01:
				// Trace: core/rtl/ibex_compressed_decoder.sv:86:9
				(* full_case, parallel_case *)
				case (instr_i[15:13])
					3'b000:
						// Trace: core/rtl/ibex_compressed_decoder.sv:90:13
						instr_o = {{6 {instr_i[12]}}, instr_i[12], instr_i[6:2], instr_i[11:7], 3'b000, instr_i[11:7], 7'h13};
					3'b001, 3'b101:
						// Trace: core/rtl/ibex_compressed_decoder.sv:97:13
						instr_o = {instr_i[12], instr_i[8], instr_i[10:9], instr_i[6], instr_i[7], instr_i[2], instr_i[11], instr_i[5:3], {9 {instr_i[12]}}, 4'b0000, ~instr_i[15], 7'h6f};
					3'b010:
						// Trace: core/rtl/ibex_compressed_decoder.sv:105:13
						instr_o = {{6 {instr_i[12]}}, instr_i[12], instr_i[6:2], 8'b00000000, instr_i[11:7], 7'h13};
					3'b011: begin
						// Trace: core/rtl/ibex_compressed_decoder.sv:112:13
						instr_o = {{15 {instr_i[12]}}, instr_i[6:2], instr_i[11:7], 7'h37};
						// Trace: core/rtl/ibex_compressed_decoder.sv:114:13
						if (instr_i[11:7] == 5'h02)
							// Trace: core/rtl/ibex_compressed_decoder.sv:116:15
							instr_o = {{3 {instr_i[12]}}, instr_i[4:3], instr_i[5], instr_i[2], instr_i[6], 24'h010113};
						if ({instr_i[12], instr_i[6:2]} == 6'b000000)
							// Trace: core/rtl/ibex_compressed_decoder.sv:120:54
							illegal_instr_o = 1'b1;
					end
					3'b100:
						// Trace: core/rtl/ibex_compressed_decoder.sv:124:13
						(* full_case, parallel_case *)
						case (instr_i[11:10])
							2'b00, 2'b01: begin
								// Trace: core/rtl/ibex_compressed_decoder.sv:130:17
								instr_o = {1'b0, instr_i[10], 5'b00000, instr_i[6:2], 2'b01, instr_i[9:7], 5'b10101, instr_i[9:7], 7'h13};
								// Trace: core/rtl/ibex_compressed_decoder.sv:132:17
								if (instr_i[12] == 1'b1)
									// Trace: core/rtl/ibex_compressed_decoder.sv:132:43
									illegal_instr_o = 1'b1;
							end
							2'b10:
								// Trace: core/rtl/ibex_compressed_decoder.sv:137:17
								instr_o = {{6 {instr_i[12]}}, instr_i[12], instr_i[6:2], 2'b01, instr_i[9:7], 5'b11101, instr_i[9:7], 7'h13};
							2'b11:
								// Trace: core/rtl/ibex_compressed_decoder.sv:142:17
								(* full_case, parallel_case *)
								case ({instr_i[12], instr_i[6:5]})
									3'b000:
										// Trace: core/rtl/ibex_compressed_decoder.sv:145:21
										instr_o = {9'b010000001, instr_i[4:2], 2'b01, instr_i[9:7], 5'b00001, instr_i[9:7], 7'h33};
									3'b001:
										// Trace: core/rtl/ibex_compressed_decoder.sv:151:21
										instr_o = {9'b000000001, instr_i[4:2], 2'b01, instr_i[9:7], 5'b10001, instr_i[9:7], 7'h33};
									3'b010:
										// Trace: core/rtl/ibex_compressed_decoder.sv:157:21
										instr_o = {9'b000000001, instr_i[4:2], 2'b01, instr_i[9:7], 5'b11001, instr_i[9:7], 7'h33};
									3'b011:
										// Trace: core/rtl/ibex_compressed_decoder.sv:163:21
										instr_o = {9'b000000001, instr_i[4:2], 2'b01, instr_i[9:7], 5'b11101, instr_i[9:7], 7'h33};
									3'b100, 3'b101, 3'b110, 3'b111:
										// Trace: core/rtl/ibex_compressed_decoder.sv:173:21
										illegal_instr_o = 1'b1;
									default:
										// Trace: core/rtl/ibex_compressed_decoder.sv:177:21
										illegal_instr_o = 1'b1;
								endcase
							default:
								// Trace: core/rtl/ibex_compressed_decoder.sv:183:17
								illegal_instr_o = 1'b1;
						endcase
					3'b110, 3'b111:
						// Trace: core/rtl/ibex_compressed_decoder.sv:191:13
						instr_o = {{4 {instr_i[12]}}, instr_i[6:5], instr_i[2], 7'b0000001, instr_i[9:7], 2'b00, instr_i[13], instr_i[11:10], instr_i[4:3], instr_i[12], 7'h63};
					default:
						// Trace: core/rtl/ibex_compressed_decoder.sv:197:13
						illegal_instr_o = 1'b1;
				endcase
			2'b10:
				// Trace: core/rtl/ibex_compressed_decoder.sv:208:9
				(* full_case, parallel_case *)
				case (instr_i[15:13])
					3'b000: begin
						// Trace: core/rtl/ibex_compressed_decoder.sv:212:13
						instr_o = {7'b0000000, instr_i[6:2], instr_i[11:7], 3'b001, instr_i[11:7], 7'h13};
						// Trace: core/rtl/ibex_compressed_decoder.sv:213:13
						if (instr_i[12] == 1'b1)
							// Trace: core/rtl/ibex_compressed_decoder.sv:213:39
							illegal_instr_o = 1'b1;
					end
					3'b010: begin
						// Trace: core/rtl/ibex_compressed_decoder.sv:218:13
						instr_o = {4'b0000, instr_i[3:2], instr_i[12], instr_i[6:4], 10'h012, instr_i[11:7], 7'h03};
						// Trace: core/rtl/ibex_compressed_decoder.sv:220:13
						if (instr_i[11:7] == 5'b00000)
							// Trace: core/rtl/ibex_compressed_decoder.sv:220:41
							illegal_instr_o = 1'b1;
					end
					3'b100:
						// Trace: core/rtl/ibex_compressed_decoder.sv:224:13
						if (instr_i[12] == 1'b0) begin
							begin
								// Trace: core/rtl/ibex_compressed_decoder.sv:225:15
								if (instr_i[6:2] != 5'b00000)
									// Trace: core/rtl/ibex_compressed_decoder.sv:228:17
									instr_o = {7'b0000000, instr_i[6:2], 8'b00000000, instr_i[11:7], 7'h33};
								else begin
									// Trace: core/rtl/ibex_compressed_decoder.sv:231:17
									instr_o = {12'b000000000000, instr_i[11:7], 15'h0067};
									// Trace: core/rtl/ibex_compressed_decoder.sv:232:17
									if (instr_i[11:7] == 5'b00000)
										// Trace: core/rtl/ibex_compressed_decoder.sv:232:45
										illegal_instr_o = 1'b1;
								end
							end
						end
						else
							// Trace: core/rtl/ibex_compressed_decoder.sv:235:15
							if (instr_i[6:2] != 5'b00000)
								// Trace: core/rtl/ibex_compressed_decoder.sv:238:17
								instr_o = {7'b0000000, instr_i[6:2], instr_i[11:7], 3'b000, instr_i[11:7], 7'h33};
							else
								// Trace: core/rtl/ibex_compressed_decoder.sv:240:17
								if (instr_i[11:7] == 5'b00000)
									// Trace: core/rtl/ibex_compressed_decoder.sv:242:19
									instr_o = 32'h00100073;
								else
									// Trace: core/rtl/ibex_compressed_decoder.sv:245:19
									instr_o = {12'b000000000000, instr_i[11:7], 15'h00e7};
					3'b110:
						// Trace: core/rtl/ibex_compressed_decoder.sv:253:13
						instr_o = {4'b0000, instr_i[8:7], instr_i[12], instr_i[6:2], 8'h12, instr_i[11:9], 9'h023};
					3'b001, 3'b011, 3'b101, 3'b111:
						// Trace: core/rtl/ibex_compressed_decoder.sv:261:13
						illegal_instr_o = 1'b1;
					default:
						// Trace: core/rtl/ibex_compressed_decoder.sv:265:13
						illegal_instr_o = 1'b1;
				endcase
			2'b11:
				;
			default:
				// Trace: core/rtl/ibex_compressed_decoder.sv:274:9
				illegal_instr_o = 1'b1;
		endcase
	end
	// Trace: core/rtl/ibex_compressed_decoder.sv:279:3
	assign is_compressed_o = instr_i[1:0] != 2'b11;
	initial _sv2v_0 = 0;
endmodule
