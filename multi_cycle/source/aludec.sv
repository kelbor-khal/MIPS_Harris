// author: Filin I.A.
// functional: ALU decoder
// last revision: 31.01.24

`timescale 1ns/10ps

`include "parameters.vh"

module aludec(
    
    input   logic   [1:0] aluop,   
    input   logic   [5:0] funct,

    output  logic   [2:0] cntrl
);

    always_comb
    begin
        case(aluop)
            2'b00: cntrl = 3'b010; // addi, lw, sw
            2'b01: cntrl = 3'b110; // beq
            default: 
                case(funct)
                    FUNCT_ADD: cntrl = 3'b010;
                    FUNCT_SUB: cntrl = 3'b110;
                    FUNCT_OR : cntrl = 3'b001;
                    FUNCT_AND: cntrl = 3'b000;
                    FUNCT_SLT: cntrl = 3'b111;
                    default:    cntrl = 3'bx;
                endcase
        endcase
    end

endmodule: aludec