---
status: aceita
---

# 0005 · REST com contrato OpenAPI gerado do código e clients gerados

A API expõe REST, e o contrato OpenAPI é gerado do código e versionado como arquivo no repo da API. Os fronts geram os clients TypeScript a partir desse arquivo, então uma mudança de contrato quebra o build do front, e não a produção. O portal chama a API pelo servidor, como um BFF.

Descartadas: GraphQL (curva maior e pouco ganho com três clientes conhecidos); contrato escrito à mão antes do código (duas fontes da verdade para uma pessoa manter); clients escritos à mão (divergem sem aviso).
Custo aceito: um passo de geração de código nos fronts a cada mudança de contrato.
