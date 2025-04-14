import os
from config import CONF
import re
from datetime import datetime 
from util import *


## Variables (TODO MG: Move to config)
ctr = 0

def log(msg):
    global ctr
    if CONF.verbose_preprocessing:
        print(f">>> Counterexample {ctr}) {msg}")
        ctr += 1

def compileWithIVerilog(file,outFolder):
    cmd = [CONF.iverilogPath]
    cmd.append("-gno-assertions")
    cmd.append("-g2005-sv")
    cmd.append("-o{}/{}".format(outFolder, CONF.prodCircuitTemplate.replace(".v","")))
    cmd.append(f"-I{outFolder}")
    cmd.append(f"-y{outFolder}")
    cmd.append(file)
    output = run_process(cmd, CONF.verbose_counterexample_checking)
    if "error" in output:
        print("Errors during counterexample compilation!")
        exit(1)
    return "{}/{}".format(outFolder, CONF.prodCircuitTemplate.replace(".v",""))
    
def runTestbed(testbed):
    cmd = [CONF.vvpPath, testbed]
    ctx = run_process(cmd, CONF.verbose_counterexample_checking)
    cycles = ctx.split(">>>>>")

    diffcycle = False
    name = ""
    ctr_list = []
    for cycle in cycles[1:-1]:
        # print("cycle",cycle)
        invs = cycle.split("\n")
        trg_equiv = ((invs[1]).split(" "))[1]
        Retire_trg = ((invs[2]).split(" "))[1]
        Retire_left = ((invs[3]).split(" "))[1]
        Retire_right = ((invs[3]).split(" "))[3]
        print("trg_equiv",trg_equiv)
        print("Retire_trg",Retire_trg)
        print("Retire_left",Retire_left)
        print("Retire_right",Retire_right)
        if trg_equiv == "0":
            diffcycle = True
            
        if diffcycle and Retire_left == "1" and Retire_right == "1":
            print("cycle",cycle) 
            for inv in invs[4:-1]:
                print("inv",inv)
                tbname = inv.split(" ")
                if (tbname[-1] == "0" or tbname[-1] == "x") and len(tbname) == 2:
                    name = tbname[0].split("_src_cand")[0].split(".")[-1]
                    print("name: ",name)
                    if not ctr_list.count(name):
                        ctr_list.append(name)
                        # break
            break
    print("ctr_list",ctr_list)      
    return ctr_list


                    


def isSpurious(counterexample,outFolder):

    # 0. move exiting context of CONF.outFolder to CONF.outFolder/old
    if CONF.verbose_counterexample_checking:
        print(f">>> Counterexample checking 0) Setting up new {outFolder} folder")
    cmd = ["cp", "-R", f"{outFolder}", f"{outFolder}_tmp"]
    run_process(cmd, CONF.verbose_counterexample_checking)
    cmd = ["rm", "-Rf", f"{outFolder}"]
    run_process(cmd, CONF.verbose_counterexample_checking)
    cmd = ["cp", "-R", CONF.codeFolder, outFolder]
    run_process(cmd, CONF.verbose_counterexample_checking)
    cmd = ["mv", f"{outFolder}_tmp", f"{outFolder}/{outFolder}_tmp"]
    run_process(cmd, CONF.verbose_counterexample_checking)


    files = [file for file in os.listdir(outFolder) if file.endswith(".v")]

    # 3. compile testbed using iverilog
    testbed = compileWithIVerilog(files, outFolder)

    # 4. run
    return runTestbed(testbed)



def displayObservations(counterexample, obsDict, prodType, keyword):
    debug = False
    if len(obsDict) > 0:
        code = ""
        with open(counterexample, "r") as f:
            code = f.read()

        if CONF.yosysCtxDisplayAtEdge:
            displayObs = f"\talways @(posedge {CONF.yosysCtxClock}) begin\n"
        else:
            displayObs = f"\talways @* begin\n"
        displayObs += f"\t\t$display(\">>>>> CYCLE %0d -- {keyword}\", {CONF.yosysCtxCycle});\n"
        displayObs += f"\t\t$display(\"{CONF.yosysCtxUUT}.trg_equiv %b\", {CONF.yosysCtxUUT}.trg_equiv);\n"
        displayObs += f"\t\t$display(\"{CONF.yosysCtxUUT}.Retire_trg %b\", {CONF.yosysCtxUUT}.Retire_trg);\n"
        # $display("UUT.renamed_left__ibex_core__ibex_id_stage__instr_rdata_i %b && %b", UUT.renamed_left__ibex_core__ibex_id_stage__instr_rdata_i, UUT.renamed_right__ibex_core__ibex_id_stage__instr_rdata_i);
        displayObs += f"\t\t$display(\"{CONF.yosysCtxUUT}.Retire %b && %b\", {CONF.yosysCtxUUT}.Retire_obs_trg_arg0_trg_left,{CONF.yosysCtxUUT}.Retire_obs_trg_arg0_trg_right );\n"
        for obsId in obsDict.keys():
            displayObs += f"\t\t $display(\"{CONF.yosysCtxUUT}.{obsId}_{prodType} %b\", {CONF.yosysCtxUUT}.{obsId}_{prodType});\n"
        if debug:
            for obsId in obsDict.keys():
                displayObs += f"\t\t$display(\">>> {obsId}\");\n"
                for obs in obsDict[obsId]:
                    var = obs.get("var")
                    displayObs += f"\t\t$display(\"{var} %b =?= %b\", {CONF.yosysCtxUUT}.{var}_{prodType}_left,  {CONF.yosysCtxUUT}.{var}_{prodType}_right);\n"
        displayObs += "\tend\n"
        displayObs += "endmodule\n"

        code = code.replace("endmodule", displayObs)
        with open(counterexample, "w") as f:
            f.write(code)


def rename(id_):
    # print("id_: ", id_)
    renamed = "renamed_"+id_.replace(".","__").replace("[","___").replace("]","").replace("\\","").replace(" ","").replace("$","").replace("/","").replace(":","")
    # if renamed.find("$func$") != -1:
    #     print("-renamed-: ", renamed)
    return renamed

def renameDotNotation(file, testbed: bool):

    code = ""
    with open(file, "r") as f:
        code = f.read()
    timein1 = datetime.now()
    #1) find all occurrences of . notation
    if testbed:
        #ids = re.findall('UUT\.([A-Za-z0-9_\.\\]*)(\[[A-Za-z0-9\']*\])?[A-Za-z0-9_\.\\\\]*', code)
        ids = re.findall('UUT\.(left\.[A-Za-z0-9_\.\\\\$/;]*)(?:\[[A-Za-z0-9\']*\])?([A-Za-z0-9_\.\\\\]*)? =', code)  
        ids += re.findall('UUT\.(right\.[A-Za-z0-9_\.\\\\$/;]*)(?:\[[A-Za-z0-9\']*\])?([A-Za-z0-9_\.\\\\]*)? =', code)

        ids_auto = re.findall('UUT\.(left\.[A-Za-z0-9_\.$/;]*)(\\\\[A-Za-z_\.]*\[[A-Za-z0-9\']*\] )([A-Za-z0-9_\.\\\\]*)? =', code)
        ids_auto += re.findall('UUT\.(right\.[A-Za-z0-9_\.$/;]*)(\\\\[A-Za-z_\.]*\[[A-Za-z0-9\']*\] )([A-Za-z0-9_\.\\\\]*)? =', code)

        # rename the variables defined in the prod.v start with "\\"
        namedArrays = re.findall('UUT\.(\\\\[A-Za-z0-9_\.\\\\$/;]*)(\[[A-Za-z0-9\']*\])?([A-Za-z0-9_\.\\\\]*)?', code)
        # currently yosys puts two spaces before the assignment whenever the [..] is used as part of an identifier :-\
        namedArrays += re.findall('UUT\.(left\.\\\\[A-Za-z0-9_\.\\\\$/;]*)(\[[A-Za-z0-9\']*\])?([A-Za-z0-9_\.\\\\]*)?  =', code)  # UUT.left.\IACK_reg[7]  =
        namedArrays += re.findall('UUT\.(right\.\\\\[A-Za-z0-9_\.\\\\$/;]*)(\[[A-Za-z0-9\']*\])?([A-Za-z0-9_\.\\\\]*)?  =', code)
        
        namedArrays += re.findall('UUT\.(left\.[A-Za-z0-9_\.\\\\$/;]*)(\[[A-Za-z0-9\']*\])?([A-Za-z0-9_\.\\\\]*)?  =', code)  # UUT.left.\IACK_reg[7]  =
        namedArrays += re.findall('UUT\.(right\.[A-Za-z0-9_\.\\\\$/;]*)(\[[A-Za-z0-9\']*\])?([A-Za-z0-9_\.\\\\]*)?  =', code)

        ids+=ids_auto
        ids+=namedArrays
    else:
        # We are renaming prod.v
        # yosys syntax for dot notation is "\xx.yy.zz"
        # These should be all definitions of registers and wires using DOT notation 
        ids =  re.findall('(?:wire|reg) (?:\[[0-9]*:[0-9]*\] )?\\\\([A-Za-z0-9_\.\\\\$/;]*)(\[[0-9]*\])?([A-Za-z0-9_\.\\\\]*)? (?:;| =)', code)  #  wire [31:0] \IOMUX[0]_obs_trg_arg0_trg_left ;
        ids += re.findall('(?:wire|reg) (?:\[[0-9]*:[0-9]*\] )?\\\\(left\.[A-Za-z0-9_\.\\\\$/;]*)(\[[0-9]*\])?([A-Za-z0-9_\.\\\\]*)? (?:;| =)', code)
        ids += re.findall('(?:wire|reg) (?:\[[0-9]*:[0-9]*\] )?\\\\(right\.[A-Za-z0-9_\.\\\\$/;]*)(\[[0-9]*\])?([A-Za-z0-9_\.\\\\]*)? (?:;| =)', code)

        # These should be all definitions of vector registers using DOT notation 
        ids += re.findall('(?:wire|reg) (?:\[[0-9]*:[0-9]*\] )?\\\\([A-Za-z0-9_\.\\\\$/;]*)(\[[0-9]*\])?([A-Za-z0-9_\.\\\\]*)?  \[[0-9]*:[0-9]*\]', code)
        ids += re.findall('(?:wire|reg) (?:\[[0-9]*:[0-9]*\] )?\\\\(left\.[A-Za-z0-9_\.\\\\$/;]*)(\[[0-9]*\])?([A-Za-z0-9_\.\\\\]*)?  \[[0-9]*:[0-9]*\]', code)
        ids += re.findall('(?:wire|reg) (?:\[[0-9]*:[0-9]*\] )?\\\\(right\.[A-Za-z0-9_\.\\\\$/;]*)(\[[0-9]*\])?([A-Za-z0-9_\.\\\\]*)?  \[[0-9]*:[0-9]*\]', code)
    # logtimefile("\n\t\t\tTime for finding illegal strings: "+ str((timein2- timein1).seconds))
    ids.sort(reverse=True,key=lambda id_: len(id_[0]+id_[1]) )
    list(set(ids))
    # logtimefile("\n\t\t\tTime for processing list: "+ str((timein3- timein2).seconds))
    print(f"Renamed {len(ids)} identifiers in {file}")
    for id_ in ids:
        if testbed:
            if id_ in namedArrays:
                id_ = id_[0] + id_[1] +id_[2]
                code = code.replace("UUT."+id_, "UUT."+rename(id_))
            elif id_ in ids_auto:
                id_ = id_[0] + id_[1] +id_[2]
                code = code.replace("UUT."+id_, "UUT."+rename(id_))
            else:
                id_ = id_[0] + id_[1]
                code = code.replace("UUT."+id_, "UUT."+rename(id_))

        else:
            id_ = id_[0]+id_[1]+id_[2]
            code = code.replace("\\"+id_+" ", rename(id_)+" ")

    with open(file, "w") as f:
        f.write(code)
    timein4 = datetime.now()
    # logtimefile("\n\t\t\tTime for replacing illegal strings: "+ str((timein4- timein3).seconds))
def fixClock(file):
    code = ""
    with open(file, "r") as f:
        code = f.read()

    testbed_clock = "PI_"+CONF.clockInput

    if f"wire [0:0] {testbed_clock} = clock;" not in code:
        ## yosys-smtbmc messed up, we need to fix it :-|
        code = code.replace(f".{CONF.clockInput}({testbed_clock})", f".{CONF.clockInput}(clock)")
        with open(file, "w") as f:
            f.write(code)
        print("Fixed clock signal")
    else:
        print("Yosys-smtbmc correctly assigned the clock signal")
        

def runCounterexample(counterexample, trgObservations, srcCandObeservations, filtertype):
    log("START - RUN CTX")
    time1 = datetime.now()

    outFolder = CONF.outFolder + "/temp"
  

    # 1nd hack:
    # yosys-smtbmc sometimes uses the wrong clock signal for the generated testbed
    # we're fixing this manually
    log(f"Check if clock signal need to be fixed in {counterexample}")
    fixClock(counterexample)

    # 2st append display statements to the counterexample
    log(f"Append display statements")
    # displayObservations(counterexample, trgObservations, "trg", "ASSERT")
    displayObservations(counterexample, srcCandObeservations, "src_cand", "SRC_CAND")

    # 3st hack:
    # iverilog seems to have trouble with using dot notation, which is used by yosys
    # we therefore need to rename stuff in prod.v :-|
    # run_process(["cp", "{}/{}".format(outFolder,counterexample), "{}/{}_non-renamed".format(outFolder,counterexample)])
    log(f"Rename dot notation in {counterexample}")
    renameDotNotation(counterexample,testbed=True)

    log(f"Rename dot notation in {outFolder}/{CONF.prodCircuitTemplate}")
    renameDotNotation(f"{outFolder}/{CONF.prodCircuitTemplate}", testbed=False)
    
    time11 = datetime.now()
    # compile and run counterexample
    log(f"Compile counterexample testbed")
    tb = compileWithIVerilog(counterexample,outFolder)
    time12 = datetime.now()
    log(f"Run counterexample testbed")
    updatedContractID = runTestbed(tb)
    if updatedContractID == []:
        logfile("No contract atom learned")
        exit(1)
    time13 = datetime.now()

    time2 = datetime.now()
    logtimefile("\n\t\tTime for analyzing counterexample: "+ str((time2- time1).seconds) + "\n\n")

    log("END - RUN CTX")
    # exit(1)
    return updatedContractID


