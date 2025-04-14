module SodorInternalTile_3stage(
  input         clock,
  input         reset,
  input         io_debug_port_req_valid,
  input  [31:0] io_debug_port_req_bits_addr,
  input  [31:0] io_debug_port_req_bits_data,
  input         io_debug_port_req_bits_fcn,
  input  [2:0]  io_debug_port_req_bits_typ,
  output        io_debug_port_resp_valid,
  output [31:0] io_debug_port_resp_bits_data,
  input         io_master_port_0_req_ready,
  output        io_master_port_0_req_valid,
  output [31:0] io_master_port_0_req_bits_addr,
  output [31:0] io_master_port_0_req_bits_data,
  output        io_master_port_0_req_bits_fcn,
  output [2:0]  io_master_port_0_req_bits_typ,
  input         io_master_port_0_resp_valid,
  input  [31:0] io_master_port_0_resp_bits_data,
  input         io_master_port_1_req_ready,
  output        io_master_port_1_req_valid,
  output [31:0] io_master_port_1_req_bits_addr,
  output [31:0] io_master_port_1_req_bits_data,
  output        io_master_port_1_req_bits_fcn,
  output [2:0]  io_master_port_1_req_bits_typ,
  input         io_master_port_1_resp_valid,
  input  [31:0] io_master_port_1_resp_bits_data,
  input         io_interrupt_debug,
  input         io_interrupt_mtip,
  input         io_interrupt_msip,
  input         io_interrupt_meip,
  input         io_hartid,
  input  [31:0] io_reset_vector
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  core_clock; // @[sodor_internal_tile.scala 60:22]
  wire  core_reset; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_imem_req_ready; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_imem_req_valid; // @[sodor_internal_tile.scala 60:22]
  wire [31:0] core_io_imem_req_bits_addr; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_imem_resp_valid; // @[sodor_internal_tile.scala 60:22]
  wire [31:0] core_io_imem_resp_bits_data; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_dmem_req_ready; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_dmem_req_valid; // @[sodor_internal_tile.scala 60:22]
  wire [31:0] core_io_dmem_req_bits_addr; // @[sodor_internal_tile.scala 60:22]
  wire [31:0] core_io_dmem_req_bits_data; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_dmem_req_bits_fcn; // @[sodor_internal_tile.scala 60:22]
  wire [2:0] core_io_dmem_req_bits_typ; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_dmem_resp_valid; // @[sodor_internal_tile.scala 60:22]
  wire [31:0] core_io_dmem_resp_bits_data; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_interrupt_debug; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_interrupt_mtip; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_interrupt_msip; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_interrupt_meip; // @[sodor_internal_tile.scala 60:22]
  wire  core_io_hartid; // @[sodor_internal_tile.scala 60:22]
  wire [31:0] core_io_reset_vector; // @[sodor_internal_tile.scala 60:22]
  wire  memory_clock; // @[sodor_internal_tile.scala 67:22]
  wire  memory_reset; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_core_ports_0_req_valid; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_core_ports_0_req_bits_addr; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_core_ports_0_req_bits_data; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_core_ports_0_req_bits_fcn; // @[sodor_internal_tile.scala 67:22]
  wire [2:0] memory_io_core_ports_0_req_bits_typ; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_core_ports_0_resp_valid; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_core_ports_0_resp_bits_data; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_core_ports_1_req_valid; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_core_ports_1_req_bits_addr; // @[sodor_internal_tile.scala 67:22]
  wire [2:0] memory_io_core_ports_1_req_bits_typ; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_core_ports_1_resp_valid; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_core_ports_1_resp_bits_data; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_debug_port_req_valid; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_debug_port_req_bits_addr; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_debug_port_req_bits_data; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_debug_port_req_bits_fcn; // @[sodor_internal_tile.scala 67:22]
  wire [2:0] memory_io_debug_port_req_bits_typ; // @[sodor_internal_tile.scala 67:22]
  wire  memory_io_debug_port_resp_valid; // @[sodor_internal_tile.scala 67:22]
  wire [31:0] memory_io_debug_port_resp_bits_data; // @[sodor_internal_tile.scala 67:22]
  wire  router_io_masterPort_req_ready; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_masterPort_req_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_masterPort_req_bits_addr; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_masterPort_req_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_masterPort_req_bits_fcn; // @[sodor_internal_tile.scala 74:24]
  wire [2:0] router_io_masterPort_req_bits_typ; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_masterPort_resp_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_masterPort_resp_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_scratchPort_req_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_scratchPort_req_bits_addr; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_scratchPort_req_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_scratchPort_req_bits_fcn; // @[sodor_internal_tile.scala 74:24]
  wire [2:0] router_io_scratchPort_req_bits_typ; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_scratchPort_resp_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_scratchPort_resp_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_corePort_req_ready; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_corePort_req_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_corePort_req_bits_addr; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_corePort_req_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_corePort_req_bits_fcn; // @[sodor_internal_tile.scala 74:24]
  wire [2:0] router_io_corePort_req_bits_typ; // @[sodor_internal_tile.scala 74:24]
  wire  router_io_corePort_resp_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_corePort_resp_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_io_respAddress; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_masterPort_req_ready; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_masterPort_req_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_masterPort_req_bits_addr; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_masterPort_req_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_masterPort_req_bits_fcn; // @[sodor_internal_tile.scala 74:24]
  wire [2:0] router_1_io_masterPort_req_bits_typ; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_masterPort_resp_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_masterPort_resp_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_scratchPort_req_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_scratchPort_req_bits_addr; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_scratchPort_req_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_scratchPort_req_bits_fcn; // @[sodor_internal_tile.scala 74:24]
  wire [2:0] router_1_io_scratchPort_req_bits_typ; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_scratchPort_resp_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_scratchPort_resp_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_corePort_req_ready; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_corePort_req_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_corePort_req_bits_addr; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_corePort_req_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_corePort_req_bits_fcn; // @[sodor_internal_tile.scala 74:24]
  wire [2:0] router_1_io_corePort_req_bits_typ; // @[sodor_internal_tile.scala 74:24]
  wire  router_1_io_corePort_resp_valid; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_corePort_resp_bits_data; // @[sodor_internal_tile.scala 74:24]
  wire [31:0] router_1_io_respAddress; // @[sodor_internal_tile.scala 74:24]
  reg [31:0] reg_resp_address; // @[sodor_internal_tile.scala 79:31]
  wire  core_ports_0_req_ready = router_io_corePort_req_ready; // @[sodor_internal_tile.scala 62:24 75:24]
  wire  core_ports_0_req_valid = core_io_dmem_req_valid; // @[sodor_internal_tile.scala 62:24 64:16]
  wire  _T = core_ports_0_req_ready & core_ports_0_req_valid; // @[Decoupled.scala 50:35]
  wire [31:0] core_ports_0_req_bits_addr = core_io_dmem_req_bits_addr; // @[sodor_internal_tile.scala 62:24 64:16]
  reg [31:0] reg_resp_address_1; // @[sodor_internal_tile.scala 79:31]
  wire  core_ports_1_req_ready = router_1_io_corePort_req_ready; // @[sodor_internal_tile.scala 62:24 75:24]
  wire  core_ports_1_req_valid = core_io_imem_req_valid; // @[sodor_internal_tile.scala 62:24 63:16]
  wire  _T_1 = core_ports_1_req_ready & core_ports_1_req_valid; // @[Decoupled.scala 50:35]
  wire [31:0] core_ports_1_req_bits_addr = core_io_imem_req_bits_addr; // @[sodor_internal_tile.scala 62:24 63:16]
  Core_3stage core ( // @[sodor_internal_tile.scala 60:22]
    .clock(core_clock),
    .reset(core_reset),
    .io_imem_req_ready(core_io_imem_req_ready),
    .io_imem_req_valid(core_io_imem_req_valid),
    .io_imem_req_bits_addr(core_io_imem_req_bits_addr),
    .io_imem_resp_valid(core_io_imem_resp_valid),
    .io_imem_resp_bits_data(core_io_imem_resp_bits_data),
    .io_dmem_req_ready(core_io_dmem_req_ready),
    .io_dmem_req_valid(core_io_dmem_req_valid),
    .io_dmem_req_bits_addr(core_io_dmem_req_bits_addr),
    .io_dmem_req_bits_data(core_io_dmem_req_bits_data),
    .io_dmem_req_bits_fcn(core_io_dmem_req_bits_fcn),
    .io_dmem_req_bits_typ(core_io_dmem_req_bits_typ),
    .io_dmem_resp_valid(core_io_dmem_resp_valid),
    .io_dmem_resp_bits_data(core_io_dmem_resp_bits_data),
    .io_interrupt_debug(core_io_interrupt_debug),
    .io_interrupt_mtip(core_io_interrupt_mtip),
    .io_interrupt_msip(core_io_interrupt_msip),
    .io_interrupt_meip(core_io_interrupt_meip),
    .io_hartid(core_io_hartid),
    .io_reset_vector(core_io_reset_vector)
  );
  SyncScratchPadMemory_3stage memory ( // @[sodor_internal_tile.scala 67:22]
    .clock(memory_clock),
    .reset(memory_reset),
    .io_core_ports_0_req_valid(memory_io_core_ports_0_req_valid),
    .io_core_ports_0_req_bits_addr(memory_io_core_ports_0_req_bits_addr),
    .io_core_ports_0_req_bits_data(memory_io_core_ports_0_req_bits_data),
    .io_core_ports_0_req_bits_fcn(memory_io_core_ports_0_req_bits_fcn),
    .io_core_ports_0_req_bits_typ(memory_io_core_ports_0_req_bits_typ),
    .io_core_ports_0_resp_valid(memory_io_core_ports_0_resp_valid),
    .io_core_ports_0_resp_bits_data(memory_io_core_ports_0_resp_bits_data),
    .io_core_ports_1_req_valid(memory_io_core_ports_1_req_valid),
    .io_core_ports_1_req_bits_addr(memory_io_core_ports_1_req_bits_addr),
    .io_core_ports_1_req_bits_typ(memory_io_core_ports_1_req_bits_typ),
    .io_core_ports_1_resp_valid(memory_io_core_ports_1_resp_valid),
    .io_core_ports_1_resp_bits_data(memory_io_core_ports_1_resp_bits_data),
    .io_debug_port_req_valid(memory_io_debug_port_req_valid),
    .io_debug_port_req_bits_addr(memory_io_debug_port_req_bits_addr),
    .io_debug_port_req_bits_data(memory_io_debug_port_req_bits_data),
    .io_debug_port_req_bits_fcn(memory_io_debug_port_req_bits_fcn),
    .io_debug_port_req_bits_typ(memory_io_debug_port_req_bits_typ),
    .io_debug_port_resp_valid(memory_io_debug_port_resp_valid),
    .io_debug_port_resp_bits_data(memory_io_debug_port_resp_bits_data)
  );
  SodorRequestRouter_3stage router ( // @[sodor_internal_tile.scala 74:24]
    .io_masterPort_req_ready(router_io_masterPort_req_ready),
    .io_masterPort_req_valid(router_io_masterPort_req_valid),
    .io_masterPort_req_bits_addr(router_io_masterPort_req_bits_addr),
    .io_masterPort_req_bits_data(router_io_masterPort_req_bits_data),
    .io_masterPort_req_bits_fcn(router_io_masterPort_req_bits_fcn),
    .io_masterPort_req_bits_typ(router_io_masterPort_req_bits_typ),
    .io_masterPort_resp_valid(router_io_masterPort_resp_valid),
    .io_masterPort_resp_bits_data(router_io_masterPort_resp_bits_data),
    .io_scratchPort_req_valid(router_io_scratchPort_req_valid),
    .io_scratchPort_req_bits_addr(router_io_scratchPort_req_bits_addr),
    .io_scratchPort_req_bits_data(router_io_scratchPort_req_bits_data),
    .io_scratchPort_req_bits_fcn(router_io_scratchPort_req_bits_fcn),
    .io_scratchPort_req_bits_typ(router_io_scratchPort_req_bits_typ),
    .io_scratchPort_resp_valid(router_io_scratchPort_resp_valid),
    .io_scratchPort_resp_bits_data(router_io_scratchPort_resp_bits_data),
    .io_corePort_req_ready(router_io_corePort_req_ready),
    .io_corePort_req_valid(router_io_corePort_req_valid),
    .io_corePort_req_bits_addr(router_io_corePort_req_bits_addr),
    .io_corePort_req_bits_data(router_io_corePort_req_bits_data),
    .io_corePort_req_bits_fcn(router_io_corePort_req_bits_fcn),
    .io_corePort_req_bits_typ(router_io_corePort_req_bits_typ),
    .io_corePort_resp_valid(router_io_corePort_resp_valid),
    .io_corePort_resp_bits_data(router_io_corePort_resp_bits_data),
    .io_respAddress(router_io_respAddress)
  );
  SodorRequestRouter_3stage router_1 ( // @[sodor_internal_tile.scala 74:24]
    .io_masterPort_req_ready(router_1_io_masterPort_req_ready),
    .io_masterPort_req_valid(router_1_io_masterPort_req_valid),
    .io_masterPort_req_bits_addr(router_1_io_masterPort_req_bits_addr),
    .io_masterPort_req_bits_data(router_1_io_masterPort_req_bits_data),
    .io_masterPort_req_bits_fcn(router_1_io_masterPort_req_bits_fcn),
    .io_masterPort_req_bits_typ(router_1_io_masterPort_req_bits_typ),
    .io_masterPort_resp_valid(router_1_io_masterPort_resp_valid),
    .io_masterPort_resp_bits_data(router_1_io_masterPort_resp_bits_data),
    .io_scratchPort_req_valid(router_1_io_scratchPort_req_valid),
    .io_scratchPort_req_bits_addr(router_1_io_scratchPort_req_bits_addr),
    .io_scratchPort_req_bits_data(router_1_io_scratchPort_req_bits_data),
    .io_scratchPort_req_bits_fcn(router_1_io_scratchPort_req_bits_fcn),
    .io_scratchPort_req_bits_typ(router_1_io_scratchPort_req_bits_typ),
    .io_scratchPort_resp_valid(router_1_io_scratchPort_resp_valid),
    .io_scratchPort_resp_bits_data(router_1_io_scratchPort_resp_bits_data),
    .io_corePort_req_ready(router_1_io_corePort_req_ready),
    .io_corePort_req_valid(router_1_io_corePort_req_valid),
    .io_corePort_req_bits_addr(router_1_io_corePort_req_bits_addr),
    .io_corePort_req_bits_data(router_1_io_corePort_req_bits_data),
    .io_corePort_req_bits_fcn(router_1_io_corePort_req_bits_fcn),
    .io_corePort_req_bits_typ(router_1_io_corePort_req_bits_typ),
    .io_corePort_resp_valid(router_1_io_corePort_resp_valid),
    .io_corePort_resp_bits_data(router_1_io_corePort_resp_bits_data),
    .io_respAddress(router_1_io_respAddress)
  );
  assign io_debug_port_resp_valid = memory_io_debug_port_resp_valid; // @[sodor_internal_tile.scala 109:24]
  assign io_debug_port_resp_bits_data = memory_io_debug_port_resp_bits_data; // @[sodor_internal_tile.scala 109:24]
  assign io_master_port_0_req_valid = router_io_masterPort_req_valid; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_0_req_bits_addr = router_io_masterPort_req_bits_addr; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_0_req_bits_data = router_io_masterPort_req_bits_data; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_0_req_bits_fcn = router_io_masterPort_req_bits_fcn; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_0_req_bits_typ = router_io_masterPort_req_bits_typ; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_1_req_valid = router_1_io_masterPort_req_valid; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_1_req_bits_addr = router_1_io_masterPort_req_bits_addr; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_1_req_bits_data = router_1_io_masterPort_req_bits_data; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_1_req_bits_fcn = router_1_io_masterPort_req_bits_fcn; // @[sodor_internal_tile.scala 70:26 77:26]
  assign io_master_port_1_req_bits_typ = router_1_io_masterPort_req_bits_typ; // @[sodor_internal_tile.scala 70:26 77:26]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_imem_req_ready = router_1_io_corePort_req_ready; // @[sodor_internal_tile.scala 62:24 75:24]
  assign core_io_imem_resp_valid = router_1_io_corePort_resp_valid; // @[sodor_internal_tile.scala 62:24 75:24]
  assign core_io_imem_resp_bits_data = router_1_io_corePort_resp_bits_data; // @[sodor_internal_tile.scala 62:24 75:24]
  assign core_io_dmem_req_ready = router_io_corePort_req_ready; // @[sodor_internal_tile.scala 62:24 75:24]
  assign core_io_dmem_resp_valid = router_io_corePort_resp_valid; // @[sodor_internal_tile.scala 62:24 75:24]
  assign core_io_dmem_resp_bits_data = router_io_corePort_resp_bits_data; // @[sodor_internal_tile.scala 62:24 75:24]
  assign core_io_interrupt_debug = io_interrupt_debug; // @[sodor_internal_tile.scala 111:18]
  assign core_io_interrupt_mtip = io_interrupt_mtip; // @[sodor_internal_tile.scala 111:18]
  assign core_io_interrupt_msip = io_interrupt_msip; // @[sodor_internal_tile.scala 111:18]
  assign core_io_interrupt_meip = io_interrupt_meip; // @[sodor_internal_tile.scala 111:18]
  assign core_io_hartid = io_hartid; // @[sodor_internal_tile.scala 112:15]
  assign core_io_reset_vector = io_reset_vector; // @[sodor_internal_tile.scala 113:21]
  assign memory_clock = clock;
  assign memory_reset = reset;
  assign memory_io_core_ports_0_req_valid = router_io_scratchPort_req_valid; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_core_ports_0_req_bits_addr = router_io_scratchPort_req_bits_addr; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_core_ports_0_req_bits_data = router_io_scratchPort_req_bits_data; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_core_ports_0_req_bits_fcn = router_io_scratchPort_req_bits_fcn; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_core_ports_0_req_bits_typ = router_io_scratchPort_req_bits_typ; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_core_ports_1_req_valid = router_1_io_scratchPort_req_valid; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_core_ports_1_req_bits_addr = router_1_io_scratchPort_req_bits_addr; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_core_ports_1_req_bits_typ = router_1_io_scratchPort_req_bits_typ; // @[sodor_internal_tile.scala 68:23 76:27]
  assign memory_io_debug_port_req_valid = io_debug_port_req_valid; // @[sodor_internal_tile.scala 109:24]
  assign memory_io_debug_port_req_bits_addr = io_debug_port_req_bits_addr; // @[sodor_internal_tile.scala 109:24]
  assign memory_io_debug_port_req_bits_data = io_debug_port_req_bits_data; // @[sodor_internal_tile.scala 109:24]
  assign memory_io_debug_port_req_bits_fcn = io_debug_port_req_bits_fcn; // @[sodor_internal_tile.scala 109:24]
  assign memory_io_debug_port_req_bits_typ = io_debug_port_req_bits_typ; // @[sodor_internal_tile.scala 109:24]
  assign router_io_masterPort_req_ready = io_master_port_0_req_ready; // @[sodor_internal_tile.scala 106:21 70:26]
  assign router_io_masterPort_resp_valid = io_master_port_0_resp_valid; // @[sodor_internal_tile.scala 106:21 70:26]
  assign router_io_masterPort_resp_bits_data = io_master_port_0_resp_bits_data; // @[sodor_internal_tile.scala 106:21 70:26]
  assign router_io_scratchPort_resp_valid = memory_io_core_ports_0_resp_valid; // @[sodor_internal_tile.scala 104:18 68:23]
  assign router_io_scratchPort_resp_bits_data = memory_io_core_ports_0_resp_bits_data; // @[sodor_internal_tile.scala 104:18 68:23]
  assign router_io_corePort_req_valid = core_io_dmem_req_valid; // @[sodor_internal_tile.scala 62:24 64:16]
  assign router_io_corePort_req_bits_addr = core_io_dmem_req_bits_addr; // @[sodor_internal_tile.scala 62:24 64:16]
  assign router_io_corePort_req_bits_data = core_io_dmem_req_bits_data; // @[sodor_internal_tile.scala 62:24 64:16]
  assign router_io_corePort_req_bits_fcn = core_io_dmem_req_bits_fcn; // @[sodor_internal_tile.scala 62:24 64:16]
  assign router_io_corePort_req_bits_typ = core_io_dmem_req_bits_typ; // @[sodor_internal_tile.scala 62:24 64:16]
  assign router_io_respAddress = reg_resp_address; // @[sodor_internal_tile.scala 81:27]
  assign router_1_io_masterPort_req_ready = io_master_port_1_req_ready; // @[sodor_internal_tile.scala 105:21 70:26]
  assign router_1_io_masterPort_resp_valid = io_master_port_1_resp_valid; // @[sodor_internal_tile.scala 105:21 70:26]
  assign router_1_io_masterPort_resp_bits_data = io_master_port_1_resp_bits_data; // @[sodor_internal_tile.scala 105:21 70:26]
  assign router_1_io_scratchPort_resp_valid = memory_io_core_ports_1_resp_valid; // @[sodor_internal_tile.scala 103:18 68:23]
  assign router_1_io_scratchPort_resp_bits_data = memory_io_core_ports_1_resp_bits_data; // @[sodor_internal_tile.scala 103:18 68:23]
  assign router_1_io_corePort_req_valid = core_io_imem_req_valid; // @[sodor_internal_tile.scala 62:24 63:16]
  assign router_1_io_corePort_req_bits_addr = core_io_imem_req_bits_addr; // @[sodor_internal_tile.scala 62:24 63:16]
  assign router_1_io_corePort_req_bits_data = 32'h0; // @[sodor_internal_tile.scala 62:24 63:16]
  assign router_1_io_corePort_req_bits_fcn = 1'h0; // @[sodor_internal_tile.scala 62:24 63:16]
  assign router_1_io_corePort_req_bits_typ = 3'h7; // @[sodor_internal_tile.scala 62:24 63:16]
  assign router_1_io_respAddress = reg_resp_address_1; // @[sodor_internal_tile.scala 81:27]
  always @(posedge clock) begin
    if (_T) begin // @[sodor_internal_tile.scala 80:31]
      reg_resp_address <= core_ports_0_req_bits_addr; // @[sodor_internal_tile.scala 80:50]
    end
    if (_T_1) begin // @[sodor_internal_tile.scala 80:31]
      reg_resp_address_1 <= core_ports_1_req_bits_addr; // @[sodor_internal_tile.scala 80:50]
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
  reg_resp_address = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_resp_address_1 = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule