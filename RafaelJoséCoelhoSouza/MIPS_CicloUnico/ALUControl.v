// AlUControl

module ALUControl(
    input wire [1:0] ALUOp,
    input wire [5:0] funct,

    output reg [3:0] ALUOperation
);

    // Define a operação da ALU

    always @(*) begin
        case (ALUOp)
            2'b00: ALUOperation = 4'b0010; // add - (funct - all dont cares)                             

            2'b01: ALUOperation = 4'b0110; // sub - (funct - all dont cares)

            2'b10: begin
                case (funct)
                    6'b100000: ALUOperation = 4'b0010;
                    6'b100010: ALUOperation = 4'b0110;
                    6'b100100: ALUOperation = 4'b0000;
                    6'b100101: ALUOperation = 4'b0001;
                    6'b101010: ALUOperation = 4'b0111;
                    default: ALUOperation = 4'b1111;
                endcase
            end
 
            default: ALUOperation = 4'b1111;
        endcase
    end
endmodule