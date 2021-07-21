`timescale 1ns / 1ps

module IDJump(
    input [5:0]opcode,
    input [5:0]funct,
    input [31:0]RData,
    input [25:0]JumpTarget,
    input [31:0]inPC,
    output reg isJump,
    output reg isLink,
    output reg [31:0]outPC
    );

    always @(*) begin
        case (opcode)
            6'b000000: 
            begin
                case (funct)
                    6'b001000: begin isJump=1;isLink=0;outPC=RData; end  //jr
                    6'b001001: begin isJump=1;isLink=1;outPC=RData; end  //jalr
                    default:begin isJump=0;isLink=0;outPC=32'b0; end
                endcase
            end
            6'b000010:begin isJump=1;isLink=0;outPC={inPC[31:28],JumpTarget,2'b00}; end //j
            6'b000011:begin isJump=1;isLink=1;outPC={inPC[31:28],JumpTarget,2'b00}; end //jal
            default:begin isJump=0;isLink=0;outPC=32'b0; end
        endcase
    end
endmodule
