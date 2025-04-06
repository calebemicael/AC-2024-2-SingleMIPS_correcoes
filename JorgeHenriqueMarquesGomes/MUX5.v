module MUX5(
    input wire A,    
    input wire [4:0] um,   
    input wire [4:0] zero, 
    output reg [4:0] Saida
);

    // Define o comportamento da ALU
    always @(*) begin
        case (A)
            1'b1: Saida = um;
            1'b0: Saida = zero;
        endcase
    end



endmodule
