# P07 · Revisar e fechar o acordo

**App:** portal · **Rota:** `/c/escola-horizonte/debts/[debtId]` (etapa de revisão) · **Quem:** a Ana · **Tamanhos:** celular e desktop

## Na história

- **Ator e papel:** Ana, a devedora: confirma o acordo antes de assumir o compromisso.
- **História:** Como devedora, quero revisar tudo o que estou aceitando, para fechar o acordo sem surpresa.
- **Momento:** Escolheu a condição no simulador (P06). Ao confirmar, paga a entrada por Pix (P08).
- **O que a tela precisa deixar claro:**
  - O que ela está assinando: valores, datas e o que acontece se uma parcela atrasar.
  - Que dá para voltar e escolher outra condição.

## Objetivo

Confirmar exatamente o que ela está aceitando, sem letra miúda escondida.

## Conteúdo

- Resumo: 5x, total R$ 901,00, desconto de 15%.
- Cronograma: entrada de R$ 135,15 em 12/11; R$ 191,46 em 12/12, 12/01 e 12/02; R$ 191,47 em 12/03.
- O que acontece se atrasar, em linguagem simples: "Se uma parcela atrasar mais de 10 dias, o acordo é cancelado e o desconto deixa de valer. O que você já pagou é descontado da dívida."
- "O acordo começa a valer quando a entrada for paga."
- Caixa de confirmação: "Li e concordo com as condições".
- Botões: **Fechar acordo** e "Voltar e mudar".

## Estados

1. Pronto para confirmar.
2. Fechando: carregamento, o botão não aceita segundo clique.
3. Conflito: outro atendimento fechou um acordo para esta dívida agora há pouco. Mensagem clara e botão para ver o acordo existente.
4. Política mudou desde a simulação: "As condições foram atualizadas pela Escola Horizonte. Confira a nova simulação."

## Notas

- O texto sobre atraso é informação, não ameaça: tom neutro, sem vermelho.
