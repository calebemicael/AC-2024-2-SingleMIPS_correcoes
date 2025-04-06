// Unidade Central de Controle

module UnidadeCentral(
    input wire [31:0] instruction,

    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp, // Diferente do ALUOperation!!!
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg Jump 
);

    // Define a Operação a partir do opcode

    reg [5:0] opcode;
    //assign opcode = instruction [31:26];

    always @(*) begin
        opcode = instruction [31:26];

        RegDst = 0;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 2'b00;
        Jump = 0;

        case (opcode)
            6'd0: begin
                ALUOp = 2'b10; // TIPO R
                RegDst = 1'b1;
                RegWrite = 1'b1;
            end

            6'd35: begin
                ALUOp = 2'b00; // LOAD
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
            end

            6'd43: begin
                ALUOp = 2'b00; // STORE
                ALUSrc = 1;
                MemWrite = 1;
            end

            6'd4: begin 
                ALUOp = 2'b01; // BRANCH
                Branch = 1;
            end

            6'd8: begin // addi 
                ALUSrc = 1;
                RegWrite = 1;
            end

            6'd2: begin // JUMP
                Jump = 1;

            end 

            default: ALUOp = 2'b11;  // Ideal é nao cair nesse caso, mas setei pra 1.
        endcase
    end
endmodule