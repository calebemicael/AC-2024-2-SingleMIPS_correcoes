        .data
array:   .word 5, 10, 15, 20  
result:  .word 0 

        .text
        .globl main
main:
    #teste de instruções R-type
    
    #teste de ADD
    li $t0, 2          # $t0 = 2
    li $t1, 3          # $t1 = 3
    add $t2, $t0, $t1    # $t2 = 2 + 3 = 5

    #teste de SUB
    li $t3, 10         	# $t3 = 10
    li $t4, 4		# $t4 = 4
    sub $t5, $t3, $t4	# $t5 = 10 - 4 = 6

    #teste de AND
    li $t6, 0xFF00FF00 	# $t6 = 0xFF00FF00
    li $t7, 0x00FF00FF 	# $t7 = 0x00FF00FF
    and $t8, $t6, $t7   # $t8 = 0xFF00FF00 & 0x00FF00FF = 0x00000000

    #teste de OR
    or $t9, $t6, $t7   	 # $t9 = 0xFF00FF00 | 0x00FF00FF = 0xFFFFFFFF

    #teste de SLT
    li $s0, 1         	 # $s0 = 1
    li $s1, 2         	 # $s1 = 2
    slt $s2, $s0, $s1    # $s2 = 1 (porque 1 < 2)


    # Teste de instruções I-type
    
    #teste de LW carregamento de palavra da memória
    la $s4, array      #carrega o endereço base de array em $s4
    lw $s3, 0($s4)     #$s3 = array[0] (tem que ser 5)

    #teste de SW: armazenar palavra na memória
    la $s5, result     #carrega o endereço de result em $s5
    sw $s3, 0($s5)     #armazena o valor de $s3 em result

    #teste de BEQ
    #se $t0 == $t0 (2 == 2) - branch_p
    beq  $t0, $t0, branch_p
    #caso não aconteça, pula para after_beq
    j dps_beq

branch_p:
    #se a branch foi tomada, sinaliza colocando 100 em $v0
    li   $v0, 100       

dps_beq:
    # Teste de instrução J-type (jump)
    j jump_target	#salta incondicionalmente para jump_target

    #código abaixo não será executado se o jump funcionar corretamente
    li $v0, 0        

jump_target:
    #ao chegar aqui, sinaliza o jump colocando 42 em $v1
    li $v1, 42       

    # Syscall para terminar o programa
    li $v0, 10       
    syscall
