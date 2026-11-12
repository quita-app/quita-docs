# Quita

Plataforma B2B de cobrança e renegociação de dívidas: a Credora define a política, o Devedor negocia sozinho e o Operador cuida das exceções.

## Pessoas e empresas

**Credora** · `Creditor`
Empresa cliente do Quita, dona das dívidas cobradas. É o tenant do sistema.
_Evitar_: cliente, empresa, tenant (fora do código)

**Devedor** · `Debtor`
Pessoa física ou jurídica que deve a uma Credora. Pode ter várias Dívidas na mesma Credora.
_Evitar_: cliente, inadimplente, consumidor

**Gestor** · `Manager`
Pessoa da Credora que configura a Política, importa Dívidas, registra pagamento fora do Quita e acompanha os resultados.
_Evitar_: admin, dono

**Operador** · `Operator`
Pessoa da Credora que atende Devedores pela Fila e envia Propostas a eles. Nunca cria Acordo direto.
_Evitar_: atendente, agente, cobrador

**Admin da plataforma** · `PlatformAdmin`
Pessoa do time do Quita que cadastra Credoras e dá suporte.
_Evitar_: admin (sozinho), superusuário

## Carteira

**Carteira** · `Portfolio`
O conjunto de todas as Dívidas de uma Credora ("a carteira da escola tem 1.200 devedores"). Cada Credora tem uma só.
_Evitar_: lote, arquivo, base, "carteira de outubro"

**Importação** · `PortfolioImport`
Um arquivo de Dívidas enviado de uma vez pelo Gestor. A Dívida guarda a Importação que a criou, e ela nunca muda.
_Evitar_: carteira (para um arquivo), lote, upload

**Safra** · `Cohort`
O recorte das Dívidas pelo mês em que entraram no Quita ("a safra de setembro recuperou 18%"). Da Fase 3 (F21).
_Evitar_: carteira do mês, lote

**Dívida** · `Debt`
Valor devido por um Devedor a uma Credora, vindo de um contrato, com vencimento original.
_Evitar_: título, débito, conta

**Faixa de atraso** · `AgingBucket`
Classificação de uma Dívida pelos dias de atraso desde o vencimento original. As Faixas são da Política publicada da Credora: de 1 a 5, começando pelas 5 padrão (0–30, 31–90, 91–180, 181–360, mais de 360).
_Evitar_: aging (fora do código), categoria

**Valor atualizado** · `UpdatedAmount`
Principal da Dívida mais multa, juros de mora e correção, calculado numa data.
_Evitar_: saldo, valor corrigido, total

## Negociação

**Política de negociação** · `NegotiationPolicy`
Regras da Credora sobre desconto máximo, parcelas, entrada mínima e validade da Proposta, por Faixa de atraso.
_Evitar_: regra, configuração, tabela de desconto

**Simulação** · `Simulation`
Cálculo de uma condição de pagamento, sem compromisso.
_Evitar_: cotação, orçamento

**Proposta** · `Proposal`
Condição de pagamento escolhida e enviada, com validade. No portal, o Devedor cria e aceita na mesma tela; pelo backoffice, o Operador envia e o Devedor aceita pelo link. Uma aberta por Dívida. Fora da Política, depende de aprovação do Gestor (Fase 2).
_Evitar_: oferta, pedido

**Exceção** · `PolicyException`
Pedido de um Operador para oferecer uma condição fora da Política.
_Evitar_: aprovação especial, override

**Acordo** · `Agreement`
Proposta aceita e formalizada, com Entrada e Parcelas.
_Evitar_: contrato, negociação, renegociação

**Parcela** · `Installment`
Cada pagamento previsto num Acordo.
_Evitar_: prestação, boleto

**Entrada** · `DownPayment`
A primeira Parcela de um Acordo; o Acordo só fica ativo depois que ela é paga.
_Evitar_: sinal, primeira parcela

**Quebra** · `Breach`
Fim de um Acordo por atraso de Parcela além da tolerância; a Dívida volta a ficar em aberto.
_Evitar_: cancelamento, inadimplência do acordo

**Contestação** · `Dispute`
Declaração do Devedor de que não reconhece uma Dívida; suspende a cobrança até a análise.
_Evitar_: reclamação, recurso

## Pagamento

**Cobrança** · `Charge`
Pix ou boleto emitido para uma Parcela.
_Evitar_: fatura, boleto (como termo geral)

**Pagamento** · `Payment`
Valor recebido pelo gateway e avisado ao Quita.
_Evitar_: baixa, recebimento

**Conciliação** · `Reconciliation`
Ligação de um Pagamento à Parcela certa.
_Evitar_: baixa, match

**Pagamento fora do Quita** · `ExternalPayment`
Registro do Gestor de que uma Dívida foi paga direto à Credora (na secretaria, por exemplo). Quita a Dívida, com nota obrigatória, e não conta como valor recuperado.
_Evitar_: baixa manual, estorno

## Atendimento

**Fila** · `WorkQueue`
Lista priorizada de Devedores para um Operador trabalhar.
_Evitar_: lista, carteira do operador

**Tratativa** · `Interaction`
Registro de um contato do Operador com o Devedor: ligação, mensagem ou promessa de pagamento.
_Evitar_: contato, atendimento, ocorrência

**Promessa de pagamento** · `PaymentPromise`
Tratativa em que o Devedor se compromete a pagar numa data, sem Acordo formal.
_Evitar_: compromisso, agendamento

**Régua de cobrança** · `CollectionCadence`
Sequência automática de contatos com o Devedor, por dias relativos ao vencimento.
_Evitar_: fluxo de cobrança, automação
