module ALU_control(ALUop, funct, ALUControl);
    input [1:0] ALUop;
    input [5:0] funct;
    output reg [2:0] ALUControl;

    always@(*) begin
        case (ALUop)
            2'b00: ALUControl = 3'b010; 
            2'b01: begin if(funct == 6'b001000) ALUControl = 3'b011; else ALUControl = 3'b110; end
            2'b10: begin
                
                case (funct)
                    6'b100000: ALUControl = 3'b010; // ADD
                    6'b100010: ALUControl = 3'b110; // SUB
                    6'b100100: ALUControl = 3'b000; // AND
                    6'b100101: ALUControl = 3'b001; // OR
                    6'b101010: ALUControl = 3'b111; // SLT
                    default:   ALUControl = 3'bxxx; // Undefined
                endcase
            end
            default: ALUControl = 3'bxxx; 
        endcase
    end
endmodule