`timescale 1ns/1ps

module testbench_mips;
    reg clk, reset;

    // instancia o processador MIPS de ciclo único
    mips_ciclo_unico UUT (
        .clk(clk),
        .reset(reset)
    );

    // Geração do Clock 
    always #10 clk = ~clk;
    initial begin
        $dumpfile("mips_tb.vcd");  // Arquivo de saída pro GTK
        $dumpvars(0, testbench_mips);

        // inicializa sinais
        clk = 0;
        reset = 1;

        #20 reset = 0; // 

        // Monitora a execução a cada ciclo de clock
        repeat (20) begin  // Executa por 20 ciclos
            #20;
            $display("PC = %h, Instrucao = %b", UUT.pc_atual, UUT.MEM_INST.instrucao);
        end

        // Exibe os valores dos registradores (todos os 32)
        $display("\n=== REGISTRADORES ===");
        for (integer i = 0; i < 32; i = i + 1) begin
            $display("R%0d: %d", i, UUT.REGISTROS.registradores[i]);
        end

        // exibe os valores da memoria para verificar operações de Load e Store (todas as 256 posições)
        $display("\n=== MEMORIA DE DADOS ===");
        for (integer i = 0; i < 256; i = i + 1) begin
            $display("Mem[%0d]: %d", i, UUT.MEM_DADOS.mem[i]);
        end

        // Finaliza a simulaçao
        #100 $finish;
    end
endmodule
