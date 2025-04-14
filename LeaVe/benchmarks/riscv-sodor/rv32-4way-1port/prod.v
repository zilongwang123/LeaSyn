module prod
(
  input clock
);

  wire         reset;   

  wire         srcio_debug_port_resp_validLeft;
  wire         srcio_debug_port_resp_validRight;
  wire         trgio_debug_port_resp_validLeft;
  wire         trgio_debug_port_resp_validRight;

  wire  [31:0] srcio_debug_port_resp_bits_dataLeft;
  wire  [31:0] srcio_debug_port_resp_bits_dataRight;
  wire  [31:0] trgio_debug_port_resp_bits_dataLeft;
  wire  [31:0] trgio_debug_port_resp_bits_dataRight;

//**Wire declarations**//
//**Init register**//
//**Self-composed modules**//
//**Initial state**//
//**State invariants**//
//**Source to target mapping**//
//**Verification conditions**//
endmodule