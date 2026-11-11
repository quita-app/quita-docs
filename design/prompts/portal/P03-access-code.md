# P03 · Acesso: informar o código

**App:** portal · **Rota:** `/c/escola-horizonte/access/verify` · **Quem:** a Ana · **Tamanhos:** celular e desktop

## Objetivo

Digitar o código de 6 dígitos com o mínimo de atrito.

## Conteúdo

- Título: "Digite o código que enviamos".
- Texto: "Enviamos para a***@gmail.com e (11) 9****-4321." (dados mascarados).
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
- Na demo, uma faixa de ambiente de demonstração, visualmente separada do produto, aponta para a "caixa de saída simulada", onde o código aparece.
