module alu_control (
    input [1:0] ALUOp,       // Sinal da Unidade de Controle
    input [5:0] funct,       // Campo 'funct' da instrução do tipo R
    output reg [3:0] ALUControl // Sinal de controle da ALU
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010; // LW e SW -> ADD
            2'b01: ALUControl = 4'b0110; // BEQ -> SUB
            2'b10: begin // Tipo R -> usa funct
                case (funct)
                    6'b100000: ALUControl = 4'b0010; // ADD
                    6'b100010: ALUControl = 4'b0110; // SUB
                    6'b100100: ALUControl = 4'b0000; // AND
                    6'b100101: ALUControl = 4'b0001; // OR
                    6'b100111: ALUControl = 4'b1100; // NOR
                    6'b000000: ALUControl = 4'b0011; // SLL
                    6'b000010: ALUControl = 4'b0100; // SRL
                    6'b101010: ALUControl = 4'b0111; // SLT
                    default:   ALUControl = 4'b0000; // Padrão (AND)
                endcase
            end
            default: ALUControl = 4'b0000; // AND por padrão
        endcase
    end
endmodule
