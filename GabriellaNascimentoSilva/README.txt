Analisando o código, observa-se alguns equívocos no testbench. O que seria 
necessário no testbench é adicionar o monitoramento desses elementos no 
gtkwave.

Os equívocos estão na forma de exibir e monitorar o funcionamento, mas a implementação funciona.
Há o sequenciamento com o PC, há o acesso às instruções (fetch).

Não consegui olhar o conteúdo dos registradores para avaliar se a etapa de decode estava correta.
Os equivocos no tb atrapalham esse monitoramento. A estrutura, geral aparenta corretude.

Faltou implementação do jump.