// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_fetch_fifo (
	clk_i,
	rst_ni,
	clear_i,
	busy_o,
	in_valid_i,
	in_addr_i,
	in_rdata_i,
	in_err_i,
	out_valid_o,
	out_ready_i,
	out_addr_o,
	out_addr_next_o,
	out_rdata_o,
	out_err_o,
	out_err_plus2_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_fetch_fifo.sv:16:13
	parameter [31:0] NUM_REQS = 2;
	// Trace: core/rtl/ibex_fetch_fifo.sv:18:5
	input wire clk_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:19:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_fetch_fifo.sv:22:5
	input wire clear_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:23:5
	output wire [NUM_REQS - 1:0] busy_o;
	// Trace: core/rtl/ibex_fetch_fifo.sv:26:5
	input wire in_valid_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:27:5
	input wire [31:0] in_addr_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:28:5
	input wire [31:0] in_rdata_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:29:5
	input wire in_err_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:32:5
	output reg out_valid_o;
	// Trace: core/rtl/ibex_fetch_fifo.sv:33:5
	input wire out_ready_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:34:5
	output wire [31:0] out_addr_o;
	// Trace: core/rtl/ibex_fetch_fifo.sv:35:5
	output wire [31:0] out_addr_next_o;
	// Trace: core/rtl/ibex_fetch_fifo.sv:36:5
	output reg [31:0] out_rdata_o;
	// Trace: core/rtl/ibex_fetch_fifo.sv:37:5
	output reg out_err_o;
	// Trace: core/rtl/ibex_fetch_fifo.sv:38:5
	output reg out_err_plus2_o;
	// Trace: core/rtl/ibex_fetch_fifo.sv:41:3
	localparam [31:0] DEPTH = NUM_REQS + 1;
	// Trace: core/rtl/ibex_fetch_fifo.sv:44:3
	wire [(DEPTH * 32) - 1:0] rdata_d;
	reg [(DEPTH * 32) - 1:0] rdata_q;
	// Trace: core/rtl/ibex_fetch_fifo.sv:45:3
	wire [DEPTH - 1:0] err_d;
	reg [DEPTH - 1:0] err_q;
	// Trace: core/rtl/ibex_fetch_fifo.sv:46:3
	wire [DEPTH - 1:0] valid_d;
	reg [DEPTH - 1:0] valid_q;
	// Trace: core/rtl/ibex_fetch_fifo.sv:47:3
	wire [DEPTH - 1:0] lowest_free_entry;
	// Trace: core/rtl/ibex_fetch_fifo.sv:48:3
	wire [DEPTH - 1:0] valid_pushed;
	wire [DEPTH - 1:0] valid_popped;
	// Trace: core/rtl/ibex_fetch_fifo.sv:49:3
	wire [DEPTH - 1:0] entry_en;
	// Trace: core/rtl/ibex_fetch_fifo.sv:51:3
	wire pop_fifo;
	// Trace: core/rtl/ibex_fetch_fifo.sv:52:3
	wire [31:0] rdata;
	wire [31:0] rdata_unaligned;
	// Trace: core/rtl/ibex_fetch_fifo.sv:53:3
	wire err;
	wire err_unaligned;
	wire err_plus2;
	// Trace: core/rtl/ibex_fetch_fifo.sv:54:3
	wire valid;
	wire valid_unaligned;
	// Trace: core/rtl/ibex_fetch_fifo.sv:56:3
	wire aligned_is_compressed;
	wire unaligned_is_compressed;
	// Trace: core/rtl/ibex_fetch_fifo.sv:58:3
	wire addr_incr_two;
	// Trace: core/rtl/ibex_fetch_fifo.sv:59:3
	wire [31:1] instr_addr_next;
	// Trace: core/rtl/ibex_fetch_fifo.sv:60:3
	wire [31:1] instr_addr_d;
	reg [31:1] instr_addr_q;
	// Trace: core/rtl/ibex_fetch_fifo.sv:61:3
	wire instr_addr_en;
	// Trace: core/rtl/ibex_fetch_fifo.sv:62:3
	wire unused_addr_in;
	// Trace: core/rtl/ibex_fetch_fifo.sv:68:3
	assign rdata = (valid_q[0] ? rdata_q[0+:32] : in_rdata_i);
	// Trace: core/rtl/ibex_fetch_fifo.sv:69:3
	assign err = (valid_q[0] ? err_q[0] : in_err_i);
	// Trace: core/rtl/ibex_fetch_fifo.sv:70:3
	assign valid = valid_q[0] | in_valid_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:84:3
	assign rdata_unaligned = (valid_q[1] ? {rdata_q[47-:16], rdata[31:16]} : {in_rdata_i[15:0], rdata[31:16]});
	// Trace: core/rtl/ibex_fetch_fifo.sv:92:3
	assign err_unaligned = (valid_q[1] ? (err_q[1] & ~unaligned_is_compressed) | err_q[0] : (valid_q[0] & err_q[0]) | (in_err_i & (~valid_q[0] | ~unaligned_is_compressed)));
	// Trace: core/rtl/ibex_fetch_fifo.sv:98:3
	assign err_plus2 = (valid_q[1] ? err_q[1] & ~err_q[0] : (in_err_i & valid_q[0]) & ~err_q[0]);
	// Trace: core/rtl/ibex_fetch_fifo.sv:102:3
	assign valid_unaligned = (valid_q[1] ? 1'b1 : valid_q[0] & in_valid_i);
	// Trace: core/rtl/ibex_fetch_fifo.sv:106:3
	assign unaligned_is_compressed = (rdata[17:16] != 2'b11) & ~err;
	// Trace: core/rtl/ibex_fetch_fifo.sv:107:3
	assign aligned_is_compressed = (rdata[1:0] != 2'b11) & ~err;
	// Trace: core/rtl/ibex_fetch_fifo.sv:113:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_fetch_fifo.sv:114:5
		if (out_addr_o[1]) begin
			// Trace: core/rtl/ibex_fetch_fifo.sv:116:7
			out_rdata_o = rdata_unaligned;
			// Trace: core/rtl/ibex_fetch_fifo.sv:117:7
			out_err_o = err_unaligned;
			// Trace: core/rtl/ibex_fetch_fifo.sv:118:7
			out_err_plus2_o = err_plus2;
			// Trace: core/rtl/ibex_fetch_fifo.sv:120:7
			if (unaligned_is_compressed)
				// Trace: core/rtl/ibex_fetch_fifo.sv:121:9
				out_valid_o = valid;
			else
				// Trace: core/rtl/ibex_fetch_fifo.sv:123:9
				out_valid_o = valid_unaligned;
		end
		else begin
			// Trace: core/rtl/ibex_fetch_fifo.sv:127:7
			out_rdata_o = rdata;
			// Trace: core/rtl/ibex_fetch_fifo.sv:128:7
			out_err_o = err;
			// Trace: core/rtl/ibex_fetch_fifo.sv:129:7
			out_err_plus2_o = 1'b0;
			// Trace: core/rtl/ibex_fetch_fifo.sv:130:7
			out_valid_o = valid;
		end
	end
	// Trace: core/rtl/ibex_fetch_fifo.sv:139:3
	assign instr_addr_en = clear_i | (out_ready_i & out_valid_o);
	// Trace: core/rtl/ibex_fetch_fifo.sv:142:3
	assign addr_incr_two = (instr_addr_q[1] ? unaligned_is_compressed : aligned_is_compressed);
	// Trace: core/rtl/ibex_fetch_fifo.sv:145:3
	assign instr_addr_next = instr_addr_q[31:1] + {29'd0, ~addr_incr_two, addr_incr_two};
	// Trace: core/rtl/ibex_fetch_fifo.sv:149:3
	assign instr_addr_d = (clear_i ? in_addr_i[31:1] : instr_addr_next);
	// Trace: core/rtl/ibex_fetch_fifo.sv:152:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_fetch_fifo.sv:153:5
		if (instr_addr_en)
			// Trace: core/rtl/ibex_fetch_fifo.sv:154:7
			instr_addr_q <= instr_addr_d;
	// Trace: core/rtl/ibex_fetch_fifo.sv:161:3
	assign out_addr_next_o = {instr_addr_next, 1'b0};
	// Trace: core/rtl/ibex_fetch_fifo.sv:162:3
	assign out_addr_o = {instr_addr_q, 1'b0};
	// Trace: core/rtl/ibex_fetch_fifo.sv:165:3
	assign unused_addr_in = in_addr_i[0];
	// Trace: core/rtl/ibex_fetch_fifo.sv:174:3
	assign busy_o = valid_q[DEPTH - 1:DEPTH - NUM_REQS];
	// Trace: core/rtl/ibex_fetch_fifo.sv:181:3
	assign pop_fifo = (out_ready_i & out_valid_o) & (~aligned_is_compressed | out_addr_o[1]);
	// Trace: core/rtl/ibex_fetch_fifo.sv:183:3
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < (DEPTH - 1); _gv_i_1 = _gv_i_1 + 1) begin : g_fifo_next
			localparam i = _gv_i_1;
			if (i == 0) begin : g_ent0
				// Trace: core/rtl/ibex_fetch_fifo.sv:186:7
				assign lowest_free_entry[i] = ~valid_q[i];
			end
			else begin : g_ent_others
				// Trace: core/rtl/ibex_fetch_fifo.sv:188:7
				assign lowest_free_entry[i] = ~valid_q[i] & valid_q[i - 1];
			end
			// Trace: core/rtl/ibex_fetch_fifo.sv:192:5
			assign valid_pushed[i] = (in_valid_i & lowest_free_entry[i]) | valid_q[i];
			// Trace: core/rtl/ibex_fetch_fifo.sv:195:5
			assign valid_popped[i] = (pop_fifo ? valid_pushed[i + 1] : valid_pushed[i]);
			// Trace: core/rtl/ibex_fetch_fifo.sv:197:5
			assign valid_d[i] = valid_popped[i] & ~clear_i;
			// Trace: core/rtl/ibex_fetch_fifo.sv:200:5
			assign entry_en[i] = (valid_pushed[i + 1] & pop_fifo) | ((in_valid_i & lowest_free_entry[i]) & ~pop_fifo);
			// Trace: core/rtl/ibex_fetch_fifo.sv:205:5
			assign rdata_d[i * 32+:32] = (valid_q[i + 1] ? rdata_q[(i + 1) * 32+:32] : in_rdata_i);
			// Trace: core/rtl/ibex_fetch_fifo.sv:206:5
			assign err_d[i] = (valid_q[i + 1] ? err_q[i + 1] : in_err_i);
		end
	endgenerate
	// Trace: core/rtl/ibex_fetch_fifo.sv:209:3
	assign lowest_free_entry[DEPTH - 1] = ~valid_q[DEPTH - 1] & valid_q[DEPTH - 2];
	// Trace: core/rtl/ibex_fetch_fifo.sv:210:3
	assign valid_pushed[DEPTH - 1] = valid_q[DEPTH - 1] | (in_valid_i & lowest_free_entry[DEPTH - 1]);
	// Trace: core/rtl/ibex_fetch_fifo.sv:211:3
	assign valid_popped[DEPTH - 1] = (pop_fifo ? 1'b0 : valid_pushed[DEPTH - 1]);
	// Trace: core/rtl/ibex_fetch_fifo.sv:212:3
	assign valid_d[DEPTH - 1] = valid_popped[DEPTH - 1] & ~clear_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:213:3
	assign entry_en[DEPTH - 1] = in_valid_i & lowest_free_entry[DEPTH - 1];
	// Trace: core/rtl/ibex_fetch_fifo.sv:214:3
	assign rdata_d[(DEPTH - 1) * 32+:32] = in_rdata_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:215:3
	assign err_d[DEPTH - 1] = in_err_i;
	// Trace: core/rtl/ibex_fetch_fifo.sv:221:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_fetch_fifo.sv:222:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_fetch_fifo.sv:223:7
			valid_q <= 1'sb0;
		else
			// Trace: core/rtl/ibex_fetch_fifo.sv:225:7
			valid_q <= valid_d;
	// Trace: core/rtl/ibex_fetch_fifo.sv:229:3
	genvar _gv_i_2;
	generate
		for (_gv_i_2 = 0; _gv_i_2 < DEPTH; _gv_i_2 = _gv_i_2 + 1) begin : g_fifo_regs
			localparam i = _gv_i_2;
			// Trace: core/rtl/ibex_fetch_fifo.sv:230:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_fetch_fifo.sv:231:7
				if (entry_en[i]) begin
					// Trace: core/rtl/ibex_fetch_fifo.sv:232:9
					rdata_q[i * 32+:32] <= rdata_d[i * 32+:32];
					// Trace: core/rtl/ibex_fetch_fifo.sv:233:9
					err_q[i] <= err_d[i];
				end
		end
	endgenerate
	initial _sv2v_0 = 0;
endmodule
