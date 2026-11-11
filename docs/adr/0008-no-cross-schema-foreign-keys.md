---
status: aceita
---

# 0008 · Sem chave estrangeira entre schemas de módulos diferentes

Cada módulo da API tem o próprio schema, e uma tabela que aponta para o dado de outro módulo guarda só o id, sem `foreign key`. Chaves estrangeiras continuam dentro do mesmo schema. Isso mantém cada módulo dono dos próprios dados e deixa a extração de um módulo para um serviço possível sem desmontar o banco: entre módulos, a consistência vem dos eventos de domínio e das regras da aplicação.

Descartadas: chaves estrangeiras entre todos os schemas (acopla os módulos no banco e impede separar um deles depois); um schema só para tudo (as fronteiras somem no banco).
Custo aceito: o banco não impede um id órfão entre módulos; a aplicação precisa validar, e os testes de integração cobrem os fluxos que cruzam módulos.
