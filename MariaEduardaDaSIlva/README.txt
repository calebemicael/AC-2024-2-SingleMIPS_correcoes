Precisei fazer uma alteração pontual no Makefile para
adequar o comando de exclusão do windows para linux. ok

Implementou suporte à instrução jump. Testou no código que segue

addi  $8,  $zero, 5
addi  $9,  $zero, 3
add   $10, $8, $9
sw    $10, 0($zero)
lw    $11, 0($zero)
beq   $11, $10, 1
j     0x400009
addi  $12, $zero, 10
j     0x40000a
addi  $12, $zero, 20
sw    $12, 4($zero)

mas o sinal jump do controle não sobe junto com a instrução.
Há, portanto, um problema na implementação do controle. ou antes.


Investigando, apenas 6 primeiras instruções são executadas corretamente. 
Na instrução beq (116a0001) o valor de prox_pc fica don't care.
O problema pode ser na geração do next_px. Revisa.

No mais, tudo certinho.