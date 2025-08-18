// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module cached_data_mem (
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
	// Trace: verif/cached_data_mem.sv:3:5
	input wire clk_i;
	// Trace: verif/cached_data_mem.sv:4:5
	input wire data_req_i;
	// Trace: verif/cached_data_mem.sv:5:5
	input wire data_we_i;
	// Trace: verif/cached_data_mem.sv:6:5
	input wire [3:0] data_be_i;
	// Trace: verif/cached_data_mem.sv:7:5
	input wire [31:0] data_addr_i;
	// Trace: verif/cached_data_mem.sv:8:5
	input wire [31:0] data_wdata_i;
	// Trace: verif/cached_data_mem.sv:9:5
	output reg data_gnt_o;
	// Trace: verif/cached_data_mem.sv:10:5
	output reg data_rvalid_o;
	// Trace: verif/cached_data_mem.sv:11:5
	output reg [31:0] data_rdata_o;
	// Trace: verif/cached_data_mem.sv:12:5
	output reg data_err_o;
	// Trace: verif/cached_data_mem.sv:13:5
	output wire [1023:0] mem_addr_o;
	// Trace: verif/cached_data_mem.sv:14:5
	output wire [255:0] mem_data_o;
	// Trace: verif/cached_data_mem.sv:17:5
	reg [1023:0] last_addr;
	// Trace: verif/cached_data_mem.sv:18:5
	reg [255:0] last_values;
	// Trace: verif/cached_data_mem.sv:19:5
	reg [32:0] temp;
	// Trace: verif/cached_data_mem.sv:21:5
	reg next_rvalid_o;
	// Trace: verif/cached_data_mem.sv:22:5
	reg [31:0] next_rdata_o;
	// Trace: verif/cached_data_mem.sv:24:5
	reg [31:0] cached_addr;
	// Trace: verif/cached_data_mem.sv:25:5
	reg cache_miss;
	// Trace: verif/cached_data_mem.sv:27:5
	wire req_now;
	// Trace: verif/cached_data_mem.sv:28:5
	assign req_now = ((data_req_i && (cached_addr == data_addr_i)) || (data_req_i && data_we_i)) || cache_miss;
	// Trace: verif/cached_data_mem.sv:30:5
	initial begin
		// Trace: verif/cached_data_mem.sv:31:9
		last_addr = 0;
		// Trace: verif/cached_data_mem.sv:32:9
		last_values = 0;
		// Trace: verif/cached_data_mem.sv:33:9
		cached_addr = 0;
	end
	// Trace: verif/cached_data_mem.sv:36:5
	integer i;
	// Trace: verif/cached_data_mem.sv:37:5
	integer j;
	// Trace: verif/cached_data_mem.sv:38:5
	always @(posedge clk_i) begin
		// Trace: verif/cached_data_mem.sv:39:9
		if (req_now == 1'b1) begin
			// Trace: verif/cached_data_mem.sv:40:13
			temp = data_addr_i % 32'h00001000;
			// Trace: verif/cached_data_mem.sv:41:13
			for (i = 0; i < 32; i = i + 1)
				begin
					// Trace: verif/cached_data_mem.sv:42:17
					if (data_be_i[0] && ((data_addr_i + 0) == last_addr[i * 32+:32]))
						// Trace: verif/cached_data_mem.sv:43:21
						temp[7:0] = last_values[i * 8+:8];
					if (data_be_i[1] && ((data_addr_i + 1) == last_addr[i * 32+:32]))
						// Trace: verif/cached_data_mem.sv:46:21
						temp[15:8] = last_values[i * 8+:8];
					if (data_be_i[2] && ((data_addr_i + 2) == last_addr[i * 32+:32]))
						// Trace: verif/cached_data_mem.sv:49:21
						temp[23:16] = last_values[i * 8+:8];
					if (data_be_i[3] && ((data_addr_i + 3) == last_addr[i * 32+:32]))
						// Trace: verif/cached_data_mem.sv:52:21
						temp[31:24] = last_values[i * 8+:8];
				end
			// Trace: verif/cached_data_mem.sv:55:13
			next_rdata_o <= temp;
			if (data_we_i) begin
				// Trace: verif/cached_data_mem.sv:57:17
				if (data_be_i[0]) begin
					// Trace: verif/cached_data_mem.sv:58:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/cached_data_mem.sv:59:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/cached_data_mem.sv:60:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/cached_data_mem.sv:62:21
					last_addr[1024+:32] = data_addr_i + 0;
					// Trace: verif/cached_data_mem.sv:63:21
					last_values[256+:8] = data_wdata_i[7:0];
				end
				if (data_be_i[1]) begin
					// Trace: verif/cached_data_mem.sv:66:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/cached_data_mem.sv:67:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/cached_data_mem.sv:68:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/cached_data_mem.sv:70:21
					last_addr[1024+:32] = data_addr_i + 1;
					// Trace: verif/cached_data_mem.sv:71:21
					last_values[256+:8] = data_wdata_i[15:8];
				end
				if (data_be_i[2]) begin
					// Trace: verif/cached_data_mem.sv:74:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/cached_data_mem.sv:75:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/cached_data_mem.sv:76:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/cached_data_mem.sv:78:21
					last_addr[1024+:32] = data_addr_i + 2;
					// Trace: verif/cached_data_mem.sv:79:21
					last_values[256+:8] = data_wdata_i[23:16];
				end
				if (data_be_i[3]) begin
					// Trace: verif/cached_data_mem.sv:82:21
					for (i = 1; i < 32; i = i + 1)
						begin
							// Trace: verif/cached_data_mem.sv:83:25
							last_addr[(i - 1) * 32+:32] = last_addr[i * 32+:32];
							// Trace: verif/cached_data_mem.sv:84:25
							last_values[(i - 1) * 8+:8] = last_values[i * 8+:8];
						end
					// Trace: verif/cached_data_mem.sv:86:21
					last_addr[1024+:32] = data_addr_i + 3;
					// Trace: verif/cached_data_mem.sv:87:21
					last_values[256+:8] = data_wdata_i[31:24];
				end
			end
			// Trace: verif/cached_data_mem.sv:90:13
			data_gnt_o <= 1'b1;
			// Trace: verif/cached_data_mem.sv:91:13
			next_rdata_o <= 1'b1;
			// Trace: verif/cached_data_mem.sv:92:13
			next_rvalid_o <= 1'b1;
			// Trace: verif/cached_data_mem.sv:93:13
			data_err_o <= 1'b0;
			if (data_we_i)
				// Trace: verif/cached_data_mem.sv:95:17
				cached_addr = 31'b0000000000000000000000000000001;
			else
				// Trace: verif/cached_data_mem.sv:97:17
				cached_addr = data_addr_i;
			// Trace: verif/cached_data_mem.sv:99:13
			cache_miss = 0;
		end
		else begin
			// Trace: verif/cached_data_mem.sv:101:13
			data_gnt_o <= 1'b0;
			// Trace: verif/cached_data_mem.sv:102:13
			next_rvalid_o <= 1'b0;
			// Trace: verif/cached_data_mem.sv:103:13
			next_rdata_o <= 1'b0;
			// Trace: verif/cached_data_mem.sv:104:13
			data_err_o <= 1'b0;
			// Trace: verif/cached_data_mem.sv:106:13
			if (data_req_i)
				// Trace: verif/cached_data_mem.sv:107:17
				cache_miss = 1'b1;
		end
		// Trace: verif/cached_data_mem.sv:111:9
		data_rvalid_o <= next_rvalid_o;
		// Trace: verif/cached_data_mem.sv:112:9
		data_rdata_o <= next_rdata_o;
	end
endmodule
