# P09 · Acompanhar o acordo

**App:** portal · **Rota:** `/c/escola-horizonte/agreements/[agreementId]` · **Quem:** a Ana, semanas depois · **Tamanhos:** celular e desktop

## Na história

- **Ator e papel:** Ana, a devedora: acompanha o acordo até a última parcela.
- **História:** Como devedora, quero ver o que já paguei e o que falta, para não perder nenhuma parcela.
- **Momento:** Semanas depois do acordo fechado (P08), volta pelo link para pagar a próxima parcela.
- **O que a tela precisa deixar claro:**
  - Em que ponto do acordo ela está, num olhar.
  - Qual é a próxima ação e a data dela.

## Objetivo

Ver em que pé está e pagar a próxima parcela em um toque.

## Conteúdo

- Status: ativo, 2 de 5 parcelas pagas.
- Progresso visual (barra ou anel): R$ 326,61 de R$ 901,00 pagos.
- Próxima parcela em destaque: R$ 191,46, vence em 12/01, **Pagar com Pix**.
- Linha do tempo das parcelas: pagas (com a data do pagamento), a próxima, as futuras.
- Ajuda: "Precisa mudar o acordo? Fale com a Escola Horizonte", com o telefone e o e-mail de atendimento do cadastro da credora.

## Estados

1. Ativo, em dia.
2. Parcela vencida dentro da tolerância: aviso calmo, "A parcela de 12/01 venceu. Pague até 22/01 para manter o acordo."
3. Quitado: todas pagas, celebração estática (sem animação), "Dívida quitada". O comprovante em PDF fica fora do MVP.
4. Acordo cancelado por atraso: explicação neutra do que aconteceu, quanto foi abatido e o caminho para negociar de novo.

## Notas

- O prazo de tolerância ("Pague até 22/01", "atrasou mais de 10 dias") vem da versão da Política que regeu a proposta do acordo (`breach_tolerance_days`); no hi-fi, use 10 dias.
