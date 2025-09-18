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

    Local cAlias := "ZZ1" //Nome da tabela
    Local cTitulo := 'Grupo de Despesas' //Titulo do cadastro
    Local cVldDel := "U_ADVPL01a()" //Valida��o para exclus�o
    Local cVldAlt := '.T.' //Valida��o para altera��o

    AxCadastro(cAlias, cTitulo, cVldDel, cVldAlt) //Chamada a fun��o gen�rica de cadastro

Return 

user function ADVPL01a()
    Local lRet := .T.

    If MsgYesNo('Tem certeza que deseja excluir?') //Se o usu�rio confirmar a exclus�o
        lRet := .T. //Permite a exclus�o
    Else
        lRet := .F. //Cancela a exclus�o
    Endif

Return lRet
