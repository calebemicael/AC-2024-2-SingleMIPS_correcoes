// Processador Principal (Single Cycle MIPS)
module Processador(
    input clk,                   // Sinal de clock
    input rst,                   // Sinal de reset
    output [31:0] pc,            // Program Counter (contador de programa)
    output [31:0] instruction,   // Instrução atual vinda da memória de instruções
    output RegWrite,             // Sinal de controle para escrita no banco de registradores
    output ALUSrc,               // Sinal de seleção da fonte do segundo operando da ALU
    output Branch,               // Sinal de desvio condicional (BEQ)
    output Jump                  // Sinal de salto incondicional (JUMP)
);

    // Fios (conexões internas entre os módulos)
    wire [31:0] next_pc, readData1, readData2, alu_result, mem_data, sign_ext_imm;
    wire [31:0] pc_plus4, branch_target, jump_target, pc_next_temp, write_data;
    wire [4:0] writeReg;
    wire [3:0] alu_control;
    wire zero, MemtoReg, MemRead, MemWrite, RegDst;
    wire [1:0] ALUOp;

    // Instâncias dos módulos principais do processador

    // PC (Program Counter) - Contador de Programa
    PC pc_reg(
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Memória de Instruções
    InstructionMemory inst_mem(
        .address(pc),
        .instruction(instruction)
    );

    // Unidade de Controle - Define sinais de controle com base no opcode
    ControlUnit control(
        .opcode(instruction[31:26]), // Extrai opcode da instrução
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    // MUX para seleção do registrador de destino (RegDst)
    MUX2to1 #(5) reg_dst_mux (
        .in0(instruction[20:16]), // rt (registrador destino para instruções tipo I)
        .in1(instruction[15:11]), // rd (registrador destino para instruções tipo R)
        .sel(RegDst),             // Controle da unidade de controle
        .out(writeReg)            // Registrador de destino final
    );

    // Banco de Registradores
    Registradores reg_file(
        .clk(clk),
        .RegWrite(RegWrite),
        .readReg1(instruction[25:21]), // rs
        .readReg2(instruction[20:16]), // rt
        .writeReg(writeReg),
        .writeData(write_data),
        .readData1(readData1), // Saída do primeiro operando
        .readData2(readData2)  // Saída do segundo operando
    );

    // Extensor de Sinal - Converte imediato de 16 bits para 32 bits
    SignExtend sign_ext(
        .in(instruction[15:0]), // Imediato extraído da instrução
        .out(sign_ext_imm)      // Imediato estendido para 32 bits
    );

    // Unidade de Controle da ALU - Define operação da ALU com base no ALUOp e funct
    ALUControl alu_ctrl(
        .ALUOp(ALUOp),
        .funct(instruction[5:0]), // Código de função (apenas para instruções tipo R)
        .alu_control(alu_control)
    );

    // ALU (Unidade Lógica e Aritmética)
    ALU alu(
        .input1(readData1), // Primeiro operando vindo do banco de registradores
        .input2(ALUSrc ? sign_ext_imm : readData2), // Segundo operando definido pelo MUX (ALUSrc)
        .ALUControl(alu_control), // Sinal de controle da ALU
        .result(alu_result), // Resultado da operação da ALU
        .zero(zero)          // Flag de zero (usada para BEQ)
    );

    // Memória de Dados - Usada para Load (LW) e Store (SW)
    DataMemory data_mem(
        .clk(clk),
        .MemRead(MemRead),   // Controle para leitura da memória
        .MemWrite(MemWrite), // Controle para escrita na memória
        .address(alu_result), // Endereço vindo da ALU
        .writeData(readData2), // Dado a ser escrito (caso SW)
        .readData(mem_data)    // Dado lido (caso LW)
    );

    // MUX para selecionar se o dado vem da ALU ou da memória (MemtoReg)
    MUX2to1 mem_to_reg_mux (
        .in0(alu_result), // Resultado da ALU
        .in1(mem_data),   // Dado lido da memória
        .sel(MemtoReg),   // Controle da unidade de controle
        .out(write_data)  // Dado final a ser escrito no registrador
    );

    // Cálculo do endereço do branch (desvio condicional)
    assign branch_target = pc_plus4 + (sign_ext_imm << 2); // PC + 4 + deslocamento do imediato

    // MUX para seleção do próximo PC baseado no Branch (BEQ)
    MUX2to1 pc_src_mux (
        .in0(pc_plus4),       // Próxima instrução normal (PC + 4)
        .in1(branch_target),  // Endereço de branch (caso BEQ seja verdadeiro)
        .sel(Branch & zero),  // Condição de BEQ: Branch ativo e flag zero ativa
        .out(pc_next_temp)    // Próximo PC antes do MUX de Jump
    );

    // Cálculo do endereço do jump (salto incondicional)
    assign jump_target = {pc_plus4[31:28], instruction[25:0] << 2}; // Endereço do jump

    // MUX para seleção do próximo PC baseado no Jump (salto incondicional)
    MUX2to1 jump_mux (
        .in0(pc_next_temp), // Próximo PC definido por BEQ ou PC+4
        .in1(jump_target),  // Endereço do Jump
        .sel(Jump),         // Controle de Jump da unidade de controle
        .out(next_pc)       // PC final para a próxima instrução
    );

    // Cálculo do PC + 4 (incrementa o PC para a próxima instrução)
    assign pc_plus4 = pc + 4;

endmodule
