module Registers(
    input wire [4:0] readRegister1,  // Endereço do registrador para leitura 1
    input wire [4:0] readRegister2,  // Endereço do registrador para leitura 2
    input wire [4:0] writeRegister,  // Endereço do registrador para escrita
    input wire [31:0] writeData,     // Dados a serem escritos
    input wire regWrite,             // Habilitação de escrita
    output wire [31:0] readData1,    // Dados lidos do registrador 1
    output wire [31:0] readData2     // Dados lidos do registrador 2
);

    // Banco de registradores: 32 registradores de 32 bits
    reg [31:0] registers [31:0];

    // Inicialização dos registradores (opcional, apenas para simulação)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;  // Inicializa todos com zero
        end
    end

    // Leitura combinacional
    assign readData1 = registers[readRegister1];
    assign readData2 = registers[readRegister2];

    // Escrita síncrona
    always @(*) begin
        if (regWrite && writeRegister != 5'b0) begin
            registers[writeRegister] <= writeData;  // Escreve no registrador
        end
    end

endmodule
