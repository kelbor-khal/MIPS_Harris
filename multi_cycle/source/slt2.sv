// author: Filin I.A.
// functional: shift logic left
// last revision: 22.02.24

`timescale 1ns/10ps

module slt2
#(
    parameter ARG_WIDTH = 5
)
(
    input   logic   [(2**ARG_WIDTH - 1):0] in,

    output  logic   [(2**ARG_WIDTH - 1):0] out
);

    assign out = {in[29:0],2'b00};

endmodule: slt2