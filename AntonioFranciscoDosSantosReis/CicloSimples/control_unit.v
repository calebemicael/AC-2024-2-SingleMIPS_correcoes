module control_unit(instruction, RegDst, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite, jump);
    input [5:0] instruction;
    output reg RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, jump;
    output reg [1:0] ALUop;

    always@(*)begin
        {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} = 9'b0000000_00;
        
        case(instruction)
            6'b000000: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} <= 10'b11000000_10; //R_TYPE
            6'b100011: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} <= 10'b10100101_00; //LW
            6'b101011: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} <= 10'b00101000_00; //SW
            6'b000100: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} <= 10'b00010000_01; //BEQ
            6'b001000: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} <= 10'b10100000_00; //ADDI
            6'b000010: {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} <= 10'b00000010_00; //J
            default:   {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, jump, MemRead, ALUop} = 10'b0;
        endcase
    end

endmodule