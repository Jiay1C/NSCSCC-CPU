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
    //SRAM
    input [31:0]inst_rdata,
    input inst_addr_ok,
    input inst_data_ok,
    output reg inst_req,
    output inst_wr,
    output [1:0]inst_size,
    output [31:0]inst_addr,
    output [31:0]inst_wdata
    );
    
    wire [31:0]inPC;
    wire PCSrc;
    wire IFEN;

    assign IFEN=(~MemBusy)&&PCEN;
    assign inPC=PCSrc3?inPC3:(PCSrc1?inPC1:inPC2);
    assign PCSrc=PCSrc1||PCSrc2||PCSrc3;

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

    assign Inst=inst_rdata;
    assign inst_size=2'h2;
    assign inst_addr=outPC;
    assign inst_wr=0;
    assign inst_wdata=32'b0;
    assign IMPause=inst_req;

    always @(posedge CLK or posedge inst_addr_ok or posedge inst_data_ok) begin
        if(CLK&&IFEN) begin
            inst_req=1;
        end
        else if(inst_addr_ok&&inst_data_ok) begin
            inst_req=0;
        end
    end
endmodule
