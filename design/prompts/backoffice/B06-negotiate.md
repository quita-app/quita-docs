# B06 · Negociar pela ficha

**App:** operations (Angular) · **Rota:** `/operations/debtors/:id` (painel de negociação) · **Quem:** Bruno, ao telefone com a Ana · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Bruno, ao telefone com a Ana: monta a condição com ela, dentro da Política, e envia a proposta.
- **História:** Como operador, quero oferecer as mesmas condições que a Ana teria no portal e enviar a proposta para ela confirmar, para fechar o acordo sem inventar desconto e com o aceite dela.
- **Momento:** Está na ficha da Ana (B05). Enviada a proposta, a Ana recebe o link por e-mail e SMS, entra no portal e aceita (P07); depois paga a entrada (P08).
- **O que a tela precisa deixar claro:**
  - Que os limites vêm da Política da credora (B10), não do operador.
  - Que o operador **envia uma proposta**: o acordo só nasce quando a Ana aceitar no portal.
  - Que a proposta vale até uma data (48 horas).

## Objetivo

O mesmo simulador do portal, na versão densa do operador, que mostra também os limites da Política e envia a proposta à Ana.

## Conteúdo

- Dívida escolhida: Mensalidade de agosto, R$ 1.060,00, faixa 91–180.
- Limites da Política visíveis: desconto máximo à vista 25%, até 10 parcelas, entrada mínima 15%, parcela mínima R$ 50,00.
- Seletor de parcelas (o mesmo componente do portal, em tamanho compacto) e campo de entrada.
- Resultado: valores iguais aos do portal (5x: entrada R$ 135,15 + 4 de R$ 191,46, total R$ 901,00).
- **Enviar proposta à Ana** e "Copiar resumo". Abaixo do botão: "O acordo só nasce quando a Ana aceitar no portal. A proposta vale até 14/11 às 10:30."
- Fase 2, já reservando o espaço: "Pedir exceção" (desconto acima da Política, com motivo).

## Estados

1. Dentro da Política.
2. Recalculando.
3. Fora da Política: os limites ficam destacados e **Enviar proposta à Ana** fica desabilitado; o espaço de "Pedir exceção ao gestor" (Fase 2) aparece reservado.
4. Já existe uma proposta aberta: "A Ana já tem uma proposta aberta, válida até 13/11 às 18:00. Enviar esta substitui a anterior." com **Enviar e substituir**.
5. Conflito: a Ana fechou um acordo pelo portal enquanto o operador negociava ("Já existe um acordo ativo para esta dívida, fechado agora há pouco." com **Abrir acordo**).
6. Proposta enviada: resumo e o próximo passo ("A Ana recebe o link por e-mail e SMS e pode aceitar no portal até 14/11 às 10:30.").
