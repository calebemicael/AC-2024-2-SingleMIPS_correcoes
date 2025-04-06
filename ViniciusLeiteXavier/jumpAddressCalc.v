module jumpAddressCalc (
    input wire [31:0] PC,        // Endereço atual do contador de programa
    input wire [25:0] immediate, // Campo imediato da instrução JUMP  
    output reg [31:0] jumpAddress // Endereço destino do jump
);

    always @(*) begin
        // Pega os 4 bits superiores de PC+4 e concatena com immediate deslocado à esquerda por 2 bits
        jumpAddress = { (PC[31:28]), immediate, 2'b00 };
    end

endmodule
