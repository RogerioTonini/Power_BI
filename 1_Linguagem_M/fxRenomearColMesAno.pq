let
    EntradaDados = (_tabela as table) as table =>
        let
            // Dicionário: abreviação e nome por extenso PT-BR → número do mês
            // Nota: chaves normalizadas (minúsculo, ç → c)
            DicMeses = [
                // Abreviados
                jan = "01", fev = "02", mar = "03",
                abr = "04", mai = "05", jun = "06",
                jul = "07", ago = "08", set = "09",
                out = "10", nov = "11", dez = "12",
                // Por extenso (marco = março com ç → c)
                janeiro   = "01", fevereiro = "02", marco     = "03",
                abril     = "04", maio      = "05", junho     = "06",
                julho     = "07", agosto    = "08", setembro  = "09",
                outubro   = "10", novembro  = "11", dezembro  = "12"
            ],

            // Normaliza o texto do mês: minúsculo + substitui ç por c
            NormalizarMes = (texto as text) as text =>
                Text.Replace(Text.Lower(texto), "ç", "c"),

            // Converte "jan/21" → "01/2021"
            ConverterNomeColuna = (nomeCol as text) as text =>
                let
                    Partes      = Text.Split(nomeCol, "/"),
                    MesNorm     = NormalizarMes(Partes{0}),
                    EhData      = List.Count(Partes) = 2
                                  and Record.HasFields(DicMeses, MesNorm),
                    NovoNome =
                        if EhData then
                            Record.Field(DicMeses, MesNorm)
                            & "/"
                            & "20" & Partes{1}
                        else
                            nomeCol
                in
                    NovoNome,

            // Filtra somente colunas no formato mes/ano (contêm "/")
            ColunasData =
                List.Select(
                    Table.ColumnNames(_tabela),
                    each Text.Contains(_, "/")
                ),

            // Monta pares {nome original, nome convertido}
            PareRenomeacao =
                List.Transform(
                    ColunasData,
                    each { _, ConverterNomeColuna(_) }
                ),

            Resultado =
                Table.RenameColumns(
                    _tabela,
                    PareRenomeacao
                )
        in
            Resultado,

    metadados = [
        Documentation.Name        = "fxRenomearColMesAno",
        Documentation.Description = "Renomeia colunas no formato 'mmm/aa' ou 'mmmmmm/aa' (abreviado ou por extenso) para 'mm/aaaa'. Case-insensitive. Suporta ç em março. Colunas fora do padrão são mantidas intactas.",
        Documentation.Examples    = {
            [
                Description = "Renomear colunas de mês/ano de uma tabela de custos",
                Code         = "fxRenomearColMesAno(ColunasMantidas)",
                Result       = "Tabela com colunas jan/21 → 01/2021, fev/21 → 02/2021, ..."
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
