# LeaSyn
LeaSyn is a tool for synthesizing sound and precise Leakage contracts for open-source RISC-V processors. 

For more details on Leasyn's synthesis approach, see our paper "Synthesis of Sound and Precise Leakage Contracts for Open-Source RISC-V Processors" at ACM CCS 2025  (open access [here](https://arxiv.org/abs/2509.06509)).

For more details on unbounded verification, see our paper "Specification and Verification of Side-channel Security for Open-source Processors via Leakage Contracts" at CCS 2023 (open access [here](https://arxiv.org/abs/2305.06979)).

For more details on leakage contracts, see our paper "Hardware-Software Contracts for Secure Speculation" at IEEE S&P 2021 (open access [here](https://arxiv.org/abs/2006.03841)).


## Compile the Yosys passes

LeaSyn relies on three Yosys custom passes to prepare the processor design for verification. These passes need to be compiled before using LeaSyn. Run `make -C yosys-passes` or follow the instructions in folder `yosys-passes` for more detailed instructions.
You will find 'addmodule.so', 'show_regs_mems.so' and 'stuttering.so' under the main folder.

## Dependencies

To run LeaSyn, you need the following dependencies:

1. Python, version 3.8.10 or higher
2. yices 2.6.4
3. Yosys, version 0.26+50 or higher
4. Icarus Verilog version 12.0
5. openjdk 18.0.2
6. sv2v



## Reproducing the results from the paper

For each target, the instructions below describe how to synthesis a precise and sound contract.

Below, `$TARGET` is one of  [`darkriscv-2`,`darkriscv-3`,`sodor-2`,`ibex-small`,`ibex-mult-div`,`ibex-cache`]. To use LeaSyn to synthesis a precise and sound contract for `$TARGET`, follow these steps:

1. In the configuration file `config/$TARGET.yaml` and `LeaVe/config/$TARGET.yaml`, change the value of the `yosysPath` option to point to the Yosys's executable in your machine, e.g., `yosys-root-path/yosys`. Change the parameters accordingly, e.g., the BMC bound, the strategy for encoding property, the contract templates, the number of testcases for initial synthesis and evaluation...

2. If you use the docker container and put the LeaSyn under the path `/home/yosys`, just skip this step. Otherwise, change the value of `TEMPLATE_PATH`, `TEMPLATE_PATH`, `COMPILATION_PATH` and `SIMULATION_PATH` in `contractgen/src/main/java/contractgen/riscv/sodor/SODOR_2.java`,  `contractgen/src/main/java/contractgen/riscv/ibex/IBEX.java`, and `contractgen/src/main/java/contractgen/riscv/darkriscv/DARKRISCV_3.java` accordingly.

3. Run LeaSyn by executing `python3 cli.py config/$TARGET.yaml`.

4. Inspect the results of bounded verification in the folder `testOut`. The folder `CTR` contains the information about the contract learned from each loop and the statistic information about the initial and final contract. The output file `logfile` contains the information about the invariants discovered in each iteration of the invariant synthesis loop. The output file `logtimefile` reports timing statistics about the verification process.

5. Similarly, inspect the results of unbounded verification in the folder `LeaVe/testOut`.


## Using the Dockerfile (Strongly recommended)

1. Construct the image using `Dockerfile` for running LeaSyn:
```
sudo docker build -t leasyn .
```

2. Run the docker container:
```
sudo docker run -t -i leasyn
```

3. In the container, under the path '/home/yosys', there are two folder: 1) `LeaSyn` contains the tool; 2) `tools` contains all the dependencies.
Compile 3 yosys passes by running:
```
cd LeaSyn
git pull
make -C yosys-passes
```

4. Reproducing the results using:
```
python3 cli.py config/$TARGET.yaml
```

## Estimated running time
There is no requirements on the platform to run LeaSyn. But it could run for a long time to terminate. 

As a reference, our experiments ran on an AMD Ryzen Threadripper PRO 5995WX with 64 cores and 512 GB of RAM.
The time for synthesizing a leakage contract and verifying bounded contract satisfaction (Correspoding to Phase 1 + Phase 2a + Phase 2b) ranges from 20 minutes to 5 hours. You can see “The CPU is bounded SECURE under the attack w.r.t the contract!” in logfile after termination.
The time for verifying unbounded contract satisfaction (Correspoding to Phase 3) ranges from 3 hours to 43.5 hours. You can see "The CPU is SECURE under the attack w.r.t the contract!!" in logfile after termination.