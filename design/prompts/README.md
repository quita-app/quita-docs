# Prompts de tela para o Claude Design

Um prompt por tela do MVP, na ordem em que vamos prototipar. Cada tela é gerada no projeto **Quita · Design System** do Claude Design, depois que o design system foi aprovado, e só passa para a próxima com a aprovação do usuário.

## Antes de cada sessão

No projeto do Claude Design, garanta que estão disponíveis:
- `quita-docs/design/PRODUCT.md` (produto, público, tom, restrições);
- o `DESIGN.md` gerado pelo Claude Design (tokens e componentes aprovados);
- as telas já aprovadas, para manter a consistência.

Cole primeiro o **preâmbulo** (`00-preamble.md`) e depois o prompt da tela.

## Ordem e status

**Meta da primeira sessão:** o fluxo completo da Ana, de P01 a P08. A P00 (landing) fica para o fim do portal, porque reaproveita as telas aprovadas.

**Como começar uma sessão no Claude Design (a mesma frase sempre):**

> Leia `design/prompts/README.md` e `design/prompts/00-preamble.md` e siga o ciclo a partir do primeiro item com status "a gerar".

**Modo lote (gerar tudo e revisar depois):**

> Leia `design/prompts/README.md` e `design/prompts/00-preamble.md` e gere em modo lote todas as telas com status "a gerar", seguindo a seção "Modo lote" do preâmbulo.

**Sessão de correção (depois da revisão):**

> Leia `design/prompts/00-preamble.md` e `design/review/corrections.md` e aplique as correções tela por tela.

O preâmbulo manda ler o `PRODUCT.md`, o `DESIGN.md`, o `ux-writing.md` e o prompt da tela, e parar a cada tela para aprovação. Os textos de todas as telas vêm do `design/ux-writing.md`.

Em 2026-11-11 cada prompt ganhou a seção "Na história" (ator, papel, momento da jornada) e a regra 8 do preâmbulo. As telas são regeneradas com ela; a P00 também perde as referências a portfólio e ao GitHub.

| # | Tela | App | Rota | Status |
| --- | --- | --- | --- | --- |
| F0 | Ajustes do design system (`01-design-system-fixes.md`): aplique no canvas e no `DESIGN.md` | todos | — | aprovada |
| P00 | Landing page do Quita | portal | `/` | a regenerar (história) |
| P01 | Página da credora | portal | `/c/[slug]` | a regenerar (história) |
| P02 | Acesso: CPF | portal | `/c/[slug]/access` | a regenerar (história) |
| P03 | Acesso: código | portal | `/c/[slug]/access/verify` | a regenerar (história) |
| P04 | Suas dívidas | portal | `/c/[slug]/debts` | a regenerar (história) |
| P05 | Detalhe da dívida e composição do valor | portal | `/c/[slug]/debts/[debtId]` + `breakdown` | a regenerar (história) |
| P06 | Simulador | portal | `/c/[slug]/debts/[debtId]` | a regenerar (história) |
| P07 | Revisar e fechar acordo | portal | `/c/[slug]/debts/[debtId]` | a regenerar (história) |
| P08 | Pix da entrada e acordo fechado | portal | `.../installments/[installmentId]/pay` | a regenerar (história) |
| P09 | Acompanhar o acordo | portal | `/c/[slug]/agreements/[agreementId]` | a regenerar (história) |
| P10 | Estados globais do portal | portal | todas | a regenerar (história) |
| B01 | Login e convite | shell | `/login`, `/invitations/:token` | a regenerar (história) |
| B02 | Moldura do backoffice | shell | todas | a regenerar (história) |
| B03 | Fila de trabalho | operations | `/operations/queue` | a regenerar (história) |
| B04 | Busca de Devedores | operations | `/operations/debtors` | a regenerar (história) |
| B05 | Ficha do Devedor | operations | `/operations/debtors/:id` | a regenerar (história) |
| B06 | Negociar pela ficha | operations | `/operations/debtors/:id` | a regenerar (história) |
| B07 | Importações e nova importação | operations | `/operations/imports` | a regenerar (história) |
| B08 | Importação em andamento e relatório de erros | operations | `/operations/imports/:id` | a regenerar (história) |
| B09 | Versões da Política | operations | `/operations/policies` | a regenerar (história) |
| B10 | Editor da Política | operations | `/operations/policies/:id` | a regenerar (história) |
| B11 | Pagamentos não conciliados | operations | `/operations/payments` | a regenerar (história) |
| B12 | Usuários e convites | operations | `/operations/admin/users` | a regenerar (história) |
| B13 | Credoras | operations | `/operations/admin/creditors` | a regenerar (história) |
| B14 | Painel | analytics | `/analytics` | a regenerar (história) |
| D1 | Dark mode de todas as telas aprovadas, numa passada só, com os tokens escuros do `DESIGN.md` | todos | — | a regenerar (história) |

O portal vem primeiro porque é a vitrine do produto e onde a identidade aparece mais. Fase 2 e 3 (contestação, régua, white-label, auditoria, chat) ganham prompts quando chegarem.

## Checklist de aprovação de cada tela

- [ ] Usa só tokens e componentes do design system aprovado (ou diz qual componente novo criou e por quê).
- [ ] Tem todos os estados pedidos no prompt (carregando, vazio, erro e os específicos).
- [ ] Light mode (o dark vem no D1); portal e backoffice em 1440 e 390 px (uma única versão web).
- [ ] Estados globais não repetidos (só citados no resumo).
- [ ] Textos em pt-BR, no tom do `PRODUCT.md`, sem palavras proibidas no portal.
- [ ] Números conferem com o exemplo da Ana e com as regras de `docs/lld/api.md`.
- [ ] Nada que o front não consiga montar com Tailwind + shadcn/ui (React/Next) ou Spartan UI (Angular).
- [ ] Foco visível, alvos de toque ≥ 44 px no portal, contraste AA.

Tela aprovada: exporte para `design/hi-fi/<id>-<nome>/` e marque o status aqui.
