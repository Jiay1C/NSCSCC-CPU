`timescale 1ns / 1ps

module IDJump(
    input [5:0]opcode,
    input [5:0]funct,
    input [31:0]RData,
    input [25:0]JumpTarget,
    input [31:0]inPC,
    input [4:0]rt,
    output reg isJump,
    output reg isLink,
    output reg isBranch,
    output reg [5:0]BranchType,
    output reg [31:0]outPC
    );

    always @(*) begin
        case (opcode)
            6'b000000: begin isBranch=0;BranchType=6'b000000;
                case (funct)
                    6'b001000: begin isJump=1;isLink=0;outPC=RData; end  //jr
                    6'b001001: begin isJump=1;isLink=1;outPC=RData; end  //jalr
                    default:begin isJump=0;isLink=0;outPC=32'b0; end
                endcase
            end
            6'b000010:begin isJump=1;isLink=0;isBranch=0;BranchType=6'b000000;outPC={inPC[31:28],JumpTarget,2'b00}; end //j
            6'b000011:begin isJump=1;isLink=1;isBranch=0;BranchType=6'b000000;outPC={inPC[31:28],JumpTarget,2'b00}; end //jal

            6'b000100:begin isJump=0;isLink=0;isBranch=1;BranchType=6'b000001;outPC=32'b0; end  //BEQ
            6'b000101:begin isJump=0;isLink=0;isBranch=1;BranchType=6'b000010;outPC=32'b0; end  //BNE
            6'b000001:
            begin isJump=0;isBranch=1;outPC=32'b0;
                case (rt)
                    5'b00001:begin isLink=0;BranchType=6'b000100; end   //BGEZ
                    5'b00000:begin isLink=0;BranchType=6'b100000; end   //BLTZ
                    5'b10001:begin isLink=1;BranchType=6'b000100; end   //BGEZAL
                    5'b10000:begin isLink=1;BranchType=6'b100000; end   //BLTZAL
                    default: begin isLink=0;BranchType=6'b000000; end
                endcase
            end
            6'b000111:begin isJump=0;isLink=0;isBranch=1;BranchType=6'b001000;outPC=32'b0; end  //BGTZ
            6'b000110:begin isJump=0;isLink=0;isBranch=1;BranchType=6'b010000;outPC=32'b0; end  //BLEZ

            default:begin isJump=0;isLink=0;isBranch=0;BranchType=6'b000000;outPC=32'b0; end
        endcase
    end
endmodule
