# Formato do ADR

Os ADRs (Architecture Decision Records) ficam em `docs/adr/`, numerados em sequência: `0001-slug.md`, `0002-slug.md`. O slug é em inglês e kebab-case (`0001-repository-structure.md`). A numeração é uma só para todo o projeto: o próximo número é o maior da pasta mais um.

## Molde

```md
---
status: proposta | aceita | substituída por NNNN
---

# NNNN · <título curto da decisão>

<1 a 3 frases: o contexto, o que se decidiu e por quê.>

Descartadas: <alternativas, separadas por ponto e vírgula, cada uma com o motivo em poucas palavras>.
Custo aceito: <o que a decisão custa, inclusive o negativo>.
```

Um ADR pode ter um parágrafo só. O valor está em registrar **que** a decisão foi tomada e **por quê**, não em preencher seções.

## Decisão trocada

Uma decisão trocada não se edita: o ADR antigo passa a `substituída por NNNN`, e o novo entra com número novo.

## Quando oferecer um ADR

As três condições precisam ser verdadeiras:

1. **Difícil de reverter:** mudar de ideia depois custa caro.
2. **Surpreendente sem contexto:** quem ler o código depois vai perguntar "por que fizeram assim?".
3. **Fruto de um trade-off real:** havia alternativas sérias, e houve um motivo para a escolhida.

Se é fácil de reverter, não precisa: é só reverter. Se não surpreende, ninguém vai perguntar. Se não havia alternativa, não há o que registrar além de "fizemos o óbvio".

### O que costuma valer um ADR

- **Forma da arquitetura.** "O backoffice é um monorepo Nx; o portal e a API ficam em repos separados."
- **Integração entre contextos.** "Pagamento e Negociação conversam por eventos de domínio, não por chamada síncrona."
- **Tecnologia que prende.** Banco, mensageria, provedor de autenticação, onde publicar. Não toda biblioteca: só as que levariam semanas para trocar.
- **Fronteiras e escopo.** "Os dados do Devedor são do contexto Carteira; os outros só guardam o id." Os "nãos" valem tanto quanto os "sins".
- **Desvios deliberados do caminho óbvio.** Algo em que um leitor razoável apostaria no contrário. Isso impede alguém de "consertar" o que foi de propósito.
- **Restrições que o código não mostra.** "Toda dívida de consumo respeita o limite de multa do CDC."
- **Alternativas descartadas por motivo nada óbvio.** Se GraphQL foi considerado e REST venceu por um motivo sutil, registre; senão alguém sugere GraphQL de novo.
