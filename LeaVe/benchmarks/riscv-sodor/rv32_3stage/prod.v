module prod
(
  input clock
);

  wire         reset;   

  wire         srcio_dmi_req_readyleft;
  wire         srcio_dmi_req_readyright;
  wire         trgio_dmi_req_readyleft;
  wire         trgio_dmi_req_readyright;

  wire         srcio_dmi_req_validleft;
  wire         srcio_dmi_req_validright;
  wire         trgio_dmi_req_validleft;
  wire         trgio_dmi_req_validright;

  wire  [1:0]  srcio_dmi_req_bits_opleft;
  wire  [1:0]  srcio_dmi_req_bits_opright;
  wire  [1:0]  trgio_dmi_req_bits_opleft;
  wire  [1:0]  trgio_dmi_req_bits_opright;

  wire  [6:0]  srcio_dmi_req_bits_addrleft;
  wire  [6:0]  srcio_dmi_req_bits_addrright;
  wire  [6:0]  trgio_dmi_req_bits_addrleft;
  wire  [6:0]  trgio_dmi_req_bits_addrright;

  wire  [31:0] srcio_dmi_req_bits_dataleft;
  wire  [31:0] srcio_dmi_req_bits_dataright;
  wire  [31:0] trgio_dmi_req_bits_dataleft;
  wire  [31:0] trgio_dmi_req_bits_dataright;

  wire         srcio_dmi_resp_validleft;
  wire         srcio_dmi_resp_validright;
  wire         trgio_dmi_resp_validleft;
  wire         trgio_dmi_resp_validright;

  wire  [31:0] srcio_dmi_resp_bits_dataleft;
  wire  [31:0] srcio_dmi_resp_bits_dataright;
  wire  [31:0] trgio_dmi_resp_bits_dataleft;
  wire  [31:0] trgio_dmi_resp_bits_dataright;



//**Wire declarations**//
//**Init register**//
//**Self-composition modules**//
//**Low-equivalence assertions**//
//**Src-Trg assertions**//
//**Verification conditions**//
endmodule