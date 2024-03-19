// author: Filin I.A.
// functional: dff
// last revision: 22.02.24

`timescale 1ns/10ps

module dff_m
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
    always_ff @(posedge clk or negedge rst)
    begin
        if(!rst)
            out <= 0;
        else
            out <= in;
    end

endmodule: dff_m