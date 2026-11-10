---
status: aceita
---

# 0007 · Hospedagem gratuita em Vercel, Render e Neon, com proxy do mesmo site

Os quatro fronts ficam na Vercel, a API (com o gateway fake) num contêiner no Render e o PostgreSQL no Neon; o CI roda no GitHub Actions. Cada front chama a API pelo próprio domínio (proxy da Vercel no backoffice, servidor no portal), para o cookie de renovação nunca ser de terceiro. A combinação é gratuita, cobre os três tipos de app e mantém o número de plataformas baixo.

Descartadas: Koyeb (instância gratuita única e pequena, regras de cartão instáveis); Fly.io e Railway (sem camada gratuita de verdade); Postgres gratuito do Render (expira); chamar a API direto de outro domínio (cookie de terceiro bloqueado pelos navegadores).
Custo aceito: a API dorme depois de 15 minutos sem uso e leva cerca de 1 minuto para acordar; memória curta para a JVM.
