---
name: Quita · Céu
description: Cobrança que baixa a tensão. Azul calmo, cards brancos sobre campo claro, menta só no quitado.
colors:
  background: "#DCE7F5"
  foreground: "#13203A"
  card: "#FFFFFF"
  card-foreground: "#13203A"
  popover: "#FFFFFF"
  popover-foreground: "#13203A"
  primary: "#13203A"
  primary-foreground: "#FFFFFF"
  secondary: "#E8F0FF"
  secondary-foreground: "#13203A"
  muted: "#E9F0F9"
  muted-foreground: "#576478"
  accent: "#E8F0FF"
  accent-foreground: "#13203A"
  border: "#DCE3EE"
  input: "#707D8F"
  ring: "#4B72C0"
  destructive: "#AB413E"
  destructive-foreground: "#FFFFFF"
  success: "#186E4E"
  warning: "#9D621E"
  info: "#4B72C0"
  signature: "#8DB0F7"
  signature-foreground: "#13203A"
  celebrate: "#91E6BE"
  celebrate-foreground: "#13203A"
  aging-1: "#A5BFEC"
  aging-2: "#8AA5D6"
  aging-3: "#6F8CC1"
  aging-4: "#5371A9"
  aging-5: "#34538F"
  chart-1: "#13203A"
  chart-2: "#4B72C0"
  chart-3: "#258B64"
  chart-4: "#BE7C1C"
  chart-5: "#7B8799"
  dark-background: "#0F1A2C"
  dark-foreground: "#EEF3FA"
  dark-card: "#17233A"
  dark-card-foreground: "#EEF3FA"
  dark-popover: "#1E2C46"
  dark-popover-foreground: "#EEF3FA"
  dark-primary: "#EEF3FA"
  dark-primary-foreground: "#13203A"
  dark-secondary: "#22345A"
  dark-secondary-foreground: "#EEF3FA"
  dark-muted: "#1A2740"
  dark-muted-foreground: "#9AA8BD"
  dark-accent: "#22345A"
  dark-accent-foreground: "#EEF3FA"
  dark-border: "#26354F"
  dark-input: "#647289"
  dark-ring: "#8DB0F7"
  dark-destructive: "#EB827B"
  dark-destructive-foreground: "#13203A"
  dark-success: "#65CFA1"
  dark-warning: "#EAB26B"
  dark-info: "#AFCBFF"
  dark-signature: "#8DB0F7"
  dark-signature-foreground: "#13203A"
  dark-celebrate: "#7CDBB0"
  dark-celebrate-foreground: "#13203A"
  dark-aging-1: "#506386"
  dark-aging-2: "#647BA3"
  dark-aging-3: "#7B96C5"
  dark-aging-4: "#93B2E8"
  dark-aging-5: "#ACCEFF"
  dark-chart-1: "#EEF3FA"
  dark-chart-2: "#8DB0F7"
  dark-chart-3: "#65CFA1"
  dark-chart-4: "#EDB161"
  dark-chart-5: "#A7B2C2"
typography:
  display:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "64px"
    fontWeight: 600
    lineHeight: "68px"
    letterSpacing: "-0.04em"
  h1:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "40px"
    fontWeight: 600
    lineHeight: "44px"
    letterSpacing: "-0.035em"
  h2:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "30px"
    fontWeight: 600
    lineHeight: "36px"
    letterSpacing: "-0.03em"
  h3:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "22px"
    fontWeight: 600
    lineHeight: "28px"
    letterSpacing: "-0.02em"
  h4:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "18px"
    fontWeight: 600
    lineHeight: "24px"
    letterSpacing: "-0.01em"
  body-lg:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "18px"
    fontWeight: 400
    lineHeight: "28px"
  body:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: "24px"
  small:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: "20px"
  caption:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "12px"
    fontWeight: 500
    lineHeight: "16px"
    letterSpacing: "0.01em"
  money-display:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "56px"
    fontWeight: 300
    lineHeight: "60px"
    letterSpacing: "-0.04em"
  money-table:
    fontFamily: "Geist, ui-sans-serif, system-ui, sans-serif"
    fontSize: "14px"
    fontWeight: 500
    lineHeight: "20px"
rounded:
  inner: "10px"
  field: "14px"
  card: "24px"
  container: "36px"
  pill: "9999px"
spacing:
  1: "4px"
  2: "8px"
  3: "12px"
  4: "16px"
  5: "20px"
  6: "24px"
  8: "32px"
  12: "48px"
  16: "64px"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.primary-foreground}"
    rounded: "{rounded.pill}"
    height: "48px"
    padding: "0 22px"
  button-signature:
    backgroundColor: "{colors.signature}"
    textColor: "{colors.signature-foreground}"
    rounded: "{rounded.pill}"
    height: "48px"
    padding: "0 22px"
  button-secondary:
    backgroundColor: "transparent"
    textColor: "{colors.foreground}"
    rounded: "{rounded.pill}"
    height: "48px"
    padding: "0 22px"
  button-ghost:
    backgroundColor: "transparent"
    textColor: "{colors.foreground}"
    rounded: "{rounded.pill}"
    height: "48px"
    padding: "0 22px"
  button-destructive:
    backgroundColor: "transparent"
    textColor: "{colors.destructive}"
    rounded: "{rounded.pill}"
    height: "48px"
    padding: "0 22px"
  button-icon:
    backgroundColor: "{colors.card}"
    textColor: "{colors.foreground}"
    rounded: "{rounded.pill}"
    size: "48px"
  input:
    backgroundColor: "{colors.card}"
    textColor: "{colors.foreground}"
    rounded: "{rounded.field}"
    height: "52px"
    padding: "0 16px"
  otp-cell:
    backgroundColor: "{colors.card}"
    textColor: "{colors.foreground}"
    rounded: "{rounded.field}"
    width: "48px"
    height: "58px"
  badge:
    backgroundColor: "{colors.secondary}"
    textColor: "{colors.secondary-foreground}"
    typography: "{typography.caption}"
    rounded: "{rounded.pill}"
    height: "28px"
    padding: "0 11px"
  badge-paid:
    backgroundColor: "{colors.celebrate}"
    textColor: "{colors.celebrate-foreground}"
    rounded: "{rounded.pill}"
    height: "28px"
  filter-pill:
    backgroundColor: "{colors.card}"
    textColor: "{colors.foreground}"
    rounded: "{rounded.pill}"
    height: "40px"
    padding: "0 16px"
  filter-pill-active:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.primary-foreground}"
  card:
    backgroundColor: "{colors.card}"
    textColor: "{colors.card-foreground}"
    rounded: "{rounded.card}"
    padding: "24px"
  panel:
    backgroundColor: "{colors.card}"
    rounded: "{rounded.container}"
    padding: "32px"
  kpi:
    backgroundColor: "{colors.card}"
    typography: "{typography.money-display}"
    rounded: "{rounded.card}"
    padding: "24px"
  kpi-signature:
    backgroundColor: "{colors.signature}"
    textColor: "{colors.signature-foreground}"
    rounded: "{rounded.card}"
    padding: "24px"
  table-row:
    backgroundColor: "{colors.card}"
    typography: "{typography.small}"
    height: "56px"
    padding: "0 20px"
  toast:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.primary-foreground}"
    rounded: "{rounded.card}"
    padding: "12px 12px 12px 16px"
---

# Design System: Quita · Céu

2026-11-10 · Status: proposta para validação · F0 aprovado (faixas da Política, erro do CPF, datas do acordo, tamanhos, sem metas, "Revisar acordo" na P06) · Produto e público: `PRODUCT.md` (mesma pasta).

Fonte visual: canvas "Quita · Design System" no Claude. À esquerda, o design system (Fundamentos, Componentes claro e escuro, Conceitos e Notas de implementação); à direita, as telas por ator e fluxo, na ordem de `prompts/README.md`. PNGs aprovados: `hi-fi/F0-design-system-fixes/`. Implementação de referência das classes: `quita.css` do canvas.

## Overview

Cobrança costuma ser agressiva; o Quita é o oposto. A interface é **calma, honesta e humana**: campo azul-claro, cards brancos, tinta azul-escura para texto e ação, e uma única cor de assinatura (céu) por tela. A base é azul porque, no Brasil, quem está em dia "está no azul". O verde-menta é reservado para o momento mais importante do produto, o acordo fechado e a dívida quitada.

- **Portal do devedor:** celular, à noite, uma decisão por tela, números grandes e leves.
- **Backoffice:** desktop, o dia todo, denso e escaneável. A marca aparece nos detalhes (pílulas, raios, números leves), não em decoração.
- **Logo:** o "q" cuja haste termina num visto, com a palavra "quita" em Geist 600, minúsculas, tracking −4,5%.

## Colors

Três escalas em OKLCH. Céu (matiz 263°) e Névoa (258°) têm quase o mesmo matiz, então o neutro conversa com o azul.

| Escala | 50 | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 950 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Céu | #F1F7FF | #E8F0FF | #CEE0FF | #AFCBFF | **#8DB0F7** assinatura | #6790E2 | #4B72C0 foco | #37589B | #264074 | #1B2C51 | **#13203A** tinta |
| Névoa | #F7F9FD | #E9F0F9 | **#DCE7F5** campo | #CBD5E4 | #A7B2C2 | #7B8799 | #576478 texto 2 | #404E63 | #28364A | #182437 | #0C1626 |
| Menta | #E6FEF1 | #D1FAE5 | #B1F3D2 | **#91E6BE** quitado | #65CFA1 | #42AF83 | #258B64 | #186E4E sucesso | #0E553B | #0D3C2A | #08281B |

### Mapeamento para shadcn/ui, Spartan UI e Tailwind

Os nomes são os mesmos do shadcn/ui e do Spartan (`:root` para claro, `.dark` para escuro). No Tailwind v4, cada um vira `--color-<nome>: var(--<nome>)` dentro de `@theme inline`.

| Token | Claro | Escuro | shadcn / Spartan | Classe Tailwind |
| --- | --- | --- | --- | --- |
| `--background` | #DCE7F5 | #0F1A2C | padrão | `bg-background` |
| `--foreground` | #13203A | #EEF3FA | padrão | `text-foreground` |
| `--card` / `-foreground` | #FFFFFF / #13203A | #17233A / #EEF3FA | padrão | `bg-card` |
| `--popover` / `-foreground` | #FFFFFF / #13203A | #1E2C46 / #EEF3FA | padrão | `bg-popover` |
| `--primary` / `-foreground` | #13203A / #FFFFFF | #EEF3FA / #13203A | padrão | `bg-primary` |
| `--secondary` / `-foreground` | #E8F0FF / #13203A | #22345A / #EEF3FA | padrão | `bg-secondary` |
| `--muted` / `-foreground` | #E9F0F9 / #576478 | #1A2740 / #9AA8BD | padrão | `text-muted-foreground` |
| `--accent` / `-foreground` | #E8F0FF / #13203A | #22345A / #EEF3FA | padrão | `bg-accent` |
| `--border` | #DCE3EE | #26354F | padrão | `border-border` |
| `--input` | #707D8F | #647289 | padrão | `border-input` |
| `--ring` | #4B72C0 | #8DB0F7 | padrão | `ring-ring` |
| `--destructive` | #AB413E | #EB827B | padrão | `bg-destructive` |
| `--destructive-foreground` | #FFFFFF | #13203A | **extra** (ver abaixo) | `text-destructive-foreground` |
| `--chart-1` a `--chart-5` | ver frontmatter | ver frontmatter | padrão | `fill-chart-1` |
| `--radius` | 24px | 24px | padrão (base) | ver Shapes |
| `--signature` / `-foreground` | #8DB0F7 / #13203A | igual | **Quita** | `bg-signature` |
| `--celebrate` / `-foreground` | #91E6BE / #13203A | #7CDBB0 / #13203A | **Quita** | `bg-celebrate` |
| `--success`, `--warning`, `--info` | #186E4E, #9D621E, #4B72C0 | #65CFA1, #EAB26B, #AFCBFF | **Quita** | `text-success` |
| `--aging-1` a `--aging-5` | #A5BFEC → #34538F | #506386 → #ACCEFF | **Quita** | `bg-aging-3` |

**Faixas de atraso** (as 5 Faixas da Política, nesta ordem): `--aging-1` Até 30 dias · `--aging-2` 31 a 90 · `--aging-3` 91 a 180 · `--aging-4` 181 a 360 · `--aging-5` Mais de 360. A Ana (120 dias) fica na faixa 3.

Pontos de atenção no mapeamento:
- **Sidebar:** o shadcn e o Spartan têm `--sidebar`, `--sidebar-foreground`, `--sidebar-primary`, `--sidebar-accent`, `--sidebar-border` e `--sidebar-ring`. Se o backoffice usar o componente Sidebar, aponte para os tokens de card: `--sidebar: var(--card)`, `--sidebar-foreground: var(--card-foreground)`, `--sidebar-primary: var(--primary)`, `--sidebar-accent: var(--accent)`, `--sidebar-border: var(--border)`, `--sidebar-ring: var(--ring)`.
- **Destrutivo:** as versões atuais do shadcn e do Spartan definem `--destructive` sem `-foreground` e pintam o texto do botão destrutivo de branco. No escuro, branco sobre #EB827B dá 2,6:1 e não passa no AA. Ajuste a variante para `text-destructive-foreground` (já previsto aqui) ou use o destrutivo em contorno, como no canvas.
- **Nada de oklch obrigatório:** os geradores do shadcn escrevem valores em oklch; trocar por estes hex não muda nada para os componentes.

### Contraste (WCAG 2.2 AA)

Calculado a partir dos próprios valores. Texto: mínimo de 4,5:1. Borda de campo e anel de foco: mínimo de 3:1.

| Par | Claro | Escuro |
| --- | --- | --- |
| foreground / background | 13,0:1 | 15,6:1 |
| foreground / card | 16,2:1 | 14,1:1 |
| muted-foreground / background | 4,8:1 | 7,2:1 |
| muted-foreground / card | 6,0:1 | 6,5:1 |
| primary-foreground / primary | 16,2:1 | 14,5:1 |
| signature-foreground / signature | 7,5:1 | 7,5:1 |
| secondary-foreground / secondary | 14,2:1 | 11,0:1 |
| celebrate-foreground / celebrate | 11,0:1 | 9,7:1 |
| destructive / card (texto de erro) | 5,9:1 | 6,0:1 |
| success / card | 6,2:1 | 8,2:1 |
| warning / card | 5,0:1 | 8,3:1 |
| input / card (borda de campo) | 4,2:1 | 3,2:1 |
| input / background | 3,3:1 | 3,6:1 |
| ring / card (foco) | 4,7:1 | 7,2:1 |

Limites conhecidos: `--signature` (#8DB0F7) não serve como texto nem como borda sobre branco (2,2:1); ele só aparece como superfície com texto tinta por cima. As faixas `--aging-1` e `--aging-2` têm menos de 3:1 contra o card no claro, por isso o badge de faixa sempre traz o texto do intervalo e o medidor de 5 degraus.

### Named Rules
- **Uma assinatura por tela.** O céu vai num único card ou numa única ação principal por tela.
- **Menta é quitação.** `--celebrate` só aparece em acordo fechado, dívida quitada e status "Quitada".
- **Vermelho não é dívida.** `--destructive` é para erro e ação destrutiva; atraso usa a escala azul `--aging-*`.

## Typography

- **Família única:** Geist, de 300 a 700. Está no Google Fonts (`family=Geist:wght@300..700`) e tem algarismos tabulares (`tnum`), conferidos no arquivo da fonte.
- **Fallback:** `ui-sans-serif, system-ui, sans-serif`.
- **Números:** todo valor, data e contagem usa `font-variant-numeric: tabular-nums` (`tabular-nums` no Tailwind, classe `.num` no canvas).

### Hierarchy

| Papel | Tamanho / altura | Peso | Tracking |
| --- | --- | --- | --- |
| Display | 64 / 68 | 600 | −4% |
| H1 | 40 / 44 | 600 | −3,5% |
| H2 | 30 / 36 | 600 | −3% |
| H3 | 22 / 28 | 600 | −2% |
| H4 | 18 / 24 | 600 | −1% |
| Corpo grande | 18 / 28 | 400 | 0 |
| Corpo | 16 / 24 | 400 | 0 |
| Pequeno | 14 / 20 | 400 e 500 | 0 |
| Legenda | 12 / 16 | 500 | +1% |
| Dinheiro no portal | 52 a 72 | 300 | −4%, centavos a 56% |
| Dinheiro em coluna | 14 / 20 | 500 | alinhado à direita |

### Manuscrita (em teste)
Uma fonte manuscrita pode aparecer **uma vez por tela**, só como bilhete da credora ("Que bom te ver em dia, Ana!"), nunca em valores, botões ou informação. Candidatas: Caveat, Playwrite BR e Reenie Beanie, todas no Google Fonts e com acentos do português. Decisão em aberto.

## Layout

- **Espaço:** base 4 (4, 8, 12, 16, 20, 24, 32, 48, 64).
- **Tamanhos obrigatórios:** toda tela tem versão celular (390 px). Portal: 390 e 1280. Backoffice: 1440, 1024 e 390.
- **Portal em 390:** margem de 20 px, uma decisão por tela, botão principal no pé da tela. Alvos de toque de pelo menos 44 px.
- **Portal em 1280:** o mesmo conteúdo em duas colunas, no máximo 1104 px de largura: leitura à esquerda, decisão à direita (card de 480 px). Barra superior de 76 px com o logo e "para {credora}".
- **Backoffice em 1440:** trilho de navegação de 76 px com botões redondos, cabeçalho com busca, 3 indicadores, filtros em pílula, tabela e ficha lateral fixa de 380 px. Gap de 20 a 24 px.
- **Backoffice em 1024:** trilho de 64 px; a tabela perde a coluna de CPF e ocupa a largura toda; a ficha abre como painel (Sheet) de 380 px sobre a fila, com fundo escurecido.
- **Backoffice em 390:** o trilho vira barra inferior com 4 itens + "Mais" (Fila, Importações, Painel, Política, Mais); a tabela vira lista de cards (nome, valor, faixa, última tratativa); a ficha vira tela cheia, com as ações fixas no rodapé. Indicadores e filtros rolam na horizontal.
- **Painel:** grade bento de 4 colunas, um número grande por card e um card de assinatura.

## Elevation & Depth

Plano por padrão: cards brancos sobre o campo, sem sombra. Só o que flutua sobre a tela tem sombra: popover, toast, ficha do operador e dialog.

- Claro: `0 16px 40px -12px rgba(19,32,58,.28), 0 2px 6px rgba(19,32,58,.08)`
- Escuro: `0 16px 40px -12px rgba(0,0,0,.6), 0 2px 6px rgba(0,0,0,.3)`
- No escuro, a profundidade vem das superfícies: fundo #0F1A2C, card #17233A, popover #1E2C46.
- Separador: 1 px `--border`. Campo e botão secundário: 1,5 px `--input`. Foco: anel de 3 px `--ring` com 3 px de afastamento.
- Sem vidro, sem backdrop-filter, sem gradiente decorativo.

## Shapes

Arredondado com hierarquia: quem contém tem raio maior que quem está dentro.

| Nível | Raio | Uso |
| --- | --- | --- |
| Pílula | 9999px | botões, filtros, badges, busca |
| Contêiner | 36px | painel, card do bento, trilho |
| Card | 24px | card de dívida, indicador, tabela, ficha, toast |
| Campo | 14px | input, célula do código, select |
| Interno | 10px | swatch, miniatura, item interno |

**Raios no shadcn e no Spartan:** o shadcn deriva `--radius-sm`, `-md`, `-lg` e `-xl` de um `--radius` só. Isso não reproduz esta hierarquia, então declare os níveis explicitamente no `@theme inline`: `--radius-sm: 10px; --radius-md: 14px; --radius-lg: 24px; --radius-xl: 24px; --radius-2xl: 36px`. Depois, confira no código gerado pelo CLI qual classe cada componente usa (o Input costuma usar `rounded-md` e o Card `rounded-xl`) e troque Button e Badge para `rounded-full`.

Ícones: Lucide, traço 1,8, pontas redondas; 20 px em botões e tabelas, 24 px soltos.

## Components

### O que já existe e o que vamos criar

| Componente | shadcn/ui | Spartan UI | O que muda |
| --- | --- | --- | --- |
| Botão (primário, secundário, fantasma, destrutivo, ícone) | Button | Button | pílula; variante nova `signature`; destrutivo em contorno |
| Campo de texto | Input + Label | Input + Label / Field | raio 14, altura 52, borda 1,5 px |
| Código de 6 dígitos | Input OTP | Input OTP | células 48 × 58, mensagens de tentativa e bloqueio (RN1.3) |
| Controle de parcelas | Slider | Slider | régua 1x–10x, valor em destaque, aria-valuetext em reais |
| Badge de status | Badge | Badge | 5 variantes de status |
| Card | Card | Card | raio 24, sem sombra |
| Tabela da fila | Table / Data Table | Table / Data Table | linha de 56 px, valor tabular à direita |
| Filtros em pílula | Toggle Group | Toggle Group | visual de pílula com contagem |
| Toast | Sonner | Sonner (Toast) | marca menta no sucesso |
| Ficha do operador | Sheet | Sheet | ou painel fixo na tela larga |
| Confirmação destrutiva | Dialog / Alert Dialog | Dialog / Alert Dialog | — |
| Esqueleto | Skeleton | Skeleton | brilho desligado em reduced-motion |
| Lembrete liga/desliga | Switch | Switch | — |
| Gráfico de barras | Chart (Recharts) | Chart | hachura custom (ver Implementação) |
| **Campo de dinheiro** | — | — | **criar:** máscara pt-BR, inputmode decimal, valor em centavos inteiros |
| **Campo de CPF** | — | — | **criar:** máscara, dígito verificador, versão mascarada |
| **Badge de faixa de atraso** | — | — | **criar:** variantes ag-1 a ag-5 com medidor de 5 degraus |
| **Card de dívida** | — | — | **criar:** composição de Card com valor atualizado e composição do valor |
| **Card de indicador** | — | — | **criar:** composição de Card, versão de assinatura |
| **Celebração do acordo fechado** | — | — | **criar:** disco menta, visto desenhado, versão reduced-motion |
| **Aviso "acordando o servidor"** | — | — | **criar:** espera crescente para a API que dorme (ADR 0007) |
| **Barra inferior do backoffice (390)** | — | — | **criar:** 4 itens + "Mais"; o "Mais" abre um Sheet (ou Drawer) com os outros itens |
| **Card da fila (390)** | — | — | **criar:** composição de Card que substitui a linha da tabela no celular |
| Ficha em 1024 e 390 | Sheet / rota própria | Sheet / rota própria | Sheet de 380 px em 1024; tela cheia em 390 |

### Buttons
- **Primário (tinta):** a ação padrão ("Ver como pagar", "Enviar proposta").
- **Assinatura (céu):** a ação única da tela. No simulador (P06) é "Revisar acordo", em todos os tamanhos; "Fechar acordo" aparece só na revisão (P07).
- **Secundário (contorno), fantasma, destrutivo (contorno vermelho-tijolo que enche no hover), ícone redondo de 48 px.**
- Estados: hover (mistura de 14% com o céu), foco (anel de 3 px), desabilitado (opacidade de 42%), carregando (spinner + verbo no gerúndio: "Fechando").
- O botão diz o que acontece, e o retorno usa a mesma palavra: "Fechar acordo" → "Acordo fechado".

### Chips
Filtros em pílula de 40 px; o ativo fica em `--primary` com a contagem em 65% de opacidade.

### Cards / Containers
Card de 24 px sem sombra sobre o campo; painel de 36 px; bloco interno em `--muted` com raio 24. Card de indicador: rótulo pequeno em cima, número grande em 300, uma linha de contexto embaixo. **Sem metas:** o produto não tem meta cadastrada; a linha de contexto compara com o período anterior ("+2,1 pontos sobre setembro") ou explica o número ("10 entradas pagas · ticket médio de R$ 894,00"). Textos: `ux-writing.md`, B03 e B14.

### Inputs / Fields
Label em cima (14 / 500), campo de 52 px, dica embaixo (13 px). Erro: borda e dica em `--destructive`, com a mensagem dizendo o que fazer ("A entrada mínima para 5x é R$ 135,15. Aumente o valor."). Desabilitado: fundo `--muted`. Textos dos estados: `ux-writing.md`.

**CPF:** o erro do campo é só de formato: "Confira os números do CPF." O portal nunca diz se um CPF tem ou não dívida (proteção contra enumeração, `docs/lld/api.md`, seção 5.7); depois de "Enviar código", a tela segue para o código sempre.

### Navigation
Backoffice em 1440 e 1024: trilho vertical com botões redondos; o item ativo fica em `--primary`. Backoffice em 390: barra inferior com 4 itens + "Mais", ícone sobre rótulo, alvo de 48 px, item ativo em `--secondary`. Portal: botão redondo de voltar ou fechar no topo, sem barra de navegação.

### Acordo fechado (componente de assinatura)
Disco menta de 112 px, de 0 a 700 ms crescendo de 55% e saindo de um desfoque de 8 px; visto desenhado de 280 a 780 ms; título subindo 10 px aos 450 ms. Curva `cubic-bezier(.16,1,.3,1)`. Com `prefers-reduced-motion`, aparece num fade de 200 ms, já com o visto desenhado.

### Linguagem do portal
Conferido nas telas do portal e no card de dívida do canvas: nenhum texto usa "inadimplente", "devedor", "débito" ou "cobrança". O devedor vê "Suas dívidas", "Em aberto", "Valor atualizado", "Em acordo", "Quitada". "Devedor" aparece só no backoffice, como manda o `GLOSSARY.md`.

## Do's and Don'ts

### Do:
- Use uma cor de assinatura por tela.
- Mostre o valor atualizado e a composição dele (original, multa, juros) antes de qualquer ação.
- Use algarismos tabulares em todo número.
- Escreva o intervalo da faixa de atraso, não só a cor.
- Componha o escuro com superfícies próprias.

### Don't:
- Não use vermelho para dívida ou atraso.
- Não use menta fora de quitação e acordo fechado.
- Não ponha sombra em card que está no fluxo da página.
- Não use vidro, blur decorativo ou gradiente.
- Não use rótulo em caixa-alta espaçada acima de título.
- Não use manuscrita em valor, botão ou informação.

## Implementação

### O que pode dar trabalho
- **Blur e vidro:** nenhum vidro ou backdrop-filter no sistema. O único blur é o `filter: blur(8px)` de entrada do disco da celebração, por 700 ms, num elemento de 112 px; dá para tirar sem perder a ideia.
- **Animação:** tudo é CSS (keyframes e transitions), sem biblioteca. Se quiser, o Motion (Framer) ou o Angular Animations reproduzem a mesma coreografia, mas não são necessários.
- **Gráfico hachurado:** é custom. No Recharts, use `<defs><pattern>` com linhas a 45° e `fill="url(#hachura)"` nas barras que não estão em destaque; a barra destacada fica sólida em `--chart-1`. Raio nas barras: prop `radius`.
- **Raios por nível:** exige sobrescrever `--radius-sm/md/lg/xl/2xl` e conferir as classes de cada componente gerado (ver Shapes).
- **Destrutivo no escuro:** ajustar o texto do botão (ver Colors).
- **Web component do Analytics:** as custom properties atravessam o shadow DOM, mas as classes do Tailwind não; o remote React precisa injetar o próprio CSS dentro do shadow root.
- **Fonte manuscrita:** se entrar, é mais uma família para carregar; use só no portal, com `display=swap` e subset latin.
