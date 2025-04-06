module MuxGeneral #(
    parameter DATA_WIDTH = 32, // Largura dos dados (padrão: 32 bits)
    parameter SEL_WIDTH = 1    // Largura do seletor (padrão: 1 bit)
)(
    input wire [(2**SEL_WIDTH)-1:0][DATA_WIDTH-1:0] Entradas, // Array de entradas
    input wire [SEL_WIDTH-1:0] selector,                      // Sinal de seleção
    output wire [DATA_WIDTH-1:0] Saida                        // Saída selecionada
);

    // Lógica do multiplexador
    assign Saida = Entradas[selector];

endmodule
