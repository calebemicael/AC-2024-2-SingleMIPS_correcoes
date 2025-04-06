module DataMemory(
    input wire clk,
    input wire [31:0] Address,
    input wire [31:0] WriteData,
    input wire MemWrite,
    input wire MemRead,
    output wire [31:0] ReadData
);

    reg [31:0] memory [0:1023];  // Memória de 1KB (1024 palavras de 32 bits)

    // Leitura da memória
    assign ReadData = (MemRead) ? memory[Address[31:2]] : 32'b0;

    // Escrita na memória
    always @(posedge clk) begin
        if (MemWrite) begin
            memory[Address[31:2]] <= WriteData;
        end
    end

endmodule