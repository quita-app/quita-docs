# Product Brief: Quita

2026-11-10 · helloWorldRuan · Status: aprovado

## Visão geral

O Quita é uma plataforma B2B de cobrança e renegociação de dívidas para empresas de médio porte. A credora sobe a carteira de inadimplentes e define até onde aceita negociar. O devedor resolve sozinho, pelo celular, em poucos minutos, e os operadores da credora cuidam só das exceções. O gestor acompanha quanto recuperou.

Promessas:
- **Autoatendimento sem constrangimento:** o devedor vê quanto deve, por quê, simula condições e fecha o acordo sem falar com ninguém.
- **Política em vez de improviso:** desconto, parcelas e entrada seguem regras da credora por faixa de atraso, e nenhum atendente negocia fora delas sem aprovação.
- **Nenhum acordo esquecido:** pagamentos caem sozinhos, atrasos viram quebra no prazo certo e a dívida volta para a fila de um operador.
- **Recuperação visível:** o gestor vê, em números, quanto recuperou, onde e com quem.

## Problema e contexto

Credoras de médio porte (escolas, clínicas, academias, varejo regional, SaaS) cobram inadimplentes por planilha, e-mail e WhatsApp. Cada atendente negocia de um jeito, o desconto depende de quem atende, acordos quebram sem ninguém perceber e o gestor não sabe quanto recuperou. Do outro lado, o devedor evita ligar por vergonha e porque não entende de onde vem o valor cobrado. As grandes plataformas de renegociação atendem bancos e grandes varejistas; a credora média fica com a planilha.

Hipóteses (não validadas):
- O devedor fecha mais acordos quando pode simular sozinho, a qualquer hora, do que quando depende de um atendente.
- Uma política de desconto por faixa de atraso recupera mais do que a negociação caso a caso, porque oferece o desconto certo para a chance real de recebimento.
- Credoras de médio porte pagam por uma ferramenta que reduz o custo de cobrar e mostra o resultado.

## Público-alvo

- **Perfil principal:** gestor financeiro de uma credora de médio porte, com de 1 mil a 50 mil devedores ativos e de 1 a 10 pessoas cobrando.
- **Gatilho de uso ou de compra:** a inadimplência cresce, a cobrança por planilha não dá conta e o gestor não consegue dizer quanto recuperou no mês.
- **Fora do foco inicial:** bancos e grandes varejistas, assessorias de cobrança que atendem várias credoras, dívidas de pessoa jurídica com negociação jurídica, e cobrança judicial.

Usuários do sistema: Gestor da credora, Operador de cobrança, Devedor e Admin da plataforma (definições em `GLOSSARY.md`).

## Modelo de negócio e planos

Mensalidade por faixa de devedores ativos, mais uma taxa de sucesso sobre o valor recuperado. Valores: a definir. A cobrança da taxa e o split de pagamento ficam fora do produto construído: o modelo existe para dar sentido ao painel e às métricas.

## Objetivos e métricas de sucesso

As métricas do produto são hipóteses de portfólio, sem dados reais; servem para orientar o painel e as decisões.

| Métrica | O que mede | Meta em 8 semanas |
| --- | --- | --- |
| Taxa de recuperação | Valor recebido ÷ valor da carteira | Calculada e exibida no painel |
| Conversão do autoatendimento | Devedores que fecharam acordo ÷ devedores que acessaram o portal | Calculada e exibida no painel |
| Taxa de quebra | Acordos quebrados ÷ acordos fechados | Calculada e exibida no painel |
| Fluxo da Ana de ponta a ponta | Do link ao acordo pago, no ambiente publicado | Funciona em menos de 3 minutos no celular |
| Entrega do projeto | Módulos do roadmap publicados | MVP na semana 5, projeto completo na semana 8 |

## Escopo do MVP

Plataforma web: backoffice para credoras, portal público para devedores e API.

1. O admin cadastra uma credora, e o gestor convida operadores.
2. O gestor importa uma carteira de dívidas por CSV e vê o relatório de erros.
3. O gestor define a política de negociação por faixa de atraso.
4. O devedor entra no portal com CPF e código, vê as dívidas com o valor atualizado e o que o compõe.
5. O devedor simula condições, fecha o acordo e paga a entrada por Pix simulado.
6. O pagamento é confirmado sozinho, e o acordo fica ativo; parcela em atraso além da tolerância quebra o acordo.
7. O operador trabalha a fila, abre a ficha do devedor, registra tratativas e negocia pelo devedor.
8. O gestor vê os indicadores principais da carteira.

## Fora de escopo

- Cobrança e repasse da taxa do Quita (split de pagamento).
- Envio real de e-mail e SMS: tudo vai para uma caixa de saída simulada.
- Gateway de pagamento real, boleto bancário real e negativação em birôs de crédito.
- App mobile nativo.
- Candidatos às fases seguintes: versões e exceções de política, régua de cobrança, LGPD e auditoria completas, white-label, chat em tempo real.

## Requisitos não funcionais e restrições

| Área | Requisito |
| --- | --- |
| Isolamento | Dados de uma credora nunca aparecem para outra, provado por teste automatizado |
| Desempenho | Listagens com p95 < 300 ms com 1 milhão de dívidas; LCP do portal < 2,5 s em 4G |
| Acessibilidade | Portal com WCAG 2.2 AA, nota 100 no Lighthouse Acessibilidade, uso completo por teclado |
| Segurança | OWASP Top 10 como checklist de revisão; dado sensível mascarado e fora dos logs |
| Conformidade | Regras do CDC (art. 42 e 43, multa de 2%) e da LGPD aplicadas como regras do sistema |
| Localização | Interface em pt-BR, moeda BRL, fuso de São Paulo |
| Stack (restrição imposta) | Micro front-ends com Angular, React e Next.js; back em Java com Spring Boot; escolhida para demonstrar arquitetura de micro front-ends e back orientado a domínio |
| Prazo (restrição imposta) | Projeto completo em 8 semanas, a partir de 2026-11-10 |
| Equipe e orçamento | Uma pessoa, 4 h por dia; orçamento de infraestrutura próximo de zero (camadas gratuitas) |

## Alternativas e concorrentes

| Alternativa | Pontos fortes | Pontos fracos para o público-alvo | Nosso posicionamento |
| --- | --- | --- | --- |
| Planilha + WhatsApp | Grátis, todo mundo sabe usar | Sem política, sem controle de quebra, sem números | Substituir o improviso por política e autoatendimento |
| Serasa Limpa Nome, Acordo Certo | Alcance enorme, devedor já conhece | Feitos para grandes credoras; a média não entra | A mesma experiência para a credora média |
| Assessoria de cobrança | Equipe pronta, experiência | Comissão alta, a credora perde o controle e a visão | A credora cobra sozinha, com ferramenta |
| Software de cobrança tradicional | Completo para operação | Pensado para assessorias; caro e complexo | Simples, com autoatendimento no centro |

Preços e detalhes dos concorrentes: a definir (pesquisa).

## Riscos, dependências e premissas

Maior risco: o escopo não caber em 8 semanas para uma pessoa aprendendo as tecnologias ao mesmo tempo.

| Risco | Mitigação |
| --- | --- |
| Escopo maior que o prazo | MVP fechado até a semana 5; cada fase tem um corte definido no roadmap, e o chat é o primeiro a sair se atrasar |
| Integração entre micro front-ends, API e hospedagem dar problema tarde | Walking skeleton na semana 1 resolve a integração antes das regras de negócio |
| Domínio abstrato para explicar | Exemplo da Ana como roteiro de demonstração |
| Cálculo de dinheiro errado | Regras com números testáveis e testes de regra de negócio desde a primeira tarefa |
| Custo de hospedar 5 apps e um banco | Camadas gratuitas e um ambiente só (produção de demonstração) |

**Dependências:** serviços de hospedagem com camada gratuita (a definir no HLD); gateway de pagamento simulado construído no próprio projeto.

**Premissas:** as três hipóteses de "Problema e contexto".

## Roadmap

Prazo total de 8 semanas a partir de 2026-11-10, com 4 h por dia.

- **Semana 1, fundação:** planejamento, protótipo e walking skeleton (todos os apps publicados, conversando de ponta a ponta).
- **Semanas 2 a 5, MVP:** os 8 itens do escopo do MVP, na ordem do fluxo da Ana.
- **Semanas 6 e 7, profundidade:** versões e exceções de política, régua de cobrança, LGPD e auditoria, white-label.
- **Semana 8, lançamento:** chat em tempo real (se o prazo permitir), painel completo, carga com 1 milhão de registros, READMEs e demo pública.

Cada fase só começa com a anterior publicada. A ordem detalhada fica em `docs/roadmap.md`.

## Questões em aberto

- [ ] Valores do modelo de negócio (mensalidade e taxa de sucesso).
- [ ] Pesquisa de preços e detalhes dos concorrentes.
- [ ] Pagamento que chega depois da quebra: crédito ou estorno.
- [ ] Pix e boleto, ou só Pix no MVP.

## Glossário

O vocabulário do domínio está em `GLOSSARY.md`.
