Tive dificuldades de entender qual era a entrega, afinal.
Estou assumindo que é o que está na pasta Processador.

O Makefile não funciona de imediato, porque é preciso optar:
ou usa include ou lista todos os arquivos .v no makefile. Uma opção seria usar 
as diretivas #ifdef #define #endif que funcionam no verilog também.

fez a impressão dos valores de PC e instrução para demonstrar que o FetchCycle
funciona. Ok. Mas as instruções executadas não demonstram o pleno suporte das 
instruções de branch, jump ou de acesso à memoria (SW/LW). Pecou nesse ponto.

Mas aparentemente estão implementados. O código, porém, poderia estar melhor
documentado.

