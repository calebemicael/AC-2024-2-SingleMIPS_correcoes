`timescale 1ns / 1ps

module processador_mips_tb;

    // Entradas da simulação
    reg clk;
    reg reset;

    // Fios de saída do processador
    wire [31:0] pc;          // Program Counter (contador de programa)
    wire [31:0] instruction; // Instrução atual
    wire RegWrite, ALUSrc, Branch;  // Sinais de controle

    // Array para armazenar o estado dos 32 registradores do banco
    reg [31:0] regBankState [31:0];

    // Declaração de genvars para blocos generate
    genvar i, j,k;
    integer idx;

    // Instância do processador
    processador_mips uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .Branch(Branch)
    );

    // Bloco generate para conectar os registradores do banco (semelhante ao "Banco_de_Registradores" do segundo arquivo)
    generate
        for (i = 0; i < 32; i = i + 1) begin : Banco_de_Registradores
            wire [31:0] registrador;
            assign registrador = uut.reg_file.registers[i];
        end
    endgenerate

    // Bloco generate para a memória de dados (assumindo 256 posições, como no segundo testbench)
    generate
        for (k = 0; k < 256; k = k + 1) begin : Memoria_de_Dados
        wire [31:0] data;
        assign data = uut.data_mem.memory[k];
        end
    endgenerate
    

    // Bloco generate para a memória de instruções (assumindo 256 posições, como no segundo testbench)
    generate
        for (j = 0; j < 256; j = j + 1) begin : Memoria_de_Instrucoes
            wire [31:0] instr_mem;
            assign instr_mem = uut.instr_mem.memoria[j];
        end
    endgenerate

    // Bloco principal de inicialização (estilo do segundo arquivo)
    initial begin
        // Configuração do arquivo de dump para visualização de ondas
        $dumpfile("processador_mips.vcd");
        $dumpvars(0, processador_mips_tb);


        // Inicializa clock e reset
        clk = 0;
        reset = 1;

        // Carrega o arquivo de memória de instruções
        $readmemb("codigo_teste.mem", uut.instr_mem.memoria);
        $display("Arquivo codigo.mem carregado com sucesso!");

        // Desativa o reset após 10 ns
        #10 reset = 0;

        // Gera 40 ciclos de clock (período total de 20 ns por ciclo)
        repeat (40) begin
            #5 clk = ~clk;
        end

        $finish;
    end

    // Monitoramento do registrador 0
    initial begin
        $monitor("Tempo: %0d | regBankState[0]: %h", $time, regBankState[0]);
    end

    // Atualiza o array regBankState a cada borda de subida do clock,
    // copiando os valores do banco de registradores do processador.
    always @(posedge clk) begin
        for (idx = 0; idx < 32; idx = idx + 1) begin
            regBankState[idx] = uut.reg_file.registers[idx];
        end
    end

endmodule