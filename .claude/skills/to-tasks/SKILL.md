---
name: to-tasks
description: Quebra a spec aprovada de uma funcionalidade do Quita em tarefas (fatias verticais com critérios de aceite, repos tocados e bloqueios) e grava uma por arquivo em docs/features/<NN>-<title>/tasks/. Use depois da spec, quando o usuário pedir as tarefas ou "quebra a F<NN>".
---

# Tarefas de uma funcionalidade

Quebre a spec em **tarefas**: fatias pequenas, verificáveis sozinhas, cada uma declarando o que entrega, que repos toca e o que a bloqueia.

## Antes de quebrar: ler

O `prd.md` e o `spec.md` da funcionalidade, o bloco dela no `docs/roadmap.md` (tamanho e prazo) e o estado atual dos repos tocados.

## Regras das fatias

- **Vertical.** Cada tarefa corta um caminho estreito, mas completo, e pode ser demonstrada ao final. "Criar todas as entidades" ou "fazer todos os componentes" não é tarefa.
- **Contrato primeiro.** Quando a funcionalidade toca API e front, a primeira fatia de cada caminho fecha o contrato na API (rota respondendo, `openapi.json` atualizado); a tarefa de front que o consome fica **bloqueada** por ela. Uma tarefa pode tocar mais de um repo quando a fatia é pequena.
- **Tamanho.** Uma tarefa cabe em uma sessão de trabalho (até 4 h). Maior que isso, divida.
- **Refatoração prévia vem primeiro**, numa tarefa própria: torne a mudança fácil, depois faça a mudança fácil.
- **Mudança que quebra** (coluna renomeada, tipo compartilhado) é organizada em expandir e contrair: uma tarefa expande, as seguintes migram, a última contrai.

## Bloqueios e decisões compartilhadas

- Cada tarefa lista as tarefas que precisam estar concluídas antes dela.
- Entre tarefas sem bloqueio entre si, procure a **decisão que mais de uma teria de tomar** (o nome de um campo, o formato de um evento, a forma de um componente compartilhado). Dê a ela um destino: uma tarefa anterior que decide e bloqueia as outras, ou o encadeamento das duas.

## Processo

1. Rascunhe a lista e mostre ao usuário, para cada tarefa: título · repos · bloqueada por · o que entrega. Mostre também as **ondas** (o que pode começar junto) e a tabela de decisões compartilhadas.
2. Pergunte: a granularidade está certa? Os bloqueios estão corretos? Algo deve ser juntado ou dividido? Cabe no tamanho da funcionalidade no roadmap?
3. Repita até aprovar. Ao juntar, dividir ou remover uma tarefa, confira de novo bloqueios, decisões e ondas.
4. Grave uma tarefa por arquivo em `docs/features/<NN>-<title>/tasks/<NN>-<title>.md`, numeradas na ordem de dependência. Fora da pasta, a tarefa é `F<NN>-T<NN>`.
5. Atualize o status da funcionalidade no `docs/roadmap.md` para `em andamento` quando a primeira tarefa começar.

## Molde do arquivo de tarefa

```markdown
# F<NN>-T<NN> · <Título da tarefa>

**Status:** a fazer
**Repos:** `quita-backend-api`, `quita-backoffice-web`
**Bloqueada por:** F<NN>-T<NN> · <título>, ou "Nenhuma"
**Decisões consumidas:** a decisão, numa linha, e a tarefa que a possui (omita se não houver)

## O que construir

O comportamento de ponta a ponta que esta tarefa faz funcionar, do ponto de vista de quem usa. Não é uma lista de implementação camada por camada.

## Critérios de aceite

- [ ] **CA1** · critério verificável
- [ ] **CA2** · ...

## Como demonstrar

Os passos para ver funcionando (tela, chamada ou teste), em 2 a 5 linhas.
```

- **Status** de uma tarefa: `a fazer` → `em andamento` → `em revisão` → `concluída`.
- `CA<n>` é um identificador estável: não muda quando a tarefa é editada, e o número de um critério removido não é reaproveitado. Cada CA da tarefa aponta, quando fizer sentido, para o CA do PRD que ele atende.
- Sem caminho de arquivo nem código: eles envelhecem rápido. Exceção: uma forma que carrega decisão (um corpo de requisição, um estado).

Commit só a pedido.
