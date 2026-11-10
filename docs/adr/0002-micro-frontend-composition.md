---
status: aceita
---

# 0002 · Shell Angular com remotes federados e portal separado

O backoffice é um shell Angular que carrega em tempo de execução o remote Operações (Angular, por federação) e o remote Analytics (React, exposto como Web Component). O portal do devedor é uma aplicação Next.js separada, ligada por endereço. A divisão segue o público: o backoffice é denso, autenticado e sem SEO; o portal é público, mobile, com SEO e renderização no servidor. O Web Component isola o React e deixa o shell sem saber o framework de dentro.

Descartadas: portal como remote do shell (Next.js com App Router não funciona bem como remote federado, e o portal não precisa do shell); Analytics como remote React por federação direta (acopla o shell ao runtime do React); um front só, sem micro front-ends (não atende à restrição de arquitetura do projeto).
Custo aceito: duas formas de integração para manter (federação e Web Component), cuidado com estilos encapsulados e com versões das bibliotecas compartilhadas.
