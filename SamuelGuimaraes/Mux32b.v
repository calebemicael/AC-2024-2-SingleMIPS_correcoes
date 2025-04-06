module Mux32b(
    input wire seletor,
    input wire [31:0] A,
    input wire [31:0] B,
    output wire [31:0] Y          
);

    reg [31:0] auxiliarY;

    always @(*) begin
        case (seletor)
            0: auxiliarY = A;
            1: auxiliarY = B;
            default: auxiliarY = 32'b00000000000000000000000000000000; // Operação inválida
        endcase
    end

    assign Y = auxiliarY;
    
endmodule
