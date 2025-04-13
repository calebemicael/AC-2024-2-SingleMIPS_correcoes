Makefile nao funcionou, e nao vou conseguir depurar.
Rodei os comandos manualmente. 

Implementou suporte ao Jump, mas nao testou no código de exemplo. Nem o BEQ.
Olhando os sinais, aparentemente os sinais de controle estão ok. Implementou meios
de acompanhar a execução no terminal (variações no PC, resultado da ALU e instruções), 
mas não há nem no terminal nem no arquivo de sinais como acompanhar o conteúdo das
memórias internas, para acompanhar o funcionamento efetivo.

AS instruções presentes em Soma.asm nao condizem com codigo.mem. São elas:

addi $8, $zero, 5       
addi $9, $zero, 10      
lw   $8, 0($zero)       
lw   $9, 4($zero)       
add  $8, $8, $9         

Em sua maioria, o código está bem documentado. Mas não consigo testar o funcionamento
das demais instruções sem que eu mesmo tenha que escrever código.

Instanciar a memoria de instruções fora do processador foi uma sacada interessante. Saiba
que dá pra usar a memoria externa da placa FPGA para servir de memoria de instrução, e 
economizar espaço da FPGA.

