unit Global;
(*
Programador         Alterado   Detalhamento
------------------- ---------- ---------------------------------------------------------------------------------------------
Verônica            27/10/2005 PSE 6667 Layouts Mercantil e Banrisul. Criação da função TrazDescricaoErroPE_COB. 

Marta               03/10/2005 Criadas as funções CTBValidaClassificadorAuxiliar e CTBValidaGrauDosClassificaodresAuxiliares.

Verônica            21/09/2005 Ajuste na função VerificaSeOsImpostosOuDescontoOuAcrescimoTemContaContabil, adicionados os
                               parametros Modulo e Pessoajuridica, para fazer a validação da Conta de INSS corretamente.

Fabiano             15/09/2005 Ajuste na função IdentificarAlteracoes onde na consistencia de datas nulas estava permitindo
                               datas do tipo '30/12/1899'.

Thiago Guelere      03/08/2005 Ajuste na Função CGS_VerificaDocumentosEmRH - SIM 11921

Luis                29/07/2005 inclusão de uma query local na função DiaUtil
                               para poder usar em outros módulos(estava usando a dmCPG.qrFeriado)

Elaine              12/04/2005 SIM 9332  - Inclusão dos Históricos 912,913 - BCO e 966 - CTB para integração do CGS - Plano
                               de viagem. Retirei o DmCPG da função PesquisaECadastraHist

Marta               28/03/2005 SIM 10668 - Retirados da função VerificaPeriodoBancario os parâmetros de empresa e filial,
                               pois apresentava erro quando a conta utilizada era compartilhada e não pertencia a filial
                               da tela.

Elaine              18/03/2005 SIM - 10148 - Acerto na função ValidaIE, foi constada diferenças no tratamento para o
                               Estado de Bahia - BA

Sila                14/03/2005 Comentários para a função FocoProximoControle e FindWinControlByTag;
Luis                28/12/2004 inclusão da função relatorioEncerradoARR;

Luis                14/12/2004 Inclusão da procedure AtualizarUsuarioAPE e
                               função UsuarioLogadoAPE ( registra e consulta usuário GLOBUS
                               logado )

Verônica            18/11/2004 Adicionado o unibanco e mercantil para a cobrança eletronica.

Verônica            20/10/2004 Alterada a função ValidaIE, foi constada diferenças no tratamento para os
                               Estados de Acre - AC e Rondonia - RO. SIM - 9094.

Verônica            16/10/2004 Criadas as Funções ProximaLinha_RdPrint, para não precisar cria-la em cada relatorio, e a
                               Função FormataCNPJCPF.

Silvio              30/09/2004 Free em DireitoAoBotoesDaTela e DesabilitaMenusDoForm.

Verônica            21/09/2004 SIM 8811 - Alterado o codigo do banco Real de 275 - 365 para 356. Os filtros feitos pelos
                               outros codigos foram comentados.

Sila                18/09/2004 Alterações em PreencherComZerosSeNaoVazio

Silvio              14/09/2004 Inclusão do "PosicionaBotoes", que estava em TUR_Funcoes.

Verônica            13/08/2004 Liberado pagamento eletronico para Transvec - Itau

Silvio              09/08/2004 Criadas as funções QtdDeUsuariosConectados e AtualizandoBaseDeDados.

Sila                04/08/2004 Alteradas StrToObjeto e ObjetoToStr

Sila                02/08/2004 Incluídas funções StrToObjeto, ObjetoToStr e ImpRDPrint

Verônica            28/07/2004 SAS 5262 - Habilitando o pagamento eletronico para VIPE banco Bradesco.

Thiago Guelere      23/07/2004 Criado mais um parametro na Pesquisa ValidaCNPJCPF , o prametro criado
                               é para jogar a mascará na função, o Defaul é pMask = 'N' mas para
                               jogar a mascará é necessário passar dois parametro:
                               1º - pMask = '0' para Jogar a máscara e não contar como caracter os pontos , barras , etc.
                               2º - pMask = '1' para Jogar a máscara e contar como caracter os pontos , barras , etc.

Verônica            14/07/2004 Criando função para calcular o proximo docto para o CPG.

Verônica            07/07/2004 Refazendo alterações que foram perdidas. Ajuste na função de envio de email.

Verônica            06/07/20004 SIM 7517 - Incluida funções para envio de email para o CGS.

Danilo              02/07/2004 Acerto na função TrazFuncionario

Silvio              02/07/2004 Ajustes em "ValidaCNPJCPF" para eliminar Warnings.

Verônica            28/06/2004 Refazendo alterações que foram perdidas em alguma alteração.
                               Pagamento eletronico Santa Paula, 1001, conciliação da 1001.

Silvio              24/06/2004 Voltei a condição anterior no PesquisaArquivoHelp, pois algumas
                               aplicações tem o nome do EXE diferente do nome do projeto (Ex.:CPagar <> Contas a pagar).
                               o Help só não funcionará no caso de algum EXE renomeado.

Silvio              22/06/2004 Ajuste na PesquisaArquivoHelp para tratar o nome do arquivo HLP de acordo com a
                               aplicação e não com o nome do .EXE.

Verônica            14/06/2004 Inclusão da Função ValidacaoGeral_COB.

Daniel              09/06/2004 Incluida função "ValidaCNPJCPF" que verifica se o número
                               digitado é um CNPJ ou CPF válido.

Alessandro          19/03/2004 Incluída função "VerificaParametrosDaTela" que verifica
                               se os campos da tela de relatório estão preenchidos
                               caso ñ esteja estorna p/ o campo em branco.
                               Ver exemplo no TURRelPedidosEmitidos.Pas.

                               Incluído procedure "OrdenaColunas" que ordena as colunas do
                               do GRID que esteja associado a uma MemoryData.
                               Ver exemplo no TURConsultaPedidos.Pas.

Rioboo              11/03/2004 Alterado processos em GravaArqIni e LeArqIni, para aceitar
                               valores com mais de 4000 Chars. Foi criado um o campo ITEM
                               na tabela CTR_DADOS_INI para controlar as quebrar do
                               valor. Todo o processo era feito através de querys criadas
                               em tempo de execução (Criava e Destruia a cada chamada). Foi
                               então criada 5 querys no DmControle, são elas:
                               qryInsereINI, qryAlteraINI, qryDeletaINI, qryPesqINI e
                               qryLerINI, ficando assim fixo as cláusilças e não precisando
                               criar e destruir a cada solicitação. Melhora de tempo estimada
                               em 15% após avaliações.
Silvio              21/01/2004 A validação de IE para TO passa a aceitar 11 ou 9 dígitos,
                               no formato '99.99.999.999-9' ou '99.999.999-9'.
Silvio              15/01/2004 Ajustes na rotina DireitoAoBotoesDaTela
                    16/01/2004 Parâmetro de cor em Msg
Alessandro          12/01/2004 Inclusão da Função "IdentificaHintNaTela" p/ identificar
                               os componentes com HINT digitado e SHOWHINT=True
                               e marca-los em vermelho o canto superior esquerdo.
Silvio              01/12/2003 DiaUtil passa a tratar feriados por empresa/filial
Silvio              18/11/2003 Rotina SenhaUsuarioPosicional para os novos clientes (>= 122)
Alessandro          10/10/2003 Inclusão da Função "TrazComparacaoDivergente" p/ verificar se o cadastro foi alterado.
Verônica            29/09/2003 Inclusão da Função para validar as empresas e banco para conciliação eletronica
Elaine              12/06/2003 Inclusão da função para verificar teclas de atalho
                               com o ALT (VerificaTeclaAlt).
Rioboo              12/09/2002 Adaptação de LeArqIni e GravaArqIni para atender
                               às requisições da Folha que passam Arq.INI e para
                               aqueles que enviam o Path completo.
Silvio              10/09/2002 Alteração de LeArqIni e GravaArqIni para Gravar
                               em tabela. CTR_Dados_INI
                               *** Silvio, complete ou corrija ***
Silvio              25/09/2001 Rotina para validação de inscrição estadual
Silvio              23/02/2001 LeArqIni e GravaArqIni (<> da Folha)
Jefferson           07/12/2000 Incluido procedure para imprimir campo memo
Jefferson           28/09/2000 Alterado a rotina que calcula o número da requisição
                               por filial. Ao invés de colocar os digitos da empresa
                               + os digitos da filial, grava em uma tabela autilizar
                               uma sequencia correspendente, ou seja, no máximo irá
                               utilizar 3 digitos do número da requisição.
Nilson              18/09/2000 Nova funcao Numero_Aleatorio
Lima                17/07/2000 Colocada Funcao TrazFuncionario
*)

interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Wordcap, Menus, ComCtrls, ImgList, MemTable, db,
  CheckLst, Buttons, DBGrids, DBTables, UCrpe32, Printers, Math, WinSpool,
  IniFiles, Registry, ComObj, DdeMan, RxMemDS, Mask, IdSMTP, IdMessage,
  RDprint, TimeEdit, dbctrls, RXDBCtrl, Filtro_Generico, CPGComum, CTR_CAD_Classes,
  MenuItemPesquisa,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};
  

type
  TInscricao = Array[1..15] Of String;
  TValidaInscIE = Array[1..2] Of String;

  TDireitosDoUsuario = Record
    TemDireitoExclusao: Boolean;
    TemDireitoAlteracao: Boolean;
    TemDireitoInclusao: Boolean;
  end;

Type
  TRetornoDadosContabiesAposIntegracao =  Record
    Codlanca : Integer;
    DoctoLanca : String;
end;

Type
  TRetornoDadosBancariosAposIntegracao =  Record
    CodMovtoBCO : Integer;
    DoctoBCO : String;
end;

Type
  TRetornoProblemasIntegracaoBCO      =  Record
    PeriodoFechado  : Boolean;
    ExisteMovtoBco  : Boolean;
    OutrosProblemas : Boolean;
end;

Type
  TFilialAutorizadasParaoUsuario      =  Record
    FaixaDeFilial  : String;
    Msg            : String;
end;

Type
  TDadosDaEmpresa =  Record
    Inscricoes : Record
      Tipo      : String;
      CNPJ_CPF  : String;
      Municipal : String;
      Estadual  : String;
    end;
    RazaoSocial  : String;
    NomeFantasia : String;
    Telefone     : String;
    Fax          : String;
    HomePage     : String;
    Email        : String;
    PessoaFisica : String[1];
    Inativa      : String[1];
    Matriz       : String[1];
    Bancario : Record
      Banco   : Integer;
      Agencia : Integer;
      Conta   : String;
    end;
    Endereco : Record
      Endereco    : String;
      Numero      : String;
      Bairro      : String;
      Cidade      : String;
      CEP         : String;
      Complemento : String;
      Estado : Record
        UF          : String;
        Descricao   : String;
      end;
    end;
end;

Type
  TValoresDocto = Record
    Registro : Boolean;
    CPG_CRC : Record
      PIS        : Real;
      ISS        : Real;
      CSL        : Real;
      INSS       : Real;
      IRRF       : Real;
      Desconto   : Real;
      Acrescimo  : Real;
      Cofins     : Real;
      DescFinanc : Real;
    end;
end;

Type
  TCalculoDiferenciaAliquota =  Record
    VlrDifAliquota  : Real;
    VlrAliquota     : Real;
end;

Type
  TRetorno = Array of String; // usado para a pesquisa (Browse de pesquisa que foi transferido do DVS_funções para a Global )

  { Ficava em CPGFuncoes - Silvio 26/1/5 }
  TConsMat = Array[1..4] Of Integer; //1 -> CodFilialParaESF, 2 -> CodFilialParaCPG, 3 -> CodFilialParaCTB, 4 -> CodFilialparaCRC

function relatorioEncerradoARR(Form: TCustomForm): boolean;
(*  é utilizada pelos botões vizualizar e imprimir quando o sistema
    for ARR para verificar se o usuário pode emitir um determinado relatório
    dentro de um período.

    o nome do relatório vem da vcItemDeMenuChamador o usuário  da vcUsuario
    e as datas a função procura no form passado como parâmetro  *)

Procedure AtualizarUsuarioAPE(pAplicacao, pEstacao, pLoginWin, pLoginGlobus: String);
(* atualizada a T__ARR__APE com o usuário que logou no módulo

 Ex. : esta sendo utilizada no módulo de PVT no evento AfterLog do contBgmSenha *)

Function UsuarioLogadoAPE(pAplicacao, pLoginGlobus: String): boolean;
(* verifica se o usuário Globus utilizado já esta logado em outra estacao para o mesmo
   módulo

 Ex. : esta sendo utilizada para habilitar/desabilitar o menu movimentações
       do módulo de PVT  *)

Procedure PosicionaBotoes(pPanel: TPanel ; pMudaTamanhoDoPainel : Boolean = True ; pMudaTamanhoDosBotoes : Boolean = True ) ;
(* Posiciona os botões no painel especificado, de acordo com os padrões de alinhamento e tamanho.
Normalmente será utilizado no FormShow. Em alguns casos é utilizado em um momento em que precisa alinhar após tornar
o(s) botão(ões) visível em tempo de execução.

Ex.: PosicionaBotoes(Self.pnlBotoes);
*)

Function ProximoNumero(pTabela, pCampo : String ; pCondicao:String=''; pZero:Integer = 0; pIgnoraControle : Boolean = False) : String ;
(*
Traz o próximo número de um pCampo qualquer, de uma pTabela qualquer,
observando o parâmetro de próximo número do CTR.
*)

function LocalizaGrupos(pCodInternoMat: String): String;
(* Procura em EST_CADMATERIAL o CODIGOINTERNOMATERIAL igual a pCodInternoMat.
Retorna string composto pelas letras E D C obedecendo os seguintes critérios:
Se EST_CADMATERIAL.CODIGOGRE > 0, inclui 'E' no retorno (Estoque).
Se EST_CADMATERIAL.CODIGOGRD > 0, inclui 'D' no retorno (Despesa).
Se EST_CADMATERIAL.CODIGOGRC > 0, inclui 'C' no retorno (Compras).*)

procedure PopulaComboBox(Sender: TComboBox);
(*
Limpa e popula ComboBox com os elementos da constante (declarada em Global.pas)

vTpVenctoStr: Array[0..5] of String = ( 'Dias da data',
                                       'Dias da data líquida',
                                       'Dias fora a semana',
                                       'Dias fora a dezena',
                                       'Dias fora a quinzena',
                                       'Dias fora o mês'
                                     );*)
procedure BarraDeProgresso(pNivel, pPosAtual, pTotal: Integer; pMens: String = 'Aguarde ...'; pAlinhamento: String = 'C');
(*
Parâmetros
  pNivel       - Tipo de operação
  pPosAtual    - Utiliza-se um contador que vai de 0 ao valor máximo da barra
  pTotal       - Valor máximo da barra
  pMens        - Mensagem que deve ser exibida. Se omitida, assume "Aguarde ..."
  pAlinhamento - Alinhamento do texto na área de mensagens. Default = Centralizado. Pode ser "E", "C" ou "D".

Operações
  0 - Limpa o painel e salva o texto da barra de status na variável vTextoPanel
  1 - Executa o progresso da barra
  2 - Preenche o panel como finalizado
  3 - Finaliza

Exemplo
  // Inicializa sem a barra, mas com a mensagem
  BarraDeProgresso(0, 0, 0, 'Gerando arquivo ...');
  // Atualiza de acordo com o progresso
  While ...
      BarraDeProgresso( 1, vContadorDeLinhas, vTotalDeLinhas, 'Gerando arquivo ...');
  // Fecha e volta a mensagem salva
  BarraDeProgresso(3, 0, 0);
*)

procedure DesabilitaMenusDoForm(Sender: TObject);
(*
Controla os menus do form, de acordo com o menu principal. Se o usuário
tem no menu principal, terá no menu do form também.
Pode ser usado por qualquer sistema.*)

function CalculaDataVencto(pDtEmissao: TDateTime; pDias, pComboIndex: Integer): TDateTime;

function DiaUtil(Data: TDateTime; pEmpresa: Integer = 0; pFilial: Integer = 0): Boolean;
(*
Verifica se a data informada é dia útil.
Se informou empresa ou filial, fazer a consulta na tabela FINFERIA_EMPRESAFILIAL,
senão, faz a pesquisa da forma antiga, na tabela FINFERIA *)

function TrazSiglaTipoVencto(Sender: TComboBox): String;

function TrazNomeTipoVencto(vSigla: String): String;
function CPGValidaExercicio(pData: TDateTime; pEmpresa, pFilial: Integer; pMgs: Boolean = True; pSistema: String = '' ): Boolean;
function IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant ;
(*Retorna ResultTrue se pCondicao for true senão ResultFalse *)

function ValidaEmail(Email: String): Boolean;
Function CTBProximoDocumentoNoDia(Emp, Fil: Integer; Data: TDateTime; Bloqueia: Boolean; pCodLanca: Integer = 0): String;
function TrataHistorico(pHistorico, pTpDocto, pDocto, pParc, pForn: String ):String;
function TrataHistorico_Teste(pCodHist, pPlano, pEmpresa, pFilial: Integer; pTpHist: String; pTpDesp: String = ''; pTpRec: String = '' ): String;

function ValidaDataLimiteDeUso(Empresa, Filial: Integer; Sistema: String; Data: TDateTime): Boolean;
(*Retorna True se a data limite não foi ultrapassada.
Emite as seguintes mensagens:
Sistema não autorizado para esta empresa/filial.
Data além do limite de uso. Contactar concedente.
Sr. usuário, por favor, contactar o departamento de apoio do concedente. *)

function PesquisaECadastraHist(pEmpresa, pFilial, pCodHisto: Integer; pPlano, pTpHisto, pTextoPadrao: String; pDC: String = '' ): Boolean;
function RodandoEmNT: Boolean;
function ValidaDataMovto(pEmpresa: Integer; pFilial: Integer; pDataMovto: TDateTime; pConsisteDiaAtual: Boolean): Boolean;
function TrazUltimoDiaDoMesAtual(pData: String): TDateTime;
function ValidaNomeDoRPT(pNomedoRPT: String): Boolean;
function RemoveExtension(pFileName: String): String;
(*Remove a extensão de um arquivo *)

function TrataValorParaCheque(pValor: String): String;
function TrazNumeroRM(pEmpresa, pFilial: Integer; pNumDigitado: Double = 0): Double;
function TiraEComercial(vString: String): String;
(*Substitui em vString os '&' por 'E' *)

function FindFile(InitDir: String; FileName: String): String;
(*Procura um arquivo FileName a partir do Diretório InitDir.
Se encontrado, retorna o caminho e o nome do arquivo.
Caso contrário, retorna ''.*)

function FormataCampo(pCampo: String; pTam: Integer; pComZero: Boolean; pDireita: Boolean): String;
function TrazFuncionario(var pCodigo: String): Integer;
function TrazNomeRelatorio(Sender: TObject): String;
function ValidaReport: String;
function UtilizaLogotipoPadrao: Boolean;
function Numero_Aleatorio: Integer;
function Pad(InputString: String; Size: Integer; Align: String = 'E'): String;
(*Retorna String com espaços à esquerda ou direita, dependendo do
alinhamento solicitado.

Exemplos:
  1) Considere a chamada para 'TEXTO DE EXEMPLO', cujo tamanho = 16.
  Pad('TEXTO DE EXEMPLO', 20, 'E') = 'TEXTO DE EXEMPLO    ';
  Pad('TEXTO DE EXEMPLO', 20, 'D') = '    TEXTO DE EXEMPLO';
  Pad('TEXTO DE EXEMPLO', 20, 'D') = '  TEXTO DE EXEMPLO  ';

  2) Para centralizar com o RdPrint:
    with Print do
      Imp(2, 1, Pad(vTitulo, TamanhoQteColunas, 'C'))
*)
function Pict(Numero: Real; TamTotal: Byte; Decimais: Byte; SuprimeSeZero: Boolean = False): String;
(*Retorna uma String contendo um número alinhado à direita, formatado de acordo com os parâmetros:
    Numero       : número que deseja formatar
    TamTotal     : tamanho total do número (parte inteira + parte decimal + pontuação)
    Decimais     : número de casas decimais
    SuprimeSeZero: retorna uma string vazia do tamanho que solicitou no parâmetro TamTotal

  Exemplos:
    Pict(123456, 7, 2 ) ->   '.456,00' - Neste caso será exibido uma msg somente em nosso ambiente
    Pict(1234,   8, 2 ) ->  '1.234,00'
    Pict(12345 , 6, 0 ) ->    '12.345'
    Pict(     0, 5, 2 ) ->     '     '
*)
function Space(Tamanho: Integer): String;
(* Retorna String contendo "Tamanho" espaços em branco *)
procedure ImprimeCampoMemo(pMemo: TMemo; pLabel: TLabel; pTitulo: String; pImpCabec: Boolean = True; pNomeImp: String = 'GLOBUSM');
(* A label é para exibir em qual impressora está sendo impresso *)
procedure ImprimeCaracEspeciais(Impressora: String; S: String);
function DireitoAoBotoesDaTela(Usuario, Sistema, NomeItemMenu: String; NomeCaption: String = ''; pAlteraVariaveisGlobais: Boolean = true): TDireitosDoUsuario;
{Se AlteraVariaveisGlobais = true (padrão), carrega as variáveis globais

    vcTemDireitoExclusao := CTR_MENUSAOUSUARIO.TemDireitoExclusaoMenu
    vcTemDireitoAlteracao := CTR_MENUSAOUSUARIO.TemDireitoAlteracaoMenu
    vcTemDireitoInclusao := CTR_MENUSAOUSUARIO.TemDireitoInclusaoMenu

  onde
      CTR_MENUSAOUSUARIO.USUARIO = Usuario
    e CTR_MENUSAOUSUARIO.SISTEMA = sistema
    e CTR_MENUSAOUSUARIO.CAPTION = nomeitemmenu ou nomeCaption

Se AlteraVariaveisGlobais = false,
  somente atribui os valores acima ao retorno da função.

OBS: As variáveis globais declaradas no dmControle
       dm.vTemDireitoExclusao
       dm.vTemDireitoAlteracao
       dm.vTemDireitoInclusao

     serão substituídas pelas declaradas em GLBComum
       vcTemDireitoExclusao
       vcTemDireitoAlteracao
       vcTemDireitoInclusao
}
Function CTBVerificaSeGravaSaldoNoProximoMes(p_Empresa, p_Filial: Integer; p_Data: TDateTime): String;
function FormataValorFloat(xValor: String): Double;
{
Procedure GravaArqIni(vSecao, vChave, vValor: String; vArquivoIni: String = ''; vModulo: String = '');
Function LeArqIni(vSecao, vChave: String; vArquivoIni: String = ''; vModulo : String = ''): String;
Mesma função da Global. Manter compatibilidade de parâmetros, para usar o include do TXT.
}
{$Include \Globus\sistemas\Procedure_GravaArqIni_Declaracao.txt}
{$Include \Globus\sistemas\Function_LeArqIni_Declaracao.txt}
Function ValidaHistorico(PCodigoEmpresa, PCodigoFG: Integer; vPlano: String; vFlagIntegradoCCTB: Boolean ): Boolean;
Function ProximaSequencia(pNomeSequence: String): Integer;
procedure ImpressoraEspecifica(pNomeImpressora: String);
Function VerificaSeEmpresaPossuiFilial(pEmpresa: Integer): Boolean;
Function TrazInscricaoEmpresa(pEmpresa, pFilial: Integer): String;
Function ImpressoraEspecificaRDP(pNomeImpressora: String): String;
Function DefineComoImpressoraPadrao(pNomeDaImpressora: String): Boolean; // Silvio
Procedure RetornaImpressoraPadrao;
Function RodandoRemoto: Boolean;
Function IncInt(Var pVlr: Integer; pIncremento: Integer = 1): Integer;
(* Incrementa uma variável de tipo inteiro com o valor definido em pIncremento
  e devolve o valor atualizado.
  Última alteração: 02/08/2004 - acrescentado o parâmetro pIncremento *)

Function EliminaNaoNumericos(pEntrada: String): String;
(*Retorna somente os caracteres da String compreendidos entre 0 e 9.*)
Procedure Msg(pMsg: String = ''; pColor: TColor = clBtnFace);
(*
  Coloca uma mensagem na área de mensagens do menu principal.

  É possível informar no segundo parâmetro a cor. Este recurso de cor é utilizado para chamar
  a atenção, como no caso de transações abertas (amarelo) e direitos dos usuários aos botões
  (vermelho). Não deve ser utilizado em situações "normais".

  Para voltar a mensagem padrão, basta chamar sem parâmetros.

  Ex.:

  // Coloca a mensagem
  Msg('Recalculando saldos do período ...');
  // Processa
  RecalculaSaldosDoPeriodo;
  // Restaura a mensagem padrão
  Msg;

  Também já é executado um Application.ProcessMessages, fazendo com que as demais aplicações
  sejam tratadas pelo Windows, evitando os "congelamentos" de telas.
*)

Function ValidaIE(pIE, pUF: String): TValidaInscIE;
Function Concatena(Var pString1: String; pString2: String): String;
(*Retorna a concatenação pString1 e pString2 no Result da função e em pString1 *)
Function NoChar(S: String; Ch: Char): String ;
(*Retira de S o caracter definido em Ch.*)
Function TrazProximoCodLanca: Integer;
Function RemoveAcentos(Str: String): String;
(*Remove de str os seguintes caracteres:
àèìòùâêîôûãõñáéíóúýçäëïöüÿÀÈÌÒÙÂÊÎÔÛÃÕÑÁÉÍÓÚÝÇÄËÏÖÜæÆåÅ*)
Function RemoveCaractersDiferentedeAlfa(Str: String): String;
//Function TrazDadosDaEmpresa(PEmpresa, PFilial: Integer): TInscricao;

Function TrazDadosDaEmpresa(PEmpresa, Pfilial : Integer) : TDadosDaEmpresa;


Function Traco(pQtde: Integer; pCharCompl: Char = '-'; pCharIniFin: Char = '+'): String;
(* Devolve uma String com caracteres "c" ou '-'
  Se nao for passado o parâmetro de quantidade,
  utiliza a variável RelWid. O "t" e' o caractere
  utilizado no início e final da String.
  Exemplo - > Traco(80,'-','|') *)

Function TrocaCaracteres(pCharSubt, pCharTroca : Char; Str: String): String;
(*Substitui em str o caracter pCharSubt por pCharTroca *)
Function PesquisaArquivoHelp: String;
(* pesquisa se existe o arquivo de help para colocar na barra de status o F1 *)
Function ValidacaoGeral_PE(pTipoVal: String; pCodBanco: String = ''; pEmpresa: Integer = 1; pFilial: Integer = 1; pSistema: String = 'CPG'): Boolean;
Function TrataEComercial(pString: String ):String;
(*Substitui em pString os '&' por 'E' *)
Function TrazProximoCodMovto: Integer;
Function MesEmPortugues(pString: String): String;
(* Substitui o nome completo do mês em Inglês pelo nome completo em português.
Exemplo: MesEmPortugues('JANUARY') = 'JANEIRO'
         MesEmPortugues('FEVEREIRO') = 'FEVEREIRO'
         MesEmPortugues('FEB') = 'FEB'
         MesEmPortugues('SET') = 'SET' *)

Function FormataClassFisc(pCodClass: String; pCFOPAcordo: Boolean = True): String;
function VerificaGrupoDeNatureza( pGNatureza, pConta: String): Boolean;
Procedure ValidaObjetosPorFaixa(vForm: TForm; Sender: TObject);
Function ReconectaBanco(pUsuario, pSenha : String): Boolean;
Function TrazCodigoCliente: Integer;
Function Right(pString: String; pTam: Integer): String;
(*Retorna pTam posições de pString a partir da direita
Exemplo: Right('EXEMPLO', 3) = 'PLO'*)
Function Left(pString : String; pTam: Integer): String;
(*Retorna pTam posições de pString a partir da esquerda
Exemplo: Left('EXEMPLO', 3) = 'EXE'*)
Procedure AbrePaginaWeb(pURL: String);
(*Tenta abrir a página definida em pURL pelo InternetExplorer.
Se não conseguir, tenta abrir pelo NetScape.*)
Function MsgConfirmaFechamentoDoSistema: Boolean;
Function VerificaTeclaAlt(var Key: Word; Shift: TShiftState; vTecla:Char): Boolean;
(*Verificar teclas de atalho com o ALT *)

Function ConverteValor(vValor: Double; vQtdDecimal, vTamanho: Integer): String;
(*Converte vValor em um String de vTamanho posições, observando a
quantidade de casas decimais definida em vQtdDecimal.*)

Function NumberToTime(vCampo: String): TDateTime;

Function ValidacaoGeral_ConciliacaoEletronica(pTipoVal : String; pCodBanco: String = ''; pEmpresa : Integer = 1; pFilial : Integer = 1; pSistema: String = 'CPG'): Boolean;

Function TrazComparacaoDivergente(pQuery: TQuery; pCriaRx: Boolean = True): String;
(*Verifica se o cadastro foi alterado. *)

Function MostraErrosQuery(pErrors: EDBEngineError; pExibeMsg: Boolean = False): String;

procedure GetSQL(qry: TQuery; vMemo: TMemo = nil; vSoRetornaParametros: Boolean = false; vIdentificador: String = '');
(*Sila Ferrari - 10/11/2003
Coloca em Memo1.Lines e na área de transferência
o qry.SQL substituindo as variáveis "Bind" pelos valores
atribuídos aos parâmetros. Utilizado em testes.

Se vSoRetornaParametros = true, retorna somente os valores atribuídos
às variáveis "Bind".

Última alteração: 15/06/2004
*)

procedure ImpRDPrint(Print: TRDPrint; vRow, vCol: Integer; vField: TField; vCampo: String = ''; vAlinhamento: Char = 'E'; vMascara: String = ''; vImprimirZero: Boolean = true);
(*Última alteração: 02/08/2004

Imprime o String vCampo ou o conteúdo de vField na linha (vRow) e coluna (vCol)
determinadas.
É possível definir o alinhamento ('E', 'D' ou 'C').
Se vField <> nil e vMascara <> '', o campo será formatado.
Se vField for Integer ou Float e seu conteúdo for igual a zero,
só será impresso se vImprimirZero = true
*)

Function  SenhaUsuarioPosicional: Boolean;
(* Para os novos clientes (superiores a 121), tratar a senha do usuário de forma posicional.
Para os demais clientes que quiserem trabalhar desta forma,
bastará incluir o código nesta rotina.
Silvio - 18/11/2003 *)

function TotalHrs(vEntra, vSaida, vIIni, vIFin: TDateTime; vRetorno: Integer = 1): Currency;
(* Quando não utilizar viini, vifin enviar 0,0  - retornos:
   1 - Qtde de Minutos;
   2 - Qtde Horas Centesimal;
   3 - Qtde Horas Normais
   4 - Qtde Dias;
   5 - Qtde Horas Normais (até 24hrs, desconsidera o dia)
   6 - Qtde Horas Centesimais (até 24hrs, desconsidera o dia) *)

Procedure IdentificaHintNaTela(Sender: TObject);
(*
Identifica e marca o canto superior esquerdo com vermelho
os componentes com HINT digitado e SHOWHINT = True*)

Procedure VerificaCriaSequence(pNomeSequence, pTabela, pCampoBase: String);
Function VerificaNroPlanoCTBParaFilial(pEmpresa, pFilial: Integer): Integer;
Function VerificaParametrosDaTela: Boolean ;
(*
Retorna true se todos os componentes visíveis e habilitados do form
foram preenchidos.
Em caso negativo, emite a mensagem 'Dados essenciais não foram digitados !'
e foca no primeiro componente não preenchido.*)

procedure OrdenaColunas(pColuna: TColumn) ;
(*
Ordena a coleção de dados de um grid que esteja associado
a uma MemoryData e desenha a seta de indicação de ordenação
se a propriedade dgIndicator do grid estiver true.
Ver exemplo no TURConsultaPedidos.Pas*)

Function ValidaCNPJCPF(pCNPJ: TMaskEdit; pMask: String = 'N'): Boolean;
(*
Thiago Guelere 23/07/2004
Criado mais um parâmetro na Pesquisa ValidaCNPJCPF.
Se pMask = 'N' (default), não utiliza máscara.
Se pMask = '0', utiliza máscara e não conta caracteres como os pontos, barras, etc.
Se pMask = '1', utiliza máscara e conta caracteres como caracter os pontos, barras, etc.
*)

Function ValidacaoGeral_COB(pTipoVal: String; pCodBanco: String = ''; pEmpresa: Integer = 1; pFilial: Integer = 1; pSistema: String = 'CRC'): Boolean;

Function EnviaEmail(vEmailDestino, vEmailOrigem, vAssunto, vMensagem, vAvisoEnviando, vAvisoErro, vHost, vSenha, vPort, vUsuario: String; vHtml: String = ''): Boolean;

Function VerificaSeEnviaEmail(PUsuario : String; vEnviaEmail: Boolean): Boolean;

Function ProximoDocto_CPG(pEmpresa, pFilial, pCodigoForn : Integer; pSerie : String; pDocto : String = '') : String;

(*Calcular o próximo docto para o CPG *)

function StrToObjeto(Sender: TObject; vValor: String): Boolean;
(*Atribui vValor ao objeto e retorno true se não houve erros

Última alteração: 04/08/2004

Classe           Ação
TCheckBox        Checked := iif(vValor = 'T', True, False)
TRadioGroup      ItemIndex := StrToIntDef(vValor, 0)
TComboBox        ItemIndex := StrToIntDef(vValor, 0)
TEdit            Text := vValor
TNumEdit         Text  := vValor
TCheckListBox    Checked := iif(vValor = 'T', True, False), dependendo do nº de elementos e sequência da String
*)


function ObjetoToStr(Sender: TObject): String;
(*Última alteração: 04/08/2004

Transforma o valor do objeto em String

Classe           Retorno
TCheckBox        'T' ou 'F'
TComboBox        StrToInt(ItemIndex)
TRadioGroup      StrToInt(ItemIndex)
TEdit            Text
TNumEdit         Text
TCheckListBox    String composta de 'T' ou 'F', dependendo do estado do
                 Checked e do nº de elementos
*)

Function AtualizandoBaseDeDados : Boolean;
(*Última alteração: 09/08/2004

Verifica se o Globus está em processo de atualização de base, impedindo que o
módulo seja aberto.
*)

Function QtdDeUsuariosConectados : Integer;
(*Última alteração: 09/08/2004

Retorna a qtd de usuários conectados. Será utilizado para informar na hora de
disparar o processo de atualização de base.
*)


function FinalMenorQueInicial(vInicial, vFinal: TWinControl; vMensagem: String; vFocalizarInicial: Boolean): Boolean;
{Retorna TRUE se o valor de vFinal maior que vInicial e emite a mensagem

vMensagem + ' final menor que ' + vMensagem + ' inicial.'

Se vFocalizarInicial, focaliza vInicial.
Última alteração: 15/09/2004
}

function FindWinControlByTag(vClasse: TClass; vForm: TForm; vTag: Integer): TWinControl;
{Retorna o Controle do vForm cuja classe = vClasse e tag = vTag.
Se o objeto não for encontrado, retornará Nil, que deverá ser tratado na aplicação chamadora.

Útil para habilitar SpeedButton de pesquisa atrelados a Edits ou
focar Edits atrelados a SpeedButton de pesquisa.
Nesse caso, é interessante que os Tags do Edit e do SpeedButton sejam iguais.

Ex:
  FindWinControlByTag(TSpeedButton, Self, 10);
  // Retorna o SpeedButton do form chamador cuja tag é 10.

  FindWinControlByTag(TSpeedButton, Self, TWinControl(Sender).Tag);
  // no OnExit de um TEdit,
  // Retorna o SpeedButton do form em uso cujo Tag é igual ao Tag do Edit chamador.

  FindWinControlByTag(TSpeedButton, Self, TEdit(Sender).Tag);
  // no OnExit de um TEdit,
  // Retorna o SpeedButton do form em uso cujo Tag é igual ao Tag do Edit chamador.


  FindWinControlByTag(TSpeedButton, Self, TWinControl(Sender).Tag).Enabled := false;
  // no OnExit de um TEdit,
  // Desabilita o SpeedButton do form em uso cujo Tag é igual ao Tag do Edit chamador.
  // Esta forma de uso pode dar Acess Violation caso a função retorne Nil.
  // Nesse caso, melhor uso seria:

    procedure Tform1.Edit1Exit(Sender: TObject);
    var
      vWinControl: TWinControl;
    begin

      vWinControl := FindWinControlByTag(TSpeedButton, Self, TWinControl(Sender).Tag);
      if vWinControl <> nil then
        vWinControl.Enabled := false;
    end;

    // ou

    procedure Tform1.Edit1Exit(Sender: TObject);
    var
      vBotao: TSpeedButton;
    begin

      vBotao := FindWinControlByTag(TSpeedButton, Self, TEdit(Sender).Tag).Enabled := false;
      if vBotao <> nil then
        vBotao.Enabled := false;
    end;

  ///////////////////////////////////////////////////

  if Sender is TSpeedButton then
    Sender := FindWinControlByTag(TEdit, Self, TWinControl(Sender).Tag);
  // Carrega o Sender com o Edit que tem o mesmo Tag do Botão de pesquisa clicado.


Última alteração: 15/09/2004
}


procedure EventoEditBuscaChange(Sender: TObject; vForm: TForm);
{Desabilita o SpeedButton associado ao Sender se seu valor for vazio.
Para tanto, é necessário definir o Tag do SpeedButton igual ao do Sender.
Se o Sender for do tipo DB, habilita o Sender se o DataSet estiver em Edição ou Alteração.
Última alteração: 26/10/2004
}

procedure HabilitarComponente(Sender: TWinControl; Habilitar: Boolean; AtribuirValor: String = 'NAOATRIBUIRVALOR');
{Habilita ou não o componente e muda a cor para cinza ou branco.
Se AtribuirValor <> 'NAOATRIBUIRVALOR', carrega com AtribuirValor.
Última alteração: 15/09/2004}

function SaiuComSetaParaBaixo(Sender: TObject; Key: Word; vValor: String = ''; vForm: TForm = nil): Boolean;
{Retorna TRUE se o usuário apertou seta para baixo.
Se vValor <> '', tenta atribuir o valor ao TWinControl(Sender).Text.

Se vForm <> nil, tenta localizar o SpeedButton atrelado ao Sender para desabilitá-lo.
Para tanto, é necessário definir o Tag do SpeedButton igual ao do Sender.

Última alteração: 15/09/2004}
function FocoProximoControle(Ativo, Atual: TWinControl; vExcetoTabOrder: Integer = -1; vExcetoControle: TWinControl = nil): Boolean;
{Obs: controle ATIVO = controle focado = ActiveControl

Retorna TRUE se o foco aparece em um controle ANTERIOR ao ATUAL.

Para tanto, usa como base o TabOrder dos componentes envolvidos.
Basicamente, o retorno será TRUE se TabOrder do ATIVO for maior que o do ATUAL.
Porém, como os controles podem pertencer a Panels ou GroupBox (Parent) diferentes,
ou ainda, estar em um panel dentro do outro, a função verifica se o TabOrder dos Parents até esgotar as possibilidades.

Normalmente é utilizado em eventos OnExit para testar se o BrowseDePesquisa dever ser aberto ou não.
Nesse caso, o ATIVO é o controle que detém o foco e o ATUAL é o que disparou o Exit.

vExcetoTabOrder define a exceção do foco. Por exemplo, se o controle ATIVO for qualquer botão de pnlBotoes, não é desejável que o BrowseDePesquisa seja disparado.
Passando -1 (default), esse teste não será feito.

vExcetoControle tem a mesma funcionalidade de vExcetoTabOrder, porém, é menos abrangente.
Enquanto vExcetoTabOrder trata todos os botões de um Panel como exceção,
vExcetoControle define um único controle para isto. Por exemplo, não é desejável que o
BrowseDePesquisa seja aberto se o controle ATIVO for o botão Limpar.

Exemplo 1:

  procedure Tform1.Edit1Exit(Sender: TObject);
  begin
    if FocoProximoControle(ActiveControl, TEdit(Sender)) then
      AbreBrowseDePesquisa;
  end;

  O retorno da função depende do Parent do controle Ativo e do Atual.
  Se eles pertencerem ao mesmo Panel, GroupBox, Form, etc, o retorno será true
  se o TabOrder do ATIVO for maior que o do ATUAL.

Exemplo 2:

  procedure Tform1.Edit1Exit(Sender: TObject);
  begin
    if FocoProximoControle(ActiveControl, TEdit(Sender), pnlBotoes) then
      AbreBrowseDePesquisa;
  end;

  Retorna true se o foco estiver no controle seguinte, EXCETO se o foco estiver em qualquer botão do painel de botões (botão Cancelar, por exemplo).

Exemplo 3:

  procedure Tform1.Edit1Exit(Sender: TObject);
  begin
    if FocoProximoControle(ActiveControl, TEdit(Sender), -1, Limpar1) then
      AbreBrowseDePesquisa;
  end;

  Retorna true se o foco estiver no controle seguinte, EXCETO se o foco estiver no botão Limpar1.
  
Última alteração: 20/10/2004}

procedure PreencherComZerosSeNaoVazio(var Sender: TObject; vTamanho: Integer);
{Se edt.Text = '', preenche edt.Text com
vTamanho zeros à esquerda
Última alteração: 15/09/2004}

Function ProximaLinha_RdPrint(pLinha, pRdPrint : Pointer) : Integer;
{ utilizado para calcular a proxima linanha para as listagens e controlar a quantidade
de linhas por página. 
}

Function FormataCNPJCPF(pString, pTipo : String): String;
{Define a mascara para o CNPJ e CPG.
 Exemplo: FormataCNPJCPF('123456789012345','CNPJ');

}

function GetIndiceArray(vTipo: String; vArray: Array of String): Integer;
(*
Retorna o índice de vArray
onde vTipo = vArray[i]
Útil principalmente quando se usa constantes do sistema.
Sila 20/10/2004 *)


function EliminaSeparadorMilhar( pValor: String ): String;

Function VerificaPeriodoBancario(pbanco, pagencia: Integer; pConta : String; pData : TdateTime ) : Boolean;
(*
 irá buscar a data limite da conta bancária, e compara-la com a data passada para verificar se o período esta liberado para receber
 novos lançamentos.
 Verônica 31/12/2004
*)

Function VerificaSeDoctoBancarioJaExiste(pbanco, pagencia : Integer; pConta, pDocumento: String; pData : TdateTime = 0 ) : Boolean;

Function EfetuaIntegracaoComBancos(pempresa, pfilial, pbanco, pagencia, phistorico : Integer; pConta, pComplHist, pTpDespesa, pTpReceita, pDocumento, pTipoPagtoIni, pTipoPagtoFin : String; pData : TdateTime; pValor : Double; pProximo : boolean = False; pCodLanca : Integer = 0; pConfirmadoMovtoBCO : String = 'S'; pConciliadoMovtoBCO : String = 'N'; pDataEfetiva : TDateTime = 0) : TRetornoDadosBancariosAposIntegracao;
(*
 Utilizar esta função quando for necessário fazer integração com o modulo de bancos.
 Esta função irá verificar se o periodo esta aberto para lançamento. Estando irá fazer a integração.
 Passando o parâmetro pProximo como True, irá calcular o próximo número disponível para a banco/agência/conta/data.
 Se este campo for definido como False é necessário passar o campo pDocumento.
 Verônica 31/12/2004
*)

Function BCOProximoDocto(pBanco, pAgencia : integer; pConta, pTipoPagtoIni, pTipoPagtoFin : String; pData : TDateTime = 0) : String;
(*
 Calcula o próximo documento livre para o banco/agência/Conta. Se o parâmetro data estiver informado irá calcular o próximo documento para
 a data.
 Verônica 31/12/2004
*)

Function CancelaIntegracaoComBancos(pCodMovtoBco : Integer; pData : TDateTime) : TRetornoProblemasIntegracaoBCO;
(*
 Faz a exclusão da movimentação bancaria.
 Se o período estiver fechadonão irá desfazer a movimentação
 Verônica 31/12/2004
*)

Procedure CGS_VerificaAtrelamentoVeiculos(pCodigoVeic : Integer);
(*
 Buscará as carretas cadastradas para o veículo informado.
 Verônica 03/01/2005
*)

Function CGS_VerificaParametrosLocais(pEmpresa, pFilial, pGaragem : Integer) : Boolean;
(*
 Irá buscar as opções dos paramêtros locais
 Verônica 03/01/2005
*)

Function CGS_VerificaDocumentosVeiculoEmDVS(pEmpresa, pFilial, pGaragem, pCodigoVeic : Integer; pData : TDateTime; pProduto : Integer = 0; pValidaProduto : Boolean = False) : Boolean;
(*
 Irá verificar se a documentação do veículo esta vencida
 Verônica 03/01/2005
*)

Function CGS_VerificaInspecaoDoVeiculoEmDVS(pEmpresa, pFilial, pCodigoVeic, pProduto, pTipoDocto: Integer; pData : TDateTime; pNrDocto : String) : Boolean;
(*
 Irá verificar se a inspeção do veículo esta vencida
 Verônica 05/01/2005
*)

Function CGS_VerificaCursosEmRH(pEmpresa, pFilial, pGaragem, pTipoVeic,pTipoCarreta1,pTipoCarreta2,  pCliente, pFuncao : Integer; pData : TDateTime; pMotorista : String)  : Boolean;
(*
Verifica se o motorista possue todos os cursos obrigatórios exigidos pelo tipo de veículo, cliente e função do motorista
Celen 11/01/2005
*)

Function CGS_VerificaDocumentosEmRH(pEmpresa, pFilial, pGaragem, pFuncao : Integer; pData : TDateTime; pMotorista : String)  : Boolean;
(*
Verifica se os documentos obrigatório exigidos pela função do motorista estão válidos
Thiago Guelere  03/08/2005
Celen           12/11/2004
*)

Function CGS_VerificaGerencRiscoEmRH(pEmpresa, pFilial, pGaragem, pDocumento, pTipoDocto : Integer;
                                     pMotorista, pSerie : String;
                                     pTela : String = '';
                                     pValorNF : Real = 0) : Boolean;
(*
pTela : cTela_Coleta - 'C' - Coleta
pTela : cTela_DocumentosDeServico - 'DS' - Documentos de Serviço

Verifica se o valor a ser transportado está dentro do limite permitido para o motorista (gerenciamento de risco)
O parametro pTela verifica o tipo de tela. Foi feita esta alteração por causa da tela de coleta.

pTela:    Se for a tela de coleta ou baixa de coleta, passar 'C' como parâmetro. Se não for nenhuma
          dessas duas, não precisa passar nada.
pValorNF: Na tela de coleta já existe uma variável com o valor total das notas. Portanto não é necessário
          passar pelo select da função. É só passar essa variável como parâmetro. Se a tela não tem essa
          variável de soma dos valores das nf´s, não precisa passar nada como parâmetro.

Thiago  25/04/2005
Celen   12/01/2005
*)

Procedure GravaDadosContabeisEmTabelaAuxiliarParaIntegracao(pMtDadosIntegracaoCTB: Pointer; pEmpresa, pFilial, pPlano, pCodHistoCTB : Integer; pValor : Double; pContaCTB, pCustoCTB, pDC, pCodTpDespesa : String; pCriatabela : Boolean = False; p_HitoricoText : String = ''; pConjunto : Integer = 1; pMostraMsg : boolean = True );

Function EfetuaIntegracaoComCTBComBaseNosDadosContabeis(pMtDadosIntegracaoCTB: Pointer; pEmpresa, pFilial, pPlano : Integer; pData : TDateTime) : TRetornoDadosContabiesAposIntegracao;

Function GeraHistoricoContabilOuBancario( pCodHist, pPlano, pEmpresa, pFilial : Integer; pTpHist : String; pTpDesp : String = ''; pTpRec : String = '' ):String;


function LastDayOfMonth ( pData : TDateTime ) : Integer;
(*
Devolve o último dia do mês da data informada em pData.
*)

function LastDayOfMonthStr ( pData : TDateTime ) : String;
(*
Devolve uma string numérica de 2 dígitos com o último dia do mês da data informada em pData.
*)

function LastDateOfMonth( pData : TDateTime ):TDateTime;             // Retorna a última data do mes
(*
*)

function LeftAlignCh ( S: String; n : Integer; Ch: String ) : String ; // Alinhamento a esquerda
function RightAlignCh( S: String; n : Integer; Ch: String ) : String ; // Alinhamento a direita
Function VerificaSeCompartilhaContas(pEmpresa, pFilial : Integer) : Boolean;
Function VerificaSeCompartilhaContasCaixa(pEmpresa, pFilial : Integer) : Boolean;
Procedure VerificaSePodeExcluirLanctoCTB(pCodLanca : Integer );
Procedure ExcluiCTB(pEmpresa, pFilial, pCodLanca, pPlano : Integer);
Function BuscaNumeroBancoParaPE(vCodBanco : Integer) : String;
Function MascaraClassificador(pMask : String) : String;
Function GrauClassificador(pClass : String) : Integer;
function IntegracaoPorTipoDeDocto( Sender:TObject; pEmpresa, pFilial : Integer; pTpDoc : String ): Boolean;
function ValidaTipoHistorico( pCodHistorico, pEmpresa, pFilial : Integer ):Boolean;
function VerificaSeSubstitui( pCodDocto : Integer; pSistema : String ):Boolean;
function ReplicaDataDePagamento( pDataPagto : TDateTime; pCodMovtoBCO : Integer; pSistema : String ; pCodDocto : Integer = 0; pTipo : String = 'S' ) : Boolean;
(*
 Utilizado para copiar a data de pagamento e o código do lançamento bancário para os documento de susbtituídos e devolvido.

  Quando o pTipo for igual a "S" será para os documentos de susbtituição se for "D"seá para os documentos de devolução.
  Os documentos de adiantamento não podem receber a data de pagamento do documento associado pois, são pagos separadamente.

 Ex.
  ReplicaDataDePagamento( edPagto.Date, vCodMovtoBco, vcSistema, vCodDocto, 'S' )
  ReplicaDataDePagamento( edPagto.Date, vCodMovtoBco, vcSistema, vCodDocto, 'D' )

  A função ja existia e já é utilizada em algumas telas, só alterei para poder aplicar a regra para os documentos de devolução.

  Verônica
*)
Function TrazCodigosDaFilialParaIntegracao(pEmpresa,pFilial: Integer; pSistema:String) : TConsmat;
Function PegaContaCTBdaCC(pBanco, pAgencia : Integer; pConta : String ):Integer;
Function ValidaIMPOSTOCRC( pPlano, pEmpresa, pFilial : integer; pTelaInclusao : Boolean = False ): Boolean;
function PegaDescricaoDoTpDoc( pEmpresa, pFilial : Integer; pTpDoc : String ) : String;
Function VerificaSeOsImpostosOuDescontoOuAcrescimoTemContaContabil(pModulo : String = 'CRC'; pPessoaJuridica : Boolean = True) : Boolean;
Function VerificaUFFilial(pEmpresa,pFilial : integer) : String;
Function DataParaExtenso( pData : String ): String;
(*
Gera uma string no formato "DD de M...M de AAAA".

Ex.:

DataParaExtenso('17/03/2005') retorna '17 DE MARCO DE 2005'
*)
function TrazTipoDeInscricao( pEmpresa : Integer ): String;
(*
Retorna CNPJ, CPF ou CEI.
*)
function TrazCodigoDeInscricao( pEmpresa : Integer ): String;
(*
Retorna o número do CNPJ, CPF ou CEI, formatados.
*)

function StrToChar(S: String): Char;
(*
Se S = '', retorna ' '. Caso contrário, retorna o S[1].
Evita Access Violation.
*)

function ColocarFoco(vControle: TWinControl): Boolean;
(*
Testa se o vControle pode receber o foco.
E retorna True se conseguiu focar.
*)

Function ValorDoIndiceParaConversao(pCodIndic : String; pVencimento : TDateTime ) : Double;
(*
 Traz o valor para o codigo da moeda (FININDIC) gravado no documento.
 Função criada para cálculo de valores onde deve ser convertido para alguma outra moeda.
 Exemplo: Dolar

 Verônica - 16/04/2005 
*)

Function FilialQueOUSuarioTemAutorizacao(pEmpresa, pFilialIni, pFilialFin : Integer ) : TFilialAutorizadasParaoUsuario;
(*
  Traz as filiais que o usuário tem direito de uma empresa e dentro de uma faixa de filiais informadas.

  Função pode ser utilizada quando na tela tiver o campo empresa (bgmPedeEmpresa)
  e campos de filial inicial e final que não sejam o componente de bgmPedeFilialGaragem.

  Exemplo.
  Empresa = 66
  Filial inicial = 1
  Filial finail = 999
  Usuário = João ( este usuario tem direito as filiais 4, 8, 50, 66 )
  Para o usuário Manager e Globus é retornado as filiais do campo.

  Irá trazer para a faixa de filiais autorizadas para o usuário. Neste caso o retorno será
  FaixaDeFilial = '4, 8, 50, 66 '.
  Para o usuário Manager e Globus a FaixaDeFilial ficará em branco.

*)

Function ModuloAutorizadoParaEmpFil(pEmpresa : Integer; pSistema : String; pFilial : Integer = 0) : Boolean;

Function ModuloAutorizado(pSistema : String) : Boolean;
(*
  Verifica se o módulo está autorizado para qualquer empresa

  Verônica 15/07/2005
*)

Function CalculoDeJurosDiarioEmValorOuPercentual(pPercentual_Juros, pValor : Double) : Double;

Function Modulo11(Valor: String; Base: Integer = 9; Resto : boolean = false; Incrementa : boolean = True; pBanco : String = '') : string;
(*
   Rotina muito usada para calcular dígitos verificadores
   Pega-se cada um dos dígitos contidos no parâmetro VALOR, da direita para a
   esquerda e multiplica-se pela seqüência de pesos 2, 3, 4 ... até BASE.
   Por exemplo: se a base for 9, os pesos serão 2,3,4,5,6,7,8,9,2,3,4,5...
   Se a base for 7, os pesos serão 2,3,4,5,6,7,2,3,4...
   Soma-se cada um dos subprodutos.
   Divide-se a soma por 11.
   Faz-se a operação 11-Resto da divisão e devolve-se o resultado dessa operação
   como resultado da função Modulo11.
   Obs.: Caso o resultado seja maior que 9, deverá ser substituído por 0 (ZERO).
   Utilizado no componente que imprimi o boleto bancário, e na função CalculaDigitoNossoNumero do CPGFunção
   Verônica 16/05/2005
*)

function Modulo10(Valor: String) : string;
(*
   Rotina usada para cálculo de alguns dígitos verificadores
   Pega-se cada um dos dígitos contidos no parâmetro VALOR, da direita para a
   esquerda e multiplica-se por 2121212...
   Soma-se cada um dos subprodutos. Caso algum dos subprodutos tenha mais de um
   dígito, deve-se somar cada um dos dígitos. (Exemplo: 7*2 = 14 >> 1+4 = 5)
   Divide-se a soma por 10.
   Faz-se a operação 10-Resto da divisão e devolve-se o resultado dessa operação
   como resultado da função Modulo10.
   Obs.: Caso o resultado seja maior que 9, deverá ser substituído por 0 (ZERO).
   Utilizado no componente que imprimi o boleto bancário, e na função CalculaDigitoNossoNumero do CPGFunção
   Verônica 16/05/2005
*)

Function RetornaStringComSomaDeValoresGrandesSemExpoentes(pValor1, pValor2 : String; pQtdDeQuebras, pOperador : Integer) : String;
(*

*)

function TrazMascaraNrProcesso : String;

function TrazMascaraNumeroOP : String;

function HoraToInt(vHora: TDateTime): Integer;
(* Converte a Hora (DateTime) para Hora (Integer) *)

function IntToHora(vHora: Integer): TDateTime;
(* Converte a Hora (Integer) para Hora (DateTime) *)
procedure AtribuirParametrosAPartirDoDataSet(DataSet: TDataSet; qrySQL: TQuery);
(*
Carrega os parâmetros de qrySQL com os Campos de DataSet.
Para tanto, é necessário que os parâmetros tenha o mesmo nome dos campos do DataSet.
*)
function IdentificarAlteracoes(vAtual, vAnterior: TQuery): String;
(* Compara os Parâmetros de vAtual com os Campos de vAnterior e retorna String com as Diferenças.
   Para tanto, é necessário que os parâmetros tenha o mesmo nome dos campos *)
Function CTBValidaClassificadorAuxiliar(pPlano : integer; pDesprezaContaSemClas : boolean = false) : boolean;
(* Verifica se os classificadores auxiliares foram definidos com mesma máscara, se não retorna False.
Retorna False também se não tiver sido definido pelo menos um grau para o classificador.  Guarda o maior
grau do classificador na variável vMaiorGrau e a máscara na variável vMask.
Marta - 03/10/2005
*)
Function CTBValidaGrauDosClassificadoresAuxiliares(pPlano : integer) : boolean;
(* Verifica se todos os graus do classificador auxiliar foram definidos, e se um classificador sintético
foi definido em mais de uma conta contábil.
Marta - 03/10/2005
*)
Function GetValoresDeDoctoSubstituido(pCodDocto : Integer; pModulo : String = 'CPG' ) : TValoresDocto;
(*
 Busca os valores de Impostos, Descontos e acréscimo dos documentos substituído para fazer a integração destes valores.
 Verônica - 04/10/2005 
*)

Function TrazDescricaoErroPE_COB(pbanco, pErroPE : String; pOpcao : String = 'PE') : String;
(*
 Traz a descrição para o código retornado no arquivo de retorno dos bancos.
 Função utilizado no retorno de cobrança eletrônica e pagamento eletrônico.
 Está função faz uso do array de erros do CPGComum.

 Verônica - 27/10/2005
*)

Function TemCaracterNaoNumerico(pEntrada : String) : boolean;
(*
  Verifica se a string possui caracteres não númericos.
  Criada pos tive problema com o try no D7.
  Verônica - 02/11/2005
*)
function Arredondar(Valor: Double; Dec: Integer): Double; { Função transferido do EST_Funcoes para cá. }

function Pesquisa(Titulo, Cabecalho, Colunas, RetornoI, RetornoII,
                  OrdemDefault, Tabela, Condicao: String;
                  TrazDadosEntrada: Boolean = True;
                  PesquisaI: String = '';
                  PesquisaII: String = ''): String;
(*Abre o browse de pesquisa.

 Titulo = caption do Form

 Cabecalho = Títulos das colunas separados por vírgulas

 Colunas = Nomes dos campos das tabelas separados por vígulas.

           Regras para preenchimento:
           * Todas as colunas COM Alias.
           * Todas as colunas SEM Alias.

           Ex: 'ANOOFICIO,COD_ORGCONC,NRCART'

           Se for o caso, utilize o Alias da tabela.
           *********************************************************
           ATENÇÃO: AO UTILIZAR ALIAS, COLOQUE-O EM TODAS AS COLUNAS
           *********************************************************

           Ex: 'O.ANOOFICIO,O.COD_ORGCONC,C.NRCART'

           Para retornar funções, use chaves.
           Ex: '{DISTINCT NROFICIO AS NROFICIO}'
               '{DISTINCT NROFICIO AS NROFICIO},ANOOFICIO,COD_ORGCONC,{LPAD(NROFICIO, 10, ''0'') AS ORDENAR}

 RetornoI = Nome do campo a ser retornado

 RetornoII = Nome do campo a ser retornado

 OrdemDefault = Coluna pertencente a "Colunas" que determina a ordem de exibição da pesquisa

 Tabela = Tabelas a serem pesquisadas. EX: 'PVT_ESTOQUE E, PVT_PASSE P'

 Condição = Links das Tabelas. EX: 'P.CODPASSE = E.CODPASSE'

 TrazDadosEntrada = Se falso, determina que o grid estará vazio qdo chamado

 PesquisaI e PesquisaII = Não consegui identificar o uso. Se alguém
                          souber, favor alterar este comentário. (Sila)


 EXEMPLO DE CHAMADA:

  if Pesquisa( 'Tabela de Cliente', // Título
               'NrCli,RSocial,Cidade,UF,Codigo,CNPJ/CPF,NFantasia', // Cabeçalo
               'C.NRCLI,C.RSOCIALCLI,C.CIDADECLI, C.CODIGOUF, ' +
               'C.CODCLI ,C.NRINSCRICAOCLI, C.NFANTASIACLI',      // Colunas
               'NRCLI',                            // RetornoI
               'NRINSCRICAOCLI',                   // RetornoII
               'RSOCIALCLI',                       // OrdemDefault
               'BGM_CLIENTE C',                    // Tabela
               '',                                 // Condição
               True,                               // TrazDadosEntrada
               '',                                 // PesquisaI
               '') = '' Then                       // PesquisaII
    ...



   BrowsePesquisaArray( vRetorno,
                      , 'Consulta de clientes e clientes esporádicos' // Título
                      , 'CNPJ,RSocial,Nrcli,Cidade,UF,Fantasia'       // Cabeçalho
                      , 'CNPJ,RSOCIAL,NRCLI,CIDADE,UF,NFANTASIA'      // Colunas
                      , 'NRCLI,RSOCIAL,CNPJ'                          // ListaDeRetornos
                      , 'Nfantasia'                                   // OrdemDefault
                      , 'VWCGS_ClientesComEsporadicos'                // Tabela
                      , ''                                            // Condição
                      , True                                          // TrazDadosEntrada
                      , ''                                            // PesquisaI
                      , ''                                            // PesquisaII
                      );
   if vRetorno[2] = '' then
     MensagemDlg('CNPJ não existe!', mtInformacao, mbOk);
 end;

 ...

*)

procedure BrowsePesquisaArray(var vRetorno: TRetorno; Titulo, Cabecalho, Colunas, ListaDeRetornos, OrdemDefault, Tabela, Condicao: String; TrazDadosEntrada: Boolean = True; PesquisaI: String = ''; PesquisaII: String = '');

(*
 Criada por Sila e Thiago Guelere em 20/07/2004.

 vRetorno = Array que será carregado com os campos de "ListaDeRetornos"
            Obs: o array sempre iniciará em 0.

 Titulo = caption do Form

 Cabecalho = Títulos das colunas separados por vírgulas

 Colunas = Nomes dos campos das tabelas separados por vígulas.

           Regras para preenchimento:
           * Todas as colunas COM Alias.
           * Todas as colunas SEM Alias.

           Ex: 'ANOOFICIO,COD_ORGCONC,NRCART'

           Se for o caso, utilize o Alias da tabela.
           *********************************************************
           ATENÇÃO: AO UTILIZAR ALIAS, COLOQUE-O EM TODAS AS COLUNAS
           *********************************************************
           Ex: 'O.ANOOFICIO,O.COD_ORGCONC,C.NRCART'

           Para retornar funções, use chaves.
           Ex: '{DISTINCT NROFICIO AS NROFICIO}'
               '{DISTINCT NROFICIO AS NROFICIO},ANOOFICIO,COD_ORGCONC,{LPAD(NROFICIO, 10, ''0'') AS ORDENAR}

 ListaDeRetornos = Nomes dos campos das tabelas separados por vígulas.
                   Não é necessário que o campo de retorno esteja mencionado em Colunas.

                   Se for o caso, utilize o Alias da tabela.

                   Ex: 'ANOOFICIO,COD_ORGCONC,NRCART'
                       'V.VIGENCIA,V.CODPASSE,V.VALOR'

 OrdemDefault = Coluna pertencente a "Colunas" que determina a ordem de exibição da pesquisa

 TrazDadosEntrada = Se falso, determina que o grid estará vazio qdo chamado 


 EXEMPLO DE CHAMADA:

 ...

 var
   vRetorno: TRetorno;
 begin

   BrowsePesquisaArray( vRetorno,
                      , 'Consulta de clientes e clientes esporádicos' // Título
                      , 'CNPJ,RSocial,Nrcli,Cidade,UF,Fantasia'       // Cabeçalho
                      , 'CNPJ,RSOCIAL,NRCLI,CIDADE,UF,NFANTASIA'      // Colunas
                      , 'NRCLI,RSOCIAL,CNPJ'                          // ListaDeRetornos
                      , 'Nfantasia'                                   // OrdemDefault
                      , 'VWCGS_ClientesComEsporadicos'                // Tabela
                      , ''                                            // Condição
                      , True                                          // TrazDadosEntrada
                      , ''                                            // PesquisaI
                      , ''                                            // PesquisaII
                      );
   if vRetorno[2] = '' then
     MensagemDlg('CNPJ não existe!', mtInformacao, mbOk);
 end;

 ...

*)


Procedure ChamaGlobusReport;
(*
  Abre o gerador de relatórios Globus report

  Verônica - 05/01/2006
*)

Function CalculaDiferencialDeAliquota(pUFEmp, pUFForn : String; pImposto, pBaseCalculo, pValorContabil, pAliquota : Double) : TCalculoDiferenciaAliquota;
(*
  Faz calculo do diferencial de aliquota dos documentos de entrada (escrituração fiscal), quando a UF do Fornecedor for
  diferente da Uf da Filial.
  Se o documento não tiver aliquota usar a aliquota da UF do fornecedor.
  Pega-se a Aliquota do documento ou da Uf do Fornecedor e subtrai da aliquota da Uf da Filial,
  Com o resultado da subtração aplica-se o calculo ou na base de calculo (se houver) ou no valor contábil
  do documento, este valor é o diferencial de aliquota

  Exemplos:
     Docto VlrContábil  BaseCalculo AliquotaDoct UF Fornecedor Uf Filial
         1      100,00       100,00          12%            RJ        SP
         2      152,20         0,00           0             RJ        SP

     Aliquota SP = 18%
     Aliquota RJ = 7%

     Docto 1 = AliqCalculo => 12 - 7 = 5%
               Diferencial => 100,00 * 5% = 5,00

     Docto 2 = AliqCalculo => 18 - 7 = 11%
               Diferencial => 152,20 * 11% = 16,74

  Verônica 13/12/2005 
*)

Var
  vTamCFOP,  vColuna                                   : Integer;   // Utilizada pela procedure OrdenaColunas()
  vPathRels, vTitulo, vNomeRelatorio, vMsgAnterior     : String;    // Utilizada pela procedure Msg()
  vPossuiFilial, vOrdem                                : Boolean;   // Utilizada pela procedure OrdenaColunas()

  vContaAdto,      vContaCSL,        vContaISS,            vContaCOFINS,
  vContaPIS,       vContaIRRF,       vContaINSS,           vContaINSS_PF,
  vContaDesconto,  vContaAcrescimo,  vContaDescFinanceiro, vContaUnica,
  vMask : String;

  vTemContaValidaISS,       vTemContaValidaPIS,           vTemContaValidaCSL,      vTemContaValidaCOFINS,
  vTemContaValidaIRRF,      vTemContaValidaINSS,          vTemContaValidaDesconto, vTemContaValidaAdto,
  vTemContaValidaAcrescimo, vTemContaValidaDescFinaceiro, vTemContaValidaINSS_PF,  vTemContaValidaUnica,
  vErroMask : Boolean;

  vQuantDeCodigos, vMaiorGrau, vGrauClas : integer; // Função VerificaSeSubstitui - Silvio

  VetorDeCodigos : Array of Integer; // Função VerificaSeSubstitui - Silvio

  vc_Inss, vc_Irrf,      vc_ISS,       vc_PIS,          vc_COFINS,
  vc_CSL,  vc_Desconto,  vc_Acrescimo, vc_Adiantamento, vc_DescFinanceiro,
  vc_Inss_PF, vc_ValorUnico : Double;
  PMenuPesquisa : TPopupMenu ;
  IMenuPesquisa : TMenuItemPesquisa ;

  vcVariaveisDeHistContabeis : Record
    TXT                : String; { Utilizado pelo DVS }
    PlanoViagem : Record { Utilizado pela integração do Plano de viagem }
      NomeMotorista : String;
    End;
    Documento : Record
      NrDocto            : String;
      NrParcela          : String;
      DoctoPE            : String;
      ObsItemDocto       : String;
      ObsDocto           : String;
      NrOP               : String;
      Favorecido         : String;
      SerieDocto         : String;
      DtVencimento       : String;
      HistCheque         : String;
      NrCheque           : String;
      NrBordero          : String;
      FormaPagto         : String;
    end;
    FornOuCli : Record
      Numero             : String;
      RSocial            : String;
      NFantasia          : String;
    end;
    TipoDocto : Record
      Codigo             : String;
      Descricao          : String;
    end;
    Folha : Record
      CompFolhaDDMMYYYY  : String; { Utilizado pela Folha }
      CompFolhaMMYYYY    : String; { Utilizado pela Folha }
      TipoFolha          : String; { Utilizado pela Folha }
      AgrupEventos : Record
        Codigo           : String; { Utilizado pela Folha }
        Descricao        : String; { Utilizado pela Folha }
      end;
      AgrupContabil : Record
        Codigo           : String; { Utilizado pela Folha }
        Descricao        : String; { Utilizado pela Folha }
      end;
    end;
    Contabil : Record
      CodConta           : String; { Utilizado pela Folha }
      DescConta          : String; { Utilizado pela Folha e Contabilidade }
      DescCCusto         : String; { Utilizado pela Folha }
    end;
end;

implementation

uses
    CGSComum, dmControle, {dmfolha,} dmContabil, dmContasPagar, Bgm_dados,
  {CPGFuncoes,}  Flp_PesquisaFuncionario,  MenuPrincipal, bgm_tela, bgm_string,
  BgmPedeEmpresa, BGMPedeFilialGaragem, ToolEdit, NumEdit, CGC, CPF,
  CTRPesquisa,
  Confirma, Imprimir // Por causa da função IntegracaoPorTipoDeDocto - Silvio
  ;


var
  vTextoPanel1, vTextoPanel2 : String;
  ar_AuxFileName : Array[0..255] of Char;
  vsai : boolean;
  qrPesqAux, qrPesqAux2 : TQuery;
  vRxCompDive : TRxMemoryData ;

const
     //vParamHisto  : Array[0..6] of String;
     vTipoVencto  : Array[0..5] of String = ( 'DDD','DDL','DFS','DFD','DFQ','DFM' );
     vTpVenctoStr : Array[0..5] of String = ( 'Dias da data',
                                              'Dias da data líquida',
                                              'Dias fora a semana',
                                              'Dias fora a dezena',
                                              'Dias fora a quinzena',
                                              'Dias fora o mês'
                                            );

var
   Dia : Integer;
   vNomeDoRelatorio : String;



Function EliminaSeparadorMilhar( pValor: String ): String;
Begin

   {
   Enquanto existir separador de milhar na string
   a rotina tratará para

   Depois retira o separador de decimal caso não o
   necessite - ",00"
  }

   While Pos( ThousandSeparator, pValor ) > 0 do
     pValor := Trim( Copy( pValor, 1, Pos( ThousandSeparator, pValor )-1 )+Copy( pValor, Pos( ThousandSeparator, pValor )+1, Length( pValor ) ) );

   If ( Pos( DecimalSeparator, pValor ) > 0 ) and ( StrToInt(Trim(Copy( pValor, Pos( DecimalSeparator, pValor )+1, Length( pValor ) ) ) ) = 0 ) then
      pValor := Copy( pValor, 1, Pos( DecimalSeparator, pValor )-1 );

     Result := pValor;

end;


procedure populaComboBox(Sender : TComboBox);
var
   i : Integer;
Begin

   TComboBox(Sender).Clear;
   for i := 0 to 5 do
    TComboBox(Sender).Items.Add(vTpVenctoStr[i]);

end;

function CalculaDataVencto( pDtEmissao : TDateTime; pDias, pComboIndex : Integer ):TDateTime;

(*  function LastDayOfMonth( pData : TDateTime ):String;
  var
    NewDate : String;
  Begin

    NewDate := DateToStr( 32 +  StrToDate( '01'+Copy( DateToStr( pData ), 3, 8 ) ) );
    Result  := Copy( DateToStr( StrToDate( '01'+Copy( NewDate , 3, 8 ) ) - 1 ), 1, 2 );

  end;*)

Begin
   Result := Date; // Apenas para não gerar WARNING.
   Case pComboIndex of  // Dias da data
   0 : Result := pDtEmissao + pDias ;
   1 : Result := pDtEmissao + pDias + 1 ;
   2 : Result := pDtEmissao + ( 7 - DayOfWeek ( pDtEmissao ) ) + pDias ;
   3 : Begin
        Dia := StrToInt( Copy( DateToStr( pDtEmissao ), 1, 2 ) );  // Peguei só o dia p/ saber em qual DEZENA ele faz parte
        if Dia < 11 then       // 1ª dezena
           Result := pDias + StrToDate( '10' + Copy( DateToStr( pDtEmissao ), 3, 8 ) )
        else if Dia < 21 then  // 2ª dezena
           Result := pDias + StrToDate( '20' + Copy( DateToStr( pDtEmissao ), 3, 8 ) )
        else
           Result := pDias + StrToDate( LastDayOfMonthStr( pDtEmissao ) + Copy( DateToStr( pDtEmissao ), 3, 8 ) ) ;
       end;
   4 : Begin
        if Copy( DateToStr( pDtEmissao ) , 1, 2 ) < '16' then       // 1ª quinzena
          Result := StrToDate( '15' + Copy( DateToStr( pDtEmissao ), 3, 8  ) ) + pDias
        else                                                        // 2ª quinzena
          Result := StrToDate( LastDayOfMonthStr( pDtEmissao ) + Copy( DateToStr( pDtEmissao ), 3, 8 ) ) + pDias ;
       end;
   5 : Result := StrToDate( LastDayOfMonthStr( pDtEmissao ) + Copy( DateToStr( pDtEmissao ), 3, 8 ) )+pDias;
   end;
end;

Function DiaUtil( Data : TDateTime; pEmpresa : Integer = 0; pFilial : Integer = 0 ) : Boolean;
var qry: TQuery;
Begin

  qry               := TQuery.Create( Application );
  qry.DataBaseName  := cDatabaseName;

  // Verifica se a data informada é dia útil
  If (DayOfWeek(Data) = 1) Or (DayOfWeek(Data) = 7) Then // Domingo ou Sábado
  Begin
    Result := False;
    Exit;
  end;

  with qry do
  Begin
    // Se informou empresa ou filial, fazer a consulta na tabela FINFERIA_EMPRESAFILIAL
    If pEmpresa + pFilial > 0 Then
    Begin
      SQL.Add( 'SELECT DATAFERIADO FROM FINFERIA_EMPRESAFILIAL WHERE DATAFERIADO = :P0 AND CODIGOFL = :P1 AND CODIGOEMPRESA = :P2' );
      Params[0].AsDateTime := Data;
      Params[1].AsInteger  := pFilial;
      Params[2].AsInteger  := pEmpresa;
      Open;
      Result := IsEmpty;
    End
    Else
      // Faz a pesquisa da forma antiga, na tabela FINFERIA
      Begin
        SQL.Add( 'SELECT DATAFERIADO FROM FINFERIA WHERE DATAFERIADO = :P0' );
        Params[0].AsDateTime := Data;
        Open;
        Result := IsEmpty;
      End;
    Free;
  End;


End;

function TrazSiglaTipoVencto(Sender: TCombobox): string;
var i : integer;
begin
  If TComboBox(Sender).Text = '' then
  begin
    TrazSiglaTipoVencto := '';
    Exit;
  end;
  For i := 0 to 5 do if TComboBox(Sender).Text = vTpVenctoStr[i] then TrazSiglaTipoVencto := vTipoVencto[i];
end;

function TrazNomeTipoVencto(vSigla:string): string;
var i : integer;
begin
  If vSigla = '' then
  begin
    TrazNomeTipoVencto := '';
    Exit;
  end;
  For i := 0 to 5 do if vSigla = vTipoVencto[i] then TrazNomeTipoVencto := vTpVenctoStr[i];
end;

function CPGValidaExercicio( pData : TDateTime; pEmpresa , pFilial : Integer; pMgs : Boolean = True; pSistema : String = '' ):Boolean;
var vExerc : String;
Begin
  { pSistema => deixar vazio, Será utilizado apenas para a contabilidade }
  
  With qrPesqAux do
  begin
    Close;
    unprepare;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBEXERC'     );
    SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'        );
    params[0].AsInteger := pEmpresa;
    Params[1].AsInteger := pFilial;
    prepare;
    Open;
    If RecordCount = 0 Then
    Begin
      If pMgs then
      mensagemDLG( 'Nenhum exercício fiscal cadastrado para a empresa ' + StrZero(pEmpresa,3) + ', filial ' + StrZero(pFilial,3) + '.', mtInformacao, mbOk );
//      mensagemDLG( 'Nenhum exercício contábil cadastrado para esta filial.', mtInformacao, mbOk );
      Result := False;
      exit;
    End;
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBEXERC'     );
    SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'        );
    SQL.Add( ' AND SITUACAO_EX = ''A'''   );
    params[0].AsInteger := pEmpresa;
    Params[1].AsInteger := pFilial;
    Open;
    If RecordCount = 0 then
    begin
      If pMgs then
      mensagemDLG( 'Nenhum exercício fiscal em aberto para a empresa ' + StrZero(pEmpresa,3) + ', filial ' + StrZero(pFilial,3) + '.', mtInformacao, mbOk );
//      mensagemDLG( 'Nenhum exercício contábil em aberto para esta filial.', mtInformacao, mbok );
      Result := False;
      exit;
    end;

    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBEXERC'     );
    SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'        );
    SQL.Add( ' AND SITUACAO_EX = ''A'''   );
    SQL.Add( ' AND DATA_INI_EX <= :P2'    );
    SQL.Add( ' AND :P2 <= DATA_FIN_EX'    );
    params[0].AsInteger  := pEmpresa;
    Params[1].AsInteger  := pFilial;
    Params[2].AsDateTime := pData;
    Open;
    If RecordCount = 0 then
    begin
      If pMgs then
      mensagemDLG( 'Exercício fiscal inexistente ou fechado.', mtinformacao, mbok );
      Result := False;
      exit;
    end;
    vExerc   := FieldByName( 'NOME_EX' ).AsString;
  end; // with qrCTBExerc
  { Verifica se a data está em mês contábil válido }
  With qrPesqAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBMESCT'     );
    SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'        );
    Params[0].AsInteger := pEmpresa;
    Params[1].AsInteger := pFilial;
    Open;
    If RecordCount = 0 Then
    begin
      If pMgs then
      mensagemDLG( 'Nenhum mês contábil cadastrado para a empresa ' + StrZero(pEmpresa,3) + ', filial ' + StrZero(pFilial,3) + '.', mtInformacao, mbOk );
//      mensagemDLG( 'Nenhum mês contábil cadastrado para esta filial.', mtinformacao, mbOK );
      Result := False;
      exit;
    end;
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBMESCT'     );
    SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'        );
    SQL.Add( ' AND NOME_EX = :P2'         );
    Params[0].AsInteger := pEmpresa;
    Params[1].AsInteger := pFilial;
    Params[2].AsString  := vExerc;
    Open;
    If RecordCount = 0 Then
    begin
      If pMgs then
      mensagemDLG( 'Nenhum mês contábil cadastrado para este exercício.', mtInformacao, mbOK );
      Result := False;
      exit;
    end;
    If pSistema = '' then
    begin
      Close;
      SQL.Clear;
      SQL.Add( 'SELECT * FROM CTBMESCT'     );
      SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
      SQL.Add( ' AND CODIGOFL = :P1'        );
      SQL.Add( ' AND NOME_EX = :P2'         );
      SQL.Add( ' AND SITUACAO_MC = ''A'''   );
      Params[0].AsInteger := pEmpresa;
      Params[1].AsInteger := pFilial;
      Params[2].AsString  := vExerc;
      Open;
      If RecordCount = 0 then
      begin
        If pMgs and (Pos(',' + frmMenuPrincipal.ContSenhaBgm.Usuario + ',',',' + FieldByName('UsuAltMesFechado').AsString + ',') = 0) Then
        begin
          mensagemDLG( 'Nenhum mês contábil aberto para este exercício.', mtInformacao, mbOK );
          Result := False;
          exit;
        end;
      end;
    end;
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBMESCT'     );
    SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'        );
    SQL.Add( ' AND NOME_EX = :P2'         );
    SQL.Add( ' AND DATA_INICIO_MC <= :P3' );
    SQL.Add( ' AND DATA_FIN_MC >= :P3'    );
    Params[0].AsInteger  := pEmpresa;
    Params[1].AsInteger  := pFilial;
    Params[2].AsString   := vExerc;
    Params[3].AsDateTime := pData;
    Open;
    If RecordCount = 0 then
    begin
      If pMgs then
      mensagemDLG( 'Não existe mês contábil para esta data (' + DateToStr(pData) + ').', mtinformacao, mbOK );
      Result := False;
      exit;
    end;
    If (FieldByName( 'SITUACAO_MC' ).AsString = 'F') and
       (Pos(',' + frmMenuPrincipal.ContSenhaBgm.Usuario + ',',',' + FieldByName('UsuAltMesFechado').AsString + ',') = 0) Then
    Begin
      If pMgs then
      mensagemDLG( 'Mês contábil fechado.', mtInformacao, mbOk );
      Result := False;
      exit;
    End;
  end; //with qrCTBMesCt
  Result := True;
end;

Function ValidaEmail( email : string ) : Boolean;
{Var
  cont, i : integer;}
Begin
  Result := (Pos(' ', eMail) = 0) And (Pos('@',eMail) > 0);
{  If Pos
  Cont := 0;
  For I := 1 To Length(email) Do
  begin
    If email[I] = ' ' Then // Não pode conter espaço no meio do endereço.
    begin
      result := false;
      Exit;
    end;
    If email[I] = '@' then
      inc(cont);
  end;
  If Cont = 0 then
  begin
    result := false;
    Exit;
  end;
  result := true;}
End;

function IIf ( pCondicao : Boolean; pResultTrue, pResultFalse : Variant) : Variant;
Begin
  If pCondicao Then
    Result := pResultTrue
  else
    Result := pResultFalse;
End;

procedure BarraDeProgresso(pNivel, pPosAtual, pTotal: Integer; pMens: String = 'Aguarde ...'; pAlinhamento: String = 'C');
var
  Y,X: Real;
  I,Z,T,L,W,H: Integer;
begin
  // Nivel 0 - Limpa o panel e garda o texto na variavel vTextoPanel
  //       1 - Executa o progresso da barra
  //       2 - Preenche o panel como finalizado
  //       3 - Redesenha o Status Bar
  Application.ProcessMessages;
  case pNivel of
    0:  begin
          with FrmMenuPrincipal.BarraDeEstatus do
          begin
            Screen.Cursor  := crHourGlass;
            vTextoPanel1   := Panels[1].Text;
            vTextoPanel2   := Panels[2].Text;
            Panels[1].Text := '';
            Panels[2].Text := '';
            if pAlinhamento = 'D' then Panels[1].Alignment := taRightJustify;
            if pAlinhamento = 'C' then Panels[1].Alignment := taCenter;
            if pAlinhamento = 'E' then Panels[1].Alignment := taLeftJustify;
            Repaint;
          end;
        end;
    1:  begin
           If pTotal = 0 Then
           Begin
             ShowMessage('BarraDeProgresso: Parâmetro TOTAL = 0. Assumido = 1.');
             pTotal := 1;
           End;
           with FrmMenuPrincipal.BarraDeEstatus do
           begin
             Panels[1].Text := '';
             T := Canvas.ClipRect.Top+4;
             H := Height-3;
             L := Panels[0].Width+Panels[1].Width+4;
             W := Panels[2].Width-8;
             X := W/pTotal;
             Y := pPosAtual * X;
             // Exibe o texto várias vezes
             Canvas.Brush.Color := Color;
             Canvas.TextOut(Panels[0].Width+6,T+1,pMens);
             //Canvas.MoveTo(Panels[0].Width+Panels[1].Width,T);
             //Canvas.LineTo(Panels[0].Width+Panels[1].Width,H);
             // Exibe a progress-bar
             if Trunc(Y) > W then Z := Trunc(Y) else Z := 1;
             For I := Z to Trunc(Y) do
             begin
               Canvas.Pen.Color := clNavy;
               Canvas.MoveTo(L+I,T);
               Canvas.LineTo(L+I,H);
             end;
           end
        end;
    2:  begin
           with FrmMenuPrincipal.BarraDeEstatus do
            begin
              T := Canvas.ClipRect.Top+4;
              H := Height-3;
              L := Panels[0].Width+Panels[1].Width+4;
              W := Panels[2].Width-8;
              For I := 0 to W do
                begin
                  Canvas.Pen.Color := clNavy;
                  Canvas.MoveTo(L+I,T);
                  Canvas.LineTo(L+I,H);
                end;
            end
        end;
    3:  begin
          Screen.Cursor := crArrow;
          FrmMenuPrincipal.BarraDeEstatus.Panels[1].Text      := vTextoPanel1;
          FrmMenuPrincipal.BarraDeEstatus.Panels[1].Alignment := taCenter;
          FrmMenuPrincipal.BarraDeEstatus.Panels[2].Text      := vTextoPanel2;
          FrmMenuPrincipal.BarraDeEstatus.Repaint;
        end;
  end;
end;

Function CTBProximoDocumentoNoDia(Emp ,Fil : Integer ; Data : TDateTime; Bloqueia : Boolean; pCodLanca : Integer = 0) : String;
Var
  vDocto, vmaior : Integer;
Begin
  with qrPesqAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBLANCA' );
    SQL.Add( 'WHERE CODIGOEMPRESA = :P0 AND' );
    SQL.Add( '      CODIGOFL      = :P1 AND' );
    SQL.Add( '      DTLANCA       = :P2' );
    If pCodLanca <> 0 Then
      SQL.Add( ' AND CODLANCA <> :P3 ' );
    Params[0].AsInteger  := Emp;
    Params[1].AsInteger  := Fil;
    Params[2].AsDateTime := Data;
    If pCodLanca <> 0 Then
      Params[3].AsInteger := pCodLanca;
    Open;
    vDocto := 0;
    If RecordCount <> 0 then
    Begin
      While Not EOF Do
      Begin
        Try
          vMaior := StrToInt(FieldByName('DocumentoLanca').AsString);
          If vMaior > vDocto then vDocto := vMaior;
          Next;
        Except
          Next;
        End;
      End; // While
    End;
    Result := StrZero(vDocto + 1,10,0);
  end;
End;

Function TrataHistorico_teste( pCodHist, pPlano, pEmpresa, pFilial : Integer; pTpHist : String; pTpDesp : String = ''; pTpRec : String = '' ):String;
var Str : String;
Begin
  Str := '';
  If pTpHist = 'CTB' then
  begin
    If (Trim(pTpDesp) <> '') or (Trim(pTpRec) <> '') then
    begin
      With dmCPG.qrCoringa do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( 'SELECT DESCRICAO DESCHISTO FROM CTBHIST_DESP_REC' );
        SQL.Add( ' WHERE CODHISTO = :P0'  );
        SQL.Add( ' AND NROPLANO = :P1'    );
        If Trim(pTpDesp) <> '' then
          SQL.Add( ' AND CODTPDESPESA = :P2'    );
        If Trim(pTpRec) <> '' then
          SQL.Add( ' AND CODTPRECEITA = :P2'    );
        params[0].AsInteger := pCodHist;
        params[1].AsInteger := pPlano;
        If Trim(pTpDesp) <> '' then
          params[2].AsString := pTpDesp;
        If Trim(pTpRec) <> '' then
          params[2].AsString := pTpRec;
        Open;
        Str := FieldByName('DESCHISTO').AsString;
      end;
    end;
    If Str = '' then
    begin
      With dmCPG.qrCoringa do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( 'SELECT DESCHISTO FROM CTBHISTO' );
        SQL.Add( ' WHERE CODHISTO = :P0'  );
        SQL.Add( ' AND NROPLANO = :P1'    );
        params[0].AsInteger := pCodHist;
        params[1].AsInteger := pPlano;
        Open;
    ////////////////////////////////////////////////////////////////////////////////////////////
    //
    //     Somente para a REUNIDAS...
    //     Quando Razão social e favorecido estiverem preenchidos, para contabilização
    //     do tipo baixa, cancelo a Razão social, para não duplicar na descrição do histórico.
    //
    ////////////////////////////////////////////////////////////////////////////////////////////

        If ( dmCPG.v_CodigoEmpresa = 1 ) and ( pCodHist = 916 ) then // Reunidas & TpContabiliza = BAIXA
        Begin
          If Trim( dmCPG.v_OD ) <> '' then
          Begin
            frmMenuPrincipal.v_RS := '' ;
            dmCPG.v_FAV           := '' ;
          end
          else
          If ( Trim( frmMenuPrincipal.v_RS ) <> '' ) and ( Trim( dmCPG.v_FAV ) <> '' ) then
             frmMenuPrincipal.v_RS := '';
        end;
      end;
    end;
  end
  else
  With dmCPG.qrCoringa do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT DESCHISTOBCO DESCHISTO FROM BCOHISTO'    );
    SQL.Add( ' WHERE CODHISTOBCO = :P0'  );
    SQL.Add( ' AND CODIGOFL = :P1'       );
    SQL.Add( ' AND CODIGOEMPRESA = :P2'  );
    params[0].AsInteger := pCodHist;
    params[1].AsInteger := pFilial;
    params[2].AsInteger := pEmpresa;
    Open;
  end;
  {
    Cuidado com a ordem das substituições, pois o %D está contido em %DTD. Esta rotina
    sempre deverá substituir o " %XX " pela variável e não por outro " %XX ".
    *************      Erik Mazzei      ***************
  }

  Str := StringReplace( dmCPG.qrCoringa. FieldByName( 'DESCHISTO' ).AsString , '%CF' , frmMenuPrincipal.v_CF  , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%TXT' , frmMenuPrincipal.v_TXT  , [rfReplaceAll, rfIgnoreCase] ); { para o DVS }
  Str := StringReplace( Str                                 , '%TD'  , frmMenuPrincipal.v_TD  , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%NFF' , frmMenuPrincipal.v_NFF , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%DTD' , dmCPG.v_DTD            , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%DTS' , FormatDateTime('dd/mm/yyyy', date), [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%DV'  , dmCPG.v_DV             , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%PE'  , dmCPG.v_PE             , [rfReplaceAll, rfIgnoreCase] ); // PAGAMENTO ELETRONICO
  Str := StringReplace( Str                                 , '%CQ'  , frmMenuPrincipal.v_CQ  , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%BO'  , frmMenuPrincipal.v_BO  , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%RS'  , frmMenuPrincipal.v_RS  , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%OID' , dmCPG.v_OID            , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%OD'  , dmCPG.v_OD             , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%FAV' , dmCPG.v_FAV            , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%HCQ' , dmCPG.v_HCQ            , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%N_OP', frmMenuPrincipal.v_N_OP, [rfReplaceAll, rfIgnoreCase] ); { descomentei esta linha. Varônica 03/01/05 }

  // -----------------------------------------------------------------------
  // INTEGRAÇÃO FOLHA - CTB
  // -----------------------------------------------------------------------
  // COMPETENCIA DA FOLHA EM MM/YYYY
  Str := StringReplace( Str                                 , '%CPDMA',dmCPG.v_CPDMA         , [rfReplaceAll, rfIgnoreCase] );
  // COMPETENCIA DA FOLHA EM DD/MM/YYYY
  Str := StringReplace( Str                                 , '%CPMA', dmCPG.v_CPMA          , [rfReplaceAll, rfIgnoreCase] );
  // TIPO DA FOLHA (ADIANTAMENTO, FOLHA, 13º...)
  Str := StringReplace( Str                                 , '%TP',   dmCPG.v_TP            , [rfReplaceAll, rfIgnoreCase] );
  // CODIGO DO AGRUPAMENTO DE EVENTOS
  Str := StringReplace( Str                                 , '%CAE',  dmCPG.v_CAE           , [rfReplaceAll, rfIgnoreCase] );
  // DESCRICAO DO AGRUPAMENTO DE EVENTOS
  Str := StringReplace( Str                                 , '%DAR',  dmCPG.v_DAE           , [rfReplaceAll, rfIgnoreCase] );
  // CODIGO DA CONTA
  Str := StringReplace( Str                                 , '%CCT',  dmCPG.v_CCT           , [rfReplaceAll, rfIgnoreCase] );
  // DESCRICAO DA CONTA
  Str := StringReplace( Str                                 , '%DCT',  dmCPG.v_DCT           , [rfReplaceAll, rfIgnoreCase] );
  // CODIGO DO AGRUPAMENTO CONTABIL
  Str := StringReplace( Str                                 , '%CACT', dmCPG.v_CACT          , [rfReplaceAll, rfIgnoreCase] );
  // DESCRICAO DO AGRUPAMENTO CONTABIL
  Str := StringReplace( Str                                 , '%DACT', dmCPG.v_DACT          , [rfReplaceAll, rfIgnoreCase] );
 // DESCRICAO CENTRO DE CUSTO CONTABIL
  Str := StringReplace( Str                                 , '%DCCC', dmCPG.v_DCCC          , [rfReplaceAll, rfIgnoreCase] );
  // -----------------------------------------------------------------------

  { Serie do CPG }
  Str := StringReplace( Str                                 , '%DCC', dmCTB.v_DCC            , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%SD'  , dmCPG.v_SD   , [rfReplaceAll, rfIgnoreCase] );

  Str := StringReplace( Str                                 , '%D'  , frmMenuPrincipal.v_D   , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str                                 , '%P'  , frmMenuPrincipal.v_P   , [rfReplaceAll, rfIgnoreCase] );

  Result := Str;

//  If pTpHist = 'BCO' then
//    Result := Copy(Str,1,100)
//  else
//    Result := Copy(Str,1,255);   {SIMs 8502 e 8503 - Aguardando maiores definições}

end;


Function PesquisaECadastraHist( pEmpresa, pFilial, pCodHisto : Integer; pPlano, pTpHisto, pTextoPadrao : String; pDC : String = '' ):Boolean;
var  qrAuxiliar, qrAuxiliar2  : TQuery;
Begin
  qrAuxiliar               := TQuery.Create( Application );
  qrAuxiliar.DataBaseName  := cDatabaseName;
  qrAuxiliar2              := TQuery.Create( Application );
  qrAuxiliar2.DataBaseName := cDatabaseName;


  If pTpHisto = 'BCO' then
  With qrAuxiliar do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM BCOHISTO'   );
    SQL.Add( ' WHERE CODHISTOBCO = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'      );
    SQL.Add( ' AND CODIGOEMPRESA = :P2' );
    params[0].AsInteger := pCodHisto;
    params[1].AsInteger := pFilial;
    params[2].AsInteger := pEmpresa;
    Open;
    If not (IsEmpty) then Result := True
    else
//    If mensagemDLG( 'Histórico bancário '+ IntToStr(pCodHisto)+' não cadastrado... Deseja cadastrar padrão ?'
//                    , mtConfirmacao, mbSIM + mbNAO ) = mrNAO then Result := False else
    Begin
      With qrAuxiliar2 do
      Begin
        Try
          Close;
          SQL.Clear;
          SQL.Add( 'INSERT INTO BCOHISTO' );
          SQL.Add( '(CODIGOEMPRESA, CODIGOFL, CODHISTOBCO, DESCHISTOBCO, COMPLEMENTOHISTOBCO, ');
          SQL.Add( 'DEBCREDHISTBCO, NROPLANO, CODCONTACTB)');
          SQL.Add( 'VALUES( :P0, :P1, :P2, :P3, :P4, :P5, :P6, :P7 )' );
          params[0].AsInteger := pEmpresa;
          params[1].AsInteger := pFilial;
          params[2].AsInteger := pCodHisto;
          params[3].AsString  := pTextoPadrao;
          params[4].AsString  := 'N';
          params[5].AsString  := pDC;
          params[6].AsString  := ''; //AsInteger := pPlano;
          params[7].AsString  := '';
          //params[7].AsInteger :=
          execSQL;
          Result := True;
        except on E:EDBEngineError do
          Begin
            If mensagemDLG( 'Problemas durante efetivação de histórico bancário padrão '+IntToStr( pCodHisto )+'... Deseja ver o erro ?'
                            , mtConfirmacao, mbSIM + mbNAO ) = mrSIM then mensagemDLG( E.Errors[1].message, mtErro, mbOK );
            Result := False;
            exit;
          end;
        end; // Try
      end; // With - qrAuxiliar2
    end; // if - mensagemDLG
  end
  else // pTpHisto = 'CTB'
  With qrAuxiliar do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBHISTO' );
    SQL.Add( ' WHERE CODHISTO = :P0'  );
    SQL.Add( ' AND NROPLANO = :P1'    );
    params[0].AsInteger := pCodHisto;
    params[1].AsInteger := StrToInt( pPlano );
    Open;
    If not (IsEmpty) then Result := True
    else
//    If mensagemDLG( 'Histórico contábil '+ IntToStr(pCodHisto)+' não cadastrado... Deseja cadastrar padrão ?'
//                    , mtConfirmacao, mbSIM + mbNAO ) = mrNAO then Result := False else
    Begin
      With qrAuxiliar2 do
      Begin
        Try
          Close;
          SQL.Clear;
          SQL.Add( 'INSERT INTO CTBHISTO'          );
          SQL.Add( '(CODHISTO, NROPLANO, DESCHISTO, INFORMA_COMPLEMENTOHISTO)');
          SQL.Add( ' VALUES( :P0, :P1, :P2, :P3 )' );
          params[0].AsInteger := pCodHisto;
          params[1].AsInteger := StrToInt( pPlano );
          params[2].AsString  := pTextoPadrao;
          params[3].AsString  := 'N';
          execSQL;
          Result := True;
          exit;
        except on E:EDBEngineError do
          Begin
            If mensagemDLG( 'Problemas durante efetivação de histórico contábil padrão... Deseja ver o erro ?'
                            , mtConfirmacao, mbSIM + mbNAO )=mrSIM then mensagemDLG( E.Errors[0].message, mtErro, mbOK );
            Result := False;
          end;
        end; // Try
      end; // With - qrAuxiliar2
    end; // If - mensagemDLG
  end; // With

  qrAuxiliar.Free;
  qrAuxiliar2.Free;

end;


Function TrataHistorico( pHistorico, pTpDocto, pDocto, pParc, pForn : String ):String;
var Str : String;
Begin

  Str := StringReplace( pHistorico, '%TD', pTpDocto     , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str       , '%D' , pDocto       , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str       , '%P' , pParc        , [rfReplaceAll, rfIgnoreCase] );
  Str := StringReplace( Str       , '%F' , pForn        , [rfReplaceAll, rfIgnoreCase] );
//  Str := StringReplace( Str       , '%RS', pRSocialForn , [rfReplaceAll, rfIgnoreCase] );

  Result := Str;

end;

Function ValidaDataLimiteDeUso(Empresa, Filial : Integer ; Sistema : String; Data : TDateTime) : Boolean;
Var
  CodIntEmpAut : Integer;
  Query1 : TQuery;
Begin
  Query1 := TQuery.Create(Application);
  Query1.DatabaseName := cDatabaseName;
  Result := True;
  with Query1 do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT CODINTEMPAUT FROM CTR_FILIAL');
    SQL.Add('WHERE CODIGOEMPRESA = :P0 AND');
    SQL.Add('      CODIGOFL      = :P1    ');
    Params[0].AsInteger := Empresa;
    Params[1].AsInteger := Filial;
    Open;
    If RecordCount = 0 then
    begin
       MensagemDlg('Filial não cadastrada.', mtErro, mbOk );
       Result := False;
       Exit;
    End;
    CodIntEmpAut := FieldByName('CodIntEmpAut').AsInteger;
    Close;
    Sql.Clear;
    Sql.Add('SELECT DATALIMITEDEUSO FROM CTR_AUTORIZACAOSISTEMAS');
    SQL.Add('WHERE CODINTEMPAUT = :PCODINTEMPAUT AND            ');
    SQL.Add('      SISTEMA      = :PSISTEMA                     ');
    ParamByName('PCODINTEMPAUT').AsInteger := CodIntEmpAut;
    ParamByName('PSISTEMA'     ).AsString  := Sistema;
    Open;
    If RecordCount = 0 then
    begin
       MensagemDlg('Sistema não autorizado para esta empresa/filial.', mtErro, mbOk );
       Result := False;
    End
    Else If Data > FieldByName('DATALIMITEDEUSO').AsDateTime Then // Período expirado
    Begin
      MensagemDlg('Data além do limite de uso. Contactar ' +
      frmMenuPrincipal.vConcedente + '.', mtErro, mbOk );
      Result := False
    End
    Else If FieldByName('DATALIMITEDEUSO').AsDateTime - Data < 7 Then // Avisa quando o período está terminando.
       MensagemDlg('Sr. usuário, por favor, contactar o departamento de apoio da ' +
       frmMenuPrincipal.vConcedente + '.', mtInformacao, mbOk );
    Close;
    Free;
  End;
End;

Function RodandoEmNT : Boolean;
Var
  OsVersionInfo: TOsVersionInfo;
begin
  Result := False; // Apenas para não gerar WARNING.
  OsVersionInfo.dwOSVersionInfoSize := SizeOf(TOsVersionInfo);
  GetVersionEx(OsVersionInfo);
  With OsVersionInfo Do
  begin
    Case dwPlatFormID Of
      VER_PLATFORM_WIN32S        : Result := False; // 'Win32s'
      VER_PLATFORM_WIN32_WINDOWS : Result := False; // 'Windows 95/98'
      VER_PLATFORM_WIN32_NT      : Result := True;  // 'Windows NT'
    end;
  end;
end;

function TrazUltimoDiaDoMesAtual(pData: String): TDateTime;
begin
  Result := (IncMonth(StrToDateTime('01/'+Copy(pData,1,2)+'/'+Copy(pData,3,4)),1)-1);
end;

function ValidaDataMovto(pEmpresa: Integer; pFilial: Integer; pDataMovto: TDateTime; pConsisteDiaAtual: Boolean): Boolean;
var
////////////////////////////////////////////////////////////////////////////////
//
//  RETORNO DA FUNCAO:
//
//  TRUE    --> É porque está tudo certo.
//  FALSE   --> Ocorreu erro, tem que barrar o usuario de continuar com o
//  movimento, tem que fazer voltar.
//
////////////////////////////////////////////////////////////////////////////////
  _QryPesquisa : TQuery;
  _vDataIni    : TDateTime;
  _vDataFim    : TDateTime;
begin
  _QryPesquisa := TQuery.Create(Application);
  _QryPesquisa.DatabaseName := cDatabaseName;

  Result := True;
  with _QryPesquisa do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT '+
                '* '+
              'FROM '+
                'CTR_CADASTRODEUSUARIOS US, '+
                'CTR_PARAMUSUARIOSISTEMA PU '+
              'WHERE '+
                'US.CODIGOGRPUSU = PU.CODIGOGRPUSU AND '+
                'PU.SISTEMA = '''+FrmMenuPrincipal.ContSenhaBgm.Sistema+''' AND '+ 
                'US.USUARIO = '''+FrmMenuPrincipal.vUserName+'''');
      Open;
      if Not IsEmpty then
        begin
          _vDataIni        := FieldByName('DTIPARUSUASIS').AsDateTime;
          _vDataFim        := FieldByName('DTFPARUSUASIS').AsDateTime;
          if (_vDataIni > pDataMovto) and (pDataMovto  < _vDataFim) then 
            begin
              MensagemDlg('A data Informada está fora do limite de uso do Usuário', mtErro,mbOk);
              Result := False;
              Exit;
            end;
        end;

      Close;
      SQL.Clear;
      SQL.Add('SELECT '+
                '* '+
              'FROM '+
                'CTR_VIGENCIAMOVTO '+
              'WHERE '+
                'CODIGOEMPRESA  = '+IntToStr(pEmpresa)+' AND '+
                'CODIGOFL       = '+IntToStr(pFilial)+' AND '+
                'SISTEMA        = '''+FrmMenuPrincipal.ContSenhaBgm.Sistema+''' AND '+
                'MESANOVIGENCIA = TO_DATE('''+DateTimeToStr(TrazUltimoDiaDoMesAtual(Copy(DateToStr(pDataMovto),4,2)+Copy(DateToStr(pDataMovto),7,4)))+''','''+'DD-MM-YYYY'+''')');
      Open;
      if IsEmpty then
        begin
          MensagemDlg('Essa data está fora da vigencia do Movimento', mtErro,mbOk);
          Result := False;
          Exit;
        end;
      Close;
    end;
  _QryPesquisa.Free;

  if not ValidaDataLimiteDeUso(pEmpresa,pFilial,FrmMenuPrincipal.ContSenhaBgm.Sistema,pDataMovto) then
    begin
      Result := False;
    end;
end;

Function ValidaNomeDoRPT( pNomedoRPT : String ):Boolean;
Begin

  vNomeDoRelatorio := RemoveExtension( pNomedoRPT );

  If RodandoEmNT then vNomeDoRelatorio := vNomeDoRelatorio + 'NT';

  vNomeDoRelatorio := vNomeDoRelatorio + '.rpt';

  If FileExists( frmMenuPrincipal.vDirRptCpg + vNomeDoRelatorio ) then Result := True
  else Result := False;

end;

Function RemoveExtension( pFileName : String ):String;
var
   i : Integer;
Begin

//////////////////////////////////////////////////////
//
//         Remove a extensão de um arquivo
//
//////////////////////////////////////////////////////

  FillChar ( ar_AuxFileName, LengTh( pFileName ), ' ' );

  For i := 1 to LengTh( pFileName ) do
  Begin
    If ( Copy( pFileName, i, 1 ) = '.' ) then Break
    else StrPCopy( @ar_AuxFileName[i-1], Copy( pFileName, i, 1 ) );
  end;

  Result := StrPas( ar_AuxFileName );

end;


Function TrazNumeroRM(pEmpresa,pFilial:integer;pNumDigitado:Double=0):Double;
var
  v_qryBuscaRM  : TQuery;
  v_NumeroIniRM : Double;
  v_Assume      : String;
  v_Pesquisa    : Boolean;
  v_NRRQ        : Real;
begin
  { Inicia as variáveis }
  v_qryBuscaRM:= TQuery.Create(Application);
  v_qryBuscaRM.DatabaseName := cDatabaseName;
  v_NumeroIniRM := 0; // Para não gerar WARNING
  { Verifica se deve assumir o código da Empresa + Filial no número da RM  }
  With v_qryBuscaRM Do
  begin
    { Pesquisa valor do parâmetro ASSUME_EMP_FIL_NUM_RQ }
    Close;
    Sql.Clear;
    Sql.Add('SELECT  '                     );
    Sql.Add('  ASSUME_EMP_FIL_NUM_RQ '     );
    Sql.Add('FROM '                        );
    Sql.Add('  EST_PARAMETRO '             );
    Sql.Add('WHERE '                       );
    Sql.Add('  CODIGOEMPRESA = :P_Empresa ');
    ParamByName('P_Empresa').asInteger:= pEmpresa;
    Open;
    v_Assume := FieldbyName('ASSUME_EMP_FIL_NUM_RQ').asString;
    Close;
  end;
  { Encontra o número inicial para a Empresa e Filial, caso deva assumir
    o código da empresa/filial }
  If v_Assume = 'S' Then
    With v_qryBuscaRM Do
    begin
      Close;
      Sql.Clear;
      Sql.Add('Select NumeroIniRM '                      );
      Sql.Add('From   EST_NUMERORQPORFILIAL '            );
      Sql.Add('Where  CodigoEmpresa=:pCodigoEmpresa And ');
      Sql.Add('       CodigoFl=:pCodigoFl '              );
      ParamByName('pCodigoEmpresa').asInteger := pEmpresa;
      ParamByName('pCodigoFl'     ).asInteger := pFilial;
      Open;
      { Caso seja vazio, é que ainda não foi definido código para a empresa/filial
        neste caso cria-se este código }
      If Not IsEmpty Then
        v_NumeroIniRM := FieldByName('NumeroIniRM').asFloat
      else
        begin
          { Encontra o próximo número }
          Close;
          Sql.Clear;
          Sql.Add('Select Nvl(Max(NumeroIniRM),0)+1 as NumeroIniRM ');
          Sql.Add('From EST_NUMERORQPORFILIAL '                     );
          Open;
          If (IsEmpty) Or (FieldByName('NumeroIniRM').asFloat=1) Then
            v_NumeroIniRM := 100
          else
            v_NumeroIniRM := FieldByName('NumeroIniRM').asFloat;
          { Grava na tabela o número encontrado }
          Close;
          Sql.Clear;
          Sql.Add('Insert Into EST_NUMERORQPORFILIAL '           );
          Sql.Add('  (CodigoEmpresa,CodigoFl,NumeroIniRM) '      );
          Sql.Add('Values '                                      );
          Sql.Add('  (:pCodigoEmpresa,:pCodigoFl,:pNumeroIniRM) ');
          ParamByName('pCodigoEmpresa').asInteger := pEmpresa;
          ParamByName('pCodigoFl'     ).asInteger := pFilial;
          ParamByName('pNumeroIniRM'  ).asFloat   := v_NumeroIniRM;
          ExecSQL;
        end;
    end; // With v_qryBuscaRM Do // If v_Assume = 'S' Then
  { Traz o número da RM }
  With v_qryBuscaRM Do
  begin
    If v_Assume = 'N' Then
      begin
        { Caso tenha sido passado o número, como não assume o código da empresa
          e filial, retorna o próprio número }
        If pNumDigitado > 0 Then
          Result := pNumDigitado
        else
          begin
            Close;
            Sql.Clear;
            Sql.Add('SELECT sqEST_REQUISICAO.NEXTVAL NRREQUISICAO FROM DUAL');
            Open;
            Result := FieldbyName('NRREQUISICAO').AsFloat;
          end;
      end
    else // If v_Assume = 'N' Then
      begin
        { Caso tenha sido informado um valor, assume este ao invés do ultimo
          encontrado }
        If pNumDigitado > 0 Then
          Result := StrToFloat( StrZero(v_NumeroIniRM,3,0) + StrZero(pNumDigitado,7,0) )
        else
          begin
            { Encontra o ultimo número para a empresa/filial }
            Close;
            Sql.Clear;
            Sql.Add('SELECT NVL(MAX(NUMERORQ),0)+1 NUMERORQ FROM EST_REQUISICAO');
            Sql.Add('WHERE CODIGOEMPRESA = :PCODIGOEMPRESA AND CODIGOFL = :PCODIGOFL');
            ParamByname('PCODIGOEMPRESA').asInteger := pEmpresa;
            ParamByname('PCODIGOFL'     ).asInteger := pFilial;
            Open;
            { Caso o número tenha o tamanho de 10 digitos, é sinal que já foi gravado
              com a opção de assumir empresa/filial, basta retornar este valor }
            If Length(FloatToStr(FieldByName('NumeroRq').asFloat)) = 10 Then
              Result := FieldByName('NumeroRq').asFloat
            else
              begin
                // corrigir tamanho do campo da tabela
                Case Length(FloatToStr(FieldByName('NumeroRq').asFloat)) Of
                  9 : Result := StrToFloat( '1'  + StrZero(FieldByName('NumeroRq').asFloat,9,0) );
                  8 : Result := StrToFloat( '10' + StrZero(FieldByName('NumeroRq').asFloat,8,0) );
                else
                // tamanho (10) Tabela atual
                  Result := StrToFloat( StrZero(v_NumeroIniRM,3,0) + StrZero(FieldByName('NumeroRq').asFloat,7,0) );
                end;
              end;

            { Verifica se existe movimento para o numero gerado EST_REQUISICAO}
            v_Pesquisa := True;
            v_NRRQ     := Result;
            While v_Pesquisa Do
            Begin
              Close;
              Sql.Clear;
              Sql.Add('SELECT NUMERORQ         ');
              Sql.Add('FROM   EST_REQUISICAO   ');
              Sql.Add('WHERE  NUMERORQ = :PNRQ ');
              ParamByname('PNRQ').asFloat := v_NRRQ;
              Open;
              If IsEmpty Then
                begin
                  v_Pesquisa := False;
                  Result     := v_NRRQ;
                end
              else
                v_NRRQ := v_NRRQ + 1;
            end;
          end; // If pNumDigitado > 0 Then
      end; // If v_Assume = 'N' Then
  end; // With v_qryBuscaRM Do
  { Fecha a query e limpa-a da memoria }
  v_qryBuscaRM.Close;
  v_qryBuscaRM.Free;
end;

function TrataValorParaCheque( pValor : String ):String;
var
   VlCheque : String;
Begin

  VlCheque := EliminaSeparadorMilhar( pValor );
  If pos( ',', VlCheque ) = 0 then Result := VlCheque+'.00'
  else
  If Length( Copy( VlCheque, pos( ',', VlCheque )+1, Length(VlCheque)  ) ) = 1 then
  Begin
    VlCheque := VlCheque+'0';
    Result   := StringReplace( VlCheque, ',', '.', [rfReplaceAll, rfIgnoreCase] );
  end
  else Result   := StringReplace( VlCheque, ',', '.', [rfReplaceAll, rfIgnoreCase] );

end;

// ################################################################################
// ##                                                                            ##
// ##                    Pode ser usado por qualquer sistema                     ##
// ##                                                                            ##
// ##  Controla os menus do form, de acordo com o menu principal. Se o usuário   ##
// ##  tem no menu principal, terá no menu do form também.                       ##
// ##                                                                            ##
// ################################################################################
Procedure DesabilitaMenusDoForm(Sender: TObject);
Var
  M, I, S : Integer;
  MTDesabilitaMenuDoForms : TMemoryTable;
begin

  // Apenas quando existe menu no form
  If TForm(Sender).Menu = Nil Then Exit;

  // criando a MemoryTable
  MTDesabilitaMenuDoForms := TMemoryTable.Create(nil);

   With MTDesabilitaMenuDoForms do
   begin
     With FieldDefs do
     begin
       Add( 'NAME'    , ftString , 50, True );
       Add( 'VISIVEL' , ftBoolean,  0, True );
     end;
   end;

  // Ativando o tabela auxiliar( Memory Table )
  MTDesabilitaMenuDoForms.Open;
  // Limpando tabela auxiliar
  MTDesabilitaMenuDoForms.EmptyTable;

  With MTDesabilitaMenuDoForms Do
  Begin
    { Processa o primeiro nível de menu }
    For M := 0 to frmMenuPrincipal.MainMenu1.Items.Count - 1 do
    Begin
      If frmMenuPrincipal.MainMenu1.Items[M].Visible Then // Só os itens visíveis
      Begin
        Append;
        Fieldbyname( 'NAME'    ).AsString  := frmMenuPrincipal.MainMenu1.Items[M].Name;
        Fieldbyname( 'VISIVEL' ).AsBoolean := True; //frmMenuPrincipal.MainMenu1.Items[M].Visible;
        Post;
        { Processa o segundo nível de menu }
        For I := 0 To frmMenuPrincipal.MainMenu1.Items[M].Count -1 Do
        Begin
          If frmMenuPrincipal.MainMenu1.Items[M].Items[i].Visible Then // Só os itens visíveis
          Begin
            Append;
            FieldByName( 'NAME'    ).AsString  := frmMenuPrincipal.MainMenu1.Items[M].Items[I].Name;
            FieldByName( 'VISIVEL' ).AsBoolean := True; //frmMenuPrincipal.MainMenu1.Items[M].Items[i].Visible;
            Post;
            { Processa o terceiro nível de menu }
            For S := 0 To frmMenuPrincipal.MainMenu1.Items[M].Items[I].Count - 1 Do
            Begin
              If frmMenuPrincipal.MainMenu1.Items[M].Items[I].Items[S].Visible Then // Só os itens visíveis
              Begin
                Append;
                FieldByName( 'NAME'    ).AsString  := frmMenuPrincipal.MainMenu1.Items[M].Items[I].Items[S].Name;
                FieldByName( 'VISIVEL' ).AsBoolean := True; //frmMenuPrincipal.MainMenu1.Items[M].Items[I].Items[S].Visible;
                Post;
              End; // If
            End; // For S
          End; // If
        End; // For I
      End; // If
    End; // For M
    { Desabilita todos os menus do form e habilita apenas os que existem na memory }
    { Não suprime os atalhos para configuração de impressão, saída e que tenham tag = 1 }
    For M := 0 To TForm(Sender).Menu.Items.Count - 1 Do
    Begin
      If (Tiraecomercial(UpperCase(TForm(Sender).Menu.Items[M].Caption)) <> UpperCase('Abrir Configuração de impressão')) and
         (Tiraecomercial(UpperCase(TForm(Sender).Menu.Items[M].Caption)) <> UpperCase('Abrir Setup de impressão')) and
         (Tiraecomercial(UpperCase(TForm(Sender).Menu.Items[M].Caption)) <> UpperCase('Saída')) and
         (TForm(Sender).Menu.Items.Count <> 1) and
         (TForm(Sender).Menu.Items[M].Tag <> 1) then
      begin
        TForm(Sender).Menu.Items[M].Visible := False;
        For I := 0 To TForm(Sender).Menu.Items[M].Count - 1 Do
        Begin
          If TForm(Sender).Menu.Items[M].Items[I].Tag <> 1 Then
            TForm(Sender).Menu.Items[M].Items[I].Visible := False;
          For S := 0 To TForm(Sender).Menu.Items[M].Items[I].Count - 1 Do
            If TForm(Sender).Menu.Items[M].Items[I].Items[S].Tag <> 1 Then
              TForm(Sender).Menu.Items[M].Items[I].Items[S].Visible := False;
        End; // For I
      end;
    End; // For M
    First; // Início da memory
    While Not Eof Do
    Begin
      For M := 0 To TForm(Sender).Menu.Items.Count - 1 Do
      Begin
        If UpperCase(FieldByName('NAME').AsString) = UpperCase(TForm(Sender).Menu.Items[M].Name) Then
          TForm(sender).Menu.Items[M].Visible := FieldByName('Visivel').AsBoolean;
        For I := 0 To TForm(Sender).Menu.Items[M].Count - 1 Do
        Begin
          If UpperCase(FieldByName('NAME').AsString) = UpperCase(TForm(Sender).Menu.Items[M].Items[I].Name) Then
          begin
            TForm(Sender).Menu.Items[M].Items[I].Visible := FieldByName('Visivel').AsBoolean;
            If FieldByName('Visivel').AsBoolean then
              TForm(sender).Menu.Items[M].Visible := True;
          end;
          For S := 0 To TForm(Sender).Menu.Items[M].Items[I].Count - 1 Do
          begin
            If UpperCase(FieldByName('NAME').AsString) = UpperCase(TForm(Sender).Menu.Items[M].Items[I].Items[S].Name) Then
            begin
              TForm(sender).Menu.Items[M].Items[I].Items[S].Visible := FieldByName('Visivel').AsBoolean;
              If FieldByName('Visivel').AsBoolean then
              begin
                TForm(sender).Menu.Items[M].Items[I].Visible := True;
                TForm(sender).Menu.Items[M].Visible := True;
              end;// If FieldByName('Visivel').AsBoolean then
            end; // If UpperCase(FieldByName('NAME').AsString) =
          end; // For S
        End; // For I
      End; // For M
      Next;
    End;// While Not Eof Do
    Free; // Silvio - 30/9
  End; //With MTDesabilitaMenuDoForms Do
End; // DesabilitaMenusDoForm


function tiraecomercial(vstring : string) : string;
var Ponto : integer;
begin
  vSai := false;
  { Tira o & ( e comercial ) do caption do Menu }
  While ( not vSai ) do
  begin
    Ponto := Pos('&',vstring);
    If ( ponto < Length( vstring ) ) then
    begin
      result := Trim( copy( vstring ,1, Pos( '&', vstring ) - 1 ) +  Copy( vstring, Pos( '&', vstring ) + 1, Length( vstring ) - Pos( '&', vstring )));
      vsai   := true;
    end
    else
    begin
      result := Trim(vstring);
      vSai   := True;
    end;
  end;

end;

Function FindFile( InitDir : String ; FileName : String ) : String ;
Var
  sStr        : String;
  s           : Array[0..200]of Char;
  Path        : Array[0..200]of Char;
  Name        : Array[0..200]of Char;
  v_SearchRec : TSearchRec ;
  Done        : Integer;

Begin

  path[0] := #0 ;
  s[0]    := #0 ;
  name[0] := #0 ;

  If ( InitDir[Length(InitDir)] <> '\' ) Then
     InitDir := InitDir + '\' ;

  StrPCopy( Path , InitDir  );
  StrCopy ( s    , Path     );
  StrPCopy( Name , FileName ) ;
  StrCat  ( s    , Name     );

  if ( FindFirst( s, faAnyFile, v_SearchRec ) = 0 ) then // Encontrou o arquivo...
  Begin
     sStr := LowerCase(s) ;
     Result := Copy( ExpandUNCFileName( FileName ), 1, 2 ) +Copy( sStr, 1, Pos( LowerCase( FileName ), sStr ) -1 ) ;
     Exit;
  End ;

  StrCopy( s, Path  );
  StrCat ( s, '*.*' );
  Done := FindFirst( s, faDirectory, v_SearchRec );
  While ( Done = 0 ) do
  Begin
    if ( ( v_SearchRec.Attr = faDirectory ) AND ( v_SearchRec.name <> '.' ) AND ( v_SearchRec.name <> '..' ) ) then
    Begin
      StrCopy ( s, Path );
      StrPCopy( Name, v_SearchRec.Name );
      StrCat  ( s, Name );
      StrCat  ( s, '\'  );
      sStr := StrPas( s );
      Result := FindFile( sStr, FileName ) ;
      if ( Result <> '' ) then
        Exit;
    End; {if ((pffblk.attr = fa_directory) AND strcomp(pffblk.name, '.') AND...}
    done := FindNext( v_SearchRec );
  End; {while (done <> 0)}

  Result := '' ;

End;

function FormataCampo(pCampo: String; pTam: Integer; pComZero: Boolean; pDireita: Boolean): String;
var
  vExisteString: Boolean;
  vFF          : String;
  i            : Integer;
begin
  // Esta funcao tem por finalidade formatar um string
  // Com zeros ou sem zeros depende se for so numero formata com zeros caso temnha
  // alguma letra na string utiliza o restante dos parametros
  //
  // Ex:  100  -> 00000100 -> FormataCampo('100',8,False,False)
  //      F    -> F0000000 -> FormataCampo('100',8,True,True)
  //      F    -> 0000000F -> FormataCampo('100',8,True,False)
  //      F    -> F        -> FormataCampo('100',8,False,False)
  //
  vExisteString := False;
  vFF           := Trim(pCampo);
  For i := 1 to Length(vFF) do 
    begin
      if (vFF[i] <> '0') and (vFF[i] <> '1') and (vFF[i] <> '2') and (vFF[i] <> '3') and 
         (vFF[i] <> '4') and (vFF[i] <> '5') and (vFF[i] <> '6') and (vFF[i] <> '7') and 
         (vFF[i] <> '8') and (vFF[i] <> '9') then
        begin
          vExisteString := True;
          Break;
        end;
    end;
  if vExisteString then
    begin
      if pComZero then
        begin
          if pDireita then
            Result := vFF+Replicate('0',pTam-Length(vFF))
          else
            Result := Replicate('0',pTam-Length(vFF))+vFF;
        end
      else
        Result := vFF;
    end
  else
    Result := StrZero(StrToInt(vFF),pTam,0);
end;

Function TrazFuncionario(var pCodigo:String):Integer;
var
  Query1, v_qryTrazFunc :TQuery ;
  vChapa        :Boolean;
  vEmp,vFilial,
  vCodint       :String ;
begin
  {Cria Query}
  v_qryTrazFunc:=TQuery.Create(Application);
  v_qryTrazFunc.DatabaseName := cDatabaseName;
  Query1 := TQuery.Create(Application);
  Query1.DatabaseName := cDatabaseName;

  {Caso pcodigo vazio}
  if Trim(pCodigo) = '' then
  begin
    With TFrmPesquisaFuncionarios.Create(Application) Do
    begin
      BrowseDePesquisa1.Cabecalho        := 'Empresa,Filial,Código,Chapa,CodigoIntFunc,Nome';
      BrowseDePesquisa1.Colunas          := 'CODIGOEMPRESA,CODIGOFL,CODFUNC,CHAPAFUNC,CODINTFUNC,NOMEFUNC';
      BrowseDePesquisa1.TabelaPesquisada := 'FLP_FUNCIONARIOS';
      BrowseDePesquisa1.OrdemDefaultPesquisa := 'CODFUNC';
      BrowseDePesquisa1.ColunaRetorno1     := 'CODINTFUNC';
      try
        Showmodal;
      finally
        Free;
      end;
      if FrmMenuPrincipal.vRetorno1 <> '' then
        vCodint := FrmMenuPrincipal.vRetorno1;
    end;
  end;
  {Executa função}
  With v_qryTrazFunc Do
  Begin
    {Caso pcodigo diferente de vazio}
    if trim(pcodigo) <> '' then
    begin
      Close;
      Sql.clear;
      Sql.Add('Select CodIntFunc');
      Sql.Add('From Flp_Funcionarios'     );
      Sql.Add('Where'                     );
      Sql.Add('(CodFunc = :pCodFunc or ChapaFunc = :pChapaFunc)');
      ParamByName('pCodFunc'  ).AsString := pcodigo ;
      ParamByName('pChapaFunc').AsString := pcodigo ;
      Open;
      if RecordCount > 1 then
      begin
        {Escolhe Codintfunc para selecionar Empresa e Filial}
        With TFrmPesquisaFuncionarios.Create(Application) Do
        begin
          Caption:='Pesquisa de Empresa e Filial por Funcionário';
          BrowseDePesquisa1.Cabecalho        := 'Empresa,Filial,Código,Chapa,CodigoIntFunc,Nome';
          BrowseDePesquisa1.Colunas          := 'CODIGOEMPRESA,CODIGOFL,CODFUNC,CHAPAFUNC,CODINTFUNC,NOMEFUNC';
          BrowseDePesquisa1.TabelaPesquisada := 'FLP_FUNCIONARIOS';
          BrowseDePesquisa1.OrdemDefaultPesquisa := 'CODFUNC';
          BrowseDePesquisa1.ColunaRetorno1     := 'CODINTFUNC';
          BrowseDePesquisa1.ValorCondPrincipal := 'CODFUNC='''+pcodigo+''''+'OR CHAPAFUNC='''+pcodigo+'''';
          try
            Showmodal;
          finally
            Free;
          end;
          if FrmMenuPrincipal.vRetorno1 <> '' then
            vCodint := FrmMenuPrincipal.vRetorno1;
        end;
      end
      else
      vCodint:=FieldByName('CodIntFunc').AsString;
    end;
    Close;
    Sql.clear;
    Sql.Add('Select CodigoEmpresa,CodigoFL,ChapaFunc,CodFunc,CodIntFunc,Nomefunc');
    Sql.Add('From Flp_Funcionarios'     );
    Sql.Add('Where'                     );
    Sql.Add('CodIntFunc = :pCodIntFunc ');
    ParamByName('pCodIntFunc').AsString := vCodint ;
    Open;
    If Not IsEmpty Then
    Begin
    {Pega Empresa e Filial para usar no browser pesquisa e achar parâmetro TRABCHAPAPAR}
      vEmp    :=FieldByName('CodigoEmpresa').AsString;
      vFilial :=FieldByName('CodigoFL'     ).AsString;
        {Procura valor do parâmetro se código ou chapa}
        With query1 do
        begin
          Close;
          sql.Clear;
          sql.Add('SELECT * FROM FLP_PARAMETROS');
          sql.Add('WHERE  CODIGOEMPRESA = :PCODIGOEMPRESA');
          ParamByName('PCodigoEmpresa').AsString := vEmp;
          Open;
          If FieldByName('TRABCHAPAPAR').AsString = 'S' then
            vChapa:=True
          else
            vChapa:=False;

          Close;
        end;
      {Caso retorne mais que 1 registro}
      If RecordCount > 1 Then
        Begin
          With TFrmPesquisaFuncionarios.Create(Application) Do
          begin
            Caption:='FLP - Escolha um Funcionário';
            if vChapa then
              begin
                BrowseDePesquisa1.Cabecalho        := 'Empresa,Filial,Chapa,Funcionário,CodigoIntFunc,Nome';
                BrowseDePesquisa1.ColunaRetorno1   := 'CHAPAFUNC';
                BrowseDePesquisa1.Colunas          := 'CODIGOEMPRESA,CODIGOFL,CHAPAFUNC,NOMEFUNC,CODINTFUNC,NOMEFUNC';
                BrowseDePesquisa1.TabelaPesquisada := 'FLP_FUNCIONARIOS';
                BrowseDePesquisa1.OrdemDefaultPesquisa := 'CODIGOEMPRESA';
              end
            else
              begin
                BrowseDePesquisa1.Cabecalho        := 'Empresa,Filial,Código,Funcionário,CodigoIntFunc,Nome';
                BrowseDePesquisa1.ColunaRetorno1   := 'CODFUNC';
                BrowseDePesquisa1.Colunas          := 'CODIGOEMPRESA,CODIGOFL,CODFUNC,NOMEFUNC,CODINTFUNC,NOMEFUNC';
                BrowseDePesquisa1.TabelaPesquisada := 'FLP_FUNCIONARIOS';
                BrowseDePesquisa1.OrdemDefaultPesquisa := 'CODIGOEMPRESA';
              end;
            BrowseDePesquisa1.ColunaRetorno2     := 'CodIntFunc';
            BrowseDePesquisa1.CondicaoPrincipal  := '&';
            BrowseDePesquisa1.Link               := 'CODIGOEMPRESA = '+ vEmp +' AND CODIGOFL = '+vFilial;
            try
              Showmodal;
            finally
              Free;
            end;
          end;
          if FrmMenuPrincipal.vRetorno1 <> '' then
            begin
              pCodigo := FrmMenuPrincipal.vRetorno1;
              result  := StrToInt(FrmMenuPrincipal.vRetorno2);
            end
          else
            begin
              result := 0 ;
              exit;
            end;
        End
      else {Se RecordCount = 1}
        begin
          {Verifica parâmetro se chapa ou código}
          If vChapa then
            pCodigo:=FieldByName('Chapafunc').AsString
          else
            pCodigo:=FieldByName('Codfunc' ).AsString;

          result:=FieldByName('CodIntFunc').AsInteger;
        end;

    End
    Else {Se Query vazia}
      begin
        MensagemDlg('Código de Funcionário não cadastrado !!',MtInformacao,mbOk);
        pCodigo:= '' ;
        result := 0 ;
        exit;
      end;
     Close;{Fecha v_qryTrazFunc}
  End;
  v_qryTrazFunc.Free;
end;

Function TrazNomeRelatorio(Sender:TObject): String;
Var
//  X : Integer;
  vSistema : String;
  vArquivo : String;
  {Define relatorios de Estoque}
begin

  if Length(vNomeRelatorio) = 0 then
    Begin
      Result := ' ';
      Exit;
    End;
    vSistema := '';
    vArquivo := '';

    vArquivo := vPathRels + vNomeRelatorio;

    TRadioButton(TRadioGroup(Sender).Controls[0]).Enabled := False;
    TRadioButton(TRadioGroup(Sender).Controls[1]).Enabled := False;

    If (FileExists(vArquivo + 'Mat' + '.Rpt') And Not RodandoEmNt) Or (FileExists(vArquivo + 'MatNT' + '.Rpt') And RodandoEmNt) then
       Begin
         TRadioButton(TRadioGroup(Sender).Controls[1]).Enabled := True;
       end;

    If FileExists(vArquivo + '.Rpt') then
       Begin
         TRadioButton(TRadioGroup(Sender).Controls[0]).Enabled := True;
       end;

    if (TRadioButton(TRadioGroup(Sender).Controls[1]).Enabled = False) And
       (TRadioButton(TRadioGroup(Sender).Controls[0]).Enabled = False) then
       Begin
          Result := ' ';
          Exit;
       end;

    if TRadioButton(TRadioGroup(Sender).Controls[1]).Enabled = False then
       Begin
          TRadioGroup(Sender).ItemIndex := 0;
       end;

    if TRadioButton(TRadioGroup(Sender).Controls[0]).Enabled = False then
       Begin
          TRadioGroup(Sender).ItemIndex := 1;
       end;


    If TRadioGroup(Sender).ItemIndex = 1 then
       Begin
         vSistema := 'Mat';
         if RodandoEmNT then
            vSistema := vSistema + 'NT';
         end;

     vTitulo := vNomeRelatorio + vSistema + '.Rpt';

    {Preenche campo com nome do relatório corrente}
    Result := vArquivo + vSistema + '.Rpt';

end;

Function ValidaReport: String;
Var
  a, b, PosIni : Integer;
  vAux : String;
  vAcessaBanco : Boolean;
Begin

  Result := '';
  vAcessaBanco := False;

  With frmMenuPrincipal.CrRpt Do
  Begin

    // Processa o relatório principal
    If Not Tables.Retrieve Then
    Begin
      Result := 'Falhou no retrieve do relatório principal';
      Exit;
    End;
    if Tables.Count > 0 then
    begin
      for a := 0 to (Tables.Count - 1) do
      begin
        Tables[a];
        vAux := Tables.Name;
        // Não altera o owner quando a tabela é Paradox.
        If (Pos('.DB',UpperCase(vAux)) = 0) and (Pos('.TXT',UpperCase(vAux)) = 0) then
        Begin
          PosIni := Pos('.', vAux) + 1;
          If PosIni = 0 Then PosIni := 1;
          vAux := {frmMenuPrincipal.vUserName + '.' + }Copy(vAux, PosIni, Length(vAux));
          Tables.Name := vAux;
          vAcessaBanco := True;
        End;
      end;
    End;

    // Processa os subrelatórios, se existirem
    If Not Subreports.Retrieve Then
    Begin
      Result := 'Falhou no retrieve dos Subreports';
      Exit;
    End;
    {Loop through Reports and Retrieve}
    for b := 1 to ( Subreports.Count - 1 ) do
    begin
      Subreports[b]; // Seleciona o subreport
      If Not Tables.Retrieve Then
      Begin
        Result := 'Falhou no retrieve das tabelas do Subreport';
        Exit;
      End;
      if Tables.Count > 0 then
      begin
        for a := 0 to (Tables.Count - 1) do
        begin
          Tables[a];
          vAux := Tables.Name;
          // Não altera o owner quando a tabela é Paradox.
          If (Pos('.DB',UpperCase(vAux)) = 0) and (Pos('.TXT',UpperCase(vAux)) = 0) then
          Begin
            PosIni := Pos('.', vAux) + 1;
            If PosIni = 0 Then PosIni := 1;
            vAux := {frmMenuPrincipal.vUserName + '.' + }Copy(vAux, PosIni, Length(vAux));
            Tables.Name := vAux;
            vAcessaBanco := True;
          end;
        End;
      end;
    end;
    {Set Crpe component back to main Report}
    Subreports[0];

    { Só faz conexão com banco quando existe pelo menos uma tabela Oracle }
    If vAcessaBanco Then
    Begin
      { Faz conexao com o banco de dados e testa }
      Connect.Propagate  := True; // Para os subrelatórios.
      Connect.ServerName := frmMenuPrincipal.vServerName;
      Connect.UserID     := frmMenuPrincipal.vUserName;
      Connect.Password   := frmMenuPrincipal.vUserSenha;
      If Not Connect.Test Then
      Begin
        Result := 'Não conseguiu conectar o relatório ao banco de dados';
        Exit;
      End;
    End;

  End; // With frmMenuPrincipal.CrRpt Do

End;

Function UtilizaLogotipoPadrao : Boolean;
Begin
  // 006 - Verzani
  // 021 - Faculdade Breda
  // 121 - Tribunal de Justiça de Santo Andre.
  Result := Not ( (frmMenuPrincipal.vCodigoCliente In
                  [6,21,121]) And
                  (Pos(frmMenuPrincipal.ContSenhaBgm.Sistema,
                  'ATF_BCO_CPG_CRC_CTB_CTR_ESC_ESF_FLP_FRQ_SRH') > 0 ) );
End;

function Numero_Aleatorio: Integer;
begin
  // Cria um numero aleatorio para utilizacao geral.
  // Favor NAO alterar o numero Random 2071683954
  Randomize;
  Result := Random(2071683954);
end;

/////////////////////////////////////////////////////////////////////////////
// Abaixo segue funções p/ alinhamento. Gde utilização em Rpt(s) via .TXT
/////////////////////////////////////////////////////////////////////////////

Function Pad(InputString : String; Size : Integer; Align : String = 'E' ): String;
Begin

  If Length( InputString ) >= Size Then
  Begin
    Result := Copy( InputString, 1, Size );
    Exit;
  End;

  If Align = 'E' Then
    Result := InputString + Space( Size - Length( InputString ) )
  Else
  If Align = 'D' Then
    Result := Space( Size - Length( InputString ) ) + InputString
  Else
  Begin
    Result := Space( ( Size - Length( InputString ) ) Div 2 )
              + InputString + Space( ( Size - Length( InputString ) ) Div 2 );
    Result := Pad( Result, Size );
  End;

End;

function Pict( Numero : Real; TamTotal: Byte; Decimais : Byte; SuprimeSeZero : Boolean = False ): String;
Var
  Mask, MaskAux : String;
  a, b : Integer;
Begin
  Mask := Replicate( '#', TamTotal - 2 {0,} - Decimais );
  MaskAux := '';
  b := 0;
  For a := Length( Mask ) + 1 downTo 1 Do
  Begin
    Inc( b );
    MaskAux := IIf( b mod 4 = 0, ',', '#' ) + MaskAux;
  End;
//  Mask := Copy( MaskAux, 1, Length( MaskAux ) -1 ) + '0.' + Replicate( '0', Decimais );
  Mask := Copy( MaskAux, 1, Length( MaskAux ) -1 ) + '0';
  If Decimais > 0 then
    Mask := Mask + '.' + Replicate( '0', Decimais );

  Mask   := FormatFloat( Mask, Numero );
  Result := Copy(Mask,Length(Mask)-TamTotal+1,TamTotal); //
  Result := Pad( Result, TamTotal, 'D' );

  If (Numero = 0) And SuprimeSeZero Then
    Result := Space( TamTotal );

  If (Length(Mask) > TamTotal) and (vcUsuarioManagerComSenhaUm)then
    MensagemDLG('Erro na formatação de um valor, tamanho do valor maior que o tamanho definido para formatação.', mtAtencao, mbOk);

End;

function Space( Tamanho : Integer ) : String;
Begin

  Result := Replicate( ' ', Tamanho );

End;

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

procedure ImprimeCampoMemo(pMemo:TMemo;pLabel:TLabel;pTitulo:String;pImpCabec:Boolean=True;pNomeImp:String='GLOBUSM'); // A label é para exibir em qual impressora está sendo impresso
Var
  vImpressoras : TStringList;
  vImpPadrao,
  vCont,
  vLinha
  {vAltLinha}    : Integer;
  vTemImp      : Boolean;
  Device,
  Driver,
  Port         : String;
  DevMod       : THandle;
begin
  vImpressoras := TStringList.Create;
  { Limpa a variavel e armazena as impressoras existentes }
  vImpressoras.Clear;
  vImpressoras.Assign(Printer.Printers);
  { Transforma tudo para maiusculas }
  For vCont := 0 To vImpressoras.Count-1 Do
    vImpressoras[vCont] := UpperCase(vImpressoras[vCont]);
  { Caso contenha a impressora GLOBUSM, altera esta para impressora padrão }
  vImpPadrao := Printer.PrinterIndex; // Guarda a impressora padrão
  vTemImp    := False;
  For vCont := 0 To vImpressoras.Count-1 Do
    If Pos(pNomeImp,vImpressoras[vCont]) > 0 Then // Encontra o indice da impressora escolhida no parâmetro
      begin
        vTemImp := True;
        Break;
      end;
  { Caso tenha a impressora passada como parâmetro, altera para impressora padrão }
  If vTemImp Then
    Printer.PrinterIndex := vCont;
  { Coloca uma descrição na label }
  pLabel.Caption := 'Imprimindo ... (' + Printer.Printers.Strings[Printer.PrinterIndex] + ')';
  { Captura uma porta para a impressora }
  SetLength(Device,255);
  SetLength(Driver,MAX_PATH);
  SetLength(Port  ,MAX_PATH);
  Printer.GetPrinter(PChar(Device),PChar(Driver),PChar(Port),DevMod);
  { Limpa a impressora }
  ImprimeCaracEspeciais(Device,#27 + '@' + #27 + 'x' + #0 + #27 + 'P' + #18  +
                               #27 + 'F' + #27 + 'H' + #27 + 'T' + #27 + '5' +
                               #27 + '-' + #0 + #27 + '2' + #27 + 'C' + #66  +
                               #27 + 'p' + #0 );
  { Inicializa a impressão }
  vLinha := 0;
  Printer.BeginDoc;
  { Imprime um cabecalho }
  If pImpCabec Then
  begin
    //vLinha := vLinha + Trunc( Printer.Canvas.TextHeight(Pad(pTitulo + '  Emissão: ' + DateTimeToStr(Date),Min(Printer.PageWidth,80),'C')) * 1.1 );
    Printer.Canvas.TextOut(0,vLinha,Pad(pTitulo + '  Emissão: ' + DateTimeToStr(Date),Min(Printer.PageWidth,80),'C'));
    Inc(vLinha);
    //vLinha := vLinha + Trunc( Printer.Canvas.TextHeight('--------------------------------------------------------------------------------') * 1.1 );
    Printer.Canvas.TextOut(0,vLinha,'--------------------------------------------------------------------------------');
    Inc(vLinha);
  end;
  { Inicia leitura do componete memo }
  For vCont := 0 To pMemo.Lines.Count-1 Do
  begin
    //vLinha := vLinha + Trunc( Printer.Canvas.TextHeight(pMemo.Lines[vCont]) * 1.1 ); // Verifica se ultrapassou o liminte de linhas da impressora, pula página
    Printer.Canvas.TextOut(0,vLinha,pMemo.Lines[vCont]); // Envia a linha para a impressora
    Inc(vLinha);
    If vLinha >= Printer.PageHeight Then
    begin
      Printer.NewPage;
      vLinha := 0;
    end;
  end;
  { Termina impressão }
  Printer.EndDoc;
  { Retorna a impressora default }
  Printer.PrinterIndex := vImpPadrao;
  vImpressoras.Free;
end;

procedure ImprimeCaracEspeciais(Impressora:String; S:String);
var
  Handle: THandle;
  N: DWORD;
  DocInfo: TDocInfo;
begin
  If Not OpenPrinter(PChar(Impressora),Handle,Nil) Then
    begin
      MensagemDlg('Erro ao abrir a impressora: ' + IntToStr(GetLastError),mtErro,mbOk);
      Exit;
    end;
  With DocInfo Do
  begin
    cbSize := 9999;
    lpszDocName := PChar('D');
    lpszOutput  := nil;
{    pDocName    := PChar('D');
    pOutputFile := Nil;
    pDataType   := 'RAW';  }
  end;
    StartDocPrinter(Handle,1,@DocInfo);
    StartPagePrinter(Handle);
    WritePrinter(Handle, PChar(S), Length(S), N);
    EndPagePrinter(Handle);
    EndDocPrinter(Handle);
    ClosePrinter(Handle);
end;

function DireitoAoBotoesDaTela(Usuario, Sistema, NomeItemMenu : String;  nomeCaption : String = ''; pAlteraVariaveisGlobais: Boolean = true): TDireitosDoUsuario;
var
  _QryCoringa : TQuery;
  vAdministrador , vAcessaTodasOpcoes : Boolean;
begin

(*
****************************************************************************************************************************************

     ATENÇÃO - FUNÇÃO UTILIZADO POR TODOS OS MODULOS DO GLOBUS

  Qualquer programador que fizer alteração deste fonte, DEVE ENVIAR um EMAIL avisando a TODOS OS COORDENADORES de desenvolvimento, que
  foi feita alteração, para que se seja gerado um versão para o suporte testar.

  Verônica - 22/02/2005

****************************************************************************************************************************************
*)

  // Silvio - 08/03/2005
  If vcUsuarioManagerComSenhaUm Then
  Begin
    If Trim(Usuario) = '' Then ShowMessage('Direitos aos botões -> Sem USUÁRIO');
    If Trim(Sistema) = '' Then ShowMessage('Direitos aos botões -> Sem SISTEMA');
    If Trim(NomeItemMenu) = '' Then ShowMessage('Direitos aos botões -> Sem NomeItemMenu');
  End;

  _QryCoringa              := TQuery.Create(Application);
  _QryCoringa.DatabaseName := cDatabaseName;

  vSai               := false;

  { Busca para o Usuário se o mesmo é administrador e se tem acesso a todas opções }
  With _QryCoringa do
  Begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT ADMINISTRADOR, ACESSATODASOPCOES ');
    Sql.Add('FROM CTR_CADASTRODEUSUARIOS             ');
    Sql.Add('WHERE USUARIO = :P0                     ');

    params[0].AsString := Usuario;
    Getsql(_QryCoringa);
    Open;

    vAdministrador     := FieldByName('Administrador'    ).AsString = 'S';
    vAcessaTodasOpcoes := FieldByName('AcessaTodasOpcoes').AsString = 'S';

    Close;
    Sql.Clear;
    Sql.Add('SELECT TEMDIREITOEXCLUSAOMENU, TEMDIREITOALTERACAOMENU, TEMDIREITOINCLUSAOMENU ');
    Sql.Add('FROM CTR_MENUSAOUSUARIO                                                        ');
    Sql.Add('WHERE USUARIO = :P0 AND SISTEMA = :P1                                          ');

    If ((Trim(nomeCaption) <> '') and (Trim(nomeitemmenu) <> '')) or   (Trim(nomeCaption) = '') then
    begin
      Sql.Add('AND UPPER(NOME) = UPPER(:P2)');
      Params[2].AsString := nomeitemmenu;
    end
    else
    begin
      Sql.Add('AND UPPER(CAPTION) = UPPER(:P2)');
      Params[2].AsString := tiraecomercial(nomeCaption);
    end;

    params[0].AsString := Usuario;
    Params[1].AsString := sistema;

    Getsql(_QryCoringa);
    Open;

    If Not IsEmpty then { Encontrou menu para o usuário, então passa o que ele tem de direito para as variáveis }
    Begin
      Result.TemDireitoExclusao  := FieldByName('TemDireitoExclusaoMenu' ).AsString = 'S';
      Result.TemDireitoAlteracao := FieldByName('TemDireitoAlteracaoMenu').AsString = 'S';
      Result.TemDireitoInclusao  := FieldByName('TemDireitoInclusaoMenu' ).AsString = 'S';

      If vcUsuarioManagerComSenhaUm And (Pos(Usuario, 'GLOBUS_MANAGER')=0) Then
      Begin
        Msg(IIf(Trim(NomeItemMenu) <> '','Nome do item="' + nomeitemmenu + '" ', '') +
            IIf(Trim(NomeCaption) <> '','Caption do item="' + nomeCaption + '" ', '') +
            'Direitos de I/A/E = ' + IIf(Result.TemDireitoInclusao  ,'S','N') + '/' +
                                     IIf(Result.TemDireitoAlteracao ,'S','N') + '/' +
                                     IIf(Result.TemDireitoExclusao  ,'S','N') + '.', clAqua);

      End;
    End

    Else { Não encontrou o Menu para o Usuário - Verifica se o Usuário é Globus, Manager ou Administrador e que tenha acesso a todas as opções
          para habilitar os botões }
    Begin
      If ( (vAdministrador) and (vAcessaTodasOpcoes) ) then


      If vcUsuarioManagerComSenhaUm And (Pos(Usuario, 'GLOBUS_MANAGER') = 0) Then
      Begin
        Msg('Este item de menu "' + IIF(Trim(NomeItemMenu) <> '',NomeItemMenu, nomeCaption) +
            '" está sem definição I/A/E para o usuário "' + Usuario + '". Direitos desativados.' , clRed);

      End;

      With Result do { para os usuários Administradores com acesso a todas opções, Globus ou Manager os botões devem ficar habilitados }
      begin
        TemDireitoExclusao  := ( (vAdministrador) and (vAcessaTodasOpcoes) ) or (Pos(Usuario, 'GLOBUS_MANAGER') <> 0);
        TemDireitoAlteracao := TemDireitoExclusao;
        TemDireitoInclusao  := TemDireitoExclusao;
      end;

    End;

    { Preenche as variaveis antigas }
    With Result do
    begin
      If pAlteraVariaveisGlobais then
      begin
        dm.vTemDireitoExclusao  := TemDireitoExclusao;
        dm.vTemDireitoAlteracao := TemDireitoAlteracao;
        dm.vTemDireitoInclusao  := TemDireitoInclusao;

        vcTemDireitoExclusao    := TemDireitoExclusao;
        vcTemDireitoAlteracao   := TemDireitoAlteracao;
        vcTemDireitoInclusao    := TemDireitoInclusao;
      end;
    end;
    Free; // Silvio 30/9
  end;
end;


Function CTBVerificaSeGravaSaldoNoProximoMes(p_empresa, P_filial : Integer; P_data : Tdatetime) : String;
begin
  {
    Verifica se o mês/ano da data final do exercício é igual ao mês/ano da data que foi passada
    como parâmetro, Se for diferente, ira permitir gravar o saldo anterior no próximo
    mês, Se for igual, só irá permitir gravar o saldo do mês atual.
   }
  With qrPesqAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBEXERC'     );
    SQL.Add( ' WHERE CODIGOEMPRESA = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'        );
    SQL.Add( ' AND SITUACAO_EX = ''A'''   );
    SQL.Add( ' AND DATA_INI_EX <= :P2'    );
    SQL.Add( ' AND :P2 <= DATA_FIN_EX'    );
    params[0].AsInteger  := p_Empresa;
    Params[1].AsInteger  := p_Filial;
    Params[2].AsDateTime := p_Data;
    Open;
    Result := Iif(Copy(FieldByName('DATA_FIN_EX').AsString,4,7) = Copy(DateToStr(p_Data),4,7),'N','S');
  end;

end;

function FormataValorFloat(xValor: String):Double;
begin
  Result := StrToFloat(StringReplace(Trim(xValor),'.','',[rfReplaceAll]));
end;


Function LeArqIni(vSecao, vChave : String; vArquivoIni : String = ''; vModulo : String = '' ): String;
Var
  IniFile : TIniFile;
Begin
  {$Include \Globus\sistemas\Function_LeArqIni_Corpo.txt}
end;

Procedure GravaArqIni(vSecao, vChave, vValor : String; vArquivoIni : String = ''; vModulo : String = '' );
var
  vStart: Boolean;
  vItem: Integer;
begin
  {$Include \Globus\sistemas\Procedure_GravaArqIni_Corpo.txt}
end;


(*
Function LeArqIni(vSecao, vChave : String; vArquivoIni : String = ''; vModulo : String = '' ): String;
Var
//  vStart: Boolean;
  IniFile : TIniFile;
  Qry : TQuery;
//  vData : TDateTime;
Begin
  // CRIANDO QUERYS AUXILIARES
  Qry := TQuery.Create(Application);
  Qry.DatabaseName := cDatabaseName;

  // BUSCANDO O(S) VALOR(ES) DA CHAVE ORDENADOS POR ITEM PARA
  // OS CASOS ONDE O VALOR TENHA MAIS DE 4000 CHARS
  Qry.Close;
  Qry.Sql.Clear;
  Qry.Sql.Add('Select /*+ RULE */ Valor, Data From CTR_Dados_Ini');
  Qry.Sql.Add('Where Modulo = :pModulo');
  Qry.Sql.Add('And Secao = :pSecao');
  Qry.Sql.Add('And Chave = :pChave');
  Qry.Sql.Add('Order By Item');

  If (vArquivoIni = '') and (vModulo = '') Then
    Qry.ParamByName('pModulo').AsString := Application.Title  // Nome da aplicação
  Else
    If vModulo = '' then
    // SE PASSOU O PATH, TRAZ SOMENTE O NOME OD ARQUIVO
    // SEM O PATH FUNCIONA NORMALMENTE - Riobóo
      Qry.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
    else
      Qry.ParamByName('pModulo').AsString := vModulo; { Veronica para busacr as cores definida pelo usuario em todos os mudulo }

  Qry.ParamByName('pSecao').AsString := vSecao;
  Qry.ParamByName('pchave').AsString := vChave;
  Qry.Open;

  // QDO NÃO EXISTE NO BANCO, BUSCA DO .INI
  If Qry.IsEmpty Then
  Begin
    If vArquivoIni = '' Then // Nome da aplicação.
      vArquivoIni := ExtractFilePath(Application.ExeName) + Application.Title + '.Ini'
    Else
    begin
      // PARA OS CASOS EM QUE NÃO PASSOU O PATH FORÇA O PATH DA APLICAÇÃO - Riobóo
      If Pos('\',vArquivoINI) > 0 Then
        vArquivoIni := vArquivoIni + '.Ini'
      else
        vArquivoIni := ExtractFilePath(Application.ExeName) + vArquivoIni + '.Ini';
    end;
    IniFile := TIniFile.Create(vArquivoIni);
    Result  := IniFile.ReadString(vSecao,vChave,'');
    IniFile.Free;
  End
  Else // Existe no BANCO
  Begin
    Result := '';
    Qry.First;
    // PARA OS CASOS ONDE O VALOR TEM MAIS DE 4000 CHARS CONCATENA TODOS OS
    // VALORES QUE ESTÃO ORDENADOS PELO ITEM
    While NOT Qry.EOF do
    begin
      Result := Result + Qry.FieldByName('Valor').AsString;
      Qry.Next;
    end;
  End;

  // FECHANDO E DESTUINDO A QUERY DE PESQUISA
  Qry.Close;
  Qry.Free;
end;

Procedure GravaArqIni(vSecao, vChave, vValor : String; vArquivoIni : String = ''; vModulo : String = '' );
var
  vStart: Boolean;
  Qry, Qry1 : TQuery;
  vItem: Integer;
begin
  // CRIANDO QUERY DE PESQUISA
  Qry := TQuery.Create(Application);
  Qry.DatabaseName := cDatabaseName;

  // CRIANDO QUERY DE INCLUSÃO/EXCLUSÃO/ALTERAÇÃO
  Qry1 := TQuery.Create(Application);
  Qry1.DatabaseName := cDatabaseName;

  // VERIFICA SE JÁ EXISTE NO BANCO
  Qry.Sql.Add('Select /*+ RULE */ Valor, Item From CTR_Dados_Ini');
  Qry.Sql.Add('Where Modulo = :pModulo');
  Qry.Sql.Add('And Secao = :pSecao');
  Qry.Sql.Add('And Chave = :pChave');

  // DIRETÓRIO E NOME DA APLICAÇÃO.
  If (vArquivoIni = '') and (vModulo = '') Then
    Qry.ParamByName('pModulo').AsString := Application.Title
  Else
    If vModulo = '' then
    // SE PASSOU O PATH, TRAZ SOMENTE O NOME OD ARQUIVO
    // SEM O PATH FUNCIONA NORMALMENTE - Riobóo
    Qry.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
  else
    Qry.ParamByName('pModulo').AsString := vModulo;

  Qry.ParamByName('pSecao').AsString := vSecao;
  Qry.ParamByName('pchave').AsString := vChave;
  Qry.Open;

  // PARA FUNCIONAR O RECORDCOUNT
  Qry.Last;

  // VERIFICA SE NÃO HÁ TRANSAÇÃO ABERTA
  // PARA NÃO "COMITAR" UMA TRANSAÇÃO ABERTAR
  // EM OUTRO MOMENTO E QUE PODERÁ SER CANCELADA
  vStart := (NOT dm.DbBGM.InTransaction);
  If vStart then
    dm.DbBGM.StartTransaction;

  // CASO UMA GRAVAÇÃO ANTERIOR TENHA UTILIZADO
  // MAIS DE UM ITEM (REGISTRO) DA TABELA (> 4000 Chars)
  // OU A GRAVAÇÃO ATUAL NECESSITAR DE MAIS DE UM ITEM
  // APAGA TODOS PARA NÃO TENTAR DAR UPDATE
  If (NOT Qry.IsEmpty) And
     ((Length(vValor) > 4000) OR
      (Qry.RecordCount > 1)) Then
  begin
    // APAGANDO TODOS OS ITENS DA CHAVE
    Qry1.Close;
    Qry1.Sql.Clear;
    Qry1.Sql.Add('DELETE /*+ RULE */ CTR_Dados_Ini WHERE');
    Qry1.Sql.Add('Modulo = :pModulo');
    Qry1.Sql.Add('AND Secao = :pSecao');
    Qry1.Sql.Add('AND Chave = :pChave');
    If (vArquivoIni = '') and (vmodulo = '') Then
      Qry1.ParamByName('pModulo').AsString := Application.Title // Nome da aplicação.
    Else
    If vModulo = '' then
      Qry1.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
    else
      Qry1.ParamByName('pModulo').AsString := vModulo; { Veronica para busacr as cores definida pelo usuario em todos os mudulo }
    Qry1.ParamByName('pSecao').AsString := vSecao;
    Qry1.ParamByName('pChave').AsString := vChave;
    Qry1.ExecSql;

    // ATUALIZANDO A PESQUISA
    Qry.Close;
    Qry.Open;
  end;

  // NÃO HAVENDO UM REGISTRO PRE GRAVADO PARA A CHAVE INSERE
  // DO CONTRÁRIO DARÁ UPDATE
  If Qry.IsEmpty Then
  begin
    // INSERINDO ITEM DA CHAVE
    Qry1.Close;
    Qry1.Sql.Clear;
    Qry1.Sql.Add('Insert /*+ RULE */ Into CTR_Dados_Ini (Modulo, Secao, Chave, Valor, Data, Item) ');
    Qry1.Sql.Add('Values (:pModulo, :pSecao, :pChave, :pValor, SysDate, :pItem )');
    If (vArquivoIni = '') and (vmodulo = '') Then
      Qry1.ParamByName('pModulo').AsString := Application.Title // Nome da aplicação.
    Else
    If vModulo = '' then
      Qry1.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
    else
      Qry1.ParamByName('pModulo').AsString := vModulo; { Veronica para busacr as cores definida pelo usuario em todos os mudulo }
    Qry1.ParamByName('pSecao').AsString := vSecao;
    Qry1.ParamByName('pChave').AsString := vChave;

    // CASO A GRAVAÇÃO SEJA MAIOR QUE 4000 (TAMANHO MÁXIMO DO CAMPO)
    // QUEBRA EM VÁRIOS ITENS INCREMENTANDO O CAMPO ITEM DA CHAVE PRIMÁRIA
    vItem := 1;
    While Length(vValor) > 4000 do
    begin
      Qry1.ParamByName('pValor').AsString := Copy(vValor,1,4000);
      Qry1.ParamByName('pItem').AsInteger := vItem;
      Qry1.ExecSql;
      System.Delete(vValor,1,4000);
      Inc(vItem);
    end;
    // GRAVA O RESTO DO VALOR OU O VALOR TOTAL QDO < 4000
    Qry1.ParamByName('pValor').AsString := vValor;
    Qry1.ParamByName('pItem').AsInteger := vItem;
    Qry1.ExecSql;
  end else
  begin
    // SE HOUVE DE FATO ALTERAÇÃO NO VALOR DARÁ UPDATE NA TABELA
    If Qry.FieldByName('Valor').AsString <> vValor Then
    Begin
      Qry1.Close;
      Qry1.Sql.Clear;
      Qry1.Sql.Add('Update /*+ RULE */ CTR_Dados_Ini');
      Qry1.Sql.Add('Set Valor = :pValor, Data = SysDate');
      Qry1.Sql.Add('Where Modulo = :pModulo');
      Qry1.Sql.Add('And Secao = :pSecao');
      Qry1.Sql.Add('And Chave = :pChave');
      If (vArquivoIni = '') and (vmodulo = '') Then
        Qry1.ParamByName('pModulo').AsString := Application.Title // Nome da aplicação.
      Else
      If vModulo = '' then
        Qry1.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
      else
        Qry1.ParamByName('pModulo').AsString := vModulo; { Veronica para busacr as cores definida pelo usuario em todos os mudulo }

      Qry1.ParamByName('pSecao').AsString := vSecao;
      Qry1.ParamByName('pChave').AsString := vChave;
      Qry1.ParamByName('pValor').AsString := vValor;
      Qry1.ExecSql;
    end;
  end;

  // SÓ "COMITA" AK SE FOI "STARTADO" AK.
  If vStart Then
    dm.dbBGM.Commit;

  // FECHANDO E DESTRUINDO AS QUERYS AUXILIARES
  Qry1.Close;
  Qry1.Free;
  Qry.Close;
  Qry.Free;
end;


*)


(*
Function LeArqIni(vSecao, vChave : String; vArquivoIni : String = ''; vModulo : String = '' ): String;
Var
//  vStart: Boolean;
  IniFile : TIniFile;
  Qry : TQuery;
//  vData : TDateTime;
Begin
  Qry := TQuery.Create(Application);
  Qry.DatabaseName := cDatabaseName;
  Qry.Close;
  Qry.Sql.Clear;
  Qry.Sql.Add('Select Valor, Data From CTR_Dados_Ini');
  Qry.Sql.Add('Where Modulo = :pModulo');
  Qry.Sql.Add('And Secao = :pSecao');
  Qry.Sql.Add('And Chave = :pChave');

  If (vArquivoIni = '') and (vModulo = '') Then
    Qry.ParamByName('pModulo').AsString := Application.Title  // Nome da aplicação
  Else
    If vModulo = '' then
    // SE PASSOU O PATH, TRAZ SOMENTE O NOME OD ARQUIVO
    // SEM O PATH FUNCIONA NORMALMENTE - Riobóo
      Qry.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
    else
      Qry.ParamByName('pModulo').AsString := vModulo; { Veronica para busacr as cores definida pelo usuario em todos os mudulo }

  Qry.ParamByName('pSecao').AsString := vSecao;
  Qry.ParamByName('pchave').AsString := vChave;
//  Msg('Lendo CTR_DADOS_INI (Lê) ...');
  Qry.Open;
//  Msg;
  If Qry.IsEmpty Then // Qdo não existe no BANCO, busca do .INI
  Begin
    If vArquivoIni = '' Then // Nome da aplicação.
      vArquivoIni := ExtractFilePath(Application.ExeName) + Application.Title + '.Ini'
    Else
    begin
      // PARA OS CASOS EM QUE NÃO PASSOU O PATH FORÇA O PATH DA APLICAÇÃO - Riobóo
      If Pos('\',vArquivoINI) > 0 Then
        vArquivoIni := vArquivoIni + '.Ini'
      else
        vArquivoIni := ExtractFilePath(Application.ExeName) + vArquivoIni + '.Ini';
    end;
    IniFile := TIniFile.Create(vArquivoIni);
    Result  := IniFile.ReadString(vSecao,vChave,'');
    IniFile.Free;
  End
  Else // Existe no BANCO
  Begin
    Result := Qry.FieldByName('Valor').AsString;

  End;
  Qry.Close;
  Qry.Free;
end;

Procedure GravaArqIni(vSecao, vChave, vValor : String; vArquivoIni : String = ''; vModulo : String = '' );
var
  vStart: Boolean;
  Qry, Qry1 : TQuery;
//  vValorAux : String;
begin
  // Verifica se já existe no BANCO
  Qry := TQuery.Create(Application);
  Qry.DatabaseName := cDatabaseName;
  Qry1 := TQuery.Create(Application);
  Qry1.DatabaseName := cDatabaseName;

  Qry.Sql.Add('Select Valor From CTR_Dados_Ini');
  Qry.Sql.Add('Where Modulo = :pModulo');
  Qry.Sql.Add('And Secao = :pSecao');
  Qry.Sql.Add('And Chave = :pChave');

  If (vArquivoIni = '') and (vModulo = '') Then // Diretório e nome da aplicação.
    Qry.ParamByName('pModulo').AsString := Application.Title
  Else
    If vModulo = '' then
    // SE PASSOU O PATH, TRAZ SOMENTE O NOME OD ARQUIVO
    // SEM O PATH FUNCIONA NORMALMENTE - Riobóo
    Qry.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
  else
    Qry.ParamByName('pModulo').AsString := vModulo; { Veronica para gravar as cores definida pelo usuario em todos os mudulo }

  Qry.ParamByName('pSecao').AsString := vSecao;
  Qry.ParamByName('pchave').AsString := vChave;
//  Msg('Lendo CTR_DADOS_INI (Grava) ...');
  Qry.Open;
//  Msg;
  If Qry.IsEmpty Then // Incluir no BANCO
  Begin
    Qry1.Close;
    Qry1.Sql.Clear;
    Qry1.Sql.Add('Insert Into CTR_Dados_Ini (Modulo, Secao, Chave, Valor, Data)');
    Qry1.Sql.Add('Values (:pModulo, :pSecao, :pChave, :pValor, SysDate )');
    If (vArquivoIni = '') and (vmodulo = '') Then
      Qry1.ParamByName('pModulo').AsString := Application.Title // Nome da aplicação.
    Else
    If vModulo = '' then
      Qry1.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
    else
      Qry1.ParamByName('pModulo').AsString := vModulo; { Veronica para busacr as cores definida pelo usuario em todos os mudulo }
    Qry1.ParamByName('pSecao').AsString := vSecao;
    Qry1.ParamByName('pChave').AsString := vChave;
    Qry1.ParamByName('pValor').AsString := vValor;

    // VERIFICA SE NÃO HÁ TRANSAÇÃO ABERTA
    vStart := (NOT dm.DbBGM.InTransaction);
    If vStart then
      dm.DbBGM.StartTransaction;

//    Msg('Inserindo CTR_DADOS_INI (Grava) ...');
    Qry1.ExecSql;
//    Msg;

    // SÓ "COMITA" AK SE FOI "STARTADO" AK.
    If vStart Then
      dm.dbBGM.Commit;
  End
  Else // Atualiza o BANCO
  Begin
    If Qry.FieldByName('Valor').AsString <> vValor Then
    Begin
      Qry1.Close;
      Qry1.Sql.Clear;
      Qry1.Sql.Add('Update CTR_Dados_Ini');
      Qry1.Sql.Add('Set Valor = :pValor, Data = SysDate');
      Qry1.Sql.Add('Where Modulo = :pModulo');
      Qry1.Sql.Add('And Secao = :pSecao');
      Qry1.Sql.Add('And Chave = :pChave');
      If (vArquivoIni = '') and (vmodulo = '') Then
        Qry1.ParamByName('pModulo').AsString := Application.Title // Nome da aplicação.
      Else
      If vModulo = '' then
        Qry1.ParamByName('pModulo').AsString := Copy(vArquivoIni,Length(ExtractFilePath(vArquivoIni))+1,Length(vArquivoIni) - Length(ExtractFilePath(vArquivoIni)))
      else
        Qry1.ParamByName('pModulo').AsString := vModulo; { Veronica para busacr as cores definida pelo usuario em todos os mudulo }

      Qry1.ParamByName('pSecao').AsString := vSecao;
      Qry1.ParamByName('pChave').AsString := vChave;
      Qry1.ParamByName('pValor').AsString := vValor;

      // VERIFICA SE NÃO HÁ TRANSAÇÃO ABERTA
      vStart := (NOT dm.DbBGM.InTransaction);
      If vStart then
        dm.DbBGM.StartTransaction;

//      Msg('Atualizando CTR_DADOS_INI (Grava) ...');
      Qry1.ExecSql;
//      Msg;

      // SÓ "COMITA" AK SE FOI "STARTADO" AK.
      If vStart Then
        dm.dbBGM.Commit;
    End;
  End;
  Qry1.Close;
  Qry1.Free;
  Qry.Close;
  Qry.Free;
end;


*)


Function ValidaHistorico(PCodigoEmpresa, PCodigoFG : integer; vplano : string; vFlagIntegradoCCTB : Boolean ) : Boolean;
Begin

// Pesquisando históricos e cadastrando-os se necessário...

  If PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 901, '', 'BCO', ' DE %TD Nr %D - %P'      , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 902, '', 'BCO', ' EMITIDO Nr. %CQ'        , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 903, '', 'BCO', ' DE PAGTO. Nr %BO'       , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 904, '', 'BCO', ' DE %TD Nr %D - %P'      , 'C') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 905, '', 'BCO', 'PAGAMENTO'               , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 906, '', 'BCO', 'CHEQUE'                  , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 907, '', 'BCO', 'BORDERO'                 , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 908, '', 'BCO', 'RECEBIMENTO'             , 'C') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 909, '', 'BCO', 'PAGAMENTO ELETRONICO'    , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 910, '', 'BCO', ' %PE'                    , 'C') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 911, '', 'BCO', ' DE BAIXA POR LOTE %BO'  , 'C') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 912, '', 'BCO', 'INTEGRAÇÃO CGS'          , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 913, '', 'BCO', 'INTEGRAÇÃO CGS'          , 'C') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 914, '', 'BCO', ' P.V. %D - %DCT - %NMOT' , 'D') and
     PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 915, '', 'BCO', ' P.V. %D - %DCT - %NMOT' , 'C') then
  Begin
    If vFlagIntegradoCCTB then
    Begin
      If PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 901, vPlano, 'CTB', 'ENTRADA DE %TD N. %D'                                   ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 902, vPlano, 'CTB', 'PAGAMENTO DE %TD Nr %D - %P'                            ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 903, vPlano, 'CTB', 'ACRESCIMO NO DOCTO Nr %D DO FORN %NFF'                  ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 904, vPlano, 'CTB', 'DESCONTO OBTIDO NO DOCTO %D DO FORN %NFF'               ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 905, vPlano, 'CTB', 'PAGAMENTO DE DOCTO CONF. CHQ Nr. %CQ - %HCQ'            ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 906, vPlano, 'CTB', 'PAGAMENTO EFETUADO CONF. DOCTO Nr. %D'                  ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 907, vPlano, 'CTB', 'SAIDA DA %TD N. %D-%P'                                  ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 908, vPlano, 'CTB', 'ENTRADA DE MATERIAL NR. %D'                             ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 909, vPlano, 'CTB', 'SAIDA DE MATERIAL NR. %D'                               ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 910, vPlano, 'CTB', 'ACRESCIMO NO RECEBTO. Nr %D DO FORN %NFF'               ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 911, vPlano, 'CTB', 'DESCONTO NO RECEBTO. %D DO FORN %NFF'                   ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 912, vPlano, 'CTB', 'RECEBIMENTO DE %TD Nr %D - %P'                          ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 913, vPlano, 'CTB', 'PAGAMENTO DE DOCTO CONF BORDERO %BO'                    ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 914, vPlano, 'CTB', 'ENTRADA DE %TD N. %D - FORNECEDOR %RS'                  ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 915, vPlano, 'CTB', 'SAIDA DA %TD N. %D-%P - CLIENTE %RS'                    ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 916, vPlano, 'CTB', 'N. PGTO %DTD Nr. %D %P %RS %FAV'                        ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 917, vPlano, 'CTB', 'ENTRADA DE %TD %D DO FORN %RS'                          ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 918, vPlano, 'CTB', 'N. RECEBTO %DTD Nr %D - %P'                             ) and
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 919, vPlano, 'CTB', 'VALOR FATURA NRO %D'                                    ) and  // para Emissão de Fatura
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 920, vPlano, 'CTB', 'PAGAMENTO DE %TD Nr %D - %P'                            ) and  // para Pagamento em conta caixa - Debito
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 921, vPlano, 'CTB', 'RECEBIMENTO DE %TD Nr %D - %P'                          ) and  // para recebimento em conta caixa - Debito
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 922, vPlano, 'CTB', 'PAGAMENTO DE %TD Nr %D - %P'                            ) and  // para pagamento em conta caixa - Credito
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 923, vPlano, 'CTB', 'RECEBIMENTO DE %TD Nr %D - %P'                          ) and  // para recebimento em conta caixa - Credito
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 924, vPlano, 'CTB', 'RECEBIMENTO DE %TD Nr %D - %P'                          ) and  // Para recebimento de fatura conta cliente
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 925, vPlano, 'CTB', 'PAGAMENTO DE INSS REF. DOCTO Nr %D - %P'                ) and  // Para pagamento de INSS
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 926, vPlano, 'CTB', 'PAGAMENTO DE IRRF REF. DOCTO Nr %D - %P'                ) and  // Para pagamento de IRRF
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 927, vPlano, 'CTB', 'INCLUSAO DE IRRF DOCTO. %D %P'                          ) and  // Para provisao de IRRF
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 928, vPlano, 'CTB', 'INCLUSAO DE INSS DOCTO. %D %P'                          ) and  // Para provisao de IRRF
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 929, vPlano, 'CTB', 'TRANSFERENCIA %TD NR %D, DA EMPRESA/FILIAL: %RS/%NFF'   ) and  // Para transferencia de locais (Estoque)
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 930, vPlano, 'CTB', 'TRANSFERENCIA %TD NR %D, PARA EMPRESA/FILIAL: %RS/%NFF' ) and  // Para transferencia de locais (Estoque)
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 931, vPlano, 'CTB', 'PAGAMENTO DE DOCTO CONF. PG.ELETRONICO %PE'             ) and  // Para pagamento eletronico  - Crédito Banco ( CPG )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 932, vPlano, 'CTB', 'SAIDA POR INVENTARIO NR. %D'                            ) and  // Saida de inventario
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 933, vPlano, 'CTB', 'ENTRADA POR INVENTARIO NR. %D'                          ) and  // Entrada de inventario
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 934, vPlano, 'CTB', 'N. PGTO %DTD Nr. %D %P %RS %FAV %PE'                    ) and  // Para pagamento eletronico - Débito Itens - forma Baixa ( CPG )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 935, vPlano, 'CTB', 'PAGAMENTO EFETUADO CONF. PG. ELETRONICO %PE'            ) and  // Para pagamento eletronico - Débito Fornecedor - forma Ambos ( CPG )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 936, vPlano, 'CTB', 'INTEGRACAO DA FOLHA %CPDMA %CPMA %TP %CAE %DAR %CCT %DCT') and // Para integração da folha - Débito  ( FLP )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 937, vPlano, 'CTB', 'INTEGRACAO DA FOLHA %CPDMA %CPMA %TP %CAE %DAR %CCT %DCT') and // Para integração da folha - Crédito ( FLP )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 938, vPlano, 'CTB', 'INTEGRACAO ARRECADACAO (DEBITOS)'                       ) and  // Para Integração Arrecadação Débitos( CPG )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 939, vPlano, 'CTB', 'INTEGRACAO ARRECADACAO (CREDITOS)'                      ) and  // Para Integração Arrecadação Créditos( CPG )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 944, vPlano, 'CTB', 'INSS RETIDO'                                            ) and  // Para Provisão INSS ( CRC )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 945, vPlano, 'CTB', 'IRRF RETIDO'                                            ) and  // Para Provisão IRRF ( CRC )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 946, vPlano, 'CTB', 'RECEBIMENTO BL %BO'                                     ) and  // Para recebimento por baixo por lote ( CRC )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 947, vPlano, 'CTB', 'PIS A RECOLHER REF. %TD NR. %D - %RS'                   ) and  // Integração do PIS ( EST )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 948, vPlano, 'CTB', 'DEVOLUCAO REF. ENTRADA DE %TD %D DO FORN %RS'           ) and  // Integração de devolução de entrada ( EST )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 949, vPlano, 'CTB', 'CONSUMO DE MATERIAIS NO PERIODO'                        ) and  // Para a integração da saída do estoque ( EST )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 950, vPlano, 'CTB', 'DEVOLUCAO REF. SAIDA DE MATERIAL NR. %D'                ) and  // Integração de devolução de saida ( EST )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 951, vPlano, 'CTB', 'INTEGRACAO DVS. %TXT %D %DTD'                           ) and  // Integração do DVS
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 952, vPlano, 'CTB', 'INCLUSAO DE ISS DOCTO. %D %P'                           ) and  // Integração do CPG
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 953, vPlano, 'CTB', 'INCLUSAO DE PIS DOCTO. %D %P'                           ) and  // Integração do CPG
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 954, vPlano, 'CTB', 'INCLUSAO DE COFINS DOCTO. %D %P'                        ) and  // Integração do CPG
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 955, vPlano, 'CTB', 'INCLUSAO DE CSL DOCTO. %D %P'                           ) and  // Integração do CPG
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 956, vPlano, 'CTB', 'ISS RETIDO DOCTO. %D %P'                                ) and  // Integração do CRC
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 957, vPlano, 'CTB', 'PIS RETIDO DOCTO. %D %P'                                ) and  // Integração do CRC
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 958, vPlano, 'CTB', 'COFINS RETIDO DOCTO. %D %P'                             ) and  // Integração do CRC
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 959, vPlano, 'CTB', 'CSL RETIDO DOCTO. %D %P'                                ) and  // Integração do CRC
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 960, vPlano, 'CTB', '%TD %D SÉRIE %SD DO CLIENTE %CF %RS'                    ) and  // Integração do TUR
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 961, vPlano, 'CTB', 'RECEBIMENTO DE DOCTO CONF. COB.ELETRONICA %PE'          ) and  // Para cobrança eletronico  - debito Banco ( CRC )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 932, vPlano, 'CTB', 'N. RECBTO %DTD Nr. %D %P %RS %FAV %PE'                  ) and  // Para cobrança eletronico - Credito Itens - forma Baixa ( CRC )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 963, vPlano, 'CTB', 'RECEBIMENTO EFETUADO CONF. COB.ELETRONICA %PE'          ) and  // Para cobrança eletronico - Credito Cliente - forma Ambos ( CRC )
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 964, vPlano, 'CTB', 'IMPOSTOS A RECOLHER REF. %TD NR. %D - %RS'              ) and  // Integração do CTB
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 965, vPlano, 'CTB', '%TD %D SÉRIE %SD DO CLIENTE %CF %RS'                    ) and  // Integração do TRR
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 966, vPlano, 'CTB', 'INTEGRAÇÃO CGS - Plano de viagem %D - %DCT - %NMOT'     ) and  // Integração do CGS - Plano de viagem
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 967, vPlano, 'CTB', 'PIS/COFINS/CSL DOCTO. %D %P'                            ) And  // Integração do CPG
         PesquisaECadastraHist( PCodigoEmpresa, PCodigoFG, 968, vPlano, 'CTB', 'ICMS A RECOLHER REF. %TD NR. %D - %RS'                  ) Then // Integração do ICMS ( EST )
         Result := True else Result := False;
         exit;
    end;
    Result := True;
  end
  else Result := False;

end;

function Localizagrupos(pCodInternoMat:String):String;
var
  vPesquisaMaterial : TQuery;
  vTipoGrupo        : String;
begin
  vTipoGrupo := '';
  vPesquisaMaterial := TQuery.Create(Application);
  vPesquisaMaterial.DatabaseName := cDatabaseName;
  With vPesquisaMaterial do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT' );
    Sql.Add('  *' );
    Sql.Add('FROM' );
    Sql.Add('  EST_CADMATERIAL' );
    Sql.Add('WHERE' );
    Sql.Add('  CODIGOINTERNOMATERIAL = :P_CODIGOINTERNOMATERIAL' );
    ParamByName('P_CODIGOINTERNOMATERIAL').AsString := pCodInternoMat;
    Open;
    If FieldByName('CODIGOGRE').AsInteger > 0 then vTipoGrupo := vTipoGrupo + 'E'; // Estoque
    If FieldByName('CODIGOGRD').AsInteger > 0 then vTipoGrupo := vTipoGrupo + 'D'; // Despesa
    If FieldByName('CODIGOGRC').AsInteger > 0 then vTipoGrupo := vTipoGrupo + 'C'; // Compras
  end; // With vPesquisaMaterial do
  vPesquisaMaterial.Close;
  vPesquisaMaterial.Free;
  Result := Trim(vTipoGrupo);
end;

Function  ProximaSequencia(pNomeSequence:String):Integer;
var _Query : TQuery;
begin
  _Query := TQuery.Create(Application);
  with _Query do
  begin
    close;
    DatabaseName := cDatabaseName;
    sql.Clear;
    sql.add('Select '+pNomeSequence+'.NextVal Proximo from dual');
    try
      Open;
      result := FieldByName('Proximo').AsInteger;
      close;
    except
      result := 0;
      close;
    end;
    Free;
  end;
end;


procedure ImpressoraEspecifica(pNomeImpressora: String);
Var
  vImpressoras : TStringList;
  vContInpressora, vImpPadrao, vCont {, vLinha} {vAltLinha}    : Integer;
  vTemImpExata : Boolean;
  vNomeImpressorasPesq , DeviceDoComp, DriverDoComp, PortDoComp         : String;
  DevModDoComp : THandle;
  vImpPodeSer : Integer;
begin
  vImpressoras := TStringList.Create;
  { Limpa a variavel e armazena as impressoras existentes }
  vImpressoras.Clear;
  vImpressoras.Assign(Printer.Printers);

  { Transforma tudo para maiusculas }
  For vCont := 0 To vImpressoras.Count-1 Do
    vImpressoras[vCont] := UpperCase(vImpressoras[vCont]);

  vImpPadrao := Printer.PrinterIndex; // Guarda a impressora padrão
  vTemImpExata := False;
  DeviceDoComp :=  frmMenuPrincipal.CrRpt.Printer.Name;
  DriverDoComp :=  frmMenuPrincipal.CrRpt.Printer.Driver;
  PortDoComp   :=  frmMenuPrincipal.CrRpt.Printer.Port;
  DevModDoComp :=  frmMenuPrincipal.CrRpt.Printer.Mode;
  vContInpressora := 0;
  vImpPodeSer := -99;
  For vCont := 0 To vImpressoras.Count-1 Do
  begin
    vNomeImpressorasPesq := Copy( vImpressoras[vCont],1,pos( Iif(pos(' ON',vImpressoras[vCont])>0,' ON',' EM'),vImpressoras[vCont]));
    If trim(vNomeImpressorasPesq) = '' then vNomeImpressorasPesq := vImpressoras[vCont];
    If Pos(pNomeImpressora,vNomeImpressorasPesq) > 0 Then // Encontra o indice da impressora escolhida no parâmetro
    Begin
      vImpPodeSer := vCont;
      Inc(vContInpressora);
      If Length(trim(pNomeImpressora)) = length(Trim(vNomeImpressorasPesq)) then
      Begin
        vTemImpExata := True;
        Break;
      end;
    end;
  end;

  if vContInpressora = 0 then
    MensagemDlg('Não existe impressora definida com o nome "' + pNomeImpressora +
                '". Será utilizada a impressora padrão.', mtInformacao, mbok );

  if vContInpressora > 1 then
    MensagemDlg('Existe mais que uma impressora definida com o nome "' + pNomeImpressora + '".',
                mtInformacao, mbok );

  { Caso tenha a impressora passada como parâmetro, altera para impressora padrão }
  If vTemImpExata Then
    Printer.PrinterIndex := vCont
  else
    If (vContInpressora = 1) And (vImpPodeSer <> -99) Then
      Printer.PrinterIndex := vImpPodeSer;
  // Assume a impressora padrão e suas características.
  frmMenuPrincipal.CrRpt.Printer.GetCurrent(False);
  frmMenuPrincipal.CrRpt.Execute;

  // Restaura a impressora padrão e as configurações do componente do Crystal
  Printer.PrinterIndex := vImpPadrao;
  frmMenuPrincipal.CrRpt.Printer.Name := DeviceDoComp;
  frmMenuPrincipal.CrRpt.Printer.Driver := DriverDoComp;
  frmMenuPrincipal.CrRpt.Printer.Port := PortDoComp;
  frmMenuPrincipal.CrRpt.Printer.Mode := DevModDoComp;

  vImpressoras.Free;
end;

Function VerificaSeEmpresaPossuiFilial(pEmpresa : integer) : Boolean;
begin
  { VERIFICA SE A EMPRESA POSSUI FILIAL }
  result := true;
  With qrPesqAux do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM CTR_CADEMP');
    SQL.Add('WHERE CODIGOEMPRESA = :P0');
    Params[0].AsInteger := pEmpresa;
    Open;
    If not IsEmpty then
    begin
      vPossuiFilial := fieldByName('POSSUIFILIALEMPRESA').AsString = 'S';
      result := vPossuiFilial;
    end;
  end;
end;

Function TrazInscricaoEmpresa(pEmpresa, pFilial : integer) : String;
(*
  Substituir pela função TrazDadosDaEmpresa
*)

begin
  With qrPesqAux do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM CTR_EMPAUTORIZADAS A , CTR_FILIAL F');
    sql.Add('WHERE F.CODIGOEMPRESA = :P0 AND F.CODIGOFL = :P1 AND');
    sql.Add('A.CODINTEMPAUT = F.CODINTEMPAUT');
    Params[0].AsInteger := pEmpresa;
    Params[1].AsInteger := pFilial;
    Open;
    If not IsEmpty then
    begin
      If fieldByname('TIPOINSCRICAOEMPAUT').AsString = 'CNPJ' then
        Result := copy(fieldByName('INSCRICAOEMPRESA').AsString,1,2) + '.' +
                  copy(fieldByName('INSCRICAOEMPRESA').AsString,3,3) + '.' +
                  copy(fieldByName('INSCRICAOEMPRESA').AsString,6,3) + '/' +
                  copy(fieldByName('INSCRICAOEMPRESA').AsString,9,4) + '-' +
                  copy(fieldByName('INSCRICAOEMPRESA').AsString,13,2)
      else
      If fieldByname('TIPOINSCRICAOEMPAUT').AsString = 'CPF' then
        Result := copy(fieldByName('INSCRICAOEMPRESA').AsString,1,3) + '.' +
                  copy(fieldByName('INSCRICAOEMPRESA').AsString,4,3) + '.' +
                  copy(fieldByName('INSCRICAOEMPRESA').AsString,7,3) + '-' +
                  copy(fieldByName('INSCRICAOEMPRESA').AsString,10,2)
      else
        Result := fieldByName('INSCRICAOEMPRESA').AsString;
    end;
  end;
end;

Function ImpressoraEspecificaRDP(pNomeImpressora: String) : String;
(*Var
  vImpressoras, vImpressorasAux : TStringList;
  vContInpressora,
  vCont : Integer;
  vTemImp : Boolean;
  vNomeImpressorasPesq : String;
  vCaminhoImp : String;
  Device, Driver, Port : String;
  DevMode : THandle;
  a : Integer;
  vImpPadrao : Integer;
  vDevice : String;
  vPort : String;*)
Var
  Registry : TRegistry;
begin
(*  { Define variáveis para a função GetPrinter }
  SetLength(Device, 255);
  SetLength(Driver, MAX_PATH);
  SetLength(Port, MAX_PATH);
  { Cria uma string list para guardar as impressoras disponíveis }
  vImpressorasAux := TStringList.Create;
  { Cria uma string list para guardar as impressoras disponíveis, com nome e caminho }
  vImpressoras := TStringList.Create;
  vImpressoras.Clear;
  { Limpa a variavel e armazena as impressoras existentes }
  vImpressorasAux.Clear;
  vImpressorasAux.Assign(Printer.Printers);
  { Guarda a impressora padrão }
  vImpPadrao := Printer.PrinterIndex;
  { Busca o nome e o caminho de cada uma das impressoras }
  For vCont := 0 To vImpressorasAux.Count-1 Do
  Begin
    { Faz a impressora da lista ser a padrão }
    Printer.PrinterIndex := vCont;
    { Traz as informações separadamente }
    Printer.GetPrinter(PChar(Device), PChar(Driver), PChar(Port), DevMode);
    MensagemDlg('Device="' + Device + '"', mtatencao,mbok);
    MensagemDlg('Driver="' + Driver + '"', mtatencao,mbok);
    MensagemDlg('Port="' + Port + '"', mtatencao,mbok);
    vDevice := '';
    For a := 1 To Length(Device) Do
    Begin
     If Device[a] = #0 Then Break;
     vDevice := vDevice + Device[a];
    End;
    vPort := '';
    For a := 1 To Length(Driver) Do
    Begin
       If Port[a] = #0 Then Break;
       vPort := vPort + Driver[a];
    End;
    vImpressoras.Add(vDevice + ' EM ' + vPort);
  End;
  Printer.PrinterIndex := -1; // Retorna a impressora padrão
//

  Result := '';
//  vImpressoras := TStringList.Create;
  { Limpa a variavel e armazena as impressoras existentes }
//  vImpressoras.Clear;
//  vImpressoras.Assign(Printer.Printers);
  { Transforma tudo em maiusculas }
  For vCont := 0 To vImpressoras.Count-1 Do
    vImpressoras[vCont] := UpperCase(vImpressoras[vCont]);

  vTemImp    := False;
  vContInpressora := 0;
  For vCont := 0 To vImpressoras.Count-1 Do
  begin
    If ( Pos(' ON',vImpressoras[vCont]) > 0 ) Or ( Pos(' EM',vImpressoras[vCont]) > 0 ) Then
    Begin // Tem caminho no nome
      vNomeImpressorasPesq := Copy( vImpressoras[vCont], 1, Pos( IIf(pos(' ON',vImpressoras[vCont]) > 0,' ON',' EM'),vImpressoras[vCont]));
      vCaminhoImp := Copy( vImpressoras[vCont], Pos( IIf(Pos(' ON',vImpressoras[vCont]) > 0,' ON',' EM'),vImpressoras[vCont]) + 4, 200);
    End
    Else
      If Copy(vImpressoras[vCont], 1, 2) = '\\' Then // Em ambiente NT não traz ON ou EM
      Begin // Não tem caminho
        vNomeImpressorasPesq := Copy(vImpressoras[vCont], 3, 200); // Remove as duas barras iniciais
        vNomeImpressorasPesq := Copy( vNomeImpressorasPesq, Pos( '\', vNomeImpressorasPesq ) + 1, 200);
        vCaminhoImp := Copy( vImpressoras[vCont], 1, Pos( '\', Copy(vImpressoras[vCont], 3, 200)) + 1);
      End
    Else
      Begin // Não tem caminho
        vNomeImpressorasPesq := vImpressoras[vCont];
        vCaminhoImp := '';
      End;
    If Trim(vNomeImpressorasPesq) = '' Then vNomeImpressorasPesq := vImpressoras[vCont];
    If Pos(pNomeImpressora,vNomeImpressorasPesq) > 0 Then // Encontra o indice da impressora escolhida no parâmetro
    begin
      inc(vContInpressora);
      if Length(trim(pNomeImpressora)) = length(Trim(vNomeImpressorasPesq)) then
      begin
        vTemImp := True;
        Result := Trim(vCaminhoImp);
        Break;
      end;
    end;
  end;

  if vContInpressora = 0 then
    MensagemDlg('Não existe impressora definida com o nome "' + pNomeImpressora + '".', mtErro, mbOk);

  if vContInpressora > 1 then
    MensagemDlg('Existe mais que uma impressora definida com o nome "' + pNomeImpressora + '".', mtErro, mbOk);

  vImpressoras.Free;
*)

  Registry := TRegistry.Create;
  Registry.RootKey := HKEY_LOCAL_MACHINE;
  Registry.OpenKey('System\CurrentControlSet\Control\Print\Printers\' + pNomeImpressora, False);
  Result := Registry.ReadString('Port');
end;

Function DefineComoImpressoraPadrao(pNomeDaImpressora : String) : Boolean;
Var
  vImpressoras : TStringList;
  vContInpressora, {vImpPadrao,} vCont , vContIndex, IndiceImpressora : Integer;
  vTemImp      : Boolean;
  vNomeImpressorasPesq {, DeviceDoComp, DriverDoComp, PortDoComp}         : String;
//  DevModDoComp : THandle;
Begin
//  Result := False;
  vImpressoras := TStringList.Create;
  { Limpa a variavel e armazena as impressoras existentes }
  vImpressoras.Clear;
  vImpressoras.Assign(Printer.Printers);
  { Transforma tudo para maiusculas }
  For vCont := 0 To vImpressoras.Count-1 Do
    vImpressoras[vCont] := UpperCase(vImpressoras[vCont]);
  { Guarda no menu principal a impressora padrão atual }
//  frmMenuPrincipal.vImpressoraPadrao := Printer.PrinterIndex;
  vImpressoraPadrao := Printer.PrinterIndex;
  { Pesquisa a impressora solicitada }
  vTemImp    := False;
  vContInpressora := 0;
  For vCont := 0 To vImpressoras.Count-1 Do
  Begin
    vNomeImpressorasPesq := Copy( vImpressoras[vCont],1,pos( Iif(pos(' ON',vImpressoras[vCont])>0,' ON',' EM'),vImpressoras[vCont]));
    If trim(vNomeImpressorasPesq) = '' then vNomeImpressorasPesq := vImpressoras[vCont];
    If Pos(pNomeDaImpressora,vNomeImpressorasPesq) > 0 Then // Encontra o indice da impressora escolhida no parâmetro
    begin
      inc(vContInpressora);
    end;
  End;

  IndiceImpressora := 0;

  For vContIndex := 0 To vImpressoras.Count-1 Do
  Begin
    vNomeImpressorasPesq := Copy( vImpressoras[vContIndex],1,pos( Iif(pos(' ON',vImpressoras[vContIndex])>0,' ON',' EM'),vImpressoras[vContIndex]));
    If trim(vNomeImpressorasPesq) = '' then vNomeImpressorasPesq := vImpressoras[vContIndex];
    If Pos(pNomeDaImpressora,vNomeImpressorasPesq) > 0 Then // Encontra o indice da impressora escolhida no parâmetro
    begin
      if Length(trim(pNomeDaImpressora)) = length(Trim(vNomeImpressorasPesq)) then
      begin
        IndiceImpressora := vContIndex;
        vTemImp := True;
        Break;
      end;
    end;
  End;

  if vContInpressora = 0 then
    MensagemDlg('Não existe impressora definida com o nome "' + pNomeDaImpressora +
                '".', mtInformacao, mbok );

  if vContInpressora > 1 then
    MensagemDlg('Existe mais que uma impressora definida com o nome "' + pNomeDaImpressora + '".',
                mtInformacao, mbok );

  { Caso exista a impressora, define-a como padrão }
  If (vTemImp) and (vcontInpressora = 1) Then
    Begin
      Printer.PrinterIndex := indiceimpressora;
      Result := True;
    End
  else
    Result := False;

  vImpressoras.Free;
End;

Procedure RetornaImpressoraPadrao;
Var
  vImpressoras : TStringList;
Begin
  vImpressoras := TStringList.Create;
  { Limpa a variavel e armazena as impressoras existentes }
  vImpressoras.Clear;
  vImpressoras.Assign(Printer.Printers);
  { Retorna de acordo com a variável do menu principal }
//  Printer.PrinterIndex := frmMenuPrincipal.vImpressoraPadrao;
  Printer.PrinterIndex := vImpressoraPadrao;
  vImpressoras.Free;
End;

Function RodandoRemoto : Boolean;
Var
  Env : PChar;
//  i : Integer;
  s : String;
Begin
  Result := False;
  Env := GetEnvironmentStrings;
  While Env^ <> #0 Do
  Begin
    s := UpperCase(StrPas(Env));
    If (Pos('SESSIONNAME=ICA-TCP#', s) > 0) Or   // Metaframe - Citrix
       (Pos('SESSIONNAME=RDP-TCP#', s) > 0) Then // Terminal  - Microsoft
    Begin
      Result := True;
      Exit;
    End;
    Inc(Env, StrLen(Env)+1);
  End;
End;

Function IncInt(Var pVlr: Integer; pIncremento: Integer = 1) : Integer; { Incrementa uma variável de tipo inteiro e devolve o valor atualizado }
Begin
  Inc(pVlr, pIncremento);
  Result := pVlr;
End;

Function EliminaNaoNumericos(pEntrada : String) : String;
Var
  i : Integer;
Begin
  Result := '';
  For i := 1 To Length(pEntrada) Do
    If (Copy(pEntrada, i, 1) >= '0') And (Copy(pEntrada, i, 1) <= '9') Then
      Result := Result + Copy(pEntrada, i , 1);
End;

Procedure Msg(pMsg : String = ''; pColor : TColor = clBtnFace);
Begin
  If pMsg = '' Then // Se vier vazia, indica que deve retornar a msg salva.
  Begin
    frmMenuPrincipal.BarraDeEstatus.Panels[1].Text := PesquisaArquivoHelp +
                                                      'F3-Calculadora F4-Novo usuário (' +
                                                      Trim(frmMenuPrincipal.vServerName) + '/' +
                                                      Trim(frmMenuPrincipal.vUserName)   + '/' +
                                                      IIf(frmMenuPrincipal.vCodigoCliente <> 0,
                                                          IntToStr(frmMenuPrincipal.vCodigoCliente) + '/', '') +
                                                      UpperCase(vDriveDir)               + ') ' ;;
    frmMenuPrincipal.BarraDeEstatus.Panels[1].Alignment := taCenter;
    vMsgAnterior := '';
  End
  Else
  Begin
    If vMsgAnterior = '' Then { Só salva a msg caso seja a 1a vez, pois podem existir msgs em série }
      vMsgAnterior := frmMenuPrincipal.BarraDeEstatus.Panels[1].Text;
    frmMenuPrincipal.BarraDeEstatus.Panels[1].Text := ' ' + pMsg;
    frmMenuPrincipal.BarraDeEstatus.Panels[1].Alignment := taLeftJustify;
  End;
  frmMenuPrincipal.BarraDeEstatus.Color      := pColor;
  Application.ProcessMessages;
End;

Function ValidaIE(pIE, pUF : String) : TValidaInscIE;
Var
  a, D1, D2, vResto, vnumero, vpeso : Integer;
  vMask, i, i2, vdig : String;
Begin
  { Ir colocando nesta string os estados suportados }
  If Pos(UpperCase(pUF), 'SP_MG_PR_BA_AC_AL_AM_AP_CE_DF_ES_GO_MA_MT_MS_PA_PB_PE_PI_RJ_RN_RO_RR_RS_SC_SE_TO') = 0 Then
  Begin
    Result[1] := 'ND';
    Exit;
  End;
  Result[1]  := 'OK';

  //A       := 0;
  //D1      := 0;
  //D2      := 0;
  //vResto  := 0;
{  vNumero := 0;}
  vPeso   := 0; I       := ''; I2      := '';  vDig    := '';

  i       := UpperCase( pIE );

  If Pos('ISENT',i) > 0 then exit;

// *********************************** Define mascara ***********************************
  If pUf = 'AC' Then
    vMask := '99.999.9999/999-99' //'99.99.9999-9' Antigo
  else If Pos(UpperCase(pUF), 'AL_AP_ES_MA_MS_PI_') > 0 Then
    vMask := '999999999'
  else If Pos(UpperCase(pUF), 'AM_GO_PB_RN_') > 0 Then
    vMask := '99.999.999-9'
  else If pUf = 'BA' Then
    vMask := '9999999-9'
  else If Pos(UpperCase(pUF), 'CE_RR_SE_') > 0 Then
    vMask := '99999999-9'
  else If pUf = 'DF' Then
    vMask := '999.99999.999-99'
  else If pUf = 'MT' Then
    vMask := '9999999999-9'
  else If pUf = 'MG' Then
    vMask := '999.999.999/9999'
  else If pUf = 'PA' Then
    vMask := '99-999999-9'
  else If pUf = 'PE' Then
    vMask := '99.9.999.9999999-9'
  else If pUf = 'PR' Then
    vMask := '999.99999-99'
  else If pUf = 'RJ' Then
    vMask := '99.999.99-9'
  else If pUf = 'RS' Then
    vMask := '999/999999-9'
  else If pUf = 'SC' Then
    vMask := '999.999.999'
  else If pUf = 'RO' Then
    vMask := '9999999999999-9'
  else If pUf = 'SP' Then
  begin
    If copy(I,1,1) = 'P' then vMask := 'x-99999999.9/999'
    else vMask := '999.999.999.999';
  end
  else If pUf = 'TO' Then
    vMask := '99.99.999999-9';

  Result[2] := vMask;
  
// *********************************** Faz validação ************************************
  If pUF = 'SP' Then { São Paulo }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    For a := 1 To Length(i) Do If ((Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9')) Or (Copy(i,a,1) = 'P') Then i2 := i2 + Copy(i,a,1);
    { – Industriais e comerciantes (exceto produtores rurais a eles não equiparados): }
    If Copy(i2,1,1) <> 'P' Then
    Begin
      If Length(i2) <> 12 Then
      Begin
        Result[1] := 'Tamanho inválido (12)';
        Exit;
      End;
      { Aplica os pesos para obter o 1º dígito }
      D1 := StrToInt(Copy(i2,1,1)) * 1 +
            StrToInt(Copy(i2,2,1)) * 3 +
            StrToInt(Copy(i2,3,1)) * 4 +
            StrToInt(Copy(i2,4,1)) * 5 +
            StrToInt(Copy(i2,5,1)) * 6 +
            StrToInt(Copy(i2,6,1)) * 7 +
            StrToInt(Copy(i2,7,1)) * 8 +
            StrToInt(Copy(i2,8,1)) * 10;
      i := Copy(IntToStr(D1 Mod 11),Length(IntToStr(D1 Mod 11)),1);
      If i <> Copy(i2,9,1) Then
      Begin
        Result[1] := '1º dígito inválido';
        Exit;
      End;
      { Aplica os pesos para obter o 2º dígito }
      D2 := StrToInt(Copy(i2,1,1)) * 3 +
            StrToInt(Copy(i2,2,1)) * 2 +
            StrToInt(Copy(i2,3,1)) * 10 +
            StrToInt(Copy(i2,4,1)) * 9 +
            StrToInt(Copy(i2,5,1)) * 8 +
            StrToInt(Copy(i2,6,1)) * 7 +
            StrToInt(Copy(i2,7,1)) * 6 +
            StrToInt(Copy(i2,8,1)) * 5 +
            StrToInt(Copy(i2,9,1)) * 4 +
            StrToInt(Copy(i2,10,1)) * 3 +
            StrToInt(Copy(i2,11,1)) * 2;
      i := Copy(IntToStr(D2 Mod 11),Length(IntToStr(D2 Mod 11)),1);
      If i <> Copy(i2,12,1) Then
      Begin
        Result[1] := '2º dígito inválido';
        Exit;
      End;
    End
    Else
    Begin
      { IE Inscrição estadual de Produtor Rural (Não equiparado a industrial ou comerciante, cujas inscrições obedecem a Regra descrita no item anterior) }
      If Length(i2) <> 13 Then
      Begin
        Result[1] := 'Tamanho inválido (13)';
        Exit;
      End;
      { Aplica os pesos para obter o 1º dígito }
      D1 := StrToInt(Copy(i2,2,1)) * 1 +
            StrToInt(Copy(i2,3,1)) * 3 +
            StrToInt(Copy(i2,4,1)) * 4 +
            StrToInt(Copy(i2,5,1)) * 5 +
            StrToInt(Copy(i2,6,1)) * 6 +
            StrToInt(Copy(i2,7,1)) * 7 +
            StrToInt(Copy(i2,8,1)) * 8 +
            StrToInt(Copy(i2,9,1)) * 10;
      i := Copy(IntToStr(D1 Mod 11),Length(IntToStr(D1 Mod 11)),1);
      If i <> Copy(i2,10,1) Then
      Begin
        Result[1] := '1º dígito inválido';
        Exit;
      End;
    End;
  End // SP
  Else If pUF = 'MG' Then // MINAS GERAIS
  Begin
    { remove caracteres inválidos }
    i2 := '';
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 13 Then
    Begin
      Result[1] := 'Tamanho inválido (13)';
      Exit;
    End;
    { Adiciona um 0 entre o 3º e o 4º dígitos }
    i2 := Copy(i2,1,3) + '0' + Copy(i2,4,10);
    { Aplica os pesos para obter o 1º dígito }
    i := IntToStr(StrToInt(Copy(i2,01,1)) * 1) +
         IntToStr(StrToInt(Copy(i2,02,1)) * 2) +
         IntToStr(StrToInt(Copy(i2,03,1)) * 1) +
         IntToStr(StrToInt(Copy(i2,04,1)) * 2) +
         IntToStr(StrToInt(Copy(i2,05,1)) * 1) +
         IntToStr(StrToInt(Copy(i2,06,1)) * 2) +
         IntToStr(StrToInt(Copy(i2,07,1)) * 1) +
         IntToStr(StrToInt(Copy(i2,08,1)) * 2) +
         IntToStr(StrToInt(Copy(i2,09,1)) * 1) +
         IntToStr(StrToInt(Copy(i2,10,1)) * 2) +
         IntToStr(StrToInt(Copy(i2,11,1)) * 1) +
         IntToStr(StrToInt(Copy(i2,12,1)) * 2);
    D1 := 0;
    For a := 1 To Length(i) Do D1 := D1 + StrToInt(Copy(i,a,1));
    D2 := D1;
    While D2 Mod 10 > 0 Do Inc(D2);
    i := IntToStr(D2 - D1);
    If i <> Copy(i2,13,1) Then
    Begin
      Result[1] := '1º dígito inválido';
      Exit;
    End;
    { Remove o 0 que foi acrescentado entre o 3º e o 4º dígitos }
    i2 := Copy(i2,1,3) + Copy(i2,5,10);
    { Aplica os pesos para obter o 2º dígito }
    D1 := StrToInt(Copy(i2,01,1)) * 03 +
          StrToInt(Copy(i2,02,1)) * 02 +
          StrToInt(Copy(i2,03,1)) * 11 +
          StrToInt(Copy(i2,04,1)) * 10 +
          StrToInt(Copy(i2,05,1)) * 09 +
          StrToInt(Copy(i2,06,1)) * 08 +
          StrToInt(Copy(i2,07,1)) * 07 +
          StrToInt(Copy(i2,08,1)) * 06 +
          StrToInt(Copy(i2,09,1)) * 05 +
          StrToInt(Copy(i2,10,1)) * 04 +
          StrToInt(Copy(i2,11,1)) * 03 +
          StrToInt(Copy(i2,12,1)) * 02;

    vResto := (D1 Mod 11);

    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,13,1) Then
    Begin
      Result[1] := '2º dígito inválido';
      Exit;
    End;
  End // MG
  Else If pUF = 'PR' Then
  Begin
    { remove caracteres inválidos }
    i2 := '';
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 10 Then
    Begin
      Result[1] := 'Tamanho inválido (10)';
      Exit;
    End;
    { Aplica os pesos para obter o 1º dígito }
    D1 := StrToInt(Copy(i2,01,1)) * 3 +
          StrToInt(Copy(i2,02,1)) * 2 +
          StrToInt(Copy(i2,03,1)) * 7 +
          StrToInt(Copy(i2,04,1)) * 6 +
          StrToInt(Copy(i2,05,1)) * 5 +
          StrToInt(Copy(i2,06,1)) * 4 +
          StrToInt(Copy(i2,07,1)) * 3 +
          StrToInt(Copy(i2,08,1)) * 2;
    i := IntToStr(11 - (D1 Mod 11));
    If (i = '10') Or (i = '11') Then i := '0';
    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := '1º dígito inválido';
      Exit;
    End;
    { Aplica os pesos para obter o 2º dígito }
    D2 := StrToInt(Copy(i2,01,1)) * 4 +
          StrToInt(Copy(i2,02,1)) * 3 +
          StrToInt(Copy(i2,03,1)) * 2 +
          StrToInt(Copy(i2,04,1)) * 7 +
          StrToInt(Copy(i2,05,1)) * 6 +
          StrToInt(Copy(i2,06,1)) * 5 +
          StrToInt(Copy(i2,07,1)) * 4 +
          StrToInt(Copy(i2,08,1)) * 3 +
          StrToInt(Copy(i2,09,1)) * 2;
    i := IntToStr(11 - (D2 Mod 11));
    If (i = '10') Or (i = '11') Then i := '0';
    If i <> Copy(i2,10,1) Then
    Begin
      Result[1] := '2º dígito inválido';
      Exit;
    End;
  End // PR
  Else If pUF = 'BA' Then // BAHIA
  Begin
    { remove caracteres inválidos }
    i2 := '';
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 8 Then
    Begin
      Result[1] := 'Tamanho inválido (8)';
      Exit;
    End;
    { Aplica os pesos para obter o 1º dígito }
    D1 := StrToInt(Copy(i2,01,1)) * 7 +
          StrToInt(Copy(i2,02,1)) * 6 +
          StrToInt(Copy(i2,03,1)) * 5 +
          StrToInt(Copy(i2,04,1)) * 4 +
          StrToInt(Copy(i2,05,1)) * 3 +
          StrToInt(Copy(i2,06,1)) * 2;
    If Pos(Copy(i2,1,1), '0123458') > 0 Then
      i := IntToStr(10 - (D1 Mod 10))
    Else
      i := IntToStr(11 - (D1 Mod 11));
    If StrToInt(i) >= 10 Then i := '0';
//    If i = '10' Then i := '0';
//    If i = '0' Then i := '0';
    If i <> Copy(i2,8,1) Then
    Begin
      Result[1] := '1º dígito inválido';
      Exit;
    End;
    { Aplica os pesos para obter o 2º dígito }
    D1 := StrToInt(Copy(i2,01,1)) * 8 +
          StrToInt(Copy(i2,02,1)) * 7 +
          StrToInt(Copy(i2,03,1)) * 6 +
          StrToInt(Copy(i2,04,1)) * 5 +
          StrToInt(Copy(i2,05,1)) * 4 +
          StrToInt(Copy(i2,06,1)) * 3 +
          StrToInt(Copy(i2,08,1)) * 2;
    If Pos(Copy(i2,1,1), '0123458') > 0 Then
      i := IntToStr(10 - (D1 Mod 10))
    Else
      i := IntToStr(11 - (D1 Mod 11));
    If StrToInt(i) >= 10 Then i := '0';
//    If i = '10' Then i := '0';
//    If (i = '0') or (i = '1') Then i := '0';
    If i <> Copy(i2,7,1) Then
    Begin
      Result[1] := '2º dígito inválido';
      Exit;
    End;
  End // PR
  else If pUF = 'AC' Then
  Begin
    { remove caracteres inválidos }
    vdig := '23456789';
    i2 := '';
    D1 := 0;
    D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 13 Then
    Begin
      Result[1] := 'Tamanho inválido (12)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '01') then { os primeiros 2 digitos são sempre 01 }
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;
    { Calculo do 1º Digito }
    vPeso := 1;
    For a := Length(i2)-2 downto 1 do
    begin
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vdig[vPeso]) ;
      Inc(vPeso);
      If vPeso > 8 then vpeso := 1;
    end;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,12,1) Then
    Begin
      Result[1] := '1º Dígito inválido';
      Exit;
    End;
    { Calculo do 2º Digito }
    vPeso := 1;
    For a := Length(i2)-1 downto 1 do
    begin
      D2 := D2 + StrToInt(i2[a]) * StrToInt(vdig[vPeso]) ;
      Inc(vPeso);
      If vPeso > 8 then vpeso := 1;
    end;

    vResto := (D2 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,13,1) Then
    Begin
      Result[1] := '2º Dígito inválido';
      Exit;
    End;

  End // AC
  Else If pUF = 'AL' Then
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '24') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    D1 := D1 * 10; // Produto

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto = 10, 0, IntToStr(vResto));

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // AL
  Else If pUF = 'AM' Then { Amazonia }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    If D1 < 11 then
      //vResto := 11 - D1
    else
    begin
      vResto := (D1 Mod 11); // resto
      i := Iif(vResto < 2, 0, IntToStr(11 - vResto));
    end;

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // AM
  Else If pUF = 'AP' Then { Amapa }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    //D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '03') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    vnumero := StrToInt(Copy(i2,1,8));
    If (vnumero >= 3000001) and (vnumero <= 3017000) then
    begin
      vpeso := 5;
      vdig  := '0'
    end
    else
    If (vnumero >= 3017001) and (vnumero <= 3019022) then
    begin
      vpeso := 9;
      vdig  := '1'
    end
    else
    If (vnumero >= 3019023) then
    begin
      vpeso := 0;
      vdig  := '0'
    end;
    D1 := vpeso;
    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto

    i := IntToStr(11 - vResto);

    If i = '10' then
      i := '0'
    else If i = '11' then
      i := vdig;

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // AP
  Else If (pUF = 'CE') or (pUF = 'PB') or (pUF = 'SE')  Then { Ceara , Pernambuco, Sergipe }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto

    D2 := 11 - vResto;

    If D2 > 9 then
      i := '0'
    else
      i := IntToStr(D2);

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // CE
  Else If pUF = 'DF' Then { Distrito federal }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 13 Then
    Begin
      Result[1] := 'Tamanho inválido (13)';
      Exit;
    End;

    If (Copy(i2,1,3) <> '073') and (Copy(i2,1,3) <> '074') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    vdig := '43298765432';

    For a := 1 to Length(i2)-2 do
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vdig[a]) ;

    vResto := (D1 Mod 11); // resto

    i := IIf(vResto < 2, 0, 11 - vResto);

    If i <> Copy(i2,12,1) Then
    Begin
      Result[1] := '1º dígito inválido';
      Exit;
    End;

    vdig := '543298765432';
    D1   := 0; 
    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vdig[a]) ;

    vResto := (D1 Mod 11); // resto

    i := IIf(vResto < 2, 0, 11 - vResto);

    If i <> Copy(i2,13,1) Then
    Begin
      Result[1] := '2º dígito inválido';
      Exit;
    End;
  End // DF
  else If pUF = 'ES' Then { Espirito Santo }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // ES
  else If pUF = 'GO' Then { Goiás }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '10') and (Copy(i2,1,2) <> '11') and (Copy(i2,1,2) <> '15')then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    If vResto = 0 then
      i := '0'
    else
    If vResto = 1 then
    begin
      vnumero := StrToInt(Copy(i2,1,8));
      i := IIf((vnumero >= 10103105) and (vnumero <= 10119997),'1','0');
    end
    else
      i := IntToStr(11 - vResto);

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // GO
  else If pUF = 'MA' Then { Maranhão }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '12') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // MA
  else If pUF = 'MT' Then { Mato grosso }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);

    i2 := StrZero(StrToInt(i2),11); // completa com zeros a esquerda.

    If Length(i2) <> 11 Then
    Begin
      Result[1] := 'Tamanho inválido (11)';
      Exit;
    End;

    vdig := '3298765432';
    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vdig[a]) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,11,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // MT
  else If pUF = 'MS' Then { Mato Grosso do Sul }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '28') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // MS
  else If pUF = 'PA' Then { Pará }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '15') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // PA
  Else If pUF = 'PE' Then { Pernanbuco }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 14 Then
    Begin
      Result[1] := 'Tamanho inválido (14)';
      Exit;
    End;

    vdig := '5432198765432';
    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vDig[a]) ;

    vResto := (D1 Mod 11); // resto

    D2 := 11 - vResto;

    If D2 > 9 then
      i := IntToStr(D2 - 10)
    else
      i := IntToStr(D2);

    If i <> Copy(i2,14,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // PE
  else If pUF = 'PI' Then { Piauí }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // PI
  else If pUF = 'RJ' Then { Rio de Janeiro }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 8 Then
    Begin
      Result[1] := 'Tamanho inválido (8)';
      Exit;
    End;

    vdig := '2765432';
    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vDig[a]) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,8,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // RJ
  else If pUF = 'RN' Then { Rio Grande do Norte }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '20') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    D1 := D1 * 10; //Produto
    vResto := (D1 Mod 11); // resto
    i := Iif(vResto > 9, 0, vResto);

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // RN
  else If pUF = 'RO' Then { Rondônia }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 14 Then
    Begin
      Result[1] := 'Tamanho inválido (14)';
      Exit;
    End;

    vdig := '23456789';

    { Calculo do 1º Digito }
    vPeso := 1;
    For a := Length(i2)-1 downto 1 do
    begin
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vdig[vPeso]) ;
      Inc(vPeso);
      If vPeso > 8 then vpeso := 1;
    end;

    vResto := (D1 Mod 11); // resto
    D2 := 11 - vResto;
    i := Iif(D2 > 9, D2 -10, D2);

    If i <> Copy(i2,14,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // RO
  else If pUF = 'RR' Then { Roraima }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    If (Copy(i2,1,2) <> '24') then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * a ; 

    vResto := (D1 Mod 9); // resto
    i := IntToStr(vResto);

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // RR
  else If pUF = 'RS' Then { Rio Grando do Sul }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 10 Then
    Begin
      Result[1] := 'Tamanho inválido (10)';
      Exit;
    End;
    vnumero := StrToInt(Copy(i2,1,3));
    If (vnumero < 0) and (vnumero > 467) then
    Begin
      Result[1] := 'Inscrição inválida para este estado';
      Exit;
    End;

    vdig := '298765432';
    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * StrToInt(vDig[a]) ;

    vResto := (D1 Mod 11); // resto
    D2 := 11 - vResto;

    If D2 > 9 then
      i := '0'
    else
      i := IntToStr(D2);

    If i <> Copy(i2,10,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // RS
  else If pUF = 'SC' Then { Santa Catarina }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0; //D2 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If Length(i2) <> 9 Then
    Begin
      Result[1] := 'Tamanho inválido (9)';
      Exit;
    End;

    For a := 1 to Length(i2)-1 do
      D1 := D1 + StrToInt(i2[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2,9,1) Then
    Begin
      Result[1] := 'Dígito inválido';
      Exit;
    End;
  End // SC
  else If pUF = 'TO' Then { ***  T O C A N T I N S  *** }
  Begin
    { remove caracteres inválidos }
    i2 := '';
    D1 := 0;
    For a := 1 To Length(i) Do If (Copy(i,a,1) >= '0') And (Copy(i,a,1) <= '9') Then i2 := i2 + Copy(i,a,1);
    If (Length(i2) <> 11) And (Length(i2) <> 9) Then // Aceita 11 ou 9 dígitos
    Begin
      Result[1] := 'Tamanho inválido. Deve ter 11 ou 9 dígitos.';
      Exit;
    End;

    { Ajusta a máscara }
    If Length(i2) = 11 Then
        vMask := '99.99.999.999-9'
    Else
        vMask := '99.999.999-9';
    Result[2] := vMask;

    If (Length(i2) = 11) And (Pos(Copy(i2,3,2),'01_02_03_99') = 0) then
    Begin
      Result[1] := 'Inscrição de 11 dígitos inválida para este estado.';
      Exit;
    End;

    If Length(i2) = 11 Then
      vDig := Copy(i2,1,2) + Copy(i2,5,length(i2))
    Else
      vDig := i2; // Para 9 dígitos

    For a := 1 to Length(vDig)-1 do
      D1 := D1 + StrToInt(vDig[a]) * (10 - a) ;

    vResto := (D1 Mod 11); // resto
    i := Iif(vResto < 2, 0, IntToStr(11 - vResto));

    If i <> Copy(i2, Length(i2), 1) Then
    Begin
      Result[1] := 'Dígito inválido.';
      Exit;
    End;

  End // TO
  else
  Begin
    Result[1] := 'Estado inválido';
  End;
End;

{ Adiciona a string à variável e devolvendo o string atualizada }
Function Concatena(Var pString1 : String; pString2 : String) : String;
Begin
  pString1 := pString1 + pString2; // Modifica diretamente a string
  Result := pString1;
End;

{ Elimina da string o caracter Ch }
function NoChar( S: String ; Ch : Char ) : String ;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length( S ) do
  begin
    if ( S[i] <> Ch ) then
      Result := Result + S[i];
  end;
end ;

Function TrazProximoCodLanca : Integer;
var vQryConfS : tQuery;
begin
  With qrPesqAux Do
  begin
    { Encontra o ultimo codlanca }
    Close;
    Sql.Clear;
    Sql.Add('SELECT SQCTBLANCA.NEXTVAL -1 AS CODLANCA FROM DUAL');
    Open;

    vQryConfS := tQuery.Create(Application);
    vQryConfS.DatabaseName := cDatabaseName;
    vQryConfS.Sql.Add('SELECT MAX(CODLANCA) CODLANCA FROM CTBLANCA');
    vQryConfS.Open;
    
          { Sequence < Max(CodLanca) }
    While FieldByName('CODLANCA').asInteger < vQryConfS.FieldByName('CODLANCA').asInteger do
    begin
      Close;
      Open;
    end;
    vQryConfS.Close;
    vQryConfS.Free;
    If IsEmpty Then
      Result :=  1
    else
      Result := FieldByName('CodLanca').asInteger + 1;
  end;
end;

Function RemoveAcentos(str: String ): String;
var i :integer;

//Aå Oƒ
//Aæ EÆ O® UØ
//AÅ
//[_Aª_aª_Oº_oº]

Const ComAcento = 'àèìòùâêîôûãõñáéíóúýçäëïöüÿÀÈÌÒÙÂÊÎÔÛÃÕÑÁÉÍÓÚÝÇÄËÏÖÜæÆåÅ';
      SemAcento = 'aeiouaeiouaonaeiouycaeiouyAEIOUAEIOUAONAEIOUYCAEIOUaAaA';

Begin
  For i := 1 to Length(Str) do
  Begin
    if Pos(Str[i],ComAcento)<>0 Then
      Str[i] := SemAcento[Pos(Str[i],ComAcento)];
  end;
  Result := Str;
end;


Function RemoveCaractersDiferentedeAlfa(str: String ): String;
var i :integer;
begin
 For i := 1 to Length (str) do
   If Not (str[i] in ['a'..'z', 'A'..'Z']) then
     str[i] := ' ';
  Result := str;
end;

//Function TrazDadosDaEmpresa(PEmpresa, Pfilial : Integer) : TInscricao;
Function TrazDadosDaEmpresa(PEmpresa, Pfilial : Integer) : TDadosDaEmpresa;
begin
  With qrPesqAux do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT A.RSOCIALEMPRESA, A.INSCRICAOEMPRESA, A.NOMEFANTASIAEMPRESA, A.TIPOINSCRICAOEMPAUT, ' );
    sql.Add('UF.CODIGOUF, UF.DESCRICAOUF, CODIGOEMPRESA, CODIGOFL, IESTADUALFL, ENDERECOFL, NUMEROENDFL, ');
    sql.Add('COMPLENDFL, CEPFL, FONEFL, FAXFL, HOMEPAGEFL, EMAILFL, MATRIZFL, CIDADEFL, BAIRROFL, '       );
    sql.Add('INSCMUNICIPALFL, BANCO_FAT, AGENCIA_FAT, CONTA_FAT, ICMS_P_FISICA, INATIVAFL '               );
    sql.Add('FROM CTR_FILIAL F, BGM_CADUF UF, CTR_EMPAUTORIZADAS A '                                      );
    sql.Add('WHERE CODIGOFL = :P_FILIAL AND CODIGOEMPRESA = :P_EMPRESA AND UF.CODIGOUF = F.CODIGOUF AND ' );
    sql.Add('A.CODINTEMPAUT = F.CODINTEMPAUT '                                                            );

    ParamByName('P_Empresa').AsInteger := pEmpresa;
    ParamByName('P_Filial' ).AsInteger := pFilial;
    open;
    Result.Inscricoes.Tipo           := Trim(FieldByName('TIPOINSCRICAOEMPAUT').AsString);
    Result.Inscricoes.CNPJ_CPF       := FormataCNPJCPF(Trim(FieldByName('INSCRICAOEMPRESA').AsString),Trim(FieldByName('TIPOINSCRICAOEMPAUT').AsString));
    Result.RazaoSocial               := Trim(FieldByName('RSOCIALEMPRESA'     ).AsString);
    Result.NomeFantasia              := Trim(FieldByName('NOMEFANTASIAEMPRESA').AsString);
    Result.Inscricoes.Municipal      := Trim(FieldByName('INSCMUNICIPALFL').AsString);
    Result.Inscricoes.Estadual       := Trim(FieldByName('IESTADUALFL'    ).AsString);
    Result.Endereco.Endereco         := Trim(FieldByName('ENDERECOFL'     ).AsString);
    Result.Endereco.Numero           := Trim(FieldByName('NUMEROENDFL'    ).AsString);
    Result.Endereco.Complemento      := Trim(FieldByName('COMPLENDFL'     ).AsString);
    Result.Endereco.Bairro           := Trim(FieldByName('BAIRROFL'       ).AsString);
    Result.Endereco.Cidade           := Trim(FieldByName('CIDADEFL'       ).AsString);
    Result.Endereco.CEP              := Trim(FieldByName('CEPFL'          ).AsString);
    Result.Endereco.Estado.UF        := Trim(FieldByName('CODIGOUF'       ).AsString);
    Result.Endereco.Estado.Descricao := Trim(FieldByName('DESCRICAOUF'    ).AsString);
    Result.Telefone                  := Trim(FieldByName('FONEFL'         ).AsString);
    Result.Fax                       := Trim(FieldByName('FAXFL'          ).AsString);
    Result.HomePage                  := Trim(FieldByName('HOMEPAGEFL'     ).AsString);
    Result.Email                     := Trim(FieldByName('EMAILFL'        ).AsString);
    Result.PessoaFisica              := Trim(FieldByName('ICMS_P_FISICA'  ).AsString);
    Result.Inativa                   := Trim(FieldByName('INATIVAFL'      ).AsString);
    Result.Matriz                    := Trim(FieldByName('MATRIZFL'       ).AsString);
    Result.Bancario.Banco            := FieldByName('BANCO_FAT'           ).AsInteger;
    Result.Bancario.Agencia          := FieldByName('AGENCIA_FAT'         ).AsInteger;
    Result.Bancario.Conta            := Trim(FieldByName('CONTA_FAT'      ).AsString);
  end;
end;

Function Traco(pQtde : Integer; pCharCompl : Char = '-'; pCharIniFin : Char = '+') : String;
Var vIniFin : String;
begin
{ Devolve uma string com caracteres "c" ou '-'
  Se nao for passado o parametro de quantidade,
  utiliza a variavel RelWid. O "t" e' o caractere
  utilizado no inicio e final da string.
  Exemplo - > Traco(80,'-','|') }

  If Trim(pcharIniFin) = '' then
    vIniFin := pCharCompl
  else
    vIniFin := pCharIniFin;

  Result := vIniFin + Replicate(pCharCompl, pQtde - 2) + vIniFin;
end;

Function TrocaCaracteres(pCharSubt, pCharTroca : Char; str: String ): String;
var i :integer;
begin
 For i := 1 to Length (str) do
   If str[i] = pCharsubt then
     str[i] := pCharTroca;
  Result := str;
end;

Function PesquisaArquivoHelp : String; { pesquisa se existe o arquivo de help para colocar na barra de status o F1 }
Var
  vNomeArquivoCompleto,
  vNomeArquivo : String;
Begin
  vNomeArquivoCompleto := ExtractFileName(Application.ExeName);
//  vNomeArquivo         := Application.Title; // Copy(vNomeArquivoCompleto,1,Pos('.',vNomeArquivoCompleto)-1);
  vNomeArquivo         := Copy(vNomeArquivoCompleto,1,Pos('.',vNomeArquivoCompleto)-1);
  If FileExists( vNomeArquivo + '.HLP') Then
  Begin
    Result := 'F1-Ajuda ';
    Application.HelpFile := vNomeArquivo + '.HLP';
  End
  else
  Begin
    Result := '';
    Application.HelpFile := '';
  End;
End;

Function ValidacaoGeral_PE(pTipoVal : String; pCodBanco : String = ''; pEmpresa : Integer = 1; pFilial : Integer = 1;pSistema : String = 'CPG') : Boolean;
Var qry : TQuery;
    // i : Integer;
    // vEmpBCO,
    vBancosDisp : String;
Begin
  (*
    Passa a não mais importar as empresas. Apenas o Banco - 30/09/2004 - Verônica
  *)

  { pTipoVal - Tipo de validação:
    1 : Menu Principal - OnShow
    2 : Botão Pagamento Eletrônico - tela de Inclusão e Alteração
    3 : Exit do Campo Banco - Tela de Definição de Pagamento Eletrônico
  }

  { Empresas:
              0001 - Reunidas
              0014 - Breda
              0015 - Catarinense
              0019 - Maringá
              0023 - Farol da Barra
              0034 - Capital do Vale
              0043 - DelRey
              0068 - VBTU
              0081 - 1001
              0112 - Cajumar
              0114 - Passaredo
              0122 - Santa Paula
              0123 - Transvec
              0129 - Brasil Sul
              0130 - VIPE
              0132 - TransMarcos
              0140 - Moratense
              9999 - BGM
  }

  { Bancos:
            001 - Banco do Brasil
            033 - BANESPA
            237 - Bradesco,
            356 - Real
            341 - Itau
            399 - HSBC
            409 - Unibanco
            422 - Safra
            041 - BanriSul
            389 - Mercantil
  }

(*  Comenstado em 30/09/2004 - Verônica
   Concatenação das empresas e bancos autorizados
             { EMP/BCO_ EMP/BCO_ EMP/BCO_ EMP/BCO_ EMP/BCO_ EMP/BCO_ EMP/BCO_}
  vEmpBco := '0001/001_0001/399_0014/237_0014/422_0034/356_0015/399_0019/237_'+
             '0023/237_0030/033_0030/237_0030/001_0034/365_0043/237_0043/033_'+
             '0068/237_0081/399_0112/237_0114/422_0123/341_0129/237_0130/237_'+
             '0132/237_0140/033_0140/237_0122/237_';
*)

  Result := True;
  vBancosDisp := cBCO_Brasil    + '_' + cBCO_Banespa   + '_'
               + cBCO_Bradesco  + '_' + cBCO_Real      + '_'
               + cBCO_Itau      + '_' + cBCO_HSBC      + '_'
               + cBCO_Unibanco  + '_' + cBCO_Safra     + '_'
               + cBCO_BanriSul  + '_' + cBCO_Mercantil;

(* Comenstado em 30/09/2004 - Verônica
  If pTipoVal = '1' then // Menu principal - Desativa para as empresas NÃO autorizadas.
  begin
    if (frmMenuPrincipal.vCodigoCliente <> 0001) and { Reunidas }
       (frmMenuPrincipal.vCodigoCliente <> 0014) and { Breda }
       (frmMenuPrincipal.vCodigoCliente <> 0015) and { Catarinense }
       (frmMenuPrincipal.vCodigoCliente <> 0019) and { Maringá }
       (frmMenuPrincipal.vCodigoCliente <> 0023) and { Farol da Barra }
       (frmMenuPrincipal.vCodigoCliente <> 0034) and { Capital do Vale }
       (frmMenuPrincipal.vCodigoCliente <> 0043) and { DelRey - Moratense }
       (frmMenuPrincipal.vCodigoCliente <> 0068) and { VBTU }
       (frmMenuPrincipal.vCodigoCliente <> 0081) and { 1001 }
       (frmMenuPrincipal.vCodigoCliente <> 0112) and { Cajumar }
       (frmMenuPrincipal.vCodigoCliente <> 0114) and { Passaredo }
       (frmMenuPrincipal.vCodigoCliente <> 0122) and { Santa Paula }
       (frmMenuPrincipal.vCodigoCliente <> 0123) and { Transvec }
       (frmMenuPrincipal.vCodigoCliente <> 0129) and { Brasil Sul }
       (frmMenuPrincipal.vCodigoCliente <> 0130) and { Vipe }
       (frmMenuPrincipal.vCodigoCliente <> 0132) and { Transmarcos }
       (frmMenuPrincipal.vCodigoCliente <> 0140) and { Moratense }
       (frmMenuPrincipal.vCodigoCliente <> 9999) then { BGM }
      For i := 0 to 3 do
      begin
        frmMenuPrincipal.MainMenu1.Items[2].Items[7].Items[i].Enabled := False;
      end;
    Exit;
  end;
*)

  If pTipoVal = '2' then // Botão PE na inclusão e na alteração
  begin
    (* Comenstado em 30/09/2004 - Verônica
    Verificava se a empresa tinha direito a pagamento eletronico
    If Pos(StrZero(frmMenuPrincipal.vCodigoCliente, 4), '0001_0014_0015_0019_0023_0034_0043_0068_0081_0112_0114_0122_0123_0129_0130_0132_0140_9999') = 0 then
    begin
      MensagemDlg('Pagamento eletrônico não disponível para a empresa.', mtErro, mbOk);
      Result := False;
      Exit;
    end;
    *)
    { Verifica se existe Pagamento eletronico para o banco }  
    qry := TQuery.Create(Application);
    qry.DatabaseName := cDatabaseName;
    With Qry do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT COUNT(*) Qtd FROM bcoBanco B ,BCOCONTA C    ');
      sql.Add('WHERE NROBANCO IN (' + StringReplace(vBancosDisp,'_',',',[rfReplaceAll, rfIgnoreCase]) + ') AND ');
      sql.Add('      CODIGOEMPRESA = :P0 AND ');
      sql.Add('      B.CODBANCO = C.CODBANCO ');
      Params[0].AsInteger := pEmpresa;
      Open;
      If FieldByName('Qtd').AsInteger = 0 Then
      begin
        Result := False;
        MensagemDlg('Pagamento eletrônico não disponível (bancos).', mtErro, mbOk);
      end;
      Close;
      Free;
      Exit;
    end; // With
  end; // If

  If pTipoVal = '3' then // Código do banco na tela de definição
  begin
    qry := TQuery.Create(Application);
    qry.DatabaseName := cDatabaseName;
    With Qry do
    Begin
      Close;
      SQL.Clear;
      SQL.Add( 'SELECT NROBANCO'       );
      SQL.Add( ' FROM BCOBANCO'        );
      SQL.Add( ' WHERE CODBANCO = :P0' );
      params[0].AsString := pCodBanco;
      Open;
      If Pos(StrZero(FieldByName( 'NROBANCO' ).AsInteger,3,0), vBancosDisp) = 0 Then
      Begin
        Result := False;
        MensagemDlg(IIF(pSistema = 'BCO','Importação','Pagamento eletrônico') +
                   ' não disponível para o banco '
                   + pCodBanco + ' (Nº oficial = ' + FieldByName( 'NROBANCO' ).AsString + ').', mtErro, mbOk);
      End;
      Close;
      Free;
      Exit;
    End;
  end;
End; // ValidacaoGeral_PE

Function TrataEComercial( pString : String ):String;
Begin
  Result := StringReplace( pString, '&', 'E', [rfReplaceAll, rfIgnoreCase] );
end;

Function TrazProximoCodMovto : Integer;
var vQryConfS : tQuery;
begin
  With qrPesqAux Do
  begin
    { Encontra o ultimo codmovto }
    Close;
    Sql.Clear;
    Sql.Add('SELECT sqBCOMOVTO.NEXTVAL -1 AS CODMOVTO FROM DUAL');
    Open;

    vQryConfS := tQuery.Create(Application);
    vQryConfS.DatabaseName := cDatabaseName;
    vQryConfS.Sql.Add('SELECT MAX(CODMOVTOBCO) CODMOVTO FROM BCOMOVTO');
    vQryConfS.Open;

          { Sequence < Max(CodMovto) }
    While FieldByName('CODMOVTO').asInteger < vQryConfS.FieldByName('CODMOVTO').asInteger do
    begin
      Close;
      Open;
    end;
    
    vQryConfS.Close;
    vQryConfS.Free;
    If IsEmpty Then
      Result :=  1
    else
      Result := FieldByName('CodMovto').asInteger + 1;
  end;
end;

Function MesEmPortugues( pString : String ):String;
const vMesPortugues  : Array[0..11] of String =  ('JANEIRO','FEVEREIRO','MARCO','ABRIL','MAIO','JUNHO','JULHO','AGOSTO','SETEMBRO','OUTUBRO','NOVEMBRO','DEZEMBRO');
      vMesIngles     : Array[0..11] of String =  ('JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER');
var  i : Integer;
     vAux : String;
Begin
  vAux := '';
  For i := 0 to 11 do
  begin
    If vMesIngles[i] = pString then
      vAux := StringReplace( pString, vMesIngles[i], vMesPortugues[i], [rfReplaceAll, rfIgnoreCase] );
  end;
  If vAux <> '' then
    Result := vAux
  else
    Result := pString;
end;

Function FormataClassFisc(pCodClass : String; pCFOPAcordo : Boolean = True) : String;
begin
  If vTamCFOP < Length(pCodClass) then
    vTamCFOP := Length(pCodClass);

  If Length(pCodClass) = 3 then
    result := copy(pCodClass,1,1) + '.' + copy(pCodClass,2,2)
  else
  begin
    If pCFOPAcordo then
      result := copy(pCodClass,1,1) + '.' + copy(pCodClass,2,Length(pCodClass))
    else
      result := copy(pCodClass,1,1) + '.' + copy(pCodClass,2,2) + '.' + copy(pCodClass,4,Length(pCodClass));
  end;
end;

function VerificaGrupoDeNatureza( pGNatureza, pConta: String ): Boolean;
Var
  i, vPos, vPosIni    : Integer ;
begin
  result  := false;
  vPosIni := 1;
//  vPos    := 0 ;
  If Trim(pGNatureza) = '' then exit;
  For i := 1 To Length(pGNatureza) Do
  Begin
    If Copy(pGNatureza,i,1) = ',' then
    begin
      vPos := (i - vPosIni) ;
      If Copy(pGNatureza,vPosIni,vPos) = Copy(pConta,1,vPos) then
      begin
        result := true;
        exit;
      end;
      vPosIni := i+1;
    end;
  End;
//  vPos := Length(pGNatureza) - (vPos + 1) ;
  If Copy(pGNatureza, vPosIni, Length(pGNatureza)) = Copy(pConta, 1, length(Copy(pGNatureza,vPosIni,Length(pGNatureza)))) then
    result := true;
end;

Procedure ValidaObjetosPorFaixa(vForm : TForm; Sender : TObject);
var
  vVerNome : String;
begin
  vVerNome := '';

  If Pos('FIN',UpperCase(TComponent(Sender).Name)) <> 0 Then
    vVerNome := 'FIN'
  Else If Pos('FIM',UpperCase(TComponent(Sender).Name)) <> 0 Then
    vVerNome := 'FIM';

  If Sender is TNumEdit Then
  begin
    If TNumEdit(Sender).Value <= 0 Then
      TNumEdit(Sender).Value := IIf(UpperCase(Copy(TNumEdit(Sender).Name,Pos('INI',UpperCase(TNumEdit(Sender).Name)),Length(TNumEdit(Sender).Name))) = 'INI',TNumEdit(Sender).MinValue,TNumEdit(Sender).MaxValue);
    Try
      If (UpperCase(Copy(TNumEdit(Sender).Name,Pos(vVerNome,UpperCase(TNumEdit(Sender).Name)),Length(TNumEdit(Sender).Name))) = vVerNome) and
         ((TNumEdit(Sender).Value) < (TNumEdit(vForm.FindComponent(Copy(UpperCase(TNumEdit(Sender).Name),1,Pos(vVerNome,UpperCase(TNumEdit(Sender).Name))-1)+'Ini')).Value))
          Then
      begin
        MensagemDlg(IIf(Trim(TNumEdit(Sender).Hint) = '','Campo final menor que campo inicial.',TNumEdit(Sender).Hint),mtInformacao,mbOK);
        TNumEdit(Sender).Clear;
        TNumEdit(Sender).SetFocus;
      end;
    Except
    End;
  end

  Else If Sender is TEdit Then
  begin
    If Trim(TEdit(Sender).Text) = '' Then
    begin
      If UpperCase(Copy(UpperCase(TEdit(Sender).Name),Pos('INI',UpperCase(TEdit(Sender).Name)),Length(TEdit(Sender).Name))) = 'INI' Then
        TEdit(Sender).Text := Replicate(' ',TEdit(Sender).MaxLength - 1) + '!'
      Else
        TEdit(Sender).Text := Replicate('z',TEdit(Sender).MaxLength);
    end
    Else
    begin
      if Trim(EliminaNaoNumericos(TEdit(Sender).Text)) = Trim(TEdit(Sender).Text) then
        Try
          TEdit(Sender).Text := StrZero(StrToFloat(Trim(TEdit(Sender).Text)),TEdit(Sender).MaxLength,0);
        Except
        End;
    end;
    Try
      If (UpperCase(Copy(TEdit(Sender).Name,Pos(vVerNome,UpperCase(TEdit(Sender).Name)),Length(TEdit(Sender).Name))) = vVerNome) and
         ((Trim(TEdit(Sender).Text) < Trim(TEdit(vForm.FindComponent(UpperCase(Copy(TEdit(Sender).Name,1,Pos(vVerNome,UpperCase(TEdit(Sender).Name))-1)+'Ini'))).Text)) or
         (StrToFloat(Trim(TEdit(Sender).Text)) < StrToFloat(Trim(TEdit(vForm.FindComponent(UpperCase(Copy(TEdit(Sender).Name,1,Pos(vVerNome,UpperCase(TEdit(Sender).Name))-1)+'Ini'))).Text)))) Then
        begin
          MensagemDlg(IIf(Trim(TEdit(Sender).Hint) = '','Campo final menor que campo inicial.',TEdit(Sender).Hint),mtInformacao,mbOK);
          TEdit(Sender).Clear;
          TEdit(Sender).SetFocus;
        end;
    Except
    End;
  end // If Sender is TEdit Then

  Else If Sender is TMaskEdit Then
  begin
    If Trim(TMaskEdit(Sender).Text) = '' Then
    begin
      If UpperCase(Copy(UpperCase(TMaskEdit(Sender).Name),Pos('INI',UpperCase(TMaskEdit(Sender).Name)),Length(TMaskEdit(Sender).Name))) = 'INI' Then
        TMaskEdit(Sender).Text := Replicate(VarToStr(IIf(Copy(TMaskEdit(Sender).EditMask,1,1) = '9','0',' '))[1],TMaskEdit(Sender).MaxLength - 1) + IIf(Copy(TMaskEdit(Sender).EditMask,1,1) = '9','1','!')
      Else
        TMaskEdit(Sender).Text := Replicate(VarToStr(IIf(Copy(TMaskEdit(Sender).EditMask,1,1) = '9','9','z'))[1],TMaskEdit(Sender).MaxLength);
    end
    Else
      Try
        If TMaskEdit(Sender).EditMask <> '' Then
          if Trim(EliminaNaoNumericos(TMaskEdit(Sender).Text)) = Trim(TMaskEdit(Sender).Text) then
            TMaskEdit(Sender).Text := StrZero(StrToFloat(Trim(TMaskEdit(Sender).Text)),TMaskEdit(Sender).MaxLength,0);
      Except
      End;

    Try
      If (UpperCase(Copy(TMaskEdit(Sender).Name,Pos(vVerNome,UpperCase(TMaskEdit(Sender).Name)),Length(TMaskEdit(Sender).Name))) = vVerNome) and
         ((Trim(TMaskEdit(Sender).Text) < Trim(TMaskEdit(vForm.FindComponent(UpperCase(Copy(TMaskEdit(Sender).Name,1,Pos(vVerNome,UpperCase(TMaskEdit(Sender).Name))-1)+'Ini'))).Text)) or
         (StrToFloat(Trim(TMaskEdit(Sender).Text)) < StrToFloat(Trim(TMaskEdit(vForm.FindComponent(UpperCase(Copy(TMaskEdit(Sender).Name,1,Pos(vVerNome,UpperCase(TMaskEdit(Sender).Name))-1)+'Ini'))).Text)))) Then
        begin
          MensagemDlg(IIf(Trim(TMaskEdit(Sender).Hint) = '','Campo final menor que campo inicial.',TMaskEdit(Sender).Hint),mtInformacao,mbOK);
          TMaskEdit(Sender).Clear;
          TMaskEdit(Sender).SetFocus;
        end;
    Except
    End;
  end // If Sender is TMaskEdit Then

  Else If (Sender is TBGMPedeEmpresa) or (Sender is TBGMPedeFilialGaragem) Then
  begin
    If (Sender is TBGMPedeEmpresa) and
         ((UpperCase(Copy(TBGMPedeEmpresa(Sender).Name,Pos(vVerNome,UpperCase(TBGMPedeEmpresa(Sender).Name)),Length(TBGMPedeEmpresa(Sender).Name))) = vVerNome) and
         (TBGMPedeEmpresa(Sender).CodigoEmpresa < TBGMPedeEmpresa(vForm.FindComponent(UpperCase(Copy(TBGMPedeEmpresa(Sender).Name,1,Pos(vVerNome,UpperCase(TBGMPedeEmpresa(Sender).Name))-1)+'Ini'))).CodigoEmpresa))
    Or (Sender is TBGMPedeFilialGaragem) and
         ((UpperCase(Copy(TBGMPedeFilialGaragem(Sender).Name,Pos(vVerNome,UpperCase(TBGMPedeFilialGaragem(Sender).Name)),Length(TBGMPedeFilialGaragem(Sender).Name))) = vVerNome) and
         (TBGMPedeFilialGaragem(Sender).CodigoFG < TBGMPedeFilialGaragem(vForm.FindComponent(UpperCase(Copy(TBGMPedeFilialGaragem(Sender).Name,1,Pos(vVerNome,UpperCase(TBGMPedeFilialGaragem(Sender).Name))-1)+'Ini'))).CodigoFG)) Then
    begin
      MensagemDlg(IIf(Trim(TCustomComboBox(Sender).Hint) = '','Campo final menor que campo inicial.',TCustomComboBox(Sender).Hint),mtInformacao,mbOK);
      TCustomComboBox(Sender).SetFocus;
    end;
  end // If (Sender is TBGMPedeEmpresa) or (Sender is TBGMPedeFilialGaragem) Then

  Else If Sender is TDateEdit Then
  begin
    If Trim(TDateEdit(Sender).Text) = '/  /' Then
      TDateEdit(Sender).Date := Now;
    If (UpperCase(Copy(TDateEdit(Sender).Name,Pos(vVerNome,UpperCase(TDateEdit(Sender).Name)),Length(TDateEdit(Sender).Name))) = vVerNome) and
       (TDateEdit(Sender).Date < TDateEdit(vForm.FindComponent(UpperCase(Copy(TDateEdit(Sender).Name,1,Pos(vVerNome,UpperCase(TDateEdit(Sender).Name))-1)+'Ini'))).Date) Then
    begin
      MensagemDlg(IIf(Trim(TDateEdit(Sender).Hint) = '','Campo final menor que campo inicial.',TDateEdit(Sender).Hint),mtInformacao,mbOK);
      TDateEdit(Sender).Clear;
      TDateEdit(Sender).SetFocus;
    end;
  end; // If Sender is TDateEdit Then
end;

Function ReconectaBanco(pUsuario, pSenha : String) : Boolean;
begin
  Result            := True;
  { Limpa os parametros do componente DataBase }
  dm.dbBgm.Connected := False;
  dm.dbBgm.Params.Clear;
  dm.dbBgm.Params.Add('USER NAME=' + pUsuario);
  dm.dbBgm.Params.Add('PASSWORD=' + pSenha);
  frmMenuPrincipal.vUserName := pUsuario;
  frmMenuPrincipal.vUserSenha := pSenha;

  { Faz a conexão ao banco de dados }
  Try
    dm.dbBgm.Connected := True;
  Except
    Result            := False;
    vFechaSplash      := True;
    frmMenuPrincipal.FazPerguntaAoSair := False;
    dm.vEncerraApl    := true;
    vcEncerraApl := true;
    MensagemDlg('Falhou na conexão do usuário "' + pUsuario +
                  '" ao banco de dados. Consulte o administrador.',MtInformacao,MbOk);
    frmMenuPrincipal.Close;
    Exit;
  End; 
  { Coloca mensagens na barra de Status }
  msg;
end;

Function TrazCodigoCliente : Integer;
begin
  Result := frmMenuPrincipal.vCodigoCliente;
end;

Function Right(pString : String; pTam : Integer) : String;
begin
  result := Copy(pString,length(pString) - ptam + 1,ptam);
end;

Function Left(pString : String; pTam : Integer) : String;
begin
  result := Copy(pString,1,ptam);
end;

Procedure AbrePaginaWeb(pURL : String);
Var
  IE    : Variant;
  Janela: Integer;
  DdeClientConv: TDdeClientConv;
begin
  { Tenta abrir pelo InternetExplorer }
  try
//    DdeClientConv := TDdeClientConv.Create(Application);
    IE := CreateOleObject('InternetExplorer.Application');
    IE.Visible := True;
    IE.Navigate(pURL);
  except
    { Caso contrário tenta achar o NetScape }
    DdeClientConv := TDdeClientConv.Create(Application);
    With DDEClientConv Do
    begin
      If SetLink('Netscape','WWW_OpenURL') Then
      begin
        Janela := Integer( RequestData('http://'+ pURL + ',,0,,,,') );
        If Janela > 0 Then
        begin
          SetLink('Netscape','WWW_Activate');
          RequestData(IntToStr(Janela)+',0');
        end;
      end;
    end;
    DdeClientConv.Free;
  end;
//  DdeClientConv.Free;
end;

Function VerificaTeclaAlt(var Key: Word; Shift: TShiftState; vTecla :Char):Boolean;
Begin
   If (ssAlt in Shift) and ((chr(Key) = UpperCase(vTecla)) or (chr(Key)= vTecla)) then
      Result := True
   Else
      Result := False;
End;

Function MsgConfirmaFechamentoDoSistema : Boolean;
Begin
  Result := MensagemDLG( 'Deseja realmente finalizar o sistema ?', mtConfirmacao, mbSim + mbNao ) = mrSim;
End;

Function ConverteValor(vValor : Double; vQtdDecimal, vTamanho : Integer) : String;
begin
  If vQtdDecimal = 2 then
    result := StrZero( ( vValor * 100 ), vtamanho)
  else
  If vQtdDecimal = 3 then
    result := StrZero( ( vValor * 1000 ), vtamanho)
  else
  If vQtdDecimal = 4 then
    result := StrZero( ( vValor * 10000 ), vtamanho)
end;

Function NumberToTime(vCampo : String) : TDateTime;
var vHoraStr : String;
begin
  If Length(vCampo) = 6 then { h:mm:ss }
    vHoraStr := Copy(vCampo,1,2) + ':' + Copy(vCampo,3,2) + ':' + Copy(vCampo,5,2)
  else
  If Length(vCampo) = 5 then { h:mm:ss }
    vHoraStr := Copy(vCampo,1,1) + ':' + Copy(vCampo,2,2) + ':' + Copy(vCampo,4,2)
  else
  If Length(vCampo) = 4 then { hh:mm }
    vHoraStr := Copy(vCampo,1,2) + ':' + Copy(vCampo,3,2)
  else
    vHoraStr := Copy(vCampo,1,1) + ':' + Copy(vCampo,2,2);
  Try
    result := StrToTime(vHoraStr);
  Except
    result := 0;
  End ; // Try - Except
end;

Function ValidacaoGeral_ConciliacaoEletronica(pTipoVal : String; pCodBanco : String = ''; pEmpresa : Integer = 1; pFilial : Integer = 1;pSistema : String = 'CPG') : Boolean;
Var qry : TQuery;
    // i : Integer;
    vBancoDisp : String;
Begin
  { pTipoVal - Tipo de validação:
    1 : Menu Principal - OnShow
    2 : Exit do Campo Banco - Tela de Definição de Pagamento Eletrônico
  }

  { Empresas:
    0001 - Reunidas
    0015 - Catarinense
    0030 - Andorinha
    0081 - 1001
    9999 - BGM
  }

  { Bancos:
    001 - Banco do Brasil
    033 - Banespa
    237 - Bradesco
    341 - Itau
    399 - HSBC
  }
  Result := True;
  vBancoDisp := '001_033_237_341_399_';

(*  If pTipoVal = '1' then // Menu principal - Desativa para as empresas NÃO autorizadas.
  begin
    if (frmMenuPrincipal.vCodigoCliente <> 0001) and { Reunidas }
       (frmMenuPrincipal.vCodigoCliente <> 0015) and { Catarinense }
       (frmMenuPrincipal.vCodigoCliente <> 0030) and { Andorinha }
       (frmMenuPrincipal.vCodigoCliente <> 0081) and { 1001 }
       (frmMenuPrincipal.vCodigoCliente <> 9999) then { BGM }
      For i := 0 to 3 do
      begin
        frmMenuPrincipal.MainMenu1.Items[2].Items[6].Items[i].Enabled := False;
      end;
    Exit;
  end;
*)
  If pTipoVal = '2' then // Código do banco na tela de definição
  begin
    qry := TQuery.Create(Application);
    qry.DatabaseName := cDatabaseName;
    With qry do
    begin
      { Verifica se banco esta disponivel para cobrança eletronica. }
      Close;
      SQL.Clear;
      SQL.Add( 'SELECT NROBANCO'       );
      SQL.Add( ' FROM BCOBANCO'        );
      SQL.Add( ' WHERE CODBANCO = :P0' );
      params[0].AsString := pCodBanco;
      Open;
      { Faz uma combinação entre o número do cliente e do banco, pois cada um dos
        clientes só poderá utilizar os bancos contratados. CCCC/BBB_ }

      If Pos(StrZero(FieldByName( 'NROBANCO' ).AsInteger,3,0), vBancoDisp) = 0 Then
      Begin
        Result := False;
        MensagemDlg(IIF(pSistema = 'IMP','Importação de depositos','Conciliação eletrônica') +
                   ' não disponível para o banco '
                   + pCodBanco + ' (Nº oficial = ' + FieldByName( 'NROBANCO' ).AsString + ').', mtErro, mbOk);
      End;
      Close;
      Free;
      Exit; 
    End;
  end;

End; // ValidacaoGeral_ConciliacaoEletronica

Function TrazComparacaoDivergente(pQuery : TQuery; pCriaRx : Boolean = True ) : String;
Var
  vItem : Integer ;
Begin
  // Quando o componente já estiver e for cria novamente
  If (vRxCompDive <> nil) And (pCriaRx) Then
  Begin
    vRxCompDive := Nil ;
    vRxCompDive.Free ;
  End ; // If (vRxCompDive <> nil) And
  
  If (vRxCompDive = nil) Or (pCriaRx) then
    vRxCompDive := TRxMemoryData.Create(Nil) ;

  Result := '' ;
  If vRxCompDive.RecordCount <= 0 Then // Verifica se existe registro na Memory Data
  Begin
    vRxCompDive.EmptyTable ;
    vRxCompDive.LoadFromDataSet(pQuery,0,lmCopy) ; // Copia a estrutura e todos registros da query p/ a Memory Data
  End Else // If pRx.RecordCount <= 0 Then
  Begin
    With vRxCompDive.Fields do
    Begin
      // Se q quandidade de campos do 2º select estiver diferente com a do 1º select cai fora
      If Count <> pQuery.Fields.Count Then
        Exit ;

      For vItem := 0 to Count-1 Do
        If Fields[vItem].AsString <> pQuery.Fields[vItem].AsString Then // Compara o conteúdo dos campos
          Result := Result + '(' + Fields[vItem].FieldName +') de ' +
                           IIf( Trim(              Fields[vItem].AsString)='','<vazio>',              Fields[vItem].AsString) +' para ' +
                           IIf( Trim(pQuery.Fields.Fields[vItem].AsString)='','<vazio>',pQuery.Fields.Fields[vItem].AsString) +', '  ;

      // Se achou alguma diferença, retira a ultima virgula.
      Result := IIf(Trim(Result)<>'',Copy(Result,1,Length(Trim(Result))-1),'') ;

      vRxCompDive := Nil ; // Iguala a Nil pq o componente só é liberado da memoria quando o mesmo esta em um Form.
      vRxCompDive.Free ; // Apenas p/ garantir que foi liberado da memoria
    End ; // With vRxCompDive.Fields do
  End ; // End Else
End ; // TrazComparacaodivergente(pQuery : TQuery) : String;

Function MostraErrosQuery(pErrors : EDBEngineError; pExibeMsg : Boolean = False) : String;
{ Silvio - 11/11/2003
  Exibe os N erros de DataBase }
Var
  a : Integer;
  b : String;
Begin
  b := '';
  For a := 0 To pErrors.ErrorCount-1 Do
  Begin
     b := b + '(' + IntToStr( pErrors.Errors[ a ].ErrorCode ) +
          ') ' + pErrors.Errors[ a ].Message + #10;
  End;
  If pExibeMsg Then
    Application.MessageBox( pChar( b ), 'Erro de SQL', MB_ICONHAND + MB_OK );
  Result := b;
End;



procedure GetSQL(qry: TQuery; vMemo: TMemo = nil; vSoRetornaParametros: Boolean = false; vIdentificador: String = '');
(* Sila Ferrari - 10/11/2003
   Coloca em Memo1.Lines o qry.SQL substituindo as variáveis "Bind" pelos valores
   atribuídos aos parâmetros. Utilizado para testes.
   Última alteração: 15/06/2004
*)


               function LimparEspacos(s: String): String;
               var
                 i: Integer;
               begin
                 Result := '';
                 for i := 1 to Length(s) do
                   if S[i] <> ' ' then
                     Result := Result + S[i]
               end;


               function GetPosParametro(s, par: String): Integer;
               var
                 i: Integer;
               begin
                 Result := Pos(s + ' ', par);
                 if Result = 0 then
                   Result := Pos(s + ',', par);
                 if Result = 0 then
                   Result := Pos(s + ')', par);
                 if Result = 0 then
                 begin
                   // Verifica se está no final da linha
                   i := Pos(s, par);
                   if Trim(Copy(par, i + length(s), 1)) = '' then
                     Result := i;
                 end;
               end;



const
  Mes: array[1..12] of String[3] = ('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
                                    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC');
var
  i, j, k: Integer;
  s, w, m: String;
  Memo1: TMemo;
  vToDate: Boolean;
  vTrunc: Boolean;
  vNull: Boolean;
  vStrings: TStringList;
begin

  // if (dm.vUsuarioManagerComSenhaUm) then
  if (vcUsuarioManagerComSenhaUm) or (vcArquivoRastreioSQL <> '') then
  begin
    if vMemo <> Nil then
      Memo1 := vMemo
    else

    begin
      // Cria um TMemo para poder usar o CopyToClipboard
      Memo1 := TMemo.Create(frmMenuPrincipal);
      Memo1.Visible := false;
      Memo1.Parent := frmMenuPrincipal;
    end;

    with qry do
    begin

      // Controla se o Params[j] = '' deve ser substituído por Null
      vNull := (Pos('INSERT', UpperCase(SQL.Text)) <> 0) or
               (Pos('UPDATE', UpperCase(SQL.Text)) <> 0);

      for i := 0 to SQL.Count - 1 do
      begin
        w := SQL.Strings[i];

        for j := 0 to ParamCount - 1 do
        begin
          if  GetPosParametro(':' + Params[j].Name, w) <> 0 then
          begin
            k := GetPosParametro(':' + Params[j].Name, w);
            // System.Delete(w, k, Length(':' + Params[j].Name));
            // Apaga os (:)
            System.Delete(w, k, 1);
            System.Insert(' */ ', w, k + Length(Params[j].Name));
            System.Insert(' /* ', w, k);


            if Params[j].DataType in [ftString] then
            begin
              if (vNull) and
                 ((Params[j].IsNull) or (Params[j].AsString = '')) then
              begin
                s := 'NULL';
                System.Insert('NULL', w, k)
              end

              else
              begin
                s := QuotedStr(Params[j].AsString);
                System.Insert(QuotedStr(Params[j].AsString), w, k);
              end;
            end

            else if Params[j].DataType in [ftDateTime, ftDate] then
            begin
              // Verifica se aparece TO_DATE
              m := UpperCase(LimparEspacos(w));
              vToDate := GetPosParametro('TO_DATE(' + ':' + Params[j].Name, m) <> 0;
              vTrunc := GetPosParametro('TRUNC', m) <> 0; 

              if not(vToDate) and not(vTrunc) then
              begin
                // Coloca o TO_DATE
                s := FormatDateTime('DD/MM/YYYY HH:NN:SS', Params[j].AsDateTime);

                s := 'TO_DATE(' + QuotedStr(s) + ', ';
                s := s + QuotedStr('DD/MM/YYYY HH24:MI:SS') + ')';
                System.Insert(s, w, k);
              end

              else

              begin
                // Garante que será inserido o mês em inglês
                s := FormatDateTime('DD-', Params[j].AsDateTime);
                s := s + Mes[StrToInt(FormatDateTime('MM', Params[j].AsDateTime))];
                s := s + '-' + FormatDateTime('YYYY', Params[j].AsDateTime);

                if Params[j].DataType <> ftDate then
                  if FormatDateTime('HH:NN:SS', Params[j].AsDateTime) <> '00:00:00' then
                    s := s + FormatDateTime(' HH:NN:SS', Params[j].AsDateTime);
                System.Insert(QuotedStr(s), w, k);
              end;

            end

            else if Params[j].DataType in [ftFloat] then
            begin

              if (vNull) and
                 ((Params[j].IsNull) or (Params[j].AsString = '')) then
                s := 'NULL'
              else

              begin
                s := FormatFloat('######0.######', Params[j].AsFloat);
                if Pos(',', s) <> 0 then
                begin
                  s := Copy(s, 1, Pos(',', s) - 1) + '.' + Copy(s, Pos(',', s) + 1, Length(s));
                end;
              end;
            
              System.Insert(s, w, k)
            end

            else

            begin
              if (vNull) and
                 ((Params[j].IsNull) or (Params[j].AsString = '')) then
              begin
                s := 'NULL';
                System.Insert('NULL', w, k)
              end

              else

              begin
                s := Params[j].AsString;
                System.Insert(Params[j].AsString, w, k);
              end;


            end;
            
            if vSoRetornaParametros then
              Memo1.Lines.Add(Params[j].Name + ' = ' + s);

          end;

        end;

        if not(vSoRetornaParametros) then
          Memo1.Lines.Add(TrimRight(w) + ' ');

      end;
    end;

    if vcUsuarioManagerComSenhaUm then
    // só copia para a memória se estiver no nosso ambiente.
    begin
      Memo1.SelectAll;
      Memo1.CopyToClipboard;
      Memo1.Width := 10000;
    end;

    if vcArquivoRastreioSQL <> '' then 
    begin
      vStrings := TStringList.Create;
      try
        vStrings.LoadFromFile(vcArquivoRastreioSQL);
      except
      end;
      vStrings.Add(Replicate('-', 50));
      vStrings.Add('-- ' + FormatDateTime('DD/MM/YYYY HH:MM:NN   ', now)
                         + Screen.ActiveForm.Name
                         + IIf(vIdentificador = '', '', ' Identificador: ' + vIdentificador));

      vStrings.AddStrings(Memo1.Lines);
      try
        vStrings.SaveToFile(vcArquivoRastreioSQL);
      except
      end;
      vStrings.Free;
    end;

    if vMemo = Nil then
      Memo1.Free;

  end;

end;



Function SenhaUsuarioPosicional : Boolean;
{ Para os novos clientes (superiores a 121), tratar a senha do usuário de forma posicional. Para os demais clientes
  que quiserem trabalhar desta forma, bastará incluir o código nesta rotina. Silvio - 18/11/2003 }
Begin
{  Case frmMenuPrincipal.vCodigoCliente Of // Ver \Globus\Clientes\CodigoCliente.txt
    0001 .. 0121 : Result := False;
    9990 .. 9999 : Result := False; // Códigos auxiliares
  Else
    Result := True;
  End;}

  Result := True;     // Julio 05/11/2004
  If (frmMenuPrincipal.vCodigoCliente <=121) or (frmMenuPrincipal.vCodigoCliente >=9990) then
  Begin
    With qrPesqAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add( 'SELECT SENHAPOSICIONAL FROM CTR_PARAMETROS'  );
      Try     // para o caso de o campo SenhaPosicional não ter sido criado
        Open;
        Result := (Not Isempty) and (FieldByName('SenhaPosicional').AsString = 'S');
      except
        Result := False;
      end;
    end;
  end;
End;

function TotalHrs(vEntra,vSaida,vIIni,vIFin :tDateTime; vretorno : Integer=1) :Currency;
         // Quando não utilizar viini, vifin enviar 0,0  - retornos:
         //  1 - Qtde de Minutos;  2 - Qtde Horas Centesimal;   3 - Qtde Horas Normais
         //  4 - Qtde Dias;        5 - Qtde Horas Normais (até 24hrs, desconsidera o dia)
         //  6 - Qtde Horas Centesimais (até 24hrs, desconsidera o dia)
var vhorasCent : Currency;
    vHoras     : Real;
begin
  If (vIIni=vIFin) Then
    vHoras := (vsaida - ventra)
  else
    vHoras := (viini - ventra) + (vsaida - vifin);

  vHorasCent := vHoras*24;

  If      vretorno = 1 then  // Minutos
    result := vHorasCent*60
  else if vretorno = 2 then  // Centesimal
    result := vHorasCent
  else if vretorno = 3 then  // Horas Normais
    result := int(vHorasCent) + (frac(vHorasCent)*0.60)
  else if vretorno = 4 then  // Dias
    result := int(vHoras)
  else if vretorno = 5 then  // (DiasHoras - Dias) = Hrs normais
  begin
    vHorasCent :=  (vHoras - int(vHoras))*24;
    result := int(vHorasCent) + (frac(vHorasCent)*0.60);
  end
  else if vretorno = 6 then  // (DiasHoras - Dias) = Hrs Centesimais
  begin
    result := (vHoras - int(vHoras))*24;
  end
  else
    result := 0;
end;

Procedure IdentificaHintNaTela(Sender : TObject) ;
Var
  v,
  vTop,
  vLeft  : integer ;
  vImage : TImage ;
  vPanel : TPanel ;
  Procedure CriaIdendificadorDeHint(Seq : Integer) ;
  Var a,b : integer ;
  Begin
    // Cria um componente panel
    vPanel := TPanel.Create(TForm(Sender));
    vPanel.Name       := 'hintpnl'+IntToStr(seq);
    vPanel.Caption    := '' ;
    vPanel.BevelOuter := bvNone ;
    vPanel.Height := 04 ;
    vPanel.Width  := 04 ;

    // Cria um componente image p/ desenhar o triangulo dentro
    vImage := TImage.Create(vPanel) ;
    vImage.Name       := 'hintimg'+IntToStr(seq);
    vImage.Parent      := vPanel ;
    vImage.Align       := alClient ;
    vImage.Transparent := True ;

    // Desenha um triangulo no image
    For a := 0 to vImage.Width do
      For b := 0 to vImage.Width do
        vImage.Canvas.Pixels[b,vImage.Top+b-a] := clRed ;
  End ;
Begin
  With TForm(Sender) do
  Begin
    For v := ComponentCount-1 downto 0 do
      If (Components[v].Classtype = TPanel) And
         (Copy(TPanel(Components[v]).name,1,7) = 'hintpnl') Then
        TPanel(Components[v]).destroy ;

    For v := 0 to ComponentCount - 1 do
    Begin
      If (Components[v] Is TWinControl)                And
         (TWinControl(Components[v]).ShowHint)         And
         (Trim(TWinControl(Components[v]).Hint) <> '') Then
      Begin
        CriaIdendificadorDeHint(v);
        vPanel.Parent := TWinControl(Components[v]).Parent ;

        // Quando for um TGROUPBOX ou TRADIOGROUP desce + 3 p/ o identificador ficar dentro do quadro
        vTop := TWinControl(Components[v]).Top+1 ;
        If (Components[v] Is TGroupBox) Or (Components[v] Is TRadioGroup) Then
          vTop := vTop+4 ;

        // Posiciona o panel no canto superior esquerdo do componente
        vPanel.Top   := vTop ;
        vPanel.Left  := TWinControl(Components[v]).Left+TWinControl(Components[v]).Width-6 ;
        vPanel.Color := TWinControl(Components[v]).Brush.Color ;
        vPanel.Hint  := Traduz(TWinControl(Components[v]).Hint) ;
        vPanel.ShowHint := True ;
      End Else // If (Components[v] Is TWinControl) And (...
      If (Components[v] Is TGraphicControl)                And
         (TGraphicControl(Components[v]).ShowHint)         And
         (Trim(TGraphicControl(Components[v]).Hint) <> '') Then
      Begin
        CriaIdendificadorDeHint(v) ;
        vPanel.Parent := TGraphicControl(Components[v]).Parent ;

        // Quando for um LABEL o identificador vai ficar do lado do componente p/ ficar encima da ultima letra
        vLeft := TGraphicControl(Components[v]).Left+TGraphicControl(Components[v]).Width-7 ;
        If Components[v] Is TLabel Then
          vLeft := vLeft + vPanel.Width ;

        // Posiciona o panel no canto superior esquerdo do componente
        vPanel.Top   := TGraphicControl(Components[v]).Top+1 ;
        vPanel.Left  := vLeft ;
        vPanel.Hint  := Traduz(TGraphicControl(Components[v]).Hint) ;
        vPanel.ShowHint := True ;
      End ; // If (Components[v] Is TGraphicControl) And (...

    End ; // For i := 0 to ComponentCount - 1 do
  End ; // With TForm(Sender) do
End ;

(*Procedure AjustaDireitosDosBotoes(Sender : TObject);
Begin
  If frmMenuPrincipal.ContSenhaBgm.Sistema = 'ATF' Then
  Begin
    vTemDireitoInclusao  := Copy(TForm(Sender).Hint,1,1) = 'S';
    vTemDireitoAlteracao := Copy(TForm(Sender).Hint,2,1) = 'S';
    vTemDireitoExclusao  := Copy(TForm(Sender).Hint,3,1) = 'S';
  End;
End;

Procedure PreencheHintComDireitosDosBotoes(Sender : TObject);
Begin
  DireitoAoBotoesDaTela(frmMenuPrincipal.ContSenhaBgm.Usuario,
                        frmMenuPrincipal.ContSenhaBgm.sistema, TComponent(Sender).Name);
  TForm(Sender).Hint := IIf(dm.vTemDireitoInclusao,  'S', 'N') +
                        IIf(dm.vTemDireitoAlteracao, 'S', 'N') +
                        IIf(dm.vTemDireitoExclusao,  'S', 'N');
End;*)

//****************************
Procedure VerificaCriaSequence(pNomeSequence, pTabela, pCampoBase : String);
//****************************
Var
  Qry : TQuery;
  vCodLanca : Integer;
Begin
  Qry := TQuery.Create(Nil);
  Qry.DataBaseName := cDatabaseName;
  With Qry Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add('Select Sequence_Name From User_Sequences Where Sequence_Name = :pSequenceName');
    ParamByName('pSequenceName').AsString := UpperCase(pNomeSequence);
    Open;
    If IsEmpty Then // Tenta criar apenas quando não existe
    Begin
      Try
        Close;
        Sql.Clear;
        // If dm.vBancoDeDados = 'ORACLE' Then
        If vcBancoDeDados = 'ORACLE' Then
          Sql.Add(' SELECT NVL(MAX(' + pCampoBase + '),0) + 1 AS CODLANCA FROM ' + pTabela)
        else // Interbase
          Sql.Add(' SELECT DNVL(Max(' + pCampoBase + '),0) + 1 AS CODLANCA FROM ' + pTabela);
        Open;
        vCodLanca := FieldByName('CodLanca').AsInteger;
        Close;

        Try
          Sql.Clear;
          // If dm.vBancoDeDados = 'ORACLE' Then
          If vcBancoDeDados = 'ORACLE' Then
          begin
            Sql.Add(' CREATE SEQUENCE ' + pNomeSequence + ' START WITH ' + IntToStr(vCodLanca) + ' INCREMENT BY 1 NOCYCLE NOMAXVALUE NOCACHE ');
            ExecSql;
          end
          else // Interbase
          begin
            Sql.Add('SELECT RDB$GENERATOR_NAME FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = ''' + pNomeSequence + '''');
            Open;
            If IsEmpty then
            begin
              Sql.Clear;
              Sql.Add(' CREATE GENERATOR ' + pNomeSequence);
              ExecSql;
              Sql.Clear;
              Sql.Add(' SET ' + pNomeSequence + ' TO ' + IntToStr(vCodLanca));
              ExecSql;
            end;
          end;
          Close;
        Except
          MensagemDlg('Falha ao criar a sequence "' + pNomeSequence + '".' + #13 + #13 + 'Informe o Administrador.', mtInformacao, mbOK, True, 'Arial');
        End;
      Except
        MensagemDlg('Falta tabela/campo "' + pTabela + '/' + pCampoBase + '"' + #13 + ' para criar a sequence "' + pNomeSequence + '".' + #13 + #13 +
          'Informe o Administrador.', mtInformacao, mbOK, True, 'Arial');
      End;
    End;
    Close;
    Free;
  End;
End;

Function VerificaNroPlanoCTBParaFilial(pEmpresa, pFilial : Integer) : Integer;
Begin
//  Result := 0;
  With qrPesqAux do
  Begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT * FROM CTBPARAM');
    SQL.Add('WHERE CODIGOFL = :P0 AND CODIGOEMPRESA = :P1');
    Params[0].AsInteger := pFilial;
    Params[1].AsInteger := pEmpresa;
    Open;
    Result := FieldByName('NroPlano').AsInteger;
    Close;
//    Free;
  End;
End;

Function VerificaParametrosDaTela : Boolean ;
Var i : Integer ;
Begin
  Result := True ;
  With Screen.Forms[0] do
  Begin
    For i := 0 to ComponentCount - 1 do
    Begin
      If ((Components[i] Is TWinControl) And ((Not TWinControl(Components[i]).Enabled) Or
                                              (Not TWinControl(Components[i]).Visible) Or
                                              (Not TWinControl(TWinControl(Components[i]).Parent).Visible) )) Then
        Continue ;

      If ((Components[i] Is TNumEdit)    And       (TNumEdit(   Components[i]).Value = 0 )) Or
         ((Components[i] Is TDateEdit)   And       (TDateEdit(  Components[i]).Date  = 0 )) Or
         ((Components[i] Is TComboBox)   And  (Trim(TComboBox(  Components[i]).Text) = '')) Or
         ((Components[i] Is TMaskEdit)   And  (Trim(TMaskEdit(  Components[i]).Text) = '')) Or
         ((Components[i] Is TCustomEdit) And  (Trim(TCustomEdit(Components[i]).Text) = '')) Then
      Begin
        MensagemDlg('Dados essenciais não foram digitados !',mtErro,mbOK) ;
        TWinControl(Components[i]).SetFocus ;
        Result := False ;
        Exit ;
      End ; // If ((Components[i] Is TNumEdit) And (...
    End ; // for i := 0 to ComponentCount - 1 do
  End ; // With Screen.Forms[0] do
End ;

procedure OrdenaColunas(pColuna: TColumn) ;
Var
  i      : Integer ;
  vGrid  : TCustomDBGrid ;
  vPanel : TPanel ;
  vImage : TImage ;
  vNomeItemMenu : String ;
  Procedure DesenhaSetas(pDecrescente : Boolean) ;
  Var
    Lin,Col,Ini,Fin : Integer ;
  Begin
    // Verifica se o componenet PanelSeta ja existe
    If vGrid.FindComponent('PanelSeta') = Nil Then
    Begin
      vPanel := TPanel.Create(vGrid) ;
      vPanel.Parent  := vGrid ;
      vPanel.Name    := 'PanelSeta' ;
      vPanel.Left    := 0 ;
      vPanel.Top     := 0 ;
      vPanel.Height  := 17 ;
      vPanel.Width   := 11 ;
      vPanel.Caption := '' ;

      vImage := TImage.Create(vPanel) ;
      vImage.Name        := 'ImageSeta' ;
      vImage.Parent      := vPanel ;
      vImage.Align       := alClient ;
      vImage.Transparent := True ;
    End Else // If vGrid.FindComponent('PanelSeta') = Nil Then
    Begin // Caso existe atribui o valor na variavel
      vPanel := TPanel(vGrid.FindComponent( 'PanelSeta')) ;
      vImage := TImage(vPanel.FindComponent('ImageSeta')) ;
    End ; // End Else

    // Limpa o componente image
    vImage.Canvas.Brush.color := clMenu ;
    vImage.Canvas.Rectangle(0,0,vImage.Width,vImage.Height) ;

    Ini := IIf(pDecrescente,4,0) ;
    Fin := IIf(pDecrescente,3,7) ;
    For Lin := 5 to 9 do
    Begin
      For Col := Ini to Fin do // Desenha seta
        vImage.Canvas.Pixels[ Col , Lin] := clBlue ;

      Ini := IIf(pDecrescente, Ini - 1, Ini + 1 ) ;
      Fin := IIf(pDecrescente, Fin + 1, Fin - 1 ) ;
    End ; // For Lin := 8 to 12 do
    vImage.Hint := IIf(pDecrescente,'Decrescente','Crescente') ;
  End ; // Procedure DesenhaSetas(pTipo : String) ;

Begin
  vGrid := pColuna.Grid ;

  If TDBGrid(vGrid).DataSource.DataSet.RecordCount <= 1 Then Exit ;

  vOrdem  := (vColuna = pColuna.Index) And (Not vOrdem);
  vColuna := pColuna.Index ;
  For i := 0 to TDBGrid(vGrid).Columns.Count-1 do
    TDBGrid(vGrid).Columns[i].Title.Font.Color := ClBlack ;

  TDBGrid(vGrid).Columns[pColuna.Index].Title.Font.Color := ClBlue ;
  TRxMemoryData(TDBGrid(vGrid).DataSource.DataSet).SortOnFields(pColuna.FieldName,True,vOrdem) ;

  // So desenha a seta se o dgIndicator estiver true
  If dgIndicator In TDBGrid(vGrid).Options Then
    DesenhaSetas(vOrdem) ;

  // Cria menu
  If TDBGrid(vGrid).PopupMenu = Nil Then
  Begin
    PMenuPesquisa      := TPopupMenu.Create(TDBGrid(vGrid)) ;
    PMenuPesquisa.Name := 'PMenuPesquisa' ;
    TDBGrid(vGrid).PopupMenu := PMenuPesquisa ;
  End ; // If vGrid.FindComponent('PMenuPesquisa') = Nil Then

  // Cria item de menu (No menu criado ou no ja existente)
  vNomeItemMenu := TDBGrid(vGrid).Name +'_'+ 'IMenuPesquisa' ;
  If TDBGrid(vGrid).FindComponent(vNomeItemMenu) = Nil Then
  Begin
    IMenuPesquisa      := TMenuItemPesquisa.Create(TDBGrid(vGrid)) ;
    IMenuPesquisa.Name := vNomeItemMenu ;
    TPopupMenu(TDBGrid(vGrid).PopupMenu).Items.Add(IMenuPesquisa) ;
  End ; // If TDBGrid(vGrid).FindComponent(vNomeItemMenu) = Nil Then

  IMenuPesquisa.ColunaPesquisa(pColuna) ;
End;

Function ValidaCNPJCPF(pCNPJ: TMaskEdit; pMask : String = 'N'): Boolean;
var
    i,
    Len  :Integer;
    vCGC : TCGC;
    vCPF : TCPF;
begin

  vCGC := Nil; // Para evitar Warnings
  vCPF := Nil; //

  Result := False;

  If Trim(pCNPJ.Text) = '' then Exit;

  Try // Verifica se o que foi digitado só existe números
    StrToFloat(Trim(pCNPJ.Text)) ;
  Except
    MensagemDlg('CPF / CNPJ tem que ser numérico.', mtErro, mbOk);
    pCNPJ.Clear ;
    pCNPJ.SetFocus;
    Exit;
  End ; // Try - Except

  Len := Length(Trim(pCNPJ.Text)) ;
  For i := 0 To 9 Do
  Begin
    If ((Len <> 11) And (Len <> 14)) Or
       (Trim(pCNPJ.Text) = Replicate(IntToStr(i)[1],Len)) Then
    Begin
      MensagemDlg(IIf(Len=11,'CPF',IIf(Len=14,'CNPJ','CNPJ/CPF')) + ' inválido.',mtErro,mbOk);
      pCNPJ.Clear;
      pCNPJ.SetFocus;
      Exit;
    End;
  End;

  If ((Len = 11) And (Not vCPF.ChecaCPF(pCNPJ.Text))) Or
     ((Len = 14) And (Not vCGC.ChecaCGC(pCNPJ.Text))) Then
  Begin
    pCNPJ.Clear;
    pCNPJ.SetFocus;
    Exit;
  End;

  { Função para jogar mascará no campo }
  If (Len = 11) and ((pMask = '0') or (pMask = '1')) Then
    pCNPJ.EditMask := '999.999.999-99;' + pMask + ';'
  Else If (Len = 14) and ((pMask = '0') or (pMask = '1')) Then
    pCNPJ.EditMask := '99.999.999/9999-99;' + pMask + ';';

  Result := True;
End;

Function ValidacaoGeral_COB(pTipoVal : String; pCodBanco : String = ''; pEmpresa : Integer = 1; pFilial : Integer = 1;pSistema : String = 'CRC') : Boolean;
Var qry : TQuery;
    vBancosDisp : String;
Begin
  (*
    Passa a não mais importar as empresas. Apenas o Banco - 30/09/2004 - Verônica
  *)

  { Bancos:
            001 - Banco do Brasil
            033 - Banespa
            041 - BANRISUL
            224 - FIBRA
            237 - Bradesco
            341 - Itau
            389 - Mercantil
            399 - HSBC
            409 - Unibanco
            422 - Safra
            748 - SINCRED
  }


  Result      := True;
  vBancosDisp := cBCO_Brasil    + '_' + cBCO_Banespa   + '_'
               + cBCO_BanriSul  + '_' + cBCO_Fibra     + '_'
               + cBCO_Bradesco  + '_' + cBCO_Itau      + '_'
               + cBCO_HSBC      + '_' + cBCO_Unibanco  + '_'
               + cBCO_Safra     + '_' + cBCO_Sicredi   + '_'
               + cBCO_Mercantil;

  If pTipoVal = '2' then // Código do banco nas telas Remessa e Retorno
  begin
    { Verifica se existe Cobrança eletronica para o banco }  
    qry := TQuery.Create(Application);
    qry.DatabaseName := cDatabaseName;
    With Qry do
    Begin
      Close;
      SQL.Clear;
      SQL.Add( 'SELECT NROBANCO'       );
      SQL.Add( ' FROM BCOBANCO'        );
      SQL.Add( ' WHERE CODBANCO = :P0' );
      params[0].AsString := pCodBanco;
      Open;
      { Faz uma combinação entre o número do cliente e do banco, pois cada um dos
        clientes só poderá utilizar os bancos contratados. CCCC/BBB_ }
      If Pos(StrZero(FieldByName( 'NROBANCO' ).AsInteger,3,0), vBancosDisp) = 0 Then
      Begin
        Result := False;
        MensagemDlg('Cobrança eletrônica não disponível para o banco '
                   + pCodBanco + ' (Nº oficial = ' + FieldByName( 'NROBANCO' ).AsString + ').', mtErro, mbOk);
      End;
      Close;
      Free;
    End;
  end;

End; // ValidacaoGeral_COB

Function Enviaemail(vEmailDestino, vEmailOrigem, vassunto, vMensagem, vAvisoEnviando, vAvisoErro, vHost, vSenha, vPort, vUsuario: String; vHtml:String=''):Boolean;
var
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
begin
  Result     := False;
  IdSMTP1    := TIdSMTP.Create(Nil);
  IdMessage1 := TIdMessage.Create(Nil);

  IdSmtp1.AuthenticationType := AtLogin;
  IdSmtp1.Host := vhost;
  IdSmtp1.Port := StrToInt(vPort);
  IdSmtp1.Username := Trim(vEmailOrigem);
  IdSmtp1.Password := Trim(vSenha);
  IdMessage1.From.Text := Trim(vEmailOrigem);
  IdMessage1.Recipients.Add.Address := Trim(vEmailDestino);
  IdMessage1.BccList.Add.Address := Trim(vEmailOrigem);
  IdMessage1.Subject := vAssunto;
  IdMessage1.Body.Add(vMensagem);

  try
    IdSmtp1.Connect;
  except
    IdSmtp1.Disconnect;
    IdSmtp1.DisconnectSocket;
    exit;
  end;
  try
    IdSmtp1.Send(IdMessage1);
    IdSmtp1.Disconnect;
    IdSmtp1.DisconnectSocket;
    Result := True;
  except
    IdSmtp1.Disconnect;
    IdSmtp1.DisconnectSocket;
    Exit;
  end;
end;

Function VerificaSeEnviaEmail(PUsuario : String; vEnviaEmail : Boolean) : Boolean;
var vEmpresa, vRSocial, vLog, vCliente, vNrContrato, vAssunto, vEmailDestino, vMensagem, vMsgAux : String;
    vCodCli{, vCodContrato, i} : Integer;
begin
  If (Not vEnviaEmail) and (frmMenuPrincipal.vCodigoCliente <> 104) then
  begin
    Result := False;
    exit;
  end;

  Result := True;

  With qrPesqAux do
  Begin
    Close;
    Sql.clear;
    sql.add('SELECT NRCLI, CT.CODCONTRATO, CT.NR_CONTRATO, CT.CODCli, CT.VALIDADE, CLI.RSOCIALCLI,');
    sql.add('CLI.EMAILCLI, U.SENHASNAP, U.SERVIDORSMTP, U.EMAIL, U.PORTAENVIO, U.PORTAPOP3,       ');
    sql.add('EMPA.RSOCIALEMPRESA EMPRESA                                                          ');
    sql.add('FROM CGSCONTRATOS CT, BGM_CLIENTE CLI, CTR_CADASTRODEUSUARIOS U, CTR_CADEMP EMP,     ');
    sql.add('CTR_EMPAUTORIZADAS EMPA                                                              ');
    sql.add('WHERE CT.CODCLI = CLI.CODCLI AND (CT.VALIDADE < :PDATE or                            ');
    sql.add('CT.VALIDADE between :PDATE and :PdateFin)  AND                                       ');
    sql.add('ACAO_VALIDADE = ''E'' AND  EMAIL_ENVIADO = ''N'' AND USUARIO = :PUSUARIO AND         ');
    sql.add('EMPA.CODINTEMPAUT = EMP.CODINTEMPAUT AND EMP.CODIGOEMPRESA = CT.EMPRESA              ');
    sql.add('Order by NRCLI, CT.VALIDADE,  CT.CODCONTRATO                                         ');
    ParamByName('PDate').AsDateTime := date;
    ParamByName('PDateFin').AsDateTime := date + 3;
    ParamByName('PUsuario').AsString := pUsuario;
//    getsql(qrPesqAux);
    Open;
    vAssunto := 'Validade do contrato';
    vCliente := FieldByName('NrCli'     ).AsString;
    vRSocial := FieldByName('RSOCIALCLI').AsString;
    vEmpresa := FieldByName('Empresa'   ).AsString;
    vCodCli  := FieldByName('CodCli'    ).Asinteger;
//    vCodContrato  := FieldByName('CodContrato').Asinteger;
    vNrContrato   := FieldByName('Nr_Contrato' ).AsString;
    vEmailDestino := Trim(FieldByName('EmailCli').AsString);
//    i := 0;
    vMensagem := 'A validade do seu ';
    While not eof do
    begin
//      Inc(i);
      If (Trim(FieldByName('EmailCli').AsString) = '') or
         ((Trim(FieldByName('Email').AsString) = '') or (Trim(FieldByName('ServidorSMTP').AsString) = '') or
          (Trim(FieldByName('SenhaSnap').AsString) = '') or (Trim(FieldByName('PortaEnvio').AsString) = '')) then
      begin
        next;
        If vMsgAux <> '' then
        begin
          With qrPesqAux2 do
          Begin
            Close;
            Sql.clear;
            sql.add('UPDATE CGSCONTRATOS');
            sql.add('SET EMAIL_ENVIADO = ''S''');
            sql.add('WHERE CODCLI = :PCLIENTE AND (VALIDADE < :PDATE or ');
            sql.add('VALIDADE between :PDATE and :PdateFin)             ');
            ParamByName('PCLIENTE').AsInteger  := vCodCli;
            ParamByName('PDate'   ).AsDateTime := date;
            ParamByName('PDateFin').AsDateTime := date + 3;
//            getsql(qrPesqAux2);
            ExecSql;
          end;
          If not Enviaemail(Trim(vEmailDestino), {EmailDestino}
                            Trim(FieldByNAme('Email').asString), {EmailOrigem}
                            vAssunto, vMensagem + vMsgAux, '', '', {Assunto, Mensagem, Enviado, Erro}
                            Trim(FieldByName('ServidorSMTP').AsString), {Host}
                            Trim(FieldByName('SenhaSnap').AsString), {Senha}
                            Trim(FieldByName('PortaEnvio').AsString), {Porta}
                            pUsuario) then
          begin
            With qrPesqAux2 do
            Begin
              Close;
              Sql.clear;
              sql.add('UPDATE CGSCONTRATOS');
              sql.add('SET EMAIL_ENVIADO = ''N''');
              sql.add('WHERE CODCLI = :PCLIENTE AND (VALIDADE < :PDATE or ');
              sql.add('VALIDADE between :PDATE and :PdateFin)                 ');
              ParamByName('PCLIENTE').AsInteger  := vCodCli;
              ParamByName('PDate'   ).AsDateTime := date;
              ParamByName('PDateFin').AsDateTime := date + 3;

//              getsql(qrPesqAux2);
              ExecSql;
            end;
            Result := False;
            Exit;
          end;
          vLog := vLog + vCliente + '_' + vNrContrato + ',';
        end;
        vMsgAux := '';
        vCliente := FieldByName('NrCli').AsString;
        vCodCli  := FieldByName('CodCli').Asinteger;
//        vCodContrato  := FieldByName('CodContrato').Asinteger;
        vNrContrato   := FieldByName('Nr_Contrato').AsString;
        vEmailDestino := Trim(FieldByName('EmailCli').AsString);
        vRSocial      := FieldByName('RSOCIALCLI').AsString;
        vEmpresa      := FieldByName('Empresa'   ).AsString;
        Continue;
      end;
      IF vCliente = FieldByName('NrCli').AsString then
      begin
        vMsgAux := vMsgAux + 'contrato nº. ' + FieldByName('NRContrato').AsString + ' vencerá em ' +
                   FieldByNAme('validade').AsString + '.' +#13;
        next;
        Continue;
      end;

      With qrPesqAux2 do
      Begin
        Close;
        Sql.clear;
        sql.add('UPDATE CGSCONTRATOS');
        sql.add('SET EMAIL_ENVIADO = ''S''');
        sql.add('WHERE CODCLI = :PCLIENTE AND (VALIDADE < :PDATE or ');
        sql.add('VALIDADE between :PDATE and :PdateFin)             ');
        ParamByName('PCLIENTE').AsInteger  := vCodCli;
        ParamByName('PDate'   ).AsDateTime := date;
        ParamByName('PDateFin').AsDateTime := date + 3;

//        getsql(qrPesqAux2);
        ExecSql;
      end;
      If not Enviaemail(Trim(vEmailDestino), {EmailDestino}
                        Trim(FieldByNAme('Email').asString), {EmailOrigem}
                        vAssunto, vMensagem + vMsgAux, '', '', {Assunto, Mensagem, Enviado, Erro}
                        Trim(FieldByName('ServidorSMTP').AsString), {Host}
                        Trim(FieldByName('SenhaSnap').AsString), {Senha}
                        Trim(FieldByName('PortaEnvio').AsString), {Porta}
                        pUsuario) then
      begin
        With qrPesqAux2 do
        Begin
          Close;
          Sql.clear;
          sql.add('UPDATE CGSCONTRATOS');
          sql.add('SET EMAIL_ENVIADO = ''N''');
          sql.add('WHERE CODCLI = :PCLIENTE AND (VALIDADE < :PDATE or ');
          sql.add('VALIDADE between :PDATE and :PdateFin)             ');
          ParamByName('PCLIENTE').AsInteger  := vCodCli;
          ParamByName('PDate'   ).AsDateTime := date;
          ParamByName('PDateFin').AsDateTime := date + 3;

//          getsql(qrPesqAux2);
          ExecSql;
        end;
        Result := False;
        Exit;
      end;
      vLog := vLog + vCliente + '_' + vNrContrato + ',';
      vCliente := FieldByName('NrCli').AsString;
      vCodCli  := FieldByName('CodCli').Asinteger;
//      vCodContrato  := FieldByName('CodContrato').Asinteger;
      vNrContrato   := FieldByName('NrContrato').AsString;
      vEmailDestino := Trim(FieldByName('EmailCli').AsString);
      vRSocial      := FieldByName('RSOCIALCLI').AsString;
      vEmpresa      := FieldByName('Empresa'   ).AsString;

      vMsgAux :=  '';
      If vEmailDestino <> '' then
      vMsgAux := vMsgAux + 'contrato nº. ' + FieldByName('NR_Contrato').AsString + ' vencerá em ' +
                   FieldByNAme('validade').AsString + '.' +#13;
      Next;
    end;
    If (Trim(FieldByName('EmailCli').AsString) <> '') and
       (Trim(FieldByName('Email').AsString) <> '') and (Trim(FieldByName('ServidorSMTP').AsString) <> '') and
       (Trim(FieldByName('SenhaSnap').AsString) <> '') and (Trim(FieldByName('PortaEnvio').AsString) <> '') then
    begin
      If vMsgAux <> '' then
      begin
        With qrPesqAux2 do
        Begin
          Close;
          Sql.clear;
          sql.add('UPDATE CGSCONTRATOS');
          sql.add('SET EMAIL_ENVIADO = ''S''');
          sql.add('WHERE CODCLI = :PCLIENTE AND (VALIDADE < :PDATE or ');
          sql.add('VALIDADE between :PDATE and :PdateFin)             ');
          ParamByName('PCLIENTE').AsInteger  := vCodCli;
          ParamByName('PDate'   ).AsDateTime := date;
          ParamByName('PDateFin').AsDateTime := date + 3;

//          getsql(qrPesqAux2);
          ExecSql;
        end;
        If not Enviaemail(Trim(vEmailDestino), {EmailDestino}
                          Trim(FieldByNAme('Email').asString), {EmailOrigem}
                          vAssunto, vMensagem + vMsgAux, '', '', {Assunto, Mensagem, Enviado, Erro}
                          Trim(FieldByName('ServidorSMTP').AsString), {Host}
                          Trim(FieldByName('SenhaSnap').AsString), {Senha}
                          Trim(FieldByName('PortaEnvio').AsString), {Porta}
                          pUsuario) then
        begin
          With qrPesqAux2 do
          Begin
            Close;
            Sql.clear;
            sql.add('UPDATE CGSCONTRATOS');
            sql.add('SET EMAIL_ENVIADO = ''N''');
            sql.add('WHERE CODCLI = :PCLIENTE AND (VALIDADE < :PDATE or ');
            sql.add('VALIDADE between :PDATE and :PdateFin)             ');
            ParamByName('PCLIENTE').AsInteger  := vCodCli;
            ParamByName('PDate'   ).AsDateTime := date;
            ParamByName('PDateFin').AsDateTime := date + 3;

//            getsql(qrPesqAux2);
            ExecSql;
          end;
          Result := False;
          Exit;
        end;
        vLog := vLog + vCliente + '_' + vNrContrato + ',';
      end;
    end;
    If vLog <> '' Then
    begin
      vlog := Copy(vLog,1,Length(vLog)-1);
      vLog := 'Enviou e-mail para os clientes com contratos expirados. (Cliente_Contrato) ' + vLog;

      If GravaLOG( frmMenuPrincipal.ContSenhaBGM.Sistema,
         frmMenuPrincipal.ContSenhaBGM.Usuario, Now, vLog ) = -1 Then
        Result  := False;
    end;
  end;
end;

Function ProximoDocto_CPG(pEmpresa, pFilial, pCodigoForn : Integer; pSerie : String; pDocto : String = '') : String;
begin
  With qrPesqAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT '                                                  );
  {$IFDEF Adiantamento}
    If Copy(pDocto,1,3) = 'AD-' then {SAS 5467 - SIM 9957}
      SQL.Add( ' MAX( TO_NUMBER( SUBSTR(NRODOCTOCPG,4,7) )+1 ) AS NEXT FROM CPGDOCTO' )
    else
    begin
      If (Copy(pDocto,1,3) = 'DV-')  then
        SQL.Add( ' MAX( TO_NUMBER( SUBSTR(NRODOCTOCPG,4,7) )+1 ) AS NEXT FROM CPGDOCTO' )
      else
        SQL.Add( ' MAX( TO_NUMBER( NRODOCTOCPG )+1 ) AS NEXT FROM CPGDOCTO' );
    end;
  {$ELSE}
      SQL.Add( ' MAX( TO_NUMBER( NRODOCTOCPG )+1 ) AS NEXT FROM CPGDOCTO' );
  {$ENDIF}
    SQL.Add( ' WHERE SUBSTR(NRODOCTOCPG,10,1 ) BETWEEN ''0'' AND ''9''' );
    SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 9, 1 ) BETWEEN ''0'' AND ''9''' );
    SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 8, 1 ) BETWEEN ''0'' AND ''9''' );
    SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 7, 1 ) BETWEEN ''0'' AND ''9''' );
    SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 6, 1 ) BETWEEN ''0'' AND ''9''' );
    SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 5, 1 ) BETWEEN ''0'' AND ''9''' );
    SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 4, 1 ) BETWEEN ''0'' AND ''9''' );

  {$IFDEF Adiantamento}
    If Copy(pDocto,1,3) = 'AD-' then
      SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 1, 3 ) = ''AD-''            ' )
    else
    begin
      If (Copy(pDocto,1,3) = 'DV-') then
        SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 1, 3 ) = ''DV-''            ' )
      else
      begin
        SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 3, 1 ) BETWEEN ''0'' AND ''9''' );
        SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 2, 1 ) BETWEEN ''0'' AND ''9''' );
        SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 1, 1 ) BETWEEN ''0'' AND ''9''' );
      end;
    end;
  {$ELSE}
      SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 3, 1 ) BETWEEN ''0'' AND ''9''' );
      SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 2, 1 ) BETWEEN ''0'' AND ''9''' );
      SQL.ADD( ' AND SUBSTR( NRODOCTOCPG, 1, 1 ) BETWEEN ''0'' AND ''9''' );
  {$ENDIF}
    SQL.Add( ' AND CODIGOEMPRESA = :P0'                                 );
    SQL.Add( ' AND CODIGOFL = :P1'                                      );
    SQL.Add( ' AND CODIGOFORN = :P2'                                    );
    SQL.Add( ' AND SERIEDOCTOCPG = :P3'                                 );
    SQL.Add( ' AND STATUSDOCTOCPG <> ''C'''                             );
    params[0].AsInteger := pEmpresa;
    params[1].AsInteger := pFilial;
    params[2].AsInteger := pCodigoForn;
    Params[3].AsString  := Trim(pSerie);
    Open;
  {$IFDEF Adiantamento}
    Result     := IIF((Copy(pDocto,1,3) = 'AD-') or (Copy(pDocto,1,3) = 'DV-'),'0000001','0000000001');
  {$ELSE}
    Result     :=  '0000000001';
  {$ENDIF}

    If ( Not IsEmpty ) and ( FieldByName( 'NEXT' ).AsString <> '' ) then
    Begin
      Try
        If FieldByName( 'NEXT' ).AsString = '10000000000' then
        begin
  {$IFDEF Adiantamento}
          Result     := StrZero( StrToFloat( FieldByName( 'NEXT' ).AsString ) - 1 ,
                                 IIF((Copy(pDocto,1,3) = 'AD-') or (Copy(pDocto,1,3) = 'DV-'),7,10));
  {$ELSE}
          Result     := StrZero( StrToFloat( FieldByName( 'NEXT' ).AsString ) - 1 ,10);
  {$ENDIF}
          exit;
        end;
  {$IFDEF Adiantamento}
        Result     := StrZero( StrToFloat( FieldByName( 'NEXT' ).AsString ),
                               IIF((Copy(pDocto,1,3) = 'AD-') or (Copy(pDocto,1,3) = 'DV-'),7,10));
  {$ELSE}
        Result     := StrZero( StrToFloat( FieldByName( 'NEXT' ).AsString ),10);
  {$ENDIF}
        exit;
      except on EConvertError do
        Begin
          Result     := FieldByName( 'NEXT' ).AsString ;
          exit;
        end;
      end; // Try
    end

  end;
end;


function ObjetoToStr(Sender: TObject): String;
(* Transforma o valor do objeto em String

Classe           Retorno
TCheckBox        'T' ou 'F'
TComboBox        StrToInt(ItemIndex)
TEdit            Text
TNumEdit         Text
TCheckListBox    String composta de 'T' ou 'F', dependendo do estado do Checked e do nº de elementos
*)
var
  i: Integer;
begin

  if Sender is TCheckBox then
    Result := iif(TCheckBox(Sender).Checked, 'T', 'F')

  else if Sender is TComboBox then
    Result := IntToStr(TComboBox(Sender).ItemIndex)

  else if Sender is TRadioGroup then
    Result := IntToStr(TRadioGroup(Sender).ItemIndex)

  else if Sender is TNumEdit then
    Result := TNumEdit(Sender).Text

  else if Sender is TCheckListBox then
  begin
    Result := '';
    for i := 0 to TCheckListBox(Sender).Items.Count - 1 do
      Result := Result + iif(TCheckListBox(Sender).Checked[i], 'T', 'F');
  end

  else if Sender is TDateEdit then
    Result := FormatDateTime('DD/MM/YYYY', TDateEdit(Sender).Date)

  else if Sender is TTimeEdit then
    Result := TTimeEdit(Sender).TimeText

  else Result := Pad(TEdit(Sender).Text, TEdit(Sender).MaxLength, 'D');

end;


function StrToObjeto(Sender: TObject; vValor: String): Boolean;
(* Atribui vValor ao objeto e retorno true se não houve erros

Classe           Ação
TCheckBox        Checked := iif(vValor = 'T', True, False)
TComboBox        ItemIndex := StrToIntDef(vValor, 0)
TRadioGroup      ItemIndex := StrToIntDef(vValor, 0)
TEdit            Text := vValor
TNumEdit         Text  := vValor                   
TCheckListBox    Checked := iif(vValor = 'T', True, False), dependendo do nº de elementos e sequência da string
*)
var
  i: Integer;
begin


  try

    if Sender is TCheckBox then
      TCheckBox(Sender).Checked := vValor = 'T'

    else if Sender is TComboBox then
    begin
      with TComboBox(Sender) do
      begin
        ItemIndex := StrToIntDef(vValor, 0);
        Text := Items[ItemIndex];
      end;
    end

    else if Sender is TRadioGroup then
    begin
      with TRadioGroup(Sender) do
        ItemIndex := StrToIntDef(vValor, 0);
    end

    else if Sender is TNumEdit then
      TNumEdit(Sender).Text := vValor

    else if Sender is TCheckListBox then
    begin
      for i := 0 to TCheckListBox(Sender).Items.Count - 1 do
        TCheckListBox(Sender).Checked[i] := Copy(vValor, i + 1, 1) = 'T';
    end

    else if Sender is TDateEdit then
    begin
      if vValor = '' then
        TDateEdit(Sender).Text := '  /  /    '
      else
        TDateEdit(Sender).Text := vValor;
    end

    else if Sender is TTimeEdit then
    begin
      if vValor = '' then
        TTimeEdit(Sender).TimeText := '00:00'
      else
        TTimeEdit(Sender).TimeText := vValor;
    end

    else TEdit(Sender).Text := Trim(vValor);

    Result := true;
  except
    Result := false;
  end;

end;


procedure ImpRDPrint(Print: TRDPrint; vRow, vCol: Integer; 
                     vField: TField; vCampo: String = '';
                     vAlinhamento: Char = 'E'; vMascara: String = '';
                     vImprimirZero: Boolean = true);
(* Criada por Sila em 02/08/2004. 
*)
        function FormatarCampo(vField: TField; vMask: String): String;
        begin

          Result := vField.AsString;
          if vMask <> '' then
          begin
            if (vField is TFloatField) or
               (vField is TIntegerField) then
            begin
              if (vField.AsFloat = 0) and
                 not(vImprimirZero) then
                Result := ''
              else
                Result := FormatFloat(vMask, vField.AsFloat);
            end

            else

            begin
              if (vField is TDateTimeField) then
                Result := FormatDateTime(vMask, vField.AsDateTime);
            end;
          end
        end;

begin

  // Trata o campo
  if (vField <> nil) then
    vCampo := FormatarCampo(vField, vMascara);

  // Faz a impressão
  with Print do
    case vAlinhamento of
      'C': Impc(vRow, vCol, vCampo, []);
      'D': ImpD(vRow, vCol, vCampo, []);
    else
      Imp (vRow, vCol, vCampo);
    end;

end;

function AtualizandoBaseDeDados : Boolean;
Var
  vMsg : String;
  vQuery : TQuery;
begin
  vQuery := TQuery.Create(Application);
  vQuery.DatabaseName := cDatabaseName;
  With vQuery Do
  begin
    Close;
    Sql.Clear;
    Sql.Add('Select * From Ctr_AtualizaBase');
    Open;
    Result := Not IsEmpty;
    vMsg := FieldByName('WinLogin').AsString;
    Close;
    Free;
  end;
  If Result Then
    MensagemDlg('O Globus está sendo atualizado por (Usuário/Estação) "' + vMsg +
                '". Aguarde alguns instantes e tente novamente.', mtInformacao, mbOk );
end;

Function QtdDeUsuariosConectados : Integer;
Var
  vQuery : TQuery;
begin
  vQuery := TQuery.Create(Application);
  vQuery.DatabaseName := cDatabaseName;
  With vQuery Do
  begin
    Close;
    Sql.Clear;
    Sql.Add(' Select Distinct Estacao || UsuarioWin ');
    Sql.Add(' From ' + cTabelaDeLicencas);
    Open;
    If IsEmpty Then Result := 0 Else Result := RecordCount;
    Close;
    Free;
  end;
end;

Procedure PosicionaBotoes(pPanel: TPanel ; pMudaTamanhoDoPainel : Boolean = True ; pMudaTamanhoDosBotoes : Boolean = True ) ;
var
  i,
  vEspaco,
  vControle,
  vQtdeBotoes  : Integer ;
  vLBoxOrdenar : TListBox ;
Const
  HeightPanelBotoes = 55 ;
  TopBotoes         = 13 ;
  HeightBotoes      = 30 ;
  WidthBotoes       = 85 ;
begin
  With TPanel(pPanel) do
  Begin
    // Cria ListBox p/ ordenar os botões conforme o TabOrder
    vLBoxOrdenar := TListBox.Create(pPanel) ;
    vLBoxOrdenar.Visible := False ;
    vLBoxOrdenar.Parent  := pPanel ;
    vLBoxOrdenar.Name    := 'vLBoxOrdenarBotoes' ;
    vLBoxOrdenar.Sorted  := True ;
    vLBoxOrdenar.Clear   ;

    // Conta a quantidade de botões visíveis no painel e guarda o TabOrder e o Controle de cada componente
    For i := 0 To ControlCount - 1 Do
      If (Controls[i] Is TButton) And (TButton(Controls[i]).Visible) Then
        vLBoxOrdenar.Items.Add('A:'+ StrZero(TButton(Controls[i]).TabOrder,2) +
                               'B:'+ StrZero(i,2) ) ;

    If pMudaTamanhoDoPainel Then
      Height := HeightPanelBotoes ; // Redefine o panel

    vQtdeBotoes := vLBoxOrdenar.Items.Count ;
    vEspaco     := Trunc((pPanel.Width-(vQtdeBotoes*WidthBotoes))/(vQtdeBotoes+1) ) ;
    For i := 0 To vLBoxOrdenar.Items.Count-1  Do
    Begin
      // Identifica qual é o controle do componente
      vControle := StrToInt(Copy(vLBoxOrdenar.Items[i],Pos('B:',vLBoxOrdenar.Items[i])+ 2,2)) ;

      If Controls[vControle] Is TButton Then
      Begin
        If pMudaTamanhoDosBotoes Then
        Begin
          // Redefine tamanho e largura dos botões
          TButton(Controls[vControle]).Height := HeightBotoes ;
          TButton(Controls[vControle]).Width  := WidthBotoes  ;
          // Define as posições dos botões
          TButton(Controls[vControle]).Top    := TopBotoes    ;
        End Else // If pTamaBotoes Then
          TButton(Controls[vControle]).Top    := Trunc((Height-TButton(Controls[vControle]).Height)/2) ;

        If TButton(Controls[vControle]).TabOrder = 0 Then
          TButton(Controls[vControle]).Left := vEspaco
        Else
          TButton(Controls[vControle]).Left := vEspaco * (TButton(Controls[vControle]).TabOrder+1) + (WidthBotoes*TButton(Controls[vControle]).TabOrder) ;
      End ; // If Controls[vControle] Is TButton Then
    End ; // For i := 0 To ControlCount-1 Do
    vLBoxOrdenar.Free ;
  End ; // With TPanel(pPanel) do
End ;

procedure PreencherComZerosSeNaoVazio(var Sender: TObject; vTamanho: Integer);
begin

  if Sender Is TEdit then
  begin
    if Trim(TEdit(Sender).Text) <> '' then
      Try
        TEdit(Sender).Text := StrZero(StrToInt(Trim(TEdit(Sender).Text)), vTamanho);
      Except
      end;
  end

  else
    if Sender is TDBEdit then
    begin
      if Trim(TDBEdit(Sender).Field.Text) <> '' then
        Try
          if vTamanho <> 0 then
            TDBEdit(Sender).Field.Text := StrZero(StrToInt(Trim(TDBEdit(Sender).Text)),
                                                           vTamanho)
          else
            TDBEdit(Sender).Field.Text := StrZero(StrToInt(Trim(TDBEdit(Sender).Text)),
                                                           TDBEdit(Sender).Field.Size);
        Except
        end;
    end;
end;


function FinalMenorQueInicial(vInicial, vFinal: TWinControl; vMensagem: String; vFocalizarInicial: Boolean): Boolean;
var
  S: String;
begin

  if (vInicial is TDateEdit) then
    Result := TDateEdit(vInicial).Date > TDateEdit(vFinal).Date
  else
    Result := TEdit(vInicial).Text > TEdit(vFinal).Text;

  if Result then
  begin
    // Põe a primeira letra em maiúsculo.
    S := UpperCase(Copy(vMensagem, 1, 1));
    S := S + Trim(Copy(vMensagem, 2, Length(vMensagem)));  
    MensagemDlg(S + ' final menor que ' + vMensagem + ' inicial.', mtErro, mbOk);
    
    if vFocalizarInicial then
      vInicial.SetFocus
    else
      vFinal.SetFocus;
  end;

end;


function FindWinControlByTag(vClasse: TClass; vForm: TForm; vTag: Integer): TWinControl;
var
  i: Integer;
begin

  Result := nil;

  with vForm do
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is vClasse) and
         (TWinControl(Components[i]).Tag = vTag) then
      begin
        Result := TWinControl(Components[i]);
        Break;
      end;

end;


procedure EventoEditBuscaChange(Sender: TObject; vForm: TForm);

    function EstaVazio: Boolean;
    begin

      if (Sender Is TEdit) or (Sender is TDBEdit) then
        Result := Trim(TEdit(Sender).Text) = ''

      else if Sender is TDateEdit then
        Result := Pos(' ', TDateEdit(Sender).Text) <> 0

      else if Sender is TTimeEdit then
        Result := Pos(' ', TTimeEdit(Sender).Text) <> 0

      else if Sender is TMaskEdit then
      begin
        Result := (Pos('_', TMaskEdit(Sender).EditText) <> 0) or (Trim(TMaskEdit(Sender).Text) = '');
      end
      else if Sender is TNumEdit then
        Result := TNumEdit(Sender).Value = 0
      else
        Result := false;
    end;


var
  vHabilitar: Boolean;
  vWinControl: TWinControl;
begin

  try
    vHabilitar := true;
    (*
    if (Sender is TDBEdit) or
       (Sender is TDBComboBox) or
       //(Pos('TDBTIMEEDIT', TObject(Sender).ClassName) <> 0) or
       //(Sender is TDBDateEdit) or
       (Sender is TDBLookUpComboBox) then
    begin
      vHabilitar := (TDBEdit(Sender).DataSource.Enabled) and
                    (TDBEdit(Sender).DataSource.DataSet.State in [dsEdit, dsInsert]);
      TDBEdit(Sender).Enabled := vHabilitar;
    end;
    *)

    if (Sender is TDBEdit) then
      vHabilitar := (TDBEdit(Sender).DataSource.Enabled) and
                    (TDBEdit(Sender).Enabled);

    vWinControl := FindWinControlByTag(TSpeedButton, vForm, TWinControl(Sender).Tag);
    if vWinControl <> nil then
      vWinControl.Enabled := EstaVazio and vHabilitar;
  except
  end;

end;


procedure HabilitarComponente(Sender: TWinControl; Habilitar: Boolean; AtribuirValor: String = 'NAOATRIBUIRVALOR');
begin

  try
    if Sender <> nil then
      Sender.Enabled := Habilitar;
  except
  end;

  try
    if Habilitar then
      TEdit(Sender).Color := clWindow
    else
      TEdit(Sender).Color := clBtnFace;
  except
  end;

  if ((Sender is TEdit) or
      (Sender is TMaskEdit))
      and
     (AtribuirValor <> 'NAOATRIBUIRVALOR') then
     TEdit(Sender).Text := AtribuirValor;
end;


function SaiuComSetaParaBaixo(Sender: TObject; Key: Word; vValor: String = ''; vForm: TForm = nil): Boolean;

    function EstaVazio: Boolean;
    begin

      if (Sender Is TEdit) or (Sender is TDBEdit) then
        Result := Trim(TEdit(Sender).Text) = ''

      else if Sender is TDateEdit then
        Result := Pos(' ', TDateEdit(Sender).Text) <> 0

      else if Sender is TTimeEdit then
        Result := Pos(' ', TTimeEdit(Sender).Text) <> 0

      else if Sender is TMaskEdit then
        Result := Pos('_', TMaskEdit(Sender).EditText) <> 0

      else if Sender is TNumEdit then
        Result := TNumEdit(Sender).Value = 0
      else
        Result := false;
    end;



    procedure AtribuirValor;
    begin

      try
        if (Sender Is TEdit) then
          TEdit(Sender).Text := vValor

        else if (Sender is TDBEdit) then
          TDBEdit(Sender).Field.AsString := vValor

        else if Sender is TDateEdit then
          TDateEdit(Sender).Text := vValor

        else if Sender is TTimeEdit then
          TTimeEdit(Sender).Text := vValor

        else if Sender is TMaskEdit then
          TMaskEdit(Sender).Text := vValor

        else if Sender is TNumEdit then
          TNumEdit(Sender).Text := vValor;
       except
       end;
    
    end;


begin
  Result := (Key = VK_DOWN) and
            ( (Sender Is TEdit) or
              (Sender Is TMaskEdit) or
              (Sender Is TNumEdit) or
              (Sender Is TDateEdit) or
              (Sender Is TTimeEdit) or
              (Sender Is TDBEdit)
            ) and
            (EstaVazio);

  // Atribui o valor
  if (Result) and (vValor <> '') then
    AtribuirValor;

  /// Tenta localizar o SpeedButton atrelado ao Sender para desabilitá-lo
  if (Result) and (vForm <> nil) then

    //// Este bloco é para evitar Access Violation
    try
      Sender := FindWinControlByTag(TSpeedButton, vForm, TWinControl(Sender).Tag);
      if Sender <> nil then
        TSpeedButton(Sender).Enabled := false;
    except
    end;
    //////

end;


function FocoProximoControle(Ativo, Atual: TWinControl; vExcetoTabOrder: Integer = -1; vExcetoControle: TWinControl = nil): Boolean;
begin

  try

    if (Ativo = vExcetoControle) or
       (Ativo.Parent.TabOrder = vExcetoTabOrder) then
      Result := false

    else
      // Se pertencem ao mesmo painel, form, etc...
      if (Ativo.Parent = Atual.Parent) then
        Result := (Ativo.TabOrder > Atual.TabOrder)
      else

      begin

        if (TWinControl(Ativo.Parent).Parent = TWinControl(Atual.Parent).Parent) then
          Result := (Ativo.Parent.TabOrder > Atual.Parent.TabOrder)
        else if (Ativo.Parent = TWinControl(Atual.Parent).Parent) then
          Result := (Ativo.TabOrder > Atual.Parent.TabOrder)
        else if (TWinControl(Ativo.Parent).Parent = Atual.Parent) then
          Result := Ativo.Parent.TabOrder > Atual.TabOrder
        else
          Result := false;

      end;

  except
    Result := false;
  end;

end;


Function ProximoNumero(pTabela,pCampo : String ; pCondicao:String=''; pZero:Integer=0; pIgnoraControle : Boolean =False) : String ;
var
  qrySQL: TQuery;

    function CodigoCadAutomatico: Boolean;
    begin

      with qrySQL Do
      Begin
        Close;
        Sql.Clear;
        Sql.Add('SELECT CODIGOCADAUTOMATICO FROM CTR_PARAMETROS');
        Open;
        Result := FieldByName('CODIGOCADAUTOMATICO').asString = 'S';
        Close;
      End;
    end;

Begin

  qrySQL := TQuery.Create(Nil);

  With qrySQL Do
  Begin
    DatabaseName := cDatabaseName;

    If (Not pIgnoraControle) And (Not CodigoCadAutomatico) Then
    Begin
      Result := '' ;
      // Exit ;
    End  // If (Not pIgnoraControle) And (...

    else

    begin
      Close ;
      Sql.Clear ;
      Sql.Add('SELECT NVL(MAX('+pCampo+'),0)+1 AS PROXIMONUMERO FROM ' + pTabela + IIf(pCondicao='','',' WHERE ' + pCondicao));
      Open ;
      Result := StrZero(FieldByName('PROXIMONUMERO').AsInteger, pZero) ;
    end;

    Free;
  End ; // With... 

End ;

Function ProximaLinha_RdPrint(pLinha, pRdPrint : Pointer) : Integer;
Var
  vLinha : ^Integer;
begin
  vLinha := pLinha;
  Inc(vLinha^);
  If vLinha^ > (TRDprint(pRdPrint^).TamanhoQteLinhas) - (TRDprint(pRdPrint^).Tag + 4) Then
  begin
    TRDprint(pRdPrint^).NovaPagina;
    Inc(vLinha^);
  end;
//  pLinha := vLinha; Gerava hint - Silvio
  Result := vLinha^;
end;

Function FormataCNPJCPF(pString, pTipo : String): String;
begin
  If pTipo = 'CNPJ' then
    Result := copy(pString,1,2) + '.' +
              copy(pString,3,3) + '.' +
              copy(pString,6,3) + '/' +
              copy(pString,9,4) + '-' +
              copy(pString,13,2)
  else
  If pTipo = 'CPF' then
    Result := copy(pString,1,3) + '.' +
              copy(pString,4,3) + '.' +
              copy(pString,7,3) + '-' +
              copy(pString,10,2)
  else
    Result := pString;
end;


function GetIndiceArray(vTipo: String; vArray: Array of String): Integer;
var
  i: Integer;
begin

  Result := Low(vArray);

  for i := Low(vArray) to High(vArray) do
    if vArray[i] = vTipo then
    begin
      Result := i;
      Break;
    end;

end;



Function UsuarioLogadoAPE(pAplicacao, pLoginGlobus: String): boolean;
var
  qry : TQuery;
begin

  qry:= TQuery.Create(Application);

  with qry do
  begin
    databaseName := vcDatabase.name;
    close;
    sql.Clear;
    sql.add(' SELECT COUNT(*) QTD FROM ' + cTabelaDeLicencas);
    sql.add(' WHERE APLICACAO =:P0 AND USUARIOGLOBUS=:P1 ');
    parambyname('P0').asString := pAplicacao;
    parambyname('P1').asString := UpperCase(pLoginGlobus);
    open;
    result := Fieldbyname('QTD').asInteger > 1;
    close;
    free;
  end; // with qry

end;

Procedure AtualizarUsuarioAPE(pAplicacao, pEstacao, pLoginWin, pLoginGlobus: String);
var
  qry : TQuery;
begin

  if dm.DbBGM.InTransaction then
    dm.DbBGM.Rollback;

  dm.DbBGM.StartTransaction;

  qry:= TQuery.Create(Application);

  with qry do
  begin
    databaseName := vcDatabase.name;
    close;
    sql.Clear;
    sql.add(' UPDATE ' + cTabelaDeLicencas + ' SET USUARIOGLOBUS=:P0 ');
    sql.add(' WHERE APLICACAO=:P1 AND ESTACAO=:P2 AND USUARIOWIN=:P3 ');
    parambyname('P0').asString := UpperCase(pLoginGlobus);
    parambyname('P1').asString := pAplicacao;
    parambyname('P2').asString := pEstacao;
    parambyname('P3').asString := UpperCase(pLoginWin);
    try
      execsql;
      dm.DbBGM.Commit;
    except
      dm.DbBGM.Rollback;
    end;
    free;
  end; // with qry Do

end;

function relatorioEncerradoARR(Form: TCustomForm): boolean;
type
  TDatas = Array[0..1] Of String;
var
  vQtdDias: integer;
  vData: TDateTime;

  function retornaDatas:TDatas;
  var
    i, j, x: integer;
    vAno, vMes : String;
  begin

    try
      x    := 0;
      for i := 1 to Form.ComponentCount  do
      begin

        if TwinControl(Form.Components[i-1]).ClassType = TGroupBox then
          for j := 1 to TGroupBox(Form.Components[i-1]).ControlCount do
          begin

            if  (x < 2)  and (TwinControl( TGroupBox(Form.Components[i-1]).Controls[j-1] ).ClassType= TDateEdit) then
            begin
              result[x] := TEdit(TGroupBox(Form.Components[i-1]).Controls[j-1] ).text;
              x := x + 1;
            end;

            if (x < 2) and (TwinControl( TGroupBox(Form.Components[i-1]).Controls[j-1] ).ClassType =
             TMaskEdit ) and (copy(TMaskEdit( TGroupBox(Form.Components[i-1]).Controls[j-1] ).editMask,1,7) = '99/9999') then
            begin
              vAno := copy(TMaskEdit(TGroupBox(Form.Components[i-1]).Controls[j-1]).text, 4, 4);
              vMes := copy(TMaskEdit(TGroupBox(Form.Components[i-1]).Controls[j-1]).text, 1, 2);

              result[0] :=  '01/' + vMes + '/' + vAno;
              result[1] :=  datetostr(TrazUltimoDiaDoMesAtual('01/'+ vMes+ '/' + vAno));
              x := 2;
            end;

          end; // for j := 1 to TGroupBox(

        if (x < 2) and (TwinControl(Form.Components[i-1]).ClassType = TGlbDateFilter) then
        begin
          result[0] := TGlbDateFilter(Form.Components[i-1]).textIni;

          if trim(TGlbDateFilter(Form.Components[i-1]).textEnd) <> '/  /' then
            result[1] := TGlbDateFilter(Form.Components[i-1]).textEnd;

          x := 2;
        end;

      end;  // for i := 1 to Form.ComponentCount  do
    except
    end;

  end; // procedure retornaDatas

  function temParametrosDeEncerramento: Boolean;
  var
    QrySql: TQuery;
  begin
    QrySql := TQuery.Create(Application);
    with qrySql do
    begin
      DatabaseName:= vcDatabase.name;
      close;
      sql.clear;
      sql.add('SELECT DATAENCERRAMENTO, QTDDIAS FROM T_ARR_ENCERRAMENTO_RELATORIO ');
      sql.add('WHERE USUARIO=:P0 AND RELATORIO=:P1 ');
      parambyname('P0').asString:= vcUsuario;
      parambyname('P1').asString:= vcItemDeMenuChamadorARR;
      getsql(qrysql);
      open;
      result  := not eof;
      vQtdDias:= fieldbyname('QTDDIAS').asinteger;
      vData   := fieldbyname('DATAENCERRAMENTO').asDateTime;
      close;
      free;
    end;
  end; // function temParametrosDeEncerramento...

  function dataEncerrada(pDatas: TDatas): Boolean;
  begin
       // a qtd de dias pretere sobre a data de encerramento
      if vQtdDias > 0 then
        vData := now - vQtdDias;


      if ( pDatas[1]= '') or (pDatas[0]= pDatas[1] ) then
        result :=  strtodate(pDatas[0])<= vData
      else
        if ( vData >= strtodate(pDatas[0]) ) and ( vData<= strtodate(pDatas[1]) ) or
             ( vData >= strtodate(pDatas[1]) ) then
          result := True
        else
          result := False;

  end; // function dataEncerrada.....


begin

  result := False;

  if temParametrosDeEncerramento then
    if dataEncerrada(retornaDatas) then
    begin
      mensagemDlg('Período encerrado para emissão do relatório.', mtAtencao, mbOk);
      result:= True;
    end;
end;

{retirado o parâmetro de empresa e filial, pois dava erro quando a conta utilizada era compartilhada e pertencia a outra filial que não a do documento - Marta - SIM 10668 }
//Function VerificaPeriodoBancario(pempresa, pfilial, pbanco, pagencia: Integer; pConta : String; pData : TdateTime ) : Boolean;
Function VerificaPeriodoBancario(pbanco, pagencia: Integer; pConta : String; pData : TdateTime ) : Boolean;
var  qrPeriodo : TQuery;
begin
  qrPeriodo              := TQuery.Create( Application );
  qrPeriodo.DataBaseName := cDatabaseName;

  Result    := True;
  With qrPeriodo do
  begin
    Close; { Verifica se o período esta aberto, para fazer a integração. Se não estiver não haverá integração }
    sql.clear;
    sql.add('SELECT DTLIMITEMOVTO FROM BCOCONTA ');
    sql.add('WHERE CODCONTABCO = :P_CONTA   AND ');
    sql.add('      CODAGENCIA  = :P_AGENCIA AND ');
    sql.add('      CODBANCO    = :P_BANCO       ');
(*    If not VerificaSeCompartilhaContas(pEmpresa,pFilial)then
    Begin
      sql.add('    CODIGOFL    = :P_FILIAL  AND ');
      ParamByName('p_filial' ).AsInteger := pFilial;
    End;
    sql.add('      CODIGOEMPRESA = :P_EMPRESA   ');  *)
    ParamByName('p_conta'  ).AsString  := pConta;
    ParamByName('p_agencia').AsInteger := pAgencia;
    ParamByName('p_banco'  ).AsInteger := pBanco;
//    ParamByName('p_Empresa').AsInteger := pEmpresa;
    Open;
    If isEmpty then
    Begin
      mensagemDLG( 'Conta não cadastrada.', mtErro, mbOK );
      Result := False;
    End

    Else If FieldByName('DTLIMITEMOVTO').AsDateTime >= pData then
    begin
      mensagemDLG( 'Não aceita movimentação para data menor que a data limite da conta.', mtErro, mbOK );
      Result := False;
    end;
    Free;
  end;
end;

Function VerificaSeDoctoBancarioJaExiste(pbanco, pagencia : Integer; pConta, pDocumento: String; pData : TdateTime = 0) : Boolean;
var qrInsert : TQuery;
begin
  qrInsert              := TQuery.Create( Application );
  qrInsert.DataBaseName := cDatabaseName;
  Result                := True;

  With qrInsert do
  begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT DOCMOVTOBCO FROM BCOMOVTO  ' );
    SQL.Add( ' WHERE DOCMOVTOBCO = :P_DOCUMENTO'  );
    SQL.Add( ' AND CODCONTABCO = :P_CONTA'        );
    SQL.Add( ' AND CODAGENCIA  = :P_AGENCIA'      );
    SQL.Add( ' AND CODBANCO    = :P_BANCO'        );
    If pdata <> 0 then
    Begin
      SQL.Add( ' AND DTMOVTOBCO = :P_DATA'        );
      ParamByName('p_data').AsDateTime := pData;                                            
    end;
    ParamByName('p_conta'    ).AsString   := pConta;
    ParamByName('p_agencia'  ).AsInteger  := pAgencia;
    ParamByName('p_banco'    ).AsInteger  := pBanco;
    ParamByName('p_documento').AsString   := pDocumento;
    open;
    If not IsEmpty then
    begin
      result := False;
      MensagemDlg('Documento já cadastrado na movimentação bancária.', mtinformacao, mbok);
      Exit;
    end;
  end;
end;

Function EfetuaIntegracaoComBancos(pempresa, pfilial, pbanco, pagencia, phistorico : Integer; pConta, pComplHist, pTpDespesa, pTpReceita, pDocumento, pTipoPagtoIni, pTipoPagtoFin : String;
                                   pData : TdateTime; pValor : Double; pProximo : boolean = False; pCodLanca : Integer = 0;
                                   pConfirmadoMovtoBCO : String = 'S'; pConciliadoMovtoBCO : String = 'N'; pDataEfetiva : TDateTime = 0) : TRetornoDadosBancariosAposIntegracao;
var qrInsert : TQuery;
begin
  qrInsert              := TQuery.Create( Application );
  qrInsert.DataBaseName := cDatabaseName;

  Result.CodMovtoBCO := 0;
  Result.DoctoBCO    := '';

{retirado o parâmetro de empresa e filial, pois dava erro quando a conta utilizada era compartilhada e pertencia a outra filial que não a do documento - Marta - SIM 10668 }
//  If Not VerificaPeriodoBancario(pEmpresa, pFilial, pBanco, pAgencia, pConta, pData) then
  If Not VerificaPeriodoBancario(pBanco, pAgencia, pConta, pData) then
    Exit;

  If pProximo then
    pDocumento := pTipoPagtoIni + BCOProximoDocto(pBanco, pAgencia, pConta, pTipoPagtoIni, pTipoPagtoFin, pData )
  else
  begin
    If not VerificaSeDoctoBancarioJaExiste(pBanco, pAgencia, pConta, pDocumento, pData) then
      exit;

    (*With qrInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Add( 'SELECT DOCMOVTOBCO FROM BCOMOVTO  ' );
      SQL.Add( ' WHERE DOCMOVTOBCO = :P_DOCUMENTO'  );
      SQL.Add( ' AND CODCONTABCO = :P_CONTA'        );
      SQL.Add( ' AND CODAGENCIA  = :P_AGENCIA'      );
      SQL.Add( ' AND CODBANCO    = :P_BANCO'        );
      ParamByName('p_conta'    ).AsString   := pConta;
      ParamByName('p_agencia'  ).AsInteger  := pAgencia;
      ParamByName('p_banco'    ).AsInteger  := pBanco;
      ParamByName('p_documento').AsString   := pDocumento;
      open;
      If not IsEmpty then
      begin
        MensagemDlg('Documento já cadastrado na movimentação bancária.', mtinformacao, mbok);
        Exit;
      end;
    end;*)
  end;

  With qrInsert do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'INSERT INTO BCOMOVTO' );
    SQL.Add( ' (CODMOVTOBCO, SISTEMA, CODIGOEMPRESA, CODIGOFL, CODBANCO, CODAGENCIA,      ');
    SQL.Add( '  CODCONTABCO, DTMOVTOBCO, DOCMOVTOBCO,CODHISTOBCO, HISTMOVTOBCO,           ');
    SQL.Add( '  VLMOVTOBCO, CONFIRMADOMOVTOBCO, CONCILIADOMOVTOBCO,                       ');
    SQL.Add( '  DTEFETIVAMOVTOBCO, STATUSMOVTOBCO, VLEMDINHEIROCQBCO, USUARIO,            ');
    SQL.Add( '  CODTPDESPESA, CODTPRECEITA, CODLANCA )                                    ');
    SQL.Add( '  VALUES( :P_CODMOVTOBCO, :P_SISTEMA, :P_CODIGOEMPRESA, :P_CODIGOFL,        ');
    SQL.Add( '  :P_CODBANCO, :P_CODAGENCIA, :P_CODCONTABCO, :P_DTMOVTOBCO, :P_DOCMOVTOBCO,');
    SQL.Add( '  :P_CODHISTOBCO, :P_HISTMOVTOBCO, :P_VLMOVTOBCO, :P_CONFIRMADOMOVTOBCO,    ');
    SQL.Add( '  :P_CONCILIADOMOVTOBCO, :P_DTEFETIVAMOVTOBCO, :P_STATUSMOVTOBCO,           ');
    SQL.Add( '  :P_VLEMDINHEIROCQBCO, :P_USUARIO, :P_CODTPDESPESA, :P_CODTPRECEITA,       ');
    SQL.Add( '  :P_CODLANCA )                                                             ');
    Result.CodMovtoBCO    := TrazProximoCodMovto;
    paramByName('P_CODMOVTOBCO'        ).AsInteger   := Result.CodMovtoBCO;
    paramByName('P_SISTEMA'            ).AsString    := vcSistema;
    paramByName('P_CODIGOEMPRESA'      ).AsInteger   := pEmpresa;
    paramByName('P_CODIGOFL'           ).AsInteger   := pFilial;
    paramByName('P_CODBANCO'           ).AsInteger   := pBanco;
    paramByName('P_CODAGENCIA'         ).AsInteger   := pAgencia;
    paramByName('P_CODCONTABCO'        ).AsString    := pConta;
    paramByName('P_DTMOVTOBCO'         ).AsDateTime  := pData;

    paramByName('P_DOCMOVTOBCO'        ).AsString    := pDocumento;

    paramByName('P_CODHISTOBCO'        ).AsInteger   := phistorico;

    paramByName('P_HISTMOVTOBCO'       ).AsString   := Copy(pComplHist,1,100);
    paramByName('P_VLMOVTOBCO'         ).AsFloat    := pValor ;
    paramByName('P_CONFIRMADOMOVTOBCO' ).AsString   := pConfirmadoMovtoBCO;//'S';
    paramByName('P_CONCILIADOMOVTOBCO' ).AsString   := pConciliadoMovtoBCO;//'N';
    paramByName('P_DTEFETIVAMOVTOBCO'  ).AsDateTime := IIF(pDataEfetiva = 0, pData, pDataEfetiva);
    paramByName('P_STATUSMOVTOBCO'     ).AsString   := 'N';
    paramByName('P_VLEMDINHEIROCQBCO'  ).AsFloat    := 0  ;
    paramByName('P_USUARIO'            ).AsString   := vcUsuario;
    paramByName('P_CODTPDESPESA'       ).AsString   := pTpDespesa;
    paramByName('P_CODTPRECEITA'       ).AsString   := pTpReceita;
    paramByName('P_CODLANCA'           ).AsString   := IIF(pCodLanca = 0, '',pCodLanca);
    Try
      execSQL;
    except on E:EDBEngineError do
      Begin
        Result.CodMovtoBCO := 0;
        Result.DoctoBCO    := '';
        dm.DbBGM.RollBack;
        If mensagemDLG( 'Problemas durante a geração do lançamento. Deseja ver o erro ?'
                        , mtConfirmacao, mbSIM+mbNAO ) = mrSIM then mensagemDLG( MostraErrosQuery(E, False), mtErro, mbOK );
        exit;
      end;
    end;  // Try
    Result.DoctoBCO := pDocumento;
    Free;
  end;
end;

Function BCOProximoDocto(pBanco, pAgencia : integer; pConta, pTipoPagtoIni, pTipoPagtoFin : String; pData : TDateTime = 0) : String;
var  qrProximoBCO : TQuery;
begin
  qrProximoBCO              := TQuery.Create( Application );
  qrProximoBCO.DataBaseName := cDatabaseName;

  With qrProximoBCO do
  Begin
    Close;
    SQL.Clear;

(*
    Verifiquei nos backup de janeiro/2005 e em nenhum fonte que calcula o próximo com o MAX. portanto não é necessário a linha abaixo.

    SQL.Add( 'SELECT MAX(TO_NUMBER(SUBSTR(DOCMOVTOBCO,4,7))) +1 AS NEXTNUMBER FROM BCOMOVTO' );

    Verônica 23/02/2005

*)
    SQL.Add( 'SELECT TO_NUMBER(SUBSTR(DOCMOVTOBCO,'+ IIf(pTipoPagtoFin = 'COB-','5','4') + ',7)) +1 AS NEXTNUMBER' );
    SQL.Add( ' FROM BCOMOVTO WHERE ');

    If (pTipoPagtoIni <> 'CQ-') and (pTipoPagtoIni <> 'BO-') and (pTipoPagtoIni <> 'PE-') and (pTipoPagtoIni <> 'BL-') then
      SQL.Add( ' SUBSTR(DOCMOVTOBCO,10,1) BETWEEN ''0'' AND ''9'' AND '                );

    SQL.Add( ' SUBSTR(DOCMOVTOBCO,9,1) BETWEEN ''0'' AND ''9'''                        );
    SQL.Add( ' AND SUBSTR(DOCMOVTOBCO,8,1) BETWEEN ''0'' AND ''9'''                    );
    SQL.Add( ' AND SUBSTR(DOCMOVTOBCO,7,1) BETWEEN ''0'' AND ''9'''                    );
    SQL.Add( ' AND SUBSTR(DOCMOVTOBCO,6,1) BETWEEN ''0'' AND ''9'''                    );
    SQL.Add( ' AND SUBSTR(DOCMOVTOBCO,5,1) BETWEEN ''0'' AND ''9'''                    );
    If pTipoPagtoFin = 'COB-' then
      SQL.Add( ' AND SUBSTR(DOCMOVTOBCO,1,4) BETWEEN ''' + pTipoPagtoIni + ''' And ''' + pTipoPagtoFin + '''')
    else
    begin
      SQL.Add( ' AND SUBSTR(DOCMOVTOBCO,4,1) BETWEEN ''0'' AND ''9'''                    );
      SQL.Add( ' AND SUBSTR(DOCMOVTOBCO,1,3) BETWEEN ''' + pTipoPagtoIni + ''' And ''' + pTipoPagtoFin + '''');
    end;
    SQL.Add( ' AND CODCONTABCO = :P_CONTA'                                             );
    SQL.Add( ' AND CODAGENCIA  = :P_AGENCIA'                                           );
    SQL.Add( ' AND CODBANCO    = :P_BANCO'                                             );
    If pdata <> 0 then
    Begin
      SQL.Add( ' AND DTMOVTOBCO = :P_DATA');
      ParamByName('p_data').AsDateTime := pData;
    end;
    If (pTipoPagtoIni = 'CQ-') OR (pTipoPagtoIni = 'BO-') then { Só pega pelo codmovtobco quando for cheque e bordero }
      SQL.Add( ' ORDER BY CODMOVTOBCO DESC'                                            )
    else
      SQL.Add( ' ORDER BY NEXTNUMBER DESC'                                             );

    ParamByName('p_conta'  ).AsString   := pConta;
    ParamByName('p_agencia').AsInteger  := pAgencia;
    ParamByName('p_banco'  ).AsInteger  := pBanco;
    GetSql(qrProximoBCO);
    Open;
    //    If ( RecordCount > 0 ) and ( IntToStr( FieldByName( 'NEXTNUMBER' ).AsInteger ) <> '0' ) then
    If  not IsEmpty then
      Result := StrZero( FieldByName( 'NEXTNUMBER' ).AsInteger, IIF(pTipoPagtoIni <> 'CX-',6, 7 ))
    else
      Result := StrZero( 1,IIF(pTipoPagtoIni <> 'CX-',6, 7 ));
    Free;
  end;
end;


Function CancelaIntegracaoComBancos(pCodMovtoBco : Integer; pData : TDateTime) : TRetornoProblemasIntegracaoBCO;
var
  qrInsert : TQuery;
  vConteudoTroco : String;

begin
  qrInsert              := TQuery.Create( Application );
  qrInsert.DataBaseName := cDatabaseName;

  With qrInsert do
  Begin
    //Incializa possiveis erros
    Result.PeriodoFechado   := False;
    Result.ExisteMovtoBco   := False;
    Result.OutrosProblemas  := False;

    //Busca dados do BCO
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM  BCOMOVTO' );
    SQL.Add( 'WHERE CODMOVTOBCO = :P_CODMOVTOBCO');
    ParamByName('P_CodMovtoBCO').AsInteger := pCodMovtoBCO;
    Open;
    If not isEmpty then
    Begin
      Result.ExisteMovtoBco := True;
      vConteudoTroco := FieldByName('HISTMOVTOBCO').AsString;

      If not VerificaPeriodoBancario({FieldByName('CODIGOEMPRESA').AsInteger,
                                 FieldByName('CODIGOFL'     ).AsInteger,}
                                 FieldByName('CODBANCO'     ).AsInteger,
                                 FieldByName('CODAGENCIA'   ).AsInteger,
                                 FieldByName('CODCONTABCO'  ).AsString, pData) then
      begin
        Result.PeriodoFechado := True;
        Exit;
      end;

      //Exclui movimento
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM  BCOMOVTO ');
      If Pos('TROCO',UpperCase(vConteudoTroco)) > 0 Then
      Begin
        { Se for o caso da conta troco, deleta os dois movto gerados, o de crédito e o de débito. }
        SQL.Add('WHERE CODMOVTOBCO IN ( :P_CODMOVTOBCO, :P_CODMOVTOBCO_2) ');
        ParamByName('P_CODMOVTOBCO_2').AsInteger := pCodMovtoBCO -1 ;
      End
      Else
        SQL.Add( 'WHERE CODMOVTOBCO = :P_CODMOVTOBCO');

      ParamByName('P_CodMovtoBCO').AsInteger := pCodMovtoBCO;
      Try
        execSQL;
      except on E:EDBEngineError do
        Begin
          dm.DbBGM.RollBack;
          If mensagemDLG( 'Problemas durante a exclusão do lançamento bancário. Deseja ver o erro ?'
                          , mtConfirmacao, mbSIM+mbNAO ) = mrSIM then
                          MostraErrosQuery(E, True);
//                          mensagemDLG( E.Errors[1].Message, mtErro, mbOK );
          Result.OutrosProblemas := True;
          exit;
        end;
      end;  // Try
    End; // If not isEmpty then
    Free;
  end;
end;

Procedure CGS_VerificaAtrelamentoVeiculos(pCodigoVeic : Integer);
var qrBusca : TQuery;
begin
  qrBusca              := TQuery.Create( Application );
  qrBusca.DataBaseName := cDatabaseName;

  with qrBusca do
  begin
    Close;
    sql.Clear;
    Sql.add('SELECT A.CODIGOVEIC    , V.PREFIXOVEIC PREFIXOVEICULO, C.PREFIXOVEIC PREFIXOCARRETA,    ');
    Sql.add('       A.CODIGOVEICCARR, TC.AGREGADOTPFROTA AS AGREGADOTPFROTA_CARR ,         ');
    Sql.add('       TV.AGREGADOTPFROTA AS AGREGADOTPFROTA_CAV                              ');
    Sql.add('FROM   FRT_ATRELAMENTOCAVALOCARRETA A, FRT_CADVEICULOS C  , FRT_CADVEICULOS V,');
    Sql.add('       FRT_TIPODEFROTA TC            , FRT_TIPODEFROTA TV                     ');
    Sql.add('WHERE  DATADESENGATE      IS NULL                      AND                    ');
    Sql.add('       (A.CODIGOVEIC      = :p_CodigoVeic OR A.CODIGOVEICCARR = :p_CodigoVeic) AND                    ');
    Sql.add('       (C.CODIGOVEIC       = A.CODIGOVEICCARR          AND                    ');
    Sql.add('       V.CODIGOVEIC       = A.CODIGOVEIC )             AND                    ');
    Sql.add('       C.CODIGOTPFROTA(+) = TC.CODIGOTPFROTA           AND                    ');
    Sql.add('       V.CODIGOTPFROTA(+) = TV.CODIGOTPFROTA                                  ');

    parambyName('p_CodigoVeic').AsInteger := pCodigoVeic;
    open;

    vcCavalo_Atrelamento    := '';
    vcCarreta1_Atrelamento  := '';
    vcCarreta2_Atrelamento  := '';
    vcIdCarr1_Atrelamento   := '';
    vcIdCarr2_Atrelamento   := '';
    vcIdCavalo_Atrelamento  := '';
    vcCodCavalo_Atrelamento := 0;
    vcCodCarr1_Atrelamento  := 0;
    vcCodCarr2_Atrelamento  := 0;

    While not Eof do
    begin
      vcCodCavalo_Atrelamento := FieldByName('CodigoVeic'    ).AsInteger;
      vcCavalo_Atrelamento    := FieldByName('PrefixoVeiculo').AsString;
      vcIdCavalo_Atrelamento  := IIF(FieldByName('AGREGADOTPFROTA_CAV').AsString = 'S','E','I');
      If vcCarreta1_atrelamento = '' then
      begin
        vcCarreta1_atrelamento := FieldByName('PrefixoCarreta').AsString;
        vcCodCarr1_atrelamento := FieldByName('CodigoVeicCarr').AsInteger;
        vcIdCarr1_atrelamento  := IIF(FieldByName('AGREGADOTPFROTA_CARR').AsString = 'S','E','I');
      end
      else
      begin
        vcCarreta2_atrelamento := FieldByName('PrefixoCarreta').AsString;
        vcCodCarr2_atrelamento := FieldByName('CodigoVeicCarr').AsInteger;
        vcIdCarr2_atrelamento  := IIF(FieldByName('AGREGADOTPFROTA_CARR').AsString = 'S','E','I');
      end;
      Next;
    end;
    Free;
  end;
end;

Function CGS_VerificaParametrosLocais(pEmpresa, pFilial, pGaragem : Integer) : Boolean;
var qrBusca : TQuery;
begin
  qrBusca              := TQuery.Create( Application );
  qrBusca.DataBaseName := cDatabaseName;

  Result   := True;

  With qrBusca do
  begin
    Close;
    sql.clear;
    sql.add('SELECT * FROM PBA012           ');
    SQL.ADD('WHERE GARAGEM = :P_GARAGEM AND ');
    SQL.ADD('FILIAL = :P_FILIAL AND         ');
    SQL.ADD('EMPRESA = :P_EMPRESA           ');
    ParamByName('p_garagem').AsInteger := pGaragem;
    ParamByName('p_filial' ).AsInteger := pFilial;
    ParamByName('p_empresa').AsInteger := pEmpresa;
    Open;
    If IsEmpty then
    begin
      MensagemDlg('Parâmetro não cadastrado.', MtInformacao, mbok);
      Result := False;
      exit;
    end;
    vcSiglaFilial                   := FieldByName('SIGLA_FILIAL'             ).AsString;
    vcControlaEstoque               := FieldByName('FLAG_ESTOQUE'             ).AsString;
    vcControlaCaixa                 := FieldByName('FLAG_CAIXA'               ).AsString;
    vcBaixaServicosPagosaVista      := FieldByName('FLAG_A_VISTA'             ).AsString;
    vcUtilizaOperacaoRemota         := FieldByName('OPERACAO_REMOTA'          ).AsString;
    vcFreteCombinado                := FieldByName('FRETE_COMBINADO'          ).AsString;
    vcTaxaColetaEntrega             := FieldByName('COLETA_ENTREGA'           ).AsString;
    vcComissaoPorFrete              := FieldByName('COMISSAOPORFRETE'         ).AsString;
    vcTaxasDeServicos               := FieldByName('UTIL_TAXASDESERVICOS'     ).AsString;
    vcValidaDoctosVeiculos          := FieldByName('VALIDA_DOCTO_VEIC'        ).AsString;
    vcValidaCursosObrigatorios      := FieldByName('VALIDA_CURSOS'            ).AsString;
    vcAnalisaCredito                := FieldByName('ANALISACREDITO'           ).AsString;
    vcBloqueiaPelaSituacaoCliente   := FieldByName('BLOQSITCLIENTE'           ).AsString;
    vcAnalisaOS                     := FieldByName('ANALISAOS'                ).AsString;
    vcBloqueiaPorOS                 := FieldByName('BLOQUEIAOS'               ).AsString;
    vcAnalisaExigenciasDeClientes   := FieldByName('ANALISEEXIGCLIENTES'      ).AsString;
    vcBloqueiaDoctosVeiculos        := FieldByName('BLOQUEIA_DOCTO_VEIC'      ).AsString;
    vcVerificaAtrelamento           := FieldByName('VERIFICA_ATRELAMENTO'     ).AsString;
    vcBloqueiaDoctosSemtabela       := FieldByName('BLOQUEIADOCTOSEMTABELAS'  ).AsString;
    vcBloqueia_ActGeradaSemRota     := FieldByName('BLOQUEIA_ACTGERADASEMROTA').AsString;
    vcValidaDoctosMotorista         := FieldByName('ALERTACNH'                ).AsString;
    vcBloqueiaDoctosMotorista       := FieldByName('BLOQUEIACNH'              ).AsString;
    vcBloqueia_CursosObrigatorios   := FieldByName('BLOQUEIA_CURSOSOBRIGATORIOS').AsString;
    Free;
  end;
end; 

Function CGS_VerificaDocumentosVeiculoEmDVS(pEmpresa, pFilial, pGaragem, pCodigoVeic : Integer; pData : TDateTime; pProduto : Integer = 0; pValidaProduto : Boolean = False) : Boolean;
var qrBusca : TQuery;
begin
  qrBusca              := TQuery.Create( Application );
  qrBusca.DataBaseName := cDatabaseName;

  Result   := True;

  If not CGS_VerificaParametrosLocais(pEmpresa, pFilial, pGaragem) then
  begin
    Result := False;
    Exit;
  end;

  If (vcValidaDoctosVeiculos = 'S') Or (vcBloqueiaDoctosVeiculos = 'S') then
  begin
    With qrBusca do
    begin
      Close;
      sql.clear;
      sql.add('SELECT D.CODIGOEMPRESA, D.CODIGOFL, D.NUMERODOC, D.CODIGOVEIC, T.DESCRICAOTPDOC, ');
      sql.add('T.FLGDOCTOOBRIGATORIO, V.VALIDADEVISTORIA, I.NRODOCUMENTO, I.DTVENCIMENTO,T.CODIGOTPDOC ');
      sql.add('FROM DVS_DOCUMENTO D, DVS_TIPODOCTO T, DVS_VISTORIA V, DVS_INSPECAOPRODPERIGO I  ');
      sql.add('WHERE T.CODIGOTPDOC = D.CODIGOTPDOC AND                                          ');
      sql.add('V.CODIGOTPDOC = D.CODIGOTPDOC AND                                                ');
      sql.add('V.NUMERODOC = D.NUMERODOC AND                                                    ');
      sql.add('V.CODIGOVEIC = D.CODIGOVEIC AND                                                  ');
      sql.add('V.CODIGOFL = D.CODIGOFL AND                                                      ');
      sql.add('V.CODIGOEMPRESA = D.CODIGOEMPRESA AND                                            ');
      sql.add('I.NRODOCUMENTO(+) = D.NUMERODOC AND                                              ');
      sql.add('I.CODIGOVEIC(+) = D.CODIGOVEIC AND                                               ');
      sql.add('I.CODIGOTPDOC(+) = D.CODIGOTPDOC   AND                                            ');
      sql.add('D.CODIGOVEIC = :P_CODIGOVEIC AND                                                 ');
      sql.add('D.CODIGOFL = :P_FILIAL AND                                                       ');
      sql.add('D.CODIGOEMPRESA = :P_EMPRESA AND                                                 ');
      sql.add('V.VALIDADEVISTORIA = (                                                           ');
      sql.add('                      SELECT MAX(VALIDADEVISTORIA)                               ');
      sql.add('                      FROM DVS_VISTORIA C                                        ');
      sql.add('                      WHERE C.CODIGOTPDOC = D.CODIGOTPDOC AND                    ');
      sql.add('                            C.CODIGOEMPRESA = D.CODIGOEMPRESA AND                ');
      sql.add('                            C.CODIGOFL      = D.CODIGOFL AND                     ');
      sql.add('                            C.CODIGOVEIC    = :P_CODIGOVEIC      )               ');

      ParamByName('P_CodigoVeic').AsInteger := pCodigoVeic;
      ParamByName('P_Filial'    ).AsInteger := pFilial;
      ParamByName('P_Empresa'   ).AsInteger := pEmpresa;
      Open;
      While not eof do
      begin
        If Not pValidaProduto Then
        Begin
          If pData > FieldByName('VALIDADEVISTORIA').AsDateTime then
          begin
            MensagemDlg('Validade do documento ' + FieldByName('DESCRICAOTPDOC').AsString + ' nº ' +
            FieldByName('NUMERODOC').AsString + ' vencida.', mtAtencao, mbok);
            If (vcBloqueiaDoctosVeiculos = 'S') and (FieldByName('FLGDOCTOOBRIGATORIO').AsString = 'S') then
            begin
              Result := false;
              Exit;
            end;
          end;
        End;// If Not pValidaProduto Then
        If (FieldByName('NRODOCUMENTO').AsString <> '') and (pProduto <> 0) then
        begin
          If not CGS_VerificaInspecaoDoVeiculoEmDVS(pEmpresa, pFilial, pCodigoVeic, pProduto, FieldByName('CODIGOTPDOC').AsInteger, pData, FieldByName('NUMERODOC').AsString) then
          begin
            Result := false;
            Exit;
          end;
        end;
        Next;
      end;
      Free;
    end;
  end;
end;

Function CGS_VerificaInspecaoDoVeiculoEmDVS(pEmpresa, pFilial, pCodigoVeic, pProduto, pTipoDocto: Integer; pData : TDateTime; pNrDocto : String) : Boolean;
var qrInspecao : TQuery;
begin
  qrInspecao              := TQuery.Create( Application );
  qrInspecao.DataBaseName := cDatabaseName;

  Result   := True;

  With qrInspecao do
  begin
    Close;
    sql.clear;
    sql.add('SELECT D.NUMERODOC, T.DESCRICAOTPDOC, T.FLGDOCTOOBRIGATORIO,             ');
    sql.add('I.NRODOCUMENTO, I.DTVENCIMENTO,  T.CODIGOTPDOC                           ');
    sql.add('FROM DVS_DOCUMENTO D, DVS_TIPODOCTO T, DVS_INSPECAOPRODPERIGO I,         ');
    sql.add('DVS_ASSOCINSPECAO_GRUPOSPROD AGP, FRT_PRODUTO PF                         ');
    sql.add('WHERE T.CODIGOTPDOC = D.CODIGOTPDOC AND                                  ');
    sql.add('I.CODIGOVEIC(+) = D.CODIGOVEIC AND                                       ');
    sql.add('I.NRODOCUMENTO(+) = D.NUMERODOC AND                                      ');
    sql.add('I.CODIGOTPDOC(+) = D.CODIGOTPDOC AND                                     ');
    sql.add('AGP.NRODOCUMENTO = I.NRODOCUMENTO AND                                    ');
    sql.add('AGP.CODIGOVEIC = I.CODIGOVEIC AND                                        ');
    sql.add('AGP.CODIGOTPDOC = I.CODIGOTPDOC AND                                      ');
    sql.add('PF.CODIGOGRPPROD = AGP.CODIGOGRPPROD AND                                 ');
    sql.add('D.CODIGOVEIC = :P_CODIGOVEIC AND                                         ');
    sql.add('D.CODIGOFL      = :P_FILIAL AND                                          ');
    sql.add('D.CODIGOEMPRESA = :P_EMPRESA AND                                         ');
    sql.add('PF.CODIGOPROD   = :P_PRODUTO AND                                         ');
    sql.add('D.NUMERODOC     = :P_NRDOCTO AND                                         ');
    sql.add('D.CODIGOTPDOC   = :P_TIPODOCTO                                           ');

    ParamByName('P_CodigoVeic').AsInteger := pCodigoVeic;
    ParamByName('P_Filial'    ).AsInteger := pFilial;
    ParamByName('P_Empresa'   ).AsInteger := pEmpresa;
    ParamByName('P_Produto'   ).AsInteger := pProduto;
    ParamByName('P_TIPODOCTO' ).AsInteger := pTipoDocto;
    ParamByName('P_NRDOCTO'   ).AssTRING  := pNrDocto;

    Open;
    If Not IsEmpty Then
    Begin
      If FormatDateTime('YYYYMM',pData) > Copy(qrInspecao.FieldByName('DTVENCIMENTO').AsString,3,4) + Copy(FieldByName('DTVENCIMENTO').AsString,1,2) then
      begin
        MensagemDlg('A inspeção nº. ' + Trim(FieldbyName('NroDocumento').AsString) +
                    ' do documento '  + Trim(FieldbyName('DESCRICAOTPDOC').AsString) +
                    ' está vencida.', mtAtencao, mbok);
        If (vcBloqueiaDoctosVeiculos = 'S') and (FieldByName('FLGDOCTOOBRIGATORIO').AsString = 'S') then
        Begin
          Result := false;
          Exit;
        end;
      end;
    end;
    Free;
  end;
end;


Function CGS_VerificaCursosEmRH(pEmpresa, pFilial, pGaragem, pTipoVeic,pTipoCarreta1,pTipoCarreta2,  pCliente, pFuncao : Integer; pData : TDateTime; pMotorista : String)  : Boolean;
var
  qrBusca, qrCurso : TQuery;
begin
    qrBusca              := TQuery.Create( Application );
    qrBusca.DataBaseName := cDatabaseName;

    qrCurso              := TQuery.Create( Application );
    qrCurso.DataBaseName := cDatabaseName;
  Try

    Result   := True;

    If not CGS_VerificaParametrosLocais(pEmpresa, pFilial, pGaragem) then
    begin
      Result := False;
      Exit;
    end;

    If ((vcValidaCursosObrigatorios = 'S')  Or (vcBloqueia_CursosObrigatorios = 'S')) then
    begin
      With qrBusca do
      begin
        Close;
        sql.clear;
        sql.add('SELECT COUNT(A.CODCURSO) CURSOS       ');
        sql.add('FROM                                  ');
        sql.add(' (SELECT TV.CODCURSO                  ');
        sql.add('      FROM                            ');
        sql.add('        SRH_TIPOVEICULO_CURSO TV      ');
        sql.add('      WHERE                           ');
        sql.add('        TV.CODIGOTPVEIC IN(:pTipoVeic, :pTipoCarreta1, :pTipoCarreta2)');
        sql.add('        AND TV.OBRIGATORIOTPVEICULO = ''S''');
        sql.add('      UNION                               ');
        sql.add('      SELECT FUN.CODCURSO                 ');
        sql.add('      FROM                                ');
        sql.add('        SRH_FUNCAO_CURSO FUN              ');
        sql.add('      WHERE                               ');
        sql.add('        FUN.CODFUNCAO = :p_FUNCAO AND     ');
        sql.add('        FUN.CURSOOBRIGATORIOFUNCAO = ''S''');
        sql.add('      UNION                               ');
        sql.add('      SELECT CLI.CODCURSO                 ');
        sql.add('      FROM                                ');
        sql.add('        CGS_CURSOS_CLIENTES   CLI         ');
        sql.add('      WHERE                               ');
        sql.add('        CLI.CODCLI        = :p_Cliente AND   ');
        sql.add('        CLI.CODIGOGA      = :p_Garagem AND   ');
        sql.add('        CLI.CODIGOFL      = :p_Filial  AND   ');
        sql.add('        CLI.CODIGOEMPRESA = :p_Empresa  ) A  ');
        sql.add('WHERE                                        ');
        sql.add('   A.CODCURSO NOT IN ( SELECT DISTINCT B.CODCURSO FROM SRH_CURSOS_FUNC B');
        sql.add('                       WHERE  (B.CODINTFUNC = :p_Motorista) OR (B.CODINTPROAUT = :p_Motorista) )');


        ParamByName('p_Cliente'  ).AsInteger := pCliente;
        ParamByName('p_Empresa'  ).AsInteger := pEmpresa;
        ParamByName('p_Filial'   ).AsInteger := pFilial ;
        ParamByName('p_Garagem'  ).AsInteger := pGaragem;
        ParamByName('p_Motorista').AsString  := pMotorista;
        ParamByName('p_Funcao'   ).AsInteger := pFuncao;
        ParamByName('pTipoVeic'  ).AsInteger := pTipoVeic;
        ParamByName('pTipoCarreta1').AsInteger := pTipoCarreta1;
        ParamByName('pTipoCarreta2').AsInteger := pTipoCarreta2;
        Open;

        If FieldByName('Cursos').AsInteger > 0 Then
        Begin
          MensagemDlg('Motorista não possui curso(s) obrigatório(s).', mtAtencao, mbok);
          If (vcBloqueia_CursosObrigatorios = 'S') Then
          Begin
            Result := False;
            Exit;
          End;
        End;

        If FieldByName('Cursos').AsInteger = 0 Then
        Begin
          With qrCurso do
          begin
            Close;
            sql.clear;
            sql.add('SELECT DATA.DATA,REPROV.REPROV FROM '                                                                    );
            sql.add('  (SELECT COUNT(CODCURSO) DATA '                                                                         );
            sql.add('   FROM SRH_CURSOS_FUNC A  '                                                                             );
            sql.add('   WHERE  A.CODINTFUNC      = :p_Motorista AND '                                                         );
            sql.add('          A.VENCTOCURSOFUNC < :p_Data      AND '                                                         );
            sql.add('          A.IDCURSOFUNC     = (SELECT MAX(B.IDCURSOFUNC) FROM SRH_CURSOS_FUNC B '                        );
            sql.add('                               WHERE  B.CODINTFUNC = :p_Motorista AND B.CODCURSO = A.CODCURSO)) DATA, '  );
            sql.add('  (SELECT COUNT(CODCURSO) REPROV '                                                                       );
            sql.add('   FROM SRH_CURSOS_FUNC C '                                                                              );
            sql.add('   WHERE  C.CODINTFUNC  = :p_Motorista AND '                                                             );
            sql.add('          C.RESULTADO   = ''R'' AND '                                                                    );
            sql.add('          C.IDCURSOFUNC = (SELECT MAX(D.IDCURSOFUNC) FROM SRH_CURSOS_FUNC D '                            );
            sql.add('                           WHERE  D.CODINTFUNC = :p_Motorista AND D.CODCURSO = C.CODCURSO)) REPROV '     );

            ParamByName('p_Motorista').AsString   := pMotorista;
            ParamByName('p_Data'     ).AsDateTime := pData;

            Open;

            If FieldByName('DATA').AsInteger > 0 then
            Begin
              MensagemDlg('Período de validade do(s) curso(s) vencido.', mtAtencao, mbok);
              If (vcBloqueia_CursosObrigatorios = 'S') Then
              Begin
                Result := False;
                Exit;
              End;
              If (vcValidaCursosObrigatorios = 'S') Then
                If FieldByName('REPROV').AsInteger > 0  Then
                   MensagemDlg('Curso(s) com status reprovado.', mtAtencao, mbok);
            End
            Else
              If FieldByName('REPROV').AsInteger > 0  Then
              Begin
                MensagemDlg('Curso(s) com status reprovado.', mtAtencao, mbok);
                If (vcBloqueia_CursosObrigatorios = 'S') Then
                Begin
                  Result := False;
                  Exit;
                End;
              End;
          end;
        End;
      end;
    end;
  Finally
    qrBusca.Free;
    qrCurso.Free;
  End;
end;


Function CGS_VerificaDocumentosEmRH(pEmpresa, pFilial, pGaragem, pFuncao : Integer; pData : TDateTime; pMotorista : String)  : Boolean;
var qrBusca, qrDocto  : TQuery;

begin
  qrBusca              := TQuery.Create( Application );
  qrBusca.DataBaseName := cDatabaseName;

  qrDocto              := TQuery.Create( Application );
  qrDocto.DataBaseName := cDatabaseName;

  Result   := True;

  If not CGS_VerificaParametrosLocais(pEmpresa, pFilial, pGaragem) then
  begin
    Result := False;
    Exit;
  end;

  If ((vcValidaDoctosMotorista = 'S')  Or (vcBloqueiaDoctosMotorista = 'S')) then
  begin
    With qrBusca do
    Begin
      Close;
      sql.clear;
      sql.add(' SELECT                                       ');
      sql.add('    B.CODFUNCAO,                              ');
      sql.add('    A.CODDOCTOESPECIF,                        ');
      sql.add('    B.OBRIGATORIO                             ');
      sql.add('  FROM SRH_DOCUMENTACAOESPECIFICA A,          ');
      sql.add('       SRH_FUNCAO_DOCESPECIFICA B             ');
      sql.add('  WHERE                                       ');
      sql.add('    A.CODDOCTOESPECIF = B.CODDOCTOESPECIF AND ');
      sql.add('    B.OBRIGATORIO       = ''S''           AND ');
      sql.add('    B.CODFUNCAO         = :p_Funcao           ');

      ParamByName('p_Funcao'   ).AsInteger := pFuncao;

      Open;

      If IsEmpty Then
         Exit;
 
      Close;
      sql.clear;
      sql.add('SELECT COUNT(DOCTOS.CODDOCTOESPECIF)  DOCUMENTOS ');
      sql.add('FROM                                             ');
      sql.add(' (SELECT                                         ');
      sql.add('    B.CODFUNCAO,                                 ');
      sql.add('    A.CODDOCTOESPECIF,                           ');
      sql.add('    B.OBRIGATORIO                                ');
      sql.add('  FROM SRH_DOCUMENTACAOESPECIFICA A,             ');
      sql.add('       SRH_FUNCAO_DOCESPECIFICA B                ');
      sql.add('  WHERE                                          ');
      sql.add('    A.CODDOCTOESPECIF = B.CODDOCTOESPECIF AND    ');
      sql.add('    B.OBRIGATORIO       = ''S''           AND    ');
      sql.add('    B.CODFUNCAO         = :p_Funcao) DOCTOS      ');
      sql.add('WHERE                                            ');
      sql.add('  DOCTOS.CODDOCTOESPECIF NOT IN                  ');
      sql.add('                        (SELECT DISTINCT MOT.CODDOCTOESPECIF  ');
      sql.add('                         FROM SRH_DOCESPECIF_FUNC MOT         ');
      sql.add('                         WHERE  MOT.CODINTFUNC = :p_Motorista)');

      ParamByName('p_Motorista').AsString  := pMotorista;
      ParamByName('p_Funcao'   ).AsInteger := pFuncao;

      Open;

      If FieldByName('DOCUMENTOS').AsInteger > 0 Then
      Begin
        MensagemDlg('Motorista não possui documento(s) obrigatório(s).', mtAtencao, mbok);
        If (vcBloqueiaDoctosMotorista = 'S') Then
        Begin
          Result := False;
          Exit;
        End;
      End;

      If FieldByName('DOCUMENTOS').AsInteger = 0 Then
      Begin
        With qrDocto do
        begin
          Close;
          sql.clear;

          sql.add('  SELECT COUNT(CODDOCTOESPECIF) VENCIMENTO                               ');
          sql.add('    FROM SRH_DOCESPECIF_FUNC                                             ');
          sql.add('   WHERE CODINTFUNC       = :p_Motorista                                 ');
          sql.add('     AND DTVENCDOCESPECIF < :p_Data                                      ');
          sql.add('     AND DTVENCDOCESPECIF IN ( SELECT MAX(DTVENCDOCESPECIF) VENCIMENTO   ');
          sql.add('                                 FROM SRH_DOCESPECIF_FUNC                ');
          sql.add('                                WHERE CODINTFUNC = :p_Motorista          ');
          sql.add('                                GROUP BY CODDOCTOESPECIF )               ');

          ParamByName('p_Motorista').AsString   := pMotorista;
          ParamByName('p_Data'     ).AsDateTime := pData;

          Open;

          If FieldByName('VENCIMENTO').AsInteger > 0 then
          Begin
            MensagemDlg('Período de validade do(s) documentos(s) vencido.', mtAtencao, mbok);
            If (vcBloqueiaDoctosMotorista = 'S') Then
            Begin
              Result := False;
              Exit;
            End;
          End;

        End;//With qrDocto do

      End;//If FieldByName('DOCUMENTOS').AsInteger = 0 Then
      
      Free;
    End;//With qrBusca do
  End;//If ((vcValidaDoctosObrigatorios = 'S')  Or...
end;

Function CGS_VerificaGerencRiscoEmRH  (pEmpresa, pFilial, pGaragem, pDocumento, pTipoDocto : Integer;
                                       pMotorista, pSerie : String;
                                       pTela : String = '';
                                       pValorNf : Real = 0)  : Boolean;
var
  qrBuscaRH, qrBuscaCGS : TQuery;

Const
  cTela_Coleta = 'C';
  cTela_DocumentosDeServico = 'DS';

  Function PesquisaValorNF (pValor : Real) : Boolean;
  Begin
    Result := True; // Para evitar warning - Silvio - 26/1/5
    If pValor > qrBuscaRH.FieldByName('VLRAUTORIZADO').AsFloat Then
    Begin
      MensagemDlg('Valor a ser transportado maior que o permitido para o motorista.', mtAtencao, mbok);
      Result := (vcBloqueiaDoctosMotorista = 'N') and (qrBuscaRH.FieldByName('OBRIGATORIO').AsString = 'S');
    End;
  End;

  Function CodFuncaoMotorista: Integer;
  begin
    With qrBuscaCGS do
    begin
      Close;
      sql.clear;
      sql.add(' SELECT NVL(CODFUNCAO,0) CODFUNCAO    ');
      sql.add('   FROM VWCGS_FUNCIONARIOSCOMAGREGADO ');
      sql.add('  WHERE CODINTFUNC    = :CO           ');
      sql.add('    AND IDENTIFICACAO = :ID           ');
      ParamByName('CO').AsString := pMotorista;
      ParamByName('ID').AsString := 'I'; // Interno
      GetSql(qrBuscaCGS);
      Open;
      Result := FieldByName('CODFUNCAO').AsInteger;
    End;
  end;

begin

  qrBuscaRH              := TQuery.Create( Application );
  qrBuscaRH.DataBaseName := cDatabaseName;

  qrBuscaCGS              := TQuery.Create( Application );
  qrBuscaCGS.DataBaseName := cDatabaseName;

  Try

    Result   := True;

    If not CGS_VerificaParametrosLocais(pEmpresa, pFilial, pGaragem) Then
    begin
      Result := False;
      Exit;
    end;

    With qrBuscaRH do
    begin
      Close;
      sql.clear;
      sql.add(' SELECT B.CODINTERNO                           ');
      sql.add('      , NVL(A.VLRAUTORIZADO,0) VLRAUTORIZADO   ');
      sql.add('      , C.OBRIGATORIO                          ');
      sql.add('   FROM SRH_DOCESPECIF_FUNC A                  ');
      sql.add('      , SRH_DOCUMENTACAOESPECIFICA B           ');
      sql.add('      , SRH_FUNCAO_DOCESPECIFICA C             ');
      sql.add('  WHERE A.CODDOCTOESPECIF = B.CODDOCTOESPECIF  ');
      sql.add('    AND B.CODINTERNO      = 1                  ');
      sql.add('    AND A.CODDOCTOESPECIF = C.CODDOCTOESPECIF  ');
      sql.add('    AND A.CODINTFUNC      = :p_MOTORISTA       ');
      sql.add('    AND C.CODFUNCAO       = :p_CODFUNCAO       ');
      ParamByName('p_MOTORISTA').AsString  := pMotorista;
      ParamByName('p_CODFUNCAO').AsInteger := CodFuncaoMotorista;
      GetSql(qrBuscaRH);
      Open;
    End;

    If vcValidaDoctosMotorista = 'S' Then
    Begin

      If qrBuscaRH.IsEmpty Then
        Exit;

      If (pTela = cTela_Coleta) or
         (pTela = cTela_DocumentosDeServico) Then
      Begin
        If not PesquisaValorNF(pValorNF) Then
        Begin
          Result := False;
          Exit;
        End;
      End
      Else
      Begin
        With qrBuscaCGS do
        begin
          Close;
          sql.Clear;
          sql.add(' SELECT SERIE                        ');
          sql.add('      , CONHECIMENTO                 ');
          sql.add('      , NVL(VALOR_NF,0) VALOR_NF     ');
          sql.add('      , TIPO_DOCTO                   ');
          sql.add('   FROM FTA001                       ');
          sql.add('  WHERE CONHECIMENTO = :p_DOC        ');
          sql.add('    AND SERIE        = :p_SERIE      ');
          sql.add('    AND TIPO_DOCTO   = :p_TIPODOCTO  ');
          sql.add('    AND GARAGEM      = :p_GARAGEM    ');
          sql.add('    AND FILIAL       = :p_FILIAL     ');
          sql.add('    AND EMPRESA      = :p_EMPRESA    ');

          ParamByName('p_DOC'      ).AsInteger := pDocumento;
          ParamByName('p_SERIE'    ).AsString  := pSerie;
          ParamByName('p_TIPODOCTO').AsInteger := pTipoDocto;
          ParamByName('p_EMPRESA'  ).AsInteger := pEmpresa;
          ParamByName('p_FILIAL'   ).AsInteger := pFilial ;
          ParamByName('p_GARAGEM'  ).AsInteger := pGaragem;
          GetSQL(qrBuscaCGS);
          Open;

          While Not qrBuscaCGS.Eof Do
          Begin
            If not PesquisaValorNF(FieldByName('VALOR_NF').AsFloat) Then
            Begin
              Result := False;
              Exit;
            End;
            Next;
          End; //While Not qrBuscaCGS.Eof Do

        End; //With qrBuscaCGS do

      End; //Else

    End; //If vcValidaDoctosMotorista <> 'S' Then

  Finally // Try
    qrBuscaRH.Free;
    qrBuscaCGS.Free;
  End;
  
end;

function LastDayOfMonth( pData : TDateTime ) : Integer;
var
  NewDate : String;
Begin
  NewDate := DateToStr( 32 +  StrToDate( '01'+Copy( DateToStr( pData ), 3, 8 ) ) );
  Result  := StrToInt(Copy( DateToStr( StrToDate( '01'+Copy( NewDate , 3, 8 ) ) - 1 ), 1, 2 ));
end;

function LastDayOfMonthStr( pData : TDateTime ) : String;
Begin
  Result := StrZero(LastDayOfMonth(pData),2);
end;

function LastDateOfMonth( pData : TDateTime ) : TDateTime;
var  // Calcula a última data do mês da data informada
  d : TDateTime;
  s : String;
Begin
  s := DateToStr( pData );
  s := '01/' + Copy( s, 4, 7 ); // Pega o 1o dia do mês
  d := StrToDate( s );
  d := d + 32; // Para cair no mês posterior
  s := DateToStr( d );
  s := '01/' + Copy( s, 4, 7 ); // Calcula o 1o dia do mês posterior
  d := StrToDate( s );
  d := d - 1; // Para voltar ao último dia do mês
  Result := d;
end;

function LeftAlignCh( S: String; n : Integer; Ch: String ) : String ;
var
  Tam : Integer ;
  AuxPChar : Array [0..255] Of Char;
begin

  Tam := Length( S );
  if ( tam > n ) then
      n := tam;

  FillChar( AuxPChar, n, Ch[1] );
  AuxPChar[n] := #0;

  StrPCopy( @AuxPChar[n-tam], S );
  Result := StrPas( AuxPChar );

end;

function RightAlignCh( S: String; n : Integer; Ch: String ) : String ;
var
  Tam : Integer ;
  AuxPChar : Array [0..255] Of Char;
begin

  //if Trim(S) = '' then S := ' ';

  Tam := LengTh( S );
  If ( tam > n ) then
      n := tam;

  //If Pos( '&',  ) > 0 then Inc(n);

  FillChar( AuxPChar, n, Ch[1] );
  AuxPChar[n] := #0;

  StrPCopy( AuxPChar, S );
  If LengTh(S) < n then
    FillChar( AuxPChar[length(S)], 1, Ch[1] );
  Result := StrPas( AuxPChar );
end;

Function VerificaSeCompartilhaContas(pEmpresa, pFilial : Integer) : Boolean;
Var
  qry : TQuery;
Begin
  qry := TQuery.Create(Application);
  qry.DatabaseName := cDatabaseName; //'dbBgm';
  With qry do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT COMPARTILHACONTAS FROM BCOPARAM' );
    SQL.Add( ' WHERE CODIGOFL      = :PFILIAL  AND'   );
    SQL.Add( '       CODIGOEMPRESA = :PEMPRESA'       );
    ParamByName('PFILIAL' ).AsInteger := pFilial;
    ParamByName('PEMPRESA').AsInteger := pEmpresa;
    Open;
    Result := FieldByName( 'COMPARTILHACONTAS' ).AsString = 'S';
  end;
end;

Function VerificaSeCompartilhaContasCaixa(pEmpresa, pFilial : Integer) : Boolean;
Var
  qry : TQuery;
Begin
  qry := TQuery.Create(Application);
  qry.DatabaseName := cDatabaseName; //'dbBgm';
  With qry do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT COMPARTILHACONTASCAIXA FROM BCOPARAM' );
    SQL.Add( ' WHERE CODIGOFL      = :PFILIAL  AND'        );
    SQL.Add( '       CODIGOEMPRESA = :PEMPRESA'            );
    ParamByName('PFILIAL' ).AsInteger := pFilial;
    ParamByName('PEMPRESA').AsInteger := pEmpresa;
    Open;
    Result := FieldByName( 'COMPARTILHACONTASCAIXA' ).AsString = 'S';
  end;
end;

Procedure VerificaSePodeExcluirLanctoCTB(pCodLanca : Integer );
Begin
  With qrPesqAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTBLANCA' );
    SQL.Add( ' WHERE CODLANCA = :P0'  );
    params[0].AsInteger := pCodLanca;
    Open;
    dmCPG.vDoctoCTB := FieldByName( 'DOCUMENTOLANCA' ).AsString;
    dmCPG.vDataCTB  := FormatDateTime('dd/mm/yyyy', FieldByName( 'DTLANCA' ).AsDateTime);
    dmCPG.vLctoModificadoCTB := FieldByName( 'LCTOMODIFICADO' ).AsString;
    dmCPG.vMesAno := FormatDateTime('yyyyMM', FieldByName( 'DTLANCA' ).AsDateTime);
    dmCPG.vFilial := FieldByName('CodigoFl').AsInteger;
  end;
end;

Procedure ExcluiCTB(pEmpresa, pFilial, pCodLanca, pPlano : Integer);
begin
  dmCPG.vExcluiuCTB[1] := 'S';
  dmCPG.vExcluiuCTB[2] := 'S';
  VerificaSePodeExcluirLanctoCTB(pCodLanca);
  If pCodLanca <> 0 then
  begin
    If dmCPG.vLctoModificadoCTB = 'S' then
       dmCPG.vExcluiuCTB[2] := 'N'
    else
    begin
      If frmMenuPrincipal.ContSenhaBgm.Sistema = 'BCO' then
      begin
        With qrPesqAux do { NÃO É PERMITO EXCLUSÃO PARA TRANFERÊNCIA }
        begin
          Close;
          SQL.Clear;
          SQL.Add( 'SELECT Count(*) Qtde'       );
          SQL.Add( ' FROM BCOMOVTO '            );
          SQL.Add( ' WHERE CODLANCA = :P0 AND'  );
          SQL.Add( ' STATUSMOVTOBCO <> ''C'''   );
          params[0].AsInteger := pCodlanca;
          Open;
          If FieldByName('Qtde').AsInteger > 1 then
          begin
            dmCPG.vExcluiuCTB[2] := 'N';
            exit;
          end
        end;
      end
      else
      If frmMenuPrincipal.ContSenhaBgm.Sistema = 'CPG' then
      begin
        With qrPesqAux do { NÃO É PERMITO EXCLUSÃO PARA DOCUMENTO PARCELADO }
        Begin
          Close;
          SQL.Clear;
          SQL.Add( 'SELECT Count(*) Qtde'       );
          SQL.Add( ' FROM CPGDOCTO             ');
          SQL.Add( ' WHERE CODLANCA = :P0 AND'  );
          SQL.Add( ' STATUSDOCTOCPG <> ''C'''   );
          params[0].AsInteger := pCodlanca;
          Open;
          If FieldByName('Qtde').AsInteger > 1 then
          begin
            dmCPG.vExcluiuCTB[2] := 'N';
            exit;
          end;
        End;
      end
      else
      Begin
        With qrPesqAux do { NÃO É PERMITO EXCLUSÃO PARA DOCUMENTO PARCELADO }
        begin
          Close;
          SQL.Clear;
          SQL.Add( 'SELECT Count(*) Qtde'       );
          SQL.Add( ' FROM CRCDOCTO             ');
          SQL.Add( ' WHERE CODLANCA = :P0 AND'  );
          SQL.Add( ' STATUSDOCTOCRC <> ''C'''   );
          params[0].AsInteger := pCodlanca;
          Open;
          If FieldByName('Qtde').AsInteger > 1 then
          begin
            dmCPG.vExcluiuCTB[2] := 'N';
            exit;
          end
        end;
      end;
      
      With dmCTB.qrCTBItLnc do
      begin
        Close;
        SQL.Clear;
        SQL.Add( 'SELECT * FROM CTBITLNC' );
        SQL.Add( ' WHERE CODLANCA = :P0'  );
        Params[0].AsInteger := pCodLanca;
        Open;
        If RecordCount > 0 then
        begin
          With dmCTB.stp_ExcluiItem do
          begin
            ParamByName( 'P_FILIAL'   ).AsInteger := pFilial;
            ParamByName( 'P_EMPRESA'  ).AsInteger := pEmpresa;
            ParamByName( 'P_PERIODOA' ).AsString  := dmCPG.vMesAno;  // Periodo atual
            ParamByName( 'P_PERIODOF' ).AsString  := InttoStr( StrToInt( dmCPG.vMesAno ) + 1 ); // Periodo seguinte
            ParamByName( 'P_NROPLANO' ).AsInteger := pPlano;
            ParamByName( 'P_CODLANCA' ).AsInteger := pCodLanca;
            ParamByName( 'P_EXECPROCPERIODO' ).AsString  := CTBVerificaSeGravaSaldoNoProximoMes(pEmpresa,
                                                            pFilial,
                                                            StrToDate(dmCPG.vDataCTB));
            execPROC;
            If ParamByName( 'P_GRAVOU' ).AsInteger = 0 then
            begin
              dmCPG.vExcluiuCTB[1] := 'N';
              If mensagemDLG( 'Problemas na exclusão do documento CTB. Deseja ver o erro ?'
                              , mtConfirmacao, mbSIM+mbNAO ) = mrSIM then
                dmCTB.stp_ExcluiItem.ExecPROC;
              exit;
            end;
          End; // With stp_CTBExcluiItem - storedprocedure
       end; // if recordcount
      end; // with dmctb.qrctbitlnc

      With dmCTB.qrCTBItLnc do // deleta todos os item do lançamento
      begin
        Close;
        SQL.Clear;
        SQL.Add( 'DELETE FROM CTBITLNC'  );
        SQL.Add( ' WHERE CODLANCA = :P0' );
        Params[0].AsInteger := pCodLanca;
        try
          execSQL;
        except on E:EDBEngineError do
          Begin
            dmCPG.vExcluiuCTB[1] := 'N';
            If mensagemDLG( 'Problemas durante a exclusão dos itens de lançamento. Deseja ver o erro ?'
                            , mtConfirmacao, mbSIM+mbNAO ) = mrSIM then mensagemDLG( E.Errors[1].Message, mtErro, mbOK );
              //dmCTB.qrCTBItLnc.ExecSQL;
            exit;
          end;
        end; // try
      end;

      With dmCTB.qrCTBLanca do // deleta o lançamento
      begin
        Close;
        SQL.Clear;
        SQL.Add( 'DELETE FROM CTBLANCA'  );
        SQL.Add( ' WHERE CODLANCA = :P0' );
        Params[0].AsInteger := pCodLanca;
        try
          execSQL;
        except on E:EDBEngineError do
          Begin
            dmCPG.vExcluiuCTB[1] := 'N';
            If mensagemDLG( 'Problemas durante a exclusão dos lançamentos. Deseja ver o erro ?'
                            , mtConfirmacao, mbSIM+mbNAO ) = mrSIM then mensagemDLG( E.Errors[1].Message, mtErro, mbOK );
              //DmCTB.qrCTBLanca.ExecSQL;
            exit;
          end;
        end; // try
      end;
    end;
  end;
end;

Function BuscaNumeroBancoParaPE(vCodBanco : Integer) : String;
Var
  qry : TQuery;
Begin
  qry := TQuery.Create(Application);
  qry.DatabaseName := cDatabaseName;
  With qry do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT NROBANCO'       );
    SQL.Add( ' FROM BCOBANCO'        );
    SQL.Add( ' WHERE CODBANCO = :P0' );
    params[0].AsInteger := vCodBanco;
    Open;
    Result := StrZero(FieldByName( 'NROBANCO' ).AsInteger,3,0);
    Close;
    Free;
  End;
End;

Function MascaraClassificador(pMask : String) : String;
Var
  s : String;
  i : Integer;
Begin
  pMask := Trim(pMask);
  s := '';
  For i := 1 To Length(pMask) Do
    If Copy(pMask,i,1) = '.' Then s := s + '.' Else s := s + '9';
  Result := s;
End;

Function GrauClassificador(pClass : String) : Integer;
// Ex.:
// 01.00.000 -> 3 graus ao total. Classificador de 1o grau
// 01.01.000 -> 3 graus ao total. Classificador de 2o grau
// 01.01.001 -> 3 graus ao total. Classificador de 3o grau
//
// Não pode conter graus intermediários vazios.
//
Var
  i : Integer;
  s : String;
  vGrau : Integer;
Begin
  pClass := Trim(pClass);
  If Pos('.', pClass) = 0 Then // Tem que ter pelo menos dois graus
  Begin
    Result := -1;
    Exit;
  End;
  { Só pode aceitar caracteres numéricos e o ponto decimal }
  For i := 1 To Length(pClass) Do
    If (Copy(pClass, i, 1) <> '.') And (Copy(pClass, i, 1) < '0') And (Copy(pClass, i, 1) > '9') Then
    Begin
      Result := -1;
      Exit;
    End;
  i := 1;
  s := '';
  vGrau := 0;
  While i <= Length(pClass) Do
  Begin
    If Copy(pClass, i, 1) = '.' Then
    Begin
      If (s <> '') And (StrToInt(s) = 0) Then
        Break;
      Inc(vGrau);
      s := ''; // Zera para testar o próximo grau
    End;
    If Copy(pClass, i, 1) <> '.' Then // Não concatena o "."
      s := s + Copy(pClass, i, 1);
    Inc(i);
  End;
  If (s <> '') And (StrToInt(s) > 0) Then
    Inc(vGrau);
  If (i < Length(pClass)) And ( StrToInt( NoChar( Copy(pClass, i, length(pClass)), '.' ) ) <> 0 ) Then
  Begin
    Result := -1;
    Exit;
  End;
  Result := vGrau;
End;

function IntegracaoPorTipoDeDocto( Sender: TObject; pEmpresa, pFilial: Integer; pTpDoc: String ): Boolean;
Begin
  Result := True;
  With dmCPG.qrCoringa do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CPRTPDOC'   );
    SQL.Add( ' WHERE CODTPDOC = :P0'    );
    SQL.Add( ' AND CODIGOFL = :P1'      );
    SQL.Add( ' AND CODIGOEMPRESA = :P2' );
    params[0].AsString  := pTpDoc;
    params[1].AsInteger := pFilial;
    params[2].AsInteger := pEmpresa;
    getSql(dmCPG.qrCoringa);
    Open;
    If (IsEmpty) then
    Begin
      mensagemDLG( 'Tipo de documento inválido ou não cadastrado para esta empresa/filial - '+pTpDOc+' .',
                   mtInformacao, mbOK );
      Result := False; // Com mensagem de erro
    end
    else
    Begin // Caso seja 'N', nào fará nenhuma contabilizacao
      If FieldByName( 'TPCONTABILIZACAO' ).AsString = 'N' then Result := False
      else
      If ( Sender is TConfirma ) then
      Begin
        If TConfirma( Sender ).Hint = 'INCLUSAO' then // Enviado pela inclusão de docto
          Result := ( FieldByName( 'TPCONTABILIZACAO' ).AsString <> 'B' )
        else
        If TConfirma( Sender ).Hint = 'BAIXA' then // Enviado pela pagamento de docto
          Result := ( FieldByName( 'TPCONTABILIZACAO' ).AsString <> 'I' );
      end
      else
      Begin
        If ( TImprimir( Sender ).Hint = 'EMISSAO' ) or ( TImprimir( Sender ).Hint = 'BORDERO' ) then // Enviado pela inclusão de docto
          Result := ( FieldByName( 'TPCONTABILIZACAO' ).AsString <> 'I' );
      end;
    end;
  end;
end;

function ValidaTipoHistorico( pCodHistorico, pEmpresa, pFilial : Integer ):Boolean;
Const
     arr_HistDeb  = ( '901_902_903' );
     arr_HistCred = ( '904' );
Begin
  result := true;
  With qrPesqAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM BCOHISTO'   );
    SQL.Add( ' WHERE CODHISTOBCO = :P0' );
    SQL.Add( ' AND CODIGOFL = :P1'      );
    SQL.Add( ' AND CODIGOEMPRESA = :P2' );
    params[0].AsInteger := pCodHistorico;
    params[1].AsInteger := pFilial;
    params[2].AsInteger := pEmpresa;
    Open;
    If (IsEmpty) then
    Begin
      mensagemDLG( 'Histórico bancário inválido - '+IntToStr( pCodHistorico ), mtInformacao, mbOK );
      Result := False;
      exit;
    end;
    If ( FieldByName( 'DEBCREDHISTBCO' ).AsString = 'C' ) and // está cadastrado como crédito...
       ( Pos( IntToStr(pCodHistorico), arr_HistDeb ) > 0 ) then
    Begin
      mensagemDLG( 'Histórico bancário '+IntToStr( pCodHistorico )+' deve ser de débito.', mtInformacao, mbOK );
      Result := False;
      exit;
    end;
    If ( FieldByName( 'DEBCREDHISTBCO' ).AsString = 'D' ) and // está cadastrado como débito...
       ( Pos( IntToStr(pCodHistorico), arr_HistCred ) > 0 ) then
    Begin
      mensagemDLG( 'Histórico bancário '+IntToStr( pCodHistorico )+' deve ser de crédito.', mtInformacao, mbOK );
      Result := False;
      exit;
    end;

  end;

end;

function VerificaSeSubstitui( pCodDocto : Integer; pSistema : String ):Boolean;
var Tabela, Campo : String;
Begin
  Tabela := pSistema+'DOCTO';
  Campo  := 'CODDOCTO'+pSistema+'SUBST';

  With qrPesqAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM '+TABELA+'' );
    SQL.Add( ' WHERE '+CAMPO+' = :P0'   );
    params[0].AsInteger := pCodDocto;
    Open;
    If (IsEmpty) then
    Begin
      Result := False;
      exit;
    end
    else
    While not EOF do
    Begin
      Inc( vQuantDeCodigos );
      SetLength( VetorDeCodigos, vQuantDeCodigos );
      VetorDeCodigos[vQuantDeCodigos-1] := FieldByName( 'CODDOCTO'+pSistema ).AsInteger;
      Next;
    end;
    Result := True;
  end;
end;

Function ReplicaDataDePagamento( pDataPagto : TDateTime; pCodMovtoBCO : Integer; pSistema : String ; pCodDocto : Integer = 0; pTipo : String = 'S') : Boolean;
var i : Integer;
   MSG, Campo1, Campo2, Tabela : String;
Begin
////////////////////////////////////////////////////////////////////////////////
//
//                               ÚTIL PARA CPG E CRC
//
////////////////////////////////////////////////////////////////////////////////


  Tabela := pSistema + 'DOCTO';

  Campo2 := 'CODDOCTO' + pSistema + IIF(pTipo = 'S','SUBST','_DEVOL');

  If pSistema = 'CPG' then
  Campo1 := 'PAGAMENTOCPG' else Campo1 := 'RECEBIMENTOCRC';

  MSG    := Copy( LowerCase( Campo1 ), 1, LengTh( Campo1 )-3 );
  i      := 0;
  Result := True;
  With qrPesqAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'UPDATE '+TABELA+''       );
    SQL.Add( ' SET '+CAMPO1+' = :P0'   );
    SQL.Add( ' , CODMOVTOBCO = :P1'    );
    SQL.Add( ' WHERE '+CAMPO2+' = :P2' );
    params[0].AsDateTime := pDataPagto;
    params[1].AsInteger  := pCodMovtoBCO;
    If pCodDocto = 0 then
      params[2].AsInteger  := VetorDeCodigos[i]
    else
      params[2].AsInteger  := pCodDocto;
    GetSql(qrPesqAux);
    Try
      execSQL;
    except on E:EDBEngineError do
      Begin
        If mensagemDLG( 'Problemas durante a atualização da data de '+MSG+' sobre os documentos substituídos. Deseja ver o erro ?'
                        , mtConfirmacao, mbSIM+mbNAO ) = mrSIM then mensagemDLG( E.Errors[1].message, mtErro, mbOK );
        Result := False;
      end;
    end;
  end;

  // Limpando buffer auxiliar( Vetor )...
  SetLength( VetorDeCodigos, 0 );
  // Zerando variável auxiliar...
  vQuantDeCodigos := 0;
end;

Function TrazCodigosDaFilialParaIntegracao(pEmpresa, pFilial: Integer; pSistema: String) : TConsmat;
var
  vNomeTabela : String;
begin
  vNomeTabela := pSistema + 'PARAM';
  With qrPesqAux do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM ' + ''+ vnometabela + '');
    SQL.Add('WHERE CODIGOFL = :P0 AND CODIGOEMPRESA = :P1');
    Params[0].Asinteger := pfilial;
    Params[1].AsInteger := pempresa;
    Open;
    If psistema = 'CPG' then
    begin
      result[1] := iif(FieldByName('CodFilialParaESF').AsInteger=0,1,FieldByName('CodFilialParaESF').AsInteger);
      result[2] := iif(FieldByName('CodFilialParaCPG').AsInteger=0,1,FieldByName('CodFilialParaCPG').AsInteger);
      result[3] := iif(FieldByName('CodFilialParaCTB').AsInteger=0,1,FieldByName('CodFilialParaCTB').AsInteger);
    end
    else
    begin // CRC
      result[1] := iif(FieldByName('CodFilialParaESF').AsInteger=0,1,FieldByName('CodFilialParaESF').AsInteger);
      result[3] := iif(FieldByName('CodFilialParaCTB').AsInteger=0,1,FieldByName('CodFilialParaCTB').AsInteger);
      result[4] := iif(FieldByName('CodFilialParaCRC').AsInteger=0,1,FieldByName('CodFilialParaCRC').AsInteger);
    end;
  end;
end;

Function PegaContaCTBdaCC(pBanco, pAgencia : Integer; pConta : String ):Integer;
Begin
  With dmCPG.qrCoringa do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM BCOCONTA' );
    SQL.Add( ' WHERE CODBANCO = :P0'  );
    SQL.Add( ' AND CODAGENCIA = :P1'  );
    SQL.Add( ' AND CODCONTABCO = :P2' );
    params[0].AsInteger := pBanco;
    params[1].AsInteger := pAgencia;
    params[2].AsString  := pConta;
    Open;
    Result := FieldByName( 'CODCONTACTB' ).AsInteger;
  end;
end;

Function ValidaIMPOSTOCRC( pPlano, pEmpresa, pFilial : integer; pTelaInclusao : Boolean = False ):Boolean;

var i : Integer;
Begin

  vTemContaValidaIRRF      := False;
  vTemContaValidaINSS      := False;
  vTemContaValidaISS       := False;
  vTemContaValidaCSL       := False;
  vTemContaValidaPIS       := False;
  vTemContaValidaCofins    := False;
  vTemContaValidaDesconto  := pTelaInclusao;
  vTemContaValidaAcrescimo := pTelaInclusao;
  vTemContaValidaDescFinaceiro := pTelaInclusao;

  With dmCPG.qrCoringa do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CRCPARAM'   );
    SQL.Add( ' WHERE CODIGOFL = :P0'    );
    SQL.Add( ' AND CODIGOEMPRESA = :P1' );
    params[0].AsInteger := pFilial;
    params[1].AsInteger := pEmpresa;
    Open;
    vContaIRRF      := FieldByName( 'CONTACTBIRRF'   ).AsString;
    vContaINSS      := FieldByName( 'CONTACTBINSS'   ).AsString;
    vContaCSL       := FieldByName( 'CONTACTBCSL'    ).AsString;
    vContaISS       := FieldByName( 'CONTACTBISS'    ).AsString;
    vContaCOFINS    := FieldByName( 'CONTACTBCOFINS' ).AsString;
    vContaPIS       := FieldByName( 'CONTACTBPIS'    ).AsString;
    vContaDesconto  := FieldByName( 'CONTACTBDESPESACRC').AsString;
    vContaAcrescimo := FieldByName( 'CONTACTBRECE'      ).AsString;
    vContaDescFinanceiro := FieldByName( 'CONTACTB_DescFinanceiro' ).AsString;

    For i := 0 to IIF(pTelaInclusao,5,8) do
    begin
      If ((I = 0) and (vContaIRRF           <> '')) or
         ((I = 1) and (vContaINSS           <> '')) or
         ((I = 2) and (vContaISS            <> '')) or
         ((I = 3) and (vContaCSL            <> '')) or
         ((I = 4) and (vContaPIS            <> '')) or
         ((I = 5) and (vContaCOFINS         <> '')) or
         ((I = 6) and (vContaDesconto       <> '')) or
         ((I = 7) and (vContaAcrescimo      <> '')) or
         ((I = 8) and (vContaDescFinanceiro <> '')) then
      begin
        With dmCPG.qrCoringa do
        Begin
          Close;
          SQL.Clear;
          SQL.Add( 'SELECT * FROM CTBCONTA'   );
          SQL.Add( ' WHERE CODCONTACTB = :P0' );
          SQL.Add( ' AND NROPLANO = :P1'      );
          params[0].AsInteger := StrToInt( IIF( i = 0
                                              , vContaIRRF
                                              , IIF( i = 1
                                                   , vContaINSS
                                                   , IIF( i = 2
                                                        , vContaISS
                                                        , IIF( i = 3
                                                             , vContaCSL
                                                             , IIF( i = 4
                                                                  , vContaPIS
                                                                  , IIF( i = 5
                                                                       , vContaCofins
                                                                       , IIF( i = 6
                                                                            , vContaDesconto
                                                                            , IIF( i = 7
                                                                                 , vContaAcrescimo
                                                                                 , vContaDescFinanceiro
                                                                                 )
                                                                            )
                                                                       )
                                                                  )
                                                             )
                                                        )
                                                   )
                                              )
                                              );
          params[1].AsInteger := pPlano;
          Open;
          If (IsEmpty) then
          Begin
            mensagemDLG( 'Conta contábil de '
                       + IIF( i = 0
                            , 'IRRF'
                            , IIF( i = 1
                                 , 'INSS'
                                 , IIF( i = 2
                                      , 'ISS'
                                      , IIF( i = 3
                                           , 'CSL'
                                           , IIF( i = 4
                                                , 'PIS'
                                                , IIF( i = 5
                                                     , 'COFINS'
                                                     , IIF( i = 6
                                                          , 'ABATIMENTO'
                                                          , IIF( i = 7
                                                               , 'ACRESCIMO'
                                                               , 'DESCONTO FINANCEIRO'
                                                               )
                                                          )
                                                     )
                                                )
                                           )
                                      )
                                 )
                            )
                          + ' inválida. Ver parâmetros.', mtInformacao, mbOK );
            Result := False;
            exit;
          end;
          if i = 0 then vTemContaValidaIRRF      := True;
          if i = 1 then vTemContaValidaINSS      := True;
          if i = 2 then vTemContaValidaISS       := True;
          if i = 3 then vTemContaValidaCSL       := True;
          if i = 4 then vTemContaValidaPIS       := True;
          if i = 5 then vTemContaValidaCofins    := True;
          if i = 6 then vTemContaValidaDesconto  := True;
          if i = 7 then vTemContaValidaAcrescimo := True;
          if i = 8 then vTemContaValidaDescFinaceiro := True;
        end;
      end;
    end;
  end;

  If (not VerificaSeOsImpostosOuDescontoOuAcrescimoTemContaContabil) then
  begin
    Result := False;
    exit;
  end;

  Result              := True;
end;

function PegaDescricaoDoTpDoc( pEmpresa, pFilial : Integer; pTpDoc : String ) : String;
Begin
  With qrPesqAux do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CPRTPDOC' );
    SQL.Add( 'WHERE CODTPDOC = :P0 AND CODIGOFL = :P1 AND CODIGOEMPRESA = :P2' );
    params[0].AsString  := pTpDoc;
    params[1].AsInteger := pFilial;
    params[2].AsInteger := pEmpresa;
    Open;
    Result := FieldByName( 'DESCTPDOC' ).AsString;
    Close;
  end;
end;

Function VerificaSeOsImpostosOuDescontoOuAcrescimoTemContaContabil(pModulo : String = 'CRC'; pPessoaJuridica : Boolean = True) : Boolean;
Begin { Dar get em CPGComum }
  Result := False;
  If (vc_IRRF > 0) and ( not vTemContaValidaIRRF ) then
  begin
    MensagemDlg('Falta conta contábil de IRRF no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If (vc_Inss > 0) and ( not vTemContaValidaINSS ) and (pModulo = 'CRC') then
  begin
    MensagemDlg('Falta conta contábil de INSS no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If (vc_Inss > 0) and ( not vTemContaValidaINSS ) and (pModulo = 'CPG') and (pPessoaJuridica) then { SIM 10228 }
  begin
    MensagemDlg('Falta conta contábil de INSS-PJ no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If (vc_Inss_PF > 0) and ( not vTemContaValidaINSS_PF) and (pModulo = 'CPG') and (not pPessoaJuridica) then { SIM 10228 }
  begin
    MensagemDlg('Falta conta contábil de INSS-PF no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If (vc_ValorUnico > 0) and (pModulo = 'CPG') and ( not vTemContaValidaUnica ) Then
  begin
    MensagemDlg('Falta conta contábil única de PIS/COFINS/CSL no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end
  else
  begin
    If (vc_PIS > 0) and ( not vTemContaValidaPIS ) and (vc_ValorUnico = 0) then
    begin
      MensagemDlg('Falta conta contábil de PIS no cadastro de parâmetros.', mtErro, mbok);
      exit;
    end;
    If (vc_Cofins > 0) and ( not vTemContaValidaCofins ) and (vc_ValorUnico = 0) then
    begin
      MensagemDlg('Falta conta contábil de COFINS no cadastro de parâmetros.', mtErro, mbok);
      exit;
    end;
    If (vc_CSL > 0) and ( not vTemContaValidaCSL ) and (vc_ValorUnico = 0) then
    begin
      MensagemDlg('Falta conta contábil de CSL no cadastro de parâmetros.', mtErro, mbok);
      exit;
    end;
  end;
  If (vc_ISS > 0) and ( not vTemContaValidaISS ) then
  begin
    MensagemDlg('Falta conta contábil de ISS no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If ( Not vTemContaValidaDesconto) and ( vc_Desconto > 0 ) then
  begin
    MensagemDlg('Falta conta contábil de DESCONTO no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If ( Not vTemContaValidaAcrescimo ) and ( vc_Acrescimo > 0 ) then
  begin
    MensagemDlg('Falta conta contábil de ACRÉSCIMO no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If ( Not vTemContaValidaAdto ) and ( vc_Adiantamento > 0 ) then
  begin
    MensagemDlg('Falta conta contábil de ADIANTAMENTO no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  If ( Not vTemContaValidaDescFinaceiro ) and ( vc_DescFinanceiro > 0 ) then
  begin
    MensagemDlg('Falta conta contábil de DESCONTO FINANCEIRO no cadastro de parâmetros.', mtErro, mbok);
    exit;
  end;
  Result := True;
end;

Function VerificaUFFilial(pEmpresa,pFilial : Integer) : String;
begin
  With qrPesqAux do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT CODIGOUF FROM CTR_FILIAL');
    SQL.Add('WHERE CODIGOFL = :P0 AND CODIGOEMPRESA = :P1');
    Params[0].Asinteger := pfilial;
    Params[1].AsInteger := pempresa;
    Open;
    result := trim(FieldByName('CODIGOUF').AsString);
  end;
end;

Function DataParaExtenso( pData : String ): String;
Const
  Mes : Array[1..12] of String = ( 'JANEIRO','FEVEREIRO','MARCO','ABRIL','MAIO','JUNHO','JULHO','AGOSTO','SETEMBRO','OUTUBRO','NOVEMBRO','DEZEMBRO' );
Begin
  Result := Copy( pData, 1, 2 ) + ' DE ' + Mes[ StrToInt( Copy( pData, 4, 2 ) ) ] + ' DE ' + Copy( pData, 7, 4 );
end;

function TrazTipoDeInscricao( pEmpresa : Integer ): String;
Begin

  With qrPesqAux do
  begin
    Close;
    SQL.Clear;
//    SQL.Add( 'SELECT * FROM CTR_CADEMP E, CTR_EMPAUTORIZADAS A' );
    SQL.Add( 'SELECT TIPOINSCRICAOEMPAUT FROM CTR_CADEMP E, CTR_EMPAUTORIZADAS A' );
    SQL.Add( ' WHERE E.CODINTEMPAUT = A.CODINTEMPAUT'           );
    SQL.Add( ' AND E.CODIGOEMPRESA = :P0'                       );
    Params[0].AsInteger := pEmpresa;
    Open;
    If (IsEmpty) then
    Begin
      mensagemDLG( 'Empresa não autorizada.(TrazTipoDeInscricao)'
                   , mtInformacao, mbOK );
      Result := '';
      exit;
    end;
    Result := FieldByName( 'TIPOINSCRICAOEMPAUT' ).AsString;
  end;

end;

function TrazCodigoDeInscricao( pEmpresa : Integer ): String;
begin

  With qrPesqAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT * FROM CTR_CADEMP E, CTR_EMPAUTORIZADAS A' );
    SQL.Add( ' WHERE E.CODINTEMPAUT = A.CODINTEMPAUT'           );
    SQL.Add( ' AND E.CODIGOEMPRESA = :P0'                       );
    Params[0].AsInteger := pEmpresa;
    Open;
    If Not IsEmpty then
    begin
      If FieldByName( 'TIPOINSCRICAOEMPAUT' ).AsString = 'CNPJ' then
        Result := Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString,  1, 2 ) + '.' +
                  Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString,  3, 3 ) + '.' +
                  Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString,  6, 3 ) + '/' +
                  Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString,  9, 4 ) + '-' +
                  Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString, 13, 2 )
      else
        If FieldByName( 'TIPOINSCRICAOEMPAUT' ).AsString = 'CPF' then
        Result := Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString,  1, 3 ) + '.' +
                  Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString,  4, 3 ) + '.' +
                  Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString,  7, 3 ) + '-' +
                  Copy( FieldByName( 'INSCRICAOEMPRESA' ).AsString, 10, 2 )
      else
        Result := FieldByName( 'INSCRICAOEMPRESA' ).AsString;
    end;
  end;
end;

Procedure GravaDadosContabeisEmTabelaAuxiliarParaIntegracao(pMtDadosIntegracaoCTB: Pointer; pEmpresa, pFilial, pPlano, pCodHistoCTB : Integer; pValor : Double; pContaCTB, pCustoCTB, pDC, pCodTpDespesa : String; pCriatabela : Boolean = False; p_HitoricoText : String = ''; pConjunto : Integer = 1; pMostraMsg : boolean = True );

    Procedure CriaEstruturaTabela ;
    begin
      If not pCriatabela then Exit;
      Try
        If not TMemoryTable(pMtDadosIntegracaoCTB^ ).IsEmpty then exit;
      except
      end;
      
      With TMemoryTable(pMtDadosIntegracaoCTB^ ) do
      begin
        With FieldDefs Do
        Begin
          Clear;
          Add('Conta'        , ftString,   5, False);
          Add('ContraPartida', ftString,   5, False);
          Add('Custo'        , ftString,   5, False);
          Add('DC'           , ftString,   1, False);
          Add('Historico'    , ftString, 255, False);
          Add('Conjunto'     , ftInteger,  0, False);
          Add('Valor'        , ftFloat,    0, False);
        End;
        CreateTable;
        Open;
      end;
    end;

Begin
  If pMostraMsg then { Colocado para não ficar piscando quando exite outra mensagem na barra }
    msg('Gravando dados contábeis em tabela auxiliar ...');

  CriaEstruturaTabela;

  with TMemoryTable(pMtDadosIntegracaoCTB^ )do
  begin
    open;
    Append;
    FieldByName('Valor'    ).AsFloat   := pValor;
    FieldByName('DC'       ).AsString  := pDC;
    FieldByName('Conta'    ).AsString  := pContaCTB;
    FieldByName('Custo'    ).AsString  := pCustoCTB;
    FieldByName('Conjunto' ).AsInteger := pConjunto;
    FieldByName('Historico').AsString  := IIF(p_HitoricoText <> '',
                                              p_HitoricoText,
                                              copy(GeraHistoricoContabilOuBancario( pCodHistoCTB, pPlano, pEmpresa, pFilial, 'CTB', pCodTpDespesa, ''),1,254));
    Post;
  end;
  If pMostraMsg then
    msg;
end;

Function EfetuaIntegracaoComCTBComBaseNosDadosContabeis(pMtDadosIntegracaoCTB: Pointer; pEmpresa, pFilial, pPlano : Integer; pData : TDateTime) : TRetornoDadosContabiesAposIntegracao;

var vQtdDebitos, vQtdCreditos, ContraDebito, ContraCredito,
    vPrimeiroItemDocto, vCont, vRegistros, IndexCTB, vItemLanca  : Integer;
    vPosReg, vDoctoCTB                               : String;
    vTimeStamp                                       : TTimeStamp;
    Stp_GravaLanca                                   : TStoredProc;
    qrBusca, qrInsert                                : TQuery;


////////////////
    Function ContaContabilExiste(pCodContaCTB : String) : boolean;
    begin
      With qrBusca do
      begin
        Close;
        sql.Clear;
        sql.Add('SELECT LANCAMENTO'           );
        sql.Add('  FROM CTBCONTA'             );
        sql.Add(' WHERE NROPLANO = :PPLANO'   );
        sql.Add('   AND CODCONTACTB = :PCONTA');
        ParamByName('PPlano').AsInteger := pPlano;
        ParamByName('PConta').AsString  := pCodContaCTB;
        Open;
        If IsEmpty then
        begin
          mensagemDlg( 'Conta contábil ' + pCodContaCTB
                     + 'não cadastrada para o plano '
                     + IntToStr(pPlano) + '.'
                     + #13
                     + 'Integração cancelada.', mtInformacao, mbok);
          Result := False;
          exit;
        end;
        If FieldByName('Lancamento').AsString = 'N' then
        begin
          mensagemDlg( 'Conta contábil ' + pCodContaCTB
                     + ' não permite lançamento.'
                     + #13
                     + 'Integração cancelada.', mtInformacao, mbok);
          Result := False;
          exit;
        end;
        Result := True;
      end;
    end;

//////////////////////
    Function CentroDeCustosContabilExiste(pCodCustoCTB : String) : boolean;
    begin
      With qrBusca do
      begin
        Close;
        sql.Clear;
        sql.Add('SELECT CODCUSTO'          );
        sql.Add('  FROM CTBCUSTO'          );
        sql.Add(' WHERE NROPLANO = :PPLANO');
        sql.Add('   AND CODCUSTO = :PCUSTO');
        ParamByName('PPlano').AsInteger := pPlano;
        ParamByName('PCusto').AsString  := pCodCustoCTB;
        Open;
        If IsEmpty then
        begin
          mensagemDlg( 'Centro de custos contábil ' + pCodCustoCTB
                     + ' não cadastrada para o plano '
                     + IntToStr(pPlano) + '.'
                     + #13
                     + 'Integração cancelada.', mtInformacao, mbok);
          Result := False;
          exit;
        end;
        Result := True;
      end;
    end;

//////////////////////
    function ProximoItemLanca( pCodLanca : Integer ):Integer;
    Begin

      With qrBusca do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( 'SELECT MAX(CODITEMLANCA) AS NEXT'     );
        SQL.Add( ' FROM CTBITLNC WHERE CODLANCA = :P0'  );
        params[0].AsInteger := pCodLanca;
        Open;
        Result := FieldByName( 'NEXT' ).AsInteger + 1;
      end;

    end;
//////////////////////

    Procedure GravaContrapartida(pConjunto : Integer);
    begin
      With TMemoryTable(pMtDadosIntegracaoCTB^ ) do
      begin
        BookMark := vPosReg;
        vCont    := vPrimeiroItemDocto;
        While (vCont <= vRegistros)  do
        begin
          If FieldByName('Conjunto').AsInteger <> pConjunto then
            Break;

          If FieldByName('DC').AsString = 'D' then
            ContraDebito  := FieldByName('Conta').AsInteger
          else
            ContraCredito := FieldByName('Conta').AsInteger;
          Inc(vCont);
          Next;
        end;
        BookMark := vPosReg;
        vCont    := vPrimeiroItemDocto;
        While (vCont <= vRegistros) do
        begin
          If FieldByName('Conjunto').AsInteger <> pConjunto then
            Break;
            
          Edit;
          If FieldByName('DC').AsString = 'D' then
          begin
            If ((vQtdDebitos >= 1) and (vQtdCreditos = 1)) then
              FieldByName('ContraPartida').AsInteger := ContraCredito
            else
            If (vQtdDebitos > 1) and (vQtdCreditos > 1) then
              FieldByName('ContraPartida').AsString := '';
          end
          else
          begin
            If ((vQtdDebitos = 1) and (vQtdCreditos >= 1)) Then
              FieldByName('ContraPartida').AsInteger := ContraDebito
            else
            If (vQtdDebitos > 1) and (vQtdCreditos >= 1) then
              FieldByName('ContraPartida').AsString := '';
          end;
          Post;
          Inc(vCont);
          Next;
        end;
      end;
    end;

    Procedure DefineContraPartidas;
    var vConjunto: Integer;
    begin
      { Verifico as contrapartidas }
      With TMemoryTable(pMtDadosIntegracaoCTB^ ) do
      begin
        Open;
        First;
        vRegistros := 0;

        Msg('Verificando contrapartidas ...');
        vConjunto := FieldByName('Conjunto').AsInteger;
        While not eof do { Verifica a quantidade de Débitos e Créditos para cada conjunto do docto }
        begin
          If vPosReg = '' then
          begin
            vPosReg :=  BookMark;
            vPrimeiroItemDocto := RecNo;
          end;
          Inc(vRegistros);
          If FieldByName('Conjunto').AsInteger <> vConjunto then
          begin
            GravaContrapartida(vConjunto);
            vConjunto          := FieldByName('Conjunto').AsInteger;
            vQtdDebitos        := 0;
            vQtdCreditos       := 0;
            vPosReg            :=  BookMark;
            vPrimeiroItemDocto := RecNo;
          end;
          If FieldByName('DC').AsString = 'D' then Inc(vQtdDebitos)
          else inc(vQtdCreditos);
          Next;
        end; {While not eof do}
      end;
      GravaContrapartida(vConjunto);
    end;
/////////////////
Begin
  qrBusca               := TQuery.Create( Application );
  qrBusca.DataBaseName := cDatabaseName;

  With TMemoryTable(pMtDadosIntegracaoCTB^ ) do
  begin
    open;
    First;
    While not eof do
    begin
      If not ContaContabilExiste(FieldByName('Conta').AsString) then
      begin
        Result.CodLanca   := 0;
        Result.DoctoLanca := '';
        qrBusca.Free;
        exit;
      end;
      If FieldByName('Custo').AsString <> '' then
      begin
        If not CentroDeCustosContabilExiste(FieldByName('Custo').AsString) then
        begin
          Result.CodLanca   := 0;
          Result.DoctoLanca := '';
          qrBusca.Free;
          exit;
        end;
      end;
      Next;
    End;
  end;
  qrInsert              := TQuery.Create( Application );
  qrInsert.DataBaseName := cDatabaseName;

  Stp_GravaLanca                := TStoredProc.Create( Application );
  With Stp_GravaLanca do
  begin
    DataBaseName   := cDatabaseName;
    StoredProcName := 'PR_CTB_GRAVALANC';

    With Params do
    begin
      CreateParam(ftFloat,   'PCODLANCA'           , ptInput);
      CreateParam(ftFloat,   'PCODITEMLANCA'       , ptInput);
      CreateParam(ftFloat,   'PNROPLANO'           , ptInput);
      CreateParam(ftFloat,   'PVRITEMLANCA'        , ptInput);
      CreateParam(ftString,  'PDEBITOCREDITO'      , ptInput);
      CreateParam(ftString,  'PHISTORICO'          , ptInput);
      CreateParam(ftFloat,   'PCONJUNTO'           , ptInput);
      CreateParam(ftFloat,   'PCODCONTACTB'        , ptInput);
      CreateParam(ftFloat,   'PCODCUSTO'           , ptInput);
      CreateParam(ftString,  'PDATA'               , ptInput);
      CreateParam(ftFloat,   'PEMPRESA'            , ptInput);
      CreateParam(ftFloat,   'PFILIAL'             , ptInput);
      CreateParam(ftString,  'P_EXECPROCPERIODO'   , ptInput);
      CreateParam(ftFloat,   'PCONTRAPARTITEMLANCA', ptInput);
      CreateParam(ftString,  'PMENSAGEM'           , ptOutput);
    end;
  end;

  Result.CodLanca   := 0;
  Result.DoctoLanca := '';

  vQtdDebitos   := 0; vQtdCreditos := 0; ContraDebito := 0; vPrimeiroItemDocto := 0;
  ContraCredito := 0;

  DefineContraPartidas;

  vTimeStamp := DateTimeToTimeStamp(Now);
  vDoctoCTB  :=  'SQ' + StrZero(vTimeStamp.Time, 8);

  IndexCTB   := TrazProximoCodLanca;

  With qrInsert do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'INSERT INTO CTBLANCA' );
    SQL.Add( '(CODLANCA, DTLANCA, SISTEMA, USUARIO, CODIGOEMPRESA,');
    SQL.Add( 'CODIGOFL, DOCUMENTOLANCA, LOTELANCA, LCTOMODIFICADO)');
    SQL.Add( ' VALUES( :P0,:P1,:P2,:P3,:P4,:P5,:P6,:P7,:P8 )' );

    params[0].AsInteger  := IndexCTB;
    params[1].AsDateTime := pData;
    params[2].AsString   := vcSistema;
    params[3].AsString   := vcUsuario;
    params[4].AsInteger  := pEmpresa;
    params[5].AsInteger  := pFilial;
    params[6].AsString   := vDoctoCTB;
    params[7].AsString   := vcSistema;
    params[8].AsString   := 'N';
    getsql(qrInsert);
    Try
      execSQL;
    except on E:EDBEngineError do
      Begin
        If mensagemDLG( 'Problemas durante a inclusão do lançamento contábil. Deseja ver o erro ?'
                        , mtInformacao, mbSIM+mbNAO ) = mrSIM then mensagemDLG( MostraErrosQuery(E, False), mtErro, mbOK );
        exit;
      end;
    end; // Try
  end;

  msg('Gravando dados contábeis ...');
  { Grava os lançamento definitivamente }
  With TMemoryTable(pMtDadosIntegracaoCTB^ ) do
  begin
    open;
    first;
    While not eof do
    begin
      With Stp_GravaLanca do
      begin
        vItemLanca := ProximoItemLanca(IndexCTB);
        ParamByName( 'PCODLANCA'         ).AsInteger := IndexCTB;
        ParamByName( 'PCODITEMLANCA'     ).AsInteger := vItemLanca;
        ParamByName( 'PNROPLANO'         ).AsInteger := pPlano;
        ParamByName( 'PVRITEMLANCA'      ).AsFloat   := TMemoryTable(pMtDadosIntegracaoCTB^ ).FieldByName('Valor').AsFloat;
        ParamByName( 'PDEBITOCREDITO'    ).AsString  := Trim(TMemoryTable(pMtDadosIntegracaoCTB^ ).FieldByName('DC').AsString);
        ParamByName( 'PHISTORICO'        ).AsString  := Trim(Copy(TMemoryTable(pMtDadosIntegracaoCTB^ ).FieldByName('Historico').AsString,1,254));
        ParamByName( 'PCONJUNTO'         ).AsInteger := 1;
        ParamByName( 'PCODCONTACTB'      ).AsString  := Trim(TMemoryTable(pMtDadosIntegracaoCTB^ ).FieldByName('Conta').AsString);
        ParamByName( 'PCODCUSTO'         ).AsString  := Trim(TMemoryTable(pMtDadosIntegracaoCTB^ ).FieldByName('Custo').AsString);
        ParamByName( 'PDATA'             ).AsString  := FormatDateTime( 'YYYYMM', pData);
        ParamByName( 'PEMPRESA'          ).AsInteger := pEmpresa;
        ParamByName( 'PFILIAL'           ).AsInteger := pFilial;
        ParamByName( 'P_EXECPROCPERIODO' ).AsString  := Trim(CTBVerificaSeGravaSaldoNoProximoMes(pEmpresa,pFilial,pData));
        ParamByName( 'PCONTRAPARTITEMLANCA' ).AsString := Trim(TMemoryTable(pMtDadosIntegracaoCTB^ ).FieldByName('Contrapartida').AsString);
        Try
          execPROC;
        except on E:EDBEngineError do
          Begin
            If mensagemDLG( 'Problemas durante gravação do lançamento contabil. Deseja ver o erro ?'
                            , mtConfirmacao, mbSIM+mbNAO ) = mrSIM then mensagemDLG( MostraErrosQuery(E, False), mtErro, mbOK );
            exit;
          end;
        end; { Try }
      end; { With stp_GravaLanca do }
      Next;
    end; { While }
  end; {TMemoryTable(pMtDadosIntegracaoCTB^ ) }

  { Ajusta o número do lançamento para o próximo no dia }
  vDoctoCTB       := CTBProximoDocumentoNoDia( pEmpresa, pFilial, pData, True, IndexCTB ) ;

  With qrBusca Do
  begin
    Close;
    SQL.Clear;
    SQL.Add( 'UPDATE CTBLANCA'         );
    SQL.Add( 'SET DOCUMENTOLANCA = :P0');
    SQL.Add( ' WHERE CODLANCA    = :P1');
    Params[0].AsString  := vDoctoCTB ;
    Params[1].AsInteger := IndexCTB;
    Try
      ExecSql;
    except on E:EDBEngineError do
      Begin
        If mensagemDLG( 'Problemas durante a atualização de contabilidade. Deseja ver o erro ?'
                        , mtInformacao, mbSIM+mbNAO ) = mrSIM then mensagemDLG( MostraErrosQuery(E, False), mtErro, mbOK );
        exit;
      end;
    end; { Try }
  end;
  Result.CodLanca   := IndexCTB;
  Result.DoctoLanca := vDoctoCTB;

  qrBusca.Free;
  qrInsert.Free;
  Stp_GravaLanca.Free;
  msg;
end;


{ Substitui a TrataHistorico_teste }
Function GeraHistoricoContabilOuBancario( pCodHist, pPlano, pEmpresa, pFilial : Integer; pTpHist : String; pTpDesp : String = ''; pTpRec : String = '' ):String;
var Str                       : String;
    qrDescHisto               : TQuery;
Begin
  qrDescHisto              := TQuery.Create( Application );
  qrDescHisto.DataBaseName := cDatabaseName;

  Str := '';
  If pTpHist = 'CTB' then
  begin
    If (Trim(pTpDesp) <> '') or (Trim(pTpRec) <> '') then
    begin
      With qrDescHisto do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( 'SELECT DESCRICAO DESCHISTO FROM CTBHIST_DESP_REC' );
        SQL.Add( ' WHERE CODHISTO = :P0'  );
        SQL.Add( ' AND NROPLANO = :P1'    );
        If Trim(pTpDesp) <> '' then
          SQL.Add( ' AND CODTPDESPESA = :P2'    );
        If Trim(pTpRec) <> '' then
          SQL.Add( ' AND CODTPRECEITA = :P2'    );
        params[0].AsInteger := pCodHist;
        params[1].AsInteger := pPlano;
        If Trim(pTpDesp) <> '' then
          params[2].AsString := pTpDesp;
        If Trim(pTpRec) <> '' then
          params[2].AsString := pTpRec;
        Open;
        Str := FieldByName('DESCHISTO').AsString;
      end;
    end;
    If Str = '' then
    begin
      With qrDescHisto do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( 'SELECT DESCHISTO FROM CTBHISTO' );
        SQL.Add( ' WHERE CODHISTO = :P0'  );
        SQL.Add( ' AND NROPLANO = :P1'    );
        params[0].AsInteger := pCodHist;
        params[1].AsInteger := pPlano;
        Open;

        If ( vcCodigoCliente = 1 ) and ( pCodHist = 916 ) then // Reunidas & TpContabiliza = BAIXA
        Begin
          If Trim( vcVariaveisDeHistContabeis.Documento.ObsDocto ) = '' then
          begin
            If ( Trim( vcVariaveisDeHistContabeis.FornOuCli.RSocial ) <> '' ) and ( Trim( vcVariaveisDeHistContabeis.Documento.Favorecido ) <> '' ) then
               frmMenuPrincipal.v_RS := '';
          end
          else
          Begin
            vcVariaveisDeHistContabeis.FornOuCli.RSocial    := '' ;
            vcVariaveisDeHistContabeis.Documento.Favorecido := '' ;
          end;
        end;
      end;
    end;
  end
  else
  With qrDescHisto do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT DESCHISTOBCO DESCHISTO FROM BCOHISTO'    );
    SQL.Add( ' WHERE CODHISTOBCO = :P0'  );
    SQL.Add( ' AND CODIGOFL = :P1'       );
    SQL.Add( ' AND CODIGOEMPRESA = :P2'  );
    params[0].AsInteger := pCodHist;
    params[1].AsInteger := pFilial;
    params[2].AsInteger := pEmpresa;
    Open;
  end;

  {
    Cuidado com a ordem das substituições, pois o %D está contido em %DTD. Esta rotina
    sempre deverá substituir o " %XX " pela variável e não por outro " %XX ".
    *************      Erik Mazzei      ***************
  }

  With vcVariaveisDeHistContabeis do
  begin
    If (Trim(FornOuCli.RSocial) = Trim(Documento.Favorecido)) then { Reunidas reclamou de duplicidade }
      Documento.Favorecido := '';

    Str := StringReplace( qrDescHisto.FieldByName( 'DESCHISTO' ).AsString , '%CF'  , FornOuCli.Numero              , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%TXT' , TXT                           , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%NMOT', PlanoViagem.NomeMotorista     , [rfReplaceAll, rfIgnoreCase] );     { para o DVS }
    Str := StringReplace( Str                                             , '%TD'  , TipoDocto.Codigo              , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%NFF' , FornOuCli.NFantasia           , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%DTD' , TipoDocto.Descricao           , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%DTS' , FormatDateTime('dd/mm/yyyy', date), [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%DV'  , Documento.DtVencimento        , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%PE'  , Documento.DoctoPE             , [rfReplaceAll, rfIgnoreCase] ); // PAGAMENTO ELETRONICO
    Str := StringReplace( Str                                             , '%CQ'  , Documento.NrCheque            , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%BO'  , Documento.NrBordero           , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%RS'  , FornOuCli.RSocial             , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%OID' , Documento.ObsItemDocto        , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%OD'  , Documento.ObsDocto            , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%FAV' , Documento.Favorecido          , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%HCQ' , Documento.HistCheque          , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%N_OP', Documento.NrOP                , [rfReplaceAll, rfIgnoreCase] ); { descomentei esta linha. Verônica 03/01/05 }
    Str := StringReplace( Str                                             , '%FP'  , Documento.FormaPagto          , [rfReplaceAll, rfIgnoreCase] ); { Marta 17/05/05 }

    Str := StringReplace( Str                                             , '%CPDMA', Folha.CompFolhaDDMMYYYY        , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%CPMA' , Folha.CompFolhaMMYYYY          , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%TP'   , Folha.TipoFolha                , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%CAE'  , Folha.AgrupEventos.Codigo      , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%DAR'  , Folha.AgrupEventos.Descricao   , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%CCT'  , Contabil.CodConta              , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%DCT'  , Contabil.DescConta             , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%CACT' , Folha.AgrupContabil.Codigo     , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%DACT' , Folha.AgrupContabil.Descricao  , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%DCCC' , Contabil.DescCCusto            , [rfReplaceAll, rfIgnoreCase] );

    Str := StringReplace( Str                                             , '%DCC'  , Contabil.DescConta             , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%SD'   , Documento.SerieDocto           , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%D'    , Documento.NrDocto              , [rfReplaceAll, rfIgnoreCase] );
    Str := StringReplace( Str                                             , '%P'    , Documento.NrParcela            , [rfReplaceAll, rfIgnoreCase] );
  end;

  Result := Str;

end;

function StrToChar(S: String): Char;
begin
  if Trim(S) = '' then
    Result := ' '
  else
    Result := S[1];
end;

function ColocarFoco(vControle: TWinControl): Boolean;
begin
  Result := false;
  if (vControle <> nil) and
     (vControle.CanFocus) then
  begin
    if (Screen.ActiveControl <> vControle) and
       not(vControle.Focused) then
      vControle.SetFocus;
    Result := true;
  end;
end;

Function ValorDoIndiceParaConversao(pCodIndic : String; pVencimento : TDateTime ) : Double;
Var qrIndice : TQuery;
Begin
  qrIndice              := TQuery.Create( Application );
  qrIndice.DataBaseName := cDatabaseName;

  Result := 0;
  With qrIndice do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT VLINDIC FROM FININDVL');
    SQL.Add('WHERE CODINDIC = :P_Codigo AND DTINDIC = :P_Data');
    ParamByName('P_Codigo').AsString   := pCodIndic;
    ParamByName('P_Data'  ).AsDateTime := pVencimento;
    Open;
    If not IsEmpty then
      Result := FieldByName('VLINDIC').AsFloat
    else
      MensagemDlg('Índice ' + pCodIndic + ' sem valor em ' + DateToStr(pVencimento), mtErro, mbOk);
    Free;
  end;
end;

Function FilialQueOUSuarioTemAutorizacao(pEmpresa, pFilialIni, pFilialFin : Integer ) : TFilialAutorizadasParaoUsuario;
var vFaixaDeFilial : String;
    vQry : TQuery;
begin
  vFaixaDeFilial := '';
  Result.Msg     := '';
  vQry := TQuery.Create(Nil);
  With vQry Do
  Begin
    DatabaseName := cDatabaseName ;
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT DISTINCT A.CODIGOFL Filial '                    );
    Sql.Add(' FROM CTR_FILIAL A, CTR_EMPAUTORIZADAS B, '             );
    Sql.Add(' CTR_AUTORIZACAOUSUARIOS C, CTR_GRUPOUSUARIOS D, '      );
    Sql.Add(' CTR_CADASTRODEUSUARIOS  E, CTR_AUTORIZACAOSISTEMAS F'  );
    Sql.Add(' WHERE A.CODINTEMPAUT = B.CODINTEMPAUT AND '            );
    Sql.Add(' C.CODINTEMPAUT = B.CODINTEMPAUT AND '                  );
    Sql.Add(' D.CODIGOGRPUSU = C.CODIGOGRPUSU AND '                  );
    Sql.Add(' E.CODIGOGRPUSU = D.CODIGOGRPUSU AND '                  );
    Sql.Add(' F.CODINTEMPAUT = B.CODINTEMPAUT AND '                  );
    If (vcUsuario <> 'GLOBUS') and (vcUsuario <> 'MANAGER') Then
    begin
      Sql.Add(' E.USUARIO = :P_USUARIO AND '                         );
      ParamByName('P_USUARIO'   ).AsString  := vcUsuario ;
    end;
    Sql.Add(' F.SISTEMA = :P_SISTEMA AND '                           );
    Sql.Add(' A.CODIGOEMPRESA = :P_EMPRESAINI AND '                  );
    Sql.Add(' A.CODIGOFL BETWEEN :P_FILIALINI AND :P_FILIALFIN '     );
    Sql.Add(' ORDER BY CODIGOFL'                                     );

    ParamByName('P_SISTEMA'   ).AsString  := vcSistema ;
    ParamByName('P_EMPRESAINI').AsInteger := pEmpresa  ;
    ParamByName('P_FILIALINI' ).AsInteger := pFilialIni;
    ParamByName('P_FILIALFIN' ).AsInteger := pFilialFin;
    Open ;
    GetSql(vQry);
    If IsEmpty then
    begin
      if (( upperCase(vcUsuario) <> 'MANAGER') and (upperCase(vcUsuario) <> 'GLOBUS')) THEN
        Result.Msg := 'Usuário sem acesso à faixa de filiais informadas.';
    end
    else
    begin
      While not eof do
      begin
        vFaixaDeFilial := vFaixaDeFilial + FieldByName('Filial').AsString + ',';
        Next;
      end;
      vFaixaDeFilial := Copy(vFaixaDeFilial,1,Length(vFaixaDeFilial) -1);
    end;
  end;
  Result.FaixaDeFilial := vFaixaDeFilial;
end;

Function ModuloAutorizadoParaEmpFil(pEmpresa : Integer; pSistema : String; pFilial : Integer = 0) : Boolean;
Var vQry : TQuery;
begin
  vQry := TQuery.Create(Nil);
  With vQry Do
  Begin
    DatabaseName := cDatabaseName ;
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT A.CODIGOFL Filial '                   );
    Sql.Add(' FROM CTR_FILIAL A, CTR_EMPAUTORIZADAS B, '   );
    Sql.Add('  CTR_AUTORIZACAOSISTEMAS F'                  );
    Sql.Add(' WHERE A.CODINTEMPAUT = B.CODINTEMPAUT AND '  );
    Sql.Add(' A.CODINTEMPAUT = B.CODINTEMPAUT AND '        );
    Sql.Add(' F.CODINTEMPAUT = B.CODINTEMPAUT AND '        );
    Sql.Add(' F.SISTEMA = :P_SISTEMA AND '                 );
    Sql.Add(' A.CODIGOEMPRESA = :P_EMPRESAINI AND '        );
    Sql.Add(' A.CODIGOFL = :P_FILIAL  '                    );

    ParamByName('P_SISTEMA'   ).AsString  := pSistema;
    ParamByName('P_EMPRESAINI').AsInteger := pEmpresa;
    ParamByName('P_FILIAL'    ).AsInteger := pFilial ;
    Open ;
    GetSql(vQry);
    Result := Not IsEmpty;
  end;
end;

Function CalculoDeJurosDiarioEmValorOuPercentual(pPercentual_Juros, pValor : Double) : Double;
begin
  Result := 0;

  If pPercentual_Juros > 0 then
  begin
    if pValor > 0 Then
      Result :=  (((pValor * pPercentual_Juros) / 100) / 30)
    else
      Result :=  (pPercentual_Juros / 30 )
  end;
end;

function Modulo11(Valor: String; Base: Integer = 9; Resto : boolean = false; Incrementa : boolean = True; pBanco : String = '') : string;
var
   Soma : integer;
   Contador, Peso, Digito, v1Digito : integer;
   vValorAux, vDigitos : String;
begin
  Soma     := 0;
  Peso     := IIF(Incrementa,2,9);
  for Contador := Length(Valor) downto 1 do
  begin
    Soma := Soma + (StrToInt(Valor[Contador]) * Peso);

    If Incrementa then
    begin
      if Peso < Base then
        INC(Peso)
      else
        Peso := 2;
    end
    else
    begin
      if (Peso <= Base) and (peso > 2) then
        Dec(Peso)
      else
        Peso := 9;
    end;
  end;
  If pbanco = cBCO_BanriSul then
  begin
    v1Digito := StrToInt(Copy(Valor,Length(Valor),1));
    If (Soma mod 11) > 1 then
    begin
      Digito := 11 - (Soma mod 11);
      vDigitos := IntToStr(v1Digito) + IntToStr(Digito);
    end
    else
    begin
      If (Soma mod 11) = 0 then { Pega o próprio resto }
      begin
        Digito := (Soma mod 11);
        vDigitos := IntToStr(v1Digito) + IntToStr(Digito);
      end
      else { Soma- se mais 1 ao Digito do modulo 10 e refaz o calculo do Modulo11 }
      begin
        If v1Digito = 9 then
          v1Digito := 0
        else
          v1Digito := v1Digito + 1;

        vValorAux := Copy(Valor,1,Length(Valor) - 1) + IntToStr(v1Digito);
        vDigitos := Modulo11(vValorAux,7, False, True, cBCO_BanriSul);
      end;
    end;
    Result := vDigitos;
  end
  else
  begin
    if Resto then
      Digito := (Soma mod 11)
    else
      Digito := 11 - (Soma mod 11);

    if not Resto and (Digito > 9) then
      Digito := 0;
    Result := IntToStr(Digito);
  end;
end;

function Modulo10(Valor: String) : string;
var
   Auxiliar : string;
   Contador, Peso : integer;
   Digito : integer;
begin
  Auxiliar := '';
  Peso := 2;
  for Contador := Length(Valor) downto 1 do
  begin
    Auxiliar := IntToStr(StrToInt(Valor[Contador]) * Peso) + Auxiliar;
    if Peso = 1 then
       Peso := 2
    else
       Peso := 1;
  end;

  Digito := 0;
  for Contador := 1 to Length(Auxiliar) do
  begin
    Digito := Digito + StrToInt(Auxiliar[Contador]);
  end;
  Digito := 10 - (Digito mod 10);
  if (Digito > 9) then
     Digito := 0;
  Result := IntToStr(Digito);
end;

Function RetornaStringComSomaDeValoresGrandesSemExpoentes(pValor1, pValor2 : String; pQtdDeQuebras, pOperador : Integer) : String;
var
 vArraySoma, vArraySoma2, vArrayResult, vArrayMult : array of string;
 vAux, vStringSoma : String;
 i, j, vTamanho, vResto : Integer;

 Procedure DefineTamanho(pValor : String) ;
 begin
    { Define tamanho dos array }
   If Length(pValor) Mod pQtdDeQuebras > 0 then
     vTamanho := StrToInt(FloatToStr(Int(Length(pValor) / pQtdDeQuebras) + 1))
   else
     vTamanho := StrToInt(FloatToStr(Int(Length(pValor) / pQtdDeQuebras))) ;

   FillChar( varraySoma, SizeOF( varraySoma), 0 );
   SetLength(varraySoma, vTamanho );
   FillChar( varraySoma2, SizeOF( varraySoma2), 0 );
   SetLength(varraySoma2, vTamanho );
   FillChar( vArrayResult, SizeOF( vArrayResult), 0 );
   SetLength(vArrayResult, vTamanho );
   FillChar( varrayMult, SizeOF( varrayMult), 0 );
   SetLength(varrayMult, vTamanho);
 end;

 Procedure PreencheVariveis(pValor : String; pTipoArray : Integer);
 begin
    i    := Length(pValor) ;
    vAux := pValor;
    j    := 0;

    While i > 0 do
    begin
      Case pTipoArray of
        0 :  vArraySoma[j]  := copy(vAux,Length(vAux)-(pQtdDeQuebras-1),pQtdDeQuebras);
        1 :  vArraySoma2[j] := copy(vAux,Length(vAux)-(pQtdDeQuebras-1),pQtdDeQuebras);
        2 :  vArrayMult[j]  := copy(vAux,Length(vAux)-(pQtdDeQuebras-1),pQtdDeQuebras);
      end;
      vAux := Copy(vAux,1,Length(vAux)-pQtdDeQuebras);
      inc(j);
      i    := Length(vAux) ;
    end;
 end;

 Procedure Calcular(pTipoArray : Integer);
 Var i : Integer;
 begin
   Case pTipoArray of
   0 : begin
         For i := 0 to Length(vArraySoma) -1 do
         begin
           vAux := StrZero(StrToIntDef(vArraySoma[i],0) + StrToIntDef(vArraySoma2[i],0) + vResto,pQtdDeQuebras);
           If Length(vAux) > pQtdDeQuebras then
             vresto := StrToIntDef(copy(vAux,1, Length(vAux)-pQtdDeQuebras),0)
           else
             vResto := 0;
            vArrayResult[i] := Copy(vAux,Length(vAux)-(pQtdDeQuebras-1),pQtdDeQuebras);
         end;
      end;
   1 : begin
          For i := 0 to Length(vArrayMult) -1 do
          begin
            vAux := StrZero( (  StrToIntDef(vArrayMult[i],0) * pOperador ) + vResto,pQtdDeQuebras);
            If Length(vAux) > pQtdDeQuebras then
              vresto := StrToIntDef(copy(vAux,1, Length(vAux)-pQtdDeQuebras),0)
            else
              vResto := 0;

            vArrayResult[i] := Copy(vAux,Length(vAux)-(pQtdDeQuebras-1),pQtdDeQuebras);
          end;
       end;
   end;
 end;

 Function ConcatenaArray : String;
 var i : Integer;
 begin
   For i := Length(vArrayResult) -1 downto 0 do
    vStringSoma := vStringSoma + vArrayResult[i] ;

   Result := Copy(vStringSoma,Length(vStringSoma)-17,18);
 end;
 
begin
  { Prepara para a Soma de strings }
  DefineTamanho(pValor1);

  PreencheVariveis(pValor1, 0);
  PreencheVariveis(pValor2, 1);

  vresto := 0;

  Calcular(0); { Soma }

  vStringSoma := ConcatenaArray;

  { Perpara para a multiplicação }
  DefineTamanho(vStringSoma);

  PreencheVariveis(vStringSoma, 2);

  FillChar( vArrayResult, SizeOF( vArrayResult), 0 );
  SetLength(vArrayResult, vTamanho );

  vresto := 0;

  Calcular(1); { Multiplica }

  Result := ConcatenaArray;
end;

function TrazMascaraNumeroOP : String;
begin
  Result := '';
  If (vcCodigoCliente = cCodCli_ETCD) then     // ETCD
    Result := '999999/9999'
end;

function TrazMascaraNrProcesso : String;
begin
  Result := '';
  If (vcCodigoCliente = cCodCli_ETCD ) then
    Result := '9999999/9999';
end;

Function ModuloAutorizado(pSistema : String) : Boolean;
Var vQry : TQuery;
begin
  vQry := TQuery.Create(Nil);
  With vQry Do
  Begin
    DatabaseName := cDatabaseName ;
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT DISTINCT SISTEMA '    );
    Sql.Add(' FROM CTR_AUTORIZACAOSISTEMAS ');
    Sql.Add(' WHERE SISTEMA = :P_SISTEMA '  );

    ParamByName('P_SISTEMA'   ).AsString  := pSistema;
    Open ;
    GetSql(vQry);
    Result := Not IsEmpty;
  end;
end;

function HoraToInt(vHora: TDateTime): Integer;
var S: String;
begin
  if vHora = 0 then
    S := '0'
  else
    S := FormatDateTime('HHNN', vHora) ;
  Result := StrToIntDef(S, 0) ;
end;

function IntToHora(vHora: Integer): TDateTime;
var S: String;
begin
  S := StrZero(vHora, 4);
  Result := StrToDateTime(Copy(S, 1, 2) + ':' +
                          Copy(S, 3, 2)
                         );
end;

procedure AtribuirParametrosAPartirDoDataSet(DataSet: TDataSet; qrySQL: TQuery);
var
  i: Integer;
begin

  with qrySQL do
  begin
    Close;
      // Atribui valores gerais
    for i := 0 to ParamCount - 1 do
    begin

      if (DataSet.FindField(Params[i].Name) <> nil) and
         not(DataSet.FieldByName(Params[i].Name).IsNull) then
        Params[i].Value := DataSet.FieldByName(Params[i].Name).Value
      else
        Params[i].AsString := '';

    end;
  end;
end; // procedure AtribuirParametrosAPartirDoDataSet



function IdentificarAlteracoes(vAtual, vAnterior: TQuery): String;
// Esta função compara os Parâmetros de vAtual com os Campos de vAnterior.
// Para tanto, é necessário que os parâmetros tenha o mesmo nome dos campos

   function TratarVazio(S: String): String;
   begin
     if Trim(S) = '' then
       Result := '<vazio>'
     else
       Result := S;
   end;

var
  i: Integer;
  vCampo: String;
  vVlrAnterior: String;
  vVlrAtual: String;
begin

  Result := '';
  for i := 0 to vAtual.Params.Count - 1 do
  begin
    vCampo := vAtual.Params[i].Name;
    // Se existe campo com o mesmo nome do parâmetro
    if vAnterior.FindField(vCampo) <> nil then
    begin
      if (vAnterior.FieldByName(vCampo) is TDateTimeField) then
      begin
        with vAtual.ParamByName(vCampo) do
          if (Trim(AsString) = '') then
            vVlrAtual := FormatDateTime('DD/MM/YYYY HH:NN', 0)
          else
            vVlrAtual := FormatDateTime('DD/MM/YYYY HH:NN', AsDateTime);
        with vAnterior.FieldByName(vCampo) do
          if (Trim(AsString) = '') then
            vVlrAnterior := FormatDateTime('DD/MM/YYYY HH:NN', 0)
          else
            vVlrAnterior := FormatDateTime('DD/MM/YYYY HH:NN', AsDateTime);
      end

      else

      begin
        vVlrAtual := vAtual.ParamByName(vCampo).AsString;
        vVlrAnterior := vAnterior.FieldByName(vCampo).AsString;
      end;

      if (vCampo <> 'DATA_ALTERACAO') and
          ( vVlrAnterior <> vVlrAtual )  then
        Result := Result + ' ' + vCampo +
                  ' de ' + TratarVazio(vVlrAnterior) +
                  ' para ' + TratarVazio(vVlrAtual) + '.';
    end;
  end;

end;

Function CTBValidaClassificadorAuxiliar(pPlano : integer; pDesprezaContaSemClas : boolean = false) : boolean;
var
  vQryAjuda : TQuery;
begin
  vQryAjuda := TQuery.Create(Nil);
  Msg('Validando a estrutura dos classificadores auxiliares...');
  With vQryAjuda Do
  Begin
    { Valida a máscara dos classificadores auxiliares das contas contábeis }
    DatabaseName := cDatabaseName ;
    Close;
    Sql.Clear;
    sql.Add('SELECT DISTINCT                                      ');
    sql.Add('  C.CLASS_AUXILIAR, C.CODCONTACTB, C.NOMECONTA       ');
    sql.Add('FROM                                                 ');
    sql.Add('  CTBCONTA C                                         ');
    sql.Add('WHERE                                                ');
    sql.Add('  C.NROPLANO = :PPLANO                               ');
    sql.Add('ORDER BY C.CLASS_AUXILIAR                            ');
    ParamByName('PPLANO').AsInteger := pPlano;
    getsql(vQryAjuda);
    Open;
    vMask      := '';
    vErroMask  := False;
    vMaiorGrau := 0;
    While Not Eof Do
    Begin
      { Validações dos classificadores }
      If (Trim(FieldByName('CLASS_AUXILIAR').AsString) = '') and (pDesprezaContaSemClas) Then
      begin
        Next;
        Continue;
      end;
      If (Trim(FieldByName('CLASS_AUXILIAR').AsString) = '') and (not pDesprezaContaSemClas) Then
      begin
        vErroMask := True;
        If MensagemDlg('Conta ' + FieldByName('CODCONTACTB').AsString +
                       ' sem classificador auxiliar. Continuar ?', mtAtencao, mbSim + mbNao) = mbNao Then
        Begin
          Msg;
          vQryAjuda.Free;
          Result := false;
          Exit;
        End;
        Next;
        Continue;
      End;
      If vMask <> '' Then // Não entra a 1a vez
      Begin
        If vMask <> MascaraClassificador(Trim(FieldByName('CLASS_AUXILIAR').AsString)) Then
        Begin
          vErroMask := True;
          If MensagemDlg('Conta ' + FieldByName('CODCONTACTB').AsString +
                         ' com máscara de classificador auxiliar diferente. Continuar ?', mtAtencao, mbSim + mbNao) = mbNao Then
          Begin
            Msg;
            vQryAjuda.Free;
            Result := false;
            Exit;
          End;
          Next;
          Continue;
        End;
      End;
      vMask := MascaraClassificador(Trim(FieldByName('CLASS_AUXILIAR').AsString));
      vGrauClas := GrauClassificador(FieldByName('CLASS_AUXILIAR').AsString);
      If vGrauClas < 1 Then
      Begin
        If MensagemDlg('Classificador auxiliar da conta ' + FieldByName('CODCONTACTB').AsString + ' ' + FieldByName('NOMECONTA').AsString +
                       ' com grau inválido: "' + FieldByName('CLASS_AUXILIAR').AsString + '". Continuar ?', mtErro, mbSim + mbNao) = mbNao Then
        Begin
          Msg;
          vQryAjuda.Free;
          Result := false;
          Exit;
        End;
      End;
      vMaiorGrau := Max(vMaiorGrau, vGrauClas);  {identifica o maior grau}
      Next;
    End; // While Not Eof

    If vErroMask Then
    Begin
      Msg;
      MensagemDlg('Não é possível continuar porque o(s) classificador(es) auxiliar(es) não possui(em) máscara(s) adequada(s).', mtErro, mbOk);
      vQryAjuda.Free;
      Result := false;
      Exit;
    End;

    If Pos('.',vMask) = 0 then
    begin
      Msg;
      MensagemDlg('Não é possível continuar, pois não foram definidos níveis para o classificador auxiliar.',MtErro,MbOk);
      vQryAjuda.Free;
      Result := false;
      Exit;
    end;
  End;  // With vQryAjuda Do
  Msg('');
  vQryAjuda.Free;
  Result := true;

end;

Function CTBValidaGrauDosClassificadoresAuxiliares(pPlano : integer) : boolean;
var
  vQuantZeros, i, vPos : integer;
  vRegAtual : TBookmark;
  vClass, vClassSint, vAux : String;
  vQryClass : TQuery;
  vMdClassAuxiliar : TRxMemoryData;
  vMskConta : TMaskEdit;
begin
  vQryClass         := TQuery.Create(Nil);
  vMdClassAuxiliar  := TRxMemoryData.Create(Nil);
  vMskConta         := TMaskEdit.Create(Nil);
  vMskConta.Visible := false;
  {verifica se todos os graus dos classificadores foram definidos}
  With vQryClass do
  begin
    Msg('Validando os graus dos classificadores auxiliares...');
    DatabaseName := cDatabaseName ;
    Close;
    Sql.Clear;
    sql.Add('SELECT DISTINCT                                      ');
    sql.Add('  C.CLASS_AUXILIAR, C.CODCONTACTB, C.NOMECONTA       ');
    sql.Add('FROM                                                 ');
    sql.Add('  CTBCONTA C                                         ');
    sql.Add('WHERE                                                ');
    sql.Add('  C.NROPLANO = :PPLANO                               ');
    sql.Add('  AND C.CLASS_AUXILIAR IS NOT NULL                   ');
    ParamByName('PPLANO').AsInteger := pPlano;
    getsql(vQryClass);
    Open;
    If Not (IsEmpty) then
      vMdClassAuxiliar.LoadFromDataSet(vQryClass,0,lmCopy);
  end;

  vMdClassAuxiliar.SortOnFields('CLASS_AUXILIAR');

  With vMdClassAuxiliar do
  begin
    First;
    While not (EOF) do
    begin
      {analisa somente os classificadores analíticos, afim de encontrar os sintéticos}
      If GrauClassificador(FieldByName('CLASS_AUXILIAR').AsString) <> vMaiorGrau then
      begin
        Next;
        Continue;
      end;
      vQuantZeros := 0;
      vClass    := FieldByName('CLASS_AUXILIAR').AsString;
      vRegAtual := GetBookmark; {guarda o registro atual antes do Locate}
      For i := Length( vClass ) downto 1 do
      Begin
        If Copy( vClass, i, 1 ) = '.' then
        Begin
          vMskConta.EditMask := MascaraClassificador(vClass) + ';0;';
          vMskConta.Text     := NoChar( Copy( vClass , 1, i ) + Replicate( '0', vQuantZeros ), '.' );
          vMskConta.EditMask := MascaraClassificador(vClass)  + ';1;';
          If Not Locate('CLASS_AUXILIAR', vMskConta.Text, [LoCaseInsensitive] ) Then
          Begin
            Msg;
            MensagemDLG( 'Classificador auxiliar "'+ vMskConta.Text + '" não cadastrado.', mtErro, mbOk );
            Result := false;
            vQryClass.Free;
            vMdClassAuxiliar.Free;
            vMskConta.Free;
            Exit;
          End;
        End
        Else
          Inc(vQuantZeros);
      End; // For
      GotoBookmark(vRegAtual); {retorna ao registro que estava antes do Locate}
      Next;
    end;
  end;

  vPos := 0;
  {guarda a posição do último ponto na máscara do classificador}
  For i := length(vMask) downto 1 do
  begin
    If Copy(vMask,i,1) = '.' then
    begin
      vPos := i;
      break;
    end;
  end;

  {verifica se um classificador sintético foi definido em mais de uma conta contábil}
  vAux := Replicate('0',Length(Copy(vMask,vPos+1,Length(vMask))));  {variável que será utilizada no select para identificar as contas sintéticas}
  With vQryClass do
  begin
    Msg('Validando os classificadores sintéticos...');
    Close;
    sql.Clear;
    sql.Add('SELECT COUNT(CLASS_AUXILIAR) AS QTDE, C1.CLASS_AUXILIAR FROM          ');
    sql.Add('    CTBCONTA C1                                                       ');
    sql.Add('WHERE C1.CLASS_AUXILIAR IS NOT NULL                                   ');
    sql.Add('    AND SUBSTR(C1.CLASS_AUXILIAR,' + IntToStr(vPos+ 1) + ',' + IntToStr(length(vAux)) + ') = ' +  QuotedStr(vAux)  );
    sql.Add('    AND C1.NROPLANO = :PPLANO                                         ');
    sql.Add('GROUP BY                                                              ');
    sql.Add('    C1.CLASS_AUXILIAR                                                 ');
    sql.Add(' HAVING                                                               ');
    sql.Add('    COUNT(CLASS_AUXILIAR) > 1                                         ');
    ParamByName('PPLANO').AsInteger := pPlano;
    getsql(vQryClass);
    Open;
    If Not (IsEmpty) then
    begin
      vClassSint := '';
      While not (EOF) do
      begin
        vClassSint := vClassSint + FieldByName('CLASS_AUXILIAR').AsString + ', ';
        Next;
      end;
      vClassSint := Copy(vClassSint,1,length(vClassSint)-2);  // retira a vírgula do final
      MensagemDlg('O(s) classificador(es) sintético(s) ' + vClassSint + ' está(ão) em mais de uma conta contábil.',MtErro,MbOk);
      Result := false;
      vQryClass.Free;
      vMdClassAuxiliar.Free;
      vMskConta.Free;
      Exit;
    end;
    Msg;
  end;
  vQryClass.Free;
  vMdClassAuxiliar.Free;
  vMskConta.Free;
  Result := true;
end;

Function GetValoresDeDoctoSubstituido(pCodDocto : Integer; pModulo : String = 'CPG' ) : TValoresDocto;
Var qrBusca : TQuery;
    vPis, vISS, vAcrescimo, vDesconto, vINSS, vIRRF, vCofins, vCSL, vDescFinanc : Double;
Begin
  qrBusca := TQuery.Create(Application);
  qrBusca.DatabaseName := cDatabaseName;

  vPis  := 0; vISS  := 0; vAcrescimo := 0; vDesconto := 0;
  vINSS := 0; vIRRF := 0; vCofins    := 0; vCSL      := 0;
  vDescFinanc := 0;
  
  with qrBusca do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( 'SELECT NVL(SUM(d.vlrinss'   + pModulo + '),0) AS INSS '     );
    SQL.Add( '     , NVL(SUM(d.vlrirrf'   + pModulo + '),0) AS IR '       );
    SQL.Add( '     , NVL(SUM(d.desconto'  + pModulo + '),0) AS Desconto ' );
    SQL.Add( '     , NVL(SUM(d.acrescimo' + pModulo + '),0) AS Acrescimo' );
    SQL.Add( '     , NVL(SUM(d.vlrpis'    + pModulo + '),0) AS PIS '      );
    SQL.Add( '     , NVL(SUM(d.vlrcofins' + pModulo + '),0) AS Cofins '   );
    SQL.Add( '     , NVL(SUM(d.vlrcsl'    + pModulo + '),0) AS CSL '      );
    SQL.Add( '     , NVL(SUM(d.vlriss'    + pModulo + '),0) AS ISS '      );

    If pModulo = 'CRC' then
      SQL.Add( '     , NVL(SUM(d.DescFinanceiro' + pModulo + '),0) AS DescFinanc ');

    SQL.Add( '     , NVL(SUM(d.vlrinss'   + pModulo + '),0)'  );
    SQL.Add( '     + NVL(SUM(d.vlrirrf'   + pModulo + '),0)'  );
    SQL.Add( '     + NVL(SUM(d.desconto'  + pModulo + '),0)'  );
    SQL.Add( '     + NVL(SUM(d.acrescimo' + pModulo + '),0)'  );
    SQL.Add( '     + NVL(SUM(d.vlrpis'    + pModulo + '),0)'  );
    SQL.Add( '     + NVL(SUM(d.vlrcofins' + pModulo + '),0)'  );
    SQL.Add( '     + NVL(SUM(d.vlrcsl'    + pModulo + '),0)'  );
    SQL.Add( '     + NVL(SUM(d.vlriss'    + pModulo + '),0)'  );
    If pModulo = 'CRC' then
      SQL.Add( '     + NVL(SUM(d.DescFinanceiro' + pModulo + '),0)');

    SQL.Add( ' AS Soma '                                           );
    SQL.Add( '  FROM '                + pModulo + 'Docto d '       );
    SQL.Add( '  , cprtpDoc t');
    SQL.Add( ' WHERE d.coddocto'      + pModulo + 'subst = :pDocto');
    SQL.Add( '    AND T.CODIGOEMPRESA = D.CODIGOEMPRESA'           );
    SQL.Add( '    AND T.CODIGOFL = D.CODIGOFL'                     );
    SQL.Add( '    AND T.CODTPDOC = D.CODTPDOC'                     );
    SQL.Add( ' GROUP BY T.TPCONTABILIZACAO'                        );
    ParamByName('pDocto').AsInteger := pCodDocto;
    getsql(qrBusca);

    Open;
    Result.Registro := False;
    If (not IsEmpty) and (FieldByName('Soma').AsFloat > 0) then
    begin
      Result.Registro           := True;
      While not Eof do
      begin
        vPis       := vPis       + FieldByName('PIS'       ).AsFloat;
        vISS       := vISS       + FieldByName('ISS'       ).AsFloat;
        vAcrescimo := vAcrescimo + FieldByName('ACRESCIMO' ).AsFloat;                                    
        vDesconto  := vDesconto  + FieldByName('DESCONTO'  ).AsFloat;
        vINSS      := vINSS      + FieldByName('INSS'      ).AsFloat;
        vIRRF      := vIRRF      + FieldByName('IR'        ).AsFloat;
        vCofins    := vCofins    + FieldByName('COFINS'    ).AsFloat;
        vCSL       := vCSL       + FieldByName('CSL'       ).AsFloat;

        If pModulo = 'CRC' then
         vDescFinanc := vDescFinanc + FieldByName('DESCFINANC').AsFloat;

        Next;
      end;
    end;

    Result.CPG_CRC.PIS        := vPIS       ;
    Result.CPG_CRC.ISS        := vISS       ;
    Result.CPG_CRC.CSL        := vCSL       ;
    Result.CPG_CRC.INSS       := vINSS      ;
    Result.CPG_CRC.IRRF       := vIRRF      ;
    Result.CPG_CRC.Desconto   := vDesconto  ;
    Result.CPG_CRC.Acrescimo  := vAcrescimo ;
    Result.CPG_CRC.Cofins     := vCofins    ;
    Result.CPG_CRC.DescFinanc := vDescFinanc;
    Free;
  end;
end;

Function TrazDescricaoErroPE_COB(pbanco, pErroPE : String; pOpcao : String = 'PE') : String;
Var a : INteger;
begin
  For a := 1 To Length(vSiglaErroPE) do
  begin
    If (pBanco = vSiglaErroPE[a,1]) and (pErroPe = vSiglaErroPE[a,2]) Then
    begin
      If (pBanco <> cBCO_Unibanco)  and
         (pBanco <> cBCO_Mercantil) and
         (pBanco <> cBCO_BanriSul)  Then
        result := RemoveAcentos(vSiglaErroPE[a,3])
      else
      begin
        If (pOpcao = 'PE') and (pos('[PE -',vSiglaErroPE[a,3]) > 0) then
          result := StringReplace(RemoveAcentos(Copy(vSiglaErroPE[a,3],pos('[PE -',vSiglaErroPE[a,3]) + 5,length(vSiglaErroPE[a,3]))),']','',[rfReplaceAll, rfIgnoreCase])
        else
        If (pOpcao = 'COB') and (pos('[COB -',vSiglaErroPE[a,3]) > 0) then
          result := StringReplace(RemoveAcentos(Copy(vSiglaErroPE[a,3],pos('[COB -',vSiglaErroPE[a,3]) + 5,length(vSiglaErroPE[a,3]))),']','',[rfReplaceAll, rfIgnoreCase])
        else
          result := StringReplace(RemoveAcentos(vSiglaErroPE[a,3]),']','',[rfReplaceAll, rfIgnoreCase])
      end;
      break;
    end;
  end;
end;

Function TemCaracterNaoNumerico(pEntrada : String) : boolean;
Var
  i : Integer;
Begin
  Result := False;
  For i := 1 To Length(pEntrada) Do
  begin
    If (Copy(pEntrada, i, 1) < '0') or (Copy(pEntrada, i, 1) > '9') Then
    begin
      Result := True;
      break;
    end;
  end;
End;


Function CalculaDiferencialDeAliquota(pUFEmp, pUFForn : String; pImposto, pBaseCalculo, pValorContabil, pAliquota : Double) : TCalculoDiferenciaAliquota;
var vUFEmp : TUF;
    vUFFor : TUF;
    vAliqDif : Double;
begin
  vUFEmp                := TUF.Create;

  Result.VlrAliquota    := 0;
  Result.VlrDifAliquota := 0;

  vUFEmp.CodigoUf       := pUFEmp;
  vUFEmp.Atualiza;

  vUFFor                := TUF.Create;
  vUFFor.CodigoUf       := pUFForn;
  vUFFor.Atualiza;

  If vUFEmp.AliquotaIcmsInternaUF <> 0 then
  begin
    If pAliquota = 0 then
      vAliqDif := Abs(vUFFor.AliquotaIcmsInternaUF - vUFEmp.AliquotaIcmsInternaUF)
    else
      vAliqDif := Abs(pAliquota - vUFEmp.AliquotaIcmsInternaUF);

    If pBaseCalculo = 0 then
      Result.VlrDifAliquota := pValorContabil * (vAliqDif/ 100)
    else
      Result.VlrDifAliquota := pBaseCalculo * (vAliqDif / 100);

    Result.VlrAliquota := vAliqDif;
  end;
  vUFEmp.Free;
  vUFFor.Free;
end;

function Arredondar(Valor: Double; Dec: Integer): Double;
var
  Valor1,
  Numero1,
  Numero2,
  Numero3: Double;
begin
  Valor1:=Exp(Ln(10) * (Dec + 1));
  Numero1:=Int(Valor * Valor1);
  Numero2:=(Numero1 / 10);
  Numero3:=Round(Numero2);
  Result:=(Numero3 / (Exp(Ln(10) * Dec)));
end;

Procedure ChamaGlobusReport;
var vDrive : String;
begin
  vDrive := Copy(ParamStr(0),1,2) + '\GLOBUS\SISTEMAS\GlobusReport\GLOBUSREPORT.exe';

  If Not FileExists( vDrive ) Then
  begin
    ShowMessage( 'O arquivo "' + vDrive + '" não existe.');
    exit;
  end;

  WinExec(PChar(vDrive + ' GLOBUS '
               + vcServerName
               + ' '
               + vcUserName
               + ' '
               + vcUserSenha
               + ' '
               + vcUsuario),SW_SHOW);
end;

function Pesquisa(Titulo, Cabecalho, Colunas, RetornoI, RetornoII,
                  OrdemDefault, Tabela, Condicao: String;
                  TrazDadosEntrada: Boolean = True;
                  PesquisaI: String = '';
                  PesquisaII: String = ''): String;
Begin { Incluido na Global para ficar em um lugar único }
  { Pesquisa }
  Try
    With TCTRFrm_Pesquisa.Create(nil) Do
    Begin
      Caption                                := Titulo;
      BrowseDePesquisa1.Cabecalho            := Cabecalho;
      BrowseDePesquisa1.Colunas              := Colunas;
      BrowseDePesquisa1.ColunaRetorno1       := RetornoI;
      BrowseDePesquisa1.ColunaRetorno2       := RetornoII;
      BrowseDePesquisa1.ColPesquisa1         := PesquisaI;
      BrowseDePesquisa1.ColPesquisa2         := PesquisaII;
      BrowseDePesquisa1.OrdemDefaultPesquisa := OrdemDefault;
      BrowseDePesquisa1.TabelaPesquisada     := Tabela;
      BrowseDePesquisa1.CondicaoPrincipal    := '&';
      BrowseDePesquisa1.ValorCondPrincipal   := Condicao;
      BrowseDePesquisa1.TrazDadosEntrada     := TrazDadosEntrada;
      BrowseDePesquisa1.TotalRegistros       := False;
      Showmodal;
      // Result := FrmMenuPrincipal.vRetorno1;
      Result := vpRetorno;
      Free;
    End;
  Except
    CTRFrm_Pesquisa.Free;
  End;
End;

procedure BrowsePesquisaArray(var vRetorno: TRetorno; Titulo, Cabecalho, Colunas, ListaDeRetornos,OrdemDefault,
                   Tabela, Condicao: String;
                   TrazDadosEntrada: Boolean = True;
                   PesquisaI: String = '';
                   PesquisaII: String = '');
var
  i: Integer;
Begin
  { Pesquisa }

  SetLength(vRetorno, 1);
  vRetorno[0] := '';

  Try
    With TCTRFrm_Pesquisa.Create(nil) Do // Fonte está no modulo de controle
      Begin
        Caption                                := Titulo;
        BrowseDePesquisa1.Cabecalho            := Cabecalho;
        BrowseDePesquisa1.Colunas              := Colunas;

        // RetornoI = Colunas separadas por vírgula
        // 'CODIGOEMPRESA,CODIGOFL,DESCRICAO';
        BrowseDePesquisa1.ColunaRetorno1       := ListaDeRetornos;
        BrowseDePesquisa1.ColPesquisa1         := PesquisaI;
        BrowseDePesquisa1.ColPesquisa2         := PesquisaII;
        BrowseDePesquisa1.OrdemDefaultPesquisa := OrdemDefault;
        BrowseDePesquisa1.TabelaPesquisada     := Tabela;
        BrowseDePesquisa1.CondicaoPrincipal    := '&';
        BrowseDePesquisa1.ValorCondPrincipal   := Condicao;
        BrowseDePesquisa1.TrazDadosEntrada     := TrazDadosEntrada;
        BrowseDePesquisa1.TotalRegistros       := False;
        Showmodal;

        SetLength(vRetorno, Length(vetRETORNO));
        for i := Low(vetRETORNO) to High(vetRETORNO) do
          vRetorno[i] := vetRETORNO[i];

        Free;
      End;
  Except
    CTRFrm_Pesquisa.Free;
  End;
End;


initialization

  qrPesqAux := TQuery.Create( qrPesqAux );
  qrPesqAux.DataBaseName := cDatabaseName;
  qrPesqAux2 := TQuery.Create( qrPesqAux );
  qrPesqAux2.DataBaseName := cDatabaseName;

end.

