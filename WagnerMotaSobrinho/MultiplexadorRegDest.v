module MUX2to1_RegDst(
    input wire [4:0] Rt,      // Campo rt da instrução
    input wire [4:0] Rd,      // Campo rd da instrução
    input wire RegDst,        // Controle de seleção
    output wire [4:0] RegWriteAddr // Saída para o endereço do registrador
);

    assign RegWriteAddr = (RegDst) ? Rd : Rt; // Se RegDst for 1, usa o campo rd

endmodule
