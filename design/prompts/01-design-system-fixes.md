# Ajustes no design system antes das telas

Design system Céu aprovado, com quatro ajustes. Corrija no canvas e no `DESIGN.md`:

1. **Faixas de atraso:** use as 5 Faixas da Política, e não 30/60/90/180. Rótulos: "Até 30 dias", "31 a 90", "91 a 180", "181 a 360", "Mais de 360" (`--aging-1` a `--aging-5` nessa ordem). Ajuste o badge, os filtros em pílula e a fila.
2. **Erro do campo de CPF:** a mensagem "Não achamos dívida com esse CPF" não pode existir. O portal nunca revela se um CPF tem dívida (proteção contra enumeração, `docs/lld/api.md` seção 5.7). O erro do campo é só de formato: "Confira os números do CPF."
3. **Datas do acordo:** a entrada vence 2 dias depois do aceite (aceite em 10/11 → entrada até 12/11), e as parcelas vencem no mesmo dia do mês da entrada: 12/12/2026, 12/01/2027, 12/02/2027, 12/03/2027. Na tela de acordo fechado, a próxima parcela é 12/12.
4. **Tamanhos:** toda tela, do portal e do backoffice, tem versão celular (390 px). Portal e backoffice: 1440 e 390 (uma única versão web, em 1440). No celular, o trilho do backoffice vira barra inferior com 4 itens + "Mais", a ficha lateral vira tela cheia e a tabela vira lista de cards.

Mantenha todo o resto.
