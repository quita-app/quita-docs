# F01-T05 · API published with migration before deploy

**Status:** a fazer
**Repos:** `quita-backend-api`
**Bloqueada por:** F01-T01 · API foundation running locally

## O que construir

A API vira uma imagem de contêiner pequena e segura, roda no Render com 512 MB, conecta no Neon e é publicada a cada merge na `main`, com a migração aplicada antes do deploy. Um PR roda o build e os testes; a `main` é protegida.

## Critérios de aceite

- [ ] **CA1** · `docker run -m 512m` com a imagem sobe a API sem ser morta por falta de memória; a imagem roda com usuário não root.
- [ ] **CA2** · Um PR roda `./mvnw verify` (inclui Testcontainers); a `main` exige PR e o check verde. (PRD CA10, CA11)
- [ ] **CA3** · O merge na `main` aplica a migração pelo endpoint direto do Neon e depois aciona o deploy no Render. (PRD CA12)
- [ ] **CA4** · O health público do Render responde `UP` com o banco.
- [ ] **CA5** · Tempo de partida a frio e memória em repouso medidos e anotados no PR.

## Como demonstrar

O workflow verde no GitHub; `curl` no endereço público do health; os números medidos.
