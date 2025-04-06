`include "ALU.v"
`include "ALUControl.v"
`include "controlUnit.v"
`include "dataMemory.v"
`include "MemoriaDeInstrucoes.v"
`include "MUX1.v"
`include "processador.v"
`include "ProgramCounter.v"
`include "registers.v"
`include "signExtended.v"
`include "ALU.v"

`timescale 1ns / 1ps

module simulacao();
    reg clk;
    reg rst;

    wire [31:0] pc;          
    wire [31:0] instruction; 
    wire RegWrite, ALUSrc, Branch, Jump; 

    reg [31:0] registerArray [31:0];

    processador inst_processador (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .instruction(instruction),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .Jump(Jump)
    );

    // Bloco principal de inicialização 
    initial begin
        //Arquivo de dump para visualização de ondas
        $dumpfile("Processador.vcd");
        $dumpvars(0, simulacao);


        // Inicializa clock e reset
        clk = 0;
        rst = 1;

        // Carrega o arquivo que será armazenado na nemoria de instrucoes
        $readmemb("codigo.mem", uut.inst_MemoriaDeInstrucoes);
        $display ("Memoria de instrucoes carregada com sucesso!");

        // Desativa o reset após 10 ns
        #10 rst = 0;

        repeat (60) begin
            #5 clk = ~clk;
        end

        $finish;
    end

    initial begin
        $monitor("Tempo: %0d | registerArray[0]: %h", $time, registerArray[0]);
    end

 
endmodule