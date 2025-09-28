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
          calcula_total_pontos(T, P)
        ),
        Pares),
    sort(2, @>=, Pares, RankingOrdenado).

%imprime bloco de relatório para um perfil
relatorio_perfil(ArquivoPerfil) :-
    carrega_perfil(ArquivoPerfil),
    ranking_trilhas(Rank),
    format('~n-˜-˜-˜- RESULTADO para ~w -˜-˜-˜-\n', [ArquivoPerfil]),
    writeln('Ranking (alto -> baixo):'),
    forall(member(T-P, Rank), format(' - ~w: ~w pontos\n', [T,P])),
    (   recomenda_trilha(TrilhasTop)
    ->  format('Recomendacao: ~w\n', [TrilhasTop])
    ;   writeln('Recomendacao: [nenhuma encontrada]')
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
