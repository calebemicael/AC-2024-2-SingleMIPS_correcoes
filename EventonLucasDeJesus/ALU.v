// Módulo da ALU
module ALU(input1, input2, aluControl, result, zero);
    input [31:0] input1, input2;
    input [3:0] aluControl;
    output reg [31:0] result;
    output zero;

    always @(*) begin // Bloco sensível a qualquer mudança nas entradas
        case (aluControl)
            3'b000: result = input1 & input2;  // AND lógico
            3'b001: result = input1 | input2;  // OR lógico
            3'b010: result = input1 + input2;  // Soma
            3'b110: result = input1 - input2;  // Subtração
            3'b111: result = (input1 < input2) ? 1 : 0;  // Comparação de menor que
            default: result = 0;  // Valor padrão em caso de código de controle inválido
        endcase
    end

    assign zero = (result == 0);  // Define o sinal de zero se o resultado for igual a zero
endmodule
