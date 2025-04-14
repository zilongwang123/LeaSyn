module DatPath_2stage(
  input        clock,
  input        reset,
  input  [2:0] io_ctl_pc_sel,
  output       io_dat_csr_interrupt,
  input        io_interrupt_debug
);
  wire  csr_clock; // @[dpath.scala 228:20]
  wire  csr_reset; // @[dpath.scala 228:20]
  wire  csr_io_ungated_clock; // @[dpath.scala 228:20]
  wire  csr_io_interrupts_debug; // @[dpath.scala 228:20]
  wire  csr_io_csr_stall; // @[dpath.scala 228:20]
  wire  csr_io_singleStep; // @[dpath.scala 228:20]
  wire  csr_io_status_cease; // @[dpath.scala 228:20]
  wire  csr_io_exception; // @[dpath.scala 228:20]
  wire  csr_io_retire; // @[dpath.scala 228:20]
  wire [31:0] csr_io_time; // @[dpath.scala 228:20]
  wire  csr_io_interrupt; // @[dpath.scala 228:20]
  wire [31:0] _T_4 = csr_io_time; // @[dpath.scala 297:18]
  wire [7:0] _T_8 = 3'h1 == io_ctl_pc_sel ? 8'h42 : 8'h3f; // @[Mux.scala 81:58]
  wire [7:0] _T_10 = 3'h2 == io_ctl_pc_sel ? 8'h4a : _T_8; // @[Mux.scala 81:58]
  wire [7:0] _T_12 = 3'h3 == io_ctl_pc_sel ? 8'h52 : _T_10; // @[Mux.scala 81:58]
  wire [7:0] _T_14 = 3'h4 == io_ctl_pc_sel ? 8'h45 : _T_12; // @[Mux.scala 81:58]
  wire [7:0] _T_16 = 3'h0 == io_ctl_pc_sel ? 8'h20 : _T_14; // @[Mux.scala 81:58]
  wire [7:0] _T_17 = csr_io_exception ? 8'h58 : 8'h20; // @[dpath.scala 317:10]
  CSRFile_2stage CSRFile_2stage ( // @[dpath.scala 228:20]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_ungated_clock(csr_io_ungated_clock),
    .io_interrupts_debug(csr_io_interrupts_debug),
    .io_csr_stall(csr_io_csr_stall),
    .io_singleStep(csr_io_singleStep),
    .io_status_cease(csr_io_status_cease),
    .io_exception(csr_io_exception),
    .io_retire(csr_io_retire),
    .io_time(csr_io_time),
    .io_interrupt(csr_io_interrupt)
  );
  assign io_dat_csr_interrupt = csr_io_interrupt; // @[dpath.scala 253:42]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_ungated_clock = clock; // @[dpath.scala 259:25]
  assign csr_io_interrupts_debug = io_interrupt_debug; // @[dpath.scala 255:22]
  assign csr_io_exception = 1'h0; // @[dpath.scala 237:21]
  assign csr_io_retire = 1'h0; // @[dpath.scala 236:38]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,
            "Cyc= %d [%d] pc=[%x] W[r%d=%x][%d] Op1=[r%d][%x] Op2=[r%d][%x] inst=[%x] %c%c%c DASM(%x)\n",_T_4,
            csr_io_retire,32'h0,5'h0,32'h0,1'h0,5'h0,32'h0,5'h0,32'h0,32'h4033,8'h53,_T_16,_T_17,32'h4033); // @[dpath.scala 296:10]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule