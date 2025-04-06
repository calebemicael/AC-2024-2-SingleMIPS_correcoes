module ALUControl(
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [3:0] ALUControl
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010; // Add (for lw, sw, addi)
            2'b01: ALUControl = 4'b0110; // Subtract (for beq)
            2'b10: begin // R-type
                case (funct)
                    6'b100000: ALUControl = 4'b0010; // ADD
                    6'b100010: ALUControl = 4'b0110; // SUB
                    // Add other funct codes as needed
                    default: ALUControl = 4'b0000;
                endcase
            end
            default: ALUControl = 4'b0000;
        endcase
    end
endmodule
