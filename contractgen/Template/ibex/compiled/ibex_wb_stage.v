// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_wb_stage (
	clk_i,
	rst_ni,
	en_wb_i,
	instr_type_wb_i,
	pc_id_i,
	instr_rdata_id_i,
	instr_is_compressed_id_i,
	instr_perf_count_id_i,
	ready_wb_o,
	rf_write_wb_o,
	outstanding_load_wb_o,
	outstanding_store_wb_o,
	pc_wb_o,
	perf_instr_ret_wb_o,
	perf_instr_ret_compressed_wb_o,
	rf_waddr_id_i,
	rf_wdata_id_i,
	rf_we_id_i,
	rf_wdata_lsu_i,
	rf_we_lsu_i,
	rf_wdata_fwd_wb_o,
	rf_waddr_wb_o,
	rf_wdata_wb_o,
	rf_we_wb_o,
	lsu_resp_valid_i,
	lsu_resp_err_i,
	instr_done_wb_o,
	instr_done_rdata_wb_o
);
	// Trace: core/rtl/ibex_wb_stage.sv:17:13
	parameter [0:0] WritebackStage = 1'b0;
	// Trace: core/rtl/ibex_wb_stage.sv:19:3
	input wire clk_i;
	// Trace: core/rtl/ibex_wb_stage.sv:20:3
	input wire rst_ni;
	// Trace: core/rtl/ibex_wb_stage.sv:22:3
	input wire en_wb_i;
	// Trace: core/rtl/ibex_wb_stage.sv:23:3
	// removed localparam type ibex_pkg_wb_instr_type_e
	input wire [1:0] instr_type_wb_i;
	// Trace: core/rtl/ibex_wb_stage.sv:24:3
	input wire [31:0] pc_id_i;
	// Trace: core/rtl/ibex_wb_stage.sv:26:3
	input wire [31:0] instr_rdata_id_i;
	// Trace: core/rtl/ibex_wb_stage.sv:28:3
	input wire instr_is_compressed_id_i;
	// Trace: core/rtl/ibex_wb_stage.sv:29:3
	input wire instr_perf_count_id_i;
	// Trace: core/rtl/ibex_wb_stage.sv:31:3
	output wire ready_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:32:3
	output wire rf_write_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:33:3
	output wire outstanding_load_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:34:3
	output wire outstanding_store_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:35:3
	output wire [31:0] pc_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:36:3
	output wire perf_instr_ret_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:37:3
	output wire perf_instr_ret_compressed_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:39:3
	input wire [4:0] rf_waddr_id_i;
	// Trace: core/rtl/ibex_wb_stage.sv:40:3
	input wire [31:0] rf_wdata_id_i;
	// Trace: core/rtl/ibex_wb_stage.sv:41:3
	input wire rf_we_id_i;
	// Trace: core/rtl/ibex_wb_stage.sv:43:3
	input wire [31:0] rf_wdata_lsu_i;
	// Trace: core/rtl/ibex_wb_stage.sv:44:3
	input wire rf_we_lsu_i;
	// Trace: core/rtl/ibex_wb_stage.sv:46:3
	output wire [31:0] rf_wdata_fwd_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:48:3
	output wire [4:0] rf_waddr_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:49:3
	output wire [31:0] rf_wdata_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:50:3
	output wire rf_we_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:52:3
	input wire lsu_resp_valid_i;
	// Trace: core/rtl/ibex_wb_stage.sv:53:3
	input wire lsu_resp_err_i;
	// Trace: core/rtl/ibex_wb_stage.sv:55:3
	output wire instr_done_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:57:3
	output wire [31:0] instr_done_rdata_wb_o;
	// Trace: core/rtl/ibex_wb_stage.sv:61:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_wb_stage.sv:65:3
	wire [31:0] rf_wdata_wb_mux [0:1];
	// Trace: core/rtl/ibex_wb_stage.sv:66:3
	wire [1:0] rf_wdata_wb_mux_we;
	// Trace: core/rtl/ibex_wb_stage.sv:68:3
	generate
		if (WritebackStage) begin : g_writeback_stage
			// Trace: core/rtl/ibex_wb_stage.sv:69:5
			reg [31:0] rf_wdata_wb_q;
			// Trace: core/rtl/ibex_wb_stage.sv:70:5
			reg rf_we_wb_q;
			// Trace: core/rtl/ibex_wb_stage.sv:71:5
			reg [4:0] rf_waddr_wb_q;
			// Trace: core/rtl/ibex_wb_stage.sv:73:5
			wire wb_done;
			// Trace: core/rtl/ibex_wb_stage.sv:75:5
			reg wb_valid_q;
			// Trace: core/rtl/ibex_wb_stage.sv:76:5
			reg [31:0] wb_pc_q;
			// Trace: core/rtl/ibex_wb_stage.sv:78:5
			reg [31:0] wb_instr_q;
			// Trace: core/rtl/ibex_wb_stage.sv:80:5
			reg wb_compressed_q;
			// Trace: core/rtl/ibex_wb_stage.sv:81:5
			reg wb_count_q;
			// Trace: core/rtl/ibex_wb_stage.sv:82:5
			reg [1:0] wb_instr_type_q;
			// Trace: core/rtl/ibex_wb_stage.sv:84:5
			wire wb_valid_d;
			// Trace: core/rtl/ibex_wb_stage.sv:88:5
			assign wb_valid_d = (en_wb_i & ready_wb_o) | (wb_valid_q & ~wb_done);
			// Trace: core/rtl/ibex_wb_stage.sv:93:5
			assign wb_done = (wb_instr_type_q == 2'd2) | lsu_resp_valid_i;
			// Trace: core/rtl/ibex_wb_stage.sv:95:5
			always @(posedge clk_i or negedge rst_ni)
				// Trace: core/rtl/ibex_wb_stage.sv:96:7
				if (~rst_ni)
					// Trace: core/rtl/ibex_wb_stage.sv:97:9
					wb_valid_q <= 1'b0;
				else
					// Trace: core/rtl/ibex_wb_stage.sv:99:9
					wb_valid_q <= wb_valid_d;
			// Trace: core/rtl/ibex_wb_stage.sv:103:5
			always @(posedge clk_i)
				// Trace: core/rtl/ibex_wb_stage.sv:104:7
				if (en_wb_i) begin
					// Trace: core/rtl/ibex_wb_stage.sv:105:9
					rf_we_wb_q <= rf_we_id_i;
					// Trace: core/rtl/ibex_wb_stage.sv:106:9
					rf_waddr_wb_q <= rf_waddr_id_i;
					// Trace: core/rtl/ibex_wb_stage.sv:107:9
					rf_wdata_wb_q <= rf_wdata_id_i;
					// Trace: core/rtl/ibex_wb_stage.sv:108:9
					wb_instr_type_q <= instr_type_wb_i;
					// Trace: core/rtl/ibex_wb_stage.sv:109:9
					wb_pc_q <= pc_id_i;
					// Trace: core/rtl/ibex_wb_stage.sv:111:9
					wb_instr_q <= instr_rdata_id_i;
					// Trace: core/rtl/ibex_wb_stage.sv:113:9
					wb_compressed_q <= instr_is_compressed_id_i;
					// Trace: core/rtl/ibex_wb_stage.sv:114:9
					wb_count_q <= instr_perf_count_id_i;
				end
			// Trace: core/rtl/ibex_wb_stage.sv:118:5
			assign rf_waddr_wb_o = rf_waddr_wb_q;
			// Trace: core/rtl/ibex_wb_stage.sv:119:5
			assign rf_wdata_wb_mux[0] = rf_wdata_wb_q;
			// Trace: core/rtl/ibex_wb_stage.sv:120:5
			assign rf_wdata_wb_mux_we[0] = rf_we_wb_q & wb_valid_q;
			// Trace: core/rtl/ibex_wb_stage.sv:122:5
			assign ready_wb_o = ~wb_valid_q | wb_done;
			// Trace: core/rtl/ibex_wb_stage.sv:126:5
			assign rf_write_wb_o = wb_valid_q & (rf_we_wb_q | (wb_instr_type_q == 2'd0));
			// Trace: core/rtl/ibex_wb_stage.sv:128:5
			assign outstanding_load_wb_o = wb_valid_q & (wb_instr_type_q == 2'd0);
			// Trace: core/rtl/ibex_wb_stage.sv:129:5
			assign outstanding_store_wb_o = wb_valid_q & (wb_instr_type_q == 2'd1);
			// Trace: core/rtl/ibex_wb_stage.sv:131:5
			assign pc_wb_o = wb_pc_q;
			// Trace: core/rtl/ibex_wb_stage.sv:132:5
			assign instr_done_rdata_wb_o = wb_instr_q;
			// Trace: core/rtl/ibex_wb_stage.sv:134:5
			assign instr_done_wb_o = wb_valid_q & wb_done;
			// Trace: core/rtl/ibex_wb_stage.sv:137:5
			assign perf_instr_ret_wb_o = (instr_done_wb_o & wb_count_q) & ~(lsu_resp_valid_i & lsu_resp_err_i);
			// Trace: core/rtl/ibex_wb_stage.sv:139:5
			assign perf_instr_ret_compressed_wb_o = perf_instr_ret_wb_o & wb_compressed_q;
			// Trace: core/rtl/ibex_wb_stage.sv:144:5
			assign rf_wdata_fwd_wb_o = rf_wdata_wb_q;
		end
		else begin : g_bypass_wb
			// Trace: core/rtl/ibex_wb_stage.sv:147:5
			assign rf_waddr_wb_o = rf_waddr_id_i;
			// Trace: core/rtl/ibex_wb_stage.sv:148:5
			assign rf_wdata_wb_mux[0] = rf_wdata_id_i;
			// Trace: core/rtl/ibex_wb_stage.sv:149:5
			assign rf_wdata_wb_mux_we[0] = rf_we_id_i;
			// Trace: core/rtl/ibex_wb_stage.sv:152:5
			assign perf_instr_ret_wb_o = (instr_perf_count_id_i & en_wb_i) & ~(lsu_resp_valid_i & lsu_resp_err_i);
			// Trace: core/rtl/ibex_wb_stage.sv:154:5
			assign perf_instr_ret_compressed_wb_o = perf_instr_ret_wb_o & instr_is_compressed_id_i;
			// Trace: core/rtl/ibex_wb_stage.sv:157:5
			assign ready_wb_o = 1'b1;
			// Trace: core/rtl/ibex_wb_stage.sv:162:5
			wire unused_clk;
			// Trace: core/rtl/ibex_wb_stage.sv:163:5
			wire unused_rst;
			// Trace: core/rtl/ibex_wb_stage.sv:164:5
			wire [1:0] unused_instr_type_wb;
			// Trace: core/rtl/ibex_wb_stage.sv:165:5
			wire [31:0] unused_pc_id;
			// Trace: core/rtl/ibex_wb_stage.sv:167:5
			assign unused_clk = clk_i;
			// Trace: core/rtl/ibex_wb_stage.sv:168:5
			assign unused_rst = rst_ni;
			// Trace: core/rtl/ibex_wb_stage.sv:169:5
			assign unused_instr_type_wb = instr_type_wb_i;
			// Trace: core/rtl/ibex_wb_stage.sv:170:5
			assign unused_pc_id = pc_id_i;
			// Trace: core/rtl/ibex_wb_stage.sv:172:5
			assign outstanding_load_wb_o = 1'b0;
			// Trace: core/rtl/ibex_wb_stage.sv:173:5
			assign outstanding_store_wb_o = 1'b0;
			// Trace: core/rtl/ibex_wb_stage.sv:174:5
			assign pc_wb_o = 1'sb0;
			// Trace: core/rtl/ibex_wb_stage.sv:175:5
			assign rf_write_wb_o = 1'b0;
			// Trace: core/rtl/ibex_wb_stage.sv:176:5
			assign rf_wdata_fwd_wb_o = 32'b00000000000000000000000000000000;
			// Trace: core/rtl/ibex_wb_stage.sv:177:5
			assign instr_done_wb_o = 1'b0;
		end
	endgenerate
	// Trace: core/rtl/ibex_wb_stage.sv:180:3
	assign rf_wdata_wb_mux[1] = rf_wdata_lsu_i;
	// Trace: core/rtl/ibex_wb_stage.sv:181:3
	assign rf_wdata_wb_mux_we[1] = rf_we_lsu_i;
	// Trace: core/rtl/ibex_wb_stage.sv:185:3
	assign rf_wdata_wb_o = (rf_wdata_wb_mux_we[0] ? rf_wdata_wb_mux[0] : rf_wdata_wb_mux[1]);
	// Trace: core/rtl/ibex_wb_stage.sv:186:3
	assign rf_we_wb_o = |rf_wdata_wb_mux_we;
endmodule
