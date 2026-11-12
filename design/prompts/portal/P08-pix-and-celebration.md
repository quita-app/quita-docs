# P08 · Pix da entrada e acordo fechado

**App:** portal · **Rota:** `/c/escola-horizonte/agreements/[agreementId]/installments/[installmentId]/pay` · **Quem:** a Ana · **Tamanhos:** celular e desktop

## Na história

- **Ator e papel:** Ana, a devedora: paga a entrada e vê o acordo fechado.
- **História:** Como devedora, quero pagar a entrada pelo Pix e ver na hora que deu certo, para sentir que resolvi.
- **Momento:** Confirmou o acordo (P07). Depois do pagamento, acompanha o acordo (P09).
- **O que a tela precisa deixar claro:**
  - Que o Pix vai para a Escola Horizonte e quanto tempo o código vale.
  - A comemoração diz o que mudou para ela e qual é a próxima parcela.

## Objetivo

Pagar a entrada sem sair do fluxo e viver o momento mais importante do produto: o acordo fechado.

## Conteúdo

- Valor da entrada: **R$ 135,15**, vence em 12/11 às 23:59.
- QR Code do Pix: em destaque no desktop; menor no celular, onde o mais comum é copiar o código.
- **Copiar código Pix**, com retorno "Código copiado".
- Passo a passo em 3 itens: abra o app do seu banco, escolha Pix copia e cola, cole o código.
- Status ao vivo: "Aguardando o pagamento…" (a tela consulta sozinha).
- "Já paguei": mostra na hora "Pagamento em processamento" enquanto a confirmação chega.
- Na demo: botão separado, com cara de ferramenta de demonstração, "Simular pagamento".

## Estados

1. Aguardando pagamento.
2. Código copiado.
3. Pagamento em processamento (depois do "Já paguei").
4. **Acordo fechado:** a celebração contida do design system, "Acordo fechado", o resumo (5x, R$ 901,00), a próxima parcela (R$ 191,46 em 12/12) e **Ver meu acordo**. Mostre o quadro-chave da animação, descreva o movimento e mostre a versão com movimento reduzido.
5. Pix vencido: "Este código venceu. Gere um novo para pagar a entrada." com **Gerar novo código Pix**.
6. Prazo encerrado (parcela depois do último dia para pagar): "O prazo para pagar esta parcela terminou em 22/01. Se você já pagou, não precisa fazer nada: o pagamento aparece aqui em instantes." Sem botão de gerar código.

## Notas

- A celebração usa a cor de "quitado"/celebração e dura pouco. Nada de confete em tela cheia.
- O código Pix vale até 24 horas, mas nunca depois do último dia para pagar a parcela (o vencimento, na entrada; o vencimento mais a tolerância, nas outras). Por isso o prazo exibido é "pague até {data} às 23:59".
