// author: Filin I.A.
// functional: data path multi-cycle processor
// last revision: 22.02.24

`timescale 1ns/10ps

module datapath
#(
    parameter IMM_WIDTH = 16,
    parameter REG_ADDR  = 5,
    parameter BUS_WIDTH = 32
)
(
    input   logic   clk,
    input   logic   rst,

    // signals memory
    input   logic   [(BUS_WIDTH - 1):0] mem_data,
    output  logic   [(BUS_WIDTH - 1):0] wr_mem_data,
    output  logic   [(BUS_WIDTH - 1):0] addr_mem_data,

    // sel mux signal
    input   logic   pc_write, 
    input   logic   branch,
    input   logic   iRwrite,
    input   logic   regWrite,

    // control set signal mux
    input  logic   IorD,
    input  logic   regDst,
    input  logic   memToReg,
    input  logic   aluSrc_a,
    input  logic   [1:0] aluSrc_b,
    input  logic   [1:0] pc_src,

    // alu operations
    input  logic   [2:0] alu_cntrl,
    output  logic [31:0] instr_datapath
);

    // signals program counter
    logic en_pc;
    logic [(BUS_WIDTH - 1):0] crnt_addr, pc_value, slt_jump, jump_addr;

    // signals invisible registers
    logic [(BUS_WIDTH - 1):0] instr, data;
    logic [(BUS_WIDTH - 1):0] rd_delay1, rd_delay2;

    // register file signals
    logic [(BUS_WIDTH - 1):0]  rdreg1, rdreg2, wrdata3;
    logic [(REG_ADDR - 1) :0]  addreg1, addreg2, addreg3;

    // extension sign signals
    logic [(IMM_WIDTH - 1):0] immconst;
    logic [(BUS_WIDTH - 1):0] extimm, sltimm;

    // ALU signals
    logic zero_f;
    logic [(BUS_WIDTH - 1):0] srcA, srcB;
    logic [(BUS_WIDTH - 1):0] aluOut, rsltALU;

    // enable signal
    assign en_pc = pc_write || (branch && zero_f);

    // program counter
    dffe_m  U_0  (.clk(clk),
                  .rst(!rst),
                  .en (en_pc),
                  .in (pc_value),
                  .out(crnt_addr));

    // jump, branch or next
    mux2    U_1  (.a    (crnt_addr),
                  .b    (aluOut),
                  .cntrl(IorD),
                  .out  (addr_mem_data));

    // instruction save
    dffe_m  U_2  (.clk(clk),
                  .rst(!rst),
                  .en (iRwrite),
                  .in (mem_data),
                  .out(instr));

    assign instr_datapath = instr;

    // data save
    dff_m   U_3  (.clk(clk),
                  .rst(!rst),
                  .in (mem_data),
                  .out(data));

    // modify address jump instruction
    slt2    U_4  (.in({6'b0,instr[25:0]}),
                  .out(slt_jump));

    // splitiong instruction
    assign addreg1   = instr[25:21];
    assign addreg2   = instr[20:16];
    assign immconst  = instr[15: 0];
    assign jump_addr = {crnt_addr[31:28],slt_jump[27:0]};

    // immidiate or register instruction
    mux2    #(.DATA_WIDTH(5))
            U_5  (.a    (instr[20:16]),
                  .b    (instr[15:11]),
                  .cntrl(regDst),
                  .out  (addreg3));

    // data or result alu
    mux2    U_6  (.a    (aluOut),
                  .b    (data),
                  .cntrl(memToReg),
                  .out  (wrdata3));

    // register file
    regfile U_7  (.clk(clk),
                  .rst(rst),
                  .a1 (addreg1),
                  .a2 (addreg2),
                  .a3 (addreg3),
                  .we (regWrite),
                  .wd3(wrdata3),
                  .rd1(rdreg1),
                  .rd2(rdreg2));

    // extension sign number
    exsign  U_8  (.innum(immconst),
                  .outnum(extimm));

    // invisible reg read 1
    dff_m   U_9  (.clk(clk),
                  .rst(!rst),
                  .in (rdreg1),
                  .out(rd_delay1));

    // invisible reg read 2
    dff_m   U_10 (.clk(clk),
                  .rst(!rst),
                  .in (rdreg2),
                  .out(rd_delay2));

    // write data in memory
    assign wr_mem_data = rd_delay2;

    // pc or data from regfile
    mux2    U_11 (.a    (crnt_addr),
                  .b    (rd_delay1),
                  .cntrl(aluSrc_a),
                  .out  (srcA));

    // argument b ALU
    mux4    U_12 (.a    (rd_delay2),
                  .b    (4),
                  .c    (extimm),
                  .d    (sltimm),
                  .cntrl(aluSrc_b),
                  .out  (srcB));

    // slt immidiate constant
    slt2    U_13 (.in(extimm),
                  .out(sltimm));

    // ALU
    alu     U_14 (.a     (srcA),
                  .b     (srcB),
                  .cntrl (alu_cntrl),
                  .zero  (zero_f),
                  .result(rsltALU));

    // source program counter value
    mux4    U_15 (.a    (rsltALU),
                  .b    (aluOut),
                  .c    (jump_addr),
                  .d    (0),
                  .cntrl(pc_src),
                  .out  (pc_value));

    // invisible register result ALU
    dff_m   U_16 (.clk(clk),
                  .rst(!rst),
                  .in (rsltALU),
                  .out(aluOut));

endmodule: datapath
