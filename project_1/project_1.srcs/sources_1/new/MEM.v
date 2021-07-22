`timescale 1ns / 1ps

module MEM(
    input CLK,
    input [31:0]ALURes,
    input CF,
    input OF,
    input SF,
    input ZF,
    input [31:0]MemWData,
    input inPCSrc,
    input MemWrite,
    input [5:0]BranchType,
    output [31:0]MemRData,
    output outPCSrc
    );

    assign outPCSrc=inPCSrc&(
            (BranchType[0]&(ZF))|    //=
            (BranchType[1]&(!ZF))| //!=
            (BranchType[2]&(ZF|!SF))| //>=
            (BranchType[3]&(!ZF&!SF))| //>
            (BranchType[4]&(ZF|SF))| //<=
            (BranchType[5]&(!ZF&SF)) //<
        );
    
    
    
    //此处替换为判断是否需要跳转的代码

    DM dm (
    .clka(CLK),    // input wire clka
    .wea(MemWrite),      // input wire [0 : 0] wea
    .addra(ALURes>>2),  // input wire [15 : 0] addra
    .dina(MemWData),    // input wire [31 : 0] dina
    .douta(MemRData)  // output wire [31 : 0] douta
    );

endmodule
