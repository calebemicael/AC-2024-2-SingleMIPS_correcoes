module data_memory(
    input wire clock,  // clock
    input wire MemRead, // Leitura
    input wire MemWrite, // Escrita
    input wire [31:0] writeData, // Dados a escrever
    input wire [31:0] adress, // Endereço de memória
    output wire [31:0] readData // Dados lidos
);

reg [31:0] memoria [255:0]; // Memória de dados - 256 palavras de 32 bits

integer k;
initial begin 
    for (k = 0; k < 256; k = k + 1) begin
        memoria[k] = 32'b0; // Corrigido para inicializar com 0
    end
end

// Leitura de memória
assign readData = (MemRead) ? memoria[adress[9:2]] : 32'd0;

// Escrita na memória
always @(posedge clock) begin 
    if (MemWrite) begin
        memoria[adress[9:2]] = writeData; 
    end
end

endmodule
