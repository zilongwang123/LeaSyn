from __future__ import absolute_import
from __future__ import print_function
import sys
import os
import time
import re
from LeaVe.config import CONF
from LeaVe.util import *
from LeaVe.counterexample_checking import rename
from LeaVe.preprocessing import preprocessing

def escape_id(id):
    if (id.count("[")) and (id.count(".") == 0):
        return "\\" + id
    else:
        return id

def id2val(id):
    if id.count(".") == 0:
        return id
    else:
        id_l = id.split(".")
        return "\\"+".".join(id_l)

# def rename2(id_):
#     renamed = "renamed_"+id_.replace(".","__").replace("[","___").replace("]","").replace("\\","_").replace(" ","").replace("$","").replace("/","").replace(":","")
#     return renamed

def concatids(id1,id2):
    return rename(id1+id2)


def createInvariantfromcond(id,cond,val, width):
    if cond == "1":
        return {"id": id2val(id), "cond": cond, "attrs": [ {"value": id2val(val), "width": width} ]}
    else:
        return {"id": id, "cond": cond, "attrs": [ {"value": val, "width": width} ]}

def createInvariantfrommems(id, i, width):
    return {"id": id2val(id) + "_"+str(i), "cond": "1", "attrs": [ {"value": id2val(id)+"_"+str(i), "width": width} ]}

def show_regs_mems(cstrtype, outFolder):

    module = CONF.module
    yosysScript = ""
    yosysScript += "read_verilog -sv {}/*.v\n".format(outFolder)
    yosysScript += "hierarchy -top {}\n".format(module)
    yosysScript += "proc -norom\n"
    yosysScript += "flatten\n"
    yosysScript += "select {}\n".format(module)
    # yosysScript += "opt\n"
    # yosysScript += "write_verilog  {}/{}.v\n".format(outFolder,module)
    yosysScript += "show_regs_mems -o {} {}\n".format(outFolder, module)
    # yosysScript += "write_verilog -selected -norename {}/{}.v\n".format("testOut",module)

    with open("{}/show_yosys.script".format(outFolder) , 'w') as f:
        f.write(yosysScript)
    
    cmd = [CONF.yosysPath]
    for m in CONF.yosysAdditionalModules:
        cmd.append(f"-m{m}")
    cmd.append("-s{}/show_yosys.script".format(outFolder))
    run_process(cmd, CONF.verbose_verification)
 

def initInvariant(filtertype):
    outFolder = CONF.outFolder + f"/{filtertype}_init" 
    ## 0. copy source code to target
    run_process(["rm", "-rf", outFolder], CONF.verbose_preprocessing)
    run_process(["cp", "-R", CONF.codeFolder, outFolder], CONF.verbose_preprocessing)
    
    ## 1. get the information about the memories and registers from the flattened design
    show_regs_mems("init", outFolder)
       
    # 2. phase the regs_mems.dat
    invariant = []
    to_expand = []
    state = []
    auxiliaryVariables = []
    f = open("{}/regs_mems.dat".format(outFolder))
    for line in f:
        linelist = line[0:-1].split("||") # without "\n"
        # create the invariants for memories 
        # Memories: name width size filename
        if linelist[0] == "Memories":
            id = linelist[1]
            if id not in CONF.memoryList:
                if (not id.count("$")) and (not (id.startswith("_") and id.endswith("_"))):
                    width = int(linelist[2])
                    size = int(linelist[3])
                    filename = (linelist[1]).split(".")[-2] + ".v"
                    to_expand.append({"filename": filename, "array": id.split(".")[-1], "width": width, "size": size, "mult": "true"})
                    for i in range(size):
                        auxiliaryVariables.append({"id": id2val(id)+"_"+str(i), "value": id2val(id)+"_"+str(i), "width": width})
                        invariant.append(createInvariantfrommems(id,i,width))
        # create the invariants for registers 
        # Registers: name width
        if linelist[0] == "Variables":
            id = linelist[1]
            width = int(linelist[2])
            if (not id.count("$")) and (not (id.startswith("_") and id.endswith("_"))):
                id = escape_id(id)
                auxiliaryVariables.append({"id": id2val(id), "value": id2val(id), "width": width})
                invariant.append(createInvariantfromcond(id,"1",id,width))

        # create the initial states for registers, if not defined in the config file, the default initial value is 0.
        # Registers: name width
        if linelist[0] == "Registers":
            id = linelist[1]
            width = int(linelist[2])
            if (not id.count("$")) and (not (id.startswith("_") and id.endswith("_"))):
                id = escape_id(id)
                state.append({"id": id2val(id), "expr": id2val(id), "width": width, "val": 0})
        ########################################################
        # # create the invariants from $dffe 
        # # Registers: name width
        # elif linelist[0] == "$dffe":
        #     yval = linelist[1].split(":=")[0]
        #     cond = linelist[1].split(":=")[0]
        #     attrlist = linelist[2].split(";")
        #     for attr in attrlist[0:-1]:
        #         if attr != "Const":
        #             attrinfo = attr.split(":=")
        #             auxiliaryVariables.append({"id": attrinfo[0], "value": attrinfo[0], "width": int(attrinfo[1])})
        #             invariant.append(createInvariantfromcond(concatids(yval,concatids(cond,attrinfo[0])),cond,attrinfo[0],int(attrinfo[1])))
        # # create the invariants from $mux 
        # # Registers: name width
        # elif linelist[0] == "$mux":
        #     # print(linelist)
        #     yval = linelist[1].split(":=")[0]
        #     cond = linelist[2].split(":=")[0]
        #     alist = linelist[3].split(";")
        #     blist = linelist[4].split(";")
        #     for attr in alist[0:-1]:
        #         if attr != "Const":
        #             attrinfo = attr.split(":=")
        #             # print(alist)
        #             auxiliaryVariables.append({"id": attrinfo[0], "value": attrinfo[0], "width": int(attrinfo[1])})
        #             invariant.append(createInvariantfromcond(concatids(yval,concatids(cond,attrinfo[0])),cond,attrinfo[0],int(attrinfo[1])))

        #     for attr in blist[0:-1]:
        #         if attr != "Const":
        #             attrinfo = attr.split(":=")
        #             auxiliaryVariables.append({"id": attrinfo[0], "value": attrinfo[0], "width": int(attrinfo[1])})
        #             invariant.append(createInvariantfromcond(concatids(yval,concatids(cond,attrinfo[0])),cond,attrinfo[0],int(attrinfo[1])))
        #############################################################
    f.close()
    # print(auxiliaryVariables)0
    # exit(1)
    # generating auxiliary Variables
    av_dict = []
    auxVars = []
    for av in (auxiliaryVariables + CONF.auxiliaryVariables):
        if av.get("id") not in av_dict:
            auxVars.append(av)
            av_dict.append(av.get("id"))
    return auxVars, to_expand, embedInvariant(CONF.trgObservations, embedInvariant(invariant,CONF.invariant)), embedInvariant(state, CONF.state)

def embedInvariant(invariant, toembedinv):
    newinv = []
    for inv in toembedinv:
        newinv.append(inv)
    for inv in invariant:
        exist = False
        for toinv in newinv:
            if inv.get("id") == toinv.get("id"):
                exist = True
        if not exist:
            newinv.append(inv)
    return newinv


def refineInvariant(invariant, diffInvList):
    newinvariant = []
    for inv in invariant:
        if (inv.get("id") not in diffInvList) and (rename(inv.get("id")) not in diffInvList):
            newinvariant.append(inv)
    return newinvariant

def invariantSubset(source, target):
    print("source",source)
    print("target",target)
    contain = True
    sourceIDList = []
    for inv in source:
        sourceIDList.append(inv.get("id"))
    for inv in target:
        print("target",inv.get("id"))
        if (inv.get("id") not in sourceIDList):
            contain = False
    print("sourceIDList",sourceIDList)
    print("target",target)
    return contain