`timescale 1ns / 1ps

module EX(
    input ALUSrc1,
    input ALUSrc2,
    input [11:0]ALUOP,
    input RegDst,
    input [31:0]inPC,
    input [31:0]RDataA,
    input [31:0]RDataB,
    input [31:0]imm32,
    input [4:0]rt,
    input [4:0]rd,
    input [4:0]shamt,
    output [4:0]WAddr,
    output [31:0]ALURes,
    output CF,
    output OF,
    output SF,
    output ZF,
    output [31:0]outPC
    );

    wire [31:0]alu_src1;
    wire [31:0]alu_src2;

    assign alu_src1=ALUSrc1? shamt:RDataA;
    assign alu_src2=ALUSrc2? imm32:RDataB;
    assign WAddr=RegDst? rd:rt;
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
