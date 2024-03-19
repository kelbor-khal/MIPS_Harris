// author: Filin I.A.
// functional: first simple test work proxessor
// last revision: 05.02.24

`timescale 1ns/10ps

module mips_test_harris();

    logic clk;
    logic rst;
    logic [31:0] write_data, data_addr;
    logic we_mem_out;
    
    // instantiate device to be tested
    top_one_cycle dut (.clk        (clk),
                       .rst        (rst),
                       .data_addr  (data_addr),
                       .write_data (write_data),
                       .we_mem_out (we_mem_out));
    
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