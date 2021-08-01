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
    input MemEN,
    output outRegWrite,
    output reg [31:0]MemRData,
    output outPCSrc,
    output DMPause,
    //SRAM
    input [31:0]data_rdata,
    input data_addr_ok,
    input data_data_ok,
    output reg data_req,
    output data_wr,
    output [1:0]data_size,
    output [31:0]data_addr,
    output [31:0]data_wdata
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
    

    assign data_wdata=WData;
    assign data_size=((MemSize==2'h2)?2'h0:
                     ((MemSize==2'h1)?2'h1:2'h2));
    assign data_addr=ALURes;
    assign data_wr=MemWrite;
    assign DMPause=data_req;
    assign RData=data_rdata;

    always @(posedge CLK or posedge data_addr_ok or posedge data_data_ok) begin
        if(CLK&&MemEN) begin
            data_req=1;
        end
        else if(data_addr_ok&&data_data_ok) begin
            data_req=0;
        end
    end
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

    /*
    DM dm (
    .clka(CLK),    // input wire clka
    .wea(Write),      // input wire [0 : 0] wea
    .addra(ALURes>>2),  // input wire [15 : 0] addra
    .dina(WData),    // input wire [31 : 0] dina
    .douta(RData)  // output wire [31 : 0] douta
    );

    */
endmodule
