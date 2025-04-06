module memoria_dados(
    input wire clk,
    input wire [31:0] addr,
    input wire [31:0] WriteData,
    input wire MemWrite,
    output wire [31:0] ReadData
);

    reg [31:0] memoria [255:0];

    // Leitura combinacional
    assign ReadData = memoria[addr[9:2]];

    // Escrita síncrona
    always @(posedge clk) begin
        if (MemWrite) begin
            memoria[addr[9:2]] <= WriteData;
        end
    end

endmodule