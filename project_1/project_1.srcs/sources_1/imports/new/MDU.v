`timescale 1ns / 1ps

module MDU(
    input clk,
    input [3:0]mdu_op,
    input [31:0]rsc1,
    input [31:0]rsc2,
    output reg mdu_pause,
    output reg [63:0]HILO
    );

    /*
        0    mult
        1    multu
        2    div
        3    divu
    */
    wire [63:0] unsigned_prod,signed_prod,signed_quot,unsigned_quot;

    assign unsigned_prod = rsc1 * rsc2;
    assign signed_prod = $signed(rsc1) * $signed(rsc2);

    reg tvalid,tvalidu;
    wire tready,treadyu,out_tvalid,out_tvalidu;


    always@(*)begin
        case(mdu_op)
            4'b0001:    begin
                mdu_pause    <=    0;
                tvalid    <=    0;
                tvalidu   <=    0;
                HILO    <=    signed_prod;
            end
            4'b0010:    begin
                mdu_pause    <=    0;
                tvalid    <=    0;
                tvalidu   <=    0;
                HILO    <=    unsigned_prod;
            end
            4'b0100:    begin
                mdu_pause    <=    ~out_tvalid;
                tvalid    <=    ~(tvalid && tready);
                tvalidu   <=    0;
                HILO    <=    {signed_quot[31:0],signed_quot[63:32]};
            end 
            4'b1000:    begin
                mdu_pause    <=    ~out_tvalidu;
                tvalid    <=    0;
                tvalidu    <=    ~(tvalidu && treadyu);
                HILO    <=    {unsigned_quot[31:0],unsigned_quot[63:32]};
            end 
            default:    begin
                mdu_pause    <=    0;
                tvalid    <=    0;
                tvalidu   <=    0;
                HILO    <=    0;
            end
        endcase
    end

    div div1 (
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

    divu div2 (
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


    // always@(posedge clk)begin
    //     if(rst) begin
    //         HI<=32'b0;
    //         LO<=32'b0;
    //     end
    //     else begin
    //         case(mdu_op)
    //             4'b0001:    HILO    <=    signed_prod;
    //             4'b0010:    HILO    <=    unsigned_prod;
    //             4'b0100:    HILO    <=    {signed_quot[31:0],signed_quot[63:32]};
    //             4'b1000:    HILO    <=    {unsigned_quot[31:0],unsigned_quot[63:32]};
    //             default:    HILO    <=    0;
    //         endcase
    //     end 
    // end

    
endmodule
