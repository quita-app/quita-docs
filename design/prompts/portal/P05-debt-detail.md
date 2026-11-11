# P05 · Detalhe da dívida e composição do valor

**App:** portal · **Rota:** `/c/escola-horizonte/debts/[debtId]` e `.../breakdown` · **Quem:** a Ana · **Tamanhos:** celular e desktop

## Objetivo

Responder "por que eu devo isso?" com transparência total. Confiança vem de mostrar a conta.

## Conteúdo

- Título: Mensalidade de agosto · Escola Horizonte · contrato 2026-0815.
- Valor atualizado em destaque: **R$ 1.060,00**.
- "Entenda este valor" abre a composição:
  - Valor original: R$ 1.000,00
  - Multa por atraso (2%): R$ 20,00
  - Juros (1% ao mês, 120 dias): R$ 40,00
  - Correção: R$ 0,00
  - Total: R$ 1.060,00
  - Rodapé: "A multa segue o limite do Código de Defesa do Consumidor."
- Abaixo, o começo do simulador (P06) com a chamada "Escolha como pagar".
- Link discreto: "Não reconheço esta dívida" (contestação é da Fase 2: o link leva a uma tela "em breve").

## Estados

1. Composição fechada.
2. Composição aberta: no celular, folha que sobe de baixo (bottom sheet); no desktop, modal. Acessada pelo endereço direto, vira página inteira.

## Notas

- A composição é uma tabela de duas colunas, valores alinhados à direita, algarismos tabulares.
