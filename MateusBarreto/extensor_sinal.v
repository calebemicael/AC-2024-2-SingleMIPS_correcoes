module extensor_sinal (
    input [15:0] imediato, // Valorde 16 bits
    output [31:0] imediato_ext // Valor estendido para 32 bits
);
    assign imediato_ext = {{16{imediato[15]}}, imediato}; // Extensão de sinal
endmodule
