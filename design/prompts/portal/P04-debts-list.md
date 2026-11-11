# P04 · Suas dívidas

**App:** portal · **Rota:** `/c/escola-horizonte/debts` · **Quem:** a Ana, logada · **Tamanhos:** celular e desktop

## Objetivo

Mostrar com clareza quanto ela deve, sem constranger, e levar ao próximo passo.

## Conteúdo

- Saudação curta: "Olá, Ana".
- Resumo no topo: total em aberto com a Escola Horizonte (R$ 1.348,87).
- Cards de dívida (componente do design system):
  1. Mensalidade de agosto · venceu em 12/07 · 120 dias · valor original R$ 1.000,00 · **valor atualizado R$ 1.060,00** · **Ver como pagar**.
  2. Material didático · venceu em 05/10 · 35 dias · valor original R$ 280,00 · **valor atualizado R$ 288,87** · **Ver como pagar**.
- Seção "Seus acordos": um acordo existente (rematrícula, 2 de 4 parcelas pagas, próxima em 14/12).
- "Sair", no cabeçalho.

## Estados

1. Com dívidas (acima).
2. Carregando: o cabeçalho aparece antes e a lista vem como esqueleto dos cards (streaming).
3. Sem dívidas em aberto: estado vazio positivo, "Você está em dia com a Escola Horizonte", na cor de "quitado".
4. Erro ao carregar, com "Tentar de novo".

## Notas

- A Faixa de atraso aparece como informação discreta ("120 dias"), nunca como alerta vermelho.
- O valor atualizado é o número mais forte do card; o original fica menor, para comparação.
