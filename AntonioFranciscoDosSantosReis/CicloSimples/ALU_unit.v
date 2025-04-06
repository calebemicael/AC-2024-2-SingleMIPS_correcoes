module ALU_unit(A, B, alu_control, ALU_result, zero);
    input [31:0] A, B;
    input [2:0] alu_control;
    output reg [31:0] ALU_result;
    output reg zero;
    integer k;

    always@(*) begin
        case(alu_control)
            3'b000: begin zero = 1'b0; ALU_result = A & B; end
            3'b001: begin zero = 1'b0; ALU_result = A | B; end
            3'b010: begin zero = 1'b0; ALU_result = A + B; end
            3'b110: begin if(A==B) zero <= 1; else zero <= 0; ALU_result = A - B; end
            3'b011: begin zero = 1'b0; ALU_result = ALU_result; end// jr instruction
            3'b111: begin zero = 1'b0; ALU_result = (A < B) ? 1 : 0; end // set on less
            
        endcase
    end
endmodule