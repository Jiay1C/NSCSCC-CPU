`timescale 1ns / 1ps

module simMDU2();

    reg clk,rst;
    reg [3:0]mdu_op;
    reg [31:0]rsc1;
    reg [31:0]rsc2;
    reg mdu_pause;
    reg [63:0]HILO;

    reg [3:0]mdu_op_0;
    reg [31:0]rsc1_0;
    reg [31:0]rsc2_0;
    reg divst;

    wire [63:0] unsigned_prod,signed_prod,signed_quot,unsigned_quot;

    reg tvalid,tvalidu;
    wire tready,treadyu,out_tvalid,out_tvalidu;

    assign unsigned_prod = rsc1 * rsc2;
    assign signed_prod = $signed(rsc1) * $signed(rsc2);

    always @(posedge divst or posedge out_tvalidu or posedge out_tvalid) begin
        if(divst) mdu_pause=1;
        else mdu_pause=0;
    end

    always@(*)begin
        case(mdu_op)
            4'b0001:    begin
                HILO    <=    signed_prod;
            end
            4'b0010:    begin
                HILO    <=    unsigned_prod;
            end
            4'b0100:    begin
                HILO    <=    {signed_quot[31:0],signed_quot[63:32]};
            end 
            4'b1000:    begin
                HILO    <=    {unsigned_quot[31:0],unsigned_quot[63:32]};
            end 
            default:    begin
                HILO    <=    0;
            end
        endcase
    end

    always@(posedge clk)
    begin
        if(rst) {divst,mdu_op_0,rsc1_0,rsc2_0}=0;
        else begin
            if((mdu_op!=mdu_op_0|rsc1!=rsc1_0|rsc2!=rsc2_0)&(mdu_op[3]|mdu_op[2])) divst=1;
            else divst=0;
            mdu_op_0=mdu_op;
            rsc1_0=rsc1;
            rsc2_0=rsc2;
        end

        if(divst) begin
            tvalid      <=    1;
            tvalidu     <=    1;
        end
        else begin
            case(mdu_op)
                4'b0001:    begin
                    tvalid      <=    0;
                    tvalidu     <=    0;
                end
                4'b0010:    begin
                    tvalid      <=    0;
                    tvalidu     <=    0;
                end
                4'b0100:    begin
                    tvalid      <=    ~tready & tvalid;
                    tvalidu     <=    0;
                end
                4'b1000:    begin
                    tvalid      <=    0;
                    tvalidu     <=    ~treadyu & tvalidu;
                end 
                default:    begin
                    tvalid      <=    0;
                    tvalidu     <=    0;
                end
            endcase
        end
    end

    div div1 (
        .aclk(clk),                                      // input wire aclk
        .s_axis_divisor_tvalid(tvalid),    // input wire s_axis_divisor_tvalid
        .s_axis_divisor_tready(tready),    // output wire s_axis_divisor_tready
        .s_axis_divisor_tdata(rsc2),      // input wire [31 : 0] s_axis_divisor_tdata
        .s_axis_dividend_tvalid(tvalid),  // input wire s_axis_dividend_tvalid
        .s_axis_dividend_tready(tready),  // output wire s_axis_dividend_tready
        .s_axis_dividend_tdata(rsc1),    // input wire [31 : 0] s_axis_dividend_tdata
        .m_axis_dout_tvalid(out_tvalid),          // output wire m_axis_dout_tvalid
        .m_axis_dout_tdata(signed_quot)            // output wire [63 : 0] m_axis_dout_tdata
    );

    divu div2 (
        .aclk(clk),                                      // input wire aclk
        .s_axis_divisor_tvalid(tvalidu),    // input wire s_axis_divisor_tvalid
        .s_axis_divisor_tready(treadyu),    // output wire s_axis_divisor_tready
        .s_axis_divisor_tdata(rsc2),      // input wire [31 : 0] s_axis_divisor_tdata
        .s_axis_dividend_tvalid(tvalidu),  // input wire s_axis_dividend_tvalid
        .s_axis_dividend_tready(treadyu),  // output wire s_axis_dividend_tready
        .s_axis_dividend_tdata(rsc1),    // input wire [31 : 0] s_axis_dividend_tdata
        .m_axis_dout_tvalid(out_tvalidu),          // output wire m_axis_dout_tvalid
        .m_axis_dout_tdata(unsigned_quot)            // output wire [63 : 0] m_axis_dout_tdata
    );


   always #1 clk = ~clk;

    initial begin
        clk=0;rst=1;
        #100
        rst=0;
        mdu_op=4'b0000;rsc1=32'h0;rsc2=32'h0;
        #100
        rst=0;mdu_op=4'b0100;rsc1=32'h12345679;rsc2=32'h2;
        #100
        mdu_op=4'b0100;rsc1=32'h8;rsc2=32'h2;
    end
endmodule
