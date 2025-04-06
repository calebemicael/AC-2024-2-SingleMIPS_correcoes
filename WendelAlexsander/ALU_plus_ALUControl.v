`include "ALU.v"
`include "ALUControl.v"
module ALU_plus_ALUControl(
 
    input wire [31:0] A,           // Operando 1   
    input wire [31:0] B,           // Operando 2
    input wire [1:0] ALUOp,      // From Main Control Unit
    input wire [5:0] funct,
    output reg [31:0] ALUResult,   // Resultado da ALU
    output wire Zero);      // From instruction (funct field))

    wire [3:0] ALUControl_to_Aluop;

    AlUControl alu_control_inst(
        .ALUOp(ALUOp),
        .funct(funct)
    );

    ALUControl_to_Aluop.(ALUControl_to_Aluop);


    ALU alu_inst(
        .A(A)
        .B(B)
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    .ALUControl_to_Aluop(ALUOperation);



    endmodule