// Unidade de Controle da ALU
module ALUControl(ALUOp, funct, ALU_Ctrl);
    input [1:0] ALUOp;
    input [5:0] funct;
    output reg [3:0] ALU_Ctrl;

    always @(*) begin
        case (ALUOp)
            2'b00: ALU_Ctrl = 4'b0010; // lw, sw: operação de soma
            2'b01: ALU_Ctrl = 4'b0110; // beq: operação de subtração
            2'b10: begin               // Instruções do tipo R
                case (funct)
                    6'b100000: ALU_Ctrl = 4'b0010;   // add
                    6'b100010: ALU_Ctrl = 4'b0110;   // sub
                    6'b100100: ALU_Ctrl = 4'b0000;   // and
                    6'b100101: ALU_Ctrl = 4'b0001;   // or
                    6'b101010: ALU_Ctrl = 4'b0111;   // slt
                    default:    ALU_Ctrl = 4'b1111;  // Instrução inválida
                endcase
            end
            default: ALU_Ctrl = 4'b1111; // Instrução inválida
        endcase
    end
endmodule
