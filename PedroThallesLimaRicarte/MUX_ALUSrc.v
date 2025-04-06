module MUX_ALUSrc(
    input wire [31:0] ReadReg,
    input wire [31:0] SignEx,
    input wire ALUSrc,
    output wire [31:0] Operand
);

    assign Operand = ALUSrc ? SignEx : ReadReg;
        
endmodule