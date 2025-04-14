import json
from util import *
from config import CONF
import os


path = "contractgen/"
attrs_width_dict = {"funct3":"3","funct7":"7","imm":"32","is_aligned":"1","is_half_aligned":"1","mem_addr":"32","mem_r_data":"32","opcode":"7",
"rd":"5","reg_rd":"32","reg_rs1":"32","rs1":"5","format":"3","mem_w_data":"32","reg_rs2":"32","rs2":"5","is_branch":"1","new_pc":"32","branch_taken":"1", 
"reg_rs1_zero":"1","reg_rs2_zero":"1","reg_rs1_log2":"32","reg_rs2_log2":"32","reg_rd_zero":"1","reg_rd_log2":"32",
"raw_rs1_2":"1","raw_rs2_2":"1","waw_2":"1","raw_rs1_3":"1","raw_rs2_3":"1","waw_3":"1","raw_rs1_4":"1",
"raw_rs2_4":"1","waw_4":"1","raw_rs1_1":"1","raw_rs2_1":"1","waw_1":"1",} 


def json2contract(contract_file):
    current_contract = []
    with open(contract_file , 'r') as f:
        ctr = f.read()
    json_dict = json.loads(ctr)
    contract_dict = json_dict["current_contract"]
    print("contract_dict:", contract_dict)

    attrs_dict = {}

    sizeOfContract = len(contract_dict)
    
    for atoms in contract_dict:
        if atoms["observation"] not in attrs_dict.keys():
            attrs_dict[atoms["observation"]] = atoms["type"].lower()
        else: 
            attrs_dict[atoms["observation"]] = attrs_dict[atoms["observation"]] + "&&" + (atoms["type"].lower())
    print("attrs_dict:", attrs_dict)

    current_contract = []
    for attr in attrs_dict.keys():
        id = attr.lower() + "_ctr"
        cond = " || ".join( ["{}.rvfi_{}_ctr".format(CONF.rvfiModule, types) for types in attrs_dict[attr].split("&&") ] )
        value = "{}.".format(CONF.rvfiModule) + attr.lower()
        # width = ""
        if attr.lower() not in attrs_width_dict.keys():
            print(f"Cannot get the width of {attr}")
            exit(1)
        else: 
            width = attrs_width_dict[attr.lower()]
        current_contract.append({"id": id, "cond": cond, "attrs": [ {"value": value, "width": int(width)} ]})
    print("current_contract:", current_contract)

    return current_contract, sizeOfContract

def contractgen (init, counter):
    contract_file = ""
    if init == "init": # generate initial contract
        testcase = CONF.testcase
        processor = CONF.processor
        threads = CONF.threads
        folder = CONF.outFolder
        logtimefile(f"Generating the initial contract with {testcase} test cases!!\n\n")
        logfile(f"Generating the initial contract with {testcase} test cases!!\n\n")
        # print("testcase:",testcase)
        # exit(1)
        cmd = ["java"]
        cmd.append("-jar")
        cmd.append(f"{path}target/contractgen-1.0-SNAPSHOT.jar")
        cmd.append("synthesize")
        cmd.append("-c")
        cmd.append(CONF.ctr_families)
        if (processor == "SODOR_2") or (processor == "DARKRISCV_2") or (processor == "DARKRISCV_3") or (processor == "SODOR_5"):
            cmd.append("-iBASE")
        else:
            cmd.append("-iBASE,M")
        cmd.append(f"-p{processor}")
        cmd.append("-s123456789")
        cmd.append(f"-t{threads}")
        cmd.append(f"-n{testcase}")
        cmd.append(f"-o")
        # cmd.append(f"CTR/current_ctr_{str(counter)}.json")
        cmd.append(f"{folder}/CTR/current_ctr.json")
        cmd.append(f"--txt")
        cmd.append(f"{folder}/CTR/current_ctr_{str(counter)}.txt")
        run_process(cmd, CONF.verbose_verification)
        run_process(["cp", f"{folder}/CTR/current_ctr.json", f"{folder}/CTR/current_ctr_init.json"])

        
    else:
        folder = CONF.outFolder
        processor = CONF.processor
        # 1. analyze the counterexample
        # java -jar target/contractgen-1.0-SNAPSHOT.jar analyze -c BASE,ALIGNED,BRANCH,VALUE -f=src/main/resources/prod_trace.vcd -o ctx.json
        cmd = ["java"]
        cmd.append("-jar")
        cmd.append(f"{path}target/contractgen-1.0-SNAPSHOT.jar")
        cmd.append("analyze")
        cmd.append(f"-p{processor}")
        cmd.append("-c")
        cmd.append(CONF.ctr_families)
        cmd.append(f"-f={folder}/temp/prod_trace.vcd")
        cmd.append(f"-o")
        cmd.append(f"{folder}/CTR/ctr_{str(counter)}.json")
        run_process(cmd, CONF.verbose_verification)
        
        # 2. update the current contract
        # java -jar target/contractgen-1.0-SNAPSHOT.jar update -c current_ctr.json -r ctx.json -o current_ctr.json --txt current_ctr.txt
        cmd = ["java"]
        cmd.append("-jar")
        cmd.append(f"{path}target/contractgen-1.0-SNAPSHOT.jar")
        cmd.append("update")
        cmd.append(f"-c")
        # cmd.append(f"CTR/current_ctr_{str(counter-1)}.json")
        cmd.append(f"{folder}/CTR/current_ctr.json")
        cmd.append(f"-r")
        cmd.append(f"{folder}/CTR/ctr_{str(counter)}.json")
        cmd.append(f"-o")
        # cmd.append(f"CTR/current_ctr_{str(counter)}.json")
        cmd.append(f"{folder}/CTR/current_ctr.json")
        cmd.append(f"--txt")
        cmd.append(f"{folder}/CTR/current_ctr_{str(counter)}.txt")
        run_process(cmd, CONF.verbose_verification)

        run_process(["cp", f"{folder}/temp/prod_trace.vcd", f"{folder}/CTR/prod_trace_{str(counter)}.vcd"], CONF.verbose_preprocessing)
    # if counter == 4:
    #     exit(1)
    current_contract, sizeOfContract = json2contract(f"{folder}/CTR/current_ctr.json")

    return current_contract, sizeOfContract

def compilecontractgen():
    cmd = ["mvn"]
    cmd.append("-f")
    cmd.append(f"{path}pom.xml")
    cmd.append("package")
    run_process(cmd, CONF.verbose_verification)

def contracteva(csr):
    evalFolder = CONF.evalFolder
    threads = CONF.threads
    processor = CONF.processor
    if ( not (os.path.exists(f"{evalFolder}/2M-TC-{processor}-{CONF.ctr_families}.json") ) ):
        run_process(["mkdir", evalFolder], CONF.verbose_preprocessing)
        # java -jar contractgen/target/contractgen-1.0-SNAPSHOT.jar synthesize -cBASE,ALIGNED,BRANCH,VALUE -iBASE,M -pIBEX -s987654321 -t64 -n2000000 -o CONF.evaTCs/2M-TC.json
        cmd = ["java"]
        cmd.append("-jar")
        cmd.append(f"{path}target/contractgen-1.0-SNAPSHOT.jar")
        cmd.append("synthesize")
        cmd.append("-c")
        if (processor == "SODOR_5"):
            cmd.append("BASE,ALIGNED,BRANCH,VALUE,DEPENDENCIES")
        else:
            cmd.append(CONF.ctr_families)
        cmd.append("-i")
        if (processor == "SODOR_2") or (processor == "DARKRISCV_2") or (processor == "DARKRISCV_3") or (processor == "SODOR_5"):
            cmd.append("BASE")
        else:
            cmd.append("BASE,M")
        cmd.append("-p")
        cmd.append(f"{processor}")
        cmd.append("-s")
        cmd.append("987654321")
        cmd.append("-t")
        cmd.append(f"{threads}")
        cmd.append("-n")
        # cmd.append("2000000")
        cmd.append(CONF.evaTCs)
        cmd.append("-o")
        cmd.append(f"{evalFolder}/2M-TC-{processor}-{CONF.ctr_families}.json")
        run_process(cmd, CONF.verbose_verification)


    if csr == "evaluate":
        folder = CONF.outFolder
        run_process(["mkdir", f"{folder}/CTR/eva-init"], CONF.verbose_preprocessing)
        # java -jar contractgen/target/contractgen-1.0-SNAPSHOT.jar evaluate -c CTR/current_ctr_init.json -e CONF.evaTCs/2M-TC.json -o CTR/eva-init
        cmd = ["java"]
        cmd.append("-jar")
        cmd.append(f"{path}target/contractgen-1.0-SNAPSHOT.jar")
        cmd.append("evaluate")
        cmd.append("-c")
        cmd.append(f"{folder}/CTR/current_ctr_init.json")
        cmd.append("-e")
        cmd.append(f"{evalFolder}/2M-TC-{processor}-{CONF.ctr_families}.json")
        cmd.append(f"-o")
        cmd.append(f"{folder}/CTR/eva-init")
        run_process(cmd, CONF.verbose_verification)
        # java -jar contractgen/target/contractgen-1.0-SNAPSHOT.jar evaluate -c testOut/CTR/current_ctr.json -e CONF.evaTCs/2M-TC-IBEX.json -o testOut/CTR/eva-ccs23
        run_process(["mkdir", f"{folder}/CTR/eva-final"], CONF.verbose_preprocessing)
        cmd1 = ["java"]
        cmd1.append("-jar")
        cmd1.append(f"{path}target/contractgen-1.0-SNAPSHOT.jar")
        cmd1.append("evaluate")
        cmd1.append("-c")
        cmd1.append(f"{folder}/CTR/current_ctr.json")
        cmd1.append("-e")
        cmd1.append(f"{evalFolder}/2M-TC-{processor}-{CONF.ctr_families}.json")
        cmd1.append(f"-o")
        cmd1.append(f"{folder}/CTR/eva-final")
        run_process(cmd1, CONF.verbose_verification)
