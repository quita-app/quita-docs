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
- Ao terminar: resumo e **Baixar relatório de erros (CSV)**.
- Tabela de erros com rolagem virtual (pode ter milhares de linhas): linha, campo, mensagem. Exemplos: "Linha 214 · document · CPF inválido"; "Linha 530 · principal_amount · valor precisa ser maior que zero"; "Linha 877 · contract_number · dívida com acordo ativo, linha ignorada".
- Filtro por tipo de erro.

## Estados

1. Processando (ao vivo).
2. Conexão ao vivo caiu: "Atualizando a cada 5 segundos" (fallback), sem alarde.
3. Concluída sem erros: celebração discreta.
4. Concluída com erros (o exemplo acima).
5. Falhou: o que houve e **Tentar de novo**.
