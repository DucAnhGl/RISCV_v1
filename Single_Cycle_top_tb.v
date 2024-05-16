`timescale 1ns/1ns
`include "Single_Cycle_top.v"

module Single_Cycle_top_tb;
    reg clk, rst;

    Single_Cycle_top Single_Cycle_dut (
        .clk (clk),
        .rst (rst)
    );

    initial begin
        $dumpfile("Single_Cycle_top_tb.vcd");
        $dumpvars(0,Single_Cycle_top_tb);
    end

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        rst =1;
        #5;
        rst =0;
        #250;
        $finish;
    end

endmodule
