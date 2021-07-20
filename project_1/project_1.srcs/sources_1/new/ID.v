`timescale 1ns / 1ps

module ID(
    input CLK,
    input RST,
    input inRegWrite,
    input [31:0]Inst,
    input [4:0]WAddr,
    input [31:0]WData,
    output [31:0]RDataA,
    output [31:0]RDataB,
    output [31:0]imm32,
    output [4:0]rt,
    output [4:0]rd,
    output [4:0]shamt,
    output RegWrite,
    output PCSrc,
    output MemWrite,
    output MemtoReg,
    output ALUSrc1,
    output ALUSrc2,
    output [11:0]ALUOP,
    output RegDst
    );

    wire [4:0]rs;
    wire [15:0]imm16;
    wire [5:0]opcode;
    wire [5:0]funct;
    wire [25:0]instr_index;

    assign imm32={{16{imm16[15]}},imm16};

    ID1 id1(
        .Inst(Inst),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),
        .imm16(imm16),
        .instr_index(instr_index)
    );

    ID2 id2(
        .opcode(opcode),
        .funct(funct),
        .RegWrite(RegWrite),
        .PCSrc(PCSrc),
        .MemWrite(MemWrite),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .MemtoReg(MemtoReg),
        .ALUOP(ALUOP),
        .RegDst(RegDst)
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
