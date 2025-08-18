// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module atk (
	clk_i,
	atk_observation_1_i,
	atk_observation_2_i,
	atk_equiv_o
);
	// Trace: verif/atk.sv:2:5
	input wire clk_i;
	// Trace: verif/atk.sv:3:5
	input wire atk_observation_1_i;
	// Trace: verif/atk.sv:4:5
	input wire atk_observation_2_i;
	// Trace: verif/atk.sv:5:5
	output reg atk_equiv_o;
	// Trace: verif/atk.sv:8:5
	initial begin
		// Trace: verif/atk.sv:8:13
		atk_equiv_o <= 1;
	end
	// Trace: verif/atk.sv:10:5
	always @(clk_i)
		// Trace: verif/atk.sv:11:9
		if (atk_observation_1_i != atk_observation_2_i)
			// Trace: verif/atk.sv:12:13
			atk_equiv_o <= 0;
endmodule
