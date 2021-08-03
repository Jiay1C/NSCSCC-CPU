`timescale 1ns / 1ps

module mycpu_top (
    input CLK,
    input RST,
    //axi
    //ar
    output [3 :0] arid         ,
    output [31:0] araddr       ,
    output [7 :0] arlen        ,
    output [2 :0] arsize       ,
    output [1 :0] arburst      ,
    output [1 :0] arlock        ,
    output [3 :0] arcache      ,
    output [2 :0] arprot       ,
    output        arvalid      ,
    input         arready      ,
    //r           
    input  [3 :0] rid          ,
    input  [31:0] rdata        ,
    input  [1 :0] rresp        ,
    input         rlast        ,
    input         rvalid       ,
    output        rready       ,
    //aw          
    output [3 :0] awid         ,
    output [31:0] awaddr       ,
    output [7 :0] awlen        ,
    output [2 :0] awsize       ,
    output [1 :0] awburst      ,
    output [1 :0] awlock       ,
    output [3 :0] awcache      ,
    output [2 :0] awprot       ,
    output        awvalid      ,
    input         awready      ,
    //w          
    output [3 :0] wid          ,
    output [31:0] wdata        ,
    output [3 :0] wstrb        ,
    output        wlast        ,
    output        wvalid       ,
    input         wready       ,
    //b           
    input  [3 :0] bid          ,
    input  [1 :0] bresp        ,
    input         bvalid       ,
    output        bready       ,

    output [31:0] debug_wb_pc  ,
    output [3 :0] debug_wb_rf_wen,
    output [4 :0] debug_wb_rf_wnum,
    output [31:0] debug_wb_rf_wdata
    );

    assign debug_wb_pc=PC0_MEM_WB;
    assign debug_wb_rf_wen={4{RegWrite_MEM_WB}};
    assign debug_wb_rf_wnum=WAddr_MEM_WB;
    assign debug_wb_rf_wdata=WData_WB;

    wire inst_req;
    wire inst_wr;
    wire [1 :0]inst_size;
    wire [31:0]inst_addr;
    wire [31:0]inst_wdata;
    wire [31:0]inst_rdata;
    wire inst_addr_ok;
    wire inst_data_ok;
    wire data_req;
    wire data_wr;
    wire [1 :0]data_size;
    wire [31:0]data_addr;
    wire [31:0]data_wdata;
    wire [31:0]data_rdata;
    wire data_addr_ok;
    wire data_data_ok;

    cpu_axi_interface axi(
        //SRAM
        .clk(CLK),
        .resetn(~RST),
        .inst_req(inst_req),
        .inst_wr(inst_wr),
        .inst_size(inst_size),
        .inst_addr(inst_addr),
        .inst_wdata(inst_wdata),
        .inst_rdata(inst_rdata),
        .inst_addr_ok(inst_addr_ok),
        .inst_data_ok(inst_data_ok),
        .data_req(data_req),
        .data_wr(data_wr),
        .data_size(data_size),
        .data_addr(data_addr),
        .data_wdata(data_wdata),
        .data_rdata(data_rdata),
        .data_addr_ok(data_addr_ok),
        .data_data_ok(data_data_ok),
        //AXI
        .arid(arid),
        .araddr(araddr),
        .arlen(arlen),
        .arsize(arsize),
        .arburst(arburst),
        .arlock(arlock),
        .arcache(arcache),
        .arprot(arprot),
        .arvalid(arvalid),
        .arready(arready),
        .rid(rid),
        .rdata(rdata),
        .rresp(rresp),
        .rlast(rlast),
        .rvalid(rvalid),
        .rready(rready),
        .awid(awid),
        .awaddr(awaddr),
        .awlen(awlen),
        .awsize(awsize),
        .awburst(awburst),
        .awlock(awlock),
        .awcache(awcache),
        .awprot(awprot),
        .awvalid(awvalid),
        .awready(awready),
        .wid(wid),
        .wdata(wdata),
        .wstrb(wstrb),
        .wlast(wlast),
        .wvalid(wvalid),
        .wready(wready),
        .bid(bid),
        .bresp(bresp),
        .bvalid(bvalid),
        .bready(bready)
    );

    wire CLK_IF;
    wire CLK_IF_ID;
    wire CLK_ID;
    wire CLK_ID_EX;
    wire CLK_EX;
    wire CLK_EX_MEM;
    wire CLK_MEM;
    wire CLK_MEM_WB;
    wire CLK_WB;
    wire WRPause_CU;
    wire ControlPause_CU;
    wire PCEN_CU;

    CU cu(
        .CLK(CLK),
        .RST(RST),
        .MDUPause(MDUPause_EX),
        .IMPause(IMPause_IF),
        .DMPause(DMPause_MEM),
        .rs(rs_ID),
        .rt(rt_ID),
        .RDataValid(RDataValid_ID),
        .WAddr_EX(WAddr_EX),
        .WAddr_MEM(WAddr_EX_MEM),
        .WAddr_WB(WAddr_MEM_WB),
        .RegWrite_EX(RegWrite_ID_EX),
        .RegWrite_MEM(RegWrite_EX_MEM),
        .RegWrite_WB(RegWrite_MEM_WB),
        .HILOValid(HILOValid_ID),
        .HIWrite_EX(HIWrite_ID_EX),
        .HIWrite_MEM(HIWrite_EX_MEM),
        .HIWrite_WB(HIWrite_MEM_WB),
        .LOWrite_EX(LOWrite_ID_EX),
        .LOWrite_MEM(LOWrite_EX_MEM),
        .LOWrite_WB(LOWrite_MEM_WB),
        .HILOWrite_EX(HILOWrite_ID_EX),
        .HILOWrite_MEM(HILOWrite_EX_MEM),
        .HILOWrite_WB(HILOWrite_MEM_WB),
        .Jump_ID(PCSrcForward_ID),
        .Branch_ID(PCSrc_ID),
        .Branch_EX(PCSrc_ID_EX),
        .Branch_MEM(PCSrc_MEM),
        .ERET_ID(ERET_ID),
        .ERET_EX(ERET_ID_EX),
        .ERET_MEM(ERET_EX_MEM),
        .ERET_WB(ERET_MEM_WB),
        
        .CLK_IF(CLK_IF),
        .CLK_IF_ID(CLK_IF_ID),
        .CLK_ID(CLK_ID),
        .CLK_ID_EX(CLK_ID_EX),
        .CLK_EX(CLK_EX),
        .CLK_EX_MEM(CLK_EX_MEM),
        .CLK_MEM(CLK_MEM),
        .CLK_MEM_WB(CLK_MEM_WB),
        .CLK_WB(CLK_WB),
        .WRPause(WRPause_CU),
        .ControlPause(ControlPause_CU),
        .PCEN(PCEN_CU)
    );
    
    wire [31:0]PC_IF;
    wire [31:0]Inst_IF;
    wire IMPause_IF;

    IF If(
        .CLK(CLK_IF),
        .RST(RST),
        .PCEN(PCEN_CU),
        .MemBusy(MemEN_EX_MEM),
        .PCSrc1(PCSrc_MEM),
        .inPC1(PC_EX_MEM),
        .PCSrc2(PCSrcForward_ID),
        .inPC2(PC_ID),
        .PCSrc3(ERET_MEM_WB),
        .inPC3(PC_WB),

        .outPC(PC_IF),
        .Inst(Inst_IF),
        .IMPause(IMPause_IF),

        .inst_rdata(inst_rdata),
        .inst_addr_ok(inst_addr_ok),
        .inst_data_ok(inst_data_ok),
        .inst_req(inst_req),
        .inst_wr(inst_wr),
        .inst_size(inst_size),
        .inst_addr(inst_addr),
        .inst_wdata(inst_wdata)
    );

    wire [31:0]PC_IF_ID;
    wire [31:0]Inst_IF_ID;

    IF_ID if_id(
        .CLK(~CLK_IF_ID),
        .RST(RST|ControlPause_CU),
        .inPC(PC_IF),
        .inInst(Inst_IF),

        .outPC(PC_IF_ID),
        .outInst(Inst_IF_ID)
    );

    wire [31:0]PC_ID;
    wire [31:0]RDataA_ID;
    wire [31:0]RDataB_ID;
    wire [31:0]imm32_ID;
    wire [4:0]rs_ID;
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
    wire [1:0]RDataValid_ID;
    wire [1:0]HILOValid_ID;
    wire MTC0_ID;
    wire ERET_ID;
    wire [4:0]ExcCode_ID;
    wire CP0toReg_ID;
    wire MemEN_ID;

    ID id(
        .CLK(CLK_ID),
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
        .rs(rs_ID),
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
        .MemSignExt(MemSignExt_ID),
        .RDataValid(RDataValid_ID),
        .HILOValid(HILOValid_ID),
        .MTC0(MTC0_ID),
        .ERET(ERET_ID),
        .ExcCode(ExcCode_ID),
        .CP0toReg(CP0toReg_ID),
        .MemEN(MemEN_ID)
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
    wire MTC0_ID_EX;
    wire ERET_ID_EX;
    wire [4:0]ExcCode_ID_EX;
    wire CP0toReg_ID_EX;
    wire MemEN_ID_EX;

    ID_EX id_ex(
        .CLK(~CLK_ID_EX),
        .RST(RST),
        .WRPause(WRPause_CU),
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
        .inMTC0(MTC0_ID),
        .inERET(ERET_ID),
        .inExcCode(ExcCode_ID),
        .inCP0toReg(CP0toReg_ID),
        .inMemEN(MemEN_ID),

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
        .outPC(PC_ID_EX),
        .outMTC0(MTC0_ID_EX),
        .outERET(ERET_ID_EX),
        .outExcCode(ExcCode_ID_EX),
        .outCP0toReg(CP0toReg_ID_EX),
        .outMemEN(MemEN_ID_EX)
    );

    wire [4:0]WAddr_EX;
    wire [31:0]ALURes_EX;
    wire CF_EX;
    wire OF_EX;
    wire SF_EX;
    wire ZF_EX;
    wire [31:0]PC_EX;
    wire [63:0]HILO_EX;
    wire MDUPause_EX;

    EX ex(
        .CLK(CLK_EX),
        .RST(RST),
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
        .HILO(HILO_EX),
        .MDUPause(MDUPause_EX)
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
    wire MTC0_EX_MEM;
    wire ERET_EX_MEM;
    wire [4:0]ExcCode_EX_MEM;
    wire CP0toReg_EX_MEM;
    wire [4:0]CP0Addr_EX_MEM;
    wire [31:0]PC0_EX_MEM;
    wire MemEN_EX_MEM;

    EX_MEM ex_mem(
        .CLK(~CLK_EX_MEM),
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
        .inMTC0(MTC0_ID_EX),
        .inERET(ERET_ID_EX),
        .inExcCode(ExcCode_ID_EX),
        .inCP0toReg(CP0toReg_ID_EX),
        .inCP0Addr(rd_ID_EX),
        .inPC0(PC_ID_EX),
        .inMemEN(MemEN_ID_EX),

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
        .outHILO(HILO_EX_MEM),
        .outMTC0(MTC0_EX_MEM),
        .outERET(ERET_EX_MEM),
        .outExcCode(ExcCode_EX_MEM),
        .outCP0toReg(CP0toReg_EX_MEM),
        .outCP0Addr(CP0Addr_EX_MEM),
        .outPC0(PC0_EX_MEM),
        .outMemEN(MemEN_EX_MEM)
    );

    wire RegWrite_MEM;
    wire [31:0]MemRData_MEM;
    wire PCSrc_MEM;
    wire DMPause_MEM;

    MEM mem(
        .CLK(CLK_MEM),
        .RST(RST),
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
        .MemEN(MemEN_EX_MEM),

        .outRegWrite(RegWrite_MEM),
        .MemRData(MemRData_MEM),
        .outPCSrc(PCSrc_MEM),
        .DMPause(DMPause_MEM),

        .data_rdata(data_rdata),
        .data_addr_ok(data_addr_ok),
        .data_data_ok(data_data_ok),
        .data_req(data_req),
        .data_wr(data_wr),
        .data_size(data_size),
        .data_addr(data_addr),
        .data_wdata(data_wdata)
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
    wire MTC0_MEM_WB;
    wire ERET_MEM_WB;
    wire [4:0]ExcCode_MEM_WB;
    wire CP0toReg_MEM_WB;
    wire [31:0]CP0WData_MEM_WB;
    wire [4:0]CP0Addr_MEM_WB;
    wire [31:0]PC0_MEM_WB;

    MEM_WB mem_wb(
        .CLK(~CLK_MEM_WB),
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
        .inMTC0(MTC0_EX_MEM),
        .inERET(ERET_EX_MEM),
        .inExcCode(ExcCode_EX_MEM),
        .inCP0toReg(CP0toReg_EX_MEM),
        .inCP0WData(MemWData_EX_MEM),
        .inCP0Addr(CP0Addr_EX_MEM),
        .inPC0(PC0_EX_MEM),

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
        .outHILO(HILO_MEM_WB),
        .outMTC0(MTC0_MEM_WB),
        .outERET(ERET_MEM_WB),
        .outExcCode(ExcCode_MEM_WB),
        .outCP0toReg(CP0toReg_MEM_WB),
        .outCP0WData(CP0WData_MEM_WB),
        .outCP0Addr(CP0Addr_MEM_WB),
        .outPC0(PC0_MEM_WB)
    );

    wire [31:0]WData_WB;
    wire [31:0]PC_WB;

    WB wb(
        .CLK(CLK_WB),
        .RST(RST),
        .MemtoReg(MemtoReg_MEM_WB),
        .ExtratoReg(ExtratoReg_MEM_WB),
        .CP0toReg(CP0toReg_MEM_WB),
        .MTC0(MTC0_MEM_WB),
        .ERET(ERET_MEM_WB),
        .ExtraData(ExtraData_MEM_WB),
        .MemRData(MemRData_MEM_WB),
        .ALURes(ALURes_MEM_WB),
        .ExcCode(ExcCode_MEM_WB),
        .CP0WData(CP0WData_MEM_WB),
        .CP0Addr(CP0Addr_MEM_WB),
        .inPC(PC0_MEM_WB),

        .outPC(PC_WB),
        .WData(WData_WB)
    );
endmodule
