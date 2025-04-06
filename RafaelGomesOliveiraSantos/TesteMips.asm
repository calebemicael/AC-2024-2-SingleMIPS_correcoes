    .text
    .globl main

main:
    # Inicializa valores nos registradores
    addi $t1, $zero, 100     # $t1 = 100
    addi $t2, $zero, 200     # $t2 = 200

    # Configura endereço de memória na RAM (0x10010000)
    lui $t3, 0x1001          # Carrega parte alta do endereço 0x10010000

    # Teste de SW (store word) - Armazena valores na memória
    sw $t1, 0($t3)           # Armazena 100 no endereço 0x10010000
    sw $t2, 4($t3)           # Armazena 200 no endereço 0x10010004
    
    # Teste de LW (load word) - Carrega os valores armazenados na memória
    lw $t4, 0($t3)           # Carrega 100 para $t4
    lw $t5, 4($t3)           # Carrega 200 para $t5
    
    # Teste de Comparação com número negativo (ADICIONADO)
    addi $s0, $zero, -5      # Carrega -5 em $s0
    addi $s1, $zero, -3      # Carrega -3 em $s1
    slt $s2, $s0, $s1        # $s2 = 1 se -5 < -3 (resultado esperado = 1)
    sw $s2, 8($t3)           # Armazena resultado em 0x10010008
    
    # Teste de operações da ALU
    add $t6, $t4, $t5        # $t6 = 100 + 200 = 300
    sub $t7, $t5, $t4        # $t7 = 200 - 100 = 100
    and $t8, $t4, $t5        # $t8 = 100 AND 200
    or  $t9, $t4, $t5        # $t9 = 100 OR 200
    
    # Teste de BEQ (branch if equal)
    beq $t4, $t5, IGUAL  # Se $t4 != $t5, pula para NAO_IGUAL
    addi $s0, $zero, 1       # Se $t4 == $t5, coloca 1 em $s0 (não deveria acontecer)
    
IGUAL:
    addi $s1, $zero, 2       # Marca que BEQ funcionou
    
    # Teste de Jump (J)
    j FIM                    # Salta para a label "FIM"
    addi $s2, $zero, 3       # Este comando nunca deve ser executado
    
FIM:
    addi $s3, $zero, 4       # Indica que o código chegou ao final corretamente

    # Encerrar programa
    li $v0, 10               # Código de exit
    syscall
    nop