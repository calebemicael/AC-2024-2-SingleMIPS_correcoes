module Control(
    input reg [5:0] OP,
    output reg [1:0] ALUOp,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg Jump
);

    always @(*)begin
        if(OP == 6'b000000)begin
            Jump = 1'b0;
            RegDst = 1'b1;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            RegWrite = 1'b1;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b0;
            ALUOp = 2'b10;
        end

        if(OP == 6'b100011)begin   //lw
            Jump = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b1;
            RegWrite = 1'b1;
            MemRead = 1'b1;
            MemWrite = 1'b0;
            Branch = 1'b0;
            ALUOp = 2'b00;
        end

        if(OP == 6'b101011)begin   //sw
            Jump = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b0;
            RegWrite = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b1;
            Branch = 1'b0;
            ALUOp = 2'b00;
        end

        if(OP == 6'b000100)begin
            Jump = 1'b0;
            RegDst = 1'b1;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            RegWrite = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b1;
            ALUOp = 2'b01;
        end

        if (OP == 6'b000010)begin
            Jump = 1'b1;
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            RegWrite = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b0;
            ALUOp = 2'b00;
        end
    end

endmodule