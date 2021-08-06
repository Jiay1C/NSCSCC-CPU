`timescale 1ns / 1ps

module ALU(
    input [31:0]alu_src1,
    input [31:0]alu_src2,
    input [11:0]alu_op,
    output [31:0]alu_res,
    output alu_ZF,alu_CF,alu_SF,alu_OF
    );
    wire alu_add;   //加法
    wire alu_sub;   //减法
    wire alu_slt;   //有符号比较，小于置位
    wire alu_sltu;  //无符号比较，小于置位
    wire alu_and;   //按位�?
    wire alu_nor;   //按位或非
    wire alu_or;    //按位�? 
    wire alu_xor;   //按位异或
    wire alu_sll;   //逻辑左移
    wire alu_srl;   //逻辑右移
    wire alu_sra;   //算数右移
    wire alu_lui;   //高位加载

    assign alu_add  = alu_op[0];
    assign alu_sub  = alu_op[1];
    assign alu_slt  = alu_op[2];
    assign alu_sltu = alu_op[3];
    assign alu_and  = alu_op[4];
    assign alu_nor  = alu_op[5];
    assign alu_or   = alu_op[6];
    assign alu_xor  = alu_op[7];
    assign alu_sll  = alu_op[8];
    assign alu_srl  = alu_op[9];
    assign alu_sra  = alu_op[10];
    assign alu_lui  = alu_op[11];

    wire [32:0] add_result;
    wire [32:0] sub_result;
    wire [32:0] slt_result;
    wire [32:0] sltu_result;
    wire [32:0] and_result;
    wire [32:0] nor_result;
    wire [32:0] or_result;
    wire [32:0] xor_result;
    wire [32:0] sll_result;
    wire [32:0] srl_result;
    wire [32:0] sra_result;
    wire [32:0] lui_result;
    wire [32:0] result;

    assign add_result = alu_src1 + alu_src2;        //使用FPGA内置加减法器尝试
    assign sub_result = alu_src1 - alu_src2;        //
    assign slt_result = $signed(alu_src1) < $signed(alu_src2) ? 1'b1 : 1'b0;   // 带符号数小于置位
    assign sltu_result = (alu_src1 < alu_src2) ? 1'b1 : 1'b0;      //无符号数小于置位
    assign and_result = alu_src1 & alu_src2;        //按位�?
    assign or_result  = alu_src1 | alu_src2;        //按位�?
    assign nor_result = ~or_result;                 //或非
    assign xor_result = alu_src1 ^ alu_src2;        //异或  
    assign sll_result = alu_src2 << alu_src1[4:0];       //逻辑左移
    assign srl_result = alu_src2 >> alu_src1[4:0];       //逻辑右移
    assign sra_result = $signed(alu_src2) >>> alu_src1[4:0];     //算数右移
    assign lui_result = {alu_src2[15:0], 16'd0};    //高位加载，第二个操作数的低十六位加载到高十六位上

    assign result = ({33{alu_add}}  &  add_result) | ({33{alu_sub}}  &  sub_result) | ({33{alu_slt}}  &  slt_result) | ({33{alu_sltu}} &  sltu_result) | ({33{alu_and}}  &  and_result) | ({33{alu_nor}}  &  nor_result) | ({33{alu_or}}   &  or_result) | ({33{alu_xor}}  &  xor_result) | ({33{alu_sll}}  &  sll_result) | ({33{alu_srl}}  &  srl_result) | ({33{alu_sra}}  &  sra_result) | ({33{alu_lui}}  &  lui_result);

    assign alu_res = result[31:0];

    assign alu_ZF = (alu_res == 32'b0) ? 1 : 0;
    
    assign alu_CF = result[32];

    assign alu_SF = result[31];

    assign alu_OF = alu_src1[31] ^ alu_src2[31] ^ result[32] ^ result[31];
endmodule
