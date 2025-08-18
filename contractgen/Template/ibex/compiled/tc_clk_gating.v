// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module tc_clk_gating (
	clk_i,
	en_i,
	test_en_i,
	clk_o
);
	// Trace: verif/tc_clk_gating.sv:2:5
	input wire clk_i;
	// Trace: verif/tc_clk_gating.sv:3:5
	input wire en_i;
	// Trace: verif/tc_clk_gating.sv:4:2
	input wire test_en_i;
	// Trace: verif/tc_clk_gating.sv:5:2
	input wire clk_o;
	// Trace: verif/tc_clk_gating.sv:8:5
	assign clk_o = clk_i;
endmodule
