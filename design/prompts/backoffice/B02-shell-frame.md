# B02 · Moldura do backoffice (shell)

**App:** shell (Angular) · **Rota:** todas as do backoffice · **Quem:** operador e gestor · **Tamanhos:** desktop 1440 px e 1024 px

## Objetivo

A moldura que envolve todas as telas: navegação, identidade do usuário, notificações e os estados que o shell controla. Cada tela de negócio é carregada dentro dela.

## Conteúdo

- Menu lateral recolhível, com ícones e rótulos: Fila, Devedores, Importações, Política, Pagamentos, Painel, Administração (o que aparece depende do papel; mostre a versão do gestor e a do operador).
- Barra superior: nome da credora (Escola Horizonte), busca global (atalho `/`), notificações com contador, avatar com nome e papel, alternância de tema claro/escuro.
- Área de conteúdo com um cabeçalho de página padrão (título, descrição curta, ações à direita).

## Estados

1. Menu aberto e recolhido.
2. Notificações abertas: lista curta ("Pagamento conciliado: Ana Souza, R$ 135,15", "Importação de outubro concluída com 12 erros").
3. **Servidor acordando:** faixa global discreta no topo, "Conectando ao servidor… isso pode levar alguns segundos.", sem bloquear a tela.
4. **Uma área (remote) não carregou:** só a área de conteúdo mostra "Não foi possível carregar esta área" com **Tentar de novo**; menu e barra continuam funcionando.
5. Sem permissão para a página.

## Notas

- O "entrar como" do admin da plataforma (Fase 2) aparece como uma faixa colorida fixa: "Você está vendo como Escola Horizonte · Sair". Desenhe a faixa agora para reservar o espaço.
