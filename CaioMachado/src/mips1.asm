.data
array: .word 1, 2, 3, 4, 5
.text
main:
    addi $t0, $zero, 0       # $t0 = 0 (índice)
    addi $t1, $zero, 5       # $t1 = 5 (tamanho do array)
loop:
    lw $t2, array($t0)       # $t2 = array[$t0]
    addi $t2, $t2, 1         # $t2 = $t2 + 1
    sw $t2, array($t0)       # array[$t0] = $t2
    addi $t0, $t0, 4         # $t0 = $t0 + 4 (próximo elemento)
    bne $t0, $t1, loop       # if $t0 != $t1, goto loop