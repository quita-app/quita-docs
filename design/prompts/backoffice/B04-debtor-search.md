# B04 · Busca de Devedores

**App:** operations (Angular) · **Rota:** `/operations/debtors` · **Quem:** operador e gestor · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Operador e gestor: encontram um devedor específico na carteira.
- **História:** Como operador, quero achar um devedor pelo nome ou CPF, para atender quem ligou ou escreveu.
- **Momento:** Um devedor entrou em contato fora da fila. Daqui abre a ficha (B05).
- **O que a tela precisa deixar claro:**
  - Que a busca é na carteira desta credora.
  - Como reconhecer a pessoa certa sem expor o CPF inteiro.

## Objetivo

Achar qualquer Devedor em segundos, por nome, trecho do CPF, contrato ou telefone.

## Conteúdo

- Campo de busca grande, com dica: "Nome, CPF, contrato ou telefone".
- Resultados enquanto digita (a busca espera uma pausa curta e precisa de pelo menos 3 caracteres): nome, CPF mascarado, número de dívidas, valor total, situação.
- Filtros combináveis em pílula: Faixa de atraso (as Faixas da Política publicada, mesma lista da Fila), situação da Dívida, operador responsável.
- Paginação "carregar mais" (a lista usa cursor, não números de página).
- Botão **Nova dívida** no cabeçalho: abre um painel lateral para cadastrar uma dívida avulsa (um aluno novo, um caso que chegou por telefone). Campos iguais a uma linha do modelo de importação: CPF/CNPJ, Nome, E-mail, Celular (pelo menos um dos dois), Contrato, Descrição (opcional), Valor original, Vencimento. Mesma validação da importação; se o CPF já existe, a dívida entra na ficha desse Devedor.

## Estados

1. Antes de digitar: buscas recentes.
2. Digitando com menos de 3 caracteres: "Digite pelo menos 3 caracteres."
3. Buscando: indicador no campo, resultados anteriores mantidos.
4. Resultados (6 itens de exemplo, reusando os nomes da Fila).
5. Nenhum resultado: sugestão de conferir o termo ou limpar filtros.
6. Erro na busca, depois de tentar de novo sozinha 3 vezes.
7. Busca por telefone: "11 98765" acha a Ana pelo celular.
8. Nova dívida: painel aberto, erro "Informe o e-mail ou o celular" e o sucesso "Dívida cadastrada".
