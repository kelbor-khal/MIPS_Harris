// author: Filin I.A.
// functional: adder
// last revision: 31.01.24

`timescale 1ns/10ps

module adder
#(
    parameter ARG_WIDTH = 5
)
(
    input   logic   [(2**ARG_WIDTH - 1):0] a, b,

    output  logic   [(2**ARG_WIDTH - 1):0] rslt
);

    assign rslt = a + b;

endmodule: adder