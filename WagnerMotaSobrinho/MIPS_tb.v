`timescale 1ns/1ps
`include "MIPS.v"

module MIPS_tb;
    reg clk, reset;
    wire [31:0] ALUResult;
    wire MemRead, MemWrite, MemtoReg;

    // Instanciar o processador MIPS
    MIPS uut (
        .clk(clk),
        .reset(reset),
        .ALUResult(ALUResult),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg)
    );

    // Geração de clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("MIPS_tb.vcd");
        $dumpvars(0, MIPS_tb);

        // Inicializar sinais
        clk = 0;
        reset = 1;
        #50 reset = 0; // Libera o reset após 10 unidades de tempo
        
        // Monitores para depuração aprimorada
        // $monitor("\nTempo: %0t | PC: %h | Instrucao: %h | R1: %h | R2: %h | WR: %d | WD: %h | Op2: %h | ALUResult: %h | MemRead: %b | MemWrite: %b | BranchTarget: %h | ProximoPC: %h | RegWrite: %b | ALUSrc: %b\n",
        //          $time, uut.pc_atual, uut.instrucao, uut.read_data_1, uut.read_data_2, 
        //          uut.write_register, uut.write_data, uut.alu_operand2, ALUResult, MemRead, MemWrite, 
        //          uut.branch_target, uut.next_pc, uut.reg_write, uut.alu_src);
        
        // Teste: Forçando escrita no banco de registradores para verificar problema
        // #10;
        // uut.REG.registers[8] = 32'h00000001;  // Força $t0 = 1
        // uut.REG.registers[9] = 32'h00000002;  // Força $t1 = 2
        // #10;
        // $display("Forcando escrita: t0 = %h, t1 = %h", uut.REG.registers[8], uut.REG.registers[9]);

        $monitor("\nTempo: %0t | PC: %h | Instrucao: %h | $8 = %h| $9 = %h | $10 = %h | mem[0]: %h ", $time, uut.pc_atual, uut.instrucao, uut.REG.registers[8], uut.REG.registers[9],
                 uut.REG.registers[10], uut.MEM.memory[0]);

        // Rodar a simulação por um tempo suficiente
        #100;
        
        $display("Fim da simulacao.");
        $finish;
    end
endmodule
