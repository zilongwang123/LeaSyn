// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_load_store_unit (
	clk_i,
	rst_ni,
	data_req_o,
	data_gnt_i,
	data_rvalid_i,
	data_err_i,
	data_pmp_err_i,
	data_addr_o,
	data_we_o,
	data_be_o,
	data_wdata_o,
	data_rdata_i,
	lsu_we_i,
	lsu_type_i,
	lsu_wdata_i,
	lsu_sign_ext_i,
	lsu_rdata_o,
	lsu_rdata_valid_o,
	lsu_req_i,
	adder_result_ex_i,
	addr_incr_req_o,
	addr_last_o,
	lsu_req_done_o,
	lsu_resp_valid_o,
	load_err_o,
	store_err_o,
	busy_o,
	perf_load_o,
	perf_store_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_load_store_unit.sv:18:5
	input wire clk_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:19:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_load_store_unit.sv:22:5
	output reg data_req_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:23:5
	input wire data_gnt_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:24:5
	input wire data_rvalid_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:25:5
	input wire data_err_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:26:5
	input wire data_pmp_err_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:28:5
	output wire [31:0] data_addr_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:29:5
	output wire data_we_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:30:5
	output wire [3:0] data_be_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:31:5
	output wire [31:0] data_wdata_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:32:5
	input wire [31:0] data_rdata_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:35:5
	input wire lsu_we_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:36:5
	input wire [1:0] lsu_type_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:37:5
	input wire [31:0] lsu_wdata_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:38:5
	input wire lsu_sign_ext_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:40:5
	output wire [31:0] lsu_rdata_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:41:5
	output wire lsu_rdata_valid_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:42:5
	input wire lsu_req_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:44:5
	input wire [31:0] adder_result_ex_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:46:5
	output reg addr_incr_req_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:48:5
	output wire [31:0] addr_last_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:52:5
	output wire lsu_req_done_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:56:5
	output wire lsu_resp_valid_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:59:5
	output wire load_err_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:60:5
	output wire store_err_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:62:5
	output wire busy_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:64:5
	output reg perf_load_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:65:5
	output reg perf_store_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:68:3
	wire [31:0] data_addr;
	// Trace: core/rtl/ibex_load_store_unit.sv:69:3
	wire [31:0] data_addr_w_aligned;
	// Trace: core/rtl/ibex_load_store_unit.sv:70:3
	reg [31:0] addr_last_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:72:3
	reg addr_update;
	// Trace: core/rtl/ibex_load_store_unit.sv:73:3
	reg ctrl_update;
	// Trace: core/rtl/ibex_load_store_unit.sv:74:3
	reg rdata_update;
	// Trace: core/rtl/ibex_load_store_unit.sv:75:3
	reg [31:8] rdata_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:76:3
	reg [1:0] rdata_offset_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:77:3
	reg [1:0] data_type_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:78:3
	reg data_sign_ext_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:79:3
	reg data_we_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:81:3
	wire [1:0] data_offset;
	// Trace: core/rtl/ibex_load_store_unit.sv:83:3
	reg [3:0] data_be;
	// Trace: core/rtl/ibex_load_store_unit.sv:84:3
	reg [31:0] data_wdata;
	// Trace: core/rtl/ibex_load_store_unit.sv:86:3
	reg [31:0] data_rdata_ext;
	// Trace: core/rtl/ibex_load_store_unit.sv:88:3
	reg [31:0] rdata_w_ext;
	// Trace: core/rtl/ibex_load_store_unit.sv:89:3
	reg [31:0] rdata_h_ext;
	// Trace: core/rtl/ibex_load_store_unit.sv:90:3
	reg [31:0] rdata_b_ext;
	// Trace: core/rtl/ibex_load_store_unit.sv:92:3
	wire split_misaligned_access;
	// Trace: core/rtl/ibex_load_store_unit.sv:93:3
	reg handle_misaligned_q;
	reg handle_misaligned_d;
	// Trace: core/rtl/ibex_load_store_unit.sv:95:3
	reg pmp_err_q;
	reg pmp_err_d;
	// Trace: core/rtl/ibex_load_store_unit.sv:96:3
	reg lsu_err_q;
	reg lsu_err_d;
	// Trace: core/rtl/ibex_load_store_unit.sv:97:3
	wire data_or_pmp_err;
	// Trace: core/rtl/ibex_load_store_unit.sv:99:3
	// removed localparam type ls_fsm_e
	// Trace: core/rtl/ibex_load_store_unit.sv:104:3
	reg [2:0] ls_fsm_cs;
	reg [2:0] ls_fsm_ns;
	// Trace: core/rtl/ibex_load_store_unit.sv:106:3
	assign data_addr = adder_result_ex_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:107:3
	assign data_offset = data_addr[1:0];
	// Trace: core/rtl/ibex_load_store_unit.sv:113:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_load_store_unit.sv:114:5
		(* full_case, parallel_case *)
		case (lsu_type_i)
			2'b00:
				// Trace: core/rtl/ibex_load_store_unit.sv:116:9
				if (!handle_misaligned_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:117:11
					(* full_case, parallel_case *)
					case (data_offset)
						2'b00:
							// Trace: core/rtl/ibex_load_store_unit.sv:118:22
							data_be = 4'b1111;
						2'b01:
							// Trace: core/rtl/ibex_load_store_unit.sv:119:22
							data_be = 4'b1110;
						2'b10:
							// Trace: core/rtl/ibex_load_store_unit.sv:120:22
							data_be = 4'b1100;
						2'b11:
							// Trace: core/rtl/ibex_load_store_unit.sv:121:22
							data_be = 4'b1000;
						default:
							// Trace: core/rtl/ibex_load_store_unit.sv:122:22
							data_be = 4'b1111;
					endcase
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:125:11
					(* full_case, parallel_case *)
					case (data_offset)
						2'b00:
							// Trace: core/rtl/ibex_load_store_unit.sv:126:22
							data_be = 4'b0000;
						2'b01:
							// Trace: core/rtl/ibex_load_store_unit.sv:127:22
							data_be = 4'b0001;
						2'b10:
							// Trace: core/rtl/ibex_load_store_unit.sv:128:22
							data_be = 4'b0011;
						2'b11:
							// Trace: core/rtl/ibex_load_store_unit.sv:129:22
							data_be = 4'b0111;
						default:
							// Trace: core/rtl/ibex_load_store_unit.sv:130:22
							data_be = 4'b1111;
					endcase
			2'b01:
				// Trace: core/rtl/ibex_load_store_unit.sv:136:9
				if (!handle_misaligned_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:137:11
					(* full_case, parallel_case *)
					case (data_offset)
						2'b00:
							// Trace: core/rtl/ibex_load_store_unit.sv:138:22
							data_be = 4'b0011;
						2'b01:
							// Trace: core/rtl/ibex_load_store_unit.sv:139:22
							data_be = 4'b0110;
						2'b10:
							// Trace: core/rtl/ibex_load_store_unit.sv:140:22
							data_be = 4'b1100;
						2'b11:
							// Trace: core/rtl/ibex_load_store_unit.sv:141:22
							data_be = 4'b1000;
						default:
							// Trace: core/rtl/ibex_load_store_unit.sv:142:22
							data_be = 4'b1111;
					endcase
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:145:11
					data_be = 4'b0001;
			2'b10, 2'b11:
				// Trace: core/rtl/ibex_load_store_unit.sv:151:9
				(* full_case, parallel_case *)
				case (data_offset)
					2'b00:
						// Trace: core/rtl/ibex_load_store_unit.sv:152:20
						data_be = 4'b0001;
					2'b01:
						// Trace: core/rtl/ibex_load_store_unit.sv:153:20
						data_be = 4'b0010;
					2'b10:
						// Trace: core/rtl/ibex_load_store_unit.sv:154:20
						data_be = 4'b0100;
					2'b11:
						// Trace: core/rtl/ibex_load_store_unit.sv:155:20
						data_be = 4'b1000;
					default:
						// Trace: core/rtl/ibex_load_store_unit.sv:156:20
						data_be = 4'b1111;
				endcase
			default:
				// Trace: core/rtl/ibex_load_store_unit.sv:160:20
				data_be = 4'b1111;
		endcase
	end
	// Trace: core/rtl/ibex_load_store_unit.sv:170:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_load_store_unit.sv:171:5
		(* full_case, parallel_case *)
		case (data_offset)
			2'b00:
				// Trace: core/rtl/ibex_load_store_unit.sv:172:16
				data_wdata = lsu_wdata_i[31:0];
			2'b01:
				// Trace: core/rtl/ibex_load_store_unit.sv:173:16
				data_wdata = {lsu_wdata_i[23:0], lsu_wdata_i[31:24]};
			2'b10:
				// Trace: core/rtl/ibex_load_store_unit.sv:174:16
				data_wdata = {lsu_wdata_i[15:0], lsu_wdata_i[31:16]};
			2'b11:
				// Trace: core/rtl/ibex_load_store_unit.sv:175:16
				data_wdata = {lsu_wdata_i[7:0], lsu_wdata_i[31:8]};
			default:
				// Trace: core/rtl/ibex_load_store_unit.sv:176:16
				data_wdata = lsu_wdata_i[31:0];
		endcase
	end
	// Trace: core/rtl/ibex_load_store_unit.sv:185:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_load_store_unit.sv:186:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_load_store_unit.sv:187:7
			rdata_q <= 1'sb0;
		else if (rdata_update)
			// Trace: core/rtl/ibex_load_store_unit.sv:189:7
			rdata_q <= data_rdata_i[31:8];
	// Trace: core/rtl/ibex_load_store_unit.sv:194:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_load_store_unit.sv:195:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_load_store_unit.sv:196:7
			rdata_offset_q <= 2'h0;
			// Trace: core/rtl/ibex_load_store_unit.sv:197:7
			data_type_q <= 2'h0;
			// Trace: core/rtl/ibex_load_store_unit.sv:198:7
			data_sign_ext_q <= 1'b0;
			// Trace: core/rtl/ibex_load_store_unit.sv:199:7
			data_we_q <= 1'b0;
		end
		else if (ctrl_update) begin
			// Trace: core/rtl/ibex_load_store_unit.sv:201:7
			rdata_offset_q <= data_offset;
			// Trace: core/rtl/ibex_load_store_unit.sv:202:7
			data_type_q <= lsu_type_i;
			// Trace: core/rtl/ibex_load_store_unit.sv:203:7
			data_sign_ext_q <= lsu_sign_ext_i;
			// Trace: core/rtl/ibex_load_store_unit.sv:204:7
			data_we_q <= lsu_we_i;
		end
	// Trace: core/rtl/ibex_load_store_unit.sv:210:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_load_store_unit.sv:211:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_load_store_unit.sv:212:7
			addr_last_q <= 1'sb0;
		else if (addr_update)
			// Trace: core/rtl/ibex_load_store_unit.sv:214:7
			addr_last_q <= data_addr;
	// Trace: core/rtl/ibex_load_store_unit.sv:219:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_load_store_unit.sv:220:5
		(* full_case, parallel_case *)
		case (rdata_offset_q)
			2'b00:
				// Trace: core/rtl/ibex_load_store_unit.sv:221:16
				rdata_w_ext = data_rdata_i[31:0];
			2'b01:
				// Trace: core/rtl/ibex_load_store_unit.sv:222:16
				rdata_w_ext = {data_rdata_i[7:0], rdata_q[31:8]};
			2'b10:
				// Trace: core/rtl/ibex_load_store_unit.sv:223:16
				rdata_w_ext = {data_rdata_i[15:0], rdata_q[31:16]};
			2'b11:
				// Trace: core/rtl/ibex_load_store_unit.sv:224:16
				rdata_w_ext = {data_rdata_i[23:0], rdata_q[31:24]};
			default:
				// Trace: core/rtl/ibex_load_store_unit.sv:225:16
				rdata_w_ext = data_rdata_i[31:0];
		endcase
	end
	// Trace: core/rtl/ibex_load_store_unit.sv:234:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_load_store_unit.sv:235:5
		(* full_case, parallel_case *)
		case (rdata_offset_q)
			2'b00:
				// Trace: core/rtl/ibex_load_store_unit.sv:237:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:238:11
					rdata_h_ext = {16'h0000, data_rdata_i[15:0]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:240:11
					rdata_h_ext = {{16 {data_rdata_i[15]}}, data_rdata_i[15:0]};
			2'b01:
				// Trace: core/rtl/ibex_load_store_unit.sv:245:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:246:11
					rdata_h_ext = {16'h0000, data_rdata_i[23:8]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:248:11
					rdata_h_ext = {{16 {data_rdata_i[23]}}, data_rdata_i[23:8]};
			2'b10:
				// Trace: core/rtl/ibex_load_store_unit.sv:253:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:254:11
					rdata_h_ext = {16'h0000, data_rdata_i[31:16]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:256:11
					rdata_h_ext = {{16 {data_rdata_i[31]}}, data_rdata_i[31:16]};
			2'b11:
				// Trace: core/rtl/ibex_load_store_unit.sv:261:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:262:11
					rdata_h_ext = {16'h0000, data_rdata_i[7:0], rdata_q[31:24]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:264:11
					rdata_h_ext = {{16 {data_rdata_i[7]}}, data_rdata_i[7:0], rdata_q[31:24]};
			default:
				// Trace: core/rtl/ibex_load_store_unit.sv:268:16
				rdata_h_ext = {16'h0000, data_rdata_i[15:0]};
		endcase
	end
	// Trace: core/rtl/ibex_load_store_unit.sv:273:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_load_store_unit.sv:274:5
		(* full_case, parallel_case *)
		case (rdata_offset_q)
			2'b00:
				// Trace: core/rtl/ibex_load_store_unit.sv:276:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:277:11
					rdata_b_ext = {24'h000000, data_rdata_i[7:0]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:279:11
					rdata_b_ext = {{24 {data_rdata_i[7]}}, data_rdata_i[7:0]};
			2'b01:
				// Trace: core/rtl/ibex_load_store_unit.sv:284:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:285:11
					rdata_b_ext = {24'h000000, data_rdata_i[15:8]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:287:11
					rdata_b_ext = {{24 {data_rdata_i[15]}}, data_rdata_i[15:8]};
			2'b10:
				// Trace: core/rtl/ibex_load_store_unit.sv:292:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:293:11
					rdata_b_ext = {24'h000000, data_rdata_i[23:16]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:295:11
					rdata_b_ext = {{24 {data_rdata_i[23]}}, data_rdata_i[23:16]};
			2'b11:
				// Trace: core/rtl/ibex_load_store_unit.sv:300:9
				if (!data_sign_ext_q)
					// Trace: core/rtl/ibex_load_store_unit.sv:301:11
					rdata_b_ext = {24'h000000, data_rdata_i[31:24]};
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:303:11
					rdata_b_ext = {{24 {data_rdata_i[31]}}, data_rdata_i[31:24]};
			default:
				// Trace: core/rtl/ibex_load_store_unit.sv:307:16
				rdata_b_ext = {24'h000000, data_rdata_i[7:0]};
		endcase
	end
	// Trace: core/rtl/ibex_load_store_unit.sv:312:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_load_store_unit.sv:313:5
		(* full_case, parallel_case *)
		case (data_type_q)
			2'b00:
				// Trace: core/rtl/ibex_load_store_unit.sv:314:20
				data_rdata_ext = rdata_w_ext;
			2'b01:
				// Trace: core/rtl/ibex_load_store_unit.sv:315:20
				data_rdata_ext = rdata_h_ext;
			2'b10, 2'b11:
				// Trace: core/rtl/ibex_load_store_unit.sv:316:20
				data_rdata_ext = rdata_b_ext;
			default:
				// Trace: core/rtl/ibex_load_store_unit.sv:317:20
				data_rdata_ext = rdata_w_ext;
		endcase
	end
	// Trace: core/rtl/ibex_load_store_unit.sv:326:3
	assign split_misaligned_access = ((lsu_type_i == 2'b00) && (data_offset != 2'b00)) || ((lsu_type_i == 2'b01) && (data_offset == 2'b11));
	// Trace: core/rtl/ibex_load_store_unit.sv:331:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_load_store_unit.sv:332:5
		ls_fsm_ns = ls_fsm_cs;
		// Trace: core/rtl/ibex_load_store_unit.sv:334:5
		data_req_o = 1'b0;
		// Trace: core/rtl/ibex_load_store_unit.sv:335:5
		addr_incr_req_o = 1'b0;
		// Trace: core/rtl/ibex_load_store_unit.sv:336:5
		handle_misaligned_d = handle_misaligned_q;
		// Trace: core/rtl/ibex_load_store_unit.sv:337:5
		pmp_err_d = pmp_err_q;
		// Trace: core/rtl/ibex_load_store_unit.sv:338:5
		lsu_err_d = lsu_err_q;
		// Trace: core/rtl/ibex_load_store_unit.sv:340:5
		addr_update = 1'b0;
		// Trace: core/rtl/ibex_load_store_unit.sv:341:5
		ctrl_update = 1'b0;
		// Trace: core/rtl/ibex_load_store_unit.sv:342:5
		rdata_update = 1'b0;
		// Trace: core/rtl/ibex_load_store_unit.sv:344:5
		perf_load_o = 1'b0;
		// Trace: core/rtl/ibex_load_store_unit.sv:345:5
		perf_store_o = 1'b0;
		// Trace: core/rtl/ibex_load_store_unit.sv:347:5
		(* full_case, parallel_case *)
		case (ls_fsm_cs)
			3'd0: begin
				// Trace: core/rtl/ibex_load_store_unit.sv:350:9
				pmp_err_d = 1'b0;
				// Trace: core/rtl/ibex_load_store_unit.sv:351:9
				if (lsu_req_i) begin
					// Trace: core/rtl/ibex_load_store_unit.sv:352:11
					data_req_o = 1'b1;
					// Trace: core/rtl/ibex_load_store_unit.sv:353:11
					pmp_err_d = data_pmp_err_i;
					// Trace: core/rtl/ibex_load_store_unit.sv:354:11
					lsu_err_d = 1'b0;
					// Trace: core/rtl/ibex_load_store_unit.sv:355:11
					perf_load_o = ~lsu_we_i;
					// Trace: core/rtl/ibex_load_store_unit.sv:356:11
					perf_store_o = lsu_we_i;
					// Trace: core/rtl/ibex_load_store_unit.sv:358:11
					if (data_gnt_i) begin
						// Trace: core/rtl/ibex_load_store_unit.sv:359:13
						ctrl_update = 1'b1;
						// Trace: core/rtl/ibex_load_store_unit.sv:360:13
						addr_update = 1'b1;
						// Trace: core/rtl/ibex_load_store_unit.sv:361:13
						handle_misaligned_d = split_misaligned_access;
						// Trace: core/rtl/ibex_load_store_unit.sv:362:13
						ls_fsm_ns = (split_misaligned_access ? 3'd2 : 3'd0);
					end
					else
						// Trace: core/rtl/ibex_load_store_unit.sv:364:13
						ls_fsm_ns = (split_misaligned_access ? 3'd1 : 3'd3);
				end
			end
			3'd1: begin
				// Trace: core/rtl/ibex_load_store_unit.sv:370:9
				data_req_o = 1'b1;
				// Trace: core/rtl/ibex_load_store_unit.sv:375:9
				if (data_gnt_i || pmp_err_q) begin
					// Trace: core/rtl/ibex_load_store_unit.sv:376:11
					addr_update = 1'b1;
					// Trace: core/rtl/ibex_load_store_unit.sv:377:11
					ctrl_update = 1'b1;
					// Trace: core/rtl/ibex_load_store_unit.sv:378:11
					handle_misaligned_d = 1'b1;
					// Trace: core/rtl/ibex_load_store_unit.sv:379:11
					ls_fsm_ns = 3'd2;
				end
			end
			3'd2: begin
				// Trace: core/rtl/ibex_load_store_unit.sv:385:9
				data_req_o = 1'b1;
				// Trace: core/rtl/ibex_load_store_unit.sv:387:9
				addr_incr_req_o = 1'b1;
				// Trace: core/rtl/ibex_load_store_unit.sv:390:9
				if (data_rvalid_i || pmp_err_q) begin
					// Trace: core/rtl/ibex_load_store_unit.sv:392:11
					pmp_err_d = data_pmp_err_i;
					// Trace: core/rtl/ibex_load_store_unit.sv:394:11
					lsu_err_d = data_err_i | pmp_err_q;
					// Trace: core/rtl/ibex_load_store_unit.sv:396:11
					rdata_update = ~data_we_q;
					// Trace: core/rtl/ibex_load_store_unit.sv:398:11
					ls_fsm_ns = (data_gnt_i ? 3'd0 : 3'd3);
					// Trace: core/rtl/ibex_load_store_unit.sv:400:11
					addr_update = data_gnt_i & ~(data_err_i | pmp_err_q);
					// Trace: core/rtl/ibex_load_store_unit.sv:402:11
					handle_misaligned_d = ~data_gnt_i;
				end
				else
					// Trace: core/rtl/ibex_load_store_unit.sv:405:11
					if (data_gnt_i) begin
						// Trace: core/rtl/ibex_load_store_unit.sv:407:13
						ls_fsm_ns = 3'd4;
						// Trace: core/rtl/ibex_load_store_unit.sv:408:13
						handle_misaligned_d = 1'b0;
					end
			end
			3'd3: begin
				// Trace: core/rtl/ibex_load_store_unit.sv:415:9
				addr_incr_req_o = handle_misaligned_q;
				// Trace: core/rtl/ibex_load_store_unit.sv:416:9
				data_req_o = 1'b1;
				// Trace: core/rtl/ibex_load_store_unit.sv:417:9
				if (data_gnt_i || pmp_err_q) begin
					// Trace: core/rtl/ibex_load_store_unit.sv:418:11
					ctrl_update = 1'b1;
					// Trace: core/rtl/ibex_load_store_unit.sv:420:11
					addr_update = ~lsu_err_q;
					// Trace: core/rtl/ibex_load_store_unit.sv:421:11
					ls_fsm_ns = 3'd0;
					// Trace: core/rtl/ibex_load_store_unit.sv:422:11
					handle_misaligned_d = 1'b0;
				end
			end
			3'd4: begin
				// Trace: core/rtl/ibex_load_store_unit.sv:429:9
				addr_incr_req_o = 1'b1;
				// Trace: core/rtl/ibex_load_store_unit.sv:431:9
				if (data_rvalid_i) begin
					// Trace: core/rtl/ibex_load_store_unit.sv:433:11
					pmp_err_d = data_pmp_err_i;
					// Trace: core/rtl/ibex_load_store_unit.sv:435:11
					lsu_err_d = data_err_i;
					// Trace: core/rtl/ibex_load_store_unit.sv:437:11
					addr_update = ~data_err_i;
					// Trace: core/rtl/ibex_load_store_unit.sv:439:11
					rdata_update = ~data_we_q;
					// Trace: core/rtl/ibex_load_store_unit.sv:441:11
					ls_fsm_ns = 3'd0;
				end
			end
			default:
				// Trace: core/rtl/ibex_load_store_unit.sv:446:9
				ls_fsm_ns = 3'd0;
		endcase
	end
	// Trace: core/rtl/ibex_load_store_unit.sv:451:3
	assign lsu_req_done_o = (lsu_req_i | (ls_fsm_cs != 3'd0)) & (ls_fsm_ns == 3'd0);
	// Trace: core/rtl/ibex_load_store_unit.sv:454:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_load_store_unit.sv:455:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_load_store_unit.sv:456:7
			ls_fsm_cs <= 3'd0;
			// Trace: core/rtl/ibex_load_store_unit.sv:457:7
			handle_misaligned_q <= 1'sb0;
			// Trace: core/rtl/ibex_load_store_unit.sv:458:7
			pmp_err_q <= 1'sb0;
			// Trace: core/rtl/ibex_load_store_unit.sv:459:7
			lsu_err_q <= 1'sb0;
		end
		else begin
			// Trace: core/rtl/ibex_load_store_unit.sv:461:7
			ls_fsm_cs <= ls_fsm_ns;
			// Trace: core/rtl/ibex_load_store_unit.sv:462:7
			handle_misaligned_q <= handle_misaligned_d;
			// Trace: core/rtl/ibex_load_store_unit.sv:463:7
			pmp_err_q <= pmp_err_d;
			// Trace: core/rtl/ibex_load_store_unit.sv:464:7
			lsu_err_q <= lsu_err_d;
		end
	// Trace: core/rtl/ibex_load_store_unit.sv:472:3
	assign data_or_pmp_err = (lsu_err_q | data_err_i) | pmp_err_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:473:3
	assign lsu_resp_valid_o = (data_rvalid_i | pmp_err_q) & (ls_fsm_cs == 3'd0);
	// Trace: core/rtl/ibex_load_store_unit.sv:474:3
	assign lsu_rdata_valid_o = (((ls_fsm_cs == 3'd0) & data_rvalid_i) & ~data_or_pmp_err) & ~data_we_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:477:3
	assign lsu_rdata_o = data_rdata_ext;
	// Trace: core/rtl/ibex_load_store_unit.sv:480:3
	assign data_addr_w_aligned = {data_addr[31:2], 2'b00};
	// Trace: core/rtl/ibex_load_store_unit.sv:483:3
	assign data_addr_o = data_addr_w_aligned;
	// Trace: core/rtl/ibex_load_store_unit.sv:484:3
	assign data_wdata_o = data_wdata;
	// Trace: core/rtl/ibex_load_store_unit.sv:485:3
	assign data_we_o = lsu_we_i;
	// Trace: core/rtl/ibex_load_store_unit.sv:486:3
	assign data_be_o = data_be;
	// Trace: core/rtl/ibex_load_store_unit.sv:489:3
	assign addr_last_o = addr_last_q;
	// Trace: core/rtl/ibex_load_store_unit.sv:492:3
	assign load_err_o = (data_or_pmp_err & ~data_we_q) & lsu_resp_valid_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:493:3
	assign store_err_o = (data_or_pmp_err & data_we_q) & lsu_resp_valid_o;
	// Trace: core/rtl/ibex_load_store_unit.sv:495:3
	assign busy_o = ls_fsm_cs != 3'd0;
	initial _sv2v_0 = 0;
endmodule
