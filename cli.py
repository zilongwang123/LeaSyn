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
    



if __name__ == '__main__':
    main()
