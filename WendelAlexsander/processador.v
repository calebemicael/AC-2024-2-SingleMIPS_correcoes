`include "ALU.v"
`include "ALUControl.v"
`include "controlUnit.v"
`include "dataMemory.v"
`include "MemoriaDeInstrucoes.v"
`include "MUX1.v"
`include "ProgramCounter.v"
`include "registers.v"
`include "signExtended.v"
`include "ALU.v"
module processador(
   
    input clk,                   // Sinal de clk
    input rst,                   // Sinal de rst
    output [31:0] programCounter,// Program Counter
    output [31:0] instruction,   // Instrução atual 
    output RegWrite,             // Sinal para escrever no banco de registradores
    output ALUSource,            // Sinal da fonte do segundo operando da ALU
    output branch,               // Sinal de desvio BEQ
    output jump                  // Sinal de salto JUMP

)

  // Fios das conexões entre módulos
    wire [31:0] pc, next_pc, readData1, readData2, alu_result, mem_data, sign_ext_imm;
    wire [31:0] pc_+_4, branch_target, jump_target, pc_next_temp, write_data;
    wire [4:0] writeReg;
    wire [3:0] alu_control;
    wire zero, MemtoReg, MemRead, MemWrite, RegDst;
    wire [1:0] ALUOp;

    // Instâncias dos módulos principais do processador

    ALU inst_alu( // ALU

        .A(readData1), // Primeiro operando vindo do banco de registradores
        .B(ALUSrc ? sign_ext_imm : readData2), // Segundo operando definido pelo MUX (ALUSrc)
        .ALUOperation(alu_control), // Sinal de controle da ALU
        .result(ALUResult), // Resultado da operação da ALU
        .Zero(zero)          // Flag de zero (usada para BEQ)

    );

       
    ALUControl inst_ALUcontrol( // Unidade de Controle da ALU

        .ALUOp(ALUOp),
        .funct(instruction[5:0]), // Código de função para instruções R
        .ALUControl_to_Aluop(alu_control)

    );

    
    controlUnit inst_controlUnit( // Unidade de Controle

        .Opcode(instruction[31:26]),
        .RegDst(RegDst),
        .ALUSource(ALUSource),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)

    );
    
    dataMemory inst_data_mem(// Memória de Dados

        .clk(clk),
        .MemRead(MemRead),   // para leitura da memória
        .MemWrite(MemWrite), // para escrita na memória
        .address(alu_result), // Endereço da ALU
        .writeData(readData2), // Dado q será escrito
        .readData(mem_data)    // Dado lido

    );

     MemoriaDeInstrucoes inst_MemoriaDeInstrucoes(// Memória de Instruções

        .address(pc),
        .instruction(instruction)

    );

     MUX1 #(5) inst_reg_dst_MUX (// MUX q seleciona o registrador de destino (RegDst)

        .input0(instruction[20:16]), // rt (registrador destino para instruções tipo I)
        .input1(instruction[15:11]), // rd (registrador destino para instruções tipo R)
        .select(RegDst),             // Controle da unidade de controle
        .outpt(writeReg)            // Registrador de destino final

    );

    MUX1 inst_mem_to_reg_mux ( // MUX para selecionar se o dado vem da ALU ou da memória (MemtoReg)

        .input0(alu_result), // Resultado da ALU
        .input1(mem_data),   // Dado lido da memória
        .select(MemtoReg),   // Controle da unidade de controle
        .outpt(write_data)  // Dado final a ser escrito no registrador

    );

    
    MUX1 inst_pc_src_mux (// MUX para seleção do próximo PC baseado no Branch (BEQ)

        .input0(pc_plus4),       // Próxima instrução normal
        .input1(branch_target),  // Endereço do branch
        .select(Branch & zero),  // Condição da BEQ
        .outpt(pc_next_temp)    // Próximo endereço antes do MUX pro Jump

    );

    
    MUX1 inst_jump_mux (// MUX para seleção do próximo PC baseado no Jump (salto incondicional)

        .input0(pc_next_temp), // Próximo PC definido por BEQ ou PC+4
        .input1(jump_target),  // Endereço do Jump
        .select(Jump),         // Controle de Jump da unidade de controle
        .outpt(next_pc)       // PC final para a próxima instrução

    );

    programCounter inst_programCounter( // PC (Program Counter) - Contador de Programa

        .clk(clk),
        .rst(rst),
        .next_instruction(next_pc),
        .pc(pc)

    ); 
    
    registers inst_registers(// Banco de Registradores

        .clk(clk),
        .RegWrite(RegWrite),
        .readRegister1(instruction[25:21]), // rs
        .readRegister2(instruction[20:16]), // rt
        .WriteRegister(writeReg),
        .writeData(write_data),
        .readData1(readData1), // Saída do primeiro operando
        .readData2(readData2)  // Saída do segundo operando
        
    );

    signExtend inst_sign_extend(    // Extensor de Sinal - Converte imediato de 16 bits para 32 bits

        .in(instruction[15:0]), // Imediato extraído da instrução
        .out(sign_ext_imm)      // Imediato estendido para 32 bits
        
    );

    // Cálculo do endereço do branch (desvio condicional)
    assign branch_target = pc_+_4 + (sign_ext_imm << 2); // PC + 4 + deslocamento do imediato

    // Cálculo do endereço do jump (salto incondicional)
    assign jump_target = {pc_+_4[31:28], instruction[25:0] << 2}; // Endereço do jump

    
    assign pc_+_4 = pc + 4;//incrementa o PC para o endereço da próxima insttrução

endmodule