SIMULATOR = iverilog
WAVE_VIEWER = gtkwave

OUT_DIR = out
OUT_FILE = $(OUT_DIR)/simv
WAVE_FILE = $(OUT_DIR)/processador_tb.vcd

SRC_FILES = \
    FetchUnit.v \
    MemoriaDeInstrucoes.v \
    controle.v \
    Registradores.v \
    multiRegDst.v \
    multiPCSrc.v \
    multiMemtoReg.v \
    multiALUSrc.v \
    DataMemory.v \
    SignExtend.v \
    controleULA.v \
    ALU.v \
    Add4.v \
    processador.v \
    testbenchProcessador.v

# Regra padrão
all: $(OUT_FILE)

# Regra para compilar os arquivos Verilog
$(OUT_FILE): $(SRC_FILES)
	@mkdir -p $(OUT_DIR)
	$(SIMULATOR) -o $(OUT_FILE) $(SRC_FILES)

# Regra para executar a simulação e gerar o arquivo VCD
run: $(OUT_FILE)
	@mkdir -p $(OUT_DIR)
	vvp $(OUT_FILE) +dumpfile=$(WAVE_FILE) +dumpvars

# Regra para visualizar as ondas
view: $(WAVE_FILE)
	$(WAVE_VIEWER) $(WAVE_FILE)

# Regra para limpar os arquivos gerados
clean:
	rm -rf $(OUT_DIR)

.PHONY: all run view clean