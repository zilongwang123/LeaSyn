module Core_5stage (
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
	// Trace: core/Core_5stage.v:2:3
	input clock;
	// Trace: core/Core_5stage.v:3:3
	input reset;
	// Trace: core/Core_5stage.v:4:3
	output wire io_imem_req_valid;
	// Trace: core/Core_5stage.v:5:3
	output wire [31:0] io_imem_req_bits_addr;
	// Trace: core/Core_5stage.v:6:3
	input io_imem_resp_valid;
	// Trace: core/Core_5stage.v:7:3
	input [31:0] io_imem_resp_bits_data;
	// Trace: core/Core_5stage.v:8:3
	output wire io_dmem_req_valid;
	// Trace: core/Core_5stage.v:9:3
	output wire [31:0] io_dmem_req_bits_addr;
	// Trace: core/Core_5stage.v:10:3
	output wire [31:0] io_dmem_req_bits_data;
	// Trace: core/Core_5stage.v:11:3
	output wire io_dmem_req_bits_fcn;
	// Trace: core/Core_5stage.v:12:3
	output wire [2:0] io_dmem_req_bits_typ;
	// Trace: core/Core_5stage.v:13:3
	input io_dmem_resp_valid;
	// Trace: core/Core_5stage.v:14:3
	input [31:0] io_dmem_resp_bits_data;
	// Trace: core/Core_5stage.v:15:3
	input io_interrupt_debug;
	// Trace: core/Core_5stage.v:16:3
	input io_interrupt_mtip;
	// Trace: core/Core_5stage.v:17:3
	input io_interrupt_msip;
	// Trace: core/Core_5stage.v:18:3
	input io_interrupt_meip;
	// Trace: core/Core_5stage.v:19:3
	input io_hartid;
	// Trace: core/Core_5stage.v:20:3
	input [31:0] io_reset_vector;
	// Trace: core/Core_5stage.v:22:4
	output wire rvfi_valid;
	// Trace: core/Core_5stage.v:23:5
	output wire [63:0] rvfi_order;
	// Trace: core/Core_5stage.v:24:5
	output wire [31:0] rvfi_insn;
	// Trace: core/Core_5stage.v:25:5
	output wire rvfi_trap;
	// Trace: core/Core_5stage.v:26:5
	output wire rvfi_halt;
	// Trace: core/Core_5stage.v:27:5
	output wire rvfi_intr;
	// Trace: core/Core_5stage.v:28:5
	output wire [1:0] rvfi_mode;
	// Trace: core/Core_5stage.v:29:5
	output wire [1:0] rvfi_ixl;
	// Trace: core/Core_5stage.v:30:5
	output wire [4:0] rvfi_rs1_addr;
	// Trace: core/Core_5stage.v:31:5
	output wire [4:0] rvfi_rs2_addr;
	// Trace: core/Core_5stage.v:32:5
	output wire [4:0] rvfi_rs3_addr;
	// Trace: core/Core_5stage.v:33:5
	output wire [31:0] rvfi_rs1_rdata;
	// Trace: core/Core_5stage.v:34:5
	output wire [31:0] rvfi_rs2_rdata;
	// Trace: core/Core_5stage.v:35:5
	output wire [31:0] rvfi_rs3_rdata;
	// Trace: core/Core_5stage.v:36:5
	output wire [4:0] rvfi_rd_addr;
	// Trace: core/Core_5stage.v:37:5
	output wire [31:0] rvfi_rd_wdata;
	// Trace: core/Core_5stage.v:38:5
	output wire [31:0] rvfi_pc_rdata;
	// Trace: core/Core_5stage.v:39:5
	output wire [31:0] rvfi_pc_wdata;
	// Trace: core/Core_5stage.v:40:5
	output wire [31:0] rvfi_mem_addr;
	// Trace: core/Core_5stage.v:41:5
	output wire [3:0] rvfi_mem_rmask;
	// Trace: core/Core_5stage.v:42:5
	output wire [3:0] rvfi_mem_wmask;
	// Trace: core/Core_5stage.v:43:5
	output wire [31:0] rvfi_mem_rdata;
	// Trace: core/Core_5stage.v:44:5
	output wire [31:0] rvfi_mem_wdata;
	// Trace: core/Core_5stage.v:46:3
	wire c_clock;
	// Trace: core/Core_5stage.v:47:3
	wire c_reset;
	// Trace: core/Core_5stage.v:48:3
	wire c_io_dmem_resp_valid;
	// Trace: core/Core_5stage.v:49:3
	wire [31:0] c_io_dat_dec_inst;
	// Trace: core/Core_5stage.v:50:3
	wire c_io_dat_dec_valid;
	// Trace: core/Core_5stage.v:51:3
	wire c_io_dat_exe_br_eq;
	// Trace: core/Core_5stage.v:52:3
	wire c_io_dat_exe_br_lt;
	// Trace: core/Core_5stage.v:53:3
	wire c_io_dat_exe_br_ltu;
	// Trace: core/Core_5stage.v:54:3
	wire [3:0] c_io_dat_exe_br_type;
	// Trace: core/Core_5stage.v:55:3
	wire c_io_dat_exe_inst_misaligned;
	// Trace: core/Core_5stage.v:56:3
	wire c_io_dat_mem_ctrl_dmem_val;
	// Trace: core/Core_5stage.v:57:3
	wire c_io_dat_mem_data_misaligned;
	// Trace: core/Core_5stage.v:58:3
	wire c_io_dat_mem_store;
	// Trace: core/Core_5stage.v:59:3
	wire c_io_dat_csr_eret;
	// Trace: core/Core_5stage.v:60:3
	wire c_io_dat_csr_interrupt;
	// Trace: core/Core_5stage.v:61:3
	wire c_io_ctl_dec_stall;
	// Trace: core/Core_5stage.v:62:3
	wire c_io_ctl_full_stall;
	// Trace: core/Core_5stage.v:63:3
	wire [1:0] c_io_ctl_exe_pc_sel;
	// Trace: core/Core_5stage.v:64:3
	wire [3:0] c_io_ctl_br_type;
	// Trace: core/Core_5stage.v:65:3
	wire c_io_ctl_if_kill;
	// Trace: core/Core_5stage.v:66:3
	wire c_io_ctl_dec_kill;
	// Trace: core/Core_5stage.v:67:3
	wire [1:0] c_io_ctl_op1_sel;
	// Trace: core/Core_5stage.v:68:3
	wire [2:0] c_io_ctl_op2_sel;
	// Trace: core/Core_5stage.v:69:3
	wire [3:0] c_io_ctl_alu_fun;
	// Trace: core/Core_5stage.v:70:3
	wire [1:0] c_io_ctl_wb_sel;
	// Trace: core/Core_5stage.v:71:3
	wire c_io_ctl_rf_wen;
	// Trace: core/Core_5stage.v:72:3
	wire c_io_ctl_mem_val;
	// Trace: core/Core_5stage.v:73:3
	wire [1:0] c_io_ctl_mem_fcn;
	// Trace: core/Core_5stage.v:74:3
	wire [2:0] c_io_ctl_mem_typ;
	// Trace: core/Core_5stage.v:75:3
	wire [2:0] c_io_ctl_csr_cmd;
	// Trace: core/Core_5stage.v:76:3
	wire c_io_ctl_fencei;
	// Trace: core/Core_5stage.v:77:3
	wire c_io_ctl_pipeline_kill;
	// Trace: core/Core_5stage.v:78:3
	wire c_io_ctl_mem_exception;
	// Trace: core/Core_5stage.v:79:3
	wire [31:0] c_io_ctl_mem_exception_cause;
	// Trace: core/Core_5stage.v:80:3
	wire d_clock;
	// Trace: core/Core_5stage.v:81:3
	wire d_reset;
	// Trace: core/Core_5stage.v:82:3
	wire d_io_imem_req_valid;
	// Trace: core/Core_5stage.v:83:3
	wire [31:0] d_io_imem_req_bits_addr;
	// Trace: core/Core_5stage.v:84:3
	wire d_io_imem_resp_valid;
	// Trace: core/Core_5stage.v:85:3
	wire [31:0] d_io_imem_resp_bits_data;
	// Trace: core/Core_5stage.v:86:3
	wire d_io_dmem_req_valid;
	// Trace: core/Core_5stage.v:87:3
	wire [31:0] d_io_dmem_req_bits_addr;
	// Trace: core/Core_5stage.v:88:3
	wire [31:0] d_io_dmem_req_bits_data;
	// Trace: core/Core_5stage.v:89:3
	wire d_io_dmem_req_bits_fcn;
	// Trace: core/Core_5stage.v:90:3
	wire [2:0] d_io_dmem_req_bits_typ;
	// Trace: core/Core_5stage.v:91:3
	wire [31:0] d_io_dmem_resp_bits_data;
	// Trace: core/Core_5stage.v:92:3
	wire d_io_ctl_dec_stall;
	// Trace: core/Core_5stage.v:93:3
	wire d_io_ctl_full_stall;
	// Trace: core/Core_5stage.v:94:3
	wire [1:0] d_io_ctl_exe_pc_sel;
	// Trace: core/Core_5stage.v:95:3
	wire [3:0] d_io_ctl_br_type;
	// Trace: core/Core_5stage.v:96:3
	wire d_io_ctl_if_kill;
	// Trace: core/Core_5stage.v:97:3
	wire d_io_ctl_dec_kill;
	// Trace: core/Core_5stage.v:98:3
	wire [1:0] d_io_ctl_op1_sel;
	// Trace: core/Core_5stage.v:99:3
	wire [2:0] d_io_ctl_op2_sel;
	// Trace: core/Core_5stage.v:100:3
	wire [3:0] d_io_ctl_alu_fun;
	// Trace: core/Core_5stage.v:101:3
	wire [1:0] d_io_ctl_wb_sel;
	// Trace: core/Core_5stage.v:102:3
	wire d_io_ctl_rf_wen;
	// Trace: core/Core_5stage.v:103:3
	wire d_io_ctl_mem_val;
	// Trace: core/Core_5stage.v:104:3
	wire [1:0] d_io_ctl_mem_fcn;
	// Trace: core/Core_5stage.v:105:3
	wire [2:0] d_io_ctl_mem_typ;
	// Trace: core/Core_5stage.v:106:3
	wire [2:0] d_io_ctl_csr_cmd;
	// Trace: core/Core_5stage.v:107:3
	wire d_io_ctl_fencei;
	// Trace: core/Core_5stage.v:108:3
	wire d_io_ctl_pipeline_kill;
	// Trace: core/Core_5stage.v:109:3
	wire d_io_ctl_mem_exception;
	// Trace: core/Core_5stage.v:110:3
	wire [31:0] d_io_ctl_mem_exception_cause;
	// Trace: core/Core_5stage.v:111:3
	wire [31:0] d_io_dat_dec_inst;
	// Trace: core/Core_5stage.v:112:3
	wire d_io_dat_dec_valid;
	// Trace: core/Core_5stage.v:113:3
	wire d_io_dat_exe_br_eq;
	// Trace: core/Core_5stage.v:114:3
	wire d_io_dat_exe_br_lt;
	// Trace: core/Core_5stage.v:115:3
	wire d_io_dat_exe_br_ltu;
	// Trace: core/Core_5stage.v:116:3
	wire [3:0] d_io_dat_exe_br_type;
	// Trace: core/Core_5stage.v:117:3
	wire d_io_dat_exe_inst_misaligned;
	// Trace: core/Core_5stage.v:118:3
	wire d_io_dat_mem_ctrl_dmem_val;
	// Trace: core/Core_5stage.v:119:3
	wire d_io_dat_mem_data_misaligned;
	// Trace: core/Core_5stage.v:120:3
	wire d_io_dat_mem_store;
	// Trace: core/Core_5stage.v:121:3
	wire d_io_dat_csr_eret;
	// Trace: core/Core_5stage.v:122:3
	wire d_io_dat_csr_interrupt;
	// Trace: core/Core_5stage.v:123:3
	wire d_io_interrupt_debug;
	// Trace: core/Core_5stage.v:124:3
	wire d_io_interrupt_mtip;
	// Trace: core/Core_5stage.v:125:3
	wire d_io_interrupt_msip;
	// Trace: core/Core_5stage.v:126:3
	wire d_io_interrupt_meip;
	// Trace: core/Core_5stage.v:127:3
	wire d_io_hartid;
	// Trace: core/Core_5stage.v:128:3
	wire [31:0] d_io_reset_vector;
	// Trace: core/Core_5stage.v:129:3
	CtlPath_5stage CtlPath_5stage(
		.clock(c_clock),
		.reset(c_reset),
		.io_dmem_resp_valid(c_io_dmem_resp_valid),
		.io_dat_dec_inst(c_io_dat_dec_inst),
		.io_dat_dec_valid(c_io_dat_dec_valid),
		.io_dat_exe_br_eq(c_io_dat_exe_br_eq),
		.io_dat_exe_br_lt(c_io_dat_exe_br_lt),
		.io_dat_exe_br_ltu(c_io_dat_exe_br_ltu),
		.io_dat_exe_br_type(c_io_dat_exe_br_type),
		.io_dat_exe_inst_misaligned(c_io_dat_exe_inst_misaligned),
		.io_dat_mem_ctrl_dmem_val(c_io_dat_mem_ctrl_dmem_val),
		.io_dat_mem_data_misaligned(c_io_dat_mem_data_misaligned),
		.io_dat_mem_store(c_io_dat_mem_store),
		.io_dat_csr_eret(c_io_dat_csr_eret),
		.io_dat_csr_interrupt(c_io_dat_csr_interrupt),
		.io_ctl_dec_stall(c_io_ctl_dec_stall),
		.io_ctl_full_stall(c_io_ctl_full_stall),
		.io_ctl_exe_pc_sel(c_io_ctl_exe_pc_sel),
		.io_ctl_br_type(c_io_ctl_br_type),
		.io_ctl_if_kill(c_io_ctl_if_kill),
		.io_ctl_dec_kill(c_io_ctl_dec_kill),
		.io_ctl_op1_sel(c_io_ctl_op1_sel),
		.io_ctl_op2_sel(c_io_ctl_op2_sel),
		.io_ctl_alu_fun(c_io_ctl_alu_fun),
		.io_ctl_wb_sel(c_io_ctl_wb_sel),
		.io_ctl_rf_wen(c_io_ctl_rf_wen),
		.io_ctl_mem_val(c_io_ctl_mem_val),
		.io_ctl_mem_fcn(c_io_ctl_mem_fcn),
		.io_ctl_mem_typ(c_io_ctl_mem_typ),
		.io_ctl_csr_cmd(c_io_ctl_csr_cmd),
		.io_ctl_fencei(c_io_ctl_fencei),
		.io_ctl_pipeline_kill(c_io_ctl_pipeline_kill),
		.io_ctl_mem_exception(c_io_ctl_mem_exception),
		.io_ctl_mem_exception_cause(c_io_ctl_mem_exception_cause)
	);
	// Trace: core/Core_5stage.v:165:3
	DatPath_5stage DatPath_5stage(
		.clock(d_clock),
		.reset(d_reset),
		.io_imem_req_valid(d_io_imem_req_valid),
		.io_imem_req_bits_addr(d_io_imem_req_bits_addr),
		.io_imem_resp_valid(d_io_imem_resp_valid),
		.io_imem_resp_bits_data(d_io_imem_resp_bits_data),
		.io_dmem_req_valid(d_io_dmem_req_valid),
		.io_dmem_req_bits_addr(d_io_dmem_req_bits_addr),
		.io_dmem_req_bits_data(d_io_dmem_req_bits_data),
		.io_dmem_req_bits_fcn(d_io_dmem_req_bits_fcn),
		.io_dmem_req_bits_typ(d_io_dmem_req_bits_typ),
		.io_dmem_resp_bits_data(d_io_dmem_resp_bits_data),
		.io_ctl_dec_stall(d_io_ctl_dec_stall),
		.io_ctl_full_stall(d_io_ctl_full_stall),
		.io_ctl_exe_pc_sel(d_io_ctl_exe_pc_sel),
		.io_ctl_br_type(d_io_ctl_br_type),
		.io_ctl_if_kill(d_io_ctl_if_kill),
		.io_ctl_dec_kill(d_io_ctl_dec_kill),
		.io_ctl_op1_sel(d_io_ctl_op1_sel),
		.io_ctl_op2_sel(d_io_ctl_op2_sel),
		.io_ctl_alu_fun(d_io_ctl_alu_fun),
		.io_ctl_wb_sel(d_io_ctl_wb_sel),
		.io_ctl_rf_wen(d_io_ctl_rf_wen),
		.io_ctl_mem_val(d_io_ctl_mem_val),
		.io_ctl_mem_fcn(d_io_ctl_mem_fcn),
		.io_ctl_mem_typ(d_io_ctl_mem_typ),
		.io_ctl_csr_cmd(d_io_ctl_csr_cmd),
		.io_ctl_fencei(d_io_ctl_fencei),
		.io_ctl_pipeline_kill(d_io_ctl_pipeline_kill),
		.io_ctl_mem_exception(d_io_ctl_mem_exception),
		.io_ctl_mem_exception_cause(d_io_ctl_mem_exception_cause),
		.io_dat_dec_inst(d_io_dat_dec_inst),
		.io_dat_dec_valid(d_io_dat_dec_valid),
		.io_dat_exe_br_eq(d_io_dat_exe_br_eq),
		.io_dat_exe_br_lt(d_io_dat_exe_br_lt),
		.io_dat_exe_br_ltu(d_io_dat_exe_br_ltu),
		.io_dat_exe_br_type(d_io_dat_exe_br_type),
		.io_dat_exe_inst_misaligned(d_io_dat_exe_inst_misaligned),
		.io_dat_mem_ctrl_dmem_val(d_io_dat_mem_ctrl_dmem_val),
		.io_dat_mem_data_misaligned(d_io_dat_mem_data_misaligned),
		.io_dat_mem_store(d_io_dat_mem_store),
		.io_dat_csr_eret(d_io_dat_csr_eret),
		.io_dat_csr_interrupt(d_io_dat_csr_interrupt),
		.io_interrupt_debug(d_io_interrupt_debug),
		.io_interrupt_mtip(d_io_interrupt_mtip),
		.io_interrupt_msip(d_io_interrupt_msip),
		.io_interrupt_meip(d_io_interrupt_meip),
		.io_hartid(d_io_hartid),
		.io_reset_vector(d_io_reset_vector),
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
	// Trace: core/Core_5stage.v:239:3
	assign io_imem_req_valid = d_io_imem_req_valid;
	// Trace: core/Core_5stage.v:240:3
	assign io_imem_req_bits_addr = d_io_imem_req_bits_addr;
	// Trace: core/Core_5stage.v:241:3
	assign io_dmem_req_valid = d_io_dmem_req_valid;
	// Trace: core/Core_5stage.v:242:3
	assign io_dmem_req_bits_addr = d_io_dmem_req_bits_addr;
	// Trace: core/Core_5stage.v:243:3
	assign io_dmem_req_bits_data = d_io_dmem_req_bits_data;
	// Trace: core/Core_5stage.v:244:3
	assign io_dmem_req_bits_fcn = d_io_dmem_req_bits_fcn;
	// Trace: core/Core_5stage.v:245:3
	assign io_dmem_req_bits_typ = d_io_dmem_req_bits_typ;
	// Trace: core/Core_5stage.v:246:3
	assign c_clock = clock;
	// Trace: core/Core_5stage.v:247:3
	assign c_reset = reset;
	// Trace: core/Core_5stage.v:248:3
	assign c_io_dmem_resp_valid = io_dmem_resp_valid;
	// Trace: core/Core_5stage.v:249:3
	assign c_io_dat_dec_inst = d_io_dat_dec_inst;
	// Trace: core/Core_5stage.v:250:3
	assign c_io_dat_dec_valid = d_io_dat_dec_valid;
	// Trace: core/Core_5stage.v:251:3
	assign c_io_dat_exe_br_eq = d_io_dat_exe_br_eq;
	// Trace: core/Core_5stage.v:252:3
	assign c_io_dat_exe_br_lt = d_io_dat_exe_br_lt;
	// Trace: core/Core_5stage.v:253:3
	assign c_io_dat_exe_br_ltu = d_io_dat_exe_br_ltu;
	// Trace: core/Core_5stage.v:254:3
	assign c_io_dat_exe_br_type = d_io_dat_exe_br_type;
	// Trace: core/Core_5stage.v:255:3
	assign c_io_dat_exe_inst_misaligned = d_io_dat_exe_inst_misaligned;
	// Trace: core/Core_5stage.v:256:3
	assign c_io_dat_mem_ctrl_dmem_val = d_io_dat_mem_ctrl_dmem_val;
	// Trace: core/Core_5stage.v:257:3
	assign c_io_dat_mem_data_misaligned = d_io_dat_mem_data_misaligned;
	// Trace: core/Core_5stage.v:258:3
	assign c_io_dat_mem_store = d_io_dat_mem_store;
	// Trace: core/Core_5stage.v:259:3
	assign c_io_dat_csr_eret = d_io_dat_csr_eret;
	// Trace: core/Core_5stage.v:260:3
	assign c_io_dat_csr_interrupt = d_io_dat_csr_interrupt;
	// Trace: core/Core_5stage.v:261:3
	assign d_clock = clock;
	// Trace: core/Core_5stage.v:262:3
	assign d_reset = reset;
	// Trace: core/Core_5stage.v:263:3
	assign d_io_imem_resp_valid = io_imem_resp_valid;
	// Trace: core/Core_5stage.v:264:3
	assign d_io_imem_resp_bits_data = io_imem_resp_bits_data;
	// Trace: core/Core_5stage.v:265:3
	assign d_io_dmem_resp_bits_data = io_dmem_resp_bits_data;
	// Trace: core/Core_5stage.v:266:3
	assign d_io_ctl_dec_stall = c_io_ctl_dec_stall;
	// Trace: core/Core_5stage.v:267:3
	assign d_io_ctl_full_stall = c_io_ctl_full_stall;
	// Trace: core/Core_5stage.v:268:3
	assign d_io_ctl_exe_pc_sel = c_io_ctl_exe_pc_sel;
	// Trace: core/Core_5stage.v:269:3
	assign d_io_ctl_br_type = c_io_ctl_br_type;
	// Trace: core/Core_5stage.v:270:3
	assign d_io_ctl_if_kill = c_io_ctl_if_kill;
	// Trace: core/Core_5stage.v:271:3
	assign d_io_ctl_dec_kill = c_io_ctl_dec_kill;
	// Trace: core/Core_5stage.v:272:3
	assign d_io_ctl_op1_sel = c_io_ctl_op1_sel;
	// Trace: core/Core_5stage.v:273:3
	assign d_io_ctl_op2_sel = c_io_ctl_op2_sel;
	// Trace: core/Core_5stage.v:274:3
	assign d_io_ctl_alu_fun = c_io_ctl_alu_fun;
	// Trace: core/Core_5stage.v:275:3
	assign d_io_ctl_wb_sel = c_io_ctl_wb_sel;
	// Trace: core/Core_5stage.v:276:3
	assign d_io_ctl_rf_wen = c_io_ctl_rf_wen;
	// Trace: core/Core_5stage.v:277:3
	assign d_io_ctl_mem_val = c_io_ctl_mem_val;
	// Trace: core/Core_5stage.v:278:3
	assign d_io_ctl_mem_fcn = c_io_ctl_mem_fcn;
	// Trace: core/Core_5stage.v:279:3
	assign d_io_ctl_mem_typ = c_io_ctl_mem_typ;
	// Trace: core/Core_5stage.v:280:3
	assign d_io_ctl_csr_cmd = c_io_ctl_csr_cmd;
	// Trace: core/Core_5stage.v:281:3
	assign d_io_ctl_fencei = c_io_ctl_fencei;
	// Trace: core/Core_5stage.v:282:3
	assign d_io_ctl_pipeline_kill = c_io_ctl_pipeline_kill;
	// Trace: core/Core_5stage.v:283:3
	assign d_io_ctl_mem_exception = c_io_ctl_mem_exception;
	// Trace: core/Core_5stage.v:284:3
	assign d_io_ctl_mem_exception_cause = c_io_ctl_mem_exception_cause;
	// Trace: core/Core_5stage.v:285:3
	assign d_io_interrupt_debug = io_interrupt_debug;
	// Trace: core/Core_5stage.v:286:3
	assign d_io_interrupt_mtip = io_interrupt_mtip;
	// Trace: core/Core_5stage.v:287:3
	assign d_io_interrupt_msip = io_interrupt_msip;
	// Trace: core/Core_5stage.v:288:3
	assign d_io_interrupt_meip = io_interrupt_meip;
	// Trace: core/Core_5stage.v:289:3
	assign d_io_hartid = io_hartid;
	// Trace: core/Core_5stage.v:290:3
	assign d_io_reset_vector = io_reset_vector;
endmodule
