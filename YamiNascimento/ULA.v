module ULA (
    input [31:0] A,
    input [31:0] B,
    input [3:0] ULAoperation,
    output reg [31:0] ULA_RESULT,
    output flagz //Flag de warning se o resultado for zero
);



    always @ (*) begin //ajuste de sensibilidade so alwas para qqrl mudança
    
        if (SELECT == 3'b001) begin //if para determinar se é soma ou sub, muda o valor de B
            B_adjusted = ~B + 1;  // complemento de 2 para B (B - A)
        end else begin
            B_adjusted = B;  
        end

        // operações disponiveis no SELECT
        case (SELECT)
            4'b0000: RESULT = A & B;   // AND
            4'b0001: RESULT = A | B;   // OR
            4'b0010: RESULT = (A + B);   // ADD
            4'b0110: RESULT =(A - B);    // SUB
            4'b0111: RESULT = (A < B) ? 1:0; // set less than (slt)
            4'b1100: RESULT = ~(A | B);  // NOR
            Default: RESULT = 32'b0;       // Default case (inválida)
        endcase

    end

    assign flagz = (ULA_RESULT == 32'b0) ? 1'b1: 1'b0; //flag de zero
endmodule


