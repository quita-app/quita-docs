# Linha de base do MVP

2026-11-12 · Status: **pronta para programar** · Fonte: `docs/review/consistency-audit.md` (aplicada) e a revisão conservadora de 2026-11-12

A porta de entrada para começar a programar. Este documento **compila**: cada regra continua morando no documento dono (coluna "Onde"), e em caso de divergência vale o dono. A ordem de leitura e quem é dono de quê estão na seção 7.

---

## 1. Escopo do MVP

### Dentro (F01 a F14, prazo até 2027-01-05)

| # | Funcionalidade | O que entrega, em uma linha |
| --- | --- | --- |
| F01 | Walking skeleton | Todos os apps publicados e conversando; schemas do banco criados; CI e deploy |
| F02 | Acesso ao backoffice | Login, refresh com rotação, recuperar senha, moldura com o menu do papel |
| F03 | Credoras e usuários | Admin cadastra a Credora com marca e contato do portal; Gestor convida gestor ou operador |
| F04 | Importação de Carteira | Modelo CSV em português, validação no navegador, processamento em lotes ao vivo, relatório corrigível |
| F05 | Busca de Devedores | Busca por nome, CPF, contrato ou telefone; cadastro manual de Dívida ("Nova dívida") |
| F06 | Política de negociação | Rascunho com 1 a 5 Faixas, simulador ao lado, publicação, lista de versões |
| F07 | Acesso do Devedor | Página da Credora com marca, CPF e código, uma Credora por sessão, caixa de saída da demo |
| F08 | Dívidas e simulador | Dívidas com Valor atualizado e composição, Acordos da Ana, simulador calculado no servidor |
| F09 | Fechar Acordo | Revisar e fechar no portal, idempotente, um Acordo vivo por Dívida |
| F10 | Pix e confirmação | Pix simulado com validade limitada, webhook com HMAC, Acordo ativo |
| F11 | Fila e ficha | Fila pelo teclado, ficha com reserva, Tratativas e Promessas, pagamento ao vivo |
| F12 | Proposta do Operador e pagamento fora do Quita | Operador envia Proposta, Ana aceita pelo link no portal; Gestor registra Dívida paga fora |
| F13 | Quebra e não conciliados | Quebra que nunca é desfeita, Entrada e Proposta vencidas, B11 para o Gestor |
| F14 | Painel | Indicadores, recuperação por semana, aging por Faixa, números do Operador (B14 e B03) |

### Fora

| Onde fica | O quê |
| --- | --- |
| Fase 2 (F15 a F19) | Versões com data de início e Exceções (F15); Régua, link mágico e notificações com histórico (F16); auditoria, "entrar como", CPF completo com permissão, anonimização (F17); editor de marca do Gestor (F18); Contestação com anexo (F19) |
| Fase 3 (F20 a F22) | Chat (F20); funil, ranking, conversão, safra, "Tempo até o acordo", "Promessas cumpridas", PDF do painel (F21); 1 milhão de Dívidas, RLS, tracing (F22) |
| Ideias futuras (sem funcionalidade) | Papel só de leitura; "Meu Quita" (várias Credoras numa visão); acordo de várias Dívidas; boleto; mapeamento de colunas na importação; integração por API ou ERP; crédito ou estorno de pagamento depois da Quebra |
| Cortado nesta revisão | "Avisar quando liberar" a ficha reservada (job a cada minuto, evento `DebtorLockReleased`, botão). A ficha mostra quem está atendendo e até quando |

---

## 2. Regras de negócio do MVP

Requisitos = `docs/foundation/business-requirements.md`; API = `docs/lld/api.md`; Banco = `docs/lld/database.md`.

### Identidade e acesso

| Id | Regra | Por quê | Onde | Feat. |
| --- | --- | --- | --- | --- |
| RN1.1 | Dado de uma Credora nunca aparece para outra; o filtro de tenant é da persistência | É a promessa número 1 do produto (LGPD e confiança) | Requisitos M1; Banco 4; API 8 | F01–F14 |
| RN1.2 | Papéis da Credora: gestor e operador (mais o admin da plataforma). O operador não altera Política, não importa e não registra pagamento fora do Quita | Menos papéis, menos casos de permissão; o papel só de leitura não tinha uso no lançamento | Requisitos M1; API 7 (rotas) | F02, F03 |
| RN1.3 | Código do Devedor: 6 dígitos, 10 min, 5 tentativas, depois 15 min de bloqueio | Equilíbrio entre segurança e atrito no celular | API 5.7 e 6 | F07 |
| A1 | Pedir código responde sempre igual e a P03 nunca mostra o contato | Não revelar quem deve (enumeração) | API 5.7; ux P03 | F07 |
| RN1.4 | Sessão do Devedor expira com 15 min sem uso | Celular compartilhado, dado financeiro | API 6; Portal 5 | F07 |
| Portal 5 | O token do Devedor é renovado no `proxy` (e em Server Actions e route handlers), nunca num Server Component | Server Component não grava cookie | Portal 5 | F07 |
| RN1.5 | Um e-mail é de uma Credora só (único em toda a plataforma); login só com e-mail e senha; convite com e-mail já usado → `EMAIL_ALREADY_IN_USE` | Login sem escolher a Credora; duas Credoras por pessoa fica para depois | Requisitos M1; API 5.13; Banco 4 | F02, F03 |
| RN4.6 | Uma Credora por sessão; cookie com o caminho `/c/<slug>` | LGPD (cada Credora é dona dos dados), marca e isolamento | Requisitos M4; API 5.7; Portal 5 | F07 |
| RF1.3 | Recuperar senha: resposta sempre igual, token de 1 h e uso único; trocar a senha revoga as sessões | Não revelar e-mails; link roubado vale pouco | API 5.13 | F02 |
| RF1.1 | O admin cadastra nome de exibição, logo (PNG ou WebP, até 256 KB, sem SVG), cor (com contraste AA) e contato | O portal precisa da marca já no MVP; SVG pode carregar script | API 5.11; Requisitos M11 | F03 |
| RN4.8 | Termos e privacidade são sempre os do Quita | A Credora média não tem termos próprios | Requisitos M4; Portal 7 | F07 |

### Carteira e Importação

| Id | Regra | Por quê | Onde | Feat. |
| --- | --- | --- | --- | --- |
| Glossário | Carteira = todas as Dívidas da Credora; o arquivo é a Importação | Um nome estável; o filtro "Carteira" mudava sozinho | `GLOSSARY.md` | F04 |
| RN2.1 | CPF/CNPJ pelo dígito; linha inválida não derruba o lote | Um erro não pode travar mil linhas | API 5.9 | F04 |
| RN2.2 | Mesma Credora + documento + contrato atualiza a Dívida | Reenviar o arquivo não duplica nada | API 5.9 | F04, F05 |
| RN2.3 | Dívida com Acordo vivo, quitada ou cancelada não é sobrescrita (linha ignorada) | A importação não desfaz o que foi negociado ou pago | API 5.9 | F04 |
| RN2.4 | Uma importação processando por vez, por Credora | Evita corrida entre dois arquivos | Banco 5.2 | F04 |
| RN2.5 | Todo Devedor tem e-mail ou celular | Sem contato, ele nunca recebe o código | API 5.9 | F04, F05 |
| RN2.6 | Devedor reimportado: célula vazia não apaga dado | O arquivo do mês nem sempre traz tudo | API 5.9 | F04 |
| RN2.7 | A importação não cancela nada | Sumir do arquivo não prova pagamento | API 5.9 | F04 |
| RN2.8 | `debt.portfolio_import_id` é a importação que criou a Dívida e nunca muda | A origem tem que ser estável; a safra (F21) sai de `created_at` | API 5.9; Banco 5.2 | F04 |
| 2.1 | Modelo com cabeçalho em português, tolerante; aceita UTF-8 e o CSV do Excel (Windows-1252) | O arquivo é do Gestor, não do código | API 5.9 | F04 |
| 2.3 | Mais de 90% de erro no primeiro lote para a importação (`early_fail_rate`) | Arquivo errado de verdade não gera milhares de erros iguais | API 5.9 e 6 | F04 |
| RF2.4 | O relatório de erros é o arquivo original com a coluna "Erro", para corrigir e reenviar | Fecha o ciclo de correção sem retrabalho | API 5.9 | F04 |
| RF2.6 | "Nova dívida" usa a mesma validação e a mesma duplicidade da importação | Um só código de validação | API 5.9 | F05 |

### Política

| Id | Regra | Por quê | Onde | Feat. |
| --- | --- | --- | --- | --- |
| RF3.1 | De 1 a 5 Faixas, começando pelas 5 padrão; sem sobreposição nem buraco; só a última sem teto | Liberdade para a Credora, com limite do mercado | API 5.10 | F06 |
| RF3.2 | Política publicada é imutável; a Proposta aponta a versão que a regeu | Acordo feito não muda quando a regra muda | Banco 5.3 | F06 |
| RF3.3 | O simulador do editor usa as regras não salvas (`POST /policies/simulations`) e não grava nada | Reagir à edição sem bater na checagem de `version` | API 5.3; Backoffice 9 | F06 |
| RN3.2 | Valor atualizado = principal − pago + multa 2% + juros 1% a.m. pró-rata + correção da estratégia | Limites do CDC; nunca gravado, sempre calculado | API 5.2 | F05, F08 |
| RN3.5 | Desconto = máximo × (máx. − n + 1) ÷ máx. | Menos parcelas, mais desconto | API 5.3 | F06, F08 |
| RN3.1 | Parcela mínima R$ 50,00; o `n` máximo é recalculado | Parcela pequena custa mais do que rende | API 5.3 | F08 |
| RN3.3 | Dinheiro em decimal exato; o centavo de resíduo vai para a última | Nenhum centavo some | API 5.1 e 5.3 | F08 |
| RN4.7 | Sem Política publicada, nada de simulação nem Acordo (`NO_PUBLISHED_POLICY`) | Não inventar condição | API 5.3 | F08 |

### Negociação e Acordo

| Id | Regra | Por quê | Onde | Feat. |
| --- | --- | --- | --- | --- |
| RN5.0 | Um Acordo é de uma Dívida só | Modelo simples; juntar Dívidas é Fase 2 | API 5.4 | F09 |
| RN4.2 | A Proposta vale 48 h (★ por Credora) | Tempo para a Ana decidir sem a condição envelhecer | API 6 | F09, F12 |
| RF7.4 | O Operador nunca cria Acordo: envia uma Proposta, e a Ana aceita no portal com "Li e concordo" | Sem o aceite dela, é um compromisso que ela não assinou | API 5.4 | F12 |
| RN4.9 | Uma Proposta aberta por Dívida; a nova encerra a anterior (`canceled`) | A Ana nunca vê duas condições do Quita ao mesmo tempo | API 5.4; Banco 5.3 | F12 |
| RN4.10 | Com Proposta aberta, a Ana pode fechar outra condição sozinha: o primeiro Acordo vale | O autoatendimento não fica refém do Operador | API 5.4 | F12 |
| Portal 6 | A escolha do simulador viaja pela URL até a P07; a API recalcula na revisão e ao criar (`{ debtId, installments, downPayment }`) | Nada a perder ao recarregar; dinheiro nunca calculado no navegador | Portal 3, 6; API 5.4 | F09 |
| 5.4 | `POST /proposals` exige a reserva do Devedor (409 `DEBTOR_LOCKED`) | Dois atendentes nunca negociam o mesmo Devedor (RN7.2) | API 5.4 | F12 |
| RN4.3 | Um Acordo vivo por Dívida (índice único parcial; 409 `AGREEMENT_ALREADY_EXISTS`) | Duas confirmações simultâneas, um só Acordo | Banco 5.3; API 5.4 | F09 |
| 5.4 | Enviar Proposta, criar Acordo e pagamento fora do Quita pegam a mesma trava por Dívida (`pg_advisory_xact_lock`) | Essas ações nunca se cruzam | API 5.4 | F09, F12 |
| 5.4 | O aceite recalcula na data de referência da Proposta | Os juros que correm em 48 h não invalidam a Proposta; a Política nova invalida | API 5.4 | F09, F12 |
| 5.4 | `Idempotency-Key` em criar Acordo e aceitar Proposta | Duplo clique não cria dois Acordos | API 5.4 e 7 | F09, F12 |
| 5.4 | Entrada vence em 2 dias; Parcela `k` no mesmo dia do mês (ou no último dia) | Datas previsíveis para a Ana | API 5.4 | F09 |
| RN5.1 | Tolerância de 10 dias (★), da versão da Política que regeu a Proposta, pela vida inteira do Acordo (vale também para validade e parcela mínima) | Atraso curto não desfaz um Acordo; Política nova não muda acordo feito | API 5.4 e 6 | F09, F13 |
| RN5.3 | Uma Quebra nunca é desfeita: o Pix vence no fim do prazo e a Quebra roda às 03:00 conferindo pagamentos no prazo | A Ana nunca vê "cancelado" e depois "ativo" | API 5.5 e 5.6 | F10, F13 |
| 9 | Jobs idempotentes e por condição; um workflow do GitHub Actions chama `POST /internal/jobs/run` a cada hora e acorda a API; aceite e Pix conferem o vencimento na leitura | API dormindo não roda o job das 03:00 | ADR 0007; API 9 | F13 |
| RN5.5 | Só quebra sem pagamento no prazo ou com pagamento incompleto | Pagou dentro da tolerância, está pago | API 5.6 | F13 |
| RN5.2 | Na Quebra, o pago abate a Dívida, o desconto se perde e a Dívida volta a `open` e à Fila | O desconto era condicionado ao Acordo inteiro | API 5.6 | F13 |
| RF7.7 / RN7.6 | Pagamento fora do Quita: só o Gestor, com nota; quita a Dívida, encerra a Proposta aberta, tira da Fila; recusado com Acordo vivo; não conta como recuperado | Zera uma Dívida sem dinheiro passar pelo Quita (risco de fraude) | API 5.15 | F12 |

### Pagamento

| Id | Regra | Por quê | Onde | Feat. |
| --- | --- | --- | --- | --- |
| RF4.5 | Só Pix no MVP | Um meio bem feito; boleto depois | Requisitos M4 | F10 |
| N2 | A Cobrança da Entrada nasce com o Acordo; a rota gera Pix novo e o das Parcelas seguintes | Um dono para cada Cobrança | API 5.5 | F10 |
| RN6.4 | Pix vale 24 h ou até o fim do último dia de pagamento, o que vier primeiro; depois, `PAYMENT_WINDOW_CLOSED` | Fecha a brecha do Pix pago depois do prazo | API 5.5 | F10 |
| RN6.1 | Webhook idempotente pelo `gateway_event_id` | O gateway repete e atrasa | API 5.5; Banco 5.4 | F10 |
| RN6.2 | Webhook com HMAC e janela de 5 min | Ninguém forja um pagamento | API 5.5 | F10 |
| 5.5 | Só concilia Cobrança `pending` com valor igual; o resto fica `unreconciled` (B11) | Dinheiro sem dono fica visível, nunca some | API 5.5 | F10, F13 |
| 5.5 | Quebra ou cancelamento cancelam as Cobranças `pending` do Acordo | Nenhum Pix válido para um Acordo encerrado | API 5.5 | F13 |
| RN5.6 | Pagamento depois da Quebra vai para a B11, sem crédito nem estorno | Gateway simulado; o Gestor resolve à mão | API 5.5 | F13 |
| P1 | Pagamento sem referência nenhuma vai para o admin da plataforma | Sem tenant, nenhum Gestor o veria | API 5.5 | F13 |

### Atendimento e Fila

| Id | Regra | Por quê | Onde | Feat. |
| --- | --- | --- | --- | --- |
| RN7.1 | Maior atraso primeiro; rodízio ao entrar na Fila | Simples e justo no MVP | API 5.8 | F11 |
| RN7.3 | Promessa vencida põe o Devedor no topo | Promessa quebrada é o melhor momento de ligar | API 5.8 e 9 | F11 |
| RN7.2 | Abrir a ficha reserva o Devedor por 15 min (renovada a cada 5); quem chega depois vê quem e até quando, sem aviso de liberação | Dois Operadores nunca negociam a mesma pessoa | API 5.8; Banco 5.5 | F11 |
| RN7.4 | CPF sempre mascarado para o Operador | LGPD; a permissão chega com a auditoria (F17) | API 5.8 | F11 |
| 5.8 | Acordo ativo e pagamento fora do Quita tiram da Fila; Quebra devolve | A Fila só tem quem precisa de contato | API 5.8 | F11, F12, F13 |

### Painel

| Id | Regra | Por quê | Onde | Feat. |
| --- | --- | --- | --- | --- |
| RN7.5 | O Acordo conta para o Operador que tinha o Devedor na Fila quando ele nasceu; sem Operador, só no total | Mérito de quem trabalhou o caso | API 5.12 | F11, F14 |
| RN9.1 | O Operador vê só os números dele | Painel de equipe, não de vigilância | Requisitos M9 | F14 |
| RN9.2 | Até 5 min de atraso, e a tela diz | Modelos de leitura por evento | Requisitos M9 | F14 |
| RF9.3 | Filtros: período e Operador (só gestor), na URL; sem filtro de Faixa (o aging já mostra por Faixa; F21) | `daily_recovery` não tem Faixa na chave; sem filtro de Carteira (é uma só); safra na F21 | Backoffice 4 | F14 |
| M1 | Notificações da moldura só do SSE, sem histórico | A tabela entra com a Régua (F16) | Backoffice 3 | F02, F04 |

---

## 3. Decisões tomadas

| Data | Decisão | Motivo | Documentos |
| --- | --- | --- | --- |
| 2026-11-11 | Marca da Credora no cadastro do admin (nome, logo no PostgreSQL, cor AA, contato) e rotas públicas da marca | A P01 prometia dados que o banco não tinha | Requisitos M1 e M11; API 5.11; Banco 5.1; Portal 7; B13, P01 |
| 2026-11-11 | Modelo de importação em português, tolerante, UTF-8 ou Windows-1252, com modelo para baixar | O arquivo é do Gestor | Requisitos RF2.2; API 5.9; B07 |
| 2026-11-11 | Cadastro manual de Dívida ("Nova dívida") | Dívida avulsa sem arquivo | Requisitos RF2.6; API 5.9; B04 |
| 2026-11-11 | Ciclo de correção: validação no navegador, resumo por tipo, relatório corrigível, parada cedo | 500 erros sem caminho de correção | API 5.9; Backoffice 6; B07, B08 |
| 2026-11-11 | I1, I3, D1, D3: Devedor atualizado com não vazios; telas em português; e-mail ou celular obrigatório; busca por telefone | Lacunas de contrato | Requisitos M2; API 5.9 e 5.14; Banco 6 |
| 2026-11-11 | A1 a A4, A6: texto neutro na P03; rota pública da Credora; recuperar senha; reenviar convite e mudar papel; link mágico na F16 | Lacunas de contrato | API 5.7, 5.13; B01, B12, P03 |
| 2026-11-11 | N2 a N5, N7: Cobrança da Entrada pelo evento; lista de Acordos do Devedor; comprovante em PDF; estado sem Política; tolerância variável no texto | Lacunas de contrato | API 5.3, 5.5; P04, P06, P07, P09 |
| 2026-11-11 | P1, O1, O3, M1 a M4: pagamento sem tenant ao admin; `operator_performance` no MVP; CPF sempre mascarado; notificações sem histórico; blocos da F21 marcados; contagem do admin fora do tenant; `/demo/inbox` | Lacunas de contrato | API 5.5, 5.12, 5.13; Banco 4, 5.6; B02, B03, B13, B14 |
| 2026-11-12 | D2: uma Dívida por Acordo | Resposta do usuário | Requisitos RN5.0; API 5.4 |
| 2026-11-12 | M5: termos e privacidade sempre do Quita | A Credora média não tem termos | Requisitos RN4.8; Portal 7 |
| 2026-11-12 | N6: de 1 a 5 Faixas editáveis | Resposta do usuário | Requisitos RF3.1; API 5.10; B10 |
| 2026-11-12 | Seção 7: uma Credora por sessão | LGPD, marca, isolamento | Requisitos RN4.6; API 5.7; Portal 5 |
| 2026-11-12 | **I2:** Carteira = todas as Dívidas; o arquivo é a Importação; `portfolio_import_id` nunca muda; filtro "Carteira" fora do painel; safra na F21 | Entrevista | Glossário; Requisitos 4, RN2.8, RF9.3; API 5.9; Banco 5.2; Backoffice 4; B14 |
| 2026-11-12 | **A5:** sem papel auditor; "papel só de leitura" vira ideia futura | Entrevista: sem uso no lançamento | Requisitos RF1.2, RN1.2, 8; Banco 5.1; B02, B12; ux B12; roadmap F03, F17 |
| 2026-11-12 | **N1:** o Operador envia Proposta; a Ana aceita no portal; uma Proposta aberta por Dívida; o primeiro Acordo vale; pagamento fora do Quita do Gestor | Entrevista | Requisitos M4, M5, M7; API 4, 5.4, 5.15, 7; Banco 5.2, 5.3; Portal 3, 5, 6; ux; B05, B06, P04, P07; roadmap F12 |
| 2026-11-12 | **P2:** a Quebra nunca é desfeita (Pix até o fim do prazo, Quebra às 03:00 conferindo pagamentos); incompleto quebra; depois da Quebra, B11 sem crédito nem estorno | Entrevista | Requisitos RN5.3, RN5.5, RN5.6, RN6.4; API 5.5, 5.6, 6, 9; Banco 5.4; HLD 6.4; ux P08, B11; roadmap F10, F13 |
| 2026-11-12 | Corte: "Avisar quando liberar" (job por minuto, `DebtorLockReleased`, botão) | Tabela, job e evento que o fluxo não precisa; a ficha já mostra quem e até quando | API 3, 5.8, 7, 9; Backoffice 6; ux B05; B05; roadmap F11; auditoria O2 |
| 2026-11-12 | Proposta ganha o status `canceled`; `ProposalClosed` só quando ela vence sem nada no lugar | `expired` diria uma mentira; o evento do que veio no lugar já move a Dívida | API 4, 5.4; Banco 5.3 |
| 2026-11-12 | Pagamento fora do Quita: caso de uso no `negotiation`, evento `ExternalPaymentRecorded`, três colunas `settled_externally_*` na Dívida, só Gestor, recusado com Acordo vivo, fora do valor recuperado | O `negotiation` conhece Propostas e Acordos; colunas são o mais simples; sem nova seta entre módulos | API 3, 5.15; Banco 5.2; Requisitos RF7.7, RN7.6 |
| 2026-11-12 | Trava por Dívida (`pg_advisory_xact_lock`) nas ações que mudam a negociação | Pagamento fora do Quita e aceite simultâneos não podem ambos passar | API 5.4 |
| 2026-11-12 | O aceite recalcula na data de referência da Proposta | Os juros diários invalidariam toda Proposta aceita no dia seguinte | API 5.4 |
| 2026-11-12 | Entrada vencida passa a rodar às 03:00 com a mesma conferência, e o Pix da Entrada vence no fim do vencimento | A mesma regra da Quebra, sem cancelar Acordo pago no prazo | API 5.5, 5.6, 9 |
| 2026-11-12 | Só concilia Cobrança `pending`; `payment` cancela as Cobranças ao receber `AgreementBreached`/`AgreementCanceled` (no lugar de `AgreementActivated`, que não tinha uso) | Nenhum Pix válido para Acordo encerrado | API 3, 5.5 |
| 2026-11-12 | Novo código `PAYMENT_WINDOW_CLOSED` | Pedido de Pix entre o fim do prazo e a Quebra | API 7; ux mapa de erros, P08 |
| 2026-11-12 | Eventos sem ouvinte removidos: `CreditorCreated`, `PaymentUnreconciled`, `PaymentPromiseBroken`, `DebtorLockReleased` | Evento sem ouvinte é código morto | API 3, 5.5 |
| 2026-11-12 | Só Pix no MVP (boleto depois) | O roadmap já tirava o boleto; fechou a questão aberta em 4 documentos | Requisitos RF4.5, RN6.4, 8; Brief; PRODUCT; API 14; Banco 5.4 |
| 2026-11-12 | RN2.3 também protege Dívida quitada ou cancelada | Uma Dívida paga fora do Quita não pode reabrir pela importação | Requisitos RN2.3; API 5.9; ux B08 |
| 2026-11-12 | B11 é do Gestor (RF6.3 dizia operador); RN4.2 = 48 h; RF1.5, RF3.4, RF4.7, RF7.6 marcados como fora do MVP | Requisito alinhado às rotas e ao LLD | Requisitos |
| 2026-11-12 | `POST /proposals` liberado ao gestor também | A ficha (B05/B06) é de operador e gestor | API 7 |
| 2026-11-12 | `agreement.operator_id` nasce nulo na F09 e é preenchido a partir da F11; os indicadores da B03 entram na F14 (F14 passa a depender da F11) | A Fila e `operator_performance` só existem nessas funcionalidades | API 5.12; roadmap F09, F11, F14 |
| 2026-11-12 | Link da Proposta: o portal guarda a rota pedida (`?next=`) e volta para ela depois do código | O link do e-mail precisa abrir a Proposta | Portal 3, 5 |
| 2026-11-12 | Textos da caixa de saída catalogados | Eventos de notificação sem texto dono | ux seção 8 |
| 2026-11-12 | Estados da B07 e da B10 renumerados (3a e 2a viraram inteiros); B05 sem mensagem da Régua na linha do tempo; KPIs "Tempo até o acordo" e "Promessas cumpridas" marcados F21 | Telas prometiam o que o MVP não tem | B05, B07, B10; ux B14 |
| 2026-11-12 | "Dívida fictícia" vira "Dívida de exemplo"; P00 sem "portfólio" | Tom de produto | Requisitos RF3.3; Backoffice 9; roadmap F06; ux P00; B10 |
| 2026-11-12 | Brief: o MVP ocupa as 8 semanas; Fases 2 e 3 viram backlog | O roadmap já dizia isso; o brief contradizia | Brief |
| 2026-11-12 | F12 de P para M (+1 dia); janelas da F12 em diante andam 1 dia; calendário anterior intacto | Tamanho honesto | Roadmap |
| 2026-11-12 | Mantidos, depois de revisar: `raw_line`/`error_type`, `failure_reason`, `template.csv`, `PUT /creditors/{id}/logo`, `PASSWORD_RESET_TTL`, `operator_id` pela `CollectionApi`, BFF em `/c/[slug]/bff/...`, F03 em P "no limite" | Cada um serve a algo que o usuário pediu (ciclo de correção, marca, senha, números do Operador) ou a uma restrição técnica (cookie por caminho) | — |
| 2026-11-12 | Prazo +1 dia aceito; comprovante em PDF fora do MVP; Acordo de Proposta conta para quem enviou; pagamento fora recusado com Acordo vivo | Seção 6 | roadmap, API 5.5 e 5.12, portal 3, banco 5.3, ux-writing P08/P09, prompt P09 |
| 2026-11-12 | **Login sem escolher a Credora:** um e-mail é de uma Credora só no MVP (índice único `lower(email)` global em `identity.app_user`); convite com e-mail já usado → 409 `EMAIL_ALREADY_IN_USE`; o login acha o usuário fora do filtro de tenant | A tela de login fica só com e-mail e senha; quem trabalha para duas Credoras é necessidade de depois | Requisitos RN1.5; API 5.13, 7; Banco 4, 5.1; ux B12; B12 |
| 2026-11-12 | **Renovação do token do Devedor no `proxy`:** Server Components só leem cookies; o `proxy` renova antes de renderizar a rota autenticada e grava os cookies na resposta; Server Actions e route handlers também podem renovar | Server Component não grava cookie | Portal 5, 10 |
| 2026-11-12 | **Simulação com o rascunho:** `POST /policies/simulations` (gestor), sem estado, com as regras do formulário, as configurações gerais e `{ principalAmount, overdueDays }`; valida e não grava | O simulador reage à edição não salva; salvar a cada tecla bateria na checagem de `version` | Requisitos RF3.3; API 5.3, 7; Backoffice 9; roadmap F06 |
| 2026-11-12 | **Simulador → revisão pela URL:** "Revisar acordo" leva `?installments=&downPayment=`; a P07 recalcula no servidor pela API; "Fechar acordo" envia `{ debtId, installments, downPayment }` com `Idempotency-Key`, e a API recalcula ao criar | Nada a perder ao recarregar, link válido na sessão, dinheiro nunca calculado no navegador | Portal 3, 6; API 5.4; prompts README (rota da P07) |
| 2026-11-12 | **Jobs com a API dormindo:** `@Scheduled` no processo e um workflow agendado do GitHub Actions chamando `POST /internal/jobs/run` a cada hora (`X-Jobs-Secret` = `JOBS_TRIGGER_SECRET`, senão 401); jobs idempotentes e por condição; aceite e Pix conferem o vencimento na leitura | Sem chamada que acorde a API, o job das 03:00 nunca roda; a API acordada gasta cerca de 744 das 750 horas gratuitas do Render | ADR 0007; HLD 11; API 5.6, 7, 9, 12; roadmap F13 |
| 2026-11-12 | **Filtro por Faixa no painel fora do MVP:** filtros da B14 = período e Operador (só gestor); o aging já mostra o valor por Faixa; filtro por Faixa na F21 | `daily_recovery` não tem Faixa na chave; acrescentar multiplica o modelo de leitura por um filtro que ninguém pediu | Requisitos RF9.3; API 5.10, 7; Backoffice 4, 8; ux B14; B14; roadmap F14, F21 |
| 2026-11-12 | **`POST /proposals` exige a reserva do Devedor:** sem ela, 409 `DEBTOR_LOCKED` com `lockedBy` e `lockedUntil` | RN7.2: dois atendentes nunca negociam o mesmo Devedor; a B06 vive na ficha, que já reserva | API 5.4, 7 |
| 2026-11-12 | **A versão da Política que vale é a da Proposta:** `proposal_validity_hours`, `breach_tolerance_days` e `min_installment_amount` da versão da Proposta valem para o Acordo inteiro; Quebra e janela do Pix leem por Acordo → Proposta → versão | Publicar uma Política nova nunca muda acordos já feitos (RF3.2) | Requisitos RN5.1; API 5.4, 5.5, 5.6; ux P07, P09; P07, P09 |
| 2026-11-12 | **Sem `docs/design-system.md`:** o design system é o `design/DESIGN.md` mais os tokens; o portal guarda uma cópia do CSS dos tokens; sem pacote no GitHub Packages nem `NPM_TOKEN` | Um consumidor fora do monorepo não justifica um registro de pacotes; rever com um terceiro app | HLD "Design system", 12; Backoffice 14; Portal 1, 11; AGENTS; PRODUCT; F01 PRD e spec |

---

## 4. Mapa de impacto no modelo de dados

Base: `git diff` de `docs/lld/database.md` e `docs/lld/api.md` contra a versão aprovada de 2026-11-10, mais esta revisão.

**Schemas.** O walking skeleton (F01) já cria os nove schemas na migração `V<carimbo>__shared_create_schemas.sql` (`identity`, `portfolio`, `negotiation`, `payment`, `collection`, `notification`, `analytics`, `audit`, `fake_gateway`). Nenhum schema novo é necessário. Cada tabela nasce numa migração nova (`V<carimbo>__<module>_<descricao>.sql`) da funcionalidade dona; coluna que chega depois entra por outra migração nova (nunca editar uma aplicada).

### Tabelas e colunas

| schema.tabela | Mudança | Migração em | Rotas | Telas |
| --- | --- | --- | --- | --- |
| `identity.creditor` | + `display_name`, `brand_color`, `support_email`, `support_phone`, `logo_version` | F02 cria a tabela; F03 acrescenta as colunas de marca | `POST /creditors`, `GET /public/creditors/{slug}` | B13, P01, P02, P09 |
| `identity.creditor_logo` | Nova (global, sem tenant) | F03 | `PUT /creditors/{id}/logo`, `GET /public/creditors/{slug}/logo/{sha256}` | B13, P01 |
| `identity.password_reset` | Nova (global) | F02 | `POST /auth/password-resets`, `POST /auth/password-resets/{token}` | B01 |
| `identity.app_user` | `role`: `platform_admin`, `manager`, `operator` (sem `auditor`); índice único `lower(email)` global, no lugar de `(tenant_id, email)` | F02 | `PATCH /users/{id}`, `POST /invitations` | B02, B12 |
| `portfolio.portfolio_import` | + `failure_reason` (`early_fail_rate`, `unexpected`) | F04 | `GET /portfolio-imports/{id}` | B08 |
| `portfolio.import_row_error` | + `error_type`, `raw_line`; várias linhas por `row_number` | F04 | `GET /portfolio-imports/{id}/errors.csv` | B08 |
| `portfolio.debtor` | `phone` só dígitos; índice `(tenant_id, phone)` | F04 (tabela); F05 (índice) | `GET /debtors?q=`, `POST /debts` | B04 |
| `portfolio.debt` | `portfolio_import_id` = importação que criou, nunca muda (nulo à mão) | F04 | `POST /debts` (F05) | B04, B05 |
| `portfolio.debt` | + `settled_externally_at`, `settled_externally_by`, `settled_externally_note` | F12 | `POST /debts/{id}/external-payment`, `GET /debtors/{id}` | B05 |
| `negotiation.policy_bucket_rule` | De 1 a 5 por Política (regra da aplicação) | F06 | `PUT /policies/{id}` | B10 |
| `negotiation.proposal` | `status` + `canceled`; `created_by_user_id` = Operador no canal `backoffice`; índice único parcial de uma Proposta aberta por Dívida | F09 (já com o status e o índice) | `POST /proposals` (F12), `GET /debtor/proposals/{id}`, `POST /debtor/proposals/{id}/accept` (F12), `POST /debtor/agreements` | B06, B05, P04, P07 |
| `negotiation.agreement` | + `operator_id` (nulo) | F09 (coluna); F11 (preenchimento pela `CollectionApi`) | `GET /agreements/{id}` | B05, B14 |
| `payment.charge` | `method` só `pix`; `expires_at` limitado ao último dia de pagamento; `canceled` quando o Acordo encerra | F10 (F13 cancela por evento) | `POST /debtor/installments/{id}/charges` | P08, P09 |
| `payment.payment` | Motivo de `unreconciled` sai dos dados; sem tenant vai ao admin | F10 (tabela); F13 (B11) | `GET /payments?status=unreconciled`, `POST /payments/{id}/resolve` | B11 |
| `payment.webhook_event` | Lido pela Quebra (eventos sem `processed_at`) | F10 (tabela); F13 (leitura) | — | — |
| `collection.debtor_lock` | Sem job de vencidas; a linha vencida é sobrescrita | F11 | `POST`/`DELETE /debtors/{id}/lock` | B03, B05 |
| `notification.outbox_message` | Novos `template_key`: `password_reset` (F02), `proposal_sent` (F12) | F02 (tabela) | — | `/demo/inbox` |
| `notification.in_app_notification` | Saiu do MVP (F16) | — | — | B02 |
| `analytics.portfolio_aging` | Chave `(tenant_id, policy_bucket_rule_id)` + `min_overdue_days`, `max_overdue_days` | F14 | `GET /analytics/aging` | B14 |
| `analytics.operator_performance` | Veio da Fase 2 para o MVP | F14 | `GET /analytics/summary` | B03, B14 |

### Eventos

| Evento | Mudança | Feat. |
| --- | --- | --- |
| `PasswordResetRequested` | Novo: `identity` → `notification` | F02 |
| `ProposalCreated` | Novo ouvinte: `notification` (só canal `backoffice`, link da Proposta) | F12 |
| `ProposalClosed` | Só quando a Proposta vence sem nada no lugar | F13 |
| `ExternalPaymentRecorded` | Novo: `negotiation` → `portfolio`, `collection` | F12 |
| `AgreementBreached`, `AgreementCanceled` | Novo ouvinte: `payment` (cancela Cobranças); `payment` deixa de ouvir `AgreementActivated` | F13 |
| `AgreementCreated` | Novo ouvinte: `analytics` | F14 |
| `CreditorCreated`, `PaymentUnreconciled`, `PaymentPromiseBroken`, `DebtorLockReleased` | Removidos (sem ouvinte) | — |

### Rotas, códigos, jobs e valores

| Tipo | Mudança | Feat. |
| --- | --- | --- |
| Rotas novas | `POST /auth/password-resets`, `POST /auth/password-resets/{token}` | F02 |
| Rotas novas | `PUT /creditors/{id}/logo`, `PATCH /users/{id}`, `POST /invitations/{id}/resend`, `GET /public/creditors/{slug}`, `GET /public/creditors/{slug}/logo/{sha256}` | F03, F07 |
| Rotas novas | `GET /portfolio-imports/template.csv`, `POST /debts` | F04, F05 |
| Rotas novas | `POST /policies/simulations` (rascunho, sem gravar) | F06 |
| Rotas novas | `GET /debtor/agreements` | F08 |
| Rotas novas | `GET /debtor/proposals/{id}`, `POST /debtor/proposals/{id}/accept`, `POST /debts/{id}/external-payment` | F12 |
| Rota removida | `POST /proposals/{id}/accept` (backoffice): o aceite é só da Ana | F12 |
| Rotas novas | `POST /internal/jobs/run` (cabeçalho `X-Jobs-Secret`, fora do proxy dos fronts) | F13 |
| Rota de tela nova | Portal `/c/[slug]/debts/[debtId]/review?installments=&downPayment=` (P07) | F09 |
| Rota de tela nova | Portal `/c/[slug]/proposals/[proposalId]`; backoffice `/password-reset`, `/password-reset/:token` | F12, F02 |
| Códigos novos | `PASSWORD_RESET_INVALID` (F02), `NO_PUBLISHED_POLICY` (F08), `PAYMENT_WINDOW_CLOSED` (F10); `PROPOSAL_EXPIRED` e `AGREEMENT_ALREADY_EXISTS` com novos casos (F12); `EMAIL_ALREADY_IN_USE` (F03); `DEBTOR_LOCKED` também em `POST /proposals` sem a reserva (F12) | — |
| Jobs | Entrada vencida: de a cada hora para 03:00 com conferência; Proposta vencida publica `ProposalClosed`; aging pelas Faixas publicadas; "Reservas vencidas" removido; todos por condição e idempotentes, disparados também pelo workflow de hora em hora (GitHub Actions no `quita-backend-api`) | F13, F14 |
| Valores novos | `IMPORT_EARLY_FAIL_RATE`, `PASSWORD_RESET_TTL`, `CREDITOR_LOGO_MAX_SIZE`, `CREDITOR_LOGO_MAX_DIMENSION`; `PIX_EXPIRATION_HOURS` limitado ao último dia; `BREACH_JOB_CRON` explicado; variável `JOBS_TRIGGER_SECRET` (F13); `NPM_TOKEN` removido do portal | — |

---

## 5. Telas a regenerar no protótipo

Todas já regeneradas, com status "gerada (auditoria), a revisar" em `design/prompts/README.md`, menos a B14, que volta a "a regenerar (auditoria)" (filtro por Faixa fora do MVP).

| Tela | O que mudou |
| --- | --- |
| P01 | Marca e contato do cadastro; termos sempre do Quita; sem logo, iniciais |
| P03 | Texto neutro, sem contato mascarado |
| P04 | Seus acordos; uma Dívida por Acordo; card com Proposta aberta e **Ver proposta** (estado 5) |
| P06 | Estado sem Política publicada |
| P07 | Tolerância da Política; estados 5 (Proposta recebida, "enviada por Bruno, válida até") e 6 (Proposta que não vale mais) |
| P08 | Validade do Pix até o último dia de pagamento; estado 6 (prazo encerrado) |
| P09 | Tolerância da Política, contato da Credora; sem comprovante em PDF (fora do MVP) |
| B01 | Recuperar senha e nova senha |
| B02 | Notificações só da sessão; menus de gestor, operador e admin, sem papel só de leitura |
| B03 | Pílulas pelas Faixas publicadas; indicadores do Operador (F14) |
| B04 | Busca por telefone; "Nova dívida" |
| B05 | CPF sempre mascarado; reserva sem "avisar quando liberar"; Proposta aberta na Dívida; "Registrar pagamento fora do Quita" (estados 5 e 6); linha do tempo sem Régua |
| B06 | "Enviar proposta à Ana", validade, Proposta aberta a substituir, estados 1 a 6 |
| B07 | Modelo em português, pré-validação, estados 1 a 7 |
| B08 | Resumo por tipo de erro, relatório corrigível, parada cedo |
| B10 | De 1 a 5 Faixas, estados 1 a 7 |
| B11 | Motivo "cobrança encerrada"; sem crédito nem estorno |
| B12 | Papéis gestor e operador (Pedro Nunes vira operador) |
| B13 | Seção "Portal da credora" (marca e contato) |
| B14 | Sem filtro de Carteira; blocos da F21 marcados; **a regenerar:** sem a pílula de Faixa (filtros = período e operador, este só para a gestora) |

Sem mudança: P00, P02, P05, P10, B09 e o D1 (dark mode, refeito depois das regeneradas).

---

## 6. Questões da entrevista: decididas (2026-11-12)

1. **Prazo +1 dia: aceito.** A vitrine termina em 05/01. O comprovante em PDF (P08, P09) **saiu do MVP**: trazia uma dependência nova (gerar PDF) para pouco ganho, e o tempo dele vira folga. Se a F03 estourar, a ordem de corte do roadmap continua valendo.
2. **Atribuição do Acordo:** o que nasce de uma Proposta enviada pelo backoffice conta para **quem enviou** (`proposal.created_by_user_id`); o que o Devedor fecha sozinho no portal conta para o dono da Fila naquele momento. Sem coluna nova (LLD da API, 5.12).
3. **Dívida paga fora com Acordo em andamento:** a recusa fica no MVP. Encerrar o Acordo vivo junto com o pagamento fora (novo estado de Acordo) fica para a Fase 2.

Sem questões em aberto para o MVP.

---

## 7. Como ler a documentação

Cascata: cada fato tem um dono, e as camadas de baixo seguem as de cima.

| Camada | Arquivo | Dono de |
| --- | --- | --- |
| 1. Requisitos | `docs/foundation/business-requirements.md`, `docs/product-brief.md`, `design/PRODUCT.md` | O quê e por quê: módulos, RF e RN, escopo, público |
| 2. Arquitetura | `docs/hld.md`, `docs/adr/*` | As partes, como conversam e as decisões de arquitetura |
| 3. LLD da API | `docs/lld/api.md` | Regras com números, valores (seção 6), máquinas de estado, eventos, rotas e códigos de erro |
| 3. LLD dos fronts | `docs/lld/backoffice.md`, `docs/lld/portal.md` | Rotas de tela, estado, chamadas, BFF |
| 4. Banco | `docs/lld/database.md` | Tabelas, colunas, índices, migrações |
| 5. Telas | `design/ux-writing.md` (todo texto), `design/prompts/*`, `design/DESIGN.md` | O que a tela mostra e diz |
| Transversais | `GLOSSARY.md` (vocabulário), `docs/roadmap.md` (ordem e tamanho), `docs/features/*` (PRD, spec e tarefas de cada funcionalidade) | — |

Para programar uma funcionalidade: o bloco dela no roadmap → as linhas dela nas seções 2 e 4 daqui → as seções citadas do LLD da API e do banco → as telas e os textos.
