 # Ex. simples programa com instruções avulsas para testar o processador =)

 .text
 .globl main
 
 	main:
 	
 	addi $t0, $zero, 0x0002 # t0 = 0 + 2
 	addi $t1, $zero, 0x0010 # t1 = 0 + 16
 	addi $t3, $zero, 0x0012 # t3 = 18
 	
 	add $t2, $t1, $t0 # t2 = 2 + 16
 	beq $t3, $t2, teste # se t3 == t2 ------ teste
 	
 	teste:
 		lw $t3, 0x10010004($0) # carrega 0
 		sub $t4, $t0, $t3 # t4 = 2 -  0
 		j ehSlt
 		
 	exSub:
 		sub $t5, $t1, $t4 #t5 = 16 - 0
 		# c jump aqui nao sera executado
 		
 	ehSlt:
 		slt $t3, $t4, $t1
 		
