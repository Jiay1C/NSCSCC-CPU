`timescale 1ns / 1ps

module WRConflict(
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
    output WRPause
    );

    wire WRConflict_rs;
    wire WRConflict_rt;
    wire WRConflict_HI;
    wire WRConflict_LO;

    assign WRConflict_rs=RDataValid[0]&&(rs!=5'b00000)&&(((rs==WAddr_EX)&&RegWrite_EX)||((rs==WAddr_MEM)&&RegWrite_MEM)||((rs==WAddr_WB)&&RegWrite_WB));
    assign WRConflict_rt=RDataValid[1]&&(rt!=5'b00000)&&(((rt==WAddr_EX)&&RegWrite_EX)||((rt==WAddr_MEM)&&RegWrite_MEM)||((rt==WAddr_WB)&&RegWrite_WB));
    assign WRConflict_HI=HILOValid[0]&&((HIWrite_EX||HILOWrite_EX)||(HIWrite_MEM||HILOWrite_MEM)||(HIWrite_WB||HILOWrite_WB));
    assign WRConflict_LO=HILOValid[1]&&((LOWrite_EX||HILOWrite_EX)||(LOWrite_MEM||HILOWrite_MEM)||(LOWrite_WB||HILOWrite_WB));
    assign WRPause=WRConflict_rs||WRConflict_rt||WRConflict_HI||WRConflict_LO;

endmodule