module MUX_32b_2x1(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire sel,
    output reg [31:0] MUX_32b_Result
);

    always @(*) begin
        case (sel)
            1'b0: MUX_32b_Result = A;
            1'b1: MUX_32b_Result = B;
            default: MUX_32b_Result = 32'b0;
        endcase
    end

endmodule