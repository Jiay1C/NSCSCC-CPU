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
    input inPCSrc,
    input inMemWrite,
    input inMemtoReg,
    input inALUSrc1,
    input inALUSrc2,
    input [11:0]inALUOP,
    input inRegDst,
    input [5:0]inBranchType,
    input [31:0]inPC,
    output reg [31:0]outRDataA,
    output reg [31:0]outRDataB,
    output reg [31:0]outimm32,
    output reg [4:0]outrt,
    output reg [4:0]outrd,
    output reg [4:0]outshamt,
    output reg outRegWrite,
    output reg outPCSrc,
    output reg outMemWrite,
    output reg outMemtoReg,
    output reg outALUSrc1,
    output reg outALUSrc2,
    output reg [11:0]outALUOP,
    output reg outRegDst,
    output reg [5:0]outBranchType,
    output reg [31:0]outPC
    );
    
    always @(posedge CLK) begin
        if(RST) {outRDataA,outRDataB,outimm32,outrt,outrd,outshamt,outRegWrite,outPCSrc,outMemWrite,outMemtoReg,outALUSrc1,outALUSrc2,outALUOP,outRegDst,outBranchType,outPC}<=0;
        else begin
            outRDataA<=inRDataA;
            outRDataB<=inRDataB;
            outimm32<=inimm32;
            outrt<=inrt;
            outrd<=inrd;
            outshamt<=inshamt;
            outRegWrite<=inRegWrite;
            outPCSrc<=inPCSrc;
            outMemWrite<=inMemWrite;
            outMemtoReg<=inMemtoReg;
            outALUSrc1<=inALUSrc1;
            outALUSrc2<=inALUSrc2;
            outALUOP<=inALUOP;
            outRegDst<=inRegDst;
            outBranchType<=inBranchType;
            outPC<=inPC;
        end
    end
endmodule
