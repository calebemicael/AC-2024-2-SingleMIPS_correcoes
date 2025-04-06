IVERILOG = iverilog
VVP = vvp
GTK = gtkwave

SRC = mips_tb.v mips_processor.v alu.v aluControl.v pc.v registers.v \
      controlUnit.v dataMemory.v instructionMemory.v mux2x1.v adder32.v signExtend.v

OUT = mips_tb.vvp
VCD = mips_tb.vcd

all: compile run view

compile:
	$(IVERILOG) -o $(OUT) $(SRC)

run:
	$(VVP) $(OUT)

view:
	$(GTK) $(VCD) &

clean:
	rm -f $(OUT) $(VCD)
