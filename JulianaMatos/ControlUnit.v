module ControlUnit(
    input wire [31:26] opcode,
    output reg RegDst, //sinais de 1 bit pra controlar os MUX
    output reg ALUSrc, //sinais de 1 bit pra controlar os MUX
    output reg MemToReg, //sinais de 1 bit pra controlar os MUX
    output reg Branch, //sinal usado para determinar se será necessário fazer um branch
    output reg [1:0] ALUOp,
    //sinais que controlam read e writes nas register file e data memory
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    //jump
    output reg Jump
    

);

    always @(*) begin
        case (opcode)
            6'b000000 : begin // Tipo R 
                RegDst = 1;
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b10;
                Jump = 0;
            end

            6'b100011 : begin // lw
                RegDst = 0;
                ALUSrc = 1;
                MemToReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
                Jump = 0;
            end

            6'b101011 : begin // sw
                RegDst = 0;
                ALUSrc = 1;
                MemToReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp = 2'b00;
                Jump = 0;
            end

            6'b000100 : begin // beq
                RegDst = 0;
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 2'b01;
                Jump = 0;
            end

            6'b000010 : begin //jump
                RegDst = 1'bx;
                ALUSrc = 1'bx;
                MemToReg = 1'bx;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
                Jump = 1;
            end

            default : begin 
                RegDst = 0;
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
                Jump = 0;
            end

        endcase
    end
    
endmodule