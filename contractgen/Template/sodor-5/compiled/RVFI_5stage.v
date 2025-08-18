module RVFI_5stage (
	clock,
	retire,
	instruction,
	old_regfile,
	register_wdata,
	old_pc,
	new_pc,
	mem_req,
	mem_addr,
	mem_rdata,
	mem_wdata,
	mem_we,
	mem_be,
	exception,
	rvfi_valid,
	rvfi_order,
	rvfi_insn,
	rvfi_trap,
	rvfi_halt,
	rvfi_intr,
	rvfi_mode,
	rvfi_ixl,
	rvfi_rs1_addr,
	rvfi_rs2_addr,
	rvfi_rs3_addr,
	rvfi_rs1_rdata,
	rvfi_rs2_rdata,
	rvfi_rs3_rdata,
	rvfi_rd_addr,
	rvfi_rd_wdata,
	rvfi_pc_rdata,
	rvfi_pc_wdata,
	rvfi_mem_addr,
	rvfi_mem_rmask,
	rvfi_mem_wmask,
	rvfi_mem_rdata,
	rvfi_mem_wdata
);
	// Trace: core/RVFI_5stage.v:41:2
	input clock;
	// Trace: core/RVFI_5stage.v:43:2
	input retire;
	// Trace: core/RVFI_5stage.v:45:2
	input [31:0] instruction;
	// Trace: core/RVFI_5stage.v:47:2
	input [1023:0] old_regfile;
	// Trace: core/RVFI_5stage.v:49:2
	input [31:0] register_wdata;
	// Trace: core/RVFI_5stage.v:51:2
	input [31:0] old_pc;
	// Trace: core/RVFI_5stage.v:53:2
	input [31:0] new_pc;
	// Trace: core/RVFI_5stage.v:55:2
	input mem_req;
	// Trace: core/RVFI_5stage.v:57:2
	input [31:0] mem_addr;
	// Trace: core/RVFI_5stage.v:59:2
	input [31:0] mem_rdata;
	// Trace: core/RVFI_5stage.v:61:2
	input [31:0] mem_wdata;
	// Trace: core/RVFI_5stage.v:63:2
	input mem_we;
	// Trace: core/RVFI_5stage.v:65:2
	input [2:0] mem_be;
	// Trace: core/RVFI_5stage.v:67:2
	input exception;
	// Trace: core/RVFI_5stage.v:69:2
	output reg rvfi_valid;
	// Trace: core/RVFI_5stage.v:71:2
	output reg [63:0] rvfi_order;
	// Trace: core/RVFI_5stage.v:73:2
	output reg [31:0] rvfi_insn;
	// Trace: core/RVFI_5stage.v:75:2
	output reg rvfi_trap;
	// Trace: core/RVFI_5stage.v:77:2
	output reg rvfi_halt;
	// Trace: core/RVFI_5stage.v:79:2
	output reg rvfi_intr;
	// Trace: core/RVFI_5stage.v:81:2
	output reg [1:0] rvfi_mode;
	// Trace: core/RVFI_5stage.v:83:2
	output reg [1:0] rvfi_ixl;
	// Trace: core/RVFI_5stage.v:85:2
	output reg [4:0] rvfi_rs1_addr;
	// Trace: core/RVFI_5stage.v:87:2
	output reg [4:0] rvfi_rs2_addr;
	// Trace: core/RVFI_5stage.v:89:2
	output reg [4:0] rvfi_rs3_addr;
	// Trace: core/RVFI_5stage.v:91:2
	output reg [31:0] rvfi_rs1_rdata;
	// Trace: core/RVFI_5stage.v:93:2
	output reg [31:0] rvfi_rs2_rdata;
	// Trace: core/RVFI_5stage.v:95:2
	output reg [31:0] rvfi_rs3_rdata;
	// Trace: core/RVFI_5stage.v:97:2
	output reg [4:0] rvfi_rd_addr;
	// Trace: core/RVFI_5stage.v:99:2
	output reg [31:0] rvfi_rd_wdata;
	// Trace: core/RVFI_5stage.v:101:2
	output reg [31:0] rvfi_pc_rdata;
	// Trace: core/RVFI_5stage.v:103:2
	output reg [31:0] rvfi_pc_wdata;
	// Trace: core/RVFI_5stage.v:105:2
	output reg [31:0] rvfi_mem_addr;
	// Trace: core/RVFI_5stage.v:107:2
	output reg [3:0] rvfi_mem_rmask;
	// Trace: core/RVFI_5stage.v:109:2
	output reg [3:0] rvfi_mem_wmask;
	// Trace: core/RVFI_5stage.v:111:2
	output reg [31:0] rvfi_mem_rdata;
	// Trace: core/RVFI_5stage.v:113:2
	output reg [31:0] rvfi_mem_wdata;
	// Trace: core/RVFI_5stage.v:115:2
	wire [6:0] op;
	// Trace: core/RVFI_5stage.v:117:2
	wire [2:0] funct_3;
	// Trace: core/RVFI_5stage.v:119:2
	wire [6:0] funct_7;
	// Trace: core/RVFI_5stage.v:121:2
	wire [2:0] format;
	// Trace: core/RVFI_5stage.v:123:2
	wire [31:0] imm;
	// Trace: core/RVFI_5stage.v:125:2
	wire [4:0] rs1;
	// Trace: core/RVFI_5stage.v:127:2
	wire [4:0] rs2;
	// Trace: core/RVFI_5stage.v:129:2
	wire [4:0] rd;
	// Trace: core/RVFI_5stage.v:131:2
	RISCV_Decoder RISCV_Decoder(
		.instr_i(instruction),
		.format_o(format),
		.op_o(op),
		.funct_3_o(funct_3),
		.funct_7_o(funct_7),
		.rd_o(rd),
		.rs1_o(rs1),
		.rs2_o(rs2),
		.imm_o(imm)
	);
	// Trace: core/RVFI_5stage.v:143:2
	initial begin
		// Trace: core/RVFI_5stage.v:145:3
		rvfi_valid <= 0;
		// Trace: core/RVFI_5stage.v:147:3
		rvfi_order <= 0;
		// Trace: core/RVFI_5stage.v:149:3
		rvfi_insn <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:151:3
		rvfi_trap <= 0;
		// Trace: core/RVFI_5stage.v:153:3
		rvfi_halt <= 0;
		// Trace: core/RVFI_5stage.v:155:3
		rvfi_intr <= 0;
		// Trace: core/RVFI_5stage.v:157:3
		rvfi_mode <= 2'b00;
		// Trace: core/RVFI_5stage.v:159:3
		rvfi_ixl <= 2'b00;
		// Trace: core/RVFI_5stage.v:161:3
		rvfi_rs1_addr <= 5'b00000;
		// Trace: core/RVFI_5stage.v:163:3
		rvfi_rs2_addr <= 5'b00000;
		// Trace: core/RVFI_5stage.v:165:3
		rvfi_rs3_addr <= 5'b00000;
		// Trace: core/RVFI_5stage.v:167:3
		rvfi_rs1_rdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:169:3
		rvfi_rs2_rdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:171:3
		rvfi_rs3_rdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:173:3
		rvfi_rd_addr <= 5'b00000;
		// Trace: core/RVFI_5stage.v:175:3
		rvfi_rd_wdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:177:3
		rvfi_pc_rdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:179:3
		rvfi_pc_wdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:181:3
		rvfi_mem_addr <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:183:3
		rvfi_mem_rdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:185:3
		rvfi_mem_rmask <= 4'b0000;
		// Trace: core/RVFI_5stage.v:187:3
		rvfi_mem_wdata <= 32'b00000000000000000000000000000000;
		// Trace: core/RVFI_5stage.v:189:3
		rvfi_mem_wmask <= 4'b0000;
	end
	// Trace: core/RVFI_5stage.v:192:2
	always @(posedge clock)
		if (retire == 1'b1) begin
			// Trace: core/RVFI_5stage.v:196:4
			rvfi_valid <= 1;
			// Trace: core/RVFI_5stage.v:198:4
			rvfi_order <= rvfi_order + 1;
			// Trace: core/RVFI_5stage.v:200:4
			rvfi_insn <= instruction;
			// Trace: core/RVFI_5stage.v:202:4
			rvfi_trap <= exception;
			// Trace: core/RVFI_5stage.v:204:4
			rvfi_halt <= 0;
			// Trace: core/RVFI_5stage.v:206:4
			rvfi_intr <= 0;
			// Trace: core/RVFI_5stage.v:208:4
			rvfi_mode <= 2'b00;
			// Trace: core/RVFI_5stage.v:210:4
			rvfi_ixl <= 2'b00;
			// Trace: core/RVFI_5stage.v:212:4
			rvfi_rs1_addr <= rs1;
			// Trace: core/RVFI_5stage.v:214:4
			rvfi_rs2_addr <= rs2;
			// Trace: core/RVFI_5stage.v:216:4
			rvfi_rs3_addr <= 5'b00000;
			// Trace: core/RVFI_5stage.v:218:4
			rvfi_rs1_rdata <= (rs1 == 0 ? 32'b00000000000000000000000000000000 : old_regfile[(31 - rs1) * 32+:32]);
			// Trace: core/RVFI_5stage.v:220:4
			rvfi_rs2_rdata <= (rs2 == 0 ? 32'b00000000000000000000000000000000 : old_regfile[(31 - rs2) * 32+:32]);
			// Trace: core/RVFI_5stage.v:222:4
			rvfi_rs3_rdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:224:4
			rvfi_rd_addr <= rd;
			// Trace: core/RVFI_5stage.v:226:4
			rvfi_rd_wdata <= (rd == 0 ? 32'b00000000000000000000000000000000 : register_wdata);
			// Trace: core/RVFI_5stage.v:228:4
			rvfi_pc_rdata <= old_pc;
			// Trace: core/RVFI_5stage.v:230:4
			rvfi_pc_wdata <= new_pc;
			// Trace: core/RVFI_5stage.v:232:4
			rvfi_mem_addr <= (mem_req == 0 ? 32'b00000000000000000000000000000000 : mem_addr);
			// Trace: core/RVFI_5stage.v:234:4
			rvfi_mem_rdata <= (mem_req == 0 ? 32'b00000000000000000000000000000000 : (mem_we == 1 ? 32'b00000000000000000000000000000000 : (mem_be == 0 ? 32'b00000000000000000000000000000000 : ((mem_be == 3'b001) || (mem_be == 3'b101) ? mem_rdata & 32'h000000ff : ((mem_be == 3'b010) || (mem_be == 3'b110) ? mem_rdata & 32'h0000ffff : mem_rdata)))));
			// Trace: core/RVFI_5stage.v:236:4
			rvfi_mem_rmask <= (mem_req == 0 ? 4'b0000 : (mem_we == 1 ? 4'b0000 : (mem_be == 0 ? 4'b0000 : ((mem_be == 3'b001) || (mem_be == 3'b101) ? 4'b0001 : ((mem_be == 3'b010) || (mem_be == 3'b110) ? 4'b0011 : 4'b1111)))));
			// Trace: core/RVFI_5stage.v:238:4
			rvfi_mem_wdata <= (mem_req == 0 ? 32'b00000000000000000000000000000000 : (mem_we == 0 ? 32'b00000000000000000000000000000000 : (mem_be == 0 ? 32'b00000000000000000000000000000000 : (mem_be == 3'b000 ? mem_wdata & 32'h000000ff : (mem_be == 3'b010 ? mem_wdata & 32'h0000ffff : mem_wdata)))));
			// Trace: core/RVFI_5stage.v:240:4
			rvfi_mem_wmask <= (mem_req == 0 ? 4'b0000 : (mem_we == 0 ? 4'b0000 : (mem_be == 0 ? 4'b0000 : (mem_be == 3'b001 ? 4'b0001 : (mem_be == 3'b010 ? 4'b0011 : 4'b1111)))));
		end
		else begin
			// Trace: core/RVFI_5stage.v:244:4
			rvfi_valid <= 0;
			// Trace: core/RVFI_5stage.v:246:4
			rvfi_order <= rvfi_order;
			// Trace: core/RVFI_5stage.v:248:4
			rvfi_insn <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:250:4
			rvfi_trap <= 0;
			// Trace: core/RVFI_5stage.v:252:4
			rvfi_halt <= 0;
			// Trace: core/RVFI_5stage.v:254:4
			rvfi_intr <= 0;
			// Trace: core/RVFI_5stage.v:256:4
			rvfi_mode <= 2'b00;
			// Trace: core/RVFI_5stage.v:258:4
			rvfi_ixl <= 2'b00;
			// Trace: core/RVFI_5stage.v:260:4
			rvfi_rs1_addr <= 5'b00000;
			// Trace: core/RVFI_5stage.v:262:4
			rvfi_rs2_addr <= 5'b00000;
			// Trace: core/RVFI_5stage.v:264:4
			rvfi_rs3_addr <= 5'b00000;
			// Trace: core/RVFI_5stage.v:266:4
			rvfi_rs1_rdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:268:4
			rvfi_rs2_rdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:270:4
			rvfi_rs3_rdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:272:4
			rvfi_rd_addr <= 5'b00000;
			// Trace: core/RVFI_5stage.v:274:4
			rvfi_rd_wdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:276:4
			rvfi_pc_rdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:278:4
			rvfi_pc_wdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:280:4
			rvfi_mem_addr <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:282:4
			rvfi_mem_rdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:284:4
			rvfi_mem_rmask <= 4'b0000;
			// Trace: core/RVFI_5stage.v:286:4
			rvfi_mem_wdata <= 32'b00000000000000000000000000000000;
			// Trace: core/RVFI_5stage.v:288:4
			rvfi_mem_wmask <= 4'b0000;
		end
endmodule
