module concatenarEndJump(
    input wire[27:0] A,
    input wire[3:0] B,
    output wire[31:0] out
);

assign out = {B, A};// concatena os 4 bits mais significativps do pc com o target da instrução j

endmodule