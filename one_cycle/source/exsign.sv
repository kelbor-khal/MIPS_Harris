// author: Filin I.A.
// functional: extension sign number
// last revision: 31.01.24

`timescale 1ns/10ps

module exsign
#(
    parameter IN_WIDTH  = 4,
    parameter OUT_WIDTH = 5
)
(
    input   logic   [(2**IN_WIDTH -  1):0] innum,

    output  logic   [(2**OUT_WIDTH - 1):0] outnum
);

    assign outnum = {{16{innum[(2**IN_WIDTH - 1)]}},innum};

endmodule: exsign