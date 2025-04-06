`timescale 1ns / 1ps

// Inclua todos os módulos necessários
`include "Add4.v"
`include "Adder32.v"
`include "ALU.v"
`include "ALUControl.v"
`include "BEQInstruction.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "Datapaths.v"
`include "FetchUnit.v"
`include "InstructionMemory.v"
`include "Jump.v"
`include "Mux.v"
`include "Mux5bits.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"

module simulacaoMIPS_tb;

    // Entradas
    reg clk;
    reg reset;

    // Instanciação do datapath
    Datapaths uut (
        .clk(clk),
        .reset(reset)
    );

    // Geração do clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock com período de 10 ns
    end

    // Inicialização e simulação
    initial begin
        // Inicializa o arquivo .vcd para visualização no GTKWave
        $dumpfile("simulacaoMIPS_tb.vcd");
        $dumpvars(0, simulacaoMIPS_tb);

        // Reseta o sistema
        reset = 1;
        #10; // Mantém o reset ativo por 10 ns
        reset = 0;

        // Aguarda a execução das instruções
        #100; // Simula por 100 ns

        // Finaliza a simulação
        $finish;
    end

endmodule