module test_MIPSProcessor;

    // Declara os sinais
    reg clk;
    reg reset;
    wire [31:0] result;
    wire [31:0] instruction;  // Agora o sinal instrucao está sendo monitorado

    // Instancia o MIPSProcessor
    MIPSProcessor uut (
        .clk(clk),
        .reset(reset),
        .result(result),
        .instruction(instruction)  // Passa instrucao para o testbench
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No começo, o PC está desconhecido.
        #10
        reset = 1;  // Reseta o PC
        #20
        reset = 0;  // Habilita o PC e começa a buscar a instrução

        // Executa alguns ciclos de clock para verificar o fetch
        #135;
        $finish;
    end

    // Monitora as instruções buscadas
    always @(posedge clk) begin
        $display("Start Testbench");
        $monitor("clk=%b, reset=%b, instrucao=%h, result=%h", clk, reset, instruction, result);
    end

    // Bloco para inicializar o dump de formas de onda
    // em um VCD para ver no GTK Wave.
    initial begin
        $dumpfile("processor_cycle.vcd"); // Nome do arquivo de saída
        $dumpvars(0, test_MIPSProcessor);  // Registrar todas as variáveis deste módulo
    end

endmodule
