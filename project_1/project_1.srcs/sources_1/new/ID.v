`timescale 1ns / 1ps

module ID(
    input CLK,
    input RST,
    input inRegWrite,
    input inHIWrite,
    input inLOWrite,
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
    output HIWrite,
    output LOWrite,
    output PCSrc,
    output PCSrcForward,
    output [3:0]MemWrite,
    output MemtoReg,
    output ExtratoReg,
    output ALUSrc1,
    output [1:0]ALUSrc2,
    output [11:0]ALUOP,
    output [1:0]RegDst,
    output [5:0]BranchType,
    output [31:0]ExtraData
    );

    wire [2:0]ExtraDataSrc;
    wire [31:0]HI;
    wire [31:0]LO;

    wire [4:0]rs;
    wire [15:0]imm16;
    wire [5:0]opcode;
    wire [5:0]funct;
    wire [25:0]JumpTarget;
    wire SignExt;

    assign imm32=SignExt? {16'b0,imm16}:{{16{imm16[15]}},imm16};

    assign ExtraData=ExtraDataSrc[0]?inPC:
                    (ExtraDataSrc[1]?HI:
                    (ExtraDataSrc[2]?LO:32'b0));

    ID1 id1(
        .Inst(Inst),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),
        .imm16(imm16),
        .JumpTarget(JumpTarget)
    );

    ID2 id2(
        .opcode(opcode),
        .funct(funct),
        .RDataA(RDataA),
        .JumpTarget(JumpTarget),
        .inPC(inPC),
        .rt(rt),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ExtratoReg(ExtratoReg),
        .HIWrite(HIWrite),
        .LOWrite(LOWrite),
        .PCSrc(PCSrc),
        .PCSrcForward(PCSrcForward),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .ALUOP(ALUOP),
        .RegDst(RegDst),
        .SignExt(SignExt),
        .ExtraDataSrc(ExtraDataSrc),
        .outPC(outPC),
        .BranchType(BranchType)
    );

    RegHILO reghilo(
        .CLK(CLK),
        .RST(RST),
        .HIWrite(inHIWrite),
        .LOWrite(inLOWrite),
        .WData(WData),
        .HI(HI),
        .LO(LO)
    );

    RegFile regfile(
        .CLK(CLK),
        .RST(RST),
        .RegWrite(inRegWrite),
        .R_Addr_A(rs),
        .R_Addr_B(rt),
        .W_Addr(WAddr),
        .W_Data(WData),
        .R_Data_A(RDataA),
        .R_Data_B(RDataB)
    );
endmodule
