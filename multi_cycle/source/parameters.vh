`ifndef OPCODE_INSTR_VH_
`define OPCODE_INSTR_VH_

// status control signal
parameter SET   = 1'b1;
parameter UNSET = 1'b0;

// funct R type instructions
parameter FUNCT_ADD = 6'b100_000;
parameter FUNCT_SUB = 6'b100_010;
parameter FUNCT_OR  = 6'b100_101;
parameter FUNCT_AND = 6'b100_100;
parameter FUNCT_SLT = 6'b101_010;

// opcode R type instructiond
parameter OPCODE_R_TYPE = 6'b000_000;

// opcode instructions J and I types
parameter OPCODE_LW_INSTR   = 6'b100_011;
parameter OPCODE_SW_INSTR   = 6'b101_011;
parameter OPCODE_BEQ_INSTR  = 6'b000_100;
parameter OPCODE_ADDI_INSTR = 6'b001_000;
parameter OPCODE_J_INSTR    = 6'b000_010;

`endif