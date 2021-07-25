`timescale 1ns / 1ps

module simMDU();
    reg CLK;
    reg [3:0]MDUOP;
    reg [31:0]alu_src1;
    reg [31:0]alu_src2;
    wire MDUPause;
    wire [63:0]HILO;

    always #5 CLK=~CLK;
    initial begin
        CLK=0;MDUOP=4'b0100;alu_src1=32'h12345679;alu_src2=32'h2;
    end




    MDU mdu(
        .clk(CLK),
        .mdu_op(MDUOP),
        .rsc1(alu_src1),
        .rsc2(alu_src2),
        .mdu_pause(MDUPause),
        .HILO(HILO)
    );
endmodule
