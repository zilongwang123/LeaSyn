module DatPath_5stage (
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
	io_dmem_resp_bits_data,
	io_ctl_dec_stall,
	io_ctl_full_stall,
	io_ctl_exe_pc_sel,
	io_ctl_br_type,
	io_ctl_if_kill,
	io_ctl_dec_kill,
	io_ctl_op1_sel,
	io_ctl_op2_sel,
	io_ctl_alu_fun,
	io_ctl_wb_sel,
	io_ctl_rf_wen,
	io_ctl_mem_val,
	io_ctl_mem_fcn,
	io_ctl_mem_typ,
	io_ctl_csr_cmd,
	io_ctl_fencei,
	io_ctl_pipeline_kill,
	io_ctl_mem_exception,
	io_ctl_mem_exception_cause,
	io_dat_dec_inst,
	io_dat_dec_valid,
	io_dat_exe_br_eq,
	io_dat_exe_br_lt,
	io_dat_exe_br_ltu,
	io_dat_exe_br_type,
	io_dat_exe_inst_misaligned,
	io_dat_mem_ctrl_dmem_val,
	io_dat_mem_data_misaligned,
	io_dat_mem_store,
	io_dat_csr_eret,
	io_dat_csr_interrupt,
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
	// Trace: core/DatPath_5stage.v:18:3
	input clock;
	// Trace: core/DatPath_5stage.v:19:3
	input reset;
	// Trace: core/DatPath_5stage.v:20:3
	output wire io_imem_req_valid;
	// Trace: core/DatPath_5stage.v:21:3
	output wire [31:0] io_imem_req_bits_addr;
	// Trace: core/DatPath_5stage.v:22:3
	input io_imem_resp_valid;
	// Trace: core/DatPath_5stage.v:23:3
	input [31:0] io_imem_resp_bits_data;
	// Trace: core/DatPath_5stage.v:24:3
	output wire io_dmem_req_valid;
	// Trace: core/DatPath_5stage.v:25:3
	output wire [31:0] io_dmem_req_bits_addr;
	// Trace: core/DatPath_5stage.v:26:3
	output wire [31:0] io_dmem_req_bits_data;
	// Trace: core/DatPath_5stage.v:27:3
	output wire io_dmem_req_bits_fcn;
	// Trace: core/DatPath_5stage.v:28:3
	output wire [2:0] io_dmem_req_bits_typ;
	// Trace: core/DatPath_5stage.v:29:3
	input [31:0] io_dmem_resp_bits_data;
	// Trace: core/DatPath_5stage.v:30:3
	input io_ctl_dec_stall;
	// Trace: core/DatPath_5stage.v:31:3
	input io_ctl_full_stall;
	// Trace: core/DatPath_5stage.v:32:3
	input [1:0] io_ctl_exe_pc_sel;
	// Trace: core/DatPath_5stage.v:33:3
	input [3:0] io_ctl_br_type;
	// Trace: core/DatPath_5stage.v:34:3
	input io_ctl_if_kill;
	// Trace: core/DatPath_5stage.v:35:3
	input io_ctl_dec_kill;
	// Trace: core/DatPath_5stage.v:36:3
	input [1:0] io_ctl_op1_sel;
	// Trace: core/DatPath_5stage.v:37:3
	input [2:0] io_ctl_op2_sel;
	// Trace: core/DatPath_5stage.v:38:3
	input [3:0] io_ctl_alu_fun;
	// Trace: core/DatPath_5stage.v:39:3
	input [1:0] io_ctl_wb_sel;
	// Trace: core/DatPath_5stage.v:40:3
	input io_ctl_rf_wen;
	// Trace: core/DatPath_5stage.v:41:3
	input io_ctl_mem_val;
	// Trace: core/DatPath_5stage.v:42:3
	input [1:0] io_ctl_mem_fcn;
	// Trace: core/DatPath_5stage.v:43:3
	input [2:0] io_ctl_mem_typ;
	// Trace: core/DatPath_5stage.v:44:3
	input [2:0] io_ctl_csr_cmd;
	// Trace: core/DatPath_5stage.v:45:3
	input io_ctl_fencei;
	// Trace: core/DatPath_5stage.v:46:3
	input io_ctl_pipeline_kill;
	// Trace: core/DatPath_5stage.v:47:3
	input io_ctl_mem_exception;
	// Trace: core/DatPath_5stage.v:48:3
	input [31:0] io_ctl_mem_exception_cause;
	// Trace: core/DatPath_5stage.v:49:3
	output wire [31:0] io_dat_dec_inst;
	// Trace: core/DatPath_5stage.v:50:3
	output wire io_dat_dec_valid;
	// Trace: core/DatPath_5stage.v:51:3
	output wire io_dat_exe_br_eq;
	// Trace: core/DatPath_5stage.v:52:3
	output wire io_dat_exe_br_lt;
	// Trace: core/DatPath_5stage.v:53:3
	output wire io_dat_exe_br_ltu;
	// Trace: core/DatPath_5stage.v:54:3
	output wire [3:0] io_dat_exe_br_type;
	// Trace: core/DatPath_5stage.v:55:3
	output wire io_dat_exe_inst_misaligned;
	// Trace: core/DatPath_5stage.v:56:3
	output wire io_dat_mem_ctrl_dmem_val;
	// Trace: core/DatPath_5stage.v:57:3
	output wire io_dat_mem_data_misaligned;
	// Trace: core/DatPath_5stage.v:58:3
	output wire io_dat_mem_store;
	// Trace: core/DatPath_5stage.v:59:3
	output wire io_dat_csr_eret;
	// Trace: core/DatPath_5stage.v:60:3
	output wire io_dat_csr_interrupt;
	// Trace: core/DatPath_5stage.v:61:3
	input io_interrupt_debug;
	// Trace: core/DatPath_5stage.v:62:3
	input io_interrupt_mtip;
	// Trace: core/DatPath_5stage.v:63:3
	input io_interrupt_msip;
	// Trace: core/DatPath_5stage.v:64:3
	input io_interrupt_meip;
	// Trace: core/DatPath_5stage.v:65:3
	input io_hartid;
	// Trace: core/DatPath_5stage.v:66:3
	input [31:0] io_reset_vector;
	// Trace: core/DatPath_5stage.v:68:4
	output wire rvfi_valid;
	// Trace: core/DatPath_5stage.v:69:5
	output wire [63:0] rvfi_order;
	// Trace: core/DatPath_5stage.v:70:5
	output wire [31:0] rvfi_insn;
	// Trace: core/DatPath_5stage.v:71:5
	output wire rvfi_trap;
	// Trace: core/DatPath_5stage.v:72:5
	output wire rvfi_halt;
	// Trace: core/DatPath_5stage.v:73:5
	output wire rvfi_intr;
	// Trace: core/DatPath_5stage.v:74:5
	output wire [1:0] rvfi_mode;
	// Trace: core/DatPath_5stage.v:75:5
	output wire [1:0] rvfi_ixl;
	// Trace: core/DatPath_5stage.v:76:5
	output wire [4:0] rvfi_rs1_addr;
	// Trace: core/DatPath_5stage.v:77:5
	output wire [4:0] rvfi_rs2_addr;
	// Trace: core/DatPath_5stage.v:78:5
	output wire [4:0] rvfi_rs3_addr;
	// Trace: core/DatPath_5stage.v:79:5
	output wire [31:0] rvfi_rs1_rdata;
	// Trace: core/DatPath_5stage.v:80:5
	output wire [31:0] rvfi_rs2_rdata;
	// Trace: core/DatPath_5stage.v:81:5
	output wire [31:0] rvfi_rs3_rdata;
	// Trace: core/DatPath_5stage.v:82:5
	output wire [4:0] rvfi_rd_addr;
	// Trace: core/DatPath_5stage.v:83:5
	output wire [31:0] rvfi_rd_wdata;
	// Trace: core/DatPath_5stage.v:84:5
	output wire [31:0] rvfi_pc_rdata;
	// Trace: core/DatPath_5stage.v:85:5
	output wire [31:0] rvfi_pc_wdata;
	// Trace: core/DatPath_5stage.v:86:5
	output wire [31:0] rvfi_mem_addr;
	// Trace: core/DatPath_5stage.v:87:5
	output wire [3:0] rvfi_mem_rmask;
	// Trace: core/DatPath_5stage.v:88:5
	output wire [3:0] rvfi_mem_wmask;
	// Trace: core/DatPath_5stage.v:89:5
	output wire [31:0] rvfi_mem_rdata;
	// Trace: core/DatPath_5stage.v:90:5
	output wire [31:0] rvfi_mem_wdata;
	// Trace: core/DatPath_5stage.v:145:3
	wire if_buffer_out_clock;
	// Trace: core/DatPath_5stage.v:146:3
	wire if_buffer_out_reset;
	// Trace: core/DatPath_5stage.v:147:3
	wire if_buffer_out_io_enq_ready;
	// Trace: core/DatPath_5stage.v:148:3
	wire if_buffer_out_io_enq_valid;
	// Trace: core/DatPath_5stage.v:149:3
	wire [31:0] if_buffer_out_io_enq_bits_data;
	// Trace: core/DatPath_5stage.v:150:3
	wire if_buffer_out_io_deq_ready;
	// Trace: core/DatPath_5stage.v:151:3
	wire if_buffer_out_io_deq_valid;
	// Trace: core/DatPath_5stage.v:152:3
	wire [31:0] if_buffer_out_io_deq_bits_data;
	// Trace: core/DatPath_5stage.v:153:3
	wire if_pc_buffer_out_clock;
	// Trace: core/DatPath_5stage.v:154:3
	wire if_pc_buffer_out_reset;
	// Trace: core/DatPath_5stage.v:155:3
	wire if_pc_buffer_out_io_enq_ready;
	// Trace: core/DatPath_5stage.v:156:3
	wire if_pc_buffer_out_io_enq_valid;
	// Trace: core/DatPath_5stage.v:157:3
	wire [31:0] if_pc_buffer_out_io_enq_bits;
	// Trace: core/DatPath_5stage.v:158:3
	wire if_pc_buffer_out_io_deq_ready;
	// Trace: core/DatPath_5stage.v:159:3
	wire if_pc_buffer_out_io_deq_valid;
	// Trace: core/DatPath_5stage.v:160:3
	wire [31:0] if_pc_buffer_out_io_deq_bits;
	// Trace: core/DatPath_5stage.v:161:3
	wire regfile_clock;
	// Trace: core/DatPath_5stage.v:162:3
	wire [4:0] regfile_io_rs1_addr;
	// Trace: core/DatPath_5stage.v:163:3
	wire [31:0] regfile_io_rs1_data;
	// Trace: core/DatPath_5stage.v:164:3
	wire [4:0] regfile_io_rs2_addr;
	// Trace: core/DatPath_5stage.v:165:3
	wire [31:0] regfile_io_rs2_data;
	// Trace: core/DatPath_5stage.v:166:3
	wire [4:0] regfile_io_waddr;
	// Trace: core/DatPath_5stage.v:167:3
	wire [31:0] regfile_io_wdata;
	// Trace: core/DatPath_5stage.v:168:3
	wire regfile_io_wen;
	// Trace: core/DatPath_5stage.v:169:3
	wire csr_clock;
	// Trace: core/DatPath_5stage.v:170:3
	wire csr_reset;
	// Trace: core/DatPath_5stage.v:171:3
	wire csr_io_ungated_clock;
	// Trace: core/DatPath_5stage.v:172:3
	wire csr_io_interrupts_debug;
	// Trace: core/DatPath_5stage.v:173:3
	wire csr_io_interrupts_mtip;
	// Trace: core/DatPath_5stage.v:174:3
	wire csr_io_interrupts_msip;
	// Trace: core/DatPath_5stage.v:175:3
	wire csr_io_interrupts_meip;
	// Trace: core/DatPath_5stage.v:176:3
	wire csr_io_hartid;
	// Trace: core/DatPath_5stage.v:177:3
	wire [11:0] csr_io_rw_addr;
	// Trace: core/DatPath_5stage.v:178:3
	wire [2:0] csr_io_rw_cmd;
	// Trace: core/DatPath_5stage.v:179:3
	wire [31:0] csr_io_rw_rdata;
	// Trace: core/DatPath_5stage.v:180:3
	wire [31:0] csr_io_rw_wdata;
	// Trace: core/DatPath_5stage.v:181:3
	wire csr_io_csr_stall;
	// Trace: core/DatPath_5stage.v:182:3
	wire csr_io_eret;
	// Trace: core/DatPath_5stage.v:183:3
	wire csr_io_singleStep;
	// Trace: core/DatPath_5stage.v:184:3
	wire csr_io_status_debug;
	// Trace: core/DatPath_5stage.v:185:3
	wire csr_io_status_cease;
	// Trace: core/DatPath_5stage.v:186:3
	wire csr_io_status_wfi;
	// Trace: core/DatPath_5stage.v:187:3
	wire [31:0] csr_io_status_isa;
	// Trace: core/DatPath_5stage.v:188:3
	wire [1:0] csr_io_status_dprv;
	// Trace: core/DatPath_5stage.v:189:3
	wire csr_io_status_dv;
	// Trace: core/DatPath_5stage.v:190:3
	wire [1:0] csr_io_status_prv;
	// Trace: core/DatPath_5stage.v:191:3
	wire csr_io_status_v;
	// Trace: core/DatPath_5stage.v:192:3
	wire csr_io_status_sd;
	// Trace: core/DatPath_5stage.v:193:3
	wire [22:0] csr_io_status_zero2;
	// Trace: core/DatPath_5stage.v:194:3
	wire csr_io_status_mpv;
	// Trace: core/DatPath_5stage.v:195:3
	wire csr_io_status_gva;
	// Trace: core/DatPath_5stage.v:196:3
	wire csr_io_status_mbe;
	// Trace: core/DatPath_5stage.v:197:3
	wire csr_io_status_sbe;
	// Trace: core/DatPath_5stage.v:198:3
	wire [1:0] csr_io_status_sxl;
	// Trace: core/DatPath_5stage.v:199:3
	wire [1:0] csr_io_status_uxl;
	// Trace: core/DatPath_5stage.v:200:3
	wire csr_io_status_sd_rv32;
	// Trace: core/DatPath_5stage.v:201:3
	wire [7:0] csr_io_status_zero1;
	// Trace: core/DatPath_5stage.v:202:3
	wire csr_io_status_tsr;
	// Trace: core/DatPath_5stage.v:203:3
	wire csr_io_status_tw;
	// Trace: core/DatPath_5stage.v:204:3
	wire csr_io_status_tvm;
	// Trace: core/DatPath_5stage.v:205:3
	wire csr_io_status_mxr;
	// Trace: core/DatPath_5stage.v:206:3
	wire csr_io_status_sum;
	// Trace: core/DatPath_5stage.v:207:3
	wire csr_io_status_mprv;
	// Trace: core/DatPath_5stage.v:208:3
	wire [1:0] csr_io_status_xs;
	// Trace: core/DatPath_5stage.v:209:3
	wire [1:0] csr_io_status_fs;
	// Trace: core/DatPath_5stage.v:210:3
	wire [1:0] csr_io_status_mpp;
	// Trace: core/DatPath_5stage.v:211:3
	wire [1:0] csr_io_status_vs;
	// Trace: core/DatPath_5stage.v:212:3
	wire csr_io_status_spp;
	// Trace: core/DatPath_5stage.v:213:3
	wire csr_io_status_mpie;
	// Trace: core/DatPath_5stage.v:214:3
	wire csr_io_status_ube;
	// Trace: core/DatPath_5stage.v:215:3
	wire csr_io_status_spie;
	// Trace: core/DatPath_5stage.v:216:3
	wire csr_io_status_upie;
	// Trace: core/DatPath_5stage.v:217:3
	wire csr_io_status_mie;
	// Trace: core/DatPath_5stage.v:218:3
	wire csr_io_status_hie;
	// Trace: core/DatPath_5stage.v:219:3
	wire csr_io_status_sie;
	// Trace: core/DatPath_5stage.v:220:3
	wire csr_io_status_uie;
	// Trace: core/DatPath_5stage.v:221:3
	wire [31:0] csr_io_evec;
	// Trace: core/DatPath_5stage.v:222:3
	wire csr_io_exception;
	// Trace: core/DatPath_5stage.v:223:3
	wire csr_io_retire;
	// Trace: core/DatPath_5stage.v:224:3
	wire [31:0] csr_io_cause;
	// Trace: core/DatPath_5stage.v:225:3
	wire [31:0] csr_io_pc;
	// Trace: core/DatPath_5stage.v:226:3
	wire [31:0] csr_io_tval;
	// Trace: core/DatPath_5stage.v:227:3
	wire [31:0] csr_io_time;
	// Trace: core/DatPath_5stage.v:228:3
	wire csr_io_interrupt;
	// Trace: core/DatPath_5stage.v:229:3
	wire [31:0] csr_io_interrupt_cause;
	// Trace: core/DatPath_5stage.v:230:3
	reg [31:0] if_reg_pc;
	// Trace: core/DatPath_5stage.v:231:3
	reg dec_reg_valid;
	// Trace: core/DatPath_5stage.v:232:3
	reg [31:0] dec_reg_inst;
	// Trace: core/DatPath_5stage.v:233:3
	reg [31:0] dec_reg_pc;
	// Trace: core/DatPath_5stage.v:234:3
	reg exe_reg_valid;
	// Trace: core/DatPath_5stage.v:235:3
	reg [31:0] exe_reg_inst;
	// Trace: core/DatPath_5stage.v:236:3
	reg [31:0] exe_reg_pc;
	// Trace: core/DatPath_5stage.v:237:3
	reg [4:0] exe_reg_wbaddr;
	// Trace: core/DatPath_5stage.v:238:3
	reg [4:0] exe_reg_rs1_addr;
	// Trace: core/DatPath_5stage.v:239:3
	reg [4:0] exe_reg_rs2_addr;
	// Trace: core/DatPath_5stage.v:240:3
	reg [31:0] exe_alu_op1;
	// Trace: core/DatPath_5stage.v:241:3
	reg [31:0] brjmp_offset;
	// Trace: core/DatPath_5stage.v:242:3
	reg [31:0] exe_reg_rs2_data;
	// Trace: core/DatPath_5stage.v:243:3
	reg [3:0] exe_reg_ctrl_br_type;
	// Trace: core/DatPath_5stage.v:244:3
	reg [3:0] exe_reg_ctrl_alu_fun;
	// Trace: core/DatPath_5stage.v:245:3
	reg [1:0] exe_reg_ctrl_wb_sel;
	// Trace: core/DatPath_5stage.v:246:3
	reg exe_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:247:3
	reg exe_reg_ctrl_mem_val;
	// Trace: core/DatPath_5stage.v:248:3
	reg exe_reg_ctrl_mem_fcn;
	// Trace: core/DatPath_5stage.v:249:3
	reg [2:0] exe_reg_ctrl_mem_typ;
	// Trace: core/DatPath_5stage.v:250:3
	reg [2:0] exe_reg_ctrl_csr_cmd;
	// Trace: core/DatPath_5stage.v:251:3
	reg mem_reg_valid;
	// Trace: core/DatPath_5stage.v:252:3
	reg [31:0] mem_reg_pc;
	// Trace: core/DatPath_5stage.v:253:3
	reg [31:0] mem_reg_inst;
	// Trace: core/DatPath_5stage.v:254:3
	reg [31:0] mem_reg_alu_out;
	// Trace: core/DatPath_5stage.v:255:3
	reg [4:0] mem_reg_wbaddr;
	// Trace: core/DatPath_5stage.v:256:3
	reg [4:0] mem_reg_rs1_addr;
	// Trace: core/DatPath_5stage.v:257:3
	reg [4:0] mem_reg_rs2_addr;
	// Trace: core/DatPath_5stage.v:258:3
	reg [31:0] mem_reg_op1_data;
	// Trace: core/DatPath_5stage.v:259:3
	reg [31:0] mem_reg_op2_data;
	// Trace: core/DatPath_5stage.v:260:3
	reg [31:0] mem_reg_rs2_data;
	// Trace: core/DatPath_5stage.v:261:3
	reg mem_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:262:3
	reg mem_reg_ctrl_mem_val;
	// Trace: core/DatPath_5stage.v:263:3
	reg mem_reg_ctrl_mem_fcn;
	// Trace: core/DatPath_5stage.v:264:3
	reg [2:0] mem_reg_ctrl_mem_typ;
	// Trace: core/DatPath_5stage.v:265:3
	reg [1:0] mem_reg_ctrl_wb_sel;
	// Trace: core/DatPath_5stage.v:266:3
	reg [2:0] mem_reg_ctrl_csr_cmd;
	// Trace: core/DatPath_5stage.v:267:3
	reg wb_reg_valid;
	// Trace: core/DatPath_5stage.v:268:3
	reg [4:0] wb_reg_wbaddr;
	// Trace: core/DatPath_5stage.v:269:3
	reg [31:0] wb_reg_wbdata;
	// Trace: core/DatPath_5stage.v:270:3
	reg wb_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:271:3
	wire if_buffer_in_ready = if_buffer_out_io_enq_ready;
	// Trace: core/DatPath_5stage.v:272:3
	wire _T_4 = ~reset;
	// Trace: core/DatPath_5stage.v:273:3
	wire _if_buffer_out_io_deq_ready_T = ~io_ctl_dec_stall;
	// Trace: core/DatPath_5stage.v:274:3
	wire _if_buffer_out_io_deq_ready_T_1 = ~io_ctl_full_stall;
	// Trace: core/DatPath_5stage.v:275:3
	wire _if_buffer_out_io_deq_ready_T_2 = ~io_ctl_dec_stall & ~io_ctl_full_stall;
	// Trace: core/DatPath_5stage.v:276:3
	reg if_reg_killed;
	// Trace: core/DatPath_5stage.v:277:3
	wire _T_7 = if_buffer_out_io_deq_ready & if_buffer_out_io_deq_valid;
	// Trace: core/DatPath_5stage.v:278:3
	wire _T_9 = (io_ctl_pipeline_kill | io_ctl_if_kill) & ~_T_7;
	// Trace: core/DatPath_5stage.v:279:3
	wire _GEN_0 = _T_9 | if_reg_killed;
	// Trace: core/DatPath_5stage.v:280:3
	wire _T_11 = if_reg_killed & _T_7;
	// Trace: core/DatPath_5stage.v:281:3
	wire _T_12 = if_buffer_in_ready & io_imem_resp_valid;
	// Trace: core/DatPath_5stage.v:282:3
	wire _T_16 = ((_T_12 & ~if_reg_killed) | io_ctl_if_kill) | io_ctl_pipeline_kill;
	// Trace: core/DatPath_5stage.v:283:3
	wire _T_17 = io_ctl_exe_pc_sel == 2'h0;
	// Trace: core/DatPath_5stage.v:284:3
	wire _T_20 = (io_ctl_fencei & (io_ctl_exe_pc_sel == 2'h0)) & _if_buffer_out_io_deq_ready_T;
	// Trace: core/DatPath_5stage.v:285:3
	wire _T_24 = (_T_20 & _if_buffer_out_io_deq_ready_T_1) & ~io_ctl_pipeline_kill;
	// Trace: core/DatPath_5stage.v:286:3
	wire [31:0] if_pc_plus4 = if_reg_pc + 32'h00000004;
	// Trace: core/DatPath_5stage.v:287:3
	wire _if_pc_next_T_1 = io_ctl_exe_pc_sel == 2'h1;
	// Trace: core/DatPath_5stage.v:288:3
	wire [31:0] exe_brjmp_target = exe_reg_pc + brjmp_offset;
	// Trace: core/DatPath_5stage.v:289:3
	wire _if_pc_next_T_2 = io_ctl_exe_pc_sel == 2'h2;
	// Trace: core/DatPath_5stage.v:290:3
	wire [31:0] exe_adder_out = exe_alu_op1 + brjmp_offset;
	// Trace: core/DatPath_5stage.v:291:3
	wire [31:0] exe_jump_reg_target = exe_adder_out & 32'hfffffffe;
	// Trace: core/DatPath_5stage.v:292:3
	wire [31:0] exception_target = csr_io_evec;
	// Trace: core/DatPath_5stage.v:293:3
	wire [31:0] _if_pc_next_T_3 = (io_ctl_exe_pc_sel == 2'h2 ? exe_jump_reg_target : exception_target);
	// Trace: core/DatPath_5stage.v:294:3
	wire [31:0] _if_pc_next_T_4 = (io_ctl_exe_pc_sel == 2'h1 ? exe_brjmp_target : _if_pc_next_T_3);
	// Trace: core/DatPath_5stage.v:295:3
	wire _T_28 = io_ctl_if_kill | if_reg_killed;
	// Trace: core/DatPath_5stage.v:296:3
	wire _GEN_4 = if_buffer_out_io_deq_valid;
	// Trace: core/DatPath_5stage.v:297:3
	wire [31:0] _GEN_5 = (if_buffer_out_io_deq_valid ? if_buffer_out_io_deq_bits_data : 32'h00004033);
	// Trace: core/DatPath_5stage.v:298:3
	wire [4:0] dec_rs1_addr = dec_reg_inst[19:15];
	// Trace: core/DatPath_5stage.v:299:3
	wire [4:0] dec_rs2_addr = dec_reg_inst[24:20];
	// Trace: core/DatPath_5stage.v:300:3
	wire [4:0] dec_wbaddr = dec_reg_inst[11:7];
	// Trace: core/DatPath_5stage.v:301:3
	wire [11:0] imm_itype = dec_reg_inst[31:20];
	// Trace: core/DatPath_5stage.v:302:3
	wire [11:0] imm_stype = {dec_reg_inst[31:25], dec_wbaddr};
	// Trace: core/DatPath_5stage.v:303:3
	wire [11:0] imm_sbtype = {dec_reg_inst[31], dec_reg_inst[7], dec_reg_inst[30:25], dec_reg_inst[11:8]};
	// Trace: core/DatPath_5stage.v:304:3
	wire [19:0] imm_utype = dec_reg_inst[31:12];
	// Trace: core/DatPath_5stage.v:305:3
	wire [19:0] imm_ujtype = {dec_reg_inst[31], dec_reg_inst[19:12], dec_reg_inst[20], dec_reg_inst[30:21]};
	// Trace: core/DatPath_5stage.v:306:3
	wire [31:0] imm_z = {27'h0000000, dec_rs1_addr};
	// Trace: core/DatPath_5stage.v:307:3
	wire [19:0] _imm_itype_sext_T_2 = (imm_itype[11] ? 20'hfffff : 20'h00000);
	// Trace: core/DatPath_5stage.v:308:3
	wire [31:0] imm_itype_sext = {_imm_itype_sext_T_2, imm_itype};
	// Trace: core/DatPath_5stage.v:309:3
	wire [19:0] _imm_stype_sext_T_2 = (imm_stype[11] ? 20'hfffff : 20'h00000);
	// Trace: core/DatPath_5stage.v:310:3
	wire [31:0] imm_stype_sext = {_imm_stype_sext_T_2, dec_reg_inst[31:25], dec_wbaddr};
	// Trace: core/DatPath_5stage.v:311:3
	wire [18:0] _imm_sbtype_sext_T_2 = (imm_sbtype[11] ? 19'h7ffff : 19'h00000);
	// Trace: core/DatPath_5stage.v:312:3
	wire [31:0] imm_sbtype_sext = {_imm_sbtype_sext_T_2, dec_reg_inst[31], dec_reg_inst[7], dec_reg_inst[30:25], dec_reg_inst[11:8], 1'h0};
	// Trace: core/DatPath_5stage.v:314:3
	wire [31:0] imm_utype_sext = {imm_utype, 12'h000};
	// Trace: core/DatPath_5stage.v:315:3
	wire [10:0] _imm_ujtype_sext_T_2 = (imm_ujtype[19] ? 11'h7ff : 11'h000);
	// Trace: core/DatPath_5stage.v:316:3
	wire [31:0] imm_ujtype_sext = {_imm_ujtype_sext_T_2, dec_reg_inst[31], dec_reg_inst[19:12], dec_reg_inst[20], dec_reg_inst[30:21], 1'h0};
	// Trace: core/DatPath_5stage.v:318:3
	wire _dec_alu_op2_T = io_ctl_op2_sel == 3'h0;
	// Trace: core/DatPath_5stage.v:319:3
	wire _dec_alu_op2_T_1 = io_ctl_op2_sel == 3'h1;
	// Trace: core/DatPath_5stage.v:320:3
	wire _dec_alu_op2_T_2 = io_ctl_op2_sel == 3'h2;
	// Trace: core/DatPath_5stage.v:321:3
	wire _dec_alu_op2_T_3 = io_ctl_op2_sel == 3'h3;
	// Trace: core/DatPath_5stage.v:322:3
	wire _dec_alu_op2_T_4 = io_ctl_op2_sel == 3'h4;
	// Trace: core/DatPath_5stage.v:323:3
	wire _dec_alu_op2_T_5 = io_ctl_op2_sel == 3'h5;
	// Trace: core/DatPath_5stage.v:324:3
	wire [31:0] _dec_alu_op2_T_6 = (_dec_alu_op2_T_5 ? imm_ujtype_sext : 32'h00000000);
	// Trace: core/DatPath_5stage.v:325:3
	wire [31:0] _dec_alu_op2_T_7 = (_dec_alu_op2_T_4 ? imm_utype_sext : _dec_alu_op2_T_6);
	// Trace: core/DatPath_5stage.v:326:3
	wire [31:0] _dec_alu_op2_T_8 = (_dec_alu_op2_T_3 ? imm_sbtype_sext : _dec_alu_op2_T_7);
	// Trace: core/DatPath_5stage.v:327:3
	wire [31:0] _dec_alu_op2_T_9 = (_dec_alu_op2_T_2 ? imm_stype_sext : _dec_alu_op2_T_8);
	// Trace: core/DatPath_5stage.v:328:3
	wire [31:0] _dec_alu_op2_T_10 = (_dec_alu_op2_T_1 ? imm_itype_sext : _dec_alu_op2_T_9);
	// Trace: core/DatPath_5stage.v:329:3
	wire [31:0] dec_alu_op2 = (_dec_alu_op2_T ? regfile_io_rs2_data : _dec_alu_op2_T_10);
	// Trace: core/DatPath_5stage.v:330:3
	wire _dec_op1_data_T = io_ctl_op1_sel == 2'h2;
	// Trace: core/DatPath_5stage.v:331:3
	wire _dec_op1_data_T_1 = io_ctl_op1_sel == 2'h1;
	// Trace: core/DatPath_5stage.v:332:3
	wire _dec_op1_data_T_3 = dec_rs1_addr != 5'h00;
	// Trace: core/DatPath_5stage.v:333:3
	wire _dec_op1_data_T_5 = ((exe_reg_wbaddr == dec_rs1_addr) & (dec_rs1_addr != 5'h00)) & exe_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:334:3
	wire _dec_op1_data_T_9 = ((mem_reg_wbaddr == dec_rs1_addr) & _dec_op1_data_T_3) & mem_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:335:3
	wire _dec_op1_data_T_13 = ((wb_reg_wbaddr == dec_rs1_addr) & _dec_op1_data_T_3) & wb_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:336:3
	wire [31:0] _dec_op1_data_T_14 = (_dec_op1_data_T_13 ? wb_reg_wbdata : regfile_io_rs1_data);
	// Trace: core/DatPath_5stage.v:337:3
	wire _mem_wbdata_T = mem_reg_ctrl_wb_sel == 2'h0;
	// Trace: core/DatPath_5stage.v:338:3
	wire _mem_wbdata_T_1 = mem_reg_ctrl_wb_sel == 2'h2;
	// Trace: core/DatPath_5stage.v:339:3
	wire _mem_wbdata_T_2 = mem_reg_ctrl_wb_sel == 2'h1;
	// Trace: core/DatPath_5stage.v:340:3
	wire _mem_wbdata_T_3 = mem_reg_ctrl_wb_sel == 2'h3;
	// Trace: core/DatPath_5stage.v:341:3
	wire [31:0] _mem_wbdata_T_4 = (_mem_wbdata_T_3 ? csr_io_rw_rdata : mem_reg_alu_out);
	// Trace: core/DatPath_5stage.v:342:3
	wire [31:0] _mem_wbdata_T_5 = (_mem_wbdata_T_2 ? io_dmem_resp_bits_data : _mem_wbdata_T_4);
	// Trace: core/DatPath_5stage.v:343:3
	wire [31:0] _mem_wbdata_T_6 = (_mem_wbdata_T_1 ? mem_reg_alu_out : _mem_wbdata_T_5);
	// Trace: core/DatPath_5stage.v:344:3
	wire [31:0] mem_wbdata = (_mem_wbdata_T ? mem_reg_alu_out : _mem_wbdata_T_6);
	// Trace: core/DatPath_5stage.v:345:3
	wire [31:0] _dec_op1_data_T_15 = (_dec_op1_data_T_9 ? mem_wbdata : _dec_op1_data_T_14);
	// Trace: core/DatPath_5stage.v:346:3
	wire _exe_alu_out_T = exe_reg_ctrl_alu_fun == 4'h0;
	// Trace: core/DatPath_5stage.v:347:3
	wire _exe_alu_out_T_1 = exe_reg_ctrl_alu_fun == 4'h1;
	// Trace: core/DatPath_5stage.v:348:3
	wire [31:0] _exe_alu_out_T_3 = exe_alu_op1 - brjmp_offset;
	// Trace: core/DatPath_5stage.v:349:3
	wire _exe_alu_out_T_4 = exe_reg_ctrl_alu_fun == 4'h5;
	// Trace: core/DatPath_5stage.v:350:3
	wire [31:0] _exe_alu_out_T_5 = exe_alu_op1 & brjmp_offset;
	// Trace: core/DatPath_5stage.v:351:3
	wire _exe_alu_out_T_6 = exe_reg_ctrl_alu_fun == 4'h6;
	// Trace: core/DatPath_5stage.v:352:3
	wire [31:0] _exe_alu_out_T_7 = exe_alu_op1 | brjmp_offset;
	// Trace: core/DatPath_5stage.v:353:3
	wire _exe_alu_out_T_8 = exe_reg_ctrl_alu_fun == 4'h7;
	// Trace: core/DatPath_5stage.v:354:3
	wire [31:0] _exe_alu_out_T_9 = exe_alu_op1 ^ brjmp_offset;
	// Trace: core/DatPath_5stage.v:355:3
	wire _exe_alu_out_T_10 = exe_reg_ctrl_alu_fun == 4'h8;
	// Trace: core/DatPath_5stage.v:356:3
	wire _exe_alu_out_T_13 = $signed(exe_alu_op1) < $signed(brjmp_offset);
	// Trace: core/DatPath_5stage.v:357:3
	wire _exe_alu_out_T_14 = exe_reg_ctrl_alu_fun == 4'h9;
	// Trace: core/DatPath_5stage.v:358:3
	wire _exe_alu_out_T_15 = exe_alu_op1 < brjmp_offset;
	// Trace: core/DatPath_5stage.v:359:3
	wire _exe_alu_out_T_16 = exe_reg_ctrl_alu_fun == 4'h2;
	// Trace: core/DatPath_5stage.v:360:3
	wire [4:0] alu_shamt = brjmp_offset[4:0];
	// Trace: core/DatPath_5stage.v:361:3
	wire [62:0] _GEN_3 = {31'd0, exe_alu_op1};
	// Trace: core/DatPath_5stage.v:362:3
	wire [62:0] _exe_alu_out_T_17 = _GEN_3 << alu_shamt;
	// Trace: core/DatPath_5stage.v:363:3
	wire _exe_alu_out_T_19 = exe_reg_ctrl_alu_fun == 4'h4;
	// Trace: core/DatPath_5stage.v:364:3
	wire [31:0] _exe_alu_out_T_22 = $signed(exe_alu_op1) >>> alu_shamt;
	// Trace: core/DatPath_5stage.v:365:3
	wire _exe_alu_out_T_23 = exe_reg_ctrl_alu_fun == 4'h3;
	// Trace: core/DatPath_5stage.v:366:3
	wire [31:0] _exe_alu_out_T_24 = exe_alu_op1 >> alu_shamt;
	// Trace: core/DatPath_5stage.v:367:3
	wire _exe_alu_out_T_25 = exe_reg_ctrl_alu_fun == 4'ha;
	// Trace: core/DatPath_5stage.v:368:3
	wire _exe_alu_out_T_26 = exe_reg_ctrl_alu_fun == 4'hb;
	// Trace: core/DatPath_5stage.v:369:3
	wire [31:0] _exe_alu_out_T_27 = (_exe_alu_out_T_26 ? brjmp_offset : exe_reg_inst);
	// Trace: core/DatPath_5stage.v:370:3
	wire [31:0] _exe_alu_out_T_28 = (_exe_alu_out_T_25 ? exe_alu_op1 : _exe_alu_out_T_27);
	// Trace: core/DatPath_5stage.v:371:3
	wire [31:0] _exe_alu_out_T_29 = (_exe_alu_out_T_23 ? _exe_alu_out_T_24 : _exe_alu_out_T_28);
	// Trace: core/DatPath_5stage.v:372:3
	wire [31:0] _exe_alu_out_T_30 = (_exe_alu_out_T_19 ? _exe_alu_out_T_22 : _exe_alu_out_T_29);
	// Trace: core/DatPath_5stage.v:373:3
	wire [31:0] _exe_alu_out_T_31 = (_exe_alu_out_T_16 ? _exe_alu_out_T_17[31:0] : _exe_alu_out_T_30);
	// Trace: core/DatPath_5stage.v:374:3
	wire [31:0] _exe_alu_out_T_32 = (_exe_alu_out_T_14 ? {31'd0, _exe_alu_out_T_15} : _exe_alu_out_T_31);
	// Trace: core/DatPath_5stage.v:375:3
	wire [31:0] _exe_alu_out_T_33 = (_exe_alu_out_T_10 ? {31'd0, _exe_alu_out_T_13} : _exe_alu_out_T_32);
	// Trace: core/DatPath_5stage.v:376:3
	wire [31:0] _exe_alu_out_T_34 = (_exe_alu_out_T_8 ? _exe_alu_out_T_9 : _exe_alu_out_T_33);
	// Trace: core/DatPath_5stage.v:377:3
	wire [31:0] _exe_alu_out_T_35 = (_exe_alu_out_T_6 ? _exe_alu_out_T_7 : _exe_alu_out_T_34);
	// Trace: core/DatPath_5stage.v:378:3
	wire [31:0] _exe_alu_out_T_36 = (_exe_alu_out_T_4 ? _exe_alu_out_T_5 : _exe_alu_out_T_35);
	// Trace: core/DatPath_5stage.v:379:3
	wire [31:0] _exe_alu_out_T_37 = (_exe_alu_out_T_1 ? _exe_alu_out_T_3 : _exe_alu_out_T_36);
	// Trace: core/DatPath_5stage.v:380:3
	wire [31:0] exe_alu_out = (_exe_alu_out_T ? exe_adder_out : _exe_alu_out_T_37);
	// Trace: core/DatPath_5stage.v:381:3
	wire [31:0] _dec_op1_data_T_16 = (_dec_op1_data_T_5 ? exe_alu_out : _dec_op1_data_T_15);
	// Trace: core/DatPath_5stage.v:382:3
	wire _dec_op2_data_T_1 = dec_rs2_addr != 5'h00;
	// Trace: core/DatPath_5stage.v:383:3
	wire _dec_op2_data_T_3 = ((exe_reg_wbaddr == dec_rs2_addr) & (dec_rs2_addr != 5'h00)) & exe_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:384:3
	wire _dec_op2_data_T_5 = (((exe_reg_wbaddr == dec_rs2_addr) & (dec_rs2_addr != 5'h00)) & exe_reg_ctrl_rf_wen) & _dec_alu_op2_T;
	// Trace: core/DatPath_5stage.v:386:3
	wire _dec_op2_data_T_9 = ((mem_reg_wbaddr == dec_rs2_addr) & _dec_op2_data_T_1) & mem_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:387:3
	wire _dec_op2_data_T_11 = (((mem_reg_wbaddr == dec_rs2_addr) & _dec_op2_data_T_1) & mem_reg_ctrl_rf_wen) & _dec_alu_op2_T;
	// Trace: core/DatPath_5stage.v:388:3
	wire _dec_op2_data_T_15 = ((wb_reg_wbaddr == dec_rs2_addr) & _dec_op2_data_T_1) & wb_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:389:3
	wire _dec_op2_data_T_17 = (((wb_reg_wbaddr == dec_rs2_addr) & _dec_op2_data_T_1) & wb_reg_ctrl_rf_wen) & _dec_alu_op2_T;
	// Trace: core/DatPath_5stage.v:390:3
	wire [31:0] _dec_op2_data_T_18 = (_dec_op2_data_T_17 ? wb_reg_wbdata : dec_alu_op2);
	// Trace: core/DatPath_5stage.v:391:3
	wire [31:0] _dec_rs2_data_T_12 = (_dec_op2_data_T_15 ? wb_reg_wbdata : regfile_io_rs2_data);
	// Trace: core/DatPath_5stage.v:392:3
	wire _T_31 = (io_ctl_dec_stall & _if_buffer_out_io_deq_ready_T_1) | io_ctl_pipeline_kill;
	// Trace: core/DatPath_5stage.v:393:3
	wire [1:0] _GEN_19 = (io_ctl_dec_kill ? 2'h0 : io_ctl_mem_fcn);
	// Trace: core/DatPath_5stage.v:394:3
	wire [1:0] _GEN_37 = (_if_buffer_out_io_deq_ready_T_2 ? _GEN_19 : {1'd0, exe_reg_ctrl_mem_fcn});
	// Trace: core/DatPath_5stage.v:395:3
	wire [1:0] _GEN_46 = (_T_31 ? 2'h0 : _GEN_37);
	// Trace: core/DatPath_5stage.v:396:3
	wire _io_dat_exe_inst_misaligned_T_7 = |exe_jump_reg_target[1:0] & _if_pc_next_T_2;
	// Trace: core/DatPath_5stage.v:397:3
	reg [31:0] mem_tval_inst_ma_REG;
	// Trace: core/DatPath_5stage.v:398:3
	wire [31:0] exe_pc_plus4 = exe_reg_pc + 32'h00000004;
	// Trace: core/DatPath_5stage.v:399:3
	wire _csr_io_tval_T = io_ctl_mem_exception_cause == 32'h00000002;
	// Trace: core/DatPath_5stage.v:400:3
	reg [31:0] csr_io_tval_REG;
	// Trace: core/DatPath_5stage.v:401:3
	wire _csr_io_tval_T_1 = io_ctl_mem_exception_cause == 32'h00000000;
	// Trace: core/DatPath_5stage.v:402:3
	wire _csr_io_tval_T_2 = io_ctl_mem_exception_cause == 32'h00000006;
	// Trace: core/DatPath_5stage.v:403:3
	wire _csr_io_tval_T_3 = io_ctl_mem_exception_cause == 32'h00000004;
	// Trace: core/DatPath_5stage.v:404:3
	wire [31:0] _csr_io_tval_T_4 = (_csr_io_tval_T_3 ? mem_reg_alu_out : 32'h00000000);
	// Trace: core/DatPath_5stage.v:405:3
	wire [31:0] _csr_io_tval_T_5 = (_csr_io_tval_T_2 ? mem_reg_alu_out : _csr_io_tval_T_4);
	// Trace: core/DatPath_5stage.v:406:3
	wire [31:0] _csr_io_tval_T_6 = (_csr_io_tval_T_1 ? mem_tval_inst_ma_REG : _csr_io_tval_T_5);
	// Trace: core/DatPath_5stage.v:407:3
	reg reg_interrupt_handled;
	// Trace: core/DatPath_5stage.v:408:3
	wire interrupt_edge = csr_io_interrupt & ~reg_interrupt_handled;
	// Trace: core/DatPath_5stage.v:409:3
	wire [2:0] _misaligned_mask_T_1 = mem_reg_ctrl_mem_typ - 3'h1;
	// Trace: core/DatPath_5stage.v:410:3
	wire [5:0] _misaligned_mask_T_3 = 6'h07 << _misaligned_mask_T_1[1:0];
	// Trace: core/DatPath_5stage.v:411:3
	wire [5:0] _misaligned_mask_T_4 = ~_misaligned_mask_T_3;
	// Trace: core/DatPath_5stage.v:412:3
	wire [2:0] misaligned_mask = _misaligned_mask_T_4[2:0];
	// Trace: core/DatPath_5stage.v:413:3
	wire [2:0] _io_dat_mem_data_misaligned_T_1 = misaligned_mask & mem_reg_alu_out[2:0];
	// Trace: core/DatPath_5stage.v:414:3
	wire _wb_reg_ctrl_rf_wen_T_1 = (io_ctl_mem_exception | interrupt_edge ? 1'h0 : mem_reg_ctrl_rf_wen);
	// Trace: core/DatPath_5stage.v:415:3
	wire _GEN_91 = _if_buffer_out_io_deq_ready_T_1 & ((mem_reg_valid & ~io_ctl_mem_exception) & ~interrupt_edge);
	// Trace: core/DatPath_5stage.v:416:3
	wire _GEN_94 = _if_buffer_out_io_deq_ready_T_1 & _wb_reg_ctrl_rf_wen_T_1;
	// Trace: core/DatPath_5stage.v:417:3
	reg [31:0] wb_reg_inst;
	// Trace: core/DatPath_5stage.v:418:3
	wire [31:0] _T_37 = csr_io_time;
	// Trace: core/DatPath_5stage.v:419:3
	reg [31:0] REG;
	// Trace: core/DatPath_5stage.v:420:3
	reg [4:0] REG_1;
	// Trace: core/DatPath_5stage.v:421:3
	reg [31:0] REG_2;
	// Trace: core/DatPath_5stage.v:422:3
	reg [4:0] REG_3;
	// Trace: core/DatPath_5stage.v:423:3
	reg [31:0] REG_4;
	// Trace: core/DatPath_5stage.v:424:3
	wire [7:0] _T_38 = (io_ctl_dec_stall ? 8'h53 : 8'h20);
	// Trace: core/DatPath_5stage.v:425:3
	wire [7:0] _T_39 = (io_ctl_full_stall ? 8'h46 : _T_38);
	// Trace: core/DatPath_5stage.v:426:3
	wire [7:0] _T_40 = (io_ctl_pipeline_kill ? 8'h4b : _T_39);
	// Trace: core/DatPath_5stage.v:427:3
	wire [7:0] _T_42 = (2'h2 == io_ctl_exe_pc_sel ? 8'h52 : 8'h42);
	// Trace: core/DatPath_5stage.v:428:3
	wire [7:0] _T_44 = (2'h3 == io_ctl_exe_pc_sel ? 8'h45 : _T_42);
	// Trace: core/DatPath_5stage.v:429:3
	wire [7:0] _T_46 = (2'h0 == io_ctl_exe_pc_sel ? 8'h20 : _T_44);
	// Trace: core/DatPath_5stage.v:430:3
	wire [7:0] _T_47 = (csr_io_exception ? 8'h58 : 8'h20);
	// Trace: core/DatPath_5stage.v:431:3
	Queue_21_5stage Queue_21_5stage(
		.clock(if_buffer_out_clock),
		.reset(if_buffer_out_reset),
		.io_enq_ready(if_buffer_out_io_enq_ready),
		.io_enq_valid(if_buffer_out_io_enq_valid),
		.io_enq_bits_data(if_buffer_out_io_enq_bits_data),
		.io_deq_ready(if_buffer_out_io_deq_ready),
		.io_deq_valid(if_buffer_out_io_deq_valid),
		.io_deq_bits_data(if_buffer_out_io_deq_bits_data)
	);
	// Trace: core/DatPath_5stage.v:441:3
	Queue_22_5stage Queue_22_5stage(
		.clock(if_pc_buffer_out_clock),
		.reset(if_pc_buffer_out_reset),
		.io_enq_ready(if_pc_buffer_out_io_enq_ready),
		.io_enq_valid(if_pc_buffer_out_io_enq_valid),
		.io_enq_bits(if_pc_buffer_out_io_enq_bits),
		.io_deq_ready(if_pc_buffer_out_io_deq_ready),
		.io_deq_valid(if_pc_buffer_out_io_deq_valid),
		.io_deq_bits(if_pc_buffer_out_io_deq_bits)
	);
	// Trace: core/DatPath_5stage.v:451:3
	wire [1023:0] rvfi_regfile;
	RegisterFile_5stage RegisterFile_5stage(
		.clock(regfile_clock),
		.reset(reset),
		.io_rs1_addr(regfile_io_rs1_addr),
		.io_rs1_data(regfile_io_rs1_data),
		.io_rs2_addr(regfile_io_rs2_addr),
		.io_rs2_data(regfile_io_rs2_data),
		.io_waddr(regfile_io_waddr),
		.io_wdata(regfile_io_wdata),
		.io_wen(regfile_io_wen),
		.rvfi_regfile(rvfi_regfile)
	);
	// Trace: core/DatPath_5stage.v:463:3
	CSRFile_5stage CSRFile_5stage(
		.clock(csr_clock),
		.reset(csr_reset),
		.io_ungated_clock(csr_io_ungated_clock),
		.io_interrupts_debug(csr_io_interrupts_debug),
		.io_interrupts_mtip(csr_io_interrupts_mtip),
		.io_interrupts_msip(csr_io_interrupts_msip),
		.io_interrupts_meip(csr_io_interrupts_meip),
		.io_hartid(csr_io_hartid),
		.io_rw_addr(csr_io_rw_addr),
		.io_rw_cmd(csr_io_rw_cmd),
		.io_rw_rdata(csr_io_rw_rdata),
		.io_rw_wdata(csr_io_rw_wdata),
		.io_csr_stall(csr_io_csr_stall),
		.io_eret(csr_io_eret),
		.io_singleStep(csr_io_singleStep),
		.io_status_debug(csr_io_status_debug),
		.io_status_cease(csr_io_status_cease),
		.io_status_wfi(csr_io_status_wfi),
		.io_status_isa(csr_io_status_isa),
		.io_status_dprv(csr_io_status_dprv),
		.io_status_dv(csr_io_status_dv),
		.io_status_prv(csr_io_status_prv),
		.io_status_v(csr_io_status_v),
		.io_status_sd(csr_io_status_sd),
		.io_status_zero2(csr_io_status_zero2),
		.io_status_mpv(csr_io_status_mpv),
		.io_status_gva(csr_io_status_gva),
		.io_status_mbe(csr_io_status_mbe),
		.io_status_sbe(csr_io_status_sbe),
		.io_status_sxl(csr_io_status_sxl),
		.io_status_uxl(csr_io_status_uxl),
		.io_status_sd_rv32(csr_io_status_sd_rv32),
		.io_status_zero1(csr_io_status_zero1),
		.io_status_tsr(csr_io_status_tsr),
		.io_status_tw(csr_io_status_tw),
		.io_status_tvm(csr_io_status_tvm),
		.io_status_mxr(csr_io_status_mxr),
		.io_status_sum(csr_io_status_sum),
		.io_status_mprv(csr_io_status_mprv),
		.io_status_xs(csr_io_status_xs),
		.io_status_fs(csr_io_status_fs),
		.io_status_mpp(csr_io_status_mpp),
		.io_status_vs(csr_io_status_vs),
		.io_status_spp(csr_io_status_spp),
		.io_status_mpie(csr_io_status_mpie),
		.io_status_ube(csr_io_status_ube),
		.io_status_spie(csr_io_status_spie),
		.io_status_upie(csr_io_status_upie),
		.io_status_mie(csr_io_status_mie),
		.io_status_hie(csr_io_status_hie),
		.io_status_sie(csr_io_status_sie),
		.io_status_uie(csr_io_status_uie),
		.io_evec(csr_io_evec),
		.io_exception(csr_io_exception),
		.io_retire(csr_io_retire),
		.io_cause(csr_io_cause),
		.io_pc(csr_io_pc),
		.io_tval(csr_io_tval),
		.io_time(csr_io_time),
		.io_interrupt(csr_io_interrupt),
		.io_interrupt_cause(csr_io_interrupt_cause)
	);
	// Trace: core/DatPath_5stage.v:526:3
	assign io_imem_req_valid = if_buffer_out_io_enq_ready;
	// Trace: core/DatPath_5stage.v:527:3
	assign io_imem_req_bits_addr = if_reg_pc;
	// Trace: core/DatPath_5stage.v:528:3
	assign io_dmem_req_valid = mem_reg_ctrl_mem_val & ~io_dat_mem_data_misaligned;
	// Trace: core/DatPath_5stage.v:529:3
	assign io_dmem_req_bits_addr = mem_reg_alu_out;
	// Trace: core/DatPath_5stage.v:530:3
	assign io_dmem_req_bits_data = mem_reg_rs2_data;
	// Trace: core/DatPath_5stage.v:531:3
	assign io_dmem_req_bits_fcn = mem_reg_ctrl_mem_fcn;
	// Trace: core/DatPath_5stage.v:532:3
	assign io_dmem_req_bits_typ = mem_reg_ctrl_mem_typ;
	// Trace: core/DatPath_5stage.v:533:3
	assign io_dat_dec_inst = dec_reg_inst;
	// Trace: core/DatPath_5stage.v:534:3
	assign io_dat_dec_valid = dec_reg_valid;
	// Trace: core/DatPath_5stage.v:535:3
	assign io_dat_exe_br_eq = exe_alu_op1 == exe_reg_rs2_data;
	// Trace: core/DatPath_5stage.v:536:3
	assign io_dat_exe_br_lt = $signed(exe_alu_op1) < $signed(exe_reg_rs2_data);
	// Trace: core/DatPath_5stage.v:537:3
	assign io_dat_exe_br_ltu = exe_alu_op1 < exe_reg_rs2_data;
	// Trace: core/DatPath_5stage.v:538:3
	assign io_dat_exe_br_type = exe_reg_ctrl_br_type;
	// Trace: core/DatPath_5stage.v:539:3
	assign io_dat_exe_inst_misaligned = (|exe_brjmp_target[1:0] & _if_pc_next_T_1) | _io_dat_exe_inst_misaligned_T_7;
	// Trace: core/DatPath_5stage.v:540:3
	assign io_dat_mem_ctrl_dmem_val = mem_reg_ctrl_mem_val;
	// Trace: core/DatPath_5stage.v:541:3
	assign io_dat_mem_data_misaligned = |_io_dat_mem_data_misaligned_T_1 & mem_reg_ctrl_mem_val;
	// Trace: core/DatPath_5stage.v:542:3
	assign io_dat_mem_store = mem_reg_ctrl_mem_fcn;
	// Trace: core/DatPath_5stage.v:543:3
	assign io_dat_csr_eret = csr_io_eret;
	// Trace: core/DatPath_5stage.v:544:3
	assign io_dat_csr_interrupt = csr_io_interrupt & ~reg_interrupt_handled;
	// Trace: core/DatPath_5stage.v:545:3
	assign if_buffer_out_clock = clock;
	// Trace: core/DatPath_5stage.v:546:3
	assign if_buffer_out_reset = reset;
	// Trace: core/DatPath_5stage.v:547:3
	assign if_buffer_out_io_enq_valid = io_imem_resp_valid;
	// Trace: core/DatPath_5stage.v:548:3
	assign if_buffer_out_io_enq_bits_data = io_imem_resp_bits_data;
	// Trace: core/DatPath_5stage.v:549:3
	assign if_buffer_out_io_deq_ready = ~io_ctl_dec_stall & ~io_ctl_full_stall;
	// Trace: core/DatPath_5stage.v:550:3
	assign if_pc_buffer_out_clock = clock;
	// Trace: core/DatPath_5stage.v:551:3
	assign if_pc_buffer_out_reset = reset;
	// Trace: core/DatPath_5stage.v:552:3
	assign if_pc_buffer_out_io_enq_valid = io_imem_resp_valid;
	// Trace: core/DatPath_5stage.v:553:3
	assign if_pc_buffer_out_io_enq_bits = if_reg_pc;
	// Trace: core/DatPath_5stage.v:554:3
	assign if_pc_buffer_out_io_deq_ready = if_buffer_out_io_deq_ready;
	// Trace: core/DatPath_5stage.v:555:3
	assign regfile_clock = clock;
	// Trace: core/DatPath_5stage.v:556:3
	assign regfile_io_rs1_addr = dec_reg_inst[19:15];
	// Trace: core/DatPath_5stage.v:557:3
	assign regfile_io_rs2_addr = dec_reg_inst[24:20];
	// Trace: core/DatPath_5stage.v:558:3
	assign regfile_io_waddr = wb_reg_wbaddr;
	// Trace: core/DatPath_5stage.v:559:3
	assign regfile_io_wdata = wb_reg_wbdata;
	// Trace: core/DatPath_5stage.v:560:3
	assign regfile_io_wen = wb_reg_ctrl_rf_wen;
	// Trace: core/DatPath_5stage.v:561:3
	assign csr_clock = clock;
	// Trace: core/DatPath_5stage.v:562:3
	assign csr_reset = reset;
	// Trace: core/DatPath_5stage.v:563:3
	assign csr_io_ungated_clock = clock;
	// Trace: core/DatPath_5stage.v:564:3
	assign csr_io_interrupts_debug = io_interrupt_debug;
	// Trace: core/DatPath_5stage.v:565:3
	assign csr_io_interrupts_mtip = io_interrupt_mtip;
	// Trace: core/DatPath_5stage.v:566:3
	assign csr_io_interrupts_msip = io_interrupt_msip;
	// Trace: core/DatPath_5stage.v:567:3
	assign csr_io_interrupts_meip = io_interrupt_meip;
	// Trace: core/DatPath_5stage.v:568:3
	assign csr_io_hartid = io_hartid;
	// Trace: core/DatPath_5stage.v:569:3
	assign csr_io_rw_addr = mem_reg_inst[31:20];
	// Trace: core/DatPath_5stage.v:570:3
	assign csr_io_rw_cmd = mem_reg_ctrl_csr_cmd;
	// Trace: core/DatPath_5stage.v:571:3
	assign csr_io_rw_wdata = mem_reg_alu_out;
	// Trace: core/DatPath_5stage.v:572:3
	assign csr_io_exception = io_ctl_mem_exception;
	// Trace: core/DatPath_5stage.v:573:3
	assign csr_io_retire = wb_reg_valid;
	// Trace: core/DatPath_5stage.v:574:3
	assign csr_io_cause = (io_ctl_mem_exception ? io_ctl_mem_exception_cause : csr_io_interrupt_cause);
	// Trace: core/DatPath_5stage.v:575:3
	assign csr_io_pc = mem_reg_pc;
	// Trace: core/DatPath_5stage.v:576:3
	assign csr_io_tval = (_csr_io_tval_T ? csr_io_tval_REG : _csr_io_tval_T_6);
	// Trace: core/DatPath_5stage.v:579:3
	reg [31:0] mem_reg_new_pc = 32'b00000000000000000000000000000000;
	// Trace: core/DatPath_5stage.v:580:3
	reg [31:0] wb_reg_new_pc = 32'b00000000000000000000000000000000;
	// Trace: core/DatPath_5stage.v:581:3
	always @(posedge clock) begin
		// Trace: core/DatPath_5stage.v:582:5
		if (reset)
			// Trace: core/DatPath_5stage.v:583:7
			if_reg_pc <= io_reset_vector;
		else if (_T_16) begin
			begin
				// Trace: core/DatPath_5stage.v:585:7
				if (!_T_24) begin
					begin
						// Trace: core/DatPath_5stage.v:586:9
						if (_T_17) begin
							// Trace: core/DatPath_5stage.v:587:11
							if_reg_pc <= if_pc_plus4;
							// Trace: core/DatPath_5stage.v:588:11
							mem_reg_new_pc <= if_pc_plus4;
						end
						else begin
							// Trace: core/DatPath_5stage.v:590:11
							if_reg_pc <= _if_pc_next_T_4;
							// Trace: core/DatPath_5stage.v:591:11
							mem_reg_new_pc <= _if_pc_next_T_4;
						end
					end
				end
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:596:7
			dec_reg_valid <= 1'h0;
		else if (io_ctl_pipeline_kill)
			// Trace: core/DatPath_5stage.v:598:7
			dec_reg_valid <= 1'h0;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:600:7
				if (_T_28)
					// Trace: core/DatPath_5stage.v:601:9
					dec_reg_valid <= 1'h0;
				else
					// Trace: core/DatPath_5stage.v:603:9
					dec_reg_valid <= _GEN_4;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:607:7
			dec_reg_inst <= 32'h00004033;
		else if (io_ctl_pipeline_kill)
			// Trace: core/DatPath_5stage.v:609:7
			dec_reg_inst <= 32'h00004033;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:611:7
				if (_T_28)
					// Trace: core/DatPath_5stage.v:612:9
					dec_reg_inst <= 32'h00004033;
				else
					// Trace: core/DatPath_5stage.v:614:9
					dec_reg_inst <= _GEN_5;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:618:7
			dec_reg_pc <= 32'h00000000;
		else if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:620:7
				if (_if_buffer_out_io_deq_ready_T_2)
					// Trace: core/DatPath_5stage.v:621:9
					dec_reg_pc <= if_pc_buffer_out_io_deq_bits;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:625:7
			exe_reg_valid <= 1'h0;
		else if (_T_31)
			// Trace: core/DatPath_5stage.v:627:7
			exe_reg_valid <= 1'h0;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:629:7
				if (io_ctl_dec_kill)
					// Trace: core/DatPath_5stage.v:630:9
					exe_reg_valid <= 1'h0;
				else
					// Trace: core/DatPath_5stage.v:632:9
					exe_reg_valid <= dec_reg_valid;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:636:7
			exe_reg_inst <= 32'h00004033;
		else if (_T_31)
			// Trace: core/DatPath_5stage.v:638:7
			exe_reg_inst <= 32'h00004033;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:640:7
				if (io_ctl_dec_kill)
					// Trace: core/DatPath_5stage.v:641:9
					exe_reg_inst <= 32'h00004033;
				else
					// Trace: core/DatPath_5stage.v:643:9
					exe_reg_inst <= dec_reg_inst;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:647:7
			exe_reg_pc <= 32'h00000000;
		else if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:649:7
				if (_if_buffer_out_io_deq_ready_T_2)
					// Trace: core/DatPath_5stage.v:650:9
					exe_reg_pc <= dec_reg_pc;
			end
		end
		if (_T_31)
			// Trace: core/DatPath_5stage.v:654:7
			exe_reg_wbaddr <= 5'h00;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:656:7
				if (io_ctl_dec_kill)
					// Trace: core/DatPath_5stage.v:657:9
					exe_reg_wbaddr <= 5'h00;
				else
					// Trace: core/DatPath_5stage.v:659:9
					exe_reg_wbaddr <= dec_wbaddr;
			end
		end
		if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:663:7
				if (_if_buffer_out_io_deq_ready_T_2)
					// Trace: core/DatPath_5stage.v:664:9
					exe_reg_rs1_addr <= dec_rs1_addr;
			end
		end
		if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:668:7
				if (_if_buffer_out_io_deq_ready_T_2)
					// Trace: core/DatPath_5stage.v:669:9
					exe_reg_rs2_addr <= dec_rs2_addr;
			end
		end
		if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:673:7
				if (_if_buffer_out_io_deq_ready_T_2) begin
					begin
						// Trace: core/DatPath_5stage.v:674:9
						if (_dec_op1_data_T)
							// Trace: core/DatPath_5stage.v:675:11
							exe_alu_op1 <= imm_z;
						else if (_dec_op1_data_T_1)
							// Trace: core/DatPath_5stage.v:677:11
							exe_alu_op1 <= dec_reg_pc;
						else
							// Trace: core/DatPath_5stage.v:679:11
							exe_alu_op1 <= _dec_op1_data_T_16;
					end
				end
			end
		end
		if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:684:7
				if (_if_buffer_out_io_deq_ready_T_2) begin
					begin
						// Trace: core/DatPath_5stage.v:685:9
						if (_dec_op2_data_T_5) begin
							begin
								// Trace: core/DatPath_5stage.v:686:11
								if (_exe_alu_out_T)
									// Trace: core/DatPath_5stage.v:687:13
									brjmp_offset <= exe_adder_out;
								else
									// Trace: core/DatPath_5stage.v:689:13
									brjmp_offset <= _exe_alu_out_T_37;
							end
						end
						else if (_dec_op2_data_T_11)
							// Trace: core/DatPath_5stage.v:692:11
							brjmp_offset <= mem_wbdata;
						else
							// Trace: core/DatPath_5stage.v:694:11
							brjmp_offset <= _dec_op2_data_T_18;
					end
				end
			end
		end
		if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:699:7
				if (_if_buffer_out_io_deq_ready_T_2) begin
					begin
						// Trace: core/DatPath_5stage.v:700:9
						if (_dec_op2_data_T_3) begin
							begin
								// Trace: core/DatPath_5stage.v:701:11
								if (_exe_alu_out_T)
									// Trace: core/DatPath_5stage.v:702:13
									exe_reg_rs2_data <= exe_adder_out;
								else
									// Trace: core/DatPath_5stage.v:704:13
									exe_reg_rs2_data <= _exe_alu_out_T_37;
							end
						end
						else if (_dec_op2_data_T_9)
							// Trace: core/DatPath_5stage.v:707:11
							exe_reg_rs2_data <= mem_wbdata;
						else
							// Trace: core/DatPath_5stage.v:709:11
							exe_reg_rs2_data <= _dec_rs2_data_T_12;
					end
				end
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:714:7
			exe_reg_ctrl_br_type <= 4'h0;
		else if (_T_31)
			// Trace: core/DatPath_5stage.v:716:7
			exe_reg_ctrl_br_type <= 4'h0;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:718:7
				if (io_ctl_dec_kill)
					// Trace: core/DatPath_5stage.v:719:9
					exe_reg_ctrl_br_type <= 4'h0;
				else
					// Trace: core/DatPath_5stage.v:721:9
					exe_reg_ctrl_br_type <= io_ctl_br_type;
			end
		end
		if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:725:7
				if (_if_buffer_out_io_deq_ready_T_2)
					// Trace: core/DatPath_5stage.v:726:9
					exe_reg_ctrl_alu_fun <= io_ctl_alu_fun;
			end
		end
		if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:730:7
				if (_if_buffer_out_io_deq_ready_T_2)
					// Trace: core/DatPath_5stage.v:731:9
					exe_reg_ctrl_wb_sel <= io_ctl_wb_sel;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:735:7
			exe_reg_ctrl_rf_wen <= 1'h0;
		else if (_T_31)
			// Trace: core/DatPath_5stage.v:737:7
			exe_reg_ctrl_rf_wen <= 1'h0;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:739:7
				if (io_ctl_dec_kill)
					// Trace: core/DatPath_5stage.v:740:9
					exe_reg_ctrl_rf_wen <= 1'h0;
				else
					// Trace: core/DatPath_5stage.v:742:9
					exe_reg_ctrl_rf_wen <= io_ctl_rf_wen;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:746:7
			exe_reg_ctrl_mem_val <= 1'h0;
		else if (_T_31)
			// Trace: core/DatPath_5stage.v:748:7
			exe_reg_ctrl_mem_val <= 1'h0;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:750:7
				if (io_ctl_dec_kill)
					// Trace: core/DatPath_5stage.v:751:9
					exe_reg_ctrl_mem_val <= 1'h0;
				else
					// Trace: core/DatPath_5stage.v:753:9
					exe_reg_ctrl_mem_val <= io_ctl_mem_val;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:757:7
			exe_reg_ctrl_mem_fcn <= 1'h0;
		else
			// Trace: core/DatPath_5stage.v:759:7
			exe_reg_ctrl_mem_fcn <= _GEN_46[0];
		if (reset)
			// Trace: core/DatPath_5stage.v:762:7
			exe_reg_ctrl_mem_typ <= 3'h0;
		else if (!_T_31) begin
			begin
				// Trace: core/DatPath_5stage.v:764:7
				if (_if_buffer_out_io_deq_ready_T_2) begin
					begin
						// Trace: core/DatPath_5stage.v:765:9
						if (!io_ctl_dec_kill)
							// Trace: core/DatPath_5stage.v:766:11
							exe_reg_ctrl_mem_typ <= io_ctl_mem_typ;
					end
				end
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:771:7
			exe_reg_ctrl_csr_cmd <= 3'h0;
		else if (_T_31)
			// Trace: core/DatPath_5stage.v:773:7
			exe_reg_ctrl_csr_cmd <= 3'h0;
		else if (_if_buffer_out_io_deq_ready_T_2) begin
			begin
				// Trace: core/DatPath_5stage.v:775:7
				if (io_ctl_dec_kill)
					// Trace: core/DatPath_5stage.v:776:9
					exe_reg_ctrl_csr_cmd <= 3'h0;
				else
					// Trace: core/DatPath_5stage.v:778:9
					exe_reg_ctrl_csr_cmd <= io_ctl_csr_cmd;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:782:7
			mem_reg_valid <= 1'h0;
		else if (io_ctl_pipeline_kill)
			// Trace: core/DatPath_5stage.v:784:7
			mem_reg_valid <= 1'h0;
		else if (_if_buffer_out_io_deq_ready_T_1)
			// Trace: core/DatPath_5stage.v:786:7
			mem_reg_valid <= exe_reg_valid;
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:789:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:790:9
					mem_reg_pc <= exe_reg_pc;
			end
		end
		if (io_ctl_pipeline_kill)
			// Trace: core/DatPath_5stage.v:794:7
			mem_reg_inst <= 32'h00004033;
		else if (_if_buffer_out_io_deq_ready_T_1)
			// Trace: core/DatPath_5stage.v:796:7
			mem_reg_inst <= exe_reg_inst;
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:799:7
				if (_if_buffer_out_io_deq_ready_T_1) begin
					begin
						// Trace: core/DatPath_5stage.v:800:9
						if (exe_reg_ctrl_wb_sel == 2'h2)
							// Trace: core/DatPath_5stage.v:801:11
							mem_reg_alu_out <= exe_pc_plus4;
						else if (_exe_alu_out_T)
							// Trace: core/DatPath_5stage.v:803:11
							mem_reg_alu_out <= exe_adder_out;
						else
							// Trace: core/DatPath_5stage.v:805:11
							mem_reg_alu_out <= _exe_alu_out_T_37;
					end
				end
			end
		end
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:810:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:811:9
					mem_reg_wbaddr <= exe_reg_wbaddr;
			end
		end
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:815:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:816:9
					mem_reg_rs1_addr <= exe_reg_rs1_addr;
			end
		end
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:820:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:821:9
					mem_reg_rs2_addr <= exe_reg_rs2_addr;
			end
		end
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:825:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:826:9
					mem_reg_op1_data <= exe_alu_op1;
			end
		end
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:830:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:831:9
					mem_reg_op2_data <= brjmp_offset;
			end
		end
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:835:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:836:9
					mem_reg_rs2_data <= exe_reg_rs2_data;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:840:7
			mem_reg_ctrl_rf_wen <= 1'h0;
		else if (io_ctl_pipeline_kill)
			// Trace: core/DatPath_5stage.v:842:7
			mem_reg_ctrl_rf_wen <= 1'h0;
		else if (_if_buffer_out_io_deq_ready_T_1)
			// Trace: core/DatPath_5stage.v:844:7
			mem_reg_ctrl_rf_wen <= exe_reg_ctrl_rf_wen;
		if (reset)
			// Trace: core/DatPath_5stage.v:847:7
			mem_reg_ctrl_mem_val <= 1'h0;
		else if (io_ctl_pipeline_kill)
			// Trace: core/DatPath_5stage.v:849:7
			mem_reg_ctrl_mem_val <= 1'h0;
		else if (_if_buffer_out_io_deq_ready_T_1)
			// Trace: core/DatPath_5stage.v:851:7
			mem_reg_ctrl_mem_val <= exe_reg_ctrl_mem_val;
		if (reset)
			// Trace: core/DatPath_5stage.v:854:7
			mem_reg_ctrl_mem_fcn <= 1'h0;
		else if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:856:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:857:9
					mem_reg_ctrl_mem_fcn <= exe_reg_ctrl_mem_fcn;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:861:7
			mem_reg_ctrl_mem_typ <= 3'h0;
		else if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:863:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:864:9
					mem_reg_ctrl_mem_typ <= exe_reg_ctrl_mem_typ;
			end
		end
		if (!io_ctl_pipeline_kill) begin
			begin
				// Trace: core/DatPath_5stage.v:868:7
				if (_if_buffer_out_io_deq_ready_T_1)
					// Trace: core/DatPath_5stage.v:869:9
					mem_reg_ctrl_wb_sel <= exe_reg_ctrl_wb_sel;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:873:7
			mem_reg_ctrl_csr_cmd <= 3'h0;
		else if (io_ctl_pipeline_kill)
			// Trace: core/DatPath_5stage.v:875:7
			mem_reg_ctrl_csr_cmd <= 3'h0;
		else if (_if_buffer_out_io_deq_ready_T_1)
			// Trace: core/DatPath_5stage.v:877:7
			mem_reg_ctrl_csr_cmd <= exe_reg_ctrl_csr_cmd;
		if (reset)
			// Trace: core/DatPath_5stage.v:880:7
			wb_reg_valid <= 1'h0;
		else
			// Trace: core/DatPath_5stage.v:882:7
			wb_reg_valid <= _GEN_91;
		if (_if_buffer_out_io_deq_ready_T_1)
			// Trace: core/DatPath_5stage.v:885:7
			wb_reg_wbaddr <= mem_reg_wbaddr;
		if (_if_buffer_out_io_deq_ready_T_1) begin
			begin
				// Trace: core/DatPath_5stage.v:888:7
				if (_mem_wbdata_T)
					// Trace: core/DatPath_5stage.v:889:9
					wb_reg_wbdata <= mem_reg_alu_out;
				else if (_mem_wbdata_T_1)
					// Trace: core/DatPath_5stage.v:891:9
					wb_reg_wbdata <= mem_reg_alu_out;
				else if (_mem_wbdata_T_2)
					// Trace: core/DatPath_5stage.v:893:9
					wb_reg_wbdata <= io_dmem_resp_bits_data;
				else
					// Trace: core/DatPath_5stage.v:895:9
					wb_reg_wbdata <= _mem_wbdata_T_4;
			end
		end
		if (reset)
			// Trace: core/DatPath_5stage.v:899:7
			wb_reg_ctrl_rf_wen <= 1'h0;
		else
			// Trace: core/DatPath_5stage.v:901:7
			wb_reg_ctrl_rf_wen <= _GEN_94;
		if (reset)
			// Trace: core/DatPath_5stage.v:904:7
			if_reg_killed <= 1'h0;
		else if (_T_11)
			// Trace: core/DatPath_5stage.v:906:7
			if_reg_killed <= 1'h0;
		else
			// Trace: core/DatPath_5stage.v:908:7
			if_reg_killed <= _GEN_0;
		if (_if_pc_next_T_1)
			// Trace: core/DatPath_5stage.v:911:7
			mem_tval_inst_ma_REG <= exe_brjmp_target;
		else
			// Trace: core/DatPath_5stage.v:913:7
			mem_tval_inst_ma_REG <= exe_jump_reg_target;
		// Trace: core/DatPath_5stage.v:915:5
		csr_io_tval_REG <= exe_reg_inst;
		if (reset)
			// Trace: core/DatPath_5stage.v:917:7
			reg_interrupt_handled <= 1'h0;
		else
			// Trace: core/DatPath_5stage.v:919:7
			reg_interrupt_handled <= csr_io_interrupt;
		// Trace: core/DatPath_5stage.v:921:5
		wb_reg_inst <= mem_reg_inst;
		// Trace: core/DatPath_5stage.v:922:5
		wb_reg_new_pc <= mem_reg_new_pc;
		// Trace: core/DatPath_5stage.v:923:5
		REG <= mem_reg_pc;
		// Trace: core/DatPath_5stage.v:924:5
		REG_1 <= mem_reg_rs1_addr;
		// Trace: core/DatPath_5stage.v:925:5
		REG_2 <= mem_reg_op1_data;
		// Trace: core/DatPath_5stage.v:926:5
		REG_3 <= mem_reg_rs2_addr;
		// Trace: core/DatPath_5stage.v:927:5
		REG_4 <= mem_reg_op2_data;
	end
	// Trace: core/DatPath_5stage.v:1115:2
	// Trace: core/DatPath_5stage.v:1117:2
	wire [31:0] new_pc_wire;
	// Trace: core/DatPath_5stage.v:1118:3
	assign new_pc_wire = wb_reg_new_pc;
	// Trace: core/DatPath_5stage.v:1119:3
	wire [31:0] register_wdata;
	// Trace: core/DatPath_5stage.v:1120:3
	assign register_wdata = regfile_io_wdata;
	// Trace: core/DatPath_5stage.v:1121:2
	wire retire_wire;
	// Trace: core/DatPath_5stage.v:1123:2
	assign retire_wire = wb_reg_valid;
	// Trace: core/DatPath_5stage.v:1124:2
	reg retire;
	// Trace: core/DatPath_5stage.v:1125:2
	always @(posedge clock)
		// Trace: core/DatPath_5stage.v:1126:3
		retire <= retire_wire;
	// Trace: core/DatPath_5stage.v:1128:3
	wire [31:0] instruction;
	// Trace: core/DatPath_5stage.v:1129:2
	assign instruction = wb_reg_inst;
	// Trace: core/DatPath_5stage.v:1132:2
	wire [31:0] old_pc;
	// Trace: core/DatPath_5stage.v:1134:2
	assign old_pc = REG;
	// Trace: core/DatPath_5stage.v:1137:2
	reg mem_req = 0;
	// Trace: core/DatPath_5stage.v:1139:2
	reg [31:0] mem_addr1 = 32'b00000000000000000000000000000000;
	// Trace: core/DatPath_5stage.v:1141:2
	reg [31:0] mem_rdata = 32'b00000000000000000000000000000000;
	// Trace: core/DatPath_5stage.v:1143:2
	reg [31:0] mem_wdata = 32'b00000000000000000000000000000000;
	// Trace: core/DatPath_5stage.v:1145:2
	reg mem_we = 0;
	// Trace: core/DatPath_5stage.v:1147:2
	reg [2:0] mem_be = 3'b000;
	// Trace: core/DatPath_5stage.v:1149:2
	wire exception;
	// Trace: core/DatPath_5stage.v:1151:2
	assign exception = 0;
	// Trace: core/DatPath_5stage.v:1183:2
	always @(posedge clock)
		if (reset) begin
			// Trace: core/DatPath_5stage.v:1187:4
			mem_req <= 0;
			// Trace: core/DatPath_5stage.v:1189:4
			mem_addr1 <= 32'b00000000000000000000000000000000;
			// Trace: core/DatPath_5stage.v:1191:4
			mem_rdata <= 32'b00000000000000000000000000000000;
			// Trace: core/DatPath_5stage.v:1193:4
			mem_wdata <= 32'b00000000000000000000000000000000;
			// Trace: core/DatPath_5stage.v:1195:4
			mem_we <= 0;
			// Trace: core/DatPath_5stage.v:1197:4
			mem_be <= 3'b000;
		end
		else begin
			// Trace: core/DatPath_5stage.v:1201:4
			mem_req <= io_dmem_req_valid;
			// Trace: core/DatPath_5stage.v:1203:4
			mem_addr1 <= io_dmem_req_bits_addr;
			// Trace: core/DatPath_5stage.v:1205:4
			mem_rdata <= io_dmem_resp_bits_data;
			// Trace: core/DatPath_5stage.v:1207:4
			mem_wdata <= io_dmem_req_bits_data;
			// Trace: core/DatPath_5stage.v:1209:4
			mem_we <= io_dmem_req_bits_fcn;
			// Trace: core/DatPath_5stage.v:1211:4
			mem_be <= io_dmem_req_bits_typ;
		end
	// Trace: core/DatPath_5stage.v:1214:2
	RVFI_5stage RVFI_5stage(
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
	// Trace: core/DatPath_5stage.v:1280:2
	wire rvfi_lui_ctr;
	// Trace: core/DatPath_5stage.v:1281:2
	assign rvfi_lui_ctr = rvfi_insn[6:0] == 7'h37;
	// Trace: core/DatPath_5stage.v:1282:2
	wire rvfi_auipc_ctr;
	// Trace: core/DatPath_5stage.v:1283:2
	assign rvfi_auipc_ctr = rvfi_insn[6:0] == 7'h17;
	// Trace: core/DatPath_5stage.v:1285:2
	wire rvfi_jal_ctr;
	// Trace: core/DatPath_5stage.v:1286:2
	assign rvfi_jal_ctr = rvfi_insn[6:0] == 7'h6f;
	// Trace: core/DatPath_5stage.v:1287:2
	wire rvfi_jalr_ctr;
	// Trace: core/DatPath_5stage.v:1288:2
	assign rvfi_jalr_ctr = (rvfi_insn[6:0] == 7'h67) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/DatPath_5stage.v:1290:2
	wire rvfi_beq_ctr;
	// Trace: core/DatPath_5stage.v:1291:2
	assign rvfi_beq_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/DatPath_5stage.v:1292:2
	wire rvfi_bge_ctr;
	// Trace: core/DatPath_5stage.v:1293:2
	assign rvfi_bge_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b101);
	// Trace: core/DatPath_5stage.v:1294:2
	wire rvfi_bgeu_ctr;
	// Trace: core/DatPath_5stage.v:1295:2
	assign rvfi_bgeu_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b111);
	// Trace: core/DatPath_5stage.v:1296:2
	wire rvfi_bltu_ctr;
	// Trace: core/DatPath_5stage.v:1297:2
	assign rvfi_bltu_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b110);
	// Trace: core/DatPath_5stage.v:1298:2
	wire rvfi_blt_ctr;
	// Trace: core/DatPath_5stage.v:1299:2
	assign rvfi_blt_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/DatPath_5stage.v:1300:2
	wire rvfi_bne_ctr;
	// Trace: core/DatPath_5stage.v:1301:2
	assign rvfi_bne_ctr = (rvfi_insn[6:0] == 7'h63) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/DatPath_5stage.v:1304:2
	wire rvfi_lb_ctr;
	// Trace: core/DatPath_5stage.v:1305:2
	assign rvfi_lb_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/DatPath_5stage.v:1306:2
	wire rvfi_lh_ctr;
	// Trace: core/DatPath_5stage.v:1307:2
	assign rvfi_lh_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/DatPath_5stage.v:1308:2
	wire rvfi_lhu_ctr;
	// Trace: core/DatPath_5stage.v:1309:2
	assign rvfi_lhu_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b101);
	// Trace: core/DatPath_5stage.v:1310:2
	wire rvfi_lbu_ctr;
	// Trace: core/DatPath_5stage.v:1311:2
	assign rvfi_lbu_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/DatPath_5stage.v:1312:2
	wire rvfi_lw_ctr;
	// Trace: core/DatPath_5stage.v:1313:2
	assign rvfi_lw_ctr = (rvfi_insn[6:0] == 7'h03) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/DatPath_5stage.v:1315:2
	wire rvfi_sb_ctr;
	// Trace: core/DatPath_5stage.v:1316:2
	assign rvfi_sb_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/DatPath_5stage.v:1317:2
	wire rvfi_sw_ctr;
	// Trace: core/DatPath_5stage.v:1318:2
	assign rvfi_sw_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/DatPath_5stage.v:1319:2
	wire rvfi_sh_ctr;
	// Trace: core/DatPath_5stage.v:1320:2
	assign rvfi_sh_ctr = (rvfi_insn[6:0] == 7'h23) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/DatPath_5stage.v:1322:2
	wire rvfi_addi_ctr;
	// Trace: core/DatPath_5stage.v:1323:2
	assign rvfi_addi_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/DatPath_5stage.v:1324:2
	wire rvfi_slti_ctr;
	// Trace: core/DatPath_5stage.v:1325:2
	assign rvfi_slti_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/DatPath_5stage.v:1326:2
	wire rvfi_sltiu_ctr;
	// Trace: core/DatPath_5stage.v:1327:2
	assign rvfi_sltiu_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b011);
	// Trace: core/DatPath_5stage.v:1328:2
	wire rvfi_xori_ctr;
	// Trace: core/DatPath_5stage.v:1329:2
	assign rvfi_xori_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/DatPath_5stage.v:1330:2
	wire rvfi_ori_ctr;
	// Trace: core/DatPath_5stage.v:1331:2
	assign rvfi_ori_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b110);
	// Trace: core/DatPath_5stage.v:1332:2
	wire rvfi_andi_ctr;
	// Trace: core/DatPath_5stage.v:1333:2
	assign rvfi_andi_ctr = (rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b111);
	// Trace: core/DatPath_5stage.v:1334:2
	wire rvfi_slli_ctr;
	// Trace: core/DatPath_5stage.v:1335:2
	assign rvfi_slli_ctr = ((rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b001)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1336:2
	wire rvfi_srli_ctr;
	// Trace: core/DatPath_5stage.v:1337:2
	assign rvfi_srli_ctr = ((rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1338:2
	wire rvfi_srai_ctr;
	// Trace: core/DatPath_5stage.v:1339:2
	assign rvfi_srai_ctr = ((rvfi_insn[6:0] == 7'h13) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0100000);
	// Trace: core/DatPath_5stage.v:1341:2
	wire rvfi_add_ctr;
	// Trace: core/DatPath_5stage.v:1342:2
	assign rvfi_add_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b000)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1343:2
	wire rvfi_sub_ctr;
	// Trace: core/DatPath_5stage.v:1344:2
	assign rvfi_sub_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b000)) && (rvfi_insn[31:25] == 7'b0100000);
	// Trace: core/DatPath_5stage.v:1345:2
	wire rvfi_sll_ctr;
	// Trace: core/DatPath_5stage.v:1346:2
	assign rvfi_sll_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b001)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1347:2
	wire rvfi_slt_ctr;
	// Trace: core/DatPath_5stage.v:1348:2
	assign rvfi_slt_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b010)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1349:2
	wire rvfi_sltu_ctr;
	// Trace: core/DatPath_5stage.v:1350:2
	assign rvfi_sltu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b011)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1351:2
	wire rvfi_xor_ctr;
	// Trace: core/DatPath_5stage.v:1352:2
	assign rvfi_xor_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b100)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1353:2
	wire rvfi_srl_ctr;
	// Trace: core/DatPath_5stage.v:1354:2
	assign rvfi_srl_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1355:2
	wire rvfi_sra_ctr;
	// Trace: core/DatPath_5stage.v:1356:2
	assign rvfi_sra_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b101)) && (rvfi_insn[31:25] == 7'b0100000);
	// Trace: core/DatPath_5stage.v:1357:2
	wire rvfi_or_ctr;
	// Trace: core/DatPath_5stage.v:1358:2
	assign rvfi_or_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b110)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1359:2
	wire rvfi_and_ctr;
	// Trace: core/DatPath_5stage.v:1360:2
	assign rvfi_and_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[14:12] == 3'b111)) && (rvfi_insn[31:25] == 7'b0000000);
	// Trace: core/DatPath_5stage.v:1362:2
	wire rvfi_mul_ctr;
	// Trace: core/DatPath_5stage.v:1363:2
	assign rvfi_mul_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b000);
	// Trace: core/DatPath_5stage.v:1364:2
	wire rvfi_mulh_ctr;
	// Trace: core/DatPath_5stage.v:1365:2
	assign rvfi_mulh_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b001);
	// Trace: core/DatPath_5stage.v:1366:2
	wire rvfi_mulhsu_ctr;
	// Trace: core/DatPath_5stage.v:1367:2
	assign rvfi_mulhsu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b010);
	// Trace: core/DatPath_5stage.v:1368:2
	wire rvfi_mulhu_ctr;
	// Trace: core/DatPath_5stage.v:1369:2
	assign rvfi_mulhu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b011);
	// Trace: core/DatPath_5stage.v:1370:2
	wire rvfi_div_ctr;
	// Trace: core/DatPath_5stage.v:1371:2
	assign rvfi_div_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b100);
	// Trace: core/DatPath_5stage.v:1372:2
	wire rvfi_divu_ctr;
	// Trace: core/DatPath_5stage.v:1373:2
	assign rvfi_divu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b101);
	// Trace: core/DatPath_5stage.v:1374:2
	wire rvfi_rem_ctr;
	// Trace: core/DatPath_5stage.v:1375:2
	assign rvfi_rem_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b110);
	// Trace: core/DatPath_5stage.v:1376:2
	wire rvfi_remu_ctr;
	// Trace: core/DatPath_5stage.v:1377:2
	assign rvfi_remu_ctr = ((rvfi_insn[6:0] == 7'h33) && (rvfi_insn[31:25] == 7'b0000001)) && (rvfi_insn[14:12] == 3'b111);
	// Trace: core/DatPath_5stage.v:1381:2
	wire [4:0] rs1;
	// Trace: core/DatPath_5stage.v:1382:2
	wire [4:0] rs2;
	// Trace: core/DatPath_5stage.v:1383:2
	wire [4:0] rd;
	// Trace: core/DatPath_5stage.v:1384:2
	wire [6:0] opcode;
	// Trace: core/DatPath_5stage.v:1385:2
	wire [31:0] imm;
	// Trace: core/DatPath_5stage.v:1386:2
	wire [2:0] format;
	// Trace: core/DatPath_5stage.v:1387:2
	wire [2:0] funct3;
	// Trace: core/DatPath_5stage.v:1388:2
	wire [6:0] funct7;
	// Trace: core/DatPath_5stage.v:1390:5
	ctr_decode ctr_decode(
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
	// Trace: core/DatPath_5stage.v:1402:2
	wire [31:0] new_pc;
	// Trace: core/DatPath_5stage.v:1403:2
	assign new_pc = rvfi_pc_wdata;
	// Trace: core/DatPath_5stage.v:1404:2
	wire is_branch;
	// Trace: core/DatPath_5stage.v:1405:2
	assign is_branch = ((((((rvfi_beq_ctr || rvfi_bge_ctr) || rvfi_bgeu_ctr) || rvfi_bltu_ctr) || rvfi_blt_ctr) || rvfi_bne_ctr) || rvfi_jal_ctr) || rvfi_jalr_ctr;
	// Trace: core/DatPath_5stage.v:1408:2
	wire [31:0] reg_rd;
	// Trace: core/DatPath_5stage.v:1409:2
	assign reg_rd = rvfi_rd_wdata;
	// Trace: core/DatPath_5stage.v:1410:2
	wire [31:0] reg_rs1;
	// Trace: core/DatPath_5stage.v:1411:2
	assign reg_rs1 = rvfi_rs1_rdata;
	// Trace: core/DatPath_5stage.v:1412:2
	wire [31:0] reg_rs2;
	// Trace: core/DatPath_5stage.v:1413:2
	assign reg_rs2 = rvfi_rs2_rdata;
	// Trace: core/DatPath_5stage.v:1415:2
	wire reg_rs1_zero;
	// Trace: core/DatPath_5stage.v:1416:2
	assign reg_rs1_zero = rvfi_rs1_rdata == 0;
	// Trace: core/DatPath_5stage.v:1417:2
	wire reg_rs2_zero;
	// Trace: core/DatPath_5stage.v:1418:2
	assign reg_rs2_zero = rvfi_rs2_rdata == 0;
	// Trace: core/DatPath_5stage.v:1419:2
	wire [31:0] reg_rs1_log2;
	// Trace: core/DatPath_5stage.v:1420:2
	function integer clogb2;
		// Trace: core/DatPath_5stage.v:1429:3
		input [31:0] value;
		// Trace: core/DatPath_5stage.v:1430:3
		integer i;
		// Trace: core/DatPath_5stage.v:1431:3
		begin
			// Trace: core/DatPath_5stage.v:1432:4
			clogb2 = 0;
			// Trace: core/DatPath_5stage.v:1433:4
			for (i = 0; i < 32; i = i + 1)
				begin
					// Trace: core/DatPath_5stage.v:1434:5
					if (value > 0) begin
						// Trace: core/DatPath_5stage.v:1435:6
						clogb2 = i + 1;
						// Trace: core/DatPath_5stage.v:1436:6
						value = value >> 1;
					end
				end
		end
	endfunction
	assign reg_rs1_log2 = clogb2(rvfi_rs1_rdata);
	// Trace: core/DatPath_5stage.v:1421:2
	wire [31:0] reg_rs2_log2;
	// Trace: core/DatPath_5stage.v:1422:2
	assign reg_rs2_log2 = clogb2(rvfi_rs2_rdata);
	// Trace: core/DatPath_5stage.v:1423:2
	wire reg_rd_zero;
	// Trace: core/DatPath_5stage.v:1424:2
	assign reg_rd_zero = rvfi_rd_wdata == 0;
	// Trace: core/DatPath_5stage.v:1425:2
	wire [31:0] reg_rd_log2;
	// Trace: core/DatPath_5stage.v:1426:2
	assign reg_rd_log2 = clogb2(rvfi_rd_wdata);
	// Trace: core/DatPath_5stage.v:1428:2
	// Trace: core/DatPath_5stage.v:1445:2
	wire is_aligned;
	// Trace: core/DatPath_5stage.v:1446:2
	assign is_aligned = rvfi_mem_addr[1:0] == 2'b00;
	// Trace: core/DatPath_5stage.v:1447:2
	wire is_half_aligned;
	// Trace: core/DatPath_5stage.v:1448:5
	assign is_half_aligned = rvfi_mem_addr[1:0] != 2'b11;
	// Trace: core/DatPath_5stage.v:1450:2
	wire branch_taken;
	// Trace: core/DatPath_5stage.v:1451:5
	assign branch_taken = (((((((opcode == 7'b1101111) || (opcode == 7'b1100111)) || (((opcode == 7'b1100011) && (funct3 == 3'b000)) && (reg_rs1 == reg_rs2))) || (((opcode == 7'b1100011) && (funct3 == 3'b001)) && (reg_rs1 != reg_rs2))) || (((opcode == 7'b1100011) && (funct3 == 3'b100)) && ($signed(reg_rs1) < $signed(reg_rs2)))) || (((opcode == 7'b1100011) && (funct3 == 3'b101)) && ($signed(reg_rs1) >= $signed(reg_rs2)))) || (((opcode == 7'b1100011) && (funct3 == 3'b110)) && (reg_rs1 < reg_rs2))) || (((opcode == 7'b1100011) && (funct3 == 3'b111)) && (reg_rs1 >= reg_rs2));
	// Trace: core/DatPath_5stage.v:1461:2
	wire [31:0] mem_addr;
	// Trace: core/DatPath_5stage.v:1462:2
	assign mem_addr = rvfi_mem_addr;
	// Trace: core/DatPath_5stage.v:1463:2
	wire [31:0] mem_r_data;
	// Trace: core/DatPath_5stage.v:1464:2
	assign mem_r_data = rvfi_mem_rdata;
	// Trace: core/DatPath_5stage.v:1465:2
	wire [31:0] mem_w_data;
	// Trace: core/DatPath_5stage.v:1466:2
	assign mem_w_data = rvfi_mem_wdata;
	// Trace: core/DatPath_5stage.v:1470:3
	wire [4:0] rd_1;
	// Trace: core/DatPath_5stage.v:1471:3
	assign rd_1 = rd;
	// Trace: core/DatPath_5stage.v:1472:3
	wire [4:0] rs1_1;
	// Trace: core/DatPath_5stage.v:1473:3
	assign rs1_1 = rs1;
	// Trace: core/DatPath_5stage.v:1474:3
	wire [4:0] rs2_1;
	// Trace: core/DatPath_5stage.v:1475:3
	assign rs2_1 = rs2;
	// Trace: core/DatPath_5stage.v:1476:3
	wire [4:0] rd_2;
	// Trace: core/DatPath_5stage.v:1477:3
	assign rd_2 = 0;
	// Trace: core/DatPath_5stage.v:1478:3
	wire [4:0] rs1_2;
	// Trace: core/DatPath_5stage.v:1479:3
	assign rs1_2 = 0;
	// Trace: core/DatPath_5stage.v:1480:3
	wire [4:0] rs2_2;
	// Trace: core/DatPath_5stage.v:1481:3
	assign rs2_2 = 0;
	// Trace: core/DatPath_5stage.v:1482:3
	reg [5:0] old_rd_1_1 = 0;
	// Trace: core/DatPath_5stage.v:1483:3
	reg [5:0] old_rd_1_2 = 0;
	// Trace: core/DatPath_5stage.v:1484:3
	reg [5:0] old_rd_1_3 = 0;
	// Trace: core/DatPath_5stage.v:1485:3
	reg [5:0] old_rd_1_4 = 0;
	// Trace: core/DatPath_5stage.v:1486:3
	reg [5:0] old_rd_2_1 = 0;
	// Trace: core/DatPath_5stage.v:1487:3
	reg [5:0] old_rd_2_2 = 0;
	// Trace: core/DatPath_5stage.v:1488:3
	reg [5:0] old_rd_2_3 = 0;
	// Trace: core/DatPath_5stage.v:1489:3
	reg [5:0] old_rd_2_4 = 0;
	// Trace: core/DatPath_5stage.v:1490:3
	always @(posedge clock)
		// Trace: core/DatPath_5stage.v:1491:7
		if (retire == 1) begin
			// Trace: core/DatPath_5stage.v:1492:11
			old_rd_1_1 <= rd_1;
			// Trace: core/DatPath_5stage.v:1493:11
			old_rd_1_2 <= old_rd_1_1;
			// Trace: core/DatPath_5stage.v:1494:11
			old_rd_1_3 <= old_rd_1_2;
			// Trace: core/DatPath_5stage.v:1495:11
			old_rd_1_4 <= old_rd_1_3;
			// Trace: core/DatPath_5stage.v:1496:11
			old_rd_2_1 <= rd_2;
			// Trace: core/DatPath_5stage.v:1497:11
			old_rd_2_2 <= old_rd_2_1;
			// Trace: core/DatPath_5stage.v:1498:11
			old_rd_2_3 <= old_rd_2_2;
			// Trace: core/DatPath_5stage.v:1499:11
			old_rd_2_4 <= old_rd_2_3;
		end
	// Trace: core/DatPath_5stage.v:1503:3
	wire raw_rs1_1_1;
	// Trace: core/DatPath_5stage.v:1504:3
	assign raw_rs1_1_1 = rs1_1 == old_rd_1_1;
	// Trace: core/DatPath_5stage.v:1505:3
	wire raw_rs2_1_1;
	// Trace: core/DatPath_5stage.v:1506:3
	assign raw_rs2_1_1 = rs2_1 == old_rd_1_1;
	// Trace: core/DatPath_5stage.v:1507:3
	wire waw_1_1;
	// Trace: core/DatPath_5stage.v:1508:3
	assign waw_1_1 = rd_1 == old_rd_1_1;
	// Trace: core/DatPath_5stage.v:1510:3
	wire raw_rs1_1_2;
	// Trace: core/DatPath_5stage.v:1511:3
	assign raw_rs1_1_2 = rs1_2 == old_rd_2_1;
	// Trace: core/DatPath_5stage.v:1512:3
	wire raw_rs2_1_2;
	// Trace: core/DatPath_5stage.v:1513:3
	assign raw_rs2_1_2 = rs2_2 == old_rd_2_1;
	// Trace: core/DatPath_5stage.v:1514:3
	wire waw_1_2;
	// Trace: core/DatPath_5stage.v:1515:3
	assign waw_1_2 = rd_2 == old_rd_2_1;
	// Trace: core/DatPath_5stage.v:1517:3
	wire raw_rs1_2_1;
	// Trace: core/DatPath_5stage.v:1518:3
	assign raw_rs1_2_1 = rs1_1 == old_rd_1_2;
	// Trace: core/DatPath_5stage.v:1519:3
	wire raw_rs2_2_1;
	// Trace: core/DatPath_5stage.v:1520:3
	assign raw_rs2_2_1 = rs2_1 == old_rd_1_2;
	// Trace: core/DatPath_5stage.v:1521:3
	wire waw_2_1;
	// Trace: core/DatPath_5stage.v:1522:3
	assign waw_2_1 = rd_1 == old_rd_1_2;
	// Trace: core/DatPath_5stage.v:1524:3
	wire raw_rs1_2_2;
	// Trace: core/DatPath_5stage.v:1525:3
	assign raw_rs1_2_2 = rs1_2 == old_rd_2_2;
	// Trace: core/DatPath_5stage.v:1526:3
	wire raw_rs2_2_2;
	// Trace: core/DatPath_5stage.v:1527:3
	assign raw_rs2_2_2 = rs2_2 == old_rd_2_2;
	// Trace: core/DatPath_5stage.v:1528:3
	wire waw_2_2;
	// Trace: core/DatPath_5stage.v:1529:3
	assign waw_2_2 = rd_2 == old_rd_2_2;
	// Trace: core/DatPath_5stage.v:1531:3
	wire raw_rs1_3_1;
	// Trace: core/DatPath_5stage.v:1532:3
	assign raw_rs1_3_1 = rs1_1 == old_rd_1_3;
	// Trace: core/DatPath_5stage.v:1533:3
	wire raw_rs2_3_1;
	// Trace: core/DatPath_5stage.v:1534:3
	assign raw_rs2_3_1 = rs2_1 == old_rd_1_3;
	// Trace: core/DatPath_5stage.v:1535:3
	wire waw_3_1;
	// Trace: core/DatPath_5stage.v:1536:3
	assign waw_3_1 = rd_1 == old_rd_1_3;
	// Trace: core/DatPath_5stage.v:1538:3
	wire raw_rs1_3_2;
	// Trace: core/DatPath_5stage.v:1539:3
	assign raw_rs1_3_2 = rs1_2 == old_rd_2_3;
	// Trace: core/DatPath_5stage.v:1540:3
	wire raw_rs2_3_2;
	// Trace: core/DatPath_5stage.v:1541:3
	assign raw_rs2_3_2 = rs2_2 == old_rd_2_3;
	// Trace: core/DatPath_5stage.v:1542:3
	wire waw_3_2;
	// Trace: core/DatPath_5stage.v:1543:3
	assign waw_3_2 = rd_2 == old_rd_2_3;
	// Trace: core/DatPath_5stage.v:1545:3
	wire raw_rs1_4_1;
	// Trace: core/DatPath_5stage.v:1546:3
	assign raw_rs1_4_1 = rs1_1 == old_rd_1_4;
	// Trace: core/DatPath_5stage.v:1547:3
	wire raw_rs2_4_1;
	// Trace: core/DatPath_5stage.v:1548:3
	assign raw_rs2_4_1 = rs2_1 == old_rd_1_4;
	// Trace: core/DatPath_5stage.v:1549:3
	wire waw_4_1;
	// Trace: core/DatPath_5stage.v:1550:3
	assign waw_4_1 = rd_1 == old_rd_1_4;
	// Trace: core/DatPath_5stage.v:1552:3
	wire raw_rs1_4_2;
	// Trace: core/DatPath_5stage.v:1553:3
	assign raw_rs1_4_2 = rs1_2 == old_rd_2_4;
	// Trace: core/DatPath_5stage.v:1554:3
	wire raw_rs2_4_2;
	// Trace: core/DatPath_5stage.v:1555:3
	assign raw_rs2_4_2 = rs2_2 == old_rd_2_4;
	// Trace: core/DatPath_5stage.v:1556:3
	wire waw_4_2;
	// Trace: core/DatPath_5stage.v:1557:3
	assign waw_4_2 = rd_2 == old_rd_2_4;
endmodule
