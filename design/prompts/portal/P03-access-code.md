# P03 · Acesso: informar o código

**App:** portal · **Rota:** `/c/escola-horizonte/access/verify` · **Quem:** a Ana · **Tamanhos:** celular e desktop

## Na história

- **Ator e papel:** Ana, a devedora: confirma o acesso com o código de uso único.
- **História:** Como devedora, quero confirmar com um código que chega no meu telefone, para ter certeza de que só eu vejo minhas dívidas.
- **Momento:** Informou o CPF (P02). Com o código certo, vê suas dívidas (P04).
- **O que a tela precisa deixar claro:**
  - Que o código vale por pouco tempo e o que fazer se ele não chegar, sem revelar para onde foi enviado (a resposta é igual exista ou não o CPF).
  - O que fazer se o código não chegou.

## Objetivo

Digitar o código de 6 dígitos com o mínimo de atrito.

## Conteúdo

- Título: "Digite o código que enviamos".
- Texto neutro: "Se o seu CPF tiver cadastro na Escola Horizonte, enviamos um código para o e-mail e o celular informados por ela." Nunca mostrar o e-mail nem o telefone, nem mascarados: a tela é igual exista ou não o CPF, para não revelar quem deve.
- Campo de código com 6 caixas; aceita colar o código inteiro e o preenchimento automático do SMS no celular.
- Botão **Entrar**.
- "Não recebeu? Enviar de novo", com contagem regressiva ("disponível em 0:45").
- "Trocar CPF".

## Estados

1. Vazio.
2. Preenchido.
3. Código errado: "Código incorreto. Você tem mais 4 tentativas."
4. Código vencido: "Este código venceu. Envie um novo."
5. Bloqueado após 5 tentativas: "Por segurança, o acesso foi pausado por 15 minutos. Tente de novo às 21:55."
6. Entrando (carregamento).

## Notas

- O código vale 10 minutos e aceita 5 tentativas (`docs/lld/api.md`, "Valores e configuração").
- Na demo, uma faixa de ambiente de demonstração, visualmente separada do produto, aponta para a "caixa de saída simulada" (`/demo/inbox`), onde o código aparece.
