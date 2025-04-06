module Mux5b(
    input wire seletor,
    input wire [4:0] A,
    input wire [4:0] B,
    output wire [4:0] Y          
);

    reg [4:0] auxiliarY;

    always @(*) begin
        case (seletor)
            0: auxiliarY = A;
            1: auxiliarY = B;
            default: auxiliarY = 32'b00000; // Operação inválida
        endcase
    end

    assign Y = auxiliarY;
    
endmodule
