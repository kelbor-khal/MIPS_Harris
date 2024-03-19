// author: Filin I.A.
// functional: main controller multi cycle MIPS
// last revision: 14.02.24

`timescale 1ns/10ps

module controller
(
    input   logic   clk,
    input   logic   rst,

    input   logic   [5:0] opcode,
    input   logic   [5:0] funct,

    // sle mux signal
    output  logic   pc_write, 
    output  logic   branch,
    output  logic   memWrite,
    output  logic   iRwrite,
    output  logic   regWrite,
    // control set signal mux
    output  logic   IorD,
    output  logic   regDst,
    output  logic   memToReg,
    output  logic   aluSrc_a,
    output  logic   [1:0] aluSrc_b,
    output  logic   [1:0] pc_src,

    output  logic   [2:0] alu_cntrl
);
   
    // declare local signals
    logic [1:0] alu_op;

    maindec U_0 (.clk       (clk),
                 .rst       (rst),  
                 .opcode    (opcode),
                 .pc_write  (pc_write),
                 .branch    (branch),
                 .memWrite  (memWrite),
                 .iRwrite   (iRwrite),
                 .regWrite  (regWrite),
                 .IorD      (IorD),
                 .regDst    (regDst),
                 .memToReg  (memToReg),
                 .aluSrc_a  (aluSrc_a),
                 .aluSrc_b  (aluSrc_b),
                 .pc_src    (pc_src),
                 .alu_op    (alu_op));

    aludec  U_1 (.aluop(alu_op),
                 .funct(funct),
                 .cntrl(alu_cntrl));

endmodule : controller