module control_unit (
    input wire [5:0] opCode,
    output reg [1:0] ALUop,
    output reg regDst,
    output reg jump,
    output reg branch,
    output reg memRead,
    output reg memToReg,
    output reg memWrite,
    output reg aluSrc,
    output reg regWrite
);

    always @(*) begin
        case(opCode)
            6'b000000: {regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, ALUop, jump} <= 10'b1001000_10_0;  // Instrução tipo R
            6'b100011: {regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, ALUop, jump} <= 10'b0111100_00_0;  // Instrução tipo lw
            6'b101011: {regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, ALUop, jump} <= 10'b0100010_00_0;  // Instrução tipo sw
            6'b000100: {regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, ALUop, jump} <= 10'b0000001_01_0;  // Instrução tipo beq
            6'b000010: {regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, ALUop, jump} <= 10'b0000000_00_1;  // Instrução tipo jump
            default:   {regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, ALUop, jump} <= 10'b0000000_00_0;  // default
        endcase
    end

endmodule