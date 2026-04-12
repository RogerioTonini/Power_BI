let
    EntradaDados = (_listFiles as table, _tableName as text, _typeData as text) as table =>
        let
            FonteDados = _listFiles,
            PlanilhaSelecionada = Table.SelectRows(FonteDados, each [Name] = _tableName),
            ExpandeDados = PlanilhaSelecionada{[
                Item = _tableName,
                Kind = _typeData
            ]}[Data],
            _DadosNormalizados_ = Table.Buffer(Table.PromoteHeaders(ExpandeDados, [PromoteAllScalars = true]))
        in
            _DadosNormalizados_,
    metadados = [
        Documentation.Name = "fxExplodePlanilha",
        Documentation.Description = "em 01/04/2026, por Rogerio Tonini",
        Documentation.Examples = {
            [
                Description = "Explodir os dados da planilha/tabela [tb_planilhas] da planilha/tabela [Planilha1], que é do tipo [Sheet/tabela]",
                Code = "fxExplodePlanilha(tb_planilhas, ""Planilha1"", ""Sheet"")",
                Result = ""
            ]
        }
    ]
in
    Value.ReplaceType(EntradaDados, Value.ReplaceMetadata(Value.Type(EntradaDados), metadados))
