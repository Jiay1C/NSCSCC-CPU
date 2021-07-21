`timescale 1ns / 1ps

module ID2(
    input [5:0]opcode,
    input [5:0]funct,
    output reg RegWrite,
    output reg PCSrc,
    output reg MemWrite,
    output reg MemtoReg,
    output reg ALUSrc1,
    output reg ALUSrc2,
    output reg [11:0]ALUOP,
    output reg RegDst,
    output reg SignExt
    );

    always @(*) begin
        case (opcode)
        6'b000000: //R
        begin 
            RegDst=1;ALUSrc2=0;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;SignExt=0;
            case (funct)
                6'b100000:begin ALUOP=12'b000000000001;ALUSrc1=0; end   //add
                6'b100001:begin ALUOP=12'b000000000001;ALUSrc1=0; end   //addu
                6'b100010:begin ALUOP=12'b000000000010;ALUSrc1=0; end   //sub
                6'b100011:begin ALUOP=12'b000000000010;ALUSrc1=0; end   //subu
                6'b101010:begin ALUOP=12'b000000000100;ALUSrc1=0; end   //slt
                6'b101011:begin ALUOP=12'b000000001000;ALUSrc1=0; end   //sltu
                6'b100100:begin ALUOP=12'b000000010000;ALUSrc1=0; end   //and
                6'b100111:begin ALUOP=12'b000000100000;ALUSrc1=0; end   //nor
                6'b100101:begin ALUOP=12'b000001000000;ALUSrc1=0; end   //or
                6'b100110:begin ALUOP=12'b000010000000;ALUSrc1=0; end   //xor
                6'b000000:begin ALUOP=12'b000100000000;ALUSrc1=1; end   //sll
                6'b000010:begin ALUOP=12'b001000000000;ALUSrc1=1; end   //srl
                6'b000011:begin ALUOP=12'b010000000000;ALUSrc1=1; end   //sra

                6'b000100:begin ALUOP=12'b000100000000;ALUSrc1=0; end   //sllv
                6'b000110:begin ALUOP=12'b001000000000;ALUSrc1=0; end   //srlv
                6'b000111:begin ALUOP=12'b010000000000;ALUSrc1=0; end   //srav
                
                default:begin ALUOP=12'b000000000000;ALUSrc1=0; end
            endcase
        end

        //I
        6'b001000:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b000000000001;SignExt=0; end //ADDI
        6'b001001:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b000000000001;SignExt=1; end //ADDIU
        6'b001010:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b000000000100;SignExt=0; end //SLTI
        6'b001011:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b000000001000;SignExt=1; end //SLTIU
        6'b001100:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b000000010000;SignExt=1; end //ANDI
        6'b001101:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b000001000000;SignExt=1; end //ORI
        6'b001110:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b000010000000;SignExt=1; end //XORI
        6'b001111:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=0;ALUOP=12'b100000000000;SignExt=0; end //LUI
        6'b100011:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=0;RegWrite=1;MemtoReg=1;ALUOP=12'b000000000001;SignExt=0; end //LW
        6'b101011:begin RegDst=0;ALUSrc1=0;ALUSrc2=1;PCSrc=0;MemWrite=1;RegWrite=0;MemtoReg=0;ALUOP=12'b000000000001;SignExt=0; end //SW


        6'b000100:begin RegDst=0;ALUSrc1=0;ALUSrc2=0;PCSrc=1;MemWrite=0;RegWrite=0;MemtoReg=0;ALUOP=12'b000000000010;SignExt=0; end //BEQ
            default: begin RegDst=0;ALUSrc1=0;ALUSrc2=0;PCSrc=0;MemWrite=0;RegWrite=0;MemtoReg=0;ALUOP=12'b000000000000;SignExt=0; end
        endcase
    end

endmodule
