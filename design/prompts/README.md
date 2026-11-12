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
| P00 | Landing page do Quita | portal | `/` | gerada (história), a revisar |
| P01 | Página da credora | portal | `/c/[slug]` | gerada (história), a revisar |
| P02 | Acesso: CPF | portal | `/c/[slug]/access` | gerada (história), a revisar |
| P03 | Acesso: código | portal | `/c/[slug]/access/verify` | gerada (história), a revisar |
| P04 | Suas dívidas | portal | `/c/[slug]/debts` | gerada (história), a revisar |
| P05 | Detalhe da dívida e composição do valor | portal | `/c/[slug]/debts/[debtId]` + `breakdown` | gerada (história), a revisar |
| P06 | Simulador | portal | `/c/[slug]/debts/[debtId]` | gerada (história), a revisar |
| P07 | Revisar e fechar acordo | portal | `/c/[slug]/debts/[debtId]` | gerada (história), a revisar |
| P08 | Pix da entrada e acordo fechado | portal | `.../installments/[installmentId]/pay` | gerada (história), a revisar |
| P09 | Acompanhar o acordo | portal | `/c/[slug]/agreements/[agreementId]` | gerada (história), a revisar |
| P10 | Estados globais do portal | portal | todas | gerada (história), a revisar |
| B01 | Login e convite | shell | `/login`, `/invitations/:token` | gerada (história), a revisar |
| B02 | Moldura do backoffice | shell | todas | gerada (história), a revisar |
| B03 | Fila de trabalho | operations | `/operations/queue` | gerada (história), a revisar |
| B04 | Busca de Devedores | operations | `/operations/debtors` | gerada (história), a revisar |
| B05 | Ficha do Devedor | operations | `/operations/debtors/:id` | gerada (história), a revisar |
| B06 | Negociar pela ficha | operations | `/operations/debtors/:id` | gerada (história), a revisar |
| B07 | Importações e nova importação | operations | `/operations/imports` | gerada (história), a revisar |
| B08 | Importação em andamento e relatório de erros | operations | `/operations/imports/:id` | gerada (história), a revisar |
| B09 | Versões da Política | operations | `/operations/policies` | gerada (história), a revisar |
| B10 | Editor da Política | operations | `/operations/policies/:id` | gerada (história), a revisar |
| B11 | Pagamentos não conciliados | operations | `/operations/payments` | gerada (história), a revisar |
| B12 | Usuários e convites | operations | `/operations/admin/users` | gerada (história), a revisar |
| B13 | Credoras | operations | `/operations/admin/creditors` | gerada (história), a revisar |
| B14 | Painel | analytics | `/analytics` | gerada (história), a revisar |
| D1 | Dark mode de todas as telas aprovadas, numa passada só, com os tokens escuros do `DESIGN.md` | todos | — | gerada (história), a revisar |

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
