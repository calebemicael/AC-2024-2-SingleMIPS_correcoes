module Processor (
    input wire clk,
    input wire reset
);
    wire [31:0] PCout_pro, instruction_pro, Rd1_pro, Rd2_pro, SigExt_pro, MuxALU_pro, Add4Out_pro, AdderIn_pro, AdderOut_pro, ALUResult_pro, ReadData_pro, MuxMem_pro,MuxAdderOut_pro, PCin_pro;
    wire [27:0] SLTJumpOut_pro;
    wire [1:0] ALUOp_pro;
    wire [4:0] MuxReg_pro;
    wire [3:0] ALUOperation_pro;
    wire RegWrite_pro, RegDst_pro, ALUSrc_pro, Branch_pro, AndOut_pro, MemRead_pro, MemWrite_pro, MemtoReg_pro, Zero_pro, Jump_pro;

    // Contador de programa
    ProgramCounter PC (
        .clk(clk), 
        .reset(reset), 
        .pc_in(PCin_pro), 
        .pc_out(PCout_pro)
    );

    // Somador do PC
    Add4 PC_Adder (.in(PCout_pro), .out(Add4Out_pro));

    // Memória de instruções
    InstructionMemory Inst_Memory (
        .addr(PCout_pro), 
        .instruction(instruction_pro)
    );

    // Multiplexador do arquivo de resgistradores
    Mux2x1Reg MuxRegFile (
        .A(instruction_pro[20:16]), 
        .B(instruction_pro[15:11]),
        .sel(RegDst_pro),
        .out(MuxReg_pro)
    );

    // Registradores
    RegisterFile Registers (
        .clk(clk),
        .ReadRegister1(instruction_pro[25:21]), 
        .ReadRegister2(instruction_pro[20:16]),  
        .WriteRegister(MuxReg_pro), 
        .WriteData(MuxMem_pro),    
        .RegWrite(RegWrite_pro),             
        .ReadData1(Rd1_pro),    
        .ReadData2(Rd2_pro)
    );

    // Extensor de sinal
    SignalExtend Signal_Ext (
        .in(instruction_pro[15:0]), 
        .out(SigExt_pro)
    );

    // Unidade de Controle
    Control_Unit Control(
        .instruction(instruction_pro[31:26]),
        .RegDst(RegDst_pro), 
        .Jump(Jump_pro), 
        .Branch(Branch_pro), 
        .MemRead(MemRead_pro), 
        .MemWrite(MemWrite_pro),
        .MemtoReg(MemtoReg_pro), 
        .RegWrite(RegWrite_pro), 
        .ALUSrc(ALUSrc_pro), 
        .ALUOp(ALUOp_pro)
    );

    // Unidade de controle da ALU
    ALU_Control ALU_Control(
        .ALUOp(ALUOp_pro),
        .funct(instruction_pro[5:0]),
        .control_out(ALUOperation_pro)
    );

    // Unidade Lógica e Aritmética
    ALU ALU(
        .A(Rd1_pro),
        .B(MuxALU_pro),           
        .ALUOperation(ALUOperation_pro), 
        .ALUResult(ALUResult_pro),   
        .Zero(Zero_pro)     
    );

    // Multiplexador da ALU
    Mux2x1 MuxALU (
        .A(Rd2_pro), 
        .B(SigExt_pro),
        .sel(ALUSrc_pro),
        .out(MuxALU_pro)
    );

    // Somador de 32 bits
    Adder32 Adder32(
        .A(Add4Out_pro),
        .B(AdderIn_pro),
        .sum(AdderOut_pro)
    );

    // Operação de deslocamento à esquerda
    ShiftLeft2 SLT_Adder (
        .in(SigExt_pro),
        .out(AdderIn_pro)
    );

    // Porta AND
    AND_logic AND_Gate ( 
        .branch(Branch_pro),
        .zero(Zero_pro),
        .and_out(AndOut_pro)
    );

    // Multiplexador dos somadores 
    Mux2x1 MuxAdder (
        .A(Add4Out_pro),
        .B(AdderOut_pro),
        .sel(AndOut_pro),
        .out(MuxAdderOut_pro)
    );

    // Memória de Dados
    DataMemory DataMemory (
        .clk(clk),          
        .MemRead(MemRead_pro),
        .MemWrite(MemWrite_pro),
        .address(ALUResult_pro), 
        .writeData(Rd2_pro),
        .readData(ReadData_pro) 
    );

    // Multiplexador da saída de memória
    Mux2x1 MuxMemory (
        .A(ALUResult_pro),
        .B(ReadData_pro),
        .sel(MemtoReg_pro),
        .out(MuxMem_pro)
    );

    // Multiplexador de jump 
    Mux2x1 MuxJump (
        .A(MuxAdderOut_pro),
        .B({Add4Out_pro[31:28], SLTJumpOut_pro}),
        .sel(Jump_pro),
        .out(PCin_pro)
    );
    
    // Deslocamento de 2 bits para calcular endereço do jump
    ShiftLeft2Jump SLT_Jump (
        .in(instruction_pro[25:0]),
        .out(SLTJumpOut_pro)
    );
endmodule



// CONTADOR DE PROGRAMA
module ProgramCounter (
    input wire clk,
    input wire reset,
    input wire [31:0] pc_in,
    output reg [31:0] pc_out
);
    // Lógica do PC: reset ou incrementa
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc_out <= 32'b0;
        end else begin
            // Atualiza o PC com o próximo endereço
            pc_out <= pc_in;
        end
    end  
endmodule


// SOMADOR DO PC
module Add4(
    input wire [31:0] in,        // Endereço atual do PC
    output wire [31:0] out       // Endereço incrementado
);
    assign out = in + 32'd4;     // Soma 4 ao valor de entrada
endmodule


// MEMÓRIA DE INSTRUÇÕES
module InstructionMemory(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instruction // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memory [255:0];

    // Inicialização da memória a partir de um arquivo binário
    initial begin
        $readmemb("codigo.mem", memory);  // Carrega o arquivo binário na memória
    end

    // Leitura combinacional
    assign instruction = memory[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule


// MULTIPLEXADOR 2x1
module Mux2x1 (
    input wire[31:0] A, 
    input wire[31:0] B,
    input wire sel,
    output wire[31:0] out
);

    assign out = (sel == 1'b0) ? A : B;
endmodule


// MULTIPLEXADOR DO ARQUIVO DE REGISTRADORES
module Mux2x1Reg (
    input wire[4:0] A, 
    input wire[4:0] B,
    input wire sel,
    output wire[4:0] out
);

    assign out = (sel == 1'b0) ? A : B;
endmodule


// ARQUIVO DE REGISTRADORES
module RegisterFile(
    input wire clk,
    input wire [4:0] ReadRegister1,  // Endereço do registrador para leitura 1
    input wire [4:0] ReadRegister2,  // Endereço do registrador para leitura 2
    input wire [4:0] WriteRegister,  // Endereço do registrador para escrita
    input wire [31:0] WriteData,     // Dados a serem escritos
    input wire RegWrite,             // Habilitação de escrita
    output wire [31:0] ReadData1,    // Dados lidos do registrador 1
    output wire [31:0] ReadData2     // Dados lidos do registrador 2
);

    // Banco de registradores: 32 registradores de 32 bits
    reg [31:0] registers [31:0];

    // Inicialização dos registradores (opcional, apenas para simulação)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;  // Inicializa todos com zero
        end
    end

    // Leitura combinacional
    assign ReadData1 = registers[ReadRegister1];
    assign ReadData2 = registers[ReadRegister2];

    // Escrita síncrona
    always @(posedge clk) begin
        if (RegWrite && WriteRegister != 5'b0) begin
            registers[WriteRegister] <= WriteData;  // Escreve no registrador
        end
    end
endmodule


// EXTENSOR DE SINAL
module SignalExtend(
    input wire [15:0] in,         // Campo de 16 bits a ser estendido
    output wire [31:0] out        // Resultado estendido para 32 bits
);

    assign out = {{16{in[15]}}, in}; // Extensão de sinal replicando o bit mais significativo
endmodule


// UNIDADE DE CONTROLE PRINCIPAL
module Control_Unit (
    input wire[31:26] instruction,
    output reg RegDst, 
    output reg Jump, 
    output reg Branch, 
    output reg MemRead, 
    output reg MemWrite,
    output reg MemtoReg, 
    output reg RegWrite, 
    output reg ALUSrc, 
    output reg [1:0]ALUOp
);

    always @(*) begin
        RegDst    = 1'b0;
        ALUSrc    = 1'b0;
        MemtoReg  = 1'b0;
        RegWrite  = 1'b0;
        MemRead   = 1'b0;
        MemWrite  = 1'b0;
        Branch    = 1'b0;
        Jump      = 1'b0;
        ALUOp     = 2'b00;

        case (instruction)
            //I-TYPE
            6'b001000: begin // addi
                RegDst    = 1'b0;
                ALUSrc    = 1'b1;
                MemtoReg  = 1'b0;
                RegWrite  = 1'b1;
                MemRead   = 1'b0;
                MemWrite  = 1'b0;
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUOp     = 2'b10;
            end

            //R-TYPE
            6'b000000: begin 
                RegDst    = 1'b1;
                ALUSrc    = 1'b0;
                MemtoReg  = 1'b0;
                RegWrite  = 1'b1;
                MemRead   = 1'b0;
                MemWrite  = 1'b0;
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUOp     = 2'b10;
            end

            //LOAD
            6'b100011: begin 
                RegDst    = 1'b0;
                ALUSrc    = 1'b1;
                MemtoReg  = 1'b1;
                RegWrite  = 1'b1;
                MemRead   = 1'b1;
                MemWrite  = 1'b0;
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUOp     = 2'b00;
            end

            //STORE
            6'b101011: begin
                RegDst    = 1'b0;
                ALUSrc    = 1'b1;
                MemtoReg  = 1'bX; // Não é relevante
                RegWrite  = 1'b0;
                MemRead   = 1'b0;
                MemWrite  = 1'b1;
                Branch    = 1'b0;
                Jump      = 1'b0;
                ALUOp     = 2'b00;
            end

            //BEQ
            6'b000100: begin 
                RegDst    = 1'b0;
                ALUSrc    = 1'b0;
                MemtoReg  = 1'bX; // Não é relevante
                RegWrite  = 1'b0;
                MemRead   = 1'b0;
                MemWrite  = 1'b0;
                Branch    = 1'b1;
                Jump      = 1'b0;
                ALUOp     = 2'b01;
            end

            //JUMP
            6'b000010: begin
                RegDst    = 1'bX; // Não é relevante
                ALUSrc    = 1'bX; // Não é relevante
                MemtoReg  = 1'bX; // Não é relevante
                RegWrite  = 1'b0;
                MemRead   = 1'b0;
                MemWrite  = 1'b0;
                Branch    = 1'b0;
                Jump      = 1'b1;
                ALUOp     = 2'bXX;
            end
        endcase
    end
endmodule


// ALU
module ALU(
    input wire [31:0] A,           // Operando 1
    input wire [31:0] B,           // Operando 2
    input wire [3:0] ALUOperation, // Código da operação ALU
    output reg [31:0] ALUResult,   // Resultado da ALU
    output wire Zero               // Sinal Zero (ativo quando ALUResult é 0)
);

    // Define o comportamento da ALU
    always @(*) begin
        case (ALUOperation)
            4'b0000: ALUResult = A & B;          // AND
            4'b0001: ALUResult = A | B;          // OR
            4'b0010: ALUResult = A + B;          // Soma
            4'b0110: ALUResult = A - B;          // Subtração
            4'b0111: ALUResult = (A < B) ? 1 : 0; // SLT (Set Less Than)
            4'b1100: ALUResult = ~(A | B);       // NOR
            default: ALUResult = 32'b0;          // Operação inválida
        endcase
    end

    // Define o sinal Zero
    assign Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;

endmodule


// UNIDADE DE CONTROLE DA ALU
module ALU_Control (
    input wire[1:0] ALUOp,
    input wire[5:0] funct,
    output reg[3:0] control_out
);

    always @(*) begin
        case (ALUOp)
            2'b00: control_out = 4'b0010; // lw e sw (soma)
            2'b01: control_out = 4'b0110; // beq (subtração)
            2'b10: begin  // Tipo R (definido pelo funct)
                case (funct)
                    6'b100000: control_out = 4'b0010; // add
                    6'b100010: control_out = 4'b0110; // sub
                    6'b100100: control_out = 4'b0000; // and
                    6'b100101: control_out = 4'b0001; // or
                    6'b101010: control_out = 4'b0111; // slt
                    default:   control_out = 4'b0010; // Tipo I
                endcase
            end
            default: control_out = 4'b0010; // Padrão
        endcase
    end
endmodule


// MEMÓRIA DE DADOS
module DataMemory(
    input wire clk,                // Clock
    input wire MemRead,            // Sinal de leitura
    input wire MemWrite,           // Sinal de escrita
    input wire [31:0] address,     // Endereço de memória
    input wire [31:0] writeData,   // Dados a serem escritos
    output wire [31:0] readData    // Dados lidos
);

    // Memória de dados (256 palavras de 32 bits)
    reg [31:0] memory [255:0];

    // Inicializa a memória para simulação (opcional)
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'b0; // Inicializa com zero
        end
    end

    // Leitura combinacional
    assign readData = (MemRead) ? memory[address[9:2]] : 32'b0;

    // Escrita combinacional
    always @(posedge clk) begin
        if (MemWrite) begin
            memory[address[9:2]] <= writeData; // Escreve na memória
        end
    end
endmodule


// DESLOCAMENTO DE 2 BITS
module ShiftLeft2(
    input wire [31:0] in,          // Entrada de 32 bits
    output wire [31:0] out         // Saída deslocada
);

    assign out = in << 2;          // Desloca à esquerda em 2 bits
endmodule

// SLT JUMP
module ShiftLeft2Jump(
    input wire [25:0] in,          // Entrada de 32 bits
    output wire [27:0] out         // Saída deslocada
);

    assign out = in << 2;          // Desloca à esquerda em 2 bits
endmodule

// SOMADOR DE 32 BITS
module Adder32(
    input wire [31:0] A,           // Operando A
    input wire [31:0] B,           // Operando B
    output wire [31:0] sum         // Resultado da soma
);

    assign sum = A + B;            // Soma A + B
endmodule

// PORTA LÓGICA AND
module AND_logic (
    input wire branch,
    input wire zero,
    output wire and_out
);

    assign and_out = branch & zero;
endmodule