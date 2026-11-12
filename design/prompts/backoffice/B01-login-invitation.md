# B01 · Login e aceite de convite

**App:** shell (Angular) · **Rotas:** `/login`, `/invitations/:token` · **Quem:** Bruno Lima (operador) e Carla Mendes (gestora) da Escola Horizonte · **Tamanhos:** desktop 1440 px e celular 390 px

## Na história

- **Ator e papel:** Bruno (operador) e Carla (gestora) da Escola Horizonte: entram no backoffice da credora.
- **História:** Como pessoa da equipe de cobrança, quero aceitar meu convite e entrar, para começar a trabalhar na carteira da minha empresa.
- **Momento:** Recebeu o convite que a Carla enviou (B12) ou volta para o dia de trabalho. Depois de entrar, cai na moldura (B02) e na fila (B03) ou no painel (B14).
- **O que a tela precisa deixar claro:**
  - De qual credora é este acesso e quem convidou.
  - Que é a área da equipe, diferente do portal do devedor.

## Objetivo

Entrar rápido no sistema de trabalho. É a porta do backoffice: sóbria, confiável, com o mesmo DNA do portal, mas sem o tom acolhedor de quem deve.

## Conteúdo

**Login**
- Logo do Quita, título "Entrar no Quita".
- E-mail e senha (com mostrar/ocultar), **Entrar**, "Esqueci minha senha".
- Um painel lateral com a marca (uma composição gráfica do design system, não foto de banco de imagem).

**Aceite de convite**
- "A Escola Horizonte convidou você como Operador."
- Nome, criar senha (com os critérios visíveis conforme digita), confirmar senha, **Criar conta e entrar**.

**Recuperar senha** (rotas `/password-reset` e `/password-reset/:token`)
- "Esqueci minha senha" leva a um formulário só com o e-mail e **Enviar link**. A resposta é sempre a mesma, exista ou não o e-mail: "Se o e-mail tiver cadastro, o link chega em alguns minutos."
- O link do e-mail abre "Crie uma nova senha", com os mesmos critérios do convite, e **Salvar nova senha**.

## Estados

1. Login vazio, preenchido, entrando.
2. E-mail ou senha incorretos: "E-mail ou senha incorretos." (nunca diz qual dos dois).
3. Muitas tentativas: "Muitas tentativas. Tente de novo em 1 minuto."
4. Sessão expirada: aviso no topo do login, "Sua sessão terminou. Entre de novo para continuar de onde parou."
5. Convite vencido ou já usado.
6. Recuperar senha: formulário e confirmação de envio (texto neutro).
7. Link de nova senha vencido ou já usado: "Este link venceu ou já foi usado. Peça um novo." com **Pedir novo link**.

## Notas

- O login é um formulário simples (template-driven no Angular): poucos campos, validação na hora.
