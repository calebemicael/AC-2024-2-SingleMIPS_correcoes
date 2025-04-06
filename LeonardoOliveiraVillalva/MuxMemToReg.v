module MuxMemToReg(
    input wire [31:0] ALUResult,   // Resultado da ALU
    input wire [31:0] ReadData,    // Dado lido da memória
    input wire MemToReg,           // Sinal de controle
    output wire [31:0] WriteData   // Dado a ser escrito no registrador
);

    assign WriteData = (MemToReg) ? ReadData : ALUResult;

endmodule