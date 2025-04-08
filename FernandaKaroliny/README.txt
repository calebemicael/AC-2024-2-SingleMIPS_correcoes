Analisando o código, observa-se alguns equívocos no testbench, ao usar o bloco generate 
instanciar várias memórias, quando ela já está instanciada nos blocos datamemory.v
e memoriainstrucoes.v. O que seria necessário no testbench é adicionar o monitoramento
desses elementos no gtkwave

Também há outro equívoco: o monitoramento do regBankState[0], sendo que ele deve ser constante em 0.

Os equívocos estão na forma de exibir e monitorar o funcionamento, mas a implementação funciona.
Há o sequenciamento com o PC, há o acesso às instruções (fetch).

Não consegui olhar o conteúdo dos registradores para avaliar se a etapa de decode estava correta.
Os equivocos no tb atrapalham esse monitoramento. A estrutura, geral aparenta corretude.

Faltou implementação do jump.