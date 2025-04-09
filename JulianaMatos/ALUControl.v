module ALUControl(
    input wire [5:0] funct, 
    input wire [1:0] ALUOp,
    output reg [3:0] ALUControlSignal
);


    always @(*) begin
            case (ALUOp)
                2'b00: ALUControlSignal = 4'b0010; // lw/sw → Add
                2'b01: ALUControlSignal = 4'b0110; // beq → Subtract
                2'b10: begin // R-type, determine based on funct
                    case (funct)
                        6'b100000: ALUControlSignal = 4'b0010; // add
                        6'b100010: ALUControlSignal = 4'b0110; // sub
                        6'b100100: ALUControlSignal = 4'b0000; // and
                        6'b100101: ALUControlSignal = 4'b0001; // or
                        6'b101010: ALUControlSignal = 4'b0111; // slt
                        default:   ALUControlSignal = 4'bxxxx; 
                    endcase
                end
                default: ALUControlSignal = 4'bxxxx; 
            endcase
        end

endmodule