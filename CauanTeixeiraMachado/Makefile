# Variáveis
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
DUT = testbench.v
EXEC = testbench.vvp 
VCD = mips.vcd


.PHONY: all sim run view clean


all: clean sim run view


sim: $(DUT)
	$(IVERILOG) -o $(EXEC) $(DUT)


run: $(EXEC)
	./$(EXEC)


view: $(VCD)
	$(GTKWAVE) $(VCD)
#windows: 
#clean:
#	del /f /q $(EXEC) $(VCD)
# Limpa os arquivos gerados
# linux
clean:
	rm -f $(EXEC) $(VCD)