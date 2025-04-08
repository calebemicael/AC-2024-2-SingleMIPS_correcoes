`timescale 1ns / 1ps

module tb_mips_single_cycle;

    reg clk, reset;

    wire [31:0] pc;
    wire [31:0] instruction;
    wire reg_write, alu_src, branch, jump;

    // Array para armazenar o estado dos 32 registradores do banco
    reg [31:0] regBankState [31:0];


    mips_single_cycle uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .pc(pc),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .branch(branch),
        //alu_input_2 = uut.alu_input_2, //??? o que se tentou fazer aqui?
        .jump(jump)
    );

    genvar i, j, k;

        // Bloco generate para conectar os registradores do banco (semelhante ao "Banco_de_Registradores" do segundo arquivo)
    generate
        for (i = 0; i < 32; i = i + 1) begin : Banco_de_Registradores
            wire [31:0] registrador;
            assign registrador = uut.rf_inst.reg_file[i];
        end
    endgenerate

    // Bloco generate para a memória de dados (assumindo 256 posições, como no segundo testbench)
    generate
        for (k = 0; k < 256; k = k + 1) begin : Memoria_de_Dados
        wire [31:0] data;
        assign data = uut.dm_inst.memory[k];
        end
    endgenerate
    

    // Bloco generate para a memória de instruções (assumindo 256 posições, como no segundo testbench)
    generate
        for (j = 0; j < 256; j = j + 1) begin : Memoria_de_Instrucoes
            wire [31:0] instr_mem;
            assign instr_mem = uut.IM.memory[j];
        end
    endgenerate

 // Bloco principal de inicialização (estilo do segundo arquivo)
    initial begin
        $dumpfile("tb_mips_single_cycle.vcd");
        $dumpvars(0, tb_mips_single_cycle);
 
        clk = 0;
        reset = 1;
        
        $readmemh("codigo.mem", uut.IM.memory);
        $display("Memória de instruções carregada com sucesso!");

        #10 reset = 0;
        repeat(40) begin
            #5 clk = ~clk;
        end
        $display("Simulação finalizada!");
        $finish;
    end

    integer idx;

        // Atualiza o array regBankState a cada borda de subida do clock,
    // copiando os valores do banco de registradores do processador.
    always @(posedge clk) begin
        for (idx = 0; idx < 32; idx = idx + 1) begin
            regBankState[idx] = uut.reg_file.regFile[idx];
        end
    end

endmodule