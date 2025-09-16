#include "protheus.ch"
#include "parmtype.ch"

/*/{Protheus.doc} ADVPLA01
(long_description)
@type user function
@author Lazaro
@since 15/09/2025
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/
User Function ADVPLA01()

    Local cAlias := "ZZ1"
    Local cTitulo := 'Grupo de Despesas'
    Local cVldDel := "U_ADVPL01a()"
    Local cVldAlt := '.T.'

    AxCadastro(cAlias, cTitulo, cVldDel, cVldAlt)

Return 

user function ADVPL01a()
    Local lRet := .T.

    If MsgYesNo('Tem certeza que deseja excluir?')
        lRet := .T.
    Else
        lRet := .F. 
    Endif

Return lRet
