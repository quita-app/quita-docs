# F01-T01 · API foundation running locally

**Status:** a fazer
**Repos:** `quita-backend-api`
**Bloqueada por:** Nenhuma

## O que construir

A API nasce pelo Spring Initializr, sobe no perfil local contra o PostgreSQL do Docker Compose e responde o health check lendo o banco. A primeira migração cria os schemas dos módulos, e os pacotes dos nove módulos existem com as fronteiras verificadas por teste. O harness do repo é instalado.

## Critérios de aceite

- [ ] **CA1** · `docker compose up` no `quita-backend-api` sobe o PostgreSQL; a API no perfil `local` responde `UP` em `/actuator/health`, com o componente `db`. (PRD CA1)
- [ ] **CA2** · Com o banco parado, o health responde `DOWN` (503) em poucos segundos, sem travar.
- [ ] **CA3** · A migração criou os nove schemas e a extensão `pg_trgm`; `flyway_schema_history` registra a versão. (PRD CA2)
- [ ] **CA4** · `ModularityTests` passa, e um import de `internal` entre módulos, feito de propósito, o faz falhar. (PRD CA14)
- [ ] **CA5** · O teste de contexto sobe a aplicação contra um PostgreSQL do Testcontainers.
- [ ] **CA6** · `openapi.json` gerado e versionado; `.env.example` no repo; nenhum segredo commitado.
- [ ] **CA7** · Harness instalado (`AGENTS.md`, `CLAUDE.md`, `spring-rules`), com as versões fixadas preenchidas. (PRD CA16)

## Como demonstrar

`curl localhost:8080/actuator/health`, parar o contêiner do banco e repetir; `./mvnw verify` verde.
