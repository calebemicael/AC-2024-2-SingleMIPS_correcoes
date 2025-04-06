module ALU (
    input [31:0] A, B, 
    input [3:0] ALUControl, 
    output reg [31:0] Result, 
    output reg Zero  // Alterado para reg
);
    always @(*) begin
        case(ALUControl)
            4'b0000: Result = A & B;  // AND
            4'b0001: Result = A | B;  // OR
            4'b0010: Result = A + B;  // ADD
            4'b0110: Result = A - B;  // SUB
            4'b0111: Result = (A < B) ? 32'b1 : 32'b0; // SLT
            4'b1100: Result = ~(A | B); // NOR
            default: Result = 32'b0;
        endcase
        Zero = (Result == 32'b0); // Atualiza Zero junto com a ALU
    end
endmodule
