module BEQInstruction(
    input wire [15:0] offset,
    input wire [31:0] currentPC,
    input wire branchSignal,
    input wire aluZero,
    output wire [31:0] saida,
    output wire andMux
);

    wire [31:0] extendedOffset;
    wire [31:0] deslocatedOffset;

    // Extende o offset.
    SignalExtend extensao(.in(offset), .out(extendedOffset));

    // Desloca o offset extendido em 2 bits para torná-lo múltiplo de 4.
    ShiftLeft2 deslocamento(.in(extendedOffset), .out(deslocatedOffset));

    // A saída atual será a soma do program counter atual com o offset reajustado.
    Adder32 somador(.a(deslocatedOffset), .b(currentPC), .sum(saida));

    // Habilita o mux para realizar o branch pelo program counter.
    assign andMux = branchSignal & aluZero; // Se ambos forem um, o mux é habilitado e o BEQ reajustará o program counter.

endmodule