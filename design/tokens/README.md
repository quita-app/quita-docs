# Tokens do Quita (Céu)

Fonte única do estilo em CSS, extraída do protótipo aprovado no canvas. O `DESIGN.md` explica as regras; estes arquivos são o que o código importa.

| Arquivo | O que é | Quem usa |
| --- | --- | --- |
| `tokens.css` | Todas as variáveis: cores claro e escuro, faixas de atraso, gráficos, raios, espaço, tipografia, sombras (`--elevation-*`), movimento, moldura do backoffice, faixa da demo. Também tem a base (seleção, foco), as animações `q-*` e o movimento reduzido. | portal, shell, operations, analytics |
| `tailwind.css` | Tema do Tailwind 4 (`@theme inline`) que vira utilitários: `bg-primary`, `bg-signature`, `bg-aging-3`, `rounded-card`, `shadow-float`, `text-h1`, `text-kpi`, `animate-q-pop`, `ease-q-out`, variante `dark:`. | quem usa Tailwind 4 |
| `components.css` | CSS de referência de todos os componentes do protótipo (botões, campos, código, simulador, badges e estados, pílulas, tabela, KPI, avisos, toast, esqueleto, moldura, folha, diálogo, notificações, bento...). Serve de especificação para as variantes do shadcn/ui e do Spartan UI. | referência; importar é opcional |
| `landing.css` | CSS de referência da landing (P00). | só o portal |

## Como importar

```css
@import "tailwindcss";
@import "./tokens.css";
@import "./tailwind.css";
```

- **Tema escuro:** classe `dark` (ou `data-theme="dark"`) no `<html>`.
- **Fonte:** Geist e Geist Mono (`next/font` no portal, pacote `geist` no backoffice).
- **White-label no portal:** a credora troca só `--signature` e `--signature-foreground` no layout de `/c/[slug]`.
- **Ícones:** Lucide, com traço 1,8. O único que não existe no Lucide é o Pix (`../assets/global-icone-pix.svg`).

Quando o valor de um token mudar, ele muda primeiro aqui. Depois os repos copiam o arquivo.
