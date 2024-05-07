module DataMem (
    input clk,

    input [31:0] Address_i,
    input [31:0] WriteData_i,

    input ReadEn_i,
    input WriteEn_i,

    output reg [31:0] Data_o
);

wire [31:0] DataMemory_0;
reg [7:0] DataMemory[0:1023];

assign DataMemory_0 ={DataMemory[3], DataMemory[2], DataMemory[1], DataMemory[0]};

// Write on posedge clk, read on negedge clk
// Little-endian
always @(posedge clk) begin
    if (WriteEn_i==1'b1) begin
        DataMemory[Address_i+3] <= WriteData_i[31:24];
        DataMemory[Address_i+2] <= WriteData_i[23:16];
        DataMemory[Address_i+1] <= WriteData_i[15:8];
        DataMemory[Address_i] <= WriteData_i[7:0];
    end
//    $writememh("DataMem.mem", DataMemory, 0, 1023);
end
  
always @(negedge clk) begin
//    $readmemh("DataMem.mem", DataMemory);
    if (ReadEn_i==1'b1) Data_o <= {DataMemory[Address_i+3], DataMemory[Address_i+2], DataMemory[Address_i+1], DataMemory[Address_i]};
end

endmodule
