# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = simulacao.v
EXEC = simulacao.vvp
VCD = simulacao.vcd

# Regras
.PHONY: all sim run view clean

# Regra principal
all: clean sim run view

# Compila o testbench e gera o executável da simulação
sim: $(DUT)
	$(IVERILOG) -o $(EXEC) $(DUT)

# Executa a simulação para gerar o arquivo .vcd
#windos:
# run: $(EXEC)
# 	vvp $(EXEC)
#linux:
run: $(EXEC)
	./$(EXEC)

# Abre o GTKWave para visualizar o arquivo .vcd
view: $(VCD)
	$(GTKWAVE) $(VCD)

# Limpa os arquivos gerado
#windows:
# clean:
# 	del /f /q $(EXEC) $(VCD)
#linux
clean:
	rm -f $(EXEC) $(VCD)
