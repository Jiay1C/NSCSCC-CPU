`timescale 1ns / 1ps

module EX(
    input ALUSrc1,
    input [1:0]ALUSrc2,
    input [11:0]ALUOP,
    input [1:0]RegDst,
    input [31:0]inPC,
    input [31:0]RDataA,
    input [31:0]RDataB,
    input [31:0]imm32,
    input [4:0]rt,
    input [4:0]rd,
    input [4:0]shamt,
    output reg [4:0]WAddr,
    output [31:0]ALURes,
    output CF,
    output OF,
    output SF,
    output ZF,
    output [31:0]outPC
    );

    reg [31:0]alu_src1;
    reg [31:0]alu_src2;

    always @(*) begin
        case (ALUSrc1)
            1'b1: alu_src1=shamt;
            1'b0: alu_src1=RDataA;
            default: alu_src1=32'b0;
        endcase
        case (ALUSrc2)
            2'h2: alu_src2=32'b0;
            2'h1: alu_src2=imm32;
            2'h0: alu_src2=RDataB;
            default: alu_src2=32'b0;
        endcase
        case (RegDst)
            2'h2: WAddr=5'b11111;
            2'h1: WAddr=rd;
            2'h0: WAddr=rt;
            default: WAddr=5'b0;
        endcase
    end

    assign outPC=inPC+(imm32<<2);

    ALU alu(
        .alu_src1(alu_src1),
        .alu_src2(alu_src2),
        .alu_op(ALUOP),
        .alu_res(ALURes),
        .alu_ZF(ZF),
        .alu_CF(CF),
        .alu_SF(SF),
        .alu_OF(OF)
    );

endmodule
