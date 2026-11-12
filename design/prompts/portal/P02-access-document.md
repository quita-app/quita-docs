# P02 · Acesso: informar o CPF

**App:** portal · **Rota:** `/c/escola-horizonte/access` · **Quem:** a Ana · **Tamanhos:** celular e desktop

## Na história

- **Ator e papel:** Ana, a devedora: prova quem é para ver as próprias dívidas.
- **História:** Como devedora, quero entrar só com meu CPF, para não precisar de senha nem cadastro.
- **Momento:** Veio da página da credora (P01). Depois do CPF, recebe um código (P03).
- **O que a tela precisa deixar claro:**
  - Por que o CPF é pedido e o que acontece com ele.
  - Que este passo é rápido e seguro, sem parecer interrogatório.

## Objetivo

Pedir só o CPF (ou CNPJ), sem assustar. A Ana precisa entender por que estamos pedindo e o que acontece em seguida.

## Conteúdo

- Cabeçalho com o logo da credora e "Voltar".
- Título: "Para começar, informe seu CPF".
- Campo de CPF com máscara (`000.000.000-00`), teclado numérico no celular, botão **Enviar código**.
- Apoio curto: "Vamos enviar um código de 6 dígitos para o e-mail e o celular cadastrados na Escola Horizonte."
- Link discreto: "Sou empresa e tenho CNPJ" (troca a máscara do campo).
- Selo de privacidade curto.

## Estados

1. Vazio, botão desabilitado.
2. Digitando, com a máscara aplicada.
3. CPF inválido (dígito verificador): erro abaixo do campo, "Confira os números do CPF".
4. Enviando: botão em carregamento.
5. Limite atingido: "Você já pediu 3 códigos nos últimos 15 minutos. Tente de novo às 21:40."

## Notas

- A resposta é sempre a mesma, exista ou não o CPF na credora: nunca mostre "CPF não encontrado" (protege a privacidade de quem deve).
- Funciona sem JavaScript: formulário comum com botão de envio.
