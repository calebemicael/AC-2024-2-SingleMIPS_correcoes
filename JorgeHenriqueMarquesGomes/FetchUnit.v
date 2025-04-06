module FetchUnit(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    output wire [31:0] instrucao    // Instrução buscada da memória
);

    // Registrador do PC
    reg [31:0] pc;

    // Fios para conexão entre módulos
    wire [31:0] pc_incrementado;
    wire [31:0]sentradaALU;

    //fios para as operações de controle
    wire [1:0]ALUop;
    wire RegDst;
    wire ALUSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire [3:0]ALUOperation;
    wire jump;

    //fios para acesso aos registradores
    wire [31:0] WriteData;
    // Saídas e sinais intermediários
    wire [31:0] ReadData1, ReadData2;   // Dados lidos do RegisterFile
    wire [31:0] signExtendedOffset;    // Offset estendido
    wire [31:0] ALUResult;             // Endereço calculado pela ALU
    wire Zero;
    wire [31:0] memoryReadData;        // Dados lidos da memória
    wire [4:0]Writeregister;
    
    //saidas pro branch
    wire [31:0] shiftedOffset;    // Offset deslocado à esquerda
    wire [31:0] branchAddress;    // Endereço de branch
    wire [31:0] pc_final;

    //saidas pro jump
    wire [31:0]jumpshift2;
    wire [31:0]jumpAddress;
    wire [31:0] pc_final_final;

    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(pc_incrementado)
    );

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(pc),
        .instrucao(instrucao)
    );

    //controle dos comandos
    Control controle (
        .OPcode(instrucao[31:26]),
        .ALUop(ALUop),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .jump(jump) 
    );

    ALUcontrol ALUcontrol(
        .OPcode(instrucao[5:0]),
        .ALUop(ALUop), 
        .ALUOperation(ALUOperation)
    );

    MUX5 MUXwrite(
        .A(RegDst),
        .um(instrucao[15:11]),
        .zero(instrucao[20:16]),
        .Saida(Writeregister)
    );

    Registradores regfile (
        .clk(clk),
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(Writeregister),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    SignExtend signExtend (
        .in(instrucao[15:0]),
        .out(signExtendedOffset)
    );

    ShiftLeft2 shiftLeft (
        .in(signExtendedOffset),
        .out(shiftedOffset)
    );

    Adder32 adder (
        .a(pc_incrementado),
        .b(shiftedOffset),
        .sum(branchAddress)
    );

    MUX branch(
        .A((Branch & Zero)),
        .um(branchAddress),
        .zero(pc_incrementado),
        .Saida(pc_final)
    );

    MUX muxALU(
        .A(ALUSrc),
        .um(signExtendedOffset),
        .zero(ReadData2),
        .Saida(sentradaALU)
    );

    ALU alu (
        .clk(clk),
        .A(ReadData1),
        .B(sentradaALU),
        .ALUOperation(ALUOperation), // Soma para calcular o endereço efetivo
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    DataMemory datamemory (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(ReadData2),
        .readData(memoryReadData)
    );

    MUX memtoReg(
        .A(MemtoReg),
        .um(memoryReadData),
        .zero(ALUResult),
        .Saida(WriteData)
    );

    ShiftLeft2 shiftLeftJump (
        .in(instrucao),
        .out(jumpshift2)
    );
    
    jumpAddresser JUMPADDRESS(
        .A(pc_incrementado),
        .B(jumpshift2),
        .Saida(jumpAddress)
    );

    MUX jumpmux(
        .A(jump),
        .um(jumpAddress),
        .zero(pc_final),
        .Saida(pc_final_final)
    );

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            pc <= pc_final_final;  
        end
    end

endmodule
