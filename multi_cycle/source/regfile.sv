// author: Filin I.A.
// functional: register file
// last revision: 22.02.24

`timescale 1ns/10ps

module regfile
#(
    parameter ADDR_WIDTH = 5,
    parameter DATA_WIDTH = 32
)
(
    input   logic   clk,
    input   logic   rst,
    
    input   logic   we,
    input   logic   [(ADDR_WIDTH - 1):0] a1, a2, a3,
    input   logic   [(DATA_WIDTH - 1):0] wd3,

    output  logic   [(DATA_WIDTH - 1):0] rd1, rd2
);

    // declare register
    logic [(DATA_WIDTH - 1):0] regf [(2**ADDR_WIDTH - 1):0];

    // write mode
    always_ff @(posedge clk)
    begin
        if(rst)
            for(int i=0; i < $size(regf); i++)
                regf[i] <= '0;
        else if(we)
            regf[a3] <= wd3; 
    end

    // read mode
    assign  rd1 = (a1 != 0) ? regf[a1] : 0;
    assign  rd2 = (a2 != 0) ? regf[a2] : 0;

endmodule: regfile