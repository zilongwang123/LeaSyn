module SyncScratchPadMemory_3stage(
  input         clock,
  input         reset,
  input         io_core_ports_0_req_valid,
  input  [31:0] io_core_ports_0_req_bits_addr,
  input  [31:0] io_core_ports_0_req_bits_data,
  input         io_core_ports_0_req_bits_fcn,
  input  [2:0]  io_core_ports_0_req_bits_typ,
  output        io_core_ports_0_resp_valid,
  output [31:0] io_core_ports_0_resp_bits_data,
  input         io_core_ports_1_req_valid,
  input  [31:0] io_core_ports_1_req_bits_addr,
  input  [2:0]  io_core_ports_1_req_bits_typ,
  output        io_core_ports_1_resp_valid,
  output [31:0] io_core_ports_1_resp_bits_data,
  input         io_debug_port_req_valid,
  input  [31:0] io_debug_port_req_bits_addr,
  input  [31:0] io_debug_port_req_bits_data,
  input         io_debug_port_req_bits_fcn,
  input  [2:0]  io_debug_port_req_bits_typ,
  output        io_debug_port_resp_valid,
  output [31:0] io_debug_port_resp_bits_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_21;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:524287]; // @[memory.scala 73:81]
  wire  mem_0_io_core_ports_0_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_0_io_core_ports_0_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_0_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_0_io_core_ports_1_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_0_io_core_ports_1_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_0_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_0_io_debug_port_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_0_io_debug_port_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_0_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire [7:0] mem_0_MPORT_data; // @[memory.scala 73:81]
  wire [18:0] mem_0_MPORT_addr; // @[memory.scala 73:81]
  wire  mem_0_MPORT_mask; // @[memory.scala 73:81]
  wire  mem_0_MPORT_en; // @[memory.scala 73:81]
  wire [7:0] mem_0_MPORT_1_data; // @[memory.scala 73:81]
  wire [18:0] mem_0_MPORT_1_addr; // @[memory.scala 73:81]
  wire  mem_0_MPORT_1_mask; // @[memory.scala 73:81]
  wire  mem_0_MPORT_1_en; // @[memory.scala 73:81]
  reg  mem_0_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_0_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_0_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_0_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_0_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_0_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  reg [7:0] mem_1 [0:524287]; // @[memory.scala 73:81]
  wire  mem_1_io_core_ports_0_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_1_io_core_ports_0_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_1_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_1_io_core_ports_1_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_1_io_core_ports_1_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_1_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_1_io_debug_port_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_1_io_debug_port_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_1_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire [7:0] mem_1_MPORT_data; // @[memory.scala 73:81]
  wire [18:0] mem_1_MPORT_addr; // @[memory.scala 73:81]
  wire  mem_1_MPORT_mask; // @[memory.scala 73:81]
  wire  mem_1_MPORT_en; // @[memory.scala 73:81]
  wire [7:0] mem_1_MPORT_1_data; // @[memory.scala 73:81]
  wire [18:0] mem_1_MPORT_1_addr; // @[memory.scala 73:81]
  wire  mem_1_MPORT_1_mask; // @[memory.scala 73:81]
  wire  mem_1_MPORT_1_en; // @[memory.scala 73:81]
  reg  mem_1_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_1_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_1_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_1_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_1_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_1_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  reg [7:0] mem_2 [0:524287]; // @[memory.scala 73:81]
  wire  mem_2_io_core_ports_0_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_2_io_core_ports_0_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_2_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_2_io_core_ports_1_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_2_io_core_ports_1_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_2_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_2_io_debug_port_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_2_io_debug_port_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_2_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire [7:0] mem_2_MPORT_data; // @[memory.scala 73:81]
  wire [18:0] mem_2_MPORT_addr; // @[memory.scala 73:81]
  wire  mem_2_MPORT_mask; // @[memory.scala 73:81]
  wire  mem_2_MPORT_en; // @[memory.scala 73:81]
  wire [7:0] mem_2_MPORT_1_data; // @[memory.scala 73:81]
  wire [18:0] mem_2_MPORT_1_addr; // @[memory.scala 73:81]
  wire  mem_2_MPORT_1_mask; // @[memory.scala 73:81]
  wire  mem_2_MPORT_1_en; // @[memory.scala 73:81]
  reg  mem_2_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_2_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_2_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_2_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_2_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_2_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  reg [7:0] mem_3 [0:524287]; // @[memory.scala 73:81]
  wire  mem_3_io_core_ports_0_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_3_io_core_ports_0_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_3_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_3_io_core_ports_1_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_3_io_core_ports_1_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_3_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire  mem_3_io_debug_port_resp_bits_data_MPORT_en; // @[memory.scala 73:81]
  wire [18:0] mem_3_io_debug_port_resp_bits_data_MPORT_addr; // @[memory.scala 73:81]
  wire [7:0] mem_3_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 73:81]
  wire [7:0] mem_3_MPORT_data; // @[memory.scala 73:81]
  wire [18:0] mem_3_MPORT_addr; // @[memory.scala 73:81]
  wire  mem_3_MPORT_mask; // @[memory.scala 73:81]
  wire  mem_3_MPORT_en; // @[memory.scala 73:81]
  wire [7:0] mem_3_MPORT_1_data; // @[memory.scala 73:81]
  wire [18:0] mem_3_MPORT_1_addr; // @[memory.scala 73:81]
  wire  mem_3_MPORT_1_mask; // @[memory.scala 73:81]
  wire  mem_3_MPORT_1_en; // @[memory.scala 73:81]
  reg  mem_3_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_3_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_3_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_3_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  reg  mem_3_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  reg [18:0] mem_3_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  wire  io_core_ports_0_resp_bits_data_module_clock; // @[memory.scala 120:26]
  wire [20:0] io_core_ports_0_resp_bits_data_module_io_addr; // @[memory.scala 120:26]
  wire [1:0] io_core_ports_0_resp_bits_data_module_io_size; // @[memory.scala 120:26]
  wire  io_core_ports_0_resp_bits_data_module_io_signed; // @[memory.scala 120:26]
  wire [31:0] io_core_ports_0_resp_bits_data_module_io_data; // @[memory.scala 120:26]
  wire [18:0] io_core_ports_0_resp_bits_data_module_io_mem_addr; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_0_resp_bits_data_module_io_mem_data_0; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_0_resp_bits_data_module_io_mem_data_1; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_0_resp_bits_data_module_io_mem_data_2; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_0_resp_bits_data_module_io_mem_data_3; // @[memory.scala 120:26]
  wire [20:0] module__io_addr; // @[memory.scala 156:26]
  wire [31:0] module__io_data; // @[memory.scala 156:26]
  wire [1:0] module__io_size; // @[memory.scala 156:26]
  wire  module__io_en; // @[memory.scala 156:26]
  wire [18:0] module__io_mem_addr; // @[memory.scala 156:26]
  wire [7:0] module__io_mem_data_0; // @[memory.scala 156:26]
  wire [7:0] module__io_mem_data_1; // @[memory.scala 156:26]
  wire [7:0] module__io_mem_data_2; // @[memory.scala 156:26]
  wire [7:0] module__io_mem_data_3; // @[memory.scala 156:26]
  wire  module__io_mem_masks_0; // @[memory.scala 156:26]
  wire  module__io_mem_masks_1; // @[memory.scala 156:26]
  wire  module__io_mem_masks_2; // @[memory.scala 156:26]
  wire  module__io_mem_masks_3; // @[memory.scala 156:26]
  wire  io_core_ports_1_resp_bits_data_module_clock; // @[memory.scala 120:26]
  wire [20:0] io_core_ports_1_resp_bits_data_module_io_addr; // @[memory.scala 120:26]
  wire [1:0] io_core_ports_1_resp_bits_data_module_io_size; // @[memory.scala 120:26]
  wire  io_core_ports_1_resp_bits_data_module_io_signed; // @[memory.scala 120:26]
  wire [31:0] io_core_ports_1_resp_bits_data_module_io_data; // @[memory.scala 120:26]
  wire [18:0] io_core_ports_1_resp_bits_data_module_io_mem_addr; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_1_resp_bits_data_module_io_mem_data_0; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_1_resp_bits_data_module_io_mem_data_1; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_1_resp_bits_data_module_io_mem_data_2; // @[memory.scala 120:26]
  wire [7:0] io_core_ports_1_resp_bits_data_module_io_mem_data_3; // @[memory.scala 120:26]
  wire  io_debug_port_resp_bits_data_module_clock; // @[memory.scala 120:26]
  wire [20:0] io_debug_port_resp_bits_data_module_io_addr; // @[memory.scala 120:26]
  wire [1:0] io_debug_port_resp_bits_data_module_io_size; // @[memory.scala 120:26]
  wire  io_debug_port_resp_bits_data_module_io_signed; // @[memory.scala 120:26]
  wire [31:0] io_debug_port_resp_bits_data_module_io_data; // @[memory.scala 120:26]
  wire [18:0] io_debug_port_resp_bits_data_module_io_mem_addr; // @[memory.scala 120:26]
  wire [7:0] io_debug_port_resp_bits_data_module_io_mem_data_0; // @[memory.scala 120:26]
  wire [7:0] io_debug_port_resp_bits_data_module_io_mem_data_1; // @[memory.scala 120:26]
  wire [7:0] io_debug_port_resp_bits_data_module_io_mem_data_2; // @[memory.scala 120:26]
  wire [7:0] io_debug_port_resp_bits_data_module_io_mem_data_3; // @[memory.scala 120:26]
  wire [20:0] module_1_io_addr; // @[memory.scala 156:26]
  wire [31:0] module_1_io_data; // @[memory.scala 156:26]
  wire [1:0] module_1_io_size; // @[memory.scala 156:26]
  wire  module_1_io_en; // @[memory.scala 156:26]
  wire [18:0] module_1_io_mem_addr; // @[memory.scala 156:26]
  wire [7:0] module_1_io_mem_data_0; // @[memory.scala 156:26]
  wire [7:0] module_1_io_mem_data_1; // @[memory.scala 156:26]
  wire [7:0] module_1_io_mem_data_2; // @[memory.scala 156:26]
  wire [7:0] module_1_io_mem_data_3; // @[memory.scala 156:26]
  wire  module_1_io_mem_masks_0; // @[memory.scala 156:26]
  wire  module_1_io_mem_masks_1; // @[memory.scala 156:26]
  wire  module_1_io_mem_masks_2; // @[memory.scala 156:26]
  wire  module_1_io_mem_masks_3; // @[memory.scala 156:26]
  reg  io_core_ports_0_resp_valid_REG; // @[memory.scala 185:92]
  reg  io_core_ports_1_resp_valid_REG; // @[memory.scala 185:92]
  wire [2:0] _io_core_ports_0_resp_bits_data_T_1 = io_core_ports_0_req_bits_typ - 3'h1; // @[memory.scala 60:24]
  wire [2:0] _io_core_ports_1_resp_bits_data_T_1 = io_core_ports_1_req_bits_typ - 3'h1; // @[memory.scala 60:24]
  reg  io_debug_port_resp_valid_REG; // @[memory.scala 207:83]
  wire [2:0] _io_debug_port_resp_bits_data_T_1 = io_debug_port_req_bits_typ - 3'h1; // @[memory.scala 60:24]
  MemReader_3stage io_core_ports_0_resp_bits_data_module ( // @[memory.scala 120:26]
    .clock(io_core_ports_0_resp_bits_data_module_clock),
    .io_addr(io_core_ports_0_resp_bits_data_module_io_addr),
    .io_size(io_core_ports_0_resp_bits_data_module_io_size),
    .io_signed(io_core_ports_0_resp_bits_data_module_io_signed),
    .io_data(io_core_ports_0_resp_bits_data_module_io_data),
    .io_mem_addr(io_core_ports_0_resp_bits_data_module_io_mem_addr),
    .io_mem_data_0(io_core_ports_0_resp_bits_data_module_io_mem_data_0),
    .io_mem_data_1(io_core_ports_0_resp_bits_data_module_io_mem_data_1),
    .io_mem_data_2(io_core_ports_0_resp_bits_data_module_io_mem_data_2),
    .io_mem_data_3(io_core_ports_0_resp_bits_data_module_io_mem_data_3)
  );
  MemWriter_3stage module_ ( // @[memory.scala 156:26]
    .io_addr(module__io_addr),
    .io_data(module__io_data),
    .io_size(module__io_size),
    .io_en(module__io_en),
    .io_mem_addr(module__io_mem_addr),
    .io_mem_data_0(module__io_mem_data_0),
    .io_mem_data_1(module__io_mem_data_1),
    .io_mem_data_2(module__io_mem_data_2),
    .io_mem_data_3(module__io_mem_data_3),
    .io_mem_masks_0(module__io_mem_masks_0),
    .io_mem_masks_1(module__io_mem_masks_1),
    .io_mem_masks_2(module__io_mem_masks_2),
    .io_mem_masks_3(module__io_mem_masks_3)
  );
  MemReader_3stage io_core_ports_1_resp_bits_data_module ( // @[memory.scala 120:26]
    .clock(io_core_ports_1_resp_bits_data_module_clock),
    .io_addr(io_core_ports_1_resp_bits_data_module_io_addr),
    .io_size(io_core_ports_1_resp_bits_data_module_io_size),
    .io_signed(io_core_ports_1_resp_bits_data_module_io_signed),
    .io_data(io_core_ports_1_resp_bits_data_module_io_data),
    .io_mem_addr(io_core_ports_1_resp_bits_data_module_io_mem_addr),
    .io_mem_data_0(io_core_ports_1_resp_bits_data_module_io_mem_data_0),
    .io_mem_data_1(io_core_ports_1_resp_bits_data_module_io_mem_data_1),
    .io_mem_data_2(io_core_ports_1_resp_bits_data_module_io_mem_data_2),
    .io_mem_data_3(io_core_ports_1_resp_bits_data_module_io_mem_data_3)
  );
  MemReader_3stage io_debug_port_resp_bits_data_module ( // @[memory.scala 120:26]
    .clock(io_debug_port_resp_bits_data_module_clock),
    .io_addr(io_debug_port_resp_bits_data_module_io_addr),
    .io_size(io_debug_port_resp_bits_data_module_io_size),
    .io_signed(io_debug_port_resp_bits_data_module_io_signed),
    .io_data(io_debug_port_resp_bits_data_module_io_data),
    .io_mem_addr(io_debug_port_resp_bits_data_module_io_mem_addr),
    .io_mem_data_0(io_debug_port_resp_bits_data_module_io_mem_data_0),
    .io_mem_data_1(io_debug_port_resp_bits_data_module_io_mem_data_1),
    .io_mem_data_2(io_debug_port_resp_bits_data_module_io_mem_data_2),
    .io_mem_data_3(io_debug_port_resp_bits_data_module_io_mem_data_3)
  );
  MemWriter_3stage module_1 ( // @[memory.scala 156:26]
    .io_addr(module_1_io_addr),
    .io_data(module_1_io_data),
    .io_size(module_1_io_size),
    .io_en(module_1_io_en),
    .io_mem_addr(module_1_io_mem_addr),
    .io_mem_data_0(module_1_io_mem_data_0),
    .io_mem_data_1(module_1_io_mem_data_1),
    .io_mem_data_2(module_1_io_mem_data_2),
    .io_mem_data_3(module_1_io_mem_data_3),
    .io_mem_masks_0(module_1_io_mem_masks_0),
    .io_mem_masks_1(module_1_io_mem_masks_1),
    .io_mem_masks_2(module_1_io_mem_masks_2),
    .io_mem_masks_3(module_1_io_mem_masks_3)
  );
  assign mem_0_io_core_ports_0_resp_bits_data_MPORT_en = mem_0_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  assign mem_0_io_core_ports_0_resp_bits_data_MPORT_addr = mem_0_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_0_io_core_ports_0_resp_bits_data_MPORT_data = mem_0[mem_0_io_core_ports_0_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_0_io_core_ports_1_resp_bits_data_MPORT_en = mem_0_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  assign mem_0_io_core_ports_1_resp_bits_data_MPORT_addr = mem_0_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_0_io_core_ports_1_resp_bits_data_MPORT_data = mem_0[mem_0_io_core_ports_1_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_0_io_debug_port_resp_bits_data_MPORT_en = mem_0_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  assign mem_0_io_debug_port_resp_bits_data_MPORT_addr = mem_0_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_0_io_debug_port_resp_bits_data_MPORT_data = mem_0[mem_0_io_debug_port_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_0_MPORT_data = module__io_mem_data_0;
  assign mem_0_MPORT_addr = module__io_mem_addr;
  assign mem_0_MPORT_mask = module__io_mem_masks_0;
  assign mem_0_MPORT_en = io_core_ports_0_req_valid & io_core_ports_0_req_bits_fcn;
  assign mem_0_MPORT_1_data = module_1_io_mem_data_0;
  assign mem_0_MPORT_1_addr = module_1_io_mem_addr;
  assign mem_0_MPORT_1_mask = module_1_io_mem_masks_0;
  assign mem_0_MPORT_1_en = io_debug_port_req_valid & io_debug_port_req_bits_fcn;
  assign mem_1_io_core_ports_0_resp_bits_data_MPORT_en = mem_1_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  assign mem_1_io_core_ports_0_resp_bits_data_MPORT_addr = mem_1_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_1_io_core_ports_0_resp_bits_data_MPORT_data = mem_1[mem_1_io_core_ports_0_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_1_io_core_ports_1_resp_bits_data_MPORT_en = mem_1_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  assign mem_1_io_core_ports_1_resp_bits_data_MPORT_addr = mem_1_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_1_io_core_ports_1_resp_bits_data_MPORT_data = mem_1[mem_1_io_core_ports_1_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_1_io_debug_port_resp_bits_data_MPORT_en = mem_1_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  assign mem_1_io_debug_port_resp_bits_data_MPORT_addr = mem_1_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_1_io_debug_port_resp_bits_data_MPORT_data = mem_1[mem_1_io_debug_port_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_1_MPORT_data = module__io_mem_data_1;
  assign mem_1_MPORT_addr = module__io_mem_addr;
  assign mem_1_MPORT_mask = module__io_mem_masks_1;
  assign mem_1_MPORT_en = io_core_ports_0_req_valid & io_core_ports_0_req_bits_fcn;
  assign mem_1_MPORT_1_data = module_1_io_mem_data_1;
  assign mem_1_MPORT_1_addr = module_1_io_mem_addr;
  assign mem_1_MPORT_1_mask = module_1_io_mem_masks_1;
  assign mem_1_MPORT_1_en = io_debug_port_req_valid & io_debug_port_req_bits_fcn;
  assign mem_2_io_core_ports_0_resp_bits_data_MPORT_en = mem_2_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  assign mem_2_io_core_ports_0_resp_bits_data_MPORT_addr = mem_2_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_2_io_core_ports_0_resp_bits_data_MPORT_data = mem_2[mem_2_io_core_ports_0_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_2_io_core_ports_1_resp_bits_data_MPORT_en = mem_2_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  assign mem_2_io_core_ports_1_resp_bits_data_MPORT_addr = mem_2_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_2_io_core_ports_1_resp_bits_data_MPORT_data = mem_2[mem_2_io_core_ports_1_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_2_io_debug_port_resp_bits_data_MPORT_en = mem_2_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  assign mem_2_io_debug_port_resp_bits_data_MPORT_addr = mem_2_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_2_io_debug_port_resp_bits_data_MPORT_data = mem_2[mem_2_io_debug_port_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_2_MPORT_data = module__io_mem_data_2;
  assign mem_2_MPORT_addr = module__io_mem_addr;
  assign mem_2_MPORT_mask = module__io_mem_masks_2;
  assign mem_2_MPORT_en = io_core_ports_0_req_valid & io_core_ports_0_req_bits_fcn;
  assign mem_2_MPORT_1_data = module_1_io_mem_data_2;
  assign mem_2_MPORT_1_addr = module_1_io_mem_addr;
  assign mem_2_MPORT_1_mask = module_1_io_mem_masks_2;
  assign mem_2_MPORT_1_en = io_debug_port_req_valid & io_debug_port_req_bits_fcn;
  assign mem_3_io_core_ports_0_resp_bits_data_MPORT_en = mem_3_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0;
  assign mem_3_io_core_ports_0_resp_bits_data_MPORT_addr = mem_3_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_3_io_core_ports_0_resp_bits_data_MPORT_data = mem_3[mem_3_io_core_ports_0_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_3_io_core_ports_1_resp_bits_data_MPORT_en = mem_3_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0;
  assign mem_3_io_core_ports_1_resp_bits_data_MPORT_addr = mem_3_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_3_io_core_ports_1_resp_bits_data_MPORT_data = mem_3[mem_3_io_core_ports_1_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_3_io_debug_port_resp_bits_data_MPORT_en = mem_3_io_debug_port_resp_bits_data_MPORT_en_pipe_0;
  assign mem_3_io_debug_port_resp_bits_data_MPORT_addr = mem_3_io_debug_port_resp_bits_data_MPORT_addr_pipe_0;
  assign mem_3_io_debug_port_resp_bits_data_MPORT_data = mem_3[mem_3_io_debug_port_resp_bits_data_MPORT_addr]; // @[memory.scala 73:81]
  assign mem_3_MPORT_data = module__io_mem_data_3;
  assign mem_3_MPORT_addr = module__io_mem_addr;
  assign mem_3_MPORT_mask = module__io_mem_masks_3;
  assign mem_3_MPORT_en = io_core_ports_0_req_valid & io_core_ports_0_req_bits_fcn;
  assign mem_3_MPORT_1_data = module_1_io_mem_data_3;
  assign mem_3_MPORT_1_addr = module_1_io_mem_addr;
  assign mem_3_MPORT_1_mask = module_1_io_mem_masks_3;
  assign mem_3_MPORT_1_en = io_debug_port_req_valid & io_debug_port_req_bits_fcn;
  assign io_core_ports_0_resp_valid = io_core_ports_0_resp_valid_REG; // @[memory.scala 185:35]
  assign io_core_ports_0_resp_bits_data = io_core_ports_0_resp_bits_data_module_io_data; // @[memory.scala 194:40]
  assign io_core_ports_1_resp_valid = io_core_ports_1_resp_valid_REG; // @[memory.scala 185:35]
  assign io_core_ports_1_resp_bits_data = io_core_ports_1_resp_bits_data_module_io_data; // @[memory.scala 201:43]
  assign io_debug_port_resp_valid = io_debug_port_resp_valid_REG; // @[memory.scala 207:29]
  assign io_debug_port_resp_bits_data = io_debug_port_resp_bits_data_module_io_data; // @[memory.scala 211:33]
  assign io_core_ports_0_resp_bits_data_module_clock = clock;
  assign io_core_ports_0_resp_bits_data_module_io_addr = io_core_ports_0_req_bits_addr[20:0]; // @[memory.scala 121:22]
  assign io_core_ports_0_resp_bits_data_module_io_size = _io_core_ports_0_resp_bits_data_T_1[1:0]; // @[memory.scala 60:30]
  assign io_core_ports_0_resp_bits_data_module_io_signed = ~_io_core_ports_0_resp_bits_data_T_1[2]; // @[memory.scala 61:21]
  assign io_core_ports_0_resp_bits_data_module_io_mem_data_0 = mem_0_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_core_ports_0_resp_bits_data_module_io_mem_data_1 = mem_1_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_core_ports_0_resp_bits_data_module_io_mem_data_2 = mem_2_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_core_ports_0_resp_bits_data_module_io_mem_data_3 = mem_3_io_core_ports_0_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign module__io_addr = io_core_ports_0_req_bits_addr[20:0]; // @[memory.scala 157:22]
  assign module__io_data = io_core_ports_0_req_bits_data; // @[memory.scala 158:22]
  assign module__io_size = _io_core_ports_0_resp_bits_data_T_1[1:0]; // @[memory.scala 60:30]
  assign module__io_en = io_core_ports_0_req_valid & io_core_ports_0_req_bits_fcn; // @[memory.scala 193:51]
  assign io_core_ports_1_resp_bits_data_module_clock = clock;
  assign io_core_ports_1_resp_bits_data_module_io_addr = io_core_ports_1_req_bits_addr[20:0]; // @[memory.scala 121:22]
  assign io_core_ports_1_resp_bits_data_module_io_size = _io_core_ports_1_resp_bits_data_T_1[1:0]; // @[memory.scala 60:30]
  assign io_core_ports_1_resp_bits_data_module_io_signed = ~_io_core_ports_1_resp_bits_data_T_1[2]; // @[memory.scala 61:21]
  assign io_core_ports_1_resp_bits_data_module_io_mem_data_0 = mem_0_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_core_ports_1_resp_bits_data_module_io_mem_data_1 = mem_1_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_core_ports_1_resp_bits_data_module_io_mem_data_2 = mem_2_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_core_ports_1_resp_bits_data_module_io_mem_data_3 = mem_3_io_core_ports_1_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_debug_port_resp_bits_data_module_clock = clock;
  assign io_debug_port_resp_bits_data_module_io_addr = io_debug_port_req_bits_addr[20:0]; // @[memory.scala 121:22]
  assign io_debug_port_resp_bits_data_module_io_size = _io_debug_port_resp_bits_data_T_1[1:0]; // @[memory.scala 60:30]
  assign io_debug_port_resp_bits_data_module_io_signed = ~_io_debug_port_resp_bits_data_T_1[2]; // @[memory.scala 61:21]
  assign io_debug_port_resp_bits_data_module_io_mem_data_0 = mem_0_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_debug_port_resp_bits_data_module_io_mem_data_1 = mem_1_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_debug_port_resp_bits_data_module_io_mem_data_2 = mem_2_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign io_debug_port_resp_bits_data_module_io_mem_data_3 = mem_3_io_debug_port_resp_bits_data_MPORT_data; // @[memory.scala 124:26]
  assign module_1_io_addr = io_debug_port_req_bits_addr[20:0]; // @[memory.scala 157:22]
  assign module_1_io_data = io_debug_port_req_bits_data; // @[memory.scala 158:22]
  assign module_1_io_size = _io_debug_port_resp_bits_data_T_1[1:0]; // @[memory.scala 60:30]
  assign module_1_io_en = io_debug_port_req_valid & io_debug_port_req_bits_fcn; // @[memory.scala 210:49]
  always @(posedge clock) begin
    if (mem_0_MPORT_en & mem_0_MPORT_mask) begin
      mem_0[mem_0_MPORT_addr] <= mem_0_MPORT_data; // @[memory.scala 73:81]
    end
    if (mem_0_MPORT_1_en & mem_0_MPORT_1_mask) begin
      mem_0[mem_0_MPORT_1_addr] <= mem_0_MPORT_1_data; // @[memory.scala 73:81]
    end
    mem_0_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_0_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_0_resp_bits_data_module_io_mem_addr;
    end
    mem_0_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_0_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_1_resp_bits_data_module_io_mem_addr;
    end
    mem_0_io_debug_port_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_0_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 <= io_debug_port_resp_bits_data_module_io_mem_addr;
    end
    if (mem_1_MPORT_en & mem_1_MPORT_mask) begin
      mem_1[mem_1_MPORT_addr] <= mem_1_MPORT_data; // @[memory.scala 73:81]
    end
    if (mem_1_MPORT_1_en & mem_1_MPORT_1_mask) begin
      mem_1[mem_1_MPORT_1_addr] <= mem_1_MPORT_1_data; // @[memory.scala 73:81]
    end
    mem_1_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_1_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_0_resp_bits_data_module_io_mem_addr;
    end
    mem_1_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_1_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_1_resp_bits_data_module_io_mem_addr;
    end
    mem_1_io_debug_port_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_1_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 <= io_debug_port_resp_bits_data_module_io_mem_addr;
    end
    if (mem_2_MPORT_en & mem_2_MPORT_mask) begin
      mem_2[mem_2_MPORT_addr] <= mem_2_MPORT_data; // @[memory.scala 73:81]
    end
    if (mem_2_MPORT_1_en & mem_2_MPORT_1_mask) begin
      mem_2[mem_2_MPORT_1_addr] <= mem_2_MPORT_1_data; // @[memory.scala 73:81]
    end
    mem_2_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_2_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_0_resp_bits_data_module_io_mem_addr;
    end
    mem_2_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_2_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_1_resp_bits_data_module_io_mem_addr;
    end
    mem_2_io_debug_port_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_2_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 <= io_debug_port_resp_bits_data_module_io_mem_addr;
    end
    if (mem_3_MPORT_en & mem_3_MPORT_mask) begin
      mem_3[mem_3_MPORT_addr] <= mem_3_MPORT_data; // @[memory.scala 73:81]
    end
    if (mem_3_MPORT_1_en & mem_3_MPORT_1_mask) begin
      mem_3[mem_3_MPORT_1_addr] <= mem_3_MPORT_1_data; // @[memory.scala 73:81]
    end
    mem_3_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_3_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_0_resp_bits_data_module_io_mem_addr;
    end
    mem_3_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_3_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 <= io_core_ports_1_resp_bits_data_module_io_mem_addr;
    end
    mem_3_io_debug_port_resp_bits_data_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_3_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 <= io_debug_port_resp_bits_data_module_io_mem_addr;
    end
    if (reset) begin // @[memory.scala 185:92]
      io_core_ports_0_resp_valid_REG <= 1'h0; // @[memory.scala 185:92]
    end else begin
      io_core_ports_0_resp_valid_REG <= io_core_ports_0_req_valid; // @[memory.scala 185:92]
    end
    if (reset) begin // @[memory.scala 185:92]
      io_core_ports_1_resp_valid_REG <= 1'h0; // @[memory.scala 185:92]
    end else begin
      io_core_ports_1_resp_valid_REG <= io_core_ports_1_req_valid; // @[memory.scala 185:92]
    end
    if (reset) begin // @[memory.scala 207:83]
      io_debug_port_resp_valid_REG <= 1'h0; // @[memory.scala 207:83]
    end else begin
      io_debug_port_resp_valid_REG <= io_debug_port_req_valid; // @[memory.scala 207:83]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 524288; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 524288; initvar = initvar+1)
    mem_1[initvar] = _RAND_7[7:0];
  _RAND_14 = {1{`RANDOM}};
  for (initvar = 0; initvar < 524288; initvar = initvar+1)
    mem_2[initvar] = _RAND_14[7:0];
  _RAND_21 = {1{`RANDOM}};
  for (initvar = 0; initvar < 524288; initvar = initvar+1)
    mem_3[initvar] = _RAND_21[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_0_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 = _RAND_2[18:0];
  _RAND_3 = {1{`RANDOM}};
  mem_0_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_0_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 = _RAND_4[18:0];
  _RAND_5 = {1{`RANDOM}};
  mem_0_io_debug_port_resp_bits_data_MPORT_en_pipe_0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  mem_0_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 = _RAND_6[18:0];
  _RAND_8 = {1{`RANDOM}};
  mem_1_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  mem_1_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 = _RAND_9[18:0];
  _RAND_10 = {1{`RANDOM}};
  mem_1_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_1_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 = _RAND_11[18:0];
  _RAND_12 = {1{`RANDOM}};
  mem_1_io_debug_port_resp_bits_data_MPORT_en_pipe_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mem_1_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 = _RAND_13[18:0];
  _RAND_15 = {1{`RANDOM}};
  mem_2_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  mem_2_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 = _RAND_16[18:0];
  _RAND_17 = {1{`RANDOM}};
  mem_2_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  mem_2_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 = _RAND_18[18:0];
  _RAND_19 = {1{`RANDOM}};
  mem_2_io_debug_port_resp_bits_data_MPORT_en_pipe_0 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  mem_2_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 = _RAND_20[18:0];
  _RAND_22 = {1{`RANDOM}};
  mem_3_io_core_ports_0_resp_bits_data_MPORT_en_pipe_0 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  mem_3_io_core_ports_0_resp_bits_data_MPORT_addr_pipe_0 = _RAND_23[18:0];
  _RAND_24 = {1{`RANDOM}};
  mem_3_io_core_ports_1_resp_bits_data_MPORT_en_pipe_0 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  mem_3_io_core_ports_1_resp_bits_data_MPORT_addr_pipe_0 = _RAND_25[18:0];
  _RAND_26 = {1{`RANDOM}};
  mem_3_io_debug_port_resp_bits_data_MPORT_en_pipe_0 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  mem_3_io_debug_port_resp_bits_data_MPORT_addr_pipe_0 = _RAND_27[18:0];
  _RAND_28 = {1{`RANDOM}};
  io_core_ports_0_resp_valid_REG = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  io_core_ports_1_resp_valid_REG = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  io_debug_port_resp_valid_REG = _RAND_30[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule