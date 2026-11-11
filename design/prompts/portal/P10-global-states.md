# P10 · Estados globais do portal

**App:** portal · **Rota:** todas · **Tamanhos:** celular

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
