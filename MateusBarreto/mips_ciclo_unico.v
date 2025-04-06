`include "program_counter.v"
`include "memoria_instrucoes.v"
`include "unidade_controle.v"
`include "banco_registradores.v"
`include "extensor_sinal.v"
`include "alu_control.v"
`include "ALU.v"
`include "memoria_dados.v"
`include "somador_pc.v"
`include "jump_address.v"

module mips_ciclo_unico (
    input clk, reset
);
    wire [31:0] pc_atual, pc_proximo, instrucao, read_data1, read_data2;
    wire [31:0] imediato_ext, alu_resultado, mem_dados, write_data, jump_addr;
    wire [31:0] branch_target;  // Novo sinal para branch target
    wire [4:0] write_reg;
    wire [3:0] ALUControl;
    wire [1:0] ALUOp;
    wire [31:0] alu_operand2;
    wire Zero, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump;
    
    // calcula o branch target: PC+4 + (imediato_ext << 2)
    assign branch_target = pc_proximo + (imediato_ext << 2);

    // instancia o program ccounter com suporte a Jump e Branch
    program_counter PC(
        clk,       // clk
        reset,     // reset
        Jump,      // sinal de Jump
        Branch,    // sinal de Branch
        Zero,      // sinal Zero (saída da ALU)
        pc_proximo,// pc + 4
        jump_addr, // endereço para Jump
        branch_target, // endereço para Branch
        pc_atual   // pc atual (saída)
    );
    
    // Memória de Instruções
    memoria_instrucoes MEM_INST(
        pc_atual, 
        instrucao
    );
    
    // Unidade de Controle
    unidade_controle CTRL(
        instrucao[31:26], 
        RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, ALUOp
    );
    
    // Banco de Registradores
    assign write_reg = (RegDst) ? instrucao[15:11] : instrucao[20:16];
    banco_registradores REGISTROS(
        clk, 
        RegWrite, 
        instrucao[25:21], 
        instrucao[20:16], 
        write_reg, 
        write_data, 
        read_data1, 
        read_data2
    );
    
    // Extensor de Sinal
    extensor_sinal EXT(
        instrucao[15:0], 
        imediato_ext
    );
    
    // Multiplexador para a ALU
    assign alu_operand2 = (ALUSrc) ? imediato_ext : read_data2;
 

    // ALU Control
    alu_control ALU_CTRL(
        ALUOp, 
        instrucao[5:0], 
        ALUControl
    );
    
    // ALU
    ALU ALU_MOD(
        read_data1, 
        alu_operand2, 
        ALUControl, 
        alu_resultado, 
        Zero
    );
    
    // Memória de Dados
    memoria_dados MEM_DADOS(
        clk, 
        MemRead, 
        MemWrite, 
        alu_resultado, 
        read_data2, 
        mem_dados
    );
    
    // Multiplexador para escrita no banco de registradores
    assign write_data = (MemtoReg) ? mem_dados : alu_resultado;
    

    // Somador de PC (PC + 4)
    somador_pc SOMADOR(
        pc_atual, 
        pc_proximo
    );

    // calculo do endereço do Jump
    jump_address JUMP_MOD(
        instrucao[25:0], 
        pc_atual, 
        jump_addr
    );
    
endmodule
