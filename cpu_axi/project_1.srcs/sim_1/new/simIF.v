`timescale 1ns / 1ps

module simIF();

    reg CLK;
    reg RST;
    reg PCSrc_MEM;
    reg PC_EX_MEM;
    reg PCSrcForward_ID;
    reg PC_ID;
    wire [31:0]PC_IF;
    wire [31:0]Inst_IF;


    always #20 CLK=~CLK;
    initial begin
        PCSrc_MEM=0;PC_EX_MEM=0;PCSrcForward_ID=0;PC_ID=0;
        CLK=0;RST=1;#101;
        RST=0;
    end

    IF If(
        .CLK(CLK),
        .RST(RST),
        .PCSrc1(PCSrc_MEM),
        .inPC1(PC_EX_MEM),
        .PCSrc2(PCSrcForward_ID),
        .inPC2(PC_ID),

        .outPC(PC_IF),
        .Inst(Inst_IF)
    );
endmodule
