# variáveis
VERILOG_COMPILER = iverilog
SIMULATOR = vvp
GTKWAVE = gtkwave


SRC_FILES = mips_ciclo_unico.v 
TB_FILES = TB_MIPS.v


OUTPUT_FILE = mips_tb


all: $(OUTPUT_FILE)

$(OUTPUT_FILE): $(SRC_FILES) $(TB_FILES)
	$(VERILOG_COMPILER) -o $(OUTPUT_FILE) $(SRC_FILES) $(TB_FILES)


sim: $(OUTPUT_FILE)
	$(SIMULATOR) $(OUTPUT_FILE)


wave:
	$(GTKWAVE) mips_tb.vcd

clean:
	del /Q $(OUTPUT_FILE).exe mips_tb.vcd 2>nul
