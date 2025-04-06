module mux32b (saida, a, b, select);
output reg saida;
input [31:0] a, b;
input select;

always @(*) begin 
    case(select)
        1'd0: saida = a;
        1'd1: saida = b;
    endcase
end
endmodule

module mux5b(saida, a ,b, select);
output reg saida;
input [4:0] a, b;
input select;

    always @ (*) begin
        case (select)
        1'd0: saida = a;
        1'd1: saida =b;
        endcase
    end
endmodule