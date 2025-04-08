`timescale 1ns / 1ps

module mips_tb;
    reg clk;
    reg reset;

    // Instância do Datapath
    MIPS_Datapath uut (.clk(clk), .reset(reset));

    always #5 clk = ~clk; // Clock de 10ns

    initial begin
        // Inicializa as entradas
        clk = 0;
        reset = 1;

        // Reseta o sistema
        #10;
        reset = 0;

        #100;

        $finish;
    end

    initial begin
        $dumpfile("mips_tb.vcd");
        $dumpvars(0, mips_tb);
    end
endmodule
