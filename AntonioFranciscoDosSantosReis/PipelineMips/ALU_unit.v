module ALU_unit(A, B, alu_control, ALU_result);
    input [31:0] A, B;
    input [2:0] alu_control;
    output reg [31:0] ALU_result;

    always@(*) begin
        case(alu_control)
            3'b000: ALU_result = A & B; 
            3'b001: ALU_result = A | B; 
            3'b010: ALU_result = A + B; 
            3'b110: ALU_result = A - B; 
            3'b011: ALU_result = ALU_result; // jr instruction
            3'b111: ALU_result = (A < B) ? 1 : 0;  // set on less
        endcase
    end
endmodule

