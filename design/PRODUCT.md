# Product

<!-- impeccable:product-schema 1 -->

Registro de produto para o trabalho de design (skill impeccable-design). Resume o que o design precisa saber e aponta para os documentos donos de cada fato; em caso de divergência, vale o documento dono.

## Platform

web

## Stack

- **Portal do devedor:** Next.js (`quita-debtor-portal-web`), público e mobile-first.
- **Backoffice da credora:** monorepo Nx com shell Angular e remote Angular de Operações (Spartan UI), mais remote React de Analytics (shadcn/ui).
- **API:** Java, Spring Boot e PostgreSQL (`quita-backend-api`), com gateway de pagamento simulado.
- Os três fronts consomem os mesmos tokens (CSS custom properties e tema do Tailwind). Dono: `README.md` e `docs/hld.md`.

## Users

- **Devedor:** pessoa física (ou jurídica) que deve a uma credora de médio porte. Muitas vezes envergonhado, no celular, à noite ou no fim de semana. Quer entender quanto deve e por quê, simular e fechar um acordo sozinho, sem falar com ninguém, pagando a entrada por Pix em poucos minutos.
- **Operador:** pessoa da credora que trabalha a fila o dia todo no desktop, abre a ficha do devedor, registra tratativas e envia propostas ao devedor dentro da política (o acordo nasce quando o devedor aceita no portal).
- **Gestor:** dono ou gerente financeiro da credora. Importa as dívidas, define a política por faixa de atraso, registra dívidas pagas fora do Quita e acompanha quanto recuperou (aprovar exceções é da Fase 2). É o comprador.
- **Admin da plataforma:** time do Quita; cadastra credoras e dá suporte.

Definições: `GLOSSARY.md`. Perfil e gatilho de compra: `docs/product-brief.md`, seção Público-alvo.

## Product Purpose

Plataforma B2B de cobrança e renegociação de dívidas para credoras de médio porte (escolas, clínicas, academias, varejo regional, SaaS). A credora sobe a carteira e define até onde aceita negociar; o devedor resolve sozinho pelo celular; o operador cuida só das exceções; o gestor vê quanto recuperou. O nome vem de **quitar**: pagar o que deve e ficar em dia.

Sucesso: o fluxo da Ana, do link ao acordo pago, funciona em menos de 3 minutos no celular, e o painel mostra taxa de recuperação, conversão do autoatendimento e taxa de quebra. Metas: `docs/product-brief.md`, seção Objetivos.

## Positioning

A credora de médio porte ganha o autoatendimento que hoje só grandes credoras têm nos birôs (Serasa Limpa Nome, Acordo Certo), com a política dela, sem depender de assessoria nem de planilha. O desconto e as parcelas seguem regras da credora por faixa de atraso e o sistema aplica; ninguém negocia fora delas sem aprovação. Do lado do devedor, a cobrança baixa a tensão em vez de ameaçar.

## Operating Context

- **Devedor:** recebe o link pela régua, entra com CPF e código de 6 dígitos, vê as dívidas com valor original, valor atualizado e o que o compõe, simula de 1x a 10x, fecha o acordo e paga a entrada por Pix. O acordo só fica ativo depois que a entrada é paga.
- **Operador:** fila priorizada, filtro por faixa de atraso, ficha com linha do tempo de tratativas, promessa de pagamento e proposta enviada ao devedor (pedido de exceção: Fase 2).
- **Gestor:** importação de CSV com pré-visualização e relatório de erros, política por faixa de atraso, pagamento fora do Quita, painel com indicadores da carteira (aprovação de exceções: Fase 2).
- **Estados da dívida e do acordo** (aberta, em negociação, em acordo, quitada, quebrada) e as regras de quebra: `docs/foundation/business-requirements.md`.
- **Hospedagem gratuita:** a API dorme após 15 minutos sem uso e leva cerca de 1 minuto para acordar. As telas precisam de um estado de espera honesto para isso (`docs/adr/0007-free-tier-hosting.md`).

## Capabilities and Constraints

- Escopo do MVP, fora de escopo e prazo (8 semanas, uma pessoa, 4 h por dia): `docs/product-brief.md`.
- Pix simulado (só Pix no MVP; boleto depois); e-mail e SMS vão para uma caixa de saída simulada.
- Dinheiro: o valor atualizado é principal + multa (máximo de 2%) + juros + correção. O desconto cai com o número de parcelas, a entrada mínima é de 15% e o centavo de resíduo vai para a última parcela. Regras e números: `docs/foundation/business-requirements.md`, exemplo da Ana (seção 2.4).
- Interface em pt-BR, moeda BRL, fuso de São Paulo. Valores sempre com algarismos tabulares.
- Light e dark mode, os dois de primeira classe.
- **Linguagem do portal:** nunca "inadimplente", "devedor" ou "débito em atraso" na tela do devedor. Ele vê "suas dívidas", "em aberto", "valor atualizado". O backoffice usa o vocabulário do `GLOSSARY.md`.
- **Escrita:** frases curtas, voz ativa, sem jargão de cobrança. O botão diz o que acontece ("Fechar acordo", "Copiar código Pix") e o retorno usa a mesma palavra ("Acordo fechado"). Erro explica o que houve e como resolver, sem pedir desculpas.
- CDC art. 42: a cobrança não pode expor ao ridículo, constranger ou ameaçar.
- LGPD: dado sensível mascarado (CPF parcial no backoffice) e fora dos logs.
- Desempenho: LCP do portal < 2,5 s em 4G; listagens do backoffice com p95 < 300 ms com 1 milhão de dívidas.

## Brand Commitments

- Nome: **Quita**, escrito em minúsculas no logo.
- Tom: calmo, honesto e humano. Cobrança costuma ser agressiva; o Quita é o oposto. Atraso é informação, não ameaça: vermelho nunca é a cor dominante de dívida ou atraso.
- O momento mais importante do produto é o acordo fechado e a dívida quitada, que merecem uma celebração contida.
- Decidido com o usuário em 2026-11-10: base de cor azul calma (no Brasil, quem está em dia "está no azul"); o estado quitado em verde; logo com o símbolo do "q" cujo rabinho é um visto (Versão 1, "Céu", no canvas de design). Detalhes visuais vão para o DESIGN.md e o `docs/design-system.md`, não para este arquivo.

## Evidence on Hand

- Projeto de portfólio em fase de planejamento (MVP), **sem clientes, credoras reais, depoimentos ou dados de resultado**. As métricas do brief são hipóteses. Nenhuma superfície pode apresentar números, clientes ou depoimentos como reais.
- Dados de exemplo para telas: o caso da Ana Souza na Escola Horizonte (mensalidade de agosto, R$ 1.000,00 original, R$ 1.060,00 atualizado, 120 dias). Os números do painel (23,4%, R$ 184.320,00) vêm do briefing de design e são ilustrativos.
- Referências visuais e análise: `../quita-mentor/design/references/` (10 capturas + `README.md`, no repo privado de mentoria). Briefing de design: `../quita-mentor/design/prompts/01-design-system-directions.md`.
- Documentos aprovados: `docs/product-brief.md`, `GLOSSARY.md`, `docs/hld.md`, `docs/lld/`, `docs/adr/` (0001 a 0013).

## Product Principles

1. **Baixar a tensão, nunca constranger.** Cada tela do portal deve deixar o devedor mais calmo do que chegou.
2. **O valor fica claro antes de tudo.** Quanto deve, por quê e quanto vai pagar aparecem sem precisar procurar.
3. **A política é da credora.** O sistema aplica as regras e mostra os limites; não improvisa condições.
4. **Resolver sozinho, em minutos.** No portal, uma decisão por tela; o operador existe para as exceções.
5. **Calma sob volume.** O backoffice é denso, mas escaneável e previsível para quem trabalha nele o dia todo.

## Accessibility & Inclusion

- Portal com WCAG 2.2 AA, nota 100 no Lighthouse Acessibilidade e uso completo por teclado (`docs/product-brief.md`, requisitos não funcionais). O mesmo contraste AA vale para o backoffice.
- Usado no celular, à noite: dark mode de primeira classe e alvos de toque de pelo menos 44 px.
- `prefers-reduced-motion` respeitado em toda animação, inclusive na celebração do acordo fechado.
