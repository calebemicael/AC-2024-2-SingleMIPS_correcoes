IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = simulation.v
EXEC = sim.vvp
VCD = MIPS.vcd
CONFIG = gtkconfig.gtkw

# Regras
.PHONY: all sim run view clean

# Regra principal
all: clean sim run view

# Compila o testbench e gera o executável da simulação
sim: $(DUT)
	$(IVERILOG) -o $(EXEC) $(DUT)

# Executa a simulação para gerar o arquivo .vcd
run: $(EXEC)
	./$(EXEC)

# Abre o GTKWave para visualizar o arquivo .vcd
view: $(VCD)
	$(GTKWAVE) $(VCD) -a $(CONFIG)

# Limpa os arquivos gerados
clean:
	rm -f $(EXEC) $(VCD)