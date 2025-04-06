all: compile simulate view

compile:
	iverilog -o mips_tb tb.v mips.v pc.v adder.v ALU.v alu_control.v dMem.v imem.v regfile.v mux_2to1.v sign_extend.v shift_left_jump.v control.v

simulate:
	vvp mips_tb

view:
	gtkwave dump.vcd &

clean:
	rm -f mips_tb dump.vcd
