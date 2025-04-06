module Mux32 (
    input wire [31:0] entrada0,
    input wire [31:0] entrada1,
    input wire sel,
    output wire [31:0] saida
);

    assign out = sel ? entrada1 : entrada0;

endmodule