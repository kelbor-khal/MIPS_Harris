// author: Filin I.A.
// functional: top file multi-cycle processor
// last revision: 12.03.24

`timescale 1ns/10ps

module top_multi_cycle(
    input   logic   clk,
    input   logic   rst,

    output  logic           we_mem,
    output  logic   [31:0]  addr_mem,
    output  logic   [31:0]  data_mem,
    output  logic   [31:0]  write_data
);

    // declare local signals
    logic memWrite;
    logic [31:0] mem_IorD, mem_addr, wr_mem_data;


    // mips multi-cycle
    mips U_0 (.clk        (clk),
              .rst        (rst),
              .mem_IorD   (mem_IorD),
              .memWrite   (memWrite),
              .mem_addr   (mem_addr),
              .wr_mem_data(wr_mem_data));

    // memory for multi-cicle
    mem  U_1 (.clk        (clk),
              .rst        (rst),
              .we         (memWrite),
              .addr       (mem_addr),
              .wr_data    (wr_mem_data),
              .mem_out    (mem_IorD));

    // output
    assign we_mem     = memWrite;
    assign addr_mem   = mem_addr;
    assign data_mem   = wr_mem_data;
    assign write_data = wr_mem_data;

endmodule : top_multi_cycle