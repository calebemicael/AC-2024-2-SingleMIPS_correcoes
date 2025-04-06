module ControlUnit(
    input wire [5:0] opCode,
    output reg regDst,
    output reg jump,
    output reg branch,
    output reg memRead,
    output reg memToReg,
    output reg [1:0] ALUop,
    output reg memWrite,
    output reg ALUsource,
    output reg regWrite
);

    always@(*) begin
        casez (opCode)
            6'b000000 : begin //R type
                regDst = 1'b1; 
                ALUsource = 1'b0;
                memToReg =  1'b0;
                regWrite = 1'b1;
                memRead = 1'b0;
                memWrite = 1'b0;
                branch = 1'b0;
                ALUop = 2'b10;
                jump = 1'b0;
            end
            6'b100011 : begin //LW
                regDst = 1'b0; 
                ALUsource = 1'b1;
                memToReg =  1'b1;
                regWrite = 1'b1;
                memRead = 1'b1;
                memWrite = 1'b0;
                branch = 1'b0;
                ALUop = 2'b00;
                jump = 1'b0;
            end
            6'b101011 : begin //SW
                regDst = 1'b0; 
                ALUsource = 1'b1;
                memToReg =  1'b0;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b1;
                branch = 1'b0;
                ALUop = 2'b00;
                jump = 1'b0;
            end
            6'b000100 : begin //beq
                regDst = 1'b0;
                ALUsource = 1'b0;
                memToReg =  1'b0;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                branch = 1'b1;
                ALUop = 2'b01;
                jump = 1'b0;
            end
            6'b001000 : begin //addi
                regDst = 1'b0;
                ALUsource = 1'b1;
                memToReg =  1'b0;
                regWrite = 1'b1;
                memRead = 1'b0;
                memWrite = 1'b0;
                branch = 1'b0;
                ALUop = 2'b00;
                jump = 1'b0;
            end
            6'b000010 : begin //jump
                regDst = 1'b0;
                ALUsource = 1'b0;
                memToReg =  1'b0;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                branch = 1'b0;
                ALUop = 2'b00;
                jump = 1'b1;
            end
        endcase
    end
endmodule