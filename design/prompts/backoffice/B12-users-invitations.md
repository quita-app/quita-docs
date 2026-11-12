# B12 · Usuários e convites

**App:** operations (Angular) · **Rota:** `/operations/admin/users` · **Quem:** Carla, gestora · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Carla, a gestora: monta a equipe de cobrança da credora.
- **História:** Como gestora, quero convidar operadores e controlar quem tem acesso, para que só a minha equipe veja a carteira.
- **Momento:** Depois que a credora foi cadastrada (B13). O convidado entra pelo convite (B01).
- **O que a tela precisa deixar claro:**
  - O papel de cada pessoa e o que ele permite.
  - Quais convites ainda estão pendentes.

## Objetivo

Gerenciar quem da Escola Horizonte usa o Quita.

## Conteúdo

- Tabela de usuários: nome, e-mail, papel (gestor, operador, auditor), situação, último acesso. Exemplo: Carla Mendes (gestora), Bruno Lima (operador), Rita Souza (operadora), Pedro Nunes (auditor, convite pendente).
- **Convidar pessoa**: formulário curto (e-mail, papel) num painel lateral.
- Ações por linha: reenviar convite, mudar papel, desativar.

## Estados

1. Lista.
2. Convidando: e-mail já convidado (validação enquanto digita).
3. Convite enviado.
4. Confirmar desativação.
