# B07 · Importações e nova importação

**App:** operations (Angular) · **Rota:** `/operations/imports` · **Quem:** Carla Mendes, gestora · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Carla, a gestora: alimenta o Quita com a carteira de inadimplentes.
- **História:** Como gestora, quero subir a planilha da carteira, para que os devedores possam resolver pelo portal.
- **Momento:** Começa aqui o trabalho da credora no Quita. Enviada a planilha, acompanha a importação (B08).
- **O que a tela precisa deixar claro:**
  - O formato esperado do arquivo, antes do envio.
  - O histórico das importações anteriores.

## Objetivo

Subir a carteira do mês sem medo de errar, vendo antes o que vai entrar.

## Conteúdo

- Histórico: data, arquivo, quem importou, linhas, válidas, com erro, ignoradas, situação. Exemplo: "carteira-outubro.csv · 1.248 linhas · 1.236 válidas · 12 com erro · concluída com erros".
- **Nova importação:**
  1. Área de soltar o arquivo (CSV, até 10 MB, até 100 mil linhas), com link "Baixar modelo".
  2. Pré-visualização das primeiras 20 linhas, lidas no navegador antes de enviar, com as colunas esperadas (`document; name; email; phone; contract_number; description; principal_amount; original_due_date`) e a indicação das linhas que já parecem erradas.
  3. **Importar 1.248 linhas**.
- Envio com barra de progresso do upload.

## Estados

1. Histórico com itens.
2. Arquivo solto, pré-visualização aberta.
3. Arquivo inválido (não é CSV, acima do limite, colunas diferentes): o que está errado e como corrigir.
4. Enviando (progresso do upload).
5. Já existe uma importação em andamento: "Aguarde a importação de outubro terminar para enviar outra."
6. Histórico vazio, com chamada para a primeira importação.
