module SC_RegFile (
    input clk,
    input rst,
	input [4:0] ReadReg1,
	input [4:0] ReadReg2,
	input [4:0] WriteReg,
	input [31:0] WriteData,
	input RegWrEn,
	output reg [31:0] ReadData1,
	output reg [31:0] ReadData2
);

reg [31:0] Registers[0:31];

//Create Regiters varibles for waveform dumping
wire [31:0] Reg_out_0, Reg_out_1, Reg_out_2, Reg_out_3,
            Reg_out_4, Reg_out_5, Reg_out_6, Reg_out_7,
            Reg_out_8, Reg_out_9, Reg_out_10,
            Reg_out_11, Reg_out_12,Reg_out_13, Reg_out_14,
            Reg_out_15, Reg_out_16, Reg_out_17, Reg_out_18,
            Reg_out_19, Reg_out_20, Reg_out_21, Reg_out_22,
            Reg_out_23, Reg_out_24, Reg_out_25, Reg_out_26,
            Reg_out_27, Reg_out_28,Reg_out_29, Reg_out_30,Reg_out_31;

assign Reg_out_0 = Registers[0];
assign Reg_out_1 = Registers[1];
assign Reg_out_2 = Registers[2];
assign Reg_out_3 = Registers[3];
assign Reg_out_4 = Registers[4];
assign Reg_out_5 = Registers[5];
assign Reg_out_6 = Registers[6];
assign Reg_out_7 = Registers[7];
assign Reg_out_8 = Registers[8];
assign Reg_out_9 = Registers[9];
assign Reg_out_10 = Registers[10];
assign Reg_out_11 = Registers[11];
assign Reg_out_12 = Registers[12];
assign Reg_out_13 = Registers[13];
assign Reg_out_14 = Registers[14];
assign Reg_out_15 = Registers[15];
assign Reg_out_16 = Registers[16];
assign Reg_out_17 = Registers[17];
assign Reg_out_18 = Registers[18];
assign Reg_out_19 = Registers[19];
assign Reg_out_20 = Registers[20];
assign Reg_out_21 = Registers[21];
assign Reg_out_22 = Registers[22];
assign Reg_out_23 = Registers[23];
assign Reg_out_24 = Registers[24];
assign Reg_out_25 = Registers[25];
assign Reg_out_26 = Registers[26];
assign Reg_out_27 = Registers[27];
assign Reg_out_28 = Registers[28];
assign Reg_out_29 = Registers[29];
assign Reg_out_30 = Registers[30];
assign Reg_out_31 = Registers[31];

////////////////////////////////////////////////////////////////////////


// Write on posedge clk, read on negedge clk to avoid data hazards.
always @(posedge clk or posedge rst) begin
    if (rst) begin
        Registers[0] <= 32'd0;
        Registers[1] <= 32'd0;
        Registers[2] <= 32'd0;
        Registers[3] <= 32'd0;
        Registers[4] <= 32'd0;
        Registers[5] <= 32'd0;
        Registers[6] <= 32'd0;
        Registers[7] <= 32'd0;
        Registers[8] <= 32'd0;
        Registers[9] <= 32'd0;
        Registers[10] <= 32'd0;
        Registers[11] <= 32'd0;
        Registers[12] <= 32'd0;
        Registers[13] <= 32'd0;
        Registers[14] <= 32'd0;
        Registers[15] <= 32'd0;
        Registers[16] <= 32'd0;
        Registers[17] <= 32'd0;
        Registers[18] <= 32'd0;
        Registers[19] <= 32'd0;
        Registers[20] <= 32'd0;
        Registers[21] <= 32'd0;
        Registers[22] <= 32'd0;
        Registers[23] <= 32'd0;
        Registers[24] <= 32'd0;
        Registers[25] <= 32'd0;
        Registers[26] <= 32'd0;
        Registers[27] <= 32'd0;
        Registers[28] <= 32'd0;
        Registers[29] <= 32'd0;
        Registers[30] <= 32'd0;
        Registers[31] <= 32'd0;
    end
	if (RegWrEn) Registers[WriteReg] <= WriteData;
end

always@(*) begin 
    ReadData1 = Registers[ReadReg1];
    ReadData2 = Registers[ReadReg2];
end

endmodule
