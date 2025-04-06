// Banco de Registradores
module register_file(
    input clk,                  
    input reg_write,             
    input [4:0] read_reg1,     
    input [4:0] read_reg2,       
    input [4:0] write_reg,      
    input [31:0] write_data,     
    output [31:0] read_data1,   
    output [31:0] read_data2   
);
    reg [31:0] reg_file [31:0];  // Banco de registradores com 32 registradores de 32 bits

    integer r;
    initial begin
        for (r = 0; r < 32; r = r + 1) reg_file[r] = 0;
    end

    // Leitura dos registradores
    assign read_data1 = reg_file[read_reg1];
    assign read_data2 = reg_file[read_reg2];

    // Escrita no registrador (sincronizada com o clock)
    always @(posedge clk) begin
        if (reg_write && write_reg != 5'b0) reg_file[write_reg] <= write_data;
    end
endmodule