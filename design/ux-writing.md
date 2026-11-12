# UX e escrita do Quita

2026-11-10 · Status: aprovado para prototipação

Dono de **tudo que é texto na interface**: voz, tom, padrões de mensagem, formatos e o catálogo de mensagens de cada tela. Quando um prompt de tela e este arquivo divergirem num texto, **vale este arquivo**. Produto e público: `PRODUCT.md`. Regras de negócio e valores: `docs/lld/api.md` (seções 5 e 6) e `docs/foundation/business-requirements.md`.

## 1. O que queremos transmitir

| Para quem | Sentimento ao sair da tela | Frase-guia |
| --- | --- | --- |
| Devedor (portal) | Alívio e controle: "dá para resolver, e eu entendi tudo" | Falamos com uma pessoa, não com uma dívida. |
| Operador | Foco e segurança: "sei o que fazer agora" | Uma ação clara por momento. |
| Gestor | Confiança: "o sistema aplica as minhas regras e me mostra o resultado" | Números com contexto, nunca sozinhos. |

## 2. Voz (fixa) e tom (varia)

**Voz do Quita:** calma, honesta, direta e respeitosa. Nunca cobra, nunca ameaça, nunca brinca com dinheiro.

| Situação | Tom |
| --- | --- |
| Portal, informação | Acolhedor e claro, segunda pessoa ("você") |
| Portal, erro ou limite | Neutro e prático: o que houve + o que fazer |
| Portal, acordo fechado e quitação | Caloroso, contido, sem euforia |
| Backoffice | Objetivo e técnico, vocabulário do `GLOSSARY.md` |
| Regras e consequências (atraso, quebra) | Factual, sem adjetivo, sem vermelho |

## 3. Princípios de escrita

1. **Frases curtas**, uma ideia por frase, voz ativa.
2. **O botão diz o que acontece** (verbo + objeto) e o retorno repete a palavra: "Fechar acordo" → "Acordo fechado".
3. **Erro = o que aconteceu + como resolver.** Sem "Ops", sem pedido de desculpas, sem culpar a pessoa, sem código técnico na frente (o código de suporte vai no fim, pequeno).
4. **Número com contexto:** "R$ 159,00 a menos que o valor atualizado", e não só "R$ 159,00".
5. **Sempre dizer o próximo passo** em estados vazios e de sucesso.
6. **Nada só por cor:** todo estado tem texto.
7. **Sem jargão:** nada de "baixa", "inadimplência", "título", "proposta pendente de aprovação" no portal.
8. **Sentence case** em títulos e botões ("Fechar acordo", não "Fechar Acordo"). Sem caixa-alta, sem ponto de exclamação, exceto no bilhete da credora.

## 4. Vocabulário

| Conceito (`GLOSSARY.md`) | No portal (devedor vê) | No backoffice |
| --- | --- | --- |
| Devedor | "você" (nunca "devedor", "inadimplente", "cliente") | Devedor |
| Dívida | "dívida", "conta em aberto" | Dívida |
| Valor atualizado | "valor atualizado" | Valor atualizado |
| Faixa de atraso | "em aberto há 120 dias" | Faixa (91 a 180) |
| Proposta / Simulação | "como pagar", "simular" | Proposta, Simulação |
| Acordo | "acordo" | Acordo |
| Entrada | "entrada" | Entrada |
| Quebra | "acordo cancelado por atraso" | Quebra |
| Cobrança (Pix) | "código Pix" | Cobrança |
| Contestação | "não reconheço esta dívida" | Contestação |
| Tratativa | não aparece | Tratativa |

Palavras proibidas no portal: inadimplente, devedor, débito, cobrança, dívida ativa, negativado, pendência financeira, regularize, evite, urgente, último aviso.

## 5. Formatos

| Dado | Formato | Exemplo |
| --- | --- | --- |
| Dinheiro | `R$` + espaço, ponto de milhar, vírgula decimal, tabular | R$ 1.060,00 |
| Dinheiro grande no portal | centavos menores | R$ 1.060,00 |
| Percentual | sem casa decimal quando inteiro | 15% de desconto · 23,4% |
| Data | dd/mm; com ano só se for de outro ano | 12/12 · 12/01/2027 |
| Data relativa (backoffice) | hoje, ontem, há 3 dias; depois de 7 dias, a data | ontem, 14:20 |
| Hora | 24 h | 21:40 |
| CPF no portal | completo enquanto digita; mascarado depois | 482.117.000-11 → ***.482.117-** |
| CPF no backoffice | sempre mascarado; completo só com permissão | ***.482.117-** |
| E-mail e telefone mascarados | primeira letra + domínio; últimos 4 dígitos | a***@gmail.com · (11) 9****-4321 |
| Parcelas | "5x" no seletor; "5 parcelas" no texto | |
| Código de suporte | 4+2 caracteres, no fim da mensagem | Código: 7F3A-21 |

## 6. Padrões globais de mensagem

Valem em todas as telas. Cada tela usa estes textos salvo quando o catálogo (seção 7) define outro.

| Padrão | Texto | Onde |
| --- | --- | --- |
| Carregando (até 3 s) | sem texto, só esqueleto | todas |
| Servidor acordando (após 3 s) | **Ligando o Quita.** Depois de um tempo parado, isso leva cerca de 1 minuto. Seus dados estão guardados. | todas (ADR 0007) |
| Sem internet | Você está sem internet. Assim que a conexão voltar, tentamos de novo. | todas |
| Erro inesperado | Não conseguimos carregar agora. Tente de novo em alguns instantes. · **Tentar de novo** · Código: XXXX-XX | todas |
| Sessão encerrada (portal, 15 min) | Por segurança, sua sessão foi encerrada. Entre de novo para continuar. · **Entrar de novo** | portal (RN1.4) |
| Sessão encerrada (backoffice) | Sua sessão terminou. Entre de novo para continuar de onde parou. | backoffice |
| Sem permissão | Você não tem acesso a esta área. Fale com o gestor da sua equipe. | backoffice |
| Área não carregou (remote) | Não foi possível carregar esta área. · **Tentar de novo** | backoffice |
| Campo obrigatório | Preencha este campo. | todas |
| Toast de sucesso | particípio do verbo do botão: "Acordo fechado", "Tratativa salva" | todas |
| Confirmação destrutiva | Título com a ação ("Desativar Rita Souza?") + consequência em uma frase + **Desativar** / Cancelar | backoffice |
| Conflito de versão (409 `STALE_VERSION`) | Alguém salvou mudanças enquanto você editava. · **Ver o que mudou** | backoffice |
| Demo | Ambiente de demonstração · dados de exemplo | faixa fixa, separada do produto |

### Mapa de erros da API → texto

| `code` da API | Texto na tela |
| --- | --- |
| `AGREEMENT_ALREADY_EXISTS` | Portal: Esta dívida já tem um acordo fechado. · **Ver meu acordo** / Backoffice (B06): Já existe um acordo ativo para esta dívida, fechado agora há pouco. · **Abrir acordo** / Backoffice (pagamento fora do Quita, B05): Esta dívida tem um acordo em andamento. Quem quita a dívida é o acordo. |
| `INSTALLMENTS_OUT_OF_POLICY` | Escolha entre 1 e {max} parcelas. |
| `INSTALLMENT_BELOW_MINIMUM` | Para esta dívida, o máximo é {maxInstallmentsAllowed} parcelas. |
| `DOWN_PAYMENT_BELOW_MINIMUM` | A entrada mínima para {n}x é {valor}. Aumente o valor. |
| `PROPOSAL_EXPIRED` / política mudou | As condições foram atualizadas pela {credora}. Confira a nova simulação. / Proposta recebida (P07): Esta proposta não vale mais: ela venceu ou foi trocada por outra. · **Ver minhas dívidas** |
| `PAYMENT_WINDOW_CLOSED` | O prazo para pagar esta parcela terminou em {data}. Se você já pagou, não precisa fazer nada: o pagamento aparece aqui em instantes. |
| `ACCESS_CODE_INVALID` | Código incorreto. Você tem mais {n} tentativas. |
| `ACCESS_CODE_EXPIRED` | Este código venceu. Envie um novo. |
| `ACCESS_CODE_LOCKED` | Por segurança, o acesso foi pausado por 15 minutos. Tente de novo às {hora}. |
| `ACCESS_CODE_RATE_LIMITED` | Você já pediu 3 códigos nos últimos 15 minutos. Tente de novo às {hora}. |
| `DEBTOR_LOCKED` | {nome} está atendendo este Devedor até {hora}. Você pode ver, mas não negociar. |
| `INVALID_CREDENTIALS` | E-mail ou senha incorretos. |
| `LOGIN_RATE_LIMITED` | Muitas tentativas. Tente de novo em 1 minuto. |
| `IMPORT_ALREADY_RUNNING` | Aguarde a importação em andamento terminar para enviar outra. |
| `NO_PUBLISHED_POLICY` | Portal: As condições para esta dívida ainda não estão disponíveis. Fale com a {credora}: {telefone} · {e-mail}. / Backoffice: Sem uma Política publicada, não há condição para negociar. |
| `PASSWORD_RESET_INVALID` | Este link venceu ou já foi usado. Peça um novo. · **Pedir novo link** |
| `STALE_VERSION` | padrão "Conflito de versão" acima |

## 7. Catálogo por tela

Só o que é específico de cada tela. Títulos (T), textos de apoio (A), botões (B), mensagens de estado (M). Variáveis entre chaves.

### P00 · Landing
- T: Sua credora recebe. Seu cliente resolve pelo celular, sem constrangimento.
- A: O Quita aplica a política de desconto da credora e deixa o devedor fechar o acordo sozinho, em minutos.
- B: **Ver a demo** · Como funciona · Entrar como devedora (Ana) · Entrar como operador · Entrar como gestora
- M: Ambiente de demonstração, com dados de exemplo.

### P01 · Página da credora
- T: Coloque suas contas com a {credora} em dia
- A: Veja quanto deve e por quê, simule parcelas e pague a entrada por Pix. Leva poucos minutos.
- B: **Consultar minhas dívidas**
- M (selo): Ambiente seguro. Seus dados são usados só para este atendimento. · Operado por quita
- Rodapé: Fale com a {credora}: {telefone} · {e-mail} (do cadastro da credora) · Termos de uso · Privacidade (sempre os do Quita)
- M (404): Não encontramos esta página. Confira o link que você recebeu da credora. (sem nome: o slug não existe)

### P02 · CPF
- T: Para começar, informe seu CPF
- A: Vamos enviar um código de 6 dígitos para o e-mail e o celular cadastrados na {credora}.
- Dica do campo (CPF e CNPJ): Só números. A gente põe a pontuação.
- B: **Enviar código** · Sou empresa e tenho CNPJ
- Variante CNPJ: T "Para começar, informe seu CNPJ" · link de volta "Sou pessoa física e tenho CPF" · M (inválido) "Confira os números do CNPJ."
- M (inválido): Confira os números do CPF.
- M (limite): mapa de erros, `ACCESS_CODE_RATE_LIMITED`. **Enviar código** fica desabilitado até o `retryAt`, com o horário na mensagem; quando passa, o botão volta sozinho. A API continua recusando se alguém forçar.
- **Voltar:** sempre leva para a página da credora (`/c/[slug]`), mesmo se a pessoa chegou direto por link. É um link, não `history.back()`, para nunca tirar a pessoa do portal.
- **Regra:** depois de enviar, a tela segue para P03 sempre, exista ou não o CPF (RN, proteção contra enumeração). Nunca escrever "CPF não encontrado".

### P03 · Código
- T: Digite o código que enviamos
- A: Se o seu CPF tiver cadastro na {credora}, enviamos um código para o e-mail e o celular informados por ela.
- **Regra:** nunca mostrar o e-mail nem o telefone, nem mascarados: a API responde igual exista ou não o CPF, e mostrar o contato revelaria que a pessoa deve (proteção contra enumeração).
- B: **Entrar** · Enviar de novo (disponível em {mm:ss}) · Trocar CPF
- M: mapa de erros, `ACCESS_CODE_*`.
- M (demo): Na demonstração, o código aparece na caixa de saída simulada. · Abrir caixa de saída

### P04 · Suas dívidas
- T: Olá, {primeiro nome}
- A (1 dívida): Você tem 1 dívida em aberto. Dá para resolver agora, por aqui.
- A (2+): Você tem {n} dívidas em aberto, somando {total}.
- Card: {credora} · {descrição} · Em aberto há {dias} dias · Valor atualizado · Valor original · Multa e juros
- B: **Ver como pagar**
- Card com proposta aberta: A {credora} enviou uma proposta para esta dívida · válida até {data} às {hora} · **Ver proposta**
- Seção: Seus acordos · {descrição}: {pagas} de {total} parcelas pagas · próxima em {data}
- M (vazio): Você está em dia com a {credora}. Se receber um novo aviso, é só voltar por este link.
- Rodapé: Você vê só o que a {credora} enviou. · Não reconheço esta dívida

### P05 · Composição do valor
- T: {descrição}
- B: Entenda este valor
- Linhas: Valor original · Multa por atraso (2%) · Juros (1% ao mês, {dias} dias) · Correção · **Valor atualizado**
- A (rodapé): A multa segue o limite do Código de Defesa do Consumidor.
- M (correção zero): A {credora} não cobra correção.

### P06 · Simulador
- T: Como você quer pagar?
- A: Quanto menos parcelas, maior o desconto.
- Rótulos: À vista · Entrada + {n-1} parcelas de (acima do valor grande, que é o valor de cada parcela; a entrada costuma ser diferente, então "{n} parcelas · cada uma" está proibido) · Entrada, por Pix · Mais {n-1} parcelas · Total · Você deixa de pagar
- A (centavo): A última fica com {valor}, por causa dos centavos.
- Campo: Quero dar uma entrada maior · Mínimo de {valor}
- B: **Revisar acordo**
- M: mapa de erros, `DOWN_PAYMENT_BELOW_MINIMUM`, `INSTALLMENT_BELOW_MINIMUM`.
- M (sem política, `NO_PUBLISHED_POLICY`): As condições para esta dívida ainda não estão disponíveis. Fale com a {credora}: {telefone} · {e-mail}. (sem simulador e sem **Revisar acordo**)
- Leitor de tela: "{n} parcelas, entrada de {valor por extenso}, desconto de {p}%".

### P07 · Revisar e fechar
- T: Confira seu acordo
- Linhas: {n} parcelas · Total {total} · {p}% de desconto · cronograma com datas
- A (regra de atraso, RN5.1 e RN5.2): Se uma parcela atrasar mais de {tolerância} dias, o acordo é cancelado e o desconto deixa de valer. O que você já pagou é descontado da dívida.
- A (ativação): O acordo começa a valer quando a entrada for paga.
- Caixa: Li e concordo com as condições
- B: **Fechar acordo** · Voltar e mudar · (carregando) Fechando
- M: mapa de erros, `AGREEMENT_ALREADY_EXISTS`, `PROPOSAL_EXPIRED`.
- Proposta recebida (link do e-mail ou SMS): T Confira a proposta da {credora} · A: Proposta enviada por {nome do operador}, válida até {data} às {hora}. · mesmas linhas, regra de atraso e caixa "Li e concordo" · B: **Fechar acordo** · Ver outras condições (vai ao simulador; se ela fechar outra condição, esta proposta deixa de valer)

### P08 · Pix e acordo fechado
- T: Pague a entrada por Pix
- A: {valor} · pague até {data} às 23:59.
- Passos: 1. Abra o app do seu banco. 2. Escolha Pix copia e cola. 3. Cole o código.
- B: **Copiar código Pix** → Código copiado · Já paguei · (demo) Simular pagamento
- M (aguardando): Aguardando o pagamento. Esta tela atualiza sozinha.
- M (processando): Pagamento em processamento. Pode levar alguns segundos.
- M (vencido, RN6.4): Este código venceu. Gere um novo para pagar a entrada. · **Gerar novo código Pix**
- M (prazo encerrado, `PAYMENT_WINDOW_CLOSED`): mapa de erros. Sem **Gerar novo código Pix**.
- Validade do código: até 24 h, nunca depois do último dia para pagar a parcela (o vencimento, na entrada; o vencimento + {tolerância}, nas outras).
- Sucesso T: **Acordo fechado**
- Sucesso A: A entrada de {valor} foi paga. Faltam {n} parcelas, e a próxima vence em {data}.
- Bilhete da credora: fora do MVP (fonte manuscrita extra pesa no LCP). Volta na Fase 3 com o white-label.
- B: **Ver meu acordo**

### P09 · Acompanhar o acordo
- T: Seu acordo com a {credora}
- A: {pagas} de {total} parcelas pagas · {valor pago} de {total}
- Próxima: {valor} · vence em {data} · **Pagar com Pix**
- M (vencida na tolerância): A parcela de {data} venceu. Pague até {data + tolerância} para manter o acordo.
- M (quitado): **Dívida quitada.** Você pagou tudo o que combinou com a {credora}.
- M (quebrado, RN5.2): Este acordo foi cancelado porque a parcela de {data} atrasou mais de {tolerância} dias. Os {valor pago} que você pagou foram descontados da dívida. · **Ver como pagar o restante**
- Ajuda: Precisa mudar o acordo? Fale com a {credora}: {telefone} · {e-mail}.
- {tolerância} = `breach_tolerance_days` da Política publicada (10 dias no exemplo da Ana); {telefone} e {e-mail} = contato do cadastro da credora.

### P10 · Estados globais
- Usa só os padrões da seção 6.

### B01 · Login e convite
- T: Entrar no Quita · B: **Entrar** · Esqueci minha senha
- Convite T: A {credora} convidou você como {papel} · B: **Criar conta e entrar**
- Critérios de senha (ao vivo): 10 caracteres ou mais · uma letra e um número
- M: mapa de erros, `INVALID_CREDENTIALS`, `LOGIN_RATE_LIMITED` · Convite vencido: Este convite venceu. Peça um novo ao gestor da {credora}.
- Recuperar senha T: Recuperar senha · A: Informe seu e-mail. Se ele tiver cadastro, enviamos um link para criar uma nova senha. · B: **Enviar link** · Voltar para o login
- Recuperar senha M (enviado, sempre igual): Se o e-mail tiver cadastro, o link chega em alguns minutos. Ele vale por 1 hora.
- Nova senha T: Crie uma nova senha · B: **Salvar nova senha** → Senha alterada. Entre com a nova senha. · M: mapa de erros, `PASSWORD_RESET_INVALID`

### B02 · Moldura
- Notificações: Pagamento conciliado: {nome}, {valor} · Importação de {mês} concluída com {n} erros · {nome} pediu uma exceção (Fase 2)
- Notificações (vazio): Nenhuma notificação nesta sessão. (no MVP, só as que chegam ao vivo; somem ao recarregar)
- Faixa de "entrar como" (Fase 2): Você está vendo como {credora} · Sair

### B03 · Fila
- T: Fila de hoje · A: {dia da semana}, {data} · {credora}
- KPIs: Devedores na fila · Acordos hoje · Valor recuperado hoje
- Linha de contexto dos KPIs (sem metas: o produto não tem meta cadastrada): Devedores na fila → {n} com promessa para hoje · Acordos hoje → {n} a mais que ontem · Valor recuperado hoje → {n} entradas pagas · ticket médio de {valor}
- Filtros: Todos · uma pílula por Faixa da Política publicada (com as 5 padrão: Até 30 dias · 31 a 90 · 91 a 180 · 181 a 360 · Mais de 360) · Promessa hoje · Nunca contatado
- KPIs do Operador: só os números dele (Acordos e valor dos Devedores da Fila dele; regra de atribuição no LLD da API, 5.12)
- B: **Próximo da fila** · Abrir ficha
- M (vazio): Fila em dia. Nenhum Devedor esperando contato agora. Novos casos aparecem quando a carteira é atualizada.
- M (reservado): Com {nome}
- Atalhos: J próximo · K anterior · Enter abrir ficha

### B04 · Busca
- Placeholder: Nome, CPF, contrato ou telefone
- M: Digite pelo menos 3 caracteres. · Nenhum Devedor encontrado para "{termo}". Confira o termo ou limpe os filtros. · Buscas recentes
- Filtro de Faixa: as Faixas da Política publicada (mesma lista da Fila)
- B: **Nova dívida**
- Nova dívida T: Nova dívida · A: Para uma dívida avulsa. Use os mesmos dados de uma linha do modelo de importação.
- Campos: CPF/CNPJ · Nome · E-mail · Celular (com DDD) · Contrato · Descrição (opcional) · Valor original · Vencimento
- Dica de contato: Informe o e-mail, o celular ou os dois. Sem contato, o Devedor não recebe o código de acesso.
- M (sem contato): Informe o e-mail ou o celular. · M (CPF já cadastrado): Este CPF já tem cadastro. A dívida entra na ficha de {nome}.
- B: **Cadastrar dívida** → Dívida cadastrada · M (mesmo contrato com acordo ativo): Esta dívida tem um acordo ativo e não pode ser alterada.

### B05 · Ficha
- A: Em atendimento por você · reserva até {hora}
- B: **Registrar tratativa** · Negociar · Registrar promessa · Mostrar CPF (Fase 2, F17: no MVP o CPF é sempre mascarado e o botão não aparece)
- Tratativa: Tipo (Ligação, Mensagem, Nota) · O que aconteceu? · **Salvar tratativa** → Tratativa salva
- Promessa: Pagar até · Valor prometido · **Registrar promessa** → Promessa registrada
- M: mapa de erros, `DEBTOR_LOCKED` · Ao vivo: Pagamento recebido: {valor}
- Dívida com proposta aberta: Proposta enviada por {nome} · válida até {data} às {hora}
- Dívida quitada fora do Quita: Paga fora do Quita · registrado por {nome} em {data} · {nota}
- B (só gestor): Registrar pagamento fora do Quita
- Diálogo: T Registrar pagamento fora do Quita? · A: A dívida {descrição} fica quitada e {Devedor} sai da Fila. A proposta aberta, se houver, deixa de valer. Não conta como valor recuperado. · Campo: Nota (como e quando foi pago) · B: **Registrar pagamento** / Cancelar → Pagamento registrado. Dívida quitada.
- M (nota vazia): Escreva como e quando a dívida foi paga. · M (acordo em andamento): mapa de erros, `AGREEMENT_ALREADY_EXISTS`.

### B06 · Negociar
- Rótulo: Política da faixa: até {p}% à vista, até {n} parcelas, entrada mínima de {p}%, parcela mínima de {valor}.
- B: **Enviar proposta à {nome}** · Copiar resumo · Pedir exceção ao gestor (Fase 2)
- A: O acordo só nasce quando {nome} aceitar no portal.
- M (fora da política): Esta condição está fora da Política. Ajuste os valores. (Pedir exceção: Fase 2)
- M (proposta aberta): {nome} já tem uma proposta aberta, válida até {data} às {hora}. Enviar esta substitui a anterior. · **Enviar e substituir** / Cancelar
- M (criado): Proposta enviada. {nome} recebe o link por e-mail e SMS e pode aceitar no portal até {data} às {hora}.
- M: mapa de erros, `AGREEMENT_ALREADY_EXISTS`.

### B07 · Importações
- T: Importações · B: **Nova importação** · Baixar modelo · **Importar {n} linhas**
- Área: Solte o arquivo CSV aqui ou escolha no computador. Até 10 MB e 100 mil linhas.
- Modelo (texto curto ao lado de "Baixar modelo"): O modelo tem uma linha de exemplo. Uma linha por dívida, separada por ponto e vírgula. Pode salvar como CSV no Excel.
- Colunas do modelo: **CPF/CNPJ** (com ou sem pontuação) · **Nome** · **E-mail** e **Celular** (com DDD; pelo menos um dos dois) · **Contrato** · Descrição (opcional, ex.: Mensalidade de agosto) · **Valor original** (1.000,00) · **Vencimento** (dd/mm/aaaa)
- M (inválido): Este arquivo não é um CSV. · O arquivo passa de 10 MB. · Faltam as colunas {colunas}. Confira o cabeçalho com o modelo.
- Pré-validação (antes de enviar): {total} linhas · {n} com problema · resumo por tipo: {n} · CPF inválido · {n} · Vencimento em formato errado · {n} · Sem e-mail e sem celular
- A (pré-validação com problema): As linhas com problema não vão entrar. Você pode enviar agora e corrigir depois pelo relatório de erros.
- M: mapa de erros, `IMPORT_ALREADY_RUNNING` · Vazio: Nenhuma importação ainda. Comece pelas dívidas deste mês.

### B08 · Importação em andamento
- A: {processadas} de {total} linhas · {válidas} válidas · {erros} com erro · {ignoradas} ignoradas
- M (fallback): Atualizando a cada 5 segundos.
- M (fim sem erros): Importação concluída. {n} dívidas prontas para a Fila.
- M (fim com erros): Importação concluída com {n} erros. As linhas com erro não entraram. · **Baixar relatório de erros**
- A (relatório): O relatório traz as linhas com erro, do jeito que estavam, e uma coluna "Erro" no fim. Corrija ali mesmo e envie o arquivo de novo. As linhas certas já entraram e não serão duplicadas.
- Resumo por tipo (antes da tabela; clicar filtra): {n} · CPF inválido · {n} · Vencimento em formato errado · {n} · Sem e-mail e sem celular · …
- Erros de linha: CPF inválido · Nome em branco · Sem e-mail e sem celular · O valor precisa ser maior que zero · Vencimento em formato errado (use dd/mm/aaaa) · Data inválida ou no futuro · Dívida com acordo ativo, linha ignorada · Dívida já quitada, linha ignorada (RN2.3)
- Linha com várias falhas: todas aparecem juntas, separadas por " · ".
- M (falhou): A importação parou. Nenhuma dívida foi perdida. · **Tentar de novo**
- M (parou cedo, `early_fail_rate`): A importação parou porque quase todas as primeiras linhas têm erro. Parece que as colunas estão em outra ordem: confira o cabeçalho com o modelo. · **Baixar modelo**

### B09 e B10 · Política
- T: Política de negociação · Versão {n} · publicada em {data} por {nome}
- B: **Nova versão** · Continuar editando · Salvar rascunho · **Publicar versão {n}**
- Confirmação de publicação: Publicar a versão {n}? Novas propostas seguem estas regras. Acordos já fechados não mudam.
- Validação: As faixas {a} e {b} se sobrepõem. · Falta cobrir de {x} a {y} dias. · O desconto vai de 0% a 100%. · A primeira faixa começa em 0 dias. · Só a última faixa fica sem limite de dias. · A Política precisa de pelo menos 1 faixa. · Use no máximo 5 faixas.
- Faixas: B: Acrescentar faixa (desabilitado com 5, dica "Máximo de 5 faixas") · Remover faixa (desabilitado com 1) · A: A Política começa com 5 faixas. Edite, remova ou acrescente, até 5.
- M (sem política): Sem uma Política publicada, o portal não oferece acordos. Crie a primeira versão.
- Saída: Sair sem salvar? As mudanças deste rascunho serão perdidas.

### B11 · Pagamentos não conciliados
- Motivos: Valor diferente da parcela (inclui pagamento incompleto) · Cobrança não encontrada · Cobrança encerrada (o acordo foi cancelado ou quebrado antes do pagamento)
- A (sem crédito nem estorno no MVP): Resolva à mão e registre na nota o que foi combinado com o Devedor.
- B: **Associar à parcela** · Marcar como resolvido (nota obrigatória)
- M (vazio): Todos os pagamentos estão conciliados.

### B12 · Usuários
- Papéis: Gestor · Operador (não há papel só leitura)
- B: **Convidar pessoa** · Reenviar convite · Mudar papel · Desativar
- M: Este e-mail já foi convidado. · Convite enviado para {email}. · Convite reenviado para {email}. O link anterior deixou de valer. · Papel alterado.
- Confirmação de desativar: Desativar {nome}? A pessoa sai do Quita na hora e não entra mais. · **Desativar** / Cancelar → Usuário desativado

### B13 · Credoras
- B: **Nova credora**
- Dica do slug: Vira o endereço do portal: quita.app/c/{slug}
- M: Este endereço já está em uso. · Credora criada. Enviamos o convite para {email}.
- Seção "Portal da credora": Nome de exibição (dica: Como o devedor vê a credora no portal) · Logo (opcional; dica: PNG ou WebP, até 256 KB e 1024 px. Sem logo, o portal mostra as iniciais.) · Cor de assinatura (opcional; dica: Sem cor, o portal usa o tema padrão.) · E-mail de atendimento · Telefone de atendimento (dica: Aparecem no rodapé do portal e na ajuda do acordo.)
- M (logo): Use PNG ou WebP. · O logo passa de 256 KB. · O logo passa de 1024 px.
- M (cor): Esta cor não tem contraste suficiente com o texto do botão. Escolha uma cor mais escura.

### B14 · Painel
- MVP (F14): Recuperado no mês · Taxa de recuperação · Acordos ativos · Quebrados no mês · recuperação por semana · aging por Faixa da Política publicada. Conversão do autoatendimento, funil e ranking de operadores são da F21 (o hi-fi mostra o painel completo como visão de futuro).
- KPIs: Recuperado no mês · Taxa de recuperação · Acordos ativos · Quebrados no mês · Conversão do autoatendimento (F21)
- Linha de contexto dos KPIs: comparação com o mês anterior ("+2,1 pontos sobre outubro"), nunca com meta (o produto não tem meta cadastrada)
- Filtros: Período · Faixa · Operador (não há filtro de carteira: a carteira é uma só; a comparação por safra é da F21)
- KPI extra no lugar da meta (F21): **Tempo até o acordo** · mediana de 3 min 40 s do primeiro acesso ao portal até o acordo fechado (calculado com o horário do código de acesso e o da criação do Acordo)
- KPI extra (F21): **Promessas cumpridas** · 72% das promessas de pagamento do mês foram pagas até a data
- A: Números atualizados há {n} minutos.
- Funil: Acessaram o portal · Simularam · Fecharam acordo · Pagaram a entrada · Quitaram
- M (sem dados): Ainda não há acordos neste período. · Card com erro: Não foi possível carregar este gráfico. · **Tentar de novo**
- B: Exportar CSV

## 8. Mensagens da caixa de saída (e-mail e SMS)

Simuladas no MVP (`notification.outbox_message`). O `template_key` é o nome em código; o texto segue a voz do portal. SMS: uma frase e o link.

| `template_key` | Evento | Texto |
| --- | --- | --- |
| `access_code` | `AccessCodeRequested` | Seu código de acesso à {credora} é {código}. Ele vale por 10 minutos. Não compartilhe. |
| `user_invitation` | `UserInvited` | A {credora} convidou você para o Quita como {papel}. Crie sua senha: {link} (vale por 7 dias). |
| `password_reset` | `PasswordResetRequested` | Para criar uma nova senha no Quita, use este link: {link}. Ele vale por 1 hora. Se não foi você, ignore. |
| `charge_issued` | `ChargeIssued` | Seu código Pix de {valor} para a {credora} está pronto. Pague até {data} às {hora}: {link} |
| `proposal_sent` | `ProposalCreated` (só as do backoffice) | {primeiro nome}, a {credora} preparou uma proposta para você: {n} parcelas, total de {valor}. Confira e aceite até {data} às {hora}: {link} |
