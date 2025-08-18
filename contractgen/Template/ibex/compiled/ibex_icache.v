// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_icache (
	clk_i,
	rst_ni,
	req_i,
	branch_i,
	branch_spec_i,
	predicted_branch_i,
	branch_mispredict_i,
	addr_i,
	ready_i,
	valid_o,
	rdata_o,
	addr_o,
	err_o,
	err_plus2_o,
	instr_req_o,
	instr_gnt_i,
	instr_addr_o,
	instr_rdata_i,
	instr_err_i,
	instr_pmp_err_i,
	instr_rvalid_i,
	icache_enable_i,
	icache_inval_i,
	busy_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_icache.sv:14:13
	parameter [0:0] BranchPredictor = 1'b0;
	// Trace: core/rtl/ibex_icache.sv:16:13
	parameter [31:0] BusWidth = 32;
	// Trace: core/rtl/ibex_icache.sv:17:13
	parameter [31:0] CacheSizeBytes = 4096;
	// Trace: core/rtl/ibex_icache.sv:18:13
	parameter [0:0] ICacheECC = 1'b0;
	// Trace: core/rtl/ibex_icache.sv:19:13
	parameter [31:0] LineSize = 64;
	// Trace: core/rtl/ibex_icache.sv:20:13
	parameter [31:0] NumWays = 2;
	// Trace: core/rtl/ibex_icache.sv:22:13
	parameter [0:0] BranchCache = 1'b0;
	// Trace: core/rtl/ibex_icache.sv:25:5
	input wire clk_i;
	// Trace: core/rtl/ibex_icache.sv:26:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_icache.sv:29:5
	input wire req_i;
	// Trace: core/rtl/ibex_icache.sv:32:5
	input wire branch_i;
	// Trace: core/rtl/ibex_icache.sv:33:5
	input wire branch_spec_i;
	// Trace: core/rtl/ibex_icache.sv:34:5
	input wire predicted_branch_i;
	// Trace: core/rtl/ibex_icache.sv:35:5
	input wire branch_mispredict_i;
	// Trace: core/rtl/ibex_icache.sv:36:5
	input wire [31:0] addr_i;
	// Trace: core/rtl/ibex_icache.sv:39:5
	input wire ready_i;
	// Trace: core/rtl/ibex_icache.sv:40:5
	output wire valid_o;
	// Trace: core/rtl/ibex_icache.sv:41:5
	output wire [31:0] rdata_o;
	// Trace: core/rtl/ibex_icache.sv:42:5
	output wire [31:0] addr_o;
	// Trace: core/rtl/ibex_icache.sv:43:5
	output wire err_o;
	// Trace: core/rtl/ibex_icache.sv:44:5
	output wire err_plus2_o;
	// Trace: core/rtl/ibex_icache.sv:47:5
	output wire instr_req_o;
	// Trace: core/rtl/ibex_icache.sv:48:5
	input wire instr_gnt_i;
	// Trace: core/rtl/ibex_icache.sv:49:5
	output wire [31:0] instr_addr_o;
	// Trace: core/rtl/ibex_icache.sv:50:5
	input wire [BusWidth - 1:0] instr_rdata_i;
	// Trace: core/rtl/ibex_icache.sv:51:5
	input wire instr_err_i;
	// Trace: core/rtl/ibex_icache.sv:52:5
	input wire instr_pmp_err_i;
	// Trace: core/rtl/ibex_icache.sv:53:5
	input wire instr_rvalid_i;
	// Trace: core/rtl/ibex_icache.sv:56:5
	input wire icache_enable_i;
	// Trace: core/rtl/ibex_icache.sv:57:5
	input wire icache_inval_i;
	// Trace: core/rtl/ibex_icache.sv:58:5
	output wire busy_o;
	// Trace: core/rtl/ibex_icache.sv:61:3
	localparam [31:0] ADDR_W = 32;
	// Trace: core/rtl/ibex_icache.sv:63:3
	localparam [31:0] NUM_FB = 4;
	// Trace: core/rtl/ibex_icache.sv:65:3
	localparam [31:0] FB_THRESHOLD = 2;
	// Trace: core/rtl/ibex_icache.sv:67:3
	localparam [31:0] LINE_SIZE_ECC = (ICacheECC ? LineSize + 8 : LineSize);
	// Trace: core/rtl/ibex_icache.sv:68:3
	localparam [31:0] LINE_SIZE_BYTES = LineSize / 8;
	// Trace: core/rtl/ibex_icache.sv:69:3
	localparam [31:0] LINE_W = $clog2(LINE_SIZE_BYTES);
	// Trace: core/rtl/ibex_icache.sv:70:3
	localparam [31:0] BUS_BYTES = BusWidth / 8;
	// Trace: core/rtl/ibex_icache.sv:71:3
	localparam [31:0] BUS_W = $clog2(BUS_BYTES);
	// Trace: core/rtl/ibex_icache.sv:72:3
	localparam [31:0] LINE_BEATS = LINE_SIZE_BYTES / BUS_BYTES;
	// Trace: core/rtl/ibex_icache.sv:73:3
	localparam [31:0] LINE_BEATS_W = $clog2(LINE_BEATS);
	// Trace: core/rtl/ibex_icache.sv:74:3
	localparam [31:0] NUM_LINES = (CacheSizeBytes / NumWays) / LINE_SIZE_BYTES;
	// Trace: core/rtl/ibex_icache.sv:75:3
	localparam [31:0] INDEX_W = $clog2(NUM_LINES);
	// Trace: core/rtl/ibex_icache.sv:76:3
	localparam [31:0] INDEX_HI = (INDEX_W + LINE_W) - 1;
	// Trace: core/rtl/ibex_icache.sv:77:3
	localparam [31:0] TAG_SIZE = ((ADDR_W - INDEX_W) - LINE_W) + 1;
	// Trace: core/rtl/ibex_icache.sv:78:3
	localparam [31:0] TAG_SIZE_ECC = (ICacheECC ? TAG_SIZE + 6 : TAG_SIZE);
	// Trace: core/rtl/ibex_icache.sv:79:3
	localparam [31:0] OUTPUT_BEATS = BUS_BYTES / 2;
	// Trace: core/rtl/ibex_icache.sv:82:3
	wire [31:0] lookup_addr_aligned;
	// Trace: core/rtl/ibex_icache.sv:83:3
	wire [31:0] branch_mispredict_addr;
	// Trace: core/rtl/ibex_icache.sv:84:3
	wire [31:0] prefetch_addr_d;
	reg [31:0] prefetch_addr_q;
	// Trace: core/rtl/ibex_icache.sv:85:3
	wire prefetch_addr_en;
	// Trace: core/rtl/ibex_icache.sv:86:3
	wire branch_or_mispredict;
	// Trace: core/rtl/ibex_icache.sv:88:3
	wire branch_suppress;
	// Trace: core/rtl/ibex_icache.sv:89:3
	wire lookup_throttle;
	// Trace: core/rtl/ibex_icache.sv:90:3
	wire lookup_req_ic0;
	// Trace: core/rtl/ibex_icache.sv:91:3
	wire [31:0] lookup_addr_ic0;
	// Trace: core/rtl/ibex_icache.sv:92:3
	wire [INDEX_W - 1:0] lookup_index_ic0;
	// Trace: core/rtl/ibex_icache.sv:93:3
	wire fill_req_ic0;
	// Trace: core/rtl/ibex_icache.sv:94:3
	wire [INDEX_W - 1:0] fill_index_ic0;
	// Trace: core/rtl/ibex_icache.sv:95:3
	wire [TAG_SIZE - 1:0] fill_tag_ic0;
	// Trace: core/rtl/ibex_icache.sv:96:3
	wire [LineSize - 1:0] fill_wdata_ic0;
	// Trace: core/rtl/ibex_icache.sv:97:3
	wire lookup_grant_ic0;
	// Trace: core/rtl/ibex_icache.sv:98:3
	wire lookup_actual_ic0;
	// Trace: core/rtl/ibex_icache.sv:99:3
	wire fill_grant_ic0;
	// Trace: core/rtl/ibex_icache.sv:100:3
	wire tag_req_ic0;
	// Trace: core/rtl/ibex_icache.sv:101:3
	wire [INDEX_W - 1:0] tag_index_ic0;
	// Trace: core/rtl/ibex_icache.sv:102:3
	wire [NumWays - 1:0] tag_banks_ic0;
	// Trace: core/rtl/ibex_icache.sv:103:3
	wire tag_write_ic0;
	// Trace: core/rtl/ibex_icache.sv:104:3
	wire [TAG_SIZE_ECC - 1:0] tag_wdata_ic0;
	// Trace: core/rtl/ibex_icache.sv:105:3
	wire data_req_ic0;
	// Trace: core/rtl/ibex_icache.sv:106:3
	wire [INDEX_W - 1:0] data_index_ic0;
	// Trace: core/rtl/ibex_icache.sv:107:3
	wire [NumWays - 1:0] data_banks_ic0;
	// Trace: core/rtl/ibex_icache.sv:108:3
	wire data_write_ic0;
	// Trace: core/rtl/ibex_icache.sv:109:3
	wire [LINE_SIZE_ECC - 1:0] data_wdata_ic0;
	// Trace: core/rtl/ibex_icache.sv:111:3
	wire [TAG_SIZE_ECC - 1:0] tag_rdata_ic1 [0:NumWays - 1];
	// Trace: core/rtl/ibex_icache.sv:112:3
	wire [LINE_SIZE_ECC - 1:0] data_rdata_ic1 [0:NumWays - 1];
	// Trace: core/rtl/ibex_icache.sv:113:3
	reg [LINE_SIZE_ECC - 1:0] hit_data_ic1;
	// Trace: core/rtl/ibex_icache.sv:114:3
	reg lookup_valid_ic1;
	// Trace: core/rtl/ibex_icache.sv:115:3
	reg [31:INDEX_HI + 1] lookup_addr_ic1;
	// Trace: core/rtl/ibex_icache.sv:116:3
	wire [NumWays - 1:0] tag_match_ic1;
	// Trace: core/rtl/ibex_icache.sv:117:3
	wire tag_hit_ic1;
	// Trace: core/rtl/ibex_icache.sv:118:3
	wire [NumWays - 1:0] tag_invalid_ic1;
	// Trace: core/rtl/ibex_icache.sv:119:3
	wire [NumWays - 1:0] lowest_invalid_way_ic1;
	// Trace: core/rtl/ibex_icache.sv:120:3
	wire [NumWays - 1:0] round_robin_way_ic1;
	reg [NumWays - 1:0] round_robin_way_q;
	// Trace: core/rtl/ibex_icache.sv:121:3
	wire [NumWays - 1:0] sel_way_ic1;
	// Trace: core/rtl/ibex_icache.sv:122:3
	wire ecc_err_ic1;
	// Trace: core/rtl/ibex_icache.sv:123:3
	wire ecc_write_req;
	// Trace: core/rtl/ibex_icache.sv:124:3
	wire [NumWays - 1:0] ecc_write_ways;
	// Trace: core/rtl/ibex_icache.sv:125:3
	wire [INDEX_W - 1:0] ecc_write_index;
	// Trace: core/rtl/ibex_icache.sv:127:3
	wire gnt_or_pmp_err;
	wire gnt_not_pmp_err;
	// Trace: core/rtl/ibex_icache.sv:128:3
	reg [1:0] fb_fill_level;
	// Trace: core/rtl/ibex_icache.sv:129:3
	wire fill_cache_new;
	// Trace: core/rtl/ibex_icache.sv:130:3
	wire fill_new_alloc;
	// Trace: core/rtl/ibex_icache.sv:131:3
	wire fill_spec_req;
	wire fill_spec_done;
	wire fill_spec_hold;
	// Trace: core/rtl/ibex_icache.sv:132:3
	wire [(NUM_FB * NUM_FB) - 1:0] fill_older_d;
	reg [(NUM_FB * NUM_FB) - 1:0] fill_older_q;
	// Trace: core/rtl/ibex_icache.sv:133:3
	wire [3:0] fill_alloc_sel;
	wire [3:0] fill_alloc;
	// Trace: core/rtl/ibex_icache.sv:134:3
	wire [3:0] fill_busy_d;
	reg [3:0] fill_busy_q;
	// Trace: core/rtl/ibex_icache.sv:135:3
	wire [3:0] fill_done;
	// Trace: core/rtl/ibex_icache.sv:136:3
	reg [3:0] fill_in_ic1;
	// Trace: core/rtl/ibex_icache.sv:137:3
	wire [3:0] fill_stale_d;
	reg [3:0] fill_stale_q;
	// Trace: core/rtl/ibex_icache.sv:138:3
	wire [3:0] fill_cache_d;
	reg [3:0] fill_cache_q;
	// Trace: core/rtl/ibex_icache.sv:139:3
	wire [3:0] fill_hit_ic1;
	wire [3:0] fill_hit_d;
	reg [3:0] fill_hit_q;
	// Trace: core/rtl/ibex_icache.sv:140:3
	wire [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_ext_cnt_d;
	reg [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_ext_cnt_q;
	// Trace: core/rtl/ibex_icache.sv:141:3
	wire [3:0] fill_ext_hold_d;
	reg [3:0] fill_ext_hold_q;
	// Trace: core/rtl/ibex_icache.sv:142:3
	wire [3:0] fill_ext_done_d;
	reg [3:0] fill_ext_done_q;
	// Trace: core/rtl/ibex_icache.sv:143:3
	wire [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_rvd_cnt_d;
	reg [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_rvd_cnt_q;
	// Trace: core/rtl/ibex_icache.sv:144:3
	wire [3:0] fill_rvd_done;
	// Trace: core/rtl/ibex_icache.sv:145:3
	wire [3:0] fill_ram_done_d;
	reg [3:0] fill_ram_done_q;
	// Trace: core/rtl/ibex_icache.sv:146:3
	wire [3:0] fill_out_grant;
	// Trace: core/rtl/ibex_icache.sv:147:3
	wire [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_out_cnt_d;
	reg [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_out_cnt_q;
	// Trace: core/rtl/ibex_icache.sv:148:3
	wire [3:0] fill_out_done;
	// Trace: core/rtl/ibex_icache.sv:149:3
	wire [3:0] fill_ext_req;
	wire [3:0] fill_rvd_exp;
	wire [3:0] fill_ram_req;
	wire [3:0] fill_out_req;
	// Trace: core/rtl/ibex_icache.sv:150:3
	wire [3:0] fill_data_sel;
	wire [3:0] fill_data_reg;
	wire [3:0] fill_data_hit;
	wire [3:0] fill_data_rvd;
	// Trace: core/rtl/ibex_icache.sv:151:3
	wire [(NUM_FB * LINE_BEATS_W) - 1:0] fill_ext_off;
	wire [(NUM_FB * LINE_BEATS_W) - 1:0] fill_rvd_off;
	// Trace: core/rtl/ibex_icache.sv:152:3
	wire [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_ext_beat;
	wire [(LINE_BEATS_W >= 0 ? (NUM_FB * (LINE_BEATS_W + 1)) - 1 : (NUM_FB * (1 - LINE_BEATS_W)) + (LINE_BEATS_W - 1)):(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W + 0)] fill_rvd_beat;
	// Trace: core/rtl/ibex_icache.sv:153:3
	wire [3:0] fill_ext_arb;
	wire [3:0] fill_ram_arb;
	wire [3:0] fill_out_arb;
	// Trace: core/rtl/ibex_icache.sv:154:3
	wire [3:0] fill_rvd_arb;
	// Trace: core/rtl/ibex_icache.sv:155:3
	wire [3:0] fill_entry_en;
	// Trace: core/rtl/ibex_icache.sv:156:3
	wire [3:0] fill_addr_en;
	// Trace: core/rtl/ibex_icache.sv:157:3
	wire [3:0] fill_way_en;
	// Trace: core/rtl/ibex_icache.sv:158:3
	wire [(NUM_FB * LINE_BEATS) - 1:0] fill_data_en;
	// Trace: core/rtl/ibex_icache.sv:159:3
	wire [(NUM_FB * LINE_BEATS) - 1:0] fill_err_d;
	reg [(NUM_FB * LINE_BEATS) - 1:0] fill_err_q;
	// Trace: core/rtl/ibex_icache.sv:160:3
	reg [31:0] fill_addr_q [0:3];
	// Trace: core/rtl/ibex_icache.sv:161:3
	reg [NumWays - 1:0] fill_way_q [0:3];
	// Trace: core/rtl/ibex_icache.sv:162:3
	wire [LineSize - 1:0] fill_data_d [0:3];
	// Trace: core/rtl/ibex_icache.sv:163:3
	reg [LineSize - 1:0] fill_data_q [0:3];
	// Trace: core/rtl/ibex_icache.sv:164:3
	reg [31:BUS_W] fill_ext_req_addr;
	// Trace: core/rtl/ibex_icache.sv:165:3
	reg [31:0] fill_ram_req_addr;
	// Trace: core/rtl/ibex_icache.sv:166:3
	reg [NumWays - 1:0] fill_ram_req_way;
	// Trace: core/rtl/ibex_icache.sv:167:3
	reg [LineSize - 1:0] fill_ram_req_data;
	// Trace: core/rtl/ibex_icache.sv:168:3
	reg [LineSize - 1:0] fill_out_data;
	// Trace: core/rtl/ibex_icache.sv:169:3
	reg [LINE_BEATS - 1:0] fill_out_err;
	// Trace: core/rtl/ibex_icache.sv:171:3
	wire instr_req;
	// Trace: core/rtl/ibex_icache.sv:172:3
	wire [31:BUS_W] instr_addr;
	// Trace: core/rtl/ibex_icache.sv:174:3
	wire skid_complete_instr;
	// Trace: core/rtl/ibex_icache.sv:175:3
	wire skid_ready;
	// Trace: core/rtl/ibex_icache.sv:176:3
	wire output_compressed;
	// Trace: core/rtl/ibex_icache.sv:177:3
	wire skid_valid_d;
	reg skid_valid_q;
	wire skid_en;
	// Trace: core/rtl/ibex_icache.sv:178:3
	wire [15:0] skid_data_d;
	reg [15:0] skid_data_q;
	// Trace: core/rtl/ibex_icache.sv:179:3
	reg skid_err_q;
	// Trace: core/rtl/ibex_icache.sv:180:3
	wire output_valid;
	// Trace: core/rtl/ibex_icache.sv:181:3
	wire addr_incr_two;
	// Trace: core/rtl/ibex_icache.sv:182:3
	wire output_addr_en;
	// Trace: core/rtl/ibex_icache.sv:183:3
	wire [31:1] output_addr_incr;
	// Trace: core/rtl/ibex_icache.sv:184:3
	wire [31:1] output_addr_d;
	reg [31:1] output_addr_q;
	// Trace: core/rtl/ibex_icache.sv:185:3
	reg [15:0] output_data_lo;
	reg [15:0] output_data_hi;
	// Trace: core/rtl/ibex_icache.sv:186:3
	wire data_valid;
	wire output_ready;
	// Trace: core/rtl/ibex_icache.sv:187:3
	wire [LineSize - 1:0] line_data;
	// Trace: core/rtl/ibex_icache.sv:188:3
	wire [LINE_BEATS - 1:0] line_err;
	// Trace: core/rtl/ibex_icache.sv:189:3
	reg [31:0] line_data_muxed;
	// Trace: core/rtl/ibex_icache.sv:190:3
	reg line_err_muxed;
	// Trace: core/rtl/ibex_icache.sv:191:3
	wire [31:0] output_data;
	// Trace: core/rtl/ibex_icache.sv:192:3
	wire output_err;
	// Trace: core/rtl/ibex_icache.sv:194:3
	wire start_inval;
	wire inval_done;
	// Trace: core/rtl/ibex_icache.sv:195:3
	reg reset_inval_q;
	// Trace: core/rtl/ibex_icache.sv:196:3
	wire inval_prog_d;
	reg inval_prog_q;
	// Trace: core/rtl/ibex_icache.sv:197:3
	wire [INDEX_W - 1:0] inval_index_d;
	reg [INDEX_W - 1:0] inval_index_q;
	// Trace: core/rtl/ibex_icache.sv:203:3
	generate
		if (BranchPredictor) begin : g_branch_predictor
			// Trace: core/rtl/ibex_icache.sv:207:5
			reg [31:0] branch_mispredict_addr_q;
			// Trace: core/rtl/ibex_icache.sv:208:5
			wire branch_mispredict_addr_en;
			// Trace: core/rtl/ibex_icache.sv:210:5
			assign branch_mispredict_addr_en = branch_i & predicted_branch_i;
			// Trace: core/rtl/ibex_icache.sv:212:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_icache.sv:213:7
				if (branch_mispredict_addr_en)
					// Trace: core/rtl/ibex_icache.sv:214:9
					branch_mispredict_addr_q <= {output_addr_incr, 1'b0};
			// Trace: core/rtl/ibex_icache.sv:218:5
			assign branch_mispredict_addr = branch_mispredict_addr_q;
		end
		else begin : g_no_branch_predictor
			// Trace: core/rtl/ibex_icache.sv:221:5
			wire unused_predicted_branch;
			// Trace: core/rtl/ibex_icache.sv:223:5
			assign unused_predicted_branch = predicted_branch_i;
			// Trace: core/rtl/ibex_icache.sv:225:5
			assign branch_mispredict_addr = 1'sb0;
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:228:3
	assign branch_or_mispredict = branch_i | branch_mispredict_i;
	// Trace: core/rtl/ibex_icache.sv:230:3
	assign lookup_addr_aligned = {lookup_addr_ic0[31:LINE_W], {LINE_W {1'b0}}};
	// Trace: core/rtl/ibex_icache.sv:238:3
	assign prefetch_addr_d = (lookup_grant_ic0 ? lookup_addr_aligned + {{(ADDR_W - LINE_W) - 1 {1'b0}}, 1'b1, {LINE_W {1'b0}}} : (branch_i ? addr_i : branch_mispredict_addr));
	// Trace: core/rtl/ibex_icache.sv:243:3
	assign prefetch_addr_en = branch_or_mispredict | lookup_grant_ic0;
	// Trace: core/rtl/ibex_icache.sv:245:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_icache.sv:246:5
		if (prefetch_addr_en)
			// Trace: core/rtl/ibex_icache.sv:247:7
			prefetch_addr_q <= prefetch_addr_d;
	// Trace: core/rtl/ibex_icache.sv:256:3
	assign lookup_throttle = fb_fill_level > FB_THRESHOLD[1:0];
	// Trace: core/rtl/ibex_icache.sv:258:3
	assign lookup_req_ic0 = ((req_i & ~&fill_busy_q) & (branch_or_mispredict | ~lookup_throttle)) & ~ecc_write_req;
	// Trace: core/rtl/ibex_icache.sv:260:3
	assign lookup_addr_ic0 = (branch_spec_i ? addr_i : (branch_mispredict_i ? branch_mispredict_addr : prefetch_addr_q));
	// Trace: core/rtl/ibex_icache.sv:263:3
	assign lookup_index_ic0 = lookup_addr_ic0[INDEX_HI:LINE_W];
	// Trace: core/rtl/ibex_icache.sv:266:3
	assign fill_req_ic0 = |fill_ram_req;
	// Trace: core/rtl/ibex_icache.sv:267:3
	assign fill_index_ic0 = fill_ram_req_addr[INDEX_HI:LINE_W];
	// Trace: core/rtl/ibex_icache.sv:268:3
	assign fill_tag_ic0 = {~inval_prog_q & ~ecc_write_req, fill_ram_req_addr[31:INDEX_HI + 1]};
	// Trace: core/rtl/ibex_icache.sv:269:3
	assign fill_wdata_ic0 = fill_ram_req_data;
	// Trace: core/rtl/ibex_icache.sv:272:3
	assign branch_suppress = branch_spec_i & ~branch_i;
	// Trace: core/rtl/ibex_icache.sv:275:3
	assign lookup_grant_ic0 = lookup_req_ic0 & ~branch_suppress;
	// Trace: core/rtl/ibex_icache.sv:276:3
	assign fill_grant_ic0 = ((fill_req_ic0 & (~lookup_req_ic0 | branch_suppress)) & ~inval_prog_q) & ~ecc_write_req;
	// Trace: core/rtl/ibex_icache.sv:279:3
	assign lookup_actual_ic0 = ((lookup_grant_ic0 & icache_enable_i) & ~inval_prog_q) & ~start_inval;
	// Trace: core/rtl/ibex_icache.sv:282:3
	assign tag_req_ic0 = ((lookup_req_ic0 | fill_req_ic0) | inval_prog_q) | ecc_write_req;
	// Trace: core/rtl/ibex_icache.sv:283:3
	assign tag_index_ic0 = (inval_prog_q ? inval_index_q : (ecc_write_req ? ecc_write_index : (fill_grant_ic0 ? fill_index_ic0 : lookup_index_ic0)));
	// Trace: core/rtl/ibex_icache.sv:287:3
	assign tag_banks_ic0 = (ecc_write_req ? ecc_write_ways : (fill_grant_ic0 ? fill_ram_req_way : {NumWays {1'b1}}));
	// Trace: core/rtl/ibex_icache.sv:290:3
	assign tag_write_ic0 = (fill_grant_ic0 | inval_prog_q) | ecc_write_req;
	// Trace: core/rtl/ibex_icache.sv:293:3
	assign data_req_ic0 = lookup_req_ic0 | fill_req_ic0;
	// Trace: core/rtl/ibex_icache.sv:294:3
	assign data_index_ic0 = tag_index_ic0;
	// Trace: core/rtl/ibex_icache.sv:295:3
	assign data_banks_ic0 = tag_banks_ic0;
	// Trace: core/rtl/ibex_icache.sv:296:3
	assign data_write_ic0 = tag_write_ic0;
	// Trace: core/rtl/ibex_icache.sv:299:3
	generate
		if (ICacheECC) begin : gen_ecc_wdata
			// Trace: core/rtl/ibex_icache.sv:303:5
			wire [21:0] tag_ecc_input_padded;
			// Trace: core/rtl/ibex_icache.sv:304:5
			wire [27:0] tag_ecc_output_padded;
			// Trace: core/rtl/ibex_icache.sv:305:5
			wire [22 - TAG_SIZE:0] tag_ecc_output_unused;
			// Trace: core/rtl/ibex_icache.sv:307:5
			assign tag_ecc_input_padded = {{22 - TAG_SIZE {1'b0}}, fill_tag_ic0};
			// Trace: core/rtl/ibex_icache.sv:308:5
			assign tag_ecc_output_unused = tag_ecc_output_padded[21:TAG_SIZE - 1];
			// Trace: core/rtl/ibex_icache.sv:310:5
			prim_secded_28_22_enc tag_ecc_enc(
				.in(tag_ecc_input_padded),
				.out(tag_ecc_output_padded)
			);
			// Trace: core/rtl/ibex_icache.sv:315:5
			assign tag_wdata_ic0 = {tag_ecc_output_padded[27:22], tag_ecc_output_padded[TAG_SIZE - 1:0]};
			// Trace: core/rtl/ibex_icache.sv:318:5
			prim_secded_72_64_enc data_ecc_enc(
				.in(fill_wdata_ic0),
				.out(data_wdata_ic0)
			);
		end
		else begin : gen_noecc_wdata
			// Trace: core/rtl/ibex_icache.sv:324:5
			assign tag_wdata_ic0 = fill_tag_ic0;
			// Trace: core/rtl/ibex_icache.sv:325:5
			assign data_wdata_ic0 = fill_wdata_ic0;
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:332:3
	genvar _gv_way_1;
	generate
		for (_gv_way_1 = 0; _gv_way_1 < NumWays; _gv_way_1 = _gv_way_1 + 1) begin : gen_rams
			localparam way = _gv_way_1;
			// Trace: core/rtl/ibex_icache.sv:334:5
			prim_ram_1p #(
				.Width(TAG_SIZE_ECC),
				.Depth(NUM_LINES),
				.DataBitsPerMask(TAG_SIZE_ECC)
			) tag_bank(
				.clk_i(clk_i),
				.req_i(tag_req_ic0 & tag_banks_ic0[way]),
				.write_i(tag_write_ic0),
				.wmask_i({TAG_SIZE_ECC {1'b1}}),
				.addr_i(tag_index_ic0),
				.wdata_i(tag_wdata_ic0),
				.rdata_o(tag_rdata_ic1[way])
			);
			// Trace: core/rtl/ibex_icache.sv:348:5
			prim_ram_1p #(
				.Width(LINE_SIZE_ECC),
				.Depth(NUM_LINES),
				.DataBitsPerMask(LINE_SIZE_ECC)
			) data_bank(
				.clk_i(clk_i),
				.req_i(data_req_ic0 & data_banks_ic0[way]),
				.write_i(data_write_ic0),
				.wmask_i({LINE_SIZE_ECC {1'b1}}),
				.addr_i(data_index_ic0),
				.wdata_i(data_wdata_ic0),
				.rdata_o(data_rdata_ic1[way])
			);
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:363:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_icache.sv:364:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_icache.sv:365:7
			lookup_valid_ic1 <= 1'b0;
		else
			// Trace: core/rtl/ibex_icache.sv:367:7
			lookup_valid_ic1 <= lookup_actual_ic0;
	// Trace: core/rtl/ibex_icache.sv:371:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_icache.sv:372:5
		if (lookup_grant_ic0) begin
			// Trace: core/rtl/ibex_icache.sv:373:7
			lookup_addr_ic1 <= lookup_addr_ic0[31:INDEX_HI + 1];
			// Trace: core/rtl/ibex_icache.sv:374:7
			fill_in_ic1 <= fill_alloc_sel;
		end
	// Trace: core/rtl/ibex_icache.sv:383:3
	genvar _gv_way_2;
	generate
		for (_gv_way_2 = 0; _gv_way_2 < NumWays; _gv_way_2 = _gv_way_2 + 1) begin : gen_tag_match
			localparam way = _gv_way_2;
			// Trace: core/rtl/ibex_icache.sv:384:5
			assign tag_match_ic1[way] = tag_rdata_ic1[way][TAG_SIZE - 1:0] == {1'b1, lookup_addr_ic1[31:INDEX_HI + 1]};
			// Trace: core/rtl/ibex_icache.sv:386:5
			assign tag_invalid_ic1[way] = ~tag_rdata_ic1[way][TAG_SIZE - 1];
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:389:3
	assign tag_hit_ic1 = |tag_match_ic1;
	// Trace: core/rtl/ibex_icache.sv:392:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:393:5
		hit_data_ic1 = 'b0;
		// Trace: core/rtl/ibex_icache.sv:394:5
		begin : sv2v_autoblock_1
			// Trace: core/rtl/ibex_icache.sv:394:10
			reg signed [31:0] way;
			// Trace: core/rtl/ibex_icache.sv:394:10
			for (way = 0; way < NumWays; way = way + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:395:7
					if (tag_match_ic1[way])
						// Trace: core/rtl/ibex_icache.sv:396:9
						hit_data_ic1 = hit_data_ic1 | data_rdata_ic1[way];
				end
		end
	end
	// Trace: core/rtl/ibex_icache.sv:404:3
	assign lowest_invalid_way_ic1[0] = tag_invalid_ic1[0];
	// Trace: core/rtl/ibex_icache.sv:405:3
	assign round_robin_way_ic1[0] = round_robin_way_q[NumWays - 1];
	// Trace: core/rtl/ibex_icache.sv:406:3
	genvar _gv_way_3;
	generate
		for (_gv_way_3 = 1; _gv_way_3 < NumWays; _gv_way_3 = _gv_way_3 + 1) begin : gen_lowest_way
			localparam way = _gv_way_3;
			// Trace: core/rtl/ibex_icache.sv:407:5
			assign lowest_invalid_way_ic1[way] = tag_invalid_ic1[way] & ~|tag_invalid_ic1[way - 1:0];
			// Trace: core/rtl/ibex_icache.sv:408:5
			assign round_robin_way_ic1[way] = round_robin_way_q[way - 1];
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:411:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_icache.sv:412:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_icache.sv:413:7
			round_robin_way_q <= {{NumWays - 1 {1'b0}}, 1'b1};
		else if (lookup_valid_ic1)
			// Trace: core/rtl/ibex_icache.sv:415:7
			round_robin_way_q <= round_robin_way_ic1;
	// Trace: core/rtl/ibex_icache.sv:419:3
	assign sel_way_ic1 = (|tag_invalid_ic1 ? lowest_invalid_way_ic1 : round_robin_way_q);
	// Trace: core/rtl/ibex_icache.sv:423:3
	generate
		if (ICacheECC) begin : gen_data_ecc_checking
			// Trace: core/rtl/ibex_icache.sv:424:5
			wire [NumWays - 1:0] tag_err_ic1;
			// Trace: core/rtl/ibex_icache.sv:425:5
			wire [1:0] data_err_ic1;
			// Trace: core/rtl/ibex_icache.sv:426:5
			wire ecc_correction_write_d;
			reg ecc_correction_write_q;
			// Trace: core/rtl/ibex_icache.sv:427:5
			wire [NumWays - 1:0] ecc_correction_ways_d;
			reg [NumWays - 1:0] ecc_correction_ways_q;
			// Trace: core/rtl/ibex_icache.sv:428:5
			reg [INDEX_W - 1:0] lookup_index_ic1;
			reg [INDEX_W - 1:0] ecc_correction_index_q;
			genvar _gv_way_4;
			for (_gv_way_4 = 0; _gv_way_4 < NumWays; _gv_way_4 = _gv_way_4 + 1) begin : gen_tag_ecc
				localparam way = _gv_way_4;
				// Trace: core/rtl/ibex_icache.sv:432:7
				wire [1:0] tag_err_bank_ic1;
				// Trace: core/rtl/ibex_icache.sv:433:7
				wire [27:0] tag_rdata_padded_ic1;
				// Trace: core/rtl/ibex_icache.sv:436:7
				assign tag_rdata_padded_ic1 = {tag_rdata_ic1[way][TAG_SIZE_ECC - 1-:6], {22 - TAG_SIZE {1'b0}}, tag_rdata_ic1[way][TAG_SIZE - 1:0]};
				// Trace: core/rtl/ibex_icache.sv:440:7
				prim_secded_28_22_dec data_ecc_dec(
					.in(tag_rdata_padded_ic1),
					.d_o(),
					.syndrome_o(),
					.err_o(tag_err_bank_ic1)
				);
				// Trace: core/rtl/ibex_icache.sv:446:7
				assign tag_err_ic1[way] = |tag_err_bank_ic1;
			end
			// Trace: core/rtl/ibex_icache.sv:451:5
			prim_secded_72_64_dec data_ecc_dec(
				.in(hit_data_ic1),
				.d_o(),
				.syndrome_o(),
				.err_o(data_err_ic1)
			);
			// Trace: core/rtl/ibex_icache.sv:458:5
			assign ecc_err_ic1 = lookup_valid_ic1 & (|data_err_ic1 | (|tag_err_ic1));
			// Trace: core/rtl/ibex_icache.sv:464:5
			assign ecc_correction_ways_d = {NumWays {|tag_err_ic1}} | (tag_match_ic1 & {NumWays {|data_err_ic1}});
			// Trace: core/rtl/ibex_icache.sv:466:5
			assign ecc_correction_write_d = ecc_err_ic1;
			// Trace: core/rtl/ibex_icache.sv:468:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_icache.sv:469:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_icache.sv:470:9
					ecc_correction_write_q <= 1'b0;
				else
					// Trace: core/rtl/ibex_icache.sv:472:9
					ecc_correction_write_q <= ecc_correction_write_d;
			// Trace: core/rtl/ibex_icache.sv:477:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_icache.sv:478:7
				if (lookup_grant_ic0)
					// Trace: core/rtl/ibex_icache.sv:479:9
					lookup_index_ic1 <= lookup_addr_ic0[INDEX_HI-:INDEX_W];
			// Trace: core/rtl/ibex_icache.sv:484:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_icache.sv:485:7
				if (ecc_err_ic1) begin
					// Trace: core/rtl/ibex_icache.sv:486:9
					ecc_correction_ways_q <= ecc_correction_ways_d;
					// Trace: core/rtl/ibex_icache.sv:487:9
					ecc_correction_index_q <= lookup_index_ic1;
				end
			// Trace: core/rtl/ibex_icache.sv:491:5
			assign ecc_write_req = ecc_correction_write_q;
			// Trace: core/rtl/ibex_icache.sv:492:5
			assign ecc_write_ways = ecc_correction_ways_q;
			// Trace: core/rtl/ibex_icache.sv:493:5
			assign ecc_write_index = ecc_correction_index_q;
		end
		else begin : gen_no_data_ecc
			// Trace: core/rtl/ibex_icache.sv:496:5
			assign ecc_err_ic1 = 1'b0;
			// Trace: core/rtl/ibex_icache.sv:497:5
			assign ecc_write_req = 1'b0;
			// Trace: core/rtl/ibex_icache.sv:498:5
			assign ecc_write_ways = 1'sb0;
			// Trace: core/rtl/ibex_icache.sv:499:5
			assign ecc_write_index = 1'sb0;
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:506:3
	generate
		if (BranchCache) begin : gen_caching_logic
			// Trace: core/rtl/ibex_icache.sv:509:5
			localparam [31:0] CACHE_AHEAD = 2;
			// Trace: core/rtl/ibex_icache.sv:510:5
			localparam [31:0] CACHE_CNT_W = 2;
			// Trace: core/rtl/ibex_icache.sv:511:5
			wire cache_cnt_dec;
			// Trace: core/rtl/ibex_icache.sv:512:5
			wire [1:0] cache_cnt_d;
			reg [1:0] cache_cnt_q;
			// Trace: core/rtl/ibex_icache.sv:514:5
			assign cache_cnt_dec = lookup_grant_ic0 & |cache_cnt_q;
			// Trace: core/rtl/ibex_icache.sv:515:5
			assign cache_cnt_d = (branch_i ? CACHE_AHEAD[1:0] : cache_cnt_q - {1'b0, cache_cnt_dec});
			// Trace: core/rtl/ibex_icache.sv:518:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_icache.sv:519:7
				if (!rst_ni)
					// Trace: core/rtl/ibex_icache.sv:520:9
					cache_cnt_q <= 1'sb0;
				else
					// Trace: core/rtl/ibex_icache.sv:522:9
					cache_cnt_q <= cache_cnt_d;
			// Trace: core/rtl/ibex_icache.sv:526:5
			assign fill_cache_new = (((branch_i | (|cache_cnt_q)) & icache_enable_i) & ~icache_inval_i) & ~inval_prog_q;
		end
		else begin : gen_cache_all
			// Trace: core/rtl/ibex_icache.sv:532:5
			assign fill_cache_new = (icache_enable_i & ~start_inval) & ~inval_prog_q;
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:539:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:540:5
		fb_fill_level = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:541:5
		begin : sv2v_autoblock_2
			// Trace: core/rtl/ibex_icache.sv:541:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_icache.sv:541:10
			for (i = 0; i < NUM_FB; i = i + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:542:7
					if (fill_busy_q[i] & ~fill_stale_q[i])
						// Trace: core/rtl/ibex_icache.sv:543:9
						fb_fill_level = fb_fill_level + 2'b01;
				end
		end
	end
	// Trace: core/rtl/ibex_icache.sv:549:3
	assign gnt_or_pmp_err = instr_gnt_i | instr_pmp_err_i;
	// Trace: core/rtl/ibex_icache.sv:550:3
	assign gnt_not_pmp_err = instr_gnt_i & ~instr_pmp_err_i;
	// Trace: core/rtl/ibex_icache.sv:552:3
	assign fill_new_alloc = lookup_grant_ic0;
	// Trace: core/rtl/ibex_icache.sv:555:3
	assign fill_spec_req = (~icache_enable_i | branch_or_mispredict) & ~|fill_ext_req;
	// Trace: core/rtl/ibex_icache.sv:556:3
	assign fill_spec_done = fill_spec_req & gnt_not_pmp_err;
	// Trace: core/rtl/ibex_icache.sv:557:3
	assign fill_spec_hold = fill_spec_req & ~gnt_or_pmp_err;
	// Trace: core/rtl/ibex_icache.sv:559:3
	genvar _gv_fb_1;
	generate
		for (_gv_fb_1 = 0; _gv_fb_1 < NUM_FB; _gv_fb_1 = _gv_fb_1 + 1) begin : gen_fbs
			localparam fb = _gv_fb_1;
			if (fb == 0) begin : gen_fb_zero
				// Trace: core/rtl/ibex_icache.sv:567:7
				assign fill_alloc_sel[fb] = ~fill_busy_q[fb];
			end
			else begin : gen_fb_rest
				// Trace: core/rtl/ibex_icache.sv:569:7
				assign fill_alloc_sel[fb] = ~fill_busy_q[fb] & (&fill_busy_q[fb - 1:0]);
			end
			// Trace: core/rtl/ibex_icache.sv:572:5
			assign fill_alloc[fb] = fill_alloc_sel[fb] & fill_new_alloc;
			// Trace: core/rtl/ibex_icache.sv:573:5
			assign fill_busy_d[fb] = fill_alloc[fb] | (fill_busy_q[fb] & ~fill_done[fb]);
			// Trace: core/rtl/ibex_icache.sv:577:5
			assign fill_older_d[fb * NUM_FB+:NUM_FB] = (fill_alloc[fb] ? fill_busy_q : fill_older_q[fb * NUM_FB+:NUM_FB]) & ~fill_done;
			// Trace: core/rtl/ibex_icache.sv:581:5
			assign fill_done[fb] = ((((fill_ram_done_q[fb] | fill_hit_q[fb]) | ~fill_cache_q[fb]) | (|fill_err_q[fb * LINE_BEATS+:LINE_BEATS])) & ((fill_out_done[fb] | fill_stale_q[fb]) | branch_or_mispredict)) & fill_rvd_done[fb];
			// Trace: core/rtl/ibex_icache.sv:593:5
			assign fill_stale_d[fb] = fill_busy_q[fb] & (branch_or_mispredict | fill_stale_q[fb]);
			// Trace: core/rtl/ibex_icache.sv:596:5
			assign fill_cache_d[fb] = (fill_alloc[fb] & fill_cache_new) | (((fill_cache_q[fb] & fill_busy_q[fb]) & icache_enable_i) & ~icache_inval_i);
			// Trace: core/rtl/ibex_icache.sv:600:5
			assign fill_hit_ic1[fb] = ((lookup_valid_ic1 & fill_in_ic1[fb]) & tag_hit_ic1) & ~ecc_err_ic1;
			// Trace: core/rtl/ibex_icache.sv:601:5
			assign fill_hit_d[fb] = fill_hit_ic1[fb] | (fill_hit_q[fb] & fill_busy_q[fb]);
			// Trace: core/rtl/ibex_icache.sv:608:5
			assign fill_ext_req[fb] = fill_busy_q[fb] & ~fill_ext_done_d[fb];
			// Trace: core/rtl/ibex_icache.sv:612:5
			assign fill_ext_cnt_d[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] = (fill_alloc[fb] ? {{LINE_BEATS_W {1'b0}}, fill_spec_done} : fill_ext_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] + {{LINE_BEATS_W {1'b0}}, fill_ext_arb[fb] & gnt_not_pmp_err});
			// Trace: core/rtl/ibex_icache.sv:617:5
			assign fill_ext_hold_d[fb] = (fill_alloc[fb] & fill_spec_hold) | (fill_ext_arb[fb] & ~gnt_or_pmp_err);
			// Trace: core/rtl/ibex_icache.sv:620:5
			assign fill_ext_done_d[fb] = (((((fill_ext_cnt_q[(fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W : LINE_BEATS_W - LINE_BEATS_W)] | fill_hit_ic1[fb]) | fill_hit_q[fb]) | fill_err_q[(fb * LINE_BEATS) + fill_ext_off[fb * LINE_BEATS_W+:LINE_BEATS_W]]) | (~fill_cache_q[fb] & ((branch_or_mispredict | fill_stale_q[fb]) | fill_ext_beat[(fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W : LINE_BEATS_W - LINE_BEATS_W)]))) & ~fill_ext_hold_q[fb]) & fill_busy_q[fb];
			// Trace: core/rtl/ibex_icache.sv:632:5
			assign fill_rvd_exp[fb] = fill_busy_q[fb] & ~fill_rvd_done[fb];
			// Trace: core/rtl/ibex_icache.sv:634:5
			assign fill_rvd_cnt_d[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] = (fill_alloc[fb] ? {(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W) * 1 {1'sb0}} : fill_rvd_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] + {{LINE_BEATS_W {1'b0}}, fill_rvd_arb[fb]});
			// Trace: core/rtl/ibex_icache.sv:638:5
			assign fill_rvd_done[fb] = (fill_ext_done_q[fb] & ~fill_ext_hold_q[fb]) & (fill_rvd_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] == fill_ext_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)]);
			// Trace: core/rtl/ibex_icache.sv:652:5
			assign fill_out_req[fb] = ((fill_busy_q[fb] & ~fill_stale_q[fb]) & ~fill_out_done[fb]) & ((((fill_hit_ic1[fb] | fill_hit_q[fb]) | fill_err_q[(fb * LINE_BEATS) + fill_out_cnt_q[(LINE_BEATS_W >= 0 ? (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W - 1 : LINE_BEATS_W - (LINE_BEATS_W - 1)) : (((fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W - 1 : LINE_BEATS_W - (LINE_BEATS_W - 1))) + LINE_BEATS_W) - 1)-:LINE_BEATS_W]]) | (fill_rvd_beat[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] > fill_out_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)])) | fill_rvd_arb[fb]);
			// Trace: core/rtl/ibex_icache.sv:658:5
			assign fill_out_grant[fb] = fill_out_arb[fb] & output_ready;
			// Trace: core/rtl/ibex_icache.sv:661:5
			assign fill_out_cnt_d[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] = (fill_alloc[fb] ? {1'b0, lookup_addr_ic0[LINE_W - 1:BUS_W]} : fill_out_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] + {{LINE_BEATS_W {1'b0}}, fill_out_grant[fb]});
			// Trace: core/rtl/ibex_icache.sv:665:5
			assign fill_out_done[fb] = fill_out_cnt_q[(fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W : LINE_BEATS_W - LINE_BEATS_W)];
			// Trace: core/rtl/ibex_icache.sv:672:5
			assign fill_ram_req[fb] = ((((fill_busy_q[fb] & fill_rvd_cnt_q[(fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W : LINE_BEATS_W - LINE_BEATS_W)]) & ~fill_hit_q[fb]) & fill_cache_q[fb]) & ~|fill_err_q[fb * LINE_BEATS+:LINE_BEATS]) & ~fill_ram_done_q[fb];
			// Trace: core/rtl/ibex_icache.sv:679:5
			assign fill_ram_done_d[fb] = fill_ram_arb[fb] | (fill_ram_done_q[fb] & fill_busy_q[fb]);
			// Trace: core/rtl/ibex_icache.sv:687:5
			assign fill_ext_beat[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] = {1'b0, fill_addr_q[fb][LINE_W - 1:BUS_W]} + fill_ext_cnt_q[(LINE_BEATS_W >= 0 ? (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1) : LINE_BEATS_W - (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1)) : (((fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1) : LINE_BEATS_W - (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1))) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1)-:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)];
			// Trace: core/rtl/ibex_icache.sv:689:5
			assign fill_ext_off[fb * LINE_BEATS_W+:LINE_BEATS_W] = fill_ext_beat[(LINE_BEATS_W >= 0 ? (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W - 1 : LINE_BEATS_W - (LINE_BEATS_W - 1)) : (((fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W - 1 : LINE_BEATS_W - (LINE_BEATS_W - 1))) + LINE_BEATS_W) - 1)-:LINE_BEATS_W];
			// Trace: core/rtl/ibex_icache.sv:690:5
			assign fill_rvd_beat[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] = {1'b0, fill_addr_q[fb][LINE_W - 1:BUS_W]} + fill_rvd_cnt_q[(LINE_BEATS_W >= 0 ? (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1) : LINE_BEATS_W - (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1)) : (((fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1) : LINE_BEATS_W - (LINE_BEATS_W >= 0 ? LINE_BEATS_W : (LINE_BEATS_W + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1))) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) - 1)-:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)];
			// Trace: core/rtl/ibex_icache.sv:692:5
			assign fill_rvd_off[fb * LINE_BEATS_W+:LINE_BEATS_W] = fill_rvd_beat[(LINE_BEATS_W >= 0 ? (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W - 1 : LINE_BEATS_W - (LINE_BEATS_W - 1)) : (((fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)) + (LINE_BEATS_W >= 0 ? LINE_BEATS_W - 1 : LINE_BEATS_W - (LINE_BEATS_W - 1))) + LINE_BEATS_W) - 1)-:LINE_BEATS_W];
			// Trace: core/rtl/ibex_icache.sv:699:5
			assign fill_ext_arb[fb] = fill_ext_req[fb] & ~|(fill_ext_req & fill_older_q[fb * NUM_FB+:NUM_FB]);
			// Trace: core/rtl/ibex_icache.sv:700:5
			assign fill_ram_arb[fb] = (fill_ram_req[fb] & fill_grant_ic0) & ~|(fill_ram_req & fill_older_q[fb * NUM_FB+:NUM_FB]);
			// Trace: core/rtl/ibex_icache.sv:702:5
			assign fill_data_sel[fb] = ~|(((fill_busy_q & ~fill_out_done) & ~fill_stale_q) & fill_older_q[fb * NUM_FB+:NUM_FB]);
			// Trace: core/rtl/ibex_icache.sv:705:5
			assign fill_out_arb[fb] = fill_out_req[fb] & fill_data_sel[fb];
			// Trace: core/rtl/ibex_icache.sv:707:5
			assign fill_rvd_arb[fb] = (instr_rvalid_i & fill_rvd_exp[fb]) & ~|(fill_rvd_exp & fill_older_q[fb * NUM_FB+:NUM_FB]);
			// Trace: core/rtl/ibex_icache.sv:715:5
			assign fill_data_reg[fb] = (((fill_busy_q[fb] & ~fill_stale_q[fb]) & ~fill_out_done[fb]) & fill_data_sel[fb]) & (((fill_rvd_beat[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] > fill_out_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)]) | fill_hit_q[fb]) | (|fill_err_q[fb * LINE_BEATS+:LINE_BEATS]));
			// Trace: core/rtl/ibex_icache.sv:721:5
			assign fill_data_hit[fb] = (fill_busy_q[fb] & fill_hit_ic1[fb]) & fill_data_sel[fb];
			// Trace: core/rtl/ibex_icache.sv:723:5
			assign fill_data_rvd[fb] = ((((((fill_busy_q[fb] & fill_rvd_arb[fb]) & ~fill_hit_q[fb]) & ~fill_hit_ic1[fb]) & ~fill_stale_q[fb]) & ~fill_out_done[fb]) & (fill_rvd_beat[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] == fill_out_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)])) & fill_data_sel[fb];
			// Trace: core/rtl/ibex_icache.sv:734:5
			assign fill_entry_en[fb] = fill_alloc[fb] | fill_busy_q[fb];
			// Trace: core/rtl/ibex_icache.sv:736:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_icache.sv:737:7
				if (!rst_ni) begin
					// Trace: core/rtl/ibex_icache.sv:738:9
					fill_busy_q[fb] <= 1'b0;
					// Trace: core/rtl/ibex_icache.sv:739:9
					fill_older_q[fb * NUM_FB+:NUM_FB] <= 1'sb0;
					// Trace: core/rtl/ibex_icache.sv:740:9
					fill_stale_q[fb] <= 1'b0;
					// Trace: core/rtl/ibex_icache.sv:741:9
					fill_cache_q[fb] <= 1'b0;
					// Trace: core/rtl/ibex_icache.sv:742:9
					fill_hit_q[fb] <= 1'b0;
					// Trace: core/rtl/ibex_icache.sv:743:9
					fill_ext_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] <= 1'sb0;
					// Trace: core/rtl/ibex_icache.sv:744:9
					fill_ext_hold_q[fb] <= 1'b0;
					// Trace: core/rtl/ibex_icache.sv:745:9
					fill_ext_done_q[fb] <= 1'b0;
					// Trace: core/rtl/ibex_icache.sv:746:9
					fill_rvd_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] <= 1'sb0;
					// Trace: core/rtl/ibex_icache.sv:747:9
					fill_ram_done_q[fb] <= 1'b0;
					// Trace: core/rtl/ibex_icache.sv:748:9
					fill_out_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] <= 1'sb0;
				end
				else if (fill_entry_en[fb]) begin
					// Trace: core/rtl/ibex_icache.sv:750:9
					fill_busy_q[fb] <= fill_busy_d[fb];
					// Trace: core/rtl/ibex_icache.sv:751:9
					fill_older_q[fb * NUM_FB+:NUM_FB] <= fill_older_d[fb * NUM_FB+:NUM_FB];
					// Trace: core/rtl/ibex_icache.sv:752:9
					fill_stale_q[fb] <= fill_stale_d[fb];
					// Trace: core/rtl/ibex_icache.sv:753:9
					fill_cache_q[fb] <= fill_cache_d[fb];
					// Trace: core/rtl/ibex_icache.sv:754:9
					fill_hit_q[fb] <= fill_hit_d[fb];
					// Trace: core/rtl/ibex_icache.sv:755:9
					fill_ext_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] <= fill_ext_cnt_d[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)];
					// Trace: core/rtl/ibex_icache.sv:756:9
					fill_ext_hold_q[fb] <= fill_ext_hold_d[fb];
					// Trace: core/rtl/ibex_icache.sv:757:9
					fill_ext_done_q[fb] <= fill_ext_done_d[fb];
					// Trace: core/rtl/ibex_icache.sv:758:9
					fill_rvd_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] <= fill_rvd_cnt_d[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)];
					// Trace: core/rtl/ibex_icache.sv:759:9
					fill_ram_done_q[fb] <= fill_ram_done_d[fb];
					// Trace: core/rtl/ibex_icache.sv:760:9
					fill_out_cnt_q[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)] <= fill_out_cnt_d[(LINE_BEATS_W >= 0 ? 0 : LINE_BEATS_W) + (fb * (LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W))+:(LINE_BEATS_W >= 0 ? LINE_BEATS_W + 1 : 1 - LINE_BEATS_W)];
				end
			// Trace: core/rtl/ibex_icache.sv:768:5
			assign fill_addr_en[fb] = fill_alloc[fb];
			// Trace: core/rtl/ibex_icache.sv:769:5
			assign fill_way_en[fb] = lookup_valid_ic1 & fill_in_ic1[fb];
			// Trace: core/rtl/ibex_icache.sv:771:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_icache.sv:772:7
				if (fill_addr_en[fb])
					// Trace: core/rtl/ibex_icache.sv:773:9
					fill_addr_q[fb] <= lookup_addr_ic0;
			// Trace: core/rtl/ibex_icache.sv:777:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_icache.sv:778:7
				if (fill_way_en[fb])
					// Trace: core/rtl/ibex_icache.sv:779:9
					fill_way_q[fb] <= sel_way_ic1;
			// Trace: core/rtl/ibex_icache.sv:785:5
			assign fill_data_d[fb] = (fill_hit_ic1[fb] ? hit_data_ic1[LineSize - 1:0] : {LINE_BEATS {instr_rdata_i}});
			genvar _gv_b_1;
			for (_gv_b_1 = 0; _gv_b_1 < LINE_BEATS; _gv_b_1 = _gv_b_1 + 1) begin : gen_data_buf
				localparam b = _gv_b_1;
				// Trace: core/rtl/ibex_icache.sv:791:7
				assign fill_err_d[(fb * LINE_BEATS) + b] = (((((instr_pmp_err_i & fill_alloc[fb]) & fill_spec_req) & (lookup_addr_ic0[LINE_W - 1:BUS_W] == b[LINE_BEATS_W - 1:0])) | ((instr_pmp_err_i & fill_ext_arb[fb]) & (fill_ext_off[fb * LINE_BEATS_W+:LINE_BEATS_W] == b[LINE_BEATS_W - 1:0]))) | ((fill_rvd_arb[fb] & instr_err_i) & (fill_rvd_off[fb * LINE_BEATS_W+:LINE_BEATS_W] == b[LINE_BEATS_W - 1:0]))) | (fill_busy_q[fb] & fill_err_q[(fb * LINE_BEATS) + b]);
				// Trace: core/rtl/ibex_icache.sv:802:7
				always @(posedge clk_i or negedge rst_ni)
					// Trace: core/rtl/ibex_icache.sv:803:9
					if (!rst_ni)
						// Trace: core/rtl/ibex_icache.sv:804:11
						fill_err_q[(fb * LINE_BEATS) + b] <= 1'sb0;
					else if (fill_entry_en[fb])
						// Trace: core/rtl/ibex_icache.sv:806:11
						fill_err_q[(fb * LINE_BEATS) + b] <= fill_err_d[(fb * LINE_BEATS) + b];
				// Trace: core/rtl/ibex_icache.sv:812:7
				assign fill_data_en[(fb * LINE_BEATS) + b] = fill_hit_ic1[fb] | ((fill_rvd_arb[fb] & ~fill_hit_q[fb]) & (fill_rvd_off[fb * LINE_BEATS_W+:LINE_BEATS_W] == b[LINE_BEATS_W - 1:0]));
				// Trace: core/rtl/ibex_icache.sv:816:7
				always @(posedge clk_i)
					// Trace: core/rtl/ibex_icache.sv:817:9
					if (fill_data_en[(fb * LINE_BEATS) + b])
						// Trace: core/rtl/ibex_icache.sv:818:11
						fill_data_q[fb][b * BusWidth+:BusWidth] <= fill_data_d[fb][b * BusWidth+:BusWidth];
			end
		end
	endgenerate
	// Trace: core/rtl/ibex_icache.sv:830:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:831:5
		fill_ext_req_addr = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:832:5
		begin : sv2v_autoblock_3
			// Trace: core/rtl/ibex_icache.sv:832:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_icache.sv:832:10
			for (i = 0; i < NUM_FB; i = i + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:833:7
					if (fill_ext_arb[i])
						// Trace: core/rtl/ibex_icache.sv:834:9
						fill_ext_req_addr = fill_ext_req_addr | {fill_addr_q[i][31:LINE_W], fill_ext_off[i * LINE_BEATS_W+:LINE_BEATS_W]};
				end
		end
	end
	// Trace: core/rtl/ibex_icache.sv:840:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:841:5
		fill_ram_req_addr = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:842:5
		fill_ram_req_way = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:843:5
		fill_ram_req_data = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:844:5
		begin : sv2v_autoblock_4
			// Trace: core/rtl/ibex_icache.sv:844:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_icache.sv:844:10
			for (i = 0; i < NUM_FB; i = i + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:845:7
					if (fill_ram_arb[i]) begin
						// Trace: core/rtl/ibex_icache.sv:846:9
						fill_ram_req_addr = fill_ram_req_addr | fill_addr_q[i];
						// Trace: core/rtl/ibex_icache.sv:847:9
						fill_ram_req_way = fill_ram_req_way | fill_way_q[i];
						// Trace: core/rtl/ibex_icache.sv:848:9
						fill_ram_req_data = fill_ram_req_data | fill_data_q[i];
					end
				end
		end
	end
	// Trace: core/rtl/ibex_icache.sv:854:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:855:5
		fill_out_data = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:856:5
		fill_out_err = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:857:5
		begin : sv2v_autoblock_5
			// Trace: core/rtl/ibex_icache.sv:857:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_icache.sv:857:10
			for (i = 0; i < NUM_FB; i = i + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:858:7
					if (fill_data_reg[i]) begin
						// Trace: core/rtl/ibex_icache.sv:859:9
						fill_out_data = fill_out_data | fill_data_q[i];
						// Trace: core/rtl/ibex_icache.sv:861:9
						fill_out_err = fill_out_err | (fill_err_q[i * LINE_BEATS+:LINE_BEATS] & ~{LINE_BEATS {fill_hit_q[i]}});
					end
				end
		end
	end
	// Trace: core/rtl/ibex_icache.sv:870:3
	assign instr_req = ((~icache_enable_i | branch_or_mispredict) & lookup_grant_ic0) | (|fill_ext_req);
	// Trace: core/rtl/ibex_icache.sv:873:3
	assign instr_addr = (|fill_ext_req ? fill_ext_req_addr : lookup_addr_ic0[31:BUS_W]);
	// Trace: core/rtl/ibex_icache.sv:876:3
	assign instr_req_o = instr_req;
	// Trace: core/rtl/ibex_icache.sv:877:3
	assign instr_addr_o = {instr_addr[31:BUS_W], {BUS_W {1'b0}}};
	// Trace: core/rtl/ibex_icache.sv:884:3
	assign line_data = (|fill_data_hit ? hit_data_ic1[LineSize - 1:0] : fill_out_data);
	// Trace: core/rtl/ibex_icache.sv:885:3
	assign line_err = (|fill_data_hit ? {LINE_BEATS {1'b0}} : fill_out_err);
	// Trace: core/rtl/ibex_icache.sv:888:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:889:5
		line_data_muxed = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:890:5
		line_err_muxed = 1'b0;
		// Trace: core/rtl/ibex_icache.sv:891:5
		begin : sv2v_autoblock_6
			// Trace: core/rtl/ibex_icache.sv:891:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_icache.sv:891:10
			for (i = 0; i < LINE_BEATS; i = i + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:893:7
					if ((output_addr_q[LINE_W - 1:BUS_W] + {{LINE_BEATS_W - 1 {1'b0}}, skid_valid_q}) == i[LINE_BEATS_W - 1:0]) begin
						// Trace: core/rtl/ibex_icache.sv:895:9
						line_data_muxed = line_data_muxed | line_data[i * 32+:32];
						// Trace: core/rtl/ibex_icache.sv:896:9
						line_err_muxed = line_err_muxed | line_err[i];
					end
				end
		end
	end
	// Trace: core/rtl/ibex_icache.sv:902:3
	assign output_data = (|fill_data_rvd ? instr_rdata_i : line_data_muxed);
	// Trace: core/rtl/ibex_icache.sv:903:3
	assign output_err = (|fill_data_rvd ? instr_err_i : line_err_muxed);
	// Trace: core/rtl/ibex_icache.sv:908:3
	assign data_valid = |fill_out_arb;
	// Trace: core/rtl/ibex_icache.sv:911:3
	assign skid_data_d = output_data[31:16];
	// Trace: core/rtl/ibex_icache.sv:913:3
	assign skid_en = data_valid & (ready_i | skid_ready);
	// Trace: core/rtl/ibex_icache.sv:915:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_icache.sv:916:5
		if (skid_en) begin
			// Trace: core/rtl/ibex_icache.sv:917:7
			skid_data_q <= skid_data_d;
			// Trace: core/rtl/ibex_icache.sv:918:7
			skid_err_q <= output_err;
		end
	// Trace: core/rtl/ibex_icache.sv:924:3
	assign skid_complete_instr = skid_valid_q & ((skid_data_q[1:0] != 2'b11) | skid_err_q);
	// Trace: core/rtl/ibex_icache.sv:927:3
	assign skid_ready = (output_addr_q[1] & ~skid_valid_q) & (~output_compressed | output_err);
	// Trace: core/rtl/ibex_icache.sv:929:3
	assign output_ready = (ready_i | skid_ready) & ~skid_complete_instr;
	// Trace: core/rtl/ibex_icache.sv:931:3
	assign output_compressed = rdata_o[1:0] != 2'b11;
	// Trace: core/rtl/ibex_icache.sv:933:3
	assign skid_valid_d = (branch_or_mispredict ? 1'b0 : (skid_valid_q ? ~(ready_i & ((skid_data_q[1:0] != 2'b11) | skid_err_q)) : ((output_addr_q[1] & (~output_compressed | output_err)) | (((~output_addr_q[1] & output_compressed) & ~output_err) & ready_i)) & data_valid));
	// Trace: core/rtl/ibex_icache.sv:944:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_icache.sv:945:5
		if (!rst_ni)
			// Trace: core/rtl/ibex_icache.sv:946:7
			skid_valid_q <= 1'b0;
		else
			// Trace: core/rtl/ibex_icache.sv:948:7
			skid_valid_q <= skid_valid_d;
	// Trace: core/rtl/ibex_icache.sv:956:3
	assign output_valid = skid_complete_instr | (data_valid & (((~output_addr_q[1] | skid_valid_q) | output_err) | (output_data[17:16] != 2'b11)));
	// Trace: core/rtl/ibex_icache.sv:963:3
	assign output_addr_en = branch_or_mispredict | (ready_i & valid_o);
	// Trace: core/rtl/ibex_icache.sv:966:3
	assign addr_incr_two = output_compressed & ~err_o;
	// Trace: core/rtl/ibex_icache.sv:969:3
	assign output_addr_incr = output_addr_q[31:1] + {29'd0, ~addr_incr_two, addr_incr_two};
	// Trace: core/rtl/ibex_icache.sv:974:3
	assign output_addr_d = (branch_i ? addr_i[31:1] : (branch_mispredict_i ? branch_mispredict_addr[31:1] : output_addr_incr));
	// Trace: core/rtl/ibex_icache.sv:978:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_icache.sv:979:5
		if (output_addr_en)
			// Trace: core/rtl/ibex_icache.sv:980:7
			output_addr_q <= output_addr_d;
	// Trace: core/rtl/ibex_icache.sv:989:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:990:5
		output_data_lo = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:991:5
		begin : sv2v_autoblock_7
			// Trace: core/rtl/ibex_icache.sv:991:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_icache.sv:991:10
			for (i = 0; i < OUTPUT_BEATS; i = i + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:992:7
					if (output_addr_q[BUS_W - 1:1] == i[BUS_W - 2:0])
						// Trace: core/rtl/ibex_icache.sv:993:9
						output_data_lo = output_data_lo | output_data[i * 16+:16];
				end
		end
	end
	// Trace: core/rtl/ibex_icache.sv:998:3
	always @(*) begin
		if (_sv2v_0)
			;
		// Trace: core/rtl/ibex_icache.sv:999:5
		output_data_hi = 1'sb0;
		// Trace: core/rtl/ibex_icache.sv:1000:5
		begin : sv2v_autoblock_8
			// Trace: core/rtl/ibex_icache.sv:1000:10
			reg signed [31:0] i;
			// Trace: core/rtl/ibex_icache.sv:1000:10
			for (i = 0; i < (OUTPUT_BEATS - 1); i = i + 1)
				begin
					// Trace: core/rtl/ibex_icache.sv:1001:7
					if (output_addr_q[BUS_W - 1:1] == i[BUS_W - 2:0])
						// Trace: core/rtl/ibex_icache.sv:1002:9
						output_data_hi = output_data_hi | output_data[(i + 1) * 16+:16];
				end
		end
		if (&output_addr_q[BUS_W - 1:1])
			// Trace: core/rtl/ibex_icache.sv:1006:7
			output_data_hi = output_data_hi | output_data[15:0];
	end
	// Trace: core/rtl/ibex_icache.sv:1010:3
	assign valid_o = output_valid & ~branch_mispredict_i;
	// Trace: core/rtl/ibex_icache.sv:1011:3
	assign rdata_o = {output_data_hi, (skid_valid_q ? skid_data_q : output_data_lo)};
	// Trace: core/rtl/ibex_icache.sv:1012:3
	assign addr_o = {output_addr_q, 1'b0};
	// Trace: core/rtl/ibex_icache.sv:1013:3
	assign err_o = (skid_valid_q & skid_err_q) | (~skid_complete_instr & output_err);
	// Trace: core/rtl/ibex_icache.sv:1016:3
	assign err_plus2_o = skid_valid_q & ~skid_err_q;
	// Trace: core/rtl/ibex_icache.sv:1024:3
	assign start_inval = (~reset_inval_q | icache_inval_i) & ~inval_prog_q;
	// Trace: core/rtl/ibex_icache.sv:1025:3
	assign inval_prog_d = start_inval | (inval_prog_q & ~inval_done);
	// Trace: core/rtl/ibex_icache.sv:1026:3
	assign inval_done = &inval_index_q;
	// Trace: core/rtl/ibex_icache.sv:1027:3
	assign inval_index_d = (start_inval ? {INDEX_W {1'sb0}} : inval_index_q + {{INDEX_W - 1 {1'b0}}, 1'b1});
	// Trace: core/rtl/ibex_icache.sv:1030:3
	always @(posedge clk_i or negedge rst_ni)
		// Trace: core/rtl/ibex_icache.sv:1031:5
		if (!rst_ni) begin
			// Trace: core/rtl/ibex_icache.sv:1032:7
			inval_prog_q <= 1'b0;
			// Trace: core/rtl/ibex_icache.sv:1033:7
			reset_inval_q <= 1'b0;
		end
		else begin
			// Trace: core/rtl/ibex_icache.sv:1035:7
			inval_prog_q <= inval_prog_d;
			// Trace: core/rtl/ibex_icache.sv:1036:7
			reset_inval_q <= 1'b1;
		end
	// Trace: core/rtl/ibex_icache.sv:1040:3
	always @(posedge clk_i)
		// Trace: core/rtl/ibex_icache.sv:1041:5
		if (inval_prog_d)
			// Trace: core/rtl/ibex_icache.sv:1042:7
			inval_index_q <= inval_index_d;
	// Trace: core/rtl/ibex_icache.sv:1052:3
	assign busy_o = inval_prog_q | (|(fill_busy_q & ~fill_rvd_done));
	initial _sv2v_0 = 0;
endmodule
