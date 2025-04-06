module MUX(
    input wire A,    
    input wire [31:0] um,   
    input wire [31:0] zero, 
    output reg [31:0] Saida
);

    // Define o comportamento da ALU
    always @(*) begin
        case (A)
            1'b1: Saida = um;
            1'b0: Saida = zero;
            default: Saida = 32'b0;
        endcase
    end



endmodule
