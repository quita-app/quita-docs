# B11 · Pagamentos não conciliados

**App:** operations (Angular) · **Rota:** `/operations/payments` · **Quem:** Carla · **Tamanhos:** desktop

## Objetivo

Resolver à mão os pagamentos que o sistema não conseguiu ligar a uma Parcela.

## Conteúdo

- Lista: data, valor recebido, valor esperado, Devedor provável, motivo ("valor diferente da parcela", "cobrança não encontrada"). Exemplo: "13/11 · recebido R$ 100,00 · esperado R$ 191,46 · Paulo Henrique · valor diferente".
- Ao selecionar: detalhes do pagamento e as ações **Associar à parcela** (com busca da Parcela) e **Marcar como resolvido** (com nota obrigatória).

## Estados

1. Com itens.
2. Nenhum pendente: "Todos os pagamentos estão conciliados."
3. Resolvido: o item sai da lista com retorno visual.
