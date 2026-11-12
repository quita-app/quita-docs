---
status: aceita
---

# 0007 · Hospedagem gratuita em Vercel, Render e Neon, com proxy do mesmo site

Os quatro fronts ficam na Vercel, a API (com o gateway fake) num contêiner no Render e o PostgreSQL no Neon; o CI roda no GitHub Actions. Cada front chama a API pelo próprio domínio (proxy da Vercel no backoffice, servidor no portal), para o cookie de renovação nunca ser de terceiro. A combinação é gratuita, cobre os três tipos de app e mantém o número de plataformas baixo.

Descartadas: Koyeb (instância gratuita única e pequena, regras de cartão instáveis); Fly.io e Railway (sem camada gratuita de verdade); Postgres gratuito do Render (expira); chamar a API direto de outro domínio (cookie de terceiro bloqueado pelos navegadores).
Custo aceito: a API dorme depois de 15 minutos sem uso e leva cerca de 1 minuto para acordar; memória curta para a JVM.

Consequência para os jobs (2026-11-12): uma API dormindo nunca roda o job das 03:00. Os jobs continuam no processo (`@Scheduled`), e um workflow agendado do GitHub Actions no `quita-backend-api` chama `POST /api/v1/internal/jobs/run` a cada hora, o que acorda a API e roda os jobs devidos. Cada job trabalha por condição ("tudo o que venceu até agora"), então rodar atrasado ou duas vezes é seguro (LLD da API, seção 9). Com a API acordada o dia todo, um serviço gasta cerca de 744 das 750 horas gratuitas do Render no mês.
