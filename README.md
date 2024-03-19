# Processor on architecture MIPS

The repository contains 3 variants of the MIPS architecture processor on the HDL System Verilog. Additionally, tools for testing and writing programming in the assembler language have been added to the repository.

## 1.0 Structure repo
1. **Processors (one-cycle, multi-cycle, pipline)**:
    - source (source system vefilog files);
    - structure (scheme and drawio file)

2. **Parcer_asm**(program converting .s files MIPS to .dat files):
    - python_script (source files python);
    - specification (register and instruction maps);

3. **Programs**(files programms to MIPS on bin, hex and .s format):
    - bin_view (.dat and .mem files on bin-view);
    - hex_view (.dat and .mem files on hex-view);
    - source_asm (source files assembler MIPS);

4. **Testbench**(set of scripts to simulating work processors):
    - simulation:
        - run_sim (scripts to start simulation);
        - tcl_script (scripts to setup options ModelSim)
    - source_test (source testbench files on system verilog)

## 2.0 Single-cycle processor

| **Characteristic** | **Name instance** |
|:------------------:|:-----------------:|
|architecture        | MIPS              |
|bit depth           | 32 bits           |
|type                | one-cycle         |
|status              | testing           |

## 3.0 Multi-cycle  processor

| **Characteristic** | **Name instance** |
|:------------------:|:-----------------:|
|architecture        | MIPS              |
|bit depth           | 32 bits           |
|type                | multi-cycle       |
|status              | testing           |

## 4.0 Pipline processor

| **Characteristic** | **Name instance** |
|:------------------:|:-----------------:|
|architecture        | MIPS              |
|bit depth           | 32 bits           |
|type                | pipeline          |
|status              | being designed    |

## 5.0 Simulation 

For simulation one-cycle processor on architecture MIPS write in console:
```bash
source ./testbench/simulation/run_sim/0_start_sim_one_cycle.sh 
```
For simulation multi-cycle processor on architecture MIPS write in console:
```bash
source ./testbench/simulation/run_sim/1_start_sim_multi_cycle.sh 
```
For simulation pipeline processor on architecture MIPS write in console:
```bash
source ./testbench/simulation/run_sim/3_start_sim_pipeline.sh 
```

