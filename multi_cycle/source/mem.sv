// author: Filin I.A.
// functional: memory multi-cycle processor
// last revision: 12.03.24

`timescale 1ns/10ps

//`define MODE_PROCESS_SYNT;

module mem 
#(
    parameter WIDTH     = 32,
    parameter NUM_IANDD = 9
)   
(
    input   logic   clk, 
    input   logic   rst,
    input   logic   we,

    input   logic   [31:0] addr,
    input   logic   [31:0] wr_data,

    output  logic   [31:0] mem_out
);

    // declare memory
    logic [(WIDTH - 1):0] mem [(2**NUM_IANDD - 1):0];

    `ifndef MODE_PROCESS_SYNT
        initial
        begin
            $readmemh("path_to_file", mem);
        end
    `endif

    always @(posedge clk)
    begin
        // write mode
        if(we)
            mem [addr[31:2]] <= wr_data;
    end

    // read mode
    assign mem_out = mem [addr[31:2]];

endmodule : mem