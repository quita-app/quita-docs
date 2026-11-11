---
status: aceita
---

# 0011 · Tipos gerados do OpenAPI e chamadas escritas à mão nos fronts

Substitui a 0005 só na parte dos fronts: a API continua expondo REST com o contrato OpenAPI gerado do código e versionado no repo dela. Os fronts geram a partir desse arquivo apenas os **tipos** TypeScript (requisições, respostas, códigos de erro), e a camada de chamada é escrita à mão em cada framework: serviços com `HttpClient` e RxJS no Angular, hooks com TanStack Query no React, funções de servidor no Next.js. Uma mudança de contrato continua quebrando o build do front, e cada front usa as ferramentas idiomáticas dele (interceptors, cache, cancelamento) em vez de um client genérico.

Descartadas: client completo gerado (esconde a camada HTTP atrás de código gerado, difícil de ajustar a interceptors e ao cache de cada framework); tipos escritos à mão (divergem do contrato sem aviso).
Custo aceito: cada front mantém a própria camada de chamadas; o passo de geração dos tipos roda a cada mudança de contrato.
