
CTR:
  # disclose whenever we are executing an ADD
  - {id: "ADD", cond: "retire && op == 8'h01", attrs: []} 
  # disclose whenever we are executing a MUL + disclosing the value of the register (before MUL)
  - {id: "MUL", cond: "retire && op == 8'h02", attrs: [ {value: "Imem[pc][31:8]", width: 24} ] } # disclose MUL operand whenever we are executing a MUL


ATK: 
 # attacker observes when the pipeline is ready to execute the next instruction
  - {id: "ready", cond: "ready", attrs: [] } 

Suppose these pipeline invariants are given: (e,\phi,e';\phi')
  # For the first contract observation: we map the instruction type ADD (op == 8'h01) to the content of ex_op == 8'h01 earlier on
  - ("op == 8'h01", "retire", "ex_op == 8'h01", "decode_reg")
  # For the 2nd contract observation: we map the "op == 8'h02? Imem[pc_r][31:8]:0x0000" to "instr[7:0] == 8'h02? instr[31:8]:0x0000"
  - ("op == 8'h02? instr_r[31:8]:0x0000", "retire", "ex_op == 8'h02? ex_imm:0x0000", " decode_reg")



Using these pipeline invariants, we can rewrite the contract as follows:
CTR'
 - {id: "ADD", cond: "decode_reg && ex_op == 8'h01", attrs: []}
 - {id: "MUL", cond: "decode_reg && ex_op == 8'h02", attrs: [ {value: "ex_imm", width: 24} ] } 


### Predicates
# Retire predicates 
predicateRetire:
 - {id: "Retire", cond: "1", attrs: [{value: "retire", width: 1}]}

# Pipeline predicates to be checked
predicatePI:
 - {id: "DECODE", cond: "1", attrs: [{value: "decode", width: 1}]}



########################################################## verify the correctness of PI ##########################################################

TODO

########################################################## result of verification ##########################################################

invariant: 
 - {id: "MUL_EXECUTE", cond: "ex_op == 8'h02", attrs: [{value: "ex_imm", width: 24}]}

stateinvariant: []

	Checking the relation between target and invariant...
	The invariant for checking is:
	- { id: MUL_EXECUTE, cond: ex_op == 8'h02, attrs: [ { value: ex_imm, width: 24 } ]}
	- { id: clk, cond: 1, attrs: [ { value: clk, width: 1 } ]}
	- { id: decode, cond: 1, attrs: [ { value: decode, width: 1 } ]}
	- { id: decode_reg, cond: 1, attrs: [ { value: decode_reg, width: 1 } ]}
	- { id: mul_imm, cond: 1, attrs: [ { value: mul_imm, width: 24 } ]}
	- { id: mult, cond: 1, attrs: [ { value: mult, width: 1 } ]}
	- { id: nxpc, cond: 1, attrs: [ { value: nxpc, width: 32 } ]}
	- { id: nxpc2, cond: 1, attrs: [ { value: nxpc2, width: 32 } ]}
	- { id: nxpc3, cond: 1, attrs: [ { value: nxpc3, width: 1 } ]}
	- { id: pc, cond: 1, attrs: [ { value: pc, width: 32 } ]}
	- { id: ready, cond: 1, attrs: [ { value: ready, width: 1 } ]}
	- { id: retire, cond: 1, attrs: [ { value: retire, width: 1 } ]}
	- { id: wb_we, cond: 1, attrs: [ { value: wb_we, width: 1 } ]}

	Time for base step: 0
	Time for inductive step: 3

	Time for preprocessing: 1
	Time for learning the strongest attacker: 4
The contract checked is satisfied with 10 loops and 13 invariants

