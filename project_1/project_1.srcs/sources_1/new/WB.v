`timescale 1ns / 1ps

module WB(
    input CLK,
    input RST,
    input MemtoReg,
    input ExtratoReg,
    input CP0toReg,
    input MTC0,
    input ERET,
    input [31:0]ExtraData,
    input [31:0]MemRData,
    input [31:0]ALURes,
    input [4:0]ExcCode,
    input [31:0]CP0WData,
    input [4:0]CP0Addr,
    input [31:0]inPC,
    output [31:0]outPC,
    output [31:0]WData
    );

    wire [31:0]CP0Data;

    assign WData=CP0toReg?CP0Data:
                (ExtratoReg?ExtraData:
                (MemtoReg? MemRData:ALURes));
    
    CP0 cp0(
        .clk(CLK),
        .rst(RST),
        .mtc0(MTC0),
        .pc(inPC),
        .addr(CP0Addr),
        .wdata(CP0WData),
        .eret(ERET),
        .ExcCode(ExcCode),
        .rdata(CP0Data),
        .exc_addr(outPC)
    );
endmodule
