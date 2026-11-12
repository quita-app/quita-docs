# Correções das telas

Preenchido depois da revisão das telas geradas em modo lote. Uma seção por tela; cada item vira `- [x]` quando aplicado. Regra nova de texto também vai para o `ux-writing.md`.

Correções que valem para várias telas ficam em "Globais" e são aplicadas primeiro. **Ordem desta rodada:** Globais → P00 (landing) → telas → organização do canvas (por último).

## Globais

- [x] Rótulo acima do valor grande de parcela: troque "{n} parcelas · cada uma" por "Entrada + {n-1} parcelas de" (a entrada de R$ 135,15 é diferente das parcelas de R$ 191,46, então "cada uma" mente). Vale em toda tela que mostrar esse bloco. `ux-writing.md` P06 já atualizado.
- [x] Bilhete manuscrito da credora: fora do MVP, nada de fonte manuscrita (`ux-writing.md` P08 atualizado). Só confirmar que nenhuma tela o usa. Conferido: nenhuma tela usa fonte manuscrita, e a Caveat saiu do carregamento de fontes das pranchas.
- [x] **Quebras de linha indesejadas.** Regra para todas as telas:
  - **Nunca quebram** (`white-space: nowrap`): valor em dinheiro, data, hora, CPF/CNPJ/telefone mascarado, nome de pessoa em cabeçalho, selo/pílula, texto de botão, cabeçalho de coluna.
  - Se não couber: encurte o rótulo, dê largura mínima à coluna, ou leve o valor para a linha de baixo **inteiro** (rótulo em cima, valor embaixo). Nunca partir "R$ / 1.348,87" ou "vence em / 12/11".
  - Reticências só em texto livre longo (ex.: última tratativa, nome de arquivo), com o texto completo no `title`/tooltip. Nunca em cabeçalho de coluna nem em selo.
  - No 390, tabela com mais de 3 colunas vira lista de cards (já é a regra da moldura).
  - Casos vistos nos prints (corrigir todos e procurar outros iguais):
    - P03: "e (11) / 9****-4321" quebrando o telefone.
    - P04: "somando R$ / 1.348,87" no 390.
    - P05/P06/B06: "Entrada, por Pix · vence em / 12/11" (no 390, o "vence em 12/11" vai inteiro para a linha de baixo, em texto de apoio).
    - B03: "ligação há 2 di…" e "promessa que…" cortados; "ticket médio de R$ / 802,05" no 1024.
    - B06 1024: nome "Ana / Souza" quebrado e o selo de reserva em duas linhas.
    - B09: cabeçalhos "Publicada e…", "Arquivada …" cortados, "Carla / Mendes" quebrado; no 390 a pílula "Mais de 360" encosta no "70%" (vira cards).
    - B10: cabeçalhos "Desconto máxi…", "Parcelas máxim…" cortados (use rótulos curtos: "Desconto", "Parcelas", "Entrada mín.").
    - B11: texto do campo "Associar à parcela" cortado ("· R$").
    - B12 1440: selo "Convite penden…" cortado.
    - B13: cabeçalho "Devedores at…" cortado.
    - B14 390: "Taxa de / recuperação".

## P00 · Landing page do Quita

A versão atual está correta nos textos, mas **crua**: parece um documento, não um produto que vende. Refazer com ambição de site premiado (nível awwwards), sem quebrar o design system nem as regras de honestidade.

- [x] **Hero que para a rolagem.**
  - Título enorme (display do Geist, 72–96 px no desktop, peso alto, entrelinha justa), com uma palavra ou trecho destacado na cor de assinatura ou em marca-texto céu. Direção: "Sua credora recebe. Seu cliente resolve pelo celular, sem constrangimento." (pode quebrar em 2–3 linhas fortes).
  - Ao lado, um **celular grande e vivo** com o fluxo da Ana tocando sozinho em loop curto: o controle desliza de 1x a 5x, os números recalculam, "Revisar acordo" → celebração menta "Acordo fechado". É o produto vendendo a si mesmo.
  - Fundo com profundidade: gradiente céu suave, um "q" gigante do logo recortado saindo do quadro, ou forma orgânica desfocada. Nada de foto de banco de imagem.
  - CTA **Ver a demo** (única aparição da cor de assinatura em botão) e "Como funciona" secundário. Abaixo, uma linha de credibilidade honesta: "Projeto de portfólio · código aberto no GitHub".
- [x] **Faixa do número.** Uma seção de impacto com a conta da Ana em tipografia gigante: "R$ 1.060,00 → R$ 901,00 em 5x · 15% de desconto · resolvido em 3 min 40 s". Os números contam ao entrar na tela.
- [x] **O problema** com contraste: fundo tinta (escuro) e texto claro, os três problemas como cartões grandes, cada um com um ícone desenhado ou uma micro-ilustração em linha (planilha bagunçada, desconto variando, acordo quebrando).
- [x] **Como funciona como narrativa de rolagem:** celular (ou janela do backoffice) fixo de um lado, que troca de tela conforme os 3 passos rolam do outro (importação → portal da Ana → fila/painel). Numeração grande (01, 02, 03).
- [x] **Grade em bento** para "Para quem atende e para quem decide": recortes reais da fila (B03), da ficha (B05), do painel (B14) e da política (B10), em cartões de tamanhos diferentes, com legenda curta. Cartões com leve inclinação/perspectiva ou sombra profunda.
- [x] **Princípios** em tipografia grande, um por linha, com a palavra-chave em destaque ("Sem constranger.", "A política é da credora.", "Resolve em minutos.").
- [x] **Demo** como fechamento forte: três cartões grandes por perfil (devedora, operador, gestora), cada um com uma miniatura da tela inicial daquele perfil e o aviso de dados fictícios. Fundo na cor de assinatura ou céu cheio.
- [x] **Rodapé** caprichado: logo grande, "Projeto de portfólio", GitHub `quita-app`, contato, stack em selos discretos (Angular, React, Next.js, Spring Boot).
- [x] **Movimento** (atualiza a regra do prompt: agora pode mais de um momento, todos em CSS/scroll-driven animations ou IntersectionObserver, sem biblioteca pesada):
  - Hero: fluxo da Ana em loop; entrada do título em revelação por linha.
  - Seções: entrada suave (fade + 12–16 px) ao rolar; números contando; celular fixo trocando de tela.
  - Hover com profundidade nos cartões do bento.
  - `prefers-reduced-motion`: tudo parado, no quadro final.
- [x] **Regras que continuam:** sem logos de clientes, depoimentos ou números de resultado inventados (os números são do exemplo da Ana, rotulados como exemplo); LCP < 2,5 s em 4G (hero sem imagem pesada: o celular é HTML/CSS); implementável em Next.js + Tailwind.
- [x] **Tamanhos:** 1440, **1280** e 390 (o portal é 390 e 1280; o 1280 precisa da prancha própria). No 390, o hero vira título + celular abaixo, e a narrativa de rolagem vira sequência simples.
- [x] GitHub `github.com/quita-app` está certo. Contato: troque `contato@quita.app` por "Fale comigo no LinkedIn" (sem e-mail inventado).

## P03 · Acesso: código
Decisões aceitas. Print conferido. Só a quebra do telefone (Globais).

## P04 · Suas dívidas
Decisões aceitas (ação em tinta e não na cor de assinatura: boa).

- [x] Card do acordo "Rematrícula": "próxima em 14/12" → "próxima em 12/12" (parcelas sempre no dia 12). Vale nos estados 1 e 3, em 390 e 1280.

## P05 · Detalhe da dívida
Decisões aceitas (P05 + P06 em duas colunas no desktop: boa). Só quebras (Globais).

## P06 · Simulador

- [x] Estado 5 (parcela abaixo do mínimo) está fora da regra: em 6x a parcela do Material didático dá R$ 42,97, abaixo do mínimo de **R$ 50,00** (RN3.1, `min_installment_amount`). O máximo é **5x**. Refaça o estado:
  - Aviso: "Para esta dívida, o máximo é 5 parcelas."
  - Controle em 5x, com 6x a 10x riscados e apagados.
  - 15% de desconto · total R$ 245,54 · entrada, por Pix, R$ 36,83 · mais 4 parcelas: R$ 52,17 (a última fica com R$ 52,20, por causa dos centavos) · você deixa de pagar R$ 43,33.
  - Valor grande: R$ 52,17, com o rótulo "Entrada + 4 parcelas de".
- [x] Aplicar o rótulo global "Entrada + {n-1} parcelas de" nos estados 2 a 4 e no 1280.

## P07 · Revisar e fechar acordo
Decisões aceitas. Sem correções.

## P08 · Pix e acordo fechado
Decisões aceitas (sem bilhete, ver Globais). Sem correções.

## P09 · Acompanhar o acordo
Decisões aceitas. Sem correções (datas conferidas no print: todas pagas até o vencimento).

## P10 · Estados globais do portal
Decisões aceitas. Sem correções.

## B01 · Login e convite
Decisões aceitas. Print conferido. Sem correções.

## B02 · Moldura do backoffice

- [x] Falta o menu do **Auditor** (RF1.2, RN1.2: só leitura). Feito: variante do auditor na B02 (1024, só leitura, sem Fila nem Administração) e barra inferior do 390 (Devedores, Política, Painel, Pagamentos, Mais).
- [x] **Admin da plataforma tem menu próprio.** Hoje (B02 estado "entrar como" e B13) a Renata Alves vê Fila, Devedores, Importações, Política… de uma credora, o que não faz sentido em "Quita · plataforma". Menu do admin: só **Credoras** (no MVP). Ao "entrar como" (Fase 2), aí sim vê o menu da credora, com a faixa no topo. Ajustar a variante na B02 e as pranchas da B13 (1440, 1024 e a barra inferior do 390).

## B03 · Fila de trabalho

- [x] Remover o campo "Buscar nome ou CPF" do cabeçalho da página: duplica a busca global da barra superior. Fica só **Próximo da fila**.
- [x] Coluna "Última tratativa": texto curto e inteiro ("Ligação · há 2 dias", "Promessa quebrada", "Nunca contatado"), sem reticências; o detalhe fica na pré-visualização. "Promessa vence hoje" em uma linha.

## B04 · Busca de Devedores

- [x] Selo "Em negociação" da Ana aparece como texto solto, sem o contorno dos outros selos. Usar o mesmo componente de selo de situação em todas as linhas.

## B05 · Ficha do Devedor
Decisões aceitas. Telefone completo para o operador: ok (finalidade do atendimento; o acesso fica na auditoria). Expiração da reserva fica fora.

- [x] 390: o selo "Ativo" do acordo Rematrícula está esticado na largura toda do card. Selo tem largura do conteúdo, ao lado do título.

## B06 · Negociar pela ficha
Decisões aceitas. Pílula "parcela mínima" entrou no `ux-writing.md`.

- [x] 390: **Enviar proposta** está cortado no fim da tela. Rodapé fixo com o botão (e "Copiar resumo" acima ou no menu), como na B05 do celular.
- [x] 1024: quebras do nome e do selo de reserva atrás do painel (Globais).

## B07 · Importações

- [x] Histórico de setembro não fecha: 1.190 linhas, 1.190 válidas, 0 com erro e **4 ignoradas** (1.190 + 4 ≠ 1.190). A B08 mostra setembro "concluída sem erros" com 0 ignoradas. Corrigir para **0 ignoradas** em todas as pranchas (1440, estados, 1024, 390).

## B08 · Importação em andamento
Decisões aceitas (1.236 + 11 + 1 ignorada = 1.248, histórico da B07 igual). Print conferido. Sem correções.

## B09 · Versões da Política
Decisões aceitas. Só quebras (Globais): tabela de arquivadas e 390 em cards.

## B10 · Editor da Política
Decisões aceitas (sem 390: ok, no celular a B09 é só leitura). Só cabeçalhos cortados (Globais).

## B11 · Pagamentos não conciliados
Decisões aceitas. Associar valor menor deixa a diferença em aberto na parcela: é a regra (RN6.3). Só o campo cortado (Globais).

## B12 · Usuários e convites

- [x] **Importações não aparece para o operador.** Conferido.
- Auditor: só leitura, menu definido na B02.
- Convite vale 7 dias: confirmado (`INVITATION_TTL` no `api.md`).
- [x] **Coerência com o Painel (B14):** o ranking da B14 tem **Lucas Araújo** como operador com 89 acordos, mas na B12 ele é quem acabou de receber convite. Ponha Lucas Araújo como **Operador ativo** na lista (último acesso "hoje, 08:15") e use outra pessoa no exemplo de convite enviado (ex.: "Marina Costa", `marina.costa@escolahorizonte.com.br`).

## B13 · Credoras

- [x] Faltam **1024 e 390**. Feito.
- [x] Menu do admin da plataforma: ver B02 (só Credoras).

## B14 · Painel
Decisões aceitas. "Autoatendimento" no ranking: sim, fica. Números conferidos (semanas somam R$ 184.320,00; ranking soma o mesmo; quebra 37 ÷ 449 = 8,2%; funil 398 ÷ 1.284 = 31%). Só a quebra do 390 (Globais) e o Lucas Araújo (B12).

## Canvas · organização final (fazer por último)

- [x] Organizar o canvas inteiro em duas grandes áreas, lado a lado, com título de seção grande:
  - **Fundação** (à esquerda ou no topo): design system (F0), conceitos, notas e decisões.
  - **Portal** (Ana): P00 → P01 → … → P10, em fila na ordem do fluxo.
  - **Backoffice**: agrupado por app e fluxo:
    - Shell: B01 (login e convite), B02 (moldura e estados globais).
    - Operação: B03 fila → B04 busca → B05 ficha → B06 negociar.
    - Carteira: B07 → B08 importação.
    - Política: B09 → B10.
    - Pagamentos: B11.
    - Administração: B12 usuários, B13 credoras.
    - Analytics: B14 painel.
- [x] Cada tela com o mesmo cabeçalho (id, nome, rota, status), as pranchas alinhadas na mesma grade, espaçamento igual entre telas e entre grupos, e os tamanhos sempre na mesma ordem (desktop maior → 1024 → 390).
- [x] Sem sobras: remova versões antigas, rascunhos e pranchas duplicadas que ficaram de rodadas anteriores (os PNGs aprovados continuam em `design/hi-fi/`).
- [x] Reexporte os PNGs das telas alteradas nesta rodada (só claro) por cima dos antigos.
- [x] Quando todas as caixas deste arquivo estiverem marcadas: mude o status de todas as telas para "aprovada" no README, apague os `design/review/<id>-questions.md` e escreva `design/review/report.md` com um resumo do que foi corrigido por tela (uma linha cada) e o que ficou para depois. O D1 (dark mode) continua "a gerar".

## Rodada final · polimento da P00

- [x] Hero: a tela do celular tem a metade de baixo vazia no quadro final. Preencha com o resto da tela real de acordo fechado (**Ver meu acordo** e "Baixar comprovante") ou com o indicador do loop (3 pontinhos: simular → revisar → fechado), para o quadro parado não parecer inacabado.
- [x] Subtítulo do hero: "deixa o devedor fechar o acordo" → "deixa o cliente fechar o acordo" ("devedor" está na lista de palavras proibidas do portal). Procure "devedor/devedora" no resto da landing e troque por "cliente" (na demo: "Entrar como cliente (Ana)").
- [x] Reexporte o PNG da P00 e acrescente uma linha no `report.md`.

## Rodada de auditoria · revisão (2026-11-12)

Conferidas: B05 (botão só da gestora, diálogo com a Proposta aberta e "não conta como recuperado", recusa com Acordo vivo), B08 (contadores), P03 (texto neutro), P07 (proposta recebida, vencida e Política mudou). Contato da Escola Horizonte e a escolha do Material didático na B05: ok.

- [x] **B08 · aviso de conclusão:** "12 linhas com erro não entraram" contradiz os contadores (11 com erro + 1 ignorada). Texto: "Importação concluída com 11 erros e 1 linha ignorada. As linhas com erro não entraram." (e o mesmo no 390).
- [x] **B08 · resumo por tipo:** a tabela tem a linha 530 ("O valor precisa ser maior que zero"), mas o resumo não tem esse tipo. E a linha 702 tem dois erros, então ela conta nos dois tipos. Regra: **"Todos" conta linhas; cada tipo conta as linhas que têm aquele erro** (a soma dos tipos pode passar de "Todos"). Exemplo coerente: Todos · 12 · 7 CPF inválido · 3 Vencimento em formato errado · 1 Valor precisa ser maior que zero · 1 Sem e-mail e sem celular · 1 Dívida com acordo ativo, ignorada.
- [x] **P03 · faixa "Na história" da prancha:** ainda mostra "Para onde o código foi enviado e quanto tempo ele vale". O prompt mudou para: "Que o código vale por pouco tempo e o que fazer se ele não chegar, sem revelar para onde foi enviado (a resposta é igual exista ou não o CPF)."
- [x] **P07 · rota no cabeçalho da prancha:** acrescentar a rota da proposta recebida: `/c/[slug]/proposals/[id]` (estado 5).
- [x] Reexporte os PNGs da B08, da P03 e da P07 (claro e escuro) e acrescente uma linha no `report.md`.
