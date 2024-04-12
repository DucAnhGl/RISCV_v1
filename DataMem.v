module DataMem (
    input clk,

    input [31:0] Address_i,
    input [31:0] WriteData_i,

    input ReadEn_i,
    input WriteEn_i,

    output reg [31:0] Data_o 
);

reg [7:0] DataMemory[0:1023];

// Write on posedge clk, read on negedge clk
// Little-endian
always @((posedge clk) and WriteEn_i) begin
    {DataMemory[Address_i+3], DataMemory[Address_i+2], DataMemory[Address_i+1], DataMemory[Address_i]} <= WriteData_i;
    writememh("DataMem.mem", DataMemory);
end
  
always @((negedge clk) and ReadEn_i) begin
   readmemh("DataMem.mem", DataMemory);
   Data_o <= {DataMemory[Address_i+3], DataMemory[Address_i+2], DataMemory[Address_i+1], DataMemory[Address_i]}; 
end

endmodule
