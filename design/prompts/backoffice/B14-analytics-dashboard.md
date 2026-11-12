# B14 · Painel

**App:** analytics (React, dentro do shell Angular) · **Rota:** `/analytics` · **Quem:** Carla (vê tudo) e Bruno (vê só os números dele) · **Tamanhos:** desktop 1440 px e celular 390 px

## Na história

- **Ator e papel:** Carla (vê tudo) e Bruno (vê só os números dele): acompanham quanto foi recuperado.
- **História:** Como gestora, quero ver quanto recuperei, onde e com quem, para saber se a cobrança está funcionando.
- **Momento:** Fim do dia ou do mês, depois do trabalho na fila (B03) e dos acordos fechados (B06, P08).
- **O que a tela precisa deixar claro:**
  - Que os números são da carteira desta credora e de que período.
  - O que cada papel enxerga: a gestora vê tudo, o operador vê os números dele.

## Objetivo

Responder "quanto recuperamos, onde e com quem?" num olhar. É a tela que vende o produto para o gestor.

## Conteúdo

- Filtros no topo, em pílula: período (este mês), Carteira, Faixa de atraso, operador. Os filtros vão para o endereço da página (link compartilhável).
- Bento grid com:
  - **Recuperado no mês: R$ 184.320,00** (card de destaque, a cor de assinatura).
  - **Taxa de recuperação: 23,4%**.
  - **Acordos ativos: 412** · **Quebrados no mês: 37** (taxa de quebra 8,2%).
  - **Conversão do autoatendimento: 31%** (devedores que acessaram o portal e fecharam acordo).
  - Gráfico de recuperação por semana (barras; considere o estilo hachurado das referências).
  - Aging da carteira: quanto está em cada Faixa de atraso.
  - Funil: acessaram o portal → simularam → fecharam acordo → pagaram a entrada → quitaram.
  - Ranking de operadores (só para o gestor).
- Aviso discreto: "Números atualizados há 3 minutos" (o painel tem até 5 minutos de atraso).
- **Exportar CSV**.

## Estados

1. Visão do gestor.
2. Visão do operador (sem ranking, números só dele).
3. Carregando por card (cada card tem o próprio esqueleto).
4. Um card com erro, sem derrubar os outros: "Não foi possível carregar este gráfico" com **Tentar de novo**.
5. Período sem dados: "Ainda não há acordos neste período."

## Notas

- Os números são ilustrativos (o projeto não tem dados reais).
- Este painel é um Web Component React dentro do shell Angular: ele não desenha menu nem barra, só a área de conteúdo, e usa os mesmos tokens.
