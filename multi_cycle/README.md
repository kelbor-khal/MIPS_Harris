# Multi-cycle processor on architecture MIPS

## Supported instructions:
| type instruction | Mnemonics               | 
|:----------------:|:------------------------|
| R-type           | add, sub, and, or, slt; |
| I-type           | addi, lw, sw;           |
| J-type           | j, beq;                 |

## 1.0 Top level connection

### 1.1 Top level processor module

This is the top processor module. Add info

<figure>
  <img src="structure/multi_cycle-MIPS.png">
  <figcaption align="center" font-style="italic"> Picture 1.1 - Multi-cycle processor MIPS </figcaption>
</figure>

The table 1.1 shows the modules included in the upper processor module and their description.

### *Table 1.1 - top-level modules* 
| Number   | Name instance   | Name module   | Description module             |
|:--------:|:---------------:|:-------------:|:-------------------------------|
|0         | U_0             | controller    | controller one-cycle processor |
|1         | U_1             | datapath      | data path  one-cycle processor |

### 1.2 RAM module

The memory has text segment (200 instruction max) and dynamic data segment (200 position for variables max).

<figure>
  <img src="structure/multi_cycle-memory map.png">
  <figcaption align="center" font-style="italic"> Picture 1.1 - Memory map multi-cycle MIPS </figcaption>
</figure>

### *Table 1.2 - Segments memory map* 
| Number block   | Name segment   | Start address   | End address |
|:--------------:|:--------------:|:---------------:|:------------|
|0               |     text       | 0x0000_0000     | 0x0000_1900 |
|1               | dynamic data   | 0x0000_1920     | 0x0000_3200 |

The table 1.2 shows the segments in memory MIPS and there start and end address

## 2.0 Data path module

This is a data path module. The program instruction enters it and is then executed.

<figure>
  <img src="structure/multi_cycle-data path.png">
  <figcaption align="center" font-style="italic"> Picture 2.1 - Multi-cycle data path module processor MIPS </figcaption>
</figure>

The table 2.1 shows the modules included in the processor data path and their description.

### *Table 2.1 - data path modules* 
| Number   | Name instance   | Name module   | Description module                                      |
|:--------:|:---------------:|:-------------:|:--------------------------------------------------------|
|0         | U_0             |    dffe       | programm counter 32-bit                                 |
|1         | U_1             |    mux2       | J-type, branch or next instructions                     |
|2         | U_2             |    dffe       | invisible instruction register                          |
|3         | U_3             |    dff        | invisible data register                                 |
|4         | U_4             |    slt2       | modify address jump instruction                         |
|5         | U_5             |    mux2       | source register for I-type or R-type instruction        |
|6         | U_6             |    mux2       | data from memory or result ALU                          |
|7         | U_7             |    regfile    | register file, width 32 and 32 registers                |
|8         | U_8             |    exsign     | signing extended for 16-bit number to 32-bit            |
|9         | U_9             |    dff        | invisible read regfile 1 register                       |
|10        | U_10            |    dff        | invisible read regfile 2 register                       |
|11        | U_11            |    mux2       | pc or read data 1 from regfile                          |
|12        | U_12            |    mux4       | source argument ALU b                                   |
|13        | U_13            |    slt2       | shift logic left immidiate constatnt                    |
|14        | U_14            |    alu        | arifmetic-logic unit                                    |
|15        | U_15            |    mux4       | source program counter value                            |
|16        | U_16            |    dff        | invisible register result ALU                           |

## 3.0 Controller module

This is a processor controller module. Depending on the incoming instruction, it generates flags that control the data path.

<figure>
  <img src="structure/multi_cycle-controller.png">
  <figcaption align="center" font-style="italic"> Picture 3.1 - Multi-cycle controller module processor MIPS </figcaption>
</figure>

The table 3.1 shows the modules included in the processor controller and their description

### *Table 3.1 - comtroller modules* 
| Number   | Name instance   | Name module   | Description module                           |
|:--------:|:---------------:|:-------------:|:---------------------------------------------|
|0         | U_0             | maindec       | decoder for controlling flags from data path |
|1         | U_1             | aludec        | decoder for alu                              |
