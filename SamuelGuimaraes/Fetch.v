`include "Add4.v"
`include "ShiftLeft26b.v"
//`include "ALU.v"
//`include "Mux32b.v"
//`include "ShiftLeft2.v"
`include "MemoriaDeInstrucoes.v"

module Fetch(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    input wire jump,
    input wire branch,
    input wire ALUZero,
    input wire [31:0] fetchInstrucao,
    output wire [31:0] instrucao    // Instrução buscada da memória
);

    // Registrador do PC
    reg [31:0] pc;

    // Fios para conexão entre módulos
    wire [31:0] pc_incrementado;

    wire [31:0] _pc_add4;
    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(_pc_add4)
    );

    wire [31:0] _shift_left_0;
    ShiftLeft2 shift_left_0 (
        .in(fetchInstrucao),
        .out(_shift_left_0)
    );

    wire [31:0] _ALU_result;
    ALU alu_add (
        .A(_pc_add4),
        .B(_shift_left_0),
        .ALUOperation(4'b0010),
        .ALUResult(_ALU_result)
    );

    wire _seletor_mux3;
    assign _seletor_mux3 = branch & ALUZero;

    wire [31:0] _mux3;
    Mux32b mux3(    
        .A(_pc_add4),
        .B(_ALU_result),
        .seletor(_seletor_mux3),
        .Y(_mux3)
    );

     // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(pc),
        .instrucao(instrucao)
    );

    wire [27:0] _shift_left_jump;
    ShiftLeft26b shift_left_26 (
        .in(instrucao[25:0]),
        .out(_shift_left_jump)
    );

    wire [31:0] endereco_jump;
    assign endereco_jump [31:28] = _pc_add4 [31:28];
    assign endereco_jump [27:0] = _shift_left_jump;

    wire [31:0] _mux4;
    Mux32b mux4 (
        .A(_mux3),
        .B(_mux4),
        .seletor(jump),
        .Y(_mux4)
    );

    assign pc_incrementado = _mux4;

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            pc <= pc_incrementado;  
        end
    end



endmodule