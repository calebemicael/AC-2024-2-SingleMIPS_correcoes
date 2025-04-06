module mux_dataMem(
    input wire [31:0] readData,
    input wire [31:0] ALU_result,
    input wire memtoReg,
    output reg [31:0] result
);

    always @(*) begin
        case (memtoReg)
            1'b0: result <= ALU_result;
            default: result <= readData;
        endcase
    end

endmodule