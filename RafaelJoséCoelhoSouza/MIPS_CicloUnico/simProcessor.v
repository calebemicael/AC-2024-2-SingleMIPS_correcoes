`timescale 1ns/1ns
`include "Add4.v"
`include "Adder32.v"
`include "ALU.v"
`include "ALUControl.v"
`include "CentralUnit.v"
`include "ConcatJump.v"
`include "DataMemory.v"
`include "MemoriaDeInstrucoes.v"
`include "MUX5.v"
`include "MUX32.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "ShiftLeftJump.v"
`include "SignalExtend.v"


module Simulacao;

    // Fetch
    reg clk;
    reg [31:0] PC;
    reg reset;

    // Entradas para o Register File
    reg [4:0] ReadRegister1, ReadRegister2;

    wire [31:0] instrucao;
    
    wire [31:0] WriteData;
    wire [31:0] inputBALU;
    wire [4:0] WriteRegister;
    // Saídas do Register File
    wire [31:0] ReadData1, ReadData2;
    // Entradas para a ALU
    wire [3:0] ALUOperation;
    // Saídas da ALU
    wire [31:0] ALUResult;
    wire Zero;
    // Saídas do UC
    wire RegDst;
    wire Branch;   
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire Jump;

    // LWSW
    wire [31:0] signExtendedOffset;    // Offset estendido
    wire [31:0] memoryReadData;        // Dados lidos da memória

    // BRANCH
    wire [31:0] shiftedOffset;
    wire [31:0] pcPlus4;
    wire [31:0] branchAddress;
    wire [31:0] nextPC;
    wire [31:0] MuxBranchRes;

    // JUMP
    wire [31:0] JumpAddress;
    wire [27:0] shiftedJump;

    Add4 somador (
        .in(PC),
        .out(pcPlus4)
    );

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(PC),
        .instrucao(instrucao)
    );

    Mux5 mux_reg (
        .A(instrucao[15:11]),
        .B(instrucao[20:16]),
        .sel(RegDst),
        .result(WriteRegister)
    );

    SignExtend signExtend (
        .in(instrucao[15:0]),
        .out(signExtendedOffset)
    );

    // Instancia o Register File
    Registradores regfile (
        .clk(clk),
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(WriteRegister),
        .WriteData(ALUResult),
        .RegWrite(RegWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );    

    UnidadeCentral uc (
        .instruction(instrucao),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump)
    );
    
    ALUControl alu_ctrl (
        .ALUOp(ALUOp),
        .funct(instrucao[5:0]),
        .ALUOperation(ALUOperation)
    );

    Mux32 mux_mem (
        .A(signExtendedOffset),
        .B(ReadData2),
        .sel(ALUSrc),
        .result(inputBALU)
    );

    // Instancia a ALU
    ALU alu_mem (
        .A(ReadData1),
        .B(inputBALU),
        .ALUOperation(ALUOperation),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    DataMemory datamemory (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(ReadData2),
        .readData(memoryReadData)
    );

    Mux32 mux_wdata (
        .A(memoryReadData),
        .B(ALUResult),
        .sel(MemtoReg),
        .result(WriteData)
    );

    // BRANCH:
    ShiftLeft2 shiftLeft (
        .in(signExtendedOffset),
        .out(shiftedOffset)
    );

    Adder32 adder_beq (
        .a(pcPlus4),
        .b(shiftedOffset),
        .sum(branchAddress)
    );

    Mux32 mux_beq (
        .A(branchAddress),
        .B(pcPlus4),
        .sel(Branch && Zero),
        .result(MuxBranchRes)
    );

    // Jump
    ShiftLeftJump shiftLeft_jump (
        .in(instrucao[25:0]),
        .out(shiftedJump)
    );

    ConcatJump concat_jump (
        .instruShift(shiftedJump),
        .pcPlus4(pcPlus4[31:28]),
        .JumpAddress(JumpAddress)
    );

    Mux32 mux_jump (
        .A(JumpAddress),
        .B(MuxBranchRes),
        .sel(Jump),
        .result(nextPC)
    );

    // Gera o clock
    always #5 clk = ~clk;
   
    integer i;
    // Simulação
    initial begin
        $dumpfile("simProcessor.vcd");    // Nome do arquivo VCD
        $dumpvars(0, Simulacao);        // Monitora o módulo "Simulacao" e seus sub modulos
        
        // preciso incluir a linha que segue para também
        // monitorar os registradores internos do regfile    
        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, Simulacao.regfile.registers[i]); // Monitora cada registrador
        end
        
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No comeco, PC desconhecido.

        #10;
        reset = 1;  // Reseta o PC
        #10;
        reset = 0;  // Volta a Habilitar o PC, e comeca a buscar instrucao

        // Em 25 ns temos a segunda instrução
        // Após cerca de 10 instruções temos + 100 ns;
        
    end

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            PC <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            PC <= nextPC;  
        end
    end


    // Monitora as instruções buscadas
    always @(posedge clk) begin
        $display("PC: %d, Instrução: %h", PC, instrucao);
    end

    // Monitora o resultado
    initial begin
        $monitor("Time: %0d, ReadData1: %d, ReadData2: %d, ALUResult: %d, Zero: %b",
            $time, ReadData1, ReadData2, ALUResult, Zero);
    end

    always @(*) begin
        if (instrucao === 32'bx) begin
            $display("Program has ended. Stopping simulation.");
            $finish;
        end
    end

endmodule
