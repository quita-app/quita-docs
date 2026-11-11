# B06 · Negociar pela ficha

**App:** operations (Angular) · **Rota:** `/operations/debtors/:id` (painel de negociação) · **Quem:** Bruno, ao telefone com a Ana · **Tamanhos:** desktop

## Objetivo

O mesmo simulador do portal, na versão densa do operador, que mostra também os limites da Política e permite pedir exceção.

## Conteúdo

- Dívida escolhida: Mensalidade de agosto, R$ 1.060,00, faixa 91–180.
- Limites da Política visíveis: desconto máximo à vista 25%, até 10 parcelas, entrada mínima 15%, parcela mínima R$ 50,00.
- Seletor de parcelas (o mesmo componente do portal, em tamanho compacto) e campo de entrada.
- Resultado: valores iguais aos do portal (5x: entrada R$ 135,15 + 4 de R$ 191,46, total R$ 901,00).
- **Criar acordo** (envia a proposta) e "Copiar resumo para enviar à Ana".
- Fase 2, já reservando o espaço: "Pedir exceção" (desconto acima da Política, com motivo).

## Estados

1. Dentro da Política.
2. Recalculando.
3. Fora da Política: os limites ficam destacados e **Criar acordo** é trocado por "Pedir exceção ao gestor" (Fase 2).
4. Conflito: a Ana fechou um acordo pelo portal enquanto o operador negociava.
5. Acordo criado: resumo e o próximo passo ("A Ana recebe o Pix da entrada por e-mail").
