
`include "instruction_memory.v"
`include "PC_module.v"

module fetch_cycle(clk, reset, PcSrcE, instructionD, PcPlus4D, PcBranchD, enable);
    input clk, reset, enable;
    input PcSrcE;
    input [31:0] PcBranchD;
    output [31:0] instructionD;
    output [31:0] PcPlus4D;
    
    //declare wires internos do fetch

    wire [31:0] PC_, PCF, PcPlus4F;
    wire [31:0] instF;

    reg [31:0] instF_Reg;
    reg [31:0] PcPlus4F_reg;

    //DECLARANDO O MUX DESCRITO NO DATAPATH

    mux_fetch m1(.a(PcPlus4F), 
                 .b(PcBranchD), 
                 .s(PcSrcE), 
                 .c(PC_)
                 );



    // MODULO PARA DESCREVER O CONTADOR DE PROGRAMA
    pc_counter Program_counter(.clk(clk),
                              .reset(reset),
                              .pc_in(PC_),
                              .pc_out(PCF),
                              .enable(enable)
                            );


    // MODULO PARA DESCREVER A MEMÓRIA DE INSTRUÇÃO

    instruction_memory Imem(.clk(clk),
                            .reset(reset), 
                            .read_address(PCF),
                            .instruction_out(instF)
                            );

    // MODULO PARA DESCREVER O SOMADOR

    PC_PLUS4 pcplus4(.pc_out(PCF),
                     .pc_outplus(PcPlus4F)
                     );



    //Fetch cycle lógic

    // troquei o original negedge reset por posedge reset pra ver. se der algum erro voltar      
    always@(posedge clk or posedge reset)begin
        if(reset)begin
            instF_Reg <= 32'b0;
            PcPlus4F_reg <= 32'b0;
        end
        else if(clr)begin
            instF_Reg <= 32'b0;
            PcPlus4F_reg <= 32'b0;
        end
        else if(~enable)begin
             instF_Reg <= instF;
             PcPlus4F_reg <= PcPlus4F;
        end
    end


    assign instructionD = (reset) ? 32'b0: instF_Reg;
    assign PcPlus4D = (reset) ? 32'b0: PcPlus4F;
    

endmodule