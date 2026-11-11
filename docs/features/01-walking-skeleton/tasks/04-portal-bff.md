# F01-T04 · Portal reads the API from the server

**Status:** a fazer
**Repos:** `quita-debtor-portal-web`
**Bloqueada por:** F01-T01 · API foundation running locally

## O que construir

O portal nasce pelo `create-next-app` e sua página inicial, renderizada no servidor, mostra se a API está no ar ou acordando. Todo acesso à API fica numa camada de servidor que quebra o build se for importada no cliente. O harness do repo é instalado.

## Critérios de aceite

- [ ] **CA1** · A página inicial mostra "API: no ar" com a API rodando, e nenhuma requisição do navegador vai ao domínio da API. (PRD CA8)
- [ ] **CA2** · Com a API parada, a página responde em até 5 s com "API: acordando", sem erro 500. (PRD CA9)
- [ ] **CA3** · Importar a camada de API num arquivo com `"use client"` quebra o build.
- [ ] **CA4** · Nenhuma variável `NEXT_PUBLIC_*`; `.env.example` versionado.
- [ ] **CA5** · Cores e fonte do design system aplicadas (fonte por `next/font`).
- [ ] **CA6** · Harness instalado (`AGENTS.md`, `CLAUDE.md`, `nextjs-rules`), com versões e comandos conferidos. (PRD CA16)

## Como demonstrar

Aba Network do navegador; parar a API e recarregar; o erro de build do import proibido.
