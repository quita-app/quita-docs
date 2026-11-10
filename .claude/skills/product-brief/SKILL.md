---
name: product-brief
description: Conduz a entrevista do product brief do Quita, uma rodada por seção, e grava docs/product-brief.md a partir do molde. Use quando o usuário pedir para criar, refinar ou revisar o product brief, o escopo do MVP ou o "o quê e para quem" do produto.
---

# Product brief por entrevista

Esta skill transforma os requisitos de negócio do Quita num product brief, entrevistando o usuário. O molde está em `assets/product-brief.md`: o comentário HTML de cada seção diz o que perguntar e o que conta como seção bem preenchida.

O brief diz **o quê e para quem**. Arquitetura, telas e implementação ficam fora; se o usuário começar a descrevê-los, anote o que servir ao escopo e diga em que documento aquilo vai morar (HLD, LLD, design system).

## Antes de começar

1. Leia `assets/product-brief.md` inteiro.
2. Leia `docs/foundation/business-requirements.md` e `docs/foundation/master-plan.md`. Eles já respondem boa parte das seções: não repita perguntas respondidas, **confirme** o que entendeu ("O documento diz X. Mantemos?").
3. O destino é `docs/product-brief.md`. Se já existir, mostre e pergunte se é revisão ou recomeço; nunca sobrescreva sem aviso.
4. Na abertura, pergunte só o que falta: o nome do autor para o cabeçalho.

## A entrevista

Percorra as seções do molde na ordem, **uma rodada por seção**:

- Nomeie a seção e diga em uma frase para que ela serve.
- Faça de 1 a 4 perguntas numeradas. Quando houver base nos documentos de `docs/foundation/`, dê a sua sugestão; sem base (orçamento, autor), pergunte direto, porque uma sugestão inventada e aceita com "ok" vira fato.
- Espere as respostas antes da próxima seção.
- Se uma resposta desatualizar um texto já combinado, atualize na hora e avise em uma linha.

### Seções que pedem cuidado

- **Objetivos e métricas de sucesso:** de 3 a 6 métricas, cada uma com meta e prazo. O Quita é um projeto de portfólio sem dados reais: diga que as metas do produto são hipóteses, e inclua métricas de entrega do projeto (ex.: MVP publicado até a data X).
- **Requisitos não funcionais e restrições:** confira se cada linha diz **o que** se exige ou **como** fazer. A stack (Angular, Next.js, React, Spring Boot, micro front-ends) é uma restrição imposta: registre-a assim.
- **Alternativas e concorrentes:** use as referências de `business-requirements.md`. Não invente preços nem números; o que não for confirmado fica "A definir", com a pesquisa em "Questões em aberto".
- **Riscos, dependências e premissas:** inclua os riscos do projeto (escopo grande para uma pessoa, prazo de 2 meses, curva de aprendizado de Nx e MFE). Um tipo de risco sem resposta fica só em "Questões em aberto".
- **Roadmap:** pergunte prazo, ritmo e orçamento aqui. Use as fases de `business-requirements.md` (MVP, Fase 2, Fase 3) como ponto de partida.
- **Questões em aberto:** rodada curta de confirmação. Antes, confira se cada promessa da Visão geral diz o que o produto faz para cumpri-la.

### Seções opcionais

Entreviste todas, inclusive as "(opcional)". Diga quando ela costuma valer a pena. Só a resposta "não se aplica" apaga a seção inteira. "A definir" ou "não sei" mantém a seção.

### O que o usuário não sabe

Resposta "a definir", "não sei" ou ausente: escreva "A definir" (em prosa, "a definir") e acrescente uma linha em "Questões em aberto". Nunca invente.

### Glossário

O brief não repete o glossário: na seção Glossário, aponte para `GLOSSARY.md`. Termos novos que surgirem na entrevista vão para lá, pela skill `domain-modeling`.

## Gravar o brief

1. Monte o documento a partir do molde:
   - Cabeçalho com o nome do produto (Quita), a data de hoje (AAAA-MM-DD), o autor e `Status: rascunho`.
   - Remova todos os comentários HTML e as seções marcadas "não se aplica"; tire o "(opcional)" das que ficaram.
   - Troque todos os placeholders. Confira com uma busca por `<` e por `AAAA`.
   - Escreva em português do Brasil, em prosa direta, sem inflar o que o usuário disse.
2. Grave em `docs/product-brief.md`.
3. Mostre o caminho, as seções que saíram e a lista de "Questões em aberto".
4. Pergunte se quer ajustar algo. Só diga que o brief está pronto quando o usuário disser que sim.
5. Não faça commit sem pedido do usuário. Sugira a mensagem (`docs: add product brief`).

O status só muda para "em revisão" ou "aprovado" por decisão do usuário.
