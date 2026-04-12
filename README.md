# Repositório de Modelos de BI

## Objetivo:

Biblioteca de scripts da Linguagem M, DAX e scripts TMDL para Power BI.

## Tabela de referencia de caracteres úteis

| Caractere | Hex | Decimal | UNICHAR |
| --- | --- | --- | --- |
| ▲ | U+25B2 | 9650 | UNICHAR(9650) |
| ▼ | U+25BC | 9660 | UNICHAR(9660) |
| ► | U+25BA | 9658 | UNICHAR(9658) |
| ↑ | U+2191 | 8593 | UNICHAR(8593) |
| ↓ | U+2193 | 8595 | UNICHAR(8595) |
| ⮙ | U+2B99 | 11161 | UNICHAR(11161) |
| ⮛ | U+2B9B | 11163 | UNICHAR(11163) |
| ⮚ | U+2B9A | 11162 | UNICHAR(11162) |

## Repositório para Linguagem M

<https://github.com/RogerioTonini/Power_BI/tree/main/1_Linguagem_M>

## Repositório para DAX

<https://github.com/RogerioTonini/Power_BI/tree/main/2_DAX>

## Repositório para TMDL

<https://github.com/RogerioTonini/Power_BI/tree/main/3_TMDL>

### Commit: Estrutura inicial - Git

```bash
git add .gitignore .gitattributes .githooks-scripts/
git commit -m "chore(git):
- Adicionar .gitignore, - Adicionar .gitattributes para normalização de arquivos e
configurar tratamento de arquivos binários,
- Adicionar scripts de hooks para Conventional Commits"
```

### Commit: Configurações do VSCode

```bash
git add .vscode/
git commit -m "chore(vscode): adicionar configurações do editor"
```

### Commit: README.md

```bash
git add README.md
git commit -m "docs: adicionar documentação do projeto"
```

### Commit: 0_Templates/

```bash
git add 0_Templates/
git commit -m "feat: Inclusão dos arquivos: Template_Default.pbit e .pbix"
```

### Commit: 1_Linguagem_M/

```bash
git add 1_Linguagem_M/
git commit -m "feat(Linguagem_M): criar estrutura base da aplicação"
```

### Commit: 2_DAX/

```bash
git add 2_DAX/
git commit -m "feat(DAX): criar estrutura base da aplicação"
```

### Commit: 3_TMDL/

```bash
git add 3_TMDL/
git commit -m "feat(TMDL): Inclusão dos arquivos _Medidas.tmdl e dimCalendario.tmdl"
```
