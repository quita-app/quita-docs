# B04 · Busca de Devedores

**App:** operations (Angular) · **Rota:** `/operations/debtors` · **Quem:** operador e gestor · **Tamanhos:** desktop

## Objetivo

Achar qualquer Devedor em segundos, por nome, trecho do CPF, contrato ou telefone.

## Conteúdo

- Campo de busca grande, com dica: "Nome, CPF, contrato ou telefone".
- Resultados enquanto digita (a busca espera uma pausa curta e precisa de pelo menos 3 caracteres): nome, CPF mascarado, número de dívidas, valor total, situação.
- Filtros combináveis em pílula: Faixa de atraso, situação da Dívida, operador responsável.
- Paginação "carregar mais" (a lista usa cursor, não números de página).

## Estados

1. Antes de digitar: buscas recentes.
2. Digitando com menos de 3 caracteres: "Digite pelo menos 3 caracteres."
3. Buscando: indicador no campo, resultados anteriores mantidos.
4. Resultados (6 itens de exemplo, reusando os nomes da Fila).
5. Nenhum resultado: sugestão de conferir o termo ou limpar filtros.
6. Erro na busca, depois de tentar de novo sozinha 3 vezes.
