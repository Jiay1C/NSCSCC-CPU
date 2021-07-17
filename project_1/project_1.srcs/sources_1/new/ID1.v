`timescale 1ns / 1ps

module ID1(
    input [31:0]Inst,
    output [5:0]opcode,
    output [4:0]rs,
    output [4:0]rt,
    output [4:0]rd,
    output [4:0]sa,
    output [5:0]funct,
    output [15:0]imm16,
    output [25:0]instr_index
    );

    assign opcode=Inst[31:26];
    assign rs=Inst[25:21];
    assign rt=Inst[20:16];
    assign rd=Inst[15:11];
    assign sa=Inst[10:6];
    assign funct=Inst[5:0];
    assign imm16=Inst[15:0];
    assign instr_index=Inst[25:0];
endmodule