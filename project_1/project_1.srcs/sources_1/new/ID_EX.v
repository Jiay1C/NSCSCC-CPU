`timescale 1ns / 1ps

module ID_EX(
    input CLK,
    input RST,
    input [31:0]inRDataA,
    input [31:0]inRDataB,
    input [31:0]inimm32,
    input [4:0]inrt,
    input [4:0]inrd,
    input inRegWrite,
    input inPCSrc,
    input inMemWrite,
    input inMemtoReg,
    input inALUSrc,
    input inALUOP,
    input inRegDst,
    input [31:0]inPC,
    output reg [31:0]outRDataA,
    output reg [31:0]outRDataB,
    output reg [31:0]outimm32,
    output reg [4:0]outrt,
    output reg [4:0]outrd,
    output reg outRegWrite,
    output reg outPCSrc,
    output reg outMemWrite,
    output reg outMemtoReg,
    output reg outALUSrc,
    output reg outALUOP,
    output reg outRegDst,
    output reg [31:0]outPC
    );
    
    always @(posedge CLK) begin
        if(RST) {outRDataA,outRDataB,outimm32,outrt,outrd,outRegWrite,outPCSrc,outMemWrite,outMemtoReg,outALUSrc,outALUOP,outRegDst,outPC}<=0;
        else begin
            outRDataA<=inRDataA;
            outRDataB<=inRDataB;
            outimm32<=inimm32;
            outrt<=inrt;
            outrd<=inrd;
            outRegWrite<=inRegWrite;
            outPCSrc<=inPCSrc;
            outMemWrite<=inMemWrite;
            outMemtoReg<=inMemtoReg;
            outALUSrc<=inALUSrc;
            outALUOP<=inALUOP;
            outRegDst<=inRegDst;
            outPC<=inPC;
        end
    end
endmodule
