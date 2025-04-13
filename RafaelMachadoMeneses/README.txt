O Makefile funciona, o que facilita a correção.

Noto que foram incluidos no arquivo de simulação códigos visando exibição 
da evolução da simulação no terminal. Mas não funcionam porque o códgio não funciona, vide
captura de tela das formas de onda em sinais.png.

Fui avaliar o código manualmente. Somente os registradores t0-4 foram
incluidos para acompanhamento das instruções, o que é esperto, já que são os unicos utilizados.

O código está bem organizado, bem documentado. Apresenta uma estrutura modular consistente.
O arquivo com o programa a ser testado foi declarado usando o parâmetro -D do iverilog. Chuto
ser esse o motivo, não sei se funciona conforme o esperado. Mas não pretendo investigar muito além disso. 

Substitui o nome da instrução direto no arquivo MemoriaDeInstrucoes.v e consegui ver os sinais. Era isso.

Implementou suporte a instrução de jump.

Voltei a simular e os sinais estão ok. Somente apos ajustes, contudo.

