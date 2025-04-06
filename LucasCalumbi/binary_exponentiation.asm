#################################################################################
# O codigo a seguir implementa o algoritmo de binary exponentiation.		#
# O binary exponentiation é um algoritmo recursivo usado para calcular  	#
# potencias de expoente grandes fazendo aproximadamente log2(n) multiplicacoes  #
# sendo 'n' o valor do expoente							#
#################################################################################


.globl main

main:
	
	#valor da base
	addi $t0, $zero, 2 

	#valor do expoente
	addi $t1, $zero, 10

	
	addi $sp, $sp, -4 #reserva na pilha o espaco para um inteiro
	sw $t1, 0($sp) #salva $t1 na pilha

	#salta para a funcao binary_exponentiation
	jal binary_exponentiation

	lw $t1, 0($sp) #carrega o valor de $t1 antes da execucao da funcao
	addi $sp, $sp, 4 #desaloca o espaco reservado para $t1

	add $t2, $v0, $zero #copia o resultado pra $t2
	#copia o resultado para $a0
	#imprime $a0 (o resultado)
	#li $v0, 1
	#syscall 

	#encerra o programa
	li $v0, 10
	syscall

#funcao para calcular f(b,n) = b^n
#argumentos em $t0 (base) e $t1 (expoente)
#resultado da funcao em $v0
#valores muitos grandes podem nao funcionar, assim como na implementacao em C
#se b=2, o valor maximo que 'n' pode ter eh 30 (para resultados corretos)
binary_exponentiation:
	
	li $t2, 0
	beq $t1, $t2, base_case #se o expoente for 0, vai pro caso base
	
	addi $sp, $sp, -4 #reserva o espaco pra 1 inteiro na pilha

	sw $ra, 0($sp) #salva endereco de retorno na pilha

	andi $t2, $t1, 1 # mod $t1 2 
	beq $t2, $zero, even_bin_expo # expoente eh par
	#j odd_bin_expo # expoente eh impar 

odd_bin_expo:

	addi $t1, $t1, -1 #faz expoente-1

	jal binary_exponentiation

	mul $v0, $t0, $v0 #faz a operacao base*x
	
	lw $ra, 0($sp) #recupera endereco de retorno
	addi $sp, $sp, 4 #desaloca espaco reservado na pilha

	jr $ra #retorna para funcao que chamou

even_bin_expo:

	srl $t1, $t1, 1 #bitwise pra direita, teoricamente divide por 2
	
	jal binary_exponentiation

	mul $v0, $v0, $v0 #faz a operacao x*x

	lw $ra 0($sp) #recupera endereco de retorno
	addi $sp, $sp, 4 #desaloca espaco reservado na pilha

	jr $ra #retorna para funcao que chamou

base_case:

	li $v0, 1 # $v0 <- 1
	jr $ra  # retorna para a funcao que o chamou
	
	
	
