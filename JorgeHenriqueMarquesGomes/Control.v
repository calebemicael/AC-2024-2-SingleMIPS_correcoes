module Control(
    input wire [5:0] OPcode, 
    output reg [1:0] ALUop,  
    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch, 
    output reg jump
);
    //define as saidas
    always @(*) begin
        case (OPcode)
            6'b000000:  RegDst = 1'b1;
            6'b001001:  RegDst = 1'b0;
            6'b001000:  RegDst = 1'b0;
            6'b100011:  RegDst = 1'b0;
            6'b101011:  RegDst = 1'b0;
            6'b000100:  RegDst = 1'b0;
            default:  RegDst = 1'b0;      
        endcase
    end

    always @(*) begin
        case (OPcode)
            6'b000000:  ALUSrc = 1'b0;
            6'b001001:  ALUSrc = 1'b1;
            6'b001000:  ALUSrc = 1'b1;
            6'b100011:  ALUSrc = 1'b1;
            6'b101011:  ALUSrc = 1'b1;
            6'b000100:  ALUSrc = 1'b0;  
            default:  ALUSrc = 1'b0;      
        endcase
    end
    always @(*) begin
        case (OPcode)
            6'b000000:  MemtoReg = 1'b0;
            6'b001001:  MemtoReg = 1'b0;
            6'b001000:  MemtoReg = 1'b0;
            6'b100011:  MemtoReg = 1'b1;
            6'b101011:  MemtoReg = 1'b0;
            6'b000100:  MemtoReg = 1'b0;  
            default:  MemtoReg = 1'b0;
        endcase
    end

    always @(*) begin
        case (OPcode)
            6'b000000:  RegWrite = 1'b1;
            6'b001001:  RegWrite = 1'b1;
            6'b001000:  RegWrite = 1'b1;
            6'b100011:  RegWrite = 1'b1;
            6'b101011:  RegWrite = 1'b0;    
            6'b000100:  RegWrite = 1'b0;  
            default:  RegWrite = 1'b0;
        endcase
    end

    always @(*) begin
        case (OPcode)
            6'b000000:  MemRead = 1'b0;
            6'b001001:  MemRead = 1'b0;
            6'b001000:  MemRead = 1'b0;
            6'b100011:  MemRead = 1'b1;
            6'b101011:  MemRead = 1'b0;    
            6'b000100:  MemRead = 1'b0;  
            default:  MemRead = 1'b0;
        endcase
    end

    always @(*) begin
        case (OPcode)
            6'b000000:  MemWrite = 1'b0;
            6'b001001:  MemWrite = 1'b0;
            6'b001000:  MemWrite = 1'b0;
            6'b100011:  MemWrite = 1'b0;
            6'b101011:  MemWrite = 1'b1;    
            6'b000100:  MemWrite = 1'b0;  
            default:  MemWrite = 1'b0;       
        endcase
    end

    always @(*) begin
        case (OPcode)
            6'b000000:  Branch = 1'b0;
            6'b001001:  Branch = 1'b0;
            6'b001000:  Branch = 1'b0;
            6'b100011:  Branch = 1'b0;
            6'b101011:  Branch = 1'b0;    
            6'b000100:  Branch = 1'b1;  
            default:  Branch = 1'b0;      
        endcase
    end

    always @(*) begin
        case (OPcode)
            6'b000000:  ALUop = 2'b10;
            6'b001001:  ALUop = 2'b00;
            6'b001000:  ALUop = 2'b00;
            6'b100011:  ALUop = 2'b00;
            6'b101011:  ALUop = 2'b00;    
            6'b000100:  ALUop = 2'b01;  
            default:  ALUop = 2'b00;        
        endcase
    end

    always @(*) begin
        case (OPcode)
            6'b000010:  jump = 1'b1;  
            default:  jump = 1'b0;        
        endcase
    end    

endmodule