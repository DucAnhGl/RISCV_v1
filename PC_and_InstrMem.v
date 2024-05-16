`include "PC.v"
`include "InstructionMem.v"
`include "32bit_Adder.v"

module PC_and_InstrMem (
    input clk,
    input rst,
    output [31:0] Instruction
    );

    wire [31:0] CurrentPC, NextPC;

    Adder_32bit PCAdder (
        .A_i (32'd4),
        .B_i (CurrentPC),
        .Sum_o (NextPC)
    );

    PC PC1 (
        .clk (clk),
        .rst (rst),
        .CurrentAddr (CurrentPC),
        .NextAddr (NextPC)
    );

    InstructionMem InstrMem (
        .PC_i (CurrentPC),
        .Instruction_o (Instruction)
    );

endmodule
