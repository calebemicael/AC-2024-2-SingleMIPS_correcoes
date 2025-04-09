ótimo! O Makefile funciona. Pelo terminal consigo acompanhar algumas
informações da simulação, como alterações no resultado da ALU.

Não consigo, contudo, ver o conteúdo do banco de registradores ou 
memórias.

Implementou suporte a instrução jump mas não exercitou no 
código assembly.

addi   $8,  $zero, 1
addi   $9,  $zero, 6
beq    $8,  $9, 3
mul    $20, $8, $9
sub    $9,  $9, $zero
bgtz   $9, -4
addiu  $2,  $zero, 1
addu   $4,  $zero, $8

