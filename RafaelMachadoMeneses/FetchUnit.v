module FetchUnit(
    input wire clk,
    input wire reset,
    input wire Jump,
    input wire [31:0] jump_address,
    output reg [31:0] pc,  
    output wire [31:0] instrucao
);
    wire [31:0] pc_plus4, pc_next;

    Add4 add4 (.in(pc), .out(pc_plus4));

    mux2x1 mux_jump (
        .in0(pc_plus4),
        .in1(jump_address),
        .sel(Jump),
        .out(pc_next)
    );

    MemoriaDeInstrucoes imem (
        .addr(pc),
        .instrucao(instrucao)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) pc <= 32'b0;
        else pc <= pc_next;
    end
endmodule
