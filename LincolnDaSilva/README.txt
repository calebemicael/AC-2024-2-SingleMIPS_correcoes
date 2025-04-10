O makefile funciona, consigo rodar a simulação.
Mas está sem saída no terminal, sem conteúdo das memorias no gtkwave.

Não implementou suporte a instrução Jump. O código hexadecimal
tem 4 instruções, e nao correspondem ao program.asm.
AS instruções são:

addi $8,  $zero, 1
addi $9,  $zero, 2
add  $10, $8, $9
sw   $10, 0($zero)
nop

O código está todo comentado, o que ajuda.
Notei um problema de sincronização na instrução sw. Vale revisão.