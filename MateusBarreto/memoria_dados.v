module memoria_dados (
    input clk,
    input MemRead, MemWrite,
    input [31:0] endereco, write_data,
    output reg [31:0] read_data
);
    reg [31:0] mem[0:255]; // Memória de 256 palavras de 32 bits

    integer i;
    // Inicializa todas as posições da memória com 0
    initial begin
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 32'b0;
    end

    // Escrita na memória com alinhamento de 4 bytes
    always @(posedge clk) begin
        if (MemWrite)
            mem[endereco[9:2]] <= write_data; // Verifique o alinhamento
    end
    // Leitura com alinhamento de 4 bytes
    always @(*) begin
        if (MemRead)
            read_data = mem[endereco[9:2]];// Leitura 
        else
            read_data = 32'b0;
    end
endmodule
