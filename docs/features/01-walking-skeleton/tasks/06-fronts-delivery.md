# F01-T06 · Fronts published and talking to the API

**Status:** a fazer
**Repos:** `quita-backoffice-web`, `quita-debtor-portal-web`
**Bloqueada por:** F01-T03 · Shell composes the remotes at runtime, F01-T04 · Portal reads the API from the server, F01-T05 · API published with migration before deploy

## O que construir

Os quatro fronts são publicados na Vercel e conversam com a API publicada: o shell pelo proxy `/api/*` do próprio domínio, o portal pelo servidor. Cada PR roda lint, testes e build (no backoffice, só o que foi afetado), e a `main` dos dois repos é protegida.

## Critérios de aceite

- [ ] **CA1** · Um PR no backoffice roda `nx affected -t lint test build`; um que muda só o Analytics não reconstrói o Operações. (PRD CA10)
- [ ] **CA2** · Um PR no portal roda lint, tipos, testes e build. (PRD CA10)
- [ ] **CA3** · A `main` dos dois repos exige PR e checks verdes. (PRD CA11)
- [ ] **CA4** · Shell, Operações, Analytics e portal publicados na Vercel; o manifesto de produção do shell aponta para os endereços reais dos remotes e é servido sem cache. (PRD CA12)
- [ ] **CA5** · No ambiente publicado, `/api/actuator/health` responde pelo domínio do shell, e o shell e o portal mostram a API no ar. (PRD CA13)

## Como demonstrar

Os endereços públicos abertos no celular; a aba Network mostrando só domínios da Vercel.
