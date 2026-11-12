# B08 · Importação em andamento e relatório de erros

**App:** operations (Angular) · **Rota:** `/operations/imports/:id` · **Quem:** Carla · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Carla, a gestora: acompanha a importação e corrige o que veio errado.
- **História:** Como gestora, quero ver o progresso e o relatório de erros, para corrigir só as linhas com problema.
- **Momento:** Enviou a planilha (B07). Terminada a importação, os devedores entram na fila (B03) e podem acessar o portal (P01).
- **O que a tela precisa deixar claro:**
  - Quantas linhas entraram, quantas falharam e por quê.
  - O que fazer com as linhas que falharam.

## Objetivo

Acompanhar ao vivo e corrigir o que deu errado.

## Conteúdo

- Progresso ao vivo: linhas processadas de 1.248, válidas, com erro, ignoradas (contadores que sobem), tempo estimado.
- Ao terminar: resumo e **Baixar relatório de erros (CSV)**, com a explicação: o relatório traz as linhas originais com erro e uma coluna "Erro" no fim; ela corrige ali mesmo e envia esse arquivo de novo (as linhas certas já entraram e não duplicam).
- **Resumo por tipo de erro primeiro**, linhas depois: "8 · CPF inválido", "3 · Vencimento em formato errado", "1 · Sem e-mail e sem celular". Clicar num tipo filtra a tabela.
- Tabela de erros com rolagem virtual (pode ter milhares de linhas), na ordem da linha do arquivo: linha, coluna do modelo, mensagem. Uma linha com várias falhas mostra todas juntas. Exemplos: "Linha 214 · CPF/CNPJ · CPF inválido"; "Linha 530 · Valor original · O valor precisa ser maior que zero"; "Linha 611 · E-mail, Celular · Sem e-mail e sem celular"; "Linha 877 · Contrato · Dívida com acordo ativo, linha ignorada".

## Estados

1. Processando (ao vivo).
2. Conexão ao vivo caiu: "Atualizando a cada 5 segundos" (fallback), sem alarde.
3. Concluída sem erros: celebração discreta.
4. Concluída com erros (o exemplo acima).
5. Falhou: o que houve e **Tentar de novo**.
6. Parou cedo (mais de 90% das primeiras linhas com erro): "A importação parou porque quase todas as primeiras linhas têm erro. Parece que as colunas estão em outra ordem: confira o cabeçalho com o modelo." com **Baixar modelo**.
