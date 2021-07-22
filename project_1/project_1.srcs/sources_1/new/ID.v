`timescale 1ns / 1ps

module ID(
    input CLK,
    input RST,
    input inRegWrite,
    input [31:0]Inst,
    input [4:0]WAddr,
    input [31:0]WData,
    input [31:0]inPC,
    output [31:0]outPC,
    output [31:0]RDataA,
    output [31:0]RDataB,
    output [31:0]imm32,
    output [4:0]rt,
    output [4:0]rd,
    output [4:0]shamt,
    output RegWrite,
    output PCSrc,
    output PCSrcForward,
    output MemWrite,
    output MemtoReg,
    output ALUSrc1,
    output ALUSrc2,
    output [11:0]ALUOP,
    output RegDst,
    output [5:0]BranchType
    );

    wire [4:0]rs_ID1;
    wire [15:0]imm16;
    wire [5:0]opcode;
    wire [5:0]funct;
    wire [25:0]JumpTarget;
    wire SignExt;

    wire isJump;
    wire isLink;
    wire isBranch;

    wire [4:0]rt_ID1;
    wire [4:0]rd_ID1;
    wire RegWrite_ID2;
    wire MemWrite_ID2;
    wire MemtoReg_ID2;
    wire ALUSrc1_ID2;
    wire ALUSrc2_ID2;
    wire SignExt_ID2;
    wire [11:0]ALUOP_ID2;
    wire [31:0]RDataA_RegFile;
    wire [31:0]RDataB_RegFile;


    assign imm32=SignExt? {16'b0,imm16}:{{16{imm16[15]}},imm16};


    //Branch指令因为数据通路原因无法链接
    assign PCSrc=isBranch;
    assign PCSrcForward=isJump;
    assign RDataA=isJump?inPC:RDataA_RegFile;
    assign RDataB=(isJump|BranchType[5]|BranchType[4]|BranchType[3]|BranchType[2])?32'b0:RDataB_RegFile;
    assign MemWrite=(isJump|isBranch)?0:MemWrite_ID2;
    assign RegWrite=(isJump|isBranch)?(isLink? 1:0):RegWrite_ID2; //
    assign MemtoReg=(isJump|isBranch)?0:MemtoReg_ID2;
    assign ALUSrc1=(isJump|isBranch)?0:ALUSrc1_ID2;
    assign ALUSrc2=(isJump|isBranch)?0:ALUSrc2_ID2;
    assign SignExt=(isJump|isBranch)?0:SignExt_ID2;
    assign ALUOP=isJump?12'b000000000001:(isBranch?12'b000000000010:ALUOP_ID2);
    assign rt=(isJump|isBranch)?5'b11111:rt_ID1;
    assign rd=(isJump|isBranch)?5'b11111:rd_ID1;

    

    ID1 id1(
        .Inst(Inst),
        .opcode(opcode),
        .rs(rs_ID1),
        .rt(rt_ID1),
        .rd(rd_ID1),
        .shamt(shamt),
        .funct(funct),
        .imm16(imm16),
        .JumpTarget(JumpTarget)
    );

    ID2 id2(
        .opcode(opcode),
        .funct(funct),
        .RegWrite(RegWrite_ID2),
        .MemWrite(MemWrite_ID2),
        .ALUSrc1(ALUSrc1_ID2),
        .ALUSrc2(ALUSrc2_ID2),
        .MemtoReg(MemtoReg_ID2),
        .ALUOP(ALUOP_ID2),
        .RegDst(RegDst),
        .SignExt(SignExt_ID2)
    );

    IDJump idjump(
        .opcode(opcode),
        .funct(funct),
        .RData(RDataA_RegFile),
        .JumpTarget(JumpTarget),
        .inPC(inPC),
        .rt(rt_ID1),
        .isJump(isJump),
        .isLink(isLink),
        .isBranch(isBranch),
        .BranchType(BranchType),
        .outPC(outPC)
    );

    RegFile regfile(
        .CLK(CLK),
        .RST(RST),
        .RegWrite(inRegWrite),
        .R_Addr_A(rs_ID1),
        .R_Addr_B(rt_ID1),
        .W_Addr(WAddr),
        .W_Data(WData),
        .R_Data_A(RDataA_RegFile),
        .R_Data_B(RDataB_RegFile)
    );
endmodule
