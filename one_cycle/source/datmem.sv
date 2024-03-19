// author: Filin I.A.
// functional: data strotage
// last revision: 31.01.24

`timescale 1ns/10ps

module datmem 
#(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32
)
(
    input   logic   clk,
    input   logic   we,

    input   logic   [(DATA_WIDTH - 1):0] addr,
    input   logic   [(DATA_WIDTH - 1):0] in,

    output  logic   [(DATA_WIDTH - 1):0] out
);

    // declare RAM
    logic [(DATA_WIDTH - 1):0] ram [(2**ADDR_WIDTH - 1):0];

    // write mode
    always_ff @(posedge clk)
    begin
        if(we)
            ram[addr[31:2]] <= in;
    end

    // read mode
    assign out = ram[addr[31:2]];

endmodule: datmem