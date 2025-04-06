module alu(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [2:0] operation,
    output reg [31:0] result,
    output wire Zero
);
    
    // Unidade lógica e aritmética do processador

    always @(*) begin
        case (operation)
            3'b000: result <= A & B;
            3'b001: result <= A | B;
            3'b010: result <= A + B;
            3'b011: result <= A - B;
            3'b100: result <= (A < B) ? 1 : 0; // SLT
            3'b101: result <= ~(A | B);
            default: result <= 32'b0;
        endcase
    end

    // Define o sinal zero
    assign Zero = (result == 32'b0) ? 1'b1 : 1'b0;

endmodule