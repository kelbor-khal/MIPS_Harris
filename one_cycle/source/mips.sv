// author: Filin I.A.
// functional: MIPS processor one-cycle
// last revision: 31.01.24

`timescale 1ns/10ps

module mips 
#(
    parameter BUS_WIDTH = 32
)
(
    input   logic   clk, 
    input   logic   rst,

    input   logic   [(BUS_WIDTH - 1):0] instr,
    input   logic   [(BUS_WIDTH - 1):0] mem_data,

    output  logic   we_mem,
    output  logic   [(BUS_WIDTH - 1):0] crnt_addr,
    output  logic   [(BUS_WIDTH - 1):0] wr_mem_data, addr_mem
);

    // declare local signals
    logic [2:0] alu_cntrl;
    logic [5:0] opcode_instr, funct_instr;

    // controller
    controller U_0 (.funct     (instr [5:0]),
                    .opcode    (instr [31:26]),
                    .we_mem    (we_mem),
                    .branch    (branch),
                    .alu_src   (alu_src),
                    .mem_to_reg(mem_to_reg),
                    .we_regf   (we_regf),
                    .reg_dst   (reg_dst),
                    .jump      (jump),
                    .alu_cntrl (alu_cntrl));

    // data path
    datapath   U_1 (.clk          (clk),
                    .rst          (rst),
                    .instr        (instr),
                    .crnt_addr    (crnt_addr),
                    .mem_data     (mem_data),
                    .wr_mem_data  (wr_mem_data),
                    .addr_mem_data(addr_mem),
                    .we_regf      (we_regf),
                    .reg_dst      (reg_dst),
                    .alu_src      (alu_src),
                    .mem_to_reg   (mem_to_reg),
                    .branch       (branch),
                    .jump         (jump),
                    .alu_cntrl    (alu_cntrl),
                    .zero_f       ());

endmodule: mips
