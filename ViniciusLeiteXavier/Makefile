 Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = tb_mips_single_cycle.v
EXEC = $(vvp) tb_mips 
VCD = mips_single_cycle.vcd

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
clean:
        rm -f $(EXEC) $(VCD)
~                                      