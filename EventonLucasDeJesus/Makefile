# Variáveis
TB = mips_tb
SIM = mips_simulation
WAVE = $(TB).vcd
SRC = SignExtend.v ShiftLeft2.v RegisterFile.v PC.v PC_MUX.v Mux2to1.v \
      Mux2to1_5bit.v ALU.v ALUControl.v Adder.v DataMemory.v \
      InstructionMemory.v ControlUnit.v MIPS_Datapath.v $(TB).v
IVERILOG = iverilog
VVPP = vvp
GTKWAVE = gtkwave

# Regras
.PHONY: all sim run view clean

# Regra principal
all: compile simulate view

# Compila o testbench e gera o executável da simulação
compile:
	$(IVERILOG) -o $(SIM) $(SRC)

# Executa a simulação para gerar o arquivo .vcd
simulate:
	$(VVPP) $(SIM)

# Abre o GTKWave para visualizar o arquivo .vcd
view:
	$(GTKWAVE) $(WAVE)

# Limpa os arquivos gerados
clean:
	rm -f $(SIM) $(WAVE)