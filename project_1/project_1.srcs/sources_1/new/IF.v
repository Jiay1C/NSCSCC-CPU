`timescale 1ns / 1ps

module IF(
    input CLK,
    input RST,
    input PCEN,
    input PCSrc1,
    input PCSrc2,
    input [31:0]inPC1,
    input [31:0]inPC2,
    output [31:0]outPC,
    output [31:0]Inst
    );
    
    wire [31:0]inPC;
    wire PCSrc;

    assign inPC=PCSrc1?inPC1:inPC2;
    assign PCSrc=PCSrc1|PCSrc2;

    PC pc (
    .CLK(~CLK),
    .RST(RST),
    .PCEN(PCEN),
    .PCSrc(PCSrc),
    .inPC(inPC),
    .outPC(outPC)
    );

    IM im (
    .clka(CLK),    // input wire clka
    .addra(outPC>>2),  // input wire [15 : 0] addra
    .douta(Inst)  // output wire [31 : 0] douta
    );

endmodule
