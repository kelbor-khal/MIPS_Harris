// author: Filin I.A.
// functional: programm strotage
// last revision: 31.01.24

`timescale 1ns/10ps

//`define MODE_PROCESS_SYNT;

module commem 
#(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32
)
(    
    input   logic   [5:0] addr,

    output  logic   [(DATA_WIDTH - 1):0] instr
);

    // declare ROM
    logic [(DATA_WIDTH - 1):0] ram [(2**ADDR_WIDTH - 1):0];

   // intial ROM for synthesis
   `ifndef MODE_PROCESS_SYNT
       initial
       begin
           $readmemh("path_to_file", ram);
       end
   `endif

    assign instr = ram[addr];

endmodule : commem