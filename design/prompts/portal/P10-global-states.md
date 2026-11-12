# P10 · Estados globais do portal

**App:** portal · **Rota:** todas · **Tamanhos:** celular

## Na história

- **Ator e papel:** Ana, a devedora, quando algo sai do caminho: erro, carregamento, sessão expirada, link inválido.
- **História:** Como devedora, quero entender o que aconteceu e o que fazer, para não desistir no meio.
- **Momento:** Pode aparecer em qualquer tela do portal (P01 a P09).
- **O que a tela precisa deixar claro:**
  - Cada estado diz o que houve sem culpar a Ana e oferece um próximo passo.
  - O tom continua o da credora que quer ajudar, nunca o de cobrança.

## Objetivo

Desenhar uma vez os estados que podem aparecer em qualquer tela, para todas falarem a mesma língua.

## Estados

1. **Servidor acordando:** a API dorme na hospedagem gratuita e pode levar até 1 minuto. Depois de alguns segundos, o esqueleto dá lugar a "Estamos preparando suas informações. Isso pode levar alguns segundos.", com um indicador calmo. Honesto, sem fingir progresso.
2. **Sessão encerrada por inatividade** (15 minutos): "Por segurança, sua sessão foi encerrada. Entre de novo para continuar." com **Entrar de novo**.
3. **Erro inesperado:** o que aconteceu, o que fazer e um código curto para suporte ("Código: 7F3A-21").
4. **Sem conexão:** "Você está sem internet. Assim que a conexão voltar, tentamos de novo."
5. **Toasts** de sucesso e de erro no padrão do design system.
6. **Página 404** genérica do portal.

## Notas

- Nenhum desses estados usa vermelho como cor principal nem ícone de alerta gritante.
