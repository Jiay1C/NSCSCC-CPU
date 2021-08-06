`timescale 1ns / 1ps

module WB(
    input CLK,
    input RST,
    input MemtoReg,
    input ExtratoReg,
    input CP0toReg,
    input MTC0,
    input ERET,
    input Exception,
    input Overflow,
    input MemAddrError,
    input [31:0]ExtraData,
    input [31:0]MemRData,
    input [31:0]ALURes,
    input [4:0]ExcCode,
    input [31:0]CP0WData,
    input [4:0]CP0Addr,
    input [31:0]inPC,
    input [31:0]MemAddr,
    input MemWrite,
    input PCError,
    input [31:0]PC_IF,
    output [31:0]outPC,
    output [31:0]WData,
    output Empty,
    output PCSrc
    );

    wire [31:0]CP0Data;
    wire [31:0]PC_CP0;
    wire [4:0]ExcCode_CP0;
    wire [31:0]inPC_CP0;
    wire [31:0]MemAddr_CP0;
    
    assign outPC=(Exception||Overflow||MemAddrError||PCError)?32'hbfc00380:(PC_CP0+32'h4);
    assign Empty=(Overflow||MemAddrError);
    assign ExcCode_CP0=PCError?5'b00100:(MemAddrError?(MemWrite?5'b00101:5'b00100):(Overflow?5'b01100:ExcCode));
    assign PCSrc=Exception||Overflow||MemAddrError||ERET||PCError;
    assign inPC_CP0=PCError?PC_IF:inPC;
    assign MemAddr_CP0=PCError?PC_IF:MemAddr;

    assign WData=CP0toReg?CP0Data:
                (ExtratoReg?ExtraData:
                (MemtoReg? MemRData:ALURes));
    
    CP0 cp0(
        .clk(CLK),
        .rst(RST),
        .mtc0(MTC0),
        .pc(inPC_CP0),
        .addr(CP0Addr),
        .wdata(CP0WData),
        .eret(ERET),
        .ExcCode(ExcCode_CP0),
        .MemAddr(MemAddr_CP0),
        .rdata(CP0Data),
        .exc_addr(PC_CP0)
    );
endmodule
