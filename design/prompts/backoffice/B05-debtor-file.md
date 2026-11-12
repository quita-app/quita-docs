# B05 · Ficha do Devedor

**App:** operations (Angular) · **Rota:** `/operations/debtors/:id` · **Quem:** Bruno, atendendo a Ana · **Tamanhos:** desktop 1440 px e celular 390 px

## Na história

- **Ator e papel:** Bruno, o operador, atendendo a Ana: vê a história completa dela com a credora.
- **História:** Como operador, quero ver dívidas, acordos e tratativas da Ana num lugar só, para atender sem pedir que ela repita tudo.
- **Momento:** Veio da fila (B03) ou da busca (B04). Se a Ana quiser negociar, abre o painel de negociação (B06) e envia uma proposta a ela.
- **O que a tela precisa deixar claro:**
  - Quem é a Ana para a credora, o que ela deve e o que já foi tentado.
  - Que o operador está com a ficha reservada, e outro colega não atende ao mesmo tempo.

## Objetivo

Tudo que o operador precisa para atender, numa tela: quem é, quanto deve, o que já aconteceu e o que fazer agora.

## Conteúdo

- Cabeçalho: Ana Souza · CPF ***.456.789-** (sempre mascarado no MVP; o botão "mostrar" é da Fase 2, F17, e não aparece agora) · e-mail e telefone · "Em atendimento por você · reserva até 15:42".
- Dívidas: Mensalidade de agosto (R$ 1.060,00, 91–180, em negociação, com a etiqueta "Proposta enviada por Bruno · válida até 14/11 às 10:30") e Material didático (R$ 288,87, 31–90, em aberto).
- Acordos: rematrícula, ativo, 2 de 4 pagas.
- Linha do tempo (mais recente no topo): proposta enviada por Bruno (5x, R$ 901,00); ligação há 2 dias com nota "Pediu para pagar na sexta"; promessa de pagamento para hoje; importação da dívida. (Mensagens da régua são da Fase 2.)
- Ações: **Registrar tratativa**, **Negociar** (abre a B06), **Registrar promessa**. Só para a gestora, por Dívida: **Registrar pagamento fora do Quita** (a família pagou na secretaria).
- Painel "Registrar tratativa": tipo (ligação, mensagem, nota), texto curto, **Salvar tratativa**.

## Estados

1. Ficha aberta e reservada por você.
2. Reservada por outro operador: "Carla Mendes está atendendo este Devedor até 15:42. Você pode ver, mas não negociar." Ficha em modo só leitura, sem aviso de liberação (no MVP, o operador tenta de novo depois).
3. Pagamento confirmado ao vivo: a linha do tempo ganha "Pagamento recebido: R$ 191,46" com destaque passageiro e um toast.
4. Carregando: cabeçalho e dívidas primeiro; a linha do tempo carrega depois (bloco adiado).
5. Visão da gestora, "Registrar pagamento fora do Quita": diálogo com a consequência ("A dívida fica quitada e a Ana sai da Fila. A proposta aberta deixa de valer. Não conta como valor recuperado.") e nota obrigatória. Depois: a Dívida aparece "Paga fora do Quita · registrado por Carla em 12/11", com a nota.
6. Pagamento fora do Quita recusado: a Dívida tem um acordo em andamento ("Quem quita a dívida é o acordo.").

## Notas

- O CPF completo nunca aparece no MVP (LGPD): mostrar o CPF depende de uma permissão que chega com a auditoria (F17).
