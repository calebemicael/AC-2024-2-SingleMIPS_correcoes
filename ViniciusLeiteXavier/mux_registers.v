module mux_registers(
    input wire [4:0] instruction1,
    input wire [4:0] instruction2,
    input wire regDst,
    output reg [4:0] result
);

    always @(*) begin
        case (regDst)
            1'b0: result <= instruction1;
            default: result <= instruction2;
        endcase
    end

endmodule