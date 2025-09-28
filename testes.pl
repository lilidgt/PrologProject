% testes.pl — runner
:- dynamic resposta/2.

:- [base_conhecimento].
:- [motor_inferencia].

% Limpar respostas
limpar_respostas :-
    retractall(resposta(_, _)).

% Carrega perfil
carrega_perfil(ArquivoPerfil) :-
    limpar_respostas,
    ensure_loaded(ArquivoPerfil).

% Monta ranking (maior p menor)
ranking_trilhas(RankingOrdenado) :-
    findall(Trilha-Pontos,
            ( trilha(Trilha, _),
              pontuacao_trilha(Trilha, Pontos, _) ),
            Pares),
    sort(2, @>=, Pares, RankingOrdenado).

% Gera relatório final de um perfil
relatorio_perfil(ArquivoPerfil) :-
    % 1. Carrega o arquivo de perfil
    carrega_perfil(ArquivoPerfil),

    % 2. Obtém o ranking de todas as trilhas
    ranking_trilhas(Rank),

    % 3. Imprime o cabeçalho e o ranking
    format('~n--- RESULTADO para ~w ---\n', [ArquivoPerfil]),
    writeln('Ranking (alto -> baixo):'),
    forall(member(T-P, Rank), format(' - ~w: ~w pontos\n', [T,P])),

    % 4. Verifica se existe uma recomendação
    ( recomenda_melhor_trilha(Trilha, Descricao, _, Justificativas)
    -> ( format('Recomendacao: ~w - ~w\n', [Trilha, Descricao]),
         writeln('Justificativas:'),
         forall(member(J, Justificativas), format(' - ~w\n', [J]))
       )
    ;  writeln('Recomendacao: [nenhuma encontrada]')
    ).

% Rodar todos os perfis
rodar_todos_testes :-
    relatorio_perfil('perfil_1.pl'),
    relatorio_perfil('perfil_2.pl'),
    relatorio_perfil('perfil_3.pl').

% Rodar perfis individualmente
rodar_p1 :- relatorio_perfil('perfil_1.pl').
rodar_p2 :- relatorio_perfil('perfil_2.pl').
rodar_p3 :- relatorio_perfil('perfil_3.pl').
