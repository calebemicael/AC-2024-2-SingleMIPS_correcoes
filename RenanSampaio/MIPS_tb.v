`timescale 1ns/1ns
`include "Add4.v"
`include "Adder32.v"
`include "ALU.v"
`include "ALUControl.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "FetchUnit.v"
`include "MemoriaDeInstrucoes.v"
`include "MIPS.v"
`include "Mux2pra1.v"
`include "Mux2pra1com5b.v"
`include "PC.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignExtend.v"


module MIPS_tb;

    // Sinais do testbench
    reg clk;
    reg reset;

    // Instanciação do módulo MIPS
    MIPS uut (
        .clk(clk),
        .reset(reset)
    );

    // Geração do clock
    always #5 clk = ~clk;

    // Inicialização do testbench
    initial begin
        $dumpfile("MIPS_tb.vcd"); // Arquivo de saída para GTKWave
        $dumpvars(0, MIPS_tb);    // Registrar variáveis no GTKWave
        
        // Inicialização dos sinais
        clk = 0;
        reset = 1;

        // Reset ativo por 10ns
        #10 reset = 0;

        // Espera um tempo
        #200;

        // Encerrar simulação
        $finish;
    end

endmodule
