# PRD: F01 · Walking skeleton

2026-11-11 · helloWorldRuan · Status: rascunho

## Resumo

- **Problema:** o Quita tem três apps de front, uma API e um banco, em três plataformas de hospedagem. Se a integração entre eles só for testada depois das regras de negócio, um problema de federação, de cookie, de memória ou de deploy aparece tarde e custa caro.
- **Solução:** antes de qualquer tela do produto, publicar a versão mais fina possível de **todos** os apps, conversando de ponta a ponta, com CI e deploy automáticos.
- **Como saber que funcionou:** uma pessoa abre o endereço público do backoffice e o do portal e vê, em cada um, o estado da API, que leu o banco. Move a métrica "Entrega do projeto" do `docs/product-brief.md` e mitiga o risco "integração dar problema tarde".

## Quem usa

Só quem desenvolve. Não há Gestor, Operador nem Devedor nesta funcionalidade: nenhuma tela do hi-fi é entregue.

## Histórias e critérios de aceite

### H1 · Como desenvolvedor, quero subir o sistema inteiro na minha máquina, para trabalhar em qualquer funcionalidade

- **CA1** · Com o banco no Docker Compose e a API rodando no perfil local, `GET /actuator/health` responde `UP` e inclui o banco.
- **CA2** · A primeira migração criou um schema por módulo e a extensão `pg_trgm`.
- **CA3** · O shell, o remote Operações, o Analytics e o portal sobem localmente, cada um na própria porta.

### H2 · Como desenvolvedor, quero ver o shell compor os remotes em tempo de execução, para provar a arquitetura de micro front-ends

- **CA4** · O shell mostra um menu com "Operações" e "Painel". O código de cada um só é baixado ao entrar na rota.
- **CA5** · "Operações" é carregado por federação, a partir do endereço do manifesto de remotes, e mostra o estado da API.
- **CA6** · "Painel" é o Web Component `<quita-analytics>`, em React, e mostra o estado da API. Um estilo global do shell não altera a aparência dele.
- **CA7** · Com um remote fora do ar, só a área de conteúdo mostra "Não foi possível carregar esta área", com **Tentar de novo**; o menu continua funcionando.

### H3 · Como desenvolvedor, quero ver o portal falar com a API pelo servidor, para provar o BFF

- **CA8** · A página inicial do portal mostra o estado da API, lido pelo servidor do Next.js. O navegador não faz nenhuma chamada ao domínio da API.
- **CA9** · Com a API fora do ar, a página responde em até 5 s com "acordando", sem erro 500.

### H4 · Como desenvolvedor, quero que cada mudança seja verificada e publicada sozinha, para a `main` estar sempre no ar

- **CA10** · Em cada repo de código, um PR roda lint, testes e build; no backoffice, só dos projetos afetados.
- **CA11** · A `main` de cada repo é protegida: sem push direto, com os checks obrigatórios.
- **CA12** · O merge na `main` publica: os quatro fronts na Vercel, a API no Render (com a migração rodando antes), o banco no Neon.
- **CA13** · No ambiente publicado, o shell chama a API pelo próprio domínio (`/api/*`), e o shell e o portal mostram a API no ar.

### H5 · Como desenvolvedor, quero as fronteiras do desenho verificadas por máquina, para a arquitetura não se perder com o tempo

- **CA14** · Na API, um teste falha se um módulo acessar o interior de outro ou se houver ciclo entre módulos.
- **CA15** · No backoffice, o lint falha se uma lib importar o que a tag dela não permite (por exemplo, Angular importando React).

### H6 · Como desenvolvedor, quero cada repo com as instruções do agente de IA, para a IA trabalhar com o contexto certo

- **CA16** · Cada repo de código tem `AGENTS.md`, `CLAUDE.md` e as regras da stack, instalados a partir de `harness/` e com as versões fixadas preenchidas.

## Telas e estados

Nenhuma tela do hi-fi. Cada app tem uma página técnica, com os tokens do design system aplicados (cores e fonte), e dois estados: API no ar e API acordando. O shell tem o estado "área não carregou" da B02 (estado 4).

## Regras de negócio

Nenhuma. Os requisitos de qualidade que esta funcionalidade começa a provar estão no `docs/hld.md`, seção 3 ("Disponibilidade" e "Manutenção").

## Fora de escopo

- Login, sessão e qualquer dado de negócio (F02 em diante).
- Layout final da moldura (F02).
- Lighthouse CI do portal (F07, quando houver página real).
- Prévia por PR com o manifesto apontando para as prévias dos remotes (questão em aberto do LLD do backoffice).
- Domínio próprio.

## Riscos de produto

| Risco | Mitigação |
| --- | --- |
| A JVM não caber na memória do plano gratuito | Medir partida a frio e memória em repouso nesta funcionalidade; ajustar as flags do LLD da API |
| Shell e remote com versões diferentes das libs compartilhadas | Versões únicas no monorepo e checagem de versão na federação |
| Camadas gratuitas com regra diferente da documentada | Descobrir agora, com um "hello world", e não com o MVP pronto |

## Questões em aberto

- [ ] Como distribuir o pacote de tokens para o portal (HLD, "Questões em aberto"). No skeleton, o portal copia o CSS gerado.
- [x] Versão do PostgreSQL oferecida pelo Neon no plano gratuito: **18** (fixada igual no Compose).
- [x] Nome do projeto no Neon: `quita`, região AWS US East 1 (junto do Render em Virginia).
- [ ] Nome da organização e dos projetos na Vercel e no Render.
