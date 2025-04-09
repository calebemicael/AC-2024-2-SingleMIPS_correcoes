# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
EXEC = sim
VCD = processor_cycle.vcd

# Arquivo principal do projeto
DUT = MIPSProcessor.v

# Lista de arquivos Verilog (módulos + testbench)
SRC_FILES = Add4.v FetchUnit.v MemoriaDeInstrucoes.v SignalExtend.v \
            mux2x1_1.v mux2x1_2.v mux2x1.v ALU.v ShiftLeft2.v \
            DataMemory.v Registradores.v ControlUnit.v aluControl.v \
            MIPSProcessor.v test_MIPSProcessor.v

# Regras
.PHONY: all sim run view clean

# Regra principal
all: clean sim run view

# Compila o testbench e gera o executável da simulação
sim: $(SRC_FILES)
	$(IVERILOG) -o $(EXEC) $(SRC_FILES)

# Executa a simulação para gerar o arquivo .vcd
run: $(EXEC)
	$(VVP) $(EXEC)

# Abre o GTKWave para visualizar o arquivo .vcd
view: $(VCD)
	$(GTKWAVE) $(VCD) &

# Limpa os arquivos gerados
clean:
	rm -f $(EXEC) $(VCD)
