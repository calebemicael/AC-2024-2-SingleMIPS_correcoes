// Módulo do Banco de Registradores
module RegisterFile(clk, regWrite, readReg1, readReg2, writeReg, writeData, readData1, readData2);
    input clk, regWrite;
    input [4:0] readReg1, readReg2, writeReg;
    input [31:0] writeData;
    output [31:0] readData1, readData2;

    reg [31:0] registers [0:31];  // 32 registradores de 32 bits

    // Leitura combinacional
    assign readData1 = registers[readReg1];
    assign readData2 = registers[readReg2];
    
    always @(posedge clk) begin
        if (regWrite)
            registers[writeReg] <= writeData;
    end
endmodule
