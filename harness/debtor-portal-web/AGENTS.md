# AGENTS.md: quita-debtor-portal-web

Portal do devedor do **Quita**, uma plataforma B2B de cobrança e renegociação de dívidas. É o site público, pensado para celular, em que o Devedor entra com CPF e código, vê as Dívidas, simula, fecha o Acordo e paga por Pix. É uma aplicação Next.js (App Router) com duas metades: o **front** (as telas) e o **BFF** (a camada de servidor que fala com a API). **O navegador nunca fala com a API.**

## Onde está o contexto

Os repos do Quita ficam lado a lado na mesma pasta. A documentação é do `quita-docs` e **não é copiada para cá**.

| Preciso de | Leia |
| --- | --- |
| Vocabulário do domínio | `../quita-docs/GLOSSARY.md` (importado pelo `CLAUDE.md`) |
| Rotas, renderização, sessão, formulários, cache | `../quita-docs/docs/lld/portal.md` |
| Contrato da API e códigos de erro | `../quita-docs/docs/lld/api.md`, seção 7 |
| Identidade visual, tokens e componentes | `../quita-docs/design/DESIGN.md` |
| Textos de tela e mapa de erros → texto | `../quita-docs/design/ux-writing.md` |
| Telas aprovadas e estados | `../quita-docs/design/hi-fi/`, `../quita-docs/design/prompts/portal/` |
| A funcionalidade e a tarefa em andamento | `../quita-docs/docs/features/<NN>-<title>/` |

## Stack

Next.js (App Router) · React 19 · TypeScript · Tailwind · Zod · `openapi-typescript` · Vitest + Testing Library + MSW · Playwright + axe · Lighthouse CI.

Sem biblioteca de estado global nem de cache no cliente: o servidor entrega os dados.

Versões fixadas: <!-- preencher no walking skeleton: Next.js, React -->

## Comandos

<!-- conferir no walking skeleton com o que o create-next-app gerou -->

| Para | Comando |
| --- | --- |
| Servidor de desenvolvimento | `npm run dev` |
| Lint | `npm run lint` |
| Tipos | `npx tsc --noEmit` |
| Testes | `npm test` |
| Build | `npm run build` |
| Ponta a ponta | `npx playwright test` |
| Gerar os tipos da API | <!-- preencher: openapi-typescript a partir do openapi.json da API --> |

A API local precisa estar rodando (`../quita-backend-api`); o endereço vem de `API_INTERNAL_URL` no `.env.local`.

## Estrutura

```
src/
  app/
    page.tsx                         página do Quita (estática)
    c/[slug]/
      layout.tsx                     marca da Credora e tema
      (public)/                      página da Credora, access, access/verify
      (authenticated)/               debts, agreements (noindex)
      @modal/                        detalhamento do valor (rota interceptada)
    bff/                             route handlers: leituras interativas do navegador
  lib/
    api/                             único ponto de contato com a API (server-only)
    schemas/                         schemas Zod, usados no cliente e no servidor
  components/                        componentes de tela
proxy.ts                             proteção de rotas e cabeçalhos de segurança
```

Nomes de pasta e de arquivo em inglês.

## Convenções

- **Idioma:** código, nomes, comentários, commits e branches em inglês. Textos de tela em pt-BR, vindos do `ux-writing.md`.
- **Server Component é o padrão.** `"use client"` só nas folhas que têm interação.
- **API só pelo servidor:** todo acesso passa por `src/lib/api/`, que importa `server-only`. Nenhuma variável `NEXT_PUBLIC_*`.
- **Tokens só em cookies `HttpOnly`** do portal; nenhuma resposta ao navegador contém token.
- **Mudança de dado** por Server Action; **leitura interativa** (simulação, status do Pix) por route handler em `app/bff/`.
- **Dinheiro:** chega como string e é só formatado. **O portal nunca calcula dinheiro.**
- **Dado do Devedor nunca vai para cache compartilhado.** Cache só no que é público e igual para todos (página e marca da Credora).
- **Erros:** decidir pelo `code` da API; erro esperado é valor de retorno, inesperado é exceção.
- **Acessibilidade WCAG 2.2 AA** e orçamento de desempenho (LCP < 2,5 s em 4G) são requisitos, verificados no CI.
- **Commits** semânticos, em inglês, uma frase. Commit, push e PR só a pedido.
- **Branches:** `main` protegida + `feat/*`, `fix/*`, `chore/*`, `docs/*`, `test/*`.

As regras detalhadas estão na skill `nextjs-rules` (`.claude/skills/nextjs-rules/`).

## Antes de dar uma tarefa por pronta

1. `npm run lint`, `npx tsc --noEmit`, `npm test` e `npm run build` verdes.
2. Estados da tela conferidos com o hi-fi, em viewport de celular.
3. Formulário funciona com JavaScript desligado, quando a tela é de acesso ou de confirmação.
4. Uso por teclado, foco gerenciado ao trocar de etapa, erros anunciados.
5. Nenhuma chamada do navegador ao domínio da API.
