O makefile funciona corretamente, o que facilita a correção.

Foram executadas 6 instruções no arquivo codigo.mem. Mas quais são essas instruções?
Tive que fazer a tradução na mão.

addi $8, $zero, 1
addi $9, $zero, 2
addi $9, $zero, 3
addi $8, $zero, 5
add $10, $8, $9
sw $10, 0($zero)

O Jump aparentemente foi implementado, mas não testado. Nao tenho como acompanhar
o funcionamento pela falta de inclusao dos conteudos das memorias internas (registradores, 
memoria de instrucao e dados) no arquivo de simulação para visualização no gtkwave. Há 
impressoes na tela para acompanhamento, mas somente os conteudos do PC registradores lidos e resultado
da alu são mostrados. ótimo para companhar parcialmente instruções do tipo R. Mas o acompanhamento das 
instruções LW e SW fica comprometido.

