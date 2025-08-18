// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module clk_sync (
	clk_i,
	retire_1_i,
	retire_2_i,
	clk_1_o,
	clk_2_o,
	retire_o
);
	// Trace: verif/clk_sync.sv:2:5
	input wire clk_i;
	// Trace: verif/clk_sync.sv:3:5
	input wire retire_1_i;
	// Trace: verif/clk_sync.sv:4:5
	input wire retire_2_i;
	// Trace: verif/clk_sync.sv:5:5
	output reg clk_1_o;
	// Trace: verif/clk_sync.sv:6:5
	output reg clk_2_o;
	// Trace: verif/clk_sync.sv:7:5
	output wire retire_o;
	// Trace: verif/clk_sync.sv:9:5
	initial begin
		// Trace: verif/clk_sync.sv:10:9
		clk_1_o <= 0;
		// Trace: verif/clk_sync.sv:11:9
		clk_2_o <= 0;
	end
	// Trace: verif/clk_sync.sv:16:5
	always @(clk_i)
		// Trace: verif/clk_sync.sv:17:9
		if (retire_1_i == retire_2_i) begin
			// Trace: verif/clk_sync.sv:18:13
			clk_1_o <= clk_i;
			// Trace: verif/clk_sync.sv:19:13
			clk_2_o <= clk_i;
		end
		else if (retire_1_i == 1) begin
			// Trace: verif/clk_sync.sv:23:13
			clk_1_o <= clk_1_o;
			// Trace: verif/clk_sync.sv:24:13
			clk_2_o <= clk_i;
		end
		else if (retire_2_i == 1) begin
			// Trace: verif/clk_sync.sv:28:13
			clk_1_o <= clk_i;
			// Trace: verif/clk_sync.sv:29:13
			clk_2_o <= clk_2_o;
		end
	// Trace: verif/clk_sync.sv:33:5
	assign retire_o = retire_1_i && retire_2_i;
endmodule
