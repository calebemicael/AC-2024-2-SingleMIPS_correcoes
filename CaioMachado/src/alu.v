module ALU (
    input [31:0] srcA,
    input [31:0] srcB,
    input [3:0] alu_control,
    output reg [31:0] alu_result,
    output zero
);
    always @(*) begin
        case (alu_control)
            4'b0000: alu_result = srcA + srcB; // ADD
            4'b0001: alu_result = srcA - srcB; // SUB
            4'b0010: alu_result = srcA & srcB; // AND
            4'b0011: alu_result = srcA | srcB; // OR
            4'b0100: alu_result = srcA ^ srcB; // XOR
            default: alu_result = 0;
        endcase
    end

    assign zero = (alu_result == 0);
endmodule