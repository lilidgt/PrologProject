:- [base_conhecimento].
:- [motor_inferencia].  % motor intacto
:- dynamic resposta/2.   
iniciar :-
    writeln('=== Sistema Especialista de Trilhas ==='),
    writeln('Responda com sim. ou nao. e termine com ponto (.)'),
    coletar_respostas,
    recomenda_melhor_trilha(Nome, Desc, Pts, Just),
    format('>> Trilha recomendada: ~w~n', [Nome]),
    format('>> Descrição: ~w~n', [Desc]),
    format('>> Pontuação: ~w~n', [Pts]),
    format('>> Justificativas: ~w~n', [Just]).

coletar_respostas :-
    findall((Id, Texto, Perfil), pergunta(Id, Texto, Perfil), Perguntas),
    perguntar_lista(Perguntas).

perguntar_lista([]).
perguntar_lista([(Id, Texto, Perfil)|T]) :-
    format('(~w) ~w ', [Perfil, Texto]),
    read(RawResp),                      % lê input do usuário
    normaliza_resposta(RawResp, Resp),  % transforma em s/n
    assertz(resposta(Id, Resp)),        % grava fato
    perguntar_lista(T).

% normaliza inputs
normaliza_resposta(s, s).
normaliza_resposta(sim, s).
normaliza_resposta(n, n).
normaliza_resposta(nao, n).
