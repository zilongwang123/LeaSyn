module control (
	clk_i,
	retire_i,
	fetch_1_i,
	fetch_2_i,
	instr_addr_1_i,
	instr_addr_2_i,
	enable_1_o,
	enable_2_o,
	finished_o
);
	// Trace: verif/control.sv:2:5
	input wire clk_i;
	// Trace: verif/control.sv:3:5
	input wire retire_i;
	// Trace: verif/control.sv:4:5
	input wire fetch_1_i;
	// Trace: verif/control.sv:5:5
	input wire fetch_2_i;
	// Trace: verif/control.sv:6:5
	input wire [31:0] instr_addr_1_i;
	// Trace: verif/control.sv:7:5
	input wire [31:0] instr_addr_2_i;
	// Trace: verif/control.sv:8:5
	output reg enable_1_o;
	// Trace: verif/control.sv:9:5
	output reg enable_2_o;
	// Trace: verif/control.sv:10:5
	output reg finished_o;
	// Trace: verif/control.sv:13:5
	(* nomem2reg *) reg [31:0] counters [0:0];
	// Trace: verif/control.sv:14:5
	reg signed [31:0] retire_count = 0;
	// Trace: verif/control.sv:15:5
	reg signed [31:0] fetch_1_count = 0;
	// Trace: verif/control.sv:16:5
	reg signed [31:0] fetch_2_count = 0;
	// Trace: verif/control.sv:17:5
	wire signed [31:0] MAX_INSTR_COUNT;
	// Trace: verif/control.sv:19:5
	assign MAX_INSTR_COUNT = counters[0];
	// Trace: verif/control.sv:21:5
	initial begin
$readmemh({"count.dat"}, counters, 0, 0);
		// Trace: verif/control.sv:22:9
		enable_1_o <= 1;
		// Trace: verif/control.sv:23:9
		enable_2_o <= 1;
		// Trace: verif/control.sv:24:9
		finished_o <= 0;
	end
	// Trace: verif/control.sv:29:5
	always @(negedge clk_i) begin
		// Trace: verif/control.sv:30:9
		if (retire_i == 1)
			// Trace: verif/control.sv:31:13
			retire_count = retire_count + 1;
		if ((enable_1_o == 1) && (fetch_1_i == 1))
			// Trace: verif/control.sv:34:13
			fetch_1_count = fetch_1_count + 1;
		if (!enable_1_o || ((fetch_1_count >= MAX_INSTR_COUNT) && fetch_1_i))
			// Trace: verif/control.sv:36:13
			enable_1_o = 0;
		if ((enable_2_o == 1) && (fetch_2_i == 1))
			// Trace: verif/control.sv:39:13
			fetch_2_count = fetch_2_count + 1;
		if (!enable_2_o || ((fetch_2_count >= MAX_INSTR_COUNT) && fetch_2_i))
			// Trace: verif/control.sv:41:13
			enable_2_o = 0;
		if ((!enable_1_o && !enable_2_o) && (retire_count == MAX_INSTR_COUNT))
			// Trace: verif/control.sv:44:13
			finished_o <= 1;
	end
endmodule
