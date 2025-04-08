
`include "file_registers.v"
`include "signal_extend.v"
`include "control_unit.v"



module decode_cycle(clk, reset, instructionD, PcPlus4D, PcBranchD, RegWrite, WireMuxFileReg, RDW, ResultW, ForwardAD, ForwardBD, PcSrcD, RsD_hazard, RtD_hazard, Clr_hazard,  MemtoRegE, MemWriteE, ALUSrcE, RegDstE, BranchE, 
RegWriteE, MemReadE, ALUControlIE, SignImmE, RD1E, RD2E, RsDE, RtDE, RdEE);

    input clk, reset, RegWrite, Clr_hazard;
    input [31:0]instructionD, PcPlus4D, ResultW;
    input [4:0] RDW;
    input [31:0] WireMuxFileReg;
    input ForwardAD, ForwardBD;
    output [31:0] PcBranchD;
    output PcSrcD;
    output [4:0] RsD_hazard, RtD_hazard;
    output MemtoRegE, MemWriteE, ALUSrcE, RegDstE, BranchE, RegWriteE, MemReadE;
    output [2:0] ALUControlIE;
    output [31:0] SignImmE;
    output [31:0] RD1E, RD2E;
    output [4:0]RsDE;
    output [4:0]RtDE;
    output [4:0]RdEE;



    wire [1:0] ALUop_top;
    wire [31:0] Rd1_top, Rd2_top;
    wire [31:0] bits_extends_top;
    wire MemtoRegD, MemWriteD, ALUSrcD, RegDstD, BranchD, RegWriteD, MemReadD;
    wire[2:0] ALUControlID;
    wire [4:0] RsD, RtD, RdE;





    //Declarando registradores para o registrador intermediário:
    reg MemtoRegD_r, MemWriteD_r, ALUSrcD_r, RegDstD_r, BranchD_r, RegWriteD_r, MemReadD_r;
    reg [2:0] ALUControlID_r;
    reg [31:0] RD1_r, RD2_r;
    reg [25:21] RsD_r;
    reg [20:16] RtD_r;
    reg [15:11] RdE_r;
    reg [31:0] SignImmD_r;


    //Declarando os sinais de saída 


    assign RsD = instructionD[25:21];
    assign RtD = instructionD[20:16];
    assign RdE = instructionD[15:11];


    assign RsD_hazard = RsD;
    assign RtD_hazard = RtD;

    //Instanciar unidade de controle
    control_unit c_unit(
                        .instruction(instructionD[31:26]), 
                        .RegDst(RegDstD), 
                        .Branch(BranchD), 
                        .MemRead(MemReadD), 
                        .MemtoReg(MemtoRegD), 
                        .ALUop(ALUop_top), 
                        .MemWrite(MemWriteD),    
                        .ALUSrc(ALUSrcD), 
                        .RegWrite(RegWriteD), //verificar isso, no pipeline regwrite n fica aqui
                        .jump()
                        );

    // instanciando alu_control

    ALU_control alu_c(
                      .ALUop(ALUop_top), 
                      .funct(instructionD[5:0]), 
                      .ALUControl(ALUControlID)
                      );


    //Instanciar banco de registradores
    file_registers f_registers(
                               .clk(clk), 
                               .reset(reset), 
                               .regWrite(RegWrite), 
                               .Rs1(instructionD[25:21]), 
                               .Rs2(instructionD[20:16]), 
                               .wR(RDW), 
                               .writeData(ResultW), 
                               .Rd1(Rd1_top), 
                               .Rd2(Rd2_top)
                               );


    //instanciar extensor de sinal

    signal_extend s_extend(
                           .instruction(instructionD[15:0]), 
                           .bits_extends(bits_extends_top)
                           );

    // Instanciar o modulo que faz a soma com shift de 2

    adder_with_shift adder (
                            .in1(PcPlus4D), 
                            .in2(bits_extends_top), // bits_extends_top = SignImmD 
                            .out_adder(PcBranchD)
                            );

   wire [31:0] mux1_result, mux2_result; 
   mux_fetch mux1(
                  .a(Rd1_top), 
                  .b(WireMuxFileReg),
                  .s(ForwardAD), 
                  .c(mux1_result)
                  );

    mux_fetch mux2(
                  .a(Rd2_top), 
                  .b(WireMuxFileReg),
                  .s(ForwardBD), 
                  .c(mux2_result)
                  );
    
    assign equalID = (mux1_result == mux2_result) ? 1'b1 : 1'b0;


    //instanciar uma and para verificar o sinal equalID com branch
    assign PcSrcD = equalID & BranchD;


    // declarando o registrador lógico

    always@(posedge clk or posedge reset or Clr_hazard)begin // VOLTAR E OLHAR MELHOR O Clr_Hazard geralmente utilizado para limpar conteudo de regitradores

        if(reset)begin

            MemtoRegD_r <= 1'b0; 
            MemWriteD_r <= 1'b0;
            ALUSrcD_r <= 1'b0;
            RegDstD_r <= 1'b0;
            BranchD_r <= 1'b0;
            RegWriteD <= 1'b0;
            MemReadD_r <= 1'b0;
            ALUControlID_r <= 3'b000;
            RD1_r <= 32'b0;
            RD2_r <= 32'b0;
            RsD_r <= 5'b0;
            RtD_r <= 5'b0;
            RdE_r <= 5'b0;
            SignImmD_r <=32'b0;

        end
        else if(Clr_hazard)begin

            MemtoRegD_r <= 1'b0; 
            MemWriteD_r <= 1'b0;
            ALUSrcD_r <= 1'b0;
            RegDstD_r <= 1'b0;
            BranchD_r <= 1'b0;
            RegWriteD <= 1'b0;
            MemReadD_r <= 1'b0;
            ALUControlID_r <= 3'b000;
            RD1_r <= 32'b0;
            RD2_r <= 32'b0;
            RsD_r <= 5'b0;
            RtD_r <= 5'b0;
            RdE_r <= 5'b0;
            SignImmD_r <=32'b0;

        end
        else begin

            MemtoRegD_r <= MemtoRegD; 
            MemWriteD_r <= MemWriteD;
            ALUSrcD_r <= ALUSrcD;
            RegDstD_r <= RegDstD;
            BranchD_r <= BranchD;
            RegWriteD_r <= RegWriteD;
            MemReadD_r <= MemReadD;
            ALUControlID_r <= ALUControlID;
            RD1_r <= Rd1_top;
            RD2_r <= Rd2_top;
            RsD_r <= RsD;
            RtD_r <= RtD;
            RdE_r <= RdE;
            SignImmD_r <=bits_extends_top; 

        end

    end

    assign MemtoRegE = MemtoRegD_r;
    assign MemWriteE = MemWriteD_r;
    assign ALUSrcE = ALUSrcD_r;
    assign RegDstE = RegDstD_r;
    assign BranchE = BranchD_r;
    assign RegWriteE = RegWriteD_r;
    assign MemReadE = MemReadD_r;
    assign ALUControlIE = ALUControlID_r;
    assign RD1E = RD1_r;
    assign RD2E = RD2_r;
    assign RsDE = RsD_r;
    assign RtDE = RtD_r;
    assign RdEE = RdE_r;
    assign SignImmE = SignImmD_r;





endmodule