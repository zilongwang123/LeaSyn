from __future__ import absolute_import
from __future__ import print_function
import sys
import os
import yaml
from optparse import OptionParser
from datetime import datetime 

from LeaVe.util import *
from LeaVe.config import CONF
from LeaVe.preprocessing import preprocessing
from LeaVe.verification import verify
from LeaVe.counterexample_checking import runCounterexample
from LeaVe.invariant import initInvariant
from LeaVe.invariant import refineInvariant
from LeaVe.invariant import invariantSubset

## TODO
# 1. better error handling :-\



def microEquivCheck(srcObservations, invariant, stateInvariant, auxVars, metaVars, toexpandArray, filtertype):
    counter = 1
    basepass = False
    starttime = datetime.now() 
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
                    logfile("\tNothing learned from counterexample! The result is UNKNOWN!")
                    logtimefile("\tNothing learned from counterexample! The result is UNKNOWN!")
                    print("Nothing learned from counterexample!")
                    return False, None
                invariant = refineInvariant(invariant, diffInvList)
                continue
            else:
                basepass = True
                logfile("  The base case is satisfied!\n")
                basetime = datetime.now()
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
                    logtimefile("\tNothing learned from counterexample! The result is UNKNOWN!")
                    return False, None
                invariant = refineInvariant(invariant, diffInvList)
                continue
            else:
                logfile("\tThe inductive step is satisfied!\n")
                invtime = datetime.now()
                logfile("\tThe invariant learned is:\n" + "".join(inv2str(invariant)))
                print("The invariant learned is: \n",invariant)
                
                logfile("\n\n\tTime for base step: "+ str((basetime- starttime).seconds))
                logfile("\n\tTime for inductive step: "+ str((invtime - basetime).seconds))
                logtimefile("\n\n\tTime for base step: "+ str((basetime- starttime).seconds))
                logtimefile("\n\tTime for inductive step: "+ str((invtime - basetime).seconds))
                return True, invariant
    logfile("  \n\t No invariant found!\n")
    return False, None


def LeaVe(srcObservations, configFile):


    with open(configFile, "r") as f:
        config_update: Dict = yaml.safe_load(f)
    for var, value in config_update.items():
        CONF.set(var, value)

    if CONF.selfCompositionEquality == "==":
        CONF.selfCompositionInequality = "!="
    if CONF.selfCompositionEquality == "===":
        CONF.selfCompositionInequality = "!=="

    run_process(["rm", CONF.outFolder + "/../logfile"], CONF.verbose_preprocessing)
    run_process(["rm", CONF.outFolder + "/../logtimefile"], CONF.verbose_preprocessing)
    logfile("1. Preparing the environment for verification....\n")
    run_process(["rm", "-rf", CONF.outFolder], CONF.verbose_preprocessing)
    run_process(["mkdir", CONF.outFolder], CONF.verbose_preprocessing)


    ########## Unbounded model checker based verification (LeaVe) ##########
    # large-bound-check
    auxVars, to_expand, invariant, state = initInvariant("delayedcheck")#invariant = CONF.invariant
    # generating toexpandArray
    toexpandArray = to_expand + CONF.expandArrays
    # normal pipeline invariant
    stateInvariant = CONF.stateInvariant
    # # source observations
    # srcObservations = CONF.srcObservations
    # target observations
    trgObservations = CONF.trgObservations #+ CONF.predicateRetire
    # meta variables
    metaVars = CONF.metaVars

    # invariant = invariant + CONF.predicateRetire
    # exit(1)
    time1 = datetime.now() 
    logfile("\n2. Start the delayed leakage ordering check...\n")
    logfile("\n\t2.1 Start the preprocessing...\n")
    logtimefile("1. Start the preprocessing...\n") 

    # print(state)
    # exit(1)
    preprocessing(toexpandArray, srcObservations, invariant, stateInvariant, state, auxVars, metaVars, "delayedcheck")
    time2 = datetime.now() 
    logtimefile("\n\n2. Start the verification...")
    State, invariant = microEquivCheck(srcObservations, invariant, stateInvariant, auxVars, metaVars, toexpandArray, "delayedcheck")
    if State:    
        logfile("\n\n3. Check the satisfaction based on learned strongest attacker.\n")
        if invariantSubset(invariant, CONF.trgObservations):
            logfile("\n\tThe CPU is SECURE under the attack w.r.t the contract!!")
            return True
        else:
            logfile("\n\tThe CPU is VULNERABLE under the attack w.r.t the contract!!")
            return False
    time3 = datetime.now()  
    logtimefile("\n\n\tTime for preprocessing: "+ str((time2- time1).seconds))
    logtimefile("\n\tTime for learning the strongest attacker: "+ str((time3- time2).seconds))




