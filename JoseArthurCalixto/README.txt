o makefile está bem estruturado, há saídas indicando a sequencia de instruções.
Contudo, nao há na saida ou incluido na simulação do gtkwave o conteúdo
dos registradores, memoria de instrução e de dados para que eu possa acompanhar
os resultados.

Rodando a simulação, vejo que os valores de ReadData1, ReadData2, WriteData do 
banco de  registradores e da memória de dados estão todos fixos em 0, o que dá
a entender que algo não funciona após o ciclo de fetch de instruções.

Pode ser o conjunto das instruções executadas, mas não há documentação sobre 
quais são elas. Podia ter incluído. Tive que extrair por conta.
j 4
addi $1, $zero, 5
lw $3, 4($zero)
sw $3, 8($zero)
beq $1, $2, 2

Nota que não tenho como avaliar se os fluxos de dados estão corretos pois estão
todos em 0. A escolha da combinação de instruções não foi das mais felizes.

Mas olhando os sinais de controle, aparentemente estão ok. Os sinais de jump,
branch e alusrc estão setando de forma condizente com as instruções executadas.

Implementou suporte a instrução de jump.

O código está bem documentado, mas faltaram facilidades para acompanhar a 
simulação. Deu trabalho pra avaliar, podia ter me ajudado a te ajudar. 