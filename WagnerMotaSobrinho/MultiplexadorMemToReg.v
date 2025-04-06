module MUX_MemToReg(
    input wire [31:0] ALUResult,  // Resultado da ALU
    input wire [31:0] ReadData,   // Dado lido da memória
    input wire MemtoReg,          // Sinal de controle do multiplexador
    output wire [31:0] WriteData  // Dado a ser escrito no banco de registradores
);
    assign WriteData = (MemtoReg) ? ReadData : ALUResult;
endmodule
