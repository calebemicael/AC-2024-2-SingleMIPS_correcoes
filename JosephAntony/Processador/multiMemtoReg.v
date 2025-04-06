module multiMemtoReg (ALU_result, readData, memtoReg, writeData);
    input [31:0] ALU_result, readData;
    input memtoReg;
    output [31:0] writeData;

    assign writeData = memtoReg ? readData : ALU_result;

endmodule
