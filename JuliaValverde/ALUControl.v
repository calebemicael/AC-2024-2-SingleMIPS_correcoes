module ALUControl(
    input wire [5:0] FunctField,
    input wire [1:0] ALUOp,
    output reg [3:0] ALUControl_Input
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl_Input = 4'b0010; //LWSW
            2'b01: ALUControl_Input = 4'b0110; //BEQ
            2'b10: begin
                    case (FunctField)
                        6'b100000: ALUControl_Input = 4'b0010; //ADD
                        6'b100010: ALUControl_Input = 4'b0110; //SUB
                        6'b100100: ALUControl_Input = 4'b0000; //AND
                        6'b100101: ALUControl_Input = 4'b0001; //OR
                        6'b101010: ALUControl_Input = 4'b0111; //SLT
                        default: ALUControl_Input = 4'b0000; 
                    endcase
            end
            default: ALUControl_Input = 4'b0000;
        endcase
    end

endmodule