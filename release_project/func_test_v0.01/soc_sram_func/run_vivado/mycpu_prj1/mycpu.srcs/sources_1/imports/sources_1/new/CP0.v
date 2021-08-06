`timescale 1ns / 1ps

module CP0(
        input clk,             //clk
        input rst,             //rst
        input mtc0,            //CPU instruction is Mtc0，检测到是MTC0发�?�这个信�?
        input [31:0] pc,        //当前PC
        input [4:0] addr,        //Specifies CP0 register   CP0内部寄存�?  链接rd
        input [31:0] wdata,    //Data from GP register to replace CP0 register    写的东西，就是从rt里读到的
        input eret,            //instruction is ERET(Exception Return)，检测到是ERET
        input [4:0] ExcCode,     //P341     表C-22内容
        input [31:0] MemAddr,
        output [31:0] rdata,    //Data from CP0 register for GP register,    读的内容，从CP0[rd]读到 CPUrt
        output [31:0] exc_addr    //Address for PC at the beginning of an exception�?    例外结束恢复的PC
    );



    //regsiter      sel     
    //  0            0          Index
    //  2            0          EntryLo0
    //  3            0          EntryLo1
    //  8            0          BadVAddr 
    //  9            0          Count
    //  10           0          EntryHi
    //  11           0          Compare
    //  12           0          Status
    //  13           0          Cause
    //  14           0          EPC
    //  16           0          Config
    //  16           1          Config1


    parameter   SYSCALL    =    5'b01000,
                BREAK      =    5'b01001,
                OVERFLOW      =    5'b01100,
                MEMADDRERROR      =    5'b00100,
                MEMADDRERROR2      =    5'b00101;
    reg [31:0]cp0[0:31];
    integer i;
    reg tick;
    wire exception;
    assign exception =(ExcCode == SYSCALL) || (ExcCode == BREAK)|| (ExcCode == OVERFLOW)|| (ExcCode == MEMADDRERROR)|| (ExcCode == MEMADDRERROR2);
    
    always@(posedge clk) begin
        if(rst)begin
            tick           <=    1'b0;
            for(i=0;i<32;i=i+1) begin
                if(i       !=    12)
                    cp0[i] <=    0;
                else begin
                    cp0[12]<=    {9'b0,1'b1,22'b0};
                end
            end
        end
        else begin
            tick           <=    ~tick;
            if(mtc0) begin
                cp0[addr]  <=    wdata;
                cp0[13][30]<=    (addr == 5'd11) ? 0 : cp0[13][30];
            end   
            else if(exception)begin 
                cp0[12][1] <=    1;
                cp0[13][6:2]<=   ExcCode;
                cp0[14]    <=    pc;
                if(ExcCode==MEMADDRERROR||ExcCode==MEMADDRERROR2) cp0[8]<=MemAddr;
            end
            else if(eret) begin
                cp0[12][1] <=    0;
                cp0[14]    <=    cp0[12][1] ? cp0[14] : pc;
            end
            else begin
                if(tick)
                cp0[9]     <=    cp0[9] + 1'b1;
                if(cp0[9]  ==    cp0[11])
                cp0[13][30]<=    1;    
            end
            
        end 
    end
    assign exc_addr   =    eret ? cp0[14] : pc;
    assign rdata      =    cp0[addr];
    
endmodule