// author: Filin I.A.
// functional: programm counter
// last revision: 22.02.24

`timescale 1ns/10ps

module dffe_m
#(
    parameter WIDTH = 5
)
(
    input   logic   clk,
    input   logic   rst,

    input   logic   en,
    
    input   logic   [(2**WIDTH - 1):0] in,

    output  logic   [(2**WIDTH - 1):0] out
);

    // declare register
    always @(posedge clk or negedge rst)
    begin
        if(!rst)
            out <= 0;
        else 
            if(en)
                out <= in;

    end

endmodule: dffe_m