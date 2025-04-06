
lw  $t0, 16($zero)   # armazena valor de memória para $t0
lw  $t1, 20($zero)   # armazena valor de memória para $t1
lw  $t2, 24($zero)   # armazena valor de memória para $t2


add $t3, $t0, $t1     # soma $t3 = $t0 + $t1


sub $t4, $t2, $t0    # sun $t4 = $t2 - $t0



and $t5, $t1, $t2    # and $t5 = $t1 & $t2 
or  $t6, $t0, $t1    # $t6 = $t0 | $t1 or
xor $t7, $t0, $t2    # $t7 = $t0 ^ $t2  xor


nor $t8, $t1, $t2    # $t8 = ~( $t1 | $t2 ) nor
slt $t9, $t0, $t1    # $t9 = $t0 < $t1  slt