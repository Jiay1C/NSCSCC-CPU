`timescale 1ns / 1ps

module RegHILO(
    input CLK,
    input RST,
    input HIWrite,
    input LOWrite,
    input [31:0]WData,
    output reg [31:0]HI,
    output reg [31:0]LO
    );

    always @(posedge CLK) begin
        if(RST) {HI,LO}<=0;
        else begin
            if(HIWrite) HI<=WData;
            if(LOWrite) LO<=WData;
        end
    end
endmodule
