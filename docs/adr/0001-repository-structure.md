---
status: aceita
---

# 0001 · Quatro repositórios, com o backoffice em monorepo Nx

O sistema fica em quatro repos lado a lado: `quita-docs` (documentação e planejamento), `quita-backoffice-web` (monorepo Nx com o shell e os remotes), `quita-debtor-portal-web` (Next.js) e `quita-backend-api` (Spring Boot). O backoffice é um produto só, para o mesmo público, e o shell muda junto com os remotes; o portal e a API têm público, requisitos e ciclo de publicação próprios. A documentação é do sistema inteiro e não pertence a nenhum repo de código.

Descartadas: um monorepo com tudo (mistura Java e três ferramentas de front num só pipeline e esconde as fronteiras); um repo por app, seis no total (custo de versionar contratos e manter seis pipelines para uma pessoa só); documentação dentro de um repo de código (os outros dependeriam dele sem ser donos).
Custo aceito: contratos entre repos (API e tokens visuais) precisam de versão e de um processo de atualização; os repos dependem de ficar lado a lado na mesma pasta.
