`include "fetch.v"
`include "execute_cycle.v"
`include "decode_cycle.v"
`include "hazard_unit.v"
`include "memory_cycle.v"
`include "auxiliar.v"

module main(clk, reset);
    input clk, reset;


    //declarar fios intermediários

    wire [31:0] PcBranchD_top, instructionD_top, PcPlus4D_top, WireMuxFileReg_top, SignImmE_top, RD1E_top, RD2E_top;
    wire MemtoRegE_top, MemWriteE_top, ALUSrcE_top, RegDstE_top, BranchE_top, RegWriteE_top, MemReadE_top;
    wire regWriteM_top, MemtoRegM_top, MemWriteM_top, MemReadM_top;
    wire [31:0] ALUOutM_top, WriteDataM_top;
    wire [4:0] WriteRegM_top, WriteRegEHazard_top, RsE_Hazard_top, RtE_Hazard_top;
    wire [2:0] ALUControlIE_top;
    wire [4:0] RDW_top;
    wire [4:0] RsDE_top, RtDE_top, RdEE_top;
    wire ForwardAD, ForwardBD;
    wire [4:0] RsD_hazard, RtD_hazard;
    wire PcSrcD_top;
    wire RegWriteW_top;
    
    
   
    //inicializar fetch cycle
    fetch_cycle fetch(.clk(clk), 
                      .reset(reset), 
                      .PcSrcE(PcSrcD_top), 
                      .instructionD(instructionD_top), 
                      .PcPlus4D(PcPlus4D_top), 
                      .PcBranchD(PcBranchD_top),
                      .enable(StallF_top)
                      );

    wire [4:0] RsD_hazard_top, RtD_hazard_top;
    //inicializar decode cycle
    decode_cycle decoder(.clk(clk), 
                         .reset(reset), 
                         .instructionD(instructionD_top), 
                         .PcPlus4D(PcPlus4D_top), 
                         .PcBranchD(PcBranchD_top), 
                         .RegWrite(RegWriteW_top), 
                         .WireMuxFileReg(ALUOut_top), 
                         .RDW(WriteRegW_top), 
                         .ResultW(ResultW_top), 
                         .ForwardAD(ForwardAD_top), 
                         .ForwardBD(ForwardBD_top), 
                         .PcSrcD(PcSrcD_top),
                         .RsD_hazard(RsD_hazard_top), 
                         .RtD_hazard(RtD_hazard_top), 
                         .Clr_hazard(FlushE_top), 
                         .MemtoRegE(MemtoRegE_top), 
                         .MemWriteE(MemWriteE_top), 
                         .ALUSrcE(ALUSrcE_top), 
                         .RegDstE(RegDstE_top), 
                         .BranchE(BranchE_top),
                         .RegWriteE(RegWriteE_top), 
                         .MemReadE(MemReadE_top), 
                         .ALUControlIE(ALUControlIE_top), 
                         .SignImmE(SignImmE_top), 
                         .RD1E(RD1E_top), 
                         .RD2E(RD2E_top), 
                         .RsDE(RsDE_top), 
                         .RtDE(RtDE_top), 
                         .RdEE(RdEE_top)
                         );
    //inicializar execute cycle

    

    execute_cycle execute(.clk(clk), 
                          .reset(reset), 
                          .MemtoRegE(MemtoRegE_top), 
                          .MemWriteE(MemWriteE_top), 
                          .ALUSrcE(ALUSrcE_top), 
                          .RegDstE(RegDstE_top), 
                          .BranchE(BranchE_top),
                          .RegWriteE(RegWriteE_top), 
                          .MemReadE(MemReadE_top), 
                          .ALUControlIE(ALUControlIE_top), 
                          .SignImmE(SignImmE_top), 
                          .RD1E(RD1E_top), 
                          .RD2E(RD2E_top), 
                          .RsDE(RsDE_top), 
                          .RtDE(RtDE_top), 
                          .RdEE(RdEE_top), 
                          .ForwardAE(ForwardAE_top), 
                          .ForwardBE(ForwardBE_top), 
                          .WireMuxFileReg(ALUOut_top), 
                          .ResultW(ResultW_top),
                          .regWriteM(regWriteM_top), 
                          .MemtoRegM(MemtoRegM_top), 
                          .MemWriteM(MemWriteM_top), 
                          .MemReadM(MemReadM_top), 
                          .ALUOutM(ALUOutM_top), 
                          .WriteDataM(WriteDataM_top),
                          .WriteRegM(WriteRegM_top), 
                          .WriteRegEHazard(WriteRegEHazard_top), 
                          .RsE_Hazard(RsE_Hazard_top), 
                          .RtE_Hazard(RtE_Hazard_top)
                          );


    wire MemtoRegW_top;
    wire [31:0] ReadDataW_top, ALUOut_top;
    wire [4:0] WriteRegW_top;
    wire [31:0] ResultW_top;
    
        //inicializar memory cycle
    memory_cycle m1 (.clk(clk), 
                     .reset(reset), 
                     .RegWriteM(regWriteM_top), 
                     .MemtoRegM(MemtoRegM_top), 
                     .MemWriteM(MemWriteM_top), 
                     .MemReadM(MemReadM_top), 
                     .ALUOutM(ALUOutM_top), 
                     .WriteDataM(WriteDataM_top), 
                     .WriteRegM(WriteRegM_top), 
                     .WriteRegM_Hazard(WriteRegW_top), 
                     .RegWriteW(RegWriteW_top), 
                     .MemtoRegW(MemtoRegW_top), 
                     .ReadDataW(ReadDataW_top), 
                     .ALUOutW(ALUOut_top), 
                     .WriteRegW(WriteRegW_top)
                     );

    assign ResultW_top = (MemtoReg_top == 1'b1) ? ReadDataW_top : ALUOut_top;

    //inicializar unidade de hazards

    wire StallF_top, StallD_top, ForwardAD_top, ForwardBD_top, FlushE_top, ForwardAE_top, ForwardBE_top;
    hazard_unit hazards(.RsD(RsD_hazard_top), 
                        .RtD(RtD_hazard_top), 
                        .RsE(RsE_Hazard_top), 
                        .RtE(RtE_Hazard_top), 
                        .WriteRegE(WriteRegEHazard_top), 
                        .WriteRegM(WriteRegM_top),
                        .WriteRegW(WriteRegW_top), 
                        .StallF(StallF_top), 
                        .StallD(StallD_top), 
                        .ForwardAD(ForwardAD_top), 
                        .ForwardBD(ForwardBD_top), 
                        .FlushE(FlushE_top), 
                        .ForwardAE(ForwardAE_top), 
                        .ForwardBE(ForwardBE_top)
                        );



endmodule