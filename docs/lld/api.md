# LLD: API (`quita-backend-api`)

2026-11-10 · helloWorldRuan · Status: aprovado

Como a API funciona por dentro: estrutura dos módulos, regras de negócio com números, máquinas de estado, contrato REST, segurança, jobs e o gateway fake. As partes e como conversam estão no HLD; o banco, em `docs/lld/database.md`; o vocabulário, em `GLOSSARY.md`.

## Onde mora cada fato

| Fato | Dono |
| --- | --- |
| Rotas, corpos e respostas | O `openapi.json` gerado e versionado no `quita-backend-api` (ADR 0005), assim que existir. Até lá, o índice de rotas planejadas fica aqui. |
| Convenções de toda rota (formato, erros, paginação, idempotência) | Este documento, seção 7 |
| Valores de regra | Este documento, seção 6 ("Valores e configuração") |
| Forma das tabelas | `docs/lld/database.md` → migrações |
| Variáveis de ambiente | Este documento, seção 12, até existir o `.env.example` do repo |

## 1. Stack

| Peça | Escolha | Por quê |
| --- | --- | --- |
| Linguagem | Java 25 (LTS) | Versão LTS atual; records, pattern matching, virtual threads |
| Framework | Spring Boot, linha 4.x atual | Versão exata fixada no walking skeleton |
| Web | Spring Web MVC com virtual threads | ADR 0009 |
| Persistência | Spring Data JPA + Hibernate | `@TenantId`, lock otimista com `@Version`, UUID v7 nativo |
| Migrações | Flyway | `docs/lld/database.md`, seção "Migrações" |
| Módulos | Spring Modulith | Verificação de fronteiras, eventos com registro de publicação, testes por módulo |
| Segurança | Spring Security + OAuth2 Resource Server (validação de JWT) + `JwtEncoder` (emissão) | Sem biblioteca de JWT de terceiros |
| Senhas | Argon2id (`Argon2PasswordEncoder`) | Recomendação atual da OWASP |
| Contrato | springdoc-openapi | Gera o `openapi.json` do código |
| Validação | Bean Validation | Validação de entrada nos DTOs |
| Limite de taxa | Bucket4j, em memória | Uma instância só; sem Redis |
| Observabilidade | Actuator + Micrometer + logs JSON (encoder do Logback) | HLD, "Observabilidade" |
| Boilerplate | Lombok | Padrão de mercado; regras de uso abaixo |
| Mapeamento | MapStruct | Padrão de mercado para entidade ↔ DTO, gerado em tempo de compilação |
| Testes | JUnit 5, AssertJ, Mockito, Testcontainers (PostgreSQL), Spring Modulith Test, MockMvc | Seção 11 |
| Build | Maven, um módulo só | Os módulos de domínio são pacotes, verificados pelo Modulith |

**Regras de uso do Lombok** (o que um revisor de mercado cobra):

| Onde | Usar | Evitar, e por quê |
| --- | --- | --- |
| Entidades JPA (agregados) | `@Getter`, `@NoArgsConstructor(access = PROTECTED)` | `@Data`, `@Setter`, `@EqualsAndHashCode`, `@ToString` sem exclusões: setters furam as regras do agregado, e `equals`/`toString` gerados disparam carregamento preguiçoso e laços em relações JPA |
| Serviços, casos de uso, controllers, adapters | `@RequiredArgsConstructor` (injeção por construtor com campos `final`), `@Slf4j` | `@Autowired` em campo |
| Value objects e objetos de teste | `@Builder`, `@Value` quando não for `record` | `@Builder` em entidade JPA |
| DTOs de entrada e saída | `record` do Java | Lombok, porque o `record` já resolve |

## 2. Arquitetura interna: hexagonal por módulo

Cada módulo segue **Ports and Adapters** (arquitetura hexagonal), de forma pragmática (ADR 0010):

- **Domínio no centro:** agregados, value objects e regras, sem depender de web, de mensageria nem de outro módulo.
- **Casos de uso** (camada de aplicação): uma classe por caso de uso (`CreateAgreementUseCase`), com um método `execute`. Ela abre a transação, carrega o agregado, chama o domínio e salva.
- **Portas de saída:** interfaces que o domínio e os casos de uso precisam do mundo de fora (`AgreementRepository`, `PaymentGatewayPort`, `DebtLookupPort`). Ficam no núcleo.
- **Adapters:** a implementação de cada porta. De entrada: controllers REST, ouvintes de eventos, jobs. De saída: persistência JPA, cliente HTTP do gateway, chamada à interface pública de outro módulo.
- **Concessão pragmática:** as entidades de domínio levam as anotações do JPA, em vez de existir um modelo de persistência separado. Isso evita duplicar cada classe, e o domínio continua sem setters e com as regras dentro dele.

**Estrutura de pacotes**

Cada pacote de primeiro nível abaixo de `com.quita` é um módulo do Spring Modulith. Só o que fica no pacote raiz do módulo e nos pacotes marcados como interface nomeada é visível para os outros.

```
com.quita
  QuitaApplication.java
  shared/                       ← núcleo compartilhado (sem regra de negócio)
    money/                        Money, Rate, Rounding
    tenant/                       TenantContext, TenantId
    web/                          Problem Details, cursor de paginação, idempotência
    time/                         Clock da aplicação (fuso de São Paulo)
  negotiation/
    NegotiationApi.java         ← porta pública do módulo para os outros módulos
    events/                     ← eventos publicados (interface nomeada)
    internal/
      domain/
        model/                    Agreement, Installment, Proposal, NegotiationPolicy (agregados e VOs)
        service/                  SimulationCalculator, DiscountCalculator (regras sem estado)
        port/                     AgreementRepository, DebtLookupPort (portas de saída)
      application/
        usecase/                  SimulateNegotiationUseCase, CreateAgreementUseCase, BreachOverdueAgreementsUseCase
        command/                  CreateAgreementCommand (entrada dos casos de uso)
      adapter/
        in/web/                   AgreementController, DTOs (records), mappers MapStruct
        in/event/                 InstallmentPaidListener
        in/scheduler/             BreachJob
        out/persistence/          JpaAgreementRepositoryAdapter + AgreementJpaRepository (Spring Data)
        out/portfolio/            DebtLookupAdapter (chama a PortfolioApi)
  identity/  portfolio/  payment/  collection/
  notification/  analytics/  audit/  fakegateway/
                                ← mesma forma interna
```

**Regras de dependência dentro de um módulo**

```mermaid
flowchart LR
  in[adapter/in] -- "chama" --> uc[application]
  uc -- "usa" --> dom[domain]
  uc -- "usa (interface)" --> port[domain/port]
  out[adapter/out] -- "implementa" --> port
```

As setas só apontam para dentro: o domínio não conhece ninguém; os adapters conhecem o núcleo, nunca o contrário. Verificado por teste de arquitetura (ArchUnit) junto com a verificação do Modulith.

**Padrões de projeto e onde aparecem**

| Padrão | Onde | Para quê |
| --- | --- | --- |
| Strategy | `CorrectionStrategy` (correção da Dívida), `QueuePriorityStrategy` (Fila) | Trocar o algoritmo por Credora sem `if` espalhado |
| Factory | `CorrectionStrategyFactory` (escolhe a estratégia pelo tipo de Credora), `ChargeFactory` (Pix ou boleto) | Centralizar a criação do objeto certo |
| Observer | Eventos de domínio entre módulos | Um módulo reage sem o outro saber que ele existe |
| State | Transições do Acordo, da Proposta e da Dívida como métodos do agregado | Recusar transição inválida num lugar só |
| Adapter | `PaymentGatewayPort` → cliente HTTP do gateway fake | Trocar o gateway fake por um real mudando só o adapter |
| Repository | Portas de persistência | O domínio não conhece JPA |
| Specification | Filtros combináveis da busca de Dívidas e Devedores (`Specification` do Spring Data) | Montar consultas dinâmicas sem concatenar SQL |
| Builder | Value objects e dados de teste (Lombok `@Builder`) | Criar objetos complexos legíveis nos testes |
| Value Object | `Money`, `Rate`, `Document` (CPF/CNPJ), `TenantId` | Validar uma vez e nunca circular dado inválido |

**Dependências permitidas entre módulos**

```mermaid
flowchart LR
  negotiation -- "consulta Dívida (PortfolioApi)" --> portfolio
  collection -- "consulta Devedor e Dívidas (PortfolioApi)" --> portfolio
  payment -- "escuta AgreementCreated" --> negotiation
  negotiation -- "escuta InstallmentPaid" --> payment
  portfolio -- "escuta eventos do Acordo" --> negotiation
  collection -- "escuta eventos do Acordo" --> negotiation
  notification -- "escuta eventos" --> identity
  analytics -- "escuta eventos" --> negotiation
  analytics -- "escuta eventos" --> payment
  audit -- "escuta eventos" --> identity
```

Seta: "depende de", com o tipo de dependência. Todos os módulos dependem de `shared` e de `identity` (contexto de tenant e usuário), omitidos no diagrama. Ciclos são proibidos e verificados pelo Modulith: quando dois módulos precisam conversar nos dois sentidos, um dos sentidos é por evento. `fakegateway` não depende de ninguém e só fala com a API por HTTP.

## 3. Módulos

| Módulo | Agregados | Publica | Escuta |
| --- | --- | --- | --- |
| `identity` | Creditor, AppUser, RefreshToken, DebtorAccessCode | `CreditorCreated`, `UserInvited`, `AccessCodeRequested` | – |
| `portfolio` | PortfolioImport, Debtor, Debt | `PortfolioImportProgressed`, `PortfolioImportFinished`, `DebtImported` | `ProposalCreated`, `ProposalClosed`, `AgreementActivated`, `AgreementSettled`, `AgreementBreached`, `AgreementCanceled` |
| `negotiation` | NegotiationPolicy, Proposal, Agreement (com Installments) | `ProposalCreated`, `ProposalClosed`, `AgreementCreated`, `AgreementActivated`, `AgreementSettled`, `AgreementBreached`, `AgreementCanceled` | `InstallmentPaid` |
| `payment` | Charge, Payment, WebhookEvent | `ChargeIssued`, `InstallmentPaid`, `PaymentUnreconciled` | `AgreementCreated`, `AgreementActivated` |
| `collection` | WorkQueueItem, DebtorLock, Interaction | `PaymentPromiseBroken` | `DebtImported`, `AgreementActivated`, `AgreementBreached` |
| `notification` | OutboxMessage | – | `AccessCodeRequested`, `UserInvited`, `ChargeIssued` |
| `analytics` | modelos de leitura | – | `AgreementActivated`, `AgreementBreached`, `AgreementSettled`, `InstallmentPaid`, `DebtImported` |
| `audit` (Fase 2) | AuditEntry | – | eventos sensíveis de todos os módulos |
| `fakegateway` | FakeCharge | – (webhook HTTP) | – |

- **Eventos são records imutáveis**, com o `tenantId`, o id do agregado, o instante e só os dados que quem escuta precisa.
- **Quem escuta roda depois do commit de quem publicou** (`@ApplicationModuleListener`), numa transação própria. Se falhar, o registro de publicação do Modulith guarda o evento como não processado, e ele é reprocessado na próxima subida ou por um job.
- **Consequência:** entre módulos, a consistência é **eventual**. Exemplo: o Acordo fica `active` antes de a Dívida virar `in_agreement`, por alguns milissegundos.

## 4. Máquinas de estado

**Dívida (`Debt`)**

```mermaid
stateDiagram-v2
  [*] --> open: importada
  open --> negotiating: ProposalCreated
  negotiating --> open: ProposalClosed sem acordo
  negotiating --> in_agreement: AgreementActivated
  negotiating --> open: AgreementCanceled
  in_agreement --> settled: AgreementSettled
  in_agreement --> open: AgreementBreached
  open --> disputed: contestação aberta (Fase 2)
  disputed --> open: contestação rejeitada
  disputed --> canceled: contestação aceita
  settled --> [*]: fim
  canceled --> [*]: fim
```

**Proposta (`Proposal`)**

```mermaid
stateDiagram-v2
  [*] --> approved: criada dentro da Política
  [*] --> pending_approval: criada fora da Política (Fase 2)
  pending_approval --> approved: Gestor aprova
  pending_approval --> rejected: Gestor recusa
  approved --> accepted: Acordo criado
  approved --> expired: passou expires_at
  pending_approval --> expired: passou expires_at
  accepted --> [*]: fim
  rejected --> [*]: fim
  expired --> [*]: fim
```

No MVP, o Devedor cria e aceita na mesma ação: a Proposta nasce `approved` e passa a `accepted` na mesma transação que cria o Acordo.

**Acordo (`Agreement`)**

```mermaid
stateDiagram-v2
  [*] --> awaiting_down_payment: Proposta aceita
  awaiting_down_payment --> active: Entrada paga (InstallmentPaid nº 1)
  awaiting_down_payment --> canceled: Entrada vencida sem pagamento
  active --> settled: última Parcela paga
  active --> breached: Parcela atrasada além da tolerância
  settled --> [*]: fim
  breached --> [*]: fim
  canceled --> [*]: fim
```

Cada transição é um método do agregado (`agreement.activate(...)`, `agreement.breach(...)`) que recusa a transição inválida com uma exceção de domínio. Nenhum código fora do agregado muda o `status` direto.

**Importação (`PortfolioImport`):** `processing → completed | completed_with_errors | failed`.

**Cobrança (`Charge`):** `pending → paid | expired | canceled`.

## 5. Regras de negócio

Cada regra está escrita para virar teste: condição, resultado e borda. Os valores citados pelo nome estão na seção 6.

### 5.1 Dinheiro

- Todo cálculo usa `BigDecimal` através do value object `Money`, com escala intermediária de 10 casas e arredondamento `HALF_EVEN` (o "arredondamento do banqueiro", que não puxa para cima em média). O resultado final fica com 2 casas.
- `Money` nunca é negativo e nunca soma moedas diferentes (só BRL).

### 5.2 Valor atualizado

Calculado na data de referência (hoje, no fuso de São Paulo):

- `dias de atraso = data de referência − original_due_date` (0 se ainda não venceu).
- `base = principal_amount − amount_paid`.
- `multa = base × LATE_FEE_RATE`, só se dias de atraso > 0.
- `juros = base × MONTHLY_INTEREST_RATE × dias de atraso ÷ 30` (juros simples, pró-rata dia).
- `correção = estratégia de correção da Credora` (Strategy):
  - `NoCorrectionStrategy`: zero. Padrão das Credoras do tipo escola.
  - `FixedIndexCorrectionStrategy`: `base × SIMULATED_MONTHLY_INDEX × dias ÷ 30`.
- `valor atualizado = base + multa + juros + correção`.

**Exemplo de teste** (a Ana): principal 1.000,00, nada pago, 120 dias, escola → multa 20,00, juros 40,00, correção 0 → **1.060,00**.

### 5.3 Simulação

Entradas: a Dívida, o número de Parcelas `n` (1 = à vista) e, opcionalmente, o valor de Entrada desejado.

1. A Faixa de atraso escolhe a `policy_bucket_rule` da Política publicada.
2. `n` precisa estar entre 1 e `max_installments`; fora disso, erro `INSTALLMENTS_OUT_OF_POLICY`.
3. `desconto aplicado = max_discount_rate × (max_installments − n + 1) ÷ max_installments`.
4. `valor negociado = valor atualizado × (1 − desconto aplicado)`.
5. `Entrada = max(valor negociado × min_down_payment_rate, Entrada desejada)`. À vista, a Entrada é o valor inteiro.
6. `restante = valor negociado − Entrada`, dividido em `n − 1` Parcelas iguais, truncadas em 2 casas; o resíduo vai para a última.
7. Cada Parcela (exceto a Entrada) precisa ser ≥ `min_installment_amount`; se não for, o `n` máximo permitido é recalculado e devolvido como `maxInstallmentsAllowed`, junto com o erro `INSTALLMENT_BELOW_MINIMUM`.

**Exemplo de teste:** 1.060,00, faixa 91–180 (25%, 10 parcelas, 15%), `n = 5` → desconto 15%, negociado 901,00, Entrada 135,15, Parcelas 191,46 + 191,46 + 191,46 + 191,47.

A simulação não grava nada e pode ser chamada quantas vezes for preciso.

### 5.4 Proposta e Acordo

- A Proposta guarda os valores calculados no momento (`updated_amount`, `negotiated_amount`, `down_payment_amount`) e vale até `expires_at = agora + proposal_validity_hours` da Política.
- **Criar o Acordo** (uma transação):
  1. Recalcula a simulação e confere se bate com a Proposta (protege contra mudança de Política entre a simulação e o aceite).
  2. Confere, pela `PortfolioApi`, se a Dívida está `open` ou `negotiating`.
  3. Cria o Acordo `awaiting_down_payment` e as Parcelas.
  4. Exige o cabeçalho `Idempotency-Key`: a mesma chave devolve o mesmo Acordo, sem criar outro.
  5. Dois Acordos vivos para a mesma Dívida batem no índice único parcial; a API devolve 409 `AGREEMENT_ALREADY_EXISTS` (`docs/lld/database.md`, seção 5.3).
- **Vencimentos:** a Entrada vence em `DOWN_PAYMENT_DUE_DAYS` dias; a Parcela `k` vence `k − 1` meses depois da Entrada, no mesmo dia do mês, ou no último dia do mês quando ele não existe (31/01 → 28/02).

### 5.5 Pagamento e conciliação

- **Webhook:** `POST /api/v1/webhooks/payment-gateway`, sem JWT, autenticado por HMAC-SHA256 do corpo cru com `GATEWAY_WEBHOOK_SECRET`, no cabeçalho `X-Gateway-Signature: t=<epoch>,v1=<hex>`. A assinatura cobre `t` + corpo.
  - Assinatura inválida → 401, e o evento é gravado com `signature_valid = false`.
  - `t` mais velho que `WEBHOOK_MAX_AGE` → 401 (proteção contra replay).
  - `gateway_event_id` repetido → 200 sem efeito (idempotência pelo banco).
  - Resposta rápida: grava o evento cru, responde 200 e processa em seguida.
- **Conciliação:** valor pago igual ao da Cobrança → Pagamento `reconciled`, Cobrança `paid`, evento `InstallmentPaid`. Valor diferente → Pagamento `unreconciled`, evento `PaymentUnreconciled`, para tratamento manual.
- **Expiração:** Pix expira em `PIX_EXPIRATION_HOURS`. Pedir de novo o Pix de uma Parcela com Cobrança vencida cria uma Cobrança nova.

### 5.6 Quebra

- O job de Quebra roda todo dia às `BREACH_JOB_CRON` e procura Parcelas `pending` com `due_date + breach_tolerance_days < hoje`.
- Para cada uma: o Acordo vira `breached`, as Parcelas `pending` viram `canceled`, e o evento `AgreementBreached` leva o total pago.
- A Carteira soma esse total em `amount_paid` da Dívida e a devolve a `open`. O desconto do Acordo quebrado se perde: o novo Valor atualizado é calculado sobre o principal menos o que já foi pago.
- Pagamento que chega depois da Quebra: a definir (crédito ou estorno).

### 5.7 Acesso do Devedor

- `POST /api/v1/debtor/access-codes` com CPF/CNPJ e o slug da Credora. A resposta é **sempre a mesma**, exista ou não o Devedor, para não revelar quem deve (proteção contra enumeração).
- O código tem `ACCESS_CODE_LENGTH` dígitos, vale `ACCESS_CODE_TTL` e aceita `ACCESS_CODE_MAX_ATTEMPTS` tentativas; depois, bloqueio por `ACCESS_CODE_LOCK_DURATION`.
- Pedido de código limitado a `ACCESS_CODE_REQUESTS_PER_WINDOW` por documento a cada `ACCESS_CODE_REQUEST_WINDOW`.
- O código vai para a caixa de saída simulada (`notification.outbox_message`), e a demo mostra essa caixa.

### 5.8 Fila e reserva

- **Prioridade (Strategy `QueuePriorityStrategy`):**
  - `OldestFirstStrategy` (padrão do MVP): maior atraso primeiro.
  - `HighestAmountStrategy`: maior Valor atualizado primeiro.
  - Promessa de pagamento vencida põe o Devedor no topo, em qualquer estratégia.
- **Distribuição:** rodízio entre os Operadores ativos ao entrar na Fila.
- **Reserva:** abrir a ficha reserva o Devedor por `DEBTOR_LOCK_DURATION`; o front renova a cada `DEBTOR_LOCK_HEARTBEAT` enquanto a ficha está aberta. Outro Operador recebe 409 `DEBTOR_LOCKED`, com o nome de quem está atendendo.
- Devedor com Acordo `active` sai da Fila; com Acordo quebrado, volta.

### 5.9 Importação

- **Formato do MVP (colunas fixas, sem mapeamento):** CSV em UTF-8, separador `;`, decimal com vírgula, data `dd/MM/aaaa`. Colunas: `document;name;email;phone;contract_number;description;principal_amount;original_due_date`.
- Limites: `IMPORT_MAX_ROWS` linhas e `IMPORT_MAX_FILE_SIZE`.
- `POST` responde 202 com o id; o processamento roda em segundo plano, em lotes de `IMPORT_CHUNK_SIZE` linhas, **uma transação por lote**. Um lote com erro de banco falha sozinho, sem desfazer os anteriores.
- Por linha: CPF/CNPJ pelo dígito verificador; valor > 0; data válida e no passado. Linha inválida → `import_row_error`.
- Duplicidade: mesma Credora + documento + contrato atualiza a Dívida, a menos que ela tenha Acordo vivo; nesse caso, a linha é contada como ignorada (`docs/foundation/business-requirements.md`, RN2.2 e RN2.3).
- Progresso publicado a cada lote (`PortfolioImportProgressed`) e entregue por SSE.

## 6. Valores e configuração

Padrões da plataforma. Os marcados com ★ podem ser mudados por Credora, na Política.

| Nome | Valor | Origem |
| --- | --- | --- |
| `LATE_FEE_RATE` | 2% | CDC (`business-requirements.md`, 2.3) |
| `MONTHLY_INTEREST_RATE` | 1% ao mês | RN3.2 |
| `SIMULATED_MONTHLY_INDEX` | 0,4% ao mês | Proposta; índice fictício |
| `proposal_validity_hours` ★ | 48 h | RN4.2 (arredondado para 48 h) |
| `breach_tolerance_days` ★ | 10 dias | RN5.1 |
| `min_installment_amount` ★ | R$ 50,00 | RN3.1 |
| `DOWN_PAYMENT_DUE_DAYS` | 2 dias | Proposta |
| `PIX_EXPIRATION_HOURS` | 24 h | RN6.4 |
| `WEBHOOK_MAX_AGE` | 5 min | Proposta |
| `ACCESS_CODE_LENGTH` | 6 dígitos | RN1.3 |
| `ACCESS_CODE_TTL` | 10 min | RN1.3 |
| `ACCESS_CODE_MAX_ATTEMPTS` | 5 | RN1.3 |
| `ACCESS_CODE_LOCK_DURATION` | 15 min | RN1.3 |
| `ACCESS_CODE_REQUESTS_PER_WINDOW` / `ACCESS_CODE_REQUEST_WINDOW` | 3 a cada 15 min | Proposta |
| `LOGIN_ATTEMPTS_PER_MINUTE` | 5 por IP + e-mail | Proposta |
| `ACCESS_TOKEN_TTL` | 15 min | Proposta |
| `REFRESH_TOKEN_TTL` (backoffice) | 7 dias | Proposta |
| `INVITATION_TTL` | 7 dias | Proposta |
| `DEBTOR_SESSION_IDLE_TIMEOUT` | 15 min | RN1.4 |
| `DEBTOR_LOCK_DURATION` | 15 min | RN7.2 |
| `DEBTOR_LOCK_HEARTBEAT` | 5 min | Proposta |
| `IMPORT_MAX_ROWS` | 100.000 | RF2.1 |
| `IMPORT_MAX_FILE_SIZE` | 10 MB | Proposta |
| `IMPORT_CHUNK_SIZE` | 1.000 linhas | Proposta |
| `PAGE_SIZE_DEFAULT` / `PAGE_SIZE_MAX` | 20 / 100 | Proposta |
| `BREACH_JOB_CRON` | 03:00, fuso de São Paulo | Proposta |

## 7. Convenções do contrato

- **Base:** `/api/v1`. Recursos no plural, em kebab-case (`/portfolio-imports`). Ações que não são CRUD viram sub-recurso com verbo (`/proposals/{id}/accept`).
- **Dois públicos, dois prefixos:** rotas do backoffice em `/api/v1/...`; rotas do Devedor em `/api/v1/debtor/...`, aceitas só com token de Devedor.
- **JSON** em camelCase. Datas `AAAA-MM-DD`; instantes ISO 8601 com fuso (`2026-11-10T13:00:00Z`).
- **Dinheiro como string decimal** (`"1060.00"`), nunca como número: o `number` do JavaScript é ponto flutuante e erra centavos. Taxas também como string (`"0.2500"`).
- **Paginação por cursor:** `?limit=20&cursor=<opaco>` → `{ "items": [...], "nextCursor": "..." | null }`. Por `offset` só nas listas pequenas (`?page=&size=`).
- **Erros:** Problem Details (RFC 9457) com `type`, `title`, `status`, `detail`, mais `code` (estável, em `UPPER_SNAKE_CASE`, ex.: `AGREEMENT_ALREADY_EXISTS`) e, em validação, `errors: [{ field, message }]`. O front decide pelo `code`, nunca pelo texto.
- **Idempotência:** `Idempotency-Key` obrigatório em `POST` de Acordo e de importação; a mesma chave com o mesmo corpo devolve a mesma resposta, e com corpo diferente devolve 422.
- **Concorrência:** recursos editáveis (Política em rascunho) levam `version` no corpo; versão desatualizada → 409 `STALE_VERSION`.
- **Correlação:** `X-Request-Id` aceito do cliente (ou gerado) e devolvido em toda resposta.
- **SSE:** `GET /api/v1/events/stream`, com `Authorization` no cabeçalho. Como o `EventSource` nativo do navegador não envia cabeçalhos, os fronts consomem o stream com `fetch` e leitura do corpo em streaming. Eventos com `event:` (tipo) e `id:` (para retomar com `Last-Event-ID`).

### Códigos de erro (planejados)

Os `code` estáveis que a API devolve. O texto que cada front mostra para cada um está em `design/ux-writing.md`, seção "Mapa de erros da API → texto".

| `code` | Status | Quando | Regra |
| --- | --- | --- | --- |
| `VALIDATION_FAILED` | 400 | Corpo inválido; detalhes em `errors[]` | seção 7 |
| `INVALID_CREDENTIALS` | 401 | E-mail ou senha incorretos (não diz qual) | seção 8 |
| `LOGIN_RATE_LIMITED` | 429 | Passou de `LOGIN_ATTEMPTS_PER_MINUTE` | seção 6 |
| `ACCESS_CODE_INVALID` | 401 | Código errado; `remainingAttempts` no corpo | 5.7 |
| `ACCESS_CODE_EXPIRED` | 401 | Código passou de `ACCESS_CODE_TTL` | 5.7 |
| `ACCESS_CODE_LOCKED` | 423 | Passou de `ACCESS_CODE_MAX_ATTEMPTS`; `lockedUntil` no corpo | 5.7 |
| `ACCESS_CODE_RATE_LIMITED` | 429 | Passou de `ACCESS_CODE_REQUESTS_PER_WINDOW`; `retryAt` no corpo | 5.7 |
| `INSTALLMENTS_OUT_OF_POLICY` | 422 | `n` fora de 1..`max_installments` | 5.3 |
| `INSTALLMENT_BELOW_MINIMUM` | 422 | Parcela abaixo de `min_installment_amount`; `maxInstallmentsAllowed` no corpo | 5.3 |
| `DOWN_PAYMENT_BELOW_MINIMUM` | 422 | Entrada desejada abaixo do mínimo da faixa; `minDownPayment` no corpo | 5.3 |
| `PROPOSAL_EXPIRED` | 409 | Proposta vencida ou recálculo diferente da Proposta (Política mudou) | 5.4 |
| `AGREEMENT_ALREADY_EXISTS` | 409 | Já há Acordo vivo para a Dívida; `agreementId` no corpo | 5.4 |
| `DEBT_NOT_NEGOTIABLE` | 409 | Dívida contestada, quitada ou cancelada | 5.4 |
| `DEBTOR_LOCKED` | 409 | Outro Operador reservou o Devedor; `lockedBy` e `lockedUntil` no corpo | 5.8 |
| `IMPORT_ALREADY_RUNNING` | 409 | Já existe importação `processing` na Credora | 5.9 |
| `IMPORT_FILE_INVALID` | 422 | Não é CSV, passou do tamanho ou das linhas, ou faltam colunas; `missingColumns` no corpo | 5.9 |
| `STALE_VERSION` | 409 | `version` desatualizada | seção 7 |
| `FORBIDDEN` | 403 | Papel ou tenant sem acesso à rota | seção 8 |
| `NOT_FOUND` | 404 | Recurso inexistente ou de outro tenant (nunca 403, para não revelar que existe) | seção 8 |

### Índice de rotas (planejadas)

| Grupo | Rotas | Quem |
| --- | --- | --- |
| Auth | `POST /auth/login`, `POST /auth/refresh`, `POST /auth/logout` | backoffice |
| Auth do Devedor | `POST /debtor/access-codes`, `POST /debtor/sessions`, `POST /debtor/sessions/refresh` | Devedor |
| Credoras | `GET/POST /creditors`, `POST /creditors/{id}/impersonate` | admin |
| Usuários | `GET /users`, `POST /invitations`, `POST /invitations/{token}/accept` | gestor |
| Importação | `POST /portfolio-imports`, `GET /portfolio-imports`, `GET /portfolio-imports/{id}`, `GET /portfolio-imports/{id}/errors.csv` | gestor |
| Devedores e Dívidas | `GET /debtors?q=`, `GET /debtors/{id}`, `GET /debtors/{id}/timeline`, `GET /debts` | gestor, operador |
| Política | `GET /policies`, `POST /policies`, `PUT /policies/{id}`, `POST /policies/{id}/publish` | gestor |
| Negociação | `POST /simulations`, `POST /proposals`, `POST /proposals/{id}/accept` | operador |
| Acordos | `GET /agreements/{id}`, `GET /debtors/{id}/agreements` | gestor, operador |
| Portal | `GET /debtor/debts`, `POST /debtor/simulations`, `POST /debtor/agreements`, `GET /debtor/agreements/{id}`, `POST /debtor/installments/{id}/charges` | Devedor |
| Pagamentos | `GET /payments?status=unreconciled`, `POST /payments/{id}/resolve` | gestor |
| Fila e atendimento | `GET /work-queue`, `POST /debtors/{id}/lock`, `DELETE /debtors/{id}/lock`, `POST /debtors/{id}/interactions` | operador |
| Analytics | `GET /analytics/summary`, `GET /analytics/recovery`, `GET /analytics/aging` | gestor, operador |
| Tempo real | `GET /events/stream` | backoffice |
| Webhook | `POST /webhooks/payment-gateway` | gateway |
| Gateway fake | `POST /fake-gateway/charges`, `POST /fake-gateway/charges/{id}/pay` | API, demo |

## 8. Segurança

- **Tokens:** JWT de acesso assinado com chave simétrica (HS256, `JWT_SECRET`), vida de `ACCESS_TOKEN_TTL`. Claims: `sub` (usuário ou Devedor), `tid` (tenant), `typ` (`user` ou `debtor`), `roles`, e `act` quando o admin está "entrando como" uma Credora.
- **Refresh:** valor aleatório opaco (não JWT), guardado como hash em `refresh_token`, no cookie `quita_refresh` (`HttpOnly`, `Secure`, `SameSite=Strict`, `Path=/api/v1/auth`). **Rotação a cada uso:** o refresh devolve um novo e invalida o antigo; um token já usado aparecendo de novo revoga a família inteira (sinal de roubo).
- **Autorização:** por papel nas rotas (`@PreAuthorize`) e por tenant na persistência. O token de Devedor só passa nas rotas `/debtor/**`, e só enxerga as Dívidas dele.
- **Tenant:** tirado do claim `tid` a cada requisição e colocado no `TenantContext`, que o Hibernate usa no `@TenantId`. Requisição sem tenant em rota de tenant → 403.
- **Limite de taxa:** login, pedido de código e validação de código (seção 6).
- **CORS:** desligado em produção, porque os fronts chamam pelo mesmo site (HLD, "Segurança e privacidade"). Liberado só para os endereços locais no perfil de desenvolvimento.
- **Logs:** nunca registram senha, token, código, CPF completo ou corpo de webhook. O CPF aparece mascarado.

## 9. Jobs agendados

| Job | Quando | O que faz |
| --- | --- | --- |
| Quebra | `BREACH_JOB_CRON` | Seção 5.6 |
| Entrada vencida | a cada hora | Acordos `awaiting_down_payment` com Entrada vencida → `canceled` |
| Proposta vencida | a cada hora | Propostas `approved` com `expires_at` no passado → `expired` |
| Promessa vencida | a cada hora | Promessas `pending` vencidas → `broken`; Devedor vai ao topo da Fila |
| Aging do painel | a cada hora | Recalcula `analytics.portfolio_aging` |
| Eventos pendentes | a cada 5 min | Reprocessa eventos não concluídos do registro do Modulith |

Todos percorrem as Credoras uma a uma, com o tenant definido em cada passada. Com uma instância só, não há trava distribuída; com mais de uma, seria preciso ShedLock (a definir).

## 10. Gateway fake

- Pacote `fakegateway`, no mesmo deploy, sem acesso a nenhum outro módulo: conversa com a API só por HTTP público, como um provedor real.
- `POST /fake-gateway/charges`: cria a cobrança e devolve um payload de Pix fictício (QR Code e copia-e-cola).
- `POST /fake-gateway/charges/{id}/pay`: simula o pagamento (botão "simular pagamento" na demo) e agenda o webhook.
- **Entrega do webhook:** assinada (seção 5.5), com novas tentativas em 1 s, 5 s, 30 s, 2 min e 10 min enquanto a API não responder 2xx.
- **Modos de caos**, para teste e demo: `?duplicate=true` (entrega o mesmo evento duas vezes), `?delay=<s>` (atrasa a entrega), `?amount=<valor>` (paga valor diferente, para testar a conciliação manual).

## 11. Testes

| Nível | O que cobre | Ferramenta |
| --- | --- | --- |
| Domínio | Cálculos (seção 5) e transições de estado, sem Spring | JUnit + AssertJ |
| Módulo | Casos de uso de um módulo com banco real e eventos | `@ApplicationModuleTest` + Testcontainers |
| Arquitetura | Fronteiras e ausência de ciclos entre módulos; dependências só para dentro em cada módulo | `ApplicationModules.verify()` + ArchUnit |
| API | As rotas pelo HTTP: status, `code` de erro, segurança | MockMvc + Testcontainers |
| Tenancy | Para cada rota de leitura: um usuário da Credora A não vê nada da B | Suíte própria, parametrizada pelas rotas |
| Contrato | O `openapi.json` versionado bate com o gerado do código | Teste que gera e compara; diferença falha o build |

Os exemplos numéricos da seção 5 são casos de teste obrigatórios.

## 12. Execução e configuração

**Variáveis de ambiente**

| Variável | Para quê |
| --- | --- |
| `SPRING_PROFILES_ACTIVE` | `local` ou `demo` |
| `DATABASE_URL`, `DATABASE_USERNAME`, `DATABASE_PASSWORD` | Conexão da aplicação (endpoint com pool) |
| `DATABASE_MIGRATION_URL` | Conexão do Flyway (endpoint direto) |
| `JWT_SECRET` | Assinatura dos tokens |
| `GATEWAY_WEBHOOK_SECRET` | Assinatura do webhook |
| `API_PUBLIC_URL` | Endereço público da API, para o gateway fake chamar o webhook |
| `CORS_ALLOWED_ORIGINS` | Só no perfil `local` |
| `JAVA_TOOL_OPTIONS` | Ajuste de memória da JVM |

**Memória:** a hospedagem gratuita tem pouca memória. Ponto de partida: `-XX:MaxRAMPercentage=70 -XX:+UseSerialGC -Xss512k`, com virtual threads ligadas (`spring.threads.virtual.enabled=true`). Os valores são medidos e fixados no walking skeleton.

**Contêiner:** imagem multi-stage (build com Maven, execução só com o JRE), usuário não root, health check no Actuator.

## 13. Decisões

| ADR | Decisão |
| --- | --- |
| [0009](../adr/0009-spring-mvc-virtual-threads.md) | Spring Web MVC com virtual threads, em vez de WebFlux |
| [0010](../adr/0010-pragmatic-hexagonal-per-module.md) | Arquitetura hexagonal pragmática dentro de cada módulo |

No texto: dinheiro como string no JSON (seção 7); refresh token opaco com rotação (seção 8); módulos como pacotes num único módulo Maven (seção 1); regras de uso do Lombok (seção 1); importação com colunas fixas no MVP (seção 5.9).

## 14. Questões em aberto

- [ ] Pagamento depois da Quebra: crédito do Devedor ou estorno (seção 5.6).
- [ ] ShedLock, se a API passar de uma instância (seção 9).
- [ ] Boleto além do Pix no MVP.
- [ ] Mapeamento de colunas na importação (Fase 2).
