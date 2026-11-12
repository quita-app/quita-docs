# Preâmbulo: regras para gerar as telas

Este arquivo e o `README.md` desta pasta são lidos no começo de cada sessão. Eles bastam para você trabalhar sozinho, tela por tela, na ordem do README.

## Leia antes de desenhar

1. `design/PRODUCT.md`: produto, público, tom, restrições.
2. `design/DESIGN.md`: tokens e componentes aprovados.
3. `design/ux-writing.md`: **todo texto da interface vem daqui.** Use os padrões globais (seção 6), o mapa de erros da API e o catálogo da tela (seção 7). Se o prompt da tela e o `ux-writing.md` divergirem num texto, vale o `ux-writing.md`. Se faltar um texto, siga os princípios da seção 3 e liste o texto novo no resumo.
4. O prompt da tela (`portal/` ou `backoffice/`) e as telas já aprovadas em `design/hi-fi/`.

## Regras de todas as telas

1. **Consistência acima de novidade.** Só tokens e componentes do design system. Componente novo: mesmo idioma visual, listado no resumo com o motivo.
2. **Implementável** com Tailwind + shadcn/ui (React e Next.js) e Spartan UI (Angular). Nada de imagem pesada, canvas ou biblioteca de animação além de CSS e da celebração.
3. **Dados e regras reais:** números, nomes, datas e limites do prompt e de `docs/lld/api.md`. Não invente métricas, clientes nem depoimentos.
4. **Estados completos:** todos os do prompt, lado a lado. Os estados globais (servidor acordando, erro inesperado, sem internet, sessão encerrada, toasts) são desenhados **uma vez só**, na P10 e na B02; nas outras telas, não os repita: escreva no resumo quais se aplicam.
5. **Só light mode por enquanto.** O dark mode de todas as telas vem numa passada única no fim (item D1 do README), aplicando os tokens escuros do `DESIGN.md`.
6. **Tamanhos:** uma única versão web, em 1440 px, mais o celular em 390 px, no portal e no backoffice (decisão de 2026-11-11: saíram o 1280 do portal e o 1024 do backoffice). No celular do backoffice, o trilho vira barra inferior (4 itens + "Mais"), a ficha lateral vira tela cheia e a tabela vira lista de cards. Organize a prancha em seções por tamanho.
7. **Acessibilidade:** contraste AA, foco visível, rótulo em todo campo, alvo de toque ≥ 44 px no portal, nada comunicado só por cor.
8. **Cada tela conta um pedaço da história.** Use a seção "Na história" do prompt: o título e o subtítulo dizem, nas palavras do ator, para que a tela serve, e fica claro quem está do outro lado (a credora por trás da cobrança, a equipe por trás da fila). É produto de verdade: a demo usa dados de exemplo, nunca "projeto fictício".

## Ciclo de cada tela

1. Ache no `README.md` a primeira tela com status "a gerar" e mude para "em revisão".
2. Gere a tela.
3. Exporte em PNG (só claro) para `design/hi-fi/<id>-<nome>/`, para a revisão ser feita pelos prints.
4. Entregue um resumo curto: componentes usados, componentes novos, textos que não estavam no `ux-writing.md` e dúvidas de regra de negócio.
5. **Pare e espere a aprovação.** Não comece a próxima sozinho.
6. Aprovada: mude o status para "aprovada" e passe para a próxima.
7. Pedido de ajuste: ajuste, exporte de novo por cima dos PNGs antigos, entregue o resumo e espere. Respostas a dúvidas viram regra no `ux-writing.md`; releia a seção da tela antes de ajustar.

## Modo lote (quando a sessão pedir)

Gera todas as telas "a gerar" sem parar para aprovação, na ordem do README, menos o D1.

1. Mude o status da tela para "em geração", gere e exporte o PNG (só claro) como no ciclo normal.
2. **Não pare por dúvida.** Escolha a opção mais conservadora (a que segue o `ux-writing.md`, o `docs/lld/api.md` e as telas já aprovadas), aplique e registre.
3. Escreva `design/review/<id>-questions.md` com no máximo estas seções, curtas:
   - **Decisões que tomei sozinho:** o que escolheu e por quê, para cada dúvida.
   - **Textos novos:** os que não estavam no `ux-writing.md`.
   - **Componentes novos:** nome e motivo.
   - **Estados globais que se aplicam.**
   Sem dúvidas? Escreva só "Sem dúvidas."
4. Mude o status para "gerada (aguardando revisão)" e siga para a próxima.
5. Se o limite de uso acabar no meio, a próxima sessão retoma pelo primeiro status "em geração" ou "a gerar".

Depois da revisão, as correções ficam em `design/review/corrections.md`, uma seção por tela. Na sessão de correção: leia o arquivo, aplique tela por tela, reexporte, marque cada item como feito e mude o status para "aprovada".
