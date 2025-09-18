//CADASTRO DE CONTAS

#Include 'Protheus.ch' 
#Include 'Parmtype.ch'
#include "FWMVCDEF.CH"
/*/{Protheus.doc} ADVPLA03
//Fonte para cadastro de contas
@author Lazaro
@since 05/10/2025
@version 1.0
/*/
User Function ADVPLA03()
	Local oBrowse // Objeto do Browse
	
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias('ZZ3')
	oBrowse:SetDescription('Cadastro de Contas')
	oBrowse:SetMenuDef('ADVPLA03')
	oBrowse:Activate()
Return

//Montagem do menu 
Static Function MenuDef() // Retorna a matriz de rotina do menu
	Local aRotina := {}

	aAdd( aRotina, { 'Visualizar'	, 'VIEWDEF.ADVPLA03'	, 0, 2, 0, NIL } ) 
	aAdd( aRotina, { 'Incluir' 		, 'VIEWDEF.ADVPLA03'	, 0, 3, 0, NIL } )
	aAdd( aRotina, { 'Alterar' 		, 'VIEWDEF.ADVPLA03'	, 0, 4, 0, NIL } )
	aAdd( aRotina, { 'Excluir' 		, 'VIEWDEF.ADVPLA03'	, 0, 5, 0, NIL } )
	aAdd( aRotina, { 'Imprimir' 	, 'VIEWDEF.ADVPLA03'	, 0, 8, 0, NIL } )
	aAdd( aRotina, { 'Copiar' 		, 'VIEWDEF.ADVPLA03'	, 0, 9, 0, NIL } )

Return aRotina

//Construcao do mdelo
Static Function ModelDef()
	Local oModel
	Local oStruZZ3 := FWFormStruct(1,"ZZ3") // Estrutura da tabela ZZ3

	oModel := MPFormModel():New("MD_ZZ3") // Nome do modelo
	oModel:addFields('MASTERZZ3',,oStruZZ3) // Adiciona a estrutura ao modelo
	oModel:SetPrimaryKey({'ZZ3_FILIAL', 'ZZ3_CODIGO'}) // Define a chave primaria

Return oModel

//Construcao da visualizacao
Static Function ViewDef()
	Local oModel := ModelDef() // Chama a funcao que monta o modelo
	Local oView
	Local oStrZZ3:= FWFormStruct(2, 'ZZ3') // Estrutura da tabela ZZ3

	oView := FWFormView():New() // Cria a visualizacao
	oView:SetModel(oModel) // Seta o modelo na visualizacao

	oView:AddField('FORM_ZZ3' , oStrZZ3,'MASTERZZ3' ) // Adiciona os campos da estrutura na visualizacao
	oView:CreateHorizontalBox( 'BOX_FORM_ZZ3', 100) // Cria um box horizontal
	oView:SetOwnerView('FORM_ZZ3','BOX_FORM_ZZ3') // Define o box como dono do campo

Return oView
