`include "Mips.v"
module tb_Mips;

// Declaração de variáveis de teste
reg clk;
reg reset;
wire [31:0] result;

// Instanciando o módulo Mips
Mips mips_inst (
    .clk(clk),
    .reset(reset),
    .result(result)
);

// Gerador de clock (a cada 10 unidades de tempo o clock alterna)
always begin
    #10 clk = ~clk;  // Alterna o clock a cada 10 unidades de tempo
end

// Sequência de estímulos
initial begin
    // Inicialização
    clk = 0;
    reset = 0;

    $dumpfile("Mips.vcd");  // Define o nome do arquivo VCD
    $dumpvars(0, tb_Mips);       // Grava todas as variáveis do testbench no arquivo VCD
    
    // Aplicando reset
    $display("Aplicando reset...");
    reset = 0;
    #70 reset = 1;  // Mantém o reset por 2 ciclos de clock (20 unidades de tempo)
    
    #80 reset = 0;
    // Teste - observa o comportamento do MIPS por alguns ciclos de clock
    $display("Iniciando a simulação...");
    #1200;
    
    // Finaliza a simulação
    $finish;
end

// Monitoramento das variáveis
initial begin
    $monitor("Tempo = %0t, result = %h", $time, result);  // Exibe o valor de 'result' em cada ciclo
end

endmodule
