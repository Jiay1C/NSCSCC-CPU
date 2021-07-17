module Digital(
    input CLK,
    input CLR,
    input [31:0] Data0,
    output reg [7:0] AN,
    output reg [7:0] Seg
    );
    // 16位计数器
    reg [15:0] cnt1;
    always@(posedge CLK or negedge CLR ) begin
    if(!CLR)
        cnt1 <= 16'd0;
    else if (cnt1 <= 16'd50000)
        cnt1 <= cnt1 +1'b1;
    else
        cnt1 <= 16'd0;
    end
    
    //分频
    reg clk_low1;
    always@(posedge CLK or negedge CLR) begin
    if(!CLR)
        clk_low1 <= 1'b0;
    else if (cnt1 <= 16'd24999) begin
        clk_low1 <= 1'b0;
    end
    else
        clk_low1 <= 1'b1;
    end
    
    //显示 
    reg [3:0] data_;
    always@(posedge CLK or negedge CLR) begin
    if(!CLR)
        Seg <= 8'd0;
    else begin
        case (data_)
                4'h0:Seg <= 8'hfc;
                4'h1:Seg <= 8'h60;
                4'h2:Seg <= 8'hda;
                4'h3:Seg <= 8'hf2;
                4'h4:Seg <= 8'h66;
                4'h5:Seg <= 8'hb6;
                4'h6:Seg <= 8'hbe;
                4'h7:Seg <= 8'he0;
                4'h8:Seg <= 8'hfe;
                4'h9:Seg <= 8'hf6;
                4'hA:Seg <= 8'hee;
                4'hB:Seg <= 8'h3e;
                4'hC:Seg <= 8'h9c;
                4'hD:Seg <= 8'h7a;
                4'hE:Seg <= 8'hde;
                4'hF:Seg <= 8'h8e;
        endcase
    end
end

      //切换数码管
      reg [3:0]cnt2;
      always@(posedge clk_low1 or negedge CLR) begin
          if(!CLR)
              cnt2 <= 4'd0;
          else if (cnt2 < 4'd8)
              cnt2 <= cnt2 +1'b1;
          else
              cnt2 <= 4'd0;
      end

      always@(posedge CLK or negedge CLR) begin
          if(!CLR)
              AN <= 8'b11111111;
          else 
          begin
              case (cnt2)
              4'd1:AN <= 8'b01111111;
              4'd2:AN <= 8'b10111111;
              4'd3:AN <= 8'b11011111;
              4'd4:AN <= 8'b11101111;
              4'd5:AN <= 8'b11110111;
              4'd6:AN <= 8'b11111011;
              4'd7:AN <= 8'b11111101;
              4'd8:AN <= 8'b11111110;
              endcase
          end
      end

      //对应数码管输出
      always@(posedge CLK or negedge CLR) begin
          if(!CLR)
              data_ <= 4'd0;
          else 
          begin
              case (AN)
              8'b01111111:data_ <= Data0[31:28];
              8'b10111111:data_ <= Data0[27:24];
              8'b11011111:data_ <= Data0[23:20];
              8'b11101111:data_ <= Data0[19:16];
              8'b11110111:data_ <= Data0[15:12];
              8'b11111011:data_ <= Data0[11:8];
              8'b11111101:data_ <= Data0[7:4];
              8'b11111110:data_ <= Data0[3:0];
              endcase
          end
      end
endmodule
