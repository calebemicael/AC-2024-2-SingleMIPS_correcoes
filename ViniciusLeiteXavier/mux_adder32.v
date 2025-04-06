module mux_adder32(
    input wire [31:0] adder_result,
    input wire [31:0] adder32_result,
    input wire and_zero_branch,
    output reg [31:0] result
);

    always @(*) begin
        case (and_zero_branch)
            1'b0: result <= adder_result;
            default: result <= adder32_result;
        endcase
    end

endmodule