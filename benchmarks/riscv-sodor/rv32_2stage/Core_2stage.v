`define JAL_OP		7'b1101111
`define JALR_OP		7'b1100111
`define BEQ_OP		7'b1100011
`define BNE_OP		7'b1100011
`define BLT_OP		7'b1100011
`define BGE_OP		7'b1100011
`define BLTU_OP		7'b1100011
`define BGEU_OP		7'b1100011

`define BEQ_FUNCT_3		3'b000
`define BNE_FUNCT_3		3'b001
`define BLT_FUNCT_3		3'b100
`define BGE_FUNCT_3		3'b101
`define BLTU_FUNCT_3	3'b110
`define BGEU_FUNCT_3	3'b111

module Core_2stage (
	clock,
	reset,
	io_imem_req_valid,
	io_imem_req_bits_addr,
	io_imem_resp_valid,
	io_imem_resp_bits_data,
	io_dmem_req_valid,
	io_dmem_req_bits_addr,
	io_dmem_req_bits_data,
	io_dmem_req_bits_fcn,
	io_dmem_req_bits_typ,
	io_dmem_resp_valid,
	io_dmem_resp_bits_data,
	io_interrupt_debug,
	io_interrupt_mtip,
	io_interrupt_msip,
	io_interrupt_meip,
	io_hartid,
	io_reset_vector,
	pc_retire,
	instr_ctr,
	io_dmem_req_bits_addr_ctr,
	exe_reg_pc,
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
	// Trace: core/Core_2stage.v:2:3
	input clock;
	// Trace: core/Core_2stage.v:3:3
	input reset;
	// Trace: core/Core_2stage.v:4:3
	output wire io_imem_req_valid;
	// Trace: core/Core_2stage.v:5:3
	output wire [31:0] io_imem_req_bits_addr;
	// Trace: core/Core_2stage.v:6:3
	input io_imem_resp_valid;
	// Trace: core/Core_2stage.v:7:3
	input [31:0] io_imem_resp_bits_data;
	// Trace: core/Core_2stage.v:8:3
	output wire io_dmem_req_valid;
	// Trace: core/Core_2stage.v:9:3
	output wire [31:0] io_dmem_req_bits_addr;
	// Trace: core/Core_2stage.v:10:3
	output wire [31:0] io_dmem_req_bits_data;
	// Trace: core/Core_2stage.v:11:3
	output wire io_dmem_req_bits_fcn;
	// Trace: core/Core_2stage.v:12:3
	output wire [2:0] io_dmem_req_bits_typ;
	// Trace: core/Core_2stage.v:13:3
	input io_dmem_resp_valid;
	// Trace: core/Core_2stage.v:14:3
	input [31:0] io_dmem_resp_bits_data;
	// Trace: core/Core_2stage.v:15:3
	input io_interrupt_debug;
	// Trace: core/Core_2stage.v:16:3
	input io_interrupt_mtip;
	// Trace: core/Core_2stage.v:17:3
	input io_interrupt_msip;
	// Trace: core/Core_2stage.v:18:3
	input io_interrupt_meip;
	// Trace: core/Core_2stage.v:19:3
	input io_hartid;
	// Trace: core/Core_2stage.v:20:3
	input [31:0] io_reset_vector;
	// Trace: core/Core_2stage.v:22:3
	output wire [31:0] pc_retire;
	// Trace: core/Core_2stage.v:23:3
	inout [31:0] instr_ctr;
	// Trace: core/Core_2stage.v:25:3
	output wire [31:0] io_dmem_req_bits_addr_ctr;
	// Trace: core/Core_2stage.v:27:3
	output wire [31:0] exe_reg_pc;
	// Trace: core/Core_2stage.v:29:4
	output wire rvfi_valid;
	// Trace: core/Core_2stage.v:30:5
	output wire [63:0] rvfi_order;
	// Trace: core/Core_2stage.v:31:5
	output wire [31:0] rvfi_insn;
	// Trace: core/Core_2stage.v:32:5
	output wire rvfi_trap;
	// Trace: core/Core_2stage.v:33:5
	output wire rvfi_halt;
	// Trace: core/Core_2stage.v:34:5
	output wire rvfi_intr;
	// Trace: core/Core_2stage.v:35:5
	output wire [1:0] rvfi_mode;
	// Trace: core/Core_2stage.v:36:5
	output wire [1:0] rvfi_ixl;
	// Trace: core/Core_2stage.v:37:5
	output wire [4:0] rvfi_rs1_addr;
	// Trace: core/Core_2stage.v:38:5
	output wire [4:0] rvfi_rs2_addr;
	// Trace: core/Core_2stage.v:39:5
	output wire [4:0] rvfi_rs3_addr;
	// Trace: core/Core_2stage.v:40:5
	output wire [31:0] rvfi_rs1_rdata;
	// Trace: core/Core_2stage.v:41:5
	output wire [31:0] rvfi_rs2_rdata;
	// Trace: core/Core_2stage.v:42:5
	output wire [31:0] rvfi_rs3_rdata;
	// Trace: core/Core_2stage.v:43:5
	output wire [4:0] rvfi_rd_addr;
	// Trace: core/Core_2stage.v:44:5
	output wire [31:0] rvfi_rd_wdata;
	// Trace: core/Core_2stage.v:45:5
	output wire [31:0] rvfi_pc_rdata;
	// Trace: core/Core_2stage.v:46:5
	output wire [31:0] rvfi_pc_wdata;
	// Trace: core/Core_2stage.v:47:5
	output wire [31:0] rvfi_mem_addr;
	// Trace: core/Core_2stage.v:48:5
	output wire [3:0] rvfi_mem_rmask;
	// Trace: core/Core_2stage.v:49:5
	output wire [3:0] rvfi_mem_wmask;
	// Trace: core/Core_2stage.v:50:5
	output wire [31:0] rvfi_mem_rdata;
	// Trace: core/Core_2stage.v:51:5
	output wire [31:0] rvfi_mem_wdata;
	// Trace: core/Core_2stage.v:53:3
	wire c_io_imem_resp_valid;
	// Trace: core/Core_2stage.v:54:3
	wire c_io_dmem_req_valid;
	// Trace: core/Core_2stage.v:55:3
	wire c_io_dmem_req_bits_fcn;
	// Trace: core/Core_2stage.v:56:3
	wire [2:0] c_io_dmem_req_bits_typ;
	// Trace: core/Core_2stage.v:57:3
	wire c_io_dmem_resp_valid;
	// Trace: core/Core_2stage.v:58:3
	wire c_io_dat_if_valid_resp;
	// Trace: core/Core_2stage.v:59:3
	wire [31:0] c_io_dat_inst;
	// Trace: core/Core_2stage.v:60:3
	wire c_io_dat_br_eq;
	// Trace: core/Core_2stage.v:61:3
	wire c_io_dat_br_lt;
	// Trace: core/Core_2stage.v:62:3
	wire c_io_dat_br_ltu;
	// Trace: core/Core_2stage.v:63:3
	wire c_io_dat_inst_misaligned;
	// Trace: core/Core_2stage.v:64:3
	wire c_io_dat_data_misaligned;
	// Trace: core/Core_2stage.v:65:3
	wire c_io_dat_mem_store;
	// Trace: core/Core_2stage.v:66:3
	wire c_io_dat_csr_eret;
	// Trace: core/Core_2stage.v:67:3
	wire c_io_dat_csr_interrupt;
	// Trace: core/Core_2stage.v:68:3
	wire c_io_ctl_stall;
	// Trace: core/Core_2stage.v:69:3
	wire c_io_ctl_if_kill;
	// Trace: core/Core_2stage.v:70:3
	wire [2:0] c_io_ctl_pc_sel;
	// Trace: core/Core_2stage.v:71:3
	wire [1:0] c_io_ctl_op1_sel;
	// Trace: core/Core_2stage.v:72:3
	wire [2:0] c_io_ctl_op2_sel;
	// Trace: core/Core_2stage.v:73:3
	wire [4:0] c_io_ctl_alu_fun;
	// Trace: core/Core_2stage.v:74:3
	wire [1:0] c_io_ctl_wb_sel;
	// Trace: core/Core_2stage.v:75:3
	wire c_io_ctl_rf_wen;
	// Trace: core/Core_2stage.v:76:3
	wire [2:0] c_io_ctl_csr_cmd;
	// Trace: core/Core_2stage.v:77:3
	wire c_io_ctl_mem_val;
	// Trace: core/Core_2stage.v:78:3
	wire [1:0] c_io_ctl_mem_fcn;
	// Trace: core/Core_2stage.v:79:3
	wire [2:0] c_io_ctl_mem_typ;
	// Trace: core/Core_2stage.v:80:3
	wire c_io_ctl_exception;
	// Trace: core/Core_2stage.v:81:3
	wire [31:0] c_io_ctl_exception_cause;
	// Trace: core/Core_2stage.v:82:3
	wire [2:0] c_io_ctl_pc_sel_no_xept;
	// Trace: core/Core_2stage.v:83:3
	wire d_clock;
	// Trace: core/Core_2stage.v:84:3
	wire d_reset;
	// Trace: core/Core_2stage.v:85:3
	wire d_io_imem_req_valid;
	// Trace: core/Core_2stage.v:86:3
	wire [31:0] d_io_imem_req_bits_addr;
	// Trace: core/Core_2stage.v:87:3
	wire d_io_imem_resp_valid;
	// Trace: core/Core_2stage.v:88:3
	wire [31:0] d_io_imem_resp_bits_data;
	// Trace: core/Core_2stage.v:89:3
	wire [31:0] d_io_dmem_req_bits_addr;
	// Trace: core/Core_2stage.v:90:3
	wire [31:0] d_io_dmem_req_bits_data;
	// Trace: core/Core_2stage.v:91:3
	wire [31:0] d_io_dmem_resp_bits_data;
	// Trace: core/Core_2stage.v:92:3
	wire d_io_ctl_stall;
	// Trace: core/Core_2stage.v:93:3
	wire d_io_ctl_if_kill;
	// Trace: core/Core_2stage.v:94:3
	wire [2:0] d_io_ctl_pc_sel;
	// Trace: core/Core_2stage.v:95:3
	wire [1:0] d_io_ctl_op1_sel;
	// Trace: core/Core_2stage.v:96:3
	wire [2:0] d_io_ctl_op2_sel;
	// Trace: core/Core_2stage.v:97:3
	wire [4:0] d_io_ctl_alu_fun;
	// Trace: core/Core_2stage.v:98:3
	wire [1:0] d_io_ctl_wb_sel;
	// Trace: core/Core_2stage.v:99:3
	wire d_io_ctl_rf_wen;
	// Trace: core/Core_2stage.v:100:3
	wire [2:0] d_io_ctl_csr_cmd;
	// Trace: core/Core_2stage.v:101:3
	wire d_io_ctl_mem_val;
	// Trace: core/Core_2stage.v:102:3
	wire [1:0] d_io_ctl_mem_fcn;
	// Trace: core/Core_2stage.v:103:3
	wire [2:0] d_io_ctl_mem_typ;
	// Trace: core/Core_2stage.v:104:3
	wire d_io_ctl_exception;
	// Trace: core/Core_2stage.v:105:3
	wire [31:0] d_io_ctl_exception_cause;
	// Trace: core/Core_2stage.v:106:3
	wire [2:0] d_io_ctl_pc_sel_no_xept;
	// Trace: core/Core_2stage.v:107:3
	wire d_io_dat_if_valid_resp;
	// Trace: core/Core_2stage.v:108:3
	wire [31:0] d_io_dat_inst;
	// Trace: core/Core_2stage.v:109:3
	wire d_io_dat_br_eq;
	// Trace: core/Core_2stage.v:110:3
	wire d_io_dat_br_lt;
	// Trace: core/Core_2stage.v:111:3
	wire d_io_dat_br_ltu;
	// Trace: core/Core_2stage.v:112:3
	wire d_io_dat_inst_misaligned;
	// Trace: core/Core_2stage.v:113:3
	wire d_io_dat_data_misaligned;
	// Trace: core/Core_2stage.v:114:3
	wire d_io_dat_mem_store;
	// Trace: core/Core_2stage.v:115:3
	wire d_io_dat_csr_eret;
	// Trace: core/Core_2stage.v:116:3
	wire d_io_dat_csr_interrupt;
	// Trace: core/Core_2stage.v:117:3
	wire d_io_interrupt_debug;
	// Trace: core/Core_2stage.v:118:3
	wire d_io_interrupt_mtip;
	// Trace: core/Core_2stage.v:119:3
	wire d_io_interrupt_msip;
	// Trace: core/Core_2stage.v:120:3
	wire d_io_interrupt_meip;
	// Trace: core/Core_2stage.v:121:3
	wire d_io_hartid;
	// Trace: core/Core_2stage.v:122:3
	wire [31:0] d_io_reset_vector;
	// Trace: core/Core_2stage.v:123:3
	wire [4:0] io_ctl_alu_fun_ctr;
	wire [1:0] io_ctl_op1_sel_ctr;
	wire [2:0] io_ctl_op2_sel_ctr;
	wire io_dat_br_eq_ctr;
	wire io_dat_br_lt_ctr;
	wire io_dat_br_ltu_ctr;
	wire [31:0] io_dat_inst_ctr;
	CtlPath_2stage CtlPath_2stage(
		.io_imem_resp_valid(c_io_imem_resp_valid),
		.io_dmem_req_valid(c_io_dmem_req_valid),
		.io_dmem_req_bits_fcn(c_io_dmem_req_bits_fcn),
		.io_dmem_req_bits_typ(c_io_dmem_req_bits_typ),
		.io_dmem_resp_valid(c_io_dmem_resp_valid),
		.io_dat_if_valid_resp(c_io_dat_if_valid_resp),
		.io_dat_inst(c_io_dat_inst),
		.io_dat_br_eq(c_io_dat_br_eq),
		.io_dat_br_lt(c_io_dat_br_lt),
		.io_dat_br_ltu(c_io_dat_br_ltu),
		.io_dat_inst_misaligned(c_io_dat_inst_misaligned),
		.io_dat_data_misaligned(c_io_dat_data_misaligned),
		.io_dat_mem_store(c_io_dat_mem_store),
		.io_dat_csr_eret(c_io_dat_csr_eret),
		.io_dat_csr_interrupt(c_io_dat_csr_interrupt),
		.io_ctl_stall(c_io_ctl_stall),
		.io_ctl_if_kill(c_io_ctl_if_kill),
		.io_ctl_pc_sel(c_io_ctl_pc_sel),
		.io_ctl_op1_sel(c_io_ctl_op1_sel),
		.io_ctl_op2_sel(c_io_ctl_op2_sel),
		.io_ctl_alu_fun(c_io_ctl_alu_fun),
		.io_ctl_wb_sel(c_io_ctl_wb_sel),
		.io_ctl_rf_wen(c_io_ctl_rf_wen),
		.io_ctl_csr_cmd(c_io_ctl_csr_cmd),
		.io_ctl_mem_val(c_io_ctl_mem_val),
		.io_ctl_mem_fcn(c_io_ctl_mem_fcn),
		.io_ctl_mem_typ(c_io_ctl_mem_typ),
		.io_ctl_exception(c_io_ctl_exception),
		.io_ctl_exception_cause(c_io_ctl_exception_cause),
		.io_ctl_pc_sel_no_xept(c_io_ctl_pc_sel_no_xept),
		.io_dat_inst_ctr(io_dat_inst_ctr),
		.io_ctl_alu_fun_ctr(io_ctl_alu_fun_ctr),
		.io_ctl_op1_sel_ctr(io_ctl_op1_sel_ctr),
		.io_ctl_op2_sel_ctr(io_ctl_op2_sel_ctr),
		.io_dat_br_eq_ctr(io_dat_br_eq_ctr),
		.io_dat_br_lt_ctr(io_dat_br_lt_ctr),
		.io_dat_br_ltu_ctr(io_dat_br_ltu_ctr)
	);
	// Trace: core/Core_2stage.v:165:3
	wire [1023:0] rvfi_regfile;
	wire [31:0] register_wdata;
 	// Trace: core/Core_2stage.v:166:3
	wire [31:0] new_pc_wire;
	DatPath_2stage DatPath_2stage(
		.clock(d_clock),
		.reset(d_reset),
		.io_imem_req_valid(d_io_imem_req_valid),
		.io_imem_req_bits_addr(d_io_imem_req_bits_addr),
		.io_imem_resp_valid(d_io_imem_resp_valid),
		.io_imem_resp_bits_data(d_io_imem_resp_bits_data),
		.io_dmem_req_bits_addr(d_io_dmem_req_bits_addr),
		.io_dmem_req_bits_data(d_io_dmem_req_bits_data),
		.io_dmem_resp_bits_data(d_io_dmem_resp_bits_data),
		.io_ctl_stall(d_io_ctl_stall),
		.io_ctl_if_kill(d_io_ctl_if_kill),
		.io_ctl_pc_sel(d_io_ctl_pc_sel),
		.io_ctl_op1_sel(d_io_ctl_op1_sel),
		.io_ctl_op2_sel(d_io_ctl_op2_sel),
		.io_ctl_alu_fun(d_io_ctl_alu_fun),
		.io_ctl_wb_sel(d_io_ctl_wb_sel),
		.io_ctl_rf_wen(d_io_ctl_rf_wen),
		.io_ctl_csr_cmd(d_io_ctl_csr_cmd),
		.io_ctl_mem_val(d_io_ctl_mem_val),
		.io_ctl_mem_fcn(d_io_ctl_mem_fcn),
		.io_ctl_mem_typ(d_io_ctl_mem_typ),
		.io_ctl_exception(d_io_ctl_exception),
		.io_ctl_exception_cause(d_io_ctl_exception_cause),
		.io_ctl_pc_sel_no_xept(d_io_ctl_pc_sel_no_xept),
		.io_dat_if_valid_resp(d_io_dat_if_valid_resp),
		.io_dat_inst(d_io_dat_inst),
		.io_dat_br_eq(d_io_dat_br_eq),
		.io_dat_br_lt(d_io_dat_br_lt),
		.io_dat_br_ltu(d_io_dat_br_ltu),
		.io_dat_inst_misaligned(d_io_dat_inst_misaligned),
		.io_dat_data_misaligned(d_io_dat_data_misaligned),
		.io_dat_mem_store(d_io_dat_mem_store),
		.io_dat_csr_eret(d_io_dat_csr_eret),
		.io_dat_csr_interrupt(d_io_dat_csr_interrupt),
		.io_interrupt_debug(d_io_interrupt_debug),
		.io_interrupt_mtip(d_io_interrupt_mtip),
		.io_interrupt_msip(d_io_interrupt_msip),
		.io_interrupt_meip(d_io_interrupt_meip),
		.io_hartid(d_io_hartid),
		.io_reset_vector(d_io_reset_vector),
		.pc_retire(pc_retire),
		.instr_ctr(instr_ctr),
		.io_dat_inst_ctr(io_dat_inst_ctr),
		.io_ctl_alu_fun_ctr(io_ctl_alu_fun_ctr),
		.io_ctl_op1_sel_ctr(io_ctl_op1_sel_ctr),
		.io_ctl_op2_sel_ctr(io_ctl_op2_sel_ctr),
		.io_dmem_req_bits_addr_ctr(io_dmem_req_bits_addr_ctr),
		.io_dat_br_eq_ctr(io_dat_br_eq_ctr),
		.io_dat_br_lt_ctr(io_dat_br_lt_ctr),
		.io_dat_br_ltu_ctr(io_dat_br_ltu_ctr),
		.exe_reg_pc(exe_reg_pc),
		.new_pc(new_pc_wire),
		.rvfi_regfile(rvfi_regfile),
		.register_wdata(register_wdata)
	);
	// Trace: core/Core_2stage.v:227:3
	// Trace: core/Core_2stage.v:229:3
	// Trace: core/Core_2stage.v:230:3
	// Trace: core/Core_2stage.v:231:3
	// Trace: core/Core_2stage.v:234:5
	// Trace: core/Core_2stage.v:235:5
	// Trace: core/Core_2stage.v:236:5
	// Trace: core/Core_2stage.v:240:3
	reg exe_reg_valid = 0;
	// Trace: core/Core_2stage.v:241:3
	always @(posedge clock)
		// Trace: core/Core_2stage.v:242:5
		if (reset)
			// Trace: core/Core_2stage.v:243:7
			exe_reg_valid <= 0;
		else
			// Trace: core/Core_2stage.v:245:7
			exe_reg_valid <= (d_io_ctl_stall ? exe_reg_valid : !d_io_ctl_if_kill);
	// Trace: core/Core_2stage.v:248:3
	wire retire_wire;
	// Trace: core/Core_2stage.v:249:3
	assign retire_wire = exe_reg_valid & ~d_io_ctl_stall;
	reg retire;
	always @(posedge clock)
		retire <= retire_wire;
	// Trace: core/Core_2stage.v:250:3
	reg [31:0] stalled_instruction = 32'b00000000000000000000000000000000;
	// Trace: core/Core_2stage.v:251:3
	always @(posedge clock)
		// Trace: core/Core_2stage.v:252:5
		if (reset)
			// Trace: core/Core_2stage.v:253:7
			stalled_instruction <= 32'b00000000000000000000000000000000;
		else
			// Trace: core/Core_2stage.v:255:7
			stalled_instruction <= (!exe_reg_valid ? stalled_instruction : d_io_dat_inst);
	// Trace: core/Core_2stage.v:258:3
	wire [31:0] instruction;
	// Trace: core/Core_2stage.v:259:3
	assign instruction = (!exe_reg_valid ? stalled_instruction : d_io_dat_inst);
	// Trace: core/Core_2stage.v:260:3
	// Trace: core/Core_2stage.v:270:3
	wire [31:0] old_pc;
	// Trace: core/Core_2stage.v:271:3
	assign old_pc = exe_reg_pc;
	// Trace: core/Core_2stage.v:272:3
	// Trace: core/Core_2stage.v:274:3
	reg mem_req = 0;
	// Trace: core/Core_2stage.v:275:3
	reg [31:0] mem_addr1 = 32'b00000000000000000000000000000000;
	// Trace: core/Core_2stage.v:276:3
	reg [31:0] mem_rdata = 32'b00000000000000000000000000000000;
	// Trace: core/Core_2stage.v:277:3
	reg [31:0] mem_wdata = 32'b00000000000000000000000000000000;
	// Trace: core/Core_2stage.v:278:3
	reg mem_we = 0;
	// Trace: core/Core_2stage.v:279:3
	reg [2:0] mem_be = 3'b000;
	// Trace: core/Core_2stage.v:280:3
	wire exception;
	// Trace: core/Core_2stage.v:281:3
	assign exception = d_io_ctl_exception;
	// Trace: core/Core_2stage.v:282:3
	// always @(posedge clock)
	// 	// Trace: core/Core_2stage.v:283:5
	// 	if (reset) begin
	// 		// Trace: core/Core_2stage.v:284:7
	// 		mem_req <= 0;
	// 		// Trace: core/Core_2stage.v:285:7
	// 		mem_addr1 <= 32'b00000000000000000000000000000000;
	// 		// Trace: core/Core_2stage.v:286:7
	// 		mem_rdata <= 32'b00000000000000000000000000000000;
	// 		// Trace: core/Core_2stage.v:287:7
	// 		mem_wdata <= 32'b00000000000000000000000000000000;
	// 		// Trace: core/Core_2stage.v:288:7
	// 		mem_we <= 0;
	// 		// Trace: core/Core_2stage.v:289:7
	// 		mem_be <= 3'b000;
	// 	end
	// 	else begin
	// 		// Trace: core/Core_2stage.v:291:7
	// 		mem_req <= io_dmem_req_valid;
	// 		// Trace: core/Core_2stage.v:292:7
	// 		mem_addr1 <= io_dmem_req_bits_addr;
	// 		// Trace: core/Core_2stage.v:293:7
	// 		mem_rdata <= io_dmem_resp_bits_data;
	// 		// Trace: core/Core_2stage.v:294:7
	// 		mem_wdata <= io_dmem_req_bits_data;
	// 		// Trace: core/Core_2stage.v:295:7
	// 		mem_we <= io_dmem_req_bits_fcn;
	// 		// Trace: core/Core_2stage.v:296:7
	// 		mem_be <= io_dmem_req_bits_typ;
	// 	end
	always @(*)
		// Trace: core/Core_2stage.v:283:5
		if (reset) begin
			// Trace: core/Core_2stage.v:284:7
			mem_req = 0;
			// Trace: core/Core_2stage.v:285:7
			mem_addr1 = 32'b00000000000000000000000000000000;
			// Trace: core/Core_2stage.v:286:7
			mem_rdata = 32'b00000000000000000000000000000000;
			// Trace: core/Core_2stage.v:287:7
			mem_wdata = 32'b00000000000000000000000000000000;
			// Trace: core/Core_2stage.v:288:7
			mem_we = 0;
			// Trace: core/Core_2stage.v:289:7
			mem_be = 3'b000;
		end
		else begin
			// Trace: core/Core_2stage.v:291:7
			mem_req = io_dmem_req_valid;
			// Trace: core/Core_2stage.v:292:7
			mem_addr1 = io_dmem_req_bits_addr;
			// Trace: core/Core_2stage.v:293:7
			mem_rdata = io_dmem_resp_bits_data;
			// Trace: core/Core_2stage.v:294:7
			mem_wdata = io_dmem_req_bits_data;
			// Trace: core/Core_2stage.v:295:7
			mem_we = io_dmem_req_bits_fcn;
			// Trace: core/Core_2stage.v:296:7
			mem_be = io_dmem_req_bits_typ;
		end
	// Trace: core/Core_2stage.v:300:3
	RVFI_2stage RVFI_2stage(
		.clock(clock),
		.retire(retire_wire),
		.instruction(instruction),
		.old_regfile(rvfi_regfile),
		.register_wdata(register_wdata),
		.old_pc(old_pc),
		.new_pc(new_pc_wire),
		.mem_req(mem_req),
		.mem_addr(mem_addr1),
		.mem_rdata(mem_rdata),
		.mem_wdata(mem_wdata),
		.mem_we(mem_we),
		.mem_be(mem_be),
		.exception(exception),
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
	// Trace: core/Core_2stage.v:343:3
	assign io_imem_req_valid = d_io_imem_req_valid;
	// Trace: core/Core_2stage.v:344:3
	assign io_imem_req_bits_addr = d_io_imem_req_bits_addr;
	// Trace: core/Core_2stage.v:345:3
	assign io_dmem_req_valid = c_io_dmem_req_valid;
	// Trace: core/Core_2stage.v:346:3
	assign io_dmem_req_bits_addr = d_io_dmem_req_bits_addr;
	// Trace: core/Core_2stage.v:347:3
	assign io_dmem_req_bits_data = d_io_dmem_req_bits_data;
	// Trace: core/Core_2stage.v:348:3
	assign io_dmem_req_bits_fcn = c_io_dmem_req_bits_fcn;
	// Trace: core/Core_2stage.v:349:3
	assign io_dmem_req_bits_typ = c_io_dmem_req_bits_typ;
	// Trace: core/Core_2stage.v:350:3
	assign c_io_imem_resp_valid = io_imem_resp_valid;
	// Trace: core/Core_2stage.v:351:3
	assign c_io_dmem_resp_valid = io_dmem_resp_valid;
	// Trace: core/Core_2stage.v:352:3
	assign c_io_dat_if_valid_resp = d_io_dat_if_valid_resp;
	// Trace: core/Core_2stage.v:353:3
	assign c_io_dat_inst = d_io_dat_inst;
	// Trace: core/Core_2stage.v:354:3
	assign c_io_dat_br_eq = d_io_dat_br_eq;
	// Trace: core/Core_2stage.v:355:3
	assign c_io_dat_br_lt = d_io_dat_br_lt;
	// Trace: core/Core_2stage.v:356:3
	assign c_io_dat_br_ltu = d_io_dat_br_ltu;
	// Trace: core/Core_2stage.v:357:3
	assign c_io_dat_inst_misaligned = d_io_dat_inst_misaligned;
	// Trace: core/Core_2stage.v:358:3
	assign c_io_dat_data_misaligned = d_io_dat_data_misaligned;
	// Trace: core/Core_2stage.v:359:3
	assign c_io_dat_mem_store = d_io_dat_mem_store;
	// Trace: core/Core_2stage.v:360:3
	assign c_io_dat_csr_eret = d_io_dat_csr_eret;
	// Trace: core/Core_2stage.v:361:3
	assign c_io_dat_csr_interrupt = d_io_dat_csr_interrupt;
	// Trace: core/Core_2stage.v:362:3
	assign d_clock = clock;
	// Trace: core/Core_2stage.v:363:3
	assign d_reset = reset;
	// Trace: core/Core_2stage.v:364:3
	assign d_io_imem_resp_valid = io_imem_resp_valid;
	// Trace: core/Core_2stage.v:365:3
	assign d_io_imem_resp_bits_data = io_imem_resp_bits_data;
	// Trace: core/Core_2stage.v:366:3
	assign d_io_dmem_resp_bits_data = io_dmem_resp_bits_data;
	// Trace: core/Core_2stage.v:367:3
	assign d_io_ctl_stall = c_io_ctl_stall;
	// Trace: core/Core_2stage.v:368:3
	assign d_io_ctl_if_kill = c_io_ctl_if_kill;
	// Trace: core/Core_2stage.v:369:3
	assign d_io_ctl_pc_sel = c_io_ctl_pc_sel;
	// Trace: core/Core_2stage.v:370:3
	assign d_io_ctl_op1_sel = c_io_ctl_op1_sel;
	// Trace: core/Core_2stage.v:371:3
	assign d_io_ctl_op2_sel = c_io_ctl_op2_sel;
	// Trace: core/Core_2stage.v:372:3
	assign d_io_ctl_alu_fun = c_io_ctl_alu_fun;
	// Trace: core/Core_2stage.v:373:3
	assign d_io_ctl_wb_sel = c_io_ctl_wb_sel;
	// Trace: core/Core_2stage.v:374:3
	assign d_io_ctl_rf_wen = c_io_ctl_rf_wen;
	// Trace: core/Core_2stage.v:375:3
	assign d_io_ctl_csr_cmd = c_io_ctl_csr_cmd;
	// Trace: core/Core_2stage.v:376:3
	assign d_io_ctl_mem_val = c_io_ctl_mem_val;
	// Trace: core/Core_2stage.v:377:3
	assign d_io_ctl_mem_fcn = c_io_ctl_mem_fcn;
	// Trace: core/Core_2stage.v:378:3
	assign d_io_ctl_mem_typ = c_io_ctl_mem_typ;
	// Trace: core/Core_2stage.v:379:3
	assign d_io_ctl_exception = c_io_ctl_exception;
	// Trace: core/Core_2stage.v:380:3
	assign d_io_ctl_exception_cause = c_io_ctl_exception_cause;
	// Trace: core/Core_2stage.v:381:3
	assign d_io_ctl_pc_sel_no_xept = c_io_ctl_pc_sel_no_xept;
	// Trace: core/Core_2stage.v:382:3
	assign d_io_interrupt_debug = io_interrupt_debug;
	// Trace: core/Core_2stage.v:383:3
	assign d_io_interrupt_mtip = io_interrupt_mtip;
	// Trace: core/Core_2stage.v:384:3
	assign d_io_interrupt_msip = io_interrupt_msip;
	// Trace: core/Core_2stage.v:385:3
	assign d_io_interrupt_meip = io_interrupt_meip;
	// Trace: core/Core_2stage.v:386:3
	assign d_io_hartid = io_hartid;
	// Trace: core/Core_2stage.v:387:3
	assign d_io_reset_vector = io_reset_vector;
	
	
//////////////////////////// for contract atoms ////////////////////////////////
	//// frist building block for contract atoms
	wire rvfi_lui_ctr;
	assign rvfi_lui_ctr = (rvfi_insn[6:0] == 7'h37);
	wire rvfi_auipc_ctr;
	assign rvfi_auipc_ctr = (rvfi_insn[6:0] == 7'h17);
	
	wire rvfi_jal_ctr;
	assign rvfi_jal_ctr = (rvfi_insn[6:0] == 7'h6f);
	wire rvfi_jalr_ctr;
	assign rvfi_jalr_ctr = (rvfi_insn[6:0] == 7'h67) && (rvfi_insn[14:12] == 3'b000);

	wire rvfi_beq_ctr;
	assign rvfi_beq_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b000);
	wire rvfi_bge_ctr;
	assign rvfi_bge_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b101);
	wire rvfi_bgeu_ctr;
	assign rvfi_bgeu_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b111);
	wire rvfi_bltu_ctr;
	assign rvfi_bltu_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b110);
	wire rvfi_blt_ctr;
	assign rvfi_blt_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b100);
	wire rvfi_bne_ctr;
	assign rvfi_bne_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b001);
	
	
	wire rvfi_lb_ctr;
	assign rvfi_lb_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b000);
	wire rvfi_lh_ctr;
	assign rvfi_lh_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b001);
	wire rvfi_lhu_ctr;
	assign rvfi_lhu_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b101);
	wire rvfi_lbu_ctr;
	assign rvfi_lbu_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b100);
	wire rvfi_lw_ctr;
	assign rvfi_lw_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b010);
	
	wire rvfi_sb_ctr;
	assign rvfi_sb_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b000);
	wire rvfi_sw_ctr;
	assign rvfi_sw_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b010);
	wire rvfi_sh_ctr;
	assign rvfi_sh_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b001);

	wire rvfi_addi_ctr;
	assign rvfi_addi_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b000);
	wire rvfi_slti_ctr;
	assign rvfi_slti_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b010);
	wire rvfi_sltiu_ctr;
	assign rvfi_sltiu_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b011);
	wire rvfi_xori_ctr;
	assign rvfi_xori_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b100);
	wire rvfi_ori_ctr;
	assign rvfi_ori_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b110);
	wire rvfi_andi_ctr;
	assign rvfi_andi_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b111);
	wire rvfi_slli_ctr;
	assign rvfi_slli_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b001) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_srli_ctr;
	assign rvfi_srli_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b101) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_srai_ctr;
	assign rvfi_srai_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b101) && (rvfi_insn[31:25] == 7'b0100000);

	wire rvfi_add_ctr;
	assign rvfi_add_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b000) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_sub_ctr;
	assign rvfi_sub_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b000) && (rvfi_insn[31:25] == 7'b0100000);
	wire rvfi_sll_ctr;
	assign rvfi_sll_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b001) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_slt_ctr;
	assign rvfi_slt_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b010) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_sltu_ctr;
	assign rvfi_sltu_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b011) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_xor_ctr;
	assign rvfi_xor_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b100) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_srl_ctr;
	assign rvfi_srl_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b101) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_sra_ctr;
	assign rvfi_sra_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b101) && (rvfi_insn[31:25] == 7'b0100000);
	wire rvfi_or_ctr;
	assign rvfi_or_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b110) && (rvfi_insn[31:25] == 7'b0000000);
	wire rvfi_and_ctr;
	assign rvfi_and_ctr = (rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b111) && (rvfi_insn[31:25] == 7'b0000000);

	wire rvfi_mul_ctr;
	assign rvfi_mul_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b000 );
	wire rvfi_mulh_ctr;
	assign rvfi_mulh_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b001 );
	wire rvfi_mulhsu_ctr;
	assign rvfi_mulhsu_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b010 );
	wire rvfi_mulhu_ctr;
	assign rvfi_mulhu_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b011 );
	wire rvfi_div_ctr;
	assign rvfi_div_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b100 );
	wire rvfi_divu_ctr;
	assign rvfi_divu_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b101 );
	wire rvfi_rem_ctr;
	assign rvfi_rem_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b110 );
	wire rvfi_remu_ctr;
	assign rvfi_remu_ctr = ( rvfi_insn[6:0] == 7'h33 ) && ( rvfi_insn[31:25] == 7'b0000001 ) && ( rvfi_insn[14:12] == 3'b111 );


	//// second block for contract
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] rd;
	wire [6:0] opcode;
	wire [31:0] imm;
	wire [2:0] format;
	wire [2:0] funct3;
	wire [6:0] funct7;

    ctr_decode ctr_decode (
        .instr_i            (rvfi_insn),
        .format_o           (format),
        .op_o               (opcode),
        .funct_3_o          (funct3),
        .funct_7_o          (funct7),
        .rd_o               (rd),
        .rs1_o              (rs1),
        .rs2_o              (rs2),
        .imm_o              (imm),
    );

	wire [31:0] new_pc;
	assign new_pc = rvfi_pc_wdata;
	wire  is_branch;
	assign is_branch = rvfi_beq_ctr || rvfi_bge_ctr || rvfi_bgeu_ctr || rvfi_bltu_ctr || rvfi_blt_ctr || rvfi_bne_ctr || rvfi_jal_ctr || rvfi_jalr_ctr;
	

	wire [31:0] reg_rd;
	assign reg_rd = rvfi_rd_wdata;
	wire [31:0] reg_rs1;
	assign reg_rs1 = rvfi_rs1_rdata;
	wire [31:0] reg_rs2;
	assign reg_rs2 = rvfi_rs2_rdata;

	wire reg_rs1_zero;
	assign reg_rs1_zero = ( rvfi_rs1_rdata == 0 );
	wire reg_rs2_zero;
	assign reg_rs2_zero = ( rvfi_rs2_rdata == 0 );
	wire [31:0] reg_rs1_log2;
	assign reg_rs1_log2 = clogb2( rvfi_rs1_rdata );
	wire [31:0] reg_rs2_log2;
	assign reg_rs2_log2 = clogb2( rvfi_rs2_rdata );
	wire reg_rd_zero;
	assign reg_rd_zero = ( rvfi_rd_wdata == 0 );
	wire [31:0] reg_rd_log2;
	assign reg_rd_log2 = clogb2( rvfi_rd_wdata );

	function integer clogb2;
		input [31:0] value;
		integer i;
		begin
			clogb2 = 0;
			for (i = 0; i < 32; i = i + 1) begin
				if (value > 0) begin
					clogb2 = i + 1;
					value = value >> 1; // Shift right to reduce the value
				end
			end
		end
	endfunction




	wire is_aligned;
	assign is_aligned = rvfi_mem_addr[1:0] == 2'b00;
	wire is_half_aligned;
    assign is_half_aligned = rvfi_mem_addr[1:0] != 2'b11;

	wire branch_taken;
    assign branch_taken =
            (opcode == `JAL_OP)
        ||  (opcode == `JALR_OP)
        ||  ((opcode == `BEQ_OP) && (funct3 == `BEQ_FUNCT_3) && (reg_rs1 == reg_rs2))
        ||  ((opcode == `BNE_OP) && (funct3 == `BNE_FUNCT_3) && (reg_rs1 != reg_rs2))
        ||  ((opcode == `BLT_OP) && (funct3 == `BLT_FUNCT_3) && ($signed(reg_rs1) < $signed(reg_rs2)))
        ||  ((opcode == `BGE_OP) && (funct3 == `BGE_FUNCT_3) && ($signed(reg_rs1) >= $signed(reg_rs2)))
        ||  ((opcode == `BLTU_OP) && (funct3 == `BLTU_FUNCT_3) && (reg_rs1 < reg_rs2))
        ||  ((opcode == `BGEU_OP) && (funct3 == `BGEU_FUNCT_3) && (reg_rs1 >= reg_rs2));

	wire [31:0] mem_addr;
	assign mem_addr = rvfi_mem_addr;
	wire [31:0] mem_r_data;
	assign mem_r_data = rvfi_mem_rdata;
	wire [31:0] mem_w_data;
	assign mem_w_data = rvfi_mem_wdata;
	
    wire [4:0] rd_1;
  assign rd_1 = rd;
  wire [4:0] rs1_1;
  assign rs1_1 = rs1;
  wire [4:0] rs2_1;
  assign rs2_1 = rs2;

  reg [4:0] old_rd_1 = 0;
  reg [4:0] old_rd_2 = 0;
  reg [4:0] old_rd_3 = 0;
  reg [4:0] old_rd_4 = 0;
  always @(posedge clock) begin
      if (retire == 1) begin
          old_rd_1 <= rd_1;
          old_rd_2 <= old_rd_1;
          old_rd_3 <= old_rd_2;
          old_rd_4 <= old_rd_3;
      end
  end

  wire raw_rs1_1;
  assign raw_rs1_1 = rs1_1 == old_rd_1;
  wire raw_rs2_1;
  assign raw_rs2_1 = rs2_1 == old_rd_1;
  wire waw_1;
  assign waw_1 = rd_1 == old_rd_1;

  wire raw_rs1_2;
  assign raw_rs1_2 = rs1_1 == old_rd_2;
  wire raw_rs2_2;
  assign raw_rs2_2 = rs2_1 == old_rd_2;
  wire waw_2;
  assign waw_2 = rd_1 == old_rd_2;

  wire raw_rs1_3;
  assign raw_rs1_3 = rs1_1 == old_rd_3;
  wire raw_rs2_3;
  assign raw_rs2_3 = rs2_1 == old_rd_3;
  wire waw_3;
  assign waw_3 = rd_1 == old_rd_3;

  wire raw_rs1_4;
  assign raw_rs1_4 = rs1_1 == old_rd_4;
  wire raw_rs2_4;
  assign raw_rs2_4 = rs2_1 == old_rd_4;
  wire waw_4;
  assign waw_4 = rd_1 == old_rd_4;
endmodule
