module darkriscv_3stages (
	CLK,
	RES,
	HLT,
	IDATA,
	IADDR,
	DATAI,
	DATAO,
	DADDR,
	BE,
	WR,
	RD,
	IDLE,
	DEBUG,
	FLUSH,
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
	// Trace: core/darkriscv_3stages.v:61:5
	input CLK;
	// Trace: core/darkriscv_3stages.v:62:5
	input RES;
	// Trace: core/darkriscv_3stages.v:63:5
	input HLT;
	// Trace: core/darkriscv_3stages.v:69:5
	input [31:0] IDATA;
	// Trace: core/darkriscv_3stages.v:70:5
	output wire [31:0] IADDR;
	// Trace: core/darkriscv_3stages.v:72:5
	input [31:0] DATAI;
	// Trace: core/darkriscv_3stages.v:73:5
	output wire [31:0] DATAO;
	// Trace: core/darkriscv_3stages.v:74:5
	output wire [31:0] DADDR;
	// Trace: core/darkriscv_3stages.v:80:5
	output wire [3:0] BE;
	// Trace: core/darkriscv_3stages.v:81:5
	output wire WR;
	// Trace: core/darkriscv_3stages.v:82:5
	output wire RD;
	// Trace: core/darkriscv_3stages.v:85:5
	output wire IDLE;
	// Trace: core/darkriscv_3stages.v:87:5
	output wire [3:0] DEBUG;
	// Trace: core/darkriscv_3stages.v:90:5
	output reg [1:0] FLUSH;
	// Trace: core/darkriscv_3stages.v:92:4
	output wire rvfi_valid;
	// Trace: core/darkriscv_3stages.v:93:5
	output wire [63:0] rvfi_order;
	// Trace: core/darkriscv_3stages.v:94:5
	output wire [31:0] rvfi_insn;
	// Trace: core/darkriscv_3stages.v:95:5
	output wire rvfi_trap;
	// Trace: core/darkriscv_3stages.v:96:5
	output wire rvfi_halt;
	// Trace: core/darkriscv_3stages.v:97:5
	output wire rvfi_intr;
	// Trace: core/darkriscv_3stages.v:98:5
	output wire [1:0] rvfi_mode;
	// Trace: core/darkriscv_3stages.v:99:5
	output wire [1:0] rvfi_ixl;
	// Trace: core/darkriscv_3stages.v:100:5
	output wire [4:0] rvfi_rs1_addr;
	// Trace: core/darkriscv_3stages.v:101:5
	output wire [4:0] rvfi_rs2_addr;
	// Trace: core/darkriscv_3stages.v:102:5
	output wire [4:0] rvfi_rs3_addr;
	// Trace: core/darkriscv_3stages.v:103:5
	output wire [31:0] rvfi_rs1_rdata;
	// Trace: core/darkriscv_3stages.v:104:5
	output wire [31:0] rvfi_rs2_rdata;
	// Trace: core/darkriscv_3stages.v:105:5
	output wire [31:0] rvfi_rs3_rdata;
	// Trace: core/darkriscv_3stages.v:106:5
	output wire [4:0] rvfi_rd_addr;
	// Trace: core/darkriscv_3stages.v:107:5
	output wire [31:0] rvfi_rd_wdata;
	// Trace: core/darkriscv_3stages.v:108:5
	output wire [31:0] rvfi_pc_rdata;
	// Trace: core/darkriscv_3stages.v:109:5
	output wire [31:0] rvfi_pc_wdata;
	// Trace: core/darkriscv_3stages.v:110:5
	output wire [31:0] rvfi_mem_addr;
	// Trace: core/darkriscv_3stages.v:111:5
	output wire [3:0] rvfi_mem_rmask;
	// Trace: core/darkriscv_3stages.v:112:5
	output wire [3:0] rvfi_mem_wmask;
	// Trace: core/darkriscv_3stages.v:113:5
	output wire [31:0] rvfi_mem_rdata;
	// Trace: core/darkriscv_3stages.v:114:5
	output wire [31:0] rvfi_mem_wdata;
	// Trace: core/darkriscv_3stages.v:118:5
	wire [31:0] INSTR_CTR;
	// Trace: core/darkriscv_3stages.v:119:5
	wire [31:0] DATAI_CTR;
	// Trace: core/darkriscv_3stages.v:120:5
	wire [31:0] DADDR_CTR;
	// Trace: core/darkriscv_3stages.v:121:5
	wire [7:0] OPCODE_CTR = INSTR_CTR[6:0];
	wire LCC_CTR = OPCODE_CTR == 7'b0000011;
	// Trace: core/darkriscv_3stages.v:122:5
	wire SCC_CTR = OPCODE_CTR == 7'b0100011;
	// Trace: core/darkriscv_3stages.v:124:5
	// Trace: core/darkriscv_3stages.v:125:5
	reg [1023:0] REG1;
	wire [31:0] U1REG_CTR = REG1[(31 - INSTR_CTR[18:15]) * 32+:32];
	// Trace: core/darkriscv_3stages.v:126:5
	// Trace: core/darkriscv_3stages.v:127:5
	wire [31:0] ALL0 = 0;
	wire [31:0] ALL1 = -1;
	wire [31:0] SIMM_CTR = (OPCODE_CTR == 7'b0100011 ? {(INSTR_CTR[31] ? ALL1[31:12] : ALL0[31:12]), INSTR_CTR[31:25], INSTR_CTR[11:7]} : (OPCODE_CTR == 7'b1100011 ? {(INSTR_CTR[31] ? ALL1[31:13] : ALL0[31:13]), INSTR_CTR[31], INSTR_CTR[7], INSTR_CTR[30:25], INSTR_CTR[11:8], ALL0[0]} : (OPCODE_CTR == 7'b1101111 ? {(INSTR_CTR[31] ? ALL1[31:21] : ALL0[31:21]), INSTR_CTR[31], INSTR_CTR[19:12], INSTR_CTR[20], INSTR_CTR[30:21], ALL0[0]} : ((OPCODE_CTR == 7'b0110111) || (OPCODE_CTR == 7'b0010111) ? {INSTR_CTR[31:12], ALL0[11:0]} : {(INSTR_CTR[31] ? ALL1[31:12] : ALL0[31:12]), INSTR_CTR[31:20]}))));
	// Trace: core/darkriscv_3stages.v:133:5
	wire [2:0] FCT3_CTR = INSTR_CTR[14:12];
	// Trace: core/darkriscv_3stages.v:134:5
	wire [31:0] LDATA_CTR = ((FCT3_CTR == 0) || (FCT3_CTR == 4) ? (DADDR_CTR[1:0] == 3 ? {((FCT3_CTR == 0) && DATAI_CTR[31] ? ALL1[31:8] : ALL0[31:8]), DATAI_CTR[31:24]} : (DADDR_CTR[1:0] == 2 ? {((FCT3_CTR == 0) && DATAI_CTR[23] ? ALL1[31:8] : ALL0[31:8]), DATAI_CTR[23:16]} : (DADDR_CTR[1:0] == 1 ? {((FCT3_CTR == 0) && DATAI_CTR[15] ? ALL1[31:8] : ALL0[31:8]), DATAI_CTR[15:8]} : {((FCT3_CTR == 0) && DATAI_CTR[7] ? ALL1[31:8] : ALL0[31:8]), DATAI_CTR[7:0]}))) : ((FCT3_CTR == 1) || (FCT3_CTR == 5) ? (DADDR_CTR[1] == 1 ? {((FCT3_CTR == 1) && DATAI_CTR[31] ? ALL1[31:16] : ALL0[31:16]), DATAI_CTR[31:16]} : {((FCT3_CTR == 1) && DATAI_CTR[15] ? ALL1[31:16] : ALL0[31:16]), DATAI_CTR[15:0]}) : DATAI_CTR));
	// Trace: core/darkriscv_3stages.v:143:5
	wire [31:0] INSTR_PC;
	// Trace: core/darkriscv_3stages.v:144:5
	wire [31:0] DATAI_PC;
	// Trace: core/darkriscv_3stages.v:145:5
	wire [31:0] DADDR_PC;
	// Trace: core/darkriscv_3stages.v:146:5
	wire [7:0] OPCODE_PC = INSTR_PC[6:0];
	wire LCC_PC = OPCODE_PC == 7'b0000011;
	// Trace: core/darkriscv_3stages.v:147:5
	wire SCC_PC = OPCODE_PC == 7'b0100011;
	// Trace: core/darkriscv_3stages.v:148:5
	wire MCC_PC = OPCODE_PC == 7'b0010011;
	// Trace: core/darkriscv_3stages.v:149:5
	wire RCC_PC = OPCODE_PC == 7'b0110011;
	// Trace: core/darkriscv_3stages.v:151:5
	// Trace: core/darkriscv_3stages.v:152:5
	wire [31:0] U1REG_PC = REG1[(31 - INSTR_PC[18:15]) * 32+:32];
	// Trace: core/darkriscv_3stages.v:153:5
	// Trace: core/darkriscv_3stages.v:154:5
	wire [31:0] SIMM_PC = (OPCODE_PC == 7'b0100011 ? {(INSTR_PC[31] ? ALL1[31:12] : ALL0[31:12]), INSTR_PC[31:25], INSTR_PC[11:7]} : (OPCODE_PC == 7'b1100011 ? {(INSTR_PC[31] ? ALL1[31:13] : ALL0[31:13]), INSTR_PC[31], INSTR_PC[7], INSTR_PC[30:25], INSTR_PC[11:8], ALL0[0]} : (OPCODE_PC == 7'b1101111 ? {(INSTR_PC[31] ? ALL1[31:21] : ALL0[31:21]), INSTR_PC[31], INSTR_PC[19:12], INSTR_PC[20], INSTR_PC[30:21], ALL0[0]} : ((OPCODE_PC == 7'b0110111) || (OPCODE_PC == 7'b0010111) ? {INSTR_PC[31:12], ALL0[11:0]} : {(INSTR_PC[31] ? ALL1[31:12] : ALL0[31:12]), INSTR_PC[31:20]}))));
	// Trace: core/darkriscv_3stages.v:160:5
	wire [2:0] FCT3_PC = INSTR_PC[14:12];
	// Trace: core/darkriscv_3stages.v:161:5
	wire [31:0] LDATA_PC = ((FCT3_PC == 0) || (FCT3_PC == 4) ? (DADDR_PC[1:0] == 3 ? {((FCT3_PC == 0) && DATAI_PC[31] ? ALL1[31:8] : ALL0[31:8]), DATAI_PC[31:24]} : (DADDR_PC[1:0] == 2 ? {((FCT3_PC == 0) && DATAI_PC[23] ? ALL1[31:8] : ALL0[31:8]), DATAI_PC[23:16]} : (DADDR_PC[1:0] == 1 ? {((FCT3_PC == 0) && DATAI_PC[15] ? ALL1[31:8] : ALL0[31:8]), DATAI_PC[15:8]} : {((FCT3_PC == 0) && DATAI_PC[7] ? ALL1[31:8] : ALL0[31:8]), DATAI_PC[7:0]}))) : ((FCT3_PC == 1) || (FCT3_PC == 5) ? (DADDR_PC[1] == 1 ? {((FCT3_PC == 1) && DATAI_PC[31] ? ALL1[31:16] : ALL0[31:16]), DATAI_PC[31:16]} : {((FCT3_PC == 1) && DATAI_PC[15] ? ALL1[31:16] : ALL0[31:16]), DATAI_PC[15:0]}) : DATAI_PC));
	// Trace: core/darkriscv_3stages.v:173:5
	// Trace: core/darkriscv_3stages.v:174:5
	// Trace: core/darkriscv_3stages.v:184:5
	reg [31:0] XIDATA;
	// Trace: core/darkriscv_3stages.v:187:9
	reg XLUI;
	reg XAUIPC;
	reg XJAL;
	reg XJALR;
	reg XBCC;
	reg XLCC;
	reg XSCC;
	reg XMCC;
	reg XRCC;
	reg XMAC;
	reg XRES;
	// Trace: core/darkriscv_3stages.v:192:5
	reg [31:0] XSIMM;
	// Trace: core/darkriscv_3stages.v:193:5
	reg [31:0] XUIMM;
	// Trace: core/darkriscv_3stages.v:212:5
	wire [31:0] XIDATA_wire = (XRES ? 0 : (HLT ? XIDATA : (FLUSH ? 0 : IDATA)));
	// Trace: core/darkriscv_3stages.v:213:5
	wire decode = (XRES ? 0 : (HLT ? 0 : (FLUSH ? 0 : 1)));
	// Trace: core/darkriscv_3stages.v:214:5
	reg decode_reg;
	// Trace: core/darkriscv_3stages.v:215:5
	always @(posedge CLK) begin
		// Trace: core/darkriscv_3stages.v:217:9
		decode_reg <= (XRES ? 0 : (HLT ? decode_reg : (FLUSH ? 0 : 1)));
		// Trace: core/darkriscv_3stages.v:218:9
		XIDATA <= (XRES ? 0 : (HLT ? XIDATA : (FLUSH ? 0 : IDATA)));
		// Trace: core/darkriscv_3stages.v:220:9
		XLUI <= (XRES ? 0 : (HLT ? XLUI : (FLUSH ? 0 : IDATA[6:0] == 7'b0110111)));
		// Trace: core/darkriscv_3stages.v:221:9
		XAUIPC <= (XRES ? 0 : (HLT ? XAUIPC : (FLUSH ? 0 : IDATA[6:0] == 7'b0010111)));
		// Trace: core/darkriscv_3stages.v:222:9
		XJAL <= (XRES ? 0 : (HLT ? XJAL : (FLUSH ? 0 : IDATA[6:0] == 7'b1101111)));
		// Trace: core/darkriscv_3stages.v:223:9
		XJALR <= (XRES ? 0 : (HLT ? XJALR : (FLUSH ? 0 : IDATA[6:0] == 7'b1100111)));
		// Trace: core/darkriscv_3stages.v:225:9
		XBCC <= (XRES ? 0 : (HLT ? XBCC : (FLUSH ? 0 : IDATA[6:0] == 7'b1100011)));
		// Trace: core/darkriscv_3stages.v:226:9
		XLCC <= (XRES ? 0 : (HLT ? XLCC : (FLUSH ? 0 : IDATA[6:0] == 7'b0000011)));
		// Trace: core/darkriscv_3stages.v:227:9
		XSCC <= (XRES ? 0 : (HLT ? XSCC : (FLUSH ? 0 : IDATA[6:0] == 7'b0100011)));
		// Trace: core/darkriscv_3stages.v:228:9
		XMCC <= (XRES ? 0 : (HLT ? XMCC : (FLUSH ? 0 : IDATA[6:0] == 7'b0010011)));
		// Trace: core/darkriscv_3stages.v:230:9
		XRCC <= (XRES ? 0 : (HLT ? XRCC : (FLUSH ? 0 : IDATA[6:0] == 7'b0110011)));
		// Trace: core/darkriscv_3stages.v:231:9
		XMAC <= (XRES ? 0 : (HLT ? XMAC : (FLUSH ? 0 : IDATA[6:0] == 7'b1111111)));
		// Trace: core/darkriscv_3stages.v:237:9
		XSIMM <= (XRES ? 0 : (HLT ? XSIMM : (FLUSH ? 0 : (IDATA[6:0] == 7'b0100011 ? {(IDATA[31] ? ALL1[31:12] : ALL0[31:12]), IDATA[31:25], IDATA[11:7]} : (IDATA[6:0] == 7'b1100011 ? {(IDATA[31] ? ALL1[31:13] : ALL0[31:13]), IDATA[31], IDATA[7], IDATA[30:25], IDATA[11:8], ALL0[0]} : (IDATA[6:0] == 7'b1101111 ? {(IDATA[31] ? ALL1[31:21] : ALL0[31:21]), IDATA[31], IDATA[19:12], IDATA[20], IDATA[30:21], ALL0[0]} : ((IDATA[6:0] == 7'b0110111) || (IDATA[6:0] == 7'b0010111) ? {IDATA[31:12], ALL0[11:0]} : {(IDATA[31] ? ALL1[31:12] : ALL0[31:12]), IDATA[31:20]})))))));
		// Trace: core/darkriscv_3stages.v:246:9
		XUIMM <= (XRES ? 0 : (HLT ? XUIMM : (FLUSH ? 0 : (IDATA[6:0] == 7'b0100011 ? {ALL0[31:12], IDATA[31:25], IDATA[11:7]} : (IDATA[6:0] == 7'b1100011 ? {ALL0[31:13], IDATA[31], IDATA[7], IDATA[30:25], IDATA[11:8], ALL0[0]} : (IDATA[6:0] == 7'b1101111 ? {ALL0[31:21], IDATA[31], IDATA[19:12], IDATA[20], IDATA[30:21], ALL0[0]} : ((IDATA[6:0] == 7'b0110111) || (IDATA[6:0] == 7'b0010111) ? {IDATA[31:12], ALL0[11:0]} : {ALL0[31:12], IDATA[31:20]})))))));
	end
	// Trace: core/darkriscv_3stages.v:256:2
	wire legal;
	// Trace: core/darkriscv_3stages.v:257:2
	assign legal = !decode_reg || ((((((((XLUI || XAUIPC) || XJAL) || (XJALR && (XIDATA[14:12] == 3'b000))) || (XBCC && ((((((XIDATA[14:12] == 3'b000) || (XIDATA[14:12] == 3'b001)) || (XIDATA[14:12] == 3'b100)) || (XIDATA[14:12] == 3'b101)) || (XIDATA[14:12] == 3'b110)) || (XIDATA[14:12] == 3'b111)))) || (XLCC && (((((XIDATA[14:12] == 3'b000) || (XIDATA[14:12] == 3'b001)) || (XIDATA[14:12] == 3'b100)) || (XIDATA[14:12] == 3'b010)) || (XIDATA[14:12] == 3'b101)))) || (XSCC && (((XIDATA[14:12] == 3'b000) || (XIDATA[14:12] == 3'b001)) || (XIDATA[14:12] == 3'b010)))) || (XRCC && (((((XIDATA[14:12] == 3'b000) && (XIDATA[31:25] == 7'b0000000)) || ((XIDATA[14:12] == 3'b000) && (XIDATA[31:25] == 7'b0100000))) || ((XIDATA[14:12] == 3'b101) && (XIDATA[31:25] == 7'b0100000))) || ((XIDATA[14:12] == 3'b101) && (XIDATA[31:25] == 7'b0100000))))) || (XMCC && ((((XIDATA[14:12] == 3'b001) && (XIDATA[31:25] == 7'b0000000)) || ((XIDATA[14:12] == 3'b101) && (XIDATA[31:25] == 7'b0100000))) || ((XIDATA[14:12] == 3'b101) && (XIDATA[31:25] == 7'b0000000)))));
	// Trace: core/darkriscv_3stages.v:309:13
	reg [4:0] RESMODE;
	// Trace: core/darkriscv_3stages.v:314:9
	wire [4:0] DPTR = (XRES ? RESMODE : XIDATA[11:7]);
	// Trace: core/darkriscv_3stages.v:315:9
	wire [4:0] S1PTR = XIDATA[19:15];
	// Trace: core/darkriscv_3stages.v:316:9
	wire [4:0] S2PTR = XIDATA[24:20];
	// Trace: core/darkriscv_3stages.v:320:5
	wire [6:0] OPCODE = (FLUSH ? 0 : XIDATA[6:0]);
	// Trace: core/darkriscv_3stages.v:321:5
	wire [2:0] FCT3 = XIDATA[14:12];
	// Trace: core/darkriscv_3stages.v:322:5
	wire [6:0] FCT7 = XIDATA[31:25];
	// Trace: core/darkriscv_3stages.v:324:5
	wire [31:0] SIMM = XSIMM;
	// Trace: core/darkriscv_3stages.v:325:5
	wire [31:0] UIMM = XUIMM;
	// Trace: core/darkriscv_3stages.v:329:5
	wire LUI = (FLUSH ? 0 : XLUI);
	// Trace: core/darkriscv_3stages.v:330:5
	wire AUIPC = (FLUSH ? 0 : XAUIPC);
	// Trace: core/darkriscv_3stages.v:331:5
	wire JAL = (FLUSH ? 0 : XJAL);
	// Trace: core/darkriscv_3stages.v:332:5
	wire JALR = (FLUSH ? 0 : XJALR);
	// Trace: core/darkriscv_3stages.v:334:5
	wire BCC = (FLUSH ? 0 : XBCC);
	// Trace: core/darkriscv_3stages.v:335:5
	wire LCC = (FLUSH ? 0 : XLCC);
	// Trace: core/darkriscv_3stages.v:336:5
	wire SCC = (FLUSH ? 0 : XSCC);
	// Trace: core/darkriscv_3stages.v:337:5
	wire MCC = (FLUSH ? 0 : XMCC);
	// Trace: core/darkriscv_3stages.v:339:5
	wire RCC = (FLUSH ? 0 : XRCC);
	// Trace: core/darkriscv_3stages.v:340:5
	wire MAC = (FLUSH ? 0 : XMAC);
	// Trace: core/darkriscv_3stages.v:358:9
	reg [31:0] NXPC2;
	// Trace: core/darkriscv_3stages.v:381:9
	// Trace: core/darkriscv_3stages.v:382:9
	reg [31:0] REG2 [0:31];
	// Trace: core/darkriscv_3stages.v:395:5
	reg [31:0] NXPC;
	// Trace: core/darkriscv_3stages.v:396:5
	reg [31:0] PC;
	// Trace: core/darkriscv_3stages.v:407:5
	wire [31:0] U1REG = REG1[(31 - S1PTR) * 32+:32];
	// Trace: core/darkriscv_3stages.v:408:5
	wire [31:0] U2REG = REG1[(31 - S2PTR) * 32+:32];
	// Trace: core/darkriscv_3stages.v:410:5
	wire signed [31:0] S1REG = U1REG;
	// Trace: core/darkriscv_3stages.v:411:5
	wire signed [31:0] S2REG = U2REG;
	// Trace: core/darkriscv_3stages.v:422:5
	wire [31:0] LDATA = ((FCT3 == 0) || (FCT3 == 4) ? (DADDR[1:0] == 3 ? {((FCT3 == 0) && DATAI[31] ? ALL1[31:8] : ALL0[31:8]), DATAI[31:24]} : (DADDR[1:0] == 2 ? {((FCT3 == 0) && DATAI[23] ? ALL1[31:8] : ALL0[31:8]), DATAI[23:16]} : (DADDR[1:0] == 1 ? {((FCT3 == 0) && DATAI[15] ? ALL1[31:8] : ALL0[31:8]), DATAI[15:8]} : {((FCT3 == 0) && DATAI[7] ? ALL1[31:8] : ALL0[31:8]), DATAI[7:0]}))) : ((FCT3 == 1) || (FCT3 == 5) ? (DADDR[1] == 1 ? {((FCT3 == 1) && DATAI[31] ? ALL1[31:16] : ALL0[31:16]), DATAI[31:16]} : {((FCT3 == 1) && DATAI[15] ? ALL1[31:16] : ALL0[31:16]), DATAI[15:0]}) : DATAI));
	// Trace: core/darkriscv_3stages.v:439:5
	wire [31:0] SDATA = (FCT3 == 0 ? (DADDR[1:0] == 3 ? {U2REG[7:0], ALL0[23:0]} : (DADDR[1:0] == 2 ? {ALL0[31:24], U2REG[7:0], ALL0[15:0]} : (DADDR[1:0] == 1 ? {ALL0[31:16], U2REG[7:0], ALL0[7:0]} : {ALL0[31:8], U2REG[7:0]}))) : (FCT3 == 1 ? (DADDR[1] == 1 ? {U2REG[15:0], ALL0[15:0]} : {ALL0[31:16], U2REG[15:0]}) : U2REG));
	// Trace: core/darkriscv_3stages.v:450:5
	wire [31:0] CDATA = 0;
	// Trace: core/darkriscv_3stages.v:454:5
	wire signed [31:0] S2REGX = (XMCC ? SIMM : S2REG);
	// Trace: core/darkriscv_3stages.v:455:5
	wire [31:0] U2REGX = (XMCC ? UIMM : U2REG);
	// Trace: core/darkriscv_3stages.v:457:5
	wire [31:0] RMDATA = (FCT3 == 7 ? U1REG & S2REGX : (FCT3 == 6 ? U1REG | S2REGX : (FCT3 == 4 ? U1REG ^ S2REGX : (FCT3 == 3 ? (U1REG < U2REGX ? 1 : 0) : (FCT3 == 2 ? (S1REG < S2REGX ? 1 : 0) : (FCT3 == 0 ? (XRCC && FCT7[5] ? U1REG - U2REGX : U1REG + S2REGX) : (FCT3 == 1 ? U1REG << U2REGX[4:0] : (!FCT7[5] ? U1REG >> U2REGX[4:0] : $signed(S1REG >>> U2REGX[4:0])))))))));
	// Trace: core/darkriscv_3stages.v:490:5
	wire BMUX = (BCC == 1) && (FCT3 == 4 ? S1REG < S2REGX : (FCT3 == 5 ? S1REG >= S2REG : (FCT3 == 6 ? U1REG < U2REGX : (FCT3 == 7 ? U1REG >= U2REG : (FCT3 == 0 ? !(U1REG ^ S2REGX) : U1REG ^ S2REGX)))));
	// Trace: core/darkriscv_3stages.v:499:5
	wire [31:0] PCSIMM = PC + SIMM;
	// Trace: core/darkriscv_3stages.v:500:5
	wire JREQ = (JAL || JALR) || BMUX;
	// Trace: core/darkriscv_3stages.v:501:5
	wire [31:0] JVAL = SIMM + (JALR ? U1REG : PC);
	// Trace: core/darkriscv_3stages.v:504:5
	wire [31:0] XIDATA_next = (FLUSH ? 0 : XIDATA);
	// Trace: core/darkriscv_3stages.v:505:5
	reg writeback_reg;
	// Trace: core/darkriscv_3stages.v:506:5
	wire writeback = (XRES ? 0 : (HLT ? 0 : 1));
	// Trace: core/darkriscv_3stages.v:518:5
	wire filter_pc_reg = decode_reg || !FLUSH;
	// Trace: core/darkriscv_3stages.v:519:5
	wire [1:0] FLUSH_wire = (XRES ? 2 : (HLT ? FLUSH : (FLUSH ? FLUSH - 1 : ((JAL || JALR) || BMUX ? 2 : 0))));
	wire filter_pc = decode || !FLUSH_wire;
	// Trace: core/darkriscv_3stages.v:520:5
	// Trace: core/darkriscv_3stages.v:524:5
	reg [31:0] DelayU1REG;
	// Trace: core/darkriscv_3stages.v:525:5
	reg DelayBCC;
	// Trace: core/darkriscv_3stages.v:526:5
	reg [31:0] DelayU2REG;
	// Trace: core/darkriscv_3stages.v:527:5
	reg DelayJALR;
	// Trace: core/darkriscv_3stages.v:528:5
	reg [31:0] DelayLDATA;
	// Trace: core/darkriscv_3stages.v:529:5
	reg DelayLCC;
	// Trace: core/darkriscv_3stages.v:530:5
	reg [31:0] DelayDADDR;
	// Trace: core/darkriscv_3stages.v:531:5
	reg DelaySCC;
	// Trace: core/darkriscv_3stages.v:532:5
	reg [31:0] DelayXIDATA_next;
	// Trace: core/darkriscv_3stages.v:534:5
	reg [31:0] PC_retire;
	// Trace: core/darkriscv_3stages.v:538:5
	wire [31:0] PC_flush = (FLUSH ? 0 : PC);
	// Trace: core/darkriscv_3stages.v:541:5
	always @(posedge CLK) begin
		// Trace: core/darkriscv_3stages.v:544:9
		PC_retire <= (HLT ? PC_retire : (FLUSH ? PC_retire : PC));
		// Trace: core/darkriscv_3stages.v:546:9
		DelayLDATA <= (HLT ? DelayLDATA : LDATA);
		// Trace: core/darkriscv_3stages.v:547:9
		DelayLCC <= (HLT ? DelayLCC : LCC);
		// Trace: core/darkriscv_3stages.v:548:9
		DelayDADDR <= (HLT ? DelayDADDR : DADDR);
		// Trace: core/darkriscv_3stages.v:549:9
		DelaySCC <= (HLT ? DelaySCC : SCC);
		// Trace: core/darkriscv_3stages.v:550:9
		DelayXIDATA_next <= (HLT ? DelayXIDATA_next : XIDATA_next);
		// Trace: core/darkriscv_3stages.v:551:9
		DelayU1REG <= (HLT ? DelayU1REG : U1REG);
		// Trace: core/darkriscv_3stages.v:552:9
		DelayBCC <= (HLT ? DelayBCC : BCC);
		// Trace: core/darkriscv_3stages.v:553:9
		DelayU2REG <= (HLT ? DelayU2REG : U2REG);
		// Trace: core/darkriscv_3stages.v:554:9
		DelayJALR <= (HLT ? DelayJALR : JALR);
		// Trace: core/darkriscv_3stages.v:556:9
		writeback_reg <= (XRES ? 0 : (HLT ? 0 : 1));
		// Trace: core/darkriscv_3stages.v:568:9
		RESMODE <= (RES ? -1 : (RESMODE ? RESMODE - 1 : 0));
		// Trace: core/darkriscv_3stages.v:570:9
		XRES <= |RESMODE;
		// Trace: core/darkriscv_3stages.v:573:6
		FLUSH <= (XRES ? 2 : (HLT ? FLUSH : (FLUSH ? FLUSH - 1 : ((JAL || JALR) || BMUX ? 2 : 0))));
		// Trace: core/darkriscv_3stages.v:581:1
		REG1[(31 - DPTR) * 32+:32] <= (XRES ? (RESMODE[4:0] == 2 ? 32'd0 : 0) : (HLT ? REG1[(31 - DPTR) * 32+:32] : (!DPTR ? 0 : (AUIPC ? PCSIMM : (JAL || JALR ? NXPC : (LUI ? SIMM : (LCC ? LDATA : (MCC || RCC ? RMDATA : REG1[(31 - DPTR) * 32+:32]))))))));
		// Trace: core/darkriscv_3stages.v:583:1
		REG2[DPTR] <= (XRES ? (RESMODE[4:0] == 2 ? 32'd0 : 0) : (HLT ? REG2[DPTR] : (!DPTR ? 0 : (AUIPC ? PCSIMM : (JAL || JALR ? NXPC : (LUI ? SIMM : (LCC ? LDATA : (MCC || RCC ? RMDATA : REG2[DPTR]))))))));
		// Trace: core/darkriscv_3stages.v:601:9
		NXPC <= (HLT ? NXPC : (FLUSH ? NXPC : NXPC2));
		// Trace: core/darkriscv_3stages.v:603:6
		NXPC2 <= (XRES ? 32'd0 : (HLT ? NXPC2 : (JREQ ? JVAL : NXPC2 + 4)));
		// Trace: core/darkriscv_3stages.v:614:9
		PC <= (HLT ? PC : (FLUSH ? PC : NXPC));
	end
	// Trace: core/darkriscv_3stages.v:620:5
	assign DATAO = (SCC ? SDATA : 0);
	// Trace: core/darkriscv_3stages.v:621:5
	assign DADDR = (SCC || LCC ? U1REG + SIMM : 0);
	// Trace: core/darkriscv_3stages.v:631:5
	assign RD = LCC;
	// Trace: core/darkriscv_3stages.v:632:5
	assign WR = SCC;
	// Trace: core/darkriscv_3stages.v:633:5
	assign BE = ((FCT3 == 0) || (FCT3 == 4) ? (DADDR[1:0] == 3 ? 4'b1000 : (DADDR[1:0] == 2 ? 4'b0100 : (DADDR[1:0] == 1 ? 4'b0010 : 4'b0001))) : ((FCT3 == 1) || (FCT3 == 5) ? (DADDR[1] == 1 ? 4'b1100 : 4'b0011) : 4'b1111));
	// Trace: core/darkriscv_3stages.v:646:9
	assign IADDR = NXPC2;
	// Trace: core/darkriscv_3stages.v:652:5
	assign IDLE = |FLUSH;
	// Trace: core/darkriscv_3stages.v:654:5
	assign DEBUG = {XRES, |FLUSH, SCC, LCC};
	// Trace: core/darkriscv_3stages.v:658:2
	reg [1023:0] rvfi_regfile;
	// Trace: core/darkriscv_3stages.v:660:2
	wire retire_wire;
	always @(*)
		if (retire_wire || XRES) begin
			// Trace: core/darkriscv_3stages.v:662:4
			rvfi_regfile = REG1;
			// Trace: core/darkriscv_3stages.v:663:4
			rvfi_regfile[(31 - DPTR) * 32+:32] = (XRES ? (RESMODE[4:0] == 2 ? 32'd0 : 0) : (HLT ? REG1[(31 - DPTR) * 32+:32] : (!DPTR ? 0 : (AUIPC ? PCSIMM : (JAL || JALR ? NXPC : (LUI ? SIMM : (LCC ? LDATA : (MCC || RCC ? RMDATA : REG1[(31 - DPTR) * 32+:32]))))))));
		end
	// Trace: core/darkriscv_3stages.v:665:2
	// Trace: core/darkriscv_3stages.v:667:2
	reg flushed = 0;
	// Trace: core/darkriscv_3stages.v:668:2
	reg [2:0] resetted = 0;
	// Trace: core/darkriscv_3stages.v:669:2
	assign retire_wire = ((HLT | flushed) | FLUSH ? 0 : (XRES || |resetted ? 0 : 1));
	// Trace: core/darkriscv_3stages.v:671:2
	wire retire;
	// Trace: core/darkriscv_3stages.v:673:2
	assign retire = rvfi_valid;
	// Trace: core/darkriscv_3stages.v:676:2
	always @(posedge CLK)
		if (FLUSH)
			// Trace: core/darkriscv_3stages.v:680:4
			flushed <= 1;
		else
			// Trace: core/darkriscv_3stages.v:683:4
			flushed <= 0;
	// Trace: core/darkriscv_3stages.v:686:2
	always @(posedge CLK)
		// Trace: core/darkriscv_3stages.v:699:3
		resetted <= (XRES ? 5 : (resetted ? resetted - 1 : 0));
	// Trace: core/darkriscv_3stages.v:701:2
	reg [31:0] stalled_instruction = 32'b00000000000000000000000000000000;
	// Trace: core/darkriscv_3stages.v:703:2
	always @(posedge CLK)
		if (RES)
			// Trace: core/darkriscv_3stages.v:707:4
			stalled_instruction <= 32'b00000000000000000000000000000000;
		else
			// Trace: core/darkriscv_3stages.v:710:4
			stalled_instruction <= (!retire_wire ? stalled_instruction : XIDATA);
	// Trace: core/darkriscv_3stages.v:712:2
	wire [31:0] instruction;
	// Trace: core/darkriscv_3stages.v:714:2
	assign instruction = (!retire_wire ? stalled_instruction : XIDATA);
	// Trace: core/darkriscv_3stages.v:716:2
	reg [1023:0] old_regfile;
	// Trace: core/darkriscv_3stages.v:718:2
	always @(posedge CLK)
		if (RES)
			// Trace: core/darkriscv_3stages.v:722:4
			old_regfile <= 0;
		else if (retire_wire || XRES)
			// Trace: core/darkriscv_3stages.v:727:5
			old_regfile <= rvfi_regfile;
	// Trace: core/darkriscv_3stages.v:729:2
	reg [31:0] old_pc;
	// Trace: core/darkriscv_3stages.v:731:2
	reg [31:0] next_pc;
	// Trace: core/darkriscv_3stages.v:733:2
	wire [31:0] pc_wdata = (FLUSH ? JVAL : NXPC);
	// Trace: core/darkriscv_3stages.v:734:2
	always @(posedge CLK)
		if (RES)
			// Trace: core/darkriscv_3stages.v:738:4
			old_pc <= 4;
		else if (retire_wire)
			// Trace: core/darkriscv_3stages.v:743:5
			old_pc <= pc_wdata;
	// Trace: core/darkriscv_3stages.v:746:2
	always @(posedge CLK)
		// Trace: core/darkriscv_3stages.v:748:3
		next_pc <= NXPC;
	// Trace: core/darkriscv_3stages.v:751:2
	reg mem_req = 0;
	// Trace: core/darkriscv_3stages.v:753:2
	reg [31:0] mem_addr1 = 32'b00000000000000000000000000000000;
	// Trace: core/darkriscv_3stages.v:755:2
	reg [31:0] mem_rdata = 32'b00000000000000000000000000000000;
	// Trace: core/darkriscv_3stages.v:757:2
	reg [31:0] mem_wdata = 32'b00000000000000000000000000000000;
	// Trace: core/darkriscv_3stages.v:759:2
	reg mem_we = 0;
	// Trace: core/darkriscv_3stages.v:761:2
	reg [3:0] mem_be = 4'b0000;
	// Trace: core/darkriscv_3stages.v:763:2
	always @(*)
		if (RES) begin
			// Trace: core/darkriscv_3stages.v:767:4
			mem_req = 0;
			// Trace: core/darkriscv_3stages.v:769:4
			mem_addr1 = 32'b00000000000000000000000000000000;
			// Trace: core/darkriscv_3stages.v:771:4
			mem_rdata = 32'b00000000000000000000000000000000;
			// Trace: core/darkriscv_3stages.v:773:4
			mem_wdata = 32'b00000000000000000000000000000000;
			// Trace: core/darkriscv_3stages.v:775:4
			mem_we = 0;
			// Trace: core/darkriscv_3stages.v:777:4
			mem_be = 4'b0000;
		end
		else begin
			// Trace: core/darkriscv_3stages.v:781:4
			mem_req = WR || RD;
			// Trace: core/darkriscv_3stages.v:783:4
			mem_addr1 = DADDR;
			// Trace: core/darkriscv_3stages.v:785:4
			mem_rdata = DATAI;
			// Trace: core/darkriscv_3stages.v:787:4
			mem_wdata = DATAO;
			// Trace: core/darkriscv_3stages.v:789:4
			mem_we = WR;
			// Trace: core/darkriscv_3stages.v:791:4
			mem_be = BE;
		end
	// Trace: core/darkriscv_3stages.v:794:2
	RVFI_3stage RVFI_3stage(
		.clock(CLK),
		.retire(retire_wire),
		.instruction(instruction),
		.old_regfile(old_regfile),
		.new_regfile(rvfi_regfile),
		.old_pc(old_pc),
		.new_pc(pc_wdata),
		.mem_req(mem_req),
		.mem_addr(mem_addr1),
		.mem_rdata(mem_rdata),
		.mem_wdata(mem_wdata),
		.mem_we(mem_we),
		.mem_be(mem_be),
		.rvfi_valid(rvfi_valid),
		.rvfi_order(rvfi_order),
		.rvfi_insn(rvfi_insn),
		.rvfi_trap(rvfi_trap),
		.rvfi_halt(rvfi_halt),
		.rvfi_intr(rvfi_intr),
		.rvfi_mode(rvfi_mode),
		.rvfi_ixl(rvfi_ixl),
		.rvfi_rs1_addr(rvfi_rs1_addr),
		.rvfi_rs2_addr(rvfi_rs2_addr),
		.rvfi_rs3_addr(rvfi_rs3_addr),
		.rvfi_rs1_rdata(rvfi_rs1_rdata),
		.rvfi_rs2_rdata(rvfi_rs2_rdata),
		.rvfi_rs3_rdata(rvfi_rs3_rdata),
		.rvfi_rd_addr(rvfi_rd_addr),
		.rvfi_rd_wdata(rvfi_rd_wdata),
		.rvfi_pc_rdata(rvfi_pc_rdata),
		.rvfi_pc_wdata(rvfi_pc_wdata),
		.rvfi_mem_addr(rvfi_mem_addr),
		.rvfi_mem_rmask(rvfi_mem_rmask),
		.rvfi_mem_wmask(rvfi_mem_wmask),
		.rvfi_mem_rdata(rvfi_mem_rdata),
		.rvfi_mem_wdata(rvfi_mem_wdata)
	);
	// Trace: core/darkriscv_3stages.v:833:2
	wire rvfi_lui_ctr;
	// Trace: core/darkriscv_3stages.v:835:2
	assign rvfi_lui_ctr = rvfi_insn[6:0] == 7'h37;
	// Trace: core/darkriscv_3stages.v:837:2
	wire rvfi_auipc_ctr;
	// Trace: core/darkriscv_3stages.v:839:2
	assign rvfi_auipc_ctr = rvfi_insn[6:0] == 7'h17;
	// Trace: core/darkriscv_3stages.v:841:2
	wire rvfi_jal_ctr;
	// Trace: core/darkriscv_3stages.v:843:2
	assign rvfi_jal_ctr = rvfi_insn[6:0] == 7'h6f;
	// Trace: core/darkriscv_3stages.v:845:2
	wire rvfi_jalr_ctr;
	// Trace: core/darkriscv_3stages.v:847:2
	assign rvfi_jalr_ctr = (rvfi_insn[6:0] == 7'h67) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/darkriscv_3stages.v:849:2
	wire rvfi_beq_ctr;
	// Trace: core/darkriscv_3stages.v:851:2
	assign rvfi_beq_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/darkriscv_3stages.v:853:2
	wire rvfi_bge_ctr;
	// Trace: core/darkriscv_3stages.v:855:2
	assign rvfi_bge_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b101);
	// Trace: core/darkriscv_3stages.v:857:2
	wire rvfi_bgeu_ctr;
	// Trace: core/darkriscv_3stages.v:859:2
	assign rvfi_bgeu_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b111);
	// Trace: core/darkriscv_3stages.v:861:2
	wire rvfi_bltu_ctr;
	// Trace: core/darkriscv_3stages.v:863:2
	assign rvfi_bltu_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b110);
	// Trace: core/darkriscv_3stages.v:865:2
	wire rvfi_blt_ctr;
	// Trace: core/darkriscv_3stages.v:867:2
	assign rvfi_blt_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/darkriscv_3stages.v:869:2
	wire rvfi_bne_ctr;
	// Trace: core/darkriscv_3stages.v:871:2
	assign rvfi_bne_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/darkriscv_3stages.v:873:2
	wire rvfi_lb_ctr;
	// Trace: core/darkriscv_3stages.v:875:2
	assign rvfi_lb_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/darkriscv_3stages.v:877:2
	wire rvfi_lh_ctr;
	// Trace: core/darkriscv_3stages.v:879:2
	assign rvfi_lh_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/darkriscv_3stages.v:881:2
	wire rvfi_lhu_ctr;
	// Trace: core/darkriscv_3stages.v:883:2
	assign rvfi_lhu_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b101);
	// Trace: core/darkriscv_3stages.v:885:2
	wire rvfi_lbu_ctr;
	// Trace: core/darkriscv_3stages.v:887:2
	assign rvfi_lbu_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/darkriscv_3stages.v:889:2
	wire rvfi_lw_ctr;
	// Trace: core/darkriscv_3stages.v:891:2
	assign rvfi_lw_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/darkriscv_3stages.v:893:2
	wire rvfi_sb_ctr;
	// Trace: core/darkriscv_3stages.v:895:2
	assign rvfi_sb_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/darkriscv_3stages.v:897:2
	wire rvfi_sw_ctr;
	// Trace: core/darkriscv_3stages.v:899:2
	assign rvfi_sw_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/darkriscv_3stages.v:901:2
	wire rvfi_sh_ctr;
	// Trace: core/darkriscv_3stages.v:903:2
	assign rvfi_sh_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/darkriscv_3stages.v:905:2
	wire rvfi_addi_ctr;
	// Trace: core/darkriscv_3stages.v:907:2
	assign rvfi_addi_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/darkriscv_3stages.v:909:2
	wire rvfi_slti_ctr;
	// Trace: core/darkriscv_3stages.v:911:2
	assign rvfi_slti_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/darkriscv_3stages.v:913:2
	wire rvfi_sltiu_ctr;
	// Trace: core/darkriscv_3stages.v:915:2
	assign rvfi_sltiu_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b011);
	// Trace: core/darkriscv_3stages.v:917:2
	wire rvfi_xori_ctr;
	// Trace: core/darkriscv_3stages.v:919:2
	assign rvfi_xori_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/darkriscv_3stages.v:921:2
	wire rvfi_ori_ctr;
	// Trace: core/darkriscv_3stages.v:923:2
	assign rvfi_ori_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b110);
	// Trace: core/darkriscv_3stages.v:925:2
	wire rvfi_andi_ctr;
	// Trace: core/darkriscv_3stages.v:927:2
	assign rvfi_andi_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b111);
	// Trace: core/darkriscv_3stages.v:929:2
	wire rvfi_slli_ctr;
	// Trace: core/darkriscv_3stages.v:931:2
	assign rvfi_slli_ctr = ((rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b001)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:933:2
	wire rvfi_srli_ctr;
	// Trace: core/darkriscv_3stages.v:935:2
	assign rvfi_srli_ctr = ((rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:937:2
	wire rvfi_srai_ctr;
	// Trace: core/darkriscv_3stages.v:939:2
	assign rvfi_srai_ctr = ((rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0100000);
	// Trace: core/darkriscv_3stages.v:941:2
	wire rvfi_add_ctr;
	// Trace: core/darkriscv_3stages.v:943:2
	assign rvfi_add_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b000)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:945:2
	wire rvfi_sub_ctr;
	// Trace: core/darkriscv_3stages.v:947:2
	assign rvfi_sub_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b000)) && (rvfi_insn[31:25] == 7'b0100000);
	// Trace: core/darkriscv_3stages.v:949:2
	wire rvfi_sll_ctr;
	// Trace: core/darkriscv_3stages.v:951:2
	assign rvfi_sll_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b001)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:953:2
	wire rvfi_slt_ctr;
	// Trace: core/darkriscv_3stages.v:955:2
	assign rvfi_slt_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b010)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:957:2
	wire rvfi_sltu_ctr;
	// Trace: core/darkriscv_3stages.v:959:2
	assign rvfi_sltu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b011)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:961:2
	wire rvfi_xor_ctr;
	// Trace: core/darkriscv_3stages.v:963:2
	assign rvfi_xor_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b100)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:965:2
	wire rvfi_srl_ctr;
	// Trace: core/darkriscv_3stages.v:967:2
	assign rvfi_srl_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:969:2
	wire rvfi_sra_ctr;
	// Trace: core/darkriscv_3stages.v:971:2
	assign rvfi_sra_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0100000);
	// Trace: core/darkriscv_3stages.v:973:2
	wire rvfi_or_ctr;
	// Trace: core/darkriscv_3stages.v:975:2
	assign rvfi_or_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b110)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:977:2
	wire rvfi_and_ctr;
	// Trace: core/darkriscv_3stages.v:979:2
	assign rvfi_and_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b111)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/darkriscv_3stages.v:981:2
	wire rvfi_mul_ctr;
	// Trace: core/darkriscv_3stages.v:983:2
	assign rvfi_mul_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/darkriscv_3stages.v:985:2
	wire rvfi_mulh_ctr;
	// Trace: core/darkriscv_3stages.v:987:2
	assign rvfi_mulh_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/darkriscv_3stages.v:989:2
	wire rvfi_mulhsu_ctr;
	// Trace: core/darkriscv_3stages.v:991:2
	assign rvfi_mulhsu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/darkriscv_3stages.v:993:2
	wire rvfi_mulhu_ctr;
	// Trace: core/darkriscv_3stages.v:995:2
	assign rvfi_mulhu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b011);
	// Trace: core/darkriscv_3stages.v:997:2
	wire rvfi_div_ctr;
	// Trace: core/darkriscv_3stages.v:999:2
	assign rvfi_div_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/darkriscv_3stages.v:1001:2
	wire rvfi_divu_ctr;
	// Trace: core/darkriscv_3stages.v:1003:2
	assign rvfi_divu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b101);
	// Trace: core/darkriscv_3stages.v:1005:2
	wire rvfi_rem_ctr;
	// Trace: core/darkriscv_3stages.v:1007:2
	assign rvfi_rem_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b110);
	// Trace: core/darkriscv_3stages.v:1009:2
	wire rvfi_remu_ctr;
	// Trace: core/darkriscv_3stages.v:1011:2
	assign rvfi_remu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b111);
	// Trace: core/darkriscv_3stages.v:1013:2
	wire [4:0] rs1;
	// Trace: core/darkriscv_3stages.v:1015:2
	wire [4:0] rs2;
	// Trace: core/darkriscv_3stages.v:1017:2
	wire [4:0] rd;
	// Trace: core/darkriscv_3stages.v:1019:2
	wire [6:0] opcode;
	// Trace: core/darkriscv_3stages.v:1021:2
	wire [31:0] imm;
	// Trace: core/darkriscv_3stages.v:1023:2
	wire [2:0] format;
	// Trace: core/darkriscv_3stages.v:1025:2
	wire [2:0] funct3;
	// Trace: core/darkriscv_3stages.v:1027:2
	wire [6:0] funct7;
	// Trace: core/darkriscv_3stages.v:1029:2
	RISCV_Decoder ctr_decode(
		.instr_i(rvfi_insn),
		.format_o(format),
		.op_o(opcode),
		.funct_3_o(funct3),
		.funct_7_o(funct7),
		.rd_o(rd),
		.rs1_o(rs1),
		.rs2_o(rs2),
		.imm_o(imm)
	);
	// Trace: core/darkriscv_3stages.v:1041:2
	wire [31:0] new_pc;
	// Trace: core/darkriscv_3stages.v:1043:2
	assign new_pc = rvfi_pc_wdata;
	// Trace: core/darkriscv_3stages.v:1045:2
	wire is_branch;
	// Trace: core/darkriscv_3stages.v:1047:2
	assign is_branch = ((((((rvfi_beq_ctr || rvfi_bge_ctr) || rvfi_bgeu_ctr) || rvfi_bltu_ctr) || rvfi_blt_ctr) || rvfi_bne_ctr) || rvfi_jal_ctr) || rvfi_jalr_ctr;
	// Trace: core/darkriscv_3stages.v:1049:2
	wire [31:0] reg_rd;
	// Trace: core/darkriscv_3stages.v:1051:2
	assign reg_rd = rvfi_rd_wdata;
	// Trace: core/darkriscv_3stages.v:1053:2
	wire [31:0] reg_rs1;
	// Trace: core/darkriscv_3stages.v:1055:2
	assign reg_rs1 = rvfi_rs1_rdata;
	// Trace: core/darkriscv_3stages.v:1057:2
	wire [31:0] reg_rs2;
	// Trace: core/darkriscv_3stages.v:1059:2
	assign reg_rs2 = rvfi_rs2_rdata;
	// Trace: core/darkriscv_3stages.v:1061:2
	wire reg_rs1_zero;
	// Trace: core/darkriscv_3stages.v:1063:2
	assign reg_rs1_zero = rvfi_rs1_rdata == 0;
	// Trace: core/darkriscv_3stages.v:1065:2
	wire reg_rs2_zero;
	// Trace: core/darkriscv_3stages.v:1067:2
	assign reg_rs2_zero = rvfi_rs2_rdata == 0;
	// Trace: core/darkriscv_3stages.v:1069:2
	wire [31:0] reg_rs1_log2;
	// Trace: core/darkriscv_3stages.v:1071:2
	function integer clogb2;
		// Trace: core/darkriscv_3stages.v:1073:3
		input [31:0] value;
		// Trace: core/darkriscv_3stages.v:1075:3
		integer i;
		// Trace: core/darkriscv_3stages.v:1077:3
		begin
			// Trace: core/darkriscv_3stages.v:1079:4
			clogb2 = 0;
			// Trace: core/darkriscv_3stages.v:1081:4
			for (i = 0; i < 32; i = i + 1)
				begin
					// Trace: core/darkriscv_3stages.v:1084:6
					if (value > 0) begin
						// Trace: core/darkriscv_3stages.v:1086:7
						clogb2 = i + 1;
						// Trace: core/darkriscv_3stages.v:1088:7
						value = value >> 1;
					end
				end
		end
	endfunction
	// Trace: core/darkriscv_3stages.v:1093:2
	assign reg_rs1_log2 = clogb2(rvfi_rs1_rdata);
	// Trace: core/darkriscv_3stages.v:1095:2
	wire [31:0] reg_rs2_log2;
	// Trace: core/darkriscv_3stages.v:1097:2
	assign reg_rs2_log2 = clogb2(rvfi_rs2_rdata);
	// Trace: core/darkriscv_3stages.v:1098:2
	wire reg_rd_zero;
	// Trace: core/darkriscv_3stages.v:1099:2
	assign reg_rd_zero = rvfi_rd_wdata == 0;
	// Trace: core/darkriscv_3stages.v:1100:2
	wire [31:0] reg_rd_log2;
	// Trace: core/darkriscv_3stages.v:1101:2
	assign reg_rd_log2 = clogb2(rvfi_rd_wdata);
	// Trace: core/darkriscv_3stages.v:1105:2
	wire is_aligned;
	// Trace: core/darkriscv_3stages.v:1107:2
	assign is_aligned = rvfi_mem_addr[1:0] == 2'b00;
	// Trace: core/darkriscv_3stages.v:1109:2
	wire is_half_aligned;
	// Trace: core/darkriscv_3stages.v:1111:2
	assign is_half_aligned = rvfi_mem_addr[1:0] != 2'b11;
	// Trace: core/darkriscv_3stages.v:1113:2
	wire branch_taken;
	// Trace: core/darkriscv_3stages.v:1115:2
	assign branch_taken = (((((((opcode == 7'b1101111) || (opcode == 7'b1100111)) || (((opcode == 7'b1100011) && (funct3 == 3'b000)) && (reg_rs1 == reg_rs2))) || (((opcode == 7'b1100011) && (funct3 == 3'b001)) && (reg_rs1 != reg_rs2))) || (((opcode == 7'b1100011) && (funct3 == 3'b100)) && ($signed(reg_rs1) < $signed(reg_rs2)))) || (((opcode == 7'b1100011) && (funct3 == 3'b101)) && ($signed(reg_rs1) >= $signed(reg_rs2)))) || (((opcode == 7'b1100011) && (funct3 == 3'b110)) && (reg_rs1 < reg_rs2))) || (((opcode == 7'b1100011) && (funct3 == 3'b111)) && (reg_rs1 >= reg_rs2));
	// Trace: core/darkriscv_3stages.v:1119:2
	wire [31:0] mem_addr;
	// Trace: core/darkriscv_3stages.v:1120:2
	assign mem_addr = rvfi_mem_addr;
	// Trace: core/darkriscv_3stages.v:1122:2
	wire [31:0] mem_r_data;
	// Trace: core/darkriscv_3stages.v:1124:2
	assign mem_r_data = rvfi_mem_rdata;
	// Trace: core/darkriscv_3stages.v:1126:2
	wire [31:0] mem_w_data;
	// Trace: core/darkriscv_3stages.v:1128:2
	assign mem_w_data = rvfi_mem_wdata;
endmodule
