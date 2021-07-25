`timescale 1ns / 1ps

module Top (
    input CLK,
    input RST
    );
    
    wire [31:0]PC_IF;
    wire [31:0]Inst_IF;

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

    wire [31:0]PC_IF_ID;
    wire [31:0]Inst_IF_ID;

    IF_ID if_id(
        .CLK(~CLK),
        .RST(RST),
        .inPC(PC_IF),
        .inInst(Inst_IF),

        .outPC(PC_IF_ID),
        .outInst(Inst_IF_ID)
    );

    wire [31:0]PC_ID;
    wire [31:0]RDataA_ID;
    wire [31:0]RDataB_ID;
    wire [31:0]imm32_ID;
    wire [4:0]rt_ID;
    wire [4:0]rd_ID;
    wire [4:0]shamt_ID;
    wire RegWrite_ID;
    wire HIWrite_ID;
    wire LOWrite_ID;
    wire HILOWrite_ID;
    wire PCSrc_ID;
    wire PCSrcForward_ID;
    wire MemWrite_ID;
    wire MemtoReg_ID;
    wire ExtratoReg_ID;
    wire ALUSrc1_ID;
    wire [1:0]ALUSrc2_ID;
    wire [11:0]ALUOP_ID;
    wire [3:0]MDUOP_ID;
    wire [1:0]RegDst_ID;
    wire [5:0]BranchType_ID;
    wire [31:0]ExtraData_ID;
    wire [1:0]MemSize_ID;
    wire MemSignExt_ID;

    ID id(
        .CLK(CLK),
        .RST(RST), 
        .inRegWrite(RegWrite_MEM_WB),
        .inHIWrite(HIWrite_MEM_WB),
        .inLOWrite(LOWrite_MEM_WB),
        .inHILOWrite(HILOWrite_MEM_WB),
        .Inst(Inst_IF_ID),
        .WAddr(WAddr_MEM_WB),
        .WData(WData_WB),
        .HILO(HILO_MEM_WB),
        .inPC(PC_IF_ID),

        .outPC(PC_ID),
        .RDataA(RDataA_ID),
        .RDataB(RDataB_ID),
        .imm32(imm32_ID),
        .rt(rt_ID),
        .rd(rd_ID),
        .shamt(shamt_ID),
        .RegWrite(RegWrite_ID),
        .HIWrite(HIWrite_ID),
        .LOWrite(LOWrite_ID),
        .HILOWrite(HILOWrite_ID),
        .PCSrc(PCSrc_ID),
        .PCSrcForward(PCSrcForward_ID),
        .MemWrite(MemWrite_ID),
        .MemtoReg(MemtoReg_ID),
        .ExtratoReg(ExtratoReg_ID),
        .ALUSrc1(ALUSrc1_ID),
        .ALUSrc2(ALUSrc2_ID),
        .ALUOP(ALUOP_ID),
        .MDUOP(MDUOP_ID),
        .RegDst(RegDst_ID),
        .BranchType(BranchType_ID),
        .ExtraData(ExtraData_ID),
        .MemSize(MemSize_ID),
        .MemSignExt(MemSignExt_ID)
    );

    wire [31:0]RDataA_ID_EX;
    wire [31:0]RDataB_ID_EX;
    wire [31:0]imm32_ID_EX;
    wire [4:0]rt_ID_EX;
    wire [4:0]rd_ID_EX;
    wire [4:0]shamt_ID_EX;
    wire RegWrite_ID_EX;
    wire HIWrite_ID_EX;
    wire LOWrite_ID_EX;
    wire HILOWrite_ID_EX;
    wire PCSrc_ID_EX;
    wire MemWrite_ID_EX;
    wire MemtoReg_ID_EX;
    wire ExtratoReg_ID_EX;
    wire ALUSrc1_ID_EX;
    wire [1:0]ALUSrc2_ID_EX;
    wire [11:0]ALUOP_ID_EX;
    wire [3:0]MDUOP_ID_EX;
    wire [1:0]RegDst_ID_EX;
    wire [5:0]BranchType_ID_EX;
    wire [31:0]ExtraData_ID_EX;
    wire [1:0]MemSize_ID_EX;
    wire MemSignExt_ID_EX;
    wire [31:0]PC_ID_EX;

    ID_EX id_ex(
        .CLK(~CLK),
        .RST(RST),
        .inRDataA(RDataA_ID),
        .inRDataB(RDataB_ID),
        .inimm32(imm32_ID),
        .inrt(rt_ID),
        .inrd(rd_ID),
        .inshamt(shamt_ID),
        .inRegWrite(RegWrite_ID),
        .inHIWrite(HIWrite_ID),
        .inLOWrite(LOWrite_ID),
        .inHILOWrite(HILOWrite_ID),
        .inPCSrc(PCSrc_ID),
        .inMemWrite(MemWrite_ID),
        .inMemtoReg(MemtoReg_ID),
        .inExtratoReg(ExtratoReg_ID),
        .inALUSrc1(ALUSrc1_ID),
        .inALUSrc2(ALUSrc2_ID),
        .inALUOP(ALUOP_ID),
        .inMDUOP(MDUOP_ID),
        .inRegDst(RegDst_ID),
        .inBranchType(BranchType_ID),
        .inExtraData(ExtraData_ID),
        .inMemSize(MemSize_ID),
        .inMemSignExt(MemSignExt_ID),
        .inPC(PC_IF_ID),

        .outRDataA(RDataA_ID_EX),
        .outRDataB(RDataB_ID_EX),
        .outimm32(imm32_ID_EX),
        .outrt(rt_ID_EX),
        .outrd(rd_ID_EX),
        .outshamt(shamt_ID_EX),
        .outRegWrite(RegWrite_ID_EX),
        .outHIWrite(HIWrite_ID_EX),
        .outLOWrite(LOWrite_ID_EX),
        .outHILOWrite(HILOWrite_ID_EX),
        .outPCSrc(PCSrc_ID_EX),
        .outMemWrite(MemWrite_ID_EX),
        .outMemtoReg(MemtoReg_ID_EX),
        .outExtratoReg(ExtratoReg_ID_EX),
        .outALUSrc1(ALUSrc1_ID_EX),
        .outALUSrc2(ALUSrc2_ID_EX),
        .outALUOP(ALUOP_ID_EX),
        .outMDUOP(MDUOP_ID_EX),
        .outRegDst(RegDst_ID_EX),
        .outBranchType(BranchType_ID_EX),
        .outExtraData(ExtraData_ID_EX),
        .outMemSize(MemSize_ID_EX),
        .outMemSignExt(MemSignExt_ID_EX),
        .outPC(PC_ID_EX)
    );

    wire [4:0]WAddr_EX;
    wire [31:0]ALURes_EX;
    wire CF_EX;
    wire OF_EX;
    wire SF_EX;
    wire ZF_EX;
    wire [31:0]PC_EX;
    wire [63:0]HILO_EX;

    EX ex(
        .CLK(CLK),
        .ALUSrc1(ALUSrc1_ID_EX),
        .ALUSrc2(ALUSrc2_ID_EX),
        .ALUOP(ALUOP_ID_EX),
        .MDUOP(MDUOP_ID_EX),
        .RegDst(RegDst_ID_EX),
        .inPC(PC_ID_EX),
        .RDataA(RDataA_ID_EX),
        .RDataB(RDataB_ID_EX),
        .imm32(imm32_ID_EX),
        .rt(rt_ID_EX),
        .rd(rd_ID_EX),
        .shamt(shamt_ID_EX),

        .WAddr(WAddr_EX),
        .ALURes(ALURes_EX),
        .CF(CF_EX),
        .OF(OF_EX),
        .SF(SF_EX),
        .ZF(ZF_EX),
        .outPC(PC_EX),
        .HILO(HILO_EX)
    );

    wire [31:0]PC_EX_MEM;
    wire [31:0]ALURes_EX_MEM;
    wire CF_EX_MEM;
    wire OF_EX_MEM;
    wire SF_EX_MEM;
    wire ZF_EX_MEM;
    wire [31:0]MemWData_EX_MEM;
    wire [4:0]WAddr_EX_MEM;
    wire RegWrite_EX_MEM;
    wire HIWrite_EX_MEM;
    wire LOWrite_EX_MEM;
    wire HILOWrite_EX_MEM;
    wire PCSrc_EX_MEM;
    wire MemWrite_EX_MEM;
    wire MemtoReg_EX_MEM;
    wire ExtratoReg_EX_MEM;
    wire [5:0]BranchType_EX_MEM;
    wire [31:0]ExtraData_EX_MEM;
    wire [1:0]MemSize_EX_MEM;
    wire MemSignExt_EX_MEM;
    wire [63:0]HILO_EX_MEM;


    EX_MEM ex_mem(
        .CLK(~CLK),
        .RST(RST),
        .inPC(PC_EX),
        .inALURes(ALURes_EX),
        .inCF(CF_EX),
        .inOF(OF_EX),
        .inSF(SF_EX),
        .inZF(ZF_EX),
        .inMemWData(RDataB_ID_EX),
        .inWAddr(WAddr_EX),
        .inRegWrite(RegWrite_ID_EX),
        .inHIWrite(HIWrite_ID_EX),
        .inLOWrite(LOWrite_ID_EX),
        .inHILOWrite(HILOWrite_ID_EX),
        .inPCSrc(PCSrc_ID_EX),
        .inMemWrite(MemWrite_ID_EX),
        .inMemtoReg(MemtoReg_ID_EX),
        .inExtratoReg(ExtratoReg_ID_EX),
        .inBranchType(BranchType_ID_EX),
        .inExtraData(ExtraData_ID_EX),
        .inMemSize(MemSize_ID_EX),
        .inMemSignExt(MemSignExt_ID_EX),
        .inHILO(HILO_EX),

        .outPC(PC_EX_MEM),
        .outALURes(ALURes_EX_MEM),
        .outCF(CF_EX_MEM),
        .outOF(OF_EX_MEM),
        .outSF(SF_EX_MEM),
        .outZF(ZF_EX_MEM),
        .outMemWData(MemWData_EX_MEM),
        .outWAddr(WAddr_EX_MEM),
        .outRegWrite(RegWrite_EX_MEM),
        .outHIWrite(HIWrite_EX_MEM),
        .outLOWrite(LOWrite_EX_MEM),
        .outHILOWrite(HILOWrite_EX_MEM),
        .outPCSrc(PCSrc_EX_MEM),
        .outMemWrite(MemWrite_EX_MEM),
        .outMemtoReg(MemtoReg_EX_MEM),
        .outExtratoReg(ExtratoReg_EX_MEM),
        .outBranchType(BranchType_EX_MEM),
        .outExtraData(ExtraData_EX_MEM),
        .outMemSize(MemSize_EX_MEM),
        .outMemSignExt(MemSignExt_EX_MEM),
        .outHILO(HILO_EX_MEM)
    );

    wire RegWrite_MEM;
    wire [31:0]MemRData_MEM;
    wire PCSrc_MEM;

    MEM mem(
        .CLK(CLK),
        .ALURes(ALURes_EX_MEM),
        .CF(CF_EX_MEM),
        .OF(OF_EX_MEM),
        .SF(SF_EX_MEM),
        .ZF(ZF_EX_MEM),
        .inRegWrite(RegWrite_EX_MEM),
        .MemWData(MemWData_EX_MEM),
        .inPCSrc(PCSrc_EX_MEM),
        .MemWrite(MemWrite_EX_MEM),
        .BranchType(BranchType_EX_MEM),
        .MemSize(MemSize_EX_MEM),
        .MemSignExt(MemSignExt_EX_MEM),

        .outRegWrite(RegWrite_MEM),
        .MemRData(MemRData_MEM),
        .outPCSrc(PCSrc_MEM)
    );

    wire [31:0]MemRData_MEM_WB;
    wire [31:0]ALURes_MEM_WB;
    wire RegWrite_MEM_WB;
    wire HIWrite_MEM_WB;
    wire LOWrite_MEM_WB;
    wire HILOWrite_MEM_WB;
    wire MemtoReg_MEM_WB;
    wire ExtratoReg_MEM_WB;
    wire [4:0]WAddr_MEM_WB;
    wire [31:0]ExtraData_MEM_WB;
    wire [63:0]HILO_MEM_WB;

    MEM_WB mem_wb(
        .CLK(~CLK),
        .RST(RST),
        .inMemRData(MemRData_MEM),
        .inALURes(ALURes_EX_MEM),
        .inRegWrite(RegWrite_MEM),
        .inHIWrite(HIWrite_EX_MEM),
        .inLOWrite(LOWrite_EX_MEM),
        .inHILOWrite(HILOWrite_EX_MEM),
        .inMemtoReg(MemtoReg_EX_MEM),
        .inExtratoReg(ExtratoReg_EX_MEM),
        .inWAddr(WAddr_EX_MEM),
        .inExtraData(ExtraData_EX_MEM),
        .inHILO(HILO_EX_MEM),

        .outMemRData(MemRData_MEM_WB),
        .outALURes(ALURes_MEM_WB),
        .outRegWrite(RegWrite_MEM_WB),
        .outHIWrite(HIWrite_MEM_WB),
        .outLOWrite(LOWrite_MEM_WB),
        .outHILOWrite(HILOWrite_MEM_WB),
        .outMemtoReg(MemtoReg_MEM_WB),
        .outExtratoReg(ExtratoReg_MEM_WB),
        .outWAddr(WAddr_MEM_WB),
        .outExtraData(ExtraData_MEM_WB),
        .outHILO(HILO_MEM_WB)
    );

    wire [31:0]WData_WB;

    WB wb(
        .MemtoReg(MemtoReg_MEM_WB),
        .ExtratoReg(ExtratoReg_MEM_WB),
        .ExtraData(ExtraData_MEM_WB),
        .MemRData(MemRData_MEM_WB),
        .ALURes(ALURes_MEM_WB),

        .WData(WData_WB)
    );
endmodule

























// module Top(
//     input CLK100M,
//     input RST,
//     output [7:0]AN,
//     output [7:0]Seg
//     );
//     reg Disp;
//      reg [99:0]div;
//     Digital digital(
//         .CLK(CLK100M),
//         .CLR(RST),
//         .Data0(Disp),
//         .AN(AN),
//         .Seg(Seg)
//     );

//     initial begin
//         Disp=32'h00000000;
//         div=32'b0;
//     end

//     always @(negedge CLK100M) begin
//         div=div+32'h1;
//         if(div==32'd100000000)
//         begin
//             div=0;
//             Disp=Disp+1;
//         end
//     end

// endmodule
