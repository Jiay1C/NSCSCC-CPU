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
    input inMTC0,
    input inERET,
    input [4:0]inExcCode,
    input inCP0toReg,
    input [31:0]inCP0WData,
    input [4:0]inCP0Addr,
    input [31:0]inPC0,
    input inException,
    input inOverflow,
    input inMemAddrError,
    input [31:0]inMemAddr,
    input inMemWrite,
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
    output reg [63:0]outHILO,
    output reg outMTC0,
    output reg outERET,
    output reg [4:0]outExcCode,
    output reg outCP0toReg,
    output reg [31:0]outCP0WData,
    output reg [4:0]outCP0Addr,
    output reg [31:0]outPC0,
    output reg outException,
    output reg outOverflow,
    output reg outMemAddrError,
    output reg [31:0]outMemAddr,
    output reg outMemWrite
    );

    always @(posedge CLK) begin
        if(RST) {outMemRData,outALURes,outRegWrite,outHIWrite,outLOWrite,outHILOWrite,outMemtoReg,outExtratoReg,outWAddr,outExtraData,outHILO,outMTC0,outERET,outExcCode,outCP0toReg,outCP0WData,outCP0Addr,outPC0,outException,outOverflow,outMemAddrError,outMemAddr,outMemWrite}<=0;
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
            outMTC0<=inMTC0;
            outERET<=inERET;
            outExcCode<=inExcCode;
            outCP0toReg<=inCP0toReg;
            outCP0WData<=inCP0WData;
            outCP0Addr<=inCP0Addr;
            outPC0<=inPC0;
            outException<=inException;
            outOverflow<=inOverflow;
            outMemAddrError<=inMemAddrError;
            outMemAddr<=inMemAddr;
            outMemWrite<=inMemWrite;
        end
    end
endmodule
