`timescale 1ns/1ps

module testbenchControle;
    reg [5:0] opcode;
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [1:0] ALUOp;

    controle uut(
        .opcode(opcode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    initial begin
    $dumpfile("controle.vcd");
    $dumpvars(0, testbenchControle, opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);

    $monitor("opcode: %b | RegDst: %b | ALUSrc: %b | MemtoReg: %b | RegWrite: %b | MemRead: %b | MemWrite: %b | Branch: %b | ALUOp: %b", opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);

    opcode = 6'b000000; #10; // R-type
        opcode = 6'b100011; #10; // lw
        opcode = 6'b101011; #10; // sw
        opcode = 6'b000100; #10; // beq
        opcode = 6'b111111; #10; // Instrução inválida


        #10;
        $finish;
    end
endmodule