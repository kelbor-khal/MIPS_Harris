// author: Filin I.A.
// functional: main controller one cycle MIPS
// last revision: 31.01.24

`timescale 1ns/10ps

module controller(

    input    logic   [5:0] funct, opcode,

    output   logic   we_mem, branch,
    output   logic   alu_src, mem_to_reg,
    output   logic   we_regf, reg_dst, jump,
    
    output   logic   [2:0] alu_cntrl
);
    // declare local signals
    logic [1:0] aluop; 

    // main decoder
    maindec U_0 (.opcode    (opcode),
                 .we_mem    (we_mem),
                 .branch    (branch),
                 .alu_src   (alu_src),
                 .mem_to_reg(mem_to_reg),
                 .we_regf   (we_regf),
                 .reg_dst   (reg_dst),
                 .jump      (jump),
                 .aluop     (aluop));

    // alu decoder
    aludec U_1 (.aluop (aluop),
                .funct (funct),
                .cntrl (alu_cntrl));

endmodule: controller