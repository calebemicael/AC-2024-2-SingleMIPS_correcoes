`timescale 1ns/1ns
`include "Adder32.v"
`include "FetchUnit.v"
`include "ALU_Control.v"
`include "Control.v"
`include "ALU.v"
`include "DataMemory.v"
`include "MIPS.v"
`include "MUX_5bits.v"
`include "MUX_32bits_ALUSrc.v"
`include "MUX_32bits_BEQ.v"
`include "MUX_32bits_MemtoReg.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"
`include "Add4.v"
`include "MemoriaDeInstrucoes.v"
`include "Concat.v"
`include "MUX_32bits_jump.v"
`include "ShiftLeft2_jump.v"

module simulacao;
    reg clk;
    reg reset;

    MIPS mips(
        .clk(clk),
        .reset(reset)
    );

    // Gera o clock
    always #5 clk = ~clk;

    integer i;
    integer j;
    initial begin
        $dumpfile("mips.vcd"); // Nome do arquivo de saída
        $dumpvars(0, mips);    // Registrar todas as variáveis deste módulo

        // monitorar os registradores internos   
        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, simulacao.mips.registradores.registers[i]); // Monitora cada registrador
        end

        for (j = 0; j < 256; j = j + 1) begin
             $dumpvars(2, simulacao.mips.data_memory.memory[j]); // Monitora a memoria
        end

        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No comeco, PC desconhecido.
        #10
        reset = 1;  // Reseta o PC
        #10
        reset = 0;  // Volta a Habilitar o PC, e comeca a buscar instrucao
        #10
    
        
        
        // Executa alguns ciclos de clock para verificar o fetch
        #100;
        $finish;
    end


endmodule