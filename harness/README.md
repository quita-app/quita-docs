# Harness dos repos de código

O harness é o que faz o agente de IA trabalhar bem num repo: as instruções (`AGENTS.md`, `CLAUDE.md`), as regras da stack (skills em `.claude/skills/`) e as permissões (`.claude/settings.json`). **Cada repo de código tem o seu.** Esta pasta guarda o **kit inicial** de cada um, porque os repos nascem pelos CLIs (Nx, `create-next-app`, Spring Initializr), que recusam ou sobrescrevem uma pasta que já tenha arquivos.

Depois de instalado, o kit **passa a pertencer ao repo**: é lá que ele evolui. Esta pasta fica como ponto de partida e referência; não é sincronizada de volta.

## Quem é dono de quê

| O quê | Onde mora | Por quê |
| --- | --- | --- |
| Produto, arquitetura, vocabulário, roadmap, PRD, spec e tarefas | `quita-docs` | São do sistema inteiro; uma funcionalidade toca vários repos |
| Skills de planejamento (`product-brief`, `prd`, `to-spec`, `to-tasks`, `domain-modeling`, `grilling`) | `quita-docs/.claude/skills/` | O planejamento acontece no `quita-docs` |
| Comandos, estrutura, convenções e regras da stack | Cada repo de código (`AGENTS.md` + `.claude/skills/<stack>-rules/`) | São daquele repo e mudam com ele |
| Contexto compartilhado (glossário) | `quita-docs`, importado pelo `CLAUDE.md` de cada repo | Um fato, um lugar |

Os repos de código **leem** o `quita-docs` (glossário, LLD, tarefas) e nunca copiam o conteúdo dele. Por isso os quatro repos ficam lado a lado na mesma pasta.

## O que há em cada kit

```
harness/<repo>/
  AGENTS.md                  instruções do repo: o que é, comandos, estrutura, convenções
  CLAUDE.md                  aponta para o AGENTS.md e importa o glossário do quita-docs
  dot-claude/                vira .claude/ na instalação
    settings.json            dá ao agente acesso de leitura ao ../quita-docs
    skills/<stack>-rules/    convenções da stack, usadas na revisão de código
  gitignore.snippet          linhas a acrescentar ao .gitignore gerado pelo CLI
  .env.example               variáveis de ambiente (quando o repo tem)
```

## Instalar num repo recém-criado

Depois que o CLI gerou o repo (e fez o `git init`), na pasta que contém os repos:

```bash
bash quita-docs/harness/install.sh quita-backend-api
bash quita-docs/harness/install.sh quita-backoffice-web
bash quita-docs/harness/install.sh quita-debtor-portal-web
```

O script copia os arquivos do kit para o repo (sem sobrescrever nada que já exista), renomeia `dot-claude` para `.claude` e acrescenta o trecho do `.gitignore`. Depois dele:

1. Preencha no `AGENTS.md` do repo as versões fixadas e confira os comandos com o que o CLI gerou.
2. Faça o commit: `chore: add agent harness`.

## Arquivos pessoais (nunca versionados)

O `.gitignore` de cada repo ignora `CLAUDE.local.md` e `.claude/settings.local.json`. Eles servem para instruções e permissões pessoais de quem desenvolve e não fazem parte do projeto.
