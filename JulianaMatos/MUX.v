module MUX(
    //mux1: decide o próximo endereço que o PC vai segurar (incrementado ou resultado do BEQ)
    input wire [31:0] Adder32, //sum (soma dos operandos a e b),
    input wire [31:0] Add4, //out (endereço incrementado),
    input wire seletor1,
    output reg [31:0] mux1, //novo endereço a ser guardado pelo PC
    //mux2
    input wire [4:0] rt,
    input wire [4:0] rd,
    input wire seletor2, 
    output reg [4:0] mux2, //hein
    //mux3
    input wire [31:0] ReadData2, //
    input wire [31:0] SignalExtend, //
    input wire seletor3, 
    output reg [31:0] mux3, //operando B da ALU
    //mux4
    input wire [31:0] readData, //do DataMemory
    input wire [31:0] ALUResult, // do ALU (obvio)
    input wire seletor4,
    output reg [31:0] mux4, // de Registradores
    //mux5: implementa o jump
    input wire [31:0] jump_target,
    input wire seletor5,
    output reg [31:0] mux5 //próximo valor do PC

);

    always @(*) begin
        case (seletor1) //mux1
            1'b0 : mux1 = Add4; //apenas incrementa o PC
            1'b1 : mux1 = Adder32; //novo endereço após beq
            default : mux1 = 32'b0;
        endcase

        case (seletor2) //mux2
            1'b0 : mux2 = rt; //escreve (no registrador) o target
            1'b1 : mux2 = rd; //escreve (no registrador) o destino
            default : mux2 = 5'b0;
        endcase

        case (seletor3) //mux3
            1'b0 : mux3 = ReadData2; //
            1'b1 : mux3 = SignalExtend; //
            default : mux3 = 32'b0;
        endcase

        case (seletor4) //mux4
            1'b0 : mux4 = readData; //
            1'b1 : mux4 = ALUResult; //
            default : mux4 = 32'b0;
        endcase

        case (seletor5) //mux5 : //o PC guarda e aponta ao endereço do jump
            1'b0 : mux5 = mux1; //o jump nao acontece e o branch ou PC+4 segue o fluxo normal
            1'b1 : mux5 = jump_target; //jump até o endereço definido
            default : mux5 = 32'b0;
        endcase
    end
    

endmodule