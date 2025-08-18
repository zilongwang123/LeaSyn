module top;
	// Trace: verif/top.sv:8:16
	(* gclk *) reg clk;
	// Trace: verif/top.sv:10:5
	reg clock;
	// Trace: verif/top.sv:11:5
	initial begin
		// Trace: verif/top.sv:11:13
		clock = 0;
	end
	// Trace: verif/top.sv:12:5
	always @(posedge clk)
		// Trace: verif/top.sv:13:9
		clock <= !clock;
	// Trace: verif/top.sv:16:5
	wire clock_1;
	// Trace: verif/top.sv:17:5
	wire clock_2;
	// Trace: verif/top.sv:19:5
	reg reset_1;
	// Trace: verif/top.sv:20:5
	reg reset_2;
	// Trace: verif/top.sv:21:2
	initial begin
		// Trace: verif/top.sv:22:9
		#(10)
			;
		// Trace: verif/top.sv:23:3
		reset_1 <= 1;
		// Trace: verif/top.sv:24:3
		reset_2 <= 1;
		#(40)
			;
		// Trace: verif/top.sv:26:3
		reset_1 <= 0;
		// Trace: verif/top.sv:27:3
		reset_2 <= 0;
	end
	// Trace: verif/top.sv:36:2
	integer counter;
	// Trace: verif/top.sv:37:2
	initial begin
		// Trace: verif/top.sv:37:10
		counter <= 0;
	end
	// Trace: verif/top.sv:38:2
	always @(posedge clock)
		// Trace: verif/top.sv:39:3
		counter <= counter + 1;
	// Trace: verif/top.sv:43:5
	wire instr_req_1;
	// Trace: verif/top.sv:44:5
	wire instr_req_2;
	// Trace: verif/top.sv:45:5
	wire [31:0] instr_addr_1;
	// Trace: verif/top.sv:46:5
	wire [31:0] instr_addr_2;
	// Trace: verif/top.sv:47:5
	wire instr_gnt_1;
	// Trace: verif/top.sv:48:5
	wire instr_gnt_2;
	// Trace: verif/top.sv:49:5
	wire [31:0] instr_1;
	// Trace: verif/top.sv:50:5
	wire [31:0] instr_2;
	// Trace: verif/top.sv:53:5
	wire data_req_1;
	// Trace: verif/top.sv:54:5
	wire data_req_2;
	// Trace: verif/top.sv:55:5
	wire data_we_1;
	// Trace: verif/top.sv:56:5
	wire data_we_2;
	// Trace: verif/top.sv:57:5
	wire [3:0] data_be_1;
	// Trace: verif/top.sv:58:5
	wire [3:0] data_be_2;
	// Trace: verif/top.sv:59:5
	wire [31:0] data_addr_1;
	// Trace: verif/top.sv:60:5
	wire [31:0] data_addr_2;
	// Trace: verif/top.sv:61:5
	wire data_gnt_1;
	// Trace: verif/top.sv:62:5
	wire data_gnt_2;
	// Trace: verif/top.sv:63:5
	wire data_rvalid_1;
	// Trace: verif/top.sv:64:5
	wire data_rvalid_2;
	// Trace: verif/top.sv:65:5
	wire [31:0] data_rdata_1;
	// Trace: verif/top.sv:66:5
	wire [31:0] data_rdata_2;
	// Trace: verif/top.sv:67:5
	wire [31:0] data_wdata_1;
	// Trace: verif/top.sv:68:5
	wire [31:0] data_wdata_2;
	// Trace: verif/top.sv:69:5
	wire data_err_1;
	// Trace: verif/top.sv:70:5
	wire data_err_2;
	// Trace: verif/top.sv:72:5
	wire irq_x_ack_1;
	// Trace: verif/top.sv:73:5
	wire irq_x_ack_2;
	// Trace: verif/top.sv:74:5
	wire [4:0] irq_x_ack_id_1;
	// Trace: verif/top.sv:75:5
	wire [4:0] irq_x_ack_id_2;
	// Trace: verif/top.sv:77:5
	wire alert_major_1;
	// Trace: verif/top.sv:78:5
	wire alert_major_2;
	// Trace: verif/top.sv:79:5
	wire alert_minor_1;
	// Trace: verif/top.sv:80:5
	wire alert_minor_2;
	// Trace: verif/top.sv:81:5
	wire core_sleep_1;
	// Trace: verif/top.sv:82:5
	wire core_sleep_2;
	// Trace: verif/top.sv:85:5
	wire retire_1;
	// Trace: verif/top.sv:86:5
	wire retire_2;
	// Trace: verif/top.sv:87:5
	wire [31:0] retire_instr_1;
	// Trace: verif/top.sv:88:5
	wire [31:0] retire_instr_2;
	// Trace: verif/top.sv:89:5
	wire fetch_1;
	// Trace: verif/top.sv:90:5
	wire fetch_2;
	// Trace: verif/top.sv:91:5
	wire [31:0] mem_r_data_1;
	// Trace: verif/top.sv:92:5
	wire [31:0] mem_w_data_1;
	// Trace: verif/top.sv:93:5
	wire [31:0] mem_r_data_2;
	// Trace: verif/top.sv:94:5
	wire [31:0] mem_w_data_2;
	// Trace: verif/top.sv:96:5
	wire retire;
	// Trace: verif/top.sv:97:5
	wire atk_equiv;
	// Trace: verif/top.sv:98:5
	wire ctr_equiv;
	// Trace: verif/top.sv:100:5
	wire enable_1;
	// Trace: verif/top.sv:101:5
	wire enable_2;
	// Trace: verif/top.sv:102:5
	wire finished;
	// Trace: verif/top.sv:105:9
	wire valid_1;
	// Trace: verif/top.sv:106:9
	wire valid_2;
	// Trace: verif/top.sv:107:9
	wire [31:0] insn_1;
	// Trace: verif/top.sv:108:9
	wire [31:0] insn_2;
	// Trace: verif/top.sv:109:9
	wire [4:0] rd_1;
	// Trace: verif/top.sv:110:9
	wire [4:0] rd_2;
	// Trace: verif/top.sv:111:9
	wire [4:0] rs1_1;
	// Trace: verif/top.sv:112:9
	wire [4:0] rs1_2;
	// Trace: verif/top.sv:113:9
	wire [4:0] rs2_1;
	// Trace: verif/top.sv:114:9
	wire [4:0] rs2_2;
	// Trace: verif/top.sv:115:9
	wire [31:0] rs1_rdata_1;
	// Trace: verif/top.sv:116:9
	wire [31:0] rs1_rdata_2;
	// Trace: verif/top.sv:117:9
	wire [31:0] rs2_rdata_1;
	// Trace: verif/top.sv:118:9
	wire [31:0] rs2_rdata_2;
	// Trace: verif/top.sv:119:9
	wire [31:0] rd_wdata_1;
	// Trace: verif/top.sv:120:9
	wire [31:0] rd_wdata_2;
	// Trace: verif/top.sv:121:9
	wire [31:0] mem_addr_1;
	// Trace: verif/top.sv:122:9
	wire [31:0] mem_addr_2;
	// Trace: verif/top.sv:123:9
	wire [31:0] mem_rdata_1;
	// Trace: verif/top.sv:124:9
	wire [31:0] mem_rdata_2;
	// Trace: verif/top.sv:125:9
	wire [31:0] mem_wdata_1;
	// Trace: verif/top.sv:126:9
	wire [31:0] mem_wdata_2;
	// Trace: verif/top.sv:127:9
	wire [3:0] mem_rmask_1;
	// Trace: verif/top.sv:128:9
	wire [3:0] mem_rmask_2;
	// Trace: verif/top.sv:129:9
	wire [3:0] mem_wmask_1;
	// Trace: verif/top.sv:130:9
	wire [3:0] mem_wmask_2;
	// Trace: verif/top.sv:131:9
	wire [31:0] mem_addr_real_1;
	// Trace: verif/top.sv:132:9
	wire [31:0] mem_addr_real_2;
	// Trace: verif/top.sv:133:9
	wire [31:0] new_pc_1;
	// Trace: verif/top.sv:134:9
	wire [31:0] new_pc_2;
	// Trace: verif/top.sv:135:9
	wire rvfi_trap_1;
	// Trace: verif/top.sv:136:9
	wire rvfi_trap_2;
	// Trace: verif/top.sv:140:5
	instr_mem #(.ID(1)) instr_mem_1(
		.clk_i(clock_1),
		.enable_i(enable_1),
		.instr_req_i(instr_req_1),
		.instr_addr_i(instr_addr_1),
		.instr_gnt_o(instr_gnt_1),
		.instr_o(instr_1)
	);
	// Trace: verif/top.sv:151:5
	instr_mem #(.ID(2)) instr_mem_2(
		.clk_i(clock_2),
		.enable_i(enable_2),
		.instr_req_i(instr_req_2),
		.instr_addr_i(instr_addr_2),
		.instr_gnt_o(instr_gnt_2),
		.instr_o(instr_2)
	);
	// Trace: verif/top.sv:162:5
	data_mem data_mem_1(
		.clk_i(clock_1),
		.data_req_i(data_req_1),
		.data_we_i(data_we_1),
		.data_be_i(data_be_1),
		.data_addr_i(data_addr_1),
		.data_wdata_i(data_wdata_1),
		.data_gnt_o(data_gnt_1),
		.data_rvalid_o(data_rvalid_1),
		.data_rdata_o(data_rdata_1),
		.data_err_o(data_err_1)
	);
	// Trace: verif/top.sv:175:5
	data_mem data_mem_2(
		.clk_i(clock_2),
		.data_req_i(data_req_2),
		.data_we_i(data_we_2),
		.data_be_i(data_be_2),
		.data_addr_i(data_addr_2),
		.data_wdata_i(data_wdata_2),
		.data_gnt_o(data_gnt_2),
		.data_rvalid_o(data_rvalid_2),
		.data_rdata_o(data_rdata_2),
		.data_err_o(data_err_2)
	);
	// Trace: verif/top.sv:188:5
	wire data_re_1;
	// Trace: verif/top.sv:189:5
	wire [1:0] flush_1;
	// Trace: verif/top.sv:190:5
	wire retire_trap_1;
	darkriscv_3stages core_1(
		.CLK(clock_1),
		.RES(reset_1),
		.HLT(1'b0),
		.IDATA(instr_1),
		.IADDR(instr_addr_1),
		.DATAI(data_rdata_1),
		.DATAO(data_wdata_1),
		.DADDR(data_addr_1),
		.BE(data_be_1),
		.WR(data_we_1),
		.RD(data_re_1),
		.IDLE(),
		.DEBUG(),
		.FLUSH(flush_1),
		.rvfi_valid(retire_1),
		.rvfi_order(),
		.rvfi_insn(retire_instr_1),
		.rvfi_trap(retire_trap_1),
		.rvfi_halt(),
		.rvfi_intr(),
		.rvfi_mode(),
		.rvfi_ixl(),
		.rvfi_rs1_addr(rs1_1),
		.rvfi_rs2_addr(rs2_1),
		.rvfi_rs3_addr(),
		.rvfi_rs1_rdata(rs1_rdata_1),
		.rvfi_rs2_rdata(rs2_rdata_1),
		.rvfi_rs3_rdata(),
		.rvfi_rd_addr(rd_1),
		.rvfi_rd_wdata(rd_wdata_1),
		.rvfi_pc_rdata(),
		.rvfi_pc_wdata(new_pc_1),
		.rvfi_mem_addr(mem_addr_1),
		.rvfi_mem_rmask(mem_rmask_1),
		.rvfi_mem_wmask(mem_wmask_1),
		.rvfi_mem_rdata(mem_rdata_1),
		.rvfi_mem_wdata(mem_wdata_1)
	);
	// Trace: verif/top.sv:229:5
	assign instr_req_1 = 1'b1;
	// Trace: verif/top.sv:230:5
	assign data_req_1 = data_re_1 || data_we_1;
	// Trace: verif/top.sv:231:5
	reg flushed_1;
	// Trace: verif/top.sv:232:5
	always @(posedge clock_1)
		// Trace: verif/top.sv:233:9
		flushed_1 <= |flush_1;
	// Trace: verif/top.sv:235:5
	assign fetch_1 = !flush_1;
	// Trace: verif/top.sv:237:5
	wire data_re_2;
	// Trace: verif/top.sv:238:5
	wire [1:0] flush_2;
	// Trace: verif/top.sv:239:5
	wire retire_trap_2;
	darkriscv_3stages core_2(
		.CLK(clock_2),
		.RES(reset_2),
		.HLT(1'b0),
		.IDATA(instr_2),
		.IADDR(instr_addr_2),
		.DATAI(data_rdata_2),
		.DATAO(data_wdata_2),
		.DADDR(data_addr_2),
		.BE(data_be_2),
		.WR(data_we_2),
		.RD(data_re_2),
		.IDLE(),
		.DEBUG(),
		.FLUSH(flush_2),
		.rvfi_valid(retire_2),
		.rvfi_order(),
		.rvfi_insn(retire_instr_2),
		.rvfi_trap(retire_trap_2),
		.rvfi_halt(),
		.rvfi_intr(),
		.rvfi_mode(),
		.rvfi_ixl(),
		.rvfi_rs1_addr(rs1_2),
		.rvfi_rs2_addr(rs2_2),
		.rvfi_rs3_addr(),
		.rvfi_rs1_rdata(rs1_rdata_2),
		.rvfi_rs2_rdata(rs2_rdata_2),
		.rvfi_rs3_rdata(),
		.rvfi_rd_addr(rd_2),
		.rvfi_rd_wdata(rd_wdata_2),
		.rvfi_pc_rdata(),
		.rvfi_pc_wdata(new_pc_2),
		.rvfi_mem_addr(mem_addr_2),
		.rvfi_mem_rmask(mem_rmask_2),
		.rvfi_mem_wmask(mem_wmask_2),
		.rvfi_mem_rdata(mem_rdata_2),
		.rvfi_mem_wdata(mem_wdata_2)
	);
	// Trace: verif/top.sv:278:5
	assign instr_req_2 = 1'b1;
	// Trace: verif/top.sv:279:5
	assign data_req_2 = data_re_2 || data_we_2;
	// Trace: verif/top.sv:280:5
	reg flushed_2;
	// Trace: verif/top.sv:281:5
	always @(posedge clock_2)
		// Trace: verif/top.sv:282:9
		flushed_2 <= |flush_2;
	// Trace: verif/top.sv:284:5
	assign fetch_2 = !flush_2;
	// Trace: verif/top.sv:286:5
	atk atk(
		.clk_i(clock),
		.atk_observation_1_i(clock_1),
		.atk_observation_2_i(clock_2),
		.atk_equiv_o(atk_equiv)
	);
	// Trace: verif/top.sv:293:5
	assign mem_r_data_1 = {(mem_rmask_1[3] ? mem_rdata_1[31:24] : 8'b00000000), (mem_rmask_1[2] ? mem_rdata_1[23:16] : 8'b00000000), (mem_rmask_1[1] ? mem_rdata_1[15:8] : 8'b00000000), (mem_rmask_1[0] ? mem_rdata_1[7:0] : 8'b00000000)};
	// Trace: verif/top.sv:299:5
	assign mem_w_data_1 = {(mem_wmask_1[3] ? mem_wdata_1[31:24] : 8'b00000000), (mem_wmask_1[2] ? mem_wdata_1[23:16] : 8'b00000000), (mem_wmask_1[1] ? mem_wdata_1[15:8] : 8'b00000000), (mem_wmask_1[0] ? mem_wdata_1[7:0] : 8'b00000000)};
	// Trace: verif/top.sv:306:5
	assign mem_r_data_2 = {(mem_rmask_2[3] ? mem_rdata_2[31:24] : 8'b00000000), (mem_rmask_2[2] ? mem_rdata_2[23:16] : 8'b00000000), (mem_rmask_2[1] ? mem_rdata_2[15:8] : 8'b00000000), (mem_rmask_2[0] ? mem_rdata_2[7:0] : 8'b00000000)};
	// Trace: verif/top.sv:312:5
	assign mem_w_data_2 = {(mem_wmask_2[3] ? mem_wdata_2[31:24] : 8'b00000000), (mem_wmask_2[2] ? mem_wdata_2[23:16] : 8'b00000000), (mem_wmask_2[1] ? mem_wdata_2[15:8] : 8'b00000000), (mem_wmask_2[0] ? mem_wdata_2[7:0] : 8'b00000000)};
	// Trace: verif/top.sv:319:5
	assign mem_addr_real_1 = ((mem_rmask_1 == 0) && (mem_wmask_1 == 0) ? 0 : mem_addr_1);
	// Trace: verif/top.sv:320:5
	assign mem_addr_real_2 = ((mem_rmask_2 == 0) && (mem_wmask_2 == 0) ? 0 : mem_addr_2);
	// Trace: verif/top.sv:321:5
	ctr ctr(
		.clk_i(clock),
		.retire_i(retire),
		.instr_1_i(retire_instr_1),
		.instr_2_i(retire_instr_2),
		.rd_1(rd_1),
		.rd_2(rd_2),
		.rs1_1(rs1_1),
		.rs1_2(rs1_2),
		.rs2_1(rs2_1),
		.rs2_2(rs2_2),
		.reg_rs1_1(rs1_rdata_1),
		.reg_rs1_2(rs1_rdata_2),
		.reg_rs2_1(rs2_rdata_1),
		.reg_rs2_2(rs2_rdata_2),
		.reg_rd_1(rd_wdata_1),
		.reg_rd_2(rd_wdata_2),
		.mem_addr_1(mem_addr_real_1),
		.mem_addr_2(mem_addr_real_2),
		.mem_r_data_1(mem_r_data_1),
		.mem_r_data_2(mem_r_data_2),
		.mem_r_mask_1(mem_rmask_1),
		.mem_r_mask_2(mem_rmask_2),
		.mem_w_data_1(mem_w_data_1),
		.mem_w_data_2(mem_w_data_2),
		.mem_w_mask_1(mem_wmask_1),
		.mem_w_mask_2(mem_wmask_2),
		.new_pc_1(new_pc_1),
		.new_pc_2(new_pc_2),
		.ctr_equiv_o(ctr_equiv)
	);
	// Trace: verif/top.sv:353:5
	clk_sync clk_sync(
		.clk_i(clock),
		.retire_1_i(retire_1),
		.retire_2_i(retire_2),
		.clk_1_o(clock_1),
		.clk_2_o(clock_2),
		.retire_o(retire)
	);
	// Trace: verif/top.sv:362:5
	control control(
		.clk_i(clock),
		.retire_i(retire),
		.fetch_1_i(fetch_1),
		.fetch_2_i(fetch_2),
		.instr_addr_1_i(instr_addr_1),
		.instr_addr_2_i(instr_addr_2),
		.enable_1_o(enable_1),
		.enable_2_o(enable_2),
		.finished_o(finished)
	);
    always @(posedge clk) begin
        if ((retire_1 && (new_pc_1[1:0] != 2'b00 || rvfi_trap_1)) || (retire_2 && (new_pc_2[1:0] != 2'b00 || rvfi_trap_2)))
        begin
            $display("ERROR");
            $finish;
        end
        if (finished && ctr_equiv && !atk_equiv) 
        begin
            $display("FAIL");
            $finish;
        end
        else if (finished && !ctr_equiv && atk_equiv)
        begin
            $display("FALSE_POSITIVE");
            $finish;
        end if (finished)
        begin
            $display("SUCCESS");
            $finish;
        end
    end

    initial
	begin
		$dumpfile("sim.vcd");
		$dumpvars();
		//$dumpvars(1, top.ctr);
		//$dumpvars(1, top.control);
		//$dumpvars(1, top.atk);
		//$dumpvars(1, top.instr_mem_1.instr_o);
		//$dumpvars(1, top.instr_mem_2.instr_o);
		#10000;
        $display("TIMEOUT");
		$finish;
	end

    always begin
		clk <= 1;
        #5;
		clk <= 0;
        #5;
    end
endmodule
