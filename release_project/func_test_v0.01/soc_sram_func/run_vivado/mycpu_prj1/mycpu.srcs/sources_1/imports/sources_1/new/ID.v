`timescale 1ns / 1ps

module ID(
    input CLK,
    input RST,
    input inRegWrite,
    input inHIWrite,
    input inLOWrite,
    input inHILOWrite,
    input [31:0]Inst,
    input [4:0]WAddr,
    input [31:0]WData,
    input [63:0]HILO,
    input [31:0]inPC,
    output [31:0]outPC,
    output [31:0]RDataA,
    output [31:0]RDataB,
    output [31:0]imm32,
    output [4:0]rs,
    output [4:0]rt,
    output [4:0]rd,
    output [4:0]shamt,
    output RegWrite,
    output HIWrite,
    output LOWrite,
    output HILOWrite,
    output PCSrc,
    output PCSrcForward,
    output MemWrite,
    output MemtoReg,
    output ExtratoReg,
    output ALUSrc1,
    output [1:0]ALUSrc2,
    output [11:0]ALUOP,
    output [3:0]MDUOP,
    output [1:0]RegDst,
    output [5:0]BranchType,
    output [31:0]ExtraData,
    output [1:0]MemSize,
    output MemSignExt,
    output [1:0]RDataValid,
    output [1:0]HILOValid,
    output MTC0,
    output ERET,
    output [4:0]ExcCode,
    output CP0toReg,
    output MemEN,
    output Exception,
    output [1:0]OPType
    );

    wire [2:0]ExtraDataSrc;
    wire [31:0]HI;
    wire [31:0]LO;

    wire [15:0]imm16;
    wire [5:0]opcode;
    wire [5:0]funct;
    wire [25:0]JumpTarget;
    wire SignExt;

    assign imm32=SignExt? {16'b0,imm16}:{{16{imm16[15]}},imm16};
    assign HILOValid=ExtraDataSrc[2:1];
    assign ExtraData=ExtraDataSrc[0]?(inPC+32'h8):
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
    
    //assign MemEN=1;

    ID2 id2(
        .opcode(opcode),
        .funct(funct),
        .RDataA(RDataA),
        .JumpTarget(JumpTarget),
        .inPC(inPC),
        .rs(rs),
        .rt(rt),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ExtratoReg(ExtratoReg),
        .HIWrite(HIWrite),
        .LOWrite(LOWrite),
        .HILOWrite(HILOWrite),
        .PCSrc(PCSrc),
        .PCSrcForward(PCSrcForward),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .ALUOP(ALUOP),
        .MDUOP(MDUOP),
        .RegDst(RegDst),
        .SignExt(SignExt),
        .ExtraDataSrc(ExtraDataSrc),
        .outPC(outPC),
        .BranchType(BranchType),
        .MemSize(MemSize),
        .MemSignExt(MemSignExt),
        .RDataValid(RDataValid),
        .MTC0(MTC0),
        .ERET(ERET),
        .ExcCode(ExcCode),
        .CP0toReg(CP0toReg),
        .MemEN(MemEN),
        .Exception(Exception),
        .OPType(OPType)
    );

    RegHILO reghilo(
        .CLK(CLK),
        .RST(RST),
        .HIWrite(inHIWrite),
        .LOWrite(inLOWrite),
        .HILOWrite(inHILOWrite),
        .WData(WData),
        .HILO(HILO),
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
