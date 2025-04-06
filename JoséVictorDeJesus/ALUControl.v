module ALUControl (
    input wire [1:0] ALUOp,
    input wire [5:0] Funct,
    output reg [3:0] ALUoperation
);

always@(*) begin
        case(ALUOp) 
        2'b00 : ALUoperation = 4'b0010;    //LW,SW -> SOMA
        2'b01 : ALUoperation = 4'b0110;    //BEQ -> Subtração
        2'b10: begin   //R-Type
            case (Funct)
                6'b100000: ALUoperation = 4'b0010;
                6'b100010: ALUoperation = 4'b0110; // SUB
                6'b100100: ALUoperation = 4'b0000; // AND
                6'b100101: ALUoperation = 4'b0001; // OR
                6'b101010: ALUoperation = 4'b0111; // SLT
                6'b100111: ALUoperation = 4'b1100; // NOR
                default:   ALUoperation = 4'b0000; // Operação inválida
            endcase
        end
                default: ALUoperation = 4'b0000; // Caso inesperado
    endcase
end
endmodule