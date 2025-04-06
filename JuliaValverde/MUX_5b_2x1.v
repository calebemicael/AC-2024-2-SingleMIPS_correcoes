module MUX_5b_2x1(
    input wire [4:0] A,
    input wire [4:0] B,
    input wire sel,
    output reg [4:0] MUX_5b_Result
);

    always @(*) begin
        case (sel)
            1'b0: MUX_5b_Result = A;
            1'b1: MUX_5b_Result = B;
            default: MUX_5b_Result = 5'b0;
        endcase
    end

endmodule