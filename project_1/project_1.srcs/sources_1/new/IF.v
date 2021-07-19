`timescale 1ns / 1ps

module IF(
    input CLK,
    input RST,
    input PCSrc,
    input [31:0]inPC,
    output [31:0]outPC,
    output [31:0]Inst
    );
    
    PC pc (
    .CLK(CLK),
    .RST(RST),
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
