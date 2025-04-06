module MUX_RegDst(

    input wire [4:0] SecOperand,
    input wire [4:0] Destiny,
    input wire RegDst,
    output wire [4:0] WriteRegister

);

assign WriteRegister = RegDst ? Destiny : SecOperand;

endmodule