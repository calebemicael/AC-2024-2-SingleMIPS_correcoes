`include "ALU.v"
`include "DataMemory.v"
`include "ALUControl.v"
`include "MemoriaDeInstrucoes.v"
`include "Registradores.v"
`include "control.v"

module mips_32(
    input clk, reset,
    output [31:0] pc_out, alu_result
);
    reg [31:0] pc_current;  // Registrador para armazenar o valor do PC
    wire [31:0] pc_next, pc_plus_4;  
    wire [31:0] instr;  // Instrução de 32 bits
    wire [1:0] reg_dst, mem_to_reg; 
    wire [1:0] alu_op;  
    wire jump, branch, mem_read, mem_write, alu_src, reg_write;  
    wire [4:0] reg_write_dest;  
    wire [31:0] reg_write_data;  
    wire [4:0] reg_read_addr_1;  
    wire [31:0] reg_read_data_1;  
    wire [4:0] reg_read_addr_2;  
    wire [31:0] reg_read_data_2;  
    wire [31:0] sign_ext_im, read_data2, zero_ext_im, imm_ext;  
    wire JRControl;  
    wire [3:0] ALU_Control;  
    wire [31:0] ALU_out;  
    wire zero_flag;  
    wire [31:0] im_shift_1, PC_j, PC_beq, PC_jr;  
    wire [25:0] jump_shift_1;  
    wire [31:0] mem_read_data;  
    wire sign_or_zero;  

    // PC: Contador de programa
    always @(posedge clk or posedge reset) begin   
        if (reset)   
            pc_current <= 32'd0;  // Inicializa o PC com 0 no reset
        else  
            pc_current <= pc_next;  // Atualiza o PC com o próximo valor
    end  

    // PC + 4
    assign pc_plus_4 = pc_current + 32'd4;  

    // Memória de Instruções
    MemoriaDeInstrucoes instrucion_memory(
        .addr(pc_current),    // Endereço do contador de programa
        .instrucao(instr)     // A instrução lida da memória
    );  

    // Cálculo do Jump Shift
    assign jump_shift_1 = {instr[25:0], 2'b00};  

    // Unidade de controle
    control control_unit(
        .opcode(instr[31:26]), 
        .reset(reset), 
        .reg_dst(reg_dst),  
        .mem_to_reg(mem_to_reg), 
        .alu_op(alu_op), 
        .jump(jump),  
        .branch(branch), 
        .mem_read(mem_read),  
        .mem_write(mem_write),  
        .alu_src(alu_src),  
        .reg_write(reg_write),  
        .sign_or_zero(sign_or_zero)  // Seleção de sinal ou zero para extensão de imediato
    );  

    // Multiplexador para reg_dst
    assign reg_write_dest = (reg_dst == 2'b10) ? 5'b11111 :  // JAL
                            (reg_dst == 2'b01) ? instr[15:11] :  // R-type
                            instr[20:16];  // I-type  

    // Registradores
    assign reg_read_addr_1 = instr[25:21];  
    assign reg_read_addr_2 = instr[20:16];  
    Registradores reg_file(
        .RegWrite(reg_write),  
        .WriteRegister(reg_write_dest), 
        .WriteData(reg_write_data),  
        .ReadRegister1(reg_read_addr_1), 
        .ReadData1(reg_read_data_1),  
        .ReadRegister2(reg_read_addr_2), 
        .ReadData2(reg_read_data_2)  
    );  

    // Extensão de Imediato (Sign/Zero Extension)
    assign sign_ext_im = {{16{instr[15]}}, instr[15:0]};  
    assign zero_ext_im = {16'b0, instr[15:0]};  
    assign imm_ext = (sign_or_zero == 1'b1) ? sign_ext_im : zero_ext_im;  

    // Controle para JR
    assign JRControl = (instr[5:0] == 6'b001000);  

    // Controle da ALU
    ALUControl ALU_Control_unit(
        .ALUOp(alu_op), 
        .Func(instr[5:0]), 
        .ALU_Control(ALU_Control)
    );  

    // Multiplexador para ALU Src
    assign read_data2 = (alu_src == 1'b1) ? imm_ext : reg_read_data_2;  

    // Unidade ALU
    ALU alu_unit(
        .A(reg_read_data_1), 
        .B(read_data2), 
        .ALU_Control(ALU_Control),  
        .Result(ALU_out), 
        .Zero(zero_flag)
    );  

    // Shift de imediato
    assign im_shift_1 = {imm_ext[29:0], 2'b00};  

    // Cálculo do próximo PC
    assign PC_beq = pc_plus_4 + im_shift_1;  // Branch target
    assign PC_j = {pc_plus_4[31:28], jump_shift_1};  // Jump target
    assign PC_jr = reg_read_data_1;  // JR target

    // Determinação do próximo PC com base em branch, jump ou JR
    assign pc_next = (JRControl) ? PC_jr :  // JR
                     (branch & zero_flag) ? PC_beq :  // Branch
                     (jump) ? PC_j :  // Jump
                     pc_plus_4;  // PC + 4

    // Instância da memória de dados
    DataMemory data_mem (
        .clk(clk),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .address(ALU_out),  // Endereço da memória é a saída da ALU
        .writeData(reg_read_data_2),  
        .readData(mem_read_data)      
    );  

    // Multiplexador para mem_to_reg
    assign reg_write_data = (mem_to_reg == 2'b01) ? mem_read_data :  // LW
                            (mem_to_reg == 2'b10) ? pc_plus_4 :  // JAL
                            ALU_out;  // R-type ou I-type

    // Saídas
    assign pc_out = pc_current;
    assign alu_result = ALU_out;

endmodule
