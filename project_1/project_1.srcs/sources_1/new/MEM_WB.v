`timescale 1ns / 1ps

module MEM_WB(
    input CLK,
    input RST,
    input [31:0]inMemRData,
    input [31:0]inALURes,
    input inRegWrite,
    input inMemtoReg,
    input [4:0]inWAddr,
    output reg [31:0]outMemRData,
    output reg [31:0]outALURes,
    output reg outRegWrite,
    output reg outMemtoReg,
    output reg [4:0]outWAddr
    );

    always @(posedge CLK) begin
        if(RST) {outMemRData,outALURes,outRegWrite,outMemtoReg,outWAddr}<=0;
        else begin
            outMemRData<=inMemRData;
            outALURes<=inALURes;
            outRegWrite<=inRegWrite;
            outMemtoReg<=inMemtoReg;
            outWAddr<=inWAddr;
        end
    end
endmodule
