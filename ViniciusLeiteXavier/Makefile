# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = tb_mips_single_cycle.v
OUT = simv
VCD = mips_single_cycle_tb.vcd

# Regras
.PHONY: all sim run view clean

# Regra principal
all: clean sim run view

# Compila o testbench e gera o executável da simulação
sim: $(DUT)
	$(IVERILOG) -o $(OUT) $(DUT)

# Executa a simulação para gerar o arquivo .vcd
run: $(OUT)
	./$(OUT)

# Abre o GTKWave para visualizar o arquivo .vcd
view: $(VCD)
	$(GTKWAVE) $(VCD)

# Limpa os arquivos gerados
clean:
	rm -f $(OUT) $(VCD)
