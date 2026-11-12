# B03 · Fila de trabalho

**App:** operations (Angular) · **Rota:** `/operations/queue` · **Quem:** Bruno Lima, operador, o dia todo · **Tamanhos:** desktop 1440 px e celular 390 px

## Na história

- **Ator e papel:** Bruno, o operador: cuida das exceções que o portal não resolveu sozinho.
- **História:** Como operador, quero uma fila priorizada, para atender primeiro quem mais precisa e seguir para o próximo.
- **Momento:** Começo do dia, depois do login (B01). Abre a ficha do devedor (B05).
- **O que a tela precisa deixar claro:**
  - Que a fila é dele e por que cada devedor está nela (promessa vencida, nunca contatado).
  - O ritmo: pegar o próximo, entender, agir, seguir.

## Objetivo

O lugar onde o operador passa o dia. Precisa ser escaneável, previsível e rápido de navegar pelo teclado: pegar o próximo, entender, agir, seguir.

## Conteúdo

- Três indicadores no topo: **Na sua fila: 37** · **Acordos hoje: 6** · **Recuperado hoje: R$ 4.812,30**.
- Filtros em pílula por Faixa de atraso (Todas, 0–30, 31–90, 91–180, 181–360, +360) e por situação (Promessa vencida, Nunca contatado).
- Lista (tabela) com colunas: Devedor · CPF mascarado · Faixa · Valor atualizado · Última tratativa · Próxima ação. Exemplo:
  1. Ana Souza · ***.456.789-** · 91–180 · R$ 1.060,00 · ligação há 2 dias · promessa vence hoje
  2. Marcos Pereira · ***.112.334-** · +360 · R$ 3.420,18 · nunca contatado · —
  3. Juliana Costa · ***.908.221-** · 31–90 · R$ 612,40 · mensagem ontem · ligar
  4. Roberto Alves · ***.775.019-** · 181–360 · R$ 2.150,00 · promessa quebrada · prioridade
  5. Fernanda Lima · ***.330.587-** · 0–30 · R$ 289,90 · nunca contatado · —
  6. Paulo Henrique · ***.661.402-** · 91–180 · R$ 1.875,55 · ligação há 5 dias · ligar
  7. Camila Rocha · ***.204.913-** · 31–90 · R$ 940,00 · nota há 1 semana · —
  8. Diego Martins · ***.587.336-** · +360 · R$ 5.010,72 · mensagem há 3 semanas · prioridade
- Painel lateral à direita com a pré-visualização do devedor selecionado e o botão **Abrir ficha**.
- Atalhos visíveis no rodapé: `J`/`K` próximo e anterior, `Enter` abrir ficha.

## Estados

1. Lista com seleção.
2. Carregando (esqueleto de linhas).
3. Fila vazia: "Sua fila está em dia" com o que fazer em seguida.
4. Devedor reservado por outro operador: a linha mostra "Com Carla" e um cadeado discreto.
5. Item novo chegando ao vivo: destaque sutil e passageiro na linha.

## Notas

- Densidade alta, mas com respiro: altura de linha confortável para 8 horas de uso.
- Promessa vencida sobe para o topo; destaque por posição e ícone, não por vermelho.
