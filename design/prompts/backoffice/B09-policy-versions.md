# B09 · Versões da Política

**App:** operations (Angular) · **Rota:** `/operations/policies` · **Quem:** Carla, gestora · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Carla, a gestora: decide até onde a credora aceita negociar.
- **História:** Como gestora, quero ver as versões da Política e qual está em vigor, para saber que regra vale hoje.
- **Momento:** Depois de importar a carteira (B08), ou quando quer mudar as condições. Daqui edita uma versão (B10).
- **O que a tela precisa deixar claro:**
  - Qual versão está valendo e desde quando.
  - Que mudar a Política muda o que devedores e operadores veem.

## Objetivo

Ver qual Política está valendo e o histórico de mudanças.

## Conteúdo

- Card da versão publicada: "Versão 3 · publicada em 01/11 por Carla Mendes", com o resumo por Faixa (desconto máximo, parcelas, entrada mínima) numa tabela compacta:
  - 0–30: 0% · 3x · 30%
  - 31–90: 10% · 6x · 20%
  - 91–180: 25% · 10x · 15%
  - 181–360: 45% · 12x · 10%
  - +360: 70% · 18x · 10%
- Rascunho em edição, se houver: "Versão 4 · rascunho · editado há 2 horas", com **Continuar editando**.
- Lista das versões arquivadas.
- **Nova versão** (cria um rascunho a partir da publicada).

## Estados

1. Publicada + rascunho.
2. Só a publicada.
3. Nenhuma Política ainda: chamada para criar a primeira, explicando que sem ela o portal não oferece acordos.
