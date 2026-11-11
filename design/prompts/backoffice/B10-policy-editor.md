# B10 · Editor da Política

**App:** operations (Angular) · **Rota:** `/operations/policies/:id` · **Quem:** Carla · **Tamanhos:** desktop 1440 px

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
