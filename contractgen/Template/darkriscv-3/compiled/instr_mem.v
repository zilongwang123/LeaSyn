module instr_mem (
	clk_i,
	enable_i,
	instr_req_i,
	instr_addr_i,
	instr_gnt_o,
	instr_o
);
	// Trace: verif/instr_mem.sv:5:15
	parameter [31:0] ID = 0;
	// Trace: verif/instr_mem.sv:7:5
	input wire clk_i;
	// Trace: verif/instr_mem.sv:8:5
	input wire enable_i;
	// Trace: verif/instr_mem.sv:9:5
	input wire instr_req_i;
	// Trace: verif/instr_mem.sv:10:5
	input wire [31:0] instr_addr_i;
	// Trace: verif/instr_mem.sv:11:5
	output wire instr_gnt_o;
	// Trace: verif/instr_mem.sv:12:5
	output reg [31:0] instr_o;
	// Trace: verif/instr_mem.sv:15:5
	(* nomem2reg *) reg [31:0] mem [127:0];
	// Trace: verif/instr_mem.sv:17:5
	wire [31:0] instr_addr;
	// Trace: verif/instr_mem.sv:18:5
	assign instr_addr = instr_addr_i - 32'h00000000;
	// Trace: verif/instr_mem.sv:19:5
	wire [32:1] sv2v_tmp_5DED1;
	assign sv2v_tmp_5DED1 = (enable_i ? ((instr_addr_i >> 2) < 128 ? mem[instr_addr_i >> 2] : 32'h00000013) : 32'h00000013);
	always @(*) instr_o = sv2v_tmp_5DED1;
	// Trace: verif/instr_mem.sv:20:5
	assign instr_gnt_o = instr_req_i;
	// Trace: verif/instr_mem.sv:24:5
	initial begin
		// Trace: verif/instr_mem.sv:25:3
		begin : sv2v_autoblock_1
			// Trace: verif/instr_mem.sv:25:7
			reg signed [31:0] i;
			// Trace: verif/instr_mem.sv:25:7
			for (i = 0; i < 128; i = i + 1)
				begin
					// Trace: verif/instr_mem.sv:26:4
					mem[i] = 32'h00000013;
				end
		end
$readmemh({"init_", $sformatf("%0d", ID), ".dat"}, mem, 0, 31);
$readmemh({"memory_", $sformatf("%0d", ID), ".dat"}, mem, 32, (128 - 1));
		// Trace: verif/instr_mem.sv:32:9
		instr_o <= 32'h00000013;
	end
endmodule
