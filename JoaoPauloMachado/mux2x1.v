module mux2x1(
        input [31:0] ALUResult,
        input [31:0] dataMemory,
        input wire MemToReg,
        output [31:0] out 
    );

        assign out = (MemToReg) ? dataMemory : ALUResult;

endmodule