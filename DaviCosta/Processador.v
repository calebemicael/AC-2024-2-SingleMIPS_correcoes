module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] Controle_ALU,
    output reg [31:0] resultado,
    output zero
);
    always @(*) begin
        case(Controle_ALU)
            4'b0000: resultado = A & B;           // and
            4'b0001: resultado = A | B;           // or
            4'b0010: resultado = A + B;           // soma
            4'b0110: resultado = A - B;           // subtração
            4'b0111: resultado = (A < B) ? 32'b1 : 32'b0; // slt
            default: resultado = 32'b0;           // caso inválido
        endcase
    end
    assign zero = (resultado == 32'b0);
endmodule

module MUX(
    input [31:0] A,
    input [31:0] B,
    input seletor,
    output [31:0] saida
);
    assign saida = (seletor) ? A : B;
endmodule

module Registrador(
    input clk,
    input reset,        //sinal de reset para inicialização
    input [4:0] rs,     //endereço do registrador rs
    input [4:0] rt,     //endereço do registrador rt
    input [4:0] rd,     //endereço do registrador rd (destino)
    input [31:0] wd,    //dado a ser escritovindo do MUX
    input rw,           //sinal de escrita, 1 para escrever em rd
    output [31:0] read_data1,   //valor lido de rs
    output [31:0] read_data2    //valor lido de rt
);
    reg [31:0] registradores [31:0]; //banco de 32 registradores de 32 bits

    //aqui está lendo os dados para serem usados nas operações
    assign read_data1 = registradores[rs];
    assign read_data2 = registradores[rt];

    //iniciando os registradores
    integer i;
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            //reset inicializa todos os registradores com 0
            for (i = 0; i < 32; i = i + 1)
                registradores[i] <= 32'b0;
        end
        //escrita normal, se rw está ativo e rd não é o registrador 0
        if (rw && (rd != 0))
            registradores[rd] <= wd;
    end
endmodule

module Unidade_controle(
    input [5:0] opcode,
    output reg rw,
    output reg alu_src,
    output reg mw,
    output reg mtr,
    output reg branch,
    output reg jump,
    output reg [1:0] alu_op
);

    //a unidade de controle decodifica o opcode da instrução e gera os sinais de controle correspondentes
    //para determinar o comportamento da ALU, dos registradores e da memória. Os sinais são definidos com base 
    //na instrução e controla as operações de leitura ou escrita e a manipulação de dados
    always @(*) begin
        rw = 1'b0;
        alu_src = 1'b0;
        mw = 1'b0;
        mtr = 1'b0;
        branch = 1'b0;
        jump = 1'b0;
        alu_op = 2'b00;
        
        case (opcode)
            6'b000000: begin    //instrução R-type
                rw = 1'b1;      //habilita a escrita no registrador de destino
                alu_src = 1'b0; //a alu opera usando dois registradores
                alu_op = 2'b10; //determina a operação da alu
            end
            6'b100011: begin    //lw
                rw = 1'b1;
                alu_src = 1'b1;
                mtr = 1'b1;
                alu_op = 2'b00; //a ALU faz uma soma para calcular o endereço
            end
            6'b101011: begin    //sw
                alu_src = 1'b1;
                mw = 1'b1;      //permite escrita de memoria
                alu_op = 2'b00; //soma para o endereço
            end
            6'b000100: begin    //beq
                branch = 1'b1;
                alu_op = 2'b01; //subtração para comparação
            end
            6'b000010: begin    //jump
                jump = 1'b1;
            end
            default: begin //se o opcode não corresponder a nenhuma instrução conhecida tudo continua zero
                rw      = 1'b0;
                alu_src = 1'b0;
                mw      = 1'b0;
                mtr     = 1'b0;
                branch  = 1'b0;
                jump    = 1'b0;
                alu_op  = 2'b00;
            end
        endcase
    end
endmodule

module ALU_CONTROLE(
    input [5:0] funcao,
    input [1:0] alu_op,
    output reg [3:0] alu_controle
);
    always @(*) begin
        case(alu_op)
            2'b00: alu_controle = 4'b0010;  //lw e sw - adição
            2'b01: alu_controle = 4'b0110;  //beq - subtração
            2'b10: begin
                case (funcao)
                    6'b100000: alu_controle = 4'b0010;  // add
                    6'b100010: alu_controle = 4'b0110;  // sub
                    6'b100100: alu_controle = 4'b0000;  // and
                    6'b100101: alu_controle = 4'b0001;  // or
                    6'b101010: alu_controle = 4'b0111;  // slt
                    default: alu_controle = 4'b0000;
                endcase
            end
            default: alu_controle = 4'b0000; //caso inválido
        endcase
    end
endmodule

module Instrucao_memoria(
    input [31:0] endereco,
    output [31:0] instrucao
);
    reg [31:0] mem [0:255];
    initial begin
        $readmemb("codigoprocessador.bin", mem); //ler arquivo em assembly
    end
    assign instrucao = mem[endereco[9:2]];
endmodule

module Data(
    input clk,
    input reset,
    input [31:0] endereco,
    input [31:0] wd,
    input mw,
    output [31:0] rd
);
    reg [31:0] mem [0:255]; //essa memoria serve para guardar os arquivos para continuar a instrução quando se passar um ciclo no processador
    integer i;
    initial begin
        for(i = 0; i < 29; i = i+1)
            mem[i] = 32'b0;
    end

    //durante o ciclo de clock, se o sinal de controle mw estiver ativado, 
    //wd será escrito na memória no endereço especificado por endereco[9:2]
    //o endereço é truncado para 8 bits (9:2) para acessar a posição correta na memória
    //o dado lido da memória na posição endereco[9:2] é atribuído ao sinal rd
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            for (i = 0; i < 256; i=i+1) begin
                mem[i] <= 32'b0;
            end
        end
        else if(mw)
            mem[endereco[9:2]] <= wd;
    end
    assign rd = mem[endereco[9:2]];
endmodule

module Processador_MIPS (
    input clk,
    input reset
);
    reg [31:0] pc;
    wire [31:0] instrucao;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] alu_resultado;
    wire [31:0] mem_data;
    wire [31:0] sinal_extendido;
    wire [31:0] wd;
    wire [3:0] alu_controle;
    wire zero;
    
    wire rw, alu_src, mw, mtr, branch, jump;
    wire [1:0] alu_op;
    
    wire [31:0] alu_input2;
    wire [31:0] pc_next;
    
    Instrucao_memoria imem(
        .endereco(pc),
        .instrucao(instrucao)
    );
    
    //essa extensão de sinal preserva o sinal do valor imediato, garantindo que ele continue sendo negativo ou positivo
    assign sinal_extendido = {{16{instrucao[15]}}, instrucao[15:0]};
    
    Registrador reg_file(
        .clk(clk),
        .rs(instrucao[25:21]),
        .rt(instrucao[20:16]),
        .rd(instrucao[15:11]),
        .wd(wd),
        .rw(rw),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    Unidade_controle controle(
        .opcode(instrucao[31:26]),
        .rw(rw),
        .alu_src(alu_src),
        .mw(mw),
        .mtr(mtr),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op)
    );
    
    ALU_CONTROLE alu_ctrl_inst(
        .funcao(instrucao[5:0]),
        .alu_op(alu_op),
        .alu_controle(alu_controle)
    );
    
    MUX mux_alu_src(
        .A(sinal_extendido),
        .B(read_data2),
        .seletor(alu_src),
        .saida(alu_input2)
    );
    
    ALU alu(
        .A(read_data1),
        .B(alu_input2),
        .Controle_ALU(alu_controle),
        .resultado(alu_resultado),
        .zero(zero)
    );
    
    Data dmem(
        .clk(clk),
        .endereco(alu_resultado),
        .wd(read_data2),
        .mw(mw),
        .rd(mem_data)
    );
    
    MUX mux_mem_para_reg(
        .A(mem_data),
        .B(alu_resultado),
        .seletor(mtr),
        .saida(wd)
    );
    
    //aqui vai haver a comparação para ver se o processador irá dar um jump ou continuar para a proxima instrução
    //próxima instrução de PC, lida com jump e branchs 
    assign pc_next = (jump) ? 
        {pc[31:28], instrucao[25:0], 2'b00} : 
        ((branch & zero) ? (pc + 4 + (sinal_extendido << 2)) : (pc + 4));
    
    //atualização do PC com reset
    always @(posedge clk or posedge reset) begin
        if(reset)
            pc <= 32'b0;
        else
            pc <= pc_next;
    end
endmodule