`timescale 1ns / 1ps

module MEM_WB(
    input CLK,
    input RST,
    input [31:0]inMemRData,
    input [31:0]inALURes,
    input inRegWrite,
    input inHIWrite,
    input inLOWrite,
    input inHILOWrite,
    input inMemtoReg,
    input inExtratoReg,
    input [4:0]inWAddr,
    input [31:0]inExtraData,
    input [63:0]inHILO,
    output reg [31:0]outMemRData,
    output reg [31:0]outALURes,
    output reg outRegWrite,
    output reg outHIWrite,
    output reg outLOWrite,
    output reg outHILOWrite,
    output reg outMemtoReg,
    output reg outExtratoReg,
    output reg [4:0]outWAddr,
    output reg [31:0]outExtraData,
    output reg [63:0]outHILO
    );

    always @(posedge CLK) begin
        if(RST) {outMemRData,outALURes,outRegWrite,outHIWrite,outLOWrite,outHILOWrite,outMemtoReg,outExtratoReg,outWAddr,outExtraData,outHILO}<=0;
        else begin
            outMemRData<=inMemRData;
            outALURes<=inALURes;
            outRegWrite<=inRegWrite;
            outHIWrite<=inHIWrite;
            outLOWrite<=inLOWrite;
            outHILOWrite<=inHILOWrite;
            outMemtoReg<=inMemtoReg;
            outExtratoReg<=inExtratoReg;
            outWAddr<=inWAddr;
            outExtraData<=inExtraData;
            outHILO<=inHILO;
        end
    end
endmodule
