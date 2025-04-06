all: compile simulate

compile:
	iverilog -o mips_cpu alu.v fetch_unit.v jump_unit.v memoria_dados.v memoria_instrucoes.v mips_cpu.v registradores.v unidade_controle.v tb_mips_cpu.v

simulate:
	vvp mips_cpu
	gtkwave waveform.vcd
	