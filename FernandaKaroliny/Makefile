# Nome do executável da simulação
EXEC = processador_mips_tb

# Compilador Verilog
IVERILOG = iverilog

# Simulador Verilog
VVP = vvp

# Visualizador de ondas
GTK_WAVE = gtkwave

# Arquivos do processador
SRC = processador_mips.v \
      PC.v \
      memoriaInstrucoes.v \
      unidadeControle.v \
      registradores.v \
      MUX2x1.v \
      ALUControl.v \
      ALU.v \
      dataMemory.v \
      signalExtend.v \
      adder32.v \
      processador_mips_tb.v

# Arquivo de dump de ondas
WAVE_FILE = processador_mips.vcd

# Regra padrão: compilar e rodar a simulação
all: compilar rodar ondas

# Regra para compilar
compilar:
	$(IVERILOG) -o $(EXEC) $(SRC)

# Regra para rodar a simulação
rodar:
	$(VVP) $(EXEC)

# Regra para abrir o GTKWave
ondas:
	$(GTK_WAVE) $(WAVE_FILE) &

# Limpeza dos arquivos gerados
clean:
	rm -f $(EXEC) $(WAVE_FILE)

