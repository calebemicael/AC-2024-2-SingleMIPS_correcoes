module controleULA(opALU, funct, ALUcontrol);
    input [1:0] opALU;
    input [5:0] funct;
    output reg [3:0] ALUcontrol;


    always @(*)begin
        if (opALU == 2'b00) begin
            ALUcontrol = 4'b0010;
        end
        else if (opALU == 2'b01) begin
            ALUcontrol = 4'b0110;
        end
        else if (opALU == 2'b10) begin
            if (funct == 6'b100000) begin
                ALUcontrol = 4'b0010;
            end
            else if (funct == 6'b100010) begin
                ALUcontrol = 4'b0110;
            end
            else if (funct == 6'b100100) begin
                ALUcontrol = 4'b0000;
            end
            else if (funct == 6'b100101) begin
                ALUcontrol = 4'b0001;
            end
            else if (funct == 6'b101010) begin
                ALUcontrol = 4'b0111;
            end
            else begin
                ALUcontrol = 4'b0000;
            end
        end
        else begin
            ALUcontrol = 4'b0000;
        end
    end
endmodule