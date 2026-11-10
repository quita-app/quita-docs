---
name: grilling
description: Entrevista o usuário sem trégua sobre um plano, uma decisão ou uma ideia, em rodadas, até chegar a um entendimento comum. Use quando o usuário quiser testar o próprio raciocínio ou usar gatilhos como "me sabatina", "grill", "testa esse plano".
---

Entreviste o usuário até chegar a um entendimento comum. Mapeie a conversa como uma **árvore de decisões**: cada decisão abre as decisões que dependem dela.

## Rodadas

Trabalhe a árvore em **rodadas**. A **fronteira** é o conjunto de decisões cujos pré-requisitos já estão resolvidos: as perguntas que dá para fazer _agora_ sem adivinhar respostas que ainda não vieram. Faça a fronteira inteira numa rodada, numere as perguntas e dê a sua recomendação. Espere as respostas antes da próxima rodada.

Formato de uma rodada:

```
❓ **Q1 - <título>**: <pergunta, podendo ter vários parágrafos e alternativas>

➡️ <sua recomendação>
💡 <por quê, em uma ou duas frases>

---

❓ **Q2 - <título>**: ...
```

Escreva cada pergunta de modo que "sim" aceite a sua recomendação.

Cada rodada respondida muda a árvore: decisões resolvidas empurram a fronteira e liberam as que dependiam delas. Recalcule a fronteira e faça a próxima rodada. Uma pergunta que depende de outra ainda aberta na mesma rodada fica para uma rodada _seguinte_.

## Fatos são seus, decisões são do usuário

Descobrir _fatos_ é trabalho seu, nunca do usuário. Quando uma pergunta da fronteira precisa de um fato do ambiente (arquivos, documentação, versão de uma lib), procure você mesmo; não pergunte ao usuário o que dá para descobrir. Enquanto procura, só as perguntas que dependem daquele fato esperam; faça o resto da fronteira. As _decisões_ são do usuário: apresente cada uma e espere.

## Alternativas

Alternativas vão em lista, nunca em tabela (o terminal quebra tabelas largas): a letra e o nome numa linha, "Prós:" e "Contras:" nas linhas de baixo.

## Fim

A sessão termina quando a fronteira está vazia: todos os galhos visitados, nada assumido em silêncio. Não aja sobre o resultado antes de o usuário confirmar que vocês chegaram a um entendimento comum.
