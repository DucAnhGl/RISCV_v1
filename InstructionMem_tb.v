`timescale 1ns/1ns
`include "InstructionMem.v"

module InstructionMem_tb;

	reg [31:0] PC;
	wire [31:0] Instruction;

	InstructionMem dut(
		.PC_i (PC),
		.Instruction_o (Instruction)
	);	

	initial begin 
		$dumpfile("InstructionMem_tb.vcd");
		$dumpvars(0, InstructionMem_tb);

		PC = 32'h00000000;
		#20;
		$display("PC = %h, Instr = %h", PC, Instruction);

		PC = 32'h00000004;
		#20;
		$display("PC = %h, Instr = %h", PC, Instruction);

		PC = 32'h00000008;
		#20;
		$display("PC = %h, Instr = %h", PC, Instruction);
		
		PC = 32'h0000000C;
		#20;
		$display("PC = %h, Instr = %h", PC, Instruction);

	end

endmodule 
