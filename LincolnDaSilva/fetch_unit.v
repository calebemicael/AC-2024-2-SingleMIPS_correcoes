module fetch_unit(
    input wire clk,
    input wire reset,
    input wire [31:0] branchAddress,
    input wire [31:0] jumpAddress,
    input wire [1:0] pcSrc,
    output wire [31:0] instrucao,
    output wire [31:0] pcAtual
);

    reg [31:0] pc;

    // Instância da Memória de Instruções
    memoria_instrucoes mem_inst (
        .addr(pc),
        .instrucao(instrucao)
    );

    // Lógica do PC
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0;
        end else begin
            case (pcSrc)
                2'b00: pc <= pc + 4;             // Próxima instrução sequencial
                2'b01: pc <= branchAddress;      // Branch
                2'b10: pc <= jumpAddress;        // Jump
                default: pc <= pc + 4;
            endcase
        end
    end

    assign pcAtual = pc;

endmodule