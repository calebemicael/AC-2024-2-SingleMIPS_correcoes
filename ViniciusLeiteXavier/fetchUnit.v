`include "adder4.v"
`include "inst_memory.v"

module fetchUnit(
    input wire clk,
    input wire reset,
    output wire [31:0] instruction
);

    // Registrador PC
    reg [31:0] pc;

    // instancia o modulo inst_memory para que instruction receba o valor de memory[pc]
    inst_memory memory (
        .address(pc),
        .instruction(instruction)
    );

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc + 4;
    end


endmodule
