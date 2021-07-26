`timescale 1ns / 1ps

module CU(
    input CLK,
    input MDUPause,
    output CLK_IF,
    output CLK_IF_ID,
    output CLK_ID,
    output CLK_ID_EX,
    output CLK_EX,
    output CLK_EX_MEM,
    output CLK_MEM,
    output CLK_MEM_WB,
    output CLK_WB
    );

    reg IF_EN;
    reg IF_ID_EN;
    reg ID_EN;
    reg ID_EX_EN;
    reg EX_EN;
    reg EX_MEM_EN;
    reg MEM_EN;
    reg MEM_WB_EN;
    reg WB_EN;

    assign CLK_IF=CLK|~IF_EN;
    assign CLK_IF_ID=CLK|~IF_ID_EN;
    assign CLK_ID=CLK|~ID_EN;
    assign CLK_ID_EX=CLK|~ID_EX_EN;
    assign CLK_EX=CLK|~EX_EN;
    assign CLK_EX_MEM=CLK|~EX_MEM_EN;
    assign CLK_MEM=CLK|~MEM_EN;
    assign CLK_MEM_WB=CLK|~MEM_WB_EN;
    assign CLK_WB=CLK|~WB_EN;

    always @(*) begin
        if(MDUPause) begin IF_EN<=0;IF_ID_EN<=0;ID_EN<=0;ID_EX_EN<=0;EX_EN<=1;EX_MEM_EN<=0;MEM_EN<=0;MEM_WB_EN<=0;WB_EN<=0; end
        else         begin IF_EN<=1;IF_ID_EN<=1;ID_EN<=1;ID_EX_EN<=1;EX_EN<=1;EX_MEM_EN<=1;MEM_EN<=1;MEM_WB_EN<=1;WB_EN<=1; end
    end


endmodule
