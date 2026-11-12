# P06 · Simulador

**App:** portal · **Rota:** `/c/escola-horizonte/debts/[debtId]` · **Quem:** a Ana · **Tamanhos:** celular e desktop

## Na história

- **Ator e papel:** Ana, a devedora: escolhe uma condição que cabe no bolso, dentro da Política da credora.
- **História:** Como devedora, quero comparar à vista e parcelado, para escolher o que consigo pagar.
- **Momento:** Viu o detalhe da dívida (P05). Escolhida a condição, revisa o acordo (P07).
- **O que a tela precisa deixar claro:**
  - Que as condições vêm da Escola Horizonte, e não de uma negociação com uma pessoa.
  - O efeito de cada escolha no valor da entrada e das parcelas.

## Objetivo

O coração do produto. A Ana escolhe como pagar e vê, enquanto arrasta, o que muda. Precisa ser gostoso de usar e impossível de entender errado.

## Conteúdo

- Controle deslizante de parcelas (componente do design system), de **1x (à vista)** a **10x**.
- Resultado ao vivo da opção escolhida:
  - À vista: **R$ 795,00**, desconto de 25% (economia de R$ 265,00).
  - 5x: entrada de **R$ 135,15** + 4 parcelas de **R$ 191,46** (a última de R$ 191,47), total R$ 901,00, desconto de 15% (economia de R$ 159,00).
- A regra numa linha: "Quanto menos parcelas, maior o desconto."
- Campo opcional "Quero dar uma entrada maior" (campo de dinheiro), com o mínimo indicado.
- Datas: entrada vence em 12/11 (2 dias após o acordo); parcelas, todo dia 12.
- Botão principal: **Revisar acordo**.

## Estados

1. 1x (à vista).
2. 5x.
3. Recalculando: os números ficam com o último valor válido e um indicador sutil de atualização (nunca somem nem piscam).
4. Entrada abaixo do mínimo: "A entrada mínima para 5x é R$ 135,15."
5. Parcela abaixo do mínimo (dívida pequena): "Para esta dívida, o máximo é 5 parcelas" (Material didático, R$ 288,87: em 6x cada parcela daria R$ 42,97, abaixo do mínimo de R$ 50,00 da RN3.1), com o controle limitado.
6. Condições ainda não disponíveis (a credora não publicou a Política): sem simulador e sem **Revisar acordo**; texto calmo "As condições para esta dívida ainda não estão disponíveis. Fale com a Escola Horizonte." com o telefone e o e-mail de atendimento.

## Notas

- O cálculo vem do servidor; a tela nunca calcula dinheiro.
- O controle funciona por teclado (setas) e por leitor de tela ("5 parcelas, entrada de 135 reais e 15 centavos...").
- Se couber sem poluir, uma barra ou mini gráfico comparando o desconto entre as opções.
