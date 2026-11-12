# P04 · Suas dívidas

**App:** portal · **Rota:** `/c/escola-horizonte/debts` · **Quem:** a Ana, logada · **Tamanhos:** celular e desktop

## Na história

- **Ator e papel:** Ana, a devedora: vê tudo o que deve a esta credora.
- **História:** Como devedora, quero ver minhas dívidas com valores claros, para escolher qual resolver primeiro.
- **Momento:** Acabou de entrar (P03). Escolhe uma dívida e abre o detalhe (P05).
- **O que a tela precisa deixar claro:**
  - Que estas são as dívidas com a Escola Horizonte, e só com ela.
  - O próximo passo óbvio: escolher uma dívida para resolver.

## Objetivo

Mostrar com clareza quanto ela deve, sem constranger, e levar ao próximo passo.

## Conteúdo

- Saudação curta: "Olá, Ana".
- Resumo no topo: total em aberto com a Escola Horizonte (R$ 1.348,87).
- Cards de dívida (componente do design system):
  1. Mensalidade de agosto · venceu em 12/07 · 120 dias · valor original R$ 1.000,00 · **valor atualizado R$ 1.060,00** · **Ver como pagar**.
  2. Material didático · venceu em 05/10 · 35 dias · valor original R$ 280,00 · **valor atualizado R$ 288,87** · **Ver como pagar**.
- Variante do card 1 com proposta aberta (o operador enviou): faixa discreta no card, "A Escola Horizonte enviou uma proposta para esta dívida · válida até 14/11 às 10:30", com **Ver proposta** (abre a P07 da proposta) e, secundário, **Ver como pagar**.
- Seção "Seus acordos": um acordo existente (rematrícula, 2 de 4 parcelas pagas, próxima em 14/12).
- "Sair", no cabeçalho.

## Estados

1. Com dívidas (acima).
2. Carregando: o cabeçalho aparece antes e a lista vem como esqueleto dos cards (streaming).
3. Sem dívidas em aberto: estado vazio positivo, "Você está em dia com a Escola Horizonte", na cor de "quitado".
4. Erro ao carregar, com "Tentar de novo".
5. Dívida com proposta aberta (a variante do card 1 acima).

## Notas

- A Faixa de atraso aparece como informação discreta ("120 dias"), nunca como alerta vermelho.
- O valor atualizado é o número mais forte do card; o original fica menor, para comparação.
- Cada acordo é de uma dívida só: as duas dívidas da Ana têm um **Ver como pagar** cada, e cada uma vira um acordo próprio.
- A seção "Seus acordos" lista todos os acordos da Ana com esta credora.
