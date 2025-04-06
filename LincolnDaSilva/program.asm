main:
    addi $t0, $zero, 5       # $t0 = 5
    addi $t1, $zero, 10      # $t1 = 10
    add $t2, $t0, $t1        # $t2 = $t0 + $t1 = 15
    beq $t2, $t1, target     # Se $t2 == $t1, salta para target (não salta)
    j end                    # Salta para end
target:
    addi $t2, $zero, 20      # $t2 = 20 (não executado)
end:
    sw $t2, 0($zero)         # Armazena $t2 na memória (endereço 0)