# Relatório final das telas

Fechamento das rodadas de geração em lote e de correção (10/11). Os PNGs (só claro) estão em `design/hi-fi/<id>-<nome>/`, e as pranchas no canvas do Claude Design, em duas áreas: Fundação, e Portal e Backoffice por fluxo.

## Globais
- Rótulo do valor grande de parcela: agora é "Entrada + {n-1} parcelas de" (P05, P06, B06, P00).
- Sem fonte manuscrita em nenhuma tela; a Caveat saiu do carregamento.
- Regra de quebra de linha aplicada em todas as pranchas: dinheiro, datas, CPF, telefones, selos, botões e cabeçalhos de coluna nunca quebram; "vence em 12/11" desce inteiro para a linha de apoio; sem reticências em cabeçalho nem em selo.

## Por tela
- P00 · Landing: refeita com hero vivo (fluxo da Ana em loop), faixa do número com contagem, problema em fundo tinta, narrativa de rolagem 01–03, bento do backoffice, princípios em tipografia grande, demo em céu e rodapé com a stack; pranchas em 1440, 1280 e 390; movimento documentado e versão sem movimento.
- P01 · Página da credora: 1280 centralizado na vertical; tamanhos reordenados.
- P02 · Acesso CPF: dica e variante CNPJ do `ux-writing.md`; só claro.
- P03 · Acesso código: telefone e e-mail mascarados sem quebra.
- P04 · Suas dívidas: próxima parcela do acordo em 12/12; total sem quebra.
- P05 · Detalhe da dívida: rótulo novo das parcelas; vencimento na linha de apoio.
- P06 · Simulador: estado de parcela mínima refeito com máximo de 5x (R$ 245,54; entrada R$ 36,83; 4 de R$ 52,17, a última R$ 52,20).
- P07 · Revisar e fechar: sem correções.
- P08 · Pix e acordo fechado: sem bilhete manuscrito; sem outras correções.
- P09 · Acompanhar o acordo: sem correções.
- P10 · Estados globais: sem correções.
- B01 · Login e convite: sem correções.
- B02 · Moldura: menu do auditor (só leitura); admin da plataforma só com Credoras, e o menu da credora só no "entrar como".
- B03 · Fila: sem busca duplicada no cabeçalho; "Última tratativa" curta e inteira; menu recolhido no 1440 para a tabela respirar.
- B04 · Busca: selo "Em negociação" com contorno, igual aos outros.
- B05 · Ficha: selo "Ativo" com largura do conteúdo no 390; próxima parcela em 12/12.
- B06 · Negociar: rodapé fixo com **Enviar proposta** no 390; nome e reserva sem quebra no 1024.
- B07 · Importações: setembro com 0 ignoradas.
- B08 · Importação em andamento: sem correções.
- B09 · Versões da Política: cabeçalhos curtos e inteiros; 390 em cards.
- B10 · Editor da Política: cabeçalhos curtos ("Desconto", "Parcelas", "Entrada mín.").
- B11 · Pagamentos: campo de associação com texto curto e inteiro.
- B12 · Usuários: Lucas Araújo ativo (coerente com o ranking da B14); convite de exemplo para Marina Costa; selo sem corte.
- B13 · Credoras: 1024 e 390; menu próprio do admin (só Credoras); cabeçalho "Devedores".
- B14 · Painel: KPIs do 390 em coluna, sem quebra de rótulo.

## Canvas
- Fundação à esquerda; Portal (P00 a P10) e Backoffice (Shell, Operação, Carteira, Política, Pagamentos, Administração, Analytics) à direita, com títulos de seção.
- Mesmo cabeçalho em todas as pranchas (id, nome, rota, status); tamanhos na ordem 1440 → 390, com os estados depois.
- Removidas as pranchas antigas da B03 e da B14.

## Rodada final e D1
- P00 · Landing: o celular do hero ficou completo no quadro final (resumo, **Ver meu acordo**, "Baixar comprovante" e o indicador do loop); "devedor" virou "cliente" no subtítulo, nos passos, no bento e na demo ("Entrar como cliente (Ana)"); a landing virou duas pranchas (1440 e 390; a 1280 saiu, a 1440 basta para o desktop), porque o canvas corta prancha acima de 8.000 px.
- D1 · Dark mode: cada tela ganhou a prancha escura ao lado da clara, com os tokens escuros do `DESIGN.md`, e o PNG `-escuro` na mesma pasta do `hi-fi` (a P01 já tinha claro e escuro na mesma prancha).

## Decisão de tamanhos (2026-11-11)
- Uma única versão web por tela, em 1440 px, mais o celular em 390 px. Saíram o 1024 do backoffice (B01 a B14; os estados que só existiam em 1024 foram refeitos em 1440) e o 1280 do portal (P01 a P10 passaram para 1440).
- O comportamento entre 1024 e 1439 px continua no `DESIGN.md` como regra de implementação, sem prancha.
- Login escuro (B01): o brilho do painel claro ficou mais discreto.
- P00 · Landing: tom de produto real (sem "portfólio", "fictício" ou GitHub); rodapé com contato, termos de uso e política de privacidade, e um Q fantasma bem apagado ao fundo.

## Rodada de auditoria (2026-11-12)
- 20 telas refeitas pela seção 5 de `docs/review/mvp-baseline.md` (P01, P03, P04, P06 a P09, B01 a B08, B10 a B14), com os textos do `ux-writing.md` e a seção "Na história" mantida; dark refeito dessas.
- P00 · Landing: o Q fantasma do rodapé fica à esquerda, atrás do logo (no 1440, `right: 850px; top: -121px`; no 390, vaza pelo canto de baixo à direita). Posição definida no canvas pela usuária; vale também para o escuro.

- Revisão da auditoria: B08 com aviso de conclusão igual aos contadores (11 erros e 1 linha ignorada) e resumo por tipo completo ("Todos" conta linhas; cada tipo conta as linhas com aquele erro); P03 com a faixa "Na história" atualizada; P07 com a rota da proposta recebida. Também atualizei a faixa "Na história" de B02, B05, B06 e B07, que tinham ficado com o texto antigo do prompt.

## Ficou para depois
- Fase 2: contestação ("Não reconheço esta dívida"), exceção ao gestor, "entrar como" da plataforma e a expiração da reserva da ficha.
- Editor da Política no celular (no 390, a Política é só leitura).
