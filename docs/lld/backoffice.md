# LLD: backoffice (`quita-backoffice-web`)

2026-11-10 · helloWorldRuan · Status: aprovado

Como o backoffice funciona por dentro: o monorepo Nx, o shell, os remotes, a comunicação entre eles, rotas, estado, chamadas à API e testes. A composição dos micro front-ends está no HLD (seção "Arquitetura") e nos ADRs 0002 e 0012; o contrato da API, em `docs/lld/api.md`; a identidade visual e os componentes, em `design/DESIGN.md`.

## Onde mora cada fato

| Fato | Dono |
| --- | --- |
| Rotas e telas do backoffice | Este documento, seção 5 |
| Forma das chamadas e respostas da API | Tipos gerados do `openapi.json` (ADR 0011) |
| Cores, tipografia, componentes visuais | `design/DESIGN.md` |
| Comandos (servir, testar, gerar) | `AGENTS.md` do `quita-backoffice-web` |

## 1. Stack

| Peça | Escolha | Por quê |
| --- | --- | --- |
| Monorepo | Nx | Projetos, grafo de dependências, cache, `nx affected`, regras de fronteira entre libs |
| Shell e Operações | Angular, versão atual (fixada no walking skeleton), standalone, zoneless, signals | Padrão atual do Angular |
| Federação | Native Federation | ADR 0012 |
| Analytics | React + TypeScript + Vite, empacotado como Web Component | ADR 0012 |
| Estado no Angular | Signals + NgRx SignalStore por funcionalidade; RxJS para fluxos assíncronos | Seção 6 |
| Estado no React | TanStack Query (dados do servidor) + estado local; filtros vindos do shell | Seção 8 |
| Formulários | Reactive Forms tipados | Formulários dinâmicos e validação cruzada da Política |
| Estilo e componentes | Tailwind + Spartan UI (Angular) + shadcn/ui (React), com tokens compartilhados | `design/DESIGN.md` |
| Tabelas | TanStack Table (adaptadores Angular e React) | O mesmo modelo de tabela nos dois frameworks |
| Gráficos | Recharts | Padrão de mercado no React |
| Tipos da API | `openapi-typescript` | ADR 0011 |
| Testes | Vitest + Testing Library (unidade e componente), Playwright (ponta a ponta) | Seção 11 |
| Qualidade | ESLint (angular-eslint, regras do React), Prettier, `@nx/enforce-module-boundaries` | Seção 2 |

## 2. Estrutura do monorepo

```
quita-backoffice-web/
  apps/
    shell/                     Angular · host: layout, login, sessão, menu, carga dos remotes
    operations/                Angular · remote: Fila, ficha, importação, Política, pagamentos, admin
    analytics/                 React + Vite · Web Component <quita-analytics>
    shell-e2e/                 Playwright · fluxos de ponta a ponta
  libs/
    shared/
      api-types/               tipos gerados do openapi.json (sem código de chamada)
      design-tokens/           tokens (CSS custom properties + preset do Tailwind)
      util/                    dinheiro, CPF/CNPJ, datas, cursor (TypeScript puro, sem framework)
    angular/
      ui/                      componentes visuais Angular (Spartan estilizado)
      data-access/             HttpClient: interceptors, serviços de API por domínio
      session/                 sessão do usuário (SignalStore singleton)
      realtime/                conexão SSE única, distribuída por tipo de evento
    operations/
      feature-queue/           Fila e ficha do Devedor
      feature-imports/         importação de Carteira
      feature-policies/        Política de negociação
      feature-payments/        pagamentos não conciliados
      feature-admin/           Credoras e usuários
    react/
      ui/                      componentes visuais React (shadcn estilizado)
```

**Regras de fronteira** (tags do Nx, verificadas pelo lint):

| Tag | Pode depender de |
| --- | --- |
| `type:app` | qualquer lib |
| `type:feature` | `type:ui`, `type:data-access`, `type:util` |
| `type:data-access` | `type:util` |
| `type:ui` | `type:util` |
| `type:util` | nada |
| `scope:angular` | `scope:angular`, `scope:shared` |
| `scope:react` | `scope:react`, `scope:shared` |
| `scope:shared` | `scope:shared` |

Uma lib de Angular nunca é importada pelo React, e vice-versa; o que é comum aos dois é TypeScript puro em `shared`.

## 3. Shell

- **Responsabilidades:** login, recuperação de senha e renovação de sessão, layout (menu lateral, barra superior, área de conteúdo), guarda de rotas por papel, carga dos remotes, conexão SSE, notificações globais e o aviso de "servidor acordando".
- **Notificações no MVP:** vêm só do SSE, sem histórico. O sino mostra as que chegaram nesta sessão, e elas somem ao recarregar. A lista guardada (`in_app_notification`) entra na F16.
- **O que o shell não faz:** nenhuma tela de negócio. Tudo que é do domínio fica num remote.
- **Manifesto de remotes:** `federation.manifest.json`, servido junto com o shell, com o endereço de cada remote no ambiente. É lido na inicialização, nunca entra em cache (`Cache-Control: no-cache`), e cada ambiente tem o seu.
- **Falha de um remote:** se o manifesto ou o código de um remote não carrega, a rota mostra um estado de erro com "tentar de novo" só naquela área. O menu e os outros remotes continuam funcionando.
- **Proxy da API:** a configuração da Vercel do shell redireciona `/api/*` para a API (HLD, "Segurança e privacidade"). No ambiente local, o servidor de desenvolvimento faz o mesmo proxy.

## 4. Comunicação entre shell e remotes

**Shell ↔ Operações (Angular com Angular)**
- As bibliotecas do Angular, RxJS e as libs `angular/session`, `angular/realtime` e `angular/data-access` são compartilhadas como **singleton** na federação. O remote recebe as mesmas instâncias de serviço que o shell criou: a sessão de login é uma só.
- O remote expõe as **rotas** dele (`./routes`), e o shell as carrega com `loadChildren`.

**Shell ↔ Analytics (Angular com React)**
- O contrato é o do Web Component, sem nada de Angular ou React atravessando a fronteira:

| Direção | Mecanismo | O quê |
| --- | --- | --- |
| Shell → Analytics | propriedade `getAccessToken` | Função que devolve o token atual (o Analytics nunca guarda token) |
| Shell → Analytics | propriedade `filters` | Filtros atuais: `{ from, to, operatorId? }` (período e Operador; o Operador só para o gestor). Sem filtro de Faixa no MVP: `daily_recovery` não tem Faixa na chave, e o card de aging já mostra o valor por Faixa (filtro na F21). Sem filtro de Carteira: a Carteira é uma só por Credora (`GLOSSARY.md`); a safra é da F21 |
| Shell → Analytics | propriedade `user` | Nome, papel e tenant, para o Operador ver só os números dele |
| Analytics → Shell | evento `quita-filters-change` | Novos filtros; o shell grava na URL |
| Analytics → Shell | evento `quita-navigate` | Pede ao shell para navegar (ex.: abrir a ficha de um Devedor) |

- **Os filtros moram na URL do shell.** O Analytics não mexe no histórico do navegador: ele pede, e o shell decide. Assim um link do painel com filtros pode ser compartilhado.
- **Estilos:** o Web Component usa Shadow DOM com os mesmos tokens, então o CSS do React não vaza para o shell, e o do shell não quebra o React.

## 5. Rotas

| Rota | App | Tela | Papéis |
| --- | --- | --- | --- |
| `/login` | shell | Login | público |
| `/invitations/:token` | shell | Aceitar convite e criar senha | público |
| `/password-reset` | shell | Pedir o link de nova senha | público |
| `/password-reset/:token` | shell | Criar a nova senha | público |
| `/` | shell | Redireciona: operador → Fila; gestor → painel | logado |
| `/operations/queue` | operations | Fila de trabalho | operador, gestor |
| `/operations/debtors` | operations | Busca de Devedores e "Nova dívida" (cadastro manual, painel lateral) | operador, gestor |
| `/operations/debtors/:id` | operations | Ficha do Devedor (Dívidas, Acordos, linha do tempo, envio de Proposta; "Registrar pagamento fora do Quita" só para o gestor) | operador, gestor |
| `/operations/imports` | operations | Histórico de importações + nova importação | gestor |
| `/operations/imports/:id` | operations | Progresso ao vivo e relatório de erros | gestor |
| `/operations/policies` | operations | Versões da Política | gestor |
| `/operations/policies/:id` | operations | Editor da Política (rascunho) com simulador | gestor |
| `/operations/payments` | operations | Pagamentos não conciliados | gestor |
| `/operations/admin/users` | operations | Usuários e convites | gestor |
| `/operations/admin/creditors` | operations | Credoras | admin da plataforma |
| `/analytics` | shell → Analytics | Painel com filtros na URL | gestor, operador |

- Remotes carregados sob demanda (lazy) por rota; dentro do Operações, cada `feature-*` também é lazy.
- Guarda de autenticação e guarda de papel no shell; o remote confia na sessão compartilhada.
- A ficha do Devedor carrega os dados com um resolver, para a tela abrir já preenchida.

## 6. Estado e fluxos assíncronos (Angular)

**Divisão de responsabilidade:**
- **Signals** para estado de tela (o que está selecionado, aberto, filtrado) e estado derivado (`computed`).
- **RxJS** para o que é fluxo no tempo: digitação, requisições canceláveis, novas tentativas, SSE, polling.
- **SignalStore** por funcionalidade quando o estado é compartilhado entre componentes (Fila, importação em andamento, sessão). A ponte entre os dois mundos é `toSignal` / `rxMethod`.

**Fluxos com regra de tempo** (cada um é critério de aceite de alguma tarefa):

| Fluxo | Comportamento exigido |
| --- | --- |
| Busca de Devedor | Ignora digitação com menos de 300 ms de pausa e termos com menos de 3 caracteres; não repete a mesma busca seguida; cancela a busca anterior quando chega uma nova; em erro, tenta 3 vezes com intervalo crescente antes de mostrar o erro |
| Pré-validação da importação | Lê e valida o **arquivo inteiro** num Web Worker, sem travar a tela, com as mesmas regras de formato da API (cabeçalho do modelo, CPF/CNPJ, e-mail ou celular, valor, data). Mostra "{total} linhas · {n} com problema" e o resumo por tipo de erro antes de enviar. A API continua sendo a fonte da verdade |
| Progresso da importação | Atualiza pelo SSE; se o SSE cair, passa a consultar a cada 5 s até reconectar; para sozinho quando a importação termina |
| Reserva do Devedor | Renova a cada `DEBTOR_LOCK_HEARTBEAT` enquanto a ficha está aberta e visível; libera ao sair; se outro Operador está com ela, mostra quem e até quando (`lockedBy`, `lockedUntil` do 409 `DEBTOR_LOCKED`), em modo só leitura. Sem aviso de liberação no MVP |
| Renovação de sessão | Num 401, faz **uma** renovação só, mesmo com várias requisições falhando ao mesmo tempo; as outras esperam a renovação e são repetidas; se a renovação falhar, vai para o login guardando a rota atual |
| Servidor acordando | Em 502, 503 ou tempo esgotado, tenta de novo com intervalo crescente por até 90 s, mostrando o aviso global "acordando o servidor" |
| Pagamento confirmado | Evento SSE atualiza a ficha aberta sem recarregar a página |

Os valores citados pelo nome estão em `docs/lld/api.md`, "Valores e configuração".

### Peças de base do Angular

Artefatos reutilizáveis planejados em `libs/angular/ui` e `libs/angular/data-access`, cada um com o problema que resolve no Quita:

| Tipo | Artefato | Problema que resolve |
| --- | --- | --- |
| Pipe | `brl` | Exibir dinheiro que chega como string, em BRL |
| Pipe | `document` | Mascarar CPF/CNPJ (`***.456.789-**`). No MVP, sempre mascarado para o Operador; o CPF completo com permissão chega na F17 |
| Pipe | `relativeTime` | "há 5 min" na linha do tempo, atualizando sozinho |
| Pipe | `agingBucket` | Rótulo e cor da Faixa de atraso a partir da data de vencimento, com as Faixas da **Política publicada** (de 1 a 5, carregadas uma vez por sessão), nunca uma lista fixa. Antes da primeira publicação, as 5 Faixas padrão. Os filtros da Fila e da Busca usam a mesma lista |
| Diretiva estrutural | `*hasRole` | Mostrar ou esconder trechos por papel, sem `@if` repetido |
| Diretiva de atributo | `autofocus`, `clickOutside`, `copyToClipboard` | Foco ao abrir a ficha, fechar painéis, copiar o código Pix |
| Controle de formulário (`ControlValueAccessor`) | `money-input`, `percent-input`, `document-input` | Campos que digitam num formato e entregam outro ao formulário (máscara → valor) |
| Inicializador | `provideAppInitializer` | Registrar o locale pt-BR, restaurar a sessão pelo refresh antes da primeira tela |
| Token de injeção | `APP_CONFIG`, `REMOTES_MANIFEST` | Configuração por ambiente sem import direto de arquivo |
| Tratador global | `ErrorHandler` próprio | Capturar erro não tratado, registrar com o `X-Request-Id` e avisar o usuário |
| Projeção de conteúdo | `card`, `page-layout`, `empty-state` com `ng-content` e slots | Moldes de tela com miolo variável |
| Formulários | Reactive Forms (Política, negociação); template-driven com `ngModel` (login, convite, nota rápida de Tratativa) | Cada estilo onde ele é a escolha natural |

## 7. Chamadas à API (Angular)

- **Tipos** de `libs/shared/api-types`; **serviços** por domínio em `libs/angular/data-access`, com `HttpClient` e funções que devolvem `Observable`.
- **Interceptors funcionais**, nesta ordem:
  1. `requestId`: acrescenta `X-Request-Id`.
  2. `auth`: acrescenta o token; num 401, coordena a renovação única.
  3. `serverWaking`: novas tentativas para o servidor dormindo.
  4. `problemDetails`: transforma o erro HTTP num erro tipado com o `code` da API.
- **Dinheiro:** chega como string e é exibido com `Intl.NumberFormat` em BRL. Nenhuma conta com dinheiro no front: todo valor calculado vem da API (a simulação inclusive).
- **Erros por `code`:** cada tela trata os códigos que pode receber (ex.: `AGREEMENT_ALREADY_EXISTS` → "Outro atendimento fechou um acordo para esta dívida agora há pouco"), e o resto cai numa mensagem genérica com o `X-Request-Id` para suporte.

## 8. Analytics (React)

- **Entrada:** `main.tsx` registra o custom element `quita-analytics`, que monta a árvore React dentro do Shadow DOM e a desmonta quando o elemento sai da página.
- **Dados:** TanStack Query, com a chave da consulta derivada dos filtros; tempo de "dado fresco" de 60 s (o painel tem até 5 min de atraso por natureza).
- **Componentização:** um hook por consulta (`useRecoverySummary(filters)`), um componente por indicador ou gráfico, `memo` só onde o perfil do React mostrar render desnecessário.
- **Estados:** carregando (esqueleto do card), vazio ("ainda sem acordos no período"), erro por card (um gráfico quebrado não derruba o painel, com error boundary por card).
- **Faixas:** o gráfico de aging usa as Faixas da Política publicada, que vêm da API (`/analytics/aging`), nunca uma lista fixa. O filtro por Faixa é da F21.
- **Números por Operador:** a visão do Operador lê `operator_performance` (LLD da API, 5.12); funil, conversão e ranking ficam para a F21.
- **Exportação:** CSV gerado no navegador a partir dos dados da tela; PDF fica para a Fase 3.
- **Propriedades do Web Component como fonte externa:** o shell muda `filters` e `user` por fora do React; a árvore lê esses valores por uma assinatura externa (`useSyncExternalStore`), sem cópia em estado local.
- **Painel de filtros:** estado com várias transições (aplicar, limpar, desfazer) num `useReducer`; filtragem de tabelas grandes sem travar a digitação (`useTransition` / `useDeferredValue`).
- **Gráficos:** medidas do contêiner antes de desenhar (`useLayoutEffect` + `useRef`), tooltip por portal (`createPortal`) dentro do Shadow DOM, ids acessíveis com `useId`.
- **Contexto:** usuário e tema em contextos separados, para uma mudança de filtro não re-renderizar quem só lê o usuário.

## 9. Formulários (Política)

- Formulário reativo tipado com um `FormArray` de regras por Faixa de atraso: de 1 a 5 Faixas. A primeira Política começa com as 5 Faixas padrão (0–30, 31–90, 91–180, 181–360, > 360); o Gestor edita, acrescenta até 5 e remove até sobrar 1 (LLD da API, 5.10).
- **Validação cruzada:** a primeira Faixa começa em 0; as Faixas não se sobrepõem, não deixam buraco e só a última não tem teto; de 1 a 5 Faixas; desconto entre 0 e 100%; Parcelas ≥ 1; Entrada mínima entre 0 e 100%.
- **Simulador ao lado:** mudar a regra recalcula, na API, uma Dívida de exemplo (com o mesmo controle de tempo da busca), por `POST /policies/simulations`: o corpo leva as regras como estão no formulário, sem salvar, as configurações gerais e `{ principalAmount, overdueDays }`. Nada é gravado, então o simulador não mexe na `version` do rascunho (LLD da API, 5.3).
- **Concorrência:** salvar envia a `version`; um 409 `STALE_VERSION` mostra o que mudou e oferece recarregar.
- **Saída sem salvar:** guarda de rota pergunta antes de descartar alterações.

## 10. Desempenho e acessibilidade

- Zoneless + signals: só re-renderiza o que mudou.
- `@defer` para blocos pesados abaixo da dobra (linha do tempo, gráficos da ficha).
- Virtual scroll (CDK) no relatório de erros da importação e em listas longas.
- `track` em todo `@for`.
- Acessibilidade AA: navegação completa por teclado, foco visível, atalhos na Fila (próximo e anterior Devedor), anúncios de leitor de tela para atualizações ao vivo (`aria-live`).

## 11. Testes

| Nível | O que cobre | Ferramenta |
| --- | --- | --- |
| Unidade | Utilitários, stores, interceptors, validadores | Vitest |
| Componente | Telas pelo que o usuário vê e faz, com a API simulada | Vitest + Testing Library + MSW |
| Fluxos de tempo | Busca, renovação de sessão, retry | Vitest com relógio falso e testes de marble do RxJS |
| Ponta a ponta | Login → Fila → ficha → Proposta enviada; importação; Política | Playwright, contra a API local |

## 12. Publicação

- Um projeto da Vercel por app (`shell`, `operations`, `analytics`), todos do mesmo repo; cada um publica só quando o `nx affected` diz que ele mudou.
- Os nomes dos arquivos levam hash; o manifesto de remotes e o `index.html` vão sem cache.
- Prévia por PR: cada app ganha a prévia dele; o manifesto da prévia do shell aponta para as prévias dos remotes do mesmo PR (a definir no walking skeleton).

## 13. Decisões

| ADR | Decisão |
| --- | --- |
| [0011](../adr/0011-generated-types-handwritten-calls.md) | Tipos gerados do OpenAPI e chamadas escritas à mão |
| [0012](../adr/0012-native-federation-and-web-component.md) | Native Federation no backoffice e o React como Web Component |

No texto: SignalStore em vez do NgRx Store clássico (seção 6); filtros do painel na URL do shell (seção 4); TanStack Table nos dois frameworks (seção 1).

## 14. Questões em aberto

- [ ] Biblioteca de componentes final (decidida no design system).
- [x] Distribuição dos tokens para o portal: o portal guarda uma cópia do CSS no MVP, sem pacote (HLD, "Design system").
- [ ] Prévia por PR com manifesto apontando para as prévias dos remotes.
