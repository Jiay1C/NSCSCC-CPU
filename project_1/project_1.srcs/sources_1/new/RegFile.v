`timescale 1ns / 1ps

module RegFile(
    input CLK,
    input RST,
    input RegWrite,
    input [4:0]R_Addr_A,
    input [4:0]R_Addr_B,
    input [4:0]W_Addr,
    input [31:0]W_Data,
    output [31:0]R_Data_A,
    output [31:0]R_Data_B
    );

    reg [31:0]REG_Files[0:31];
    assign R_Data_A=REG_Files[R_Addr_A];
    assign R_Data_B=REG_Files[R_Addr_B];
    integer i;
    always @(posedge CLK) begin
        if(RST)
        begin
            REG_Files[0]<=32'b0;
            for(i=1;i<32;i=i+1)
                REG_Files[i]<=32'b0;
        end else
            if(RegWrite&&W_Addr!=5'b0)
                REG_Files[W_Addr]<=W_Data;
            
    end
endmodule
