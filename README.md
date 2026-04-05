# Repositório de Modelos de BI

## Objetivo:

Biblioteca de scripts da Linguagem M, DAX e scripts TMDL para Power BI.

## Repositório para Linguagem M

## Repositório para DAX

## Repositório para TMDL

### Commit: Estrutura inicial - Git

```bash
git add .gitignore .gitattributes .githooks-scripts/
git commit -m "chore(git):
- Adicionar .gitignore, - Adicionar .gitattributes para normalização de arquivos e
configurar tratamento de arquivos binários,
- Adicionar scripts de hooks para Conventional Commits"
```

### Commit: Versão do Python e Dependências do Projeto

```bash
git add .python-version pyproject.toml poetry.lock
git commit -m "build:
- Configuração da versão do Python utilizada no projeto,
- Configuração do Poetry e bibliotecas (dependências) do projeto"
```

### Commit: Configurações do VSCode

```bash
git add .vscode/
git commit -m "chore(vscode): adicionar configurações do editor"
```

### Commit: README.md

```bash
git add README.md docs/.
git commit -m "docs: adicionar documentação do projeto"
```

### Commit: app / noteboos / sql

```bash
git add app/. notebooks/. sql/.
git commit -m "feat(app): criar estrutura base da aplicação (notebooks, sql)"
```

### Commit: Testes - Se for criado

```bash
git add tests/
git commit -m "test: adicionar estrutura de testes"
```
