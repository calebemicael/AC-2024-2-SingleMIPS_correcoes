module ControlUnit (
    input wire [5:0] instrucao,
    output reg RegWrite,
    output reg AluSCR,
    output reg RegDst,
    output reg MemWrite,
    output reg MemtoReg,
    output reg MemRead,
    output reg Branch,
    output reg Jump,
    output reg [1:0] AluOp
);

always@(*) begin
        RegWrite = 0;
        AluSCR = 0;
        RegDst = 0;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        Branch = 0;
        Jump = 0;
        AluOp = 2'b00;

    case(instrucao)
        6'b000000: begin  //R-format
            RegDst = 1;
            RegWrite = 1;
            AluSCR = 0;
            AluOp = 2'b10;
        end

        6'b100011: begin  //LW (Load Word)
            RegWrite = 1;
            MemRead = 1;
            MemtoReg = 1;
            AluSCR = 1;
            AluOp = 2'b00;
        end

        6'b101011: begin //SW (Store Word)
            AluSCR = 1;
            MemWrite = 1;
            AluOp = 2'b00;
        end

         6'b001000: begin // ADDI (Add Immediate)
            RegWrite = 1;
            AluSCR = 1;
            AluOp = 2'b00;
        end

        6'b000111: begin // BGTZ (Branch if Greater Than Zero)
            Branch = 1;
            AluSCR = 0;
            AluOp = 2'b01;
        end


        6'b000100: begin //BEQ(Branch if Equal)
            Branch = 1;
            AluSCR = 0;
            AluOp = 2'b01;
        end

         6'b000101: begin // BNE (Branch if Not Equal)
            Branch = 1;
            AluSCR = 0;
            AluOp = 2'b01;
        end

        6'b000010: begin 
            Jump = 1;
        end

          6'b000011: begin // JAL (Jump and Link)
            Jump = 1;
            RegWrite = 1; // Salva o endereço de retorno
        end

        default: begin 
            RegWrite = 0;
            AluSCR = 0;
            RegDst = 0;
            MemRead = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch = 0;
            Jump = 0;
            AluOp = 2'b00;

        end
    endcase
end
endmodule