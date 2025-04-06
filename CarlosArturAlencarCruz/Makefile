# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = processor_tb.v
EXEC = processor.vvp
VCD = processor_sim.vcd

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

# Limpa os arquivos gerados
# Caso esteja usando Windows, troque o comando do 'clean' pelo escrito abaixo:
# 	del $(EXEC) $(VCD) 2> NUL
clean:
	rm -f $(EXEC) $(VCD)
	
