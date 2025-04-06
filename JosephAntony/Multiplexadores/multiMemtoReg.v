module multiMemtoReG (ALU_result, MemRead, memtoReg, writeData);
    input [31:0] ALU_result, MemRead;
    input memtoReg;
    output [31:0] writeData;

    assign writeData = memtoReg ? MemRead : ALU_result;

endmodule