// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module data_mem (
	clk_i,
	data_req_i,
	data_we_i,
	data_be_i,
	data_addr_i,
	data_wdata_i,
	data_gnt_o,
	data_rvalid_o,
	data_rdata_o,
	data_err_o,
	mem_addr_o,
	mem_data_o
);
	// Trace: verif/data_mem.sv:3:5
	input wire clk_i;
	// Trace: verif/data_mem.sv:4:5
	input wire data_req_i;
	// Trace: verif/data_mem.sv:5:5
	input wire data_we_i;
	// Trace: verif/data_mem.sv:6:5
	input wire [3:0] data_be_i;
	// Trace: verif/data_mem.sv:7:5
	input wire [31:0] data_addr_i;
	// Trace: verif/data_mem.sv:8:5
	input wire [31:0] data_wdata_i;
	// Trace: verif/data_mem.sv:9:5
	output reg data_gnt_o;
	// Trace: verif/data_mem.sv:10:5
	output reg data_rvalid_o;
	// Trace: verif/data_mem.sv:11:5
	output reg [31:0] data_rdata_o;
	// Trace: verif/data_mem.sv:12:5
	output reg data_err_o;
	// Trace: verif/data_mem.sv:13:5
	output wire [1023:0] mem_addr_o;
	// Trace: verif/data_mem.sv:14:5
	output wire [255:0] mem_data_o;
	// Trace: verif/data_mem.sv:17:5
	reg [1023:0] last_addr;
	// Trace: verif/data_mem.sv:18:5
	reg [255:0] last_values;
	// Trace: verif/data_mem.sv:19:5
	reg [32:0] temp;
	// Trace: verif/data_mem.sv:21:5
	initial begin
		// Trace: verif/data_mem.sv:22:9
		last_addr = 0;
		// Trace: verif/data_mem.sv:23:9
		last_values = 0;
	end
	// Trace: verif/data_mem.sv:26:5
	integer i;
	// Trace: verif/data_mem.sv:27:5
	integer j;
	// Trace: verif/data_mem.sv:28:5
	always @(posedge clk_i)
		// Trace: verif/data_mem.sv:29:9
		if (data_req_i == 1'b1) begin
			// Trace: verif/data_mem.sv:30:13
			temp = data_addr_i % 32'h00001000;
			// Trace: verif/data_mem.sv:31:13
			for (i = 0; i < 32; i = i + 1)
				begin
					// Trace: verif/data_mem.sv:32:17
					if (data_be_i[0] && ((data_addr_i + 0) == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:33:21
						temp[7:0] = last_values[i * 8+:8];
					if (data_be_i[1] && ((data_addr_i + 1) == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:36:21
						temp[15:8] = last_values[i * 8+:8];
					if (data_be_i[2] && ((data_addr_i + 2) == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:39:21
						temp[23:16] = last_values[i * 8+:8];
					if (data_be_i[3] && ((data_addr_i + 3) == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:42:21
						temp[31:24] = last_values[i * 8+:8];
				end
			// Trace: verif/data_mem.sv:45:13
			data_rdata_o <= temp;
			if (data_we_i) begin
				// Trace: verif/data_mem.sv:47:17
				if (data_be_i[0]) begin
					// Trace: verif/data_mem.sv:48:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/data_mem.sv:49:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/data_mem.sv:50:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/data_mem.sv:52:21
					last_addr[992+:32] = data_addr_i + 0;
					// Trace: verif/data_mem.sv:53:21
					last_values[248+:8] = data_wdata_i[7:0];
				end
				if (data_be_i[1]) begin
					// Trace: verif/data_mem.sv:56:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/data_mem.sv:57:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/data_mem.sv:58:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/data_mem.sv:60:21
					last_addr[992+:32] = data_addr_i + 1;
					// Trace: verif/data_mem.sv:61:21
					last_values[248+:8] = data_wdata_i[15:8];
				end
				if (data_be_i[2]) begin
					// Trace: verif/data_mem.sv:64:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/data_mem.sv:65:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/data_mem.sv:66:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/data_mem.sv:68:21
					last_addr[992+:32] = data_addr_i + 2;
					// Trace: verif/data_mem.sv:69:21
					last_values[248+:8] = data_wdata_i[23:16];
				end
				if (data_be_i[3]) begin
					// Trace: verif/data_mem.sv:72:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/data_mem.sv:73:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/data_mem.sv:74:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/data_mem.sv:76:21
					last_addr[992+:32] = data_addr_i + 3;
					// Trace: verif/data_mem.sv:77:21
					last_values[248+:8] = data_wdata_i[31:24];
				end
			end
			// Trace: verif/data_mem.sv:80:13
			data_gnt_o <= 1'b1;
			// Trace: verif/data_mem.sv:81:13
			data_rvalid_o <= 1'b1;
			// Trace: verif/data_mem.sv:82:13
			data_err_o <= 1'b0;
		end
		else begin
			// Trace: verif/data_mem.sv:84:13
			data_gnt_o <= 1'b0;
			// Trace: verif/data_mem.sv:85:13
			data_rvalid_o <= 1'b0;
			// Trace: verif/data_mem.sv:86:13
			data_err_o <= 1'b0;
		end
endmodule
