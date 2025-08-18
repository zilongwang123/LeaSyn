// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_register_file_ff (
	clk_i,
	rst_ni,
	test_en_i,
	dummy_instr_id_i,
	raddr_a_i,
	rdata_a_o,
	raddr_b_i,
	rdata_b_o,
	waddr_a_i,
	wdata_a_i,
	we_a_i,
	regfile_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_register_file_ff.sv:14:15
	parameter [0:0] RV32E = 0;
	// Trace: core/rtl/ibex_register_file_ff.sv:15:15
	parameter [31:0] DataWidth = 32;
	// Trace: core/rtl/ibex_register_file_ff.sv:16:15
	parameter [0:0] DummyInstructions = 0;
	// Trace: core/rtl/ibex_register_file_ff.sv:19:5
	input wire clk_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:20:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_register_file_ff.sv:22:5
	input wire test_en_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:23:5
	input wire dummy_instr_id_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:26:5
	input wire [4:0] raddr_a_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:27:5
	output wire [DataWidth - 1:0] rdata_a_o;
	// Trace: core/rtl/ibex_register_file_ff.sv:30:5
	input wire [4:0] raddr_b_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:31:5
	output wire [DataWidth - 1:0] rdata_b_o;
	// Trace: core/rtl/ibex_register_file_ff.sv:35:5
	input wire [4:0] waddr_a_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:36:5
	input wire [DataWidth - 1:0] wdata_a_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:37:5
	input wire we_a_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:40:5
	output wire [((2 ** (RV32E ? 4 : 5)) * DataWidth) - 1:0] regfile_o;
	// Trace: core/rtl/ibex_register_file_ff.sv:44:3
	localparam [31:0] ADDR_WIDTH = (RV32E ? 4 : 5);
	// Trace: core/rtl/ibex_register_file_ff.sv:45:3
	localparam [31:0] NUM_WORDS = 2 ** ADDR_WIDTH;
	// Trace: core/rtl/ibex_register_file_ff.sv:47:3
	wire [(NUM_WORDS * DataWidth) - 1:0] rf_reg;
	// Trace: core/rtl/ibex_register_file_ff.sv:48:3
	reg [((NUM_WORDS - 1) >= 1 ? ((NUM_WORDS - 1) * DataWidth) + (DataWidth - 1) : ((3 - NUM_WORDS) * DataWidth) + (((NUM_WORDS - 1) * DataWidth) - 1)):((NUM_WORDS - 1) >= 1 ? DataWidth : (NUM_WORDS - 1) * DataWidth)] rf_reg_q;
	// Trace: core/rtl/ibex_register_file_ff.sv:49:3
	reg [NUM_WORDS - 1:1] we_a_dec;
	// Trace: core/rtl/ibex_register_file_ff.sv:51:3
	function automatic [4:0] sv2v_cast_5;
		input reg [4:0] inp;
		sv2v_cast_5 = inp;
	endfunction
	always @(*) begin : we_a_decoder
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_register_file_ff.sv:52:5
		begin : sv2v_autoblock_1
			// Trace: core/rtl/ibex_register_file_ff.sv:52:10
			reg [31:0] i;
			// Trace: core/rtl/ibex_register_file_ff.sv:52:10
			for (i = 1; i < NUM_WORDS; i = i + 1)
				begin
					// Trace: core/rtl/ibex_register_file_ff.sv:53:7
					we_a_dec[i] = (waddr_a_i == sv2v_cast_5(i) ? we_a_i : 1'b0);
				end
		end
	end
	// Trace: core/rtl/ibex_register_file_ff.sv:58:3
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 1; _gv_i_1 < NUM_WORDS; _gv_i_1 = _gv_i_1 + 1) begin : g_rf_flops
			localparam i = _gv_i_1;
			// Trace: core/rtl/ibex_register_file_ff.sv:59:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_register_file_ff.sv:60:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_register_file_ff.sv:61:9
					rf_reg_q[((NUM_WORDS - 1) >= 1 ? i : 1 - (i - (NUM_WORDS - 1))) * DataWidth+:DataWidth] <= 1'sb0;
				else if (we_a_dec[i])
					// Trace: core/rtl/ibex_register_file_ff.sv:63:9
					rf_reg_q[((NUM_WORDS - 1) >= 1 ? i : 1 - (i - (NUM_WORDS - 1))) * DataWidth+:DataWidth] <= wdata_a_i;
		end
	endgenerate
	// Trace: core/rtl/ibex_register_file_ff.sv:70:3
	generate
		if (DummyInstructions) begin : g_dummy_r0
			// Trace: core/rtl/ibex_register_file_ff.sv:71:5
			wire we_r0_dummy;
			// Trace: core/rtl/ibex_register_file_ff.sv:72:5
			reg [DataWidth - 1:0] rf_r0_q;
			// Trace: core/rtl/ibex_register_file_ff.sv:75:5
			assign we_r0_dummy = we_a_i & dummy_instr_id_i;
			// Trace: core/rtl/ibex_register_file_ff.sv:77:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_register_file_ff.sv:78:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_register_file_ff.sv:79:9
					rf_r0_q <= 1'sb0;
				else if (we_r0_dummy)
					// Trace: core/rtl/ibex_register_file_ff.sv:81:9
					rf_r0_q <= wdata_a_i;
			// Trace: core/rtl/ibex_register_file_ff.sv:86:5
			assign rf_reg[0+:DataWidth] = (dummy_instr_id_i ? rf_r0_q : {DataWidth * 1 {1'sb0}});
		end
		else begin : g_normal_r0
			// Trace: core/rtl/ibex_register_file_ff.sv:89:5
			wire unused_dummy_instr_id;
			// Trace: core/rtl/ibex_register_file_ff.sv:90:5
			assign unused_dummy_instr_id = dummy_instr_id_i;
			// Trace: core/rtl/ibex_register_file_ff.sv:93:5
			assign rf_reg[0+:DataWidth] = 1'sb0;
		end
	endgenerate
	// Trace: core/rtl/ibex_register_file_ff.sv:96:3
	assign rf_reg[DataWidth * (((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : ((NUM_WORDS - 1) + ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS)) - 1) - (((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS) - 1))+:DataWidth * ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS)] = rf_reg_q[DataWidth * ((NUM_WORDS - 1) >= 1 ? ((NUM_WORDS - 1) >= 1 ? ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : ((NUM_WORDS - 1) + ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS)) - 1) - (((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS) - 1) : ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : ((NUM_WORDS - 1) + ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS)) - 1)) : 1 - (((NUM_WORDS - 1) >= 1 ? ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : ((NUM_WORDS - 1) + ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS)) - 1) - (((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS) - 1) : ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : ((NUM_WORDS - 1) + ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS)) - 1)) - (NUM_WORDS - 1)))+:DataWidth * ((NUM_WORDS - 1) >= 1 ? NUM_WORDS - 1 : 3 - NUM_WORDS)];
	// Trace: core/rtl/ibex_register_file_ff.sv:98:3
	assign rdata_a_o = rf_reg[raddr_a_i * DataWidth+:DataWidth];
	// Trace: core/rtl/ibex_register_file_ff.sv:99:3
	assign rdata_b_o = rf_reg[raddr_b_i * DataWidth+:DataWidth];
	// Trace: core/rtl/ibex_register_file_ff.sv:102:3
	wire unused_test_en;
	// Trace: core/rtl/ibex_register_file_ff.sv:103:3
	assign unused_test_en = test_en_i;
	// Trace: core/rtl/ibex_register_file_ff.sv:106:3
	assign regfile_o = rf_reg;
	initial _sv2v_0 = 0;
endmodule
