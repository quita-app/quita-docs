# P00 · Landing page do Quita

**App:** portal (Next.js) · **Rota:** `/` · **Quem:** gestor de uma credora curioso, recrutador ou pessoa avaliando o portfólio · **Tamanhos:** 390, 1280 e 1440 px

## Objetivo

Mostrar em uma rolagem o que o Quita é, para quem e como funciona, e levar à demo. É a vitrine pública do produto e a página com mais liberdade de identidade.

## Conteúdo

1. **Abertura:** o que o Quita faz em uma frase, para a credora de médio porte. Direção: "Sua escola recebe o que tem para receber. Seu aluno resolve pelo celular, sem constrangimento." Botão **Ver a demo** e "Como funciona".
2. **O problema, em três linhas:** cobrança por planilha e WhatsApp, desconto que muda de atendente para atendente, acordo que quebra sem ninguém ver.
3. **Como funciona, em 3 passos reais (é sequência, então numerar faz sentido):** a credora importa a carteira e define a política → o devedor recebe o link, simula e fecha pelo celular → o operador cuida só das exceções e o gestor acompanha o painel.
4. **O fluxo da Ana:** mostre as três telas do portal já aprovadas (suas dívidas, simulador, acordo fechado) num celular, com os números reais do exemplo.
5. **O backoffice:** um recorte da fila e um do painel.
6. **Princípios:** sem constranger, a política é da credora, resolver em minutos.
7. **Demo:** três entradas, uma por perfil: "Entrar como devedora (Ana)", "Entrar como operador", "Entrar como gestora", com um aviso de que os dados são fictícios.
8. **Rodapé:** "Projeto de portfólio", link do GitHub (`quita-app`), contato.

## Regras

- **Sem prova social inventada:** nada de logos de clientes, depoimentos ou números de resultado. O projeto não tem clientes reais (`PRODUCT.md`, "Evidence on Hand").
- A cor de assinatura aparece uma vez (no botão **Ver a demo**).
- Leve: sem vídeo, imagens otimizadas, LCP < 2,5 s em 4G.
- Movimento: pode ter vários momentos (fluxo da Ana em loop no hero, entradas ao rolar, números contando, narrativa com celular fixo), só com CSS/scroll-driven animations ou IntersectionObserver, e tudo parado com `prefers-reduced-motion`. Direção visual completa em `design/review/corrections.md`, seção P00.
