module UnidadeControle(
    input wire [5:0] operacao,   // OpCode    
    output wire jump,       
    output wire regDst,
    output wire ALUSrc,
    output wire memtoReg,
    output wire regWrite,
    output wire memRead,
    output wire memWrite,
    output wire branch,
    output wire ALUOp1,
    output wire ALUOp0
);

    reg [9:0] auxiliar;

    // Define o comportamento da Unidade de Controle
    always @(*) begin
        case (operacao)
            6'b000010: auxiliar = 10'b1000000000;  // jump
            6'b000000: auxiliar = 10'b0100100010;  // R
            6'b100011: auxiliar = 10'b0011110000;  // lw
            6'b101011: auxiliar = 10'b0x1x001000;  // sw
            6'b000100: auxiliar = 10'b0x0x000101;  // beq
            6'b001000: auxiliar = 10'b0010100000;  // addi
            default: auxiliar = 10'b000000000;     // Operação inválida
        endcase
    end
    
    assign jump = auxiliar[9];
    assign regDst = auxiliar[8];
    assign ALUSrc = auxiliar[7];
    assign memtoReg = auxiliar[6];
    assign regWrite = auxiliar[5];
    assign memRead = auxiliar[4];
    assign memWrite = auxiliar[3];
    assign branch = auxiliar[2];
    assign ALUOp1 = auxiliar[1];
    assign ALUOp0 = auxiliar[0];
    
endmodule
