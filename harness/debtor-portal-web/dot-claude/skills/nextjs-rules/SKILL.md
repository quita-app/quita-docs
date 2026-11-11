---
name: nextjs-rules
description: Convenções de Next.js e React do quita-debtor-portal-web (App Router, Server e Client Components, BFF, Server Actions, cache, cookies, acessibilidade, desempenho, testes). Use ao escrever, revisar ou discutir código deste repo.
---

# Regras da stack: Next.js (portal)

Valem para todo o `quita-debtor-portal-web`. A origem é o LLD do portal (`../quita-docs/docs/lld/portal.md`); quando divergir, vale o LLD. Use só APIs atuais do App Router; o que é legado aparece na última seção.

## Servidor e cliente

- Server Component por padrão. `"use client"` só em arquivos-folha com estado, evento, efeito ou API do navegador.
- Client Component não importa Server Component: recebe-o como `children`.
- O que atravessa a fronteira como prop é serializável e **mínimo**: só os campos que a tela usa, nunca o objeto inteiro da API.
- Nada de `window`, `Date.now()`, `Math.random()` ou `localStorage` no render (erro de hidratação). Datas e dinheiro são formatados no servidor, com fuso de São Paulo fixo.

## Rotas

- `params` e `searchParams` são Promises: sempre `await`.
- Cada página dinâmica tem `loading.tsx` (esqueleto com a altura do conteúdo) e `error.tsx`; slug ou recurso inexistente chama `notFound()`.
- Grupos `(public)` e `(authenticated)`; rotas autenticadas com `noindex`.
- `proxy.ts` só para checagem barata (existe sessão?) e cabeçalhos de segurança. A validação de verdade é a da API.

## Dados e cache

- Busca no servidor, em Server Component `async`, pela `lib/api`. Buscas independentes em paralelo; `<Suspense>` por bloco visual para streaming.
- **Dado do Devedor nunca é cacheado.** `"use cache"` + `cacheTag` só para o que é público e igual para todos (marca da Credora, `creditor:<slug>`); função com cache não lê `cookies()`.
- `React.cache` para não repetir a mesma leitura no `layout`, na `page` e no `generateMetadata`.
- Depois de mutar, invalidar o que envelheceu (`revalidatePath`/`revalidateTag`) **antes** do `redirect`.

## BFF

- Todo acesso à API em `src/lib/api/`, com `import 'server-only'`, timeout, novas tentativas com intervalo crescente e erro tipado pelo `code`.
- Nenhuma variável `NEXT_PUBLIC_*`. O endereço da API e os tokens não chegam ao navegador.
- Tokens em cookies `HttpOnly`, `Secure`, `SameSite=Lax`. Cookie só é gravado em Server Action, route handler ou `proxy`.
- **Server Action para mudança; route handler (`app/bff/`) para leitura interativa** que precisa ser cancelável (simulação, status do Pix).
- Server Action e route handler são **rotas públicas**: validam a entrada com Zod e a sessão em toda chamada. Ids nunca são confiados: a API confere o dono.

## Formulários e mutações

- `<form action={serverAction}>` com `useActionState` e `useFormStatus`; o formulário de acesso e o de confirmação funcionam sem JavaScript.
- O mesmo schema Zod no cliente e no servidor.
- Erro esperado é **valor de retorno** (união discriminada com o `code`); erro inesperado é exceção e cai no `error.tsx`. `redirect()` fora de `try/catch`.
- Criação com efeito leva uma chave de idempotência gerada **uma vez por intenção**, no servidor.
- Nada de afirmar resultado de dinheiro de forma otimista: o otimista é "em processamento", nunca "pago".
- O portal nunca calcula dinheiro: envia a escolha, exibe o que a API devolver.

## Interação no cliente

- Requisição em efeito sempre com `AbortController` e limpeza; `AbortError` não é erro de tela.
- `useDeferredValue`/`useTransition` para manter a entrada responsiva; mostrar o último resultado válido enquanto recalcula.
- Polling com fim definido, só com a aba visível, sem sobrepor chamadas, e com limpeza completa.
- Lógica reutilizável em custom hook, testado com relógio falso.

## Acessibilidade e desempenho

- WCAG 2.2 AA: rótulo em todo campo, erro ligado ao campo e anunciado, foco movido ao trocar de etapa, alvo de toque ≥ 44 px, controle deslizante por teclado com `aria-valuetext`.
- Animação só em `prefers-reduced-motion: no-preference`.
- `next/font` para a fonte, `next/image` para o logo (com `priority` no que é LCP); código pesado e secundário com `next/dynamic`.
- Orçamento: LCP < 2,5 s em 4G e nota 100 em Acessibilidade no Lighthouse CI.
- Sem vermelho como cor principal de estado e sem linguagem que constranja (CDC, art. 42); textos do `ux-writing.md`.

## Testes

- Vitest para schemas, formatação e a função de chamada à API; Testing Library + MSW para Client Components.
- Server Component assíncrono é coberto no ponta a ponta (Playwright, viewport de celular, com axe).
- Sem espera fixa (`waitForTimeout`): esperar por estado visível.

## Legado: reconhecer, não escrever

Pages Router (`getServerSideProps`, `getStaticProps`, `_app`), `middleware.ts` (hoje `proxy.ts`), `useEffect` + `fetch` para dado que o servidor pode buscar, API routes em `pages/api`, `next/head`.
