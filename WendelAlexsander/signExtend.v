module signExtend(
    input [15:0] in,             // Entrada de 16 bits
    output [31:0] out            // Saída de 32 bits com extensão de sinal
);
    assign out = {{16{in[15]}}, in}; // Estende o sinal do bit mais significativo
    
endmodule  