/*Motor de Inferência*/
% Caso 1: Se a resposta for 's', calcula a pontuação com o peso.
calcula_ponto_perfil(Caracteristica, Pontuacao) :-
    pergunta(ID, _, Caracteristica), % Procura a pergunta que tem relação com a caracteristica
    resposta(ID, s),                 % Com o ID da pergunta e se a resposta for sim
    perfil(_, Caracteristica, Pontuacao). % Procura o peso da caracteristica caso a resposta for sim

% Caso 2: Se a resposta for 'n', a pontuação é 0.
calcula_ponto_perfil(Caracteristica, 0) :-
    pergunta(ID, _, Caracteristica), % Procura a pergunta que tem relação com a caracteristica
    resposta(ID, n).                 % Com o ID da pergunta vemos que a resposta é não então irá ser somado 0

%Calcular o total de pontos de cada trilha
calcula_total_pontos(Trilha, PontuacaoTotal) :-
    findall(Pontos, % Defino o que quero encontrar
            (perfil(Trilha, Caracteristica, _), % Procuro todas as caracteristicas de cada trilha
            calcula_ponto_perfil(Caracteristica, Pontos)), % Chamo o predicado que preenche a lista com pontos baseados nas respostas do usuário
            ListaDePontos), % Onde irei guardar meus pontos nesta lista
    sumlist(ListaDePontos, PontuacaoTotal). % Soma todos os elementos da lista e retorna em PontuacaoTotal

% Primeiro vou encontrar a pontuacao maxima:
encontra_pontuacao_maxima(PontuacaoMaxima) :-
    findall(PontuacaoTotal,
            (trilha(Trilha, _), % Para cada trilha que encontrar
             calcula_total_pontos(Trilha, PontuacaoTotal)), % Pega o total de pontos desta trilha
            ListaPontosTrilhas), % Armazena numa lista o total dos pontos encontrados
    max_list(ListaPontosTrilhas, PontuacaoMaxima). % Encontra a pontuação máxima na lista

% Predicado que lista todas as pontuações (ajuda no debug)
listar_todas_pontuacoes(Lista) :-
    findall(Trilha-Pontos,
            (trilha(Trilha,_),
             calcula_total_pontos(Trilha, Pontos)),
            Lista).

% Auxiliar para extrair a maior pontuação da lista
max_lista_pontuacoes(Lista, Max) :-
    findall(P, member(_-P, Lista), Pontuacoes),
    max_list(Pontuacoes, Max).

% Agora irei ver qual trilha é recomendada para o usuário
recomenda_trilha(ListaTrilhasRecomendadas) :-
    listar_todas_pontuacoes(Lista),
    max_lista_pontuacoes(Lista, PontuacaoMaxima),
    findall(Trilha,
            member(Trilha-PontuacaoMaxima, Lista),
            ListaTrilhasRecomendadas).
