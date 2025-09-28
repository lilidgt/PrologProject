:- [base_conhecimento].   % carrega as perguntas e trilhas
:- [motor_inferencia].    % carrega o motor do aluno 2

% Início da interação
iniciar :-
    writeln('=== Sistema Especialista de Trilhas ==='),
    writeln('Responda com sim. ou nao. e termine com ponto (.)'),
    coletar_respostas,                       % não precisamos guardar na lista, apenas assertz
    recomenda_trilha(ListaTrilhas),         % chama o predicado correto
    format('>> Trilha(s) recomendada(s): ~w~n', [ListaTrilhas]).

% Coleta todas as perguntas
coletar_respostas :-
    findall((Id, Texto, Perfil), pergunta(Id, Texto, Perfil), Perguntas),
    perguntar_lista(Perguntas).

% Percorre a lista de perguntas e armazena como fatos resposta/2
perguntar_lista([]).
perguntar_lista([(Id, Texto, Perfil)|T]) :-
    format('(~w) ~w ', [Perfil, Texto]),
    read(Resp),         % espera sim. ou nao.
    assertz(resposta(Id, Resp)),             % adiciona o fato dinamicamente
    perguntar_lista(T).
