A entrega feita com arquivos soltos dificulta a correção. Precisei renomear 
todos os arquivos. Para evitar esse transtorno, deveria ter sido entregue como
um pacote zip. 

Tive vários problemas com os nomes dos arquivos. É preciso ter consistencia 
quanto ao Case das letras. MUX2x1 é diferente de Mux2x1. Para uma plataforma, pode
ser indiferente, mas não para outras.

Quando ajustei os nomes dos arquivos, tive problema de inclusão cruzada de arquivo.
Uma solução para evitar esse tipo de problema é usar as diretivas #ifndef #define #endif, 
ou evitar redundar no uso da diretitra `include e a listagem dos .v no makefile. Um ou outro. 

Analisando o código, notei que nao há meio implementado de acompanhar o funcionamento:
    Sem impressoes na saida
    Sem banco de registradores ou memoria de instruções adicionadas para rastreamento no tb_mips.
Não deu suporte ao jump, ao menos não na ControlUnit.v. Apesar disso, a instrução j está presente 
no código exemplo. Ao executar o código, o valor de PC e o valor da instrução fica em xxx. 

Tudo isso me leva a crer que o projeto foi enviado sem ter sido devidamente depurado.

Nota-se, contudo, uma estrutura modular que aparenta estar consistente.