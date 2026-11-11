# F01-T03 · Shell composes the remotes at runtime

**Status:** a fazer
**Repos:** `quita-backoffice-web`
**Bloqueada por:** F01-T01 · API foundation running locally, F01-T02 · Backoffice workspace with enforced boundaries

## O que construir

O shell mostra um menu com "Operações" e "Painel". Operações é carregado por Native Federation a partir do manifesto de remotes; o Painel é o Web Component `<quita-analytics>`, cujo script só é baixado ao entrar na rota. Os dois mostram o estado da API, lido pelo proxy `/api/*` do servidor de desenvolvimento. Se um remote não carrega, só a área de conteúdo mostra o erro com "Tentar de novo".

## Critérios de aceite

- [ ] **CA1** · O primeiro acesso ao shell não baixa nenhum arquivo do Operações nem do Analytics; cada um só é pedido ao entrar na rota. (PRD CA4)
- [ ] **CA2** · `/operations` é carregado por `loadRemoteModule` a partir de `federation.manifest.json` e mostra o estado da API. Angular e RxJS são baixados uma vez só. (PRD CA5)
- [ ] **CA3** · `/analytics` mostra `<quita-analytics>` com o estado da API, lido pelo React. Entrar e sair da rota várias vezes não registra o elemento nem carrega o script de novo. (PRD CA6)
- [ ] **CA4** · Uma regra `h1 { color: red }` no shell não altera o painel. (PRD CA6)
- [ ] **CA5** · Com o Operações parado, a rota mostra "Não foi possível carregar esta área" com **Tentar de novo**; o menu continua funcionando; com o remote de volta, "Tentar de novo" carrega. (PRD CA7)
- [ ] **CA6** · `APP_CONFIG` e `REMOTES_MANIFEST` chegam por `InjectionToken`, sem import de arquivo de ambiente.

## Como demonstrar

Aba Network ao navegar entre as rotas; parar o servidor do Operações e clicar no menu.
