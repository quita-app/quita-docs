---
status: aceita
---

# 0012 · Native Federation no backoffice e o React como Web Component

O shell e o remote Operações usam Native Federation, que funciona com o builder atual do Angular (esbuild) e é baseada em padrões do navegador (módulos ES e import maps). O remote Analytics é uma aplicação React empacotada pelo Vite como um Web Component (`<quita-analytics>`), carregada pelo shell a partir de um endereço do manifesto de remotes. O Nx organiza o monorepo (projetos, dependências, cache, builds afetados), mas não define o mecanismo de federação. A forma exata da integração é provada no walking skeleton antes de qualquer funcionalidade.

Descartadas: Module Federation com Webpack ou Rspack no Angular (obriga a trocar o builder padrão do Angular); React carregado por federação direta no shell (acopla o shell ao runtime do React); iframe para o Analytics (isolamento total, mas navegação, tamanho e acessibilidade ruins).
Custo aceito: dois mecanismos de carga no shell (federação e script do Web Component); o React vai inteiro dentro do pacote do Analytics.
