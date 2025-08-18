module RegisterFile_5stage (
	clock,
	reset,
	io_rs1_addr,
	io_rs1_data,
	io_rs2_addr,
	io_rs2_data,
	io_waddr,
	io_wdata,
	io_wen,
	rvfi_regfile
);
	// Trace: core/RegisterFile_5stage.v:2:3
	input clock;
	// Trace: core/RegisterFile_5stage.v:3:3
	input reset;
	// Trace: core/RegisterFile_5stage.v:4:3
	input [4:0] io_rs1_addr;
	// Trace: core/RegisterFile_5stage.v:5:3
	output wire [31:0] io_rs1_data;
	// Trace: core/RegisterFile_5stage.v:6:3
	input [4:0] io_rs2_addr;
	// Trace: core/RegisterFile_5stage.v:7:3
	output wire [31:0] io_rs2_data;
	// Trace: core/RegisterFile_5stage.v:8:3
	input [4:0] io_waddr;
	// Trace: core/RegisterFile_5stage.v:9:3
	input [31:0] io_wdata;
	// Trace: core/RegisterFile_5stage.v:10:3
	input io_wen;
	// Trace: core/RegisterFile_5stage.v:11:3
	output reg [1023:0] rvfi_regfile;
	// Trace: core/RegisterFile_5stage.v:16:3
	reg [1023:0] regfile;
	// Trace: core/RegisterFile_5stage.v:17:3
	wire regfile_io_rs1_data_MPORT_en;
	// Trace: core/RegisterFile_5stage.v:18:3
	wire [4:0] regfile_io_rs1_data_MPORT_addr;
	// Trace: core/RegisterFile_5stage.v:19:3
	wire [31:0] regfile_io_rs1_data_MPORT_data;
	// Trace: core/RegisterFile_5stage.v:20:3
	wire regfile_io_rs2_data_MPORT_en;
	// Trace: core/RegisterFile_5stage.v:21:3
	wire [4:0] regfile_io_rs2_data_MPORT_addr;
	// Trace: core/RegisterFile_5stage.v:22:3
	wire [31:0] regfile_io_rs2_data_MPORT_data;
	// Trace: core/RegisterFile_5stage.v:23:3
	wire regfile_io_dm_rdata_MPORT_en;
	// Trace: core/RegisterFile_5stage.v:24:3
	wire [4:0] regfile_io_dm_rdata_MPORT_addr;
	// Trace: core/RegisterFile_5stage.v:25:3
	wire [31:0] regfile_io_dm_rdata_MPORT_data;
	// Trace: core/RegisterFile_5stage.v:26:3
	wire [31:0] regfile_MPORT_data;
	// Trace: core/RegisterFile_5stage.v:27:3
	wire [4:0] regfile_MPORT_addr;
	// Trace: core/RegisterFile_5stage.v:28:3
	wire regfile_MPORT_mask;
	// Trace: core/RegisterFile_5stage.v:29:3
	wire regfile_MPORT_en;
	// Trace: core/RegisterFile_5stage.v:30:3
	wire [31:0] regfile_MPORT_1_data;
	// Trace: core/RegisterFile_5stage.v:31:3
	wire [4:0] regfile_MPORT_1_addr;
	// Trace: core/RegisterFile_5stage.v:32:3
	wire regfile_MPORT_1_mask;
	// Trace: core/RegisterFile_5stage.v:33:3
	wire regfile_MPORT_1_en;
	// Trace: core/RegisterFile_5stage.v:34:3
	wire _T = io_waddr != 5'h00;
	// Trace: core/RegisterFile_5stage.v:35:3
	assign regfile_io_rs1_data_MPORT_en = 1'h1;
	// Trace: core/RegisterFile_5stage.v:36:3
	assign regfile_io_rs1_data_MPORT_addr = io_rs1_addr;
	// Trace: core/RegisterFile_5stage.v:37:3
	assign regfile_io_rs1_data_MPORT_data = regfile[(31 - regfile_io_rs1_data_MPORT_addr) * 32+:32];
	// Trace: core/RegisterFile_5stage.v:38:3
	assign regfile_io_rs2_data_MPORT_en = 1'h1;
	// Trace: core/RegisterFile_5stage.v:39:3
	assign regfile_io_rs2_data_MPORT_addr = io_rs2_addr;
	// Trace: core/RegisterFile_5stage.v:40:3
	assign regfile_io_rs2_data_MPORT_data = regfile[(31 - regfile_io_rs2_data_MPORT_addr) * 32+:32];
	// Trace: core/RegisterFile_5stage.v:41:3
	assign regfile_io_dm_rdata_MPORT_en = 1'h1;
	// Trace: core/RegisterFile_5stage.v:42:3
	assign regfile_io_dm_rdata_MPORT_addr = 5'h00;
	// Trace: core/RegisterFile_5stage.v:43:3
	assign regfile_io_dm_rdata_MPORT_data = regfile[(31 - regfile_io_dm_rdata_MPORT_addr) * 32+:32];
	// Trace: core/RegisterFile_5stage.v:44:3
	assign regfile_MPORT_data = io_wdata;
	// Trace: core/RegisterFile_5stage.v:45:3
	assign regfile_MPORT_addr = io_waddr;
	// Trace: core/RegisterFile_5stage.v:46:3
	assign regfile_MPORT_mask = 1'h1;
	// Trace: core/RegisterFile_5stage.v:47:3
	assign regfile_MPORT_en = io_wen & _T;
	// Trace: core/RegisterFile_5stage.v:48:3
	assign regfile_MPORT_1_data = 32'h00000000;
	// Trace: core/RegisterFile_5stage.v:49:3
	assign regfile_MPORT_1_addr = 5'h00;
	// Trace: core/RegisterFile_5stage.v:50:3
	assign regfile_MPORT_1_mask = 1'h1;
	// Trace: core/RegisterFile_5stage.v:51:3
	assign regfile_MPORT_1_en = 1'h0;
	// Trace: core/RegisterFile_5stage.v:52:3
	assign io_rs1_data = (io_rs1_addr != 5'h00 ? regfile_io_rs1_data_MPORT_data : 32'h00000000);
	// Trace: core/RegisterFile_5stage.v:53:3
	assign io_rs2_data = (io_rs2_addr != 5'h00 ? regfile_io_rs2_data_MPORT_data : 32'h00000000);
	// Trace: core/RegisterFile_5stage.v:54:3
	always @(posedge clock) begin
		// Trace: core/RegisterFile_5stage.v:55:5
		if (reset)
			// Trace: core/RegisterFile_5stage.v:56:7
			regfile <= 0;
		else if (regfile_MPORT_en & regfile_MPORT_mask)
			// Trace: core/RegisterFile_5stage.v:58:7
			regfile[(31 - regfile_MPORT_addr) * 32+:32] <= regfile_MPORT_data;
		if (regfile_MPORT_1_en & regfile_MPORT_1_mask)
			// Trace: core/RegisterFile_5stage.v:61:7
			regfile[(31 - regfile_MPORT_1_addr) * 32+:32] <= regfile_MPORT_1_data;
	end
	// Trace: core/RegisterFile_5stage.v:65:1
	// combined with rvfi_regfile
	// Trace: core/RegisterFile_5stage.v:66:1
	integer i;
	// Trace: core/RegisterFile_5stage.v:67:1
	always @(*)
		// Trace: core/RegisterFile_5stage.v:68:3
		for (i = 0; i < 32; i = i + 1)
			begin
				// Trace: core/RegisterFile_5stage.v:69:7
				rvfi_regfile[(31 - i) * 32+:32] = regfile[(31 - i) * 32+:32];
			end
endmodule
