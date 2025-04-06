
module mips(
    input wire clock,
    input wire reset
);
    
    wire [31:0] pc_proximo, pc_mais4, pc_desvio;
    wire [31:0] instrucao;
    wire FontePC;

    
    wire RegDst, Branch, MemRead, MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite, ALUSrc, RegWrite;
    wire Zero;
    wire [3:0] ALUOperation;

    
    wire [4:0] reg_escrita;
    wire [31:0] dado_escrita_reg;
    wire [31:0] dado_leitura1, dado_leitura2;
    wire [31:0] extendido_sinal;
    wire [31:0] entrada_b_alu;
    wire [31:0] resultado_alu;
    wire [31:0] dado_leitura_mem;
    wire [31:0] endereco_deslocado;

    
    reg [31:0] pc; // Fetch Unit
    always @(posedge clock or posedge reset) begin
        if (reset)
            pc <= 32'b0;
        else
            pc <= pc_proximo;
    end

    
    Add4 soma_pc(
        .in(pc),
        .out(pc_mais4)
    );

    MemoriaDeInstrucoes memoria_instrucoes(
        .addr(pc),
        .instrucao(instrucao)
    );

    
    ControlUnit controle(
        .opcode(instrucao[31:26]),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    
    Mux2_5bit mux_reg_dst(
        .in0(instrucao[20:16]),
        .in1(instrucao[15:11]),
        .sel(RegDst),
        .out(reg_escrita)
    );

    Registradores registradores(
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(reg_escrita),
        .WriteData(dado_escrita_reg),
        .RegWrite(RegWrite),
        .ReadData1(dado_leitura1),
        .ReadData2(dado_leitura2)
    );

    SignExtend extensor_sinal(
        .in(instrucao[15:0]),
        .out(extendido_sinal)
    );

    
    Mux2 mux_fonte_alu(
        .in0(dado_leitura2),
        .in1(extendido_sinal),
        .sel(ALUSrc),
        .out(entrada_b_alu)
    );

    
    ALUControl controle_alu(
        .ALUOp(ALUOp),
        .funct(instrucao[5:0]),
        .ALUOperation(ALUOperation)
    );

    ALU alu(
        .A(dado_leitura1),
        .B(entrada_b_alu),
        .ALUOperation(ALUOperation),
        .ALUResult(resultado_alu),
        .Zero(Zero)
    );

    DataMemory memoria_dados(
        .clk(clock),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(resultado_alu),
        .writeData(dado_leitura2),
        .readData(dado_leitura_mem)
    );

    
    Mux2 mux_mem_para_reg(
        .in0(resultado_alu),
        .in1(dado_leitura_mem),
        .sel(MemtoReg),
        .out(dado_escrita_reg)
    );

    ShiftLeft2 desloca_esquerda_2(
        .in(extendido_sinal),
        .out(endereco_deslocado)
    );

    Adder32 somador_desvio(
        .a(pc_mais4),
        .b(endereco_deslocado),
        .sum(pc_desvio)
    );

    assign FontePC = Branch & Zero;
    
    
    Mux2 mux_fonte_pc(
        .in0(pc_mais4),
        .in1(pc_desvio),
        .sel(FontePC),
        .out(pc_proximo)
    );

endmodule