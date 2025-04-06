module simulacao; 

    reg clk;
    reg reset;
    wire [31:0] pc_out;
    wire [31:0] instrucao;
    wire [31:0] t0, t1, t2, t3; // Sinais para os registradores $t0, $t1, $t2, $t3
    wire [31:0] mem_data_0, mem_data_4; // Sinais para os dados da memória nos endereços 0 e 4

    reg [31:0] stored_pc;
    reg [31:0] stored_instrucao;

    mips mips_core (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .instrucao_out(instrucao)
    );

    // Acessando os registradores
    assign t0 = mips_core.regs.registers[8];  // $t0
    assign t1 = mips_core.regs.registers[9];  // $t1
    assign t2 = mips_core.regs.registers[10]; // $t2
    assign t3 = mips_core.regs.registers[11]; // $t3

    // Acessando a memória
    assign mem_data_0 = mips_core.data_mem.memory[0]; // Dado no endereço 0
    assign mem_data_4 = mips_core.data_mem.memory[1]; // Dado no endereço 4 (1 palavra = 4 bytes)

    initial begin
        clk = 0;
        reset = 1;
        #22;
        reset = 0;
    end

    always #10 clk = ~clk;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, simulacao);
        #1000 $finish;  
    end

    
    always @(negedge clk) begin
        stored_pc <= pc_out;
        stored_instrucao <= instrucao;
    end

    
    always @(posedge clk) begin // borda de descida se nao so carrega apos a instrucao /corrgir
        #5; 
        $display("Time = %t | PC = %h | Instrucao = %h", 
                 $time, stored_pc, stored_instrucao);
        $display("$t0 = %h | $t1 = %h | $t2 = %h | $t3 = %h", t0, t1, t2, t3);
        $display("Mem[0] = %h | Mem[4] = %h", mem_data_0, mem_data_4);
    end
endmodule