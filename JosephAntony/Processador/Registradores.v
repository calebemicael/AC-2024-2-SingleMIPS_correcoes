module Registradores (
    input wire clk,
    input wire reset,
    input wire [4:0] ReadRegister1,
    input wire [4:0] ReadRegister2,
    input wire [4:0] WriteRegister,
    input wire [31:0] WriteData,
    input wire RegWrite,
    output wire [31:0] ReadData1,
    output wire [31:0] ReadData2
);
    // Banco de registradores de 32 entradas, cada uma com 32 bits
    reg [31:0] registradores [31:0]; 

    // Inicializa os registradores (opcional)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registradores[i] = 32'b0;  // Inicializa todos os registradores com 0
        end
    end

    // Escrita no registrador
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registradores[i] <= 32'b0;  // Reseta todos os registradores
            end
        end
        else if (RegWrite) begin
            registradores[WriteRegister] <= WriteData;  // Escreve no registrador
        end
    end
        // Leitura dos registradores
    assign ReadData1 = registradores[ReadRegister1];
    assign ReadData2 = registradores[ReadRegister2];

endmodule