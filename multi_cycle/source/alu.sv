// author: Filin I.A.
// functional: ALU
// last revision: 22.02.24

`timescale 1ns/10ps

module alu
#(
    parameter CNTRL_WIDTH = 3,
    parameter DATA_WIDTH  = 5
)
(
    input   logic   [(2**DATA_WIDTH - 1):0] a, b,
    input   logic   [(CNTRL_WIDTH   - 1):0] cntrl,

    output  logic   [(2**DATA_WIDTH - 1):0] result,
    output  logic   zero  
);

    always_comb
    begin
        case(cntrl)
            3'b000: result =  a  &  b;
            3'b001: result =  a  |  b;
            3'b010: result =  a  +  b;
            3'b100: result =  a  & ~b;
            3'b101: result =  a  | ~b;
            3'b110: result =  a  -  b;
            3'b111: result = (a < b) ? 1 : 0;
            default:          result = 32'bx;
        endcase
    end

    // zero result
    assign zero = (a == b) ? 1'b1 : 1'b0;

endmodule: alu