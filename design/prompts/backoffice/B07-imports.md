# B07 · Importações e nova importação

**App:** operations (Angular) · **Rota:** `/operations/imports` · **Quem:** Carla Mendes, gestora · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Carla, a gestora: alimenta o Quita com a carteira de inadimplentes.
- **História:** Como gestora, quero subir a planilha com as dívidas do mês, para que os devedores possam resolver pelo portal.
- **Momento:** Começa aqui o trabalho da credora no Quita. Enviada a planilha, acompanha a importação (B08).
- **O que a tela precisa deixar claro:**
  - O formato esperado do arquivo, antes do envio.
  - O histórico das importações anteriores.

## Objetivo

Subir as dívidas do mês sem medo de errar, vendo antes o que vai entrar.

## Conteúdo

- Histórico: data, arquivo, quem importou, linhas, válidas, com erro, ignoradas, situação. Exemplo: "carteira-outubro.csv · 1.248 linhas · 1.236 válidas · 12 com erro · concluída com erros".
- **Nova importação:**
  1. Área de soltar o arquivo (CSV, até 10 MB, até 100 mil linhas), com link "Baixar modelo" (um `.csv` com o cabeçalho e uma linha de exemplo, a Ana) e um texto curto explicando cada coluna.
  2. Colunas do modelo, em português: **CPF/CNPJ** (com ou sem pontuação) · **Nome** · **E-mail** · **Celular** (com DDD; e-mail ou celular, pelo menos um) · **Contrato** · Descrição (opcional) · **Valor original** (`1.000,00`) · **Vencimento** (`dd/mm/aaaa`). O arquivo salvo como CSV pelo Excel funciona.
  3. Pré-visualização das primeiras 20 linhas, lidas no navegador antes de enviar. O navegador valida o **arquivo inteiro** sem travar a tela e mostra, antes de enviar, "1.248 linhas · 12 com problema", com o resumo por tipo ("8 · CPF inválido", "3 · Vencimento em formato errado", "1 · Sem e-mail e sem celular") e as linhas com problema marcadas.
  4. **Importar 1.248 linhas**.
- Envio com barra de progresso do upload.

## Estados

1. Histórico com itens.
2. Arquivo solto, pré-visualização aberta.
3. Arquivo inválido (não é CSV, acima do limite, faltam colunas do modelo): o que está errado e como corrigir ("Faltam as colunas Vencimento e Contrato. Confira o cabeçalho com o modelo.").
4. Arquivo válido, mas com linhas com problema: o resumo por tipo de erro e o aviso de que essas linhas não vão entrar e podem ser corrigidas depois pelo relatório.
5. Enviando (progresso do upload).
6. Já existe uma importação em andamento: "Aguarde a importação de outubro terminar para enviar outra."
7. Histórico vazio, com chamada para a primeira importação.
