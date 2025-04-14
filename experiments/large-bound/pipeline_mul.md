####### Pipeline_mul
### Source
srcObservations: 
 - {id: "ADD", cond: "(op == 8'h01)", attrs: []} # disclose whenever we are executing an ADD
 - {id: "MUL", cond: "(op == 8'h02)", attrs: [ {value: "imm", width: 24} ] } # disclose MUL operand whenever we are executing a MUL


### TARGET
trgObservations: 
  - {id: "ready", cond: "ready", attrs: [] } 


### STATEINVARIANT
stateInvariant: []

### INVARIANT
invariant: 
 - {id: "MUL_EXECUTE", cond: "ex_op == 8'h02", attrs: [{value: "ex_imm", width: 24}]}


Firstly, we constrain the size of mul_imm by mod it with 4.

* cycleDelayed: "5"
result:
	The contract checked is not satisfied after 19 loops!
	Time for preprocessing: 1
	Time for learning the strongest attacker: 10

* cycleDelayed: "6"
result:
	The contract checked is satisfied after 11 loops!
	Time for preprocessing: 1
	Time for learning the strongest attacker: 6
  
  