`timescale 1ns / 1ps

module EX_MEM(
    input CLK,
    input RST,
    input [31:0]inPC,
    input [31:0]inALURes,
    input inCF,
    input inOF,
    input inSF,
    input inZF,
    input [31:0]inMemWData,
    input [4:0]inWAddr,
    input inRegWrite,
    input inHIWrite,
    input inLOWrite,
    input inPCSrc,
    input [3:0]inMemWrite,
    input inMemtoReg,
    input inExtratoReg,
    input [5:0]inBranchType,
    input [31:0]inExtraData,
    output reg [31:0]outPC,
    output reg [31:0]outALURes,
    output reg outCF,
    output reg outOF,
    output reg outSF,
    output reg outZF,
    output reg [31:0]outMemWData,
    output reg [4:0]outWAddr,
    output reg outRegWrite,
    output reg outHIWrite,
    output reg outLOWrite,
    output reg outPCSrc,
    output reg [3:0]outMemWrite,
    output reg outMemtoReg,
    output reg outExtratoReg,
    output reg [5:0]outBranchType,
    output reg [31:0]outExtraData
    );

    always @(posedge CLK) begin
        if(RST) {outPC,outALURes,outCF,outOF,outSF,outZF,outMemWData,outWAddr,outRegWrite,outHIWrite,outLOWrite,outPCSrc,outMemWrite,outMemtoReg,outExtratoReg,outBranchType,outExtraData}<=0;
        else begin
            outPC<=inPC;
            outALURes<=inALURes;
            outCF<=inCF;
            outOF<=inOF;
            outSF<=inSF;
            outZF<=inZF;
            outMemWData<=inMemWData;
            outWAddr<=inWAddr;
            outRegWrite<=inRegWrite;
            outHIWrite<=inHIWrite;
            outLOWrite<=inLOWrite;
            outPCSrc<=inPCSrc;
            outMemWrite<=inMemWrite;
            outMemtoReg<=inMemtoReg;
            outExtratoReg<=inExtratoReg;
            outBranchType<=inBranchType;
            outExtraData<=inExtraData;
        end
    end
endmodule
