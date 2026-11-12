# Revisão: coerência da estrutura de `libs/` do backoffice

2026-11-12 · Status: **decidido (opção B enxuta, seção 9)** · Origem: dúvida levantada ao executar o guia da Parte 5 (F01-T02)

Este relatório registra uma incoerência na estrutura de pastas do `quita-backoffice-web` e pede a decisão sobre o critério. Nada foi alterado nos docs de origem (LLD, harness, roadmap) nem no repo de código.

## 1. O que existe hoje

Fonte: `docs/lld/backoffice.md`, seção 2, e o repo (`libs/` criado na Parte 5, ainda sem commit).

```
libs/
  shared/      api-types · design-tokens · util                 (TS puro)
  angular/     ui · data-access · session · realtime            (camadas técnicas, Angular)
  operations/  feature-queue · feature-imports · feature-policies
               feature-payments · feature-admin                 (features do domínio)
  react/       ui                                               (camada técnica, React)
apps/
  shell · operations · analytics · shell-e2e
```

Tags (`type:*` e `scope:*`) por projeto; a regra `@nx/enforce-module-boundaries` barra import proibido.

## 2. A incoerência

O primeiro nível de `libs/` usa **três critérios diferentes**:

| Pasta | Critério | O que guarda |
| --- | --- | --- |
| `shared/` | neutralidade de framework | código TS puro, usado por todos |
| `angular/`, `react/` | **framework** | camadas técnicas (ui, data-access, session, realtime) |
| `operations/` | **domínio** | features de negócio |

Consequências observadas:

1. **Falta simetria.** Existe `libs/operations/feature-*` (domínio), mas não existe `libs/analytics/feature-*`. O Painel (Analytics) não tem lib de feature em nenhum lugar do LLD.
2. **O Analytics tende a engordar o app.** O roadmap F14 lista `apps/analytics` e `libs/react/ui` como os repos tocados. As telas do Painel (cards, aging, filtros com `useReducer`, `useTransition`, TanStack Query, Recharts) ficam em `apps/analytics`. Isso contradiz a regra "apps finos: entry point, configuração e composição" adotada para o resto do monorepo.
3. **O nome da pasta não prevê onde cada coisa vai.** Quem procura "o código do Painel" não sabe se é `libs/react/`, `libs/analytics/` ou `apps/analytics/`. Quem procura "a sessão" encontra em `libs/angular/session`, mas a Fila (domínio) está em `libs/operations/`, e as duas coisas são usadas juntas.
4. A pergunta que gerou este relatório: *"se a separação é por domínio, por que não `angular/operations` e `react/analytics`?"* O LLD não declara qual critério vale.

## 3. Por que foi pensado assim (reconstrução a partir do LLD)

O LLD não registra a motivação. O que dá para inferir, e que o agente revisor deve confirmar ou refutar:

- **Federação.** A seção 4 compartilha `angular/session`, `angular/realtime` e `angular/data-access` como **singleton** entre shell e Operações. Essas libs servem a **dois apps Angular**, então não pertencem ao domínio Operações: por isso ficaram em `angular/`, e não em `operations/`.
- **Fronteira Angular × React.** A regra central do T02-CA3 é "Angular nunca importa React". Ter `angular/` e `react/` na árvore deixa essa regra visível a olho nu, além de verificada pela tag `scope:`.
- **Features só no Operações.** No MVP, só o Operações tem várias telas de negócio. O Analytics foi tratado como "um painel só", pequeno o bastante para viver no app (ADR 0012: Web Component).
- **Hipótese não confirmada:** a estrutura foi desenhada para casar com o grafo do T02-CA2 sem decidir antes um critério único de agrupamento.

## 4. O que a documentação oficial do Nx diz

Trecho da doc oficial (colado pelo usuário em 2026-11-12), sobre estrutura de monorepo:

- Dois layouts cobrem a maioria dos casos: **plano** (`packages/`, simplicidade) e **agrupado** (`apps/` + `libs/`, com pastas de agrupamento, "navegabilidade em escala").
- No agrupado, o exemplo agrupa libs **por domínio** (`libs/booking/feature-shell`, `libs/check-in/feature-shell`) e deixa o código comum em `libs/shared/`.
- **Apps finos:** o app guarda o shell implantável (entry point, configuração, composição de features); as features vivem em libs; o alvo é a maioria do código em `libs/`.
- Razões citadas: reuso por padrão, fronteiras aplicáveis (API pública da lib), unidades menores para o `affected`.

O que **não** foi verificado nesta sessão (para o agente revisor conferir nas fontes):

- Se a doc do Nx recomenda explicitamente `libs/<domínio>/<tipo>-<nome>` e a tag `scope:` como forma de expressar o "dono". A convenção de `scope` + `type` vem da Nrwl (livro *Enterprise Angular Monorepo Patterns*), mas a citação exata precisa de checagem.
- Se há recomendação de uma pasta por framework no primeiro nível. Pelo trecho colado, o exemplo oficial **não** faz isso: o framework não aparece na árvore.
- Páginas a consultar no nx.dev: *Folder Structure*, *Project Size* (Concepts → Decisions), *Library Types*, *Enforce Module Boundaries*.

## 5. Opções

| | Opção | Estrutura | Prós | Contras |
| --- | --- | --- | --- | --- |
| A | **Manter e declarar o critério** | Como está, com uma regra escrita: `shared/` = neutro, `angular/` e `react/` = camadas técnicas compartilhadas entre apps do mesmo framework, `<domínio>/` = features | Zero retrabalho; casa com o T02-CA2 e o LLD aprovado | Continua misto; precisa de explicação para quem chega |
| B | **Domínio primeiro, framework só na tag** | `libs/operations/{feature-*,ui,data-access}`, `libs/analytics/{feature-dashboard,ui}`, `libs/shared/*`; `angular/session` e `realtime` viram `libs/platform/*` ou ficam em `shared` com tag `scope:angular` | Um critério só; é o exemplo da doc do Nx; a árvore diz de que negócio cada coisa é | Retrabalho no LLD, harness, guia e tags; libs compartilhadas por shell e Operações (session, realtime) não têm domínio óbvio; a regra Angular × React deixa de ser visível na árvore |
| C | **A + lib de feature do Analytics** | Opção A mais `libs/analytics/feature-dashboard` (`type:feature`, `scope:react`), criada quando o Painel ganhar telas reais (F14) | Corrige a única lacuna concreta (app engordando); mudança pequena e adiável | Mantém o critério misto da opção A |
| D | **Plano** | Todas as libs direto em `libs/` com prefixo (`angular-ui`, `operations-feature-queue`) | Simples, nada a decidir sobre agrupamento | A doc diz que o plano perde navegabilidade acima de algumas dezenas de projetos; 13 libs já pedem agrupamento |

## 6. Recomendação provisória (a confirmar pelo revisor)

**Opção C**: manter a estrutura, escrever o critério no LLD e criar a lib de feature do Analytics quando a F14 começar.

Motivos: a única incoerência que causa dano real é o Painel viver no app; o resto é uma questão de nomenclatura que um parágrafo no LLD resolve; e a opção B tem custo alto (LLD aprovado, harness público, guia, tags) com ganho só estético num monorepo de 4 apps. Se o revisor concluir que o padrão de mercado é inequivocamente domínio-primeiro, a opção B passa a valer e deve ser feita **agora**, antes de existir código nas libs, porque o custo de migrar cresce a cada tarefa.

## 7. O que muda se a estrutura for alterada

Documentos e artefatos que precisam acompanhar a decisão:

- `docs/lld/backoffice.md`, seção 2 (árvore e tabela de tags) e seção 4 (libs compartilhadas na federação)
- `harness/backoffice-web/AGENTS.md` e `harness/backoffice-web/README.md` (árvore de `libs/`)
- `harness/backoffice-web/dot-claude/skills/angular-rules` e `react-rules` (caminhos `libs/angular/*`, `libs/react/*`)
- `docs/roadmap.md`, F14 (lista de repos e pastas)
- `docs/features/01-walking-skeleton/tasks/02-backoffice-workspace.md` (CA2 e CA3)
- No repo de código: `tsconfig.base.json` (apelidos `@quita/*`), tags de cada `project.json`, `eslint.config.mjs` da raiz
- O guia de construção da Parte 5, que lista os 13 comandos de geração

## 8. Perguntas para o agente revisor

1. Qual é a convenção mais usada no mercado para agrupar libs em monorepo Nx com mais de um framework (Angular e React no mesmo workspace)? Domínio, framework ou tipo no primeiro nível?
2. Libs usadas por dois apps do mesmo framework (aqui, `session`, `realtime`, `data-access` entre shell e Operações) pertencem a qual agrupamento no padrão Nx?
3. Um app com um único painel (o Analytics) deve ter uma lib de feature desde o início, ou extrair só quando crescer? Qual o critério de "crescer"?
4. A visibilidade da fronteira Angular × React na árvore de pastas justifica manter `angular/` e `react/` no primeiro nível, ou a tag `scope:` basta?
5. Confirmar ou refutar a reconstrução da seção 3 olhando o ADR 0012 e o histórico do LLD.

## 9. Decisão

- **Opção escolhida:** B, em versão enxuta. Domínio no primeiro nível, framework como tag.

  ```
  libs/
    shared/       api-types · design-tokens · util
      angular/    ui · data-access · session · realtime
    operations/   feature-* · data-access
    analytics/    feature-dashboard · ui
  ```

  Tags em três dimensões: `type:*` (camada), `scope:shell|operations|analytics|shared` (domínio), `framework:angular|react|none`.
- **Motivo:**
  - É o layout agrupado da documentação do Nx, com um critério só: "quem usa?".
  - No Quita, cada domínio tem um framework só, então a fronteira Angular × React continua visível na árvore.
  - `scope:` volta ao uso padrão (domínio).
  - Os serviços de API do Operações saem da lib singleton compartilhada com o shell.
  - O Painel ganha lib de feature, e o app fica fino.
  - As libs ainda não tinham código nem commit: a migração custou só os docs.
- **Data:** 2026-11-12
- **Aplicado em:** LLD seção 2 (e 4, 6, 7), harness (`AGENTS.md`, `README.md`, `angular-rules`, `react-rules`, também no repo), roadmap F02/F04/F14, F01-T02, guia `F01-setup/04-build-backoffice.md` (Parte 5) e guias de estudo do backoffice. No repo, a pasta `libs/` foi apagada e o `nx.json`, o `package.json`, o lock e o `tsconfig.base.json` voltaram ao último commit.
