module CtlPath_2stage (
	io_imem_resp_valid,
	io_dmem_req_valid,
	io_dmem_req_bits_fcn,
	io_dmem_req_bits_typ,
	io_dmem_resp_valid,
	io_dat_if_valid_resp,
	io_dat_inst,
	io_dat_br_eq,
	io_dat_br_lt,
	io_dat_br_ltu,
	io_dat_inst_misaligned,
	io_dat_data_misaligned,
	io_dat_mem_store,
	io_dat_csr_eret,
	io_dat_csr_interrupt,
	io_ctl_stall,
	io_ctl_if_kill,
	io_ctl_pc_sel,
	io_ctl_op1_sel,
	io_ctl_op2_sel,
	io_ctl_alu_fun,
	io_ctl_wb_sel,
	io_ctl_rf_wen,
	io_ctl_csr_cmd,
	io_ctl_mem_val,
	io_ctl_mem_fcn,
	io_ctl_mem_typ,
	io_ctl_exception,
	io_ctl_exception_cause,
	io_ctl_pc_sel_no_xept,
	io_dat_inst_ctr,
	io_ctl_alu_fun_ctr,
	io_ctl_op1_sel_ctr,
	io_ctl_op2_sel_ctr,
	io_dat_br_eq_ctr,
	io_dat_br_lt_ctr,
	io_dat_br_ltu_ctr
);
	// Trace: core/CtlPath_2stage.v:2:3
	input io_imem_resp_valid;
	// Trace: core/CtlPath_2stage.v:3:3
	output wire io_dmem_req_valid;
	// Trace: core/CtlPath_2stage.v:4:3
	output wire io_dmem_req_bits_fcn;
	// Trace: core/CtlPath_2stage.v:5:3
	output wire [2:0] io_dmem_req_bits_typ;
	// Trace: core/CtlPath_2stage.v:6:3
	input io_dmem_resp_valid;
	// Trace: core/CtlPath_2stage.v:7:3
	input io_dat_if_valid_resp;
	// Trace: core/CtlPath_2stage.v:8:3
	input [31:0] io_dat_inst;
	// Trace: core/CtlPath_2stage.v:9:3
	input io_dat_br_eq;
	// Trace: core/CtlPath_2stage.v:10:3
	input io_dat_br_lt;
	// Trace: core/CtlPath_2stage.v:11:3
	input io_dat_br_ltu;
	// Trace: core/CtlPath_2stage.v:12:3
	input io_dat_inst_misaligned;
	// Trace: core/CtlPath_2stage.v:13:3
	input io_dat_data_misaligned;
	// Trace: core/CtlPath_2stage.v:14:3
	input io_dat_mem_store;
	// Trace: core/CtlPath_2stage.v:15:3
	input io_dat_csr_eret;
	// Trace: core/CtlPath_2stage.v:16:3
	input io_dat_csr_interrupt;
	// Trace: core/CtlPath_2stage.v:17:3
	output wire io_ctl_stall;
	// Trace: core/CtlPath_2stage.v:18:3
	output wire io_ctl_if_kill;
	// Trace: core/CtlPath_2stage.v:19:3
	output wire [2:0] io_ctl_pc_sel;
	// Trace: core/CtlPath_2stage.v:20:3
	output wire [1:0] io_ctl_op1_sel;
	// Trace: core/CtlPath_2stage.v:21:3
	output wire [2:0] io_ctl_op2_sel;
	// Trace: core/CtlPath_2stage.v:22:3
	output wire [4:0] io_ctl_alu_fun;
	// Trace: core/CtlPath_2stage.v:23:3
	output wire [1:0] io_ctl_wb_sel;
	// Trace: core/CtlPath_2stage.v:24:3
	output wire io_ctl_rf_wen;
	// Trace: core/CtlPath_2stage.v:25:3
	output wire [2:0] io_ctl_csr_cmd;
	// Trace: core/CtlPath_2stage.v:26:3
	output wire io_ctl_mem_val;
	// Trace: core/CtlPath_2stage.v:27:3
	output wire [1:0] io_ctl_mem_fcn;
	// Trace: core/CtlPath_2stage.v:28:3
	output wire [2:0] io_ctl_mem_typ;
	// Trace: core/CtlPath_2stage.v:29:3
	output wire io_ctl_exception;
	// Trace: core/CtlPath_2stage.v:30:3
	output wire [31:0] io_ctl_exception_cause;
	// Trace: core/CtlPath_2stage.v:31:3
	output wire [2:0] io_ctl_pc_sel_no_xept;
	// Trace: core/CtlPath_2stage.v:33:3
	input [31:0] io_dat_inst_ctr;
	// Trace: core/CtlPath_2stage.v:35:3
	output wire [4:0] io_ctl_alu_fun_ctr;
	// Trace: core/CtlPath_2stage.v:36:3
	output wire [1:0] io_ctl_op1_sel_ctr;
	// Trace: core/CtlPath_2stage.v:37:3
	output wire [2:0] io_ctl_op2_sel_ctr;
	// Trace: core/CtlPath_2stage.v:39:3
	input io_dat_br_eq_ctr;
	// Trace: core/CtlPath_2stage.v:40:3
	input io_dat_br_lt_ctr;
	// Trace: core/CtlPath_2stage.v:41:3
	input io_dat_br_ltu_ctr;
	// Trace: core/CtlPath_2stage.v:45:3
	wire load_ctr;
	// Trace: core/CtlPath_2stage.v:46:3
	wire [1:0] io_ctl_wb_sel_ctr;
	assign load_ctr = io_ctl_wb_sel_ctr == 2'h1;
	// Trace: core/CtlPath_2stage.v:47:3
	// Trace: core/CtlPath_2stage.v:48:3
	wire [31:0] _csignals_T_ctr = io_dat_inst_ctr & 32'h0000707f;
	wire _csignals_T_1_ctr = 32'h00002003 == _csignals_T_ctr;
	wire _csignals_T_11_ctr = 32'h00002023 == _csignals_T_ctr;
	wire _csignals_T_13_ctr = 32'h00000023 == _csignals_T_ctr;
	wire _csignals_T_15_ctr = 32'h00001023 == _csignals_T_ctr;
	wire [31:0] _csignals_T_16_ctr = io_dat_inst_ctr & 32'h0000007f;
	wire _csignals_T_17_ctr = 32'h00000017 == _csignals_T_16_ctr;
	wire _csignals_T_19_ctr = 32'h00000037 == _csignals_T_16_ctr;
	wire _csignals_T_21_ctr = 32'h00000013 == _csignals_T_ctr;
	wire _csignals_T_23_ctr = 32'h00007013 == _csignals_T_ctr;
	wire _csignals_T_25_ctr = 32'h00006013 == _csignals_T_ctr;
	wire _csignals_T_27_ctr = 32'h00004013 == _csignals_T_ctr;
	wire _csignals_T_29_ctr = 32'h00002013 == _csignals_T_ctr;
	wire _csignals_T_31_ctr = 32'h00003013 == _csignals_T_ctr;
	wire [31:0] _csignals_T_32_ctr = io_dat_inst_ctr & 32'hfc00707f;
	wire _csignals_T_33_ctr = 32'h00001013 == _csignals_T_32_ctr;
	wire _csignals_T_35_ctr = 32'h40005013 == _csignals_T_32_ctr;
	wire _csignals_T_85_ctr = 32'h00007073 == _csignals_T_ctr;
	wire [1:0] _csignals_T_352_ctr = (_csignals_T_85_ctr ? 2'h3 : 2'h0);
	wire _csignals_T_83_ctr = 32'h00003073 == _csignals_T_ctr;
	wire [1:0] _csignals_T_353_ctr = (_csignals_T_83_ctr ? 2'h3 : _csignals_T_352_ctr);
	wire _csignals_T_81_ctr = 32'h00002073 == _csignals_T_ctr;
	wire [1:0] _csignals_T_354_ctr = (_csignals_T_81_ctr ? 2'h3 : _csignals_T_353_ctr);
	wire _csignals_T_79_ctr = 32'h00001073 == _csignals_T_ctr;
	wire [1:0] _csignals_T_355_ctr = (_csignals_T_79_ctr ? 2'h3 : _csignals_T_354_ctr);
	wire _csignals_T_77_ctr = 32'h00006073 == _csignals_T_ctr;
	wire [1:0] _csignals_T_356_ctr = (_csignals_T_77_ctr ? 2'h3 : _csignals_T_355_ctr);
	wire _csignals_T_75_ctr = 32'h00005073 == _csignals_T_ctr;
	wire [1:0] _csignals_T_357_ctr = (_csignals_T_75_ctr ? 2'h3 : _csignals_T_356_ctr);
	wire _csignals_T_73_ctr = 32'h00006063 == _csignals_T_ctr;
	wire [1:0] _csignals_T_358_ctr = (_csignals_T_73_ctr ? 2'h0 : _csignals_T_357_ctr);
	wire _csignals_T_71_ctr = 32'h00004063 == _csignals_T_ctr;
	wire [1:0] _csignals_T_359_ctr = (_csignals_T_71_ctr ? 2'h0 : _csignals_T_358_ctr);
	wire _csignals_T_69_ctr = 32'h00007063 == _csignals_T_ctr;
	wire [1:0] _csignals_T_360_ctr = (_csignals_T_69_ctr ? 2'h0 : _csignals_T_359_ctr);
	wire _csignals_T_67_ctr = 32'h00005063 == _csignals_T_ctr;
	wire [1:0] _csignals_T_361_ctr = (_csignals_T_67_ctr ? 2'h0 : _csignals_T_360_ctr);
	wire _csignals_T_65_ctr = 32'h00001063 == _csignals_T_ctr;
	wire [1:0] _csignals_T_362_ctr = (_csignals_T_65_ctr ? 2'h0 : _csignals_T_361_ctr);
	wire _csignals_T_63_ctr = 32'h00000063 == _csignals_T_ctr;
	wire [1:0] _csignals_T_363_ctr = (_csignals_T_63_ctr ? 2'h0 : _csignals_T_362_ctr);
	wire _csignals_T_61_ctr = 32'h00000067 == _csignals_T_ctr;
	wire [1:0] _csignals_T_364_ctr = (_csignals_T_61_ctr ? 2'h2 : _csignals_T_363_ctr);
	wire _csignals_T_59_ctr = 32'h0000006f == _csignals_T_16_ctr;
	wire [1:0] _csignals_T_365_ctr = (_csignals_T_59_ctr ? 2'h2 : _csignals_T_364_ctr);
	wire [31:0] _csignals_T_38_ctr = io_dat_inst_ctr & 32'hfe00707f;
	wire _csignals_T_57_ctr = 32'h00005033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_366_ctr = (_csignals_T_57_ctr ? 2'h0 : _csignals_T_365_ctr);
	wire _csignals_T_55_ctr = 32'h40005033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_367_ctr = (_csignals_T_55_ctr ? 2'h0 : _csignals_T_366_ctr);
	wire _csignals_T_53_ctr = 32'h00004033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_368_ctr = (_csignals_T_53_ctr ? 2'h0 : _csignals_T_367_ctr);
	wire _csignals_T_51_ctr = 32'h00006033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_369_ctr = (_csignals_T_51_ctr ? 2'h0 : _csignals_T_368_ctr);
	wire _csignals_T_49_ctr = 32'h00007033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_370_ctr = (_csignals_T_49_ctr ? 2'h0 : _csignals_T_369_ctr);
	wire _csignals_T_47_ctr = 32'h00003033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_371_ctr = (_csignals_T_47_ctr ? 2'h0 : _csignals_T_370_ctr);
	wire _csignals_T_45_ctr = 32'h00002033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_372_ctr = (_csignals_T_45_ctr ? 2'h0 : _csignals_T_371_ctr);
	wire _csignals_T_43_ctr = 32'h40000033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_373_ctr = (_csignals_T_43_ctr ? 2'h0 : _csignals_T_372_ctr);
	wire _csignals_T_41_ctr = 32'h00000033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_374_ctr = (_csignals_T_41_ctr ? 2'h0 : _csignals_T_373_ctr);
	wire _csignals_T_39_ctr = 32'h00001033 == _csignals_T_38_ctr;
	wire [1:0] _csignals_T_375_ctr = (_csignals_T_39_ctr ? 2'h0 : _csignals_T_374_ctr);
	wire _csignals_T_37_ctr = 32'h00005013 == _csignals_T_32_ctr;
	wire [1:0] _csignals_T_376_ctr = (_csignals_T_37_ctr ? 2'h0 : _csignals_T_375_ctr);
	wire [1:0] _csignals_T_377_ctr = (_csignals_T_35_ctr ? 2'h0 : _csignals_T_376_ctr);
	wire [1:0] _csignals_T_378_ctr = (_csignals_T_33_ctr ? 2'h0 : _csignals_T_377_ctr);
	wire [1:0] _csignals_T_379_ctr = (_csignals_T_31_ctr ? 2'h0 : _csignals_T_378_ctr);
	wire [1:0] _csignals_T_380_ctr = (_csignals_T_29_ctr ? 2'h0 : _csignals_T_379_ctr);
	wire [1:0] _csignals_T_381_ctr = (_csignals_T_27_ctr ? 2'h0 : _csignals_T_380_ctr);
	wire [1:0] _csignals_T_382_ctr = (_csignals_T_25_ctr ? 2'h0 : _csignals_T_381_ctr);
	wire [1:0] _csignals_T_383_ctr = (_csignals_T_23_ctr ? 2'h0 : _csignals_T_382_ctr);
	wire [1:0] _csignals_T_384_ctr = (_csignals_T_21_ctr ? 2'h0 : _csignals_T_383_ctr);
	wire [1:0] _csignals_T_385_ctr = (_csignals_T_19_ctr ? 2'h0 : _csignals_T_384_ctr);
	wire [1:0] _csignals_T_386_ctr = (_csignals_T_17_ctr ? 2'h0 : _csignals_T_385_ctr);
	wire [1:0] _csignals_T_387_ctr = (_csignals_T_15_ctr ? 2'h0 : _csignals_T_386_ctr);
	wire [1:0] _csignals_T_388_ctr = (_csignals_T_13_ctr ? 2'h0 : _csignals_T_387_ctr);
	wire [1:0] _csignals_T_389_ctr = (_csignals_T_11_ctr ? 2'h0 : _csignals_T_388_ctr);
	wire _csignals_T_9_ctr = 32'h00005003 == _csignals_T_ctr;
	wire [1:0] _csignals_T_390_ctr = (_csignals_T_9_ctr ? 2'h1 : _csignals_T_389_ctr);
	wire _csignals_T_7_ctr = 32'h00001003 == _csignals_T_ctr;
	wire [1:0] _csignals_T_391_ctr = (_csignals_T_7_ctr ? 2'h1 : _csignals_T_390_ctr);
	wire _csignals_T_5_ctr = 32'h00004003 == _csignals_T_ctr;
	wire [1:0] _csignals_T_392_ctr = (_csignals_T_5_ctr ? 2'h1 : _csignals_T_391_ctr);
	wire _csignals_T_3_ctr = 32'h00000003 == _csignals_T_ctr;
	wire [1:0] _csignals_T_393_ctr = (_csignals_T_3_ctr ? 2'h1 : _csignals_T_392_ctr);
	assign io_ctl_wb_sel_ctr = (_csignals_T_1_ctr ? 2'h1 : _csignals_T_393_ctr);
	// Trace: core/CtlPath_2stage.v:50:3
	// Trace: core/CtlPath_2stage.v:51:3
	// Trace: core/CtlPath_2stage.v:52:3
	// Trace: core/CtlPath_2stage.v:53:3
	// Trace: core/CtlPath_2stage.v:54:3
	// Trace: core/CtlPath_2stage.v:55:3
	// Trace: core/CtlPath_2stage.v:56:3
	// Trace: core/CtlPath_2stage.v:57:3
	// Trace: core/CtlPath_2stage.v:58:3
	// Trace: core/CtlPath_2stage.v:59:3
	// Trace: core/CtlPath_2stage.v:60:3
	// Trace: core/CtlPath_2stage.v:61:3
	// Trace: core/CtlPath_2stage.v:62:3
	// Trace: core/CtlPath_2stage.v:63:3
	// Trace: core/CtlPath_2stage.v:64:3
	// Trace: core/CtlPath_2stage.v:65:3
	// Trace: core/CtlPath_2stage.v:66:3
	// Trace: core/CtlPath_2stage.v:67:3
	// Trace: core/CtlPath_2stage.v:68:3
	// Trace: core/CtlPath_2stage.v:69:3
	// Trace: core/CtlPath_2stage.v:70:3
	// Trace: core/CtlPath_2stage.v:71:3
	// Trace: core/CtlPath_2stage.v:72:3
	// Trace: core/CtlPath_2stage.v:73:3
	// Trace: core/CtlPath_2stage.v:74:3
	// Trace: core/CtlPath_2stage.v:75:3
	// Trace: core/CtlPath_2stage.v:76:3
	// Trace: core/CtlPath_2stage.v:77:3
	// Trace: core/CtlPath_2stage.v:78:3
	// Trace: core/CtlPath_2stage.v:79:3
	// Trace: core/CtlPath_2stage.v:80:3
	// Trace: core/CtlPath_2stage.v:81:3
	// Trace: core/CtlPath_2stage.v:82:3
	// Trace: core/CtlPath_2stage.v:83:3
	// Trace: core/CtlPath_2stage.v:84:3
	// Trace: core/CtlPath_2stage.v:85:3
	// Trace: core/CtlPath_2stage.v:86:3
	// Trace: core/CtlPath_2stage.v:87:3
	// Trace: core/CtlPath_2stage.v:88:3
	// Trace: core/CtlPath_2stage.v:89:3
	// Trace: core/CtlPath_2stage.v:90:3
	// Trace: core/CtlPath_2stage.v:91:3
	// Trace: core/CtlPath_2stage.v:92:3
	// Trace: core/CtlPath_2stage.v:93:3
	// Trace: core/CtlPath_2stage.v:94:3
	// Trace: core/CtlPath_2stage.v:95:3
	// Trace: core/CtlPath_2stage.v:96:3
	// Trace: core/CtlPath_2stage.v:98:3
	// Trace: core/CtlPath_2stage.v:99:3
	// Trace: core/CtlPath_2stage.v:100:3
	// Trace: core/CtlPath_2stage.v:101:3
	// Trace: core/CtlPath_2stage.v:102:3
	// Trace: core/CtlPath_2stage.v:103:3
	// Trace: core/CtlPath_2stage.v:104:3
	// Trace: core/CtlPath_2stage.v:105:3
	// Trace: core/CtlPath_2stage.v:106:3
	// Trace: core/CtlPath_2stage.v:107:3
	// Trace: core/CtlPath_2stage.v:108:3
	// Trace: core/CtlPath_2stage.v:109:3
	// Trace: core/CtlPath_2stage.v:110:3
	// Trace: core/CtlPath_2stage.v:111:3
	// Trace: core/CtlPath_2stage.v:112:3
	// Trace: core/CtlPath_2stage.v:113:3
	// Trace: core/CtlPath_2stage.v:114:3
	// Trace: core/CtlPath_2stage.v:115:3
	// Trace: core/CtlPath_2stage.v:116:3
	// Trace: core/CtlPath_2stage.v:117:3
	// Trace: core/CtlPath_2stage.v:118:3
	// Trace: core/CtlPath_2stage.v:119:3
	// Trace: core/CtlPath_2stage.v:120:3
	// Trace: core/CtlPath_2stage.v:121:3
	// Trace: core/CtlPath_2stage.v:122:3
	// Trace: core/CtlPath_2stage.v:123:3
	// Trace: core/CtlPath_2stage.v:124:3
	// Trace: core/CtlPath_2stage.v:125:3
	// Trace: core/CtlPath_2stage.v:126:3
	// Trace: core/CtlPath_2stage.v:127:3
	// Trace: core/CtlPath_2stage.v:128:3
	// Trace: core/CtlPath_2stage.v:129:3
	// Trace: core/CtlPath_2stage.v:130:3
	// Trace: core/CtlPath_2stage.v:131:3
	// Trace: core/CtlPath_2stage.v:132:3
	// Trace: core/CtlPath_2stage.v:133:3
	// Trace: core/CtlPath_2stage.v:134:3
	// Trace: core/CtlPath_2stage.v:135:3
	// Trace: core/CtlPath_2stage.v:136:3
	// Trace: core/CtlPath_2stage.v:137:3
	// Trace: core/CtlPath_2stage.v:138:3
	// Trace: core/CtlPath_2stage.v:139:3
	// Trace: core/CtlPath_2stage.v:142:3
	wire store_ctr;
	// Trace: core/CtlPath_2stage.v:143:3
	wire io_dmem_req_valid_ctr;
	// Trace: core/CtlPath_2stage.v:144:3
	wire io_dmem_req_bits_fcn_ctr;
	// Trace: core/CtlPath_2stage.v:145:3
	assign store_ctr = io_dmem_req_valid_ctr & io_dmem_req_bits_fcn_ctr;
	// Trace: core/CtlPath_2stage.v:146:3
	wire cs0_1_ctr = _csignals_T_1_ctr | (_csignals_T_3_ctr | (_csignals_T_5_ctr | (_csignals_T_7_ctr | (_csignals_T_9_ctr | (_csignals_T_11_ctr | (_csignals_T_13_ctr | _csignals_T_15_ctr))))));
	assign io_dmem_req_valid_ctr = cs0_1_ctr;
	// Trace: core/CtlPath_2stage.v:147:3
	// Trace: core/CtlPath_2stage.v:149:3
	wire _csignals_T_537_ctr = (_csignals_T_9_ctr ? 1'h0 : _csignals_T_11_ctr | (_csignals_T_13_ctr | _csignals_T_15_ctr));
	wire _csignals_T_538_ctr = (_csignals_T_7_ctr ? 1'h0 : _csignals_T_537_ctr);
	wire _csignals_T_539_ctr = (_csignals_T_5_ctr ? 1'h0 : _csignals_T_538_ctr);
	wire _csignals_T_540_ctr = (_csignals_T_3_ctr ? 1'h0 : _csignals_T_539_ctr);
	assign io_dmem_req_bits_fcn_ctr = (_csignals_T_1_ctr ? 1'h0 : _csignals_T_540_ctr);
	// Trace: core/CtlPath_2stage.v:150:3
	// Trace: core/CtlPath_2stage.v:151:3
	// Trace: core/CtlPath_2stage.v:152:3
	// Trace: core/CtlPath_2stage.v:153:3
	// Trace: core/CtlPath_2stage.v:156:3
	// combined with io_ctl_alu_fun_ctr
	// Trace: core/CtlPath_2stage.v:157:3
	// combined with io_ctl_op1_sel_ctr
	// Trace: core/CtlPath_2stage.v:158:3
	// combined with io_ctl_op2_sel_ctr
	// Trace: core/CtlPath_2stage.v:160:3
	wire [3:0] _csignals_T_303_ctr = (_csignals_T_85_ctr ? 4'hb : 4'h0);
	wire [3:0] _csignals_T_304_ctr = (_csignals_T_83_ctr ? 4'hb : _csignals_T_303_ctr);
	wire [3:0] _csignals_T_305_ctr = (_csignals_T_81_ctr ? 4'hb : _csignals_T_304_ctr);
	wire [3:0] _csignals_T_306_ctr = (_csignals_T_79_ctr ? 4'hb : _csignals_T_305_ctr);
	wire [3:0] _csignals_T_307_ctr = (_csignals_T_77_ctr ? 4'hb : _csignals_T_306_ctr);
	wire [3:0] _csignals_T_308_ctr = (_csignals_T_75_ctr ? 4'hb : _csignals_T_307_ctr);
	wire [3:0] _csignals_T_309_ctr = (_csignals_T_73_ctr ? 4'h0 : _csignals_T_308_ctr);
	wire [3:0] _csignals_T_310_ctr = (_csignals_T_71_ctr ? 4'h0 : _csignals_T_309_ctr);
	wire [3:0] _csignals_T_311_ctr = (_csignals_T_69_ctr ? 4'h0 : _csignals_T_310_ctr);
	wire [3:0] _csignals_T_312_ctr = (_csignals_T_67_ctr ? 4'h0 : _csignals_T_311_ctr);
	wire [3:0] _csignals_T_313_ctr = (_csignals_T_65_ctr ? 4'h0 : _csignals_T_312_ctr);
	wire [3:0] _csignals_T_314_ctr = (_csignals_T_63_ctr ? 4'h0 : _csignals_T_313_ctr);
	wire [3:0] _csignals_T_315_ctr = (_csignals_T_61_ctr ? 4'h0 : _csignals_T_314_ctr);
	wire [3:0] _csignals_T_316_ctr = (_csignals_T_59_ctr ? 4'h0 : _csignals_T_315_ctr);
	wire [3:0] _csignals_T_317_ctr = (_csignals_T_57_ctr ? 4'h4 : _csignals_T_316_ctr);
	wire [3:0] _csignals_T_318_ctr = (_csignals_T_55_ctr ? 4'h5 : _csignals_T_317_ctr);
	wire [3:0] _csignals_T_319_ctr = (_csignals_T_53_ctr ? 4'h8 : _csignals_T_318_ctr);
	wire [3:0] _csignals_T_320_ctr = (_csignals_T_51_ctr ? 4'h7 : _csignals_T_319_ctr);
	wire [3:0] _csignals_T_321_ctr = (_csignals_T_49_ctr ? 4'h6 : _csignals_T_320_ctr);
	wire [3:0] _csignals_T_322_ctr = (_csignals_T_47_ctr ? 4'ha : _csignals_T_321_ctr);
	wire [3:0] _csignals_T_323_ctr = (_csignals_T_45_ctr ? 4'h9 : _csignals_T_322_ctr);
	wire [3:0] _csignals_T_324_ctr = (_csignals_T_43_ctr ? 4'h2 : _csignals_T_323_ctr);
	wire [3:0] _csignals_T_325_ctr = (_csignals_T_41_ctr ? 4'h1 : _csignals_T_324_ctr);
	wire [3:0] _csignals_T_326_ctr = (_csignals_T_39_ctr ? 4'h3 : _csignals_T_325_ctr);
	wire [3:0] _csignals_T_327_ctr = (_csignals_T_37_ctr ? 4'h4 : _csignals_T_326_ctr);
	wire [3:0] _csignals_T_328_ctr = (_csignals_T_35_ctr ? 4'h5 : _csignals_T_327_ctr);
	wire [3:0] _csignals_T_329_ctr = (_csignals_T_33_ctr ? 4'h3 : _csignals_T_328_ctr);
	wire [3:0] _csignals_T_330_ctr = (_csignals_T_31_ctr ? 4'ha : _csignals_T_329_ctr);
	wire [3:0] _csignals_T_331_ctr = (_csignals_T_29_ctr ? 4'h9 : _csignals_T_330_ctr);
	wire [3:0] _csignals_T_332_ctr = (_csignals_T_27_ctr ? 4'h8 : _csignals_T_331_ctr);
	wire [3:0] _csignals_T_333_ctr = (_csignals_T_25_ctr ? 4'h7 : _csignals_T_332_ctr);
	wire [3:0] _csignals_T_334_ctr = (_csignals_T_23_ctr ? 4'h6 : _csignals_T_333_ctr);
	wire [3:0] _csignals_T_335_ctr = (_csignals_T_21_ctr ? 4'h1 : _csignals_T_334_ctr);
	wire [3:0] _csignals_T_336_ctr = (_csignals_T_19_ctr ? 4'hb : _csignals_T_335_ctr);
	wire [3:0] _csignals_T_337_ctr = (_csignals_T_17_ctr ? 4'h1 : _csignals_T_336_ctr);
	wire [3:0] _csignals_T_338_ctr = (_csignals_T_15_ctr ? 4'h1 : _csignals_T_337_ctr);
	wire [3:0] _csignals_T_339_ctr = (_csignals_T_13_ctr ? 4'h1 : _csignals_T_338_ctr);
	wire [3:0] _csignals_T_340_ctr = (_csignals_T_11_ctr ? 4'h1 : _csignals_T_339_ctr);
	wire [3:0] _csignals_T_341_ctr = (_csignals_T_9_ctr ? 4'h1 : _csignals_T_340_ctr);
	wire [3:0] _csignals_T_342_ctr = (_csignals_T_7_ctr ? 4'h1 : _csignals_T_341_ctr);
	wire [3:0] _csignals_T_343_ctr = (_csignals_T_5_ctr ? 4'h1 : _csignals_T_342_ctr);
	wire [3:0] _csignals_T_344_ctr = (_csignals_T_3_ctr ? 4'h1 : _csignals_T_343_ctr);
	wire [3:0] cs_alu_fun_ctr = (_csignals_T_1_ctr ? 4'h1 : _csignals_T_344_ctr);
	assign io_ctl_alu_fun_ctr = {1'd0, cs_alu_fun_ctr};
	// Trace: core/CtlPath_2stage.v:161:3
	// Trace: core/CtlPath_2stage.v:162:3
	// Trace: core/CtlPath_2stage.v:163:3
	// Trace: core/CtlPath_2stage.v:164:3
	// Trace: core/CtlPath_2stage.v:165:3
	// Trace: core/CtlPath_2stage.v:166:3
	// Trace: core/CtlPath_2stage.v:167:3
	// Trace: core/CtlPath_2stage.v:168:3
	// Trace: core/CtlPath_2stage.v:169:3
	// Trace: core/CtlPath_2stage.v:170:3
	// Trace: core/CtlPath_2stage.v:171:3
	// Trace: core/CtlPath_2stage.v:172:3
	// Trace: core/CtlPath_2stage.v:173:3
	// Trace: core/CtlPath_2stage.v:174:3
	// Trace: core/CtlPath_2stage.v:175:3
	// Trace: core/CtlPath_2stage.v:176:3
	// Trace: core/CtlPath_2stage.v:177:3
	// Trace: core/CtlPath_2stage.v:178:3
	// Trace: core/CtlPath_2stage.v:179:3
	// Trace: core/CtlPath_2stage.v:180:3
	// Trace: core/CtlPath_2stage.v:181:3
	// Trace: core/CtlPath_2stage.v:182:3
	// Trace: core/CtlPath_2stage.v:183:3
	// Trace: core/CtlPath_2stage.v:184:3
	// Trace: core/CtlPath_2stage.v:185:3
	// Trace: core/CtlPath_2stage.v:186:3
	// Trace: core/CtlPath_2stage.v:187:3
	// Trace: core/CtlPath_2stage.v:188:3
	// Trace: core/CtlPath_2stage.v:189:3
	// Trace: core/CtlPath_2stage.v:190:3
	// Trace: core/CtlPath_2stage.v:191:3
	// Trace: core/CtlPath_2stage.v:192:3
	// Trace: core/CtlPath_2stage.v:193:3
	// Trace: core/CtlPath_2stage.v:194:3
	// Trace: core/CtlPath_2stage.v:195:3
	// Trace: core/CtlPath_2stage.v:196:3
	// Trace: core/CtlPath_2stage.v:197:3
	// Trace: core/CtlPath_2stage.v:198:3
	// Trace: core/CtlPath_2stage.v:199:3
	// Trace: core/CtlPath_2stage.v:200:3
	// Trace: core/CtlPath_2stage.v:201:3
	// Trace: core/CtlPath_2stage.v:202:3
	// Trace: core/CtlPath_2stage.v:203:3
	// Trace: core/CtlPath_2stage.v:205:3
	wire [1:0] _csignals_T_205_ctr = (_csignals_T_85_ctr ? 2'h2 : 2'h0);
	wire [1:0] _csignals_T_206_ctr = (_csignals_T_83_ctr ? 2'h0 : _csignals_T_205_ctr);
	wire [1:0] _csignals_T_207_ctr = (_csignals_T_81_ctr ? 2'h0 : _csignals_T_206_ctr);
	wire [1:0] _csignals_T_208_ctr = (_csignals_T_79_ctr ? 2'h0 : _csignals_T_207_ctr);
	wire [1:0] _csignals_T_209_ctr = (_csignals_T_77_ctr ? 2'h2 : _csignals_T_208_ctr);
	wire [1:0] _csignals_T_210_ctr = (_csignals_T_75_ctr ? 2'h2 : _csignals_T_209_ctr);
	wire [1:0] _csignals_T_211_ctr = (_csignals_T_73_ctr ? 2'h0 : _csignals_T_210_ctr);
	wire [1:0] _csignals_T_212_ctr = (_csignals_T_71_ctr ? 2'h0 : _csignals_T_211_ctr);
	wire [1:0] _csignals_T_213_ctr = (_csignals_T_69_ctr ? 2'h0 : _csignals_T_212_ctr);
	wire [1:0] _csignals_T_214_ctr = (_csignals_T_67_ctr ? 2'h0 : _csignals_T_213_ctr);
	wire [1:0] _csignals_T_215_ctr = (_csignals_T_65_ctr ? 2'h0 : _csignals_T_214_ctr);
	wire [1:0] _csignals_T_216_ctr = (_csignals_T_63_ctr ? 2'h0 : _csignals_T_215_ctr);
	wire [1:0] _csignals_T_217_ctr = (_csignals_T_61_ctr ? 2'h0 : _csignals_T_216_ctr);
	wire [1:0] _csignals_T_218_ctr = (_csignals_T_59_ctr ? 2'h0 : _csignals_T_217_ctr);
	wire [1:0] _csignals_T_219_ctr = (_csignals_T_57_ctr ? 2'h0 : _csignals_T_218_ctr);
	wire [1:0] _csignals_T_220_ctr = (_csignals_T_55_ctr ? 2'h0 : _csignals_T_219_ctr);
	wire [1:0] _csignals_T_221_ctr = (_csignals_T_53_ctr ? 2'h0 : _csignals_T_220_ctr);
	wire [1:0] _csignals_T_222_ctr = (_csignals_T_51_ctr ? 2'h0 : _csignals_T_221_ctr);
	wire [1:0] _csignals_T_223_ctr = (_csignals_T_49_ctr ? 2'h0 : _csignals_T_222_ctr);
	wire [1:0] _csignals_T_224_ctr = (_csignals_T_47_ctr ? 2'h0 : _csignals_T_223_ctr);
	wire [1:0] _csignals_T_225_ctr = (_csignals_T_45_ctr ? 2'h0 : _csignals_T_224_ctr);
	wire [1:0] _csignals_T_226_ctr = (_csignals_T_43_ctr ? 2'h0 : _csignals_T_225_ctr);
	wire [1:0] _csignals_T_227_ctr = (_csignals_T_41_ctr ? 2'h0 : _csignals_T_226_ctr);
	wire [1:0] _csignals_T_228_ctr = (_csignals_T_39_ctr ? 2'h0 : _csignals_T_227_ctr);
	wire [1:0] _csignals_T_229_ctr = (_csignals_T_37_ctr ? 2'h0 : _csignals_T_228_ctr);
	wire [1:0] _csignals_T_230_ctr = (_csignals_T_35_ctr ? 2'h0 : _csignals_T_229_ctr);
	wire [1:0] _csignals_T_231_ctr = (_csignals_T_33_ctr ? 2'h0 : _csignals_T_230_ctr);
	wire [1:0] _csignals_T_232_ctr = (_csignals_T_31_ctr ? 2'h0 : _csignals_T_231_ctr);
	wire [1:0] _csignals_T_233_ctr = (_csignals_T_29_ctr ? 2'h0 : _csignals_T_232_ctr);
	wire [1:0] _csignals_T_234_ctr = (_csignals_T_27_ctr ? 2'h0 : _csignals_T_233_ctr);
	wire [1:0] _csignals_T_235_ctr = (_csignals_T_25_ctr ? 2'h0 : _csignals_T_234_ctr);
	wire [1:0] _csignals_T_236_ctr = (_csignals_T_23_ctr ? 2'h0 : _csignals_T_235_ctr);
	wire [1:0] _csignals_T_237_ctr = (_csignals_T_21_ctr ? 2'h0 : _csignals_T_236_ctr);
	wire [1:0] _csignals_T_238_ctr = (_csignals_T_19_ctr ? 2'h1 : _csignals_T_237_ctr);
	wire [1:0] _csignals_T_239_ctr = (_csignals_T_17_ctr ? 2'h1 : _csignals_T_238_ctr);
	wire [1:0] _csignals_T_240_ctr = (_csignals_T_15_ctr ? 2'h0 : _csignals_T_239_ctr);
	wire [1:0] _csignals_T_241_ctr = (_csignals_T_13_ctr ? 2'h0 : _csignals_T_240_ctr);
	wire [1:0] _csignals_T_242_ctr = (_csignals_T_11_ctr ? 2'h0 : _csignals_T_241_ctr);
	wire [1:0] _csignals_T_243_ctr = (_csignals_T_9_ctr ? 2'h0 : _csignals_T_242_ctr);
	wire [1:0] _csignals_T_244_ctr = (_csignals_T_7_ctr ? 2'h0 : _csignals_T_243_ctr);
	wire [1:0] _csignals_T_245_ctr = (_csignals_T_5_ctr ? 2'h0 : _csignals_T_244_ctr);
	wire [1:0] _csignals_T_246_ctr = (_csignals_T_3_ctr ? 2'h0 : _csignals_T_245_ctr);
	assign io_ctl_op1_sel_ctr = (_csignals_T_1_ctr ? 2'h0 : _csignals_T_246_ctr);
	// Trace: core/CtlPath_2stage.v:206:3
	wire [2:0] _csignals_T_266_ctr = (_csignals_T_61_ctr ? 3'h2 : 3'h0);
	wire [2:0] _csignals_T_267_ctr = (_csignals_T_59_ctr ? 3'h0 : _csignals_T_266_ctr);
	wire [2:0] _csignals_T_268_ctr = (_csignals_T_57_ctr ? 3'h0 : _csignals_T_267_ctr);
	wire [2:0] _csignals_T_269_ctr = (_csignals_T_55_ctr ? 3'h0 : _csignals_T_268_ctr);
	wire [2:0] _csignals_T_270_ctr = (_csignals_T_53_ctr ? 3'h0 : _csignals_T_269_ctr);
	wire [2:0] _csignals_T_271_ctr = (_csignals_T_51_ctr ? 3'h0 : _csignals_T_270_ctr);
	wire [2:0] _csignals_T_272_ctr = (_csignals_T_49_ctr ? 3'h0 : _csignals_T_271_ctr);
	wire [2:0] _csignals_T_273_ctr = (_csignals_T_47_ctr ? 3'h0 : _csignals_T_272_ctr);
	wire [2:0] _csignals_T_274_ctr = (_csignals_T_45_ctr ? 3'h0 : _csignals_T_273_ctr);
	wire [2:0] _csignals_T_275_ctr = (_csignals_T_43_ctr ? 3'h0 : _csignals_T_274_ctr);
	wire [2:0] _csignals_T_276_ctr = (_csignals_T_41_ctr ? 3'h0 : _csignals_T_275_ctr);
	wire [2:0] _csignals_T_277_ctr = (_csignals_T_39_ctr ? 3'h0 : _csignals_T_276_ctr);
	wire [2:0] _csignals_T_278_ctr = (_csignals_T_37_ctr ? 3'h2 : _csignals_T_277_ctr);
	wire [2:0] _csignals_T_279_ctr = (_csignals_T_35_ctr ? 3'h2 : _csignals_T_278_ctr);
	wire [2:0] _csignals_T_280_ctr = (_csignals_T_33_ctr ? 3'h2 : _csignals_T_279_ctr);
	wire [2:0] _csignals_T_281_ctr = (_csignals_T_31_ctr ? 3'h2 : _csignals_T_280_ctr);
	wire [2:0] _csignals_T_282_ctr = (_csignals_T_29_ctr ? 3'h2 : _csignals_T_281_ctr);
	wire [2:0] _csignals_T_283_ctr = (_csignals_T_27_ctr ? 3'h2 : _csignals_T_282_ctr);
	wire [2:0] _csignals_T_284_ctr = (_csignals_T_25_ctr ? 3'h2 : _csignals_T_283_ctr);
	wire [2:0] _csignals_T_285_ctr = (_csignals_T_23_ctr ? 3'h2 : _csignals_T_284_ctr);
	wire [2:0] _csignals_T_286_ctr = (_csignals_T_21_ctr ? 3'h2 : _csignals_T_285_ctr);
	wire [2:0] _csignals_T_287_ctr = (_csignals_T_19_ctr ? 3'h0 : _csignals_T_286_ctr);
	wire [2:0] _csignals_T_288_ctr = (_csignals_T_17_ctr ? 3'h1 : _csignals_T_287_ctr);
	wire [2:0] _csignals_T_289_ctr = (_csignals_T_15_ctr ? 3'h3 : _csignals_T_288_ctr);
	wire [2:0] _csignals_T_290_ctr = (_csignals_T_13_ctr ? 3'h3 : _csignals_T_289_ctr);
	wire [2:0] _csignals_T_291_ctr = (_csignals_T_11_ctr ? 3'h3 : _csignals_T_290_ctr);
	wire [2:0] _csignals_T_292_ctr = (_csignals_T_9_ctr ? 3'h2 : _csignals_T_291_ctr);
	wire [2:0] _csignals_T_293_ctr = (_csignals_T_7_ctr ? 3'h2 : _csignals_T_292_ctr);
	wire [2:0] _csignals_T_294_ctr = (_csignals_T_5_ctr ? 3'h2 : _csignals_T_293_ctr);
	wire [2:0] _csignals_T_295_ctr = (_csignals_T_3_ctr ? 3'h2 : _csignals_T_294_ctr);
	assign io_ctl_op2_sel_ctr = (_csignals_T_1_ctr ? 3'h2 : _csignals_T_295_ctr);
	// Trace: core/CtlPath_2stage.v:208:3
	// Trace: core/CtlPath_2stage.v:209:3
	// Trace: core/CtlPath_2stage.v:210:3
	// Trace: core/CtlPath_2stage.v:211:3
	// Trace: core/CtlPath_2stage.v:212:3
	// Trace: core/CtlPath_2stage.v:213:3
	// Trace: core/CtlPath_2stage.v:214:3
	// Trace: core/CtlPath_2stage.v:215:3
	// Trace: core/CtlPath_2stage.v:216:3
	// Trace: core/CtlPath_2stage.v:217:3
	// Trace: core/CtlPath_2stage.v:218:3
	// Trace: core/CtlPath_2stage.v:219:3
	// Trace: core/CtlPath_2stage.v:220:3
	// Trace: core/CtlPath_2stage.v:221:3
	// Trace: core/CtlPath_2stage.v:222:3
	// Trace: core/CtlPath_2stage.v:223:3
	// Trace: core/CtlPath_2stage.v:224:3
	// Trace: core/CtlPath_2stage.v:225:3
	// Trace: core/CtlPath_2stage.v:226:3
	// Trace: core/CtlPath_2stage.v:227:3
	// Trace: core/CtlPath_2stage.v:228:3
	// Trace: core/CtlPath_2stage.v:229:3
	// Trace: core/CtlPath_2stage.v:230:3
	// Trace: core/CtlPath_2stage.v:231:3
	// Trace: core/CtlPath_2stage.v:232:3
	// Trace: core/CtlPath_2stage.v:233:3
	// Trace: core/CtlPath_2stage.v:234:3
	// Trace: core/CtlPath_2stage.v:235:3
	// Trace: core/CtlPath_2stage.v:236:3
	// Trace: core/CtlPath_2stage.v:237:3
	// Trace: core/CtlPath_2stage.v:238:3
	// Trace: core/CtlPath_2stage.v:239:3
	// Trace: core/CtlPath_2stage.v:240:3
	// Trace: core/CtlPath_2stage.v:241:3
	// Trace: core/CtlPath_2stage.v:242:3
	// Trace: core/CtlPath_2stage.v:243:3
	// Trace: core/CtlPath_2stage.v:244:3
	// Trace: core/CtlPath_2stage.v:245:3
	// Trace: core/CtlPath_2stage.v:246:3
	// Trace: core/CtlPath_2stage.v:247:3
	// Trace: core/CtlPath_2stage.v:248:3
	// Trace: core/CtlPath_2stage.v:249:3
	// Trace: core/CtlPath_2stage.v:250:3
	// Trace: core/CtlPath_2stage.v:251:3
	// Trace: core/CtlPath_2stage.v:252:3
	// Trace: core/CtlPath_2stage.v:253:3
	// Trace: core/CtlPath_2stage.v:254:3
	// Trace: core/CtlPath_2stage.v:255:3
	// Trace: core/CtlPath_2stage.v:256:3
	// Trace: core/CtlPath_2stage.v:257:3
	// Trace: core/CtlPath_2stage.v:258:3
	// Trace: core/CtlPath_2stage.v:259:3
	// Trace: core/CtlPath_2stage.v:260:3
	// Trace: core/CtlPath_2stage.v:261:3
	// Trace: core/CtlPath_2stage.v:262:3
	// Trace: core/CtlPath_2stage.v:263:3
	// Trace: core/CtlPath_2stage.v:264:3
	// Trace: core/CtlPath_2stage.v:265:3
	// Trace: core/CtlPath_2stage.v:266:3
	// Trace: core/CtlPath_2stage.v:267:3
	// Trace: core/CtlPath_2stage.v:268:3
	// Trace: core/CtlPath_2stage.v:269:3
	// Trace: core/CtlPath_2stage.v:270:3
	// Trace: core/CtlPath_2stage.v:271:3
	// Trace: core/CtlPath_2stage.v:272:3
	// Trace: core/CtlPath_2stage.v:273:3
	// Trace: core/CtlPath_2stage.v:274:3
	// Trace: core/CtlPath_2stage.v:275:3
	// Trace: core/CtlPath_2stage.v:276:3
	// Trace: core/CtlPath_2stage.v:277:3
	// Trace: core/CtlPath_2stage.v:278:3
	// Trace: core/CtlPath_2stage.v:279:3
	// Trace: core/CtlPath_2stage.v:282:3
	wire [3:0] _csignals_T_162_ctr = (_csignals_T_73_ctr ? 4'h6 : 4'h0);
	// Trace: core/CtlPath_2stage.v:283:3
	wire [3:0] _csignals_T_163_ctr = (_csignals_T_71_ctr ? 4'h5 : _csignals_T_162_ctr);
	// Trace: core/CtlPath_2stage.v:284:3
	wire [3:0] _csignals_T_164_ctr = (_csignals_T_69_ctr ? 4'h4 : _csignals_T_163_ctr);
	// Trace: core/CtlPath_2stage.v:285:3
	wire [3:0] _csignals_T_165_ctr = (_csignals_T_67_ctr ? 4'h3 : _csignals_T_164_ctr);
	// Trace: core/CtlPath_2stage.v:286:3
	wire [3:0] _csignals_T_166_ctr = (_csignals_T_65_ctr ? 4'h1 : _csignals_T_165_ctr);
	// Trace: core/CtlPath_2stage.v:287:3
	wire [3:0] _csignals_T_167_ctr = (_csignals_T_63_ctr ? 4'h2 : _csignals_T_166_ctr);
	// Trace: core/CtlPath_2stage.v:288:3
	wire [3:0] _csignals_T_168_ctr = (_csignals_T_61_ctr ? 4'h8 : _csignals_T_167_ctr);
	// Trace: core/CtlPath_2stage.v:289:3
	wire [3:0] _csignals_T_169_ctr = (_csignals_T_59_ctr ? 4'h7 : _csignals_T_168_ctr);
	// Trace: core/CtlPath_2stage.v:290:3
	wire [3:0] _csignals_T_170_ctr = (_csignals_T_57_ctr ? 4'h0 : _csignals_T_169_ctr);
	// Trace: core/CtlPath_2stage.v:291:3
	wire [3:0] _csignals_T_171_ctr = (_csignals_T_55_ctr ? 4'h0 : _csignals_T_170_ctr);
	// Trace: core/CtlPath_2stage.v:292:3
	wire [3:0] _csignals_T_172_ctr = (_csignals_T_53_ctr ? 4'h0 : _csignals_T_171_ctr);
	// Trace: core/CtlPath_2stage.v:293:3
	wire [3:0] _csignals_T_173_ctr = (_csignals_T_51_ctr ? 4'h0 : _csignals_T_172_ctr);
	// Trace: core/CtlPath_2stage.v:294:3
	wire [3:0] _csignals_T_174_ctr = (_csignals_T_49_ctr ? 4'h0 : _csignals_T_173_ctr);
	// Trace: core/CtlPath_2stage.v:295:3
	wire [3:0] _csignals_T_175_ctr = (_csignals_T_47_ctr ? 4'h0 : _csignals_T_174_ctr);
	// Trace: core/CtlPath_2stage.v:296:3
	wire [3:0] _csignals_T_176_ctr = (_csignals_T_45_ctr ? 4'h0 : _csignals_T_175_ctr);
	// Trace: core/CtlPath_2stage.v:297:3
	wire [3:0] _csignals_T_177_ctr = (_csignals_T_43_ctr ? 4'h0 : _csignals_T_176_ctr);
	// Trace: core/CtlPath_2stage.v:298:3
	wire [3:0] _csignals_T_178_ctr = (_csignals_T_41_ctr ? 4'h0 : _csignals_T_177_ctr);
	// Trace: core/CtlPath_2stage.v:299:3
	wire [3:0] _csignals_T_179_ctr = (_csignals_T_39_ctr ? 4'h0 : _csignals_T_178_ctr);
	// Trace: core/CtlPath_2stage.v:300:3
	wire [3:0] _csignals_T_180_ctr = (_csignals_T_37_ctr ? 4'h0 : _csignals_T_179_ctr);
	// Trace: core/CtlPath_2stage.v:301:3
	wire [3:0] _csignals_T_181_ctr = (_csignals_T_35_ctr ? 4'h0 : _csignals_T_180_ctr);
	// Trace: core/CtlPath_2stage.v:302:3
	wire [3:0] _csignals_T_182_ctr = (_csignals_T_33_ctr ? 4'h0 : _csignals_T_181_ctr);
	// Trace: core/CtlPath_2stage.v:303:3
	wire [3:0] _csignals_T_183_ctr = (_csignals_T_31_ctr ? 4'h0 : _csignals_T_182_ctr);
	// Trace: core/CtlPath_2stage.v:304:3
	wire [3:0] _csignals_T_184_ctr = (_csignals_T_29_ctr ? 4'h0 : _csignals_T_183_ctr);
	// Trace: core/CtlPath_2stage.v:305:3
	wire [3:0] _csignals_T_185_ctr = (_csignals_T_27_ctr ? 4'h0 : _csignals_T_184_ctr);
	// Trace: core/CtlPath_2stage.v:306:3
	wire [3:0] _csignals_T_186_ctr = (_csignals_T_25_ctr ? 4'h0 : _csignals_T_185_ctr);
	// Trace: core/CtlPath_2stage.v:307:3
	wire [3:0] _csignals_T_187_ctr = (_csignals_T_23_ctr ? 4'h0 : _csignals_T_186_ctr);
	// Trace: core/CtlPath_2stage.v:308:3
	wire [3:0] _csignals_T_188_ctr = (_csignals_T_21_ctr ? 4'h0 : _csignals_T_187_ctr);
	// Trace: core/CtlPath_2stage.v:309:3
	wire [3:0] _csignals_T_189_ctr = (_csignals_T_19_ctr ? 4'h0 : _csignals_T_188_ctr);
	// Trace: core/CtlPath_2stage.v:310:3
	wire [3:0] _csignals_T_190_ctr = (_csignals_T_17_ctr ? 4'h0 : _csignals_T_189_ctr);
	// Trace: core/CtlPath_2stage.v:311:3
	wire [3:0] _csignals_T_191_ctr = (_csignals_T_15_ctr ? 4'h0 : _csignals_T_190_ctr);
	// Trace: core/CtlPath_2stage.v:312:3
	wire [3:0] _csignals_T_192_ctr = (_csignals_T_13_ctr ? 4'h0 : _csignals_T_191_ctr);
	// Trace: core/CtlPath_2stage.v:313:3
	wire [3:0] _csignals_T_193_ctr = (_csignals_T_11_ctr ? 4'h0 : _csignals_T_192_ctr);
	// Trace: core/CtlPath_2stage.v:314:3
	wire [3:0] _csignals_T_194_ctr = (_csignals_T_9_ctr ? 4'h0 : _csignals_T_193_ctr);
	// Trace: core/CtlPath_2stage.v:315:3
	wire [3:0] _csignals_T_195_ctr = (_csignals_T_7_ctr ? 4'h0 : _csignals_T_194_ctr);
	// Trace: core/CtlPath_2stage.v:316:3
	wire [3:0] _csignals_T_196_ctr = (_csignals_T_5_ctr ? 4'h0 : _csignals_T_195_ctr);
	// Trace: core/CtlPath_2stage.v:317:3
	wire [3:0] _csignals_T_197_ctr = (_csignals_T_3_ctr ? 4'h0 : _csignals_T_196_ctr);
	// Trace: core/CtlPath_2stage.v:318:3
	wire [3:0] cs_br_type_ctr = (_csignals_T_1_ctr ? 4'h0 : _csignals_T_197_ctr);
	// Trace: core/CtlPath_2stage.v:320:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_3_ctr = (~io_dat_br_eq_ctr ? 3'h1 : 3'h0);
	// Trace: core/CtlPath_2stage.v:321:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_5_ctr = (io_dat_br_eq_ctr ? 3'h1 : 3'h0);
	// Trace: core/CtlPath_2stage.v:322:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_8_ctr = (~io_dat_br_lt_ctr ? 3'h1 : 3'h0);
	// Trace: core/CtlPath_2stage.v:323:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_11_ctr = (~io_dat_br_ltu_ctr ? 3'h1 : 3'h0);
	// Trace: core/CtlPath_2stage.v:324:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_13_ctr = (io_dat_br_lt_ctr ? 3'h1 : 3'h0);
	// Trace: core/CtlPath_2stage.v:325:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_15_ctr = (io_dat_br_ltu_ctr ? 3'h1 : 3'h0);
	// Trace: core/CtlPath_2stage.v:326:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_18_ctr = (cs_br_type_ctr == 4'h8 ? 3'h3 : 3'h0);
	// Trace: core/CtlPath_2stage.v:327:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_19_ctr = (cs_br_type_ctr == 4'h7 ? 3'h2 : _ctrl_pc_sel_no_xept_T_18_ctr);
	// Trace: core/CtlPath_2stage.v:328:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_20_ctr = (cs_br_type_ctr == 4'h6 ? _ctrl_pc_sel_no_xept_T_15_ctr : _ctrl_pc_sel_no_xept_T_19_ctr);
	// Trace: core/CtlPath_2stage.v:329:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_21_ctr = (cs_br_type_ctr == 4'h5 ? _ctrl_pc_sel_no_xept_T_13_ctr : _ctrl_pc_sel_no_xept_T_20_ctr);
	// Trace: core/CtlPath_2stage.v:330:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_22_ctr = (cs_br_type_ctr == 4'h4 ? _ctrl_pc_sel_no_xept_T_11_ctr : _ctrl_pc_sel_no_xept_T_21_ctr);
	// Trace: core/CtlPath_2stage.v:331:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_23_ctr = (cs_br_type_ctr == 4'h3 ? _ctrl_pc_sel_no_xept_T_8_ctr : _ctrl_pc_sel_no_xept_T_22_ctr);
	// Trace: core/CtlPath_2stage.v:332:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_24_ctr = (cs_br_type_ctr == 4'h2 ? _ctrl_pc_sel_no_xept_T_5_ctr : _ctrl_pc_sel_no_xept_T_23_ctr);
	// Trace: core/CtlPath_2stage.v:333:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_25_ctr = (cs_br_type_ctr == 4'h1 ? _ctrl_pc_sel_no_xept_T_3_ctr : _ctrl_pc_sel_no_xept_T_24_ctr);
	// Trace: core/CtlPath_2stage.v:334:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_26_ctr = (cs_br_type_ctr == 4'h0 ? 3'h0 : _ctrl_pc_sel_no_xept_T_25_ctr);
	// Trace: core/CtlPath_2stage.v:335:3
	wire [2:0] ctrl_pc_sel_ctr = _ctrl_pc_sel_no_xept_T_26_ctr;
	// Trace: core/CtlPath_2stage.v:337:3
	wire branch_inst = ((((_csignals_T_63_ctr | _csignals_T_65_ctr) | _csignals_T_67_ctr) | _csignals_T_69_ctr) | _csignals_T_71_ctr) | _csignals_T_73_ctr;
	// Trace: core/CtlPath_2stage.v:338:3
	// Trace: core/CtlPath_2stage.v:339:3
	// Trace: core/CtlPath_2stage.v:340:3
	// Trace: core/CtlPath_2stage.v:341:3
	// Trace: core/CtlPath_2stage.v:342:3
	// Trace: core/CtlPath_2stage.v:343:3
	// Trace: core/CtlPath_2stage.v:344:3
	wire branch_taken = ctrl_pc_sel_ctr == 3'h1;
	// Trace: core/CtlPath_2stage.v:346:3
	wire [31:0] _csignals_T = io_dat_inst & 32'h0000707f;
	wire _csignals_T_63 = 32'h00000063 == _csignals_T;
	wire _csignals_T_65 = 32'h00001063 == _csignals_T;
	wire _csignals_T_67 = 32'h00005063 == _csignals_T;
	wire _csignals_T_69 = 32'h00007063 == _csignals_T;
	wire _csignals_T_71 = 32'h00004063 == _csignals_T;
	wire _csignals_T_73 = 32'h00006063 == _csignals_T;
	wire branch_inst_exe = ((((_csignals_T_63 | _csignals_T_65) | _csignals_T_67) | _csignals_T_69) | _csignals_T_71) | _csignals_T_73;
	// Trace: core/CtlPath_2stage.v:347:3
	wire [2:0] _ctrl_pc_sel_no_xept_T_11 = (~io_dat_br_ltu ? 3'h1 : 3'h0);
	wire [2:0] _ctrl_pc_sel_no_xept_T_13 = (io_dat_br_lt ? 3'h1 : 3'h0);
	wire [2:0] _ctrl_pc_sel_no_xept_T_15 = (io_dat_br_ltu ? 3'h1 : 3'h0);
	wire _csignals_T_1 = 32'h00002003 == _csignals_T;
	wire _csignals_T_11 = 32'h00002023 == _csignals_T;
	wire _csignals_T_13 = 32'h00000023 == _csignals_T;
	wire _csignals_T_15 = 32'h00001023 == _csignals_T;
	wire [31:0] _csignals_T_16 = io_dat_inst & 32'h0000007f;
	wire _csignals_T_17 = 32'h00000017 == _csignals_T_16;
	wire [3:0] _csignals_T_162 = (_csignals_T_73 ? 4'h6 : 4'h0);
	wire [3:0] _csignals_T_163 = (_csignals_T_71 ? 4'h5 : _csignals_T_162);
	wire [3:0] _csignals_T_164 = (_csignals_T_69 ? 4'h4 : _csignals_T_163);
	wire [3:0] _csignals_T_165 = (_csignals_T_67 ? 4'h3 : _csignals_T_164);
	wire [3:0] _csignals_T_166 = (_csignals_T_65 ? 4'h1 : _csignals_T_165);
	wire [3:0] _csignals_T_167 = (_csignals_T_63 ? 4'h2 : _csignals_T_166);
	wire _csignals_T_61 = 32'h00000067 == _csignals_T;
	wire [3:0] _csignals_T_168 = (_csignals_T_61 ? 4'h8 : _csignals_T_167);
	wire _csignals_T_59 = 32'h0000006f == _csignals_T_16;
	wire [3:0] _csignals_T_169 = (_csignals_T_59 ? 4'h7 : _csignals_T_168);
	wire [31:0] _csignals_T_38 = io_dat_inst & 32'hfe00707f;
	wire _csignals_T_57 = 32'h00005033 == _csignals_T_38;
	wire [3:0] _csignals_T_170 = (_csignals_T_57 ? 4'h0 : _csignals_T_169);
	wire _csignals_T_55 = 32'h40005033 == _csignals_T_38;
	wire [3:0] _csignals_T_171 = (_csignals_T_55 ? 4'h0 : _csignals_T_170);
	wire _csignals_T_53 = 32'h00004033 == _csignals_T_38;
	wire [3:0] _csignals_T_172 = (_csignals_T_53 ? 4'h0 : _csignals_T_171);
	wire _csignals_T_51 = 32'h00006033 == _csignals_T_38;
	wire [3:0] _csignals_T_173 = (_csignals_T_51 ? 4'h0 : _csignals_T_172);
	wire _csignals_T_49 = 32'h00007033 == _csignals_T_38;
	wire [3:0] _csignals_T_174 = (_csignals_T_49 ? 4'h0 : _csignals_T_173);
	wire _csignals_T_47 = 32'h00003033 == _csignals_T_38;
	wire [3:0] _csignals_T_175 = (_csignals_T_47 ? 4'h0 : _csignals_T_174);
	wire _csignals_T_45 = 32'h00002033 == _csignals_T_38;
	wire [3:0] _csignals_T_176 = (_csignals_T_45 ? 4'h0 : _csignals_T_175);
	wire _csignals_T_43 = 32'h40000033 == _csignals_T_38;
	wire [3:0] _csignals_T_177 = (_csignals_T_43 ? 4'h0 : _csignals_T_176);
	wire _csignals_T_41 = 32'h00000033 == _csignals_T_38;
	wire [3:0] _csignals_T_178 = (_csignals_T_41 ? 4'h0 : _csignals_T_177);
	wire _csignals_T_39 = 32'h00001033 == _csignals_T_38;
	wire [3:0] _csignals_T_179 = (_csignals_T_39 ? 4'h0 : _csignals_T_178);
	wire [31:0] _csignals_T_32 = io_dat_inst & 32'hfc00707f;
	wire _csignals_T_37 = 32'h00005013 == _csignals_T_32;
	wire [3:0] _csignals_T_180 = (_csignals_T_37 ? 4'h0 : _csignals_T_179);
	wire _csignals_T_35 = 32'h40005013 == _csignals_T_32;
	wire [3:0] _csignals_T_181 = (_csignals_T_35 ? 4'h0 : _csignals_T_180);
	wire _csignals_T_33 = 32'h00001013 == _csignals_T_32;
	wire [3:0] _csignals_T_182 = (_csignals_T_33 ? 4'h0 : _csignals_T_181);
	wire _csignals_T_31 = 32'h00003013 == _csignals_T;
	wire [3:0] _csignals_T_183 = (_csignals_T_31 ? 4'h0 : _csignals_T_182);
	wire _csignals_T_29 = 32'h00002013 == _csignals_T;
	wire [3:0] _csignals_T_184 = (_csignals_T_29 ? 4'h0 : _csignals_T_183);
	wire _csignals_T_27 = 32'h00004013 == _csignals_T;
	wire [3:0] _csignals_T_185 = (_csignals_T_27 ? 4'h0 : _csignals_T_184);
	wire _csignals_T_25 = 32'h00006013 == _csignals_T;
	wire [3:0] _csignals_T_186 = (_csignals_T_25 ? 4'h0 : _csignals_T_185);
	wire _csignals_T_23 = 32'h00007013 == _csignals_T;
	wire [3:0] _csignals_T_187 = (_csignals_T_23 ? 4'h0 : _csignals_T_186);
	wire _csignals_T_21 = 32'h00000013 == _csignals_T;
	wire [3:0] _csignals_T_188 = (_csignals_T_21 ? 4'h0 : _csignals_T_187);
	wire _csignals_T_19 = 32'h00000037 == _csignals_T_16;
	wire [3:0] _csignals_T_189 = (_csignals_T_19 ? 4'h0 : _csignals_T_188);
	wire [3:0] _csignals_T_190 = (_csignals_T_17 ? 4'h0 : _csignals_T_189);
	wire [3:0] _csignals_T_191 = (_csignals_T_15 ? 4'h0 : _csignals_T_190);
	wire [3:0] _csignals_T_192 = (_csignals_T_13 ? 4'h0 : _csignals_T_191);
	wire [3:0] _csignals_T_193 = (_csignals_T_11 ? 4'h0 : _csignals_T_192);
	wire _csignals_T_9 = 32'h00005003 == _csignals_T;
	wire [3:0] _csignals_T_194 = (_csignals_T_9 ? 4'h0 : _csignals_T_193);
	wire _csignals_T_7 = 32'h00001003 == _csignals_T;
	wire [3:0] _csignals_T_195 = (_csignals_T_7 ? 4'h0 : _csignals_T_194);
	wire _csignals_T_5 = 32'h00004003 == _csignals_T;
	wire [3:0] _csignals_T_196 = (_csignals_T_5 ? 4'h0 : _csignals_T_195);
	wire _csignals_T_3 = 32'h00000003 == _csignals_T;
	wire [3:0] _csignals_T_197 = (_csignals_T_3 ? 4'h0 : _csignals_T_196);
	wire [3:0] cs_br_type = (_csignals_T_1 ? 4'h0 : _csignals_T_197);
	wire [2:0] _ctrl_pc_sel_no_xept_T_18 = (cs_br_type == 4'h8 ? 3'h3 : 3'h0);
	wire [2:0] _ctrl_pc_sel_no_xept_T_19 = (cs_br_type == 4'h7 ? 3'h2 : _ctrl_pc_sel_no_xept_T_18);
	wire [2:0] _ctrl_pc_sel_no_xept_T_20 = (cs_br_type == 4'h6 ? _ctrl_pc_sel_no_xept_T_15 : _ctrl_pc_sel_no_xept_T_19);
	wire [2:0] _ctrl_pc_sel_no_xept_T_21 = (cs_br_type == 4'h5 ? _ctrl_pc_sel_no_xept_T_13 : _ctrl_pc_sel_no_xept_T_20);
	wire [2:0] _ctrl_pc_sel_no_xept_T_22 = (cs_br_type == 4'h4 ? _ctrl_pc_sel_no_xept_T_11 : _ctrl_pc_sel_no_xept_T_21);
	wire [2:0] _ctrl_pc_sel_no_xept_T_8 = (~io_dat_br_lt ? 3'h1 : 3'h0);
	wire [2:0] _ctrl_pc_sel_no_xept_T_23 = (cs_br_type == 4'h3 ? _ctrl_pc_sel_no_xept_T_8 : _ctrl_pc_sel_no_xept_T_22);
	wire [2:0] _ctrl_pc_sel_no_xept_T_5 = (io_dat_br_eq ? 3'h1 : 3'h0);
	wire [2:0] _ctrl_pc_sel_no_xept_T_24 = (cs_br_type == 4'h2 ? _ctrl_pc_sel_no_xept_T_5 : _ctrl_pc_sel_no_xept_T_23);
	wire [2:0] _ctrl_pc_sel_no_xept_T_3 = (~io_dat_br_eq ? 3'h1 : 3'h0);
	wire [2:0] _ctrl_pc_sel_no_xept_T_25 = (cs_br_type == 4'h1 ? _ctrl_pc_sel_no_xept_T_3 : _ctrl_pc_sel_no_xept_T_24);
	wire [2:0] _ctrl_pc_sel_no_xept_T_26 = (cs_br_type == 4'h0 ? 3'h0 : _ctrl_pc_sel_no_xept_T_25);
	wire [2:0] ctrl_pc_sel_no_xept = (io_dat_csr_interrupt ? 3'h4 : _ctrl_pc_sel_no_xept_T_26);
	wire [2:0] ctrl_pc_sel = (io_ctl_exception | io_dat_csr_eret ? 3'h4 : ctrl_pc_sel_no_xept);
	wire branch_taken_exe = ctrl_pc_sel == 3'h1;
	// Trace: core/CtlPath_2stage.v:349:3
	// Trace: core/CtlPath_2stage.v:350:3
	// Trace: core/CtlPath_2stage.v:351:3
	// Trace: core/CtlPath_2stage.v:352:3
	// Trace: core/CtlPath_2stage.v:353:3
	// Trace: core/CtlPath_2stage.v:354:3
	// Trace: core/CtlPath_2stage.v:355:3
	// Trace: core/CtlPath_2stage.v:356:3
	// Trace: core/CtlPath_2stage.v:357:3
	// Trace: core/CtlPath_2stage.v:358:3
	// Trace: core/CtlPath_2stage.v:359:3
	// Trace: core/CtlPath_2stage.v:360:3
	// Trace: core/CtlPath_2stage.v:361:3
	// Trace: core/CtlPath_2stage.v:362:3
	// Trace: core/CtlPath_2stage.v:363:3
	// Trace: core/CtlPath_2stage.v:364:3
	// Trace: core/CtlPath_2stage.v:365:3
	// Trace: core/CtlPath_2stage.v:366:3
	// Trace: core/CtlPath_2stage.v:367:3
	// Trace: core/CtlPath_2stage.v:368:3
	// Trace: core/CtlPath_2stage.v:369:3
	// Trace: core/CtlPath_2stage.v:370:3
	// Trace: core/CtlPath_2stage.v:371:3
	// Trace: core/CtlPath_2stage.v:372:3
	// Trace: core/CtlPath_2stage.v:373:3
	// Trace: core/CtlPath_2stage.v:374:3
	// Trace: core/CtlPath_2stage.v:375:3
	// Trace: core/CtlPath_2stage.v:376:3
	// Trace: core/CtlPath_2stage.v:377:3
	// Trace: core/CtlPath_2stage.v:378:3
	// Trace: core/CtlPath_2stage.v:379:3
	// Trace: core/CtlPath_2stage.v:380:3
	// Trace: core/CtlPath_2stage.v:381:3
	// Trace: core/CtlPath_2stage.v:382:3
	// Trace: core/CtlPath_2stage.v:383:3
	// Trace: core/CtlPath_2stage.v:384:3
	// Trace: core/CtlPath_2stage.v:385:3
	// Trace: core/CtlPath_2stage.v:386:3
	// Trace: core/CtlPath_2stage.v:387:3
	// Trace: core/CtlPath_2stage.v:388:3
	// Trace: core/CtlPath_2stage.v:389:3
	// Trace: core/CtlPath_2stage.v:390:3
	wire _csignals_T_75 = 32'h00005073 == _csignals_T;
	// Trace: core/CtlPath_2stage.v:391:3
	wire _csignals_T_77 = 32'h00006073 == _csignals_T;
	// Trace: core/CtlPath_2stage.v:392:3
	wire _csignals_T_79 = 32'h00001073 == _csignals_T;
	// Trace: core/CtlPath_2stage.v:393:3
	wire _csignals_T_81 = 32'h00002073 == _csignals_T;
	// Trace: core/CtlPath_2stage.v:394:3
	wire _csignals_T_83 = 32'h00003073 == _csignals_T;
	// Trace: core/CtlPath_2stage.v:395:3
	wire _csignals_T_85 = 32'h00007073 == _csignals_T;
	// Trace: core/CtlPath_2stage.v:396:3
	wire _csignals_T_87 = 32'h00000073 == io_dat_inst;
	// Trace: core/CtlPath_2stage.v:397:3
	wire _csignals_T_89 = 32'h30200073 == io_dat_inst;
	// Trace: core/CtlPath_2stage.v:398:3
	wire _csignals_T_91 = 32'h7b200073 == io_dat_inst;
	// Trace: core/CtlPath_2stage.v:399:3
	wire _csignals_T_93 = 32'h00100073 == io_dat_inst;
	// Trace: core/CtlPath_2stage.v:400:3
	wire _csignals_T_95 = 32'h10500073 == io_dat_inst;
	// Trace: core/CtlPath_2stage.v:401:3
	wire _csignals_T_97 = 32'h0000100f == _csignals_T;
	// Trace: core/CtlPath_2stage.v:402:3
	wire _csignals_T_99 = 32'h0000000f == _csignals_T;
	// Trace: core/CtlPath_2stage.v:403:3
	wire _csignals_T_130 = _csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (_csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | (_csignals_T_59 | (_csignals_T_61 | (_csignals_T_63 | (_csignals_T_65 | (_csignals_T_67 | (_csignals_T_69 | (_csignals_T_71 | (_csignals_T_73 | (_csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81 | (_csignals_T_83 | (_csignals_T_85 | (_csignals_T_87 | (_csignals_T_89 | (_csignals_T_91 | (_csignals_T_93 | (_csignals_T_95 | (_csignals_T_97 | _csignals_T_99)))))))))))))))))))))))))))));
	// Trace: core/CtlPath_2stage.v:409:3
	wire cs_val_inst = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (_csignals_T_13 | (_csignals_T_15 | (_csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (_csignals_T_23 | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (_csignals_T_37 | _csignals_T_130))))))))))))))))));
	// Trace: core/CtlPath_2stage.v:413:3
	// Trace: core/CtlPath_2stage.v:414:3
	// Trace: core/CtlPath_2stage.v:415:3
	// Trace: core/CtlPath_2stage.v:416:3
	// Trace: core/CtlPath_2stage.v:417:3
	// Trace: core/CtlPath_2stage.v:418:3
	// Trace: core/CtlPath_2stage.v:419:3
	// Trace: core/CtlPath_2stage.v:420:3
	// Trace: core/CtlPath_2stage.v:421:3
	// Trace: core/CtlPath_2stage.v:422:3
	// Trace: core/CtlPath_2stage.v:423:3
	// Trace: core/CtlPath_2stage.v:424:3
	// Trace: core/CtlPath_2stage.v:425:3
	// Trace: core/CtlPath_2stage.v:426:3
	// Trace: core/CtlPath_2stage.v:427:3
	// Trace: core/CtlPath_2stage.v:428:3
	// Trace: core/CtlPath_2stage.v:429:3
	// Trace: core/CtlPath_2stage.v:430:3
	// Trace: core/CtlPath_2stage.v:431:3
	// Trace: core/CtlPath_2stage.v:432:3
	// Trace: core/CtlPath_2stage.v:433:3
	// Trace: core/CtlPath_2stage.v:434:3
	// Trace: core/CtlPath_2stage.v:435:3
	// Trace: core/CtlPath_2stage.v:436:3
	// Trace: core/CtlPath_2stage.v:437:3
	// Trace: core/CtlPath_2stage.v:438:3
	// Trace: core/CtlPath_2stage.v:439:3
	// Trace: core/CtlPath_2stage.v:440:3
	// Trace: core/CtlPath_2stage.v:441:3
	// Trace: core/CtlPath_2stage.v:442:3
	// Trace: core/CtlPath_2stage.v:443:3
	// Trace: core/CtlPath_2stage.v:444:3
	// Trace: core/CtlPath_2stage.v:445:3
	// Trace: core/CtlPath_2stage.v:446:3
	// Trace: core/CtlPath_2stage.v:447:3
	// Trace: core/CtlPath_2stage.v:448:3
	// Trace: core/CtlPath_2stage.v:449:3
	// Trace: core/CtlPath_2stage.v:450:3
	wire [1:0] _csignals_T_205 = (_csignals_T_85 ? 2'h2 : 2'h0);
	// Trace: core/CtlPath_2stage.v:451:3
	wire [1:0] _csignals_T_206 = (_csignals_T_83 ? 2'h0 : _csignals_T_205);
	// Trace: core/CtlPath_2stage.v:452:3
	wire [1:0] _csignals_T_207 = (_csignals_T_81 ? 2'h0 : _csignals_T_206);
	// Trace: core/CtlPath_2stage.v:453:3
	wire [1:0] _csignals_T_208 = (_csignals_T_79 ? 2'h0 : _csignals_T_207);
	// Trace: core/CtlPath_2stage.v:454:3
	wire [1:0] _csignals_T_209 = (_csignals_T_77 ? 2'h2 : _csignals_T_208);
	// Trace: core/CtlPath_2stage.v:455:3
	wire [1:0] _csignals_T_210 = (_csignals_T_75 ? 2'h2 : _csignals_T_209);
	// Trace: core/CtlPath_2stage.v:456:3
	wire [1:0] _csignals_T_211 = (_csignals_T_73 ? 2'h0 : _csignals_T_210);
	// Trace: core/CtlPath_2stage.v:457:3
	wire [1:0] _csignals_T_212 = (_csignals_T_71 ? 2'h0 : _csignals_T_211);
	// Trace: core/CtlPath_2stage.v:458:3
	wire [1:0] _csignals_T_213 = (_csignals_T_69 ? 2'h0 : _csignals_T_212);
	// Trace: core/CtlPath_2stage.v:459:3
	wire [1:0] _csignals_T_214 = (_csignals_T_67 ? 2'h0 : _csignals_T_213);
	// Trace: core/CtlPath_2stage.v:460:3
	wire [1:0] _csignals_T_215 = (_csignals_T_65 ? 2'h0 : _csignals_T_214);
	// Trace: core/CtlPath_2stage.v:461:3
	wire [1:0] _csignals_T_216 = (_csignals_T_63 ? 2'h0 : _csignals_T_215);
	// Trace: core/CtlPath_2stage.v:462:3
	wire [1:0] _csignals_T_217 = (_csignals_T_61 ? 2'h0 : _csignals_T_216);
	// Trace: core/CtlPath_2stage.v:463:3
	wire [1:0] _csignals_T_218 = (_csignals_T_59 ? 2'h0 : _csignals_T_217);
	// Trace: core/CtlPath_2stage.v:464:3
	wire [1:0] _csignals_T_219 = (_csignals_T_57 ? 2'h0 : _csignals_T_218);
	// Trace: core/CtlPath_2stage.v:465:3
	wire [1:0] _csignals_T_220 = (_csignals_T_55 ? 2'h0 : _csignals_T_219);
	// Trace: core/CtlPath_2stage.v:466:3
	wire [1:0] _csignals_T_221 = (_csignals_T_53 ? 2'h0 : _csignals_T_220);
	// Trace: core/CtlPath_2stage.v:467:3
	wire [1:0] _csignals_T_222 = (_csignals_T_51 ? 2'h0 : _csignals_T_221);
	// Trace: core/CtlPath_2stage.v:468:3
	wire [1:0] _csignals_T_223 = (_csignals_T_49 ? 2'h0 : _csignals_T_222);
	// Trace: core/CtlPath_2stage.v:469:3
	wire [1:0] _csignals_T_224 = (_csignals_T_47 ? 2'h0 : _csignals_T_223);
	// Trace: core/CtlPath_2stage.v:470:3
	wire [1:0] _csignals_T_225 = (_csignals_T_45 ? 2'h0 : _csignals_T_224);
	// Trace: core/CtlPath_2stage.v:471:3
	wire [1:0] _csignals_T_226 = (_csignals_T_43 ? 2'h0 : _csignals_T_225);
	// Trace: core/CtlPath_2stage.v:472:3
	wire [1:0] _csignals_T_227 = (_csignals_T_41 ? 2'h0 : _csignals_T_226);
	// Trace: core/CtlPath_2stage.v:473:3
	wire [1:0] _csignals_T_228 = (_csignals_T_39 ? 2'h0 : _csignals_T_227);
	// Trace: core/CtlPath_2stage.v:474:3
	wire [1:0] _csignals_T_229 = (_csignals_T_37 ? 2'h0 : _csignals_T_228);
	// Trace: core/CtlPath_2stage.v:475:3
	wire [1:0] _csignals_T_230 = (_csignals_T_35 ? 2'h0 : _csignals_T_229);
	// Trace: core/CtlPath_2stage.v:476:3
	wire [1:0] _csignals_T_231 = (_csignals_T_33 ? 2'h0 : _csignals_T_230);
	// Trace: core/CtlPath_2stage.v:477:3
	wire [1:0] _csignals_T_232 = (_csignals_T_31 ? 2'h0 : _csignals_T_231);
	// Trace: core/CtlPath_2stage.v:478:3
	wire [1:0] _csignals_T_233 = (_csignals_T_29 ? 2'h0 : _csignals_T_232);
	// Trace: core/CtlPath_2stage.v:479:3
	wire [1:0] _csignals_T_234 = (_csignals_T_27 ? 2'h0 : _csignals_T_233);
	// Trace: core/CtlPath_2stage.v:480:3
	wire [1:0] _csignals_T_235 = (_csignals_T_25 ? 2'h0 : _csignals_T_234);
	// Trace: core/CtlPath_2stage.v:481:3
	wire [1:0] _csignals_T_236 = (_csignals_T_23 ? 2'h0 : _csignals_T_235);
	// Trace: core/CtlPath_2stage.v:482:3
	wire [1:0] _csignals_T_237 = (_csignals_T_21 ? 2'h0 : _csignals_T_236);
	// Trace: core/CtlPath_2stage.v:483:3
	wire [1:0] _csignals_T_238 = (_csignals_T_19 ? 2'h1 : _csignals_T_237);
	// Trace: core/CtlPath_2stage.v:484:3
	wire [1:0] _csignals_T_239 = (_csignals_T_17 ? 2'h1 : _csignals_T_238);
	// Trace: core/CtlPath_2stage.v:485:3
	wire [1:0] _csignals_T_240 = (_csignals_T_15 ? 2'h0 : _csignals_T_239);
	// Trace: core/CtlPath_2stage.v:486:3
	wire [1:0] _csignals_T_241 = (_csignals_T_13 ? 2'h0 : _csignals_T_240);
	// Trace: core/CtlPath_2stage.v:487:3
	wire [1:0] _csignals_T_242 = (_csignals_T_11 ? 2'h0 : _csignals_T_241);
	// Trace: core/CtlPath_2stage.v:488:3
	wire [1:0] _csignals_T_243 = (_csignals_T_9 ? 2'h0 : _csignals_T_242);
	// Trace: core/CtlPath_2stage.v:489:3
	wire [1:0] _csignals_T_244 = (_csignals_T_7 ? 2'h0 : _csignals_T_243);
	// Trace: core/CtlPath_2stage.v:490:3
	wire [1:0] _csignals_T_245 = (_csignals_T_5 ? 2'h0 : _csignals_T_244);
	// Trace: core/CtlPath_2stage.v:491:3
	wire [1:0] _csignals_T_246 = (_csignals_T_3 ? 2'h0 : _csignals_T_245);
	// Trace: core/CtlPath_2stage.v:492:3
	wire [2:0] _csignals_T_266 = (_csignals_T_61 ? 3'h2 : 3'h0);
	// Trace: core/CtlPath_2stage.v:493:3
	wire [2:0] _csignals_T_267 = (_csignals_T_59 ? 3'h0 : _csignals_T_266);
	// Trace: core/CtlPath_2stage.v:494:3
	wire [2:0] _csignals_T_268 = (_csignals_T_57 ? 3'h0 : _csignals_T_267);
	// Trace: core/CtlPath_2stage.v:495:3
	wire [2:0] _csignals_T_269 = (_csignals_T_55 ? 3'h0 : _csignals_T_268);
	// Trace: core/CtlPath_2stage.v:496:3
	wire [2:0] _csignals_T_270 = (_csignals_T_53 ? 3'h0 : _csignals_T_269);
	// Trace: core/CtlPath_2stage.v:497:3
	wire [2:0] _csignals_T_271 = (_csignals_T_51 ? 3'h0 : _csignals_T_270);
	// Trace: core/CtlPath_2stage.v:498:3
	wire [2:0] _csignals_T_272 = (_csignals_T_49 ? 3'h0 : _csignals_T_271);
	// Trace: core/CtlPath_2stage.v:499:3
	wire [2:0] _csignals_T_273 = (_csignals_T_47 ? 3'h0 : _csignals_T_272);
	// Trace: core/CtlPath_2stage.v:500:3
	wire [2:0] _csignals_T_274 = (_csignals_T_45 ? 3'h0 : _csignals_T_273);
	// Trace: core/CtlPath_2stage.v:501:3
	wire [2:0] _csignals_T_275 = (_csignals_T_43 ? 3'h0 : _csignals_T_274);
	// Trace: core/CtlPath_2stage.v:502:3
	wire [2:0] _csignals_T_276 = (_csignals_T_41 ? 3'h0 : _csignals_T_275);
	// Trace: core/CtlPath_2stage.v:503:3
	wire [2:0] _csignals_T_277 = (_csignals_T_39 ? 3'h0 : _csignals_T_276);
	// Trace: core/CtlPath_2stage.v:504:3
	wire [2:0] _csignals_T_278 = (_csignals_T_37 ? 3'h2 : _csignals_T_277);
	// Trace: core/CtlPath_2stage.v:505:3
	wire [2:0] _csignals_T_279 = (_csignals_T_35 ? 3'h2 : _csignals_T_278);
	// Trace: core/CtlPath_2stage.v:506:3
	wire [2:0] _csignals_T_280 = (_csignals_T_33 ? 3'h2 : _csignals_T_279);
	// Trace: core/CtlPath_2stage.v:507:3
	wire [2:0] _csignals_T_281 = (_csignals_T_31 ? 3'h2 : _csignals_T_280);
	// Trace: core/CtlPath_2stage.v:508:3
	wire [2:0] _csignals_T_282 = (_csignals_T_29 ? 3'h2 : _csignals_T_281);
	// Trace: core/CtlPath_2stage.v:509:3
	wire [2:0] _csignals_T_283 = (_csignals_T_27 ? 3'h2 : _csignals_T_282);
	// Trace: core/CtlPath_2stage.v:510:3
	wire [2:0] _csignals_T_284 = (_csignals_T_25 ? 3'h2 : _csignals_T_283);
	// Trace: core/CtlPath_2stage.v:511:3
	wire [2:0] _csignals_T_285 = (_csignals_T_23 ? 3'h2 : _csignals_T_284);
	// Trace: core/CtlPath_2stage.v:512:3
	wire [2:0] _csignals_T_286 = (_csignals_T_21 ? 3'h2 : _csignals_T_285);
	// Trace: core/CtlPath_2stage.v:513:3
	wire [2:0] _csignals_T_287 = (_csignals_T_19 ? 3'h0 : _csignals_T_286);
	// Trace: core/CtlPath_2stage.v:514:3
	wire [2:0] _csignals_T_288 = (_csignals_T_17 ? 3'h1 : _csignals_T_287);
	// Trace: core/CtlPath_2stage.v:515:3
	wire [2:0] _csignals_T_289 = (_csignals_T_15 ? 3'h3 : _csignals_T_288);
	// Trace: core/CtlPath_2stage.v:516:3
	wire [2:0] _csignals_T_290 = (_csignals_T_13 ? 3'h3 : _csignals_T_289);
	// Trace: core/CtlPath_2stage.v:517:3
	wire [2:0] _csignals_T_291 = (_csignals_T_11 ? 3'h3 : _csignals_T_290);
	// Trace: core/CtlPath_2stage.v:518:3
	wire [2:0] _csignals_T_292 = (_csignals_T_9 ? 3'h2 : _csignals_T_291);
	// Trace: core/CtlPath_2stage.v:519:3
	wire [2:0] _csignals_T_293 = (_csignals_T_7 ? 3'h2 : _csignals_T_292);
	// Trace: core/CtlPath_2stage.v:520:3
	wire [2:0] _csignals_T_294 = (_csignals_T_5 ? 3'h2 : _csignals_T_293);
	// Trace: core/CtlPath_2stage.v:521:3
	wire [2:0] _csignals_T_295 = (_csignals_T_3 ? 3'h2 : _csignals_T_294);
	// Trace: core/CtlPath_2stage.v:522:3
	wire [3:0] _csignals_T_303 = (_csignals_T_85 ? 4'hb : 4'h0);
	// Trace: core/CtlPath_2stage.v:523:3
	wire [3:0] _csignals_T_304 = (_csignals_T_83 ? 4'hb : _csignals_T_303);
	// Trace: core/CtlPath_2stage.v:524:3
	wire [3:0] _csignals_T_305 = (_csignals_T_81 ? 4'hb : _csignals_T_304);
	// Trace: core/CtlPath_2stage.v:525:3
	wire [3:0] _csignals_T_306 = (_csignals_T_79 ? 4'hb : _csignals_T_305);
	// Trace: core/CtlPath_2stage.v:526:3
	wire [3:0] _csignals_T_307 = (_csignals_T_77 ? 4'hb : _csignals_T_306);
	// Trace: core/CtlPath_2stage.v:527:3
	wire [3:0] _csignals_T_308 = (_csignals_T_75 ? 4'hb : _csignals_T_307);
	// Trace: core/CtlPath_2stage.v:528:3
	wire [3:0] _csignals_T_309 = (_csignals_T_73 ? 4'h0 : _csignals_T_308);
	// Trace: core/CtlPath_2stage.v:529:3
	wire [3:0] _csignals_T_310 = (_csignals_T_71 ? 4'h0 : _csignals_T_309);
	// Trace: core/CtlPath_2stage.v:530:3
	wire [3:0] _csignals_T_311 = (_csignals_T_69 ? 4'h0 : _csignals_T_310);
	// Trace: core/CtlPath_2stage.v:531:3
	wire [3:0] _csignals_T_312 = (_csignals_T_67 ? 4'h0 : _csignals_T_311);
	// Trace: core/CtlPath_2stage.v:532:3
	wire [3:0] _csignals_T_313 = (_csignals_T_65 ? 4'h0 : _csignals_T_312);
	// Trace: core/CtlPath_2stage.v:533:3
	wire [3:0] _csignals_T_314 = (_csignals_T_63 ? 4'h0 : _csignals_T_313);
	// Trace: core/CtlPath_2stage.v:534:3
	wire [3:0] _csignals_T_315 = (_csignals_T_61 ? 4'h0 : _csignals_T_314);
	// Trace: core/CtlPath_2stage.v:535:3
	wire [3:0] _csignals_T_316 = (_csignals_T_59 ? 4'h0 : _csignals_T_315);
	// Trace: core/CtlPath_2stage.v:536:3
	wire [3:0] _csignals_T_317 = (_csignals_T_57 ? 4'h4 : _csignals_T_316);
	// Trace: core/CtlPath_2stage.v:537:3
	wire [3:0] _csignals_T_318 = (_csignals_T_55 ? 4'h5 : _csignals_T_317);
	// Trace: core/CtlPath_2stage.v:538:3
	wire [3:0] _csignals_T_319 = (_csignals_T_53 ? 4'h8 : _csignals_T_318);
	// Trace: core/CtlPath_2stage.v:539:3
	wire [3:0] _csignals_T_320 = (_csignals_T_51 ? 4'h7 : _csignals_T_319);
	// Trace: core/CtlPath_2stage.v:540:3
	wire [3:0] _csignals_T_321 = (_csignals_T_49 ? 4'h6 : _csignals_T_320);
	// Trace: core/CtlPath_2stage.v:541:3
	wire [3:0] _csignals_T_322 = (_csignals_T_47 ? 4'ha : _csignals_T_321);
	// Trace: core/CtlPath_2stage.v:542:3
	wire [3:0] _csignals_T_323 = (_csignals_T_45 ? 4'h9 : _csignals_T_322);
	// Trace: core/CtlPath_2stage.v:543:3
	wire [3:0] _csignals_T_324 = (_csignals_T_43 ? 4'h2 : _csignals_T_323);
	// Trace: core/CtlPath_2stage.v:544:3
	wire [3:0] _csignals_T_325 = (_csignals_T_41 ? 4'h1 : _csignals_T_324);
	// Trace: core/CtlPath_2stage.v:545:3
	wire [3:0] _csignals_T_326 = (_csignals_T_39 ? 4'h3 : _csignals_T_325);
	// Trace: core/CtlPath_2stage.v:546:3
	wire [3:0] _csignals_T_327 = (_csignals_T_37 ? 4'h4 : _csignals_T_326);
	// Trace: core/CtlPath_2stage.v:547:3
	wire [3:0] _csignals_T_328 = (_csignals_T_35 ? 4'h5 : _csignals_T_327);
	// Trace: core/CtlPath_2stage.v:548:3
	wire [3:0] _csignals_T_329 = (_csignals_T_33 ? 4'h3 : _csignals_T_328);
	// Trace: core/CtlPath_2stage.v:549:3
	wire [3:0] _csignals_T_330 = (_csignals_T_31 ? 4'ha : _csignals_T_329);
	// Trace: core/CtlPath_2stage.v:550:3
	wire [3:0] _csignals_T_331 = (_csignals_T_29 ? 4'h9 : _csignals_T_330);
	// Trace: core/CtlPath_2stage.v:551:3
	wire [3:0] _csignals_T_332 = (_csignals_T_27 ? 4'h8 : _csignals_T_331);
	// Trace: core/CtlPath_2stage.v:552:3
	wire [3:0] _csignals_T_333 = (_csignals_T_25 ? 4'h7 : _csignals_T_332);
	// Trace: core/CtlPath_2stage.v:553:3
	wire [3:0] _csignals_T_334 = (_csignals_T_23 ? 4'h6 : _csignals_T_333);
	// Trace: core/CtlPath_2stage.v:554:3
	wire [3:0] _csignals_T_335 = (_csignals_T_21 ? 4'h1 : _csignals_T_334);
	// Trace: core/CtlPath_2stage.v:555:3
	wire [3:0] _csignals_T_336 = (_csignals_T_19 ? 4'hb : _csignals_T_335);
	// Trace: core/CtlPath_2stage.v:556:3
	wire [3:0] _csignals_T_337 = (_csignals_T_17 ? 4'h1 : _csignals_T_336);
	// Trace: core/CtlPath_2stage.v:557:3
	wire [3:0] _csignals_T_338 = (_csignals_T_15 ? 4'h1 : _csignals_T_337);
	// Trace: core/CtlPath_2stage.v:558:3
	wire [3:0] _csignals_T_339 = (_csignals_T_13 ? 4'h1 : _csignals_T_338);
	// Trace: core/CtlPath_2stage.v:559:3
	wire [3:0] _csignals_T_340 = (_csignals_T_11 ? 4'h1 : _csignals_T_339);
	// Trace: core/CtlPath_2stage.v:560:3
	wire [3:0] _csignals_T_341 = (_csignals_T_9 ? 4'h1 : _csignals_T_340);
	// Trace: core/CtlPath_2stage.v:561:3
	wire [3:0] _csignals_T_342 = (_csignals_T_7 ? 4'h1 : _csignals_T_341);
	// Trace: core/CtlPath_2stage.v:562:3
	wire [3:0] _csignals_T_343 = (_csignals_T_5 ? 4'h1 : _csignals_T_342);
	// Trace: core/CtlPath_2stage.v:563:3
	wire [3:0] _csignals_T_344 = (_csignals_T_3 ? 4'h1 : _csignals_T_343);
	// Trace: core/CtlPath_2stage.v:564:3
	wire [3:0] cs_alu_fun = (_csignals_T_1 ? 4'h1 : _csignals_T_344);
	// Trace: core/CtlPath_2stage.v:565:3
	wire [1:0] _csignals_T_352 = (_csignals_T_85 ? 2'h3 : 2'h0);
	// Trace: core/CtlPath_2stage.v:566:3
	wire [1:0] _csignals_T_353 = (_csignals_T_83 ? 2'h3 : _csignals_T_352);
	// Trace: core/CtlPath_2stage.v:567:3
	wire [1:0] _csignals_T_354 = (_csignals_T_81 ? 2'h3 : _csignals_T_353);
	// Trace: core/CtlPath_2stage.v:568:3
	wire [1:0] _csignals_T_355 = (_csignals_T_79 ? 2'h3 : _csignals_T_354);
	// Trace: core/CtlPath_2stage.v:569:3
	wire [1:0] _csignals_T_356 = (_csignals_T_77 ? 2'h3 : _csignals_T_355);
	// Trace: core/CtlPath_2stage.v:570:3
	wire [1:0] _csignals_T_357 = (_csignals_T_75 ? 2'h3 : _csignals_T_356);
	// Trace: core/CtlPath_2stage.v:571:3
	wire [1:0] _csignals_T_358 = (_csignals_T_73 ? 2'h0 : _csignals_T_357);
	// Trace: core/CtlPath_2stage.v:572:3
	wire [1:0] _csignals_T_359 = (_csignals_T_71 ? 2'h0 : _csignals_T_358);
	// Trace: core/CtlPath_2stage.v:573:3
	wire [1:0] _csignals_T_360 = (_csignals_T_69 ? 2'h0 : _csignals_T_359);
	// Trace: core/CtlPath_2stage.v:574:3
	wire [1:0] _csignals_T_361 = (_csignals_T_67 ? 2'h0 : _csignals_T_360);
	// Trace: core/CtlPath_2stage.v:575:3
	wire [1:0] _csignals_T_362 = (_csignals_T_65 ? 2'h0 : _csignals_T_361);
	// Trace: core/CtlPath_2stage.v:576:3
	wire [1:0] _csignals_T_363 = (_csignals_T_63 ? 2'h0 : _csignals_T_362);
	// Trace: core/CtlPath_2stage.v:577:3
	wire [1:0] _csignals_T_364 = (_csignals_T_61 ? 2'h2 : _csignals_T_363);
	// Trace: core/CtlPath_2stage.v:578:3
	wire [1:0] _csignals_T_365 = (_csignals_T_59 ? 2'h2 : _csignals_T_364);
	// Trace: core/CtlPath_2stage.v:579:3
	wire [1:0] _csignals_T_366 = (_csignals_T_57 ? 2'h0 : _csignals_T_365);
	// Trace: core/CtlPath_2stage.v:580:3
	wire [1:0] _csignals_T_367 = (_csignals_T_55 ? 2'h0 : _csignals_T_366);
	// Trace: core/CtlPath_2stage.v:581:3
	wire [1:0] _csignals_T_368 = (_csignals_T_53 ? 2'h0 : _csignals_T_367);
	// Trace: core/CtlPath_2stage.v:582:3
	wire [1:0] _csignals_T_369 = (_csignals_T_51 ? 2'h0 : _csignals_T_368);
	// Trace: core/CtlPath_2stage.v:583:3
	wire [1:0] _csignals_T_370 = (_csignals_T_49 ? 2'h0 : _csignals_T_369);
	// Trace: core/CtlPath_2stage.v:584:3
	wire [1:0] _csignals_T_371 = (_csignals_T_47 ? 2'h0 : _csignals_T_370);
	// Trace: core/CtlPath_2stage.v:585:3
	wire [1:0] _csignals_T_372 = (_csignals_T_45 ? 2'h0 : _csignals_T_371);
	// Trace: core/CtlPath_2stage.v:586:3
	wire [1:0] _csignals_T_373 = (_csignals_T_43 ? 2'h0 : _csignals_T_372);
	// Trace: core/CtlPath_2stage.v:587:3
	wire [1:0] _csignals_T_374 = (_csignals_T_41 ? 2'h0 : _csignals_T_373);
	// Trace: core/CtlPath_2stage.v:588:3
	wire [1:0] _csignals_T_375 = (_csignals_T_39 ? 2'h0 : _csignals_T_374);
	// Trace: core/CtlPath_2stage.v:589:3
	wire [1:0] _csignals_T_376 = (_csignals_T_37 ? 2'h0 : _csignals_T_375);
	// Trace: core/CtlPath_2stage.v:590:3
	wire [1:0] _csignals_T_377 = (_csignals_T_35 ? 2'h0 : _csignals_T_376);
	// Trace: core/CtlPath_2stage.v:591:3
	wire [1:0] _csignals_T_378 = (_csignals_T_33 ? 2'h0 : _csignals_T_377);
	// Trace: core/CtlPath_2stage.v:592:3
	wire [1:0] _csignals_T_379 = (_csignals_T_31 ? 2'h0 : _csignals_T_378);
	// Trace: core/CtlPath_2stage.v:593:3
	wire [1:0] _csignals_T_380 = (_csignals_T_29 ? 2'h0 : _csignals_T_379);
	// Trace: core/CtlPath_2stage.v:594:3
	wire [1:0] _csignals_T_381 = (_csignals_T_27 ? 2'h0 : _csignals_T_380);
	// Trace: core/CtlPath_2stage.v:595:3
	wire [1:0] _csignals_T_382 = (_csignals_T_25 ? 2'h0 : _csignals_T_381);
	// Trace: core/CtlPath_2stage.v:596:3
	wire [1:0] _csignals_T_383 = (_csignals_T_23 ? 2'h0 : _csignals_T_382);
	// Trace: core/CtlPath_2stage.v:597:3
	wire [1:0] _csignals_T_384 = (_csignals_T_21 ? 2'h0 : _csignals_T_383);
	// Trace: core/CtlPath_2stage.v:598:3
	wire [1:0] _csignals_T_385 = (_csignals_T_19 ? 2'h0 : _csignals_T_384);
	// Trace: core/CtlPath_2stage.v:599:3
	wire [1:0] _csignals_T_386 = (_csignals_T_17 ? 2'h0 : _csignals_T_385);
	// Trace: core/CtlPath_2stage.v:600:3
	wire [1:0] _csignals_T_387 = (_csignals_T_15 ? 2'h0 : _csignals_T_386);
	// Trace: core/CtlPath_2stage.v:601:3
	wire [1:0] _csignals_T_388 = (_csignals_T_13 ? 2'h0 : _csignals_T_387);
	// Trace: core/CtlPath_2stage.v:602:3
	wire [1:0] _csignals_T_389 = (_csignals_T_11 ? 2'h0 : _csignals_T_388);
	// Trace: core/CtlPath_2stage.v:603:3
	wire [1:0] _csignals_T_390 = (_csignals_T_9 ? 2'h1 : _csignals_T_389);
	// Trace: core/CtlPath_2stage.v:604:3
	wire [1:0] _csignals_T_391 = (_csignals_T_7 ? 2'h1 : _csignals_T_390);
	// Trace: core/CtlPath_2stage.v:605:3
	wire [1:0] _csignals_T_392 = (_csignals_T_5 ? 2'h1 : _csignals_T_391);
	// Trace: core/CtlPath_2stage.v:606:3
	wire [1:0] _csignals_T_393 = (_csignals_T_3 ? 2'h1 : _csignals_T_392);
	// Trace: core/CtlPath_2stage.v:607:3
	wire _csignals_T_407 = (_csignals_T_73 ? 1'h0 : _csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81 | (_csignals_T_83 | _csignals_T_85)))));
	// Trace: core/CtlPath_2stage.v:609:3
	wire _csignals_T_408 = (_csignals_T_71 ? 1'h0 : _csignals_T_407);
	// Trace: core/CtlPath_2stage.v:610:3
	wire _csignals_T_409 = (_csignals_T_69 ? 1'h0 : _csignals_T_408);
	// Trace: core/CtlPath_2stage.v:611:3
	wire _csignals_T_410 = (_csignals_T_67 ? 1'h0 : _csignals_T_409);
	// Trace: core/CtlPath_2stage.v:612:3
	wire _csignals_T_411 = (_csignals_T_65 ? 1'h0 : _csignals_T_410);
	// Trace: core/CtlPath_2stage.v:613:3
	wire _csignals_T_412 = (_csignals_T_63 ? 1'h0 : _csignals_T_411);
	// Trace: core/CtlPath_2stage.v:614:3
	wire _csignals_T_436 = (_csignals_T_15 ? 1'h0 : _csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (_csignals_T_23 | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (_csignals_T_37 | (_csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (_csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | (_csignals_T_59 | (_csignals_T_61 | _csignals_T_412)))))))))))))))))))))));
	// Trace: core/CtlPath_2stage.v:619:3
	wire _csignals_T_437 = (_csignals_T_13 ? 1'h0 : _csignals_T_436);
	// Trace: core/CtlPath_2stage.v:620:3
	wire _csignals_T_438 = (_csignals_T_11 ? 1'h0 : _csignals_T_437);
	// Trace: core/CtlPath_2stage.v:621:3
	wire cs0_0 = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | _csignals_T_438))));
	// Trace: core/CtlPath_2stage.v:622:3
	wire cs0_1 = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (_csignals_T_13 | _csignals_T_15))))));
	// Trace: core/CtlPath_2stage.v:624:3
	wire _csignals_T_537 = (_csignals_T_9 ? 1'h0 : _csignals_T_11 | (_csignals_T_13 | _csignals_T_15));
	// Trace: core/CtlPath_2stage.v:625:3
	wire _csignals_T_538 = (_csignals_T_7 ? 1'h0 : _csignals_T_537);
	// Trace: core/CtlPath_2stage.v:626:3
	wire _csignals_T_539 = (_csignals_T_5 ? 1'h0 : _csignals_T_538);
	// Trace: core/CtlPath_2stage.v:627:3
	wire _csignals_T_540 = (_csignals_T_3 ? 1'h0 : _csignals_T_539);
	// Trace: core/CtlPath_2stage.v:628:3
	wire cs0_2 = (_csignals_T_1 ? 1'h0 : _csignals_T_540);
	// Trace: core/CtlPath_2stage.v:629:3
	wire [2:0] _csignals_T_583 = (_csignals_T_15 ? 3'h2 : 3'h0);
	// Trace: core/CtlPath_2stage.v:630:3
	wire [2:0] _csignals_T_584 = (_csignals_T_13 ? 3'h1 : _csignals_T_583);
	// Trace: core/CtlPath_2stage.v:631:3
	wire [2:0] _csignals_T_585 = (_csignals_T_11 ? 3'h3 : _csignals_T_584);
	// Trace: core/CtlPath_2stage.v:632:3
	wire [2:0] _csignals_T_586 = (_csignals_T_9 ? 3'h6 : _csignals_T_585);
	// Trace: core/CtlPath_2stage.v:633:3
	wire [2:0] _csignals_T_587 = (_csignals_T_7 ? 3'h2 : _csignals_T_586);
	// Trace: core/CtlPath_2stage.v:634:3
	wire [2:0] _csignals_T_588 = (_csignals_T_5 ? 3'h5 : _csignals_T_587);
	// Trace: core/CtlPath_2stage.v:635:3
	wire [2:0] _csignals_T_589 = (_csignals_T_3 ? 3'h1 : _csignals_T_588);
	// Trace: core/CtlPath_2stage.v:636:3
	wire [2:0] _csignals_T_593 = (_csignals_T_93 ? 3'h4 : 3'h0);
	// Trace: core/CtlPath_2stage.v:637:3
	wire [2:0] _csignals_T_594 = (_csignals_T_91 ? 3'h4 : _csignals_T_593);
	// Trace: core/CtlPath_2stage.v:638:3
	wire [2:0] _csignals_T_595 = (_csignals_T_89 ? 3'h4 : _csignals_T_594);
	// Trace: core/CtlPath_2stage.v:639:3
	wire [2:0] _csignals_T_596 = (_csignals_T_87 ? 3'h4 : _csignals_T_595);
	// Trace: core/CtlPath_2stage.v:640:3
	wire [2:0] _csignals_T_597 = (_csignals_T_85 ? 3'h7 : _csignals_T_596);
	// Trace: core/CtlPath_2stage.v:641:3
	wire [2:0] _csignals_T_598 = (_csignals_T_83 ? 3'h7 : _csignals_T_597);
	// Trace: core/CtlPath_2stage.v:642:3
	wire [2:0] _csignals_T_599 = (_csignals_T_81 ? 3'h6 : _csignals_T_598);
	// Trace: core/CtlPath_2stage.v:643:3
	wire [2:0] _csignals_T_600 = (_csignals_T_79 ? 3'h5 : _csignals_T_599);
	// Trace: core/CtlPath_2stage.v:644:3
	wire [2:0] _csignals_T_601 = (_csignals_T_77 ? 3'h6 : _csignals_T_600);
	// Trace: core/CtlPath_2stage.v:645:3
	wire [2:0] _csignals_T_602 = (_csignals_T_75 ? 3'h5 : _csignals_T_601);
	// Trace: core/CtlPath_2stage.v:646:3
	wire [2:0] _csignals_T_603 = (_csignals_T_73 ? 3'h0 : _csignals_T_602);
	// Trace: core/CtlPath_2stage.v:647:3
	wire [2:0] _csignals_T_604 = (_csignals_T_71 ? 3'h0 : _csignals_T_603);
	// Trace: core/CtlPath_2stage.v:648:3
	wire [2:0] _csignals_T_605 = (_csignals_T_69 ? 3'h0 : _csignals_T_604);
	// Trace: core/CtlPath_2stage.v:649:3
	wire [2:0] _csignals_T_606 = (_csignals_T_67 ? 3'h0 : _csignals_T_605);
	// Trace: core/CtlPath_2stage.v:650:3
	wire [2:0] _csignals_T_607 = (_csignals_T_65 ? 3'h0 : _csignals_T_606);
	// Trace: core/CtlPath_2stage.v:651:3
	wire [2:0] _csignals_T_608 = (_csignals_T_63 ? 3'h0 : _csignals_T_607);
	// Trace: core/CtlPath_2stage.v:652:3
	wire [2:0] _csignals_T_609 = (_csignals_T_61 ? 3'h0 : _csignals_T_608);
	// Trace: core/CtlPath_2stage.v:653:3
	wire [2:0] _csignals_T_610 = (_csignals_T_59 ? 3'h0 : _csignals_T_609);
	// Trace: core/CtlPath_2stage.v:654:3
	wire [2:0] _csignals_T_611 = (_csignals_T_57 ? 3'h0 : _csignals_T_610);
	// Trace: core/CtlPath_2stage.v:655:3
	wire [2:0] _csignals_T_612 = (_csignals_T_55 ? 3'h0 : _csignals_T_611);
	// Trace: core/CtlPath_2stage.v:656:3
	wire [2:0] _csignals_T_613 = (_csignals_T_53 ? 3'h0 : _csignals_T_612);
	// Trace: core/CtlPath_2stage.v:657:3
	wire [2:0] _csignals_T_614 = (_csignals_T_51 ? 3'h0 : _csignals_T_613);
	// Trace: core/CtlPath_2stage.v:658:3
	wire [2:0] _csignals_T_615 = (_csignals_T_49 ? 3'h0 : _csignals_T_614);
	// Trace: core/CtlPath_2stage.v:659:3
	wire [2:0] _csignals_T_616 = (_csignals_T_47 ? 3'h0 : _csignals_T_615);
	// Trace: core/CtlPath_2stage.v:660:3
	wire [2:0] _csignals_T_617 = (_csignals_T_45 ? 3'h0 : _csignals_T_616);
	// Trace: core/CtlPath_2stage.v:661:3
	wire [2:0] _csignals_T_618 = (_csignals_T_43 ? 3'h0 : _csignals_T_617);
	// Trace: core/CtlPath_2stage.v:662:3
	wire [2:0] _csignals_T_619 = (_csignals_T_41 ? 3'h0 : _csignals_T_618);
	// Trace: core/CtlPath_2stage.v:663:3
	wire [2:0] _csignals_T_620 = (_csignals_T_39 ? 3'h0 : _csignals_T_619);
	// Trace: core/CtlPath_2stage.v:664:3
	wire [2:0] _csignals_T_621 = (_csignals_T_37 ? 3'h0 : _csignals_T_620);
	// Trace: core/CtlPath_2stage.v:665:3
	wire [2:0] _csignals_T_622 = (_csignals_T_35 ? 3'h0 : _csignals_T_621);
	// Trace: core/CtlPath_2stage.v:666:3
	wire [2:0] _csignals_T_623 = (_csignals_T_33 ? 3'h0 : _csignals_T_622);
	// Trace: core/CtlPath_2stage.v:667:3
	wire [2:0] _csignals_T_624 = (_csignals_T_31 ? 3'h0 : _csignals_T_623);
	// Trace: core/CtlPath_2stage.v:668:3
	wire [2:0] _csignals_T_625 = (_csignals_T_29 ? 3'h0 : _csignals_T_624);
	// Trace: core/CtlPath_2stage.v:669:3
	wire [2:0] _csignals_T_626 = (_csignals_T_27 ? 3'h0 : _csignals_T_625);
	// Trace: core/CtlPath_2stage.v:670:3
	wire [2:0] _csignals_T_627 = (_csignals_T_25 ? 3'h0 : _csignals_T_626);
	// Trace: core/CtlPath_2stage.v:671:3
	wire [2:0] _csignals_T_628 = (_csignals_T_23 ? 3'h0 : _csignals_T_627);
	// Trace: core/CtlPath_2stage.v:672:3
	wire [2:0] _csignals_T_629 = (_csignals_T_21 ? 3'h0 : _csignals_T_628);
	// Trace: core/CtlPath_2stage.v:673:3
	wire [2:0] _csignals_T_630 = (_csignals_T_19 ? 3'h0 : _csignals_T_629);
	// Trace: core/CtlPath_2stage.v:674:3
	wire [2:0] _csignals_T_631 = (_csignals_T_17 ? 3'h0 : _csignals_T_630);
	// Trace: core/CtlPath_2stage.v:675:3
	wire [2:0] _csignals_T_632 = (_csignals_T_15 ? 3'h0 : _csignals_T_631);
	// Trace: core/CtlPath_2stage.v:676:3
	wire [2:0] _csignals_T_633 = (_csignals_T_13 ? 3'h0 : _csignals_T_632);
	// Trace: core/CtlPath_2stage.v:677:3
	wire [2:0] _csignals_T_634 = (_csignals_T_11 ? 3'h0 : _csignals_T_633);
	// Trace: core/CtlPath_2stage.v:678:3
	wire [2:0] _csignals_T_635 = (_csignals_T_9 ? 3'h0 : _csignals_T_634);
	// Trace: core/CtlPath_2stage.v:679:3
	wire [2:0] _csignals_T_636 = (_csignals_T_7 ? 3'h0 : _csignals_T_635);
	// Trace: core/CtlPath_2stage.v:680:3
	wire [2:0] _csignals_T_637 = (_csignals_T_5 ? 3'h0 : _csignals_T_636);
	// Trace: core/CtlPath_2stage.v:681:3
	wire [2:0] _csignals_T_638 = (_csignals_T_3 ? 3'h0 : _csignals_T_637);
	// Trace: core/CtlPath_2stage.v:682:3
	wire [2:0] cs0_4 = (_csignals_T_1 ? 3'h0 : _csignals_T_638);
	// Trace: core/CtlPath_2stage.v:683:3
	// Trace: core/CtlPath_2stage.v:684:3
	// Trace: core/CtlPath_2stage.v:685:3
	// Trace: core/CtlPath_2stage.v:686:3
	// Trace: core/CtlPath_2stage.v:687:3
	// Trace: core/CtlPath_2stage.v:688:3
	// Trace: core/CtlPath_2stage.v:689:3
	// Trace: core/CtlPath_2stage.v:690:3
	// Trace: core/CtlPath_2stage.v:691:3
	// Trace: core/CtlPath_2stage.v:692:3
	// Trace: core/CtlPath_2stage.v:693:3
	// Trace: core/CtlPath_2stage.v:694:3
	// Trace: core/CtlPath_2stage.v:695:3
	// Trace: core/CtlPath_2stage.v:696:3
	// Trace: core/CtlPath_2stage.v:697:3
	// Trace: core/CtlPath_2stage.v:698:3
	// Trace: core/CtlPath_2stage.v:699:3
	// Trace: core/CtlPath_2stage.v:700:3
	wire stall = ~io_dat_if_valid_resp | ~((cs0_1 & (io_dmem_resp_valid | io_dat_data_misaligned)) | ~cs0_1);
	// Trace: core/CtlPath_2stage.v:701:3
	wire [4:0] rs1_addr = io_dat_inst[19:15];
	// Trace: core/CtlPath_2stage.v:702:3
	wire csr_ren = ((cs0_4 == 3'h6) | (cs0_4 == 3'h7)) & (rs1_addr == 5'h00);
	// Trace: core/CtlPath_2stage.v:703:3
	wire [2:0] csr_cmd = (csr_ren ? 3'h2 : cs0_4);
	// Trace: core/CtlPath_2stage.v:704:3
	wire illegal = ~cs_val_inst & io_imem_resp_valid;
	// Trace: core/CtlPath_2stage.v:705:3
	wire [2:0] _io_ctl_exception_cause_T = (io_dat_mem_store ? 3'h6 : 3'h4);
	// Trace: core/CtlPath_2stage.v:706:3
	wire [2:0] _io_ctl_exception_cause_T_1 = (io_dat_inst_misaligned ? 3'h0 : _io_ctl_exception_cause_T);
	// Trace: core/CtlPath_2stage.v:707:3
	wire [2:0] _io_ctl_exception_cause_T_2 = (illegal ? 3'h2 : _io_ctl_exception_cause_T_1);
	// Trace: core/CtlPath_2stage.v:708:3
	assign io_dmem_req_valid = cs0_1 & ~io_dat_data_misaligned;
	// Trace: core/CtlPath_2stage.v:709:3
	assign io_dmem_req_bits_fcn = (_csignals_T_1 ? 1'h0 : _csignals_T_540);
	// Trace: core/CtlPath_2stage.v:710:3
	assign io_dmem_req_bits_typ = (_csignals_T_1 ? 3'h3 : _csignals_T_589);
	// Trace: core/CtlPath_2stage.v:711:3
	assign io_ctl_stall = ~io_dat_if_valid_resp | ~((cs0_1 & (io_dmem_resp_valid | io_dat_data_misaligned)) | ~cs0_1);
	// Trace: core/CtlPath_2stage.v:712:3
	assign io_ctl_if_kill = ~(ctrl_pc_sel == 3'h0);
	// Trace: core/CtlPath_2stage.v:713:3
	assign io_ctl_pc_sel = (io_ctl_exception | io_dat_csr_eret ? 3'h4 : ctrl_pc_sel_no_xept);
	// Trace: core/CtlPath_2stage.v:714:3
	assign io_ctl_op1_sel = (_csignals_T_1 ? 2'h0 : _csignals_T_246);
	// Trace: core/CtlPath_2stage.v:715:3
	assign io_ctl_op2_sel = (_csignals_T_1 ? 3'h2 : _csignals_T_295);
	// Trace: core/CtlPath_2stage.v:716:3
	assign io_ctl_alu_fun = {1'd0, cs_alu_fun};
	// Trace: core/CtlPath_2stage.v:717:3
	assign io_ctl_wb_sel = (_csignals_T_1 ? 2'h1 : _csignals_T_393);
	// Trace: core/CtlPath_2stage.v:718:3
	assign io_ctl_rf_wen = (stall ? 1'h0 : cs0_0);
	// Trace: core/CtlPath_2stage.v:719:3
	assign io_ctl_csr_cmd = (stall ? 3'h0 : csr_cmd);
	// Trace: core/CtlPath_2stage.v:720:3
	assign io_ctl_mem_val = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (_csignals_T_13 | _csignals_T_15))))));
	// Trace: core/CtlPath_2stage.v:722:3
	assign io_ctl_mem_fcn = {1'd0, cs0_2};
	// Trace: core/CtlPath_2stage.v:723:3
	assign io_ctl_mem_typ = (_csignals_T_1 ? 3'h3 : _csignals_T_589);
	// Trace: core/CtlPath_2stage.v:724:3
	assign io_ctl_exception = ((illegal | io_dat_inst_misaligned) | io_dat_data_misaligned) & ~io_dat_csr_eret;
	// Trace: core/CtlPath_2stage.v:725:3
	assign io_ctl_exception_cause = {29'd0, _io_ctl_exception_cause_T_2};
	// Trace: core/CtlPath_2stage.v:726:3
	assign io_ctl_pc_sel_no_xept = (io_dat_csr_interrupt ? 3'h4 : _ctrl_pc_sel_no_xept_T_26);
endmodule
