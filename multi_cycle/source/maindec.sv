// author: Filin I.A.
// functional: main decoderr multi cycle MIPS
// last revision: 22.02.24

`timescale 1ns/10ps

`include "parameters.vh"

typedef enum {
    state_choice,
    state_decode,
    state_SWorLW,
    state_OpcdLW,
    state_BackLW,
    state_BackSW,
    state_RgType,
    state_RgBack,
    state_BrType,
    state_AddiIn,
    state_JumpIn
} state;

module maindec
(
    input   logic   clk,
    input   logic   rst,

    input   logic   [5:0] opcode,

    // sel mux signal
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

    // alu operations
    output  logic   [1:0] alu_op
);

    // declare local signals
    state state_reg, state_next;

    // switch next state
    always_ff @(posedge clk)
    begin
        if(rst)
            state_reg <= state_choice;
        else
            state_reg <= state_next;
    end

    // logic next state
    always_comb
    begin
        unique case(state_reg)
            state_choice: 
                state_next = state_decode;

            state_decode: 
                unique case(opcode)
                    OPCODE_R_TYPE    : state_next = state_RgType;
                    OPCODE_LW_INSTR  : state_next = state_SWorLW;
                    OPCODE_SW_INSTR  : state_next = state_SWorLW;
                    OPCODE_BEQ_INSTR : state_next = state_BrType;
                    OPCODE_ADDI_INSTR: state_next = state_SWorLW;
                    OPCODE_J_INSTR   : state_next = state_JumpIn;
                endcase
            
            state_SWorLW:
                unique case(opcode)
                    OPCODE_LW_INSTR  : state_next = state_OpcdLW;
                    OPCODE_SW_INSTR  : state_next = state_BackSW;
                    OPCODE_ADDI_INSTR: state_next = state_AddiIn;
                endcase
            
            state_OpcdLW: 
                state_next = state_BackLW;
            
            state_BackLW: 
                state_next = state_choice;
            
            state_BackSW: 
                state_next = state_choice;
            
            state_RgType: 
                state_next = state_RgBack;
            
            state_RgBack: 
                state_next = state_choice;
            
            state_BrType: 
                state_next = state_choice;
            
            state_AddiIn: 
                state_next = state_choice;
            
            state_JumpIn: 
                state_next = state_choice;
        endcase
    end

    // output signals
    assign branch   =  (state_reg == state_BrType) ? SET : UNSET;
    assign memWrite =  (state_reg == state_BackSW) ? SET : UNSET;
    assign iRwrite  =  (state_reg == state_choice) ? SET : UNSET;
    assign pc_write = ((state_reg == state_choice) || (state_reg == state_JumpIn)) ? SET : UNSET;
    assign regWrite = ((state_reg == state_BackLW) || (state_reg == state_RgBack) || 
                                                      (state_reg == state_AddiIn)) ? SET : UNSET;

    // output sel signals
    assign IorD     = ((state_reg == state_OpcdLW) || (state_reg == state_BackSW)) ? SET : UNSET;
    assign regDst   =  (state_reg == state_RgBack) ? SET : UNSET;
    assign memToReg =  (state_reg == state_BackLW) ? SET : UNSET;
    assign aluSrc_a = ((state_reg == state_SWorLW) || (state_reg == state_RgType) || 
                       (state_reg == state_BrType)) ? SET : UNSET;
    assign pc_src   =  (state_reg == state_JumpIn) ? 2'b10 : ((state_reg == state_BrType) ? 2'b01 : 2'b00);
    assign aluSrc_b =  (state_reg == state_choice) ? 2'b01 : (state_reg == state_decode) ? 2'b11 : 
                       (state_reg == state_SWorLW) ? 2'b10 : 2'b00;
    assign alu_op   =  (state_reg == state_RgType) ? 2'b10 : (state_reg == state_BrType) ? 2'b01 : 2'b00;

endmodule : maindec