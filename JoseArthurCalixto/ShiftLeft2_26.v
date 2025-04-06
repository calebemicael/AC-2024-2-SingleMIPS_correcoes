module ShiftLeft2_26(
  	input wire [25:0] in,             // Entrada de 26 bits
  	input wire [3:0] pc_mais_4, // 4 bits superiores do PC+4
  	output wire [31:0] out            // Saída deslocada
);

  assign out = {pc_mais_4, in, 2'b00};  // Concatena e adiciona deslocamento

endmodule