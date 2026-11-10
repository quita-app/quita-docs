---
name: domain-modeling
description: Constrói e lapida o modelo de domínio do Quita. Use ao discutir a terminologia do negócio, ao escrever ou editar o GLOSSARY.md e ao registrar ou editar um ADR.
---

# Modelagem de domínio

Construa e lapide ativamente o modelo de domínio enquanto o desenho é discutido: questione termos, invente cenários de borda e grave o glossário e as decisões assim que se firmarem. (Só _ler_ o `GLOSSARY.md` para usar o vocabulário não é esta skill: é um hábito que qualquer skill tem. Esta é para quando o modelo muda.)

## Onde ficam os arquivos

O `quita-docs` é a casa do modelo de domínio do sistema inteiro:

```
quita-docs/
├── GLOSSARY.md        ← vocabulário do domínio (um só, para todos os repos)
└── docs/
    └── adr/           ← decisões de arquitetura (0001-slug.md, ...)
```

Os repos de código não têm glossário próprio: importam este. Se o domínio crescer a ponto de os contextos usarem a mesma palavra com sentidos diferentes, proponha dividir em contextos com um `GLOSSARY-MAP.md` (ver `GLOSSARY-FORMAT.md`).

Crie os arquivos sob demanda: o `GLOSSARY.md` quando o primeiro termo for resolvido.

## Durante a sessão

### Confronte com o glossário

Quando o usuário usar um termo que conflita com o `GLOSSARY.md`, aponte na hora: "O glossário define 'quebra' como X, mas você parece falar de Y. Qual é?"

### Afie a linguagem vaga

Quando o usuário usar um termo vago ou sobrecarregado, proponha um termo canônico: "Você disse 'cliente': é a Credora ou o Devedor? São coisas diferentes."

### Discuta cenários concretos

Teste as relações do domínio com cenários específicos, inventados para sondar as bordas. Use pessoas e números, como o exemplo da Ana em `docs/foundation/business-requirements.md`.

### Confira com o código

Quando houver código nos repos vizinhos (`../quita-backend-api`, `../quita-backoffice-web`, `../quita-debtor-portal-web`) e o usuário afirmar como algo funciona, confira se o código concorda. Se houver contradição, mostre.

### Atualize o GLOSSARY.md na hora

Quando um termo for resolvido, grave no `GLOSSARY.md` na hora, no formato de [GLOSSARY-FORMAT.md](GLOSSARY-FORMAT.md). Não acumule.

O `GLOSSARY.md` não tem detalhe de implementação. Não é spec, não é rascunho, não guarda decisão de implementação. A única ponte com o código é o **nome em código** de cada termo, em inglês, para o vocabulário bater entre o documento e as classes.

### Ofereça ADRs com parcimônia

Só ofereça um ADR quando as três condições forem verdadeiras:

1. **Difícil de reverter:** mudar de ideia depois custa caro.
2. **Surpreendente sem contexto:** alguém sem o histórico perguntaria por quê, ou proporia o contrário.
3. **Fruto de um trade-off real:** havia alternativas sérias, e houve um motivo para a escolhida.

Se faltar uma, não há ADR. Use o formato de [ADR-FORMAT.md](ADR-FORMAT.md) e grave só a versão que o usuário aprovou.
