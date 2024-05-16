`include "2to1MUX.v"
`include "32bit_Adder.v"
`include "ALU_and_ALU_control.v"
`include "ControlUnit.v"
`include "DataMem.v"
`include "ImmGen.v"
`include "InstructionMem.v"
`include "PC.v"
`include "SC_RegFile.v"

module Single_Cycle_top (
    input clk, rst
    );

    wire [31:0] CurrentPC, NextPC, PCplus4, AddrCal, Instruction, Imm, WriteData, ReadData1, ReadData2, MemOrALU, AddrCalSrc, OprB, ALUOut, DataMemOut;  
    wire PCMUXSel, ALUFlag;
    wire RegWrEn, PCtoReg, OffsetBase, ALUSrc, MemRdEn, MemWrEn, MemtoReg, BrEn, UncBr; //Control lines
    wire [1:0] ALUOp;

    wire [4:0] Rs1, Rs2, Rd;
    wire [6:0] func7;
    wire [2:0] func3;

    assign Rd = Instruction[11:7];
    assign Rs1 = Instruction[19:15];
    assign Rs2 = Instruction[24:20];
    assign func7 = Instruction[31:25];
    assign func3 = Instruction[14:12];

    PC PC1 (
        .rst (rst),
        .clk (clk),
        .CurrentAddr (CurrentPC),
        .NextAddr (NextPC)
    );

    MUX2to1 PCMUX (
        .A_i (PCplus4),
        .B_i (AddrCal),
        .sel (PCMUXSel),
        .Out_o (NextPC)
    );

    Adder_32bit PCInc (
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

   SC_RegFile RegisterFile (
        .clk (clk),
        .rst (rst),
        .ReadReg1 (Rs1),
        .ReadReg2 (Rs2),
        .WriteReg (Rd),
        .WriteData (WriteData),
        .RegWrEn (RegWrEn),
        .ReadData1 (ReadData1),
        .ReadData2 (ReadData2)
   );

   MUX2to1 WriteDataMUX (
        .A_i (MemOrALU),
        .B_i (PCplus4),
        .sel (PCtoReg),
        .Out_o (WriteData)
   );

   Adder_32bit AddrCalAdder (
        .A_i (AddrCalSrc),
        .B_i (Imm),
        .Sum_o (AddrCal)
   );

   MUX2to1 AddrCalSrcMUX (
       .A_i (CurrentPC),
       .B_i (ReadData1),
       .sel (OffsetBase),
       .Out_o (AddrCalSrc)
   );

   ALU_and_ALU_control ALU_and_ALU_Control_main (
       .OperandA_i (ReadData1),
       .OperandB_i (OprB),
       .Funct7_i (func7),
       .Funct3_i (func3),
       .ALUOp_i (ALUOp),
       .Result_o (ALUOut),
       .Flag_o (ALUFlag)
   );

   MUX2to1 OperandBMUX (
       .A_i (ReadData2),
       .B_i (Imm),
       .sel (ALUSrc),
       .Out_o (OprB)
   );

   DataMem DataMemory (
        .clk (clk),
        .Address_i (ALUOut),
        .WriteData_i (ReadData2),
        .ReadEn_i (MemRdEn),
        .WriteEn_i (MemWrEn),
        .Data_o (DataMemOut)
   );

   MUX2to1 MemtoRegMUX (
        .A_i (ALUOut),
        .B_i (DataMemOut),
        .sel (MemtoReg),
        .Out_o (MemOrALU)
   );

   assign PCMUXSel = (ALUFlag & BrEn) | UncBr;

   ControlUnit Controlunit (
        .Instruction_i (Instruction),
        .ALUSrc_o (ALUSrc),
        .OffsetBase_o (OffsetBase),
        .BrEn_o (BrEn),
        .UncBr_o (UncBr),
        .MemWrEn_o (MemWrEn),
        .MemRdEn_o (MemRdEn),
        .MemtoReg_o (MemtoReg),
        .RegWrEn_o (RegWrEn),
        .PCtoReg_o (PCtoReg),
        .ALUOp_o (ALUOp)
   );


endmodule
