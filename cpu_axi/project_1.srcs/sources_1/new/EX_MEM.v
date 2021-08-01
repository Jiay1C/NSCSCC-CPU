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
    input inHILOWrite,
    input inPCSrc,
    input inMemWrite,
    input inMemtoReg,
    input inExtratoReg,
    input [5:0]inBranchType,
    input [31:0]inExtraData,
    input [1:0]inMemSize,
    input inMemSignExt,
    input [63:0]inHILO,
    input inMTC0,
    input inERET,
    input [4:0]inExcCode,
    input inCP0toReg,
    input [4:0]inCP0Addr,
    input [31:0]inPC0,
    input inMemEN,
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
    output reg outHILOWrite,
    output reg outPCSrc,
    output reg outMemWrite,
    output reg outMemtoReg,
    output reg outExtratoReg,
    output reg [5:0]outBranchType,
    output reg [31:0]outExtraData,
    output reg [1:0]outMemSize,
    output reg outMemSignExt,
    output reg [63:0]outHILO,
    output reg outMTC0,
    output reg outERET,
    output reg [4:0]outExcCode,
    output reg outCP0toReg,
    output reg [4:0]outCP0Addr,
    output reg [31:0]outPC0,
    output reg outMemEN
    );

    always @(posedge CLK) begin
        if(RST) {outPC,outALURes,outCF,outOF,outSF,outZF,outMemWData,outWAddr,outRegWrite,outHIWrite,outLOWrite,outHILOWrite,outPCSrc,outMemWrite,outMemtoReg,outExtratoReg,outBranchType,outExtraData,outMemSize,outMemSignExt,outHILO,outMTC0,outERET,outExcCode,outCP0toReg,outCP0Addr,outPC0,outMemEN}<=0;
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
            outHILOWrite<=inHILOWrite;
            outPCSrc<=inPCSrc;
            outMemWrite<=inMemWrite;
            outMemtoReg<=inMemtoReg;
            outExtratoReg<=inExtratoReg;
            outBranchType<=inBranchType;
            outExtraData<=inExtraData;
            outMemSize<=inMemSize;
            outMemSignExt<=inMemSignExt;
            outHILO<=inHILO;
            outMTC0<=inMTC0;
            outERET<=inERET;
            outExcCode<=inExcCode;
            outCP0toReg<=inCP0toReg;
            outCP0Addr<=inCP0Addr;
            outPC0<=inPC0;
            outMemEN<=inMemEN;
        end
    end
endmodule
