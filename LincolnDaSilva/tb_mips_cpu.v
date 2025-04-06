module tb_mips_cpu;

    reg clk, reset;
    wire [31:0] pcAtual;  // Sinal de saída do PC

    // Instância do mips_cpu
    mips_cpu uut (
        .clk(clk),
        .reset(reset),
        .pcAtual(pcAtual)  // Conectando o sinal de PC
    );

    // Gerador de clock
    always #5 clk = ~clk;

    // Inicialização
    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        #100 $finish;  // Finaliza a simulação após 100 unidades de tempo
    end

    // Dump de forma de onda
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_mips_cpu);  // Captura todos os sinais no módulo de teste
    end

endmodule
