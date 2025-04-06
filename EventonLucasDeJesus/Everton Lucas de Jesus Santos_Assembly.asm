# Definição dos dados na memória
.data
	num1:   .word 5       # Primeiro número (5)
	num2:   .word 10      # Segundo número (10)
	result: .word 0       # Variável para armazenar o resultado

# Código do programa
.text
	# Carrega os valores de num1 e num2 da memória para registradores
	lw $t0, num1      # $t0 = num1 (5)
	lw $t1, num2      # $t1 = num2 (10)

	# Soma os valores em $t0 e $t1, armazenando o resultado em $t2
	add $t2, $t0, $t1 # $t2 = $t0 + $t1 (5 + 10 = 15)

	# Armazena o resultado na memória
	sw $t2, result    # result = $t2 (15)

	# Mostra o resultado da soma
	li $v0, 1
	lw $a0, result
	syscall
    
	# Fim do programa
	j end

	end:
		li $v0, 10
		syscall