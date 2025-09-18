// #include 'protheus.ch'
// #include 'parmtype.ch'

// user function ADVPLR02()
//     Private oReport

//     ReportDef()

//     oReport:PrintDialog() //chama a tela de parametros do relatorio

// Return 

// static function ReportDef() //define o relatorio

// Local oSection1

//     oReport := TReport():New('ADVPLR02', 'Espelho do Movimento', '', {|oReport| PrintReport(oReport)}, 'Espelho do Movimento' ) //nome do relatorio, titulo, subtitulo, funcao de impressao, descricao

//     oSection1 := TRSection():New(oReport, 'Dados Gerais', {'ZZ4'}) //nome da secao e tabela

//     TRCell():New(oSection1, "ZZ4_STATUS", "ZZ4")
//     TRCell():New(oSection1, "ZZ4_CODIGO", "ZZ4")
//     TRCell():New(oSection1, "ZZ4_DATA", "ZZ4")
//     TRCell():New(oSection1, "ZZ4_TOTAL", "ZZ4")

//     oSection2 := TRSection():New(oReport, 'Detalhes do Movimento', {'ZZ5'}) // nome da secao e tabela

//     TRCell():New(oSection2, "ZZ5_CODZZ2", "ZZ5")
//     TRCell():New(oSection2, "ZZ5_DESCRI", "ZZ5")
//     TRCell():New(oSection2, "ZZ5_TOTAL", "ZZ5")


// return

// // static function PrintReport(oReport)

// //     Local oSection1 := oReport:Section(1)
// //     Local oSection2 := oReport:Section(2)

// //     oSection1:Init()
// //     oSection1:PrintLine() //imprime a secao 1

// //     oSection2:Init()

// //     ZZ5->(DbSetOrder(1))
// //     ZZ5->(DbSeek(cSeek := xFilial('ZZ5'), ZZ4->ZZ4_CODIGO)) //posiciona no primeiro registro de detalhes do movimento

// //     while ZZ5->(!Eof()) .AND. cSeek == ZZ5->(ZZ5_FILIAL) + ZZ5->(ZZ5_CODZZ4) //enquanto nao chegar no fim do arquivo e o codigo do movimento for igual ao da cabecalho

// //         oSection2:PrintLine() //imprime a secao 2

// //         ZZ5->(DbSkip()) //avanca para o proximo registro
// //     enddo

// //     oSection1:Finish()
// //     oSection2:Finish()

// //     oReport:EndPage()
// // return

// static function PrintReport(oReport)

//     Local oSection1 := oReport:Section(1)
//     Local oSection2 := oReport:Section(2)
//     Local cSeek

//     oSection1:Init()
//     oSection1:PrintLine()

//     oSection2:Init()

//     ZZ5->(DbSetOrder(1)) // Garante que o índice é (Filial + Cód. Movimento)

//     // Monta a chave de busca
//     cSeek := xFilial("ZZ5") + ZZ4->ZZ4_CODIGO

//     // --- CORREÇÃO APLICADA AQUI ---
//     // A chamada DbSeek deve ser feita diretamente, sem o ALIAS->()
//     // A função já atua na área de trabalho selecionada (ZZ5)
//     If DbSeek(cSeek)

//         // Itera enquanto a chave for a mesma e não for fim de arquivo
//         while !Eof() .AND. (ZZ5->ZZ5_FILIAL + ZZ5->ZZ5_CODZZ4) == cSeek
//             oSection2:PrintLine()
//             ZZ5->(DbSkip())
//         enddo

//     EndIf

//     oSection1:Finish()
//     oSection2:Finish()

//     oReport:EndPage()
// return

#include 'protheus.ch'
#include 'parmtype.ch'

user function ADVPLR02()
	Private oReport
	
	ReportDef()
	
	oReport:PrintDialog()
	
return

Static Function ReportDef()
	Local oSection1

	oReport := TReport():New('ADVPLR02', 'Espelho do Movimento', '', {|oReport| PrintReport(oReport) }, 'Espelho do Movimento' )
	
	oSection1 := TRSection():New(oReport, 'Dados Gerais', {'ZZ4'})

	TRCell():New(oSection1, "ZZ4_STATUS", "ZZ4")
	TRCell():New(oSection1, "ZZ4_CODIGO", "ZZ4")
	TRCell():New(oSection1, "ZZ4_DATA"	, "ZZ4")
	TRCell():New(oSection1, "ZZ4_TOTAL"	, "ZZ4")
	
	oSection2 := TRSection():New(oReport, 'Detalhes do Movimento', {'ZZ5'})
	TRCell():New(oSection2, "ZZ5_CODZZ2"	, "ZZ5")
	TRCell():New(oSection2, "ZZ5_DESCRI"	, "ZZ5")
	TRCell():New(oSection2, "ZZ5_TOTAL"		, "ZZ5")
	
Return

Static Function PrintReport(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)
	
	oSection1:Init()
	oSection1:PrintLine()
	
	oSection2:Init()
	
	ZZ5->(DbSetOrder(1))//Filial+CodigoZZ4
	ZZ5->(DbSeek(cSeek := xFilial('ZZ5') + ZZ4->ZZ4_CODIGO))
	
	While ZZ5->(!Eof()) .AND. cSeek == ZZ5->(ZZ5_FILIAL + ZZ5_CODZZ4)
		oSection2:PrintLine()
		ZZ5->(DBSkip())
	EndDo
	
	oSection1:Finish()
	oSection2:Finish()
	
	oReport:EndPage()	
	
Return
