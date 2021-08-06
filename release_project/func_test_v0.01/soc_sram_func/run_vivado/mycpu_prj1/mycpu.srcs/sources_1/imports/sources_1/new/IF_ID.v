`timescale 1ns / 1ps

module IF_ID(
    input CLK,
    input RST,
    input [31:0]inPC,
    output reg [31:0]outPC,
    input [31:0]inInst,
    output reg [31:0]outInst
    );
    
    always @(posedge CLK) begin
        if(RST) {outPC,outInst}<=0;
        else begin
            outPC<=inPC;
            outInst<=inInst;
        end
    end
    
endmodule
