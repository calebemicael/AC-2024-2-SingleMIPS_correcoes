module ALUControl (
    input wire [1:0] ALUOp,      // Reebido da unidade de controle
    input wire [5:0] funct,     // funct field
    output reg [3:0] ALUContro1 // saída pra ALU
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUContro1 = 4'b0010; // lw/sw: add
        2'b01: ALUContro1 = 4'b0110; // beq: sub
        2'b10: begin
            case (funct)
                6'b100000: ALUContro1 = 4'b0010; // add
                6'b100010: ALUContro1 = 4'b0110; // sub
                6'b100100: ALUContro1 = 4'b0000; // and
                6'b100101: ALUContro1 = 4'b0001; // or
                6'b101010: ALUContro1 = 4'b0111; // slt
                default:   ALUContro1 = 4'b0000; // default to and
            endcase
        end
        default: ALUContro1 = 4'b0000; // default to and
    endcase
end

endmodule