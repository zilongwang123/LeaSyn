// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_counter (
	clk_i,
	rst_ni,
	counter_inc_i,
	counterh_we_i,
	counter_we_i,
	counter_val_i,
	counter_val_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_counter.sv:2:13
	parameter signed [31:0] CounterWidth = 32;
	// Trace: core/rtl/ibex_counter.sv:4:3
	input wire clk_i;
	// Trace: core/rtl/ibex_counter.sv:5:3
	input wire rst_ni;
	// Trace: core/rtl/ibex_counter.sv:7:3
	input wire counter_inc_i;
	// Trace: core/rtl/ibex_counter.sv:8:3
	input wire counterh_we_i;
	// Trace: core/rtl/ibex_counter.sv:9:3
	input wire counter_we_i;
	// Trace: core/rtl/ibex_counter.sv:10:3
	input wire [31:0] counter_val_i;
	// Trace: core/rtl/ibex_counter.sv:11:3
	output wire [63:0] counter_val_o;
	// Trace: core/rtl/ibex_counter.sv:14:3
	wire [63:0] counter;
	// Trace: core/rtl/ibex_counter.sv:15:3
	reg [CounterWidth - 1:0] counter_upd;
	// Trace: core/rtl/ibex_counter.sv:16:3
	reg [63:0] counter_load;
	// Trace: core/rtl/ibex_counter.sv:17:3
	reg we;
	// Trace: core/rtl/ibex_counter.sv:18:3
	reg [CounterWidth - 1:0] counter_d;
	// Trace: core/rtl/ibex_counter.sv:21:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_counter.sv:24:5
		we = counter_we_i | counterh_we_i;
		// Trace: core/rtl/ibex_counter.sv:25:5
		counter_load[63:32] = counter[63:32];
		// Trace: core/rtl/ibex_counter.sv:26:5
		counter_load[31:0] = counter_val_i;
		// Trace: core/rtl/ibex_counter.sv:27:5
		if (counterh_we_i) begin
			// Trace: core/rtl/ibex_counter.sv:28:7
			counter_load[63:32] = counter_val_i;
			// Trace: core/rtl/ibex_counter.sv:29:7
			counter_load[31:0] = counter[31:0];
		end
		// Trace: core/rtl/ibex_counter.sv:33:5
		counter_upd = counter[CounterWidth - 1:0] + {{CounterWidth - 1 {1'b0}}, 1'b1};
		if (we)
			// Trace: core/rtl/ibex_counter.sv:37:7
			counter_d = counter_load[CounterWidth - 1:0];
		else if (counter_inc_i)
			// Trace: core/rtl/ibex_counter.sv:39:7
			counter_d = counter_upd[CounterWidth - 1:0];
		else
			// Trace: core/rtl/ibex_counter.sv:41:7
			counter_d = counter[CounterWidth - 1:0];
	end
	// Trace: core/rtl/ibex_counter.sv:53:3
	reg [CounterWidth - 1:0] counter_q;
	// Trace: core/rtl/ibex_counter.sv:59:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_counter.sv:60:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_counter.sv:61:7
			counter_q <= 1'sb0;
		else
			// Trace: core/rtl/ibex_counter.sv:63:7
			counter_q <= counter_d;
	// Trace: core/rtl/ibex_counter.sv:67:3
	generate
		if (CounterWidth < 64) begin : g_counter_narrow
			// Trace: core/rtl/ibex_counter.sv:68:5
			wire [63:CounterWidth] unused_counter_load;
			// Trace: core/rtl/ibex_counter.sv:70:5
			assign counter[CounterWidth - 1:0] = counter_q;
			// Trace: core/rtl/ibex_counter.sv:71:5
			assign counter[63:CounterWidth] = 1'sb0;
			// Trace: core/rtl/ibex_counter.sv:72:5
			assign unused_counter_load = counter_load[63:CounterWidth];
		end
		else begin : g_counter_full
			// Trace: core/rtl/ibex_counter.sv:74:5
			assign counter = counter_q;
		end
	endgenerate
	// Trace: core/rtl/ibex_counter.sv:77:3
	assign counter_val_o = counter;
	initial _sv2v_0 = 0;
endmodule
