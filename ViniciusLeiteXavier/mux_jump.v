module mux_jump(
    input wire [31:0] jumpAddress,
    input wire [31:0] usual_instruction,
    input wire jump,
    output reg [31:0] result
);

    always @(*) begin
        case (jump)
            1'b0: result <= usual_instruction;
            default: result <= jumpAddress;
        endcase
    end

endmodule