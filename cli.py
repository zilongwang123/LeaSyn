from __future__ import absolute_import
from __future__ import print_function
import sys
import os
import yaml
from optparse import OptionParser
from util import *
from datetime import datetime 
import time


from config import CONF
from preprocessing import preprocessing
from verification import verify, boundedVerify
from counterexample_checking import runCounterexample
from invariant import initInvariant
from invariant import refineInvariant
from invariant import invariantSubset
from contractgen import contractgen
from contractgen import compilecontractgen
from contractgen import contracteva
from LeaVe.LeaVe import LeaVe

## TODO
# 1. better error handling :-\


'''
def microEquivCheck(srcObservations, invariant, stateInvariant, auxVars, metaVars, toexpandArray, filtertype):
    counter = 1
    basepass = False
    starttime = time.time() 
    while(invariant):
        logfile("\nBegin the {}th loop...\n".format(counter))
        logtimefile("\n\n\tTime for the {}th loop...".format(counter))
        counter+=1
        logfile("\tThe invariant for verification is:\n" + "".join(inv2str(invariant)))
        if not basepass: 
            # 1.1 verification_base
            print("Checking the base case")
            logfile("\n3.1. Checking the micro-equivalence relation...\n")
            logfile("\n3.1.1. Checking the base case...\n")
            verifStatus, cex, inv = verify(invariant, "base", filtertype)
            print(verifStatus)

            if verifStatus == "FAIL":
                diffInvList = runCounterexample(cex, inv, "base", filtertype)
                logfile("  The base step is not satisfied!\n" + "\tthe difference set of invariant is:\n------\n"+ "\n".join(diffInvList)+"\n------\n")
                print("The base case is not satisfied!")
                if diffInvList == []:
                    logfile("  Nothing learned from counterexample! The result is UNKNOWN!")
                    print("Nothing learned from counterexample!")
                    return False, None
                invariant = refineInvariant(invariant, diffInvList)
                continue
            else:
                basepass = True
                logfile("  The base case is satisfied!\n")
                basetime = time.time()
                continue
        else:
            # 1.2 verification_inductive
            print("  Checking the inductive step")
            logfile("\n\t Checking the inductive step...\n")
            verifStatus, cex, inv = verify(invariant, "inductive", filtertype)
            if verifStatus == "FAIL":
                print("The inductive step is not satisfied!")
                diffInvList = runCounterexample(cex, inv, "inductive", filtertype)
                logfile("\tThe inductive step is not satisfied!\n" + "\tthe difference set of invariant is:\n------\n"+ "\n".join(diffInvList)+"\n------\n")
                if diffInvList == []:
                    print("Nothing learned from counterexample!")
                    logfile("\tNothing learned from counterexample! The result is UNKNOWN!")
                    return False, None
                invariant = refineInvariant(invariant, diffInvList)
                continue
            else:
                logfile("\tThe inductive step is satisfied!\n")
                invtime = time.time()
                logfile("\tThe invariant learned is:\n" + "".join(inv2str(invariant)))
                print("The invariant learned is: \n",invariant)
                
                logfile("\n\n\tTime for base step: "+ str(int(basetime- starttime)))
                logfile("\n\tTime for inductive step: "+ str(int(invtime - basetime)))
                logtimefile("\n\n\tTime for base step: "+ str(int(basetime- starttime)))
                logtimefile("\n\tTime for inductive step: "+ str(int(invtime - basetime)))
                return True, invariant
    logfile("  \n\t No invariant found!\n")
    return False, None
'''

def updateCandidateContract(srcObservations, candidateContractAtoms, updatedContractID):
    updatedContract = srcObservations
    for name in updatedContractID:
        print("name:",name)
        for atom in candidateContractAtoms:
            print("atom[id]",atom["id"])
            if atom["id"] == name:
                print("name:",name)
                print("atom[id]",atom["id"])
                updatedContract.append(atom)
                print("append_atom",name)
    return updatedContract


def main():
    INFO = "Verification of contract satisfaction"
    VERSION = "0.0 :-|"
    USAGE = "Usage: python cli.py configFile"

    def showVersion():
        print(INFO)
        print(VERSION)
        print(USAGE)
        sys.exit()

    optparser = OptionParser()
    optparser.add_option("-v", "--version", action="store_true", dest="showversion",
                         default=False, help="Show the version")
    # optparser.add_option("-h", "--help", action="store_true", dest="showhelp",
                        #  default=False, help="Show the help")
    optparser.add_option("-I", "--include", dest="include", action="append",
                         default=[], help="Include path")
    optparser.add_option("-D", dest="define", action="append",
                         default=[], help="Macro Definition")
    optparser.add_option("-c", dest="clk", action="append",
                         default='clk', help="Clock Signal Name")                        
    (options, args) = optparser.parse_args()

    filelist = args
    if options.showversion: # or options.showhelp:
        showVersion()

    for f in filelist:
        if not os.path.exists(f):
            raise IOError("file not found: " + f)

    if len(filelist) == 0:
        showVersion()

    ## Init configuration
    configFile = filelist[0]
    configFile_leave = "LeaVe/" + configFile
    
    if getattr(args, 'verbose', 0):
        CONF.set('verbose', 1)
    with open(configFile, "r") as f:
        config_update: Dict = yaml.safe_load(f)
    for var, value in config_update.items():
        CONF.set(var, value)

    if CONF.selfCompositionEquality == "==":
        CONF.selfCompositionInequality = "!="
    if CONF.selfCompositionEquality == "===":
        CONF.selfCompositionInequality = "!=="

    # run_process(["rm", CONF.outFolder + "/logfile"], CONF.verbose_preprocessing)
    # run_process(["rm", CONF.outFolder + "/logtimefile"], CONF.verbose_preprocessing)
    # run_process(["rm", "-rf", CONF.outFolder + "/CTR"], CONF.verbose_preprocessing)
    run_process(["rm", "-rf", CONF.outFolder], CONF.verbose_preprocessing)
    run_process(["mkdir", CONF.outFolder], CONF.verbose_preprocessing)
    run_process(["mkdir", CONF.outFolder + "/CTR"], CONF.verbose_preprocessing)
    run_process(["mkdir", CONF.outFolder + "/temp"], CONF.verbose_preprocessing)

######## bounded verification ###########
    time1 = time.time()
    # large-bound-check
    auxVars, to_expand, invariant = initInvariant("delayedcheck")#invariant = CONF.invariant
    # generating toexpandArray
    toexpandArray = CONF.expandArrays
    # normal pipeline invariant
    stateInvariant = CONF.stateInvariant
    
    
    compilecontractgen()
    time2 = time.time()
    # source observations
    srcObservations, sizeOfContract = contractgen("init",0) # -s
    # srcObservations = CONF.srcObservations
    # sizeOfContract = 3
    time3 = time.time()

    # candidate contract atoms
    candidateContractAtoms = CONF.candidateContractAtoms
    # target observations
    trgObservations = CONF.trgObservations
    # meta variables
    metaVars = CONF.metaVars
    
     
    counter = 1
    # memSize = 1
    logtimefile(f"Start learning the contract!!\n")
    while 1: 
        # logtimefile(f"\tThe number of symbolic instruction is {memSize}:\n")
        logtimefile(f"\tStart the {counter}th loop:")
        logfile(f"Preparing the environment for the {counter}th loop....\n")
        run_process(["rm", "-rf", CONF.outFolder + "/temp"], CONF.verbose_preprocessing)
        run_process(["mkdir", CONF.outFolder + "/temp"], CONF.verbose_preprocessing)  
        # logtimefile("\n\tStart the preprocessing...") 
        preprocessing(toexpandArray, "delayedcheck") 
        # preprocessing(toexpandArray, "delayedcheck", memSize) 
        logfile(f"\tThe contract for the {counter}th loop is:\n" + "".join(inv2str(srcObservations)))
        logfile(f"\tThe contract contains {sizeOfContract} atoms.\n")
        State, tbname, trg_obs_dict, src_cand_obs_dict = boundedVerify(srcObservations, trgObservations, candidateContractAtoms, stateInvariant, auxVars, metaVars, "delayedcheck")
        # State = "PASS"
        if State == "PASS":    
            logfile("\tThe CPU is bounded SECURE under the attack w.r.t the contract!!\n\n")
            # exit(1)
            # memSize += 1
            # if memSize < int(CONF.maxInstrMem):
            #     continue
            time4 = time.time()
            contracteva("evaluate")
            time5 = time.time()
            logtimefile("\n\n\tTime for preprocessing: "+ str(int(time2- time1)))
            logtimefile("\n\n\tTime for generate the initial contract: "+ str(int(time3- time2)))
            logtimefile("\n\tTime for updating the contract: "+ str(int(time4- time3)))
            logtimefile("\n\tTime for evaluating the contract: "+ str(int(time5- time4)))
            logfile("\n\nStart the inductively proving for the learned contract...\n\n")
            logtimefile("\n\nStart the inductively proving for the learned contract...\n\n")
            State = LeaVe(srcObservations, configFile_leave)
            time6 = time.time()
            if State:    
                logfile("\n\tThe CPU is SECURE under the attack w.r.t the contract!!\n\n")
                break
            else:
                logfile("\n\tThe CPU is VULNERABLE under the attack w.r.t the contract!!\n\n")
                break
                # increase the bound for BMC and loop again 
        else:
            logfile("\tThe CPU is bounded VULNERABLE under the attack w.r.t the contract!!\n\n")
            # diffInvList = runCounterexample(tbname, trg_obs_dict, "inductive", "delayedcheck")
            # print(diffInvList)
            # exit(1)
            # updatedContractID = runCounterexample(tbname, trg_obs_dict, src_cand_obs_dict, "delayedcheck")
            # print("updatedContractID",updatedContractID)
            # srcObservations = updateCandidateContract(srcObservations, candidateContractAtoms, updatedContractID) # -s; -u
            time11 = time.time()
            srcObservations, sizeOfContract = contractgen("update",counter)
            time12 = time.time()
            logtimefile("\t\tTime for updating contract: "+ str(int(time12- time11)) + "\n\n")
        counter+=1

    

    logtimefile("\n\tTime for inductively proving the secure with the contract: "+ str(int(time6- time5)))
    




'''
    # large-bound-check
    auxVars, to_expand, invariant = initInvariant("delayedcheck")#invariant = CONF.invariant
    # generating toexpandArray
    toexpandArray = to_expand + CONF.expandArrays
    # normal pipeline invariant
    stateInvariant = CONF.stateInvariant
    # source observations
    srcObservations = CONF.srcObservations
    # target observations
    trgObservations = CONF.trgObservations + CONF.predicateRetire
    # meta variables
    metaVars = CONF.metaVars

    time1 = time.time() 
    logfile("\n2. Start the delayed leakage ordering check...\n")
    logfile("\n\t2.1 Start the preprocessing...\n")
    logtimefile("1. Start the preprocessing...\n")    
    # print(invariant)
    # exit(1)
    preprocessing(toexpandArray, srcObservations, invariant, stateInvariant, auxVars, metaVars, "delayedcheck")
    time2 = time.time() 
    logtimefile("\n\n2. Start the verification...")
    State, invariant = microEquivCheck(srcObservations, invariant, stateInvariant, auxVars, metaVars, toexpandArray, "delayedcheck")
    if State:    
        logfile("\n\n3. Check the satisfaction based on learned strongest attacker.\n")
        if invariantSubset(invariant, CONF.trgObservations):
            logfile("\n\tThe CPU is SECURE under the attack w.r.t the contract!!")
        else:
            logfile("\n\tThe CPU is VULNERABLE under the attack w.r.t the contract!!")
    time3 = time.time()  
    logtimefile("\n\n\tTime for preprocessing: "+ str(int(time2- time1)))
    logtimefile("\n\tTime for learning the strongest attacker: "+ str(int(time3- time2)))
'''





if __name__ == '__main__':
    main()
