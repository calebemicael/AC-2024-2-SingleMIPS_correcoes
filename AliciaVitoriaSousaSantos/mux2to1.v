// Multiplexador
module mux2to1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] ent0,       // Entrada 0
    input [WIDTH-1:0] ent1,       // Entrada 1
    input sel,                   // Sinal de seleção
    output [WIDTH-1:0] out       // Saída
);
    assign out = sel ? ent1 : ent0; // Se sel = 1, então out = ent1, senão out = ent0
endmodule