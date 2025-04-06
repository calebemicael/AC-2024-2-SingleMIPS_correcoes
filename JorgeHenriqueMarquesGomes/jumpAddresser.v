module jumpAddresser( 
    input wire [31:0] A,   
    input wire [31:0] B, 
    output reg [31:0] Saida
);

    // Define o comportamento da ALU
    always @(*) begin
        Saida[31:28] = A[31:28];
        Saida[27:0] = B[27:0];
    end



endmodule
