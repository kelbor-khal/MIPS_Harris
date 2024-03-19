// author: Filin I.A.
// functional: MIPS processor
// last revision: 12.03.24

`timescale 1ns/10ps

module mips
#(
    parameter BUS_WIDTH = 32
)
(
    input   logic   clk,
    input   logic   rst,

    input   logic   [(BUS_WIDTH - 1):0] mem_IorD,
    output  logic                       memWrite,
    output  logic   [(BUS_WIDTH - 1):0] mem_addr,
    output  logic   [(BUS_WIDTH - 1):0] wr_mem_data
);

    // declare local signals
    logic [5:0] opcode, funct;
    logic pc_write, branch, iRwrite, regWrite,
          IorD, regDst, memToReg, aluSrc_a;
    logic [1:0] aluSrc_b, pc_src;
    logic [2:0] alu_cntrl;
    logic [(BUS_WIDTH - 1):0] instr_datapath;

    assign opcode = instr_datapath [31:26];
    assign funct  = instr_datapath [5 : 0];

    // controller
    controller U_0 (.clk        (clk),
                    .rst        (rst),
                    .opcode     (opcode),
                    .funct      (funct),
                    .pc_write   (pc_write),
                    .branch     (branch),
                    .memWrite   (memWrite),
                    .iRwrite    (iRwrite),
                    .regWrite   (regWrite),
                    .IorD       (IorD),
                    .regDst     (regDst),
                    .memToReg   (memToReg),
                    .aluSrc_a   (aluSrc_a),
                    .aluSrc_b   (aluSrc_b),
                    .pc_src     (pc_src),
                    .alu_cntrl  (alu_cntrl));

    // data path
    datapath   U_1 (.clk(clk),
                    .rst           (rst),
                    .pc_write      (pc_write),
                    .branch        (branch),
                    .iRwrite       (iRwrite),
                    .regWrite      (regWrite),
                    .IorD          (IorD),
                    .regDst        (regDst),
                    .memToReg      (memToReg),
                    .aluSrc_a      (aluSrc_a),
                    .aluSrc_b      (aluSrc_b),
                    .pc_src        (pc_src),
                    .alu_cntrl     (alu_cntrl),
                    .mem_data      (mem_IorD),
                    .wr_mem_data   (wr_mem_data),
                    .addr_mem_data (mem_addr),
                    .instr_datapath(instr_datapath));

endmodule : mips