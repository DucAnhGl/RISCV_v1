module RegFile (
	input [4:0] ReadReg1,
	input [4:0] ReadReg2,
	input [4:0] WriteReg,
	input [31:0] WriteData,
	input RegWrite,
	output [31:0] ReadData1,
	output [31:0] ReadData2
);

reg [31:0] Registers[32];

always @(RegWrite) begin
	Registers[WriteReg] <= WriteData;
end


assign ReadData1 = Registers[ReadReg1];
assign ReadData2 = Registers[ReadReg2];


endmodule
