module MUX_MemtoReg(
    input wire [31:0] ReadData,
    input wire [31:0] ALUResult,
    input wire MemtoReg,
    output wire [31:0] WriteData
);

    assign WriteData = MemtoReg ? ReadData : ALUResult;

endmodule