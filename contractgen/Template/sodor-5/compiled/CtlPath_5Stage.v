module CtlPath_5stage (
	clock,
	reset,
	io_dmem_resp_valid,
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
	io_ctl_mem_exception_cause
);
	// Trace: core/CtlPath_5Stage.v:2:3
	input clock;
	// Trace: core/CtlPath_5Stage.v:3:3
	input reset;
	// Trace: core/CtlPath_5Stage.v:4:3
	input io_dmem_resp_valid;
	// Trace: core/CtlPath_5Stage.v:5:3
	input [31:0] io_dat_dec_inst;
	// Trace: core/CtlPath_5Stage.v:6:3
	input io_dat_dec_valid;
	// Trace: core/CtlPath_5Stage.v:7:3
	input io_dat_exe_br_eq;
	// Trace: core/CtlPath_5Stage.v:8:3
	input io_dat_exe_br_lt;
	// Trace: core/CtlPath_5Stage.v:9:3
	input io_dat_exe_br_ltu;
	// Trace: core/CtlPath_5Stage.v:10:3
	input [3:0] io_dat_exe_br_type;
	// Trace: core/CtlPath_5Stage.v:11:3
	input io_dat_exe_inst_misaligned;
	// Trace: core/CtlPath_5Stage.v:12:3
	input io_dat_mem_ctrl_dmem_val;
	// Trace: core/CtlPath_5Stage.v:13:3
	input io_dat_mem_data_misaligned;
	// Trace: core/CtlPath_5Stage.v:14:3
	input io_dat_mem_store;
	// Trace: core/CtlPath_5Stage.v:15:3
	input io_dat_csr_eret;
	// Trace: core/CtlPath_5Stage.v:16:3
	input io_dat_csr_interrupt;
	// Trace: core/CtlPath_5Stage.v:17:3
	output wire io_ctl_dec_stall;
	// Trace: core/CtlPath_5Stage.v:18:3
	output wire io_ctl_full_stall;
	// Trace: core/CtlPath_5Stage.v:19:3
	output wire [1:0] io_ctl_exe_pc_sel;
	// Trace: core/CtlPath_5Stage.v:20:3
	output wire [3:0] io_ctl_br_type;
	// Trace: core/CtlPath_5Stage.v:21:3
	output wire io_ctl_if_kill;
	// Trace: core/CtlPath_5Stage.v:22:3
	output wire io_ctl_dec_kill;
	// Trace: core/CtlPath_5Stage.v:23:3
	output wire [1:0] io_ctl_op1_sel;
	// Trace: core/CtlPath_5Stage.v:24:3
	output wire [2:0] io_ctl_op2_sel;
	// Trace: core/CtlPath_5Stage.v:25:3
	output wire [3:0] io_ctl_alu_fun;
	// Trace: core/CtlPath_5Stage.v:26:3
	output wire [1:0] io_ctl_wb_sel;
	// Trace: core/CtlPath_5Stage.v:27:3
	output wire io_ctl_rf_wen;
	// Trace: core/CtlPath_5Stage.v:28:3
	output wire io_ctl_mem_val;
	// Trace: core/CtlPath_5Stage.v:29:3
	output wire [1:0] io_ctl_mem_fcn;
	// Trace: core/CtlPath_5Stage.v:30:3
	output wire [2:0] io_ctl_mem_typ;
	// Trace: core/CtlPath_5Stage.v:31:3
	output wire [2:0] io_ctl_csr_cmd;
	// Trace: core/CtlPath_5Stage.v:32:3
	output wire io_ctl_fencei;
	// Trace: core/CtlPath_5Stage.v:33:3
	output wire io_ctl_pipeline_kill;
	// Trace: core/CtlPath_5Stage.v:34:3
	output wire io_ctl_mem_exception;
	// Trace: core/CtlPath_5Stage.v:35:3
	output wire [31:0] io_ctl_mem_exception_cause;
	// Trace: core/CtlPath_5Stage.v:48:3
	wire [31:0] _csignals_T = io_dat_dec_inst & 32'h0000707f;
	// Trace: core/CtlPath_5Stage.v:49:3
	wire _csignals_T_1 = 32'h00002003 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:50:3
	wire _csignals_T_3 = 32'h00000003 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:51:3
	wire _csignals_T_5 = 32'h00004003 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:52:3
	wire _csignals_T_7 = 32'h00001003 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:53:3
	wire _csignals_T_9 = 32'h00005003 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:54:3
	wire _csignals_T_11 = 32'h00002023 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:55:3
	wire _csignals_T_13 = 32'h00000023 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:56:3
	wire _csignals_T_15 = 32'h00001023 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:57:3
	wire [31:0] _csignals_T_16 = io_dat_dec_inst & 32'h0000007f;
	// Trace: core/CtlPath_5Stage.v:58:3
	wire _csignals_T_17 = 32'h00000017 == _csignals_T_16;
	// Trace: core/CtlPath_5Stage.v:59:3
	wire _csignals_T_19 = 32'h00000037 == _csignals_T_16;
	// Trace: core/CtlPath_5Stage.v:60:3
	wire _csignals_T_21 = 32'h00000013 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:61:3
	wire _csignals_T_23 = 32'h00007013 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:62:3
	wire _csignals_T_25 = 32'h00006013 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:63:3
	wire _csignals_T_27 = 32'h00004013 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:64:3
	wire _csignals_T_29 = 32'h00002013 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:65:3
	wire _csignals_T_31 = 32'h00003013 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:66:3
	wire [31:0] _csignals_T_32 = io_dat_dec_inst & 32'hfc00707f;
	// Trace: core/CtlPath_5Stage.v:67:3
	wire _csignals_T_33 = 32'h00001013 == _csignals_T_32;
	// Trace: core/CtlPath_5Stage.v:68:3
	wire _csignals_T_35 = 32'h40005013 == _csignals_T_32;
	// Trace: core/CtlPath_5Stage.v:69:3
	wire _csignals_T_37 = 32'h00005013 == _csignals_T_32;
	// Trace: core/CtlPath_5Stage.v:70:3
	wire [31:0] _csignals_T_38 = io_dat_dec_inst & 32'hfe00707f;
	// Trace: core/CtlPath_5Stage.v:71:3
	wire _csignals_T_39 = 32'h00001033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:72:3
	wire _csignals_T_41 = 32'h00000033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:73:3
	wire _csignals_T_43 = 32'h40000033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:74:3
	wire _csignals_T_45 = 32'h00002033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:75:3
	wire _csignals_T_47 = 32'h00003033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:76:3
	wire _csignals_T_49 = 32'h00007033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:77:3
	wire _csignals_T_51 = 32'h00006033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:78:3
	wire _csignals_T_53 = 32'h00004033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:79:3
	wire _csignals_T_55 = 32'h40005033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:80:3
	wire _csignals_T_57 = 32'h00005033 == _csignals_T_38;
	// Trace: core/CtlPath_5Stage.v:81:3
	wire _csignals_T_59 = 32'h0000006f == _csignals_T_16;
	// Trace: core/CtlPath_5Stage.v:82:3
	wire _csignals_T_61 = 32'h00000067 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:83:3
	wire _csignals_T_63 = 32'h00000063 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:84:3
	wire _csignals_T_65 = 32'h00001063 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:85:3
	wire _csignals_T_67 = 32'h00005063 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:86:3
	wire _csignals_T_69 = 32'h00007063 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:87:3
	wire _csignals_T_71 = 32'h00004063 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:88:3
	wire _csignals_T_73 = 32'h00006063 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:89:3
	wire _csignals_T_75 = 32'h00005073 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:90:3
	wire _csignals_T_77 = 32'h00006073 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:91:3
	wire _csignals_T_79 = 32'h00001073 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:92:3
	wire _csignals_T_81 = 32'h00002073 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:93:3
	wire _csignals_T_83 = 32'h00003073 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:94:3
	wire _csignals_T_85 = 32'h00007073 == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:95:3
	wire _csignals_T_87 = 32'h00000073 == io_dat_dec_inst;
	// Trace: core/CtlPath_5Stage.v:96:3
	wire _csignals_T_89 = 32'h30200073 == io_dat_dec_inst;
	// Trace: core/CtlPath_5Stage.v:97:3
	wire _csignals_T_91 = 32'h7b200073 == io_dat_dec_inst;
	// Trace: core/CtlPath_5Stage.v:98:3
	wire _csignals_T_93 = 32'h00100073 == io_dat_dec_inst;
	// Trace: core/CtlPath_5Stage.v:99:3
	wire _csignals_T_95 = 32'h10500073 == io_dat_dec_inst;
	// Trace: core/CtlPath_5Stage.v:100:3
	wire _csignals_T_97 = 32'h0000100f == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:101:3
	wire _csignals_T_99 = 32'h0000000f == _csignals_T;
	// Trace: core/CtlPath_5Stage.v:102:3
	wire _csignals_T_130 = _csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (_csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | (_csignals_T_59 | (_csignals_T_61 | (_csignals_T_63 | (_csignals_T_65 | (_csignals_T_67 | (_csignals_T_69 | (_csignals_T_71 | (_csignals_T_73 | (_csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81 | (_csignals_T_83 | (_csignals_T_85 | (_csignals_T_87 | (_csignals_T_89 | (_csignals_T_91 | (_csignals_T_93 | (_csignals_T_95 | (_csignals_T_97 | _csignals_T_99)))))))))))))))))))))))))))));
	// Trace: core/CtlPath_5Stage.v:108:3
	wire cs_val_inst = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (_csignals_T_13 | (_csignals_T_15 | (_csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (_csignals_T_23 | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (_csignals_T_37 | _csignals_T_130))))))))))))))))));
	// Trace: core/CtlPath_5Stage.v:112:3
	wire [3:0] _csignals_T_162 = (_csignals_T_73 ? 4'h6 : 4'h0);
	// Trace: core/CtlPath_5Stage.v:113:3
	wire [3:0] _csignals_T_163 = (_csignals_T_71 ? 4'h5 : _csignals_T_162);
	// Trace: core/CtlPath_5Stage.v:114:3
	wire [3:0] _csignals_T_164 = (_csignals_T_69 ? 4'h4 : _csignals_T_163);
	// Trace: core/CtlPath_5Stage.v:115:3
	wire [3:0] _csignals_T_165 = (_csignals_T_67 ? 4'h3 : _csignals_T_164);
	// Trace: core/CtlPath_5Stage.v:116:3
	wire [3:0] _csignals_T_166 = (_csignals_T_65 ? 4'h1 : _csignals_T_165);
	// Trace: core/CtlPath_5Stage.v:117:3
	wire [3:0] _csignals_T_167 = (_csignals_T_63 ? 4'h2 : _csignals_T_166);
	// Trace: core/CtlPath_5Stage.v:118:3
	wire [3:0] _csignals_T_168 = (_csignals_T_61 ? 4'h8 : _csignals_T_167);
	// Trace: core/CtlPath_5Stage.v:119:3
	wire [3:0] _csignals_T_169 = (_csignals_T_59 ? 4'h7 : _csignals_T_168);
	// Trace: core/CtlPath_5Stage.v:120:3
	wire [3:0] _csignals_T_170 = (_csignals_T_57 ? 4'h0 : _csignals_T_169);
	// Trace: core/CtlPath_5Stage.v:121:3
	wire [3:0] _csignals_T_171 = (_csignals_T_55 ? 4'h0 : _csignals_T_170);
	// Trace: core/CtlPath_5Stage.v:122:3
	wire [3:0] _csignals_T_172 = (_csignals_T_53 ? 4'h0 : _csignals_T_171);
	// Trace: core/CtlPath_5Stage.v:123:3
	wire [3:0] _csignals_T_173 = (_csignals_T_51 ? 4'h0 : _csignals_T_172);
	// Trace: core/CtlPath_5Stage.v:124:3
	wire [3:0] _csignals_T_174 = (_csignals_T_49 ? 4'h0 : _csignals_T_173);
	// Trace: core/CtlPath_5Stage.v:125:3
	wire [3:0] _csignals_T_175 = (_csignals_T_47 ? 4'h0 : _csignals_T_174);
	// Trace: core/CtlPath_5Stage.v:126:3
	wire [3:0] _csignals_T_176 = (_csignals_T_45 ? 4'h0 : _csignals_T_175);
	// Trace: core/CtlPath_5Stage.v:127:3
	wire [3:0] _csignals_T_177 = (_csignals_T_43 ? 4'h0 : _csignals_T_176);
	// Trace: core/CtlPath_5Stage.v:128:3
	wire [3:0] _csignals_T_178 = (_csignals_T_41 ? 4'h0 : _csignals_T_177);
	// Trace: core/CtlPath_5Stage.v:129:3
	wire [3:0] _csignals_T_179 = (_csignals_T_39 ? 4'h0 : _csignals_T_178);
	// Trace: core/CtlPath_5Stage.v:130:3
	wire [3:0] _csignals_T_180 = (_csignals_T_37 ? 4'h0 : _csignals_T_179);
	// Trace: core/CtlPath_5Stage.v:131:3
	wire [3:0] _csignals_T_181 = (_csignals_T_35 ? 4'h0 : _csignals_T_180);
	// Trace: core/CtlPath_5Stage.v:132:3
	wire [3:0] _csignals_T_182 = (_csignals_T_33 ? 4'h0 : _csignals_T_181);
	// Trace: core/CtlPath_5Stage.v:133:3
	wire [3:0] _csignals_T_183 = (_csignals_T_31 ? 4'h0 : _csignals_T_182);
	// Trace: core/CtlPath_5Stage.v:134:3
	wire [3:0] _csignals_T_184 = (_csignals_T_29 ? 4'h0 : _csignals_T_183);
	// Trace: core/CtlPath_5Stage.v:135:3
	wire [3:0] _csignals_T_185 = (_csignals_T_27 ? 4'h0 : _csignals_T_184);
	// Trace: core/CtlPath_5Stage.v:136:3
	wire [3:0] _csignals_T_186 = (_csignals_T_25 ? 4'h0 : _csignals_T_185);
	// Trace: core/CtlPath_5Stage.v:137:3
	wire [3:0] _csignals_T_187 = (_csignals_T_23 ? 4'h0 : _csignals_T_186);
	// Trace: core/CtlPath_5Stage.v:138:3
	wire [3:0] _csignals_T_188 = (_csignals_T_21 ? 4'h0 : _csignals_T_187);
	// Trace: core/CtlPath_5Stage.v:139:3
	wire [3:0] _csignals_T_189 = (_csignals_T_19 ? 4'h0 : _csignals_T_188);
	// Trace: core/CtlPath_5Stage.v:140:3
	wire [3:0] _csignals_T_190 = (_csignals_T_17 ? 4'h0 : _csignals_T_189);
	// Trace: core/CtlPath_5Stage.v:141:3
	wire [3:0] _csignals_T_191 = (_csignals_T_15 ? 4'h0 : _csignals_T_190);
	// Trace: core/CtlPath_5Stage.v:142:3
	wire [3:0] _csignals_T_192 = (_csignals_T_13 ? 4'h0 : _csignals_T_191);
	// Trace: core/CtlPath_5Stage.v:143:3
	wire [3:0] _csignals_T_193 = (_csignals_T_11 ? 4'h0 : _csignals_T_192);
	// Trace: core/CtlPath_5Stage.v:144:3
	wire [3:0] _csignals_T_194 = (_csignals_T_9 ? 4'h0 : _csignals_T_193);
	// Trace: core/CtlPath_5Stage.v:145:3
	wire [3:0] _csignals_T_195 = (_csignals_T_7 ? 4'h0 : _csignals_T_194);
	// Trace: core/CtlPath_5Stage.v:146:3
	wire [3:0] _csignals_T_196 = (_csignals_T_5 ? 4'h0 : _csignals_T_195);
	// Trace: core/CtlPath_5Stage.v:147:3
	wire [3:0] _csignals_T_197 = (_csignals_T_3 ? 4'h0 : _csignals_T_196);
	// Trace: core/CtlPath_5Stage.v:148:3
	wire [1:0] _csignals_T_205 = (_csignals_T_85 ? 2'h2 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:149:3
	wire [1:0] _csignals_T_206 = (_csignals_T_83 ? 2'h0 : _csignals_T_205);
	// Trace: core/CtlPath_5Stage.v:150:3
	wire [1:0] _csignals_T_207 = (_csignals_T_81 ? 2'h0 : _csignals_T_206);
	// Trace: core/CtlPath_5Stage.v:151:3
	wire [1:0] _csignals_T_208 = (_csignals_T_79 ? 2'h0 : _csignals_T_207);
	// Trace: core/CtlPath_5Stage.v:152:3
	wire [1:0] _csignals_T_209 = (_csignals_T_77 ? 2'h2 : _csignals_T_208);
	// Trace: core/CtlPath_5Stage.v:153:3
	wire [1:0] _csignals_T_210 = (_csignals_T_75 ? 2'h2 : _csignals_T_209);
	// Trace: core/CtlPath_5Stage.v:154:3
	wire [1:0] _csignals_T_211 = (_csignals_T_73 ? 2'h0 : _csignals_T_210);
	// Trace: core/CtlPath_5Stage.v:155:3
	wire [1:0] _csignals_T_212 = (_csignals_T_71 ? 2'h0 : _csignals_T_211);
	// Trace: core/CtlPath_5Stage.v:156:3
	wire [1:0] _csignals_T_213 = (_csignals_T_69 ? 2'h0 : _csignals_T_212);
	// Trace: core/CtlPath_5Stage.v:157:3
	wire [1:0] _csignals_T_214 = (_csignals_T_67 ? 2'h0 : _csignals_T_213);
	// Trace: core/CtlPath_5Stage.v:158:3
	wire [1:0] _csignals_T_215 = (_csignals_T_65 ? 2'h0 : _csignals_T_214);
	// Trace: core/CtlPath_5Stage.v:159:3
	wire [1:0] _csignals_T_216 = (_csignals_T_63 ? 2'h0 : _csignals_T_215);
	// Trace: core/CtlPath_5Stage.v:160:3
	wire [1:0] _csignals_T_217 = (_csignals_T_61 ? 2'h0 : _csignals_T_216);
	// Trace: core/CtlPath_5Stage.v:161:3
	wire [1:0] _csignals_T_218 = (_csignals_T_59 ? 2'h0 : _csignals_T_217);
	// Trace: core/CtlPath_5Stage.v:162:3
	wire [1:0] _csignals_T_219 = (_csignals_T_57 ? 2'h0 : _csignals_T_218);
	// Trace: core/CtlPath_5Stage.v:163:3
	wire [1:0] _csignals_T_220 = (_csignals_T_55 ? 2'h0 : _csignals_T_219);
	// Trace: core/CtlPath_5Stage.v:164:3
	wire [1:0] _csignals_T_221 = (_csignals_T_53 ? 2'h0 : _csignals_T_220);
	// Trace: core/CtlPath_5Stage.v:165:3
	wire [1:0] _csignals_T_222 = (_csignals_T_51 ? 2'h0 : _csignals_T_221);
	// Trace: core/CtlPath_5Stage.v:166:3
	wire [1:0] _csignals_T_223 = (_csignals_T_49 ? 2'h0 : _csignals_T_222);
	// Trace: core/CtlPath_5Stage.v:167:3
	wire [1:0] _csignals_T_224 = (_csignals_T_47 ? 2'h0 : _csignals_T_223);
	// Trace: core/CtlPath_5Stage.v:168:3
	wire [1:0] _csignals_T_225 = (_csignals_T_45 ? 2'h0 : _csignals_T_224);
	// Trace: core/CtlPath_5Stage.v:169:3
	wire [1:0] _csignals_T_226 = (_csignals_T_43 ? 2'h0 : _csignals_T_225);
	// Trace: core/CtlPath_5Stage.v:170:3
	wire [1:0] _csignals_T_227 = (_csignals_T_41 ? 2'h0 : _csignals_T_226);
	// Trace: core/CtlPath_5Stage.v:171:3
	wire [1:0] _csignals_T_228 = (_csignals_T_39 ? 2'h0 : _csignals_T_227);
	// Trace: core/CtlPath_5Stage.v:172:3
	wire [1:0] _csignals_T_229 = (_csignals_T_37 ? 2'h0 : _csignals_T_228);
	// Trace: core/CtlPath_5Stage.v:173:3
	wire [1:0] _csignals_T_230 = (_csignals_T_35 ? 2'h0 : _csignals_T_229);
	// Trace: core/CtlPath_5Stage.v:174:3
	wire [1:0] _csignals_T_231 = (_csignals_T_33 ? 2'h0 : _csignals_T_230);
	// Trace: core/CtlPath_5Stage.v:175:3
	wire [1:0] _csignals_T_232 = (_csignals_T_31 ? 2'h0 : _csignals_T_231);
	// Trace: core/CtlPath_5Stage.v:176:3
	wire [1:0] _csignals_T_233 = (_csignals_T_29 ? 2'h0 : _csignals_T_232);
	// Trace: core/CtlPath_5Stage.v:177:3
	wire [1:0] _csignals_T_234 = (_csignals_T_27 ? 2'h0 : _csignals_T_233);
	// Trace: core/CtlPath_5Stage.v:178:3
	wire [1:0] _csignals_T_235 = (_csignals_T_25 ? 2'h0 : _csignals_T_234);
	// Trace: core/CtlPath_5Stage.v:179:3
	wire [1:0] _csignals_T_236 = (_csignals_T_23 ? 2'h0 : _csignals_T_235);
	// Trace: core/CtlPath_5Stage.v:180:3
	wire [1:0] _csignals_T_237 = (_csignals_T_21 ? 2'h0 : _csignals_T_236);
	// Trace: core/CtlPath_5Stage.v:181:3
	wire [1:0] _csignals_T_238 = (_csignals_T_19 ? 2'h0 : _csignals_T_237);
	// Trace: core/CtlPath_5Stage.v:182:3
	wire [1:0] _csignals_T_239 = (_csignals_T_17 ? 2'h1 : _csignals_T_238);
	// Trace: core/CtlPath_5Stage.v:183:3
	wire [1:0] _csignals_T_240 = (_csignals_T_15 ? 2'h0 : _csignals_T_239);
	// Trace: core/CtlPath_5Stage.v:184:3
	wire [1:0] _csignals_T_241 = (_csignals_T_13 ? 2'h0 : _csignals_T_240);
	// Trace: core/CtlPath_5Stage.v:185:3
	wire [1:0] _csignals_T_242 = (_csignals_T_11 ? 2'h0 : _csignals_T_241);
	// Trace: core/CtlPath_5Stage.v:186:3
	wire [1:0] _csignals_T_243 = (_csignals_T_9 ? 2'h0 : _csignals_T_242);
	// Trace: core/CtlPath_5Stage.v:187:3
	wire [1:0] _csignals_T_244 = (_csignals_T_7 ? 2'h0 : _csignals_T_243);
	// Trace: core/CtlPath_5Stage.v:188:3
	wire [1:0] _csignals_T_245 = (_csignals_T_5 ? 2'h0 : _csignals_T_244);
	// Trace: core/CtlPath_5Stage.v:189:3
	wire [1:0] _csignals_T_246 = (_csignals_T_3 ? 2'h0 : _csignals_T_245);
	// Trace: core/CtlPath_5Stage.v:190:3
	wire [2:0] _csignals_T_260 = (_csignals_T_73 ? 3'h3 : 3'h0);
	// Trace: core/CtlPath_5Stage.v:191:3
	wire [2:0] _csignals_T_261 = (_csignals_T_71 ? 3'h3 : _csignals_T_260);
	// Trace: core/CtlPath_5Stage.v:192:3
	wire [2:0] _csignals_T_262 = (_csignals_T_69 ? 3'h3 : _csignals_T_261);
	// Trace: core/CtlPath_5Stage.v:193:3
	wire [2:0] _csignals_T_263 = (_csignals_T_67 ? 3'h3 : _csignals_T_262);
	// Trace: core/CtlPath_5Stage.v:194:3
	wire [2:0] _csignals_T_264 = (_csignals_T_65 ? 3'h3 : _csignals_T_263);
	// Trace: core/CtlPath_5Stage.v:195:3
	wire [2:0] _csignals_T_265 = (_csignals_T_63 ? 3'h3 : _csignals_T_264);
	// Trace: core/CtlPath_5Stage.v:196:3
	wire [2:0] _csignals_T_266 = (_csignals_T_61 ? 3'h1 : _csignals_T_265);
	// Trace: core/CtlPath_5Stage.v:197:3
	wire [2:0] _csignals_T_267 = (_csignals_T_59 ? 3'h5 : _csignals_T_266);
	// Trace: core/CtlPath_5Stage.v:198:3
	wire [2:0] _csignals_T_268 = (_csignals_T_57 ? 3'h0 : _csignals_T_267);
	// Trace: core/CtlPath_5Stage.v:199:3
	wire [2:0] _csignals_T_269 = (_csignals_T_55 ? 3'h0 : _csignals_T_268);
	// Trace: core/CtlPath_5Stage.v:200:3
	wire [2:0] _csignals_T_270 = (_csignals_T_53 ? 3'h0 : _csignals_T_269);
	// Trace: core/CtlPath_5Stage.v:201:3
	wire [2:0] _csignals_T_271 = (_csignals_T_51 ? 3'h0 : _csignals_T_270);
	// Trace: core/CtlPath_5Stage.v:202:3
	wire [2:0] _csignals_T_272 = (_csignals_T_49 ? 3'h0 : _csignals_T_271);
	// Trace: core/CtlPath_5Stage.v:203:3
	wire [2:0] _csignals_T_273 = (_csignals_T_47 ? 3'h0 : _csignals_T_272);
	// Trace: core/CtlPath_5Stage.v:204:3
	wire [2:0] _csignals_T_274 = (_csignals_T_45 ? 3'h0 : _csignals_T_273);
	// Trace: core/CtlPath_5Stage.v:205:3
	wire [2:0] _csignals_T_275 = (_csignals_T_43 ? 3'h0 : _csignals_T_274);
	// Trace: core/CtlPath_5Stage.v:206:3
	wire [2:0] _csignals_T_276 = (_csignals_T_41 ? 3'h0 : _csignals_T_275);
	// Trace: core/CtlPath_5Stage.v:207:3
	wire [2:0] _csignals_T_277 = (_csignals_T_39 ? 3'h0 : _csignals_T_276);
	// Trace: core/CtlPath_5Stage.v:208:3
	wire [2:0] _csignals_T_278 = (_csignals_T_37 ? 3'h1 : _csignals_T_277);
	// Trace: core/CtlPath_5Stage.v:209:3
	wire [2:0] _csignals_T_279 = (_csignals_T_35 ? 3'h1 : _csignals_T_278);
	// Trace: core/CtlPath_5Stage.v:210:3
	wire [2:0] _csignals_T_280 = (_csignals_T_33 ? 3'h1 : _csignals_T_279);
	// Trace: core/CtlPath_5Stage.v:211:3
	wire [2:0] _csignals_T_281 = (_csignals_T_31 ? 3'h1 : _csignals_T_280);
	// Trace: core/CtlPath_5Stage.v:212:3
	wire [2:0] _csignals_T_282 = (_csignals_T_29 ? 3'h1 : _csignals_T_281);
	// Trace: core/CtlPath_5Stage.v:213:3
	wire [2:0] _csignals_T_283 = (_csignals_T_27 ? 3'h1 : _csignals_T_282);
	// Trace: core/CtlPath_5Stage.v:214:3
	wire [2:0] _csignals_T_284 = (_csignals_T_25 ? 3'h1 : _csignals_T_283);
	// Trace: core/CtlPath_5Stage.v:215:3
	wire [2:0] _csignals_T_285 = (_csignals_T_23 ? 3'h1 : _csignals_T_284);
	// Trace: core/CtlPath_5Stage.v:216:3
	wire [2:0] _csignals_T_286 = (_csignals_T_21 ? 3'h1 : _csignals_T_285);
	// Trace: core/CtlPath_5Stage.v:217:3
	wire [2:0] _csignals_T_287 = (_csignals_T_19 ? 3'h4 : _csignals_T_286);
	// Trace: core/CtlPath_5Stage.v:218:3
	wire [2:0] _csignals_T_288 = (_csignals_T_17 ? 3'h4 : _csignals_T_287);
	// Trace: core/CtlPath_5Stage.v:219:3
	wire [2:0] _csignals_T_289 = (_csignals_T_15 ? 3'h2 : _csignals_T_288);
	// Trace: core/CtlPath_5Stage.v:220:3
	wire [2:0] _csignals_T_290 = (_csignals_T_13 ? 3'h2 : _csignals_T_289);
	// Trace: core/CtlPath_5Stage.v:221:3
	wire [2:0] _csignals_T_291 = (_csignals_T_11 ? 3'h2 : _csignals_T_290);
	// Trace: core/CtlPath_5Stage.v:222:3
	wire [2:0] _csignals_T_292 = (_csignals_T_9 ? 3'h1 : _csignals_T_291);
	// Trace: core/CtlPath_5Stage.v:223:3
	wire [2:0] _csignals_T_293 = (_csignals_T_7 ? 3'h1 : _csignals_T_292);
	// Trace: core/CtlPath_5Stage.v:224:3
	wire [2:0] _csignals_T_294 = (_csignals_T_5 ? 3'h1 : _csignals_T_293);
	// Trace: core/CtlPath_5Stage.v:225:3
	wire [2:0] _csignals_T_295 = (_csignals_T_3 ? 3'h1 : _csignals_T_294);
	// Trace: core/CtlPath_5Stage.v:226:3
	wire _csignals_T_316 = (_csignals_T_59 ? 1'h0 : _csignals_T_61 | (_csignals_T_63 | (_csignals_T_65 | (_csignals_T_67 | (_csignals_T_69 | (_csignals_T_71 | (_csignals_T_73 | (_csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81 | (_csignals_T_83 | _csignals_T_85))))))))))));
	// Trace: core/CtlPath_5Stage.v:229:3
	wire _csignals_T_336 = (_csignals_T_19 ? 1'h0 : _csignals_T_21 | (_csignals_T_23 | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (_csignals_T_37 | (_csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (_csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | _csignals_T_316)))))))))))))))))));
	// Trace: core/CtlPath_5Stage.v:233:3
	wire _csignals_T_337 = (_csignals_T_17 ? 1'h0 : _csignals_T_336);
	// Trace: core/CtlPath_5Stage.v:234:3
	wire cs_rs1_oen = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (_csignals_T_13 | (_csignals_T_15 | _csignals_T_337)))))));
	// Trace: core/CtlPath_5Stage.v:236:3
	wire _csignals_T_364 = (_csignals_T_61 ? 1'h0 : _csignals_T_63 | (_csignals_T_65 | (_csignals_T_67 | (_csignals_T_69 | (_csignals_T_71 | (_csignals_T_73 | (_csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81 | (_csignals_T_83 | _csignals_T_85)))))))))));
	// Trace: core/CtlPath_5Stage.v:239:3
	wire _csignals_T_365 = (_csignals_T_59 ? 1'h0 : _csignals_T_364);
	// Trace: core/CtlPath_5Stage.v:240:3
	wire _csignals_T_376 = (_csignals_T_37 ? 1'h0 : _csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (_csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | _csignals_T_365))))))))));
	// Trace: core/CtlPath_5Stage.v:243:3
	wire _csignals_T_377 = (_csignals_T_35 ? 1'h0 : _csignals_T_376);
	// Trace: core/CtlPath_5Stage.v:244:3
	wire _csignals_T_378 = (_csignals_T_33 ? 1'h0 : _csignals_T_377);
	// Trace: core/CtlPath_5Stage.v:245:3
	wire _csignals_T_379 = (_csignals_T_31 ? 1'h0 : _csignals_T_378);
	// Trace: core/CtlPath_5Stage.v:246:3
	wire _csignals_T_380 = (_csignals_T_29 ? 1'h0 : _csignals_T_379);
	// Trace: core/CtlPath_5Stage.v:247:3
	wire _csignals_T_381 = (_csignals_T_27 ? 1'h0 : _csignals_T_380);
	// Trace: core/CtlPath_5Stage.v:248:3
	wire _csignals_T_382 = (_csignals_T_25 ? 1'h0 : _csignals_T_381);
	// Trace: core/CtlPath_5Stage.v:249:3
	wire _csignals_T_383 = (_csignals_T_23 ? 1'h0 : _csignals_T_382);
	// Trace: core/CtlPath_5Stage.v:250:3
	wire _csignals_T_384 = (_csignals_T_21 ? 1'h0 : _csignals_T_383);
	// Trace: core/CtlPath_5Stage.v:251:3
	wire _csignals_T_385 = (_csignals_T_19 ? 1'h0 : _csignals_T_384);
	// Trace: core/CtlPath_5Stage.v:252:3
	wire _csignals_T_386 = (_csignals_T_17 ? 1'h0 : _csignals_T_385);
	// Trace: core/CtlPath_5Stage.v:253:3
	wire _csignals_T_390 = (_csignals_T_9 ? 1'h0 : _csignals_T_11 | (_csignals_T_13 | (_csignals_T_15 | _csignals_T_386)));
	// Trace: core/CtlPath_5Stage.v:254:3
	wire _csignals_T_391 = (_csignals_T_7 ? 1'h0 : _csignals_T_390);
	// Trace: core/CtlPath_5Stage.v:255:3
	wire _csignals_T_392 = (_csignals_T_5 ? 1'h0 : _csignals_T_391);
	// Trace: core/CtlPath_5Stage.v:256:3
	wire _csignals_T_393 = (_csignals_T_3 ? 1'h0 : _csignals_T_392);
	// Trace: core/CtlPath_5Stage.v:257:3
	wire cs_rs2_oen = (_csignals_T_1 ? 1'h0 : _csignals_T_393);
	// Trace: core/CtlPath_5Stage.v:258:3
	wire [3:0] _csignals_T_401 = (_csignals_T_85 ? 4'ha : 4'h0);
	// Trace: core/CtlPath_5Stage.v:259:3
	wire [3:0] _csignals_T_402 = (_csignals_T_83 ? 4'ha : _csignals_T_401);
	// Trace: core/CtlPath_5Stage.v:260:3
	wire [3:0] _csignals_T_403 = (_csignals_T_81 ? 4'ha : _csignals_T_402);
	// Trace: core/CtlPath_5Stage.v:261:3
	wire [3:0] _csignals_T_404 = (_csignals_T_79 ? 4'ha : _csignals_T_403);
	// Trace: core/CtlPath_5Stage.v:262:3
	wire [3:0] _csignals_T_405 = (_csignals_T_77 ? 4'ha : _csignals_T_404);
	// Trace: core/CtlPath_5Stage.v:263:3
	wire [3:0] _csignals_T_406 = (_csignals_T_75 ? 4'ha : _csignals_T_405);
	// Trace: core/CtlPath_5Stage.v:264:3
	wire [3:0] _csignals_T_407 = (_csignals_T_73 ? 4'h0 : _csignals_T_406);
	// Trace: core/CtlPath_5Stage.v:265:3
	wire [3:0] _csignals_T_408 = (_csignals_T_71 ? 4'h0 : _csignals_T_407);
	// Trace: core/CtlPath_5Stage.v:266:3
	wire [3:0] _csignals_T_409 = (_csignals_T_69 ? 4'h0 : _csignals_T_408);
	// Trace: core/CtlPath_5Stage.v:267:3
	wire [3:0] _csignals_T_410 = (_csignals_T_67 ? 4'h0 : _csignals_T_409);
	// Trace: core/CtlPath_5Stage.v:268:3
	wire [3:0] _csignals_T_411 = (_csignals_T_65 ? 4'h0 : _csignals_T_410);
	// Trace: core/CtlPath_5Stage.v:269:3
	wire [3:0] _csignals_T_412 = (_csignals_T_63 ? 4'h0 : _csignals_T_411);
	// Trace: core/CtlPath_5Stage.v:270:3
	wire [3:0] _csignals_T_413 = (_csignals_T_61 ? 4'h0 : _csignals_T_412);
	// Trace: core/CtlPath_5Stage.v:271:3
	wire [3:0] _csignals_T_414 = (_csignals_T_59 ? 4'h0 : _csignals_T_413);
	// Trace: core/CtlPath_5Stage.v:272:3
	wire [3:0] _csignals_T_415 = (_csignals_T_57 ? 4'h3 : _csignals_T_414);
	// Trace: core/CtlPath_5Stage.v:273:3
	wire [3:0] _csignals_T_416 = (_csignals_T_55 ? 4'h4 : _csignals_T_415);
	// Trace: core/CtlPath_5Stage.v:274:3
	wire [3:0] _csignals_T_417 = (_csignals_T_53 ? 4'h7 : _csignals_T_416);
	// Trace: core/CtlPath_5Stage.v:275:3
	wire [3:0] _csignals_T_418 = (_csignals_T_51 ? 4'h6 : _csignals_T_417);
	// Trace: core/CtlPath_5Stage.v:276:3
	wire [3:0] _csignals_T_419 = (_csignals_T_49 ? 4'h5 : _csignals_T_418);
	// Trace: core/CtlPath_5Stage.v:277:3
	wire [3:0] _csignals_T_420 = (_csignals_T_47 ? 4'h9 : _csignals_T_419);
	// Trace: core/CtlPath_5Stage.v:278:3
	wire [3:0] _csignals_T_421 = (_csignals_T_45 ? 4'h8 : _csignals_T_420);
	// Trace: core/CtlPath_5Stage.v:279:3
	wire [3:0] _csignals_T_422 = (_csignals_T_43 ? 4'h1 : _csignals_T_421);
	// Trace: core/CtlPath_5Stage.v:280:3
	wire [3:0] _csignals_T_423 = (_csignals_T_41 ? 4'h0 : _csignals_T_422);
	// Trace: core/CtlPath_5Stage.v:281:3
	wire [3:0] _csignals_T_424 = (_csignals_T_39 ? 4'h2 : _csignals_T_423);
	// Trace: core/CtlPath_5Stage.v:282:3
	wire [3:0] _csignals_T_425 = (_csignals_T_37 ? 4'h3 : _csignals_T_424);
	// Trace: core/CtlPath_5Stage.v:283:3
	wire [3:0] _csignals_T_426 = (_csignals_T_35 ? 4'h4 : _csignals_T_425);
	// Trace: core/CtlPath_5Stage.v:284:3
	wire [3:0] _csignals_T_427 = (_csignals_T_33 ? 4'h2 : _csignals_T_426);
	// Trace: core/CtlPath_5Stage.v:285:3
	wire [3:0] _csignals_T_428 = (_csignals_T_31 ? 4'h9 : _csignals_T_427);
	// Trace: core/CtlPath_5Stage.v:286:3
	wire [3:0] _csignals_T_429 = (_csignals_T_29 ? 4'h8 : _csignals_T_428);
	// Trace: core/CtlPath_5Stage.v:287:3
	wire [3:0] _csignals_T_430 = (_csignals_T_27 ? 4'h7 : _csignals_T_429);
	// Trace: core/CtlPath_5Stage.v:288:3
	wire [3:0] _csignals_T_431 = (_csignals_T_25 ? 4'h6 : _csignals_T_430);
	// Trace: core/CtlPath_5Stage.v:289:3
	wire [3:0] _csignals_T_432 = (_csignals_T_23 ? 4'h5 : _csignals_T_431);
	// Trace: core/CtlPath_5Stage.v:290:3
	wire [3:0] _csignals_T_433 = (_csignals_T_21 ? 4'h0 : _csignals_T_432);
	// Trace: core/CtlPath_5Stage.v:291:3
	wire [3:0] _csignals_T_434 = (_csignals_T_19 ? 4'hb : _csignals_T_433);
	// Trace: core/CtlPath_5Stage.v:292:3
	wire [3:0] _csignals_T_435 = (_csignals_T_17 ? 4'h0 : _csignals_T_434);
	// Trace: core/CtlPath_5Stage.v:293:3
	wire [3:0] _csignals_T_436 = (_csignals_T_15 ? 4'h0 : _csignals_T_435);
	// Trace: core/CtlPath_5Stage.v:294:3
	wire [3:0] _csignals_T_437 = (_csignals_T_13 ? 4'h0 : _csignals_T_436);
	// Trace: core/CtlPath_5Stage.v:295:3
	wire [3:0] _csignals_T_438 = (_csignals_T_11 ? 4'h0 : _csignals_T_437);
	// Trace: core/CtlPath_5Stage.v:296:3
	wire [3:0] _csignals_T_439 = (_csignals_T_9 ? 4'h0 : _csignals_T_438);
	// Trace: core/CtlPath_5Stage.v:297:3
	wire [3:0] _csignals_T_440 = (_csignals_T_7 ? 4'h0 : _csignals_T_439);
	// Trace: core/CtlPath_5Stage.v:298:3
	wire [3:0] _csignals_T_441 = (_csignals_T_5 ? 4'h0 : _csignals_T_440);
	// Trace: core/CtlPath_5Stage.v:299:3
	wire [3:0] _csignals_T_442 = (_csignals_T_3 ? 4'h0 : _csignals_T_441);
	// Trace: core/CtlPath_5Stage.v:300:3
	wire [1:0] _csignals_T_450 = (_csignals_T_85 ? 2'h3 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:301:3
	wire [1:0] _csignals_T_451 = (_csignals_T_83 ? 2'h3 : _csignals_T_450);
	// Trace: core/CtlPath_5Stage.v:302:3
	wire [1:0] _csignals_T_452 = (_csignals_T_81 ? 2'h3 : _csignals_T_451);
	// Trace: core/CtlPath_5Stage.v:303:3
	wire [1:0] _csignals_T_453 = (_csignals_T_79 ? 2'h3 : _csignals_T_452);
	// Trace: core/CtlPath_5Stage.v:304:3
	wire [1:0] _csignals_T_454 = (_csignals_T_77 ? 2'h3 : _csignals_T_453);
	// Trace: core/CtlPath_5Stage.v:305:3
	wire [1:0] _csignals_T_455 = (_csignals_T_75 ? 2'h3 : _csignals_T_454);
	// Trace: core/CtlPath_5Stage.v:306:3
	wire [1:0] _csignals_T_456 = (_csignals_T_73 ? 2'h0 : _csignals_T_455);
	// Trace: core/CtlPath_5Stage.v:307:3
	wire [1:0] _csignals_T_457 = (_csignals_T_71 ? 2'h0 : _csignals_T_456);
	// Trace: core/CtlPath_5Stage.v:308:3
	wire [1:0] _csignals_T_458 = (_csignals_T_69 ? 2'h0 : _csignals_T_457);
	// Trace: core/CtlPath_5Stage.v:309:3
	wire [1:0] _csignals_T_459 = (_csignals_T_67 ? 2'h0 : _csignals_T_458);
	// Trace: core/CtlPath_5Stage.v:310:3
	wire [1:0] _csignals_T_460 = (_csignals_T_65 ? 2'h0 : _csignals_T_459);
	// Trace: core/CtlPath_5Stage.v:311:3
	wire [1:0] _csignals_T_461 = (_csignals_T_63 ? 2'h0 : _csignals_T_460);
	// Trace: core/CtlPath_5Stage.v:312:3
	wire [1:0] _csignals_T_462 = (_csignals_T_61 ? 2'h2 : _csignals_T_461);
	// Trace: core/CtlPath_5Stage.v:313:3
	wire [1:0] _csignals_T_463 = (_csignals_T_59 ? 2'h2 : _csignals_T_462);
	// Trace: core/CtlPath_5Stage.v:314:3
	wire [1:0] _csignals_T_464 = (_csignals_T_57 ? 2'h0 : _csignals_T_463);
	// Trace: core/CtlPath_5Stage.v:315:3
	wire [1:0] _csignals_T_465 = (_csignals_T_55 ? 2'h0 : _csignals_T_464);
	// Trace: core/CtlPath_5Stage.v:316:3
	wire [1:0] _csignals_T_466 = (_csignals_T_53 ? 2'h0 : _csignals_T_465);
	// Trace: core/CtlPath_5Stage.v:317:3
	wire [1:0] _csignals_T_467 = (_csignals_T_51 ? 2'h0 : _csignals_T_466);
	// Trace: core/CtlPath_5Stage.v:318:3
	wire [1:0] _csignals_T_468 = (_csignals_T_49 ? 2'h0 : _csignals_T_467);
	// Trace: core/CtlPath_5Stage.v:319:3
	wire [1:0] _csignals_T_469 = (_csignals_T_47 ? 2'h0 : _csignals_T_468);
	// Trace: core/CtlPath_5Stage.v:320:3
	wire [1:0] _csignals_T_470 = (_csignals_T_45 ? 2'h0 : _csignals_T_469);
	// Trace: core/CtlPath_5Stage.v:321:3
	wire [1:0] _csignals_T_471 = (_csignals_T_43 ? 2'h0 : _csignals_T_470);
	// Trace: core/CtlPath_5Stage.v:322:3
	wire [1:0] _csignals_T_472 = (_csignals_T_41 ? 2'h0 : _csignals_T_471);
	// Trace: core/CtlPath_5Stage.v:323:3
	wire [1:0] _csignals_T_473 = (_csignals_T_39 ? 2'h0 : _csignals_T_472);
	// Trace: core/CtlPath_5Stage.v:324:3
	wire [1:0] _csignals_T_474 = (_csignals_T_37 ? 2'h0 : _csignals_T_473);
	// Trace: core/CtlPath_5Stage.v:325:3
	wire [1:0] _csignals_T_475 = (_csignals_T_35 ? 2'h0 : _csignals_T_474);
	// Trace: core/CtlPath_5Stage.v:326:3
	wire [1:0] _csignals_T_476 = (_csignals_T_33 ? 2'h0 : _csignals_T_475);
	// Trace: core/CtlPath_5Stage.v:327:3
	wire [1:0] _csignals_T_477 = (_csignals_T_31 ? 2'h0 : _csignals_T_476);
	// Trace: core/CtlPath_5Stage.v:328:3
	wire [1:0] _csignals_T_478 = (_csignals_T_29 ? 2'h0 : _csignals_T_477);
	// Trace: core/CtlPath_5Stage.v:329:3
	wire [1:0] _csignals_T_479 = (_csignals_T_27 ? 2'h0 : _csignals_T_478);
	// Trace: core/CtlPath_5Stage.v:330:3
	wire [1:0] _csignals_T_480 = (_csignals_T_25 ? 2'h0 : _csignals_T_479);
	// Trace: core/CtlPath_5Stage.v:331:3
	wire [1:0] _csignals_T_481 = (_csignals_T_23 ? 2'h0 : _csignals_T_480);
	// Trace: core/CtlPath_5Stage.v:332:3
	wire [1:0] _csignals_T_482 = (_csignals_T_21 ? 2'h0 : _csignals_T_481);
	// Trace: core/CtlPath_5Stage.v:333:3
	wire [1:0] _csignals_T_483 = (_csignals_T_19 ? 2'h0 : _csignals_T_482);
	// Trace: core/CtlPath_5Stage.v:334:3
	wire [1:0] _csignals_T_484 = (_csignals_T_17 ? 2'h0 : _csignals_T_483);
	// Trace: core/CtlPath_5Stage.v:335:3
	wire [1:0] _csignals_T_485 = (_csignals_T_15 ? 2'h0 : _csignals_T_484);
	// Trace: core/CtlPath_5Stage.v:336:3
	wire [1:0] _csignals_T_486 = (_csignals_T_13 ? 2'h0 : _csignals_T_485);
	// Trace: core/CtlPath_5Stage.v:337:3
	wire [1:0] _csignals_T_487 = (_csignals_T_11 ? 2'h0 : _csignals_T_486);
	// Trace: core/CtlPath_5Stage.v:338:3
	wire [1:0] _csignals_T_488 = (_csignals_T_9 ? 2'h1 : _csignals_T_487);
	// Trace: core/CtlPath_5Stage.v:339:3
	wire [1:0] _csignals_T_489 = (_csignals_T_7 ? 2'h1 : _csignals_T_488);
	// Trace: core/CtlPath_5Stage.v:340:3
	wire [1:0] _csignals_T_490 = (_csignals_T_5 ? 2'h1 : _csignals_T_489);
	// Trace: core/CtlPath_5Stage.v:341:3
	wire [1:0] _csignals_T_491 = (_csignals_T_3 ? 2'h1 : _csignals_T_490);
	// Trace: core/CtlPath_5Stage.v:342:3
	wire _csignals_T_505 = (_csignals_T_73 ? 1'h0 : _csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81 | (_csignals_T_83 | _csignals_T_85)))));
	// Trace: core/CtlPath_5Stage.v:344:3
	wire _csignals_T_506 = (_csignals_T_71 ? 1'h0 : _csignals_T_505);
	// Trace: core/CtlPath_5Stage.v:345:3
	wire _csignals_T_507 = (_csignals_T_69 ? 1'h0 : _csignals_T_506);
	// Trace: core/CtlPath_5Stage.v:346:3
	wire _csignals_T_508 = (_csignals_T_67 ? 1'h0 : _csignals_T_507);
	// Trace: core/CtlPath_5Stage.v:347:3
	wire _csignals_T_509 = (_csignals_T_65 ? 1'h0 : _csignals_T_508);
	// Trace: core/CtlPath_5Stage.v:348:3
	wire _csignals_T_510 = (_csignals_T_63 ? 1'h0 : _csignals_T_509);
	// Trace: core/CtlPath_5Stage.v:349:3
	wire _csignals_T_534 = (_csignals_T_15 ? 1'h0 : _csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (_csignals_T_23 | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (_csignals_T_37 | (_csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (_csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | (_csignals_T_59 | (_csignals_T_61 | _csignals_T_510)))))))))))))))))))))));
	// Trace: core/CtlPath_5Stage.v:354:3
	wire _csignals_T_535 = (_csignals_T_13 ? 1'h0 : _csignals_T_534);
	// Trace: core/CtlPath_5Stage.v:355:3
	wire _csignals_T_536 = (_csignals_T_11 ? 1'h0 : _csignals_T_535);
	// Trace: core/CtlPath_5Stage.v:356:3
	wire cs0_3 = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (_csignals_T_13 | _csignals_T_15))))));
	// Trace: core/CtlPath_5Stage.v:358:3
	wire _csignals_T_635 = (_csignals_T_9 ? 1'h0 : _csignals_T_11 | (_csignals_T_13 | _csignals_T_15));
	// Trace: core/CtlPath_5Stage.v:359:3
	wire _csignals_T_636 = (_csignals_T_7 ? 1'h0 : _csignals_T_635);
	// Trace: core/CtlPath_5Stage.v:360:3
	wire _csignals_T_637 = (_csignals_T_5 ? 1'h0 : _csignals_T_636);
	// Trace: core/CtlPath_5Stage.v:361:3
	wire _csignals_T_638 = (_csignals_T_3 ? 1'h0 : _csignals_T_637);
	// Trace: core/CtlPath_5Stage.v:362:3
	wire cs0_4 = (_csignals_T_1 ? 1'h0 : _csignals_T_638);
	// Trace: core/CtlPath_5Stage.v:363:3
	wire [2:0] _csignals_T_681 = (_csignals_T_15 ? 3'h2 : 3'h0);
	// Trace: core/CtlPath_5Stage.v:364:3
	wire [2:0] _csignals_T_682 = (_csignals_T_13 ? 3'h1 : _csignals_T_681);
	// Trace: core/CtlPath_5Stage.v:365:3
	wire [2:0] _csignals_T_683 = (_csignals_T_11 ? 3'h3 : _csignals_T_682);
	// Trace: core/CtlPath_5Stage.v:366:3
	wire [2:0] _csignals_T_684 = (_csignals_T_9 ? 3'h6 : _csignals_T_683);
	// Trace: core/CtlPath_5Stage.v:367:3
	wire [2:0] _csignals_T_685 = (_csignals_T_7 ? 3'h2 : _csignals_T_684);
	// Trace: core/CtlPath_5Stage.v:368:3
	wire [2:0] _csignals_T_686 = (_csignals_T_5 ? 3'h5 : _csignals_T_685);
	// Trace: core/CtlPath_5Stage.v:369:3
	wire [2:0] _csignals_T_687 = (_csignals_T_3 ? 3'h1 : _csignals_T_686);
	// Trace: core/CtlPath_5Stage.v:370:3
	wire [2:0] _csignals_T_691 = (_csignals_T_93 ? 3'h4 : 3'h0);
	// Trace: core/CtlPath_5Stage.v:371:3
	wire [2:0] _csignals_T_692 = (_csignals_T_91 ? 3'h4 : _csignals_T_691);
	// Trace: core/CtlPath_5Stage.v:372:3
	wire [2:0] _csignals_T_693 = (_csignals_T_89 ? 3'h4 : _csignals_T_692);
	// Trace: core/CtlPath_5Stage.v:373:3
	wire [2:0] _csignals_T_694 = (_csignals_T_87 ? 3'h4 : _csignals_T_693);
	// Trace: core/CtlPath_5Stage.v:374:3
	wire [2:0] _csignals_T_695 = (_csignals_T_85 ? 3'h7 : _csignals_T_694);
	// Trace: core/CtlPath_5Stage.v:375:3
	wire [2:0] _csignals_T_696 = (_csignals_T_83 ? 3'h7 : _csignals_T_695);
	// Trace: core/CtlPath_5Stage.v:376:3
	wire [2:0] _csignals_T_697 = (_csignals_T_81 ? 3'h6 : _csignals_T_696);
	// Trace: core/CtlPath_5Stage.v:377:3
	wire [2:0] _csignals_T_698 = (_csignals_T_79 ? 3'h5 : _csignals_T_697);
	// Trace: core/CtlPath_5Stage.v:378:3
	wire [2:0] _csignals_T_699 = (_csignals_T_77 ? 3'h6 : _csignals_T_698);
	// Trace: core/CtlPath_5Stage.v:379:3
	wire [2:0] _csignals_T_700 = (_csignals_T_75 ? 3'h5 : _csignals_T_699);
	// Trace: core/CtlPath_5Stage.v:380:3
	wire [2:0] _csignals_T_701 = (_csignals_T_73 ? 3'h0 : _csignals_T_700);
	// Trace: core/CtlPath_5Stage.v:381:3
	wire [2:0] _csignals_T_702 = (_csignals_T_71 ? 3'h0 : _csignals_T_701);
	// Trace: core/CtlPath_5Stage.v:382:3
	wire [2:0] _csignals_T_703 = (_csignals_T_69 ? 3'h0 : _csignals_T_702);
	// Trace: core/CtlPath_5Stage.v:383:3
	wire [2:0] _csignals_T_704 = (_csignals_T_67 ? 3'h0 : _csignals_T_703);
	// Trace: core/CtlPath_5Stage.v:384:3
	wire [2:0] _csignals_T_705 = (_csignals_T_65 ? 3'h0 : _csignals_T_704);
	// Trace: core/CtlPath_5Stage.v:385:3
	wire [2:0] _csignals_T_706 = (_csignals_T_63 ? 3'h0 : _csignals_T_705);
	// Trace: core/CtlPath_5Stage.v:386:3
	wire [2:0] _csignals_T_707 = (_csignals_T_61 ? 3'h0 : _csignals_T_706);
	// Trace: core/CtlPath_5Stage.v:387:3
	wire [2:0] _csignals_T_708 = (_csignals_T_59 ? 3'h0 : _csignals_T_707);
	// Trace: core/CtlPath_5Stage.v:388:3
	wire [2:0] _csignals_T_709 = (_csignals_T_57 ? 3'h0 : _csignals_T_708);
	// Trace: core/CtlPath_5Stage.v:389:3
	wire [2:0] _csignals_T_710 = (_csignals_T_55 ? 3'h0 : _csignals_T_709);
	// Trace: core/CtlPath_5Stage.v:390:3
	wire [2:0] _csignals_T_711 = (_csignals_T_53 ? 3'h0 : _csignals_T_710);
	// Trace: core/CtlPath_5Stage.v:391:3
	wire [2:0] _csignals_T_712 = (_csignals_T_51 ? 3'h0 : _csignals_T_711);
	// Trace: core/CtlPath_5Stage.v:392:3
	wire [2:0] _csignals_T_713 = (_csignals_T_49 ? 3'h0 : _csignals_T_712);
	// Trace: core/CtlPath_5Stage.v:393:3
	wire [2:0] _csignals_T_714 = (_csignals_T_47 ? 3'h0 : _csignals_T_713);
	// Trace: core/CtlPath_5Stage.v:394:3
	wire [2:0] _csignals_T_715 = (_csignals_T_45 ? 3'h0 : _csignals_T_714);
	// Trace: core/CtlPath_5Stage.v:395:3
	wire [2:0] _csignals_T_716 = (_csignals_T_43 ? 3'h0 : _csignals_T_715);
	// Trace: core/CtlPath_5Stage.v:396:3
	wire [2:0] _csignals_T_717 = (_csignals_T_41 ? 3'h0 : _csignals_T_716);
	// Trace: core/CtlPath_5Stage.v:397:3
	wire [2:0] _csignals_T_718 = (_csignals_T_39 ? 3'h0 : _csignals_T_717);
	// Trace: core/CtlPath_5Stage.v:398:3
	wire [2:0] _csignals_T_719 = (_csignals_T_37 ? 3'h0 : _csignals_T_718);
	// Trace: core/CtlPath_5Stage.v:399:3
	wire [2:0] _csignals_T_720 = (_csignals_T_35 ? 3'h0 : _csignals_T_719);
	// Trace: core/CtlPath_5Stage.v:400:3
	wire [2:0] _csignals_T_721 = (_csignals_T_33 ? 3'h0 : _csignals_T_720);
	// Trace: core/CtlPath_5Stage.v:401:3
	wire [2:0] _csignals_T_722 = (_csignals_T_31 ? 3'h0 : _csignals_T_721);
	// Trace: core/CtlPath_5Stage.v:402:3
	wire [2:0] _csignals_T_723 = (_csignals_T_29 ? 3'h0 : _csignals_T_722);
	// Trace: core/CtlPath_5Stage.v:403:3
	wire [2:0] _csignals_T_724 = (_csignals_T_27 ? 3'h0 : _csignals_T_723);
	// Trace: core/CtlPath_5Stage.v:404:3
	wire [2:0] _csignals_T_725 = (_csignals_T_25 ? 3'h0 : _csignals_T_724);
	// Trace: core/CtlPath_5Stage.v:405:3
	wire [2:0] _csignals_T_726 = (_csignals_T_23 ? 3'h0 : _csignals_T_725);
	// Trace: core/CtlPath_5Stage.v:406:3
	wire [2:0] _csignals_T_727 = (_csignals_T_21 ? 3'h0 : _csignals_T_726);
	// Trace: core/CtlPath_5Stage.v:407:3
	wire [2:0] _csignals_T_728 = (_csignals_T_19 ? 3'h0 : _csignals_T_727);
	// Trace: core/CtlPath_5Stage.v:408:3
	wire [2:0] _csignals_T_729 = (_csignals_T_17 ? 3'h0 : _csignals_T_728);
	// Trace: core/CtlPath_5Stage.v:409:3
	wire [2:0] _csignals_T_730 = (_csignals_T_15 ? 3'h0 : _csignals_T_729);
	// Trace: core/CtlPath_5Stage.v:410:3
	wire [2:0] _csignals_T_731 = (_csignals_T_13 ? 3'h0 : _csignals_T_730);
	// Trace: core/CtlPath_5Stage.v:411:3
	wire [2:0] _csignals_T_732 = (_csignals_T_11 ? 3'h0 : _csignals_T_731);
	// Trace: core/CtlPath_5Stage.v:412:3
	wire [2:0] _csignals_T_733 = (_csignals_T_9 ? 3'h0 : _csignals_T_732);
	// Trace: core/CtlPath_5Stage.v:413:3
	wire [2:0] _csignals_T_734 = (_csignals_T_7 ? 3'h0 : _csignals_T_733);
	// Trace: core/CtlPath_5Stage.v:414:3
	wire [2:0] _csignals_T_735 = (_csignals_T_5 ? 3'h0 : _csignals_T_734);
	// Trace: core/CtlPath_5Stage.v:415:3
	wire [2:0] _csignals_T_736 = (_csignals_T_3 ? 3'h0 : _csignals_T_735);
	// Trace: core/CtlPath_5Stage.v:416:3
	wire [2:0] cs0_6 = (_csignals_T_1 ? 3'h0 : _csignals_T_736);
	// Trace: core/CtlPath_5Stage.v:417:3
	wire _csignals_T_739 = (_csignals_T_95 ? 1'h0 : _csignals_T_97);
	// Trace: core/CtlPath_5Stage.v:418:3
	wire _csignals_T_740 = (_csignals_T_93 ? 1'h0 : _csignals_T_739);
	// Trace: core/CtlPath_5Stage.v:419:3
	wire _csignals_T_741 = (_csignals_T_91 ? 1'h0 : _csignals_T_740);
	// Trace: core/CtlPath_5Stage.v:420:3
	wire _csignals_T_742 = (_csignals_T_89 ? 1'h0 : _csignals_T_741);
	// Trace: core/CtlPath_5Stage.v:421:3
	wire _csignals_T_743 = (_csignals_T_87 ? 1'h0 : _csignals_T_742);
	// Trace: core/CtlPath_5Stage.v:422:3
	wire _csignals_T_744 = (_csignals_T_85 ? 1'h0 : _csignals_T_743);
	// Trace: core/CtlPath_5Stage.v:423:3
	wire _csignals_T_745 = (_csignals_T_83 ? 1'h0 : _csignals_T_744);
	// Trace: core/CtlPath_5Stage.v:424:3
	wire _csignals_T_746 = (_csignals_T_81 ? 1'h0 : _csignals_T_745);
	// Trace: core/CtlPath_5Stage.v:425:3
	wire _csignals_T_747 = (_csignals_T_79 ? 1'h0 : _csignals_T_746);
	// Trace: core/CtlPath_5Stage.v:426:3
	wire _csignals_T_748 = (_csignals_T_77 ? 1'h0 : _csignals_T_747);
	// Trace: core/CtlPath_5Stage.v:427:3
	wire _csignals_T_749 = (_csignals_T_75 ? 1'h0 : _csignals_T_748);
	// Trace: core/CtlPath_5Stage.v:428:3
	wire _csignals_T_750 = (_csignals_T_73 ? 1'h0 : _csignals_T_749);
	// Trace: core/CtlPath_5Stage.v:429:3
	wire _csignals_T_751 = (_csignals_T_71 ? 1'h0 : _csignals_T_750);
	// Trace: core/CtlPath_5Stage.v:430:3
	wire _csignals_T_752 = (_csignals_T_69 ? 1'h0 : _csignals_T_751);
	// Trace: core/CtlPath_5Stage.v:431:3
	wire _csignals_T_753 = (_csignals_T_67 ? 1'h0 : _csignals_T_752);
	// Trace: core/CtlPath_5Stage.v:432:3
	wire _csignals_T_754 = (_csignals_T_65 ? 1'h0 : _csignals_T_753);
	// Trace: core/CtlPath_5Stage.v:433:3
	wire _csignals_T_755 = (_csignals_T_63 ? 1'h0 : _csignals_T_754);
	// Trace: core/CtlPath_5Stage.v:434:3
	wire _csignals_T_756 = (_csignals_T_61 ? 1'h0 : _csignals_T_755);
	// Trace: core/CtlPath_5Stage.v:435:3
	wire _csignals_T_757 = (_csignals_T_59 ? 1'h0 : _csignals_T_756);
	// Trace: core/CtlPath_5Stage.v:436:3
	wire _csignals_T_758 = (_csignals_T_57 ? 1'h0 : _csignals_T_757);
	// Trace: core/CtlPath_5Stage.v:437:3
	wire _csignals_T_759 = (_csignals_T_55 ? 1'h0 : _csignals_T_758);
	// Trace: core/CtlPath_5Stage.v:438:3
	wire _csignals_T_760 = (_csignals_T_53 ? 1'h0 : _csignals_T_759);
	// Trace: core/CtlPath_5Stage.v:439:3
	wire _csignals_T_761 = (_csignals_T_51 ? 1'h0 : _csignals_T_760);
	// Trace: core/CtlPath_5Stage.v:440:3
	wire _csignals_T_762 = (_csignals_T_49 ? 1'h0 : _csignals_T_761);
	// Trace: core/CtlPath_5Stage.v:441:3
	wire _csignals_T_763 = (_csignals_T_47 ? 1'h0 : _csignals_T_762);
	// Trace: core/CtlPath_5Stage.v:442:3
	wire _csignals_T_764 = (_csignals_T_45 ? 1'h0 : _csignals_T_763);
	// Trace: core/CtlPath_5Stage.v:443:3
	wire _csignals_T_765 = (_csignals_T_43 ? 1'h0 : _csignals_T_764);
	// Trace: core/CtlPath_5Stage.v:444:3
	wire _csignals_T_766 = (_csignals_T_41 ? 1'h0 : _csignals_T_765);
	// Trace: core/CtlPath_5Stage.v:445:3
	wire _csignals_T_767 = (_csignals_T_39 ? 1'h0 : _csignals_T_766);
	// Trace: core/CtlPath_5Stage.v:446:3
	wire _csignals_T_768 = (_csignals_T_37 ? 1'h0 : _csignals_T_767);
	// Trace: core/CtlPath_5Stage.v:447:3
	wire _csignals_T_769 = (_csignals_T_35 ? 1'h0 : _csignals_T_768);
	// Trace: core/CtlPath_5Stage.v:448:3
	wire _csignals_T_770 = (_csignals_T_33 ? 1'h0 : _csignals_T_769);
	// Trace: core/CtlPath_5Stage.v:449:3
	wire _csignals_T_771 = (_csignals_T_31 ? 1'h0 : _csignals_T_770);
	// Trace: core/CtlPath_5Stage.v:450:3
	wire _csignals_T_772 = (_csignals_T_29 ? 1'h0 : _csignals_T_771);
	// Trace: core/CtlPath_5Stage.v:451:3
	wire _csignals_T_773 = (_csignals_T_27 ? 1'h0 : _csignals_T_772);
	// Trace: core/CtlPath_5Stage.v:452:3
	wire _csignals_T_774 = (_csignals_T_25 ? 1'h0 : _csignals_T_773);
	// Trace: core/CtlPath_5Stage.v:453:3
	wire _csignals_T_775 = (_csignals_T_23 ? 1'h0 : _csignals_T_774);
	// Trace: core/CtlPath_5Stage.v:454:3
	wire _csignals_T_776 = (_csignals_T_21 ? 1'h0 : _csignals_T_775);
	// Trace: core/CtlPath_5Stage.v:455:3
	wire _csignals_T_777 = (_csignals_T_19 ? 1'h0 : _csignals_T_776);
	// Trace: core/CtlPath_5Stage.v:456:3
	wire _csignals_T_778 = (_csignals_T_17 ? 1'h0 : _csignals_T_777);
	// Trace: core/CtlPath_5Stage.v:457:3
	wire _csignals_T_779 = (_csignals_T_15 ? 1'h0 : _csignals_T_778);
	// Trace: core/CtlPath_5Stage.v:458:3
	wire _csignals_T_780 = (_csignals_T_13 ? 1'h0 : _csignals_T_779);
	// Trace: core/CtlPath_5Stage.v:459:3
	wire _csignals_T_781 = (_csignals_T_11 ? 1'h0 : _csignals_T_780);
	// Trace: core/CtlPath_5Stage.v:460:3
	wire _csignals_T_782 = (_csignals_T_9 ? 1'h0 : _csignals_T_781);
	// Trace: core/CtlPath_5Stage.v:461:3
	wire _csignals_T_783 = (_csignals_T_7 ? 1'h0 : _csignals_T_782);
	// Trace: core/CtlPath_5Stage.v:462:3
	wire _csignals_T_784 = (_csignals_T_5 ? 1'h0 : _csignals_T_783);
	// Trace: core/CtlPath_5Stage.v:463:3
	wire _csignals_T_785 = (_csignals_T_3 ? 1'h0 : _csignals_T_784);
	// Trace: core/CtlPath_5Stage.v:464:3
	wire cs0_7 = (_csignals_T_1 ? 1'h0 : _csignals_T_785);
	// Trace: core/CtlPath_5Stage.v:465:3
	wire [1:0] _ctrl_exe_pc_sel_T_3 = (~io_dat_exe_br_eq ? 2'h1 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:466:3
	wire [1:0] _ctrl_exe_pc_sel_T_5 = (io_dat_exe_br_eq ? 2'h1 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:467:3
	wire [1:0] _ctrl_exe_pc_sel_T_8 = (~io_dat_exe_br_lt ? 2'h1 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:468:3
	wire [1:0] _ctrl_exe_pc_sel_T_11 = (~io_dat_exe_br_ltu ? 2'h1 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:469:3
	wire [1:0] _ctrl_exe_pc_sel_T_13 = (io_dat_exe_br_lt ? 2'h1 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:470:3
	wire [1:0] _ctrl_exe_pc_sel_T_15 = (io_dat_exe_br_ltu ? 2'h1 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:471:3
	wire [1:0] _ctrl_exe_pc_sel_T_18 = (io_dat_exe_br_type == 4'h8 ? 2'h2 : 2'h0);
	// Trace: core/CtlPath_5Stage.v:472:3
	wire [1:0] _ctrl_exe_pc_sel_T_19 = (io_dat_exe_br_type == 4'h7 ? 2'h1 : _ctrl_exe_pc_sel_T_18);
	// Trace: core/CtlPath_5Stage.v:473:3
	wire [1:0] _ctrl_exe_pc_sel_T_20 = (io_dat_exe_br_type == 4'h6 ? _ctrl_exe_pc_sel_T_15 : _ctrl_exe_pc_sel_T_19);
	// Trace: core/CtlPath_5Stage.v:474:3
	wire [1:0] _ctrl_exe_pc_sel_T_21 = (io_dat_exe_br_type == 4'h5 ? _ctrl_exe_pc_sel_T_13 : _ctrl_exe_pc_sel_T_20);
	// Trace: core/CtlPath_5Stage.v:475:3
	wire [1:0] _ctrl_exe_pc_sel_T_22 = (io_dat_exe_br_type == 4'h4 ? _ctrl_exe_pc_sel_T_11 : _ctrl_exe_pc_sel_T_21);
	// Trace: core/CtlPath_5Stage.v:476:3
	wire [1:0] _ctrl_exe_pc_sel_T_23 = (io_dat_exe_br_type == 4'h3 ? _ctrl_exe_pc_sel_T_8 : _ctrl_exe_pc_sel_T_22);
	// Trace: core/CtlPath_5Stage.v:477:3
	wire [1:0] _ctrl_exe_pc_sel_T_24 = (io_dat_exe_br_type == 4'h2 ? _ctrl_exe_pc_sel_T_5 : _ctrl_exe_pc_sel_T_23);
	// Trace: core/CtlPath_5Stage.v:478:3
	wire [1:0] _ctrl_exe_pc_sel_T_25 = (io_dat_exe_br_type == 4'h1 ? _ctrl_exe_pc_sel_T_3 : _ctrl_exe_pc_sel_T_24);
	// Trace: core/CtlPath_5Stage.v:479:3
	wire [1:0] _ctrl_exe_pc_sel_T_26 = (io_dat_exe_br_type == 4'h0 ? 2'h0 : _ctrl_exe_pc_sel_T_25);
	// Trace: core/CtlPath_5Stage.v:480:3
	wire [1:0] ctrl_exe_pc_sel = (io_ctl_pipeline_kill ? 2'h3 : _ctrl_exe_pc_sel_T_26);
	// Trace: core/CtlPath_5Stage.v:481:3
	wire _ifkill_T = ctrl_exe_pc_sel != 2'h0;
	// Trace: core/CtlPath_5Stage.v:482:3
	reg ifkill_REG;
	// Trace: core/CtlPath_5Stage.v:483:3
	wire dec_illegal = ~cs_val_inst & io_dat_dec_valid;
	// Trace: core/CtlPath_5Stage.v:484:3
	wire [4:0] dec_rs1_addr = io_dat_dec_inst[19:15];
	// Trace: core/CtlPath_5Stage.v:485:3
	wire [4:0] dec_rs2_addr = io_dat_dec_inst[24:20];
	// Trace: core/CtlPath_5Stage.v:486:3
	wire [4:0] dec_wbaddr = io_dat_dec_inst[11:7];
	// Trace: core/CtlPath_5Stage.v:487:3
	wire dec_rs1_oen = (_ifkill_T ? 1'h0 : cs_rs1_oen);
	// Trace: core/CtlPath_5Stage.v:488:3
	wire dec_rs2_oen = (_ifkill_T ? 1'h0 : cs_rs2_oen);
	// Trace: core/CtlPath_5Stage.v:489:3
	reg [4:0] exe_reg_wbaddr;
	// Trace: core/CtlPath_5Stage.v:490:3
	reg exe_reg_illegal;
	// Trace: core/CtlPath_5Stage.v:491:3
	reg exe_reg_is_csr;
	// Trace: core/CtlPath_5Stage.v:492:3
	reg exe_inst_is_load;
	// Trace: core/CtlPath_5Stage.v:493:3
	wire _stall_T_2 = exe_reg_wbaddr != 5'h00;
	// Trace: core/CtlPath_5Stage.v:494:3
	wire _stall_T_9 = ((exe_inst_is_load & (exe_reg_wbaddr == dec_rs2_addr)) & _stall_T_2) & dec_rs2_oen;
	// Trace: core/CtlPath_5Stage.v:495:3
	wire _stall_T_10 = (((exe_inst_is_load & (exe_reg_wbaddr == dec_rs1_addr)) & (exe_reg_wbaddr != 5'h00)) & dec_rs1_oen) | _stall_T_9;
	// Trace: core/CtlPath_5Stage.v:496:3
	wire stall = _stall_T_10 | exe_reg_is_csr;
	// Trace: core/CtlPath_5Stage.v:497:3
	wire full_stall = ~((io_dat_mem_ctrl_dmem_val & io_dmem_resp_valid) | ~io_dat_mem_ctrl_dmem_val);
	// Trace: core/CtlPath_5Stage.v:498:3
	wire _T_1 = ~full_stall;
	// Trace: core/CtlPath_5Stage.v:499:3
	wire _T_2 = ~stall & ~full_stall;
	// Trace: core/CtlPath_5Stage.v:500:3
	wire _T_4 = stall & _T_1;
	// Trace: core/CtlPath_5Stage.v:501:3
	reg io_ctl_fencei_REG;
	// Trace: core/CtlPath_5Stage.v:502:3
	reg io_ctl_mem_exception_REG;
	// Trace: core/CtlPath_5Stage.v:503:3
	reg io_ctl_mem_exception_cause_REG;
	// Trace: core/CtlPath_5Stage.v:504:3
	reg io_ctl_mem_exception_cause_REG_1;
	// Trace: core/CtlPath_5Stage.v:505:3
	wire [2:0] _io_ctl_mem_exception_cause_T = (io_dat_mem_store ? 3'h6 : 3'h4);
	// Trace: core/CtlPath_5Stage.v:506:3
	wire [2:0] _io_ctl_mem_exception_cause_T_1 = (io_ctl_mem_exception_cause_REG_1 ? 3'h0 : _io_ctl_mem_exception_cause_T);
	// Trace: core/CtlPath_5Stage.v:507:3
	wire [2:0] _io_ctl_mem_exception_cause_T_2 = (io_ctl_mem_exception_cause_REG ? 3'h2 : _io_ctl_mem_exception_cause_T_1);
	// Trace: core/CtlPath_5Stage.v:508:3
	wire csr_ren = ((cs0_6 == 3'h6) | (cs0_6 == 3'h7)) & (dec_rs1_addr == 5'h00);
	// Trace: core/CtlPath_5Stage.v:509:3
	assign io_ctl_dec_stall = _stall_T_10 | exe_reg_is_csr;
	// Trace: core/CtlPath_5Stage.v:510:3
	assign io_ctl_full_stall = ~((io_dat_mem_ctrl_dmem_val & io_dmem_resp_valid) | ~io_dat_mem_ctrl_dmem_val);
	// Trace: core/CtlPath_5Stage.v:511:3
	assign io_ctl_exe_pc_sel = (io_ctl_pipeline_kill ? 2'h3 : _ctrl_exe_pc_sel_T_26);
	// Trace: core/CtlPath_5Stage.v:512:3
	assign io_ctl_br_type = (_csignals_T_1 ? 4'h0 : _csignals_T_197);
	// Trace: core/CtlPath_5Stage.v:513:3
	assign io_ctl_if_kill = ((ctrl_exe_pc_sel != 2'h0) | cs0_7) | ifkill_REG;
	// Trace: core/CtlPath_5Stage.v:514:3
	assign io_ctl_dec_kill = ctrl_exe_pc_sel != 2'h0;
	// Trace: core/CtlPath_5Stage.v:515:3
	assign io_ctl_op1_sel = (_csignals_T_1 ? 2'h0 : _csignals_T_246);
	// Trace: core/CtlPath_5Stage.v:516:3
	assign io_ctl_op2_sel = (_csignals_T_1 ? 3'h1 : _csignals_T_295);
	// Trace: core/CtlPath_5Stage.v:517:3
	assign io_ctl_alu_fun = (_csignals_T_1 ? 4'h0 : _csignals_T_442);
	// Trace: core/CtlPath_5Stage.v:518:3
	assign io_ctl_wb_sel = (_csignals_T_1 ? 2'h1 : _csignals_T_491);
	// Trace: core/CtlPath_5Stage.v:519:3
	assign io_ctl_rf_wen = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | _csignals_T_536))));
	// Trace: core/CtlPath_5Stage.v:521:3
	assign io_ctl_mem_val = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (_csignals_T_13 | _csignals_T_15))))));
	// Trace: core/CtlPath_5Stage.v:523:3
	assign io_ctl_mem_fcn = {1'd0, cs0_4};
	// Trace: core/CtlPath_5Stage.v:524:3
	assign io_ctl_mem_typ = (_csignals_T_1 ? 3'h3 : _csignals_T_687);
	// Trace: core/CtlPath_5Stage.v:525:3
	assign io_ctl_csr_cmd = (csr_ren ? 3'h2 : cs0_6);
	// Trace: core/CtlPath_5Stage.v:526:3
	assign io_ctl_fencei = cs0_7 | io_ctl_fencei_REG;
	// Trace: core/CtlPath_5Stage.v:527:3
	assign io_ctl_pipeline_kill = (io_dat_csr_eret | io_ctl_mem_exception) | io_dat_csr_interrupt;
	// Trace: core/CtlPath_5Stage.v:528:3
	assign io_ctl_mem_exception = io_ctl_mem_exception_REG | io_dat_mem_data_misaligned;
	// Trace: core/CtlPath_5Stage.v:529:3
	assign io_ctl_mem_exception_cause = {29'd0, _io_ctl_mem_exception_cause_T_2};
	// Trace: core/CtlPath_5Stage.v:530:3
	always @(posedge clock) begin
		// Trace: core/CtlPath_5Stage.v:531:5
		if (_csignals_T_1)
			// Trace: core/CtlPath_5Stage.v:532:7
			ifkill_REG <= 1'h0;
		else if (_csignals_T_3)
			// Trace: core/CtlPath_5Stage.v:534:7
			ifkill_REG <= 1'h0;
		else if (_csignals_T_5)
			// Trace: core/CtlPath_5Stage.v:536:7
			ifkill_REG <= 1'h0;
		else if (_csignals_T_7)
			// Trace: core/CtlPath_5Stage.v:538:7
			ifkill_REG <= 1'h0;
		else
			// Trace: core/CtlPath_5Stage.v:540:7
			ifkill_REG <= _csignals_T_782;
		if (_T_2) begin
			begin
				// Trace: core/CtlPath_5Stage.v:543:7
				if (_ifkill_T)
					// Trace: core/CtlPath_5Stage.v:544:9
					exe_reg_wbaddr <= 5'h00;
				else
					// Trace: core/CtlPath_5Stage.v:546:9
					exe_reg_wbaddr <= dec_wbaddr;
			end
		end
		else if (_T_4)
			// Trace: core/CtlPath_5Stage.v:549:7
			exe_reg_wbaddr <= 5'h00;
		if (reset)
			// Trace: core/CtlPath_5Stage.v:552:7
			exe_reg_illegal <= 1'h0;
		else if (io_dat_csr_eret)
			// Trace: core/CtlPath_5Stage.v:554:7
			exe_reg_illegal <= 1'h0;
		else if (_T_2) begin
			begin
				// Trace: core/CtlPath_5Stage.v:556:7
				if (_ifkill_T)
					// Trace: core/CtlPath_5Stage.v:557:9
					exe_reg_illegal <= 1'h0;
				else
					// Trace: core/CtlPath_5Stage.v:559:9
					exe_reg_illegal <= dec_illegal;
			end
		end
		else if (_T_4)
			// Trace: core/CtlPath_5Stage.v:562:7
			exe_reg_illegal <= 1'h0;
		if (reset)
			// Trace: core/CtlPath_5Stage.v:565:7
			exe_reg_is_csr <= 1'h0;
		else if (_T_2) begin
			begin
				// Trace: core/CtlPath_5Stage.v:567:7
				if (_ifkill_T)
					// Trace: core/CtlPath_5Stage.v:568:9
					exe_reg_is_csr <= 1'h0;
				else
					// Trace: core/CtlPath_5Stage.v:570:9
					exe_reg_is_csr <= (cs0_6 != 3'h0) & (cs0_6 != 3'h4);
			end
		end
		else if (_T_4)
			// Trace: core/CtlPath_5Stage.v:573:7
			exe_reg_is_csr <= 1'h0;
		if (reset)
			// Trace: core/CtlPath_5Stage.v:576:7
			exe_inst_is_load <= 1'h0;
		else if (_T_1)
			// Trace: core/CtlPath_5Stage.v:578:7
			exe_inst_is_load <= cs0_3 & ~cs0_4;
		if (_csignals_T_1)
			// Trace: core/CtlPath_5Stage.v:581:7
			io_ctl_fencei_REG <= 1'h0;
		else if (_csignals_T_3)
			// Trace: core/CtlPath_5Stage.v:583:7
			io_ctl_fencei_REG <= 1'h0;
		else if (_csignals_T_5)
			// Trace: core/CtlPath_5Stage.v:585:7
			io_ctl_fencei_REG <= 1'h0;
		else if (_csignals_T_7)
			// Trace: core/CtlPath_5Stage.v:587:7
			io_ctl_fencei_REG <= 1'h0;
		else
			// Trace: core/CtlPath_5Stage.v:589:7
			io_ctl_fencei_REG <= _csignals_T_782;
		// Trace: core/CtlPath_5Stage.v:591:5
		io_ctl_mem_exception_REG <= (exe_reg_illegal | io_dat_exe_inst_misaligned) & ~io_dat_csr_eret;
		// Trace: core/CtlPath_5Stage.v:592:5
		io_ctl_mem_exception_cause_REG <= exe_reg_illegal;
		// Trace: core/CtlPath_5Stage.v:593:5
		io_ctl_mem_exception_cause_REG_1 <= io_dat_exe_inst_misaligned;
	end
	// Trace: core/CtlPath_5Stage.v:657:1
	always @(posedge clock)
		// Trace: core/CtlPath_5Stage.v:658:3
		if (reset) begin
			// Trace: core/CtlPath_5Stage.v:659:7
			ifkill_REG <= 1'h0;
			// Trace: core/CtlPath_5Stage.v:660:7
			exe_reg_wbaddr <= 5'h00;
			// Trace: core/CtlPath_5Stage.v:661:7
			io_ctl_fencei_REG <= 1'h0;
			// Trace: core/CtlPath_5Stage.v:662:7
			io_ctl_mem_exception_REG <= 1'h0;
			// Trace: core/CtlPath_5Stage.v:663:7
			io_ctl_mem_exception_cause_REG <= 1'h0;
			// Trace: core/CtlPath_5Stage.v:664:7
			io_ctl_mem_exception_cause_REG_1 <= 1'h0;
		end
endmodule
