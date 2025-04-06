// Módulo dataMemory
// Este módulo implementa uma memória de dados de 256 palavras de 32 bits. Ele é responsável 
// por ler e escrever dados na memória com base nos sinais de controle de leitura e escrita. 
module dataMemory (
    input wire clk,             // Clock
    input wire memWrite,        // Sinal de escrita na memória
    input wire memRead,         // Sinal de leitura da memória
    input wire [31:0] address,  // Endereço de memória
    input wire [31:0] writeData, // Dados a serem escritos
    output reg [31:0] readData  // Dados lidos da memória
);

    reg [31:0] memory [0:255]; // Memória de 256 palavras de 32 bits

    always @(posedge clk) begin
        if (memWrite) 
            memory[address[9:2]] <= writeData; // Escreve na memória (endereçamento por palavra)
    end

    always @(*) begin
        if (memRead) 
            readData = memory[address[9:2]]; // Lê da memória (endereçamento por palavra)
        else
            readData = 32'b0;
    end

endmodule
