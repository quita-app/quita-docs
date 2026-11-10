---
status: aceita
---

# 0006 · Multi-tenancy por coluna num banco só

Todas as Credoras compartilham o mesmo banco e as mesmas tabelas; cada linha de dado de Credora leva o id do tenant, e a camada de persistência aplica o filtro sozinha em toda consulta. É o modelo mais barato e o mais comum em SaaS, e cabe numa hospedagem gratuita.

Descartadas: um banco por Credora (inviável na camada gratuita e pesado de migrar); um schema por Credora (migrações multiplicadas pelo número de Credoras).
Custo aceito: um erro no filtro vaza dados entre Credoras; por isso o isolamento é provado por teste automatizado em cada módulo.
