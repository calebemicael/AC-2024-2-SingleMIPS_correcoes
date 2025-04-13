module fetch (
    input clock, 
    input reset, 
    input branch, 
    input [31:0] addr_extended,
    output [31:0] inst
);

reg [31:0] pc;

wire [31:0] pc_summed4;
wire [31:0] pc_summed32;
wire [31:0] inst_added;

// Instanciamento dos módulos
sum4b somador(
    .entrada(pc),         
    .saida(pc_summed4)
);

sum32b somador32 (
    .a(pc_summed32),
    .b(addr_extended),
    .res(inst_added)
);

mux32b m32(
    .a(pc_summed4),
    .b(inst_added),
    .select(branch),
    .saida(pc_summed32)
);

inst_memory memoria(
    .addr(pc),        
    .inst(inst)
);

always @(posedge clock or posedge reset) begin
    if (reset) begin 
        pc <= 32'b0;  // Inicia o PC com 0 no reset
    end else begin
        pc <= pc_summed32;  // Atualiza o PC com o endereço somado
    end
end

endmodule
