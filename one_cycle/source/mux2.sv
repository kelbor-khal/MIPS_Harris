// author: Filin I.A.
// functional: mux
// last revision: 31.01.24

`timescale 1ns/10ps

module mux2
#(
    parameter DATA_WIDTH = 32
)
(
    input   logic   cntrl,
    input   logic   [(DATA_WIDTH - 1):0] a, b,

    output  logic   [(DATA_WIDTH - 1):0] out
);

    assign out = (cntrl == 0) ? a: b;

endmodule: mux2