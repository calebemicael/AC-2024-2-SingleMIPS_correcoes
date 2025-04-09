# Makefile para compilar e simular o projeto MIPS16

# Compilador e simulador
COMPILER = iverilog
SIMULATOR = vvp

# Arquivos Verilog
SRC_FILES = dataMemory.v instr_mem.v mips.v aluControl.v control.v tb_mips16.v

# Nome do executável de simulação
SIM_EXEC = mips16_tb.vvp

# Nome do arquivo de log de simulação
LOG_FILE = mips16_tb.log

# Nome do arquivo de dump de onda
WAVE_FILE = mips16_tb.vcd

# Alvo padrão
all: compile simulate

# Compilar o projeto
compile:
	$(COMPILER) -o $(SIM_EXEC) $(SRC_FILES)

# Simular o projeto
simulate:
	$(SIMULATOR) $(SIM_EXEC) -l$(LOG_FILE)
	gtkwave $(WAVE_FILE) &

# Limpar arquivos gerados
clean:
	rm -f $(SIM_EXEC) $(LOG_FILE) $(WAVE_FILE)

# Alvo para forçar a recompilação
.PHONY: all compile simulate clean