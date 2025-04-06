module aluControl(
    input wire [1:0] ALUop,
    input wire [5:0] funct,
    output reg [2:0] result
);

    /*
    Modulo alu control que retorna a operação correta da ula
    dado um sinal ALUop e um funct de uma instrução assembly
    */

    always @(*) begin
        case (ALUop)
            2'b00: result <= 3'b010; // LW/SW
            2'b01: result <= 3'b011; // beq
            2'b10: begin // Operaçoes do tipo R
                case (funct)
                    6'b100000: result <= 3'b010; // add
                    6'b100010: result <= 3'b011; // sub
                    6'b100100: result <= 3'b000; // AND
                    6'b100101: result <= 3'b001; // OR
                    6'b101010: result <= 3'b100; // SLT
                    default: result <= 3'bxxx;
                endcase
            end
            default: result <= 3'bxxx;
        endcase
    end
endmodule