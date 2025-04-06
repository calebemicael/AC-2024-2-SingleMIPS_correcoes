`include "Add4.v"
`include "MemoriaDeInstrucoes.v"
`include "Mux2para1.v"


module FetchUnit(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    input wire branch,
    input wire jump,
    input wire [31:0] jumpEndereco,
    input wire [31:0] branchEndereco,
    output wire [31:0] instrucao    // Instrução buscada da memória
);

    // Registrador do PC
    reg [31:0] pc;

    // Fios para conexão entre módulos
    wire [31:0] pc_incrementado;
    wire [31:0] proximoPC;
    wire [31:0] proximoPCbranch;

    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(pc_incrementado)
    );
    // Instancia um MUX para selecionar o próximo PC (incrementação, jump ou branch)
    Mux2para1 muxpc (
        .a(pc_incrementado),
        .b(jumpEndereco),
        .sc(jump),
        .out(proximoPC));

    // MUX adicional para controlar o branch
    Mux2para1 muxbranch(        
        .a(proximoPC),
        .b(branchEndereco),          
        .sel(branch),          
        .out(proximoPCbranch));

    // Atualiza proximoPC final com a lógica de jump e branch
    assign proximoPC = jump ? jumpEndereco : proximoPCbranch;

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(pc),
        .instrucao(instrucao)
    );

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            pc <= proximoPC;  
        end
    end

endmodule
