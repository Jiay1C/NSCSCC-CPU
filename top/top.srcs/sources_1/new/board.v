`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/20 13:01:06
// Design Name: 
// Module Name: board
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module board(
    input clk_100m,
    input rst,
    
    input [7:0] sw,
    output [15:0] led,
    //4*4¼üÅÌ
    input [3:0] key_row,
    output [3:0] key_col,
    
    input [31:0] Data0,
    output reg [7:0] AN,
    output reg [7:0] Seg
    );
endmodule
