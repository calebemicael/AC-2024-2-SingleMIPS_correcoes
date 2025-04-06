module Datapaths(//Juntando tudo aqui
    input clk,
    input reset
);

    // Controladores de fluxo:
    wire RegDst, Branch, memRead, MemtoReg, memWrite, regWrite, ALUSrc, jump, ZeroALU, andMulti;
    wire [1:0] AluOp;
    wire [3:0] AluControl; 

    // Demais fios para o MIPS
    wire [31:0] instruction, dataRead, readData1, readData2, aluResult, memReadData, offSet32bit;
    wire [31:0] saidaMuxULA, saidaMuxData;
    wire [4:0]  writeRegister, saidaMux5Bit;

    // Realiza a busca do endereço da ALU + atualiza o program counter que nele estiver de maneira sequencial, jump ou branch.
    FetchUnit moduloBusca(
        .clk(clk), 
        .reset(reset), 
        .branch(Branch), 
        .zeroALU(ZeroALU), 
        .jumpSignal(jump), 
        .jumpAddress(instruction[25:0]), 
        .instrucao(instruction), 
        .andMuxSignal(andMulti)
    );

    // Responsável pela inserção dos valores nos devidos registradores baseada na instrução encontrada.
    Registradores registra (
        .ReadRegister1(instruction[25:21]), 
        .ReadRegister2(instruction[20:16]), 
        .WriteRegister(saidaMux5Bit), 
        .WriteData(saidaMuxData), 
        .RegWrite(regWrite), 
        .Clk(clk), 
        .ReadData1(readData1), 
        .ReadData2(readData2)
    );

    // Controla a operação que a ULA fará.
    ALUControl controlaULA (
        .ALUOp(AluOp), 
        .FunctionField(instruction[5:0]), 
        .saidaALU(AluControl)
    );
    
    // Responsável pelas principais operações lógicas e aritméticas do processador.
    ALU ula(
        .A(readData1), 
        .B(saidaMuxULA), 
        .ALUOperation(AluControl), 
        .ALUResult(aluResult), 
        .Zero(ZeroALU)
    );
    
    // Cuidará de mandar os valores corretos para escrita nos registradores de destino.
    DataMemory armazenamento (
        .Clk(clk), 
        .MemRead(memRead), 
        .MemWrite(memWrite), 
        .address(aluResult), 
        .writeData(readData2), 
        .readData(dataRead)
    );
    
    // Define os valores de cada sinal de controle a depender da operação a ser feita:
    ControlUnit unidadeControle(
        .opCode(instruction[31:26]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(regWrite),
        .MemRead(memRead),
        .MemWrite(memWrite),
        .Branch(Branch),
        .ALUOp1(AluOp[1]),
        .ALUOp0(AluOp[0]),
        .jump(jump)
    );

    // Extensor de bits para o offset:
    SignalExtend extensor(
        .in(instruction[15:0]), 
        .out(offSet32bit)
    );
    
    // Muxes: Controlam o fluxo de dados

    // Define o registrador de destino a ser escrito: rt ou rd.
    Mux5bits mux5bit (
        .entradaA(instruction[15:11]), 
        .entradaB(instruction[20:16]), 
        .seletora(RegDst), 
        .saida(saidaMux5Bit)
    );
    
    // Define se a segunda entrada da ULA será provinda do ReadData 2 ou do offset:
    Mux muxULA (
        .entradaA(offSet32bit), 
        .entradaB(readData2), 
        .seletora(ALUSrc), 
        .saida(saidaMuxULA)
    );

    // Define qual conteúdo será escrito no registrador de destino.
    Mux muxData (
        .entradaA(dataRead), 
        .entradaB(aluResult), 
        .seletora(MemtoReg),  
        .saida(saidaMuxData)
    );

endmodule