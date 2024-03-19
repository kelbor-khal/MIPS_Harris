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

## 5.0 Machine code

For create firmware for synthesis and simulation need to run parser:
```bash
python parser_asm/python_script/parser.py 
```
You can translate a single instruction or an entire program.
Single instruction example:
```
Choose mode translation:  1 - one command (only R and I);  2 - all programm : 1
Write instruction on MIPS arch: addi $t0, $0, -19
hex view: 0x2008ffed 
bin view: 001000 00000 01000 1111111111101101

```
Entire programm example:
```
Choose mode translation:  1 - one command (only R and I);  2 - all programm : 2
Write path to progtamm file on asm MIPS: programs/source_asm/harris_test.s
Wrirte in file or only display result translate:  1 - write in file;  2 - only display result: 2
|||
00000000   200a0005   00100000000010100000000000000101 # addi $t2, $0, 5                                 
00000004   200b000c   00100000000010110000000000001100 # addi $t3, $0, 12                                
00000008   216ffff7   00100001011011111111111111110111 # addi $t7, $t3, -9                               
0000000c   01ea6025   00000001111010100110000000100101 # or   $t4, $t7, $t2                              
00000010   016c6824   00000001011011000110100000100100 # and  $t5, $t3, $t4                              
00000014   01ac6820   00000001101011000110100000100000 # add  $t5, $t5, $t4                              
00000018   11ed000b   00010001111011010000000000001011 # beq  $t5, $t7, end                              
0000001c   016c602a   00000001011011000110000000101010 # slt  $t4, $t3, $t4                              
00000020   100c0001   00010000000011000000000000000001 # beq  $t4, $0, around                            
00000024   200d0000   00100000000011010000000000000000 # addi $t5, $0,  0                                
00000028   01ea602a   00000001111010100110000000101010 # slt  $t4, $t7, $t2                              
0000002c   018d7820   00000001100011010111100000100000 # add  $t7, $t4, $t5                              
00000030   01ea7822   00000001111010100111100000100010 # sub  $t7, $t7, $t2                              
00000034   ad6f0044   10101101011011110000000001000100 # sw   $t7, 68($t3)                               
00000038   8c0a0050   10001100000010100000000001010000 # lw   $t2, 80($0)                                
0000003c   08000011   00001000000000000000000000010001 # j    end                                        
00000040   200a0001   00100000000010100000000000000001 # addi $t2, $0, 1                                 
00000044   ac0a0054   10101100000010100000000001010100 # sw   $t2, 84($0)                                
|||

```

## 6.0 Simulation 

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

