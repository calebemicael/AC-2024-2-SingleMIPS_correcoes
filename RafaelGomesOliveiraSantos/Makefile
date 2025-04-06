# Compiler
IVERILOG = iverilog

# Source files
SRC = $(shell find . -name "*.v")

# Output executable (dentro da pasta ./Modulos de Testbench e GTKWAVE)
OUT = ./Modulos de Testbench e GTKWAVE/sim.vvp

# Default rule: compila o simulador
all: $(OUT)

$(OUT): $(SRC)
	@mkdir -p ./Modulos_de_Testbench_GTKWAVE
	$(IVERILOG) -o $(OUT) $(SRC)

# Regra para executar a simulação e abrir o GTKWave com o arquivo de configuração
run: $(OUT)
	vvp $(OUT)
	gtkwave processador.vcd./Modulos_de _Testbench_e_GTKWAVE/GTK_MODIFICADO.gtkw

# Limpeza dos arquivos gerados
clean:
	rm -f $(OUT) *.vcd

.PHONY: all run clean