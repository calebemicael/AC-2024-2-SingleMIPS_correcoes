module DataMemory(
    input wire Clk,
    input wire MemRead,
    input wire MemWrite,
    input wire [31:0] address,
    input wire [31:0] writeData,
    output wire [31:0] readData
);

    // Memória de dados (256 palavras de 32 bits)
    reg [31:0] memory [255:0];

    // Inicializa a memória para simulação (opcional)
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'b0; // Inicializa com zero
        end
    end

    // Leitura combinacional
    assign readData = (MemRead) ? memory[address[9:2]] : 32'b0;

    // Escrita síncrona
    always @(posedge Clk) begin
        if (MemWrite) begin
            memory[address[9:2]] <= writeData; // Escreve na memória
        end
    end

endmodule