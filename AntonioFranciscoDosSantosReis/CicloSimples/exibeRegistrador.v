module Display4Digitos2(
    input wire clk,               // Clock do sistema
    input wire [31:0] reg_data,   // Dados do registrador de 32 bits
    output reg [6:0] display1,    // Segmentos do 1º display
    output reg [6:0] display2,    // Segmentos do 2º display
    output reg [6:0] display3,    // Segmentos do 3º display
    output reg [6:0] display4     // Segmentos do 4º display
);

    
    reg [3:0] unidade; 
    reg [3:0] dezena;
    reg [3:0] centena;
    
    always @(posedge clk) begin
        unidade <= reg_data % 10;
        dezena <= (reg_data / 10) % 10;
        centena <= (reg_data / 100) % 10;


        case (unidade)
            4'h0: display1 = 7'b100_0000; // 0
            4'h1: display1 = 7'b111_1001; // 1
            4'h2: display1 = 7'b010_0100; // 2
            4'h3: display1 = 7'b011_0000; // 3
            4'h4: display1 = 7'b001_1001; // 4
            4'h5: display1 = 7'b001_0010; // 5
            4'h6: display1 = 7'b000_0010; // 6
            4'h7: display1 = 7'b111_1000; // 7
            4'h8: display1 = 7'b000_0000; // 8
            4'h9: display1 = 7'b001_0000; // 9
            4'hA: display1 = 7'b000_1000; // A
            4'hB: display1 = 7'b000_0011; // b
            4'hC: display1 = 7'b100_0110; // C
            4'hD: display1 = 7'b010_0001; // d
            4'hE: display1 = 7'b000_0110; // E
            4'hF: display1 = 7'b000_1110; // F
            default: display1 = 7'b111_1111; // Apaga tudo
        endcase

        // Display 1
        case (dezena)
            4'h0: display2 = 7'b100_0000; // 0
            4'h1: display2 = 7'b111_1001; // 1
            4'h2: display2 = 7'b010_0100; // 2
            4'h3: display2 = 7'b011_0000; // 3
            4'h4: display2 = 7'b001_1001; // 4
            4'h5: display2 = 7'b001_0010; // 5
            4'h6: display2 = 7'b000_0010; // 6
            4'h7: display2 = 7'b111_1000; // 7
            4'h8: display2 = 7'b000_0000; // 8
            4'h9: display2 = 7'b001_0000; // 9
            4'hA: display2 = 7'b000_1000; // A
            4'hB: display2 = 7'b000_0011; // b
            4'hC: display2 = 7'b100_0110; // C
            4'hD: display2 = 7'b010_0001; // d
            4'hE: display2 = 7'b000_0110; // E
            4'hF: display2 = 7'b000_1110; // F
            default: display2 = 7'b111_1111; // Apaga tudo
        endcase

        // Display 2
        case (centena)
            4'h0: display3 = 7'b100_0000; // 0
            4'h1: display3 = 7'b111_1001; // 1
            4'h2: display3 = 7'b010_0100; // 2
            4'h3: display3 = 7'b011_0000; // 3
            4'h4: display3 = 7'b001_1001; // 4
            4'h5: display3 = 7'b001_0010; // 5
            4'h6: display3 = 7'b000_0010; // 6
            4'h7: display3 = 7'b111_1000; // 7
            4'h8: display3 = 7'b000_0000; // 8
            4'h9: display3 = 7'b001_0000; // 9
            4'hA: display3 = 7'b000_1000; // A
            4'hB: display3 = 7'b000_0011; // b
            4'hC: display3 = 7'b100_0110; // C
            4'hD: display3 = 7'b010_0001; // d
            4'hE: display3 = 7'b000_0110; // E
            4'hF: display3 = 7'b000_1110; // F
            default: display3 = 7'b111_1111; // Apaga tudo
        endcase

        
        
        display4 = 7'b111_1111; // Apaga tudo
        
    end

endmodule