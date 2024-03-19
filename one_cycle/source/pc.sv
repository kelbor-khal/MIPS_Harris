// author: Filin I.A.
// functional: programm counter
// last revision: 31.01.24

`timescale 1ns/10ps

module pc
#(
    parameter WIDTH = 5
)
(
    input   logic   clk,
    input   logic   rst,
    input   logic   [(2**WIDTH - 1):0] in,

    output  logic   [(2**WIDTH - 1):0] out
);

    // declare register
    always_ff @(posedge clk or posedge rst)
    begin
        if(rst)
            out <= 0;
        else
            out <= in;
    end

endmodule: pc