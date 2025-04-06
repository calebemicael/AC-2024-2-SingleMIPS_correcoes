module
    ALUControl(
        input [5:0] funct,
        input [1:0] ALUOp,
        output reg [3:0] op
    );

    always @(*) begin
        if(ALUOp == 2'b00) begin
            op = 4'b0010;       // Operação ADD para lw e sw
        end else if(ALUOp == 2'b01) begin
            op = 4'b0110;       // Operação SUB para beq
        end else if(ALUOp == 2'b10) begin
            case(funct)
                6'b100000: op = 4'b0010;  // ADD
                6'b100010: op = 4'b0110;  // SUB
                6'b100100: op = 4'b0000;  // AND
                6'b100101: op = 4'b0001;  // OR
                6'b101010: op = 4'b0111;  // slt
                default:   op = 4'b1111;  // Don't care
            endcase
        end else begin
               op = 4'b1111;  // Dont't care
        end
    end
endmodule
                