module ControlUnit (
    input [31:0] Instruction_i,
    output reg ALUSrc_o, OffsetBase_o, BrEn_o, UncBr_o, MemWrEn_o, MemRdEn_o, MemtoReg_o, RegWrEn_o, PCtoReg_o,
    output reg [1:0] ALUOp_o
    );

    parameter R_type    = 7'b0110011,
              Imm_A_L   = 7'b0010011,
              Load      = 7'b0000011,
              Store     = 7'b0100011,
              SB_type   = 7'b1100011,
              Lui       = 7'b0110111,
              jal       = 7'b1101111,
              jalr      = 7'b1100111;

    wire [6:0] Opcode;
    assign Opcode = Instruction_i[6:0];

    always@ (*) begin 
        case (Opcode)
            R_type: begin
               ALUOp_o = 2'b00; ALUSrc_o = 1'b0; OffsetBase_o = 1'bx; BrEn_o = 1'b0; UncBr_o = 1'b0; MemWrEn_o = 1'b0; MemRdEn_o = 1'b0; MemtoReg_o = 1'b0; RegWrEn_o = 1'b1; PCtoReg_o = 1'b0;
            end

            Imm_A_L: begin
               ALUOp_o = 2'b00; ALUSrc_o = 1'b1; OffsetBase_o = 1'bx; BrEn_o = 1'b0; UncBr_o = 1'b0; MemWrEn_o = 1'b0; MemRdEn_o = 1'b0; MemtoReg_o = 1'b0; RegWrEn_o = 1'b1; PCtoReg_o = 1'b0;
            end

            Load: begin
               ALUOp_o = 2'b01; ALUSrc_o = 1'b1; OffsetBase_o = 1'bx; BrEn_o = 1'b0; UncBr_o = 1'b0; MemWrEn_o = 1'b0; MemRdEn_o = 1'b1; MemtoReg_o = 1'b1; RegWrEn_o = 1'b1; PCtoReg_o = 1'b0;
            end

            Store: begin
               ALUOp_o = 2'b01; ALUSrc_o = 1'b1; OffsetBase_o = 1'bx; BrEn_o = 1'b0; UncBr_o = 1'b0; MemWrEn_o = 1'b1; MemRdEn_o = 1'b0; MemtoReg_o = 1'bx; RegWrEn_o = 1'b0; PCtoReg_o = 1'bx;
            end

            SB_type: begin
               ALUOp_o = 2'b10; ALUSrc_o = 1'b0; OffsetBase_o = 1'b0; BrEn_o = 1'b1; UncBr_o = 1'b0; MemWrEn_o = 1'b0; MemRdEn_o = 1'b0; MemtoReg_o = 1'bx; RegWrEn_o = 1'b0; PCtoReg_o = 1'bx;
            end
            
            Lui: begin
               ALUOp_o = 2'b11; ALUSrc_o = 1'b1; OffsetBase_o = 1'bx; BrEn_o = 1'b0; UncBr_o = 1'b0; MemWrEn_o = 1'b0; MemRdEn_o = 1'b0; MemtoReg_o = 1'b0; RegWrEn_o = 1'b1; PCtoReg_o = 1'b0;
            end

            jal: begin
               ALUOp_o = 2'bxx; ALUSrc_o = 1'bx; OffsetBase_o = 1'b0; BrEn_o = 1'bx; UncBr_o = 1'b1; MemWrEn_o = 1'b0; MemRdEn_o = 1'b0; MemtoReg_o = 1'bx; RegWrEn_o = 1'b1; PCtoReg_o = 1'b1;
            end

            jalr: begin
               ALUOp_o = 2'bxx; ALUSrc_o = 1'bx; OffsetBase_o = 1'b1; BrEn_o = 1'bx; UncBr_o = 1'b1; MemWrEn_o = 1'b0; MemRdEn_o = 1'b0; MemtoReg_o = 1'bx; RegWrEn_o = 1'b1; PCtoReg_o = 1'b1;
            end

            default: begin
               ALUOp_o = 2'b00; ALUSrc_o = 1'b0; OffsetBase_o = 1'bx; BrEn_o = 1'b0; UncBr_o = 1'b0; MemWrEn_o = 1'b0; MemRdEn_o = 1'b0; MemtoReg_o = 1'b0; RegWrEn_o = 1'b1; PCtoReg_o = 1'b0;
            end

           
        endcase
    end

endmodule
