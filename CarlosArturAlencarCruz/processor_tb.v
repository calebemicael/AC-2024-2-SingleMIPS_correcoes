`include "processor.v"
`timescale 1ps/1ps

module processor_tb;
    // Sinais de entrada
    reg clk;
    reg reset;

    // Instancia o processador MIPS de ciclo único
    Processor uut (
        .clk(clk),
        .reset(reset)
    );
    
    // Gera o clock
    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("processor_sim.vcd");
        $dumpvars(0, processor_tb);

        // Inicializa sinais
        clk = 0;
        reset = 1;
        
        // Aplica reset
        #20;
        reset = 0;
        
        // Executa a simulação por um determinado tempo
        #200;
        
        // Finaliza a simulação
        $finish;
    end
endmodule