#Include 'Protheus.ch'
#Include 'Parmtype.ch'
#include "FWMVCDEF.CH"

/*/{Protheus.doc} fADVPLA04
(long_description)
@type user function
@author user
@since 16/09/2025
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/
User Function ADVPLA04()

Local oBrowse
	//Montagem do Browse principal	
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias('ZZ4')
	oBrowse:SetDescription('Cadastro de Movimentos')
	oBrowse:SetMenuDef('ADVPLA04')
	oBrowse:Activate()
Return

//Montagem do menu 
Static Function MenuDef()
	Local aRotina := {}

	aAdd( aRotina, { 'Visualizar'	, 'VIEWDEF.ADVPLA04'	, 0, 2, 0, NIL } ) 
	aAdd( aRotina, { 'Incluir' 		, 'VIEWDEF.ADVPLA04'	, 0, 3, 0, NIL } )
	aAdd( aRotina, { 'Alterar' 		, 'VIEWDEF.ADVPLA04'	, 0, 4, 0, NIL } )
	aAdd( aRotina, { 'Excluir' 		, 'VIEWDEF.ADVPLA04'	, 0, 5, 0, NIL } )
	aAdd( aRotina, { 'Imprimir' 	, 'VIEWDEF.ADVPLA04'	, 0, 8, 0, NIL } )
	aAdd( aRotina, { 'Copiar' 		, 'VIEWDEF.ADVPLA04'	, 0, 9, 0, NIL } )

Return aRotina

//Construcao do mdelo
Static Function ModelDef()
	Local oModel
	Local oStruZZ4 := FWFormStruct(1,"ZZ4") //zz4 - cabeçalho
	Local oStruZZ5 := FWFormStruct(1,"ZZ5") //zz5 - (grid)

	oModel := MPFormModel():New("MD_ZZ4") 
	oModel:addFields('MASTERZZ4',,oStruZZ4) //Campos de cabeçalho
    oModel:AddGrid('DETAILSZZ5','MASTERZZ4', oStruZZ5) //Estrutura da Grid (ITENS, MODELO PRINCIPAL, ESTRUTURA DA GRID)

    oModel.SetRelation('DETAILSZZ5', { {'ZZ5_FILIAL', 'xFilial('ZZ5')'}, {ZZ5_CODZZ4, 'ZZ4_CODIGO'} }, ZZ5->(IndexKey(1))) //Relacionamento entre o cabeçalho e a grid


	oModel:SetPrimaryKey({'ZZ4_FILIAL', 'ZZ4_CODIGO'})

Return oModel

//Construcao da visualizacao
Static Function ViewDef()
	Local oModel := ModelDef()
	Local oView
	Local oStrZZ4:= FWFormStruct(2, 'ZZ4')

	oView := FWFormView():New()
	oView:SetModel(oModel)

	oView:AddField('FORM_ZZ4' , oStrZZ4,'MASTERZZ4' ) 
	oView:CreateHorizontalBox( 'BOX_FORM_ZZ4', 100)
	oView:SetOwnerView('FORM_ZZ4','BOX_FORM_ZZ4')

Return oView
