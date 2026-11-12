# Auditoria de consistência: requisitos × telas × HLD × LLDs

2026-11-11 · Status: **aplicada** · 2026-11-12: D2, M5 e N6 decididos; I2, A5, N1 e P2 decididos na entrevista e aplicados (seção 6); Devedor com várias Credoras decidido (seção 7); revisão conservadora feita e linha de base em `docs/review/mvp-baseline.md`

Cruzamento de `docs/foundation/business-requirements.md`, `docs/roadmap.md`, `docs/hld.md`, os três LLDs (`api`, `database`, `backoffice`, `portal`), `design/ux-writing.md` e os 25 prompts de tela (`design/prompts/`). Cada achado diz **onde** está a diferença, **o que** propomos e **até quando** decidir (a funcionalidade do roadmap que precisa da resposta). Em 2026-11-12, tudo foi aplicado nos documentos de origem. O ponto de partida para programar é `docs/review/mvp-baseline.md`, que compila escopo, regras, decisões e o impacto no modelo de dados.

**Legenda do tipo:** 🔴 decisão de produto (sua) · 🟠 lacuna de contrato (rota, tabela ou evento faltando) · 🟡 texto ou tela desalinhada (correção de documento).

---

## 1. Marca da Credora: logo, cor e contato

### O que existe hoje

- A P01 mostra **logo, nome, cor de assinatura e contato** (telefone e e-mail) da Credora; a P09 mostra "Fale com a Escola Horizonte (contato)"; a P02 usa o logo no cabeçalho.
- O LLD do portal (seção 7) diz: _"No MVP, só logo e cor de assinatura vindos do cadastro; o editor de marca é da Fase 2."_
- Mas o cadastro **não tem esses campos**: `identity.creditor` só tem `legal_name`, `document`, `slug`, `kind`, `plan`, `status` (LLD do banco, 5.1), e o formulário da B13 não pede logo, cor nem contato.
- Não existe rota pública para o portal buscar a Credora pelo slug (o índice de rotas da API só tem `GET/POST /creditors`, para o admin).
- Não existe decisão de **onde guardar arquivo** (a mesma lacuna aparece no anexo da Contestação, LLD do portal, seção 13).
- O white-label completo (editor, pré-visualização, contraste AA) é a F18, Fase 2.

**Resumo:** a tela promete, o LLD do portal aceita, mas o banco, a API e o cadastro não entregam. É um buraco no MVP.

### Proposta

| Peça                                 | Proposta                                                                                                                                                                                            | Por quê                                                                                                                                                                                                             |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Quem cadastra no MVP                 | O **admin da plataforma**, no cadastro da Credora (B13): nome de exibição, logo (opcional), cor de assinatura (opcional), e-mail e telefone de atendimento                                          | É onboarding: o time do Quita configura a Credora nova. O editor do próprio Gestor, com pré-visualização ao vivo, continua na F18                                                                                   |
| Colunas novas em `identity.creditor` | `display_name`, `brand_color` (hex do tema claro), `support_email`, `support_phone`, `logo_version`                                                                                                 | A cor escura é calculada (RN11.2), não gravada                                                                                                                                                                      |
| Onde fica o logo                     | Tabela `identity.creditor_logo` (`creditor_id`, `content_type`, `bytes`, `sha256`, `updated_at`), no próprio PostgreSQL                                                                             | Zero serviço novo e zero custo (ADR 0007). Um logo pequeno no banco é aceitável; um serviço de arquivos (Vercel Blob, Cloudflare R2) fica para quando houver anexos de Contestação (F19), e a troca é só no adapter |
| Limites do arquivo                   | PNG ou WebP, até 256 KB, até 1024 px; **SVG recusado**                                                                                                                                              | SVG pode carregar script (XSS); PNG/WebP cobrem logo                                                                                                                                                                |
| Rotas                                | `GET /api/v1/public/creditors/{slug}` (nome, cor clara e escura, contato, `logoUrl`) e `GET /api/v1/public/creditors/{slug}/logo/{sha256}` com `Cache-Control: public, max-age=31536000, immutable` | O hash na URL deixa o cache eterno: logo novo, URL nova                                                                                                                                                             |
| Validação da cor                     | Recusar cor sem contraste AA com o texto do botão (RN11.1) já no MVP, na API                                                                                                                        | Sem isso, uma Credora pode deixar o botão principal ilegível                                                                                                                                                        |
| Sem logo                             | Iniciais num círculo + tema padrão (já previsto na P01, estado 2)                                                                                                                                   | —                                                                                                                                                                                                                   |
| Contato da Credora                   | Rodapé da P01 e ajuda da P09 leem `support_email` e `support_phone`                                                                                                                                 | Hoje não há de onde ler                                                                                                                                                                                             |

**Decidir até:** F03 (o cadastro da Credora) e F07 (a P01). **Muda:** LLD do banco 5.1, LLD da API (rotas, seção 7), LLD do portal (seção 7), prompt B13, roadmap (F03 fica um pouco maior).

---

## 2. Importação de Carteira

### 2.1 O modelo em inglês está errado

O LLD da API (5.9) fixou as colunas em inglês (`document;name;email;phone;contract_number;description;principal_amount;original_due_date`), provavelmente herdando a regra "tabelas e colunas em inglês" do banco. Essa regra é do **código**, não do produto: o arquivo é do Gestor, e a interface é toda em pt-BR (requisitos, seção 6). Concordo com você: está errado.

**Proposta:** cabeçalho do modelo em português, e a API traduz para o nome interno.

| Coluna do modelo | Obrigatória  | Formato                      | Campo interno       |
| ---------------- | ------------ | ---------------------------- | ------------------- |
| `CPF/CNPJ`       | sim          | com ou sem pontuação         | `document`          |
| `Nome`           | sim          | —                            | `name`              |
| `E-mail`         | uma das duas | —                            | `email`             |
| `Celular`        | uma das duas | com DDD                      | `phone`             |
| `Contrato`       | sim          | texto                        | `contract_number`   |
| `Descrição`      | não          | ex.: "Mensalidade de agosto" | `description`       |
| `Valor original` | sim          | `1.000,00` ou `1000,00`      | `principal_amount`  |
| `Vencimento`     | sim          | `dd/mm/aaaa`                 | `original_due_date` |

- **Cabeçalho tolerante:** compara sem acento, sem maiúscula e sem espaço extra (`vencimento`, `VENCIMENTO`, `Data de vencimento` não; só os nomes do modelo e uma lista curta de sinônimos, como `CPF`, `CNPJ`, `Documento`).
- **E-mail ou celular obrigatório:** hoje nenhum dos dois é exigido, mas o acesso do Devedor depende de receber o código (P02/P03). Uma Dívida sem contato nunca chega ao portal (achado 3.2).
- **O arquivo que o Excel salva:** o Excel em pt-BR salva "CSV" com `;` e na codificação **Windows-1252**, não UTF-8 (só a opção "CSV UTF-8" salva em UTF-8). O LLD exige UTF-8: na prática, todo acento viraria lixo. Proposta: aceitar UTF-8 (com ou sem BOM) e cair para Windows-1252 quando o arquivo não for UTF-8 válido.
- **O modelo para baixar:** um `.csv` com o cabeçalho e **uma linha de exemplo** (a Ana), mais um texto curto na B07 explicando cada coluna. Um `.xlsx` também é aceitável como modelo, mas o envio continua CSV no MVP.

### 2.2 "Não era para tirar a planilha da vida dela?"

A planilha que o Quita tira da vida da Credora é a **planilha de trabalho**: quem ligou para quem, quem prometeu pagar, qual desconto deu, quem quebrou o acordo, quanto entrou no mês. Isso hoje vive na planilha e no WhatsApp, e passa a viver no Quita.

A **origem** das dívidas é outra coisa: elas nascem no sistema da escola, da clínica ou da academia (o ERP, o sistema acadêmico, o financeiro). O Quita não emite mensalidade; ele recebe as que venceram. Por isso a importação existe, e ela é uma **ponte**, não um retrabalho: a Credora exporta do sistema dela, uma vez por mês, e solta no Quita. Ninguém digita mil linhas.

O que falta para ficar redondo:

| Necessidade                                                        | Proposta                                                                                                                                                                                                 | Quando                                                                                                     |
| ------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Uma dívida avulsa (um aluno novo, um caso que chegou por telefone) | **Cadastro manual de Dívida** na busca de Devedores (B04 → "Nova dívida"): o mesmo formulário de uma linha do modelo, com a **mesma validação** da importação (um só código de validação no `portfolio`) | MVP, junto da F05 (P, cabe em 1 dia). Rota `POST /debts`, que cria ou reaproveita o Devedor pelo documento |
| O arquivo do sistema dela tem outras colunas                       | **Mapeamento de colunas** na pré-visualização (RF2.2): ela diz qual coluna é qual, uma vez, e o Quita lembra                                                                                             | Fase 2 (já previsto no LLD da API, seção 14). No MVP, o modelo fixo                                        |
| Nunca mais exportar arquivo                                        | Integração por **API** (o sistema dela envia as dívidas) ou conectores com ERPs                                                                                                                          | Fase 3 ou pós-lançamento, quando houver cliente pedindo                                                    |

### 2.3 Mil linhas, metade com erro: como fica

O desenho atual (B07, B08, LLD da API 5.9) já processa em lotes, não derruba o lote por causa de uma linha e entrega o relatório de erros em CSV. O que falta é o **ciclo de correção**: hoje ela recebe 500 erros e não tem um jeito simples de corrigir e reenviar. Proposta:

1. **Validar no navegador antes de enviar.** A pré-visualização (B07) já lê o arquivo no navegador; ela passa a validar **o arquivo inteiro** num Web Worker (sem travar a tela), com as mesmas regras de formato da API. Antes de enviar, ela já vê "1.000 linhas · 500 com problema". A API continua sendo a fonte da verdade (duplicidade e Acordo vivo só ela sabe).
2. **Resumo por tipo de erro primeiro, linhas depois.** Em vez de uma lista de 500 linhas, um resumo: "312 · CPF inválido", "150 · Vencimento em formato errado", "38 · Sem e-mail e sem celular". Clicar num tipo filtra a tabela (B08 já tem o filtro). Dentro de cada tipo, ordem pela linha do arquivo.
3. **O relatório é o próprio arquivo, corrigível.** O CSV de erros devolve as **linhas originais** com uma coluna `Erro` no fim, no mesmo formato do modelo. Ela corrige ali mesmo e envia **esse** arquivo de volta. As linhas certas já entraram; a duplicidade (RN2.2) garante que nada é criado duas vezes.
4. **Arquivo errado de verdade para cedo.** Se o primeiro lote tiver mais de 90% das linhas com erro, a importação para como `failed` com uma explicação ("parece que as colunas estão em outra ordem: confira o cabeçalho com o modelo"), em vez de gerar milhares de erros iguais. Valor como configuração: `IMPORT_EARLY_FAIL_RATE`.
5. **Várias falhas na mesma linha** aparecem todas de uma vez (a `import_row_error` já permite mais de uma linha por número de linha), para ela não corrigir uma coisa e descobrir a próxima no envio seguinte.

**Decidir até:** F04. **Muda:** LLD da API (5.9, seção 6, códigos de erro), LLD do banco (sem mudança de forma), prompts B07 e B08, `ux-writing.md` (B07, B08).

### 2.4 Outras lacunas da importação

| #   | Tipo | Onde               | Problema                                                                                                                                                | Proposta                                                                                                                                                                                  | Decisão                                                               |
| --- | ---- | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| I1  | 🟠   | RN2.2, LLD API 5.9 | A regra de duplicidade fala da **Dívida**; nada diz o que acontece com o **Devedor** reimportado com e-mail ou celular novo                             | O Devedor é atualizado com os dados mais recentes não vazios (uma célula vazia não apaga o que já existe)                                                                                 |
| I2  | 🔴   | Glossário, B14     | "Carteira" é "um lote importado", mas uma Dívida reimportada troca de `portfolio_import_id`. O filtro "Carteira" do painel fica sem significado estável | Carteira = o arquivo da importação, e a Dívida guarda **a primeira** importação que a criou (`portfolio_import_id` nunca muda). Ou tirar o filtro "Carteira" do MVP (ele não está na F14) | Não entendi, me entrevista nessa parte e me explica pra gente decidir · decidido e aplicado (2026-11-12) |
| I3  | 🟡   | B07, LLD API 5.9   | Colunas e textos em inglês na tela                                                                                                                      | Atualizar com o modelo em português (2.1)                                                                                                                                                 |
| I4  | 🟠   | LLD API 5.9        | Dívida que **sumiu** do arquivo do mês (a família pagou na secretaria) continua aberta no Quita                                                         | Fora do MVP: a importação não cancela nada. Registrar como questão: "baixa de dívida paga fora do Quita" (manual na ficha, Fase 2)                                                        | resolvido pelo N1: "Registrar pagamento fora do Quita", do Gestor, no MVP (2026-11-12) |

---

## 3. Demais inconsistências, por frente

### 3.1 Acesso (portal e backoffice)

| #   | Tipo | Onde                            | Problema                                                                                                                                                                                                          | Proposta                                                                                                                                                                                                    | Decidir até                                                     |
| --- | ---- | ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| A1  | 🟠   | P03 × LLD API 5.7               | A P03 mostra "Enviamos para a\*\*\*@gmail.com e (11) 9\*\*\*\*-4321", mas a API responde **sempre igual**, exista ou não o CPF (proteção contra enumeração). Mostrar o contato mascarado revela que a pessoa deve | Texto neutro: "Se o seu CPF tiver cadastro na Escola Horizonte, enviamos um código para o e-mail e o celular informados por ela." Mudar prompt P03 e `ux-writing.md`                                        | F07                                                             |
| A2  | 🟠   | P01, P02, LLD API (rotas)       | O portal precisa da Credora pelo slug (nome, marca, contato) e não há rota pública                                                                                                                                | `GET /public/creditors/{slug}` (achado 1)                                                                                                                                                                   | F07                                                             |
| A3  | 🟠   | B01, RF1.3 × LLD API, LLD banco | "Esqueci minha senha" está na tela e no requisito, mas não há rota nem tabela                                                                                                                                     | `POST /auth/password-resets` (resposta sempre igual) e `POST /auth/password-resets/{token}`, tabela `identity.password_reset` (hash, validade, uso único), e-mail na caixa de saída. Ou tirar o link do MVP | F02                                                             |
| A4  | 🟠   | B12 × LLD API                   | A B12 tem "reenviar convite", "mudar papel" e "desativar", sem rota                                                                                                                                               | `POST /invitations/{id}/resend`, `PATCH /users/{id}` (papel, status). Desativar revoga os refresh tokens do usuário                                                                                         | F03                                                             |
| A5  | 🔴   | RF1.2, B12, LLD backoffice 5    | O papel **auditor** (só leitura) aparece no requisito, no banco e na B12, mas não na tabela de rotas e papéis do backoffice nem na F03                                                                            | Decidir: auditor entra no MVP (lê tudo, não muda nada; rotas `GET` liberadas) ou sai da B12 até a F17                                                                                                       | F03 Cara, não entendi tbem, me explica e entrevista pra decidir · decidido e aplicado (2026-11-12) |
| A6  | 🟡   | RF1.4                           | "Link mágico" pela régua: a régua é Fase 2 e o link não aparece em nenhum LLD                                                                                                                                     | Marcar no requisito como Fase 2 (F16)                                                                                                                                                                       | —                                                               |

### 3.2 Devedor e contato

| #   | Tipo | Onde                   | Problema                                                                                                     | Proposta                                                                                                | Decidir até                             |
| --- | ---- | ---------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| D1  | 🟠   | LLD API 5.9 × P02      | Um Devedor sem e-mail e sem celular nunca recebe o código                                                    | Importação e cadastro manual exigem pelo menos um dos dois (2.1)                                        | F04                                     |
| D2  | 🔴   | P04 × modelo           | Ana tem **duas** Dívidas; o Acordo é sempre de uma Dívida só. No mercado é comum juntar várias num acordo só | MVP: uma Dívida por Acordo (já é o modelo). Registrar "acordo de várias Dívidas" como questão da Fase 2 | F08 Vamos no MVP, uma dívida por acordo |
| D3  | 🟡   | B04 × LLD banco 6, F05 | A busca por **telefone** está no requisito (RF7.5) e na B04, mas não há índice e a F05 não cita              | Incluir telefone na F05, com índice `debtor (tenant_id, phone)` (só dígitos)                            | F05                                     |

### 3.3 Negociação e Acordo

| #   | Tipo | Onde                               | Problema                                                                                                                                                                                              | Proposta                                                                                                                                                                                                                                                                                                                         | Decidir até                                                                                                                                                                                                                                                                                                                                                                                                     |
| --- | ---- | ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| N1  | 🔴   | B06 × LLD API 4 e rotas            | O Operador "cria o acordo" pelo telefone (B06), mas não está escrito se a Ana precisa **confirmar** esse acordo. Sem o aceite dela, é um compromisso que ela não assinou                              | Proposta: o Operador cria a **Proposta**; a Ana recebe o link e confirma no portal (P07), e só então nasce o Acordo. A B06 vira "Enviar proposta à Ana". Exige rota `GET /debtor/proposals/{id}` e `POST /debtor/proposals/{id}/accept`. Alternativa mais simples: o aceite por telefone vale, e o registro da ligação é a prova | F12 Entrevista pra decidir, mas isso muda alguma coisa? Vamos supor que o operador criou o acordo por telefone, ele vai enviar a proposta de qualquer jeito que vai servir como uma confirmação por parte da Ana. Ou seja, independente de como o acordo foi criado, o processo sempre vai ser enviar a proposta pra ana. Se a Ana pagar por fora do app, remove ela da lista de devedores manualmente, simples · decidido e aplicado (2026-11-12) |
| N2  | 🟠   | LLD API 3 × rotas                  | O `payment` escuta `AgreementCreated` (cobrança automática da Entrada?) e existe a rota `POST /debtor/installments/{id}/charges` (cobrança sob demanda). Não está claro quem cria a primeira cobrança | A cobrança da Entrada nasce com o Acordo (evento). A rota serve para **gerar de novo** um Pix vencido (P08, estado 5)                                                                                                                                                                                                            | F10                                                                                                                                                                                                                                                                                                                                                                                                             |
| N3  | 🟠   | P04 × rotas                        | A P04 lista "Seus acordos", mas só existe `GET /debtor/agreements/{id}`                                                                                                                               | `GET /debtor/agreements` (lista)                                                                                                                                                                                                                                                                                                 | F08                                                                                                                                                                                                                                                                                                                                                                                                             |
| N4  | 🟠   | P09 × LLD                          | "Comprovante para baixar" (Acordo quitado) sem rota nem formato                                                                                                                                       | `GET /debtor/agreements/{id}/receipt` (PDF simples gerado pela API) ou tirar do MVP                                                                                                                                                                                                                                              | F10                                                                                                                                                                                                                                                                                                                                                                                                             |
| N5  | 🟡   | P06 × B09                          | Sem Política publicada, o portal não oferece acordos (B09, estado 3), mas a P06 não tem esse estado                                                                                                   | Estado na P06: "As condições para esta dívida ainda não estão disponíveis. Fale com a Escola Horizonte." e código `NO_PUBLISHED_POLICY` na API                                                                                                                                                                                   | F08                                                                                                                                                                                                                                                                                                                                                                                                             |
| N6  | 🔴   | B10 × B03, B04, pipe `agingBucket` | A B10 deixa **acrescentar e remover Faixas**, mas as pílulas da Fila, da Busca e do painel usam as 5 Faixas fixas                                                                                     | Proposta: Faixas fixas no MVP (as 5 do requisito), só os valores são editáveis. Faixas livres ficam para a F15                                                                                                                                                                                                                   | F06 Aqui eu prefiro que credora tenha liberdade pra criar suas faixas, mas tbem n pode criar 100 faixas. Acho que faz sentido limita até 5 ou que mais estiver alinhado a esse mercado. Ou seja, podemos começar com 5 faixas fixas pré-definidas, mas o operador pode excluir e editar e talvez só até uma faixa, ele que escolhe, mas no max 5                                                                |
| N7  | 🟡   | P07                                | O texto "mais de 10 dias" está fixo, mas a tolerância é por Credora (★)                                                                                                                               | O texto usa `breach_tolerance_days` da Política                                                                                                                                                                                                                                                                                  | F09                                                                                                                                                                                                                                                                                                                                                                                                             |

### 3.4 Pagamentos

| #   | Tipo | Onde                           | Problema                                                                                                                | Proposta                                                                                                                                                | Decidir até                                                                                                                                   |
| --- | ---- | ------------------------------ | ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| P1  | 🟠   | B11 × LLD banco 5.4            | "Cobrança não encontrada": o pagamento sem `charge_id` não tem tenant (o tenant vem da cobrança). Nenhum Gestor o veria | O gateway devolve a `external_reference` com o tenant; sem nenhuma referência, o pagamento vai para uma fila do **admin da plataforma**, não da Credora | F13                                                                                                                                           |
| P2  | 🔴   | RN5.3 (aberta em 4 documentos) | Pagamento depois da Quebra: crédito ou estorno                                                                          | Proposta: vira **crédito** que abate o próximo Acordo da mesma Dívida (sem estorno no MVP, porque o gateway é simulado)                                 | F13 Entrevista, como ele vai pagar depois da quebra se o pix só deve ser gerado dentro do período de atraso? Acho que isso nem deve acontecer · decidido e aplicado (2026-11-12) |

### 3.5 Operador e Fila

| #   | Tipo | Onde                     | Problema                                                                                                                                                                                             | Proposta                                                                                                                                                                          | Decidir até |
| --- | ---- | ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| O1  | 🟠   | B03, B14 × LLD banco 5.6 | "Acordos hoje", "Recuperado hoje" e o painel "só os números dele" precisam de números **por Operador**, mas `operator_performance` é Fase 2. E um Acordo fechado pela Ana no portal não tem Operador | Trazer `operator_performance` para o MVP (F14). Regra: o Acordo conta para o Operador que tinha o Devedor na Fila quando o Acordo nasceu; acordos sem Operador contam só no total | F11         |
| O2  | 🟠   | B05 × LLD API            | "Avisar quando liberar" a reserva do Devedor precisa de um evento (`DebtorLockReleased`) que não existe                                                                                              | Evento no SSE quando a reserva é liberada ou vence                                                                                                                                | F11 · revisto em 2026-11-12: **cortado** do MVP (job, evento e botão); a ficha mostra quem está atendendo e até quando |
| O3  | 🟡   | B05, RN7.4               | O botão "mostrar CPF" depende de uma permissão que não existe no MVP                                                                                                                                 | Marcar no prompt como Fase 2 (F17); no MVP, o CPF é sempre mascarado para o Operador                                                                                              | F11         |

### 3.6 Moldura, painel e admin

| #   | Tipo | Onde               | Problema                                                                                                                  | Proposta                                                                                                                                                       | Decidir até                                                                                                                                                                                                                                                  |
| --- | ---- | ------------------ | ------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| M1  | 🟠   | B02 × LLD banco    | As notificações da moldura ("Pagamento conciliado", "Importação concluída") usam `in_app_notification`, que é Fase 2      | MVP: notificações só do SSE, sem histórico (somem ao recarregar), e o sino mostra as da sessão. A tabela entra na F16                                          | F04                                                                                                                                                                                                                                                          |
| M2  | 🟡   | B14 × roadmap F14  | O prompt desenha funil, conversão e ranking; o roadmap tirou os três do MVP (F21)                                         | Marcar no prompt os blocos da F21; o hi-fi continua mostrando o painel completo como visão de futuro                                                           | F14                                                                                                                                                                                                                                                          |
| M3  | 🟠   | B13 × LLD banco 4  | A coluna "devedores ativos" da lista de Credoras soma dados de **todos** os tenants, e o filtro `@TenantId` impede isso   | Consulta própria do admin, fora do filtro de tenant, só para o papel `platform_admin`, e só a contagem                                                         | F03                                                                                                                                                                                                                                                          |
| M4  | 🟡   | P00 × LLD portal 3 | A demo da landing precisa mostrar a "caixa de saída simulada" (onde o código aparece), mas ela não tem rota em nenhum app | Rota `/demo/inbox` no portal, só no ambiente de demonstração, lendo a caixa de saída da Credora de demo                                                        | F07                                                                                                                                                                                                                                                          |
| M5  | 🔴   | P01, P00           | "Termos e privacidade" do rodapé: os da **Credora** (P01) ou os do **Quita** (P00)?                                       | Rodapé da P01 com os da Credora (link cadastrado) e "Operado por Quita" com os do Quita. Os textos entram com a parte jurídica (decisão de 2026-11-11: depois) | É foda pq a Credora tbem vai ter cadastrar esses termos e talvez nem ela tenha, vamos ter que abrir mais um campo no schema pra enviar uma politica de cada credora. Deixa tudo da Quita mesmo, pode ter alguma coisa especifica dentro do painel do devedor |

---

## 4. O que está consistente (conferido)

- O exemplo da Ana bate em todos os documentos: 1.060,00; 25% à vista = 795,00; 5x = 135,15 + 3 × 191,46 + 191,47 = 901,00; 326,61 pagos depois de 2 parcelas.
- Valores de regra (código de acesso, tolerância, parcela mínima, Pix) iguais entre requisitos, LLD da API, P02, P03, P06, P07 e B10.
- Rotas do portal (LLD portal 3) e do backoffice (LLD backoffice 5) batem com os prompts.
- Máquinas de estado da Dívida, Proposta e Acordo coerentes com as telas (P07 conflito, P09 quebra, B06 conflito).
- Um Acordo vivo por Dívida garantido pelo banco, e a mensagem de conflito desenhada nos dois lados (P07, B06).

## 5. Próximo passo

1. Os itens sem decisão sua (🟠, 🟡 e as propostas das seções 1 e 2) são aplicados nos documentos de origem; cada um ganha "aplicado" na tabela.
2. Os quatro da entrevista (seção 6) foram decididos e aplicados em 2026-11-12.
3. Cada decisão entra no PRD da funcionalidade quando ela começar (a coluna "Decidir até").

## 6. Entrevista: os quatro pontos em aberto

Para cada ponto: o conceito com um exemplo, o que muda no sistema e as perguntas. No fim de cada um, a minha recomendação, para você concordar ou derrubar.

### 6.1 I2 · O que é "Carteira"

**O conceito.** Pense numa pasta de arquivo. Hoje o glossário diz que a Carteira é **o lote de um arquivo** ("a carteira de outubro"). O problema aparece quando a mesma dívida vem em dois arquivos: a mensalidade de agosto da Ana chega no lote de setembro (ainda sem pagar) e de novo no de outubro. Ela é da "carteira de setembro" ou da "de outubro"? Se a cada importação a dívida muda de pasta, um filtro "Carteira: setembro" no painel muda de resultado sozinho, sem ninguém mexer.

No mercado, "carteira" costuma ser **o conjunto inteiro de dívidas de uma credora** ("a carteira da escola tem 1.200 devedores"). O recorte por mês de entrada tem outro nome: **safra** ("a safra de setembro recuperou 18%").

**O que muda:** o filtro "Carteira" do painel (B14) e o texto das telas B07 e B08.

**Perguntas**

1. Quando a Carla diz "a carteira", ela pensa no **arquivo de outubro** ou em **todas as dívidas da escola**?
2. Ela precisa comparar resultados entre meses ("quem entrou em setembro pagou mais que quem entrou em outubro")?
3. Se precisa, o mês certo de uma dívida é o da **primeira** vez que ela chegou ao Quita?

**Recomendação.** Carteira = todas as dívidas da Credora. O lote vira só "Importação" (como já se chama na tela). O filtro "Carteira" sai do painel do MVP; a comparação por **safra** (o mês da primeira importação, que nunca muda) entra na F21.

RESPOSTA: ACEITO A RECOMENDAÇÃO

**Aplicado:** Carteira = todas as Dívidas da Credora; o arquivo é a Importação; `debt.portfolio_import_id` guarda a importação que criou a Dívida e nunca muda; o filtro "Carteira" saiu do painel (B14, RF9.3, contrato `filters` do Web Component); safra (mês de `debt.created_at`) na F21. Glossário e requisitos atualizados.

### 6.2 A5 · O papel "auditor"

**O conceito.** É alguém que **só olha**: entra, vê telas e números, e não consegue mudar nada. Na escola, seria o sócio que quer acompanhar, o contador ou uma auditoria externa. No sistema, é um terceiro papel além de Gestor e Operador.

**O que custa:** cada tela precisa esconder os botões de ação para ele (a diretiva `*hasRole` já existe para isso), a API precisa recusar toda escrita desse papel, e cada teste de permissão ganha mais um caso. Não é muito, mas toca todas as telas.

**Perguntas**

1. Na escola da Ana, existe alguém além da Carla (gestora) e do Bruno (operador) que precisaria ver o sistema **sem mexer**?
2. Essa pessoa precisa estar lá **no lançamento**, ou pode chegar junto com a trilha de auditoria (F17), que é quando "quem viu o quê" passa a ser registrado?
3. O sócio olharia só o **painel**, ou também a ficha de cada devedor (dados pessoais, LGPD)?

**Recomendação.** Sai do MVP: a B12 fica só com Gestor e Operador, e o auditor volta na F17, junto da trilha de auditoria, onde ele faz mais sentido.

RESPOSTA: DE VERDADE, N VEJO A IMPORTANCIA DESSE PAPEL. ACHO QUE PODEMOS REMOVER E TALVEZ PENSAR NO FUTURO

**Aplicado:** o papel saiu do MVP e da lista de papéis (`app_user.role`: `platform_admin`, `manager`, `operator`), de RF1.2, RN1.2, B02, B12 e `ux-writing.md`. "Papel só de leitura" ficou como ideia futura, sem funcionalidade planejada (requisitos, seção 8; roadmap, F17).

### 6.3 N1 · A proposta do Operador

**Sua resposta:** "independente de como o acordo foi criado, o processo sempre vai ser enviar a proposta pra Ana". Concordo, e **muda sim** algumas coisas:

| Antes (desenho atual)                              | Depois (sua regra)                                                                                                       |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| A B06 tem **Criar acordo**: o Acordo nasce na hora | A B06 tem **Enviar proposta à Ana**: nasce uma **Proposta** com validade                                                 |
| A Ana só vê o acordo pronto                        | A Ana recebe um link por e-mail ou SMS, entra com o código e vê a P07 com "Proposta enviada por Bruno, válida até 14/11" |
| Não há rota de proposta para o Devedor             | Rotas `GET /debtor/proposals/{id}` e `POST /debtor/proposals/{id}/accept`                                                |
| O Acordo de telefone não tem o aceite dela         | O Acordo só nasce com o "Li e concordo" dela, e isso é a prova                                                           |

**Perguntas**

1. Enquanto a proposta do Bruno está aberta, a Ana pode **ignorar** e fechar outra condição sozinha no portal? (Recomendo que sim: o primeiro Acordo vale, e a Proposta aberta se encerra.)
2. A proposta vale **48 horas** (o mesmo prazo de hoje)?
3. Sobre "se a Ana pagar por fora, remove manualmente": no MVP, a ficha (B05) ganha **"Registrar pagamento fora do Quita"**, com nota obrigatória, que marca a Dívida como quitada? Isso resolve também o I4 (a dívida paga na secretaria).

**Recomendação.** Sua regra (sempre Proposta) mais o "Registrar pagamento fora do Quita" no MVP, ambos na F12.

RESPOSTA: ACEITO A RECOMENDAÇÃO

**Aplicado:** B06 vira "Enviar proposta à Ana" (`POST /proposals`, `channel = backoffice`, 48 h); a Ana aceita na P07 pelo link (`GET /debtor/proposals/{id}`, `POST /debtor/proposals/{id}/accept`), com o mesmo caso de uso de criar Acordo; uma Proposta aberta por Dívida (novo status `canceled`); o primeiro Acordo vale. "Registrar pagamento fora do Quita" só para o Gestor (`POST /debts/{id}/external-payment`, `ExternalPaymentRecorded`, colunas `settled_externally_*`), recusado com Acordo vivo. F12 passou de P para M.

### 6.4 P2 · Pagamento depois da Quebra

**Sua pergunta:** "como ele vai pagar depois da quebra se o Pix só deve ser gerado dentro do período?" Quase sempre não vai. Mas existem três brechas:

1. **O Pix gerado no último dia:** a 3ª parcela vence em 12/01, e a tolerância vai até 22/01. A Ana gera o Pix em 22/01 às 23:00; ele vale **24 horas**. O job de Quebra roda em 23/01 às 03:00 e quebra o Acordo. Ela paga às 08:00, com um Pix ainda válido.
2. **O aviso atrasado:** ela paga em 22/01 às 23:58, mas o webhook do gateway chega às 00:05 (o banco atrasou, ou o gateway tentou de novo).
3. **Valor diferente ou fora de hora:** qualquer pagamento que chega sem uma parcela aberta.

**Como fechar as três**

- **Brecha 1:** o Pix de uma parcela atrasada vence **no fim da tolerância**, e não 24 horas depois (o que vier primeiro).
- **Brecha 2:** a Quebra olha a **hora do pagamento** (`paid_at`), não a hora em que o aviso chegou. Um pagamento feito até o fim da tolerância desfaz a Quebra.
- **Brecha 3:** o que ainda sobrar vai para a B11 (pagamentos não conciliados), e o Gestor resolve à mão.

**Perguntas**

1. Concorda que o Pix de parcela atrasada vença no fim da tolerância? SIM
2. Um pagamento feito **antes** do fim da tolerância, mas avisado **depois**, desfaz a Quebra? (A alternativa é deixar quebrado e mandar para a B11.) MAS AQUI É FODA, PQ VAI APARECER QUEBRADO PRA ANA, SENDO QUE DEPOIS VAI SER DESFEITO, VAI CONFUDIR USUÁRIO. SE PAGAMENTO FOI FEITO DENTRO DO PERIODO DE TOLERANCIA, O BANCO DEVE REGISTRAR COMO EM PROCESSAMENTO. SÓ QUEBRA SE 1. PAGAMENTO DEPOIS DA TOLERANCIA 2. PAGAMENTO INCOMPLETO
3. Com isso, a pergunta "crédito ou estorno" sai do MVP: o que sobrar é resolvido na B11. Concorda? SIM

**Recomendação.** Sim às três: a questão aberta em 4 documentos deixa de existir no MVP.

**Aplicado:** a Quebra nunca é desfeita. O Pix vale até 24 h ou até o fim do último dia de pagamento (23:59:59), o que vier primeiro; a Quebra roda às 03:00 e antes confere, pela `PaymentApi`, pagamentos conciliados no prazo e avisos ainda não processados. Pagamento incompleto no prazo vai para a B11 e o Acordo quebra; pagamento depois da Quebra vai para a B11, sem crédito nem estorno. A Entrada vencida segue a mesma regra. Novo código `PAYMENT_WINDOW_CLOSED`. A questão saiu de requisitos, brief, HLD, LLDs e roadmap.

## 7. Decisão: Devedor com mais de uma Credora

**A situação.** A Ana deve para a escola e para a academia, e as duas usam o Quita. No banco, ela é **dois** Devedores, um em cada Credora (o `debtor` é único por Credora e documento). Cada Credora manda o próprio link (`/c/escola-horizonte`, `/c/academia-pulso`).

**Decisão para o MVP: uma Credora por vez.** A Ana entra pelo link de uma Credora e vê só as dívidas dela. Para ver a academia, ela entra pelo link da academia, com outro código.

**Por quê**

- **Privacidade (LGPD).** Cada Credora é dona dos dados dos devedores dela. Mostrar a dívida da academia dentro do portal da escola, ou numa tela única do Quita, faz o Quita juntar dados de empresas diferentes sobre a mesma pessoa. Isso exige uma base legal própria e o consentimento da Ana. É o que os birôs (Serasa Limpa Nome) fazem, e é um produto à parte.
- **Marca.** O portal é da Credora (white-label). Uma tela com várias marcas misturadas quebra essa promessa.
- **Modelo de dados.** Hoje o isolamento por tenant é total. Uma visão entre Credoras precisaria de uma identidade global do Devedor, fora de qualquer tenant.

**O que entra no MVP para isso funcionar direito**

- A sessão do Devedor vale **para uma Credora só** (o token já leva o `tid`). Se a Ana, logada na escola, abrir o link da academia, o portal a manda para o acesso da academia, sem erro e sem misturar nada.
- Cookies de sessão separados por Credora (o caminho do cookie inclui o slug), para as duas sessões conviverem no mesmo navegador.

**Depois do MVP (registrado como questão):** um "Meu Quita" opcional, em que a Ana, com o próprio consentimento, vê em que Credoras tem pendências e entra em cada uma. Exige a base legal acima e vira uma funcionalidade nova no backlog.
