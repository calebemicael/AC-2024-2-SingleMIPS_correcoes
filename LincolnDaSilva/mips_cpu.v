module mips_cpu (
    input wire clk,
    input wire reset,
    output wire [31:0] pcAtual // 
);

// Sinais internos
wire [31:0] instrucao, ReadData1, ReadData2, ALUResult, WriteData, ReadDataMem;
wire [3:0] ALUOperation;
wire RegWrite, MemWrite, ALUSrc, RegDst, Zero;
wire [1:0] pcSrc;
wire [31:0] branchAddress, jumpAddress;

// Instância do Fetch Unit
fetch_unit fetch (
    .clk(clk),
    .reset(reset),
    .branchAddress(branchAddress),
    .jumpAddress(jumpAddress),
    .pcSrc(pcSrc),
    .instrucao(instrucao),
    .pcAtual(pcAtual)
);

// Instância do Banco de Registradores
registradores regs (
    .clk(clk),
    .ReadRegister1(instrucao[25:21]),
    .ReadRegister2(instrucao[20:16]),
    .WriteRegister(RegDst ? instrucao[15:11] : instrucao[20:16]),
    .WriteData(WriteData),
    .RegWrite(RegWrite),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

// Instância da ALU
alu alu (
    .A(ReadData1),
    .B(ALUSrc ? instrucao[15:0] : ReadData2),
    .ALUOperation(ALUOperation),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

// Instância da Memória de Dados
memoria_dados data_mem (
    .clk(clk),
    .addr(ALUResult),
    .WriteData(ReadData2),
    .MemWrite(MemWrite),
    .ReadData(ReadDataMem)
);

// Instância da Unidade de Controle
unidade_controle control (
    .opcode(instrucao[31:26]),
    .funct(instrucao[5:0]),
    .RegWrite(RegWrite),
    .ALUOperation(ALUOperation),
    .MemWrite(MemWrite),
    .pcSrc(pcSrc),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst)
);

// Instância do Jump Unit
jump_unit jump (
    .jumpAddr(instrucao[25:0]),
    .pcAtual(pcAtual),
    .jumpAddress(jumpAddress)
);

// Lógica para branchAddress
assign branchAddress = pcAtual + (instrucao[15:0] << 2);

// Lógica para WriteData
assign WriteData = (MemWrite) ? ReadDataMem : ALUResult;

endmodule
