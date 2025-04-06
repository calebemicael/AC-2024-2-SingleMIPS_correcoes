module ALUControl(
    input wire ALUOp1,
    input wire ALUOp0,
    input wire [5:0] instrucao,
    output wire [3:0] operacao          
);

    wire [7:0] auxiliarIn;
    reg [3:0] auxiliarOut;
    assign auxiliarIn[7] = ALUOp1;
    assign auxiliarIn[6] = ALUOp0;
    assign auxiliarIn[5:0] = instrucao [5:0];

    always @(*) begin
        casex (auxiliarIn)
            8'b00??????: auxiliarOut = 4'b0010;
            8'b01??????: auxiliarOut = 4'b0110;
            8'b10??0000: auxiliarOut = 4'b0010;
            8'b1???0010: auxiliarOut = 4'b0110;
            8'b10??0100: auxiliarOut = 4'b0000;
            8'b10??0101: auxiliarOut = 4'b0001;
            8'b1???1010: auxiliarOut = 4'b0111;
            default: auxiliarOut = 4'b0000; // Operação inválida
        endcase
    end

    assign operacao = auxiliarOut;
    
endmodule
