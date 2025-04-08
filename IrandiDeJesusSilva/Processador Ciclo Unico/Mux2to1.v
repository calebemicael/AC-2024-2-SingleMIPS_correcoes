module MUX2to1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] in0,    // Entrada 0
    input [WIDTH-1:0] in1,    // Entrada 1
    input sel,                // Sinal de seleção
    output [WIDTH-1:0] out    // Saída
);
    assign out = sel ? in1 : in0;
endmodule