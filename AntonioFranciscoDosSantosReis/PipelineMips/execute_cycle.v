`include "ALU_unit.v"



module execute_cycle(clk, reset, MemtoRegE, MemWriteE, ALUSrcE, RegDstE, BranchE, RegWriteE, MemReadE, ALUControlIE, SignImmE, RD1E, 
RD2E, RsDE, RtDE, RdEE, ForwardAE, ForwardBE, WireMuxFileReg, ResultW, regWriteM, MemtoRegM, MemWriteM, MemReadM, ALUOutM, WriteDataM, WriteRegM, WriteRegEHazard, RsE_Hazard, RtE_Hazard);
    input clk, reset, MemtoRegE, MemWriteE, ALUSrcE, RegDstE, BranchE, RegWriteE, MemReadE;
    input ForwardAE, ForwardBE;
    input [2:0] ALUControlIE;
    input [31:0] SignImmE, RD1E, RD2E;
    input [4:0] RsDE, RtDE, RdEE;
    input [31:0] WireMuxFileReg, ResultW;
    output regWriteM, MemtoRegM, MemWriteM, MemReadM;
    output [31:0] ALUOutM;
    output [31:0] WriteDataM;
    output [4:0] WriteRegM, WriteRegEHazard, RsE_Hazard, RtE_Hazard;





    wire [31:0] SrcAE, SrcBE, WriteDataE, ALUOutE;
    wire[4:0] writeRegE;

    reg regWriteE_r, MemtoRegE_r, MemWriteE_r, MemReadE_r;
    reg [31:0] WriteDataE_r, ALUOutE_r, WriteRegE_r;


    //instanciando um mux 3X1
    mux3x1 m1(
              .a(RD1E), 
              .b(ResultW), 
              .c(WireMuxFileReg), 
              .sel(ForwardAE), 
              .out(SrcAE)
              );

    mux3x1 m2 (.a(RD2E), 
              .b(ResultW), 
              .c(WireMuxFileReg), 
              .sel(ForwardBE), 
              .out(WriteDataE)
              );

    mux1 m3 (
             .A(WriteDataE), 
             .B(SignImmE), 
             .sel1(ALUSrcE), 
             .out(SrcBE)
             );


    //instanciando a ALU
    ALU_unit alu (
                  .A(SrcAE), 
                  .B(SrcBE), 
                  .alu_control(ALUControlIE), 
                  .ALU_result(ALUOutE)
                  );
                  
    mux1 m4 (
             .A(RtDE), 
             .B(RdEE), 
             .sel1(RegDstE), 
             .out(WriteDataE)
             );


    assign WriteRegEHazard = writeRegE;
    assign RsE_Hazard = RsDE;
    assign RtE_Hazard = RtDE;

    always@(posedge clk or posedge reset)begin
        if(reset)begin
            regWriteE_r <= 1'b0;
            MemtoRegE_r <= 1'b0;
            MemWriteE_r <= 1'b0;
            MemReadE_r <= 1'b0;
        end
        begin
            regWriteE_r <= RegWriteE;
            MemtoRegE_r <= MemtoRegE;
            MemWriteE_r <= MemWriteE;
            MemReadE_r <= MemReadE;
            WriteDataE_r <= WriteDataE;
            ALUOutE_r <= ALUOutE;
            WriteRegE_r <= writeRegE;
        end

    end

    assign regWriteM = regWriteE_r;
    assign MemtoRegM = MemtoRegE_r;
    assign MemWriteM = MemWriteE_r;
    assign MemReadM = MemReadE_r;
    assign WriteDataM = WriteDataE_r;
    assign ALUOutM = ALUOutE_r;
    assign WriteRegM = WriteRegE_r;


    
    



endmodule