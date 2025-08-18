module tc_sram (
	clk_i,
	rst_ni,
	req_i,
	we_i,
	addr_i,
	wdata_i,
	be_i,
	rdata_o
);
	reg _sv2v_0;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:54:13
	parameter [31:0] NumWords = 32'd1024;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:55:13
	parameter [31:0] DataWidth = 32'd128;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:56:13
	parameter [31:0] ByteWidth = 32'd8;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:57:13
	parameter [31:0] NumPorts = 32'd2;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:58:13
	parameter [31:0] Latency = 32'd1;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:59:26
	parameter SimInit = "zeros";
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:60:13
	parameter [0:0] PrintSimCfg = 1'b0;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:62:13
	parameter [31:0] AddrWidth = (NumWords > 32'd1 ? $clog2(NumWords) : 32'd1);
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:63:13
	parameter [31:0] BeWidth = ((DataWidth + ByteWidth) - 32'd1) / ByteWidth;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:64:26
	// removed localparam type addr_t
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:65:26
	// removed localparam type data_t
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:66:26
	// removed localparam type be_t
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:68:3
	input wire clk_i;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:69:3
	input wire rst_ni;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:71:3
	input wire [NumPorts - 1:0] req_i;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:72:3
	input wire [NumPorts - 1:0] we_i;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:73:3
	input wire [(NumPorts * AddrWidth) - 1:0] addr_i;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:74:3
	input wire [(NumPorts * DataWidth) - 1:0] wdata_i;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:75:3
	input wire [(NumPorts * BeWidth) - 1:0] be_i;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:77:3
	output reg [(NumPorts * DataWidth) - 1:0] rdata_o;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:82:3
	(* nomem2reg *) reg [(NumWords * DataWidth) - 1:0] sram;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:84:3
	reg [(NumPorts * AddrWidth) - 1:0] r_addr_q;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:87:3
	reg [(NumWords * DataWidth) - 1:0] init_val;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:88:3
	initial begin : proc_sram_init
		// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:89:5
		begin : sv2v_autoblock_1
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:89:10
			reg [31:0] i;
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:89:10
			for (i = 0; i < NumWords; i = i + 1)
				begin
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:90:7
					init_val[i * DataWidth+:DataWidth] = {DataWidth {1'b0}};
				end
		end
	end
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:100:3
	reg [((NumPorts * Latency) * DataWidth) - 1:0] rdata_q;
	reg [((NumPorts * Latency) * DataWidth) - 1:0] rdata_d;
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:101:3
	generate
		if (Latency == 32'd0) begin : gen_no_read_lat
			genvar _gv_i_1;
			for (_gv_i_1 = 0; _gv_i_1 < NumPorts; _gv_i_1 = _gv_i_1 + 1) begin : gen_port
				localparam i = _gv_i_1;
				// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:103:7
				wire [DataWidth * 1:1] sv2v_tmp_09466;
				assign sv2v_tmp_09466 = (req_i[i] && !we_i[i] ? sram[addr_i[i * AddrWidth+:AddrWidth] * DataWidth+:DataWidth] : sram[r_addr_q[i * AddrWidth+:AddrWidth] * DataWidth+:DataWidth]);
				always @(*) rdata_o[i * DataWidth+:DataWidth] = sv2v_tmp_09466;
			end
		end
		else begin : gen_read_lat
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:107:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:108:7
				begin : sv2v_autoblock_2
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:108:12
					reg [31:0] i;
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:108:12
					for (i = 0; i < NumPorts; i = i + 1)
						begin
							// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:109:9
							rdata_o[i * DataWidth+:DataWidth] = rdata_q[((i * Latency) + 0) * DataWidth+:DataWidth];
							// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:110:9
							begin : sv2v_autoblock_3
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:110:14
								reg [31:0] j;
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:110:14
								for (j = 0; j < (Latency - 1); j = j + 1)
									begin
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:111:11
										rdata_d[((i * Latency) + j) * DataWidth+:DataWidth] = rdata_q[(((i * Latency) + j) + 1) * DataWidth+:DataWidth];
									end
							end
							// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:113:9
							rdata_d[(((i * Latency) + Latency) - 1) * DataWidth+:DataWidth] = (req_i[i] && !we_i[i] ? sram[addr_i[i * AddrWidth+:AddrWidth] * DataWidth+:DataWidth] : sram[r_addr_q[i * AddrWidth+:AddrWidth] * DataWidth+:DataWidth]);
						end
				end
			end
		end
	endgenerate
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:120:3
	generate
		if (SimInit == "none") begin : genblk2
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:122:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:123:7
				if (!rst_ni)
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:124:9
					begin : sv2v_autoblock_4
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:124:14
						reg signed [31:0] i;
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:124:14
						for (i = 0; i < NumPorts; i = i + 1)
							begin
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:125:11
								r_addr_q[i * AddrWidth+:AddrWidth] <= {AddrWidth {1'b0}};
							end
					end
				else begin
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:129:9
					begin : sv2v_autoblock_5
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:129:14
						reg [31:0] i;
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:129:14
						for (i = 0; i < NumPorts; i = i + 1)
							begin
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:130:11
								if (Latency != 0)
									// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:131:13
									begin : sv2v_autoblock_6
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:131:18
										reg [31:0] j;
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:131:18
										for (j = 0; j < Latency; j = j + 1)
											begin
												// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:132:15
												rdata_q[((i * Latency) + j) * DataWidth+:DataWidth] <= rdata_d[((i * Latency) + j) * DataWidth+:DataWidth];
											end
									end
							end
					end
					begin : sv2v_autoblock_7
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:137:14
						reg [31:0] i;
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:137:14
						for (i = 0; i < NumPorts; i = i + 1)
							begin
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:138:11
								if (req_i[i]) begin
									begin
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:139:13
										if (we_i[i])
											// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:141:15
											begin : sv2v_autoblock_8
												// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:141:20
												reg [31:0] j;
												// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:141:20
												for (j = 0; j < BeWidth; j = j + 1)
													begin
														// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:142:17
														if (be_i[(i * BeWidth) + j])
															// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:143:19
															sram[(addr_i[i * AddrWidth+:AddrWidth] * DataWidth) + (j * ByteWidth)+:ByteWidth] <= wdata_i[(i * DataWidth) + (j * ByteWidth)+:ByteWidth];
													end
											end
										else
											// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:148:15
											r_addr_q[AddrWidth * (((i * Latency) >= +Latency ? i * Latency : ((i * Latency) + ((i * Latency) >= +Latency ? ((i * Latency) - +Latency) + 1 : (+Latency - (i * Latency)) + 1)) - 1) - (((i * Latency) >= +Latency ? ((i * Latency) - +Latency) + 1 : (+Latency - (i * Latency)) + 1) - 1))+:AddrWidth * ((i * Latency) >= +Latency ? ((i * Latency) - +Latency) + 1 : (+Latency - (i * Latency)) + 1)] <= addr_i[i * AddrWidth+:AddrWidth];
									end
								end
							end
					end
				end
		end
		else begin : genblk2
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:156:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:157:7
				if (!rst_ni) begin
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:158:9
					sram <= init_val;
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:159:9
					begin : sv2v_autoblock_9
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:159:14
						reg signed [31:0] i;
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:159:14
						for (i = 0; i < NumPorts; i = i + 1)
							begin
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:160:11
								r_addr_q[AddrWidth * (((i * Latency) >= +Latency ? i * Latency : ((i * Latency) + ((i * Latency) >= +Latency ? ((i * Latency) - +Latency) + 1 : (+Latency - (i * Latency)) + 1)) - 1) - (((i * Latency) >= +Latency ? ((i * Latency) - +Latency) + 1 : (+Latency - (i * Latency)) + 1) - 1))+:AddrWidth * ((i * Latency) >= +Latency ? ((i * Latency) - +Latency) + 1 : (+Latency - (i * Latency)) + 1)] <= {AddrWidth {1'b0}};
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:162:11
								if (Latency != 32'd0)
									// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:163:13
									begin : sv2v_autoblock_10
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:163:18
										reg [31:0] j;
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:163:18
										for (j = 0; j < Latency; j = j + 1)
											begin
												// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:164:15
												rdata_q[((i * Latency) + j) * DataWidth+:DataWidth] <= init_val[{AddrWidth {1'b0}} * DataWidth+:DataWidth];
											end
									end
							end
					end
				end
				else begin
					// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:170:9
					begin : sv2v_autoblock_11
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:170:14
						reg [31:0] i;
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:170:14
						for (i = 0; i < NumPorts; i = i + 1)
							begin
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:171:11
								if (Latency != 0)
									// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:172:13
									begin : sv2v_autoblock_12
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:172:18
										reg [31:0] j;
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:172:18
										for (j = 0; j < Latency; j = j + 1)
											begin
												// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:173:15
												rdata_q[((i * Latency) + j) * DataWidth+:DataWidth] <= rdata_d[((i * Latency) + j) * DataWidth+:DataWidth];
											end
									end
							end
					end
					begin : sv2v_autoblock_13
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:178:14
						reg [31:0] i;
						// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:178:14
						for (i = 0; i < NumPorts; i = i + 1)
							begin
								// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:179:11
								if (req_i[i]) begin
									begin
										// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:180:13
										if (we_i[i])
											// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:182:15
											begin : sv2v_autoblock_14
												// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:182:20
												reg [31:0] j;
												// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:182:20
												for (j = 0; j < BeWidth; j = j + 1)
													begin
														// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:183:17
														if (be_i[(i * BeWidth) + j])
															// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:184:19
															sram[(addr_i[i * AddrWidth+:AddrWidth] * DataWidth) + (j * ByteWidth)+:ByteWidth] <= wdata_i[(i * DataWidth) + (j * ByteWidth)+:ByteWidth];
													end
											end
										else
											// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:189:15
											r_addr_q[i * AddrWidth+:AddrWidth] <= addr_i[i * AddrWidth+:AddrWidth];
									end
								end
							end
					end
				end
		end
	endgenerate
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:201:3
	initial begin : p_assertions
		// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:202:5
	end
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:211:3
	initial begin : p_sim_hello
		// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:212:5
		if (PrintSimCfg) begin
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:213:7
			$display("#################################################################################");
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:214:7
			$display("tc_sram functional instantiated with the configuration:");
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:215:7
			$display("Instance: %m");
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:216:7
			$display("Number of ports   (dec): %0d", NumPorts);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:217:7
			$display("Number of words   (dec): %0d", NumWords);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:218:7
			$display("Address width     (dec): %0d", AddrWidth);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:219:7
			$display("Data width        (dec): %0d", DataWidth);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:220:7
			$display("Byte width        (dec): %0d", ByteWidth);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:221:7
			$display("Byte enable width (dec): %0d", BeWidth);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:222:7
			$display("Latency Cycles    (dec): %0d", Latency);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:223:7
			$display("Simulation init   (str): %0s", SimInit);
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:224:7
			$display("#################################################################################");
		end
	end
	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:227:3
	genvar _gv_i_2;
	generate
		for (_gv_i_2 = 0; _gv_i_2 < NumPorts; _gv_i_2 = _gv_i_2 + 1) begin : gen_assertions
			localparam i = _gv_i_2;
			// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:228:5
			// removed an assertion item
			// assert property (@(posedge clk_i) disable iff (!rst_ni)
			// 	(req_i[i] |-> addr_i[i] < NumWords)
			// ) else begin
			// 	// Trace: vendor/pulp-platform/tech_cells_generic/src/rtl/tc_sram.sv:230:7
			// 	$warning("Request address %0h not mapped, port %0d, expect random write or read behavior!", addr_i[i], i);
			// end
		end
	endgenerate
	initial _sv2v_0 = 0;
endmodule
