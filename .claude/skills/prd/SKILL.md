---
name: prd
description: Escreve o PRD de uma funcionalidade do roadmap do Quita (o quê e para quem, histórias, critérios de aceite, fora de escopo, riscos) e grava em docs/features/<NN>-<title>/prd.md. Use quando o usuário pedir o PRD de uma funcionalidade, disser "vamos começar a F<NN>" ou pedir os requisitos de produto de algo do roadmap.
---

# PRD de uma funcionalidade

O PRD diz **o que** a funcionalidade entrega e **para quem**, em linguagem de produto. Como ela é construída fica na spec (`to-spec`); a ordem das entregas fica no `docs/roadmap.md`.

## Antes de escrever: ler

1. `docs/roadmap.md`: o bloco da funcionalidade (objetivo, telas, módulos, repos, dependências, tamanho).
2. `docs/product-brief.md` (escopo e métricas) e `GLOSSARY.md` (vocabulário obrigatório).
3. `docs/foundation/business-requirements.md`: os RF e as RN do módulo.
4. Os LLDs das frentes tocadas (`docs/lld/`), principalmente regras, valores e códigos de erro.
5. As telas: `design/prompts/<app>/<tela>.md` (conteúdo e estados) e `design/hi-fi/<tela>/`; os textos em `design/ux-writing.md`.
6. As "Questões em aberto" dos documentos acima que tocam esta funcionalidade.

## Passo 1: fechar as dúvidas

Liste as lacunas que você achou (regra sem valor, estado sem texto, rota citada na tela e ausente do contrato, questão em aberto de um LLD) e leve ao usuário **numa rodada só**, com uma recomendação em cada uma. O que o usuário decidir entra no PRD; o que mudar um fato de outro documento (LLD, glossário) é corrigido **lá**, no documento dono, e o PRD aponta para ele.

Não invente regra: o que continuar sem resposta entra em "Questões em aberto" como `A definir`.

## Passo 2: rascunho

Grave em `docs/features/<NN>-<title>/prd.md` (número de dois dígitos e título em kebab-case, em inglês, iguais aos do roadmap), com esta estrutura:

```markdown
# PRD: F<NN> · <Nome da funcionalidade>

<data> · <autor> · Status: rascunho

## Resumo

- **Problema:** 1 ou 2 frases, do ponto de vista de quem sofre.
- **Solução:** 1 ou 2 frases, do ponto de vista de quem usa.
- **Como saber que funcionou:** o que a pessoa consegue fazer ao final e qual métrica do `docs/product-brief.md` isto move (pelo nome, sem criar indicador novo).

## Quem usa

Os atores do `GLOSSARY.md` envolvidos e o que cada um faz aqui.

## Histórias e critérios de aceite

### H1 · Como <ator>, quero <ação>, para <benefício>

- **CA1** · critério verificável, com número quando houver (valor, prazo, limite)
- **CA2** · ...

(uma seção por história; os CA são numerados em sequência no documento inteiro)

## Telas e estados

Tabela: tela (código do hi-fi) · estados que esta funcionalidade entrega · textos (ponteiro para o `design/ux-writing.md`).

## Regras de negócio

As RN que valem aqui, pelo número, com ponteiro para o documento dono dos valores (`docs/lld/api.md`, seção "Valores e configuração"). Não repita o valor: aponte.

## Fora de escopo

O que **não** entra, e para qual funcionalidade do roadmap vai, quando for o caso.

## Riscos de produto

O que pode impedir a funcionalidade de resolver o problema, e a mitigação.

## Questões em aberto

- [ ] ...
```

## Qualidade dos critérios

Concretos e verificáveis. Evite "rápido", "fácil", "intuitivo".

| Vago | Concreto |
| --- | --- |
| A busca deve ser rápida. | A busca só dispara depois de 300 ms sem digitação e com 3 caracteres ou mais. |
| O erro deve ser claro. | Código errado mostra quantas tentativas restam. |

- Critério de aceite descreve comportamento observável, nunca implementação ("usa `switchMap`" não é critério).
- Use os exemplos numéricos do domínio (a Ana: R$ 1.000,00 → R$ 1.060,00; 5x: Entrada de R$ 135,15 + Parcelas de R$ 191,46) quando a funcionalidade envolver cálculo.
- Sem caminho de arquivo nem trecho de código.

## Passo 3: aprovação

Mostre o rascunho, peça ajustes por seção e, quando o usuário aprovar, troque o Status para `aprovado` e atualize o status da funcionalidade no `docs/roadmap.md` para `em PRD`. Commit só a pedido.
