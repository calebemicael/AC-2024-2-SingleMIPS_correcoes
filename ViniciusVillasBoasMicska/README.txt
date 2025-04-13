-------------------------------------  primeira entrega ----------------------------------------------

Boa noite professor.

Consegui consertar o problema do PC incrementando loucamente, os mux genéricos que estavam
declarados invertidos. 

Tive problemas rodando o processador com o teste2.hex pois ele usava o $sp, e creio eu que
tenha sido esse o problema já que o teste3 não usa o $sp, mas ainda sim funciona.

No entanto, quando finalmente consegui descobrir qual o problema com o PC verifiquei nos
testes, teste3 inclusive, que a operação R não está funcionando adequadamente, pois além de 
modificar um registrador que não era suposto para ser modificado, ele adiciona um valor absurdo

Não vou ter tempo de corrigir o problema.

De modificação que fiz nos arquivos que você forneceu, eu atualizei o shiftleft para ser mais modulável
nos conformes no MuxGeneral que fiz para evitar repetições. E atualizei também a fetch unit para poder
modificar o valor do pc conforme as instruções de jump e beq.

Meus testes foram ínfimos devido ao problema com o pc que comentei. 

Enfim, aparentemente ele está conseguindo ler e executar parcialmente as instruções. O código no documento
teste3.hex é o seguinte:

    addi $t0, $zero, 10
    addi $t1, $zero, 40
    add $t2, $t1, $t0  #t2 = t1 + t0
    
    addi $t3, $zero, 40
    
    beq $t1, $t3, myLabel
    j end
    
    myLabel: 	
    addi $t3, $zero, 50
    
    end:
    addi $t3, $zero, 100

E observando o registrador $t3, aparentemente a instrução de jump está funcionando. Por algum motivo aparece um
valor 41 no meio, mas creio eu que esteja tudo certo.

Não tive como testar as operações de lw e sw, então deixo ao seu critério julgar.

Enfim. 

-------------------------------------  Segunda entrega ----------------------------------------------

Boa noite professor. Novamente, fiz diversas correções, cavuquei esse arquivo por completo, tentei substituir algumas
partes com ajuda de quem conseguiu para ver se encontrava o erro e simplesmente não encontro. Não consigo simular o sw
e o lw de forma alguma, de modo que não consigo ver se as outras operações estão funcionando adequadamente. Não tive tempo
de trabalhar muito no código nesse fim de semana, então deixo ao seu critério julgar conforme o tempo dado para realização.

Se você souber, ou imaginar, qual o erro da minha implementação, por favor, a título de curiosidade, gostaria muito de saber.
Não entendo de onde vem esse loop infinito.

Nessa etapa as adições não foram muitas, substituí os muxs para ver se o problema era com eles e revisei todas as ligações. 
Creio eu ter consertado as operações de ADDi pois para o código (da primeira etapa) addi funciona corretamente.

Enfim, peço desculpas por não ter conseguido entregar funcionando mesmo com a extensão do prazo de entrega. 


-- 

Comecei a depurar teu código e realmente há alguns problemas. COmecei isolando os ciclos. Comecei pelo fetch de instruções.

Por que concatenas tanto as entradas? Tu poderias separá-las. Juntando-as assim fica ilegivel e dificulta a depuração.
Por exemplo, seus sinais de controle estão concatenados, e acabas os referenciando por meio dos indices. Nada legivel.
É confuso jogar pcIncrementado para fora de fetch, e calcular o pcSet fora do modulo. Fica mais organizado jogar os sinais de 
controle dos multiplexadores e a instancia dos extensores de sinal para dentro do modulo fetch.

Fixei os seletores, para não depender de sinais que ainda estão isolados. Primeiro, vou garantir o fluxo sequencial. Fixei
também as entradas alternativas.
Notei que beqAddrs é driveado em duas saídas de modulo, gerando um sinal em alta impedância.


Buenas, há muito erros. Recomendo seguir por conta essa metodologia de isolar os ciclos e garanti-los antes de habilitar
os modulos dos demais ciclos. Deixei no código exemplos de como fazer esse isolamento. Mas é preciso investir tempo.