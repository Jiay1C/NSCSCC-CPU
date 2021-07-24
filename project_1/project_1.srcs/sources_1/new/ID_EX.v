`timescale 1ns / 1ps

module ID_EX(
    input CLK,
    input RST,
    input [31:0]inRDataA,
    input [31:0]inRDataB,
    input [31:0]inimm32,
    input [4:0]inrt,
    input [4:0]inrd,
    input [4:0]inshamt,
    input inRegWrite,
    input inHIWrite,
    input inLOWrite,
    input inPCSrc,
    input inMemWrite,
    input inMemtoReg,
    input inExtratoReg,
    input inALUSrc1,
    input [1:0]inALUSrc2,
    input [11:0]inALUOP,
    input [1:0]inRegDst,
    input [5:0]inBranchType,
    input [31:0]inExtraData,
    input [1:0]inMemSize,
    input inMemSignExt,
    input [31:0]inPC,
    output reg [31:0]outRDataA,
    output reg [31:0]outRDataB,
    output reg [31:0]outimm32,
    output reg [4:0]outrt,
    output reg [4:0]outrd,
    output reg [4:0]outshamt,
    output reg outRegWrite,
    output reg outHIWrite,
    output reg outLOWrite,
    output reg outPCSrc,
    output reg outMemWrite,
    output reg outMemtoReg,
    output reg outExtratoReg,
    output reg outALUSrc1,
    output reg [1:0]outALUSrc2,
    output reg [11:0]outALUOP,
    output reg [1:0]outRegDst,
    output reg [5:0]outBranchType,
    output reg [31:0]outExtraData,
    output reg [1:0]outMemSize,
    output reg outMemSignExt,
    output reg [31:0]outPC
    );
    
    always @(posedge CLK) begin
        if(RST) {outRDataA,outRDataB,outimm32,outrt,outrd,outshamt,outRegWrite,outHIWrite,outLOWrite,outPCSrc,outMemWrite,outMemtoReg,outExtratoReg,outALUSrc1,outALUSrc2,outALUOP,outRegDst,outBranchType,outExtraData,outMemSize,outMemSignExt,outPC}<=0;
        else begin
            outRDataA<=inRDataA;
            outRDataB<=inRDataB;
            outimm32<=inimm32;
            outrt<=inrt;
            outrd<=inrd;
            outshamt<=inshamt;
            outRegWrite<=inRegWrite;
            outHIWrite<=inHIWrite;
            outLOWrite<=inLOWrite;
            outPCSrc<=inPCSrc;
            outMemWrite<=inMemWrite;
            outMemtoReg<=inMemtoReg;
            outExtratoReg<=inExtratoReg;
            outALUSrc1<=inALUSrc1;
            outALUSrc2<=inALUSrc2;
            outALUOP<=inALUOP;
            outRegDst<=inRegDst;
            outBranchType<=inBranchType;
            outExtraData<=inExtraData;
            outMemSize<=inMemSize;
            outMemSignExt<=inMemSignExt;
            outPC<=inPC;
        end
    end
endmodule
