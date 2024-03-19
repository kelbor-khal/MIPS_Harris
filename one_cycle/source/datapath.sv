// author: Filin I.A.
// functional: data path one-cycle processor
// last revision: 31.01.24

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

    // signals command memory
    input   logic   [(BUS_WIDTH - 1):0] instr,
    output  logic   [(BUS_WIDTH - 1):0] crnt_addr, 

    // signals data memory
    input   logic   [(BUS_WIDTH - 1):0] mem_data,
    output  logic   [(BUS_WIDTH - 1):0] wr_mem_data,
    output  logic   [(BUS_WIDTH - 1):0] addr_mem_data,

    // signals for state maschine control
    input   logic   we_regf,
    input   logic   reg_dst,
    input   logic   alu_src,
    input   logic   [2:0] alu_cntrl,
    input   logic   mem_to_reg,
    input   logic   branch,
    input   logic   jump,
    output  logic   zero_f
);

    // signals program counter
    logic pcsrc;
    logic [(BUS_WIDTH - 1):0] next_addr, plus_addr, temp_addr,
                              brnch_addr, slt_jump, jump_addr;
    
    // regfile signals
    logic [(REG_ADDR  - 1):0] wrtreg3;
    logic [(REG_ADDR  - 1):0] addreg1, addreg2, addreg3;
    logic [(BUS_WIDTH - 1):0] rdreg1, rdreg2, wrdata3;
    
    // extension sign signals
    logic [(IMM_WIDTH - 1):0] immconst;
    logic [(BUS_WIDTH - 1):0] extimm, sltimm;

    // ALU signals
    logic [(BUS_WIDTH - 1):0] srcA, srcB, rsltALU;

    // program counter
    pc       U_0  (.clk(clk),
                   .rst(rst),
                   .in (next_addr),
                   .out(crnt_addr));
    
    // next command
    adder    U_1  (.a   (crnt_addr),
                   .b   (4),
                   .rslt(plus_addr));
    
    // branch instruction
    adder    U_2  (.a   (plus_addr),
                   .b   (sltimm),
                   .rslt(brnch_addr));

    // next instruction or branch
    assign pcsrc = branch & zero_f;

    // shift address in jump instr 
    slt2     U_3  (.in ({6'b0,instr[25:0]}),
                   .out(slt_jump));

    // jump or not jump
    mux2     U_4  (.a    (temp_addr),
                   .b    (jump_addr),
                   .cntrl(jump),
                   .out  (next_addr));

    // branch or next instruction
    mux2     U_5  (.a    (plus_addr),
                   .b    (brnch_addr),
                   .cntrl(pcsrc),
                   .out  (temp_addr));

    // spliting instruction
    assign addreg1   = instr[25:21];
    assign addreg2   = instr[20:16];
    assign immconst  = instr[15: 0];
    assign jump_addr = {plus_addr[31:28],slt_jump[27:0]};

    // immidiate or register instruction
    mux2     #(.DATA_WIDTH(5))   
             U_6  (.a    (instr[20:16]),
                   .b    (instr[15:11]),
                   .cntrl(reg_dst),
                   .out  (addreg3));

    // register file
    regfile  U_7  (.clk(clk),
                   .rst(rst),
                   .a1 (addreg1),
                   .a2 (addreg2),
                   .a3 (addreg3),
                   .we (we_regf),
                   .wd3(wrdata3),
                   .rd1(rdreg1),
                   .rd2(rdreg2));

    // extension sign number
    exsign   U_8  (.innum (immconst),
                   .outnum(extimm));

    // shift logic left
    slt2     U_9  (.in (extimm),
                   .out(sltimm));

    // ALU source
    mux2     U_10 (.a    (rdreg2),
                   .b    (extimm),
                   .cntrl(alu_src),
                   .out  (srcB));

    // ALU signals
    assign srcA = rdreg1;

    // ALU
    alu      U_11 (.a     (srcA),
                   .b     (srcB),
                   .cntrl (alu_cntrl),
                   .zero  (zero_f),
                   .result(rsltALU));

    // connect data memory
    assign wr_mem_data   = rdreg2;
    assign addr_mem_data = rsltALU;

    // load in memory or register
    mux2     U_12 (.a    (rsltALU),
                   .b    (mem_data),
                   .cntrl(mem_to_reg),
                   .out  (wrdata3));

endmodule: datapath
