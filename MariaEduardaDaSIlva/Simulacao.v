`timescale 1ns/1ns
`include "Processador.v"
`include "Add4.v"
`include "MemoriaDeInstrucoes.v"
`include "Control.v"
`include "Registradores.v"
`include "SignExtend.v"
`include "ALUControl.v"
`include "ALU.v"
`include "Adder32.v"
`include "ShiftLeft2.v"
`include "DataMemory.v"
`include "Mux5.v"
`include "Mux32.v"

module Simulacao;
    reg clk;
    reg reset;

    // Instancia o módulo Processador
    Processador processador (
        .clk(clk),
        .reset(reset)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No comeco, PC desconhecido.
        #10
        reset = 1;  // Reseta o PC
        #20
        reset = 0;  // Volta a Habilitar o PC, e comeca a buscar instrucao

        // Executa alguns ciclos de clock para verificar o fetch
        #100;
        $finish;
    end
    
    // Bloco para inicializar o dump de formas de onda
    // em um VCD para ver no GTK Wave.
    initial begin
        $dumpfile("processador.vcd"); // Nome do arquivo de saída
        $dumpvars(0, Simulacao);    // Registrar todas as variáveis deste módulo
    end

endmodule