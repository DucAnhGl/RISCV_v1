`timescale 1ns/1ns
`include "DataMem.v"

module DataMem_tb;
    
    reg clk_i;
    reg [31:0] Address_i, WriteData_i;
    reg ReadEn_i, WriteEn_i;

    wire [31:0] DataMemory_0;
    wire [31:0] Data_o;

    DataMem dut (
        .clk (clk_i),
        .Address_i (Address_i),
        .WriteData_i (WriteData_i),
        .ReadEn_i (ReadEn_i),
        .WriteEn_i (WriteEn_i),
        .Data_o (Data_o)
       // .DataMemory_0 (DataMemory_0)
    );

    initial begin
        $dumpfile("DataMem_tb.vcd");
        $dumpvars(0,DataMem_tb);
        
        clk_i = 1;

        Address_i = 32'h00000000;
        WriteData_i = 32'h000000AE;
        ReadEn_i = 1'b0;
        WriteEn_i = 1'b1;
        #20;
        toggle_clk;

        Address_i = 32'h00000000;
        WriteData_i = 32'h000000FF;
        ReadEn_i = 1'b1;
        WriteEn_i = 1'b0;
        #20;
        toggle_clk;

        Address_i = 32'h00000000;
        WriteData_i = 32'h000000DA;
        ReadEn_i = 1'b1;
        WriteEn_i = 1'b1;
        #20;
        toggle_clk;
        
    end

    task toggle_clk;
        begin
            #20 clk_i = ~clk_i;
            #10 clk_i = ~clk_i;
        end
    endtask

endmodule
