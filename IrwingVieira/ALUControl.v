module ALUControl(//Manda a operação a ser realizada para a ALU.
    input [1:0] ALUOp,
    input [5:0] FunctionField,
    output reg [3:0] saidaALU // Removida a vírgula extra
);

    always @ (*) begin
        if (ALUOp == 2'b00) begin // Load ou Store ou addi.
            saidaALU = 4'b0010;
        end else if (ALUOp == 2'b01) begin // Para o branch if equal.
            saidaALU = 4'b0110;
        end else if (ALUOp == 2'b10) begin
            case (FunctionField)
                6'b100100: saidaALU = 4'b0000; // And
                6'b100101: saidaALU = 4'b0001; // Or
                6'b100000: saidaALU = 4'b0010; // Soma
                6'b100010: saidaALU = 4'b0110; // Sub
                6'b101010: saidaALU = 4'b0111; // Set less than
                default: saidaALU = 4'b1111; // Valor inválido.
            endcase
        end else begin
            saidaALU = 4'b1111; // Valor inválido.
        end
    end

endmodule