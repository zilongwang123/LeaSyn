module SodorInternalTile_1stage(
  input         clock,
  input         reset,
  input         io_debug_port_req_valid,
  input  [31:0] io_debug_port_req_bits_addr,
  input  [31:0] io_debug_port_req_bits_data,
  input         io_debug_port_req_bits_fcn,
  input  [2:0]  io_debug_port_req_bits_typ,
  output        io_debug_port_resp_valid,
  output [31:0] io_debug_port_resp_bits_data,
  input         io_interrupt_debug,
  input  [31:0] io_reset_vector
);
  wire  core_clock; // @[sodor_internal_tile.scala 120:22]
  wire  core_reset; // @[sodor_internal_tile.scala 120:22]
  wire  core_io_interrupt_debug; // @[sodor_internal_tile.scala 120:22]
  wire [31:0] core_io_reset_vector; // @[sodor_internal_tile.scala 120:22]
  wire  memory_clock; // @[sodor_internal_tile.scala 122:22]
  wire  memory_io_debug_port_req_valid; // @[sodor_internal_tile.scala 122:22]
  wire [31:0] memory_io_debug_port_req_bits_addr; // @[sodor_internal_tile.scala 122:22]
  wire [31:0] memory_io_debug_port_req_bits_data; // @[sodor_internal_tile.scala 122:22]
  wire  memory_io_debug_port_req_bits_fcn; // @[sodor_internal_tile.scala 122:22]
  wire [2:0] memory_io_debug_port_req_bits_typ; // @[sodor_internal_tile.scala 122:22]
  wire  memory_io_debug_port_resp_valid; // @[sodor_internal_tile.scala 122:22]
  wire [31:0] memory_io_debug_port_resp_bits_data; // @[sodor_internal_tile.scala 122:22]
  Core_1stage Core_1stage ( // @[sodor_internal_tile.scala 120:22]
    .clock(core_clock),
    .reset(core_reset),
    .io_interrupt_debug(core_io_interrupt_debug),
    .io_reset_vector(core_io_reset_vector)
  );
  AsyncScratchPadMemory_1stage AsyncScratchPadMemory_1stage ( // @[sodor_internal_tile.scala 122:22]
    .clock(memory_clock),
    .io_debug_port_req_valid(memory_io_debug_port_req_valid),
    .io_debug_port_req_bits_addr(memory_io_debug_port_req_bits_addr),
    .io_debug_port_req_bits_data(memory_io_debug_port_req_bits_data),
    .io_debug_port_req_bits_fcn(memory_io_debug_port_req_bits_fcn),
    .io_debug_port_req_bits_typ(memory_io_debug_port_req_bits_typ),
    .io_debug_port_resp_valid(memory_io_debug_port_resp_valid),
    .io_debug_port_resp_bits_data(memory_io_debug_port_resp_bits_data)
  );
  assign io_debug_port_resp_valid = memory_io_debug_port_resp_valid; // @[sodor_internal_tile.scala 134:17]
  assign io_debug_port_resp_bits_data = memory_io_debug_port_resp_bits_data; // @[sodor_internal_tile.scala 134:17]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_interrupt_debug = io_interrupt_debug; // @[sodor_internal_tile.scala 136:18]
  assign core_io_reset_vector = io_reset_vector; // @[sodor_internal_tile.scala 138:21]
  assign memory_clock = clock;
  assign memory_io_debug_port_req_valid = io_debug_port_req_valid; // @[sodor_internal_tile.scala 134:17]
  assign memory_io_debug_port_req_bits_addr = io_debug_port_req_bits_addr; // @[sodor_internal_tile.scala 134:17]
  assign memory_io_debug_port_req_bits_data = io_debug_port_req_bits_data; // @[sodor_internal_tile.scala 134:17]
  assign memory_io_debug_port_req_bits_fcn = io_debug_port_req_bits_fcn; // @[sodor_internal_tile.scala 134:17]
  assign memory_io_debug_port_req_bits_typ = io_debug_port_req_bits_typ; // @[sodor_internal_tile.scala 134:17]
endmodule