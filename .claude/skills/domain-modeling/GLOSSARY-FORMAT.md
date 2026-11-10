# Formato do GLOSSARY.md

## Estrutura

```md
# Quita

Plataforma B2B de cobrança e renegociação de dívidas: a Credora define a política, o Devedor negocia sozinho, o Operador cuida das exceções.

## Negociação

**Acordo** · `Agreement`
Proposta aceita e formalizada, com parcelas e entrada.
_Evitar_: contrato, negociação, deal

**Quebra** · `Breach`
Cancelamento de um Acordo por atraso de Parcela além da tolerância.
_Evitar_: cancelamento, inadimplência do acordo
```

Cada termo tem:
- o **nome em português**, que é o usado nos documentos e na conversa;
- o **nome em código**, em inglês e entre crases, que é o usado em classes, tabelas, rotas e eventos;
- a **definição**, em uma ou duas frases;
- os termos a **evitar**.

## Regras

- **Tenha opinião.** Quando várias palavras servem para o mesmo conceito, escolha a melhor e liste as outras em _Evitar_.
- **Definições curtas.** Uma ou duas frases. Diga o que a coisa **é**, não o que ela faz.
- **Só termos do domínio do Quita.** Conceitos gerais de programação (timeout, retry, cache) não entram, mesmo que o projeto os use muito. Antes de acrescentar, pergunte: este conceito é próprio do negócio de cobrança, ou é de programação? Só o primeiro entra.
- **Agrupe em subtítulos** quando surgirem grupos naturais (Carteira, Negociação, Pagamento, Atendimento).
- **O nome em código é decidido uma vez.** Mudar depois é uma refatoração em vários repos: discuta antes de trocar.

## Um contexto ou vários

**Um contexto (o começo do Quita):** um `GLOSSARY.md` na raiz do `quita-docs`.

**Vários contextos:** um `GLOSSARY-MAP.md` na raiz lista os contextos, onde moram e como se relacionam:

```md
# Mapa do glossário

## Contextos

- [Carteira](./glossary/portfolio.md): importa e mantém as dívidas
- [Negociação](./glossary/negotiation.md): simula, propõe e formaliza acordos
- [Pagamento](./glossary/payment.md): emite cobranças e concilia pagamentos

## Relações

- **Negociação → Pagamento**: Negociação emite `AgreementCreated`; Pagamento emite a cobrança da entrada
- **Pagamento → Negociação**: Pagamento emite `InstallmentPaid`; Negociação ativa ou quita o Acordo
```

A skill descobre qual estrutura vale:

- Se existir `GLOSSARY-MAP.md`, leia-o para achar os contextos.
- Se existir só o `GLOSSARY.md`, é um contexto só.
- Se não existir nenhum, crie o `GLOSSARY.md` quando o primeiro termo for resolvido.
