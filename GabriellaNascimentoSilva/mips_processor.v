module mips_processor (
    input wire clk,              // Clock
    input wire reset,            // Reset
    output [31:0] pc,            // Program Counter (contador de programa)
    output [31:0] instruction,   // Instrução atual vinda da memória de instruções
    output RegWrite,             // Sinal de controle para escrita no banco de registradores
    output ALUSrc,               // Sinal de seleção da fonte do segundo operando da ALU
    output Branch                // Sinal de desvio condicional (BEQ)
);

    // Sinais de controle
    wire [31:0] instr, readData1, readData2, aluResult, writeData;
    wire [31:0] imm, aluSrcB, aluOut;
    wire [4:0] writeReg;
    wire zero, branch, regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branchCond;
    wire [1:0] aluOp;
    wire [3:0] aluControl;
    
    // Conexões com módulos
    wire [31:0] pcNext, pcBranch;
    wire [31:0] pcPlus4, pcBranchMuxOut;

    // PC (Program Counter)
    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .nextPC(pcNext),
        .pc(pc)
    );

    // Memória de Instruções
    instructionMemory imem (
        .address(pc),
        .instruction(instr)
    );

    // Unidade de Controle
    controlUnit ctrl_unit (
        .opcode(instr[31:26]),
        .regDst(regDst),
        .aluSrc(aluSrc),
        .memToReg(memToReg),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .branch(branch),
        .aluOp(aluOp)
    );

    // Registradores
    registers reg_file (
        .clk(clk),
        .regWrite(regWrite),
        .readReg1(instr[25:21]),
        .readReg2(instr[20:16]),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    // Sinal de controle da ALU
    aluControl alu_ctrl (
        .aluOp(aluOp),
        .funct(instr[5:0]),
        .aluControl(aluControl)
    );

    // ALU
    alu alu_inst (
        .A(readData1),
        .B(aluSrcB),
        .ALUOperation(aluControl),
        .ALUResult(aluResult),
        .Zero(zero)
    );

    // Memória de Dados
    dataMemory data_mem (
        .clk(clk),
        .memRead(memRead),
        .memWrite(memWrite),
        .address(aluResult),
        .writeData(readData2),
        .readData(writeData)
    );

    // Calculando o próximo PC
    adder32 pc_adder (
        .a(pc),
        .b(32'd4),
        .sum(pcPlus4)
    );

    // Mux de desvio
    mux2x1 pc_branch_mux (
        .A(pcPlus4),
        .B(pcBranch),
        .sel(branchCond),
        .out(pcBranchMuxOut)
    );

    // PC de entrada
    mux2x1 pc_mux (
        .A(pcBranchMuxOut),
        .B(pcPlus4),
        .sel(branch),
        .out(pcNext)
    );

    // Imediato
    signExtend sign_ext (
        .in(instr[15:0]),
        .out(imm)
    );

    // ALU Src Mux
    mux2x1 alu_src_mux (
        .A(readData2),
        .B(imm),
        .sel(aluSrc),
        .out(aluSrcB)
    );

    // Branch condicional
    assign branchCond = (zero && branch);

    // Instruções de desvio
    assign pcBranch = pcPlus4 + (imm << 2);

endmodule
