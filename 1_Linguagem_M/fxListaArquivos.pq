let
    EntradaDados = (_tableName as table, _listFiles as text) as table =>
        let
            FonteDados = Table.CombineColumns(
                _tableName,
                {"Folder Path", "Name"},
                Combiner.CombineTextByDelimiter("", QuoteStyle.None),
                "Caminho_E_Arquivo"
            ),
            FiltraArquivos = Table.SelectRows(FonteDados, each Text.Contains([Caminho_E_Arquivo], _listFiles))
        in
            FiltraArquivos,
    metadados = [
        Documentation.Name = "fxListaArquivos",
        Documentation.Description = "em 01/04/2026, por Rogerio Tonini",
        Documentation.Examples = {
            [
                Description = "Listar o conteúdo de uma pasta que contenha no nome um texto específico",
                Code = "Exemplo: Carregar todos os arquivos da pasta que contenham o texto 'Movimenta' no nome.",
                Result = "Chamada da função: fxListaArquivos(NomeDaTabela, ""Movimenta"")"
            ]
        }
    ]
in
    Value.ReplaceType(EntradaDados, Value.ReplaceMetadata(Value.Type(EntradaDados), metadados))
