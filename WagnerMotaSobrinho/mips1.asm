    .data
msg_add:    .asciiz "Soma: "  
msg_sub:    .asciiz "\nSubtracao: "  
msg_mul:    .asciiz "\nMultiplicacao: "  
msg_div:    .asciiz "\nDivisao: "  
msg_and:    .asciiz "\nAND: "  
msg_or:     .asciiz "\nOR: "  

    .text
    .globl main

main:
    # Carregar dois valores em hexadecimal
    li $t0, 0x0D   # 13  (00001101 em binário)
    li $t1, 0x07   # 7   (00000111 em binário)

    ###### SOMA ######
    add $t2, $t0, $t1  # Soma: $t2 = $t0 + $t1
    li $v0, 4          # Imprimir string
    la $a0, msg_add
    syscall
    li $v0, 1          # Imprimir resultado
    move $a0, $t2
    syscall

    ###### SUBTRAÇÃO ######
    sub $t3, $t0, $t1  # Subtração: $t3 = $t0 - $t1
    li $v0, 4
    la $a0, msg_sub
    syscall
    li $v0, 1
    move $a0, $t3
    syscall

    ###### MULTIPLICAÇÃO ######
    mul $t4, $t0, $t1  # Multiplicação: $t4 = $t0 * $t1
    li $v0, 4
    la $a0, msg_mul
    syscall
    li $v0, 1
    move $a0, $t4
    syscall

    ###### DIVISÃO ######
    div $t0, $t1  # Divide $t0 por $t1
    mflo $t5      # Parte inteira do resultado vai para $t5

    li $v0, 4
    la $a0, msg_div
    syscall
    li $v0, 1
    move $a0, $t5
    syscall

    ###### AND ######
    and $t7, $t0, $t1  # Operação AND bit a bit
    li $v0, 4
    la $a0, msg_and
    syscall
    li $v0, 1
    move $a0, $t7
    syscall

    ###### OR ######
    or $t7, $t0, $t1  # Operação OR bit a bit
    li $v0, 4
    la $a0, msg_or
    syscall
    li $v0, 1
    move $a0, $t7
    syscall

    ###### ENCERRAR PROGRAMA ######
    li $v0, 10
    syscall
