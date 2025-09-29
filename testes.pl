%testes.pl — runner
:- dynamic resposta/2.

:- [base_conhecimento].
:- [motor_inferencia].


%limpar
limpar_respostas :-
    retractall(resposta(_, _)).

%carrega perfil
carrega_perfil(ArquivoPerfil) :-
    limpar_respostas,
    ensure_loaded(ArquivoPerfil).

%monta ranking (maior p menor)
ranking_trilhas(RankingOrdenado) :-
    findall(T-P,
        ( trilha(T,_),
          pontuacao_trilha(T, P, _) 
        ),
        Pares),
    sort(2, @>=, Pares, RankingOrdenado).

% predicado 'relatorio_perfil' gera relatório final.
relatorio_perfil(ArquivoPerfil) :-
    %carrega arquivo de perfil.
    carrega_perfil(ArquivoPerfil),

    %pega ranking de todas as trilhas.
    ranking_trilhas(Rank),

    %imprime cabeçalho e ranking.
    format('~n--- RESULTADO para ~w ---\n', [ArquivoPerfil]),
    writeln('Ranking (alto -> baixo):'),
    forall(member(T-P, Rank), format(' - ~w: ~w pontos\n', [T,P])),

    % Verifica se existe uma recomendação.
    (   recomenda_melhor_trilha(Trilha, Descricao, _, Justificativas)  % antigo recomenda_trilha/1 -> recomenda_melhor_trilha/4
    ->  (   % Se sim, imprime a recomendação e suas justificativas.
            format('Recomendacao: ~w - ~w\n', [Trilha, Descricao]),
            writeln('Justificativas:'),
            forall(member(J, Justificativas), format(' - ~w\n', [J]))
        )
    ;   % Se não, imprime uma mensagem padrão.
        writeln('Recomendacao: [nenhuma encontrada]')
    ).

%tds os perfis
rodar_todos_testes :-
    relatorio_perfil('perfil_1.pl'),
    relatorio_perfil('perfil_2.pl'),
    relatorio_perfil('perfil_3.pl').

%individualmente
rodar_p1 :- relatorio_perfil('perfil_1.pl').
rodar_p2 :- relatorio_perfil('perfil_2.pl').
rodar_p3 :- relatorio_perfil('perfil_3.pl').
