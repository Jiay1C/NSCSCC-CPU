`timescale 1ns / 1ps

module MEM(
    input CLK,
    input [31:0]ALURes,
    input CF,
    input OF,
    input SF,
    input ZF,
    input [31:0]MemWData,
    input inPCSrc,
    input MemWrite,
    output [31:0]MemRData,
    output outPCSrc
    );

    assign outPCSrc=inPCSrc;//此处替换为判断是否需要跳转的代码

    DM dm (
    .clka(CLK),    // input wire clka
    .wea(MemWrite),      // input wire [0 : 0] wea
    .addra(ALURes),  // input wire [15 : 0] addra
    .dina(MemWData),    // input wire [31 : 0] dina
    .douta(MemRData)  // output wire [31 : 0] douta
    );

endmodule
