# Quita · documentação

O **Quita** é uma plataforma B2B de cobrança e renegociação de dívidas. A credora sobe a carteira de inadimplentes e define até onde aceita negociar. O devedor resolve sozinho, pelo celular, e os operadores da credora cuidam só das exceções.

Este repositório é a **fonte única** do produto e da arquitetura: requisitos, decisões, vocabulário do domínio e planejamento de cada funcionalidade. Ele não tem código de produção. O código mora nos repositórios abaixo, que importam daqui o glossário e o desenho da sua frente.

## Repositórios

| Repositório | O que é | Stack |
| --- | --- | --- |
| `quita-docs` | Este: produto, arquitetura e planejamento | Markdown, Mermaid |
| `quita-backoffice-web` | Backoffice da credora, em micro front-ends | Nx, Angular (shell e Operações), React (Analytics) |
| `quita-debtor-portal-web` | Portal público do devedor | Next.js |
| `quita-backend-api` | Regras de negócio, dados e integrações | Java, Spring Boot, PostgreSQL |

## Por onde começar

1. [Product brief](docs/product-brief.md): o quê, para quem e o escopo do MVP.
2. [Requisitos de negócio](docs/foundation/business-requirements.md): como o negócio de cobrança funciona, com um exemplo completo em números.
3. [Glossário](GLOSSARY.md): o vocabulário do domínio e o nome de cada termo no código.
4. [HLD](docs/hld.md): a arquitetura de alto nível, com diagramas.
5. [ADRs](docs/adr/): as decisões de arquitetura e as alternativas descartadas.

## Estrutura

```
docs/
  foundation/     requisitos de negócio
  product-brief.md
  hld.md          arquitetura de alto nível
  lld/            detalhe de implementação de cada frente
  adr/            decisões de arquitetura
  features/       uma pasta por funcionalidade: PRD, spec e tarefas
design/           protótipos low-fi e hi-fi
.claude/skills/   skills de spec-driven development usadas com o Claude Code
```

## Como o projeto é construído

O Quita segue spec-driven development: cada funcionalidade passa por PRD → spec → tarefas antes do código, e as decisões que mudam o desenho viram ADR. O fluxo é apoiado por skills do Claude Code, em `.claude/skills/`.
