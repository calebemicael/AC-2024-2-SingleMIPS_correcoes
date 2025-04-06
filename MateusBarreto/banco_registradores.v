module banco_registradores (
    input clk,
    input RegWrite, // Sinal de escrita
    input [4:0] read_reg1, read_reg2, write_reg, // Endereços dos registradores
    input [31:0] write_data, // Dado para escrita
    output reg [31:0] read_data1, read_data2 // Saídas 
);
    //registradores
    reg [31:0] registradores [0:31]; 

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registradores[i] = 0; // Inicializa todos os registradores com 0 (Evita 'X')
    end

    // Escrita no registrador (somente na borda de subida do clock)
    always @(posedge clk) begin
        if (RegWrite && write_reg != 0) // Evita escrita no registrador $zero
            registradores[write_reg] <= write_data;
    end

    // Leitura dos registradores
    always @(*) begin
        read_data1 = registradores[read_reg1];
        read_data2 = registradores[read_reg2];
    end
endmodule
