addi $t0, $0, 5       # $t0 = 5
addi $t1, $0, 3       # $t1 = 3
add  $t2, $t0, $t1    # $t2 = $t0 + $t1 (5 + 3 = 8)
sw   $t2, 0($0)       # Armazena 8 na memória (endereço 0)
j    end              # Salta para "end"
addi $t3, $0, 10      # Esta instrução será pulada
end:
lw   $t4, 0($0)       # $t4 = valor da memória (8)