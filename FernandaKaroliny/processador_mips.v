module processador_mips(
    input wire clk,
    input wire reset,
    output [31:0] pc,            // Program Counter (contador de programa)
    output [31:0] instruction,   // Instrução atual vinda da memória de instruções
    output RegWrite,             // Sinal de controle para escrita no banco de registradores
    output ALUSrc,               // Sinal de seleção da fonte do segundo operando da ALU
    output Branch               // Sinal de desvio condicional (BEQ)
);
    
    // Sinais de controle
    wire RegDst, MemtoReg, MemRead, MemWrite;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    wire Zero;
    
    // Barramentos
    wire [31:0] instrucao, readData1, readData2, writeData, signExtImm;
    wire [31:0] aluSrcB, aluResult, memData, pcNext, pcBranch;
    wire [4:0] writeReg;
    wire branchAndZero;
    
    // PC
    PC pc_reg(
        .clk(clk),
        .reset(reset),
        .pc_incrementado(pcNext),
        .pc(pc)
    );
    
    // Memória de Instruções
    memoriaInstrucoes instr_mem(
        .addr(pc),
        .instrucao(instrucao)
    );
    
    // Unidade de Controle
    unidadeControle control_unit(
        .opcode(instrucao[31:26]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );
    
    // Banco de Registradores
    registradores reg_file(
        .clk(clk),
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(writeReg),
        .WriteData(writeData),
        .RegWrite(RegWrite),
        .ReadData1(readData1),
        .ReadData2(readData2)
    );
    
    // MUX para selecionar o registrador de escrita
    MUX2x1 #(.WIDTH(5)) mux_reg_dst (
        .in0(instrucao[20:16]),
        .in1(instrucao[15:11]),
        .sel(RegDst),
        .out(writeReg)
    );

    
    // Extensão de Sinal
    signalExtend sign_ext(
        .in(instrucao[15:0]),
        .out(signExtImm)
    );
    
    // MUX para selecionar a entrada da ALU
    MUX2x1 mux_alu_src(
        .in0(readData2),
        .in1(signExtImm),
        .sel(ALUSrc),
        .out(aluSrcB)
    );
    
    // Unidade de Controle da ALU
    ALUControl alu_control(
        .ALUOp(ALUOp),
        .funct(instrucao[5:0]),
        .ALUControl(ALUControl)
    );
    
    // ALU
    ALU alu(
        .A(readData1),
        .B(aluSrcB),
        .ALUOperation(ALUControl),
        .ALUResult(aluResult),
        .Zero(Zero)
    );
    
    // Memória de Dados
    dataMemory data_mem(
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(aluResult),
        .writeData(readData2),
        .readData(memData)
    );
    
    // MUX para selecionar a fonte dos dados a serem escritos no registrador
    MUX2x1 mux_mem_to_reg(
        .in0(aluResult),
        .in1(memData),
        .sel(MemtoReg),
        .out(writeData)
    );
    
    // Calcular endereço de branch
    adder32 pc_adder(
        .a(pc),
        .b({signExtImm[29:0], 2'b00}),
        .sum(pcBranch)
    );
    
    // Controle do Branch
    assign branchAndZero = Branch & Zero;
    
    // Selecionar próximo PC
    MUX2x1 mux_pc_src(
        .in0(pc + 4),
        .in1(pcBranch),
        .sel(branchAndZero),
        .out(pcNext)
    );
    
endmodule
