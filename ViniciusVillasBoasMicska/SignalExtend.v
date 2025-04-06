module SignExtend #(
  parameter DATA_IN = 16,
  parameter DATA_OUT= 32
)(
    input wire [DATA_IN-1:0] in,         // Campo de 16 bits a ser estendido
    output wire [DATA_OUT-1:0] out        // Resultado estendido para 32 bits
);

    assign out = {{(DATA_OUT - DATA_IN){in[DATA_IN-1]}}, in}; // Extensão de sinal replicando o bit mais significativo

endmodule
