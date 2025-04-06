module program_counter (
    input clk, reset, Jump, Branch, Zero,
    input [31:0] pc_next, jump_addr, branch_target,
    output reg [31:0] pc
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'h00000000;      // Inicializa o PC em 0
        else if (Jump)
            pc <= jump_addr;         // JUMP
        else if (Branch && Zero)
            pc <= branch_target;     // Salta para  o branch_target 
        else
            pc <= pc_next & 32'hFFFFFFFC; // PC normal, mantendo alinhamento de 4 bytes
    end
endmodule
