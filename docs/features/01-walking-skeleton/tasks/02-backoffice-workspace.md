# F01-T02 · Backoffice workspace with enforced boundaries

**Status:** a fazer
**Repos:** `quita-backoffice-web`
**Bloqueada por:** Nenhuma

## O que construir

O monorepo Nx nasce com os três apps (shell e Operações em Angular, Analytics em React + Vite) e as libs da seção 2 do LLD do backoffice, vazias e agrupadas por domínio, cada uma com as tags de camada, domínio e framework. A regra de fronteira entre libs barra imports proibidos. Os tokens do design system existem como CSS custom properties numa lib compartilhada. O harness do repo é instalado.

## Critérios de aceite

- [ ] **CA1** · Os três apps sobem localmente, cada um na própria porta. (PRD CA3, parte do backoffice)
- [ ] **CA2** · `nx graph` mostra os projetos e as dependências da seção 2 do LLD.
- [ ] **CA3** · Um import de `libs/analytics/ui` dentro de um projeto Angular, feito de propósito, faz o `nx lint` falhar. (PRD CA15)
- [ ] **CA4** · Shell e Operações são standalone e zoneless.
- [ ] **CA5** · `libs/shared/design-tokens` com os tokens do `design/DESIGN.md`; uma página de cada app usa a cor e a fonte do design system.
- [ ] **CA6** · Harness instalado (`AGENTS.md`, `CLAUDE.md`, `angular-rules`, `react-rules`), com versões e comandos conferidos. (PRD CA16)

## Como demonstrar

`npx nx graph`; o import proibido e o erro do lint; os três apps no navegador.
