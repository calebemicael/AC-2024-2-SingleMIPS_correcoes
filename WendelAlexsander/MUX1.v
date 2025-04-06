module MUX1 #(parameter WIDTH = 32) (
    
    input [WIDTH-1:0] input0,    // Entrada 0: Primeira entrada (32 bits por padrão)
    input [WIDTH-1:0] input1,    // Entrada 1: Segunda entrada (32 bits por padrão)
    input select,                // Sinal q decide qual entrada será selecionada
    output [WIDTH-1:0] outpt    // Valor selecionado (32 bits por padrão)

);
   
    assign outpt = select ? input1 : input0;
endmodule