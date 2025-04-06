module mux_alu(
    input wire [31:0] readData2,
    input wire [31:0] signal_extend,
    input wire aluSrc,
    output reg [31:0] result
);

    always @(*) begin
        case (aluSrc)
            1'b0: result <= readData2;
            default: result <= signal_extend;
        endcase
    end

endmodule