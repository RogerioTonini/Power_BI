let
    EntradaDados = (
        _tabela       as table,
        _colunasFixas as list,
        _nomesUnpivot as list   // lista com exatamente 2 elementos: {nomeAtributo, nomeValor}
    ) as table =>
        let
            // Valida se _nomesUnpivot possui exatamente 2 elementos
            QtdNomes = List.Count(_nomesUnpivot),

            _nomeAtributo =
                if QtdNomes >= 1
                then _nomesUnpivot{0}
                else error Error.Record(
                        "Parâmetro inválido",
                        "_nomesUnpivot deve conter 2 elementos: {nomeAtributo, nomeValor}",
                        "_nomesUnpivot"
                    ),

            _nomeValor =
                if QtdNomes >= 2
                then _nomesUnpivot{1}
                else error Error.Record(
                        "Parâmetro inválido",
                        "_nomesUnpivot deve conter 2 elementos: {nomeAtributo, nomeValor}",
                        "_nomesUnpivot"
                    ),

            // Unpivot: mantém _colunasFixas como chave e empilha o restante em linhas
            Resultado =
                Table.UnpivotOtherColumns(
                    _tabela,
                    _colunasFixas,
                    _nomeAtributo,
                    _nomeValor
                )
        in
            Resultado,

    metadados = [
        Documentation.Name        = "fxUnpivotTable",
        Documentation.Description =
            "Função genérica de Unpivot. "
            & "Mantém as colunas informadas em '_colunasFixas' como chave "
            & "e transforma todas as demais em linhas. "
            & "Os nomes das colunas geradas são definidos pelo parâmetro '_nomesUnpivot'.",
        Documentation.Examples    = {
            [
                Description =
                    "Unpivot de uma tabela de custos por mês, "
                    & "mantendo idProduto como chave e nomeando as novas colunas",
                Code   =
                    "fxUnpivotTable("
                    & "ColunasRenomeadas, "
                    & "{""idProduto""}, "
                    & "{""MesAno"", ""Valor""})",
                Result =
                    "Tabela com colunas: idProduto | MesAno | Valor"
            ],
            [
                Description =
                    "Unpivot de uma tabela de vendas com múltiplas colunas fixas",
                Code   =
                    "fxUnpivotTable("
                    & "tbVendas, "
                    & "{""idVenda"", ""Regiao"", ""Produto""}, "
                    & "{""Periodo"", ""Quantidade""})",
                Result =
                    "Tabela com colunas: idVenda | Regiao | Produto | Periodo | Quantidade"
            ]
        }
    ]
in
    Value.ReplaceType(
        EntradaDados,
        Value.ReplaceMetadata(
            Value.Type(EntradaDados),
            metadados
        )
    )
