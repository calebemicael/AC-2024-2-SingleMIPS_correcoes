module registradores (
    input clk,
    input [4:0] v1_loc,
    input [4:0] v2_loc,
    input [31:0] v_write_res,
    input [4:0] r_write_res,
    input signal,
    output [31:0] get_reg1,
    output [31:0] get_reg2
);
    reg [31:0] registers [0:31];

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) registers[i] = 32'b0; // 0
    end

    assign get_reg1 = (v1_loc != 0) ? registers[v1_loc] : 0;
    assign get_reg2 = (v2_loc != 0) ? registers[v2_loc] : 0;

    always @(posedge clk) begin
        if (signal && r_write_res != 0) begin
            registers[r_write_res] <= v_write_res;
            $display("Registrador %0d atualizado para %d", r_write_res, v_write_res); 
        end
    end
endmodule