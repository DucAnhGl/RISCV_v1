`include "2to1MUX.v"
`include "32bit_Adder.v"
`include "ALU_and_ALU_control.v"
`include "ControlUnit.v"
`include "DataMem.v"
`include "ImmGen.v"
`include "InstructionMem.v"
`include "PC.v"
`include "RegFile.v"

module Single_Cycle_top (
    input clk
    );

    wire [31:0] CurrentPC, NextPC, PCplus4, AddrCal, Instruction, Imm, WriteData, ReadData1, ReadData2, MemOrALU, AddCalSrc;  
    wire PCMUXSel;
    wire RegWrEn, PCtoReg;
    wire [4:0] Rs1, Rs2, Rd;

    assign Rd = Instruction[11:7];
    assign Rs1 = Instruction[19:15];
    assign Rs2 = Instruction[24:20];

    PC PC1 (
        .clk (clk),
        .CurrentAddr (CurrentPC),
        .NextAddr (NextPC)
    );

    2to1MUX PCMUX (
        .A_i (PCplus4),
        .B_i (AddrCal),
        .sel (PCMUXSel),
        .Out_o (NextPC)
    );

    32bit_Adder PCInc (
        .A_i (32'd4),
        .B_i (CurrentPC),
        .Sum_o (PCplus4)
    );

    InstructionMem InstrMem (
        .PC_i (CurrentPC),
        .Instruction_o (Instruction) 
    );

    ImmGen ImmExt (
        .Instruction_i (Instruction),
        .Immediate_o (Imm)
    );

   RegFile RegisterFile (
        .clk (clk),
        .ReadReg1 (Rs1),
        .ReadReg2 (Rs2),
        .WriteReg (Rd),
        .WriteData (WriteData),
        .RegWrEn (RegWrEn),
        .ReadData1 (ReadData1),
        .ReadData2 (ReadData2)
   );

   2to1MUX WriteDataMUX (
        .A_i (MemOrALU),
        .B_i (PCplus4),
        .sel (PCtoReg),
        .Out_o (writeData)
   );

   32bit_Adder AddrCalAdder (
        .A_i (AddrCalSrc),
        .B_i (Imm),
        .Sum_o (AddrCal)
   );
   

endmodule
