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
- Seção **Portal da credora**, no mesmo cadastro (no MVP, quem preenche é o time do Quita; o editor da própria gestora, com pré-visualização ao vivo, é da Fase 2): nome de exibição ("Escola Horizonte"), logo (opcional; PNG ou WebP, até 256 KB e 1024 px; SVG não é aceito), cor de assinatura (opcional, seletor de cor), e-mail e telefone de atendimento (aparecem no rodapé do portal e na ajuda do acordo). Uma miniatura mostra o logo, ou as iniciais quando não há logo.
- A coluna "devedores ativos" mostra só a contagem de cada credora.
- Ação "Entrar como" (Fase 2), já com o espaço reservado.

## Estados

1. Lista.
2. Cadastro com slug já em uso.
3. Credora criada: convite enviado ao primeiro gestor.
4. Logo recusado (SVG ou acima de 256 KB): "Use PNG ou WebP." / "O logo passa de 256 KB."
5. Cor sem contraste: "Esta cor não tem contraste suficiente com o texto do botão. Escolha uma cor mais escura."
