module Registradores(
    input wire clk,                // Clock
    input wire [4:0] ReadRegister1, // Endereço de leitura 1
    input wire [4:0] ReadRegister2, // Endereço de leitura 2
    input wire [4:0] WriteRegister, // Endereço de escrita
    input wire [31:0] WriteData,    // Dados a serem escritos
    input wire RegWrite,            // Habilitação de escrita
    output wire [31:0] ReadData1,   // Dados lidos do registrador 1
    output wire [31:0] ReadData2    // Dados lidos do registrador 2
);

    // Banco de 32 registradores de 32 bits
    reg [31:0] registers [31:0];

    // Inicializa os registradores
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;  // Inicializa todos com zero
        end
    end

    // Leitura combinacional
    assign ReadData1 = registers[ReadRegister1];
    assign ReadData2 = registers[ReadRegister2];

    // Escrita no registrador (sincronizada no clock)
    always @(posedge clk) begin
        if (RegWrite && WriteRegister != 5'b0) begin
            registers[WriteRegister] <= WriteData;  // Escreve no registrador
        end
    end

endmodule

