#include 'protheus.ch'
#include 'parmtype.ch'

user function FA050UPD ()
	Local lRet := .T.

	If ! Empty(SE2->E2_YCODZZ4)
		
		//testa a alteração
		If ALTERA
			lRet := .F.
		EndIf
		
		//testa a exclusao
		If ! ALTERA .AND. ! INCLUI // exclusao
			lRet := .F.
		EndIf 
		
		If ! lRet // se for alteracao ou exclusao
			MsgAlert('Não é possivel alterar o titulo pois o mesmo foi incluido a partir do cadastro de movimentos.', 'Atenção')
		EndIf				
		
	EndIf

return lRet
