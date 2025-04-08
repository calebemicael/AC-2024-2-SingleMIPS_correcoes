module ulaControle(
    input wire[1:0] ALUOp,         // sinal de controle da unidade de controle principal
    input wire[5:0] instrucao,   //campo funct instrucao
    output reg[3:0] ALUOperation   // Operação da ALU
);

always @(*) begin
    case (ALUOp)
        2'b00: begin //lw/sw
            ALUOperation = 4'b0010; // ADD
        end
        2'b01: begin //branch
            ALUOperation = 4'b0110; // SUB
        end
        2'b10: begin // Operações R-type (depende do campo funct)
            case (instrucao[5:0])
                6'b100000: ALUOperation = 4'b0010; //add
                6'b100010: ALUOperation = 4'b0110; //sub
                6'b100100: ALUOperation = 4'b0000; //and
                6'b100101: ALUOperation = 4'b0001; //or
                6'b101010: ALUOperation = 4'b0111; //slt
                default:   ALUOperation = 4'b0000;
            endcase
        end
        2'b11: begin //caso de operacoes imediata
            ALUOperation = 4'b0010; 
        end
        default: begin //caso não atendido anteriormente
            ALUOperation = 4'b0000; 
        end
    endcase
end

endmodule