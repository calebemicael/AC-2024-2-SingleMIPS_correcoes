
IVERILOG= iverilog 
VVP=vvp 
GTKWAVE=gtkwave 
DUT=Proc_tb.v 
EXEC= Proc_tb.vvp
VCD= Proc.vcd 

.PHONY: all sim run view clean

all: clean sim run view 

sim: $(DUT)
		$(IVERILOG) -o $(EXEC) $(DUT)

run: $(EXEC)
		./$(EXEC)

view: $(VCD)
		$(GTKWAVE) $(VCD)

clean:
		rm -f $(EXEC) $(VCD)