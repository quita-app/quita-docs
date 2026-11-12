# P01 · Página da credora

**App:** portal (Next.js) · **Rota:** `/c/escola-horizonte` · **Quem:** a Ana, que clicou no link recebido por mensagem · **Tamanhos:** celular 390 px e desktop 1440 px

## Na história

- **Ator e papel:** Ana, a devedora: tem uma mensalidade em atraso com a Escola Horizonte e quer resolver sem constrangimento.
- **História:** Como devedora, quero confirmar que o link é da minha escola e que posso resolver sozinha, para ter coragem de seguir.
- **Momento:** Acabou de clicar no link recebido por mensagem. Daqui vai para o acesso por CPF (P02).
- **O que a tela precisa deixar claro:**
  - Quem cobra é a Escola Horizonte; o Quita aparece como a ferramenta que ela usa.
  - O texto fala com a Ana, sem julgamento, e diz quanto tempo leva.

## Objetivo

Em 5 segundos, a Ana entende que está no lugar certo (é a escola dela, não um golpe), que dá para resolver sozinha e o que fazer agora. É a primeira impressão da marca e a tela que precisa carregar mais rápido (LCP < 2,5 s em 4G).

## Conteúdo

- Logo e nome da credora: **Escola Horizonte** (use um logo genérico de escola).
- Título que acolhe, sem falar em dívida de forma pesada. Direção: "Coloque suas contas com a Escola Horizonte em dia".
- Três pontos curtos do que ela consegue fazer: ver quanto deve e por quê, simular parcelas, pagar a entrada por Pix.
- Botão principal: **Consultar minhas dívidas**.
- Selo de confiança discreto: "Ambiente seguro: seus dados são usados só para este atendimento" e "Operado por quita" (logo do Quita pequeno).
- Rodapé: contato da credora (telefone e e-mail fictícios), termos e privacidade.

## Estados

1. Padrão.
2. Credora sem logo cadastrado: iniciais num círculo e o tema padrão do Quita.
3. Endereço inexistente (404): "Não encontramos esta página", com orientação para conferir o link recebido.

## Notas

- Página white-label: cor de assinatura e logo são da credora. Mostre a versão com o tema padrão do Quita e uma variação com outra cor de assinatura (ex.: verde-azulado), provando que os tokens trocam sem quebrar o contraste.
- Sem foto grande de pessoa e sem vídeo: o peso da página importa.
- Uma única ação principal. Sem menu de navegação.
