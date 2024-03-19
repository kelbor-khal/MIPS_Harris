// author: Filin I.A.
// functional: top file one-cycle processor
// last revision: 04.02.24

`timescale 1ns/10ps

module top_one_cycle (
    input   logic   clk,
    input   logic   rst,

    output  logic   [31:0] data_addr,
    output  logic   [31:0] write_data,
    output  logic   we_mem_out
);

    // declare local signals
    logic we_mem;
    logic [31:0] instr, addr_comm;
    logic [31:0] wr_mem_data, mem_data, addr_mem;

    // mips
    mips   U_0 (.clk         (clk),
                .rst         (rst),
                .instr       (instr),
                .we_mem      (we_mem),
                .mem_data    (mem_data),
                .crnt_addr   (addr_comm),
                .wr_mem_data (wr_mem_data),
                .addr_mem    (addr_mem));

    // memory command
    commem U_1 (.addr (addr_comm[7:2]),
                .instr(instr));

    // memory data
    datmem U_2 (.clk (clk),
                .in  (wr_mem_data),
                .addr(addr_mem),
                .we  (we_mem),
                .out (mem_data));

    // output signals
    assign we_mem_out = we_mem;
    assign data_addr  = addr_mem;
    assign write_data = wr_mem_data;


endmodule : top_one_cycle
