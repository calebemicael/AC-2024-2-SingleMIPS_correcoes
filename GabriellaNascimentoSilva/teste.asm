        .data                   # Seção de dados
val1:   .word 10               # Valor 1
val2:   .word 20               # Valor 2
val3:   .word 0                # Local onde o resultado será armazenado

        .text                   # Seção de código
        .globl main
main:
        # Carregar valores da memória para os registradores
        la   $t0, val1           # Carrega o endereço de val1 em $t0
        lw   $t1, 0($t0)         # Carrega o valor de val1 em $t1 (lw = load word)

        la   $t0, val2           # Carrega o endereço de val2 em $t0
        lw   $t2, 0($t0)         # Carrega o valor de val2 em $t2 (lw = load word)

        # Soma: $t3 = $t1 + $t2
        add  $t3, $t1, $t2       # Soma de $t1 e $t2

        # Armazenar o resultado da soma em val3
        la   $t0, val3           # Carrega o endereço de val3 em $t0
        sw   $t3, 0($t0)         # Armazena o valor de $t3 em val3 (sw = store word)

        # Subtração: $t4 = $t1 - $t2
        sub  $t4, $t1, $t2       # Subtração de $t1 e $t2

        # Armazenar o resultado da subtração em val3
        la   $t0, val3           # Carrega o endereço de val3 em $t0
        sw   $t4, 0($t0)         # Armazena o valor de $t4 em val3

        # AND: $t5 = $t1 & $t2
        and  $t5, $t1, $t2       # Operação AND bit a bit

        # Armazenar o resultado da operação AND em val3
        la   $t0, val3           # Carrega o endereço de val3 em $t0
        sw   $t5, 0($t0)         # Armazena o valor de $t5 em val3

        # OR: $t6 = $t1 | $t2
        or   $t6, $t1, $t2       # Operação OR bit a bit

        # Armazenar o resultado da operação OR em val3
        la   $t0, val3           # Carrega o endereço de val3 em $t0
        sw   $t6, 0($t0)         # Armazena o valor de $t6 em val3

        # XOR: $t7 = $t1 ^ $t2
        xor  $t7, $t1, $t2       # Operação XOR bit a bit

        # Armazenar o resultado da operação XOR em val3
        la   $t0, val3           # Carrega o endereço de val3 em $t0
        sw   $t7, 0($t0)         # Armazena o valor de $t7 em val3

        # Comparação: se $t1 == $t2, pular para a label "equal"
        beq  $t1, $t2, equal     # Se $t1 == $t2, desvia para equal

        # Se os valores não forem iguais, armazenar uma mensagem de erro
        li   $t8, 999            # Coloca 999 em $t8 (mensagem de erro)
        la   $t0, val3           # Carrega o endereço de val3
        sw   $t8, 0($t0)         # Armazena o valor de $t8 em val3

        j    end                 # Pula para o final

equal:
        # Se os valores forem iguais, armazenar uma mensagem de sucesso
        li   $t8, 42             # Coloca 42 em $t8 (mensagem de sucesso)
        la   $t0, val3           # Carrega o endereço de val3
        sw   $t8, 0($t0)         # Armazena o valor de $t8 em val3

end:
        # Finaliza o programa
        li   $v0, 10             # Código para terminar o programa
        syscall                  # Chama a interrupção para terminar o programa
