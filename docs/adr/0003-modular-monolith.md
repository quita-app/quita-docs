---
status: aceita
---

# 0003 · Back como monólito modular com eventos dentro da aplicação

A API é uma aplicação Spring Boot só, dividida em módulos por contexto do domínio (Identidade, Carteira, Negociação, Pagamento, Atendimento, Notificação, Analytics, Auditoria), com as fronteiras verificadas pelo Spring Modulith. Os módulos conversam por eventos de domínio publicados dentro da aplicação, com registro persistente de publicação no lugar de um broker. Para uma pessoa e uma hospedagem gratuita, isso entrega fronteiras de domínio e consistência eventual sem o custo de operar vários serviços e uma fila de mensagens.

Descartadas: microsserviços (infraestrutura, rede e deploy multiplicados sem ganho no domínio); monólito sem módulos (as fronteiras se perdem e a extração futura fica impossível); RabbitMQ ou Kafka (mais um serviço para hospedar, e o volume não pede).
Custo aceito: um deploy só para tudo do back; a escala é da aplicação inteira, não por módulo.
