`timescale 1ns / 1ps

module IF(
    input CLK,
    input RST,
    input PCEN,
    input MemBusy,
    input PCSrc1,
    input PCSrc2,
    input PCSrc3,
    input [31:0]inPC1,
    input [31:0]inPC2,
    input [31:0]inPC3,
    output [31:0]outPC,
    output [31:0]Inst,
    output IMPause,
    output PCError,
    //SRAM
    output inst_sram_en,
    output [3:0]inst_sram_wen,
    output [31:0]inst_sram_addr,
    output [31:0]inst_sram_wdata,
    input  [31:0]inst_sram_rdata
    );
    
    wire [31:0]inPC;
    wire PCSrc;
    wire IFEN;

    assign IFEN=PCEN;
    assign inPC=PCSrc3?inPC3:(PCSrc1?inPC1:inPC2);
    assign PCSrc=PCSrc1||PCSrc2||PCSrc3;
    assign PCError=(outPC[1:0]!=2'b0);

    PC pc (
    .CLK(~CLK),
    .RST(RST),
    .PCEN(IFEN),
    .PCSrc(PCSrc),
    .inPC(inPC),
    .outPC(outPC)
    );

    /*
    IM im (
    .clka(CLK),    // input wire clka
    .addra(outPC>>2),  // input wire [15 : 0] addra
    .douta(Inst)  // output wire [31 : 0] douta
    );
    */
    assign inst_sram_en=1;
    assign inst_sram_addr=outPC;
    assign inst_sram_wen=0;
    assign inst_sram_wdata=32'b0;
    assign Inst=PCError?0:inst_sram_rdata;
    assign IMPause=0;
    
endmodule
