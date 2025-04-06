module data_memory(
    input wire clk,
    input wire memRead,
    input wire memWrite,
    input wire [31:0] address,
    input wire [31:0] writeData,
    output wire [31:0] readData
);

    /*
        Memória maior e mais lenta que a registers file que se comunica
        com o processador por meio de instruções lw e sw
    */

    // memoria de dados (256 palavras de 32 bits)
    reg [31:0] memory [255:0];

    // Inicializa a memória para a simulação
    integer i;
    wire [6:0] index;

    // inicializa os 32 primeiros campos da data memory com valores binarios aleatórios
    initial begin
        memory[0]  = 32'b10101010101010101010101010101010;
        memory[1]  = 32'b11001100110011001100110011001100;
        memory[2]  = 32'b11110000111100001111000011110000;
        memory[3]  = 32'b00001111000011110000111100001111;
        memory[4]  = 32'b00110011001100110011001100110011;
        memory[5]  = 32'b01010101010101010101010101010101;
        memory[6]  = 32'b10011001100110011001100110011001;
        memory[7]  = 32'b01100110011001100110011001100110;
        memory[8]  = 32'b00000000000000001111111111111111;
        memory[9]  = 32'b11111111111111110000000000000000;
        memory[10] = 32'b10000000000000001000000000000001;
        memory[11] = 32'b01111111111111110111111111111110;
        memory[12] = 32'b01000010000001000100001000000100;
        memory[13] = 32'b00010001000100010001000100010001;
        memory[14] = 32'b11100011100011101110001110001110;
        memory[15] = 32'b10101010101110101010101010111010;
        memory[16] = 32'b10000000010000001000000001000000;
        memory[17] = 32'b01111111101111110111111110111111;
        memory[18] = 32'b00101100001011000010110000101100;
        memory[19] = 32'b11010011110100111101001111010011;
        memory[20] = 32'b01011010010110100101101001011010;
        memory[21] = 32'b00111100001111000011110000111100;
        memory[22] = 32'b11111100000011110000001111110000;
        memory[23] = 32'b00001111111100001111000000001111;
        memory[24] = 32'b10101000101010001010100010101000;
        memory[25] = 32'b01010111010101110101011101010111;
        memory[26] = 32'b11001111001100111100110011001100;
        memory[27] = 32'b00110011000011000011001100001100;
        memory[28] = 32'b01101001011010010110100101101001;
        memory[29] = 32'b10010110100101101001011010010110;
        memory[30] = 32'b00000011111100000000011111100000;
        memory[31] = 32'b11100000000011111110000000001111;
    end

    assign readData = (memRead) ? memory[address[8:1]] : 32'b0;
    
    always @(*) begin
        if (memWrite) begin
            memory[index] = writeData; // Escreve na memória
        end
    end

endmodule
