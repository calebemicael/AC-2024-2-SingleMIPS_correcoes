all: compile simulate

compile:
    iverilog -o mips_tb mips.v control_unit.v alu.v register_file.v instruction_memory.v data_memory.v mux.v mips_tb.v

simulate:
    vvp mips_tb
    gtkwave waveform.vcd