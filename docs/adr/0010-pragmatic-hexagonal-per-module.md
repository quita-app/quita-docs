---
status: aceita
---

# 0010 · Arquitetura hexagonal pragmática dentro de cada módulo

Cada módulo do monólito segue Ports and Adapters: o domínio fica no centro, os casos de uso são uma classe por ação, o que vem de fora entra por adapters (REST, eventos, jobs) e o que o núcleo precisa do mundo sai por portas (repositórios, gateway de pagamento, outros módulos). A concessão pragmática é deixar as anotações do JPA nas entidades de domínio, em vez de manter um modelo de persistência separado. O resultado isola as regras de negócio para testar sem Spring e deixa trocar uma integração, como o gateway fake por um real, mudando só um adapter.

Descartadas: camadas tradicionais controller → service → repository sem portas (o domínio vira anêmico e as regras se espalham pelos services); hexagonal pura com modelo de persistência separado (dobra o número de classes e de mapeamentos sem ganho no escopo do projeto); Clean Architecture completa com portas de entrada para cada caso de uso (mais interfaces do que o projeto precisa).
Custo aceito: mais pacotes e classes do que o modelo em camadas; o domínio depende das anotações do JPA.
