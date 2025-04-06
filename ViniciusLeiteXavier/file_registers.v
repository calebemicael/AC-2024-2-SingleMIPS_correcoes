module file_registers(
    input wire [4:0] readRegister1, // Endereço do registrador a ser lido
    input wire [4:0] readRegister2,
    input wire [4:0] writeRegister, // Endereço do registrador a ser escrito
    input wire [31:0] writeData, // Conteudo a ser escrito no registrador
    input wire regWrite,
    output wire [31:0] readData1,
    output wire [31:0] readData2    
);

    /*
    Banco de registradores do MIPS que possui 
    por padrão 32 registradores de 32 bits
    */
    
    reg [31:0] registers [31:0];

    integer i;

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    assign readData1 = registers[readRegister1];
    assign readData2 = registers[readRegister2];

    always @(*) begin
        if(regWrite && writeRegister != 5'b0) begin
            registers[writeRegister] <= writeData;
        end
    end

endmodule