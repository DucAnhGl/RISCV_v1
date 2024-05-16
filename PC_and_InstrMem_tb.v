`timescale 1ns/1ns
`include "PC_and_InstrMem.v"

module PC_and_InstrMem_tb ();

    reg clk;
    reg rst;
    wire [31:0] Instruction;

    PC_and_InstrMem dut (
        .clk (clk),
        .rst (rst),
        .Instruction (Instruction)
    );
    
    initial begin
        $dumpfile("PC_and_InstrMem_tb.vcd");
        $dumpvars(0, PC_and_InstrMem_tb);
    end

    initial begin 
        clk = 0;
        forever begin 
         #5  clk = ~clk;
        end
    end

    initial begin
       #0 rst =1;
        #15;
        rst =0;
        #50;
        $finish;
    end


endmodule 
