// author: Filin I.A.
// functional: first simple test work proxessor
// last revision: 14.03.24

`timescale 1ns/10ps

module mips_test_harris();

    logic clk;
    logic rst;
    logic [31:0] write_data, data_addr;
    logic we_mem_out;
    
    // instantiate device to be tested
    top_multi_cycle dut (.clk       (clk),
                         .rst       (rst),
                         .we_mem    (we_mem_out),
                         .addr_mem  (data_addr),
                         .data_mem  (),
                         .write_data(write_data));
    
    // initialize test
    initial
    begin
        rst <= 1; # 22; 
        rst <= 0;
    end
    
    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5;
        clk <= 0; # 5;
    end

    // check results
    always @(negedge clk)
    begin
        if (we_mem_out) begin
            if (data_addr === 84 & write_data === 7) 
            begin
                $display("Simulation succeeded");
                $stop;
            end 

            else if (data_addr !== 80) 
            begin
                $display("Simulation failed");
                $stop;
            end
        end
    end

endmodule : mips_test_harris