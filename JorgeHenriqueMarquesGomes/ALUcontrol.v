module ALUcontrol(
    input wire [5:0] OPcode,
    input wire [1:0] ALUop,   
    output reg [3:0] ALUOperation          
);

    // Define o comportamento da ALU
    always @(*) begin
        case (ALUop)
            2'b00: ALUOperation = 4'b0010;
            2'b01: ALUOperation = 4'b0110;
            2'b10:case (OPcode[3:0])
                        4'b0000: ALUOperation = 4'b0010;
                        4'b0010: ALUOperation = 4'b0110;
                        4'b0100: ALUOperation = 4'b0000;
                        4'b0101: ALUOperation = 4'b0001;
                        4'b1010: ALUOperation = 4'b0111;
                        default: ALUOperation = 4'b0000;
                        endcase
            default: ALUOperation = 4'b0000;
        endcase
    end


endmodule