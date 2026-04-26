let
    EntradaDados = (
        _listFiles      as table,
        _tableName      as text,
        _typeData       as text,
        _promoteHeaders as logical  // TRUE = promove cabeçalho; FALSE = retorna tabela bruta
    ) as table =>
        let
            FonteDados         = _listFiles,
            PlanilhaSelecionada = Table.SelectRows(FonteDados, each [Name] = _tableName),
            ExpandeDados        = PlanilhaSelecionada{[
                Item = _tableName,
                Kind = _typeData
            ]}[Data],
            _DadosNormalizados_ =
                if _promoteHeaders
                then Table.Buffer(Table.PromoteHeaders(ExpandeDados, [PromoteAllScalars = true]))
                else Table.Buffer(ExpandeDados)
        in
            _DadosNormalizados_,

    metadados = [
        Documentation.Name        =
            "fxExplodePlanilha",
        Documentation.Description =
            "Explode os dados de uma planilha/tabela de um arquivo Excel. "
            & "O parâmetro '_promoteHeaders' controla se a primeira linha "
            & "será promovida a cabeçalho (TRUE) ou se a tabela bruta será retornada (FALSE).",
        Documentation.Examples    = {
            [
                Description =
                    "Explodir os dados da aba [Planilha1] promovendo a primeira linha como cabeçalho",
                Code   =
                    "fxExplodePlanilha(tb_planilhas, ""Planilha1"", ""Sheet"", true)",
                Result =
                    "Tabela com cabeçalho promovido a partir da primeira linha"
            ],
            [
                Description =
                    "Explodir os dados da aba [Planilha1] sem promover cabeçalho (retorna tabela bruta)",
                Code   =
                    "fxExplodePlanilha(tb_planilhas, ""Planilha1"", ""Sheet"", false)",
                Result =
                    "Tabela bruta com colunas nomeadas Column1, Column2, ..."
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
