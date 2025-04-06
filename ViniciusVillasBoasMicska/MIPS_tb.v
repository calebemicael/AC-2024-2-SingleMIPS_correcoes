`timescale 1ns/1ns
`include "MIPS.v"

module MIPS_tb();

  reg clk;
  reg reset;

  MIPS dut(
    .clk(clk),
    .reset(reset)
  );

  // Gera o clock
  always #5 clk = ~clk;

  initial begin
    $dumpfile("mips.vcd"); // Nome do arquivo de saída
    $dumpvars(0, MIPS_tb);    // Registrar todas as variáveis deste módulo

    for (integer i = 0; i < 32; i = i + 1) begin
      $dumpvars(0, MIPS_tb.dut.unidade_registradores.registers[i]); // Monitora cada registrador
    end
      clk = 0;
      reset = 0;

      #5
      reset = 1;
      #5
      reset = 0;


      
      #1000;
      $finish;
  end


endmodule


