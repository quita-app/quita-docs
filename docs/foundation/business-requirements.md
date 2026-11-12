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

- **Gestor (segunda de manhã):** importa as dívidas do mês, confere o relatório de erros, ajusta a política da faixa > 360 dias porque a recuperação está baixa e aprova duas exceções pedidas pelos operadores.
- **Operador (o dia todo):** abre a fila, pega o próximo devedor, lê a linha do tempo, liga, registra uma promessa de pagamento para sexta, envia para a devedora uma proposta em 6 parcelas (ela confirma pelo link, no portal) e passa para o próximo.
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
- **Carteira (Portfolio):** o conjunto de todas as dívidas de uma credora ("a carteira da escola tem 1.200 devedores").
- **Importação (Portfolio import):** um arquivo de dívidas enviado de uma vez. O recorte por mês de entrada da dívida se chama **safra** (Fase 3, F21).
- **Dívida (Debt):** um valor devido por um devedor a uma credora, vindo de um contrato, com vencimento original.
- **Devedor (Debtor):** pessoa ou empresa que deve. Pode ter várias dívidas na mesma credora.
- **Faixa de atraso (Aging bucket):** classificação da dívida pelos dias de atraso (ex.: 0–30, 31–90...).
- **Valor atualizado:** principal + multa + juros de mora + correção, calculado numa data.
- **Política de negociação (Negotiation policy):** regras da credora sobre desconto máximo, parcelas, entrada e validade de proposta, por faixa de atraso.
- **Simulação (Simulation):** cálculo de uma condição de pagamento, sem compromisso.
- **Proposta (Proposal):** condição escolhida e enviada, com validade. No portal, o devedor cria e aceita na mesma tela; pelo backoffice, o operador envia e o devedor aceita pelo link. Fora da política, precisa de aprovação (Fase 2).
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
- RF1.1 Admin da plataforma cadastra uma credora (razão social, CNPJ, plano, status). No MVP, o cadastro também leva os dados do portal: nome de exibição, logo (opcional), cor de assinatura (opcional), e-mail e telefone de atendimento (ver M11).
- RF1.2 Gestor convida usuários da credora por e-mail, com papel (gestor ou operador).
- RF1.3 Login do backoffice com e-mail e senha, recuperação de senha e sessão com expiração.
- RF1.4 Devedor acessa o portal por **CPF/CNPJ + código de uso único** (enviado por e-mail/SMS simulado) ou por **link mágico** recebido na régua. O link mágico é da Fase 2 (F16, junto com a régua); no MVP, só CPF/CNPJ + código.
- RF1.5 Admin da plataforma pode "entrar como" uma credora para suporte, com registro na auditoria (Fase 2, F17).

**RN**
- RN1.1 Dados de uma credora nunca aparecem para outra (isolamento total de tenant).
- RN1.2 Permissões por papel: o operador não altera política, não importa dívidas e não registra pagamento fora do Quita; o gestor faz tudo na credora dele. Um papel só de leitura não entra no MVP (ideia futura, seção 8).
- RN1.3 Código de acesso do devedor: 6 dígitos, válido por 10 min, no máximo 5 tentativas; depois, bloqueio de 15 min.
- RN1.4 Sessão do devedor expira após 15 min sem atividade.
- RN1.5 No MVP, um e-mail pertence a **uma credora só** (único em toda a plataforma). Por isso o login é só e-mail e senha, sem escolher a credora: a credora vem do usuário encontrado. Convidar um e-mail que já é de um usuário ativo de qualquer credora é recusado. Uma pessoa que trabalha para duas credoras é necessidade de depois.

---

### M2. Importação de carteira

**RF**
- RF2.1 Gestor envia um arquivo CSV de dívidas (até 100 mil linhas).
- RF2.2 Antes de confirmar, a tela mostra uma **pré-visualização** das primeiras linhas e o mapeamento de colunas (o gestor diz qual coluna é CPF, valor, vencimento...). No MVP, o modelo é fixo, com cabeçalho em português (`CPF/CNPJ`, `Nome`, `E-mail`, `Celular`, `Contrato`, `Descrição`, `Valor original`, `Vencimento`), e a tela valida o arquivo inteiro antes de enviar; o mapeamento é da Fase 2.
- RF2.3 O processamento é assíncrono, com **progresso em tempo real** (linhas processadas, válidas, com erro).
- RF2.4 Ao final, relatório de erros por linha, baixável em CSV: as linhas originais com uma coluna "Erro", para corrigir e enviar de novo.
- RF2.5 Histórico de importações com status (processando, concluída, concluída com erros, falhou).
- RF2.6 Cadastro manual de uma dívida avulsa ("Nova dívida", na busca de devedores), com a mesma validação da importação.

**RN**
- RN2.1 CPF/CNPJ validado pelo dígito verificador. Linha inválida não entra, mas não derruba o lote.
- RN2.2 Duplicidade: mesma credora + mesmo documento + mesmo número de contrato = atualiza a dívida existente, não cria outra.
- RN2.3 Dívida com acordo ativo, já quitada ou cancelada não é sobrescrita pela importação: a linha vai para o relatório como "ignorada".
- RN2.4 Uma credora só tem uma importação processando por vez.
- RN2.5 Toda dívida precisa de e-mail ou celular do devedor: sem contato, ele nunca recebe o código de acesso.
- RN2.6 Devedor reimportado é atualizado com os dados mais recentes não vazios; uma célula vazia não apaga o que já existe.
- RN2.7 A importação não cancela nada: uma dívida que sumiu do arquivo do mês continua aberta. Quem dá baixa numa dívida paga fora do Quita é o gestor, na ficha (RF7.7).
- RN2.8 A dívida guarda a importação que a **criou**, e ela nunca muda: reimportar atualiza os dados da dívida, não a origem. Dívida cadastrada à mão não tem importação.

---

### M3. Política de negociação

**RF**
- RF3.1 Gestor configura a política por faixa de atraso: desconto máximo, número máximo de parcelas, entrada mínima, juros de parcelamento. Cada credora tem **de 1 a 5 faixas**: começa com as 5 da tabela abaixo, e o gestor edita os limites, remove (mínimo 1) e acrescenta (máximo 5), sem sobreposição nem buraco, e só a última sem teto. Filtros e painel usam as faixas da política publicada.
- RF3.2 Política tem **versões**: editar cria uma versão nova com data de início, sem afetar acordos já feitos.
- RF3.3 Simulador interno: o gestor testa a política com uma dívida de exemplo antes de publicar, inclusive com as regras ainda não salvas do rascunho (nada é gravado).
- RF3.4 Operador pode pedir **exceção** (desconto acima da política), que o gestor aprova ou recusa (Fase 2, F15).

**RN (propostas)** · faixas padrão de uma credora nova

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
- RF4.4 Escolher uma condição gera uma proposta. Dentro da política, o devedor confirma na mesma tela e ela vira acordo; fora dela, vai para aprovação (Fase 2).
- RF4.5 Pagar a entrada por Pix (QR Code e copia-e-cola), simulado. Boleto fica fora do MVP.
- RF4.6 Acompanhar o acordo: parcelas pagas, próximas e segunda via.
- RF4.7 Contestar uma dívida ("não reconheço"), com motivo e anexo (Fase 2, F19).
- RF4.8 Ver e aceitar a proposta que o operador enviou: o devedor recebe o link por e-mail e SMS, entra com o código, revisa e confirma com "Li e concordo". Só então nasce o acordo.

**RN**
- RN4.1 A simulação é calculada no servidor (a fonte da verdade), mas a interface responde sem travar enquanto o devedor arrasta o slider.
- RN4.2 Proposta vale 48 horas (configurável por credora, na política).
- RN4.3 Uma dívida só pode ter **um** acordo ativo. Se duas confirmações chegarem ao mesmo tempo (o devedor no simulador e o aceite da proposta do operador), só uma vence, e a outra recebe uma mensagem clara.
- RN4.4 Dívida contestada fica suspensa (sem régua e sem negociação) até a análise (Fase 2, F19).
- RN4.5 Acessível (WCAG 2.2 AA) e usável num celular básico em 4G.
- RN4.6 **Uma credora por sessão (MVP).** Um devedor que deve para duas credoras do Quita é um devedor em cada uma. Ele entra pelo link de cada credora, com um código para cada, e vê só as dívidas daquela credora. Se, logado numa, abrir o link da outra, vai para o acesso da outra, sem misturar nada. Motivos: privacidade (cada credora é dona dos dados dos seus devedores, LGPD), marca (o portal é da credora) e isolamento de tenant. Uma visão única opcional ("Meu Quita") fica para depois do MVP (seção 8).
- RN4.7 Sem política publicada, o portal não oferece acordos: a dívida aparece, mas a simulação diz que as condições ainda não estão disponíveis e indica o contato da credora.
- RN4.8 Termos de uso e privacidade do portal são sempre os do Quita, iguais para todas as credoras.
- RN4.9 Uma dívida tem no máximo **uma proposta aberta**. Uma proposta nova do operador encerra a anterior.
- RN4.10 Com uma proposta do operador aberta, o devedor pode fechar outra condição sozinho no portal: o primeiro acordo vale, e a proposta aberta se encerra.

---

### M5. Acordos e parcelas (coração do domínio)

**Ciclo de vida da dívida**
- em aberto → em negociação: proposta criada (no portal ou pelo operador)
- em negociação → em acordo: entrada paga
- em negociação → em aberto: a proposta venceu sem acordo, ou a entrada não foi paga
- em acordo → quitada: última parcela paga
- em acordo → em aberto: acordo quebrado
- em aberto ou em negociação (sem acordo vivo) → quitada: o gestor registrou pagamento fora do Quita (RF7.7)
- em aberto → contestada → (em aberto | cancelada) (Fase 2)

"Em negociação" quer dizer: há uma proposta aberta ou um acordo aguardando a entrada.

**Ciclo de vida da proposta**
- aberta → aceita: o devedor confirmou e o acordo nasceu
- aberta → vencida: passou a validade
- aberta → encerrada: outra proposta a substituiu, outro acordo nasceu ou o gestor registrou pagamento fora do Quita

**Ciclo de vida do acordo**
- aguardando entrada → ativo → quitado
- aguardando entrada → cancelado: entrada não paga até o vencimento
- ativo → quebrado: parcela em atraso além da tolerância

**RN**
- RN5.0 Um acordo é de **uma dívida só** no MVP. Quem tem duas dívidas fecha dois acordos. Juntar várias dívidas num acordo é questão da Fase 2 (seção 8).
- RN5.1 Tolerância de quebra: parcela com mais de 10 dias de atraso quebra o acordo (configurável por credora). Vale a tolerância da versão da política que regeu a proposta do acordo, pela vida inteira dele: publicar uma política nova não muda acordos já feitos (RF3.2).
- RN5.2 Na quebra, o que já foi pago abate o principal e a dívida volta a "em aberto" com o saldo recalculado.
- RN5.3 Um acordo nunca quebra para depois "desquebrar". Por isso: o Pix de uma parcela vale até o fim do último dia em que ela pode ser paga (vencimento + tolerância; para a entrada, o próprio vencimento), e a quebra só roda horas depois desse fim, conferindo antes que nenhum pagamento feito no prazo ficou para trás. Enquanto o aviso do banco não chega, o devedor vê "pagamento em processamento".
- RN5.4 Toda mudança de estado gera um evento (ex.: `AgreementBreached`) que outros módulos escutam (régua, painel, notificações).
- RN5.5 O acordo só quebra se a parcela não foi paga no prazo: (1) o pagamento veio depois da tolerância, ou (2) veio dentro dela, mas menor que a parcela (incompleto). O pagamento incompleto vai para a conciliação manual e não dá baixa.
- RN5.6 Pagamento que chega depois da quebra (ou de um acordo cancelado) não vira crédito nem estorno no MVP: vai para a conciliação manual, e o gestor resolve.

---

### M6. Pagamentos e conciliação

**RF**
- RF6.1 Emitir cobrança (Pix/boleto) para uma parcela, através de um gateway **simulado** (um serviço fake que você mesmo constrói).
- RF6.2 Receber o aviso de pagamento por webhook e dar baixa na parcela.
- RF6.3 Tela de pagamentos não conciliados para o gestor resolver à mão.

**RN**
- RN6.1 O webhook pode chegar repetido, fora de ordem ou atrasado: processar duas vezes nunca dá baixa duas vezes.
- RN6.2 O webhook é autenticado por assinatura (HMAC).
- RN6.3 Pagamento parcial (valor menor que a parcela) não dá baixa: vai para conciliação manual.
- RN6.4 Pix expira em 24 h, ou no fim do último dia de pagamento da parcela, o que vier primeiro (RN5.3). Boleto: fora do MVP.

---

### M7. Backoffice do operador

**RF**
- RF7.1 **Fila de trabalho:** cada operador vê os devedores priorizados para ele.
- RF7.2 **Ficha do devedor:** dados, dívidas, acordos, linha do tempo de tratativas e pagamentos.
- RF7.3 Registrar tratativa (ligação, mensagem, promessa de pagamento com data).
- RF7.4 Negociar pelo devedor: o operador usa o mesmo simulador do portal, com os limites da política, e **envia uma proposta**. O acordo só nasce quando o devedor aceita no portal (RF4.8); o aceite dele é a prova. Pedir exceção: Fase 2.
- RF7.5 Busca global de devedor por nome, CPF parcial, contrato ou telefone.
- RF7.6 Ações em lote: reatribuir devedores, pausar régua (depois do MVP).
- RF7.7 **Registrar pagamento fora do Quita** (a família pagou na secretaria): o gestor, na ficha, com nota obrigatória. A dívida fica quitada, e a proposta aberta, se houver, se encerra.

**RN**
- RN7.1 Distribuição da fila configurável: rodízio, por faixa de atraso ou por valor (estratégias plugáveis).
- RN7.2 Dois operadores não trabalham o mesmo devedor ao mesmo tempo: abrir a ficha "reserva" o devedor por 15 min, e o outro vê quem está atendendo e até quando.
- RN7.3 Promessa de pagamento vencida volta o devedor para o topo da fila.
- RN7.4 CPF aparece mascarado (`***.456.789-**`) para o operador, exceto com permissão. No MVP, sempre mascarado: a permissão chega com a auditoria (F17).
- RN7.5 Acordos e valor recuperado contam para o operador que tinha o devedor na fila quando o acordo nasceu; acordos sem operador (fechados no portal por quem não estava em fila nenhuma) contam só no total da credora.
- RN7.6 Registrar pagamento fora do Quita é só do gestor, porque zera uma dívida sem dinheiro passar pelo Quita. Não vale com acordo vivo: nesse caso, quem quita a dívida é o acordo. Não conta como valor recuperado.

---

### M8. Régua de cobrança e notificações

**RF**
- RF8.1 Gestor monta a régua: passos por dia relativo ao vencimento (D-3 lembrete, D+1 e-mail, D+5 SMS, D+15 oferta especial...).
- RF8.2 Modelos de mensagem com variáveis (`{nome}`, `{valor}`, `{link}`), com pré-visualização.
- RF8.3 Envio simulado (caixa de saída visível no sistema, sem disparar de verdade).
- RF8.4 Notificações internas no backoffice (exceção para aprovar, pagamento conciliado). No MVP, só as que chegam em tempo real durante a sessão, sem histórico; a lista guardada entra com a régua (F16).

**RN**
- RN8.1 Nada de contato fora de 8h–20h nem aos domingos (boa prática do mercado).
- RN8.2 Devedor com acordo ativo, contestação ou opt-out sai da régua.
- RN8.3 No máximo 1 contato por canal por dia.

---

### M9. Painel analítico

**RF**
- RF9.1 Indicadores: valor recuperado, taxa de recuperação, acordos ativos e quebrados, ticket médio.
- RF9.2 Gráficos: recuperação no tempo, aging da carteira, funil (devedores → simulação → proposta → acordo → quitado), ranking de operadores.
- RF9.3 Filtros combináveis (período e operador; o operador só para o gestor) refletidos na URL (link compartilhável). O card de aging já mostra o valor por faixa; o filtro por faixa e a comparação por safra (mês em que a dívida entrou no Quita) são da Fase 3 (F21).
- RF9.4 Exportar o relatório (CSV no MVP; PDF na F21).

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
- No MVP, o admin da plataforma preenche nome de exibição, logo (PNG ou WebP, até 256 KB; SVG recusado), cor de assinatura e contato no cadastro da credora (RF1.1), e o portal já usa esses dados. O editor do gestor (RF11.1 e RF11.3) fica para a Fase 2 (F18). Termos e privacidade não são da credora: são sempre os do Quita (RN4.8).

**RN**
- RN11.1 O sistema recusa combinações de cor sem contraste mínimo (WCAG AA). Vale já no MVP, no cadastro da cor pelo admin.
- RN11.2 A Credora informa só a cor do tema claro; o sistema calcula a versão do tema escuro (mesmo matiz, luminosidade ajustada até passar no AA). Sobrescrever a cor escura à mão: a definir (Fase 2).

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

- Acordo de várias dívidas: Fase 2 (RN5.0).
- Boleto além do Pix: depois do MVP.
- "Meu Quita": visão única das credoras em que o devedor tem pendências, com consentimento e base legal própria. Depois do MVP (RN4.6).
- Papel só de leitura (sócio, contador): ideia futura, sem funcionalidade planejada (RN1.2).

Já decididas: pagamento depois da quebra (RN5.6: sem crédito nem estorno no MVP); baixa de dívida paga fora do Quita (RF7.7); só Pix no MVP (RF4.5); mensageria (eventos dentro da aplicação, ADR 0003); chat na Fase 3 (F20).
