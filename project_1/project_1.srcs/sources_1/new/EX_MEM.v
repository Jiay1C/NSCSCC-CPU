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
    input inPCSrc,
    input inMemWrite,
    input inMemtoReg,
    output reg [31:0]outPC,
    output reg [31:0]outALURes,
    output reg outCF,
    output reg outOF,
    output reg outSF,
    output reg outZF,
    output reg [31:0]outMemWData,
    output reg [4:0]outWAddr,
    output reg outRegWrite,
    output reg outPCSrc,
    output reg outMemWrite,
    output reg outMemtoReg
    );

    always @(posedge CLK) begin
        if(RST) {outPC,outALURes,outCF,outOF,outSF,outZF,outMemWData,outWAddr,outRegWrite,outPCSrc,outMemWrite,outMemtoReg}<=0;
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
            outPCSrc<=inPCSrc;
            outMemWrite<=inMemWrite;
            outMemtoReg<=inMemtoReg;
        end
    end
endmodule
