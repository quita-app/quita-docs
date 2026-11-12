# AGENTS.md: quita-docs

O `quita-docs` é a documentação e o planejamento do **Quita**, uma plataforma B2B de cobrança e renegociação de dívidas. Aqui ficam o produto, a arquitetura, o vocabulário do domínio, as funcionalidades e as skills de spec-driven development (SDD). Nenhum código de produção mora aqui.

## Os repositórios do Quita

Os repos ficam lado a lado na mesma pasta (`quita/`), e os caminhos relativos entre eles (`../quita-backend-api`) dependem disso.

| Repo | O que é |
| --- | --- |
| `quita-docs` | Este: documentação, planejamento e skills de SDD |
| `quita-backoffice-web` | Monorepo Nx: shell Angular + remote Angular (Operações) + remote React (Analytics) |
| `quita-debtor-portal-web` | Next.js: portal público do devedor |
| `quita-backend-api` | Spring Boot: monólito modular + gateway de pagamento fake |

Cada repo de código tem o próprio harness (`AGENTS.md`, `CLAUDE.md`, regras da stack). O kit inicial de cada um mora em `harness/<repo>/` e é instalado com `harness/install.sh` logo depois do CLI que cria o repo; daí em diante ele pertence ao repo. O `CLAUDE.md` de cada repo importa o glossário daqui e o `.claude/settings.json` dá acesso de leitura a esta pasta. Detalhes em `harness/README.md`.

## Documentos

| Documento | O que guarda | Status |
| --- | --- | --- |
| `docs/foundation/business-requirements.md` | Requisitos de negócio, módulos, regras e o exemplo da Ana | rascunho |
| `docs/product-brief.md` | O quê e para quem, escopo do MVP | aprovado |
| `GLOSSARY.md` | Vocabulário do domínio, com o nome em código de cada termo | aprovado |
| `docs/hld.md` | Arquitetura de alto nível | aprovado |
| `docs/lld/<frente>.md` | Detalhe de implementação de cada frente | `database.md`, `api.md`, `backoffice.md` e `portal.md` aprovados |
| `docs/adr/` | Decisões de arquitetura | aceitas: 0001 a 0013 (0005 substituída) |
| `docs/design-system.md` | Identidade visual, tokens, componentes, fluxo design → código | a criar |
| `docs/roadmap.md` | Funcionalidades, dependências e status | rascunho |
| `design/PRODUCT.md` | Registro de produto para as skills de design (aponta para os documentos donos) | criado pelo Claude Design |
| `design/ux-writing.md` | Voz, tom, formatos, padrões de mensagem e o catálogo de textos de cada tela | aprovado |
| `design/DESIGN.md` | Design system Céu: tokens, tipografia, raios, componentes | aprovado com ajustes (F0) |
| `design/prompts/` | Preâmbulo, ajustes e um prompt por tela (P00–P10, B01–B14) | pronto |
| `design/hi-fi/` | Telas aprovadas, exportadas do Claude Design | aprovado |
| `docs/features/<NN>-<title>/` | PRD, spec e tarefas de cada funcionalidade | F01 em rascunho |
| `docs/review/` | Auditoria de consistência e a linha de base do MVP (`mvp-baseline.md`: escopo, regras, decisões, impacto no banco) | aplicada em 2026-11-12 |
| `harness/<repo>/` | Kit de harness de cada repo de código, instalado depois do CLI | pronto |

**Um fato, um lugar.** Cada informação tem um documento dono, e os outros apontam para ele pelo nome do documento e da seção, sem repetir o conteúdo.

## Planejamento

Os arquivos markdown deste repo são o issue tracker do projeto. A hierarquia é **funcionalidade → tarefa**:

```
docs/features/<NN>-<title>/
  prd.md               ← requisitos de produto (o quê)
  spec.md              ← como será construída
  tasks/
    <NN>-<title>.md    ← a tarefa e os critérios de aceite (CA1, CA2...)
```

- Números com dois dígitos, títulos em kebab-case e em inglês (`01-walking-skeleton`).
- Fora da pasta, uma tarefa é identificada como `F<NN>-T<NN>` (ex.: `F01-T02`).
- Uma funcionalidade é uma entrega demonstrável, descrita pelo que a pessoa consegue fazer. Uma tarefa pode tocar mais de um repo de código.
- O status de cada funcionalidade mora no `docs/roadmap.md`; o de cada tarefa, num campo Status no topo do arquivo dela.

## Convenções

- **Idioma:** documentos em português do Brasil. Código, nomes de arquivos e de pastas, slugs, branches e commits em inglês.
- **Commits:** semânticos, em inglês, uma frase (`docs: add product brief`). Commit, push e PR só a pedido do usuário.
- **Branches:** `main` + `feature/*`, `bugfix/*`, `hotfix/*`, `docs/*`.
- **Pastas vazias** levam um `.gitkeep`.
- **Arquivos gerados por CLI** (Nx, Next, Spring Initializr) nunca são escritos à mão: quem roda o CLI é o usuário.

## Skills

Ficam em `.claude/skills/`.

| Skill | Para quê | Status |
| --- | --- | --- |
| `product-brief` | Entrevista e grava o product brief | pronta |
| `grilling` | Sabatina um plano em rodadas | pronta |
| `domain-modeling` | Glossário e ADRs | pronta |
| `grill-with-docs` | Sabatina + glossário e ADRs | pronta |
| `frontend-design` | Direção visual e acabamento de interface (oficial da Anthropic, Apache 2.0) | instalada |
| `prd` | PRD de uma funcionalidade do roadmap | pronta |
| `to-spec` | Spec técnica a partir do PRD | pronta |
| `to-tasks` | Tarefas (fatias verticais) a partir da spec | pronta |

As regras de cada stack (`spring-rules`, `angular-rules`, `react-rules`, `nextjs-rules`) moram no harness de cada repo de código.

Quando uma skill divergir deste arquivo, vale este arquivo.
