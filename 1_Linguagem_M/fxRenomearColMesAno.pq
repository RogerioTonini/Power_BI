let
    EntradaDados =
        (
            _tabela as table,
            _nomeColuna as text
        ) as table =>
        let
            // Dicionario: abreviacao e nome por extenso PT-BR → numero do mes
            // Nota: chaves normalizadas (minusculo, c → c)
            DicMeses = [
                // Abreviados
                jan = "01", fev = "02", mar = "03",
                abr = "04", mai = "05", jun = "06",
                jul = "07", ago = "08", set = "09",
                out = "10", nov = "11", dez = "12",
                // Por extenso (marco = marco com c → c)
                janeiro   = "01", fevereiro = "02", marco     = "03",
                abril     = "04", maio      = "05", junho     = "06",
                julho     = "07", agosto    = "08", setembro  = "09",
                outubro   = "10", novembro  = "11", dezembro  = "12"
            ],

            // Normaliza o texto do mes: minusculo + substitui c por c
            NormalizarMes = (texto as text) as text =>
                Text.Replace( Text.Lower( texto ), "ç", "c" ),

            // Converte "jan/21" → "01/2021"
            ConverterValor = (valor as text) as text =>
                let
                    Partes   = Text.Split( valor, "/" ),
                    MesNorm  = NormalizarMes( Partes{0} ),
                    EhData   = List.Count( Partes ) = 2
                               and Record.HasFields( DicMeses, MesNorm ),
                    NovoValor =
                        if EhData then
                            Record.Field( DicMeses, MesNorm )
                            & "/"
                            & "20" & Partes{1}
                        else
                            valor
                in
                    NovoValor,

            // Aplica a conversao nos valores da coluna informada
            Resultado =
                Table.TransformColumns(
                    _tabela,
                    { _nomeColuna, each ConverterValor( _ ), type text }
                )
        in
            Resultado,

    metadados = [
        Documentation.Name        = "fxRenomearColMesAno",
        Documentation.Description =
            "Converte valores no formato 'mmm/aa' ou 'mmmmmm/aa' para 'mm/aaaa' dentro de uma coluna especificada. " &
            "Case-insensitive. Suporta c em marco. Valores fora do padrao sao mantidos intactos.",
        Documentation.Examples    = {
            [
                Description = "Converter valores da coluna MesAno",
                Code        = "fxRenomearColMesAno( MinhaTabela, ""MesAno"" )",
                Result      = "jan/21 → 01/2021, fev/21 → 02/2021, ..."
            ]
        }
    ]
in
    Value.ReplaceType(
        EntradaDados,
        Value.ReplaceMetadata(
            Value.Type( EntradaDados ),
            metadados
        )
    )
