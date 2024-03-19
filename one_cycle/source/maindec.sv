// author: Filin I.A.
// functional: main decoder
// last revision: 31.01.24

`timescale 1ns/10ps

`include "parameters.vh"

module maindec
(
    input    logic   [5:0] opcode,

    output   logic   we_mem, branch,
    output   logic   alu_src, mem_to_reg,
    output   logic   we_regf, reg_dst, jump,

    output   logic   [1:0] aluop
);
    // declare local signals
    logic [8:0] control;

    // concatinate flags
    assign {we_regf, reg_dst, alu_src, branch,  
            we_mem,  mem_to_reg, jump, aluop} = control; 

    // decoder
    always_comb 
    begin
        case(opcode)
            OPCODE_R_TYPE    : control = 9'b110_000_010; // register-type
            OPCODE_LW_INSTR  : control = 9'b101_001_000; // lw
            OPCODE_SW_INSTR  : control = 9'b001_010_000; // sw
            OPCODE_BEQ_INSTR : control = 9'b000_100_001; // beq
            OPCODE_ADDI_INSTR: control = 9'b101_000_000; // addi
            OPCODE_J_INSTR   : control = 9'b000_000_100; // j
            default:           control = 9'bxxx_xxx_xxx; // incorrect opcode
        endcase
    end

endmodule: maindec
