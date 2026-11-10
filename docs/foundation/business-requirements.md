# Quita: requisitos de negócio

Plataforma B2B de cobrança e renegociação de dívidas

2026-11-10 · Status: rascunho para validação

> Este documento alimenta o `product-brief`. Arquitetura, telas e schema não entram aqui: são do HLD, do design system e do LLD. Os valores de regra (percentuais, prazos) são **propostas** para dar realismo e testabilidade; o dono final deles é a tabela "Valores e configuração" do LLD.

---

## 1. Contexto de mercado

- **A dor.** Credoras de médio porte (escolas particulares, clínicas, academias, varejo regional, SaaS, cooperativas) cobram inadimplentes por planilha, e-mail e WhatsApp. Não têm política clara de desconto, cada atendente negocia de um jeito, acordos quebram sem ninguém perceber e o gestor não sabe quanto recuperou.
- **O devedor** quer resolver sozinho, pelo celular, sem ligar para ninguém e sem constrangimento, entendendo exatamente quanto deve e por quê.
- **Referências reais** (para estudar o fluxo, não copiar): Serasa Limpa Nome, Acordo Certo, QuiteJá, programa Desenrola Brasil, softwares de assessorias de cobrança.
- **Proposta.** Um SaaS B2B multi-empresa (multi-tenant): a credora sobe a carteira de dívidas e define a política de negociação. O devedor se autoatende num portal, e os operadores cuidam das exceções num backoffice. O gestor acompanha a recuperação num painel analítico.

## 2. Como o negócio funciona

### 2.1 Por que a credora aceita receber menos

Pensa numa padaria que vendeu fiado: cada mês que passa, a chance de receber cai, porque o cliente se muda, troca de número ou simplesmente esquece. Receber **R$ 600 hoje** vale mais do que tentar receber R$ 1.000 que talvez nunca venham.

No mercado isso tem nome:

- **Curva de recuperação:** quanto mais velha a dívida, menor a chance de pagar. Por isso o desconto cresce com o atraso.
- **Provisão para perda (PDD):** depois de um tempo, a contabilidade da credora já registra a dívida como prejuízo. Daí em diante, qualquer valor recebido volta como receita.
- **Custo de cobrar:** ligação, SMS, atendente e assessoria custam dinheiro. O autoatendimento baixa esse custo, e é aí que o Quita gera valor.
- **Alternativa ruim:** vender a carteira para um fundo especializado (cessão de crédito) por uma fração pequena do valor de face.

### 2.2 Quem ganha o quê (proposta)

- **Credora:** recupera dinheiro que daria como perdido, com menos custo e sem constranger o cliente.
- **Devedor:** sai da inadimplência com desconto e parcelas que cabem no bolso, sem ligar para ninguém.
- **Quita (modelo de receita, proposta):** mensalidade por faixa de devedores ativos + **taxa de sucesso** (percentual sobre o valor recuperado). Valores: a definir.
- **Fluxo do dinheiro:** devedor → gateway de pagamento → conta da credora. A cobrança da taxa do Quita fica fora do MVP (sem split de pagamento).

### 2.3 Regras do mundo real que o sistema respeita

- **CDC, art. 42:** na cobrança, o consumidor não pode ser exposto ao ridículo nem sofrer constrangimento ou ameaça. Por isso há horário de contato, limite de contatos e linguagem neutra nos modelos de mensagem.
- **CDC, art. 43:** informação negativa não fica mais de 5 anos nos cadastros de proteção ao crédito.
- **Multa e juros:** em dívida de consumo, a multa por atraso é limitada a 2%.
- **LGPD:** dados do devedor só são usados para a cobrança, com acesso mínimo e trilha de quem viu o quê.

### 2.4 Exemplo completo, com números

**A dívida.** Ana deve R$ 1.000,00 de mensalidade para a escola, vencida há **120 dias** (faixa 91–180).

**Valor atualizado** (RN3.2, sem correção para simplificar):
- Multa de 2%: R$ 20,00
- Juros de 1% ao mês, 4 meses: R$ 40,00
- Correção (escola não cobra): R$ 0,00
- **Total: R$ 1.060,00**

**Simulação no portal.** A política da faixa permite até **25% de desconto à vista** e até **10 parcelas**. O desconto cai à medida que as parcelas aumentam (RN3.5):
- À vista: 25% → **R$ 795,00**
- 5 parcelas: 25% × 6/10 = 15% → **R$ 901,00**

**Ana escolhe 5 parcelas.**
- Entrada mínima de 15%: R$ 135,15
- Restante: R$ 765,85, dividido em 4 parcelas
- R$ 765,85 ÷ 4 = R$ 191,4625. Viram 3 parcelas de R$ 191,46 e a última de **R$ 191,47**: o centavo de resíduo vai para a última (RN3.3).

**O acordo nasce.** Ana paga o Pix da entrada, o gateway avisa por webhook, a parcela tem baixa, e o acordo passa de "aguardando entrada" para "ativo". A dívida sai da régua de cobrança.

**A quebra.** Ana paga a 2ª parcela, mas a 3ª atrasa 11 dias, além da tolerância de 10 (RN5.1). O acordo quebra e o desconto se perde. O que ela pagou (R$ 326,61) abate a dívida, o saldo é recalculado sobre o valor atualizado na data da quebra, e a dívida volta para "em aberto" e para a fila de um operador.

Esse exemplo, sozinho, toca cálculo de dinheiro, Strategy, máquina de estados, webhook idempotente, evento de domínio, job agendado e UX de simulação.

### 2.5 Um dia de cada ator

- **Gestor (segunda de manhã):** importa a carteira do mês, confere o relatório de erros, ajusta a política da faixa > 360 dias porque a recuperação está baixa e aprova duas exceções pedidas pelos operadores.
- **Operador (o dia todo):** abre a fila, pega o próximo devedor, lê a linha do tempo, liga, registra uma promessa de pagamento para sexta, negocia um acordo em 6 parcelas e passa para o próximo.
- **Devedor (domingo à noite, no celular):** recebe o link pela régua, entra com CPF e código, vê quanto deve e por quê, mexe no simulador, fecha o acordo e paga a entrada por Pix em 3 minutos.
- **Admin do Quita:** cadastra uma credora nova e entra como ela para ajudar a configurar a primeira política.

### 2.6 Como a credora mede o sucesso

- **Taxa de recuperação:** valor recebido ÷ valor total da carteira, no período.
- **Taxa de conversão:** devedores que fecharam acordo ÷ devedores contatados.
- **Taxa de quebra:** acordos quebrados ÷ acordos fechados. Uma taxa alta mostra que a política está oferecendo parcelas que não cabem no bolso.
- **Aging da carteira:** quanto da carteira está em cada faixa de atraso.
- **Produtividade do operador:** acordos e valor recuperado por operador.

## 3. Atores

| Ator | Quem é | Onde atua |
| --- | --- | --- |
| **Admin da plataforma** | Time dono do SaaS | Backoffice (área admin) |
| **Gestor da credora** | Dono ou gerente financeiro da empresa cliente | Backoffice + Painel analítico |
| **Operador de cobrança** | Atendente da credora ou da assessoria contratada | Backoffice |
| **Devedor** | Pessoa física (CPF) ou jurídica (CNPJ) com dívida | Portal do devedor |
| **Gateway de pagamento** | Sistema externo (simulado) que emite Pix/boleto e avisa pagamentos | Integração (webhook) |

## 4. Glossário inicial (candidatos)

A `domain-modeling` vai lapidar esses termos. Ficam aqui para a gente falar a mesma língua desde já.

- **Credora (Creditor):** empresa cliente da plataforma, dona das dívidas. É o *tenant*.
- **Carteira (Portfolio):** um lote de dívidas importado de uma vez.
- **Dívida (Debt):** um valor devido por um devedor a uma credora, vindo de um contrato, com vencimento original.
- **Devedor (Debtor):** pessoa ou empresa que deve. Pode ter várias dívidas na mesma credora.
- **Faixa de atraso (Aging bucket):** classificação da dívida pelos dias de atraso (ex.: 0–30, 31–90...).
- **Valor atualizado:** principal + multa + juros de mora + correção, calculado numa data.
- **Política de negociação (Negotiation policy):** regras da credora sobre desconto máximo, parcelas, entrada e validade de proposta, por faixa de atraso.
- **Simulação (Simulation):** cálculo de uma condição de pagamento, sem compromisso.
- **Proposta (Proposal):** condição escolhida e enviada, com validade. Pode precisar de aprovação quando sai da política.
- **Acordo (Agreement):** proposta aceita e formalizada, com parcelas.
- **Parcela (Installment):** cada pagamento previsto num acordo. A primeira é a **entrada**.
- **Cobrança (Charge):** Pix ou boleto emitido para uma parcela.
- **Conciliação (Reconciliation):** ligar um pagamento recebido do gateway à parcela certa.
- **Quebra (Breach):** acordo cancelado por atraso de parcela além da tolerância.
- **Régua de cobrança (Collection cadence):** sequência automática de contatos por dias de atraso.
- **Tratativa (Interaction):** registro de um contato do operador com o devedor (ligação, mensagem, promessa de pagamento).
- **Fila (Work queue):** lista priorizada de devedores para cada operador trabalhar.

## 5. Módulos e requisitos

Convenção: **RF** = requisito funcional, **RN** = regra de negócio.

A distribuição entre apps é uma **proposta** para o HLD decidir:
- **Next.js:** Portal do devedor (público, mobile-first, SEO, white-label).
- **Angular:** Backoffice (shell/host + módulos operacionais e administrativos).
- **React:** Painel analítico + widget de atendimento (componente consumido por mais de um app).

---

### M1. Identidade, empresas e acesso

**RF**
- RF1.1 Admin da plataforma cadastra uma credora (razão social, CNPJ, plano, status).
- RF1.2 Gestor convida usuários da credora por e-mail, com papel (gestor, operador, auditor só-leitura).
- RF1.3 Login do backoffice com e-mail e senha, recuperação de senha e sessão com expiração.
- RF1.4 Devedor acessa o portal por **CPF/CNPJ + código de uso único** (enviado por e-mail/SMS simulado) ou por **link mágico** recebido na régua.
- RF1.5 Admin da plataforma pode "entrar como" uma credora para suporte, com registro na auditoria.

**RN**
- RN1.1 Dados de uma credora nunca aparecem para outra (isolamento total de tenant).
- RN1.2 Permissões por papel: operador não altera política, auditor não altera nada.
- RN1.3 Código de acesso do devedor: 6 dígitos, válido por 10 min, no máximo 5 tentativas; depois, bloqueio de 15 min.
- RN1.4 Sessão do devedor expira após 15 min sem atividade.

---

### M2. Importação de carteira

**RF**
- RF2.1 Gestor envia um arquivo CSV de dívidas (até 100 mil linhas).
- RF2.2 Antes de confirmar, a tela mostra uma **pré-visualização** das primeiras linhas e o mapeamento de colunas (o gestor diz qual coluna é CPF, valor, vencimento...).
- RF2.3 O processamento é assíncrono, com **progresso em tempo real** (linhas processadas, válidas, com erro).
- RF2.4 Ao final, relatório de erros por linha, baixável em CSV.
- RF2.5 Histórico de importações com status (processando, concluída, concluída com erros, falhou).

**RN**
- RN2.1 CPF/CNPJ validado pelo dígito verificador. Linha inválida não entra, mas não derruba o lote.
- RN2.2 Duplicidade: mesma credora + mesmo documento + mesmo número de contrato = atualiza a dívida existente, não cria outra.
- RN2.3 Dívida com acordo ativo não é sobrescrita pela importação: a linha vai para o relatório como "ignorada".
- RN2.4 Uma credora só tem uma importação processando por vez.

---

### M3. Política de negociação

**RF**
- RF3.1 Gestor configura a política por faixa de atraso: desconto máximo, número máximo de parcelas, entrada mínima, juros de parcelamento.
- RF3.2 Política tem **versões**: editar cria uma versão nova com data de início, sem afetar acordos já feitos.
- RF3.3 Simulador interno: o gestor testa a política com uma dívida fictícia antes de publicar.
- RF3.4 Operador pode pedir **exceção** (desconto acima da política), que o gestor aprova ou recusa.

**RN (propostas)**

| Faixa de atraso | Desconto máx. à vista (sobre o valor atualizado) | Parcelas máx. | Entrada mín. |
| --- | --- | --- | --- |
| 0–30 dias | 0% | 3 | 30% |
| 31–90 | 10% | 6 | 20% |
| 91–180 | 25% | 10 | 15% |
| 181–360 | 45% | 12 | 10% |
| > 360 | 70% | 18 | 10% |

- RN3.1 Parcela mínima de R$ 50,00.
- RN3.2 Valor atualizado = principal + multa (2%) + juros de mora (1% a.m., pró-rata dia) + correção (índice simulado). Base: limites do CDC para dívidas de consumo.
- RN3.3 Dinheiro é sempre calculado em centavos/decimal exato; o resíduo de arredondamento vai para a **última** parcela.
- RN3.4 Cada tipo de credora pode ter uma estratégia de cálculo diferente (ex.: escola não cobra correção).
- RN3.5 O desconto diminui com o número de parcelas: desconto aplicado = desconto máximo × (parcelas máx. − parcelas escolhidas + 1) ÷ parcelas máx. À vista recebe o desconto cheio.
- RN3.6 Juros de parcelamento: a definir (no MVP, 0%).

---

### M4. Portal do devedor (autoatendimento)

**RF**
- RF4.1 Página pública da credora (white-label, ver M11) com explicação e botão "consultar minhas dívidas".
- RF4.2 Após acesso, lista das dívidas com valor original, valor atualizado e o que compõe a diferença.
- RF4.3 **Simulador interativo:** o devedor escolhe a entrada e o número de parcelas (slider), e vê o desconto e o valor das parcelas recalculados na hora.
- RF4.4 Escolher uma condição gera uma proposta. Dentro da política, vira acordo direto; fora dela, vai para aprovação.
- RF4.5 Pagar a entrada por Pix (QR Code e copia-e-cola) ou boleto, ambos simulados.
- RF4.6 Acompanhar o acordo: parcelas pagas, próximas e segunda via.
- RF4.7 Contestar uma dívida ("não reconheço"), com motivo e anexo.

**RN**
- RN4.1 A simulação é calculada no servidor (a fonte da verdade), mas a interface responde sem travar enquanto o devedor arrasta o slider.
- RN4.2 Proposta vale até as 23:59 do dia seguinte.
- RN4.3 Uma dívida só pode ter **um** acordo ativo. Se o operador e o devedor fecharem ao mesmo tempo, só um vence, e o outro recebe uma mensagem clara.
- RN4.4 Dívida contestada fica suspensa (sem régua e sem negociação) até a análise.
- RN4.5 Acessível (WCAG 2.2 AA) e usável num celular básico em 4G.

---

### M5. Acordos e parcelas (coração do domínio)

**Ciclo de vida da dívida (proposta)**
- em aberto → em negociação: proposta criada
- em negociação → em acordo: entrada paga
- em negociação → em aberto: proposta expirou ou foi recusada
- em acordo → quitada: última parcela paga
- em acordo → em aberto: acordo quebrado
- qualquer → contestada → (em aberto | cancelada)

**Ciclo de vida do acordo (proposta)**
- proposto → aguardando entrada → ativo → quitado
- aguardando entrada → cancelado: entrada não paga até o vencimento
- ativo → quebrado: parcela em atraso além da tolerância

**RN**
- RN5.1 Tolerância de quebra: parcela com mais de 10 dias de atraso quebra o acordo (configurável por credora).
- RN5.2 Na quebra, o que já foi pago abate o principal e a dívida volta a "em aberto" com o saldo recalculado.
- RN5.3 Pagamento que chega depois da quebra vira **crédito** para o próximo acordo (ou estorno, a definir).
- RN5.4 Toda mudança de estado gera um evento (ex.: `AgreementBreached`) que outros módulos escutam (régua, painel, notificações).

---

### M6. Pagamentos e conciliação

**RF**
- RF6.1 Emitir cobrança (Pix/boleto) para uma parcela, através de um gateway **simulado** (um serviço fake que você mesmo constrói).
- RF6.2 Receber o aviso de pagamento por webhook e dar baixa na parcela.
- RF6.3 Tela de pagamentos não conciliados para o operador resolver à mão.

**RN**
- RN6.1 O webhook pode chegar repetido, fora de ordem ou atrasado: processar duas vezes nunca dá baixa duas vezes.
- RN6.2 O webhook é autenticado por assinatura (HMAC).
- RN6.3 Pagamento parcial (valor menor que a parcela) não dá baixa: vai para conciliação manual.
- RN6.4 Pix expira em 24h; boleto vence em 3 dias úteis.

---

### M7. Backoffice do operador

**RF**
- RF7.1 **Fila de trabalho:** cada operador vê os devedores priorizados para ele.
- RF7.2 **Ficha do devedor:** dados, dívidas, acordos, linha do tempo de tratativas e pagamentos.
- RF7.3 Registrar tratativa (ligação, mensagem, promessa de pagamento com data).
- RF7.4 Negociar pelo devedor (mesmo simulador do portal, com os limites da política e a opção de pedir exceção).
- RF7.5 Busca global de devedor por nome, CPF parcial, contrato ou telefone.
- RF7.6 Ações em lote: reatribuir devedores, pausar régua.

**RN**
- RN7.1 Distribuição da fila configurável: rodízio, por faixa de atraso ou por valor (estratégias plugáveis).
- RN7.2 Dois operadores não trabalham o mesmo devedor ao mesmo tempo: abrir a ficha "reserva" o devedor por 15 min, e o outro vê quem está atendendo.
- RN7.3 Promessa de pagamento vencida volta o devedor para o topo da fila.
- RN7.4 CPF aparece mascarado (`***.456.789-**`) para o operador, exceto com permissão.

---

### M8. Régua de cobrança e notificações

**RF**
- RF8.1 Gestor monta a régua: passos por dia relativo ao vencimento (D-3 lembrete, D+1 e-mail, D+5 SMS, D+15 oferta especial...).
- RF8.2 Modelos de mensagem com variáveis (`{nome}`, `{valor}`, `{link}`), com pré-visualização.
- RF8.3 Envio simulado (caixa de saída visível no sistema, sem disparar de verdade).
- RF8.4 Notificações internas no backoffice (exceção para aprovar, pagamento conciliado).

**RN**
- RN8.1 Nada de contato fora de 8h–20h nem aos domingos (boa prática do mercado).
- RN8.2 Devedor com acordo ativo, contestação ou opt-out sai da régua.
- RN8.3 No máximo 1 contato por canal por dia.

---

### M9. Painel analítico

**RF**
- RF9.1 Indicadores: valor recuperado, taxa de recuperação, acordos ativos e quebrados, ticket médio.
- RF9.2 Gráficos: recuperação no tempo, aging da carteira, funil (devedores → simulação → proposta → acordo → quitado), ranking de operadores.
- RF9.3 Filtros combináveis (período, carteira, faixa, operador) refletidos na URL (link compartilhável).
- RF9.4 Exportar o relatório (CSV/PDF).

**RN**
- RN9.1 Operador vê só os próprios números; gestor vê tudo da credora.
- RN9.2 Números do painel podem ter até 5 min de atraso (consistência eventual), e a tela diz isso.

---

### M10. Auditoria e LGPD

**RF**
- RF10.1 Trilha de auditoria: quem fez o quê, quando e de onde (alteração de política, aprovação de exceção, "entrar como", exportação).
- RF10.2 Devedor pode baixar seus dados e pedir exclusão (respeitando a retenção legal).
- RF10.3 Registro de consentimento de contato (opt-in/opt-out por canal).

**RN**
- RN10.1 Auditoria é só de escrita: ninguém edita nem apaga.
- RN10.2 Dívida com mais de 5 anos não pode ser cobrada como negativável (referência: CDC, art. 43), e o sistema sinaliza.

---

### M11. White-label da credora

**RF**
- RF11.1 Gestor define logo, cores e textos do portal da credora.
- RF11.2 O portal de cada credora tem endereço próprio (`/c/<slug>` ou subdomínio).
- RF11.3 Pré-visualização ao vivo das cores antes de publicar.

**RN**
- RN11.1 O sistema recusa combinações de cor sem contraste mínimo (WCAG AA).

---

### M12. Atendimento em tempo real

**RF**
- RF12.1 Devedor abre um chat no portal e um operador atende pelo backoffice.
- RF12.2 Indicador de "digitando", lido/não lido, histórico.
- RF12.3 O mesmo widget de chat funciona nos dois apps (portal e backoffice).

**RN**
- RN12.1 Sem operador disponível, a conversa vira mensagem e entra na fila.

---

## 6. Requisitos não funcionais (propostas)

- **Isolamento de tenant** provado por teste automatizado.
- **Desempenho:** listagens paginadas com p95 < 300 ms com 1 milhão de dívidas no banco; LCP do portal < 2,5 s em 4G.
- **Acessibilidade:** portal com nota 100 no Lighthouse Acessibilidade e navegação 100% por teclado.
- **Segurança:** OWASP Top 10 como checklist de revisão; segredos fora do código.
- **Observabilidade:** logs estruturados com id de correlação ponta a ponta (front → API), métricas e health checks.
- **Qualidade:** CI que roda lint, testes e build de todos os apps a cada PR.
- **Idioma:** interface em pt-BR, moeda BRL, datas no fuso de São Paulo.

## 7. Fatiamento proposto

- **MVP (prova do ciclo completo):** M1 (simples), M2, M3 (sem versões nem exceção), M4, M5, M6, M7 (fila + ficha + negociação) e M9 (indicadores básicos).
- **Fase 2 (profundidade):** versões e exceções de política, M8, M10, M11.
- **Fase 3 (vitrine sênior):** M12, painel completo, carga com 1 milhão de registros, observabilidade completa.

## 8. Questões em aberto

- Pagamento após quebra: vira crédito ou estorno? (RN5.3)
- Gateway: Pix e boleto, ou só Pix no MVP?
- Mensageria (RabbitMQ ou Kafka), ou eventos só dentro da aplicação no MVP? (decisão de HLD)
- Quanto do M12 entra antes do deploy final.
