`timescale 1ns / 1ps

module ID2(
    input [5:0]opcode,
    input [5:0]funct,
    output reg RegWrite,
    output reg PCSrc,
    output reg MemWrite,
    output reg MemtoReg,
    output reg ALUSrc,
    output reg [11:0]ALUOP,
    output reg RegDst
    );

    always @(*) begin
        case (opcode)
        6'b000000:
        begin 
            RegDst=1;ALUSrc=0;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0; 
            case (funct)
                6'b100000: ALUOP=12'b000000000001;
                6'b100010: ALUOP=12'b000000000010;
                6'b101010: ALUOP=12'b000000000100;
                6'b101011: ALUOP=12'b000000001000;
                6'b100100: ALUOP=12'b000000010000;
                6'b100111: ALUOP=12'b000000100000;
                6'b100101: ALUOP=12'b000001000000;
                6'b100110: ALUOP=12'b000010000000;
                6'b000000: ALUOP=12'b000100000000;
                6'b000010: ALUOP=12'b001000000000;
                6'b000011: ALUOP=12'b010000000000;
                default: ALUOP=12'b000000000000;
            endcase
        end //R
        6'b100011:begin RegDst=0;ALUSrc=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=1;ALUOP=12'b000000000001; end //LW
        6'b101011:begin RegDst=0;ALUSrc=1;PCSrc=0;MemWrite=1;RegWrite=0;MemtoReg=0;ALUOP=12'b000000000001; end //SW
        6'b000100:begin RegDst=0;ALUSrc=0;PCSrc=1;MemWrite=0;RegWrite=0;MemtoReg=0;ALUOP=12'b000000000010; end //BEQ
            default: begin RegDst=0;ALUSrc=0;PCSrc=0;MemWrite=0;RegWrite=0;MemtoReg=0;ALUOP=12'b000000000000; end
        endcase
    end

endmodule
