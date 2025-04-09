module decodificador(
    input wire [31:0] instrucao,
    output wire [5:0] opcode,
    output wire [4:0] rs,
    output wire [4:0] rt,
    output wire [4:0] rd,
    output wire [4:0] shamt,
    output wire [5:0] funct,
    output wire [15:0] immediate,
    output wire [25:0] jumpinicial
);

    assign opcode = instrucao[31:26];


    assign rs = (opcode == 6'b000000 || opcode == 6'b000100 || opcode == 6'b000101 || opcode == 6'b100011 || opcode == 6'b101011) ? instrucao[25:21] : 5'b00000;
    assign rt = (opcode == 6'b000000 || opcode == 6'b000100 || opcode == 6'b000101 || opcode == 6'b100011 || opcode == 6'b101011) ? instrucao[20:16] : 5'b00000;
    assign rd = (opcode == 6'b000000) ? instrucao[15:11] : 5'b00000;
    assign shamt = (opcode == 6'b000000) ? instrucao[10:6] : 5'b00000;
    assign funct = (opcode == 6'b000000) ? instrucao[5:0] : 6'b000000;
    assign immediate = (opcode == 6'b001000 || opcode == 6'b001100 || opcode == 6'b100011 || opcode == 6'b101011 || opcode == 6'b000100 || opcode == 6'b000101) ? instrucao[15:0] : 16'b0;
    assign jumpinicial = (opcode == 6'b000010) ? instrucao[25:0] : 26'b0;

endmodule