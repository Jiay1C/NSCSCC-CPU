`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/02 22:31:53
// Design Name: 
// Module Name: simmycpu
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


module simmycpu();
    reg resetn;
    reg clk;
    wire [15:0] led;
    wire [1 :0] led_rg0;
    wire [1 :0] led_rg1;
    wire [7 :0] num_csn;
    wire [6 :0] num_a_g;
    wire [7 :0] switch;
    wire [3 :0] btn_key_col;
    wire [3 :0] btn_key_row;
    wire [1 :0] btn_step;
    soc_axi_lite_top #(.SIMULATION(1'b1)) soc_lite
    (
       .resetn      (resetn     ), 
       .clk         (clk        ),
    
        //------gpio-------
        .num_csn    (num_csn    ),
        .num_a_g    (num_a_g    ),
        .led        (led        ),
        .led_rg0    (led_rg0    ),
        .led_rg1    (led_rg1    ),
        .switch     (switch     ),
        .btn_key_col(btn_key_col),
        .btn_key_row(btn_key_row),
        .btn_step   (btn_step   )
    );
    wire cpu_clk;
    wire sys_clk;
    wire [31:0] debug_wb_pc;
    wire [3 :0] debug_wb_rf_wen;
    wire [4 :0] debug_wb_rf_wnum;
    wire [31:0] debug_wb_rf_wdata;
    assign cpu_clk           = soc_lite.cpu_clk;
    assign sys_clk           = soc_lite.sys_clk;
    assign debug_wb_pc       = soc_lite.debug_wb_pc;
    assign debug_wb_rf_wen   = soc_lite.debug_wb_rf_wen;
    assign debug_wb_rf_wnum  = soc_lite.debug_wb_rf_wnum;
    assign debug_wb_rf_wdata = soc_lite.debug_wb_rf_wdata;
    initial begin
        clk=0;resetn=0;
        forever begin
            #1;
            clk=~clk;
        end
        #10;
        resetn=1;
    end
endmodule
