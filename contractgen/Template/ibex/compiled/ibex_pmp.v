// removed package "ibex_pkg"
// removed package "ibex_tracer_pkg"
module ibex_pmp (
	clk_i,
	rst_ni,
	csr_pmp_cfg_i,
	csr_pmp_addr_i,
	priv_mode_i,
	pmp_req_addr_i,
	pmp_req_type_i,
	pmp_req_err_o
);
	reg _sv2v_0;
	// Trace: core/rtl/ibex_pmp.sv:8:15
	parameter [31:0] PMPGranularity = 0;
	// Trace: core/rtl/ibex_pmp.sv:10:15
	parameter [31:0] PMPNumChan = 2;
	// Trace: core/rtl/ibex_pmp.sv:12:15
	parameter [31:0] PMPNumRegions = 4;
	// Trace: core/rtl/ibex_pmp.sv:15:5
	input wire clk_i;
	// Trace: core/rtl/ibex_pmp.sv:16:5
	input wire rst_ni;
	// Trace: core/rtl/ibex_pmp.sv:19:5
	// removed localparam type ibex_pkg_pmp_cfg_mode_e
	// removed localparam type ibex_pkg_pmp_cfg_t
	input wire [(PMPNumRegions * 6) - 1:0] csr_pmp_cfg_i;
	// Trace: core/rtl/ibex_pmp.sv:20:5
	input wire [(PMPNumRegions * 34) - 1:0] csr_pmp_addr_i;
	// Trace: core/rtl/ibex_pmp.sv:22:5
	// removed localparam type ibex_pkg_priv_lvl_e
	input wire [(PMPNumChan * 2) - 1:0] priv_mode_i;
	// Trace: core/rtl/ibex_pmp.sv:24:5
	input wire [(PMPNumChan * 34) - 1:0] pmp_req_addr_i;
	// Trace: core/rtl/ibex_pmp.sv:25:5
	// removed localparam type ibex_pkg_pmp_req_e
	input wire [(PMPNumChan * 2) - 1:0] pmp_req_type_i;
	// Trace: core/rtl/ibex_pmp.sv:26:5
	output wire [0:PMPNumChan - 1] pmp_req_err_o;
	// Trace: core/rtl/ibex_pmp.sv:30:3
	// removed import ibex_pkg::*;
	// Trace: core/rtl/ibex_pmp.sv:33:3
	wire [33:0] region_start_addr [0:PMPNumRegions - 1];
	// Trace: core/rtl/ibex_pmp.sv:34:3
	wire [33:PMPGranularity + 2] region_addr_mask [0:PMPNumRegions - 1];
	// Trace: core/rtl/ibex_pmp.sv:35:3
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_match_gt;
	// Trace: core/rtl/ibex_pmp.sv:36:3
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_match_lt;
	// Trace: core/rtl/ibex_pmp.sv:37:3
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_match_eq;
	// Trace: core/rtl/ibex_pmp.sv:38:3
	reg [(PMPNumChan * PMPNumRegions) - 1:0] region_match_all;
	// Trace: core/rtl/ibex_pmp.sv:39:3
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_perm_check;
	// Trace: core/rtl/ibex_pmp.sv:40:3
	reg [PMPNumChan - 1:0] access_fault;
	// Trace: core/rtl/ibex_pmp.sv:47:3
	genvar _gv_r_1;
	generate
		for (_gv_r_1 = 0; _gv_r_1 < PMPNumRegions; _gv_r_1 = _gv_r_1 + 1) begin : g_addr_exp
			localparam r = _gv_r_1;
			if (r == 0) begin : g_entry0
				// Trace: core/rtl/ibex_pmp.sv:50:7
				assign region_start_addr[r] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] == 2'b01 ? 34'h000000000 : csr_pmp_addr_i[((PMPNumRegions - 1) - r) * 34+:34]);
			end
			else begin : g_oth
				// Trace: core/rtl/ibex_pmp.sv:53:7
				assign region_start_addr[r] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] == 2'b01 ? csr_pmp_addr_i[((PMPNumRegions - 1) - (r - 1)) * 34+:34] : csr_pmp_addr_i[((PMPNumRegions - 1) - r) * 34+:34]);
			end
			genvar _gv_b_1;
			for (_gv_b_1 = PMPGranularity + 2; _gv_b_1 < 34; _gv_b_1 = _gv_b_1 + 1) begin : g_bitmask
				localparam b = _gv_b_1;
				if (b == 2) begin : g_bit0
					// Trace: core/rtl/ibex_pmp.sv:60:9
					assign region_addr_mask[r][b] = csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] != 2'b11;
				end
				else begin : g_others
					if (PMPGranularity == 0) begin : g_region_addr_mask_zero_granularity
						// Trace: core/rtl/ibex_pmp.sv:68:11
						assign region_addr_mask[r][b] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] != 2'b11) | ~&csr_pmp_addr_i[(((PMPNumRegions - 1) - r) * 34) + ((b - 1) >= 2 ? b - 1 : ((b - 1) + ((b - 1) >= 2 ? b - 2 : 4 - b)) - 1)-:((b - 1) >= 2 ? b - 2 : 4 - b)];
					end
					else begin : g_region_addr_mask_other_granularity
						// Trace: core/rtl/ibex_pmp.sv:71:11
						assign region_addr_mask[r][b] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] != 2'b11) | ~&csr_pmp_addr_i[(((PMPNumRegions - 1) - r) * 34) + ((b - 1) >= (PMPGranularity + 1) ? b - 1 : ((b - 1) + ((b - 1) >= (PMPGranularity + 1) ? ((b - 1) - (PMPGranularity + 1)) + 1 : ((PMPGranularity + 1) - (b - 1)) + 1)) - 1)-:((b - 1) >= (PMPGranularity + 1) ? ((b - 1) - (PMPGranularity + 1)) + 1 : ((PMPGranularity + 1) - (b - 1)) + 1)];
					end
				end
			end
		end
	endgenerate
	// Trace: core/rtl/ibex_pmp.sv:78:3
	genvar _gv_c_1;
	generate
		for (_gv_c_1 = 0; _gv_c_1 < PMPNumChan; _gv_c_1 = _gv_c_1 + 1) begin : g_access_check
			localparam c = _gv_c_1;
			genvar _gv_r_2;
			for (_gv_r_2 = 0; _gv_r_2 < PMPNumRegions; _gv_r_2 = _gv_r_2 + 1) begin : g_regions
				localparam r = _gv_r_2;
				// Trace: core/rtl/ibex_pmp.sv:81:7
				assign region_match_eq[(c * PMPNumRegions) + r] = (pmp_req_addr_i[(((PMPNumChan - 1) - c) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)] & region_addr_mask[r]) == (region_start_addr[r][33:PMPGranularity + 2] & region_addr_mask[r]);
				// Trace: core/rtl/ibex_pmp.sv:85:7
				assign region_match_gt[(c * PMPNumRegions) + r] = pmp_req_addr_i[(((PMPNumChan - 1) - c) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)] > region_start_addr[r][33:PMPGranularity + 2];
				// Trace: core/rtl/ibex_pmp.sv:87:7
				assign region_match_lt[(c * PMPNumRegions) + r] = pmp_req_addr_i[(((PMPNumChan - 1) - c) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)] < csr_pmp_addr_i[(((PMPNumRegions - 1) - r) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)];
				// Trace: core/rtl/ibex_pmp.sv:90:7
				always @(*) begin
					if (_sv2v_0)
						;
					// Trace: core/rtl/ibex_pmp.sv:91:9
					region_match_all[(c * PMPNumRegions) + r] = 1'b0;
					// Trace: core/rtl/ibex_pmp.sv:92:9
					(* full_case, parallel_case *)
					case (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2])
						2'b00:
							// Trace: core/rtl/ibex_pmp.sv:93:28
							region_match_all[(c * PMPNumRegions) + r] = 1'b0;
						2'b10:
							// Trace: core/rtl/ibex_pmp.sv:94:28
							region_match_all[(c * PMPNumRegions) + r] = region_match_eq[(c * PMPNumRegions) + r];
						2'b11:
							// Trace: core/rtl/ibex_pmp.sv:95:28
							region_match_all[(c * PMPNumRegions) + r] = region_match_eq[(c * PMPNumRegions) + r];
						2'b01:
							// Trace: core/rtl/ibex_pmp.sv:97:13
							region_match_all[(c * PMPNumRegions) + r] = (region_match_eq[(c * PMPNumRegions) + r] | region_match_gt[(c * PMPNumRegions) + r]) & region_match_lt[(c * PMPNumRegions) + r];
						default:
							// Trace: core/rtl/ibex_pmp.sv:100:28
							region_match_all[(c * PMPNumRegions) + r] = 1'b0;
					endcase
				end
				// Trace: core/rtl/ibex_pmp.sv:105:7
				assign region_perm_check[(c * PMPNumRegions) + r] = (((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b00) & csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 2]) | ((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b01) & csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 1])) | ((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b10) & csr_pmp_cfg_i[((PMPNumRegions - 1) - r) * 6]);
			end
			// Trace: core/rtl/ibex_pmp.sv:112:5
			always @(*) begin
				if (_sv2v_0)
					;
				// Trace: core/rtl/ibex_pmp.sv:114:7
				access_fault[c] = priv_mode_i[((PMPNumChan - 1) - c) * 2+:2] != 2'b11;
				// Trace: core/rtl/ibex_pmp.sv:118:7
				begin : sv2v_autoblock_1
					// Trace: core/rtl/ibex_pmp.sv:118:12
					reg signed [31:0] r;
					// Trace: core/rtl/ibex_pmp.sv:118:12
					for (r = PMPNumRegions - 1; r >= 0; r = r - 1)
						begin
							// Trace: core/rtl/ibex_pmp.sv:119:9
							if (region_match_all[(c * PMPNumRegions) + r])
								// Trace: core/rtl/ibex_pmp.sv:120:11
								access_fault[c] = (priv_mode_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b11 ? csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 5] & ~region_perm_check[(c * PMPNumRegions) + r] : ~region_perm_check[(c * PMPNumRegions) + r]);
						end
				end
			end
			// Trace: core/rtl/ibex_pmp.sv:130:5
			assign pmp_req_err_o[c] = access_fault[c];
		end
	endgenerate
	initial _sv2v_0 = 0;
endmodule
