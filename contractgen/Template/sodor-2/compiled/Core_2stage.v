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
	// Trace: core/Core_2stage.v:166:3
	wire [31:0] new_pc;
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
		.new_pc(new_pc),
		.rvfi_regfile(rvfi_regfile)
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
	wire retire;
	// Trace: core/Core_2stage.v:249:3
	assign retire = exe_reg_valid & ~d_io_ctl_stall;
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
	reg [1023:0] old_regfile;
	// Trace: core/Core_2stage.v:261:3
	always @(posedge clock)
		// Trace: core/Core_2stage.v:262:5
		if (reset)
			// Trace: core/Core_2stage.v:263:7
			old_regfile <= 0;
		else
			// Trace: core/Core_2stage.v:265:7
			if (retire)
				// Trace: core/Core_2stage.v:266:9
				old_regfile <= rvfi_regfile;
	// Trace: core/Core_2stage.v:270:3
	wire [31:0] old_pc;
	// Trace: core/Core_2stage.v:271:3
	assign old_pc = exe_reg_pc;
	// Trace: core/Core_2stage.v:272:3
	// Trace: core/Core_2stage.v:302:3
	wire mem_req;
	// Trace: core/Core_2stage.v:303:3
	assign mem_req = io_dmem_req_valid;
	// Trace: core/Core_2stage.v:304:3
	wire [31:0] mem_addr;
	// Trace: core/Core_2stage.v:305:3
	assign mem_addr = io_dmem_req_bits_addr;
	// Trace: core/Core_2stage.v:306:3
	wire [31:0] mem_rdata;
	// Trace: core/Core_2stage.v:307:3
	assign mem_rdata = io_dmem_resp_bits_data;
	// Trace: core/Core_2stage.v:308:3
	wire [31:0] mem_wdata;
	// Trace: core/Core_2stage.v:309:3
	assign mem_wdata = io_dmem_req_bits_data;
	// Trace: core/Core_2stage.v:310:3
	wire mem_we;
	// Trace: core/Core_2stage.v:311:3
	assign mem_we = io_dmem_req_bits_fcn;
	// Trace: core/Core_2stage.v:312:3
	wire [2:0] mem_be;
	// Trace: core/Core_2stage.v:313:3
	assign mem_be = io_dmem_req_bits_typ;
	// Trace: core/Core_2stage.v:314:3
	wire exception;
	// Trace: core/Core_2stage.v:315:3
	assign exception = d_io_ctl_exception;
	// Trace: core/Core_2stage.v:317:3
	RVFI_2stage RVFI_2stage(
		.clock(clock),
		.retire(retire),
		.instruction(instruction),
		.old_regfile(old_regfile),
		.new_regfile(rvfi_regfile),
		.old_pc(old_pc),
		.new_pc(new_pc),
		.mem_req(mem_req),
		.mem_addr(mem_addr),
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
	// Trace: core/Core_2stage.v:360:3
	assign io_imem_req_valid = d_io_imem_req_valid;
	// Trace: core/Core_2stage.v:361:3
	assign io_imem_req_bits_addr = d_io_imem_req_bits_addr;
	// Trace: core/Core_2stage.v:362:3
	assign io_dmem_req_valid = c_io_dmem_req_valid;
	// Trace: core/Core_2stage.v:363:3
	assign io_dmem_req_bits_addr = d_io_dmem_req_bits_addr;
	// Trace: core/Core_2stage.v:364:3
	assign io_dmem_req_bits_data = d_io_dmem_req_bits_data;
	// Trace: core/Core_2stage.v:365:3
	assign io_dmem_req_bits_fcn = c_io_dmem_req_bits_fcn;
	// Trace: core/Core_2stage.v:366:3
	assign io_dmem_req_bits_typ = c_io_dmem_req_bits_typ;
	// Trace: core/Core_2stage.v:367:3
	assign c_io_imem_resp_valid = io_imem_resp_valid;
	// Trace: core/Core_2stage.v:368:3
	assign c_io_dmem_resp_valid = io_dmem_resp_valid;
	// Trace: core/Core_2stage.v:369:3
	assign c_io_dat_if_valid_resp = d_io_dat_if_valid_resp;
	// Trace: core/Core_2stage.v:370:3
	assign c_io_dat_inst = d_io_dat_inst;
	// Trace: core/Core_2stage.v:371:3
	assign c_io_dat_br_eq = d_io_dat_br_eq;
	// Trace: core/Core_2stage.v:372:3
	assign c_io_dat_br_lt = d_io_dat_br_lt;
	// Trace: core/Core_2stage.v:373:3
	assign c_io_dat_br_ltu = d_io_dat_br_ltu;
	// Trace: core/Core_2stage.v:374:3
	assign c_io_dat_inst_misaligned = d_io_dat_inst_misaligned;
	// Trace: core/Core_2stage.v:375:3
	assign c_io_dat_data_misaligned = d_io_dat_data_misaligned;
	// Trace: core/Core_2stage.v:376:3
	assign c_io_dat_mem_store = d_io_dat_mem_store;
	// Trace: core/Core_2stage.v:377:3
	assign c_io_dat_csr_eret = d_io_dat_csr_eret;
	// Trace: core/Core_2stage.v:378:3
	assign c_io_dat_csr_interrupt = d_io_dat_csr_interrupt;
	// Trace: core/Core_2stage.v:379:3
	assign d_clock = clock;
	// Trace: core/Core_2stage.v:380:3
	assign d_reset = reset;
	// Trace: core/Core_2stage.v:381:3
	assign d_io_imem_resp_valid = io_imem_resp_valid;
	// Trace: core/Core_2stage.v:382:3
	assign d_io_imem_resp_bits_data = io_imem_resp_bits_data;
	// Trace: core/Core_2stage.v:383:3
	assign d_io_dmem_resp_bits_data = io_dmem_resp_bits_data;
	// Trace: core/Core_2stage.v:384:3
	assign d_io_ctl_stall = c_io_ctl_stall;
	// Trace: core/Core_2stage.v:385:3
	assign d_io_ctl_if_kill = c_io_ctl_if_kill;
	// Trace: core/Core_2stage.v:386:3
	assign d_io_ctl_pc_sel = c_io_ctl_pc_sel;
	// Trace: core/Core_2stage.v:387:3
	assign d_io_ctl_op1_sel = c_io_ctl_op1_sel;
	// Trace: core/Core_2stage.v:388:3
	assign d_io_ctl_op2_sel = c_io_ctl_op2_sel;
	// Trace: core/Core_2stage.v:389:3
	assign d_io_ctl_alu_fun = c_io_ctl_alu_fun;
	// Trace: core/Core_2stage.v:390:3
	assign d_io_ctl_wb_sel = c_io_ctl_wb_sel;
	// Trace: core/Core_2stage.v:391:3
	assign d_io_ctl_rf_wen = c_io_ctl_rf_wen;
	// Trace: core/Core_2stage.v:392:3
	assign d_io_ctl_csr_cmd = c_io_ctl_csr_cmd;
	// Trace: core/Core_2stage.v:393:3
	assign d_io_ctl_mem_val = c_io_ctl_mem_val;
	// Trace: core/Core_2stage.v:394:3
	assign d_io_ctl_mem_fcn = c_io_ctl_mem_fcn;
	// Trace: core/Core_2stage.v:395:3
	assign d_io_ctl_mem_typ = c_io_ctl_mem_typ;
	// Trace: core/Core_2stage.v:396:3
	assign d_io_ctl_exception = c_io_ctl_exception;
	// Trace: core/Core_2stage.v:397:3
	assign d_io_ctl_exception_cause = c_io_ctl_exception_cause;
	// Trace: core/Core_2stage.v:398:3
	assign d_io_ctl_pc_sel_no_xept = c_io_ctl_pc_sel_no_xept;
	// Trace: core/Core_2stage.v:399:3
	assign d_io_interrupt_debug = io_interrupt_debug;
	// Trace: core/Core_2stage.v:400:3
	assign d_io_interrupt_mtip = io_interrupt_mtip;
	// Trace: core/Core_2stage.v:401:3
	assign d_io_interrupt_msip = io_interrupt_msip;
	// Trace: core/Core_2stage.v:402:3
	assign d_io_interrupt_meip = io_interrupt_meip;
	// Trace: core/Core_2stage.v:403:3
	assign d_io_hartid = io_hartid;
	// Trace: core/Core_2stage.v:404:3
	assign d_io_reset_vector = io_reset_vector;
endmodule
