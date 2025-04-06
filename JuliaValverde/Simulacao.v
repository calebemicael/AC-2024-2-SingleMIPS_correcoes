`timescale 1ns/1ns
`include "Add4.v"
`include "Adder32.v"
`include "ALU.v"
`include "ALUControl.v"
`include "Control.v"
`include "DataMemory.v"
`include "JumpAddressCalculator.v"
`include "MemoriaDeInstrucoes.v"
`include "MUX_5b_2x1.v"
`include "MUX_32b_2x1.v"
`include "ProcessadorMIPS.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignExtend.v"

module Simulacao;

    reg clk;
    reg reset;

    // Instancia o módulo ProcessadorMIPS
    ProcessadorMIPS mips (
        .clk(clk),
        .rst(reset)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No comeco, PC desconhecido.

        // Executa alguns ciclos de clock para verificar o fetch
        #200;
        $finish;
    end
    
    // Bloco para inicializar o dump de formas de onda
    // em um VCD para ver no GTK Wave.
    initial begin
        $dumpfile("ProcessadorMIPS.vcd"); // Nome do arquivo de saída
        $dumpvars(0, Simulacao);    // Registrar todas as variáveis deste módulo
    end

endmodule
