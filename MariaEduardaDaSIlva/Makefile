# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = Simulacao.v
EXEC = Simulacao.vvp 
VCD = processador.vcd

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
	$(GTKWAVE) $(VCD)
#windows: 
clean:
	rm -rf $(EXEC) $(VCD)
# Limpa os arquivos gerados
# linux
#clean:
#	rm -f $(EXEC) $(VCD)
