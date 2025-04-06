`timescale 1ns/1ps
module tb_processador_mips;
    reg clk;
    reg reset;
    
    // Instancia o processador MIPS
    Processador_MIPS uut (
        .clk(clk),
        .reset(reset)
    );
    
    // Geração do clock: período de 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Sequência de reset e término da simulação
    initial begin
        reset = 1;
        #15;       // Mantém o reset ativo por alguns ciclos
        reset = 0;
        #500;      // Ajuste o tempo de simulação conforme necessário
        $finish;
    end
    
    // Gerar arquivo de waveform (VCD) para visualizar com GTKWave
    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars(0, tb_processador_mips);
    end
    
    // Monitoramento dos sinais chave: PC e instrução atual
    initial begin
        $monitor("Time=%0t | PC=%h | Instr=%h", $time, uut.pc, uut.instrucao);
    end
endmodule
