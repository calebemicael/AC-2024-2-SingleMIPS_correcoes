module Control(
    input wire [5:0] OP,   // Código da operação (opcode)

    output wire RegDist, 
    output wire Branch, 
    output wire MemRead, 
    output wire MemtoReg, 
    output wire MemWrite, 
    output wire ALUSrc, 
    output wire RegWrite,
    output wire Jump,
    output wire [1:0] ALUOp
);

    // Definição dos sinais com base no opcode
    assign RegDist  = (OP == 6'b000000) ? 1 :
                      (OP == 6'b101011 || OP == 6'b000100) ? 1'bx : 0;

    assign ALUSrc   = (OP == 6'b100011 || OP == 6'b101011) ? 1 : 0;

    assign MemtoReg = (OP == 6'b100011) ? 1 :
                      (OP == 6'b101011 || OP == 6'b000100) ? 1'bx : 0;

    assign RegWrite = (OP == 6'b000000 || OP == 6'b100011) ? 1 : 0;

    assign MemRead  = (OP == 6'b100011) ? 1 : 0;

    assign MemWrite = (OP == 6'b101011) ? 1 : 0;

    assign Branch   = (OP == 6'b000100) ? 1 : 0;

    assign Jump =  (OP == 6'b000010) ? 1 : 0;

    assign ALUOp    = (OP == 6'b000000) ? 2'b10 :  // R-type
                      (OP == 6'b000100) ? 2'b01 :  // BEQ
                                         2'b00;   // LW e SW

endmodule

/*
module Control(
    input wire [5:0] OP,   //   6 palavras de 32bits 

    output reg RegDist, 
    output reg Branch, 
    output reg MemRead, 
    output reg MemtoReg, 
    output reg MemWrite, 
    output reg ALUSrc, 
    output reg RegWrite,
    output reg [1:0] ALUOp        
);
    
    always @(*) begin 
           
    if (OP == 6'b000000) begin // R
         RegDist = 1;
         ALUSrc = 0;
         MemtoReg = 0;
         RegWrite = 1;
         MemRead = 0;
         MemWrite = 0;
         Branch = 0;
         ALUOp = 2'b10;
    end

    if (OP == 6'b100011) begin // LW
         RegDist = 0;
         ALUSrc = 1;
         MemtoReg = 1;
         RegWrite = 1;
         MemRead = 1;
         MemWrite = 0;
         Branch = 0;
         ALUOp = 2'b00;
    end 

    if (OP == 6'b101011) begin // SW
         RegDist = 1'b?;
         ALUSrc = 1;
         MemtoReg = 1'b?;
         RegWrite = 0;
         MemRead = 0;
         MemWrite = 1;
         Branch = 0;
         ALUOp = 2'b00;
    end

    if (OP == 6'b000100) begin // BEQ
         RegDist = 1'b?;
         ALUSrc = 0;
         MemtoReg = 1'b?;
         RegWrite = 0;
         MemRead = 0;
         MemWrite = 0;
         Branch = 1;
         ALUOp = 2'b01;
    end

end

endmodule   
*/