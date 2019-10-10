
# Projeto CASTLE DEFENSE

Neste projeto, vocês deverão implementar diversas mecânicas em um
*tower defense*. Nessa versão relativamente simplificada de um gênero
bastante diverso, haverá apenas mecânicas de posicionamento de unidades e um
certo nível de gerenciamento de recursos.

## 1. Entrega

Para o primeiro projeto, a entrega será até dia 6/11.

Para o segundo projeto, a entrega será até dia 4/12.

Os projetos valerão 10 pontos a menos por dia de atraso.

### 1.1 Formato

Vocês deverão entregar um arquivo comprimido (zip ou tar.gz) contendo:

1. O projeto LÖVE do jogo de vocês
2. Um relatório com nome e número USP dos participantes

O jogo deverá ser feito para a versão mais recente da LÖVE (11.2), e deverá
incluir todos os pacotes Lua externos que usar. Por exemplo, se você usa o
pacote [SUIT](https://github.com/vrld/suit) para *immediate-mode GUI*, você
deve incluir o código dele no seu projeto. Evite ao máximo usar pacotes
compilados (isso é, não escritos em Lua). Tome cuidado com as licenças.

## 2. Código base

Vocês devem usar o código neste repositório como base para a implementação do
projeto de vocês. Nossa recomendação é fazer um *fork* (usando git) deste
repositório, assim vocês já terão o formato estabelecido e um jeito fácil de
atualizar o código base caso mandemos alguma atualização. Mas não é necessário,
podem se organizar como acharem melhor contanto que o formato de entrega seja
atendido.

### 2.1 Máquina de estados

O código base providenciado nesse repositório tem um sistema simples de máquina
de estado. Cada estado é aproximadamente uma das "telas" do jogo, e eles se
acumulam usando uma pilha, para que seja possível retornar a estados anteriores
automaticamente. Se não houver nenhum estado na pilha, o jogo deve ser
encerrado. Aqui descrevemos as telas do jogo.

#### 2.1.2 Seleção de fases

Esse estado contém um menu que lista todas as fases do banco de dados para
que os jogadores escolham qual querem jogar.

#### 2.1.2 Jogar fase

Estado principal de interação do jogo, onde os jogadores posicionam unidades
para defender seu castelo.

### 2.2 Estrutura de pastas

A estrutura de pastas e módulos segue uma arquitetura baseada no
*Model-View-Controller*. A diferença é que os "controllers" são os estados da
pilha. A divisão fica então assim:

+ `assets/`: arquivos de mídia para o jogo (texturas, fontes, sons, etc.)
+ `common/`: módulos e classes usadas por todo o resto do código
+ `database/`: especificação das entidades e cenários do jogo
+ `model/`: módulos e classes que definem a simulção (i.e. mecânicas) do jogo
+ `state/`: os estados de interação que o jogo tem
+ `view/`: classes dos elementos visuais que o jogador vê e interage com

## 3. Tarefas

Diferente dos EPs, no projeto não há uma "solução correta" do enunciado. Cada
grupo deve desenvolver seu projeto como achar melhor, escolhendo dentre as
tarefas listadas aqui. Cada tarefa em geral acrescenta uma mecânica no jogo,
podendo conter não só a parte lógica como também partes visuais e de interação
com usuário (inclusive novos estados/telas). **Vocês ganham até 10 pontos com
cada tarefa que fizerem, até um máximo de 100 pontos**. As tarefas indicam o que
é necessário para ganhar seu valor máximo. Notem que várias delas têm como
pré-requisito tarefas anteriores.

**Dica**: não precisa fazer a tarefa inteira pra ganhar nota nela, então não
percam tempo com subtarefas difíceis. Sigam para a próxima tarefa. Também não
precisam fazer as tarefas na ordem, contanto que satisfaçam seus pré-requisitos.

#### Índice de tarefas

1.  [Apresentação](#apresentação-ax)
2.  [Qualidade de código](#qualidade-de-código-ux)
3.  [Juiciness](#juiciness-jx)
4.  [Dano e derrota](#dano-e-derrota-ex)
5.  [Ondas e vitória](#ondas-e-vitória-vx)
6.  [Variação das unidades](#variação-de-unidades-ux)
7.  [Dinheiro e custo das unidades](#dinheiro-e-custo-das-unidades-cx)
8.  [Pré-requisito de unidades](#pré-requisito-de-unidades-rx)
9.  [Manobras táticas](#manobras-táticas-mx)
10. [Invasores com prioridade](#invasores-com-prioridade-ix)
11. [Unidades de suporte](#unidades-de-suporte-sx)
12. [Evolução de unidades](#evolução-de-unidades-nx)
13. [Elementos do mapa](#elementos-do-mapa-tx)
14. [Invasores aprimorados](#invasores-aprimorados-px)
15. [Conteúdo adicional](#conteúdo-adicional-dx)

### **A**presentação (Ax)

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| A1     | Atender o formato de entrega                               | +2     |
| A2     | Executar sem erros                                         | +3     |
| A3     | Explicar organização do código no relatório                | +3     |
| A4     | Listar tarefas cumpridas no relatório                      | +2     |

No relatório, listem quais critérios de cada tarefa vocês cumpriram,
preferencialmente usando os códigos.

### Q**u**alidade de código (Ux)

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| U1     | Passar no [luacheck](https://github.com/mpeterv/luacheck)  | +5     |
| U2     | Separação clara entre Model, View e os estados             | +3     |
| U3     | Módulos de até 200 linhas                                  | +2     |
| U4     | Funções de até 20 linhas                                   | +2     |
| U5     | Linhas com até 100 caracteres                              | +2     |

### **J**uiciness (Jx)

Cada efeito de *juiciness* que vocês colocarem no jogo vale +2 pontos nesta
tarefa. Vocês precisam documentar o efeito no relatório. Algumas sugestões:

+ Efeito sonoros de interação com a interface (mover cursor, selecionar, etc.)
+ Transições entre telas e menus
+ Partículas

### Dano e d**e**rrota (Ex)

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| E1     | Unidades inimigas perdem vida/tempo quando próximas        | +2     |
| E2     | Unidades sem vida morrem                                   | +2     |
| E3     | Invasores se movem em direção ao castelo dos jogadores     | +2     |
| E4     | Invasores não se amontoam em cima do castelo               | +2     |
| E5     | Jogador perde a partida se seu castelo for destruído       | +2     |

"Perder vida/tempo" significa que a unidade perde vida ao longo do tempo, seja
continuamente a cada quadro do jogo, ou periodicamente a cada segundo ou ciclo
similar. Fica a critério de vocês!

Todos os critérios dessa tarefa precisam que haja alguma representação textual
ou visual que o jogador possa ver e entender o que está acontecendo.

### Ondas e **v**itória (Vx)

Requer [dano e derrota](#dano-e-derrota-ex).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| V1     | Quantidade e sequência de invasores seguem as ondas do BD  | +3     |
| V2     | Uma onda só acaba quando todos os invasores dela morrerem  | +3     |
| V3     | Há uma pausa entre cada onda                               | +2     |
| V4     | Ao final da última onda, os jogadores vencem a partida     | +2     |

"Ondas" são as levas de invasores que aparecem por vez e tentam destruir o
castelo dos jogadores.

Os critérios V2, V3 e V4 dessa tarefa precisam que haja alguma representação
textual ou visual que o jogador possa ver e  entender o que está acontecendo.
No caso do V3, o importante é avisar quando a próxima onda começou.

### Variação de **u**nidades (Ux)

Requer [Dano e derrota](#dano-e-derrota-ex).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| U1     | Selação de unidades durante a partida                      | +4     |
| U2     | Poder                                                      | +2     |
| U3     | Alcance                                                    | +2     |
| U4     | Velocidade                                                 | +2     |
| U5     | Carregar estatísticas do banco de dados                    | +2     |

No critério U1, os jogadores devem poder selecionar unidades diferentes para
criar durante a partida. Por exemplo, pode haver um menu lateral que lista as
unidades disponíveis, e os jogadores podem clicar lá para mudar qual unidade
eles estão criando no momento. A lista de unidades disponíveis pode ser sempre
a mesma ou variar para cada fase, como preferirem. Invasores também são
unidades.

Nos critérios U2, U3 e U4, o papel de cada estatística das unidades fica também
a gosto de vocês, seguindo mais ou menos essas linhas:

1.  O **poder** indica quanto dano um personagem causa ao atacar. Vocês podem
    usar o valor exato de poder, ou alguma fórmula. Vocês também podem gerar o
    dano aleatoriamente com base no poder do personagem, ou dividir o poder em
    poder físico e mágico. Vale lembrar que dano é causado como dano/tempo.
2.  O **alcance** indica quão próximo uma unidade adversária precisa estar para
    que esta unidade possa afetar ela.
3.  A **velocidade** indica quão rápido a unidade se move pelo mapa da partida.

Para ganhar a pontuação completa das estatísticas de poder, alcance e
velocidade, deve haver alguma representação textual e/ou visual delas que os
jogadores conseguem ver. Por exemplo, quando eles passam o cursor sobre a
unidade, pode aparecer um menu na interface descrevendo essas estatísticas.
Também deve haver pelo menos 3 tipos diferentes de unidades para os jogadores e
3 tipos diferentes de unidades invasoras presentes em alguma fase.

### Dinheiro e **c**usto das unidades (Cx)

Requer [variação de unidades](#variação-de-unidades-ux).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| C1     | Cada fase especifica uma quantidade inicial de dinheiro    | +2     |
| C2     | Unidades custam dinheiro                                   | +3     |
| C3     | Algumas unidades produzem dinheiro/tempo                   | +2     |
| C4     | Carregar essas informações do banco de dados               | +3     |

No critério C3, unidades que produzem dinheiro podem ser fazendas, mercados,
etc. Elas podem ser destruídas. Além disso, é preciso ter alguma indicação
textual ou visual de quanto dinheiro elas estão produzindo. Deve haver pelo
menos uma unidade produtora de dinheiro disponível para os jogadores em alguma
fase.

### Pré-**r**equisito de unidades (Rx)

Requer [variação de unidades](#variação-de-unidades-ux).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| R1     | Unidades que permitem criar novas unidades                 | +3     |
| R2     | Unidades que só são colocadas perto de outras unidades     | +3     |
| R3     | Unidades que aumentam o limite de unidades                 | +3     |
| R4     | Carregar essas informações do banco de dados               | +4     |

No critério R1, algumas tipos de unidades precisam que outros tipos específicos
de unidades existam para serem criadas. Por exemplo, só é possível criar magos
se os jogadores tiverem pelo menos uma biblioteca. É preciso indicar claramente
quais unidades estão disponíveis, então a lista de unidades da interface pode
não listar unidades indisponíveis, ou listá-las meio apagadas e não deixar os
jogadores as selecionarem. Deve haver pelo menos três unidades com
pré-requisito, mas elas podem ter o mesmo pré-requisito.

O critério R2 é similar ao R1, exceto que a unidade criada também só pode ser
posicionada próxima a unidade pré-requisito. Por exemplo, guerreiros só podem
ser criados perto de fortes, e fortes só podem ser criados perto de
construtores, etc. "Perto" pode ser determinado pela estatística de alcance da
unidade pré-requisito. É preciso indicar que uma unidade não pode ser criada
quando está longe de seu pré-requisito. Por exemplo, vocês podem fazer o cursor
ficar vermelho nesses casos. Deve haver pelo menos três unidades com esse
pré-requisito de localidade, podendo todas elas terem o mesmo pré-requisito.

O critério R3 é também uma variação do R1, onde um tipo de unidade limita
quantas unidades de outros tipos podem existir. Por exemplo, cada fazenda pode
aumentar em 5 a capacidade máxima de unidade não-construções dos jogadores.
É preciso indicar essa capacidade máxima em algum lugar da interface, e deve
haver pelo menos um caso de unidade que limita a criação de outras unidades em
alguma fase.

### **M**anobras táticas (Mx)

Requer [variação de unidades](#variação-de-unidades-ux) e [dinheiro e custo de
unidades](#dinheiro-e-custo-das-unidades-cx).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| M1     | Seleção de manobras durante a partida                      | +3     |
| M2     | Manobras custam dinheiro                                   | +2     |
| M3     | Manobras afetam todas as unidades relevantes               | +2     |
| M4     | Manobras afetam unidades dentro de uma área                | +2     |
| M5     | Carregar manobras do banco de dados                        | +3     |

Assim como os jogadores selecionam unidades para criar, eles devem poder
selecionar manobras táticas para usar. Manobras são usadas em posições do mapa,
podendo afetar todas as unidades relevantes ou (pelo critério M4) só aquelas
próximas do cursor quando a manobra foi usada.

O efeito de uma manobra é alguma alteração imediata no estado das unidades
envolvidas, como dano direto à vida delas, ou redução permanente da velocidade
delas.

Para os critérios M3 e M4, vocês devem implementar pelo menos 3 manobras de
qualquer um dos tipos.

### **I**nvasores com prioridade (Ix)

Requer [variação de unidades](#variação-de-unidades-ux).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| I1     | Invasores priorizam atacar certas unidades                 | +3     |
| I2     | Invasores evitam se aproximar de certas unidades           | +3     |
| I3     | Invasores podem ter prioridades distintas                  | +3     |
| I4     | Carregar prioridades do banco de dados                     | +4     |

Não é necessário nenhum algoritmo sofisticado nessa tarefa. Basta os invasores
se moverem em linha reta até seus alvos, ou se afastarem das ameaças como se
fossem "repelidas" pode elas quando estão pertos demais.

Para o critério I3, deve haver pelo menos 3 invasores com comportamentos
distintos.

### Unidades de **s**uporte (Sx)

Requer [variação de unidades](#variação-de-unidades-ux).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| S1     | Algumas unidades afetam outras unidades em seu alcance     | +4     |
| S2     | Unidades afetadas ficam com estatísticas alteradas         | +3     |
| S3     | Carregar efeitos do banco de dados                         | +3     |

Para o critério S1, basta ser capaz de detectar quais unidades estão
influenciando quais unidades, mesmo que não haja efeito nenhum. Deve apenas
haver alguma indicação visual.

Para o critério S2, deve haver pelo menos 3 tipos diferentes de efeitos. Alguns
exemplos: redução de poder, aumento de velocidade, etc.

### Evolução de u**n**idades (Nx)

Requer [variação de unidades](#variação-de-unidades-ux).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| N1     | Seleção de evoluções durante a partida                     | +3     |
| N2     | Evoluções custam dinheiro                                  | +2     |
| N3     | Unidades do tipo evoluído ficam mais fortes                | +2     |
| N4     | Carregar evoluções do banco de dados                       | +3     |

Assim como os jogadores selecionam unidades para criar, eles devem poder
selecionar evoluções para aplicar sobre suas unidades. Evoluções afetam todas as
unidades de um determinado tipo. Por exemplo, você pode evoluir todos os
guerreiros para terem mais poder, ou seu castelo para ter mais vida.

Os critérios N1, N2 e N3 exigem pelo menos 3 evoluções para valer sua pontuação
completa. Podem ser a mesmas 3 evoluções para os três critérios.

### Elemen**t**os do mapa (Tx)

Requer [dano e derrota](#dano-e-derrota-ex) e possivelmente outras mecânicas.

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| T1     | Obstáculos naturais                                        | +2     |
| T2     | Caminhos onde unidades se movem mais rápido                | +2     |
| T3     | Lugares que geram mais dinheiro para unidades produtoras   | +2     |
| T4     | Outros elementos puramente visuais                         | +2     |
| T5     | Carregar mapas da aventura no banco de dados               | +4     |

Basta apenas um tipo de elemento para cada um dos critérios T1, T2 e T3.

No critério T3, unidades que produzem dinheiro produzem mais se estão próximas
a certos elementos do mapa, como minhas de ouro.

No critério T4, deve haver pelo menos 3 elementos visuais.

### Invasores a**p**rimorados (Px)

Requer [variação de unidades](#variação-de-unidades-ux).

| Código | Critério                                                   | Valor  |
| ------ | ---------------------------------------------------------- | ------ |
| P1     | Teletransportam                                            | +3     |
| P2     | Criam outros invasores                                     | +3     |
| P3     | Roubam dinheiro                                            | +3     |
| P4     | Carregar essas informações do banco de dados               | +4     |

Nos critérios R1, R2 e R2, basta um invasor de cada tipo. Eles podem usar seus
poderes de tempos em tempos e/ou uma quantidade fixa de vezes.

### Conteúdo a**d**icional (Dx)

Toda unidade, fase, manobra, evolução, etc. que vocês fizerem além do requerido
nos critérios das tarefas valem +1 ponto nesta tarefa, contanto que sejam
significativamente diferentes do conteúdo já existente. Isto é, se os jogadores
tivessem que escolher entre eles, não deveria haver uma opção estritamente
melhor que a outra. Por exemplo, escolher entre uma unidade que causa mais dano
ou uma unidade mais rápida.

