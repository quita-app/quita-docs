# Assets do sistema

Nome: `<tela>-<seção>-<asset>.<ext>`. `global` = usado em mais de uma tela. SVG monocromático usa `currentColor` (a cor vem do CSS); os que têm `-tinta` e `-claro` no nome têm a cor fixa.

| Arquivo | Onde | Observação |
| --- | --- | --- |
| `global-marca-simbolo-q.svg` | menu do backoffice, cabeçalhos, "Operado por quita" | `currentColor` |
| `global-marca-simbolo-q-tinta.svg` / `-claro.svg` | onde não dá para herdar a cor (img, e-mail) | cor fixa |
| `global-marca-logo-quita.svg` | símbolo + "quita" (texto em contorno, Geist 600) | `currentColor` |
| `global-marca-logo-quita-tinta.svg` / `-claro.svg` | idem, com cor fixa | e-mail, OG |
| `global-icone-pix.svg` | P08, B11, notificações | fora do Lucide; traço 1,8 |
| `global-favicon-quita.ico` | favicon dos dois apps | 16, 32 e 48 px |
| `global-favicon-quita.svg` | favicon vetorial | |
| `global-favicon-apple-touch-180.png` | atalho no celular | 180 px |
| `p00-hero-q-fantasma.svg` | P00, fundo do hero | `currentColor`; cor `signature` 40% sobre o fundo, opacidade .55 |
| `p00-rodape-q-fantasma.svg` | P00, rodapé | `currentColor` = `--foreground`; opacidade .045 no claro e .035 no escuro; 560 px, right 850px, top -121px (1440) |
| `p00-problema-planilha.svg` / `-desconto.svg` / `-quebra.svg` | P00, seção "O problema" (fundo tinta) | cores fixas para fundo escuro |
| `p01-cabecalho-logo-escola-horizonte.svg` | P01 a P10, marca da credora de exemplo | só seed e demo; em produção vem do `logoUrl` da credora |
| `b01-painel-q-fantasma.svg` | B01, painel da marca, fundo | `currentColor`; opacidade .08 no claro e .06 no escuro |
| `b01-painel-q-ponto.svg` | B01, painel da marca, Q com ponto menta | `currentColor` no Q; ponto `--celebrate` fixo |
| `p08-celebracao-disco-check.svg` | P08 e P09 (quitado) | versão estática; animada no app com `q-pop` e `q-draw` |

O QR Code do Pix é gerado em tempo de execução, e os outros ícones vêm do Lucide.
