---
name: to-spec
description: Transforma o PRD aprovado de uma funcionalidade do Quita numa spec técnica (contrato da API, mudanças de schema, decisões por repo, pontos de teste) e grava em docs/features/<NN>-<title>/spec.md. Use depois do PRD, quando o usuário pedir a spec ou "como vamos construir a F<NN>".
---

# Spec de uma funcionalidade

A spec diz **como** a funcionalidade será construída, no nível de decisão: o contrato entre os repos, o que muda no banco, que partes de cada app são tocadas e onde ela será testada. Ela não entrevista: sintetiza o PRD, os LLDs e o que já foi conversado. Dúvida que apareça aqui volta para o PRD ou vira uma pergunta direta ao usuário.

## Antes de escrever: ler

1. O `prd.md` da funcionalidade (precisa estar aprovado).
2. Os LLDs das frentes tocadas e os ADRs citados neles.
3. O estado atual do código de cada repo tocado (`../quita-backend-api`, `../quita-backoffice-web`, `../quita-debtor-portal-web`), quando já existir: o que pode ser reaproveitado.
4. O `openapi.json` versionado da API, quando existir.

## Princípios

- **Contrato primeiro.** Uma funcionalidade que toca API e front começa pelo contrato: rotas, corpos, respostas e códigos de erro. A API publica o `openapi.json`; os fronts geram os tipos a partir dele (ADR 0011).
- **Um fato, um lugar.** O que já está num LLD não é copiado: a spec aponta. O que a spec decide e muda um LLD é corrigido **no LLD**.
- **Vocabulário do `GLOSSARY.md`** em tudo; nomes de código em inglês.
- **Sem caminho de arquivo nem código de implementação.** Entram só formas que carregam decisão: um corpo de requisição, um estado, uma coluna.

## Estrutura

Grave em `docs/features/<NN>-<title>/spec.md`:

```markdown
# Spec: F<NN> · <Nome da funcionalidade>

<data> · <autor> · Status: rascunho · PRD: [prd.md](prd.md)

## Visão geral

Um parágrafo: o caminho de ponta a ponta, de quem clica até o banco e de volta. Um diagrama de sequência (Mermaid) quando houver mais de dois participantes ou evento entre módulos.

## Contrato da API

Para cada rota nova ou alterada: método e caminho · quem pode chamar · corpo · resposta · códigos de erro (`code`) com os dados extras. Eventos de tempo real (SSE), se houver: nome e conteúdo.

## Dados

Tabelas e colunas novas ou alteradas, restrições e índices, com a consulta que cada índice atende. Mudança que quebra quem já lê: os passos de expandir e contrair.

## Decisões por repo

### quita-backend-api
Módulos tocados, agregados e transições, eventos publicados e escutados, portas novas, jobs.

### quita-backoffice-web  /  quita-debtor-portal-web
Rotas e telas, onde mora cada estado (servidor, tela, URL, formulário, sessão), componentes reutilizados e novos, tratamento de cada `code` de erro.

(só os repos que a funcionalidade toca)

## Decisões de teste

- Os pontos de teste (o mais alto possível em cada repo) e o que cada um prova.
- Os casos numéricos obrigatórios, quando houver cálculo.
- O que entra no ponta a ponta.

## Fora de escopo

## Decisões tomadas aqui

Tabela: decisão · alternativa descartada · por quê. Decisão difícil de reverter, surpreendente e com trade-off real vira ADR (skill `domain-modeling`).

## Questões em aberto
```

## Fechamento

1. Confirme com o usuário os pontos de teste e as decisões da tabela.
2. Aprovada, troque o Status para `aprovado` e o status da funcionalidade no `docs/roadmap.md` para `em spec`.
3. Corrija nos LLDs o que a spec mudou (rota nova no índice, coluna nova, código de erro novo).

Commit só a pedido.
