# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SRC = MIPS_tb.v  # Inclui o testbench
EXEC = MIPS.vvp
VCD = MIPS_tb.vcd

# Regras
.PHONY: all sim run view clean

# Regra principal
all: clean sim run view

# Compila o testbench e gera o executável da simulação
sim: $(SRC)
	$(IVERILOG) -o $(EXEC) $(SRC)

# Executa a simulação para gerar o arquivo .vcd
run: $(EXEC)
	$(VVP) $(EXEC)

# Abre o GTKWave para visualizar o arquivo .vcd
view: $(VCD)
	$(GTKWAVE) $(VCD) &

# Limpa os arquivos gerados
clean:
	rm -f $(EXEC) $(VCD)
