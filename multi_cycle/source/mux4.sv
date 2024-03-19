// author: Filin I.A.
// functional: mux 4
// last revision: 22.02.24

`timescale 1ns/10ps

module mux4
#(
    parameter DATA_WIDTH = 32
)
(
    input   logic   [1:0] cntrl,
    input   logic   [(DATA_WIDTH - 1):0] a, b, c, d,

    output  logic   [(DATA_WIDTH - 1):0] out
);

    always_comb
    begin
        case (cntrl)
            2'b00: out = a;
            2'b01: out = b;
            2'b10: out = c;
            2'b11: out = d;
        endcase
    end

endmodule: mux4