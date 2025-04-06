// Módulo de memória de dados
module DataMemory(clk, memWrite, memRead, address, writeData, readData);
    input clk;
    input memWrite, memRead;
    input [31:0] address, writeData;
    output [31:0] readData;

    reg [31:0] memory [0:255];   // Memória de 256 palavras de 32 bits

    assign readData = (memRead) ? memory[address[7:0]] : 0; // Lê da memória se memRead estiver ativo

    always @(posedge clk) begin // Bloco sensível à borda de subida do clock
        if (memWrite)
            memory[address[7:0]] <= writeData; // Escreve se memWrite estiver ativo
    end
endmodule
