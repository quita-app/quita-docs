---
status: aceita
---

# 0013 · Portal da Credora por caminho, não por subdomínio

Cada Credora tem o portal em `/c/<slug>` dentro do domínio do portal, em vez de um subdomínio próprio (`<slug>.quita...`). Subdomínio por Credora exige domínio próprio com DNS curinga e certificado curinga, o que tem custo e configuração fora da camada gratuita; o caminho funciona no domínio da Vercel e mantém um cookie de sessão por domínio só. Como os links vão para o Devedor por mensagem e ficam salvos, o formato da URL é difícil de trocar depois.

Descartadas: subdomínio por Credora (custo de domínio e DNS curinga); domínio próprio de cada Credora (configuração por cliente, fora do escopo).
Custo aceito: a URL mostra o Quita, não só a Credora; uma Credora que exija domínio próprio fica para depois, com redirecionamento.
