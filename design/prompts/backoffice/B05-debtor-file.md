# B05 · Ficha do Devedor

**App:** operations (Angular) · **Rota:** `/operations/debtors/:id` · **Quem:** Bruno, atendendo a Ana · **Tamanhos:** desktop 1440 px e 1024 px

## Objetivo

Tudo que o operador precisa para atender, numa tela: quem é, quanto deve, o que já aconteceu e o que fazer agora.

## Conteúdo

- Cabeçalho: Ana Souza · CPF ***.456.789-** (botão "mostrar" só para quem tem permissão) · e-mail e telefone · "Em atendimento por você · reserva até 15:42".
- Dívidas: Mensalidade de agosto (R$ 1.060,00, 91–180, em aberto) e Material didático (R$ 288,87, 31–90, em aberto).
- Acordos: rematrícula, ativo, 2 de 4 pagas.
- Linha do tempo (mais recente no topo): ligação há 2 dias com nota "Pediu para pagar na sexta"; promessa de pagamento para hoje; mensagem da régua enviada; importação da dívida.
- Ações: **Registrar tratativa**, **Negociar** (abre a B06), **Registrar promessa**.
- Painel "Registrar tratativa": tipo (ligação, mensagem, nota), texto curto, **Salvar tratativa**.

## Estados

1. Ficha aberta e reservada por você.
2. Reservada por outro operador: "Carla Mendes está atendendo a Ana. Você pode ver, mas não negociar." com **Avisar quando liberar**.
3. Pagamento confirmado ao vivo: a linha do tempo ganha "Pagamento recebido: R$ 191,46" com destaque passageiro e um toast.
4. Carregando: cabeçalho e dívidas primeiro; a linha do tempo carrega depois (bloco adiado).

## Notas

- O CPF completo nunca aparece por padrão (LGPD).
