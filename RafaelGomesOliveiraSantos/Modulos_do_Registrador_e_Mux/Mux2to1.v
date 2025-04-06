module MUX2to1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] in0,    // Entrada 0: Primeiro valor de entrada (32 bits por padrão)
    input [WIDTH-1:0] in1,    // Entrada 1: Segundo valor de entrada (32 bits por padrão)
    input sel,                // Sinal de seleção: Decide qual entrada será selecionada
    output [WIDTH-1:0] out    // Saída: Valor selecionado (32 bits por padrão)
);
    // Lógica do MUX:
    // Se o sinal de seleção (sel) for 1, a saída (out) recebe in1.
    // Caso contrário, a saída recebe in0.
    assign out = sel ? in1 : in0;
endmodule