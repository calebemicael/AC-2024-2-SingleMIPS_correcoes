module ALUControl(
    input [1:0] ALUOp,       // Entrada de controle da ALU 
    input [5:0] Func,        // Campo funct da instrução 
    output reg [3:0] ALU_Control // Sinal de controle da ALU 
);

    wire [7:0] ALUControlIn;
    assign ALUControlIn = {ALUOp, Func};

    always @(*) begin
        case (ALUControlIn)
            8'b00xxxxxx: ALU_Control = 4'b0010; // LW e SW (soma)
            8'b01xxxxxx: ALU_Control = 4'b0110; // BEQ (subtração)
            8'b10100000: ALU_Control = 4'b0010; // ADD 
            8'b10100010: ALU_Control = 4'b0110; // SUB
            8'b10100100: ALU_Control = 4'b0000; // AND
            8'b10100101: ALU_Control = 4'b0001; // OR
            8'b10101010: ALU_Control = 4'b0111; // SLT (set less than)
            default: ALU_Control = 4'b0010;     // Default (soma)
        endcase
    end

endmodule



module JR_Control(
    input [1:0] alu_op,      // Entrada de controle da ALU 
    input [5:0] funct,       // Campo funct da instrução 
    output reg JRControl     // Sinal de controle para instrução JR
);

    wire [7:0] JRControlIn;
    assign JRControlIn = {alu_op, funct};

    always @(*) begin
        JRControl = (JRControlIn == 8'b11001000) ? 1'b1 : 1'b0; // JR 
    end

endmodule
