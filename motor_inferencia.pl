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
% O predicado 'pontuacao_trilha' calcula a pontuação total e
% coleta as justificativas para uma trilha específica.
pontuacao_trilha(NomeTrilha, PontuacaoTotal, Justificativas) :-
    % 1. Calcula a pontuação total da trilha.
    % Coleta a pontuação de cada habilidade...
    findall(Pontos,
            ( perfil(NomeTrilha, Habilidade, _),
              calcula_ponto_perfil(Habilidade, Pontos) 
            ),
            ListaPontos),
    % ...e soma os pontos da lista para obter o total.
    sumlist(ListaPontos, PontuacaoTotal),
    
    % 2. Coleta as justificativas.
    % Encontra e lista o texto das perguntas que tiveram pontuação maior que 0.
    findall(TextoPergunta,
            ( perfil(NomeTrilha, Habilidade, _),
              pergunta(_, TextoPergunta, Habilidade),
              calcula_ponto_perfil(Habilidade, Pontos),
              Pontos > 0
            ),
            Justificativas).

% O predicado 'recomenda_melhor_trilha' encontra a trilha com a
% maior pontuação e sua descrição.
recomenda_melhor_trilha(NomeTrilha, Descricao, PontuacaoTotal, Justificativas) :-
    % 1. Coleta a pontuação de todas as trilhas.
    findall(NomeTrilhaTemp-Pontos-Just,
            ( pontuacao_trilha(NomeTrilhaTemp, Pontos, Just) ),
            ListaPontuacoes),
            
    % 2. Encontra a trilha com a pontuação mais alta.
    % Ordena a lista de pontuações em ordem decrescente.
    % E unifica a 'NomeTrilha' e a 'PontuacaoTotal' com o primeiro item da lista (o mais alto).
    sort(2, @>=, ListaPontuacoes,
         [NomeTrilha-PontuacaoTotal-Justificativas | _]),
         
    % 3. Busca a descrição da trilha que foi recomendada.
    trilha(NomeTrilha, Descricao).
