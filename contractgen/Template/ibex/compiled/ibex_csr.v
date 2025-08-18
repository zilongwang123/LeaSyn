// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_csr (
	clk_i,
	rst_ni,
	wr_data_i,
	wr_en_i,
	rd_data_o,
	rd_error_o
);
	// Trace: core/rtl/ibex_csr.sv:12:15
	parameter [31:0] Width = 32;
	// Trace: core/rtl/ibex_csr.sv:13:15
	parameter [0:0] ShadowCopy = 1'b0;
	// Trace: core/rtl/ibex_csr.sv:14:15
	parameter [Width - 1:0] ResetValue = 1'sb0;
	// Trace: core/rtl/ibex_csr.sv:16:5
	input wire clk_i;
	// Trace: core/rtl/ibex_csr.sv:17:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_csr.sv:19:5
	input wire [Width - 1:0] wr_data_i;
	// Trace: core/rtl/ibex_csr.sv:20:5
	input wire wr_en_i;
	// Trace: core/rtl/ibex_csr.sv:21:5
	output wire [Width - 1:0] rd_data_o;
	// Trace: core/rtl/ibex_csr.sv:23:5
	output wire rd_error_o;
	// Trace: core/rtl/ibex_csr.sv:26:3
	reg [Width - 1:0] rdata_q;
	// Trace: core/rtl/ibex_csr.sv:28:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_csr.sv:29:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_csr.sv:30:7
			rdata_q <= ResetValue;
		else if (wr_en_i)
			// Trace: core/rtl/ibex_csr.sv:32:7
			rdata_q <= wr_data_i;
	// Trace: core/rtl/ibex_csr.sv:36:3
	assign rd_data_o = rdata_q;
	// Trace: core/rtl/ibex_csr.sv:38:3
	generate
		if (ShadowCopy) begin : gen_shadow
			// Trace: core/rtl/ibex_csr.sv:39:5
			reg [Width - 1:0] shadow_q;
			// Trace: core/rtl/ibex_csr.sv:41:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_csr.sv:42:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_csr.sv:43:9
					shadow_q <= ~ResetValue;
				else if (wr_en_i)
					// Trace: core/rtl/ibex_csr.sv:45:9
					shadow_q <= ~wr_data_i;
			// Trace: core/rtl/ibex_csr.sv:49:5
			assign rd_error_o = rdata_q != ~shadow_q;
		end
		else begin : gen_no_shadow
			// Trace: core/rtl/ibex_csr.sv:52:5
			assign rd_error_o = 1'b0;
		end
	endgenerate
endmodule
