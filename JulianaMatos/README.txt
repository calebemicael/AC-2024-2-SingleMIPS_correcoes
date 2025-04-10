Entregou com atrasos. Aceito, mas com algum desconto.
Precisei fazer ajustes para o makefile funcionar. Os problemas se deveram à
dependencia dos arquivos. Ajustados, funcionou bem.

Não foi implementada forma simplificada de acompanhar a execução. Nota-se
nas formas de onda que alguns sinais seguem como don't care ou z.
É importante depurar para validar os ciclos um a um. O PC já não está
incrementando como deveria ao baixar o sinal de reset. 

Implementou um modulo unico que codifica todos os multiplexadores do sistema.
Interessante, mas não sei se funciona. O valor do PC está sendo atribuido nesse 
modulo, mas também precisa ser sensivel ao reset, para começar em 0. 

Onde o valor de PC é somado com 4?

Tem vários errinhos, a estrutura foi montada sem ter sido corretamente depurada.
Sugiro refazer para aprendizado, e ir garantindo cada ciclo antes de adicionar o 
próximo. (Fetch, decode...).