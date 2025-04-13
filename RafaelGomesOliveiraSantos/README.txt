O projeto está bem documentado. A estrutura geral do projeto está bem organizada.
Parabéns.

Tive alguma dificuldade de executar o Makefile para linux, mas reconheço o esforço
de garantir o suporte para rWindows. Felizmente encontrei o arquivo vcd em um dos diretorios,
e avaliei a partir dali. 

Somente as 5 primeiras instruções são executadas corretamente. 
São elas:
addi $9,  $zero, 100       # $9 = 100
addi $10, $zero, 200       # $10 = 200
lui  $11, 0x1001           # $11 = 0x10010000
sw   $9,  0($11)           # Mem[$11 + 0] = $9
sw   $10, 4($11)           # Mem[$11 + 4] = $10

A 6 instrução é um LW,
lw   $12, 0($11)           # $12 = Mem[$11 + 0]

E nota-se o sinal MemWrite baixando corretamente.
Mas nesse momento a instrução torna-se don't care. Note que estou executando o vcd deixado.
Pq isso acontece?

Desisti de acompanhar o vcd e gtkw original, e resolvi ajustar o Makefile. Espaços em nomes de
diretórios eram o problema, windows e linux tratam diferente.

Rodei, precisei corrigir na ULA.v umas inconsistencias descabidas que imagino a origem...
Gerei o novo VCD. Mesmo problema. Subi uma captura de tela, para acompanhamento.