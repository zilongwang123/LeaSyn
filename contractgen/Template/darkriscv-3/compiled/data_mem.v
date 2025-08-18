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
	reg _sv2v_0;
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
	output wire data_gnt_o;
	// Trace: verif/data_mem.sv:10:5
	output wire data_rvalid_o;
	// Trace: verif/data_mem.sv:11:5
	output reg [31:0] data_rdata_o;
	// Trace: verif/data_mem.sv:12:5
	output wire data_err_o;
	// Trace: verif/data_mem.sv:13:5
	output wire [1023:0] mem_addr_o;
	// Trace: verif/data_mem.sv:14:5
	output wire [255:0] mem_data_o;
	// Trace: verif/data_mem.sv:17:5
	reg [1023:0] last_addr;
	// Trace: verif/data_mem.sv:18:5
	reg [255:0] last_values;
	// Trace: verif/data_mem.sv:20:5
	initial begin
		// Trace: verif/data_mem.sv:21:9
		last_addr = 0;
		// Trace: verif/data_mem.sv:22:9
		last_values = 0;
	end
	// Trace: verif/data_mem.sv:25:5
	assign data_gnt_o = data_req_i;
	// Trace: verif/data_mem.sv:26:5
	assign data_rvalid_o = data_req_i && !data_we_i;
	// Trace: verif/data_mem.sv:28:5
	integer i;
	// Trace: verif/data_mem.sv:29:5
	always @(*) begin : data_rdata_o_gen
		if (_sv2v_0)
			;
		// Trace: verif/data_mem.sv:30:9
		data_rdata_o = 0;
		// Trace: verif/data_mem.sv:31:9
		begin : sv2v_autoblock_1
			// Trace: verif/data_mem.sv:31:14
			reg signed [31:0] i;
			// Trace: verif/data_mem.sv:31:14
			for (i = 0; i < 32; i = i + 1)
				begin
					// Trace: verif/data_mem.sv:32:13
					if (data_be_i[0] && (data_addr_i == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:33:17
						data_rdata_o[7:0] = last_values[i * 8+:8];
					if (data_be_i[1] && ((data_addr_i + 1) == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:36:17
						data_rdata_o[15:8] = last_values[i * 8+:8];
					if (data_be_i[2] && ((data_addr_i + 2) == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:39:17
						data_rdata_o[23:16] = last_values[i * 8+:8];
					if (data_be_i[3] && ((data_addr_i + 3) == last_addr[i * 32+:32]))
						// Trace: verif/data_mem.sv:42:17
						data_rdata_o[31:24] = last_values[i * 8+:8];
				end
		end
	end
	// Trace: verif/data_mem.sv:47:5
	assign data_err_o = 0;
	// Trace: verif/data_mem.sv:48:5
	assign mem_addr_o = last_addr;
	// Trace: verif/data_mem.sv:49:5
	assign mem_data_o = last_values;
	// Trace: verif/data_mem.sv:51:5
	always @(negedge clk_i)
		// Trace: verif/data_mem.sv:52:9
		if (data_req_i == 1'b1) begin
			begin
				// Trace: verif/data_mem.sv:53:13
				if (data_we_i) begin
					// Trace: verif/data_mem.sv:54:17
					if (data_be_i[0]) begin
						// Trace: verif/data_mem.sv:55:21
						for (i = 1; i < 32; i = i + 1)
							begin
								// Trace: verif/data_mem.sv:56:25
								last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
								// Trace: verif/data_mem.sv:57:25
								last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
							end
						// Trace: verif/data_mem.sv:59:21
						last_addr[992+:32] = data_addr_i + 0;
						// Trace: verif/data_mem.sv:60:21
						last_values[248+:8] = data_wdata_i[7:0];
					end
					if (data_be_i[1]) begin
						// Trace: verif/data_mem.sv:63:21
						for (i = 1; i < 32; i = i + 1)
							begin
								// Trace: verif/data_mem.sv:64:25
								last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
								// Trace: verif/data_mem.sv:65:25
								last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
							end
						// Trace: verif/data_mem.sv:67:21
						last_addr[992+:32] = data_addr_i + 1;
						// Trace: verif/data_mem.sv:68:21
						last_values[248+:8] = data_wdata_i[15:8];
					end
					if (data_be_i[2]) begin
						// Trace: verif/data_mem.sv:71:21
						for (i = 1; i < 32; i = i + 1)
							begin
								// Trace: verif/data_mem.sv:72:25
								last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
								// Trace: verif/data_mem.sv:73:25
								last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
							end
						// Trace: verif/data_mem.sv:75:21
						last_addr[992+:32] = data_addr_i + 2;
						// Trace: verif/data_mem.sv:76:21
						last_values[248+:8] = data_wdata_i[23:16];
					end
					if (data_be_i[3]) begin
						// Trace: verif/data_mem.sv:79:21
						for (i = 1; i < 32; i = i + 1)
							begin
								// Trace: verif/data_mem.sv:80:25
								last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
								// Trace: verif/data_mem.sv:81:25
								last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
							end
						// Trace: verif/data_mem.sv:83:21
						last_addr[992+:32] = data_addr_i + 3;
						// Trace: verif/data_mem.sv:84:21
						last_values[248+:8] = data_wdata_i[31:24];
					end
				end
			end
		end
	initial _sv2v_0 = 0;
endmodule
