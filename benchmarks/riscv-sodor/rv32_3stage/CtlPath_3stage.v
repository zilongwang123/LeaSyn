module CtlPath_3stage(
  input         clock,
  input         reset,
  output        io_imem_req_valid,
  input         io_imem_resp_valid,
  input  [31:0] io_imem_resp_bits_inst,
  output        io_imem_exe_kill,
  input         io_dat_br_eq,
  input         io_dat_br_lt,
  input         io_dat_br_ltu,
  input         io_dat_inst_misaligned,
  input         io_dat_data_misaligned,
  input         io_dat_wb_hazard_stall,
  input         io_dat_csr_eret,
  input         io_dat_csr_interrupt,
  output        io_ctl_exe_kill,
  output [2:0]  io_ctl_pc_sel,
  output        io_ctl_brjmp_sel,
  output [1:0]  io_ctl_op1_sel,
  output [1:0]  io_ctl_op2_sel,
  output [3:0]  io_ctl_alu_fun,
  output [1:0]  io_ctl_wb_sel,
  output        io_ctl_rf_wen,
  output        io_ctl_bypassable,
  output [2:0]  io_ctl_csr_cmd,
  output        io_ctl_dmem_val,
  output        io_ctl_dmem_fcn,
  output [2:0]  io_ctl_dmem_typ,
  output        io_ctl_exception,
  output [31:0] io_ctl_exception_cause
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] _csignals_T = io_imem_resp_bits_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_1 = 32'h2003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_3 = 32'h3 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_5 = 32'h4003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_7 = 32'h1003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_9 = 32'h5003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_11 = 32'h2023 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_13 = 32'h23 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_15 = 32'h1023 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_16 = io_imem_resp_bits_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _csignals_T_17 = 32'h17 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_19 = 32'h37 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_21 = 32'h13 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_23 = 32'h7013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_25 = 32'h6013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_27 = 32'h4013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_29 = 32'h2013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_31 = 32'h3013 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_32 = io_imem_resp_bits_inst & 32'hfc00707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_33 = 32'h1013 == _csignals_T_32; // @[Lookup.scala 31:38]
  wire  _csignals_T_35 = 32'h40005013 == _csignals_T_32; // @[Lookup.scala 31:38]
  wire  _csignals_T_37 = 32'h5013 == _csignals_T_32; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_38 = io_imem_resp_bits_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_39 = 32'h1033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_41 = 32'h33 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_43 = 32'h40000033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_45 = 32'h2033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_47 = 32'h3033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_49 = 32'h7033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_51 = 32'h6033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_53 = 32'h4033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_55 = 32'h40005033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_57 = 32'h5033 == _csignals_T_38; // @[Lookup.scala 31:38]
  wire  _csignals_T_59 = 32'h6f == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_61 = 32'h67 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_63 = 32'h63 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_65 = 32'h1063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_67 = 32'h5063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_69 = 32'h7063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_71 = 32'h4063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_73 = 32'h6063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_75 = 32'h5073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_77 = 32'h6073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_79 = 32'h1073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_81 = 32'h2073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_83 = 32'h3073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_85 = 32'h7073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_87 = 32'h73 == io_imem_resp_bits_inst; // @[Lookup.scala 31:38]
  wire  _csignals_T_89 = 32'h30200073 == io_imem_resp_bits_inst; // @[Lookup.scala 31:38]
  wire  _csignals_T_91 = 32'h7b200073 == io_imem_resp_bits_inst; // @[Lookup.scala 31:38]
  wire  _csignals_T_93 = 32'h100073 == io_imem_resp_bits_inst; // @[Lookup.scala 31:38]
  wire  _csignals_T_95 = 32'h10500073 == io_imem_resp_bits_inst; // @[Lookup.scala 31:38]
  wire  _csignals_T_97 = 32'h100f == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_99 = 32'hf == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_130 = _csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (
    _csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | (_csignals_T_59 | (
    _csignals_T_61 | (_csignals_T_63 | (_csignals_T_65 | (_csignals_T_67 | (_csignals_T_69 | (_csignals_T_71 | (
    _csignals_T_73 | (_csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81 | (_csignals_T_83 | (
    _csignals_T_85 | (_csignals_T_87 | (_csignals_T_89 | (_csignals_T_91 | (_csignals_T_93 | (_csignals_T_95 | (
    _csignals_T_97 | _csignals_T_99))))))))))))))))))))))))))))); // @[Lookup.scala 34:39]
  wire  cs_inst_val = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (
    _csignals_T_11 | (_csignals_T_13 | (_csignals_T_15 | (_csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (
    _csignals_T_23 | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (
    _csignals_T_35 | (_csignals_T_37 | _csignals_T_130)))))))))))))))))); // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_162 = _csignals_T_73 ? 4'h6 : 4'h0; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_163 = _csignals_T_71 ? 4'h5 : _csignals_T_162; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_164 = _csignals_T_69 ? 4'h4 : _csignals_T_163; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_165 = _csignals_T_67 ? 4'h3 : _csignals_T_164; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_166 = _csignals_T_65 ? 4'h1 : _csignals_T_165; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_167 = _csignals_T_63 ? 4'h2 : _csignals_T_166; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_168 = _csignals_T_61 ? 4'h8 : _csignals_T_167; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_169 = _csignals_T_59 ? 4'h7 : _csignals_T_168; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_170 = _csignals_T_57 ? 4'h0 : _csignals_T_169; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_171 = _csignals_T_55 ? 4'h0 : _csignals_T_170; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_172 = _csignals_T_53 ? 4'h0 : _csignals_T_171; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_173 = _csignals_T_51 ? 4'h0 : _csignals_T_172; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_174 = _csignals_T_49 ? 4'h0 : _csignals_T_173; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_175 = _csignals_T_47 ? 4'h0 : _csignals_T_174; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_176 = _csignals_T_45 ? 4'h0 : _csignals_T_175; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_177 = _csignals_T_43 ? 4'h0 : _csignals_T_176; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_178 = _csignals_T_41 ? 4'h0 : _csignals_T_177; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_179 = _csignals_T_39 ? 4'h0 : _csignals_T_178; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_180 = _csignals_T_37 ? 4'h0 : _csignals_T_179; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_181 = _csignals_T_35 ? 4'h0 : _csignals_T_180; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_182 = _csignals_T_33 ? 4'h0 : _csignals_T_181; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_183 = _csignals_T_31 ? 4'h0 : _csignals_T_182; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_184 = _csignals_T_29 ? 4'h0 : _csignals_T_183; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_185 = _csignals_T_27 ? 4'h0 : _csignals_T_184; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_186 = _csignals_T_25 ? 4'h0 : _csignals_T_185; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_187 = _csignals_T_23 ? 4'h0 : _csignals_T_186; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_188 = _csignals_T_21 ? 4'h0 : _csignals_T_187; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_189 = _csignals_T_19 ? 4'h0 : _csignals_T_188; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_190 = _csignals_T_17 ? 4'h0 : _csignals_T_189; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_191 = _csignals_T_15 ? 4'h0 : _csignals_T_190; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_192 = _csignals_T_13 ? 4'h0 : _csignals_T_191; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_193 = _csignals_T_11 ? 4'h0 : _csignals_T_192; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_194 = _csignals_T_9 ? 4'h0 : _csignals_T_193; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_195 = _csignals_T_7 ? 4'h0 : _csignals_T_194; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_196 = _csignals_T_5 ? 4'h0 : _csignals_T_195; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_197 = _csignals_T_3 ? 4'h0 : _csignals_T_196; // @[Lookup.scala 34:39]
  wire [3:0] cs_br_type = _csignals_T_1 ? 4'h0 : _csignals_T_197; // @[Lookup.scala 34:39]
  wire  _csignals_T_219 = _csignals_T_57 ? 1'h0 : _csignals_T_59 | _csignals_T_61; // @[Lookup.scala 34:39]
  wire  _csignals_T_220 = _csignals_T_55 ? 1'h0 : _csignals_T_219; // @[Lookup.scala 34:39]
  wire  _csignals_T_221 = _csignals_T_53 ? 1'h0 : _csignals_T_220; // @[Lookup.scala 34:39]
  wire  _csignals_T_222 = _csignals_T_51 ? 1'h0 : _csignals_T_221; // @[Lookup.scala 34:39]
  wire  _csignals_T_223 = _csignals_T_49 ? 1'h0 : _csignals_T_222; // @[Lookup.scala 34:39]
  wire  _csignals_T_224 = _csignals_T_47 ? 1'h0 : _csignals_T_223; // @[Lookup.scala 34:39]
  wire  _csignals_T_225 = _csignals_T_45 ? 1'h0 : _csignals_T_224; // @[Lookup.scala 34:39]
  wire  _csignals_T_226 = _csignals_T_43 ? 1'h0 : _csignals_T_225; // @[Lookup.scala 34:39]
  wire  _csignals_T_227 = _csignals_T_41 ? 1'h0 : _csignals_T_226; // @[Lookup.scala 34:39]
  wire  _csignals_T_228 = _csignals_T_39 ? 1'h0 : _csignals_T_227; // @[Lookup.scala 34:39]
  wire  _csignals_T_229 = _csignals_T_37 ? 1'h0 : _csignals_T_228; // @[Lookup.scala 34:39]
  wire  _csignals_T_230 = _csignals_T_35 ? 1'h0 : _csignals_T_229; // @[Lookup.scala 34:39]
  wire  _csignals_T_231 = _csignals_T_33 ? 1'h0 : _csignals_T_230; // @[Lookup.scala 34:39]
  wire  _csignals_T_232 = _csignals_T_31 ? 1'h0 : _csignals_T_231; // @[Lookup.scala 34:39]
  wire  _csignals_T_233 = _csignals_T_29 ? 1'h0 : _csignals_T_232; // @[Lookup.scala 34:39]
  wire  _csignals_T_234 = _csignals_T_27 ? 1'h0 : _csignals_T_233; // @[Lookup.scala 34:39]
  wire  _csignals_T_235 = _csignals_T_25 ? 1'h0 : _csignals_T_234; // @[Lookup.scala 34:39]
  wire  _csignals_T_236 = _csignals_T_23 ? 1'h0 : _csignals_T_235; // @[Lookup.scala 34:39]
  wire  _csignals_T_237 = _csignals_T_21 ? 1'h0 : _csignals_T_236; // @[Lookup.scala 34:39]
  wire  _csignals_T_238 = _csignals_T_19 ? 1'h0 : _csignals_T_237; // @[Lookup.scala 34:39]
  wire  _csignals_T_239 = _csignals_T_17 ? 1'h0 : _csignals_T_238; // @[Lookup.scala 34:39]
  wire  _csignals_T_240 = _csignals_T_15 ? 1'h0 : _csignals_T_239; // @[Lookup.scala 34:39]
  wire  _csignals_T_241 = _csignals_T_13 ? 1'h0 : _csignals_T_240; // @[Lookup.scala 34:39]
  wire  _csignals_T_242 = _csignals_T_11 ? 1'h0 : _csignals_T_241; // @[Lookup.scala 34:39]
  wire  _csignals_T_243 = _csignals_T_9 ? 1'h0 : _csignals_T_242; // @[Lookup.scala 34:39]
  wire  _csignals_T_244 = _csignals_T_7 ? 1'h0 : _csignals_T_243; // @[Lookup.scala 34:39]
  wire  _csignals_T_245 = _csignals_T_5 ? 1'h0 : _csignals_T_244; // @[Lookup.scala 34:39]
  wire  _csignals_T_246 = _csignals_T_3 ? 1'h0 : _csignals_T_245; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_254 = _csignals_T_85 ? 2'h2 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_255 = _csignals_T_83 ? 2'h0 : _csignals_T_254; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_256 = _csignals_T_81 ? 2'h0 : _csignals_T_255; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_257 = _csignals_T_79 ? 2'h0 : _csignals_T_256; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_258 = _csignals_T_77 ? 2'h2 : _csignals_T_257; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_259 = _csignals_T_75 ? 2'h2 : _csignals_T_258; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_260 = _csignals_T_73 ? 2'h0 : _csignals_T_259; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_261 = _csignals_T_71 ? 2'h0 : _csignals_T_260; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_262 = _csignals_T_69 ? 2'h0 : _csignals_T_261; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_263 = _csignals_T_67 ? 2'h0 : _csignals_T_262; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_264 = _csignals_T_65 ? 2'h0 : _csignals_T_263; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_265 = _csignals_T_63 ? 2'h0 : _csignals_T_264; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_266 = _csignals_T_61 ? 2'h0 : _csignals_T_265; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_267 = _csignals_T_59 ? 2'h0 : _csignals_T_266; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_268 = _csignals_T_57 ? 2'h0 : _csignals_T_267; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_269 = _csignals_T_55 ? 2'h0 : _csignals_T_268; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_270 = _csignals_T_53 ? 2'h0 : _csignals_T_269; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_271 = _csignals_T_51 ? 2'h0 : _csignals_T_270; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_272 = _csignals_T_49 ? 2'h0 : _csignals_T_271; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_273 = _csignals_T_47 ? 2'h0 : _csignals_T_272; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_274 = _csignals_T_45 ? 2'h0 : _csignals_T_273; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_275 = _csignals_T_43 ? 2'h0 : _csignals_T_274; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_276 = _csignals_T_41 ? 2'h0 : _csignals_T_275; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_277 = _csignals_T_39 ? 2'h0 : _csignals_T_276; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_278 = _csignals_T_37 ? 2'h0 : _csignals_T_277; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_279 = _csignals_T_35 ? 2'h0 : _csignals_T_278; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_280 = _csignals_T_33 ? 2'h0 : _csignals_T_279; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_281 = _csignals_T_31 ? 2'h0 : _csignals_T_280; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_282 = _csignals_T_29 ? 2'h0 : _csignals_T_281; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_283 = _csignals_T_27 ? 2'h0 : _csignals_T_282; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_284 = _csignals_T_25 ? 2'h0 : _csignals_T_283; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_285 = _csignals_T_23 ? 2'h0 : _csignals_T_284; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_286 = _csignals_T_21 ? 2'h0 : _csignals_T_285; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_287 = _csignals_T_19 ? 2'h1 : _csignals_T_286; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_288 = _csignals_T_17 ? 2'h1 : _csignals_T_287; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_289 = _csignals_T_15 ? 2'h0 : _csignals_T_288; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_290 = _csignals_T_13 ? 2'h0 : _csignals_T_289; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_291 = _csignals_T_11 ? 2'h0 : _csignals_T_290; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_292 = _csignals_T_9 ? 2'h0 : _csignals_T_291; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_293 = _csignals_T_7 ? 2'h0 : _csignals_T_292; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_294 = _csignals_T_5 ? 2'h0 : _csignals_T_293; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_295 = _csignals_T_3 ? 2'h0 : _csignals_T_294; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_315 = _csignals_T_61 ? 2'h1 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_316 = _csignals_T_59 ? 2'h0 : _csignals_T_315; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_317 = _csignals_T_57 ? 2'h0 : _csignals_T_316; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_318 = _csignals_T_55 ? 2'h0 : _csignals_T_317; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_319 = _csignals_T_53 ? 2'h0 : _csignals_T_318; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_320 = _csignals_T_51 ? 2'h0 : _csignals_T_319; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_321 = _csignals_T_49 ? 2'h0 : _csignals_T_320; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_322 = _csignals_T_47 ? 2'h0 : _csignals_T_321; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_323 = _csignals_T_45 ? 2'h0 : _csignals_T_322; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_324 = _csignals_T_43 ? 2'h0 : _csignals_T_323; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_325 = _csignals_T_41 ? 2'h0 : _csignals_T_324; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_326 = _csignals_T_39 ? 2'h0 : _csignals_T_325; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_327 = _csignals_T_37 ? 2'h1 : _csignals_T_326; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_328 = _csignals_T_35 ? 2'h1 : _csignals_T_327; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_329 = _csignals_T_33 ? 2'h1 : _csignals_T_328; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_330 = _csignals_T_31 ? 2'h1 : _csignals_T_329; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_331 = _csignals_T_29 ? 2'h1 : _csignals_T_330; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_332 = _csignals_T_27 ? 2'h1 : _csignals_T_331; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_333 = _csignals_T_25 ? 2'h1 : _csignals_T_332; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_334 = _csignals_T_23 ? 2'h1 : _csignals_T_333; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_335 = _csignals_T_21 ? 2'h1 : _csignals_T_334; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_336 = _csignals_T_19 ? 2'h0 : _csignals_T_335; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_337 = _csignals_T_17 ? 2'h3 : _csignals_T_336; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_338 = _csignals_T_15 ? 2'h2 : _csignals_T_337; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_339 = _csignals_T_13 ? 2'h2 : _csignals_T_338; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_340 = _csignals_T_11 ? 2'h2 : _csignals_T_339; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_341 = _csignals_T_9 ? 2'h1 : _csignals_T_340; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_342 = _csignals_T_7 ? 2'h1 : _csignals_T_341; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_343 = _csignals_T_5 ? 2'h1 : _csignals_T_342; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_344 = _csignals_T_3 ? 2'h1 : _csignals_T_343; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_352 = _csignals_T_85 ? 4'h8 : 4'h0; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_353 = _csignals_T_83 ? 4'h8 : _csignals_T_352; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_354 = _csignals_T_81 ? 4'h8 : _csignals_T_353; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_355 = _csignals_T_79 ? 4'h8 : _csignals_T_354; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_356 = _csignals_T_77 ? 4'h8 : _csignals_T_355; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_357 = _csignals_T_75 ? 4'h8 : _csignals_T_356; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_358 = _csignals_T_73 ? 4'h0 : _csignals_T_357; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_359 = _csignals_T_71 ? 4'h0 : _csignals_T_358; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_360 = _csignals_T_69 ? 4'h0 : _csignals_T_359; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_361 = _csignals_T_67 ? 4'h0 : _csignals_T_360; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_362 = _csignals_T_65 ? 4'h0 : _csignals_T_361; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_363 = _csignals_T_63 ? 4'h0 : _csignals_T_362; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_364 = _csignals_T_61 ? 4'h0 : _csignals_T_363; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_365 = _csignals_T_59 ? 4'h0 : _csignals_T_364; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_366 = _csignals_T_57 ? 4'h5 : _csignals_T_365; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_367 = _csignals_T_55 ? 4'hb : _csignals_T_366; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_368 = _csignals_T_53 ? 4'h4 : _csignals_T_367; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_369 = _csignals_T_51 ? 4'h6 : _csignals_T_368; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_370 = _csignals_T_49 ? 4'h7 : _csignals_T_369; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_371 = _csignals_T_47 ? 4'he : _csignals_T_370; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_372 = _csignals_T_45 ? 4'hc : _csignals_T_371; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_373 = _csignals_T_43 ? 4'ha : _csignals_T_372; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_374 = _csignals_T_41 ? 4'h0 : _csignals_T_373; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_375 = _csignals_T_39 ? 4'h1 : _csignals_T_374; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_376 = _csignals_T_37 ? 4'h5 : _csignals_T_375; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_377 = _csignals_T_35 ? 4'hb : _csignals_T_376; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_378 = _csignals_T_33 ? 4'h1 : _csignals_T_377; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_379 = _csignals_T_31 ? 4'he : _csignals_T_378; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_380 = _csignals_T_29 ? 4'hc : _csignals_T_379; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_381 = _csignals_T_27 ? 4'h4 : _csignals_T_380; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_382 = _csignals_T_25 ? 4'h6 : _csignals_T_381; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_383 = _csignals_T_23 ? 4'h7 : _csignals_T_382; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_384 = _csignals_T_21 ? 4'h0 : _csignals_T_383; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_385 = _csignals_T_19 ? 4'h8 : _csignals_T_384; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_386 = _csignals_T_17 ? 4'h0 : _csignals_T_385; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_387 = _csignals_T_15 ? 4'h0 : _csignals_T_386; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_388 = _csignals_T_13 ? 4'h0 : _csignals_T_387; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_389 = _csignals_T_11 ? 4'h0 : _csignals_T_388; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_390 = _csignals_T_9 ? 4'h0 : _csignals_T_389; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_391 = _csignals_T_7 ? 4'h0 : _csignals_T_390; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_392 = _csignals_T_5 ? 4'h0 : _csignals_T_391; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_393 = _csignals_T_3 ? 4'h0 : _csignals_T_392; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_401 = _csignals_T_85 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_402 = _csignals_T_83 ? 2'h3 : _csignals_T_401; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_403 = _csignals_T_81 ? 2'h3 : _csignals_T_402; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_404 = _csignals_T_79 ? 2'h3 : _csignals_T_403; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_405 = _csignals_T_77 ? 2'h3 : _csignals_T_404; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_406 = _csignals_T_75 ? 2'h3 : _csignals_T_405; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_407 = _csignals_T_73 ? 2'h0 : _csignals_T_406; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_408 = _csignals_T_71 ? 2'h0 : _csignals_T_407; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_409 = _csignals_T_69 ? 2'h0 : _csignals_T_408; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_410 = _csignals_T_67 ? 2'h0 : _csignals_T_409; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_411 = _csignals_T_65 ? 2'h0 : _csignals_T_410; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_412 = _csignals_T_63 ? 2'h0 : _csignals_T_411; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_413 = _csignals_T_61 ? 2'h2 : _csignals_T_412; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_414 = _csignals_T_59 ? 2'h2 : _csignals_T_413; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_415 = _csignals_T_57 ? 2'h0 : _csignals_T_414; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_416 = _csignals_T_55 ? 2'h0 : _csignals_T_415; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_417 = _csignals_T_53 ? 2'h0 : _csignals_T_416; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_418 = _csignals_T_51 ? 2'h0 : _csignals_T_417; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_419 = _csignals_T_49 ? 2'h0 : _csignals_T_418; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_420 = _csignals_T_47 ? 2'h0 : _csignals_T_419; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_421 = _csignals_T_45 ? 2'h0 : _csignals_T_420; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_422 = _csignals_T_43 ? 2'h0 : _csignals_T_421; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_423 = _csignals_T_41 ? 2'h0 : _csignals_T_422; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_424 = _csignals_T_39 ? 2'h0 : _csignals_T_423; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_425 = _csignals_T_37 ? 2'h0 : _csignals_T_424; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_426 = _csignals_T_35 ? 2'h0 : _csignals_T_425; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_427 = _csignals_T_33 ? 2'h0 : _csignals_T_426; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_428 = _csignals_T_31 ? 2'h0 : _csignals_T_427; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_429 = _csignals_T_29 ? 2'h0 : _csignals_T_428; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_430 = _csignals_T_27 ? 2'h0 : _csignals_T_429; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_431 = _csignals_T_25 ? 2'h0 : _csignals_T_430; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_432 = _csignals_T_23 ? 2'h0 : _csignals_T_431; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_433 = _csignals_T_21 ? 2'h0 : _csignals_T_432; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_434 = _csignals_T_19 ? 2'h0 : _csignals_T_433; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_435 = _csignals_T_17 ? 2'h0 : _csignals_T_434; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_436 = _csignals_T_15 ? 2'h0 : _csignals_T_435; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_437 = _csignals_T_13 ? 2'h0 : _csignals_T_436; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_438 = _csignals_T_11 ? 2'h0 : _csignals_T_437; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_439 = _csignals_T_9 ? 2'h1 : _csignals_T_438; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_440 = _csignals_T_7 ? 2'h1 : _csignals_T_439; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_441 = _csignals_T_5 ? 2'h1 : _csignals_T_440; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_442 = _csignals_T_3 ? 2'h1 : _csignals_T_441; // @[Lookup.scala 34:39]
  wire  _csignals_T_456 = _csignals_T_73 ? 1'h0 : _csignals_T_75 | (_csignals_T_77 | (_csignals_T_79 | (_csignals_T_81
     | (_csignals_T_83 | _csignals_T_85)))); // @[Lookup.scala 34:39]
  wire  _csignals_T_457 = _csignals_T_71 ? 1'h0 : _csignals_T_456; // @[Lookup.scala 34:39]
  wire  _csignals_T_458 = _csignals_T_69 ? 1'h0 : _csignals_T_457; // @[Lookup.scala 34:39]
  wire  _csignals_T_459 = _csignals_T_67 ? 1'h0 : _csignals_T_458; // @[Lookup.scala 34:39]
  wire  _csignals_T_460 = _csignals_T_65 ? 1'h0 : _csignals_T_459; // @[Lookup.scala 34:39]
  wire  _csignals_T_461 = _csignals_T_63 ? 1'h0 : _csignals_T_460; // @[Lookup.scala 34:39]
  wire  _csignals_T_485 = _csignals_T_15 ? 1'h0 : _csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (_csignals_T_23
     | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (
    _csignals_T_37 | (_csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (
    _csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | (_csignals_T_59 | (
    _csignals_T_61 | _csignals_T_461)))))))))))))))))))))); // @[Lookup.scala 34:39]
  wire  _csignals_T_486 = _csignals_T_13 ? 1'h0 : _csignals_T_485; // @[Lookup.scala 34:39]
  wire  _csignals_T_487 = _csignals_T_11 ? 1'h0 : _csignals_T_486; // @[Lookup.scala 34:39]
  wire  cs0_2 = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | _csignals_T_487)))); // @[Lookup.scala 34:39]
  wire  _csignals_T_534 = _csignals_T_15 ? 1'h0 : _csignals_T_17 | (_csignals_T_19 | (_csignals_T_21 | (_csignals_T_23
     | (_csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 | (_csignals_T_33 | (_csignals_T_35 | (
    _csignals_T_37 | (_csignals_T_39 | (_csignals_T_41 | (_csignals_T_43 | (_csignals_T_45 | (_csignals_T_47 | (
    _csignals_T_49 | (_csignals_T_51 | (_csignals_T_53 | (_csignals_T_55 | (_csignals_T_57 | _csignals_T_59)))))))))))))
    ))))))); // @[Lookup.scala 34:39]
  wire  _csignals_T_535 = _csignals_T_13 ? 1'h0 : _csignals_T_534; // @[Lookup.scala 34:39]
  wire  _csignals_T_536 = _csignals_T_11 ? 1'h0 : _csignals_T_535; // @[Lookup.scala 34:39]
  wire  _csignals_T_537 = _csignals_T_9 ? 1'h0 : _csignals_T_536; // @[Lookup.scala 34:39]
  wire  _csignals_T_538 = _csignals_T_7 ? 1'h0 : _csignals_T_537; // @[Lookup.scala 34:39]
  wire  _csignals_T_539 = _csignals_T_5 ? 1'h0 : _csignals_T_538; // @[Lookup.scala 34:39]
  wire  _csignals_T_540 = _csignals_T_3 ? 1'h0 : _csignals_T_539; // @[Lookup.scala 34:39]
  wire  cs0_4 = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11 | (
    _csignals_T_13 | _csignals_T_15)))))); // @[Lookup.scala 34:39]
  wire  _csignals_T_635 = _csignals_T_9 ? 1'h0 : _csignals_T_11 | (_csignals_T_13 | _csignals_T_15); // @[Lookup.scala 34:39]
  wire  _csignals_T_636 = _csignals_T_7 ? 1'h0 : _csignals_T_635; // @[Lookup.scala 34:39]
  wire  _csignals_T_637 = _csignals_T_5 ? 1'h0 : _csignals_T_636; // @[Lookup.scala 34:39]
  wire  _csignals_T_638 = _csignals_T_3 ? 1'h0 : _csignals_T_637; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_681 = _csignals_T_15 ? 3'h2 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_682 = _csignals_T_13 ? 3'h1 : _csignals_T_681; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_683 = _csignals_T_11 ? 3'h3 : _csignals_T_682; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_684 = _csignals_T_9 ? 3'h6 : _csignals_T_683; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_685 = _csignals_T_7 ? 3'h2 : _csignals_T_684; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_686 = _csignals_T_5 ? 3'h5 : _csignals_T_685; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_687 = _csignals_T_3 ? 3'h1 : _csignals_T_686; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_690 = _csignals_T_95 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_691 = _csignals_T_93 ? 3'h4 : _csignals_T_690; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_692 = _csignals_T_91 ? 3'h4 : _csignals_T_691; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_693 = _csignals_T_89 ? 3'h4 : _csignals_T_692; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_694 = _csignals_T_87 ? 3'h4 : _csignals_T_693; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_695 = _csignals_T_85 ? 3'h7 : _csignals_T_694; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_696 = _csignals_T_83 ? 3'h7 : _csignals_T_695; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_697 = _csignals_T_81 ? 3'h6 : _csignals_T_696; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_698 = _csignals_T_79 ? 3'h5 : _csignals_T_697; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_699 = _csignals_T_77 ? 3'h6 : _csignals_T_698; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_700 = _csignals_T_75 ? 3'h5 : _csignals_T_699; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_701 = _csignals_T_73 ? 3'h0 : _csignals_T_700; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_702 = _csignals_T_71 ? 3'h0 : _csignals_T_701; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_703 = _csignals_T_69 ? 3'h0 : _csignals_T_702; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_704 = _csignals_T_67 ? 3'h0 : _csignals_T_703; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_705 = _csignals_T_65 ? 3'h0 : _csignals_T_704; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_706 = _csignals_T_63 ? 3'h0 : _csignals_T_705; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_707 = _csignals_T_61 ? 3'h0 : _csignals_T_706; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_708 = _csignals_T_59 ? 3'h0 : _csignals_T_707; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_709 = _csignals_T_57 ? 3'h0 : _csignals_T_708; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_710 = _csignals_T_55 ? 3'h0 : _csignals_T_709; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_711 = _csignals_T_53 ? 3'h0 : _csignals_T_710; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_712 = _csignals_T_51 ? 3'h0 : _csignals_T_711; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_713 = _csignals_T_49 ? 3'h0 : _csignals_T_712; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_714 = _csignals_T_47 ? 3'h0 : _csignals_T_713; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_715 = _csignals_T_45 ? 3'h0 : _csignals_T_714; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_716 = _csignals_T_43 ? 3'h0 : _csignals_T_715; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_717 = _csignals_T_41 ? 3'h0 : _csignals_T_716; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_718 = _csignals_T_39 ? 3'h0 : _csignals_T_717; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_719 = _csignals_T_37 ? 3'h0 : _csignals_T_718; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_720 = _csignals_T_35 ? 3'h0 : _csignals_T_719; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_721 = _csignals_T_33 ? 3'h0 : _csignals_T_720; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_722 = _csignals_T_31 ? 3'h0 : _csignals_T_721; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_723 = _csignals_T_29 ? 3'h0 : _csignals_T_722; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_724 = _csignals_T_27 ? 3'h0 : _csignals_T_723; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_725 = _csignals_T_25 ? 3'h0 : _csignals_T_724; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_726 = _csignals_T_23 ? 3'h0 : _csignals_T_725; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_727 = _csignals_T_21 ? 3'h0 : _csignals_T_726; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_728 = _csignals_T_19 ? 3'h0 : _csignals_T_727; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_729 = _csignals_T_17 ? 3'h0 : _csignals_T_728; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_730 = _csignals_T_15 ? 3'h0 : _csignals_T_729; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_731 = _csignals_T_13 ? 3'h0 : _csignals_T_730; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_732 = _csignals_T_11 ? 3'h0 : _csignals_T_731; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_733 = _csignals_T_9 ? 3'h0 : _csignals_T_732; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_734 = _csignals_T_7 ? 3'h0 : _csignals_T_733; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_735 = _csignals_T_5 ? 3'h0 : _csignals_T_734; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_736 = _csignals_T_3 ? 3'h0 : _csignals_T_735; // @[Lookup.scala 34:39]
  wire [2:0] cs0_7 = _csignals_T_1 ? 3'h0 : _csignals_T_736; // @[Lookup.scala 34:39]
  wire [2:0] _ctrl_pc_sel_T_3 = ~io_dat_br_eq ? 3'h1 : 3'h0; // @[cpath.scala 140:53]
  wire [2:0] _ctrl_pc_sel_T_5 = io_dat_br_eq ? 3'h1 : 3'h0; // @[cpath.scala 141:53]
  wire [2:0] _ctrl_pc_sel_T_8 = ~io_dat_br_lt ? 3'h1 : 3'h0; // @[cpath.scala 142:53]
  wire [2:0] _ctrl_pc_sel_T_11 = ~io_dat_br_ltu ? 3'h1 : 3'h0; // @[cpath.scala 143:53]
  wire [2:0] _ctrl_pc_sel_T_13 = io_dat_br_lt ? 3'h1 : 3'h0; // @[cpath.scala 144:53]
  wire [2:0] _ctrl_pc_sel_T_15 = io_dat_br_ltu ? 3'h1 : 3'h0; // @[cpath.scala 145:53]
  wire [2:0] _ctrl_pc_sel_T_18 = cs_br_type == 4'h8 ? 3'h3 : 3'h0; // @[cpath.scala 147:25]
  wire [2:0] _ctrl_pc_sel_T_19 = cs_br_type == 4'h7 ? 3'h2 : _ctrl_pc_sel_T_18; // @[cpath.scala 146:25]
  wire [2:0] _ctrl_pc_sel_T_20 = cs_br_type == 4'h6 ? _ctrl_pc_sel_T_15 : _ctrl_pc_sel_T_19; // @[cpath.scala 145:25]
  wire [2:0] _ctrl_pc_sel_T_21 = cs_br_type == 4'h5 ? _ctrl_pc_sel_T_13 : _ctrl_pc_sel_T_20; // @[cpath.scala 144:25]
  wire [2:0] _ctrl_pc_sel_T_22 = cs_br_type == 4'h4 ? _ctrl_pc_sel_T_11 : _ctrl_pc_sel_T_21; // @[cpath.scala 143:25]
  wire [2:0] _ctrl_pc_sel_T_23 = cs_br_type == 4'h3 ? _ctrl_pc_sel_T_8 : _ctrl_pc_sel_T_22; // @[cpath.scala 142:25]
  wire [2:0] _ctrl_pc_sel_T_24 = cs_br_type == 4'h2 ? _ctrl_pc_sel_T_5 : _ctrl_pc_sel_T_23; // @[cpath.scala 141:25]
  wire [2:0] _ctrl_pc_sel_T_25 = cs_br_type == 4'h1 ? _ctrl_pc_sel_T_3 : _ctrl_pc_sel_T_24; // @[cpath.scala 140:25]
  wire [2:0] _ctrl_pc_sel_T_26 = cs_br_type == 4'h0 ? 3'h0 : _ctrl_pc_sel_T_25; // @[cpath.scala 139:25]
  wire  take_evec = io_ctl_exception | io_dat_csr_eret | io_dat_csr_interrupt; // @[cpath.scala 199:60]
  wire [2:0] ctrl_pc_sel = take_evec ? 3'h4 : _ctrl_pc_sel_T_26; // @[cpath.scala 138:25]
  wire  _io_ctl_rf_wen_T = ~io_imem_resp_valid; // @[cpath.scala 161:29]
  wire [4:0] rs1_addr = io_imem_resp_bits_inst[19:15]; // @[cpath.scala 164:41]
  wire  csr_ren = (cs0_7 == 3'h6 | cs0_7 == 3'h7) & rs1_addr == 5'h0; // @[cpath.scala 165:65]
  wire [2:0] csr_cmd = csr_ren ? 3'h2 : cs0_7; // @[cpath.scala 166:21]
  wire  exe_illegal = ~cs_inst_val & io_imem_resp_valid; // @[cpath.scala 181:35]
  reg  wb_reg_illegal; // @[cpath.scala 184:32]
  reg  wb_reg_data_misaligned; // @[cpath.scala 185:40]
  reg  wb_reg_inst_misaligned; // @[cpath.scala 186:40]
  reg  wb_reg_mem_fcn; // @[cpath.scala 187:32]
  wire [2:0] _io_ctl_exception_cause_T_1 = wb_reg_mem_fcn ? 3'h6 : 3'h4; // @[cpath.scala 204:34]
  wire [2:0] _io_ctl_exception_cause_T_2 = wb_reg_inst_misaligned ? 3'h0 : _io_ctl_exception_cause_T_1; // @[cpath.scala 203:34]
  wire [2:0] _io_ctl_exception_cause_T_3 = wb_reg_illegal ? 3'h2 : _io_ctl_exception_cause_T_2; // @[cpath.scala 202:34]
  assign io_imem_req_valid = ~(ctrl_pc_sel == 3'h0) & io_imem_resp_valid & ~io_dat_wb_hazard_stall | ctrl_pc_sel == 3'h4
    ; // @[cpath.scala 151:93]
  assign io_imem_exe_kill = io_ctl_exception | io_dat_csr_eret | io_dat_csr_interrupt; // @[cpath.scala 199:60]
  assign io_ctl_exe_kill = io_ctl_exception | io_dat_csr_eret | io_dat_csr_interrupt; // @[cpath.scala 199:60]
  assign io_ctl_pc_sel = take_evec ? 3'h4 : _ctrl_pc_sel_T_26; // @[cpath.scala 138:25]
  assign io_ctl_brjmp_sel = _csignals_T_1 ? 1'h0 : _csignals_T_246; // @[Lookup.scala 34:39]
  assign io_ctl_op1_sel = _csignals_T_1 ? 2'h0 : _csignals_T_295; // @[Lookup.scala 34:39]
  assign io_ctl_op2_sel = _csignals_T_1 ? 2'h1 : _csignals_T_344; // @[Lookup.scala 34:39]
  assign io_ctl_alu_fun = _csignals_T_1 ? 4'h0 : _csignals_T_393; // @[Lookup.scala 34:39]
  assign io_ctl_wb_sel = _csignals_T_1 ? 2'h1 : _csignals_T_442; // @[Lookup.scala 34:39]
  assign io_ctl_rf_wen = ~io_imem_resp_valid ? 1'h0 : cs0_2; // @[cpath.scala 161:28]
  assign io_ctl_bypassable = _csignals_T_1 ? 1'h0 : _csignals_T_540; // @[Lookup.scala 34:39]
  assign io_ctl_csr_cmd = _io_ctl_rf_wen_T ? 3'h0 : csr_cmd; // @[cpath.scala 167:28]
  assign io_ctl_dmem_val = cs0_4 & io_imem_resp_valid; // @[cpath.scala 173:38]
  assign io_ctl_dmem_fcn = _csignals_T_1 ? 1'h0 : _csignals_T_638; // @[Lookup.scala 34:39]
  assign io_ctl_dmem_typ = _csignals_T_1 ? 3'h3 : _csignals_T_687; // @[Lookup.scala 34:39]
  assign io_ctl_exception = (wb_reg_illegal | wb_reg_inst_misaligned | wb_reg_data_misaligned) & ~io_dat_csr_eret; // @[cpath.scala 201:93]
  assign io_ctl_exception_cause = {{29'd0}, _io_ctl_exception_cause_T_3}; // @[cpath.scala 202:27]
  always @(posedge clock) begin
    if (reset) begin // @[cpath.scala 184:32]
      wb_reg_illegal <= 1'h0; // @[cpath.scala 184:32]
    end else if (io_dat_wb_hazard_stall | io_ctl_exe_kill) begin // @[cpath.scala 192:53]
      wb_reg_illegal <= 1'h0; // @[cpath.scala 193:22]
    end else begin
      wb_reg_illegal <= exe_illegal; // @[cpath.scala 188:19]
    end
    if (reset) begin // @[cpath.scala 185:40]
      wb_reg_data_misaligned <= 1'h0; // @[cpath.scala 185:40]
    end else if (io_dat_wb_hazard_stall | io_ctl_exe_kill) begin // @[cpath.scala 192:53]
      wb_reg_data_misaligned <= 1'h0; // @[cpath.scala 194:30]
    end else begin
      wb_reg_data_misaligned <= io_dat_data_misaligned; // @[cpath.scala 189:27]
    end
    if (reset) begin // @[cpath.scala 186:40]
      wb_reg_inst_misaligned <= 1'h0; // @[cpath.scala 186:40]
    end else if (io_dat_wb_hazard_stall | io_ctl_exe_kill) begin // @[cpath.scala 192:53]
      wb_reg_inst_misaligned <= 1'h0; // @[cpath.scala 195:30]
    end else begin
      wb_reg_inst_misaligned <= io_dat_inst_misaligned; // @[cpath.scala 190:27]
    end
    if (reset) begin // @[cpath.scala 187:32]
      wb_reg_mem_fcn <= 1'h0; // @[cpath.scala 187:32]
    end else if (io_dat_wb_hazard_stall | io_ctl_exe_kill) begin // @[cpath.scala 192:53]
      wb_reg_mem_fcn <= 1'h0; // @[cpath.scala 196:22]
    end else if (_csignals_T_1) begin // @[Lookup.scala 34:39]
      wb_reg_mem_fcn <= 1'h0;
    end else if (_csignals_T_3) begin // @[Lookup.scala 34:39]
      wb_reg_mem_fcn <= 1'h0;
    end else begin
      wb_reg_mem_fcn <= _csignals_T_637;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  wb_reg_illegal = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  wb_reg_data_misaligned = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  wb_reg_inst_misaligned = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  wb_reg_mem_fcn = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule