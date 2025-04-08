IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Lista manual de arquivos fonte 
SRC = mips_single_cycle.v tb_mips_single_cycle.v instruction_memory.v data_memory.v register_file.v alu.v control_unit.v mux2to1.v sign_extension.v alu_control_unit.v pc.v


# Saída da simulação
OUT = simulacao.vvp
VCD = tb_mips_single_cycle.vcd

# Regra principal
all: $(OUT)

$(OUT): $(SRC)
	$(IVERILOG) -o $(OUT) $(SRC)

# Executar simulação e abrir GTKWave
run: $(OUT)
	$(VVP) $(OUT)
	$(GTKWAVE) $(VCD)

# Limpar arquivos gerados
clean:
	del /Q $(OUT) $(VCD) 2> nul

.PHONY: all run clean