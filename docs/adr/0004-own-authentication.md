---
status: aceita
---

# 0004 · Autenticação própria com JWT curto e refresh em cookie httpOnly

A API emite um token de acesso de vida curta, guardado só em memória no front, e um token de renovação em cookie httpOnly, para os dois públicos: senha no backoffice, CPF com código de uso único no portal. Um provedor de identidade separado pesaria na hospedagem gratuita, e o acesso do devedor por código já exigiria uma extensão sob medida.

Descartadas: Keycloak (consumo de memória e mais um serviço para hospedar); Auth0 ou similar (dependência externa e limites do plano gratuito); sessão no servidor com cookie (não combina com os fronts em domínios e plataformas diferentes da API).
Custo aceito: a segurança do login, da renovação e da revogação passa a ser responsabilidade do projeto, com testes próprios.
