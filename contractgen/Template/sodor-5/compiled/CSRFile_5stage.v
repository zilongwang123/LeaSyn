module CSRFile_5stage (
	clock,
	reset,
	io_ungated_clock,
	io_interrupts_debug,
	io_interrupts_mtip,
	io_interrupts_msip,
	io_interrupts_meip,
	io_hartid,
	io_rw_addr,
	io_rw_cmd,
	io_rw_rdata,
	io_rw_wdata,
	io_csr_stall,
	io_eret,
	io_singleStep,
	io_status_debug,
	io_status_cease,
	io_status_wfi,
	io_status_isa,
	io_status_dprv,
	io_status_dv,
	io_status_prv,
	io_status_v,
	io_status_sd,
	io_status_zero2,
	io_status_mpv,
	io_status_gva,
	io_status_mbe,
	io_status_sbe,
	io_status_sxl,
	io_status_uxl,
	io_status_sd_rv32,
	io_status_zero1,
	io_status_tsr,
	io_status_tw,
	io_status_tvm,
	io_status_mxr,
	io_status_sum,
	io_status_mprv,
	io_status_xs,
	io_status_fs,
	io_status_mpp,
	io_status_vs,
	io_status_spp,
	io_status_mpie,
	io_status_ube,
	io_status_spie,
	io_status_upie,
	io_status_mie,
	io_status_hie,
	io_status_sie,
	io_status_uie,
	io_evec,
	io_exception,
	io_retire,
	io_cause,
	io_pc,
	io_tval,
	io_time,
	io_interrupt,
	io_interrupt_cause
);
	// Trace: core/CSRFile_5stage.v:2:3
	input clock;
	// Trace: core/CSRFile_5stage.v:3:3
	input reset;
	// Trace: core/CSRFile_5stage.v:4:3
	input io_ungated_clock;
	// Trace: core/CSRFile_5stage.v:5:3
	input io_interrupts_debug;
	// Trace: core/CSRFile_5stage.v:6:3
	input io_interrupts_mtip;
	// Trace: core/CSRFile_5stage.v:7:3
	input io_interrupts_msip;
	// Trace: core/CSRFile_5stage.v:8:3
	input io_interrupts_meip;
	// Trace: core/CSRFile_5stage.v:9:3
	input io_hartid;
	// Trace: core/CSRFile_5stage.v:10:3
	input [11:0] io_rw_addr;
	// Trace: core/CSRFile_5stage.v:11:3
	input [2:0] io_rw_cmd;
	// Trace: core/CSRFile_5stage.v:12:3
	output wire [31:0] io_rw_rdata;
	// Trace: core/CSRFile_5stage.v:13:3
	input [31:0] io_rw_wdata;
	// Trace: core/CSRFile_5stage.v:14:3
	output wire io_csr_stall;
	// Trace: core/CSRFile_5stage.v:15:3
	output wire io_eret;
	// Trace: core/CSRFile_5stage.v:16:3
	output wire io_singleStep;
	// Trace: core/CSRFile_5stage.v:17:3
	output wire io_status_debug;
	// Trace: core/CSRFile_5stage.v:18:3
	output wire io_status_cease;
	// Trace: core/CSRFile_5stage.v:19:3
	output wire io_status_wfi;
	// Trace: core/CSRFile_5stage.v:20:3
	output wire [31:0] io_status_isa;
	// Trace: core/CSRFile_5stage.v:21:3
	output wire [1:0] io_status_dprv;
	// Trace: core/CSRFile_5stage.v:22:3
	output wire io_status_dv;
	// Trace: core/CSRFile_5stage.v:23:3
	output wire [1:0] io_status_prv;
	// Trace: core/CSRFile_5stage.v:24:3
	output wire io_status_v;
	// Trace: core/CSRFile_5stage.v:25:3
	output wire io_status_sd;
	// Trace: core/CSRFile_5stage.v:26:3
	output wire [22:0] io_status_zero2;
	// Trace: core/CSRFile_5stage.v:27:3
	output wire io_status_mpv;
	// Trace: core/CSRFile_5stage.v:28:3
	output wire io_status_gva;
	// Trace: core/CSRFile_5stage.v:29:3
	output wire io_status_mbe;
	// Trace: core/CSRFile_5stage.v:30:3
	output wire io_status_sbe;
	// Trace: core/CSRFile_5stage.v:31:3
	output wire [1:0] io_status_sxl;
	// Trace: core/CSRFile_5stage.v:32:3
	output wire [1:0] io_status_uxl;
	// Trace: core/CSRFile_5stage.v:33:3
	output wire io_status_sd_rv32;
	// Trace: core/CSRFile_5stage.v:34:3
	output wire [7:0] io_status_zero1;
	// Trace: core/CSRFile_5stage.v:35:3
	output wire io_status_tsr;
	// Trace: core/CSRFile_5stage.v:36:3
	output wire io_status_tw;
	// Trace: core/CSRFile_5stage.v:37:3
	output wire io_status_tvm;
	// Trace: core/CSRFile_5stage.v:38:3
	output wire io_status_mxr;
	// Trace: core/CSRFile_5stage.v:39:3
	output wire io_status_sum;
	// Trace: core/CSRFile_5stage.v:40:3
	output wire io_status_mprv;
	// Trace: core/CSRFile_5stage.v:41:3
	output wire [1:0] io_status_xs;
	// Trace: core/CSRFile_5stage.v:42:3
	output wire [1:0] io_status_fs;
	// Trace: core/CSRFile_5stage.v:43:3
	output wire [1:0] io_status_mpp;
	// Trace: core/CSRFile_5stage.v:44:3
	output wire [1:0] io_status_vs;
	// Trace: core/CSRFile_5stage.v:45:3
	output wire io_status_spp;
	// Trace: core/CSRFile_5stage.v:46:3
	output wire io_status_mpie;
	// Trace: core/CSRFile_5stage.v:47:3
	output wire io_status_ube;
	// Trace: core/CSRFile_5stage.v:48:3
	output wire io_status_spie;
	// Trace: core/CSRFile_5stage.v:49:3
	output wire io_status_upie;
	// Trace: core/CSRFile_5stage.v:50:3
	output wire io_status_mie;
	// Trace: core/CSRFile_5stage.v:51:3
	output wire io_status_hie;
	// Trace: core/CSRFile_5stage.v:52:3
	output wire io_status_sie;
	// Trace: core/CSRFile_5stage.v:53:3
	output wire io_status_uie;
	// Trace: core/CSRFile_5stage.v:54:3
	output wire [31:0] io_evec;
	// Trace: core/CSRFile_5stage.v:55:3
	input io_exception;
	// Trace: core/CSRFile_5stage.v:56:3
	input io_retire;
	// Trace: core/CSRFile_5stage.v:57:3
	input [31:0] io_cause;
	// Trace: core/CSRFile_5stage.v:58:3
	input [31:0] io_pc;
	// Trace: core/CSRFile_5stage.v:59:3
	input [31:0] io_tval;
	// Trace: core/CSRFile_5stage.v:60:3
	output wire [31:0] io_time;
	// Trace: core/CSRFile_5stage.v:61:3
	output wire io_interrupt;
	// Trace: core/CSRFile_5stage.v:62:3
	output wire [31:0] io_interrupt_cause;
	// Trace: core/CSRFile_5stage.v:89:3
	reg reg_mstatus_spp;
	// Trace: core/CSRFile_5stage.v:90:3
	reg reg_mstatus_mpie;
	// Trace: core/CSRFile_5stage.v:91:3
	reg reg_mstatus_mie;
	// Trace: core/CSRFile_5stage.v:92:3
	reg reg_dcsr_ebreakm;
	// Trace: core/CSRFile_5stage.v:93:3
	reg [2:0] reg_dcsr_cause;
	// Trace: core/CSRFile_5stage.v:94:3
	reg reg_dcsr_step;
	// Trace: core/CSRFile_5stage.v:95:3
	reg reg_debug;
	// Trace: core/CSRFile_5stage.v:96:3
	reg [31:0] reg_dpc;
	// Trace: core/CSRFile_5stage.v:97:3
	reg [31:0] reg_dscratch;
	// Trace: core/CSRFile_5stage.v:98:3
	reg reg_singleStepped;
	// Trace: core/CSRFile_5stage.v:99:3
	reg [31:0] reg_mie;
	// Trace: core/CSRFile_5stage.v:100:3
	reg [31:0] reg_mepc;
	// Trace: core/CSRFile_5stage.v:101:3
	reg [31:0] reg_mcause;
	// Trace: core/CSRFile_5stage.v:102:3
	reg [31:0] reg_mtval;
	// Trace: core/CSRFile_5stage.v:103:3
	reg [31:0] reg_mscratch;
	// Trace: core/CSRFile_5stage.v:104:3
	reg [31:0] reg_mtvec;
	// Trace: core/CSRFile_5stage.v:105:3
	reg reg_wfi;
	// Trace: core/CSRFile_5stage.v:106:3
	reg [2:0] reg_mcountinhibit;
	// Trace: core/CSRFile_5stage.v:107:3
	wire x79 = reg_mcountinhibit[2];
	// Trace: core/CSRFile_5stage.v:108:3
	reg [5:0] small_;
	// Trace: core/CSRFile_5stage.v:109:3
	wire [5:0] _GEN_34 = {5'd0, io_retire};
	// Trace: core/CSRFile_5stage.v:110:3
	wire [6:0] nextSmall = small_ + _GEN_34;
	// Trace: core/CSRFile_5stage.v:111:3
	wire _T_14 = ~x79;
	// Trace: core/CSRFile_5stage.v:112:3
	wire [6:0] _GEN_0 = (~x79 ? nextSmall : {1'd0, small_});
	// Trace: core/CSRFile_5stage.v:113:3
	reg [57:0] large_;
	// Trace: core/CSRFile_5stage.v:114:3
	wire [57:0] _large_r_T_1 = large_ + 58'h000000000000001;
	// Trace: core/CSRFile_5stage.v:115:3
	wire [57:0] _GEN_1 = (nextSmall[6] & _T_14 ? _large_r_T_1 : large_);
	// Trace: core/CSRFile_5stage.v:116:3
	wire [63:0] value = {large_, small_};
	// Trace: core/CSRFile_5stage.v:117:3
	wire x86 = ~io_csr_stall;
	// Trace: core/CSRFile_5stage.v:118:3
	reg [5:0] small_1;
	// Trace: core/CSRFile_5stage.v:119:3
	wire [5:0] _GEN_35 = {5'd0, x86};
	// Trace: core/CSRFile_5stage.v:120:3
	wire [6:0] nextSmall_1 = small_1 + _GEN_35;
	// Trace: core/CSRFile_5stage.v:121:3
	wire _T_15 = ~reg_mcountinhibit[0];
	// Trace: core/CSRFile_5stage.v:122:3
	wire [6:0] _GEN_2 = (~reg_mcountinhibit[0] ? nextSmall_1 : {1'd0, small_1});
	// Trace: core/CSRFile_5stage.v:123:3
	reg [57:0] large_1;
	// Trace: core/CSRFile_5stage.v:124:3
	wire [57:0] _large_r_T_3 = large_1 + 58'h000000000000001;
	// Trace: core/CSRFile_5stage.v:125:3
	wire [57:0] _GEN_3 = (nextSmall_1[6] & _T_15 ? _large_r_T_3 : large_1);
	// Trace: core/CSRFile_5stage.v:126:3
	wire [63:0] value_1 = {large_1, small_1};
	// Trace: core/CSRFile_5stage.v:127:3
	wire [15:0] _read_mip_T = {4'h0, io_interrupts_meip, 3'h0, io_interrupts_mtip, 3'h0, io_interrupts_msip, 3'h0};
	// Trace: core/CSRFile_5stage.v:129:3
	wire [15:0] read_mip = _read_mip_T & 16'h0888;
	// Trace: core/CSRFile_5stage.v:130:3
	wire [31:0] _GEN_40 = {16'd0, read_mip};
	// Trace: core/CSRFile_5stage.v:131:3
	wire [31:0] pending_interrupts = _GEN_40 & reg_mie;
	// Trace: core/CSRFile_5stage.v:132:3
	wire [14:0] d_interrupts = {io_interrupts_debug, 14'h0000};
	// Trace: core/CSRFile_5stage.v:133:3
	wire [31:0] _m_interrupts_T_3 = ~pending_interrupts;
	// Trace: core/CSRFile_5stage.v:134:3
	wire [31:0] _m_interrupts_T_5 = ~_m_interrupts_T_3;
	// Trace: core/CSRFile_5stage.v:135:3
	wire [31:0] m_interrupts = (reg_mstatus_mie ? _m_interrupts_T_5 : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:136:3
	wire _any_T_78 = ((((((((((((((d_interrupts[14] | d_interrupts[13]) | d_interrupts[12]) | d_interrupts[11]) | d_interrupts[3]) | d_interrupts[7]) | d_interrupts[9]) | d_interrupts[1]) | d_interrupts[5]) | d_interrupts[10]) | d_interrupts[2]) | d_interrupts[6]) | d_interrupts[8]) | d_interrupts[0]) | d_interrupts[4]) | m_interrupts[15];
	// Trace: core/CSRFile_5stage.v:139:3
	wire anyInterrupt = ((((((((((((((_any_T_78 | m_interrupts[14]) | m_interrupts[13]) | m_interrupts[12]) | m_interrupts[11]) | m_interrupts[3]) | m_interrupts[7]) | m_interrupts[9]) | m_interrupts[1]) | m_interrupts[5]) | m_interrupts[10]) | m_interrupts[2]) | m_interrupts[6]) | m_interrupts[8]) | m_interrupts[0]) | m_interrupts[4];
	// Trace: core/CSRFile_5stage.v:142:3
	wire [3:0] _which_T_95 = (m_interrupts[0] ? 4'h0 : 4'h4);
	// Trace: core/CSRFile_5stage.v:143:3
	wire [3:0] _which_T_96 = (m_interrupts[8] ? 4'h8 : _which_T_95);
	// Trace: core/CSRFile_5stage.v:144:3
	wire [3:0] _which_T_97 = (m_interrupts[6] ? 4'h6 : _which_T_96);
	// Trace: core/CSRFile_5stage.v:145:3
	wire [3:0] _which_T_98 = (m_interrupts[2] ? 4'h2 : _which_T_97);
	// Trace: core/CSRFile_5stage.v:146:3
	wire [3:0] _which_T_99 = (m_interrupts[10] ? 4'ha : _which_T_98);
	// Trace: core/CSRFile_5stage.v:147:3
	wire [3:0] _which_T_100 = (m_interrupts[5] ? 4'h5 : _which_T_99);
	// Trace: core/CSRFile_5stage.v:148:3
	wire [3:0] _which_T_101 = (m_interrupts[1] ? 4'h1 : _which_T_100);
	// Trace: core/CSRFile_5stage.v:149:3
	wire [3:0] _which_T_102 = (m_interrupts[9] ? 4'h9 : _which_T_101);
	// Trace: core/CSRFile_5stage.v:150:3
	wire [3:0] _which_T_103 = (m_interrupts[7] ? 4'h7 : _which_T_102);
	// Trace: core/CSRFile_5stage.v:151:3
	wire [3:0] _which_T_104 = (m_interrupts[3] ? 4'h3 : _which_T_103);
	// Trace: core/CSRFile_5stage.v:152:3
	wire [3:0] _which_T_105 = (m_interrupts[11] ? 4'hb : _which_T_104);
	// Trace: core/CSRFile_5stage.v:153:3
	wire [3:0] _which_T_106 = (m_interrupts[12] ? 4'hc : _which_T_105);
	// Trace: core/CSRFile_5stage.v:154:3
	wire [3:0] _which_T_107 = (m_interrupts[13] ? 4'hd : _which_T_106);
	// Trace: core/CSRFile_5stage.v:155:3
	wire [3:0] _which_T_108 = (m_interrupts[14] ? 4'he : _which_T_107);
	// Trace: core/CSRFile_5stage.v:156:3
	wire [3:0] _which_T_109 = (m_interrupts[15] ? 4'hf : _which_T_108);
	// Trace: core/CSRFile_5stage.v:157:3
	wire [3:0] _which_T_111 = (d_interrupts[4] ? 4'h4 : _which_T_109);
	// Trace: core/CSRFile_5stage.v:158:3
	wire [3:0] _which_T_112 = (d_interrupts[0] ? 4'h0 : _which_T_111);
	// Trace: core/CSRFile_5stage.v:159:3
	wire [3:0] _which_T_113 = (d_interrupts[8] ? 4'h8 : _which_T_112);
	// Trace: core/CSRFile_5stage.v:160:3
	wire [3:0] _which_T_114 = (d_interrupts[6] ? 4'h6 : _which_T_113);
	// Trace: core/CSRFile_5stage.v:161:3
	wire [3:0] _which_T_115 = (d_interrupts[2] ? 4'h2 : _which_T_114);
	// Trace: core/CSRFile_5stage.v:162:3
	wire [3:0] _which_T_116 = (d_interrupts[10] ? 4'ha : _which_T_115);
	// Trace: core/CSRFile_5stage.v:163:3
	wire [3:0] _which_T_117 = (d_interrupts[5] ? 4'h5 : _which_T_116);
	// Trace: core/CSRFile_5stage.v:164:3
	wire [3:0] _which_T_118 = (d_interrupts[1] ? 4'h1 : _which_T_117);
	// Trace: core/CSRFile_5stage.v:165:3
	wire [3:0] _which_T_119 = (d_interrupts[9] ? 4'h9 : _which_T_118);
	// Trace: core/CSRFile_5stage.v:166:3
	wire [3:0] _which_T_120 = (d_interrupts[7] ? 4'h7 : _which_T_119);
	// Trace: core/CSRFile_5stage.v:167:3
	wire [3:0] _which_T_121 = (d_interrupts[3] ? 4'h3 : _which_T_120);
	// Trace: core/CSRFile_5stage.v:168:3
	wire [3:0] _which_T_122 = (d_interrupts[11] ? 4'hb : _which_T_121);
	// Trace: core/CSRFile_5stage.v:169:3
	wire [3:0] _which_T_123 = (d_interrupts[12] ? 4'hc : _which_T_122);
	// Trace: core/CSRFile_5stage.v:170:3
	wire [3:0] _which_T_124 = (d_interrupts[13] ? 4'hd : _which_T_123);
	// Trace: core/CSRFile_5stage.v:171:3
	wire [3:0] whichInterrupt = (d_interrupts[14] ? 4'he : _which_T_124);
	// Trace: core/CSRFile_5stage.v:172:3
	wire [31:0] _GEN_41 = {28'd0, whichInterrupt};
	// Trace: core/CSRFile_5stage.v:173:3
	wire _io_interrupt_T = ~io_singleStep;
	// Trace: core/CSRFile_5stage.v:174:3
	wire [8:0] read_mstatus_lo_lo = {io_status_spp, io_status_mpie, io_status_ube, io_status_spie, io_status_upie, io_status_mie, io_status_hie, io_status_sie, io_status_uie};
	// Trace: core/CSRFile_5stage.v:176:3
	wire [21:0] read_mstatus_lo = {io_status_tw, io_status_tvm, io_status_mxr, io_status_sum, io_status_mprv, io_status_xs, io_status_fs, io_status_mpp, io_status_vs, read_mstatus_lo_lo};
	// Trace: core/CSRFile_5stage.v:178:3
	wire [64:0] read_mstatus_hi_hi = {io_status_debug, io_status_cease, io_status_wfi, io_status_isa, io_status_dprv, io_status_dv, io_status_prv, io_status_v, io_status_sd, io_status_zero2};
	// Trace: core/CSRFile_5stage.v:180:3
	wire [82:0] read_mstatus_hi = {read_mstatus_hi_hi, io_status_mpv, io_status_gva, io_status_mbe, io_status_sbe, io_status_sxl, io_status_uxl, io_status_sd_rv32, io_status_zero1, io_status_tsr};
	// Trace: core/CSRFile_5stage.v:182:3
	wire [104:0] _read_mstatus_T = {read_mstatus_hi, read_mstatus_lo};
	// Trace: core/CSRFile_5stage.v:183:3
	wire [31:0] read_mstatus = _read_mstatus_T[31:0];
	// Trace: core/CSRFile_5stage.v:184:3
	wire [6:0] _read_mtvec_T_1 = (reg_mtvec[0] ? 7'h7e : 7'h02);
	// Trace: core/CSRFile_5stage.v:185:3
	wire [31:0] _read_mtvec_T_3 = {25'd0, _read_mtvec_T_1};
	// Trace: core/CSRFile_5stage.v:186:3
	wire [31:0] _read_mtvec_T_4 = ~_read_mtvec_T_3;
	// Trace: core/CSRFile_5stage.v:187:3
	wire [31:0] read_mtvec = reg_mtvec & _read_mtvec_T_4;
	// Trace: core/CSRFile_5stage.v:188:3
	wire [31:0] _T_18 = ~reg_mepc;
	// Trace: core/CSRFile_5stage.v:189:3
	wire [31:0] _T_21 = _T_18 | 32'h00000003;
	// Trace: core/CSRFile_5stage.v:190:3
	wire [31:0] _T_22 = ~_T_21;
	// Trace: core/CSRFile_5stage.v:191:3
	wire [31:0] _T_23 = {16'h4000, reg_dcsr_ebreakm, 6'h00, reg_dcsr_cause, 3'h0, reg_dcsr_step, 2'h3};
	// Trace: core/CSRFile_5stage.v:192:3
	wire [31:0] _T_24 = ~reg_dpc;
	// Trace: core/CSRFile_5stage.v:193:3
	wire [31:0] _T_27 = _T_24 | 32'h00000003;
	// Trace: core/CSRFile_5stage.v:194:3
	wire [31:0] _T_28 = ~_T_27;
	// Trace: core/CSRFile_5stage.v:195:3
	wire [12:0] addr = {io_status_v, io_rw_addr};
	// Trace: core/CSRFile_5stage.v:196:3
	wire [12:0] _decoded_T_8 = addr & 13'h0865;
	// Trace: core/CSRFile_5stage.v:197:3
	wire decoded_4 = _decoded_T_8 == 13'h0001;
	// Trace: core/CSRFile_5stage.v:198:3
	wire decoded_5 = _decoded_T_8 == 13'h0000;
	// Trace: core/CSRFile_5stage.v:199:3
	wire [12:0] _decoded_T_12 = addr & 13'h0825;
	// Trace: core/CSRFile_5stage.v:200:3
	wire decoded_6 = _decoded_T_12 == 13'h0005;
	// Trace: core/CSRFile_5stage.v:201:3
	wire [12:0] _decoded_T_14 = addr & 13'h0044;
	// Trace: core/CSRFile_5stage.v:202:3
	wire decoded_7 = _decoded_T_14 == 13'h0044;
	// Trace: core/CSRFile_5stage.v:203:3
	wire decoded_8 = _decoded_T_8 == 13'h0004;
	// Trace: core/CSRFile_5stage.v:204:3
	wire [12:0] _decoded_T_18 = addr & 13'h0047;
	// Trace: core/CSRFile_5stage.v:205:3
	wire decoded_9 = _decoded_T_18 == 13'h0040;
	// Trace: core/CSRFile_5stage.v:206:3
	wire [12:0] _decoded_T_20 = addr & 13'h0043;
	// Trace: core/CSRFile_5stage.v:207:3
	wire decoded_10 = _decoded_T_20 == 13'h0041;
	// Trace: core/CSRFile_5stage.v:208:3
	wire [12:0] _decoded_T_22 = addr & 13'h0823;
	// Trace: core/CSRFile_5stage.v:209:3
	wire decoded_11 = _decoded_T_22 == 13'h0003;
	// Trace: core/CSRFile_5stage.v:210:3
	wire decoded_12 = _decoded_T_22 == 13'h0002;
	// Trace: core/CSRFile_5stage.v:211:3
	wire [12:0] _decoded_T_26 = addr & 13'h0483;
	// Trace: core/CSRFile_5stage.v:212:3
	wire decoded_13 = _decoded_T_26 == 13'h0400;
	// Trace: core/CSRFile_5stage.v:213:3
	wire [12:0] _decoded_T_28 = addr & 13'h0c13;
	// Trace: core/CSRFile_5stage.v:214:3
	wire decoded_14 = _decoded_T_28 == 13'h0410;
	// Trace: core/CSRFile_5stage.v:215:3
	wire [12:0] _decoded_T_30 = addr & 13'h0c11;
	// Trace: core/CSRFile_5stage.v:216:3
	wire decoded_15 = _decoded_T_30 == 13'h0411;
	// Trace: core/CSRFile_5stage.v:217:3
	wire [12:0] _decoded_T_32 = addr & 13'h0c12;
	// Trace: core/CSRFile_5stage.v:218:3
	wire decoded_16 = _decoded_T_32 == 13'h0412;
	// Trace: core/CSRFile_5stage.v:219:3
	wire [12:0] _decoded_T_34 = addr & 13'h043e;
	// Trace: core/CSRFile_5stage.v:220:3
	wire decoded_17 = _decoded_T_34 == 13'h0020;
	// Trace: core/CSRFile_5stage.v:221:3
	wire [12:0] _decoded_T_36 = addr & 13'h089e;
	// Trace: core/CSRFile_5stage.v:222:3
	wire decoded_18 = _decoded_T_36 == 13'h0800;
	// Trace: core/CSRFile_5stage.v:223:3
	wire [12:0] _decoded_T_38 = addr & 13'h00df;
	// Trace: core/CSRFile_5stage.v:224:3
	wire decoded_19 = _decoded_T_38 == 13'h0002;
	// Trace: core/CSRFile_5stage.v:225:3
	wire [12:0] _decoded_T_122 = addr & 13'h049f;
	// Trace: core/CSRFile_5stage.v:226:3
	wire [12:0] _decoded_T_214 = addr & 13'h049e;
	// Trace: core/CSRFile_5stage.v:227:3
	wire decoded_107 = _decoded_T_214 == 13'h0080;
	// Trace: core/CSRFile_5stage.v:228:3
	wire decoded_108 = _decoded_T_122 == 13'h0082;
	// Trace: core/CSRFile_5stage.v:229:3
	wire [31:0] _wdata_T_1 = (io_rw_cmd[1] ? io_rw_rdata : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:230:3
	wire [31:0] _wdata_T_2 = _wdata_T_1 | io_rw_wdata;
	// Trace: core/CSRFile_5stage.v:231:3
	wire [31:0] _wdata_T_5 = (&io_rw_cmd[1:0] ? io_rw_wdata : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:232:3
	wire [31:0] _wdata_T_6 = ~_wdata_T_5;
	// Trace: core/CSRFile_5stage.v:233:3
	wire [31:0] wdata = _wdata_T_2 & _wdata_T_6;
	// Trace: core/CSRFile_5stage.v:234:3
	wire system_insn = io_rw_cmd == 3'h4;
	// Trace: core/CSRFile_5stage.v:235:3
	wire [31:0] _T_172 = {io_rw_addr, 20'h00000};
	// Trace: core/CSRFile_5stage.v:236:3
	wire [31:0] _T_173 = _T_172 & 32'h20100000;
	// Trace: core/CSRFile_5stage.v:237:3
	wire _T_174 = _T_173 == 32'h00000000;
	// Trace: core/CSRFile_5stage.v:238:3
	wire [31:0] _T_176 = _T_172 & 32'h10100000;
	// Trace: core/CSRFile_5stage.v:239:3
	wire _T_177 = _T_176 == 32'h00100000;
	// Trace: core/CSRFile_5stage.v:240:3
	wire [31:0] _T_179 = _T_172 & 32'h20400000;
	// Trace: core/CSRFile_5stage.v:241:3
	wire _T_180 = _T_179 == 32'h20000000;
	// Trace: core/CSRFile_5stage.v:242:3
	wire [31:0] _T_182 = _T_172 & 32'h20200000;
	// Trace: core/CSRFile_5stage.v:243:3
	wire _T_183 = _T_182 == 32'h20000000;
	// Trace: core/CSRFile_5stage.v:244:3
	wire [31:0] _T_185 = _T_172 & 32'h30000000;
	// Trace: core/CSRFile_5stage.v:245:3
	wire _T_186 = _T_185 == 32'h10000000;
	// Trace: core/CSRFile_5stage.v:246:3
	wire insn_call = system_insn & _T_174;
	// Trace: core/CSRFile_5stage.v:247:3
	wire insn_break = system_insn & _T_177;
	// Trace: core/CSRFile_5stage.v:248:3
	wire insn_ret = system_insn & _T_180;
	// Trace: core/CSRFile_5stage.v:249:3
	wire insn_cease = system_insn & _T_183;
	// Trace: core/CSRFile_5stage.v:250:3
	wire insn_wfi = system_insn & _T_186;
	// Trace: core/CSRFile_5stage.v:251:3
	wire _io_decode_0_read_illegal_T_16 = ~reg_debug;
	// Trace: core/CSRFile_5stage.v:252:3
	wire [31:0] _cause_T_5 = (insn_break ? 32'h00000003 : io_cause);
	// Trace: core/CSRFile_5stage.v:253:3
	wire [31:0] cause = (insn_call ? 32'h0000000b : _cause_T_5);
	// Trace: core/CSRFile_5stage.v:254:3
	wire [7:0] cause_lsbs = cause[7:0];
	// Trace: core/CSRFile_5stage.v:255:3
	wire _causeIsDebugInt_T_1 = cause_lsbs == 8'h0e;
	// Trace: core/CSRFile_5stage.v:256:3
	wire causeIsDebugInt = cause[31] & (cause_lsbs == 8'h0e);
	// Trace: core/CSRFile_5stage.v:257:3
	wire _causeIsDebugTrigger_T_1 = ~cause[31];
	// Trace: core/CSRFile_5stage.v:258:3
	wire causeIsDebugTrigger = ~cause[31] & _causeIsDebugInt_T_1;
	// Trace: core/CSRFile_5stage.v:259:3
	wire [3:0] _causeIsDebugBreak_T_3 = {reg_dcsr_ebreakm, 3'h0};
	// Trace: core/CSRFile_5stage.v:260:3
	wire [3:0] _causeIsDebugBreak_T_4 = {3'd0, _causeIsDebugBreak_T_3[3]};
	// Trace: core/CSRFile_5stage.v:261:3
	wire causeIsDebugBreak = (_causeIsDebugTrigger_T_1 & insn_break) & _causeIsDebugBreak_T_4[0];
	// Trace: core/CSRFile_5stage.v:262:3
	wire trapToDebug = (((reg_singleStepped | causeIsDebugInt) | causeIsDebugTrigger) | causeIsDebugBreak) | reg_debug;
	// Trace: core/CSRFile_5stage.v:263:3
	wire [11:0] _debugTVec_T = (insn_break ? 12'h800 : 12'h808);
	// Trace: core/CSRFile_5stage.v:264:3
	wire [11:0] debugTVec = (reg_debug ? _debugTVec_T : 12'h800);
	// Trace: core/CSRFile_5stage.v:265:3
	wire [6:0] notDebugTVec_interruptOffset = {cause[4:0], 2'h0};
	// Trace: core/CSRFile_5stage.v:266:3
	wire [31:0] notDebugTVec_interruptVec = {read_mtvec[31:7], notDebugTVec_interruptOffset};
	// Trace: core/CSRFile_5stage.v:267:3
	wire notDebugTVec_doVector = (read_mtvec[0] & cause[31]) & (cause_lsbs[7:5] == 3'h0);
	// Trace: core/CSRFile_5stage.v:268:3
	wire [31:0] _notDebugTVec_T_1 = {read_mtvec[31:2], 2'h0};
	// Trace: core/CSRFile_5stage.v:269:3
	wire [31:0] notDebugTVec = (notDebugTVec_doVector ? notDebugTVec_interruptVec : _notDebugTVec_T_1);
	// Trace: core/CSRFile_5stage.v:270:3
	wire [31:0] tvec = (trapToDebug ? {20'd0, debugTVec} : notDebugTVec);
	// Trace: core/CSRFile_5stage.v:271:3
	wire _io_eret_T = insn_call | insn_break;
	// Trace: core/CSRFile_5stage.v:272:3
	wire exception = _io_eret_T | io_exception;
	// Trace: core/CSRFile_5stage.v:273:3
	wire [1:0] _T_214 = insn_ret + insn_call;
	// Trace: core/CSRFile_5stage.v:274:3
	wire [1:0] _T_216 = insn_break + io_exception;
	// Trace: core/CSRFile_5stage.v:275:3
	wire [2:0] _T_218 = _T_214 + _T_216;
	// Trace: core/CSRFile_5stage.v:276:3
	wire _T_222 = ~reset;
	// Trace: core/CSRFile_5stage.v:277:3
	wire _GEN_46 = ((insn_wfi & _io_interrupt_T) & _io_decode_0_read_illegal_T_16) | reg_wfi;
	// Trace: core/CSRFile_5stage.v:278:3
	wire _GEN_48 = (io_retire | exception) | reg_singleStepped;
	// Trace: core/CSRFile_5stage.v:279:3
	wire [31:0] _epc_T = ~io_pc;
	// Trace: core/CSRFile_5stage.v:280:3
	wire [31:0] _epc_T_1 = _epc_T | 32'h00000003;
	// Trace: core/CSRFile_5stage.v:281:3
	wire [31:0] epc = ~_epc_T_1;
	// Trace: core/CSRFile_5stage.v:282:3
	wire [1:0] _reg_dcsr_cause_T = (causeIsDebugTrigger ? 2'h2 : 2'h1);
	// Trace: core/CSRFile_5stage.v:283:3
	wire [1:0] _reg_dcsr_cause_T_1 = (causeIsDebugInt ? 2'h3 : _reg_dcsr_cause_T);
	// Trace: core/CSRFile_5stage.v:284:3
	wire [2:0] _reg_dcsr_cause_T_2 = (reg_singleStepped ? 3'h4 : {1'd0, _reg_dcsr_cause_T_1});
	// Trace: core/CSRFile_5stage.v:285:3
	wire _GEN_51 = _io_decode_0_read_illegal_T_16 | reg_debug;
	// Trace: core/CSRFile_5stage.v:286:3
	wire [31:0] _GEN_52 = (_io_decode_0_read_illegal_T_16 ? epc : reg_dpc);
	// Trace: core/CSRFile_5stage.v:287:3
	wire [1:0] _GEN_73 = {1'd0, reg_mstatus_spp};
	// Trace: core/CSRFile_5stage.v:288:3
	wire _GEN_145 = (trapToDebug ? _GEN_51 : reg_debug);
	// Trace: core/CSRFile_5stage.v:289:3
	wire [31:0] _GEN_146 = (trapToDebug ? _GEN_52 : reg_dpc);
	// Trace: core/CSRFile_5stage.v:290:3
	wire [1:0] _GEN_170 = (trapToDebug ? {1'd0, reg_mstatus_spp} : _GEN_73);
	// Trace: core/CSRFile_5stage.v:291:3
	wire [31:0] _GEN_174 = (trapToDebug ? reg_mepc : epc);
	// Trace: core/CSRFile_5stage.v:292:3
	wire [31:0] _GEN_175 = (trapToDebug ? reg_mcause : cause);
	// Trace: core/CSRFile_5stage.v:293:3
	wire [31:0] _GEN_176 = (trapToDebug ? reg_mtval : io_tval);
	// Trace: core/CSRFile_5stage.v:294:3
	wire _GEN_178 = (trapToDebug ? reg_mstatus_mpie : reg_mstatus_mie);
	// Trace: core/CSRFile_5stage.v:295:3
	wire _GEN_180 = trapToDebug & reg_mstatus_mie;
	// Trace: core/CSRFile_5stage.v:296:3
	wire _GEN_182 = (exception ? _GEN_145 : reg_debug);
	// Trace: core/CSRFile_5stage.v:297:3
	wire [31:0] _GEN_183 = (exception ? _GEN_146 : reg_dpc);
	// Trace: core/CSRFile_5stage.v:298:3
	wire [1:0] _GEN_207 = (exception ? _GEN_170 : {1'd0, reg_mstatus_spp});
	// Trace: core/CSRFile_5stage.v:299:3
	wire [31:0] _GEN_211 = (exception ? _GEN_174 : reg_mepc);
	// Trace: core/CSRFile_5stage.v:300:3
	wire [31:0] _GEN_212 = (exception ? _GEN_175 : reg_mcause);
	// Trace: core/CSRFile_5stage.v:301:3
	wire [31:0] _GEN_213 = (exception ? _GEN_176 : reg_mtval);
	// Trace: core/CSRFile_5stage.v:302:3
	wire _GEN_215 = (exception ? _GEN_178 : reg_mstatus_mpie);
	// Trace: core/CSRFile_5stage.v:303:3
	wire _GEN_217 = (exception ? _GEN_180 : reg_mstatus_mie);
	// Trace: core/CSRFile_5stage.v:304:3
	wire [31:0] _GEN_239 = (io_rw_addr[10] & io_rw_addr[7] ? _T_28 : _T_22);
	// Trace: core/CSRFile_5stage.v:305:3
	wire _GEN_241 = (io_rw_addr[10] & io_rw_addr[7] ? _GEN_217 : reg_mstatus_mpie);
	// Trace: core/CSRFile_5stage.v:306:3
	wire _GEN_242 = (io_rw_addr[10] & io_rw_addr[7] ? _GEN_215 : 1'h1);
	// Trace: core/CSRFile_5stage.v:307:3
	wire _GEN_273 = (insn_ret ? _GEN_241 : _GEN_217);
	// Trace: core/CSRFile_5stage.v:308:3
	wire _GEN_274 = (insn_ret ? _GEN_242 : _GEN_215);
	// Trace: core/CSRFile_5stage.v:309:3
	reg io_status_cease_r;
	// Trace: core/CSRFile_5stage.v:310:3
	wire _GEN_279 = insn_cease | io_status_cease_r;
	// Trace: core/CSRFile_5stage.v:311:3
	wire [30:0] _io_rw_rdata_T_4 = (decoded_4 ? 31'h40800100 : 31'h00000000);
	// Trace: core/CSRFile_5stage.v:312:3
	wire [31:0] _io_rw_rdata_T_5 = (decoded_5 ? read_mstatus : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:313:3
	wire [31:0] _io_rw_rdata_T_6 = (decoded_6 ? read_mtvec : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:314:3
	wire [15:0] _io_rw_rdata_T_7 = (decoded_7 ? read_mip : 16'h0000);
	// Trace: core/CSRFile_5stage.v:315:3
	wire [31:0] _io_rw_rdata_T_8 = (decoded_8 ? reg_mie : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:316:3
	wire [31:0] _io_rw_rdata_T_9 = (decoded_9 ? reg_mscratch : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:317:3
	wire [31:0] _io_rw_rdata_T_10 = (decoded_10 ? _T_22 : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:318:3
	wire [31:0] _io_rw_rdata_T_11 = (decoded_11 ? reg_mtval : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:319:3
	wire [31:0] _io_rw_rdata_T_12 = (decoded_12 ? reg_mcause : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:320:3
	wire _io_rw_rdata_T_13 = decoded_13 & io_hartid;
	// Trace: core/CSRFile_5stage.v:321:3
	wire [31:0] _io_rw_rdata_T_14 = (decoded_14 ? _T_23 : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:322:3
	wire [31:0] _io_rw_rdata_T_15 = (decoded_15 ? _T_28 : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:323:3
	wire [31:0] _io_rw_rdata_T_16 = (decoded_16 ? reg_dscratch : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:324:3
	wire [2:0] _io_rw_rdata_T_17 = (decoded_17 ? reg_mcountinhibit : 3'h0);
	// Trace: core/CSRFile_5stage.v:325:3
	wire [63:0] _io_rw_rdata_T_18 = (decoded_18 ? value_1 : 64'h0000000000000000);
	// Trace: core/CSRFile_5stage.v:326:3
	wire [63:0] _io_rw_rdata_T_19 = (decoded_19 ? value : 64'h0000000000000000);
	// Trace: core/CSRFile_5stage.v:327:3
	wire [31:0] _io_rw_rdata_T_107 = (decoded_107 ? value_1[63:32] : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:328:3
	wire [31:0] _io_rw_rdata_T_108 = (decoded_108 ? value[63:32] : 32'h00000000);
	// Trace: core/CSRFile_5stage.v:329:3
	wire [31:0] _io_rw_rdata_T_115 = {1'd0, _io_rw_rdata_T_4};
	// Trace: core/CSRFile_5stage.v:330:3
	wire [31:0] _io_rw_rdata_T_116 = _io_rw_rdata_T_115 | _io_rw_rdata_T_5;
	// Trace: core/CSRFile_5stage.v:331:3
	wire [31:0] _io_rw_rdata_T_117 = _io_rw_rdata_T_116 | _io_rw_rdata_T_6;
	// Trace: core/CSRFile_5stage.v:332:3
	wire [31:0] _GEN_341 = {16'd0, _io_rw_rdata_T_7};
	// Trace: core/CSRFile_5stage.v:333:3
	wire [31:0] _io_rw_rdata_T_118 = _io_rw_rdata_T_117 | _GEN_341;
	// Trace: core/CSRFile_5stage.v:334:3
	wire [31:0] _io_rw_rdata_T_119 = _io_rw_rdata_T_118 | _io_rw_rdata_T_8;
	// Trace: core/CSRFile_5stage.v:335:3
	wire [31:0] _io_rw_rdata_T_120 = _io_rw_rdata_T_119 | _io_rw_rdata_T_9;
	// Trace: core/CSRFile_5stage.v:336:3
	wire [31:0] _io_rw_rdata_T_121 = _io_rw_rdata_T_120 | _io_rw_rdata_T_10;
	// Trace: core/CSRFile_5stage.v:337:3
	wire [31:0] _io_rw_rdata_T_122 = _io_rw_rdata_T_121 | _io_rw_rdata_T_11;
	// Trace: core/CSRFile_5stage.v:338:3
	wire [31:0] _io_rw_rdata_T_123 = _io_rw_rdata_T_122 | _io_rw_rdata_T_12;
	// Trace: core/CSRFile_5stage.v:339:3
	wire [31:0] _GEN_342 = {31'd0, _io_rw_rdata_T_13};
	// Trace: core/CSRFile_5stage.v:340:3
	wire [31:0] _io_rw_rdata_T_124 = _io_rw_rdata_T_123 | _GEN_342;
	// Trace: core/CSRFile_5stage.v:341:3
	wire [31:0] _io_rw_rdata_T_125 = _io_rw_rdata_T_124 | _io_rw_rdata_T_14;
	// Trace: core/CSRFile_5stage.v:342:3
	wire [31:0] _io_rw_rdata_T_126 = _io_rw_rdata_T_125 | _io_rw_rdata_T_15;
	// Trace: core/CSRFile_5stage.v:343:3
	wire [31:0] _io_rw_rdata_T_127 = _io_rw_rdata_T_126 | _io_rw_rdata_T_16;
	// Trace: core/CSRFile_5stage.v:344:3
	wire [31:0] _GEN_343 = {29'd0, _io_rw_rdata_T_17};
	// Trace: core/CSRFile_5stage.v:345:3
	wire [31:0] _io_rw_rdata_T_128 = _io_rw_rdata_T_127 | _GEN_343;
	// Trace: core/CSRFile_5stage.v:346:3
	wire [63:0] _GEN_344 = {32'd0, _io_rw_rdata_T_128};
	// Trace: core/CSRFile_5stage.v:347:3
	wire [63:0] _io_rw_rdata_T_129 = _GEN_344 | _io_rw_rdata_T_18;
	// Trace: core/CSRFile_5stage.v:348:3
	wire [63:0] _io_rw_rdata_T_130 = _io_rw_rdata_T_129 | _io_rw_rdata_T_19;
	// Trace: core/CSRFile_5stage.v:349:3
	wire [63:0] _GEN_345 = {32'd0, _io_rw_rdata_T_107};
	// Trace: core/CSRFile_5stage.v:350:3
	wire [63:0] _io_rw_rdata_T_218 = _io_rw_rdata_T_130 | _GEN_345;
	// Trace: core/CSRFile_5stage.v:351:3
	wire [63:0] _GEN_346 = {32'd0, _io_rw_rdata_T_108};
	// Trace: core/CSRFile_5stage.v:352:3
	wire [63:0] _io_rw_rdata_T_219 = _io_rw_rdata_T_218 | _GEN_346;
	// Trace: core/CSRFile_5stage.v:353:3
	wire _T_366 = io_rw_cmd == 3'h5;
	// Trace: core/CSRFile_5stage.v:354:3
	wire _T_367 = io_rw_cmd == 3'h6;
	// Trace: core/CSRFile_5stage.v:355:3
	wire _T_368 = io_rw_cmd == 3'h7;
	// Trace: core/CSRFile_5stage.v:356:3
	wire csr_wen = (_T_367 | _T_368) | _T_366;
	// Trace: core/CSRFile_5stage.v:357:3
	wire [104:0] _new_mstatus_WIRE = {73'd0, wdata};
	// Trace: core/CSRFile_5stage.v:358:3
	wire new_mstatus_mie = _new_mstatus_WIRE[3];
	// Trace: core/CSRFile_5stage.v:359:3
	wire new_mstatus_mpie = _new_mstatus_WIRE[7];
	// Trace: core/CSRFile_5stage.v:360:3
	wire [31:0] _reg_mie_T = wdata & 32'h00000888;
	// Trace: core/CSRFile_5stage.v:361:3
	wire [31:0] _reg_mepc_T = ~wdata;
	// Trace: core/CSRFile_5stage.v:362:3
	wire [31:0] _reg_mepc_T_1 = _reg_mepc_T | 32'h00000003;
	// Trace: core/CSRFile_5stage.v:363:3
	wire [31:0] _reg_mepc_T_2 = ~_reg_mepc_T_1;
	// Trace: core/CSRFile_5stage.v:364:3
	wire [31:0] _reg_mcause_T = wdata & 32'h8000000f;
	// Trace: core/CSRFile_5stage.v:365:3
	wire [31:0] _reg_mcountinhibit_T_1 = wdata & 32'hfffffffd;
	// Trace: core/CSRFile_5stage.v:366:3
	wire [31:0] _GEN_293 = (decoded_17 ? _reg_mcountinhibit_T_1 : {29'd0, reg_mcountinhibit});
	// Trace: core/CSRFile_5stage.v:367:3
	wire [63:0] _T_1714 = {value_1[63:32], wdata};
	// Trace: core/CSRFile_5stage.v:368:3
	wire [63:0] _GEN_294 = (decoded_18 ? _T_1714 : {57'd0, _GEN_2});
	// Trace: core/CSRFile_5stage.v:369:3
	wire [63:0] _T_1717 = {wdata, value_1[31:0]};
	// Trace: core/CSRFile_5stage.v:370:3
	wire [63:0] _GEN_296 = (decoded_107 ? _T_1717 : _GEN_294);
	// Trace: core/CSRFile_5stage.v:371:3
	wire [63:0] _T_1719 = {value[63:32], wdata};
	// Trace: core/CSRFile_5stage.v:372:3
	wire [63:0] _GEN_298 = (decoded_19 ? _T_1719 : {57'd0, _GEN_0});
	// Trace: core/CSRFile_5stage.v:373:3
	wire [63:0] _T_1722 = {wdata, value[31:0]};
	// Trace: core/CSRFile_5stage.v:374:3
	wire [63:0] _GEN_300 = (decoded_108 ? _T_1722 : _GEN_298);
	// Trace: core/CSRFile_5stage.v:375:3
	wire new_dcsr_ebreakm = wdata[15];
	// Trace: core/CSRFile_5stage.v:376:3
	wire [31:0] _GEN_315 = (csr_wen ? _GEN_293 : {29'd0, reg_mcountinhibit});
	// Trace: core/CSRFile_5stage.v:377:3
	wire [63:0] _GEN_316 = (csr_wen ? _GEN_296 : {57'd0, _GEN_2});
	// Trace: core/CSRFile_5stage.v:378:3
	wire [63:0] _GEN_318 = (csr_wen ? _GEN_300 : {57'd0, _GEN_0});
	// Trace: core/CSRFile_5stage.v:379:3
	assign io_rw_rdata = _io_rw_rdata_T_219[31:0];
	// Trace: core/CSRFile_5stage.v:380:3
	assign io_csr_stall = reg_wfi | io_status_cease;
	// Trace: core/CSRFile_5stage.v:381:3
	assign io_eret = (insn_call | insn_break) | insn_ret;
	// Trace: core/CSRFile_5stage.v:382:3
	assign io_singleStep = reg_dcsr_step & _io_decode_0_read_illegal_T_16;
	// Trace: core/CSRFile_5stage.v:383:3
	assign io_status_debug = reg_debug;
	// Trace: core/CSRFile_5stage.v:384:3
	assign io_status_cease = io_status_cease_r;
	// Trace: core/CSRFile_5stage.v:385:3
	assign io_status_wfi = reg_wfi;
	// Trace: core/CSRFile_5stage.v:386:3
	assign io_status_isa = 32'h40800100;
	// Trace: core/CSRFile_5stage.v:387:3
	assign io_status_dprv = 2'h3;
	// Trace: core/CSRFile_5stage.v:388:3
	assign io_status_dv = 1'h0;
	// Trace: core/CSRFile_5stage.v:389:3
	assign io_status_prv = 2'h3;
	// Trace: core/CSRFile_5stage.v:390:3
	assign io_status_v = 1'h0;
	// Trace: core/CSRFile_5stage.v:391:3
	assign io_status_sd = (&io_status_fs | &io_status_xs) | &io_status_vs;
	// Trace: core/CSRFile_5stage.v:392:3
	assign io_status_zero2 = 23'h000000;
	// Trace: core/CSRFile_5stage.v:393:3
	assign io_status_mpv = 1'h0;
	// Trace: core/CSRFile_5stage.v:394:3
	assign io_status_gva = 1'h0;
	// Trace: core/CSRFile_5stage.v:395:3
	assign io_status_mbe = 1'h0;
	// Trace: core/CSRFile_5stage.v:396:3
	assign io_status_sbe = 1'h0;
	// Trace: core/CSRFile_5stage.v:397:3
	assign io_status_sxl = 2'h0;
	// Trace: core/CSRFile_5stage.v:398:3
	assign io_status_uxl = 2'h0;
	// Trace: core/CSRFile_5stage.v:399:3
	assign io_status_sd_rv32 = io_status_sd;
	// Trace: core/CSRFile_5stage.v:400:3
	assign io_status_zero1 = 8'h00;
	// Trace: core/CSRFile_5stage.v:401:3
	assign io_status_tsr = 1'h0;
	// Trace: core/CSRFile_5stage.v:402:3
	assign io_status_tw = 1'h0;
	// Trace: core/CSRFile_5stage.v:403:3
	assign io_status_tvm = 1'h0;
	// Trace: core/CSRFile_5stage.v:404:3
	assign io_status_mxr = 1'h0;
	// Trace: core/CSRFile_5stage.v:405:3
	assign io_status_sum = 1'h0;
	// Trace: core/CSRFile_5stage.v:406:3
	assign io_status_mprv = 1'h0;
	// Trace: core/CSRFile_5stage.v:407:3
	assign io_status_xs = 2'h0;
	// Trace: core/CSRFile_5stage.v:408:3
	assign io_status_fs = 2'h0;
	// Trace: core/CSRFile_5stage.v:409:3
	assign io_status_mpp = 2'h3;
	// Trace: core/CSRFile_5stage.v:410:3
	assign io_status_vs = 2'h0;
	// Trace: core/CSRFile_5stage.v:411:3
	assign io_status_spp = reg_mstatus_spp;
	// Trace: core/CSRFile_5stage.v:412:3
	assign io_status_mpie = reg_mstatus_mpie;
	// Trace: core/CSRFile_5stage.v:413:3
	assign io_status_ube = 1'h0;
	// Trace: core/CSRFile_5stage.v:414:3
	assign io_status_spie = 1'h0;
	// Trace: core/CSRFile_5stage.v:415:3
	assign io_status_upie = 1'h0;
	// Trace: core/CSRFile_5stage.v:416:3
	assign io_status_mie = reg_mstatus_mie;
	// Trace: core/CSRFile_5stage.v:417:3
	assign io_status_hie = 1'h0;
	// Trace: core/CSRFile_5stage.v:418:3
	assign io_status_sie = 1'h0;
	// Trace: core/CSRFile_5stage.v:419:3
	assign io_status_uie = 1'h0;
	// Trace: core/CSRFile_5stage.v:420:3
	assign io_evec = (insn_ret ? _GEN_239 : tvec);
	// Trace: core/CSRFile_5stage.v:421:3
	assign io_time = value_1[31:0];
	// Trace: core/CSRFile_5stage.v:422:3
	assign io_interrupt = ((anyInterrupt & ~io_singleStep) | reg_singleStepped) & ~(reg_debug | io_status_cease);
	// Trace: core/CSRFile_5stage.v:423:3
	assign io_interrupt_cause = 32'h80000000 + _GEN_41;
	// Trace: core/CSRFile_5stage.v:424:3
	always @(posedge clock) begin
		// Trace: core/CSRFile_5stage.v:425:5
		if (reset)
			// Trace: core/CSRFile_5stage.v:426:7
			reg_mstatus_spp <= 1'h0;
		else
			// Trace: core/CSRFile_5stage.v:428:7
			reg_mstatus_spp <= _GEN_207[0];
		if (reset)
			// Trace: core/CSRFile_5stage.v:431:7
			reg_mstatus_mpie <= 1'h0;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:433:7
				if (decoded_5)
					// Trace: core/CSRFile_5stage.v:434:9
					reg_mstatus_mpie <= new_mstatus_mpie;
				else
					// Trace: core/CSRFile_5stage.v:436:9
					reg_mstatus_mpie <= _GEN_274;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:439:7
			reg_mstatus_mpie <= _GEN_274;
		if (reset)
			// Trace: core/CSRFile_5stage.v:442:7
			reg_mstatus_mie <= 1'h0;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:444:7
				if (decoded_5)
					// Trace: core/CSRFile_5stage.v:445:9
					reg_mstatus_mie <= new_mstatus_mie;
				else
					// Trace: core/CSRFile_5stage.v:447:9
					reg_mstatus_mie <= _GEN_273;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:450:7
			reg_mstatus_mie <= _GEN_273;
		if (reset)
			// Trace: core/CSRFile_5stage.v:453:7
			reg_dcsr_ebreakm <= 1'h0;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:455:7
				if (decoded_14)
					// Trace: core/CSRFile_5stage.v:456:9
					reg_dcsr_ebreakm <= new_dcsr_ebreakm;
			end
		end
		if (reset)
			// Trace: core/CSRFile_5stage.v:460:7
			reg_dcsr_cause <= 3'h0;
		else if (exception) begin
			begin
				// Trace: core/CSRFile_5stage.v:462:7
				if (trapToDebug) begin
					begin
						// Trace: core/CSRFile_5stage.v:463:9
						if (_io_decode_0_read_illegal_T_16)
							// Trace: core/CSRFile_5stage.v:464:11
							reg_dcsr_cause <= _reg_dcsr_cause_T_2;
					end
				end
			end
		end
		if (reset)
			// Trace: core/CSRFile_5stage.v:469:7
			reg_dcsr_step <= 1'h0;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:471:7
				if (decoded_14)
					// Trace: core/CSRFile_5stage.v:472:9
					reg_dcsr_step <= wdata[2];
			end
		end
		if (reset)
			// Trace: core/CSRFile_5stage.v:476:7
			reg_debug <= 1'h0;
		else if (insn_ret) begin
			begin
				// Trace: core/CSRFile_5stage.v:478:7
				if (io_rw_addr[10] & io_rw_addr[7])
					// Trace: core/CSRFile_5stage.v:479:9
					reg_debug <= 1'h0;
				else
					// Trace: core/CSRFile_5stage.v:481:9
					reg_debug <= _GEN_182;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:484:7
			reg_debug <= _GEN_182;
		if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:487:7
				if (decoded_15)
					// Trace: core/CSRFile_5stage.v:488:9
					reg_dpc <= _reg_mepc_T_2;
				else
					// Trace: core/CSRFile_5stage.v:490:9
					reg_dpc <= _GEN_183;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:493:7
			reg_dpc <= _GEN_183;
		if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:496:7
				if (decoded_16)
					// Trace: core/CSRFile_5stage.v:497:9
					reg_dscratch <= wdata;
			end
		end
		if (_io_interrupt_T)
			// Trace: core/CSRFile_5stage.v:501:7
			reg_singleStepped <= 1'h0;
		else
			// Trace: core/CSRFile_5stage.v:503:7
			reg_singleStepped <= _GEN_48;
		if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:506:7
				if (decoded_8)
					// Trace: core/CSRFile_5stage.v:507:9
					reg_mie <= _reg_mie_T;
			end
		end
		if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:511:7
				if (decoded_10)
					// Trace: core/CSRFile_5stage.v:512:9
					reg_mepc <= _reg_mepc_T_2;
				else
					// Trace: core/CSRFile_5stage.v:514:9
					reg_mepc <= _GEN_211;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:517:7
			reg_mepc <= _GEN_211;
		if (reset)
			// Trace: core/CSRFile_5stage.v:520:7
			reg_mcause <= 32'h00000000;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:522:7
				if (decoded_12)
					// Trace: core/CSRFile_5stage.v:523:9
					reg_mcause <= _reg_mcause_T;
				else
					// Trace: core/CSRFile_5stage.v:525:9
					reg_mcause <= _GEN_212;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:528:7
			reg_mcause <= _GEN_212;
		if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:531:7
				if (decoded_11)
					// Trace: core/CSRFile_5stage.v:532:9
					reg_mtval <= wdata;
				else
					// Trace: core/CSRFile_5stage.v:534:9
					reg_mtval <= _GEN_213;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:537:7
			reg_mtval <= _GEN_213;
		if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:540:7
				if (decoded_9)
					// Trace: core/CSRFile_5stage.v:541:9
					reg_mscratch <= wdata;
			end
		end
		if (reset)
			// Trace: core/CSRFile_5stage.v:545:7
			reg_mtvec <= 32'h00000000;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:547:7
				if (decoded_6)
					// Trace: core/CSRFile_5stage.v:548:9
					reg_mtvec <= wdata;
			end
		end
		if (reset)
			// Trace: core/CSRFile_5stage.v:552:7
			reg_mcountinhibit <= 3'h0;
		else
			// Trace: core/CSRFile_5stage.v:554:7
			reg_mcountinhibit <= _GEN_315[2:0];
		if (reset)
			// Trace: core/CSRFile_5stage.v:557:7
			small_ <= 6'h00;
		else
			// Trace: core/CSRFile_5stage.v:559:7
			small_ <= _GEN_318[5:0];
		if (reset)
			// Trace: core/CSRFile_5stage.v:562:7
			large_ <= 58'h000000000000000;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:564:7
				if (decoded_108)
					// Trace: core/CSRFile_5stage.v:565:9
					large_ <= _T_1722[63:6];
				else if (decoded_19)
					// Trace: core/CSRFile_5stage.v:567:9
					large_ <= _T_1719[63:6];
				else
					// Trace: core/CSRFile_5stage.v:569:9
					large_ <= _GEN_1;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:572:7
			large_ <= _GEN_1;
		if (reset)
			// Trace: core/CSRFile_5stage.v:575:7
			io_status_cease_r <= 1'h0;
		else
			// Trace: core/CSRFile_5stage.v:577:7
			io_status_cease_r <= _GEN_279;
	end
	// Trace: core/CSRFile_5stage.v:627:3
	always @(posedge io_ungated_clock) begin
		// Trace: core/CSRFile_5stage.v:628:5
		if (reset)
			// Trace: core/CSRFile_5stage.v:629:7
			reg_wfi <= 1'h0;
		else if ((|pending_interrupts | io_interrupts_debug) | exception)
			// Trace: core/CSRFile_5stage.v:631:7
			reg_wfi <= 1'h0;
		else
			// Trace: core/CSRFile_5stage.v:633:7
			reg_wfi <= _GEN_46;
		if (reset)
			// Trace: core/CSRFile_5stage.v:636:7
			small_1 <= 6'h00;
		else
			// Trace: core/CSRFile_5stage.v:638:7
			small_1 <= _GEN_316[5:0];
		if (reset)
			// Trace: core/CSRFile_5stage.v:641:7
			large_1 <= 58'h000000000000000;
		else if (csr_wen) begin
			begin
				// Trace: core/CSRFile_5stage.v:643:7
				if (decoded_107)
					// Trace: core/CSRFile_5stage.v:644:9
					large_1 <= _T_1717[63:6];
				else if (decoded_18)
					// Trace: core/CSRFile_5stage.v:646:9
					large_1 <= _T_1714[63:6];
				else
					// Trace: core/CSRFile_5stage.v:648:9
					large_1 <= _GEN_3;
			end
		end
		else
			// Trace: core/CSRFile_5stage.v:651:7
			large_1 <= _GEN_3;
	end
endmodule
