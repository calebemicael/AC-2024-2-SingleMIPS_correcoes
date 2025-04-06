// Módulo de registradores (Registers)
// Este módulo implementa um banco de registradores de 32 registros de 32 bits cada.
// Ele permite a leitura e escrita de dados em registradores, com controle de escrita 
// por meio de um sinal regWrite e leitura assíncrona de dois registradores ao mesmo tempo.

module registers (
    input wire clk,              // Clock
    input wire regWrite,         // Sinal de escrita no registrador
    input wire [4:0] readReg1,   // Registrador a ser lido (rs)
    input wire [4:0] readReg2,   // Registrador a ser lido (rt)
    input wire [4:0] writeReg,   // Registrador a ser escrito (rd)
    input wire [31:0] writeData, // Dado a ser escrito no registrador
    output reg [31:0] readData1, // Saída do primeiro registrador lido
    output reg [31:0] readData2  // Saída do segundo registrador lido
);

    reg [31:0] registers [31:0]; // 32 registradores de 32 bits

    // Leitura assíncrona
    always @(*) begin
        readData1 = registers[readReg1];
        readData2 = registers[readReg2];
    end

    // Escrita síncrona (na borda de subida do clock)
    always @(posedge clk) begin
        if (regWrite && writeReg != 5'b00000) // Registrador $zero é sempre 0
            registers[writeReg] <= writeData;
    end

endmodule
