Corrigi os arquivos que estavam em projetoAC.

Toda a implementação do processador foi feita no mesmo arquivo de simulação (simulacao.v)
o que atrapalha a organização. O ideal é instanciar o processador no arquivo de simulação.


Notei que o projeto caminha em dois ciclos de clock, ao invés de 1.
O sinal de branch não foi exercitado nas instruções.
Não implementou suporte ao jump