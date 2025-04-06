module ALUControl(

    input wire [5:0] funct,
    input wire [1:0] AluOp,
    output reg [3:0] ALUC

);

    always @(*) begin
        case(AluOp)
        2'b00: ALUC = 4'b0010;
        2'b01: ALUC = 4'b0110;
        endcase

        if(AluOp == 2'b10) begin
            case(funct)
            6'b100000: ALUC = 4'b0010;
            6'b100010: ALUC = 4'b0110;
            6'b100100: ALUC = 4'b0000;
            6'b100101: ALUC = 4'b0001;
            6'b101010: ALUC = 4'b0111;
            endcase

        end


    end


endmodule