`include "ALU.v"
`include "Registradores.v"
`include "SignalExtend.v"
`include "DataMemory.v"
`include "FetchUnit.v"
`include "ShiftLeft.v"
`include "MuxGeneral.v"
`include "ControlUnit.v"
`include "ALUControl.v"
`include "Adder32.v"
`include "Mux32_bits.v"
`include "Mux5_bits.v"

module MIPS(
  input wire clk,
  input wire reset
);

  wire [31:0] instrucao, pcIncrementado, newPcAdrs, beqAdrs, branchAddress;
  wire [31:0] ReadData1, ReadData2, signExtendedOffset, EntradaALU, ResultadoALU;
  wire [31:0] memoryRead, WriteData, shiftedOffset;
  wire [27:0] JumpshiftedOffset;
  wire [9:0] ctrl_signals;
  wire [4:0] WriteRegister;
  wire [3:0] Operation; 
  wire zero;

  FetchUnit unidade_fetch(
    .clk(clk),
    .reset(reset),
    .pcSet(newPcAdrs),
    .instrucao(instrucao),
    .pc_incrementado(pcIncrementado)
  );

  ControlUnit unidade_controle (
    .OpCode(instrucao[31:26]),
    .ControlSignals(ctrl_signals)
  );

  Registradores unidade_registradores (
    .ReadRegister1(instrucao[25:21]),
    .ReadRegister2(instrucao[20:16]),
    .WriteRegister(WriteRegister),
    .WriteData(WriteData), 
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .RegWrite(ctrl_signals[5])
  );

  SignExtend signExtend (
    .in(instrucao[15:0]),
    .out(signExtendedOffset)
  );

  ALUControl controle_alu (
    .Instruction(instrucao[5:0]),
    .AluOp(ctrl_signals[1:0]),
    .Operation(Operation)
  );

  ALU alu (
    .A(ReadData1),
    .B(EntradaALU),
    .ALUOperation(Operation), 
    .ALUResult(ResultadoALU),
    .Zero(zero)
  );

  DataMemory datamemory (
    .clk(clk),
    .MemRead(ctrl_signals[4]),
    .MemWrite(ctrl_signals[3]),
    .address(ResultadoALU),
    .writeData(ReadData2),
    .readData(memoryRead)
  );

  ShiftLeft shiftLeft_beq (
    .in(signExtendedOffset),
    .out(shiftedOffset)
  );

  Adder32 add_beq(
    .a(pcIncrementado),
    .b(shiftedOffset),
    .sum(branchAddress)
  );

  Mux5_bits M_RegDst(
    .true(instrucao[15:11]),
    .false(instrucao[20:16]),
    .sel(ctrl_signals[8]),
    .o_output(WriteRegister)
  );
  
  Mux32_bits M_beq(
    .true(branchAddress),
    .false(pcIncrementado),
    .sel((ctrl_signals[2] & zero)),
    .o_output(beqAdrs)
  );

  Mux32_bits M_dataMemory(
    .true(memoryRead),
    .false(ResultadoALU),
    .sel(ctrl_signals[6]),
    .o_output(WriteData)
  );

  
  Mux32_bits M_Alu(
    .true(signExtendedOffset),
    .false(ReadData2),
    .sel(ctrl_signals[7]),
    .o_output(EntradaALU)
  );

  Mux32_bits M_jump(
    .true({pcIncrementado[31:28], JumpshiftedOffset}),
    .false(beqAdrs),
    .sel(ctrl_signals[9]),
    .o_output(newPcAdrs)
  );

  
  // MuxGeneral  Mux_Alu (
  //   .Entradas({signExtendedOffset, ReadData2}),
  //   .selector(ctrl_signals[7]),
  //   .Saida(EntradaALU)
  // );

  //
  // MuxGeneral #(.DATA_WIDTH(5)) Mux_RegDst (
  //   .Entradas({instrucao[15:11], instrucao[20:16]}),
  //   .selector(ctrl_signals[8]),
  //   .Saida(WriteRegister)
  // );

  // MuxGeneral  Mux_dataMemory (
  //   .Entradas({memoryRead, ResultadoALU}),
  //   .selector(ctrl_signals[6]),
  //   .Saida(WriteData)
  // );

  // MuxGeneral Mux_beq (
  //   .Entradas({branchAddress, pcIncrementado}),
  //   .selector(ctrl_signals[2] & zero),
  //   .Saida(beqAdrs)
  // );

  ShiftLeft #(
    .DATA_IN(26),
    .DATA_SHIFT(28)) shiftLeft_jump (
    .in(instrucao[25:0]),
    .out(JumpshiftedOffset)
  );

  MuxGeneral Mux_jump (
    .Entradas({{pcIncrementado[31:28], JumpshiftedOffset}, beqAdrs}),
    .selector(ctrl_signals[9]),
    .Saida(newPcAdrs)
  );

endmodule


  // wire [31:0] instrucao;             instrução recebida do banco de instruções 
  // wire [31:0] pcIncrementado;        Recebe o valor do pc pcIncrementado
  // wire [31:0] newPcAdrs;             Recebe o valor do endereço final beq ou j
  // wire [31:0] beqAdrs;               Recebe o valor do novo endereço beq
  // wire [9:0] ctrl_signals;           Resultado da unidade de controle
  // wire [4:0] WriteRegister;          Valor que deve ser escrito de volta nos Registradores
  // wire [31:0] ReadData1;             Valor lido dos Registradores (A)
  // wire [31:0] ReadData2;             Valor lido dos Registradores (B)
  // wire [31:0] signExtendedOffset;    Valor extendido para instruções de beq e j
  // wire [3:0] Operation;              Código da operação retornada pelo controle_alu
  // wire [31:0] EntradaALU;            Valor escolhido no mux da alu
  // wire [31:0] ResultadoALU;          Valor resultante da alu
  // wire zero;                         flag nula da alu
  // wire [31:0] memoryRead;            Valor lido da memória
  // wire [31:0] WriteData;             Valor valor escolhido no mux do datamemory
  // wire [31:0] shiftedOffset;         Valor que entra no ADD do PC
  // wire [31:0] branchAddress;         Valor que sai no ADD do PC
  // wire [27:0] JumpshiftedOffset;     Valor com shift do endereço da instrucao j
