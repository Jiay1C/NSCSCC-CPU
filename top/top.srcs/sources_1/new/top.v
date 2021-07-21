`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/20 12:29:39
// Design Name: 
// Module Name: top
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


module top(
    input clk_100m,
    input rst,
    input clk,
    //LCD
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout [15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn,
    
    input [7:0] sw,
    output [15:0] led,
    //4*4¼üÅÌ
    input [3:0] key_row,
    output [3:0] key_col,
    
    input [31:0] Data0,
    output reg [7:0] AN,
    output reg [7:0] Seg
    );
    
    screen_display screen(
        .clk_100m(clk_100m),
        .rst(rst),
        .clk(clk),

        .lcd_rst(lcd_rst),
        .lcd_cs(lcd_cs),
        .lcd_rs(lcd_rs),
        .lcd_wr(lcd_wr),
        .lcd_rd(lcd_rd),
        .lcd_data_io(lcd_data_io),
        .lcd_bl_ctr(lcd_bl_ctr),
        .ct_int(ct_int),
        .ct_sda(ct_sda),
        .ct_scl(ct_scl),
        .ct_rstn(ct_rscn)
        );
    
    board board(
        .clk_100m(clk_100m),
        .rst(rst),
        .sw(sw),
        .led(led),
        .key_row(key_row),
        .key_col(key_col),
        .Data0(Data0),
        .AN(AN),
        .Seg(Seg)
        );
endmodule
