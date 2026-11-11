---
status: aceita
---

# 0009 · Spring Web MVC com virtual threads, em vez de WebFlux

A API usa o modelo tradicional do Spring Web MVC (um fluxo de execução por requisição, código imperativo) com as virtual threads do Java ligadas. As virtual threads deixam milhares de requisições esperando banco ou rede sem esgotar threads, que era o principal motivo para escolher o modelo reativo, e o código continua simples de ler, depurar e testar. SSE funciona no MVC sem precisar do modelo reativo.

Descartadas: Spring WebFlux (programação reativa em toda a pilha, inclusive no acesso ao banco, com curva alta e pouco ganho para o volume do projeto); MVC sem virtual threads (o pool de threads limitado viraria gargalo com conexões SSE abertas).
Custo aceito: bibliotecas que travam a virtual thread no próprio carregador (*pinning*) precisam ser evitadas ou isoladas; o projeto não aprende o modelo reativo.
