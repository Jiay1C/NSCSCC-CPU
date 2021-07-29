`timescale 1ns / 1ps

module CU(
    input CLK,
    input RST,
    input MDUPause,
    input [4:0]rs,
    input [4:0]rt,
    input [1:0]RDataValid,
    input [4:0]WAddr_EX,
    input [4:0]WAddr_MEM,
    input [4:0]WAddr_WB,
    input RegWrite_EX,
    input RegWrite_MEM,
    input RegWrite_WB,
    input [1:0]HILOValid,
    input HIWrite_EX,
    input HIWrite_MEM,
    input HIWrite_WB,
    input LOWrite_EX,
    input LOWrite_MEM,
    input LOWrite_WB,
    input HILOWrite_EX,
    input HILOWrite_MEM,
    input HILOWrite_WB,
    input Jump_ID,
    input Branch_ID,
    input Branch_EX,
    input Branch_MEM,
    output CLK_IF,
    output CLK_IF_ID,
    output CLK_ID,
    output CLK_ID_EX,
    output CLK_EX,
    output CLK_EX_MEM,
    output CLK_MEM,
    output CLK_MEM_WB,
    output CLK_WB,
    output reg WRPause,
    output ControlPause,
    output PCEN
    );

    wire WRPause_WRConflict;
    wire JumpPause;
    wire BranchPause;
    reg WRPause0;
    reg JumpPause1;
    reg JumpPause0;
    reg BranchPause0;
    reg BranchPause1;

    reg IF_EN;
    reg IF_ID_EN;
    reg ID_EN;
    reg ID_EX_EN;
    reg EX_EN;
    reg EX_MEM_EN;
    reg MEM_EN;
    reg MEM_WB_EN;
    reg WB_EN;

    assign JumpPause=JumpPause0||JumpPause1;
    assign BranchPause=BranchPause0||BranchPause1;
    assign ControlPause=JumpPause||BranchPause;
    assign PCEN=~BranchPause0;

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
        if(MDUPause)      begin IF_EN<=0;IF_ID_EN<=0;ID_EN<=0;ID_EX_EN<=0;EX_EN<=1;EX_MEM_EN<=0;MEM_EN<=0;MEM_WB_EN<=0;WB_EN<=0; end
        else if(WRPause0) begin IF_EN<=0;IF_ID_EN<=0;ID_EN<=1;ID_EX_EN<=0;EX_EN<=1;EX_MEM_EN<=1;MEM_EN<=1;MEM_WB_EN<=1;WB_EN<=1; end
        else              begin IF_EN<=1;IF_ID_EN<=1;ID_EN<=1;ID_EX_EN<=1;EX_EN<=1;EX_MEM_EN<=1;MEM_EN<=1;MEM_WB_EN<=1;WB_EN<=1; end
    end

    always @(posedge CLK) begin
        if(RST) {WRPause0,WRPause,JumpPause1,JumpPause0,BranchPause1,BranchPause0}<=0;
        else begin
            WRPause0<=WRPause_WRConflict;
            WRPause<=WRPause0;
            JumpPause0<=Jump_ID;
            JumpPause1<=JumpPause0;
            BranchPause0<=Branch_ID||Branch_EX||Branch_MEM;
            BranchPause1<=BranchPause0;
        end
    end

    WRConflict wrconflict(
        .rs(rs),
        .rt(rt),
        .RDataValid(RDataValid),
        .WAddr_EX(WAddr_EX),
        .WAddr_MEM(WAddr_MEM),
        .WAddr_WB(WAddr_WB),
        .RegWrite_EX(RegWrite_EX),
        .RegWrite_MEM(RegWrite_MEM),
        .RegWrite_WB(RegWrite_WB),
        .HILOValid(HILOValid),
        .HIWrite_EX(HIWrite_EX),
        .HIWrite_MEM(HIWrite_MEM),
        .HIWrite_WB(HIWrite_WB),
        .LOWrite_EX(LOWrite_EX),
        .LOWrite_MEM(LOWrite_MEM),
        .LOWrite_WB(LOWrite_WB),
        .HILOWrite_EX(HILOWrite_EX),
        .HILOWrite_MEM(HILOWrite_MEM),
        .HILOWrite_WB(HILOWrite_WB),
        .WRPause(WRPause_WRConflict)
    );
endmodule
