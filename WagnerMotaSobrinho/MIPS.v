// Incluindo os módulos necessários
`include "ALU.v"
`include "Registradores.v"
`include "DataMemory.v"
`include "UnidControle.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"
`include "ALUControl.v"
`include "MemoriaDeInstrucoes.v"
`include "MultiplexadorMemToReg.v"
`include "Add4.v"
`include "Adder32.v"
`include "MUX2to1_PC.v"

module MIPS(
    input wire clk,
    input wire reset,
    output wire [31:0] ALUResult,  // Expor resultado da ALU
    output wire MemRead,           // Expor controle de leitura de memória
    output wire MemWrite,
    output wire MemtoReg
);
    // Sinais do caminho de dados
    wire [31:0] instrucao;
    wire [31:0] pc_plus_4;       // PC + 4
    wire [31:0] branch_target;   // Branch Target: PC + 4 + (SignExtend << 2)
    wire [31:0] next_pc;         // Próximo PC selecionado pelo MUX
    wire [31:0] read_data_1, read_data_2, write_data, alu_result;
    wire [31:0] sign_extended, deslocado, mem_data;
    wire [31:0] alu_operand2;
    wire [4:0]  write_register;
    wire [3:0]  alu_control_signal;
    wire [1:0]  alu_op;
    wire zero, reg_write, mem_read, mem_write, alu_src, branch, reg_dst;
    reg  [31:0] pc_atual;

     // Memória de Instruções
    MemoriaDeInstrucoes IM (
        .addr(pc_atual),
        .instrucao(instrucao)
    );

    // Unidade de Controle
    UnidadeControle UC (
        .opcode(instrucao[31:26]),
        .RegWrite(reg_write),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .ALUSrc(alu_src),
        .ALUOp(alu_op),
        .Branch(branch),
        .RegDst(reg_dst),
        .MemtoReg(MemtoReg)
    );

    // Banco de Registradores
    Registradores REG (
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(write_register),
        .WriteData(write_data),
        .RegWrite(reg_write),
        .clk(clk),
        .ReadData1(read_data_1),
        .ReadData2(read_data_2)
    );

    // Extensão de Sinal
    SignExtend SE (
        .in(instrucao[15:0]),
        .out(sign_extended)
    );

    // Shift Left 2 (para cálculo de endereço de branch)
    ShiftLeft2 SL2 (
        .in(sign_extended),
        .out(deslocado)
    );

    // ALU Control
    ALUControl ALUC (
        .ALUOp(alu_op),
        .funct(instrucao[5:0]),
        .ALUControlSignal(alu_control_signal)
    );

    // MUX para WriteRegister
    assign write_register = reg_dst ? instrucao[15:11] : instrucao[20:16];

    // MUX para ALU Operand2
    assign alu_operand2 = alu_src ? sign_extended : read_data_2;

    // ALU
    ALU ALU (
        .A(read_data_1),
        .B(alu_operand2),
        .ALUOperation(alu_control_signal),
        .Zero(zero),
        .ALUResult(alu_result)
    );

    // Memória de Dados
    DataMemory MEM (
        .clk(clk),
        .address(alu_result),
        .writeData(read_data_2),
        .MemWrite(mem_write),
        .MemRead(mem_read),
        .readData(mem_data)
    );

    // MUX para WriteData (registradores)
    MUX_MemToReg mux_memtoreg (
        .ALUResult(alu_result),
        .ReadData(mem_data),
        .MemtoReg(MemtoReg),
        .WriteData(write_data)
    );

    // Cálculo do PC + 4 
    Add4 add4_inst (
        .in(pc_atual),
        .out(pc_plus_4)
    );

    // Cálculo do Branch Target (PC + 4 + deslocado) 
    Adder32 branch_adder (
        .a(pc_plus_4),
        .b(deslocado),
        .sum(branch_target)
    );

    // Sinal para branch_taken: somente toma o branch se (branch == 1) e (zero == 1) 
    wire branch_taken;
    assign branch_taken = branch && zero;

    // MUX para selecionar o próximo PC 
    MUX2to1_PC mux_pc (
        .pc_plus_4(pc_plus_4),
        .branch_target(branch_target),
        .branch_taken(branch_taken),
        .next_pc(next_pc)
    );

    // PC (Program Counter)
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_atual <= 0;
        else
            pc_atual <= next_pc; 
    end
  
    assign ALUResult = alu_result;
    assign MemRead = mem_read;
    assign MemWrite = mem_write;

endmodule
