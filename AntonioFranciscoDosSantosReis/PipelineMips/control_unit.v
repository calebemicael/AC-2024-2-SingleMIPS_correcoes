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

module ALU_control(ALUop, funct, ALUControl);
    input [1:0] ALUop;
    input [5:0] funct;
    output reg [2:0] ALUControl;

    always@(*) begin
        case (ALUop)
            2'b00: ALUControl = 3'b010; 
            2'b01: begin if(funct == 6'b001000) ALUControl = 3'b011; else ALUControl = 3'b110; end
            2'b10: begin
                
                case (funct)
                    6'b100000: ALUControl = 3'b010; // ADD
                    6'b100010: ALUControl = 3'b110; // SUB
                    6'b100100: ALUControl = 3'b000; // AND
                    6'b100101: ALUControl = 3'b001; // OR
                    6'b101010: ALUControl = 3'b111; // SLT
                    default:   ALUControl = 3'bxxx; // Undefined
                endcase
            end
            default: ALUControl = 3'bxxx; 
        endcase
    end
endmodule