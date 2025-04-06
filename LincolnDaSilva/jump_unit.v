module jump_unit(
    input wire [25:0] jumpAddr,
    input wire [31:0] pcAtual,
    output wire [31:0] jumpAddress
);

    assign jumpAddress = {pcAtual[31:28], jumpAddr, 2'b00};

endmodule