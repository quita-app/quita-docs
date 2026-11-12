# B10 · Editor da Política

**App:** operations (Angular) · **Rota:** `/operations/policies/:id` · **Quem:** Carla · **Tamanhos:** desktop 1440 px

## Na história

- **Ator e papel:** Carla, a gestora: define descontos e parcelas por faixa de atraso.
- **História:** Como gestora, quero ajustar as condições por faixa e ver o efeito antes de publicar, para negociar com regra e não no improviso.
- **Momento:** Veio da lista de versões (B09). Publicada, a Política vale para o simulador da Ana (P06) e para o Bruno (B06).
- **O que a tela precisa deixar claro:**
  - Que esta é a regra única da credora para todos os canais.
  - A diferença entre rascunho e versão publicada.

## Objetivo

Editar as regras com segurança, vendo o efeito na hora num exemplo, antes de publicar.

## Conteúdo

- Configurações gerais: validade da proposta (48 h), tolerância de quebra (10 dias), parcela mínima (R$ 50,00).
- Tabela editável de Faixas (uma linha por Faixa): dias de atraso de/até, desconto máximo à vista (%), parcelas máximas, entrada mínima (%). Botões para acrescentar e remover Faixa.
- Simulador lateral: uma Dívida fictícia (R$ 1.000,00, 120 dias) mostrando, com a regra editada, o valor à vista e o 5x.
- **Salvar rascunho** e **Publicar versão 4** (com confirmação explicando que acordos já fechados não mudam).

## Estados

1. Editando, válido.
2. Erros de validação cruzada: Faixas sobrepostas ("31–90 e 80–180 se sobrepõem"), buraco entre Faixas, desconto acima de 100%.
3. Simulador recalculando.
4. Conflito de versão: outra pessoa salvou este rascunho; mostra o que mudou e oferece recarregar.
5. Saindo com alterações não salvas: confirmação.
6. Publicada com sucesso.
