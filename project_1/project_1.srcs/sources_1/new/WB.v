`timescale 1ns / 1ps

module WB(
    input MemtoReg,
    input [31:0]MemRData,
    input [31:0]ALURes,
    output [31:0]WData
    );

    assign WData=MemtoReg? MemRData:ALURes;
    
endmodule
