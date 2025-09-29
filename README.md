# RA1 – Sistema Especialista em Prolog  
Disciplina: Programação Lógica e Funcional  
Professor: Frank  
Estudantes:
- Andressa de Oliveira Barros – Parte 1 e Parte 2 (base de conhecimento e motor de inferência)  
- Melissa Weiss Perussulo – Parte 3 (interface interativa: perguntas e coleta de respostas)  
- Lissa Deguti – Parte 4 (testes automatizados, validação e GitHub)  

## Objetivo
Desenvolver um sistema especialista em Prolog que auxilie estudantes a escolher uma trilha acadêmica de especialização em tecnologia.  

## Estrutura dos Arquivos
- base_conhecimento.pl -> trilhas, perfis (características + pesos) e perguntas  
- motor_inferencia.pl -> motor lógico (cálculo de pontos e recomendação)  
- interface.pl -> interação no modo manual (usuário responde perguntas)  
- testes.pl -> execução automática de perfis de teste  
- perfil_1.pl, perfil_2.pl, perfil_3.pl -> respostas pré-definidas de alunos fictícios para validação  

------

## Requisitos
- [SWI-Prolog](https://www.swi-prolog.org/)  
- Testado em: `SWI-Prolog version 9.2.9 for arm64-darwin` (macOS via Homebrew)
- Testado em: Windows 

## Execução

### Modo Interativo (Windows)
1. Abra o SWI-Prolog.  
2. Troque para a pasta do projeto (ajuste o caminho para o local onde você salvou) com o comando:  
    cd('C:/Users/melis/OneDrive/Desktop/Prolog').
3. Carregue a iterface:
    [interface].
4. Inicie o sistema:
    iniciar

Fluxo:
- Exibe as perguntas.
- Usuário responde com sim. ou nao.
- Mostra a trilha recomendada, pontuação, e justificativas.

Comandos adicionais:
- Mostrar melhor trilha diretamente:
    recomenda_melhor_trilha(Nome, Descricao, PontuacaoTotal, Justificativas).
- Calcular pontuação de uma trilha específica:
    pontuacao_trilha(desenvolvimento_software, P, Justificativas).
- Limpar respostas antes de rodar de novo:
    retractall(resposta(_, _)).
    
 ### Modo Testes (Windows)
1. Abra o SWI-Prolog.  
2. Troque para a pasta do projeto (ajuste o caminho para o local onde você salvou) com o comando:  
    cd('C:/Users/melis/OneDrive/Desktop/Prolog').
3. Carregue os testes:
    [testes].
4. a) Todos os perfis de uma vez:
    rodar_todos_testes.
4. b) Perfil individualmente:
    rodar_p1.
    rodar_p2.
    rodar_p3.

Se precisar limpar respostas antes de rodar novamente:
    retractall(resposta(_, _)).

## Resultados Esperados
- perfil_1.pl -> empate entre desenvolvimento_software e desenvolvimento_web
- perfil_2.pl -> recomendação: ux_ui_design
- perfil_3.pl -> recomendação: inteligencia_artificial

## Github
https://github.com/lilidgt/PrologProject
