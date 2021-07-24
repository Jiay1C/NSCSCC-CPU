`timescale 1ns / 1ps

module MDU(
    input clk,
    input rst,
    input [2:0] mdu,
    input [31:0] rsc1,
    input [31:0] rsc2,
    output reg pc_ena,
    output reg[31:0] HI,LO
    );

    /*
        1    mult
        2    multu
        3    div    
        4    divu
        5    mthi
        6    mtlo
    */
    wire [63:0] unsigned_prod,signed_prod,signed_quot,unsigned_quot;

    assign unsigned_prod = rsc1 * rsc2;
    assign signed_prod = $signed(rsc1) * $signed(rsc2);

    reg tvalid,tvalidu;
    wire tready,treadyu,out_tvalid,out_tvalidu;


    always@(*)begin
        case(mdu)
            3'h3:    begin
                pc_ena    =    out_tvalid;
                tvalid    =    ~(tvalid && tready);
            end 
            3'h4:    begin
                pc_ena    =    out_tvalidu;
                tvalidu    =    ~(tvalidu && treadyu);
            end 
            default: pc_ena    =    1;
        endcase
    end

    div d (
        .aclk(clk),                                      // input wire aclk
        .s_axis_divisor_tvalid(tvalid),    // input wire s_axis_divisor_tvalid
        .s_axis_divisor_tready(tready),    // output wire s_axis_divisor_tready
        .s_axis_divisor_tdata(rsc1),      // input wire [31 : 0] s_axis_divisor_tdata
        .s_axis_dividend_tvalid(tvalid),  // input wire s_axis_dividend_tvalid
        .s_axis_dividend_tready(tready),  // output wire s_axis_dividend_tready
        .s_axis_dividend_tdata(rsc2),    // input wire [31 : 0] s_axis_dividend_tdata
        .m_axis_dout_tvalid(out_tvalid),          // output wire m_axis_dout_tvalid
        .m_axis_dout_tdata(signed_quot)            // output wire [63 : 0] m_axis_dout_tdata
    );

    divu du (
        .aclk(clk),                                      // input wire aclk
        .s_axis_divisor_tvalid(tvalidu),    // input wire s_axis_divisor_tvalid
        .s_axis_divisor_tready(treadyu),    // output wire s_axis_divisor_tready
        .s_axis_divisor_tdata(rsc1),      // input wire [31 : 0] s_axis_divisor_tdata
        .s_axis_dividend_tvalid(tvalidu),  // input wire s_axis_dividend_tvalid
        .s_axis_dividend_tready(treadyu),  // output wire s_axis_dividend_tready
        .s_axis_dividend_tdata(rsc2),    // input wire [31 : 0] s_axis_dividend_tdata
        .m_axis_dout_tvalid(out_tvalidu),          // output wire m_axis_dout_tvalid
        .m_axis_dout_tdata(unsigned_quot)            // output wire [63 : 0] m_axis_dout_tdata
    );


    always@(posedge clk)begin
        if(rst) begin
            HI<=32'b0;
            LO<=32'b0;
        end
        else begin
            case(mdu)
                3'h1:    {HI,LO}    <=    signed_prod;
                3'h2:    {HI,LO}    <=    unsigned_prod;
                3'h3:    {LO,HI}    <=    signed_quot;
                3'h4:    {LO,HI}    <=    unsigned_quot;
                3'h5:    HI         <=    rsc1;
                3'h6:    LO         <=    rsc1;
            endcase
        end 
    end
endmodule
