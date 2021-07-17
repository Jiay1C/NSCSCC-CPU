`timescale 1ns / 1ps

module PC(
    input CLK,
    input RST,
    input PCSrc,
    input [31:0]inPC,
    output reg [31:0]outPC
    );
    always @(posedge CLK) begin
        if(RST) outPC=32'b0;
        else begin
            if(PCSrc) outPC=inPC;
            else outPC=outPC+32'h4;
        end
    end
endmodule
