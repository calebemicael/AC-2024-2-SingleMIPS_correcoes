module DataMemory(
    input wire Clk,                
    input wire MemRead,            //sinal de controle de leitura
    input wire MemWrite,           //sinal de cotrole de escrita
    input wire [31:0] address,     //endereco do data memory
    input wire [31:0] writeData,   // dado a ser escrito
    output wire [31:0] readData    //dado lido
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

    // Escrita combinacional
    always @(posedge Clk) begin
        if (MemWrite) begin
            memory[address[9:2]] = writeData; // Escreve na memória
        end
    end

endmodule
