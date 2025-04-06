module ULAcontrole(
    output reg [3:0] ULAoperation,  // Correção do tipo para 4 bits
    input wire [5:0] funcao,         // Correção do tipo para 6 bits
    input wire [1:0] ULAopt          // Correção do tipo para 2 bits
);

always @(*) begin
    case (ULAopt)
        2'b00: ULAoperation = 4'b0010;  // Adição
        2'b01: ULAoperation = 4'b0010;  // Adição

        2'b10: begin
            case (funcao)
                6'b100000: ULAoperation = 4'b0010;  // Adição
                6'b100010: ULAoperation = 4'b0110;  // Subtração
                6'b100100: ULAoperation = 4'b0000;  // AND
                6'b100101: ULAoperation = 4'b0001;  // OR
                6'b101010: ULAoperation = 4'b0111;  // SLT (Set on Less Than)
                default: ULAoperation = 4'b1111;  // Valor padrão inválido para operação
            endcase
        end

        default: ULAoperation = 4'b1111;  // Valor inválido caso `ULAopt` não corresponda a nenhum dos valores acima
    endcase
end

endmodule
