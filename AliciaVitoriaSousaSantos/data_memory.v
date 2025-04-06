// Memória de Dados
module data_memory(
    input clk,                   // Sinal de clock
    input mem_read,              // Habilita leitura da memória
    input mem_write,             // Habilita escrita na memória
    input [31:0] addr,           // Endereço de memória
    input [31:0] write_data,     // Dado a ser escrito na memória
    output [31:0] read_data      // Dado lido da memória
);
    reg [31:0] memory [255:0];  

    // Leitura da memória
    assign read_data = (mem_read) ? memory[addr[7:0]] : 0;

    // Escrita na memória (sincronizada com o clock)
    always @(posedge clk) begin
        if (mem_write) memory[addr[7:0]] <= write_data;
    end

    always @(posedge clk ) begin
    if (clk) begin
        for (integer i = 0; i < 256; i++) 
            memory[i] <= 0;
    end
    else if (mem_write)
        memory[addr[7:0]] <= write_data;
end
endmodule