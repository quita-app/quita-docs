# B13 · Credoras (admin da plataforma)

**App:** operations (Angular) · **Rota:** `/operations/admin/creditors` · **Quem:** time do Quita · **Tamanhos:** desktop

## Na história

- **Ator e papel:** Time do Quita: cadastra as credoras que usam o produto.
- **História:** Como administrador do Quita, quero cadastrar uma credora e seu primeiro gestor, para que ela comece a usar o produto.
- **Momento:** Primeiro passo de uma credora nova. Depois, a gestora convida a equipe (B12).
- **O que a tela precisa deixar claro:**
  - Que esta área é do Quita, não de uma credora.
  - Em que situação cada credora está.

## Objetivo

Cadastrar e acompanhar as Credoras que usam o Quita.

## Conteúdo

- Tabela: razão social, CNPJ, slug do portal, tipo (escola, clínica, academia, varejo), plano, situação, devedores ativos. Exemplos: Escola Horizonte, Clínica Bem Viver, Academia Pulso.
- **Nova credora**: razão social, CNPJ (com validação), tipo, slug (sugerido a partir do nome, com aviso de que vira o endereço do portal), plano, e-mail do primeiro gestor.
- Ação "Entrar como" (Fase 2), já com o espaço reservado.

## Estados

1. Lista.
2. Cadastro com slug já em uso.
3. Credora criada: convite enviado ao primeiro gestor.
