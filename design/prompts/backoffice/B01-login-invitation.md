# B01 · Login e aceite de convite

**App:** shell (Angular) · **Rotas:** `/login`, `/invitations/:token` · **Quem:** Bruno Lima (operador) e Carla Mendes (gestora) da Escola Horizonte · **Tamanhos:** desktop 1440 px e 1024 px

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

## Estados

1. Login vazio, preenchido, entrando.
2. E-mail ou senha incorretos: "E-mail ou senha incorretos." (nunca diz qual dos dois).
3. Muitas tentativas: "Muitas tentativas. Tente de novo em 1 minuto."
4. Sessão expirada: aviso no topo do login, "Sua sessão terminou. Entre de novo para continuar de onde parou."
5. Convite vencido ou já usado.

## Notas

- O login é um formulário simples (template-driven no Angular): poucos campos, validação na hora.
