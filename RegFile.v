module RegFile (
    input clk,
	input [4:0] ReadReg1,
	input [4:0] ReadReg2,
	input [4:0] WriteReg,
	input [31:0] WriteData,
	input RegWrite,
	output [31:0] ReadData1,
	output [31:0] ReadData2
);

reg [31:0] Registers[32];

// Write on posedge clk, read on negedge clk to avoid data hazards.
always @((posedge clk) and RegWrite) begin
	Registers[WriteReg] <= WriteData;
end

always@(negedge clk) begin 
    ReadData1 <= Registers[ReadReg1];
    ReadData2 <= Registers[ReadReg2];
end

endmodule
