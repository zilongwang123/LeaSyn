// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_dummy_instr (
	clk_i,
	rst_ni,
	dummy_instr_en_i,
	dummy_instr_mask_i,
	dummy_instr_seed_en_i,
	dummy_instr_seed_i,
	fetch_valid_i,
	id_in_ready_i,
	insert_dummy_instr_o,
	dummy_instr_data_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_dummy_instr.sv:13:5
	input wire clk_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:14:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_dummy_instr.sv:17:5
	input wire dummy_instr_en_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:18:5
	input wire [2:0] dummy_instr_mask_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:19:5
	input wire dummy_instr_seed_en_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:20:5
	input wire [31:0] dummy_instr_seed_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:23:5
	input wire fetch_valid_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:24:5
	input wire id_in_ready_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:25:5
	output wire insert_dummy_instr_o;
	// Trace: core/rtl/ibex_dummy_instr.sv:26:5
	output wire [31:0] dummy_instr_data_o;
	// Trace: core/rtl/ibex_dummy_instr.sv:29:3
	localparam [31:0] TIMEOUT_CNT_W = 5;
	// Trace: core/rtl/ibex_dummy_instr.sv:30:3
	localparam [31:0] OP_W = 5;
	// Trace: core/rtl/ibex_dummy_instr.sv:32:3
	// removed localparam type dummy_instr_e
	// Trace: core/rtl/ibex_dummy_instr.sv:39:3
	// removed localparam type lfsr_data_t
	// Trace: core/rtl/ibex_dummy_instr.sv:45:3
	localparam [31:0] LFSR_OUT_W = 17;
	// Trace: core/rtl/ibex_dummy_instr.sv:47:3
	wire [16:0] lfsr_data;
	// Trace: core/rtl/ibex_dummy_instr.sv:48:3
	wire [4:0] dummy_cnt_incr;
	wire [4:0] dummy_cnt_threshold;
	// Trace: core/rtl/ibex_dummy_instr.sv:49:3
	wire [4:0] dummy_cnt_d;
	reg [4:0] dummy_cnt_q;
	// Trace: core/rtl/ibex_dummy_instr.sv:50:3
	wire dummy_cnt_en;
	// Trace: core/rtl/ibex_dummy_instr.sv:51:3
	wire lfsr_en;
	// Trace: core/rtl/ibex_dummy_instr.sv:52:3
	wire [16:0] lfsr_state;
	// Trace: core/rtl/ibex_dummy_instr.sv:53:3
	wire insert_dummy_instr;
	// Trace: core/rtl/ibex_dummy_instr.sv:54:3
	reg [6:0] dummy_set;
	// Trace: core/rtl/ibex_dummy_instr.sv:55:3
	reg [2:0] dummy_opcode;
	// Trace: core/rtl/ibex_dummy_instr.sv:56:3
	wire [31:0] dummy_instr;
	// Trace: core/rtl/ibex_dummy_instr.sv:57:3
	reg [31:0] dummy_instr_seed_q;
	wire [31:0] dummy_instr_seed_d;
	// Trace: core/rtl/ibex_dummy_instr.sv:60:3
	assign lfsr_en = insert_dummy_instr & id_in_ready_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:62:3
	assign dummy_instr_seed_d = dummy_instr_seed_q ^ dummy_instr_seed_i;
	// Trace: core/rtl/ibex_dummy_instr.sv:64:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_dummy_instr.sv:65:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_dummy_instr.sv:66:7
			dummy_instr_seed_q <= 1'sb0;
		else if (dummy_instr_seed_en_i)
			// Trace: core/rtl/ibex_dummy_instr.sv:68:7
			dummy_instr_seed_q <= dummy_instr_seed_d;
	// Trace: core/rtl/ibex_dummy_instr.sv:72:3
	prim_lfsr #(
		.LfsrDw(32),
		.StateOutDw(LFSR_OUT_W)
	) lfsr_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.seed_en_i(dummy_instr_seed_en_i),
		.seed_i(dummy_instr_seed_d),
		.lfsr_en_i(lfsr_en),
		.entropy_i(1'sb0),
		.state_o(lfsr_state)
	);
	// Trace: core/rtl/ibex_dummy_instr.sv:86:3
	function automatic [16:0] sv2v_cast_92F3A;
		input reg [16:0] inp;
		sv2v_cast_92F3A = inp;
	endfunction
	assign lfsr_data = sv2v_cast_92F3A(lfsr_state);
	// Trace: core/rtl/ibex_dummy_instr.sv:90:3
	assign dummy_cnt_threshold = lfsr_data[4-:TIMEOUT_CNT_W] & {dummy_instr_mask_i, {2 {1'b1}}};
	// Trace: core/rtl/ibex_dummy_instr.sv:91:3
	assign dummy_cnt_incr = dummy_cnt_q + {{4 {1'b0}}, 1'b1};
	// Trace: core/rtl/ibex_dummy_instr.sv:93:3
	assign dummy_cnt_d = (insert_dummy_instr ? {5 {1'sb0}} : dummy_cnt_incr);
	// Trace: core/rtl/ibex_dummy_instr.sv:96:3
	assign dummy_cnt_en = (dummy_instr_en_i & id_in_ready_i) & (fetch_valid_i | insert_dummy_instr);
	// Trace: core/rtl/ibex_dummy_instr.sv:99:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_dummy_instr.sv:100:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_dummy_instr.sv:101:7
			dummy_cnt_q <= 1'sb0;
		else if (dummy_cnt_en)
			// Trace: core/rtl/ibex_dummy_instr.sv:103:7
			dummy_cnt_q <= dummy_cnt_d;
	// Trace: core/rtl/ibex_dummy_instr.sv:108:3
	assign insert_dummy_instr = dummy_instr_en_i & (dummy_cnt_q == dummy_cnt_threshold);
	// Trace: core/rtl/ibex_dummy_instr.sv:111:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_dummy_instr.sv:112:5
		(* full_case, parallel_case *)
		case (lfsr_data[16-:2])
			2'b00: begin
				// Trace: core/rtl/ibex_dummy_instr.sv:114:9
				dummy_set = 7'b0000000;
				// Trace: core/rtl/ibex_dummy_instr.sv:115:9
				dummy_opcode = 3'b000;
			end
			2'b01: begin
				// Trace: core/rtl/ibex_dummy_instr.sv:118:9
				dummy_set = 7'b0000001;
				// Trace: core/rtl/ibex_dummy_instr.sv:119:9
				dummy_opcode = 3'b000;
			end
			2'b10: begin
				// Trace: core/rtl/ibex_dummy_instr.sv:122:9
				dummy_set = 7'b0000001;
				// Trace: core/rtl/ibex_dummy_instr.sv:123:9
				dummy_opcode = 3'b100;
			end
			2'b11: begin
				// Trace: core/rtl/ibex_dummy_instr.sv:126:9
				dummy_set = 7'b0000000;
				// Trace: core/rtl/ibex_dummy_instr.sv:127:9
				dummy_opcode = 3'b111;
			end
			default: begin
				// Trace: core/rtl/ibex_dummy_instr.sv:130:9
				dummy_set = 7'b0000000;
				// Trace: core/rtl/ibex_dummy_instr.sv:131:9
				dummy_opcode = 3'b000;
			end
		endcase
	end
	// Trace: core/rtl/ibex_dummy_instr.sv:137:3
	assign dummy_instr = {dummy_set, lfsr_data[14-:5], lfsr_data[9-:5], dummy_opcode, 12'h033};
	// Trace: core/rtl/ibex_dummy_instr.sv:140:3
	assign insert_dummy_instr_o = insert_dummy_instr;
	// Trace: core/rtl/ibex_dummy_instr.sv:141:3
	assign dummy_instr_data_o = dummy_instr;
	initial _sv2v_0 = 0;
endmodule
