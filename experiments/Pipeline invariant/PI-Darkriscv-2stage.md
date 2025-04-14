
CTR: 
  # program counter
  - {id: "PC", cond: "\\core0.retire", attrs: [{value: "\\core0.PC_retire", width: 32}]}
  # When the instruction is a load, we attach the data address
  - {id: "LOAD", cond: "\\core0.retire && \\core0.DelayLCC", attrs: [ {value: "\\core0.DelayDADDR", width: 32}]} 
  # When the instruction is a write, we attach the data address
  - {id: "STORE", cond: "\\core0.retire && \\core0.DelaySCC", attrs: [ {value: "\\core0.DelayDADDR", width: 32}]} 
  # When the instruction is a load, we need the data loaded to the registers are the same
  - {id: "DATAI", cond: "\\core0.retire && \\core0.DelayLCC", attrs: [ {value: "\\core0.DelayLDATA", width: 32}]} 
  # Indicates that the instruction on fly of the two runs are the same
  - {id: "INSTR", cond: "\\core0.retire", attrs: [ {value: "\\core0.DelayXIDATA_next", width: 32}]}
  
  # When the instruction is a conditional branch, we attach the condition-related registers 
  - {id: "BCC", cond: "\\core0.retire && \\core0.DelayBCC", attrs: [ {value: "\\core0.DelayU1REG", width: 32},{value: "\\core0.DelayU2REG", width: 32}]}
  # When the instruction is a JALR, we attach the condition-related registers 
  - {id: "JALR", cond: "\\core0.retire && \\core0.DelayJALR", attrs: [ {value: "\\core0.DelayU1REG", width: 32}]}--------------------------------------------------------------------------------------------------------

PIs:
  # for the 1th 
  - ("\\core0.PC_retire", "\\core0.retire", "\\core0.PC", "\\core0.filter_pc_reg" )
  # for the 2th
  - ("\\core0.DelayLCC? \\core0.DelayDADDR:0x0000", "\\core0.retire", "\\core0.LCC? \\core0.DADDR:0x0000", "\\core0.decode_reg")
  # for the 3th
  - ("\\core0.DelaySCC? \\core0.DelayDADDR:0x0000", "\\core0.retire", "\\core0.SCC? \\core0.DADDR:0x0000", "\\core0.decode_reg")
  # For the 4th 
  - ("\\core0.DelayLCC? \\core0.DelayLDATA:0x0000", "\\core0.retire", "\\core0.DelayLCC? \\core0.DelayLDATA:0x0000", "\\core0.writeback_reg")
  # For the 5th 
  - ("\\core0.DelayXIDATA_next", "\\core0.retire", "\\core0.IDATA", "\\core0.decode_reg")
  # For the 6th 
  - ("\\core0.DelayBCC? \\core0.DelayU1REG:0x0000", "\\core0.retire", "\\core0.BCC? \\core0.U1REG:0x0000", "\\core0.decode_reg")
  - ("\\core0.DelayBCC? \\core0.DelayU2REG:0x0000", "\\core0.retire", "\\core0.BCC? \\core0.U2REG:0x0000", "\\core0.decode_reg")
  # For the 7th 
  - ("\\core0.DelayJALR? \\core0.DelayU1REG:0x0000", "\\core0.retire", "\\core0.JALR? \\core0.U1REG:0x0000", "\\core0.decode_reg")

PI1(..PIi..(CTR1)):
  - {id: "PCs", cond: " \\core0.filter_pc_reg ", attrs: [{value: "\\core0.PC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]}
  - {id: "LOAD", cond: "\\core0.decode_reg && \\core0.LCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a LOAD whenever we have a memory load. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO 
  - {id: "STORE", cond: "\\core0.decode_reg && \\core0.SCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a STORE whenever we have a memory store. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO  
  - {id: "\\core0.DATAI", cond: "\\core0.writeback_reg && \\core0.DelayLCC", attrs: [ {value: "\\core0.DelayLDATA", width: 32}]} # disclose a LOAD and the data write to the register at write back stage
  - {id: "\\core0.XIDATA_next", cond: "\\core0.decode_reg ", attrs: [ {value: "\\core0.XIDATA_next", width: 32}]}
  - {id: "BCC", cond: "\\core0.decode_reg && \\core0.BCC", attrs: [ {value: "\\core0.U1REG", width: 32},{value: "\\core0.U2REG", width: 32}]}
  - {id: "JALR", cond: "\\core0.decode_reg && \\core0.JALR", attrs: [ {value: "\\core0.U1REG", width: 32}]}

### Predicates
# Retire predicates
predicateRetire:
 - {id: "Retire", cond: "1", attrs: [{value: "\\core0.retire", width: 1}]}

# Pipeline predicates
predicatePI:
 - {id: "WRITEBACK", cond: "1", attrs: [{value: "\\core0.writeback", width: 1}]}
 - {id: "DECODE", cond: "1", attrs: [{value: "\\core0.decode", width: 1}]}
 - {id: "FILTER_PC", cond: "1", attrs: [{value: "\\core0.filter_pc", width: 1}]}



########################################################## verify the correctness of PI ##########################################################

TODO

########################################################## result of verification ##########################################################

stateInvariant: # if init is "1", it will only be assumed in cycle 0 
  - {id: "OprInvs", cond: "1", attrs: [ { value: "(((\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (\\core0.XRCC ) && (!\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (\\core0.XMAC ) ) || ((!\\core0.XLUI ) && (!\\core0.XAUIPC ) && (!\\core0.XJAL ) && (!\\core0.XJALR ) && (!\\core0.XBCC ) && (!\\core0.XLCC ) && (!\\core0.XSCC ) && (!\\core0.XMCC ) && (!\\core0.XRCC ) && (!\\core0.XMAC ) ) )", width: 1} ]} # (!XLUI ) && (!XAUIPC ) && (!XJAL ) && (!XJALR ) && (!XBCC ) && (!XLCC ) && (!XSCC ) && (!XMCC ) && (!XRCC ) && (!XMAC )
  - {id: "IRESInvs", cond: "1", attrs: [ { value: "IRES==0", width: 1}] }  
  - {id: "IDATAInvs", cond: "1", attrs: [ { value: " ( \\core0.IDATA == 0 ) == 0 ", width: 1}] }  
  - {id: "XRESInvs", cond: "1", attrs: [ { value: "\\core0.XRES == 0", width: 1}] }
  - {id: "reg1Invs", cond: "1", attrs: [ { value: "\\core0.REG1_0 == 0", width: 1, init: "0"}] }
  - {id: "reg2Invs", cond: "1", attrs: [ { value: "\\core0.REG2_0 == 0", width: 1, init: "0"}] }
  - {id: "PC_NXPC", cond: "1", attrs: [ {value: " ( ! ( \\core0.decode_reg && ( ! \\core0.FLUSH ) && ( \\core0.JAL || \\core0.JALR ) ) ) || ( \\core0.NXPC == \\core0.PC + 4 ) ", width: 1}]}

invariant: 
  - {id: "PCs_inv1_1", cond: " ! \\core0.FLUSH ", attrs: [ {value: "\\core0.PC", width: 32}]}
  - {id: "PCs_inv1_2", cond: " ! \\core0.FLUSH ", attrs: [ {value: "\\core0.NXPC", width: 32}]}
  - {id: "PCs_inv2_1", cond: " \\core0.decode_reg && ! \\core0.FLUSH ", attrs: [ {value: "\\core0.PC", width: 32}]}
  - {id: "PCs_inv2_2", cond: " \\core0.decode_reg && ! \\core0.FLUSH ", attrs: [ {value: "\\core0.NXPC", width: 32}]}
  - {id: "HLT_FLUSH_inv", cond: " \\core0.HLT ", attrs: [ {value: "\\core0.FLUSH", width: 32}]}
  - {id: "HLT_inv", cond: "\\core0.decode ", attrs: [ {value: "\\core0.HLT", width: 32}]}
  - {id: "FLUSH_inv", cond: "\\core0.decode ", attrs: [ {value: "\\core0.FLUSH", width: 32}]}
  - {id: "BCC_EXECUTE", cond: "\\core0.BCC", attrs: [ {value: "\\core0.U1REG", width: 32},{value: "\\core0.U2REG", width: 32}]}
  - {id: "JALR_EXECUTE", cond: "\\core0.JALR", attrs: [ {value: "\\core0.U1REG", width: 32}]}
  - {id: "LCC_ADDR", cond: "\\core0.LCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}
  - {id: "LCC_EXECUTE5", cond: " (\\core0.MCC || \\core0.RCC )", attrs: [ {value: "\\core0.RMDATA", width: 32}]}
  - {id: "LCC_EXECUTE4", cond: " \\core0.LCC ", attrs: [ {value: "\\core0.LDATA", width: 32}]}
  - {id: "LCC_EXECUTE1", cond: " \\core0.AUIPC ", attrs: [ {value: "\\core0.PCSIMM", width: 32}]}
  - {id: "LCC_EXECUTE2", cond: " (\\core0.JAL || \\core0.JALR )", attrs: [ {value: "\\core0.NXPC", width: 32}]}
  - {id: "LCC_EXECUTE3", cond: " \\core0.LUI ", attrs: [ {value: "\\core0.SIMM", width: 32}]}
  - {id: "LCC_EXECUTE5_1", cond: " \\core0.writeback && (\\core0.MCC || \\core0.RCC )", attrs: [ {value: "\\core0.RMDATA", width: 32}]}
  - {id: "LCC_EXECUTE4_1", cond: " \\core0.writeback && \\core0.LCC ", attrs: [ {value: "\\core0.LDATA", width: 32}]}
  - {id: "LCC_EXECUTE1_1", cond: " \\core0.writeback && \\core0.AUIPC ", attrs: [ {value: "\\core0.PCSIMM", width: 32}]}
  - {id: "LCC_EXECUTE2_1", cond: " \\core0.writeback && (\\core0.JAL || \\core0.JALR )", attrs: [ {value: "\\core0.NXPC", width: 32}]}
  - {id: "LCC_EXECUTE3_1", cond: " \\core0.writeback && \\core0.LUI ", attrs: [ {value: "\\core0.SIMM", width: 32}]}
  - {id: "SCC_EXECUTE", cond: "\\core0.SCC", attrs: [ {value: "\\core0.U2REG", width: 32}]}



### FILTERED SOURCE
filteredSrcObservations:
######################
# seq-arch with store data
######################
   - {id: "PCs", cond: " \\core0.filter_pc_reg ", attrs: [{value: "\\core0.PC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]}
   - {id: "LOAD", cond: "\\core0.decode_reg && \\core0.LCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a LOAD whenever we have a memory load. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO 
   - {id: "STORE", cond: "\\core0.decode_reg && \\core0.SCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a STORE whenever we have a memory store. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO  
   - {id: "\\core0.DATAI", cond: "\\core0.writeback_reg && \\core0.DelayLCC", attrs: [ {value: "\\core0.DelayLDATA", width: 32}]} # disclose a LOAD and the data write to the register at write back stage
   - {id: "\\core0.DATAO", cond: "\\core0.decode_reg && \\core0.SCC", attrs: [ {value: "\\core0.DATAO", width: 32}]}
   - {id: "\\core0.XIDATA_next", cond: "\\core0.decode_reg ", attrs: [ {value: "\\core0.XIDATA_next", width: 32}]}

	Checking the relation between target and invariant...
	The invariant for checking is:
	- { id: PCs_inv1_1, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv1_2, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: PCs_inv2_1, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv2_2, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: HLT_FLUSH_inv, cond:  \core0.HLT , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: HLT_inv, cond: \core0.decode , attrs: [ { value: \core0.HLT, width: 32 } ]}
	- { id: FLUSH_inv, cond: \core0.decode , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: BCC_EXECUTE, cond: \core0.BCC, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: JALR_EXECUTE, cond: \core0.JALR, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: LCC_ADDR, cond: \core0.LCC, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: LCC_EXECUTE5, cond:  (\core0.MCC || \core0.RCC ), attrs: [ { value: \core0.RMDATA, width: 32 } ]}
	- { id: LCC_EXECUTE1, cond:  \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2, cond:  (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3, cond:  \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: LCC_EXECUTE5_1, cond:  \core0.writeback && (\core0.MCC || \core0.RCC ), attrs: [ { value: \core0.RMDATA, width: 32 } ]}
	- { id: LCC_EXECUTE1_1, cond:  \core0.writeback && \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2_1, cond:  \core0.writeback && (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3_1, cond:  \core0.writeback && \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: SCC_EXECUTE, cond: \core0.SCC, attrs: [ { value: \core0.U2REG, width: 32 } ]}
	- { id: \core0.REG1_0, cond: 1, attrs: [ { value: \core0.REG1_0, width: 32 } ]}
	- { id: \core0.REG1_1, cond: 1, attrs: [ { value: \core0.REG1_1, width: 32 } ]}
	- { id: \core0.REG1_2, cond: 1, attrs: [ { value: \core0.REG1_2, width: 32 } ]}
	- { id: \core0.REG1_3, cond: 1, attrs: [ { value: \core0.REG1_3, width: 32 } ]}
	- { id: \core0.REG1_4, cond: 1, attrs: [ { value: \core0.REG1_4, width: 32 } ]}
	- { id: \core0.REG1_5, cond: 1, attrs: [ { value: \core0.REG1_5, width: 32 } ]}
	- { id: \core0.REG1_6, cond: 1, attrs: [ { value: \core0.REG1_6, width: 32 } ]}
	- { id: \core0.REG1_7, cond: 1, attrs: [ { value: \core0.REG1_7, width: 32 } ]}
	- { id: \core0.REG1_8, cond: 1, attrs: [ { value: \core0.REG1_8, width: 32 } ]}
	- { id: \core0.REG1_9, cond: 1, attrs: [ { value: \core0.REG1_9, width: 32 } ]}
	- { id: \core0.REG1_10, cond: 1, attrs: [ { value: \core0.REG1_10, width: 32 } ]}
	- { id: \core0.REG1_11, cond: 1, attrs: [ { value: \core0.REG1_11, width: 32 } ]}
	- { id: \core0.REG1_12, cond: 1, attrs: [ { value: \core0.REG1_12, width: 32 } ]}
	- { id: \core0.REG1_13, cond: 1, attrs: [ { value: \core0.REG1_13, width: 32 } ]}
	- { id: \core0.REG1_14, cond: 1, attrs: [ { value: \core0.REG1_14, width: 32 } ]}
	- { id: \core0.REG1_15, cond: 1, attrs: [ { value: \core0.REG1_15, width: 32 } ]}
	- { id: \core0.REG2_0, cond: 1, attrs: [ { value: \core0.REG2_0, width: 32 } ]}
	- { id: \core0.REG2_1, cond: 1, attrs: [ { value: \core0.REG2_1, width: 32 } ]}
	- { id: \core0.REG2_2, cond: 1, attrs: [ { value: \core0.REG2_2, width: 32 } ]}
	- { id: \core0.REG2_3, cond: 1, attrs: [ { value: \core0.REG2_3, width: 32 } ]}
	- { id: \core0.REG2_4, cond: 1, attrs: [ { value: \core0.REG2_4, width: 32 } ]}
	- { id: \core0.REG2_5, cond: 1, attrs: [ { value: \core0.REG2_5, width: 32 } ]}
	- { id: \core0.REG2_6, cond: 1, attrs: [ { value: \core0.REG2_6, width: 32 } ]}
	- { id: \core0.REG2_7, cond: 1, attrs: [ { value: \core0.REG2_7, width: 32 } ]}
	- { id: \core0.REG2_8, cond: 1, attrs: [ { value: \core0.REG2_8, width: 32 } ]}
	- { id: \core0.REG2_9, cond: 1, attrs: [ { value: \core0.REG2_9, width: 32 } ]}
	- { id: \core0.REG2_10, cond: 1, attrs: [ { value: \core0.REG2_10, width: 32 } ]}
	- { id: \core0.REG2_11, cond: 1, attrs: [ { value: \core0.REG2_11, width: 32 } ]}
	- { id: \core0.REG2_12, cond: 1, attrs: [ { value: \core0.REG2_12, width: 32 } ]}
	- { id: \core0.REG2_13, cond: 1, attrs: [ { value: \core0.REG2_13, width: 32 } ]}
	- { id: \core0.REG2_14, cond: 1, attrs: [ { value: \core0.REG2_14, width: 32 } ]}
	- { id: \core0.REG2_15, cond: 1, attrs: [ { value: \core0.REG2_15, width: 32 } ]}
	- { id: BOARD_CK, cond: 1, attrs: [ { value: BOARD_CK, width: 8 } ]}
	- { id: BOARD_CM, cond: 1, attrs: [ { value: BOARD_CM, width: 8 } ]}
	- { id: BOARD_ID, cond: 1, attrs: [ { value: BOARD_ID, width: 8 } ]}
	- { id: BOARD_IRQ, cond: 1, attrs: [ { value: BOARD_IRQ, width: 8 } ]}
	- { id: CLK, cond: 1, attrs: [ { value: CLK, width: 1 } ]}
	- { id: DACK, cond: 1, attrs: [ { value: DACK, width: 1 } ]}
	- { id: DADDR, cond: 1, attrs: [ { value: DADDR, width: 32 } ]}
	- { id: DATAO, cond: 1, attrs: [ { value: DATAO, width: 32 } ]}
	- { id: DEBUG, cond: 1, attrs: [ { value: DEBUG, width: 4 } ]}
	- { id: DHIT, cond: 1, attrs: [ { value: DHIT, width: 1 } ]}
	- { id: GPIOFF, cond: 1, attrs: [ { value: GPIOFF, width: 16 } ]}
	- { id: HLT, cond: 1, attrs: [ { value: HLT, width: 1 } ]}
	- { id: IACK, cond: 1, attrs: [ { value: IACK, width: 8 } ]}
	- { id: IDLE, cond: 1, attrs: [ { value: IDLE, width: 1 } ]}
	- { id: IHIT, cond: 1, attrs: [ { value: IHIT, width: 1 } ]}
	- { id: IHITACK, cond: 1, attrs: [ { value: IHITACK, width: 1 } ]}
	- { id: \IOMUX[0], cond: 1, attrs: [ { value: \IOMUX[0], width: 32 } ]}
	- { id: \IOMUX[2], cond: 1, attrs: [ { value: \IOMUX[2], width: 32 } ]}
	- { id: \IOMUX[3], cond: 1, attrs: [ { value: \IOMUX[3], width: 32 } ]}
	- { id: IREQ, cond: 1, attrs: [ { value: IREQ, width: 8 } ]}
	- { id: IRES, cond: 1, attrs: [ { value: IRES, width: 8 } ]}
	- { id: KDEBUG, cond: 1, attrs: [ { value: KDEBUG, width: 4 } ]}
	- { id: LED, cond: 1, attrs: [ { value: LED, width: 4 } ]}
	- { id: LEDFF, cond: 1, attrs: [ { value: LEDFF, width: 16 } ]}
	- { id: RD, cond: 1, attrs: [ { value: RD, width: 1 } ]}
	- { id: RES, cond: 1, attrs: [ { value: RES, width: 1 } ]}
	- { id: TIMER, cond: 1, attrs: [ { value: TIMER, width: 32 } ]}
	- { id: TIMERFF, cond: 1, attrs: [ { value: TIMERFF, width: 32 } ]}
	- { id: WHIT, cond: 1, attrs: [ { value: WHIT, width: 1 } ]}
	- { id: WR, cond: 1, attrs: [ { value: WR, width: 1 } ]}
	- { id: XADDR, cond: 1, attrs: [ { value: XADDR, width: 32 } ]}
	- { id: XCLK, cond: 1, attrs: [ { value: XCLK, width: 1 } ]}
	- { id: XRES, cond: 1, attrs: [ { value: XRES, width: 1 } ]}
	- { id: XTIMER, cond: 1, attrs: [ { value: XTIMER, width: 1 } ]}
	- { id: \core0.ALL0, cond: 1, attrs: [ { value: \core0.ALL0, width: 32 } ]}
	- { id: \core0.ALL1, cond: 1, attrs: [ { value: \core0.ALL1, width: 32 } ]}
	- { id: \core0.AUIPC, cond: 1, attrs: [ { value: \core0.AUIPC, width: 1 } ]}
	- { id: \core0.BCC, cond: 1, attrs: [ { value: \core0.BCC, width: 1 } ]}
	- { id: \core0.BMUX, cond: 1, attrs: [ { value: \core0.BMUX, width: 1 } ]}
	- { id: \core0.CDATA, cond: 1, attrs: [ { value: \core0.CDATA, width: 32 } ]}
	- { id: \core0.CLK, cond: 1, attrs: [ { value: \core0.CLK, width: 1 } ]}
	- { id: \core0.DADDR, cond: 1, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: \core0.DATAO, cond: 1, attrs: [ { value: \core0.DATAO, width: 32 } ]}
	- { id: \core0.DEBUG, cond: 1, attrs: [ { value: \core0.DEBUG, width: 4 } ]}
	- { id: \core0.DelayBCC, cond: 1, attrs: [ { value: \core0.DelayBCC, width: 1 } ]}
	- { id: \core0.DelayDADDR, cond: 1, attrs: [ { value: \core0.DelayDADDR, width: 32 } ]}
	- { id: \core0.DelayJALR, cond: 1, attrs: [ { value: \core0.DelayJALR, width: 1 } ]}
	- { id: \core0.DelayLCC, cond: 1, attrs: [ { value: \core0.DelayLCC, width: 1 } ]}
	- { id: \core0.DelaySCC, cond: 1, attrs: [ { value: \core0.DelaySCC, width: 1 } ]}
	- { id: \core0.DelayXIDATA_next, cond: 1, attrs: [ { value: \core0.DelayXIDATA_next, width: 32 } ]}
	- { id: \core0.FLUSH, cond: 1, attrs: [ { value: \core0.FLUSH, width: 1 } ]}
	- { id: \core0.FLUSH_wire, cond: 1, attrs: [ { value: \core0.FLUSH_wire, width: 1 } ]}
	- { id: \core0.HLT, cond: 1, attrs: [ { value: \core0.HLT, width: 1 } ]}
	- { id: \core0.IDLE, cond: 1, attrs: [ { value: \core0.IDLE, width: 1 } ]}
	- { id: \core0.JAL, cond: 1, attrs: [ { value: \core0.JAL, width: 1 } ]}
	- { id: \core0.JALR, cond: 1, attrs: [ { value: \core0.JALR, width: 1 } ]}
	- { id: \core0.JREQ, cond: 1, attrs: [ { value: \core0.JREQ, width: 1 } ]}
	- { id: \core0.LCC, cond: 1, attrs: [ { value: \core0.LCC, width: 1 } ]}
	- { id: \core0.LUI, cond: 1, attrs: [ { value: \core0.LUI, width: 1 } ]}
	- { id: \core0.MAC, cond: 1, attrs: [ { value: \core0.MAC, width: 1 } ]}
	- { id: \core0.MCC, cond: 1, attrs: [ { value: \core0.MCC, width: 1 } ]}
	- { id: \core0.OPCODE, cond: 1, attrs: [ { value: \core0.OPCODE, width: 7 } ]}
	- { id: \core0.PC, cond: 1, attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: \core0.PC_retire, cond: 1, attrs: [ { value: \core0.PC_retire, width: 32 } ]}
	- { id: \core0.RCC, cond: 1, attrs: [ { value: \core0.RCC, width: 1 } ]}
	- { id: \core0.RD, cond: 1, attrs: [ { value: \core0.RD, width: 1 } ]}
	- { id: \core0.RES, cond: 1, attrs: [ { value: \core0.RES, width: 1 } ]}
	- { id: \core0.RESMODE, cond: 1, attrs: [ { value: \core0.RESMODE, width: 4 } ]}
	- { id: \core0.SCC, cond: 1, attrs: [ { value: \core0.SCC, width: 1 } ]}
	- { id: \core0.WR, cond: 1, attrs: [ { value: \core0.WR, width: 1 } ]}
	- { id: \core0.XIDATA_next, cond: 1, attrs: [ { value: \core0.XIDATA_next, width: 32 } ]}
	- { id: \core0.XRES, cond: 1, attrs: [ { value: \core0.XRES, width: 1 } ]}
	- { id: \core0.decode, cond: 1, attrs: [ { value: \core0.decode, width: 1 } ]}
	- { id: \core0.decode_reg, cond: 1, attrs: [ { value: \core0.decode_reg, width: 1 } ]}
	- { id: \core0.filter_pc, cond: 1, attrs: [ { value: \core0.filter_pc, width: 1 } ]}
	- { id: \core0.filter_pc_reg, cond: 1, attrs: [ { value: \core0.filter_pc_reg, width: 1 } ]}
	- { id: \core0.retire, cond: 1, attrs: [ { value: \core0.retire, width: 1 } ]}
	- { id: \core0.writeback, cond: 1, attrs: [ { value: \core0.writeback, width: 1 } ]}
	- { id: \core0.writeback_reg, cond: 1, attrs: [ { value: \core0.writeback_reg, width: 1 } ]}
	- { id: \uart0.CLK, cond: 1, attrs: [ { value: \uart0.CLK, width: 1 } ]}
	- { id: \uart0.DATAI, cond: 1, attrs: [ { value: \uart0.DATAI, width: 32 } ]}
	- { id: \uart0.RD, cond: 1, attrs: [ { value: \uart0.RD, width: 1 } ]}
	- { id: \uart0.RES, cond: 1, attrs: [ { value: \uart0.RES, width: 1 } ]}
	- { id: \uart0.UART_XFIFO, cond: 1, attrs: [ { value: \uart0.UART_XFIFO, width: 8 } ]}
	- { id: \uart0.WR, cond: 1, attrs: [ { value: \uart0.WR, width: 1 } ]}

	Time for base step: 21
	Time for induction step: 1234
	Time for generating invariant: 1256
	Time for checking: 20
The contract checked is satisfied with 35 loops with 136 invariants

### FILTERED SOURCE
filteredSrcObservations:
######################
# seq-arch
######################
   - {id: "PCs", cond: " \\core0.filter_pc_reg ", attrs: [{value: "\\core0.PC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]}
   - {id: "LOAD", cond: "\\core0.decode_reg && \\core0.LCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a LOAD whenever we have a memory load. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO 
   - {id: "STORE", cond: "\\core0.decode_reg && \\core0.SCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a STORE whenever we have a memory store. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO  
   - {id: "\\core0.DATAI", cond: "\\core0.writeback_reg && \\core0.DelayLCC", attrs: [ {value: "\\core0.DelayLDATA", width: 32}]} # disclose a LOAD and the data write to the register at write back stage
   - {id: "\\core0.XIDATA_next", cond: "\\core0.decode_reg ", attrs: [ {value: "\\core0.XIDATA_next", width: 32}]}

	Checking the relation between target and invariant...
	The invariant for checking is:
	- { id: PCs_inv1_1, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv1_2, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: PCs_inv2_1, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv2_2, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: HLT_FLUSH_inv, cond:  \core0.HLT , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: HLT_inv, cond: \core0.decode , attrs: [ { value: \core0.HLT, width: 32 } ]}
	- { id: FLUSH_inv, cond: \core0.decode , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: BCC_EXECUTE, cond: \core0.BCC, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: JALR_EXECUTE, cond: \core0.JALR, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: LCC_ADDR, cond: \core0.LCC, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: LCC_EXECUTE5, cond:  (\core0.MCC || \core0.RCC ), attrs: [ { value: \core0.RMDATA, width: 32 } ]}
	- { id: LCC_EXECUTE1, cond:  \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2, cond:  (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3, cond:  \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: LCC_EXECUTE5_1, cond:  \core0.writeback && (\core0.MCC || \core0.RCC ), attrs: [ { value: \core0.RMDATA, width: 32 } ]}
	- { id: LCC_EXECUTE1_1, cond:  \core0.writeback && \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2_1, cond:  \core0.writeback && (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3_1, cond:  \core0.writeback && \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: SCC_EXECUTE, cond: \core0.SCC, attrs: [ { value: \core0.U2REG, width: 32 } ]}
	- { id: \core0.REG1_0, cond: 1, attrs: [ { value: \core0.REG1_0, width: 32 } ]}
	- { id: \core0.REG1_1, cond: 1, attrs: [ { value: \core0.REG1_1, width: 32 } ]}
	- { id: \core0.REG1_2, cond: 1, attrs: [ { value: \core0.REG1_2, width: 32 } ]}
	- { id: \core0.REG1_3, cond: 1, attrs: [ { value: \core0.REG1_3, width: 32 } ]}
	- { id: \core0.REG1_4, cond: 1, attrs: [ { value: \core0.REG1_4, width: 32 } ]}
	- { id: \core0.REG1_5, cond: 1, attrs: [ { value: \core0.REG1_5, width: 32 } ]}
	- { id: \core0.REG1_6, cond: 1, attrs: [ { value: \core0.REG1_6, width: 32 } ]}
	- { id: \core0.REG1_7, cond: 1, attrs: [ { value: \core0.REG1_7, width: 32 } ]}
	- { id: \core0.REG1_8, cond: 1, attrs: [ { value: \core0.REG1_8, width: 32 } ]}
	- { id: \core0.REG1_9, cond: 1, attrs: [ { value: \core0.REG1_9, width: 32 } ]}
	- { id: \core0.REG1_10, cond: 1, attrs: [ { value: \core0.REG1_10, width: 32 } ]}
	- { id: \core0.REG1_11, cond: 1, attrs: [ { value: \core0.REG1_11, width: 32 } ]}
	- { id: \core0.REG1_12, cond: 1, attrs: [ { value: \core0.REG1_12, width: 32 } ]}
	- { id: \core0.REG1_13, cond: 1, attrs: [ { value: \core0.REG1_13, width: 32 } ]}
	- { id: \core0.REG1_14, cond: 1, attrs: [ { value: \core0.REG1_14, width: 32 } ]}
	- { id: \core0.REG1_15, cond: 1, attrs: [ { value: \core0.REG1_15, width: 32 } ]}
	- { id: \core0.REG2_0, cond: 1, attrs: [ { value: \core0.REG2_0, width: 32 } ]}
	- { id: \core0.REG2_1, cond: 1, attrs: [ { value: \core0.REG2_1, width: 32 } ]}
	- { id: \core0.REG2_2, cond: 1, attrs: [ { value: \core0.REG2_2, width: 32 } ]}
	- { id: \core0.REG2_3, cond: 1, attrs: [ { value: \core0.REG2_3, width: 32 } ]}
	- { id: \core0.REG2_4, cond: 1, attrs: [ { value: \core0.REG2_4, width: 32 } ]}
	- { id: \core0.REG2_5, cond: 1, attrs: [ { value: \core0.REG2_5, width: 32 } ]}
	- { id: \core0.REG2_6, cond: 1, attrs: [ { value: \core0.REG2_6, width: 32 } ]}
	- { id: \core0.REG2_7, cond: 1, attrs: [ { value: \core0.REG2_7, width: 32 } ]}
	- { id: \core0.REG2_8, cond: 1, attrs: [ { value: \core0.REG2_8, width: 32 } ]}
	- { id: \core0.REG2_9, cond: 1, attrs: [ { value: \core0.REG2_9, width: 32 } ]}
	- { id: \core0.REG2_10, cond: 1, attrs: [ { value: \core0.REG2_10, width: 32 } ]}
	- { id: \core0.REG2_11, cond: 1, attrs: [ { value: \core0.REG2_11, width: 32 } ]}
	- { id: \core0.REG2_12, cond: 1, attrs: [ { value: \core0.REG2_12, width: 32 } ]}
	- { id: \core0.REG2_13, cond: 1, attrs: [ { value: \core0.REG2_13, width: 32 } ]}
	- { id: \core0.REG2_14, cond: 1, attrs: [ { value: \core0.REG2_14, width: 32 } ]}
	- { id: \core0.REG2_15, cond: 1, attrs: [ { value: \core0.REG2_15, width: 32 } ]}
	- { id: BOARD_CK, cond: 1, attrs: [ { value: BOARD_CK, width: 8 } ]}
	- { id: BOARD_CM, cond: 1, attrs: [ { value: BOARD_CM, width: 8 } ]}
	- { id: BOARD_ID, cond: 1, attrs: [ { value: BOARD_ID, width: 8 } ]}
	- { id: BOARD_IRQ, cond: 1, attrs: [ { value: BOARD_IRQ, width: 8 } ]}
	- { id: CLK, cond: 1, attrs: [ { value: CLK, width: 1 } ]}
	- { id: DACK, cond: 1, attrs: [ { value: DACK, width: 1 } ]}
	- { id: DADDR, cond: 1, attrs: [ { value: DADDR, width: 32 } ]}
	- { id: DATAO, cond: 1, attrs: [ { value: DATAO, width: 32 } ]}
	- { id: DEBUG, cond: 1, attrs: [ { value: DEBUG, width: 4 } ]}
	- { id: DHIT, cond: 1, attrs: [ { value: DHIT, width: 1 } ]}
	- { id: GPIOFF, cond: 1, attrs: [ { value: GPIOFF, width: 16 } ]}
	- { id: HLT, cond: 1, attrs: [ { value: HLT, width: 1 } ]}
	- { id: IACK, cond: 1, attrs: [ { value: IACK, width: 8 } ]}
	- { id: IDLE, cond: 1, attrs: [ { value: IDLE, width: 1 } ]}
	- { id: IHIT, cond: 1, attrs: [ { value: IHIT, width: 1 } ]}
	- { id: IHITACK, cond: 1, attrs: [ { value: IHITACK, width: 1 } ]}
	- { id: \IOMUX[0], cond: 1, attrs: [ { value: \IOMUX[0], width: 32 } ]}
	- { id: \IOMUX[2], cond: 1, attrs: [ { value: \IOMUX[2], width: 32 } ]}
	- { id: \IOMUX[3], cond: 1, attrs: [ { value: \IOMUX[3], width: 32 } ]}
	- { id: IREQ, cond: 1, attrs: [ { value: IREQ, width: 8 } ]}
	- { id: IRES, cond: 1, attrs: [ { value: IRES, width: 8 } ]}
	- { id: KDEBUG, cond: 1, attrs: [ { value: KDEBUG, width: 4 } ]}
	- { id: LED, cond: 1, attrs: [ { value: LED, width: 4 } ]}
	- { id: LEDFF, cond: 1, attrs: [ { value: LEDFF, width: 16 } ]}
	- { id: RD, cond: 1, attrs: [ { value: RD, width: 1 } ]}
	- { id: RES, cond: 1, attrs: [ { value: RES, width: 1 } ]}
	- { id: TIMER, cond: 1, attrs: [ { value: TIMER, width: 32 } ]}
	- { id: TIMERFF, cond: 1, attrs: [ { value: TIMERFF, width: 32 } ]}
	- { id: WHIT, cond: 1, attrs: [ { value: WHIT, width: 1 } ]}
	- { id: WR, cond: 1, attrs: [ { value: WR, width: 1 } ]}
	- { id: XADDR, cond: 1, attrs: [ { value: XADDR, width: 32 } ]}
	- { id: XCLK, cond: 1, attrs: [ { value: XCLK, width: 1 } ]}
	- { id: XRES, cond: 1, attrs: [ { value: XRES, width: 1 } ]}
	- { id: XTIMER, cond: 1, attrs: [ { value: XTIMER, width: 1 } ]}
	- { id: \core0.ALL0, cond: 1, attrs: [ { value: \core0.ALL0, width: 32 } ]}
	- { id: \core0.ALL1, cond: 1, attrs: [ { value: \core0.ALL1, width: 32 } ]}
	- { id: \core0.AUIPC, cond: 1, attrs: [ { value: \core0.AUIPC, width: 1 } ]}
	- { id: \core0.BCC, cond: 1, attrs: [ { value: \core0.BCC, width: 1 } ]}
	- { id: \core0.BMUX, cond: 1, attrs: [ { value: \core0.BMUX, width: 1 } ]}
	- { id: \core0.CDATA, cond: 1, attrs: [ { value: \core0.CDATA, width: 32 } ]}
	- { id: \core0.CLK, cond: 1, attrs: [ { value: \core0.CLK, width: 1 } ]}
	- { id: \core0.DADDR, cond: 1, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: \core0.DATAO, cond: 1, attrs: [ { value: \core0.DATAO, width: 32 } ]}
	- { id: \core0.DEBUG, cond: 1, attrs: [ { value: \core0.DEBUG, width: 4 } ]}
	- { id: \core0.DelayBCC, cond: 1, attrs: [ { value: \core0.DelayBCC, width: 1 } ]}
	- { id: \core0.DelayDADDR, cond: 1, attrs: [ { value: \core0.DelayDADDR, width: 32 } ]}
	- { id: \core0.DelayJALR, cond: 1, attrs: [ { value: \core0.DelayJALR, width: 1 } ]}
	- { id: \core0.DelayLCC, cond: 1, attrs: [ { value: \core0.DelayLCC, width: 1 } ]}
	- { id: \core0.DelaySCC, cond: 1, attrs: [ { value: \core0.DelaySCC, width: 1 } ]}
	- { id: \core0.DelayXIDATA_next, cond: 1, attrs: [ { value: \core0.DelayXIDATA_next, width: 32 } ]}
	- { id: \core0.FLUSH, cond: 1, attrs: [ { value: \core0.FLUSH, width: 1 } ]}
	- { id: \core0.FLUSH_wire, cond: 1, attrs: [ { value: \core0.FLUSH_wire, width: 1 } ]}
	- { id: \core0.HLT, cond: 1, attrs: [ { value: \core0.HLT, width: 1 } ]}
	- { id: \core0.IDLE, cond: 1, attrs: [ { value: \core0.IDLE, width: 1 } ]}
	- { id: \core0.JAL, cond: 1, attrs: [ { value: \core0.JAL, width: 1 } ]}
	- { id: \core0.JALR, cond: 1, attrs: [ { value: \core0.JALR, width: 1 } ]}
	- { id: \core0.JREQ, cond: 1, attrs: [ { value: \core0.JREQ, width: 1 } ]}
	- { id: \core0.LCC, cond: 1, attrs: [ { value: \core0.LCC, width: 1 } ]}
	- { id: \core0.LUI, cond: 1, attrs: [ { value: \core0.LUI, width: 1 } ]}
	- { id: \core0.MAC, cond: 1, attrs: [ { value: \core0.MAC, width: 1 } ]}
	- { id: \core0.MCC, cond: 1, attrs: [ { value: \core0.MCC, width: 1 } ]}
	- { id: \core0.OPCODE, cond: 1, attrs: [ { value: \core0.OPCODE, width: 7 } ]}
	- { id: \core0.PC, cond: 1, attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: \core0.PC_retire, cond: 1, attrs: [ { value: \core0.PC_retire, width: 32 } ]}
	- { id: \core0.RCC, cond: 1, attrs: [ { value: \core0.RCC, width: 1 } ]}
	- { id: \core0.RD, cond: 1, attrs: [ { value: \core0.RD, width: 1 } ]}
	- { id: \core0.RES, cond: 1, attrs: [ { value: \core0.RES, width: 1 } ]}
	- { id: \core0.RESMODE, cond: 1, attrs: [ { value: \core0.RESMODE, width: 4 } ]}
	- { id: \core0.SCC, cond: 1, attrs: [ { value: \core0.SCC, width: 1 } ]}
	- { id: \core0.WR, cond: 1, attrs: [ { value: \core0.WR, width: 1 } ]}
	- { id: \core0.XIDATA_next, cond: 1, attrs: [ { value: \core0.XIDATA_next, width: 32 } ]}
	- { id: \core0.XRES, cond: 1, attrs: [ { value: \core0.XRES, width: 1 } ]}
	- { id: \core0.decode, cond: 1, attrs: [ { value: \core0.decode, width: 1 } ]}
	- { id: \core0.decode_reg, cond: 1, attrs: [ { value: \core0.decode_reg, width: 1 } ]}
	- { id: \core0.filter_pc, cond: 1, attrs: [ { value: \core0.filter_pc, width: 1 } ]}
	- { id: \core0.filter_pc_reg, cond: 1, attrs: [ { value: \core0.filter_pc_reg, width: 1 } ]}
	- { id: \core0.retire, cond: 1, attrs: [ { value: \core0.retire, width: 1 } ]}
	- { id: \core0.writeback, cond: 1, attrs: [ { value: \core0.writeback, width: 1 } ]}
	- { id: \core0.writeback_reg, cond: 1, attrs: [ { value: \core0.writeback_reg, width: 1 } ]}
	- { id: \uart0.CLK, cond: 1, attrs: [ { value: \uart0.CLK, width: 1 } ]}
	- { id: \uart0.DATAI, cond: 1, attrs: [ { value: \uart0.DATAI, width: 32 } ]}
	- { id: \uart0.RD, cond: 1, attrs: [ { value: \uart0.RD, width: 1 } ]}
	- { id: \uart0.RES, cond: 1, attrs: [ { value: \uart0.RES, width: 1 } ]}
	- { id: \uart0.UART_XFIFO, cond: 1, attrs: [ { value: \uart0.UART_XFIFO, width: 8 } ]}
	- { id: \uart0.WR, cond: 1, attrs: [ { value: \uart0.WR, width: 1 } ]}

	Time for base step: 21
	Time for induction step: 1218
	Time for generating invariant: 1240
	Time for checking: 20
The contract checked is satisfied with 35 loops


### FILTERED SOURCE
filteredSrcObservations:
######################
# seq-ct with jump instruction
######################
   - {id: "PCs", cond: " \\core0.filter_pc_reg ", attrs: [{value: "\\core0.PC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]}
   - {id: "LOAD", cond: "\\core0.decode_reg && \\core0.LCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a LOAD whenever we have a memory load. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO 
   - {id: "STORE", cond: "\\core0.decode_reg && \\core0.SCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a STORE whenever we have a memory store. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO  
   - {id: "BCC", cond: "\\core0.decode_reg && \\core0.BCC", attrs: [ {value: "\\core0.U1REG", width: 32},{value: "\\core0.U2REG", width: 32}]}
   - {id: "JALR", cond: "\\core0.decode_reg && \\core0.JALR", attrs: [ {value: "\\core0.U1REG", width: 32}]}
   - {id: "\\core0.XIDATA_next", cond: "\\core0.decode_reg ", attrs: [ {value: "\\core0.XIDATA_next", width: 32}]}


	Checking the relation between target and invariant...
	The invariant for checking is:
	- { id: PCs_inv1_1, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv1_2, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: PCs_inv2_1, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv2_2, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: HLT_FLUSH_inv, cond:  \core0.HLT , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: HLT_inv, cond: \core0.decode , attrs: [ { value: \core0.HLT, width: 32 } ]}
	- { id: FLUSH_inv, cond: \core0.decode , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: BCC_EXECUTE, cond: \core0.BCC, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: JALR_EXECUTE, cond: \core0.JALR, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: LCC_ADDR, cond: \core0.LCC, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: LCC_EXECUTE1, cond:  \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2, cond:  (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3, cond:  \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: LCC_EXECUTE1_1, cond:  \core0.writeback && \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2_1, cond:  \core0.writeback && (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3_1, cond:  \core0.writeback && \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: \core0.REG1_0, cond: 1, attrs: [ { value: \core0.REG1_0, width: 32 } ]}
	- { id: \core0.REG2_0, cond: 1, attrs: [ { value: \core0.REG2_0, width: 32 } ]}
	- { id: BOARD_CK, cond: 1, attrs: [ { value: BOARD_CK, width: 8 } ]}
	- { id: BOARD_CM, cond: 1, attrs: [ { value: BOARD_CM, width: 8 } ]}
	- { id: BOARD_ID, cond: 1, attrs: [ { value: BOARD_ID, width: 8 } ]}
	- { id: CLK, cond: 1, attrs: [ { value: CLK, width: 1 } ]}
	- { id: DACK, cond: 1, attrs: [ { value: DACK, width: 1 } ]}
	- { id: DADDR, cond: 1, attrs: [ { value: DADDR, width: 32 } ]}
	- { id: DHIT, cond: 1, attrs: [ { value: DHIT, width: 1 } ]}
	- { id: HLT, cond: 1, attrs: [ { value: HLT, width: 1 } ]}
	- { id: IDLE, cond: 1, attrs: [ { value: IDLE, width: 1 } ]}
	- { id: IHIT, cond: 1, attrs: [ { value: IHIT, width: 1 } ]}
	- { id: IHITACK, cond: 1, attrs: [ { value: IHITACK, width: 1 } ]}
	- { id: IRES, cond: 1, attrs: [ { value: IRES, width: 8 } ]}
	- { id: KDEBUG, cond: 1, attrs: [ { value: KDEBUG, width: 4 } ]}
	- { id: RD, cond: 1, attrs: [ { value: RD, width: 1 } ]}
	- { id: RES, cond: 1, attrs: [ { value: RES, width: 1 } ]}
	- { id: WHIT, cond: 1, attrs: [ { value: WHIT, width: 1 } ]}
	- { id: WR, cond: 1, attrs: [ { value: WR, width: 1 } ]}
	- { id: XADDR, cond: 1, attrs: [ { value: XADDR, width: 32 } ]}
	- { id: XCLK, cond: 1, attrs: [ { value: XCLK, width: 1 } ]}
	- { id: XRES, cond: 1, attrs: [ { value: XRES, width: 1 } ]}
	- { id: \core0.ALL0, cond: 1, attrs: [ { value: \core0.ALL0, width: 32 } ]}
	- { id: \core0.ALL1, cond: 1, attrs: [ { value: \core0.ALL1, width: 32 } ]}
	- { id: \core0.AUIPC, cond: 1, attrs: [ { value: \core0.AUIPC, width: 1 } ]}
	- { id: \core0.BCC, cond: 1, attrs: [ { value: \core0.BCC, width: 1 } ]}
	- { id: \core0.BMUX, cond: 1, attrs: [ { value: \core0.BMUX, width: 1 } ]}
	- { id: \core0.CDATA, cond: 1, attrs: [ { value: \core0.CDATA, width: 32 } ]}
	- { id: \core0.CLK, cond: 1, attrs: [ { value: \core0.CLK, width: 1 } ]}
	- { id: \core0.DADDR, cond: 1, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: \core0.DEBUG, cond: 1, attrs: [ { value: \core0.DEBUG, width: 4 } ]}
	- { id: \core0.DelayBCC, cond: 1, attrs: [ { value: \core0.DelayBCC, width: 1 } ]}
	- { id: \core0.DelayDADDR, cond: 1, attrs: [ { value: \core0.DelayDADDR, width: 32 } ]}
	- { id: \core0.DelayJALR, cond: 1, attrs: [ { value: \core0.DelayJALR, width: 1 } ]}
	- { id: \core0.DelayLCC, cond: 1, attrs: [ { value: \core0.DelayLCC, width: 1 } ]}
	- { id: \core0.DelaySCC, cond: 1, attrs: [ { value: \core0.DelaySCC, width: 1 } ]}
	- { id: \core0.DelayXIDATA_next, cond: 1, attrs: [ { value: \core0.DelayXIDATA_next, width: 32 } ]}
	- { id: \core0.FLUSH, cond: 1, attrs: [ { value: \core0.FLUSH, width: 1 } ]}
	- { id: \core0.FLUSH_wire, cond: 1, attrs: [ { value: \core0.FLUSH_wire, width: 1 } ]}
	- { id: \core0.HLT, cond: 1, attrs: [ { value: \core0.HLT, width: 1 } ]}
	- { id: \core0.IDLE, cond: 1, attrs: [ { value: \core0.IDLE, width: 1 } ]}
	- { id: \core0.JAL, cond: 1, attrs: [ { value: \core0.JAL, width: 1 } ]}
	- { id: \core0.JALR, cond: 1, attrs: [ { value: \core0.JALR, width: 1 } ]}
	- { id: \core0.JREQ, cond: 1, attrs: [ { value: \core0.JREQ, width: 1 } ]}
	- { id: \core0.LCC, cond: 1, attrs: [ { value: \core0.LCC, width: 1 } ]}
	- { id: \core0.LUI, cond: 1, attrs: [ { value: \core0.LUI, width: 1 } ]}
	- { id: \core0.MAC, cond: 1, attrs: [ { value: \core0.MAC, width: 1 } ]}
	- { id: \core0.MCC, cond: 1, attrs: [ { value: \core0.MCC, width: 1 } ]}
	- { id: \core0.OPCODE, cond: 1, attrs: [ { value: \core0.OPCODE, width: 7 } ]}
	- { id: \core0.PC, cond: 1, attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: \core0.PC_retire, cond: 1, attrs: [ { value: \core0.PC_retire, width: 32 } ]}
	- { id: \core0.RCC, cond: 1, attrs: [ { value: \core0.RCC, width: 1 } ]}
	- { id: \core0.RD, cond: 1, attrs: [ { value: \core0.RD, width: 1 } ]}
	- { id: \core0.RES, cond: 1, attrs: [ { value: \core0.RES, width: 1 } ]}
	- { id: \core0.RESMODE, cond: 1, attrs: [ { value: \core0.RESMODE, width: 4 } ]}
	- { id: \core0.SCC, cond: 1, attrs: [ { value: \core0.SCC, width: 1 } ]}
	- { id: \core0.WR, cond: 1, attrs: [ { value: \core0.WR, width: 1 } ]}
	- { id: \core0.XIDATA_next, cond: 1, attrs: [ { value: \core0.XIDATA_next, width: 32 } ]}
	- { id: \core0.XRES, cond: 1, attrs: [ { value: \core0.XRES, width: 1 } ]}
	- { id: \core0.decode, cond: 1, attrs: [ { value: \core0.decode, width: 1 } ]}
	- { id: \core0.decode_reg, cond: 1, attrs: [ { value: \core0.decode_reg, width: 1 } ]}
	- { id: \core0.filter_pc, cond: 1, attrs: [ { value: \core0.filter_pc, width: 1 } ]}
	- { id: \core0.filter_pc_reg, cond: 1, attrs: [ { value: \core0.filter_pc_reg, width: 1 } ]}
	- { id: \core0.retire, cond: 1, attrs: [ { value: \core0.retire, width: 1 } ]}
	- { id: \core0.writeback, cond: 1, attrs: [ { value: \core0.writeback, width: 1 } ]}
	- { id: \core0.writeback_reg, cond: 1, attrs: [ { value: \core0.writeback_reg, width: 1 } ]}
	- { id: \uart0.CLK, cond: 1, attrs: [ { value: \uart0.CLK, width: 1 } ]}
	- { id: \uart0.RD, cond: 1, attrs: [ { value: \uart0.RD, width: 1 } ]}
	- { id: \uart0.RES, cond: 1, attrs: [ { value: \uart0.RES, width: 1 } ]}
	- { id: \uart0.WR, cond: 1, attrs: [ { value: \uart0.WR, width: 1 } ]}

	Time for base step: 21
	Time for induction step: 1423
	Time for generating invariant: 1445
	Time for checking: 17
The contract checked is satisfied with 61 loops

filteredSrcObservations:
######################
# seq-ct
######################
   - {id: "PCs", cond: " \\core0.filter_pc_reg ", attrs: [{value: "\\core0.PC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]}
   - {id: "LOAD", cond: "\\core0.decode_reg && \\core0.LCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a LOAD whenever we have a memory load. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO 
   - {id: "STORE", cond: "\\core0.decode_reg && \\core0.SCC", attrs: [ {value: "\\core0.DADDR", width: 32}]}  # disclose a STORE whenever we have a memory store. DADDR[12:2] is the address of the memory. DATAO is the value to be loaded, BE indicates the valid positions of DATAO  
   - {id: "\\core0.XIDATA_next", cond: "\\core0.decode_reg ", attrs: [ {value: "\\core0.XIDATA_next", width: 32}]}

	Checking the relation between target and invariant...
	The invariant for checking is:
	- { id: PCs_inv1_1, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv1_2, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: PCs_inv2_1, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv2_2, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: HLT_FLUSH_inv, cond:  \core0.HLT , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: HLT_inv, cond: \core0.decode , attrs: [ { value: \core0.HLT, width: 32 } ]}
	- { id: FLUSH_inv, cond: \core0.decode , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: LCC_ADDR, cond: \core0.LCC, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: LCC_EXECUTE1, cond:  \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2, cond:  (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3, cond:  \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: LCC_EXECUTE1_1, cond:  \core0.writeback && \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2_1, cond:  \core0.writeback && (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3_1, cond:  \core0.writeback && \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: \core0.REG1_0, cond: 1, attrs: [ { value: \core0.REG1_0, width: 32 } ]}
	- { id: \core0.REG2_0, cond: 1, attrs: [ { value: \core0.REG2_0, width: 32 } ]}
	- { id: BOARD_CK, cond: 1, attrs: [ { value: BOARD_CK, width: 8 } ]}
	- { id: BOARD_CM, cond: 1, attrs: [ { value: BOARD_CM, width: 8 } ]}
	- { id: BOARD_ID, cond: 1, attrs: [ { value: BOARD_ID, width: 8 } ]}
	- { id: CLK, cond: 1, attrs: [ { value: CLK, width: 1 } ]}
	- { id: DACK, cond: 1, attrs: [ { value: DACK, width: 1 } ]}
	- { id: DADDR, cond: 1, attrs: [ { value: DADDR, width: 32 } ]}
	- { id: DHIT, cond: 1, attrs: [ { value: DHIT, width: 1 } ]}
	- { id: HLT, cond: 1, attrs: [ { value: HLT, width: 1 } ]}
	- { id: IDLE, cond: 1, attrs: [ { value: IDLE, width: 1 } ]}
	- { id: IHIT, cond: 1, attrs: [ { value: IHIT, width: 1 } ]}
	- { id: IHITACK, cond: 1, attrs: [ { value: IHITACK, width: 1 } ]}
	- { id: IRES, cond: 1, attrs: [ { value: IRES, width: 8 } ]}
	- { id: KDEBUG, cond: 1, attrs: [ { value: KDEBUG, width: 4 } ]}
	- { id: RD, cond: 1, attrs: [ { value: RD, width: 1 } ]}
	- { id: RES, cond: 1, attrs: [ { value: RES, width: 1 } ]}
	- { id: WHIT, cond: 1, attrs: [ { value: WHIT, width: 1 } ]}
	- { id: WR, cond: 1, attrs: [ { value: WR, width: 1 } ]}
	- { id: XADDR, cond: 1, attrs: [ { value: XADDR, width: 32 } ]}
	- { id: XCLK, cond: 1, attrs: [ { value: XCLK, width: 1 } ]}
	- { id: XRES, cond: 1, attrs: [ { value: XRES, width: 1 } ]}
	- { id: \core0.ALL0, cond: 1, attrs: [ { value: \core0.ALL0, width: 32 } ]}
	- { id: \core0.ALL1, cond: 1, attrs: [ { value: \core0.ALL1, width: 32 } ]}
	- { id: \core0.AUIPC, cond: 1, attrs: [ { value: \core0.AUIPC, width: 1 } ]}
	- { id: \core0.BCC, cond: 1, attrs: [ { value: \core0.BCC, width: 1 } ]}
	- { id: \core0.CDATA, cond: 1, attrs: [ { value: \core0.CDATA, width: 32 } ]}
	- { id: \core0.CLK, cond: 1, attrs: [ { value: \core0.CLK, width: 1 } ]}
	- { id: \core0.DADDR, cond: 1, attrs: [ { value: \core0.DADDR, width: 32 } ]}
	- { id: \core0.DEBUG, cond: 1, attrs: [ { value: \core0.DEBUG, width: 4 } ]}
	- { id: \core0.DelayBCC, cond: 1, attrs: [ { value: \core0.DelayBCC, width: 1 } ]}
	- { id: \core0.DelayDADDR, cond: 1, attrs: [ { value: \core0.DelayDADDR, width: 32 } ]}
	- { id: \core0.DelayJALR, cond: 1, attrs: [ { value: \core0.DelayJALR, width: 1 } ]}
	- { id: \core0.DelayLCC, cond: 1, attrs: [ { value: \core0.DelayLCC, width: 1 } ]}
	- { id: \core0.DelaySCC, cond: 1, attrs: [ { value: \core0.DelaySCC, width: 1 } ]}
	- { id: \core0.DelayXIDATA_next, cond: 1, attrs: [ { value: \core0.DelayXIDATA_next, width: 32 } ]}
	- { id: \core0.FLUSH, cond: 1, attrs: [ { value: \core0.FLUSH, width: 1 } ]}
	- { id: \core0.HLT, cond: 1, attrs: [ { value: \core0.HLT, width: 1 } ]}
	- { id: \core0.IDLE, cond: 1, attrs: [ { value: \core0.IDLE, width: 1 } ]}
	- { id: \core0.JAL, cond: 1, attrs: [ { value: \core0.JAL, width: 1 } ]}
	- { id: \core0.JALR, cond: 1, attrs: [ { value: \core0.JALR, width: 1 } ]}
	- { id: \core0.LCC, cond: 1, attrs: [ { value: \core0.LCC, width: 1 } ]}
	- { id: \core0.LUI, cond: 1, attrs: [ { value: \core0.LUI, width: 1 } ]}
	- { id: \core0.MAC, cond: 1, attrs: [ { value: \core0.MAC, width: 1 } ]}
	- { id: \core0.MCC, cond: 1, attrs: [ { value: \core0.MCC, width: 1 } ]}
	- { id: \core0.OPCODE, cond: 1, attrs: [ { value: \core0.OPCODE, width: 7 } ]}
	- { id: \core0.PC, cond: 1, attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: \core0.PC_retire, cond: 1, attrs: [ { value: \core0.PC_retire, width: 32 } ]}
	- { id: \core0.RCC, cond: 1, attrs: [ { value: \core0.RCC, width: 1 } ]}
	- { id: \core0.RD, cond: 1, attrs: [ { value: \core0.RD, width: 1 } ]}
	- { id: \core0.RES, cond: 1, attrs: [ { value: \core0.RES, width: 1 } ]}
	- { id: \core0.RESMODE, cond: 1, attrs: [ { value: \core0.RESMODE, width: 4 } ]}
	- { id: \core0.SCC, cond: 1, attrs: [ { value: \core0.SCC, width: 1 } ]}
	- { id: \core0.WR, cond: 1, attrs: [ { value: \core0.WR, width: 1 } ]}
	- { id: \core0.XIDATA_next, cond: 1, attrs: [ { value: \core0.XIDATA_next, width: 32 } ]}
	- { id: \core0.XRES, cond: 1, attrs: [ { value: \core0.XRES, width: 1 } ]}
	- { id: \core0.decode, cond: 1, attrs: [ { value: \core0.decode, width: 1 } ]}
	- { id: \core0.decode_reg, cond: 1, attrs: [ { value: \core0.decode_reg, width: 1 } ]}
	- { id: \core0.filter_pc, cond: 1, attrs: [ { value: \core0.filter_pc, width: 1 } ]}
	- { id: \core0.filter_pc_reg, cond: 1, attrs: [ { value: \core0.filter_pc_reg, width: 1 } ]}
	- { id: \core0.retire, cond: 1, attrs: [ { value: \core0.retire, width: 1 } ]}
	- { id: \core0.writeback, cond: 1, attrs: [ { value: \core0.writeback, width: 1 } ]}
	- { id: \core0.writeback_reg, cond: 1, attrs: [ { value: \core0.writeback_reg, width: 1 } ]}
	- { id: \uart0.CLK, cond: 1, attrs: [ { value: \uart0.CLK, width: 1 } ]}
	- { id: \uart0.RD, cond: 1, attrs: [ { value: \uart0.RD, width: 1 } ]}
	- { id: \uart0.RES, cond: 1, attrs: [ { value: \uart0.RES, width: 1 } ]}
	- { id: \uart0.WR, cond: 1, attrs: [ { value: \uart0.WR, width: 1 } ]}

	Time for base step: 21
	Time for induction step: 1558
	Time for generating invariant: 1579
	Time for checking: 17
The contract checked is satisfied with 66 loops


filteredSrcObservations:
######################
# seq-pc with jump instruction
######################
   - {id: "PCs", cond: " \\core0.filter_pc_reg ", attrs: [{value: "\\core0.PC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]}
   - {id: "BCC", cond: "\\core0.decode_reg && \\core0.BCC", attrs: [ {value: "\\core0.U1REG", width: 32},{value: "\\core0.U2REG", width: 32}]}
   - {id: "JALR", cond: "\\core0.decode_reg && \\core0.JALR", attrs: [ {value: "\\core0.U1REG", width: 32}]}
   - {id: "\\core0.XIDATA_next", cond: "\\core0.decode_reg ", attrs: [ {value: "\\core0.XIDATA_next", width: 32}]}

	Checking the relation between target and invariant...
	The invariant for checking is:
	- { id: PCs_inv1_1, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv1_2, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: PCs_inv2_1, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv2_2, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: HLT_FLUSH_inv, cond:  \core0.HLT , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: HLT_inv, cond: \core0.decode , attrs: [ { value: \core0.HLT, width: 32 } ]}
	- { id: FLUSH_inv, cond: \core0.decode , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: BCC_EXECUTE, cond: \core0.BCC, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: JALR_EXECUTE, cond: \core0.JALR, attrs: [ { value: \core0.U1REG, width: 32 } ]}
	- { id: LCC_EXECUTE1, cond:  \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2, cond:  (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3, cond:  \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: LCC_EXECUTE1_1, cond:  \core0.writeback && \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2_1, cond:  \core0.writeback && (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3_1, cond:  \core0.writeback && \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: \core0.REG1_0, cond: 1, attrs: [ { value: \core0.REG1_0, width: 32 } ]}
	- { id: \core0.REG2_0, cond: 1, attrs: [ { value: \core0.REG2_0, width: 32 } ]}
	- { id: BOARD_CK, cond: 1, attrs: [ { value: BOARD_CK, width: 8 } ]}
	- { id: BOARD_CM, cond: 1, attrs: [ { value: BOARD_CM, width: 8 } ]}
	- { id: BOARD_ID, cond: 1, attrs: [ { value: BOARD_ID, width: 8 } ]}
	- { id: CLK, cond: 1, attrs: [ { value: CLK, width: 1 } ]}
	- { id: DACK, cond: 1, attrs: [ { value: DACK, width: 1 } ]}
	- { id: DHIT, cond: 1, attrs: [ { value: DHIT, width: 1 } ]}
	- { id: HLT, cond: 1, attrs: [ { value: HLT, width: 1 } ]}
	- { id: IDLE, cond: 1, attrs: [ { value: IDLE, width: 1 } ]}
	- { id: IHIT, cond: 1, attrs: [ { value: IHIT, width: 1 } ]}
	- { id: IHITACK, cond: 1, attrs: [ { value: IHITACK, width: 1 } ]}
	- { id: IRES, cond: 1, attrs: [ { value: IRES, width: 8 } ]}
	- { id: KDEBUG, cond: 1, attrs: [ { value: KDEBUG, width: 4 } ]}
	- { id: RD, cond: 1, attrs: [ { value: RD, width: 1 } ]}
	- { id: RES, cond: 1, attrs: [ { value: RES, width: 1 } ]}
	- { id: WHIT, cond: 1, attrs: [ { value: WHIT, width: 1 } ]}
	- { id: WR, cond: 1, attrs: [ { value: WR, width: 1 } ]}
	- { id: XCLK, cond: 1, attrs: [ { value: XCLK, width: 1 } ]}
	- { id: XRES, cond: 1, attrs: [ { value: XRES, width: 1 } ]}
	- { id: \core0.ALL0, cond: 1, attrs: [ { value: \core0.ALL0, width: 32 } ]}
	- { id: \core0.ALL1, cond: 1, attrs: [ { value: \core0.ALL1, width: 32 } ]}
	- { id: \core0.AUIPC, cond: 1, attrs: [ { value: \core0.AUIPC, width: 1 } ]}
	- { id: \core0.BCC, cond: 1, attrs: [ { value: \core0.BCC, width: 1 } ]}
	- { id: \core0.BMUX, cond: 1, attrs: [ { value: \core0.BMUX, width: 1 } ]}
	- { id: \core0.CDATA, cond: 1, attrs: [ { value: \core0.CDATA, width: 32 } ]}
	- { id: \core0.CLK, cond: 1, attrs: [ { value: \core0.CLK, width: 1 } ]}
	- { id: \core0.DEBUG, cond: 1, attrs: [ { value: \core0.DEBUG, width: 4 } ]}
	- { id: \core0.DelayBCC, cond: 1, attrs: [ { value: \core0.DelayBCC, width: 1 } ]}
	- { id: \core0.DelayJALR, cond: 1, attrs: [ { value: \core0.DelayJALR, width: 1 } ]}
	- { id: \core0.DelayLCC, cond: 1, attrs: [ { value: \core0.DelayLCC, width: 1 } ]}
	- { id: \core0.DelaySCC, cond: 1, attrs: [ { value: \core0.DelaySCC, width: 1 } ]}
	- { id: \core0.DelayXIDATA_next, cond: 1, attrs: [ { value: \core0.DelayXIDATA_next, width: 32 } ]}
	- { id: \core0.FLUSH, cond: 1, attrs: [ { value: \core0.FLUSH, width: 1 } ]}
	- { id: \core0.FLUSH_wire, cond: 1, attrs: [ { value: \core0.FLUSH_wire, width: 1 } ]}
	- { id: \core0.HLT, cond: 1, attrs: [ { value: \core0.HLT, width: 1 } ]}
	- { id: \core0.IDLE, cond: 1, attrs: [ { value: \core0.IDLE, width: 1 } ]}
	- { id: \core0.JAL, cond: 1, attrs: [ { value: \core0.JAL, width: 1 } ]}
	- { id: \core0.JALR, cond: 1, attrs: [ { value: \core0.JALR, width: 1 } ]}
	- { id: \core0.JREQ, cond: 1, attrs: [ { value: \core0.JREQ, width: 1 } ]}
	- { id: \core0.LCC, cond: 1, attrs: [ { value: \core0.LCC, width: 1 } ]}
	- { id: \core0.LUI, cond: 1, attrs: [ { value: \core0.LUI, width: 1 } ]}
	- { id: \core0.MAC, cond: 1, attrs: [ { value: \core0.MAC, width: 1 } ]}
	- { id: \core0.MCC, cond: 1, attrs: [ { value: \core0.MCC, width: 1 } ]}
	- { id: \core0.OPCODE, cond: 1, attrs: [ { value: \core0.OPCODE, width: 7 } ]}
	- { id: \core0.PC, cond: 1, attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: \core0.PC_retire, cond: 1, attrs: [ { value: \core0.PC_retire, width: 32 } ]}
	- { id: \core0.RCC, cond: 1, attrs: [ { value: \core0.RCC, width: 1 } ]}
	- { id: \core0.RD, cond: 1, attrs: [ { value: \core0.RD, width: 1 } ]}
	- { id: \core0.RES, cond: 1, attrs: [ { value: \core0.RES, width: 1 } ]}
	- { id: \core0.RESMODE, cond: 1, attrs: [ { value: \core0.RESMODE, width: 4 } ]}
	- { id: \core0.SCC, cond: 1, attrs: [ { value: \core0.SCC, width: 1 } ]}
	- { id: \core0.WR, cond: 1, attrs: [ { value: \core0.WR, width: 1 } ]}
	- { id: \core0.XIDATA_next, cond: 1, attrs: [ { value: \core0.XIDATA_next, width: 32 } ]}
	- { id: \core0.XRES, cond: 1, attrs: [ { value: \core0.XRES, width: 1 } ]}
	- { id: \core0.decode, cond: 1, attrs: [ { value: \core0.decode, width: 1 } ]}
	- { id: \core0.decode_reg, cond: 1, attrs: [ { value: \core0.decode_reg, width: 1 } ]}
	- { id: \core0.filter_pc, cond: 1, attrs: [ { value: \core0.filter_pc, width: 1 } ]}
	- { id: \core0.filter_pc_reg, cond: 1, attrs: [ { value: \core0.filter_pc_reg, width: 1 } ]}
	- { id: \core0.retire, cond: 1, attrs: [ { value: \core0.retire, width: 1 } ]}
	- { id: \core0.writeback, cond: 1, attrs: [ { value: \core0.writeback, width: 1 } ]}
	- { id: \core0.writeback_reg, cond: 1, attrs: [ { value: \core0.writeback_reg, width: 1 } ]}
	- { id: \uart0.CLK, cond: 1, attrs: [ { value: \uart0.CLK, width: 1 } ]}
	- { id: \uart0.RES, cond: 1, attrs: [ { value: \uart0.RES, width: 1 } ]}

	Time for base step: 21
	Time for induction step: 1594
	Time for generating invariant: 1616
	Time for checking: 17
The contract checked is satisfied with 68 loops

filteredSrcObservations:
######################
# seq-pc 
######################
   - {id: "PCs", cond: " \\core0.filter_pc_reg ", attrs: [{value: "\\core0.PC", width: 32}]} #,{value: "\\core0.NXPC", width: 32}]}
   - {id: "\\core0.XIDATA_next", cond: "\\core0.decode_reg ", attrs: [ {value: "\\core0.XIDATA_next", width: 32}]}


	Checking the relation between target and invariant...
	The invariant for checking is:
	- { id: PCs_inv1_1, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv1_2, cond:  ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: PCs_inv2_1, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: PCs_inv2_2, cond:  \core0.decode_reg && ! \core0.FLUSH , attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: HLT_FLUSH_inv, cond:  \core0.HLT , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: HLT_inv, cond: \core0.decode , attrs: [ { value: \core0.HLT, width: 32 } ]}
	- { id: FLUSH_inv, cond: \core0.decode , attrs: [ { value: \core0.FLUSH, width: 32 } ]}
	- { id: LCC_EXECUTE1, cond:  \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2, cond:  (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3, cond:  \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: LCC_EXECUTE1_1, cond:  \core0.writeback && \core0.AUIPC , attrs: [ { value: \core0.PCSIMM, width: 32 } ]}
	- { id: LCC_EXECUTE2_1, cond:  \core0.writeback && (\core0.JAL || \core0.JALR ), attrs: [ { value: \core0.NXPC, width: 32 } ]}
	- { id: LCC_EXECUTE3_1, cond:  \core0.writeback && \core0.LUI , attrs: [ { value: \core0.SIMM, width: 32 } ]}
	- { id: \core0.REG1_0, cond: 1, attrs: [ { value: \core0.REG1_0, width: 32 } ]}
	- { id: \core0.REG2_0, cond: 1, attrs: [ { value: \core0.REG2_0, width: 32 } ]}
	- { id: BOARD_CK, cond: 1, attrs: [ { value: BOARD_CK, width: 8 } ]}
	- { id: BOARD_CM, cond: 1, attrs: [ { value: BOARD_CM, width: 8 } ]}
	- { id: BOARD_ID, cond: 1, attrs: [ { value: BOARD_ID, width: 8 } ]}
	- { id: CLK, cond: 1, attrs: [ { value: CLK, width: 1 } ]}
	- { id: DACK, cond: 1, attrs: [ { value: DACK, width: 1 } ]}
	- { id: DHIT, cond: 1, attrs: [ { value: DHIT, width: 1 } ]}
	- { id: HLT, cond: 1, attrs: [ { value: HLT, width: 1 } ]}
	- { id: IDLE, cond: 1, attrs: [ { value: IDLE, width: 1 } ]}
	- { id: IHIT, cond: 1, attrs: [ { value: IHIT, width: 1 } ]}
	- { id: IHITACK, cond: 1, attrs: [ { value: IHITACK, width: 1 } ]}
	- { id: IRES, cond: 1, attrs: [ { value: IRES, width: 8 } ]}
	- { id: KDEBUG, cond: 1, attrs: [ { value: KDEBUG, width: 4 } ]}
	- { id: RD, cond: 1, attrs: [ { value: RD, width: 1 } ]}
	- { id: RES, cond: 1, attrs: [ { value: RES, width: 1 } ]}
	- { id: WHIT, cond: 1, attrs: [ { value: WHIT, width: 1 } ]}
	- { id: WR, cond: 1, attrs: [ { value: WR, width: 1 } ]}
	- { id: XCLK, cond: 1, attrs: [ { value: XCLK, width: 1 } ]}
	- { id: XRES, cond: 1, attrs: [ { value: XRES, width: 1 } ]}
	- { id: \core0.ALL0, cond: 1, attrs: [ { value: \core0.ALL0, width: 32 } ]}
	- { id: \core0.ALL1, cond: 1, attrs: [ { value: \core0.ALL1, width: 32 } ]}
	- { id: \core0.AUIPC, cond: 1, attrs: [ { value: \core0.AUIPC, width: 1 } ]}
	- { id: \core0.BCC, cond: 1, attrs: [ { value: \core0.BCC, width: 1 } ]}
	- { id: \core0.CDATA, cond: 1, attrs: [ { value: \core0.CDATA, width: 32 } ]}
	- { id: \core0.CLK, cond: 1, attrs: [ { value: \core0.CLK, width: 1 } ]}
	- { id: \core0.DEBUG, cond: 1, attrs: [ { value: \core0.DEBUG, width: 4 } ]}
	- { id: \core0.DelayBCC, cond: 1, attrs: [ { value: \core0.DelayBCC, width: 1 } ]}
	- { id: \core0.DelayJALR, cond: 1, attrs: [ { value: \core0.DelayJALR, width: 1 } ]}
	- { id: \core0.DelayLCC, cond: 1, attrs: [ { value: \core0.DelayLCC, width: 1 } ]}
	- { id: \core0.DelaySCC, cond: 1, attrs: [ { value: \core0.DelaySCC, width: 1 } ]}
	- { id: \core0.DelayXIDATA_next, cond: 1, attrs: [ { value: \core0.DelayXIDATA_next, width: 32 } ]}
	- { id: \core0.FLUSH, cond: 1, attrs: [ { value: \core0.FLUSH, width: 1 } ]}
	- { id: \core0.HLT, cond: 1, attrs: [ { value: \core0.HLT, width: 1 } ]}
	- { id: \core0.IDLE, cond: 1, attrs: [ { value: \core0.IDLE, width: 1 } ]}
	- { id: \core0.JAL, cond: 1, attrs: [ { value: \core0.JAL, width: 1 } ]}
	- { id: \core0.JALR, cond: 1, attrs: [ { value: \core0.JALR, width: 1 } ]}
	- { id: \core0.LCC, cond: 1, attrs: [ { value: \core0.LCC, width: 1 } ]}
	- { id: \core0.LUI, cond: 1, attrs: [ { value: \core0.LUI, width: 1 } ]}
	- { id: \core0.MAC, cond: 1, attrs: [ { value: \core0.MAC, width: 1 } ]}
	- { id: \core0.MCC, cond: 1, attrs: [ { value: \core0.MCC, width: 1 } ]}
	- { id: \core0.OPCODE, cond: 1, attrs: [ { value: \core0.OPCODE, width: 7 } ]}
	- { id: \core0.PC, cond: 1, attrs: [ { value: \core0.PC, width: 32 } ]}
	- { id: \core0.PC_retire, cond: 1, attrs: [ { value: \core0.PC_retire, width: 32 } ]}
	- { id: \core0.RCC, cond: 1, attrs: [ { value: \core0.RCC, width: 1 } ]}
	- { id: \core0.RD, cond: 1, attrs: [ { value: \core0.RD, width: 1 } ]}
	- { id: \core0.RES, cond: 1, attrs: [ { value: \core0.RES, width: 1 } ]}
	- { id: \core0.RESMODE, cond: 1, attrs: [ { value: \core0.RESMODE, width: 4 } ]}
	- { id: \core0.SCC, cond: 1, attrs: [ { value: \core0.SCC, width: 1 } ]}
	- { id: \core0.WR, cond: 1, attrs: [ { value: \core0.WR, width: 1 } ]}
	- { id: \core0.XIDATA_next, cond: 1, attrs: [ { value: \core0.XIDATA_next, width: 32 } ]}
	- { id: \core0.XRES, cond: 1, attrs: [ { value: \core0.XRES, width: 1 } ]}
	- { id: \core0.decode, cond: 1, attrs: [ { value: \core0.decode, width: 1 } ]}
	- { id: \core0.decode_reg, cond: 1, attrs: [ { value: \core0.decode_reg, width: 1 } ]}
	- { id: \core0.filter_pc, cond: 1, attrs: [ { value: \core0.filter_pc, width: 1 } ]}
	- { id: \core0.filter_pc_reg, cond: 1, attrs: [ { value: \core0.filter_pc_reg, width: 1 } ]}
	- { id: \core0.retire, cond: 1, attrs: [ { value: \core0.retire, width: 1 } ]}
	- { id: \core0.writeback, cond: 1, attrs: [ { value: \core0.writeback, width: 1 } ]}
	- { id: \core0.writeback_reg, cond: 1, attrs: [ { value: \core0.writeback_reg, width: 1 } ]}
	- { id: \uart0.CLK, cond: 1, attrs: [ { value: \uart0.CLK, width: 1 } ]}
	- { id: \uart0.RES, cond: 1, attrs: [ { value: \uart0.RES, width: 1 } ]}

	Time for base step: 21
	Time for induction step: 1682
	Time for generating invariant: 1704
	Time for checking: 17
The contract checked is satisfied with  72 loops

