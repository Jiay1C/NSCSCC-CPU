`timescale 1ns / 1ps

module MEM(
    input CLK,
    input [31:0]ALURes,
    input CF,
    input OF,
    input SF,
    input ZF,
    input inRegWrite,
    input [31:0]MemWData,
    input inPCSrc,
    input MemWrite,
    input [5:0]BranchType,
    input [1:0]MemSize,
    input MemSignExt,
    output outRegWrite,
    output reg [31:0]MemRData,
    output outPCSrc
    );

    reg [3:0]Write;
    reg [31:0]WData;
    wire [31:0]RData;

    assign outRegWrite=inRegWrite&(inPCSrc^~outPCSrc);

    assign outPCSrc=inPCSrc&(
            (BranchType[0]&(ZF))|    //=
            (BranchType[1]&(!ZF))| //!=
            (BranchType[2]&(ZF|!SF))| //>=
            (BranchType[3]&(!ZF&!SF))| //>
            (BranchType[4]&(ZF|SF))| //<=
            (BranchType[5]&(!ZF&SF)) //<
        );
    
    always @(*) begin
        case (MemSize)
            2'h0: begin Write={4{MemWrite}};WData=MemWData;MemRData=RData; end
            2'h1: begin 
                        WData={2{MemWData[15:0]}};
                        if(MemSignExt)
                        begin
                            case(ALURes[1])
                            0:begin MemRData={16'b0,RData[15:0]};Write={4{MemWrite}}&4'b0011; end
                            1:begin MemRData={16'b0,RData[31:16]};Write={4{MemWrite}}&4'b1100; end
                            endcase
                        end
                        else begin
                            case(ALURes[1])
                            0:begin MemRData={{16{RData[15]}},RData[15:0]};Write={4{MemWrite}}&4'b0011; end
                            1:begin MemRData={{16{RData[31]}},RData[31:16]};Write={4{MemWrite}}&4'b1100; end
                            endcase
                        end
                  end
            2'h2: begin 
                        WData={4{MemWData[7:0]}}; 
                        if(MemSignExt)
                        begin
                            case(ALURes[1:0])
                            2'b00:begin MemRData={24'b0,RData[7:0]};Write={4{MemWrite}}&4'b0001; end
                            2'b01:begin MemRData={24'b0,RData[15:8]};Write={4{MemWrite}}&4'b0010; end
                            2'b10:begin MemRData={24'b0,RData[23:16]};Write={4{MemWrite}}&4'b0100; end
                            2'b11:begin MemRData={24'b0,RData[31:24]};Write={4{MemWrite}}&4'b1000; end
                            endcase
                        end else
                        begin
                            case(ALURes[1:0])
                            2'b00:begin MemRData={{24{RData[7]}},RData[7:0]};Write={4{MemWrite}}&4'b0001; end
                            2'b01:begin MemRData={{24{RData[15]}},RData[15:8]};Write={4{MemWrite}}&4'b0010; end
                            2'b10:begin MemRData={{24{RData[23]}},RData[23:16]};Write={4{MemWrite}}&4'b0100; end
                            2'b11:begin MemRData={{24{RData[31]}},RData[31:24]};Write={4{MemWrite}}&4'b1000; end
                            endcase
                        end
                  end
            default: {WData,MemRData,Write}=0;
        endcase
    end

    DM dm (
    .clka(CLK),    // input wire clka
    .wea(Write),      // input wire [0 : 0] wea
    .addra(ALURes>>2),  // input wire [15 : 0] addra
    .dina(WData),    // input wire [31 : 0] dina
    .douta(RData)  // output wire [31 : 0] douta
    );

endmodule
