#include 'protheus.ch'
#include 'parmtype.ch'
#include 'tbiconn.ch'
#include 'topconn.ch'

/*/{Protheus.doc} ADVPLA05
(long_description)
@type user function
@author user
@since 17/09/2025
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/
User Function ADVPLA05()

	If Empty(FunName())
		Prepare Environment Empresa '99' Filial '01'
	EndIf

	oDlg := FWDialogModal():New() //cria a tela em si
	oDlg:SetTitle('Resumo Financeiro')
	oDlg:SetSubtitle('Dados do Resumo Financeiro')
	oDlg:SetSize(350,450) //largura, altura
	oDlg:CreateDialog() //cria o dialogo

	oPaneModal := oDlg:GetPanelMain() //painel principal do dialogo
	oLayer := FWLayer():New() //divisoes da tela
	oLayer:Init(oPaneModal) //inicializa o painel principal

	oLayer:AddColumn('col01',100,.T.)

	oLayer:AddWindow('col01','win01','Filtros',20)
	oPanel01 := oLayer:getWinPanel('col01', 'win01')

	oLayer:AddWindow('col01','win02','Dados',40)
	oPanel02 := oLayer:getWinPanel('col01', 'win02')

	oLayer:AddWindow('col01','win03','Grafico',40)
	oPanel03 := oLayer:getWinPanel('col01', 'win03')

	dDataDe := dDataBase - 30
	dDataAte:= dDatabase 

    oLblDe	:= TSay():create(oPanel01, {||  'Data de?' },5,5,,,,,,.T.,,,200,20)
	oGetDe  := TGet():New( 013, 005, { | u | If( PCount() == 0, dDataDe , dDataDe   := u ) },oPanel01, 060, 010, "@D",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"dDataDe",,,,.T.  ) //campo data

    oLblAte	:= TSay():create(oPanel01, {||  'Data Ate?' },5,75,,,,,,.T.,,,200,20)
	oGetAte := TGet():New( 013, 075, { | u | If( PCount() == 0, dDataAte, dDataAte := u ) },oPanel01, 060, 010, "@D",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"dDataAte",,,,.T.  ) //campo data

	oBrowse := FwBrowse():New(oPanel02)
 //cria o browser

	oBrowse:disableReport()	
	oBrowse:disableConfig()

	oChart := FwChartFactory():New() //cria o grafico
	oChart:SetOwner(oPanel03) //define o painel onde o grafico sera exibido
	oChart:SetLegend(CONTROL_ALIGN_LEFT) //alinha a legenda a esquerda

	oBrowse:SetDataQUery(.T.)
	oBrowse:SetAlias('QRY')
	oBrowse:SetQuery(getQuery())

	oCollum := FwBrwColumn():New() //cria a coluna para a descrição do grupo de despesa
	oCollum:SetData({|| QRY->ZZ1_DESCRI }) //dados que serao exibidos
	oCollum:SetTitle('Grupo de Despesa') //titulo da coluna	
	oCollum:SetSize(50)
	oBrowse:SetColumns({oCollum})

	oCollum := FwBrwColumn():New() //cria a coluna para o total
	oCollum:SetData({|| QRY->ZZ5_TOTAL })
	oCollum:SetTitle('Total')
	oCollum:SetSize(10)
	oCollum:SetAlign(2)
	oCollum:SetDecimal(2)
	oCollum:SetPicture('@e 999,999,999.99')
	oBrowse:SetColumns({oCollum})

	oBrowse:Activate()

	


	oDlg:AddButton('Sair'		, {|| oDlg:Deactivate() }, 'Sair', , .T., .T., .T., )  //adiciona o botao sair
	oDlg:AddButton('Atualizar'	, {|| oBrowse:SetQuery(getQuery()), oBrowse:Refresh() }, 'Atualizar',, .T., .T., .T., ) //adiciona o botao atualizar chamando a funcao getQuery e a funcao refresh do browse

	
	oDlg:Activate() // Ativa o diálogo (mantém a janela aberta)

Return

Static Function getQuery()
	
	//Local create

	cRet := " SELECT ZZ1_CODIGO, ZZ1_DESCRI, SUM(ZZ5_TOTAL) ZZ5_TOTAL FROM "  + RetSqlTab('ZZ5')
	cRet += " INNER JOIN " + RetSqlTab('ZZ2') + " ON ZZ5_FILIAL = ZZ2_FILIAL AND ZZ5_CODZZ2 = ZZ2_CODIGO " 
	cRet += " INNER JOIN " + RetSqlTab('ZZ1') + " ON ZZ1_FILIAL = ZZ2_FILIAL AND ZZ1_CODIGO = ZZ2_CODZZ1 "
	cRet += " INNER JOIN " + RetSqlTab('ZZ4') + " ON ZZ4_FILIAL = ZZ5_FILIAL AND ZZ4_CODIGO = ZZ5_CODZZ4 "
	cRet += " WHERE ZZ1.D_E_L_E_T_ <> '*' "
	cRet += " AND ZZ2.D_E_L_E_T_ <> '*' "
	cRet += " AND ZZ4.D_E_L_E_T_ <> '*' "
	cRet += " AND ZZ5.D_E_L_E_T_ <> '*' "	
	cRet += " AND ZZ4_DATA BETWEEN '" + DtoS(dDataDe) +"' AND '" + DtoS(dDataAte) + "' " 	
	cRet += " GROUP BY ZZ1_CODIGO, ZZ1_DESCRI "

	MontaGrafico(cRet)

Return cRet

// Static Function MontaGrafico(cQuery)

// 	if Select('QRY1') > 0
// 		QRY->(DbCloseArea())
// 	EndIf

// 	TcQuery cQuery New Alias 'QRY1'

// 	oChart:DeActivate()
// 	oChart:SetChartDefault(3) //tipo do grafico

// 	While ! QRY1->(Eof())
// 		oChart:AddSerie(QRY1 ->ZZ1_DESCRI, QRY1 ->ZZ5_TOTAL)
// 		QRY1->(DbSkip())//cQuery:AddData(QRY1->ZZ1_DESCRI, QRY1->ZZ5_TOTAL)
// 	EndDo

// 	oChart:Activate()

// Return 

Static Function MontaGrafico(cQuery)

    // --- CORREÇÃO APLICADA AQUI ---
    // Garante que o alias 'QRY1' seja fechado se já existir
	If Select("QRY1") > 0
		DbSelectArea("QRY1")
		DbCloseArea()
	EndIf
    // --- FIM DA CORREÇÃO ---

	TcQuery cQuery New Alias 'QRY1'

	oChart:DeActivate()
	oChart:SetChartDefault(3) //tipo do grafico

	While ! QRY1->(Eof())
		oChart:AddSerie(QRY1->ZZ1_DESCRI, QRY1->ZZ5_TOTAL)
		QRY1->(DbSkip())
	EndDo

	oChart:Activate()

Return
