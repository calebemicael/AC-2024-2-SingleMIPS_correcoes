`timescale 1ns/1ns
`include "mips_single_cycle.v"

module tb_mips_single_cycle;

    reg clk;
    reg reset;

    mips_single_cycle uut (
        .clk(clk),
        .reset(reset)
    );

    // Geração do clock
    always #5 clk = ~clk; 

    // Simulação
    initial begin
        // Geração do arquivo VCD para visualização
        $dumpfile("mips_single_cycle_tb.vcd");
        $dumpvars(0, tb_mips_single_cycle);

        // Inicialização dos sinais
        clk = 0;
        reset = 1;

        // Reseta o processador
        #10 reset = 0;

        #40; // Aguarda a execução

        #20; // Aguarda a execução

        #20; // Aguarda a execução

        #20; // Aguarda a execução

        #20; // Aguarda a execução

        #10;
        $finish; // Termina a execução da instruções presentes no instruction memory
    end

    // Monitoramento dos sinais
    initial begin
        $monitor("Time: %0d | PC: %h | Instruction: %h | ReadData1: %h | ReadData2: %h | ALUResult: %h | MemReadData: %h | NextPC: %h",
            $time, uut.instruction_PC, uut.instruction_fetch_unit, uut.readData1, uut.readData2, uut.ALU_result, uut.readData, uut.next_pc);
    end

endmodule