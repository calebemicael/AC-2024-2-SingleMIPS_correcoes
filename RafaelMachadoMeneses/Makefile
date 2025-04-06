# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = mips.v ALUControl.v control_unit.v SignalExtend.v ShiftLeft2.v MemoriaDeInstrucoes.v DataMemory.v ula.v registradores.v FetchUnit.v mux2x1.v simulacao.v Add4.v Adder32.v
EXEC = mips_tb.vvp
VCD = waveform.vcd
MEM_FILE ?= "programa.mem"  # Arquivo padrão com aspas

# Regras
.PHONY: all compile run view clean

# Regra principal
all: compile run view

# Compilar o projeto
compile:
	$(IVERILOG) -o $(EXEC) -DMEM_FILE="\"$(MEM_FILE)\"" -s simulacao $(DUT)

# Executar simulação e gerar .vcd
run:
	$(VVP) $(EXEC)

# Visualizar waveform
view:
	$(GTKWAVE) $(VCD) &

# Limpar arquivos gerados
clean:
	rm -f $(EXEC) $(VCD)