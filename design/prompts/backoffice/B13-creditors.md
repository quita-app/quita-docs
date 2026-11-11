# B13 · Credoras (admin da plataforma)

**App:** operations (Angular) · **Rota:** `/operations/admin/creditors` · **Quem:** time do Quita · **Tamanhos:** desktop

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
