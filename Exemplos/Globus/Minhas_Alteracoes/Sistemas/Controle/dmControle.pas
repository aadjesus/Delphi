{$Include \Globus\sistemas\Defines.txt}

unit dmControle;

(*

Data       Programador         Descrição
---------- ------------------- ---------------------------------------------------------------------------------------
07/11/2006 Verônica            Tirado do select "/*+ RULE */" das querys QryLerIni e QryPesqIni a pedido do Aprigio.
 
17/05/2006 Silvio              Inclusão do módulo ROD.

11/04/2006 Silvio              Controle de licenças.

30/12/2005 Silvio              Grava no log as qtds de usuários e de módulos ativos.
  
03/10/2005 Verônica            Adicionado validação de impressora.

10/07/2005 Verônica            SIM 11276 - Ajuste para não rodar os upts do cargas para a empresa Caxiense. Alterado
                               para ler os dados da empresa das constantes. 

24/02/2005 Silvio              Ajustes no controle de licenças presas.
 
16/02/2005 Silvio              Inicializa a variável vcMoedaSimbolo com o símbolo monetário do Oracle (NLS_CURRENCY).

23/01/2005 Silvio              Não roda UPTs anteriores a 01/07/2004.

20/01/2005 Silvio              Inclusão da rotina "VerificaCriaTabelaDeLicencas".

11/01/2005 Silvio              Deleta os arquivos \Globus\About e About2.rtf na carga do módulo.

19/10/2004 Silvio              Inclusão da SUT nos casos que não devem ser rodados os UPTs de CGS (DFX).

24/09/2004 Silvio              Falta o nome deste sistema em "ValidaNomeDoEXE"
                               qdo se utiliza uma versão LIGHT de projeto.

26/08/2004 Silvio              Grava um log quando acontece a mensagem:
                               O sistema já está sendo executado por esta estação. (Tente novamente caso tenha ocorrido
                               fechamento anormal).

01/03/2004 Silvio              Passa a gravar nos log de atualização o conteúdo do DataHora.txt.

23/01/2004 Silvio              Passa a gravar no log de abertura do módulo o conteúdo do DataHora.txt.

25/07/2003 Luis                Inclusão do Módulo PVT

11/07/2002 Silvio              Criada a variável vFechaSplash para controlar o
                               fechamento no próprio form do splash, pois esta-
                               va ficando aberto.

                               Deixa de recriar os objetos inválidos na atuali-
                               zação da base: Para ficar sem o Grant de DBA.

06/06/2001 Jefferson           Verifica se a Data e Hora colocadas nos arquivos
                               Sql´s está Ok. Exibe o log de erro no final da
                               atualização. Só permite que o Controle e o Segu-
                               rança atualizem o banco.
28/05/2001 Jefferson           Bloqueias as outras estações se o sistema estiver
                               sendo atualizado.
03/05/2001 Jefferson           Permanece os comentários na criação da Stored
31/01/2001 Silvio              Se existir o globus.ini no diretório corrente,
                               carrega-o. Também é possível acionar a tela de
                               login, com o parâmetro /login na linha de coman-
                               do.
29/01/2001 Silvio              O controle de acesso passa a considerar o usuá-
                               rio de login no Windows (Metaframe).
19/10/2000 Silvio              Controle de acesso por estação.
08/09/2000 Jefferson           Só processa os scripts que contenham uma linha
                               comentando a Data e Hora de criação/alteração.
29/08/2000 Jefferson           Exibe o usuário que está conectado na tela de
                               criação de scripts.
                               Grava um log de quem fez a atualização.
09/08/2000 Jefferson           Na criação dos scripts compara também o tamanho.
18/07/2000 Jefferson           Implementado a rotina de criação das tabelas/
                               scripts. Chamada (+ ou - Linha 513)
                               Obs: Esta rotina só é processada caso exista o
                               arquivo: Glb_Atu_Bco_Dados.txt no diretorio Globus

*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Buttons, Gauges,
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS OFF}
  {$ENDIF}
  FileCtrl,
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS ON}
  {$ENDIF}
  Mask,CheckLst, DBGrids, printers,
  DBCtrls, ToolEdit, NumEdit, TimeEdit, extctrls, DBNumEdt, RxQuery, comctrls,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt},
  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt}
  ;

type
  Tdm = class(TDataModule)
    DbBGM: TDatabase;
    dsCtr_CadEmp: TDataSource;
    dsCtr_EmpAutorizadas: TDataSource;
    dsCtr_Filial: TDataSource;
    dsCtr_CadLocal: TDataSource;
    dsCtr_CadastroDeUsuarios: TDataSource;
    dsCtr_AutorizacaoUsuarios: TDataSource;
    dsCtr_MenusDoSistema: TDataSource;
    dsCtr_MenusAoUsuario: TDataSource;
    dsCtr_CadastroSistemas: TDataSource;
    dsCtr_CadIdioma: TDataSource;
    dsCtr_IdiomaRegional: TDataSource;
    dsCtr_IdiomaNacional: TDataSource;
    dsCtr_Concedente: TDataSource;
    dsCtr_AutorizacaoSistemas: TDataSource;
    DsBgm_CadUF: TDataSource;
    dsCtr_Parametros: TDataSource;
    dsCtr_Erros: TDataSource;
    dsCtr_Garagem: TDataSource;
    dsCtr_Filial_Gar: TDataSource;
    stppr_Aba_RecalVelocimetro: TStoredProc;
    qrCtr_Erros: TQuery;
    qrCtr_ParamUsuarioSistema: TQuery;
    dsCtr_ParamUsuarioSistema: TDataSource;
    qrCtr_Concedente: TQuery;
    qrCtr_EmpAutorizadas: TQuery;
    qrCtr_CadastroSistemas: TQuery;
    qrCtr_AutorizacaoSistemas: TQuery;
    qrCtr_CadIdioma: TQuery;
    qrCtr_IdiomaNacional: TQuery;
    qrCtr_IdiomaRegional: TQuery;
    stpPrTraduzInterface: TStoredProc;
    qrBgm_CadUf: TQuery;
    qrCtr_CadEmp: TQuery;
    qrCtr_Filial: TQuery;
    qrCtr_Garagem: TQuery;
    qrCtr_Filial_Gar: TQuery;
    qrCtr_CadLocal: TQuery;
    qrCtr_Parametros: TQuery;
    qrCtr_CadastroDeUsuarios: TQuery;
    qrCtr_MenusDoSistema: TQuery;
    qrCtr_MenusAoUsuario: TQuery;
    qrCtr_AutorizacaoUsuarios: TQuery;
    qrBgm_ParVelocCatra: TQuery;
    DsBGM_Fufixo_Funcao: TDataSource;
    QrBGM_Fufixo_Funcao: TQuery;
    DsBGM_FuncaoFixa: TDataSource;
    QrBGM_FuncaoFixa: TQuery;
    QrBGM_FuncaoFixaTPFUNCFIXA: TStringField;
    QrBGM_FuncaoFixaSISTEMA: TStringField;
    QrBGM_Fufixo_FuncaoTPFUNCFIXA: TStringField;
    QrBGM_Fufixo_FuncaoSISTEMA: TStringField;
    QrBGM_Fufixo_FuncaoCODFUNCAO: TFloatField;
    qrCtr_AutorizacaoSistemasCODINTEMPAUT: TFloatField;
    qrCtr_AutorizacaoSistemasSISTEMA: TStringField;
    qrCtr_AutorizacaoSistemasDATALIMITEDEUSO: TDateTimeField;
    qrCtr_AutorizacaoSistemasCHECKSUMAUTSISTEMAS: TStringField;
    qrCtr_GaragemCODIGOGA: TFloatField;
    qrCtr_GaragemCODIGOUF: TStringField;
    qrCtr_GaragemNOMEGA: TStringField;
    qrCtr_GaragemENDERECOGA: TStringField;
    qrCtr_GaragemNUMEROENDGA: TStringField;
    qrCtr_GaragemCOMPLENDGA: TStringField;
    qrCtr_GaragemCEPGA: TStringField;
    qrCtr_GaragemCIDADEGA: TStringField;
    qrCtr_GaragemBAIRROGA: TStringField;
    qrCtr_AutorizacaoUsuariosCODINTEMPAUT: TFloatField;
    qrCtr_AutorizacaoUsuariosCODIGOGRPUSU: TFloatField;
    qrCtr_AutorizacaoUsuariosCHECKSUMAUTUSUARIOS: TStringField;
    qrCtr_ErrosERR_NUMERO: TFloatField;
    qrCtr_ErrosCONSTRAINTERRO: TStringField;
    qrCtr_ErrosERR_DESCRICAO: TStringField;
    qrCtr_ErrosERR_ROTINA: TStringField;
    qrCtr_ErrosERR_ULTIMADATA: TDateTimeField;
    qrCtr_ErrosERR_ULTIMAHORA: TDateTimeField;
    qrCtr_ErrosERR_ULTIMOUSUARIO: TStringField;
    qrCtr_ErrosERR_QTDEDIAS: TFloatField;
    qrCtr_Filial_GarCODIGOEMPRESA: TFloatField;
    qrCtr_Filial_GarCODIGOFL: TFloatField;
    qrCtr_Filial_GarCODIGOGA: TFloatField;
    qrCtr_CadIdiomaNOMELINGUA: TStringField;
    qrCtr_CadIdiomaUSARCOMOLINGUAREGIONAL: TStringField;
    qrCtr_ParamUsuarioSistemaCODIGOGRPUSU: TFloatField;
    qrCtr_ParamUsuarioSistemaSISTEMA: TStringField;
    qrCtr_ParamUsuarioSistemaDTIPARUSUASIS: TDateTimeField;
    qrCtr_ParamUsuarioSistemaDTFPARUSUASIS: TDateTimeField;
    qrCtr_ParamUsuarioSistemaCHECKSUMPARUSUSIS: TStringField;
    qrCtr_ParametrosCODIGOCADAUTOMATICO: TStringField;
    qrCtr_ParametrosUSARPORTUGUESPADRAO: TStringField;
    qrCtr_IdiomaRegionalNOMELINGUA: TStringField;
    qrCtr_IdiomaRegionalSEQUENCIAIDNAC: TFloatField;
    qrCtr_IdiomaRegionalPALAVRA_FRASEREG: TStringField;
    qrCtr_GrupoUsuarios: TQuery;
    dsCtr_GrupoUsuarios: TDataSource;
    qrCtr_GrupoUsuariosCODIGOGRPUSU: TFloatField;
    qrCtr_GrupoUsuariosDESCRICAOGRPUSU: TStringField;
    qrCtr_GrupoUsuariosCODDEPTO: TFloatField;
    qrCtr_MenusAoGrupo: TQuery;
    dsCtr_MenusAoGrupo: TDataSource;
    qrAuxiliar: TQuery;
    qrAuxiliar1: TQuery;
    DsCtr_VigenciaMovto: TDataSource;
    QrCtr_VigenciaMovto: TQuery;
    QrCtr_VigenciaMovtoCODIGOEMPRESA: TFloatField;
    QrCtr_VigenciaMovtoCODIGOFL: TFloatField;
    QrCtr_VigenciaMovtoSISTEMA: TStringField;
    QrCtr_VigenciaMovtoMESANOVIGENCIA: TDateTimeField;
    qrCtr_MenusAoUsuarioUSUARIO: TStringField;
    qrCtr_MenusAoUsuarioSISTEMA: TStringField;
    qrCtr_MenusAoUsuarioINDICEMENU: TStringField;
    qrCtr_MenusAoUsuarioNOME: TStringField;
    qrCtr_MenusAoUsuarioCAPTION: TStringField;
    qrCtr_MenusAoUsuarioCHECKSUMMENU: TStringField;
    qrCtr_MenusAoUsuarioTEMDIREITOEXCLUSAOMENU: TStringField;
    qrCtr_MenusAoUsuarioTEMDIREITOINCLUSAOMENU: TStringField;
    qrCtr_MenusAoUsuarioTEMDIREITOALTERACAOMENU: TStringField;
    Qry_FeriadoEmpresaFilial: TQuery;
    qryInsereINI: TQuery;
    qryAlteraINI: TQuery;
    qryDeletaINI: TQuery;
    qryPesqINI: TQuery;
    qryLerIni: TQuery;
    qrCtr_GrupoUsuariosATIVO: TStringField;
    procedure qrCtr_AutorizacaoSistemasBeforePost(DataSet: TDataSet);
    procedure qrCtr_CadIdiomaAfterInsert(DataSet: TDataSet);
    procedure qrCtr_CadEmpAfterInsert(DataSet: TDataSet);
    procedure qrCtr_ParametrosAfterInsert(DataSet: TDataSet);
    function  AbreDataBase:Boolean;
    procedure dmCreate(Sender: TObject);
    procedure qrCtr_EmpAutorizadasAfterClose(DataSet: TDataSet);
    procedure qrCtr_AutorizacaoSistemasAfterClose(DataSet: TDataSet);
    procedure qrCtr_MenusDoSistemaAfterClose(DataSet: TDataSet);
    procedure qrCtr_IdiomaRegionalAfterClose(DataSet: TDataSet);
    procedure qrCtr_ErrosAfterClose(DataSet: TDataSet);
    procedure qrBgm_ParVelocCatraAfterClose(DataSet: TDataSet);
    procedure qrCtr_GrupoUsuariosAfterClose(DataSet: TDataSet);
    procedure qrCtr_AutorizacaoUsuariosAfterClose(DataSet: TDataSet);
    procedure qrCtr_CadIdiomaAfterClose(DataSet: TDataSet);
    procedure qrCtr_CadastroSistemasAfterClose(DataSet: TDataSet);
    procedure qrCtr_MenusAoGrupoAfterClose(DataSet: TDataSet);
    procedure qrCtr_CadastroDeUsuariosAfterClose(DataSet: TDataSet);
    procedure qrCtr_MenusAoUsuarioAfterClose(DataSet: TDataSet);
    procedure qrCtr_ParamUsuarioSistemaAfterClose(DataSet: TDataSet);
    procedure qrCtr_FilialAfterClose(DataSet: TDataSet);
    procedure qrCtr_CadEmpAfterClose(DataSet: TDataSet);
    procedure qrCtr_ConcedenteAfterClose(DataSet: TDataSet);
    procedure FazLogin;
    procedure pConfirma(Sender:TObject);
    procedure QrCtr_VigenciaMovtoAfterClose(DataSet: TDataSet);
    procedure qrCtr_IdiomaNacionalAfterClose(DataSet: TDataSet);
    function  AtualizaBaseDeDados(pDrive: String):Boolean;
    procedure qrCtr_CadLocalAfterClose(DataSet: TDataSet);
    procedure MudaCor(Sender: TObject);
    Procedure LimpaAcessoPorEstacao;
    Procedure ValidaNomeDoExe;
    Function  DeletaArquivo(pArquivo : String) : String; // Retorno vazio = ok. Preenchido = msg de erro.
    Procedure VerificaCriaTabelaDeLicencas;
    procedure GravaLogDasExcecoes(Sender: TObject; E: Exception) ;
    (*
    Trata da criação e ajustes na tabela de controle de licenças cujo nome está definido em .cTabelaDeLicencas
    *)
  private
    CompoAnt1  : TEdit;
    CompoAnt2  : TDBEdit;
    CompoAnt3  : TMaskEdit;
    CompoAnt4  : TDateEdit;
    CompoAnt5  : TTimeEdit;
    CompoAnt6  : TNumEdit;
    CompoAnt7  : TDbMemo;
    CompoAnt8  : TDBCheckBox;
    CompoAnt9  : TDBRadioGroup;
    CompoAnt10 : TRadioButton;
    CompoAnt11 : TCheckBox;
    CompoAnt12 : TDBNumEdit;
    CompoAnt13 : tComboBox;
    CompoAnt14 : TMemo;
    CompoAnt15 : TCheckListBox;
//    CompoAnt16 : TDBGrid;

    cFontAnt,
    cColorAnt  : TColor;
    procedure AtualizaProgress(pProgressBar : TGauge; pStatus : TLabel;pPos,pTotal: Integer; pString: String);
    function AtualizarBaseDeDados: Boolean;
    Procedure VerificaCriaSistemas;
//    Function PesquisaArquivoHelp : String;
    Function LicencaValida : Boolean;
    function criptografouSenhaEmail: string;
    (*
    Analisa as tabelas de controle de licença para saber se o módulo pode ser utilizado.
    Se o módulo for tratado de forma individual, verifica quantos dele estão abertos,
    senão considera a permissão a partir das licenças globais.
    *)
  public
    { Public declarations }
    vEncerraApl, vEnviaEMailLog,vAtualizouBase: Boolean;

    vTemDireitoExclusao, vTemDireitoAlteracao, vTemDireitoInclusao : Boolean;

    vCodParaFilialESF, vCodParaFilialCRC,
    vCodParaFilialCTB, vCodParaFilialCPG : Integer;
    vBancoDeDados,vcArquivoLog, vcArquivoLoge, vcArquivoAcessoMenu : String;

    vPanelAux : TPanel;
//    { Quando o usuário MANAGER tiver senha = "1", esta variável será TRUE }
//    vUsuarioManagerComSenhaUm : Boolean;

  end;

Const
  cQtdDeModulos = 38;
  cSiglasDosSistemas : Array [1 .. cQtdDeModulos] Of String = ( 'ABA',
                                                   'ACD',
                                                   'ARR',
                                                   'ATF',
                                                   'BCO',
                                                   'CPN',
                                                   'CPR',
                                                   'CTB',
                                                   'CPG',
                                                   'CRC',
                                                   'CTR',
                                                   'DVS',
                                                   'ESC',
                                                   'ESF',
                                                   'EST',
                                                   'FLP',
                                                   'FRQ',
                                                   'FRT',
                                                   'MAN',
                                                   'MOT',
                                                   'PAS',
                                                   'PNE',
                                                   'SEG',
                                                   'SRH',
                                                   'TRF',
                                                   'TUR',
                                                   'PLT',
                                                   'TER',
                                                   'CGS',
                                                   'FRE',
                                                   'PVT',
                                                   'COT',
                                                   'GRP',
                                                   'TRR',
                                                   'ROD',
                                                   'CTE',
                                                   'CRA',
                                                   'RET');
  cNomesDosSistemas  : Array [1 .. cQtdDeModulos] Of String = ('ABASTECIMENTO',
                                                  'ACIDENTES',
                                                  'ARRECADACAO',
                                                  'ATIVO',
                                                  'BANCOS',
                                                  'COMPONENTES',
                                                  'COMPRAS',
                                                  'CONTABILIDADE',
                                                  'CONTAS A PAGAR',
                                                  'CONTAS A RECEBER',
                                                  'CONTROLE',
                                                  'DOCUMENTACAO DE VEICULOS E SEGUROS',
                                                  'ESCALA',
                                                  'ESCRITURACAO FISCAL',
                                                  'ESTOQUE',
                                                  'FOLHA DE PAGAMENTO',
                                                  'FREQUENCIA',
                                                  'FROTA',
                                                  'MANUTENCAO',
                                                  'MOTORES',
                                                  'PASSES',
                                                  'PNEUS',
                                                  'SEGURANCA',
                                                  'RECURSOS HUMANOS',
                                                  'TRAFEGO',
                                                  'TURISMO',
                                                  'PLANTAO',
                                                  'TERMINAL',
                                                  'CARGAS',
                                                  'FRETAMENTO',
                                                  'PASSES E VALES-TRANSPORTE',
                                                  'E-COMPRAS',
                                                  'GLOBUS REPORT',
                                                  'TRANSPORTADOR-REVENDEDOR-RETALHISTA',
                                                  'ESCALA RODOVIARIA',
                                                  'CONTROLE DE TERCEIROS',
                                                  'CONTROLE DE CRACHAS',
                                                  'RETAGUARDA');
  cNomesDosExecutaveis : Array [1 .. cQtdDeModulos] Of String = ('ABASTECIMENTO',
                                                    'ACIDENTES',
                                                    'ARRECADACAO',
                                                    'ATIVO',
                                                    'BANCOS',
                                                    'COMPONENTE',
                                                    'COMPRAS',
                                                    'CONTABILIDADE',
                                                    'CPAGAR',
                                                    'CRECEBER',
                                                    'CONTROLE',
                                                    'DVS',
                                                    'ESCALA',
                                                    'ESCRITURACAO',
                                                    'ESTOQUE',
                                                    'FOLHA',
                                                    'FREQUENCIA',
                                                    'FROTA',
                                                    'MANUTENCAO',
                                                    'MOTOR',
                                                    'PASSES',
                                                    'PNEUS',
                                                    'SEGURANCA',
                                                    'RECURSOSHUMANOS',
                                                    'TRAFEGO',
                                                    'TURISMO',
                                                    'PLANTAO',
                                                    'TERMINAL',
                                                    'CARGAS',
                                                    'FRETAMENTO',
                                                    'PVT',
                                                    'ECOMPRAS',
                                                    'GLOBUSREPORT',
                                                    'TRR',
                                                    'ESCALARODOVIARIA',
                                                    'TERCEIROS',
                                                    'CRACHA',
                                                    'RETAGUARDA');
Var
  dm: Tdm;
  vForm: TForm;
  vSecao, vDriveDir, vDriveTemp: String;
  vCorEdicao, vCorOpcao, vCorFonteEdicao, vCorFonteopcao: TColor;
  vImpressoraPadrao: Integer; // Utilizada pela funcao DefineComoImpressoraPadrao() que está na Global.
  vContadorTempoMenuPrincipal: Integer;
  vEServerName: TEdit;
  vEUserName: TEdit;
  vEPassword: TEdit;
  vEServer: TEdit;
  vEDrive: TDriveComboBox;
  vLServerName: TLabel;
  vLUserName: TLabel;
  vLPassword: TLabel;
  vLDrive: TLabel;
  vLServer: TLabel;
  vBotao: TBitBtn;
  vFechaSplash: Boolean;


implementation

Uses

  Bgm_String,
  Bgm_Utils,
  Bgm_Dados,
  Bgm_Tela,
  MenuPrincipal, SetupRD;


{$R *.DFM}

{ No momento da Criacao do DmControle faz a conexão com o banco }

procedure Tdm.dmCreate(Sender: TObject);
begin
  { Limpa os parametros do componente DataBase }
  dbBgm.Connected := False;
  dbBgm.DatabaseName := cDatabaseName;
  vContadorTempoMenuPrincipal := 0;

  Application.OnException := GravaLogDasExcecoes ;

  vEnviaEMailLog := False;
  vAtualizouBase := False;  
end;

//
// Rotinas que serão chamadas no momento de Inserir e Gravar dados nas Tabelas
//

{Tabela de Autorizacao de sistemas ********************************************}

procedure Tdm.qrCtr_AutorizacaoSistemasBeforePost(DataSet: TDataSet);
begin
  With qrCtr_AutorizacaoSistemas Do
    begin
      FieldByName('CheckSumAutSistemas').AsString :=
        Encripta( FieldByName('Sistema'        ).asString +
                  FieldByName('DataLimiteDeUso').asString, 10 );
      If FieldByName('DataLimiteDeUso').isNull Then
        GeraExcecao( 'A data limite é um campo obrigatório' );
    end;
end;

{ Tabela de Cadastro de Idiomas ********************************************** }

procedure Tdm.qrCtr_CadIdiomaAfterInsert(DataSet: TDataSet);
begin
  qrCtr_CadIdioma.FieldByName('UsarComoLinguaRegional').asString := 'N';
end;

{ Após inserir um registro no cadastro de Empresas }

procedure Tdm.qrCtr_CadEmpAfterInsert(DataSet: TDataSet);
begin
  dm.qrCtr_CadEmp.FieldByName('PossuiFilialEmpresa').AsString := 'N';
end;

{ Após inserir um registro nos Parâmetros }

procedure Tdm.qrCtr_ParametrosAfterInsert(DataSet: TDataSet);
begin
  qrCtr_Parametros.FieldByName('CODIGOCADAUTOMATICO').asString := 'S';
  qrCtr_Parametros.FieldByName('USARPORTUGUESPADRAO').asString := 'N';
end;

procedure Tdm.qrCtr_CadastroDeUsuariosAfterClose(DataSet: TDataSet);
begin
  qrCtr_CadastroDeUsuarios.Sql.Clear;
  qrCtr_CadastroDeUsuarios.Sql.Add('SELECT * FROM CTR_CADASTRODEUSUARIOS WHERE USUARIO = :PUSUARIO');
end;

procedure Tdm.qrCtr_ConcedenteAfterClose(DataSet: TDataSet);
begin
  With qrCtr_Concedente Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_CONCEDENTE');
  end;
end;

procedure Tdm.qrCtr_EmpAutorizadasAfterClose(DataSet: TDataSet);
begin
  With qrCtr_EmpAutorizadas Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_EMPAUTORIZADAS WHERE RSOCIALEMPRESA = :PRSOCIALEMPRESA AND INSCRICAOEMPRESA = :PINSCRICAOEMPRESA');
  end;
end;

procedure Tdm.qrCtr_AutorizacaoSistemasAfterClose(DataSet: TDataSet);
begin
  With qrCtr_AutorizacaoSistemas Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_AUTORIZACAOSISTEMAS WHERE CODINTEMPAUT = :PCODINTEMPAUT AND SISTEMA  BETWEEN :PSISTEMAINI AND :PSISTEMAFIN');
  end;
end;

procedure Tdm.qrCtr_MenusDoSistemaAfterClose(DataSet: TDataSet);
begin
  With qrCtr_MenusDoSistema Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_MENUSDOSISTEMA WHERE SISTEMA BETWEEN :PSISTEMAINI AND :PSISTEMAFIN AND INDICEMENU BETWEEN :PINDICEMENUINI AND :PINDICEMENUFIN AND NOME BETWEEN :PNOMEINI AND :PNOMEFIN');
  end;
end;

procedure Tdm.qrCtr_IdiomaRegionalAfterClose(DataSet: TDataSet);
begin
  With qrCtr_IdiomaRegional Do
    begin
      Sql.Clear;
      Sql.Add('SELECT * FROM CTR_IDIOMAREGIONAL WHERE NOMELINGUA=:PNOMELINGUA AND SEQUENCIAIDNAC=:PSEQUENCIAIDNAC');
    end;
end;

procedure Tdm.qrCtr_ErrosAfterClose(DataSet: TDataSet);
begin
  With qrCtr_Erros Do
    begin
      Sql.Clear;
      Sql.Add('SELECT * FROM CTR_ERROS WHERE CONSTRAINTERRO=:PCONSTRAINTERRO');
    end;
end;

procedure Tdm.qrBgm_ParVelocCatraAfterClose(DataSet: TDataSet);
begin
  With qrBgm_ParVelocCatra Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM BGM_PARVELOCCATRA WHERE HORAPARAM BETWEEN :P_HORAPARAMINI AND :P_HORAPARAMFIN ORDER BY SEQUENCIAPARAM');
  end;
end;

procedure Tdm.qrCtr_GrupoUsuariosAfterClose(DataSet: TDataSet);
begin
  With qrCtr_GrupoUsuarios Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_GRUPOUSUARIOS WHERE CODIGOGRPUSU=:PCODIGOGRPUSU');
  end;
end;

procedure Tdm.qrCtr_AutorizacaoUsuariosAfterClose(DataSet: TDataSet);
begin
  With qrCtr_AutorizacaoUsuarios do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_AUTORIZACAOUSUARIOS WHERE CODINTEMPAUT = :PCODINTEMPAUT AND CODIGOGRPUSU = :PCODIGOGRPUSU');
  end;
end;

procedure Tdm.qrCtr_CadIdiomaAfterClose(DataSet: TDataSet);
begin
  With qrCtr_CadIdioma Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_CADIDIOMA WHERE NOMELINGUA BETWEEN :PNOMELINGUAINI AND :PNOMELINGUAFIN ORDER BY NOMELINGUA');
  end;
end;

procedure Tdm.qrCtr_CadastroSistemasAfterClose(DataSet: TDataSet);
begin
  With qrCtr_CadastroSistemas Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_CADASTROSISTEMAS WHERE SISTEMA BETWEEN :PSISTEMAINI AND :PSISTEMAFIN');
  end;
end;

procedure Tdm.qrCtr_MenusAoGrupoAfterClose(DataSet: TDataSet);
begin
  With qrCtr_MenusAoGrupo Do
   begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_MENUSAOGRUPO WHERE CODIGOGRPUSU = :PCODIGOGRPUSU AND SISTEMA = :PSISTEMA AND INDICEMENU = :PINDICEMENU AND NOME = :PNOME');
  end;
end;

procedure Tdm.qrCtr_MenusAoUsuarioAfterClose(DataSet: TDataSet);
begin
  With qrCtr_MenusAoUsuario Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_MENUSAOUSUARIO WHERE USUARIO = :PUSUARIO AND SISTEMA = :PSISTEMA AND INDICEMENU = :PINDICEMENU AND NOME = :PNOME');
  end;
end;

procedure Tdm.qrCtr_ParamUsuarioSistemaAfterClose(DataSet: TDataSet);
begin
  With qrCtr_ParamUsuarioSistema Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_PARAMUSUARIOSISTEMA WHERE SISTEMA BETWEEN :PSISTEMAINI AND :PSISTEMAFIN AND CODIGOGRPUSU = :PCODIGOGRPUSU');
  end;
end;

procedure Tdm.qrCtr_FilialAfterClose(DataSet: TDataSet);
begin
  With qrCtr_Filial Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_FILIAL WHERE CODIGOEMPRESA = :PCODIGOEMPRESA AND CODIGOFL = :PCODIGOFL');
  end;
end;

procedure Tdm.qrCtr_CadEmpAfterClose(DataSet: TDataSet);
begin
  With qrCtr_CadEmp Do
  begin
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_CADEMP WHERE CODIGOEMPRESA = :PCODIGOEMPRESA');
  end;
end;

////////////////////////////////////////////////////////////////////////////////

{ Rotina para abrir DataBase e Setar as variaveis no MenuPrincipal }

function Tdm.AbreDataBase:Boolean;
Var
  I        : Byte;
  vTexto   : TextFile;
  vStr     : String;
(*  vRetorno : Byte;
  vAcesTot : Boolean;
  vQtdAces : Integer;
  vOpAcess : Boolean;*)
  vDiretorioTemporario : String;
  vSystemTime : TSystemTime;
  vSystemTimeOld : String;
//  vPanelAux : TPanel;
  vFileName : String;
  vFileHandle : Integer;
  vFileAttr : Integer;
  vMsgBdeErrors : String;
  vMsgBdeCounter : Integer;
begin

  { Elimina os antigos arquivos com textos da tela "Sobre o Sistema" - Silvio 11/01/2005 }
  DeletaArquivo('\Globus\About.rtf');
  DeletaArquivo('\Globus\About2.rtf');

  { Carrega nas duas imagens do menuprincipal as imagens que estão no SetupRD, que é comum a todos os módulos - Silvio }
  If (vcSistema <> 'GRP') Then
  begin
    if Screen.Width < 1024 then
    begin
      frmMenuPrincipal.Image1.Picture := frmSetupRD.imgMenuPrincipal1.Picture;
      frmMenuPrincipal.Image2.Picture := frmSetupRD.imgMenuPrincipal2.Picture;
    end
    else if Screen.Width = 1024 then
    begin
      frmMenuPrincipal.Image1.Picture := frmSetupRD.imgMenuPrincipal3.Picture;
      frmMenuPrincipal.Image2.Picture := frmSetupRD.imgMenuPrincipal4.Picture;
    end
    else
    begin
      frmMenuPrincipal.Image1.Picture := frmSetupRD.imgMenuPrincipal5.Picture;
      frmMenuPrincipal.Image2.Picture := frmSetupRD.imgMenuPrincipal6.Picture;
    end;
  end;

  { Se gerar o except é porque não tem nenhuma impressora definida e isto gera erro em RDPrint.
    Em Crystal não dá erro, mas o botão imprimir vem desabilitado. }
{ Rotina incluída no SetupRd.pas.
  A consistência abaixo gerava problemas quando faz impressão em RdPrint
  utilizando o Citrix.  As impressoras da máquina do usuário não aparecem. }
//  Try
//    Printer.PrinterIndex;
//  Except
//    ShowMessage('Atenção: Nenhuma impressora disponível. Isto pode provocar erros em processos que venham a gerar impressão. Favor verificar.');
//  end;

  { Quando a aplicação é remota, inibe a imagem de fundo e deixa um painel padrão }
//  If (vcSistema <> 'GRP') Then
//  begin
//    If RodandoRemoto Then // Global
//    Begin
      frmMenuPrincipal.Image1.Visible := Not RodandoRemoto ;
      frmMenuPrincipal.Image2.Visible := Not RodandoRemoto ;
      vPanelAux := TPanel.Create(Self);
      With vPanelAux Do
      Begin
        Align := alClient;
        BevelInner := bvLowered;
        Caption := 'GLOBUS ASP';
        //Color := clBtnFace;
        Font.Size := 60;
        Font.Name := 'Arial';
        Font.Style := [fsBold,fsItalic];
        Font.Color := clAppWorkSpace;
        Parent := frmMenuPrincipal;
      End;
      If Not RodandoRemoto Then
        frmMenuPrincipal.Image1.Parent := vPanelAux ;

//    End;
//  end;
  ValidaNomeDoEXE;
  { Atribui diretorios a sessão dos arquivos temporarios }
  { Proibido tirar desta posição. }
  { Apenas para a freqüência, pois foi onde houve a necessidade. Isto fará com que seja
    criado o arquivo PDOXUSRS.NET }
  { Manutenção na Kwikasair também cria este arquivo no fechamento de OS }
  If (vcSistema = 'FRQ') or
     (vcSistema = 'FLP') or
     (vcSistema = 'SRH') or
     (vcSistema = 'MAN') or
     (vcSistema = 'ARR') or
     (vcSistema = 'TRF') or
     (vcSistema = 'ESC') or
     (vcSistema = 'PVT') or
     (vcSistema = 'PLT') or
     (vcSistema = 'PNE') Then
  Begin
    { Colocada a criação de diretórios exclusivos, para permitir o uso de vários módulos na mesma estação e MetaFrame }
    vDiretorioTemporario := 'C:\Temp\';
    Try
      MkDir(vDiretorioTemporario);
    Except
    End;
    vDiretorioTemporario := vDiretorioTemporario + vcSistema + '\';
    Try
      MkDir(vDiretorioTemporario);
    Except
    End;
    vDiretorioTemporario := vDiretorioTemporario + WinLogin + '\';
    Try
      MkDir(vDiretorioTemporario);
    Except
    End;
    Session.NetFileDir := vDiretorioTemporario;
    Session.PrivateDir := vDiretorioTemporario;
  End;
  { Cria o componente de tabela de acesso }
  { Desabilita o timer do menu principal,
    isto porque na folha à o sistema de agenda que lê uma tabela mas o banco
    ainda não está conectado }
  frmMenuPrincipal.Timer1.Enabled := False;

//  { Esta variável ficará true se a senha do MANAGER for "1" - Ver em ControleParaSenhasBgm.pas }
//  vUsuarioManagerComSenhaUm := False;
//  vcUsuarioManagerComSenhaUm := False;

  { Evita que modificações no ambiente do Windows altere as configurações no sistema }
  Application.UpdateFormatSettings := False;

  { Define configuracao padrão para o sistema }
  ThousandSeparator         := '.';
  DecimalSeparator          := ',';
  DateSeparator             := '/';
  TwoDigitYearCenturyWindow := 70;

  vTemDireitoExclusao  := True;
  vTemDireitoAlteracao := True;
  vTemDireitoInclusao  := True;

  vcTemDireitoExclusao  := True;
  vcTemDireitoAlteracao := True;
  vcTemDireitoInclusao  := True;

  try
    ShortDateFormat := 'DD/MM/YYYY';
  except
    ShortDateFormat := 'DD/MM/YYYY';
  end;
  try
    LongDateFormat := 'DD/MM/AAAA';
  except
    LongDateFormat := 'DD/MM/YYYY';
  end;
  ShortTimeFormat := 'HH:MM';
  LongTimeFormat  := 'HH:MM:SS';

  { Define o valor de Retorno }
  Result    := True;
  I         := 1;
  vDriveDir := 'C:';
  vDriveTemp   := '';
  { Limpa os parametros do componente DataBase }
  dbBgm.Connected := False;
  dbBgm.Params.Clear;
  { Faz a leitura do Arquivo Globus.INI, que pode estar no diretório corrente ou em \Globus
    Se passar como parâmetro /LOGIN, chama a tela de login }
  If (( Not FileExists('\GLOBUS\GLOBUS.INI') ) And
      ( Not FileExists('GLOBUS.INI'        ) )) Or
      ( UpperCase(ParamStr(1)) = '/LOGIN' ) Then
  Begin
    vFechaSplash := True;
    FazLogin;
  End
  else
  begin
    { Abre o arquivo Globus.INI e seta os parametros }
    If FileExists('GLOBUS.INI') Then
    Begin
      AssignFile(vTexto,'GLOBUS.INI');
//        If Not RodandoRemoto Then
//          ShowMessage('Atenção: O arquivo GLOBUS.INI está sendo lido do diretório corrente.');
    End
    Else
      AssignFile(vTexto,'\GLOBUS\GLOBUS.INI');
    Reset(vTexto);
    { Faz o Loop }
    While Not Eof(vTexto) Do
    begin
      Readln(vTexto,vStr);
      If vStr <> '' Then
        Case I Of
          1 : begin
                dbBgm.AliasName              := DesCriptografa(vStr);
                frmMenuPrincipal.vServerName := DesCriptografa(vStr);
                vcServerName := DesCriptografa(vStr);
              end;
          2 : begin
                dbBgm.Params.Add('USER NAME='+DesCriptografa(vStr));
                frmMenuPrincipal.vUserName := DesCriptografa(vStr);
                vcUserName := DesCriptografa(vStr);
              end;
          3 : begin
                dbBgm.Params.Add('PASSWORD='+DesCriptografa(vStr));
                frmMenuPrincipal.vUserSenha := DesCriptografa(vStr);
                vcUserSenha := DesCriptografa(vStr);
              end;
          4 : vDriveDir  := Copy(DesCriptografa(vStr),1,1) + ':';
          5 : vDriveTemp := DesCriptografa(vStr);
        end;
      Inc(I);
    end;
    { Fecha o arquivo }
    CloseFile(vTexto);
  end; // If
  vDriveTemp := Trim(vDriveTemp);
  vcDriveDosRelatorios := vDriveDir;
  { Testa a variavel do servidor. Caso esteja vazia, assume o drive dos relatorios }
  If vDriveTemp = '' Then vDriveTemp := vDriveDir;
  { Adiciona a barra }
  If Copy(vDriveTemp, Length(vDriveTemp), 1) <> '\' Then vDriveTemp := vDriveTemp + '\';
//  { Caso tenha a barra no final do vServer, a retira }
//  If Copy(vServer,Length(vServer),1) = '\' Then vServer := Copy(vServer,1,Length(vServer)-1);
  { Faz a conexão ao banco de dados }
  Try
    dbBgm.Connected := True;
  Except
    On E:EDBEngineError Do
    Begin
      vFechaSplash := True;
      // Silvio - 08/10/2003
      vMsgBdeErrors := 'Não foi possível fazer a conexão com o banco de dados.' + Chr(13) + Chr(13) +
                       'Possíveis causas:' + Chr(13) +
                       '- Dados no arquivo GLOBUS.INI incorretos;' + Chr(13) +
                       '- Configuração do BDE incorreta;' + Chr(13) +
                       '- Configuração do cliente Oracle incorreta.' + Chr(13) + Chr(13) +
                       'Tentando: ALIAS = "' + vcServerName + '" USER = "' + vcUserName + '".' + Chr(13) + Chr(13) +
                       'Erro(s): ' + #13;
      For vMsgBdeCounter := 0 To E.ErrorCount - 1 Do
       vMsgBdeErrors := vMsgBdeErrors +
          '(' + IntToStr( E.Errors[ vMsgBdeCounter ].ErrorCode ) +
          ') ' + E.Errors[ vMsgBdeCounter ].Message + #10;
      Application.MessageBox( pChar( vMsgBdeErrors ), 'Erro ao conectar com o banco de dados', MB_ICONHAND + MB_OK );

      Result      := False;
      vEncerraApl := True;  // Deixada para compatibilidade
      vcEncerraApl := True;
      Exit;
    End;
  End; // Try

  { Daqui para frente está conectado }
  vcDatabase := self.DBBGM;

  { Verifica se está rodando em ORACLE ou INTERBASE/FIREBIRD }
  Try
    qrAuxiliar.Close;
    qrAuxiliar.Sql.Clear;
    qrAuxiliar.Sql.Add('SELECT SYSDATE FROM DUAL');
    qrAuxiliar.Open;
    qrAuxiliar.Close;
    vBancoDeDados := 'ORACLE';
    vcBancoDeDados := 'ORACLE';
  Except
    vBancoDeDados := 'INTERBASE';
    vcBancoDeDados := 'INTERBASE';
  End;

  { Obtém o símbolo monetário configurado no ORACLE - NLS_CURRENCY }
  With qrAuxiliar Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT TO_CHAR(0,''L'') SIMBOLO FROM DUAL');
    Open;
    vcMoedaSimbolo := Trim(FieldByName('SIMBOLO').AsString);
    { Se retornar vazio ou $ (padrão), assume o símbolo de REAIS }
    If IsEmpty Or (vcMoedaSimbolo = '') Or (vcMoedaSimbolo = '$') Then
      vcMoedaSimbolo := 'R$';
    Close;
    vcMoedaNomeSingular := 'Real';
    vcMoedaNomePlural := 'Reais';
  End;

  { Define o nome do concedente para os Relatorios e no titulo do formulário }
  With qrCtr_Concedente Do
  begin
    Open;
    First;
    frmMenuPrincipal.Caption := FieldByName('NomeConcedente').asString + ' - ' +
                                vcSistema + ' - ' + frmMenuPrincipal.Caption;
    frmMenuPrincipal.vConcedente := FieldByName('NomeConcedente').asString;
    frmMenuPrincipal.vCodigoCliente := FieldByName('CodigoCliente' ).AsInteger;

    vcCodigoCliente := frmMenuPrincipal.vCodigoCliente;
    vcConcedente    := frmMenuPrincipal.vConcedente;

//    dm.vUsuarioManagerComSenhaUm := Descriptografa(FieldByName('ChaveCliente').asString) = '1';
    vcUsuarioManagerComSenhaUm := Descriptografa(FieldByName('ChaveCliente').asString) = '1';
    Close;
  end;

  { Jogada para rodar uma determinada versão em apenas um dia - Gol - Silvio }
{  If DateToStr(Now()) <> '29/01/2004' Then
  Begin
    ShowMessage('Versão de uso exclusivo - Silvio.');
      Result      := False;
      vEncerraApl := True;
      vcEncerraApl := True;
      Exit;
  End; }

  VerificaCriaTabelaDeLicencas;

  { Limpa os acessos antigos (+ de 1 ou 2 dias ou nulos) }
  With qrAuxiliar Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add('Delete from ' + cTabelaDeLicencas);
    // If dm.vBancoDeDados = 'ORACLE' Then
    If vcBancoDeDados = 'ORACLE' Then
    Begin
      Sql.Add('Where ((SysDate - VALIDA_SESSAO) > ((1/24)/3)) Or '); // ((1/24)/3) = 1 dia / 24 horas / 3 = 20 minutos
      Sql.Add('       (DataHora Is Null) or                      ');
      // Se o campo valida_sessao não estiver gravado, quer dizer que tem algum módulo que
      // não foi compilado com as novas opções, então valida como antes
      If vcSistema = 'CTR' Then
        Sql.Add('    (VALIDA_SESSAO is null and (SysDate - DataHora > (1 / 24 * 4)))') //
        // Sql.Add('Where SysDate - DataHora > (1 / 24 * 4) Or DataHora Is Null') // 1 hora = 1/24 dias
        // Sql.Add('Where SysDate - DataHora > 1 Or DataHora Is Null') // 1 dia = 24 horas Silvio 24/6/4
      Else
        Sql.Add('    (VALIDA_SESSAO is null and (SysDate - DataHora > 2))'); //
        // Sql.Add('Where SysDate - DataHora > 2 Or DataHora Is Null'); // 2 dias = 48 horas
    End
    Else
    Begin
      MensagemDlg('Ajustar aqui. Silvio', mtInformacao, mbOk);
      Sql.Add('Where Cast(Current_TimeStamp As TimeStamp) - DataHora > 2 Or DataHora Is Null');
    End;
    Try
      ExecSql;
    Except
    End;
    Close;
  End;

  // Cria sequences
  RodaVerificaCriaSequence;

  { Processa a atualização dos scripts. Só processa se os sistemas forem:
    Ctr - Controle ou Seg - Segurança }
  If ( vcSistema = 'SEG' ) Or
     ( vcSistema = 'CTR' ) Then
  begin
    vFechaSplash := True;
    If Not AtualizaBaseDeDados(vDriveDir) Then
    begin
      dbBgm.Connected := False;
      Result          := False;
      vEncerraApl     := True;
      vcEncerraApl     := True;
      Exit;
    end;
  end;

  { Não permite abrir o módulo se estiver sendo processada uma atualização. Silvio - 09/08/04 }
  If ( vcSistema <> 'SEG' ) And
     ( vcSistema <> 'CTR' ) And
     ( AtualizandoBaseDeDados ) Then
  begin
    If (vcUsuarioManagerComSenhaUm And (MensagemDlg('Deseja continuar?',mtConfirmacao, mbSim+mbNao ) = mbNao)) Or
       (Not vcUsuarioManagerComSenhaUm) Then
    Begin
      dbBgm.Connected := False;
      Result          := False;
      vEncerraApl     := True;
      vcEncerraApl     := True;
      Exit;
    End ;  
  end;

  { Abre a query auxiliar, caso ocorra erro é sinal que não exitem tabelas
    criadas para o usuário.
    Não abre para os módulos SEG e CTR }
  If ( vcSistema <> 'SEG' ) And
     ( vcSistema <> 'CTR' ) Then
  begin
    { Testa se não há tabelas criadas para o usuário }
    try
      qrAuxiliar.Close;
      qrAuxiliar.Sql.Clear;
      qrAuxiliar.Sql.Add('SELECT');
      qrAuxiliar.Sql.Add('  CodIntConcedente, NomeConcedente, ChecksumConcedente, CodigoCliente');
      qrAuxiliar.Sql.Add('FROM');
      qrAuxiliar.Sql.Add('  CTR_CONCEDENTE');
      qrAuxiliar.Open;
      If qrAuxiliar.IsEmpty Then
      begin
        vFechaSplash := True;
        ShowMessage('Sistema não configurado corretamente. Por favor, entre em contato com a BgmRodotec.');
        dbBgm.Connected := False;
        Result          := False;
        vEncerraApl     := True;
        vcEncerraApl     := True;
        Exit;
      end;
      { Passa a validar em 09 caracteres após o concedente passar para "BgmRodotec". Com isso
        apenas o novo segurança poderá ser utilizado }
      If (Copy(qrAuxiliar.FieldByName('NomeConcedente').AsString, 1, 10) = 'BgmRodotec') And
         (qrAuxiliar.FieldByName('CheckSumConcedente').AsString <>
          Encripta( qrAuxiliar.FieldByName('NomeConcedente').asString +
                    qrAuxiliar.FieldByName('CodigoCliente').asString, 09 )) Then
      begin
        vFechaSplash := True;
        MensagemDlg('Tabela de concedente violada. Não será possível carregar o sistema.', mtErro, mbOk );
        dbBgm.Connected := False;
        Result          := False;
        vEncerraApl     := True;
        vcEncerraApl     := True;
        Exit;
      end;
    except
      begin
        vFechaSplash := True;
        ShowMessage('Nenhuma tabela criada para este usuário');
        dbBgm.Connected := False;
        Result          := False;
        vEncerraApl     := True;
        vcEncerraApl     := True;
        Exit;
      end;
    end;
    { Testa se a empresa tem permissão de utilizar o sistema }
    try
      qrAuxiliar.Close;
      qrAuxiliar.Sql.Clear;
      qrAuxiliar.Sql.Add('SELECT');
      qrAuxiliar.Sql.Add('  CODINTEMPAUT, SISTEMA, DATALIMITEDEUSO, CHECKSUMAUTSISTEMAS');
      qrAuxiliar.Sql.Add('FROM');
      qrAuxiliar.Sql.Add('  CTR_AUTORIZACAOSISTEMAS ');
      qrAuxiliar.Sql.Add('WHERE');
      qrAuxiliar.Sql.Add('  SISTEMA = :PSISTEMA');
      qrAuxiliar.ParamByName('PSistema').asString := vcSistema;
      qrAuxiliar.Open;
      If qrAuxiliar.IsEmpty Then
      begin
        If (vcSistema = 'GRP') Then
           frmMenuPrincipal.vVersaoTrial := true
        else
        begin
          If (vcUsuarioManagerComSenhaUm And (MensagemDlg('Módulo sem autorização para uso. Deseja continuar?',mtConfirmacao, mbSim+mbNao ) = mbNao)) Or
             (Not vcUsuarioManagerComSenhaUm) Then
          Begin
            vFechaSplash := True;
            If Not vcUsuarioManagerComSenhaUm Then
              MensagemDlg('Módulo sem autorização para uso. Entre em contato com ' + vcConcedente + '.', mtErro, mbOk );
            dbBgm.Connected := False;
            Result          := False;
            vEncerraApl     := True;
            vcEncerraApl     := True;
            Exit;
          End ;
        end;
      end
      else
      begin
        { Faz um Loop, pois pode haver mais de um registro }
        qrAuxiliar.First;
        While Not qrAuxiliar.Eof do
        begin
          If qrAuxiliar.FieldByName('CheckSumAutSistemas').AsString <>
             Encripta( qrAuxiliar.FieldByName('Sistema'        ).asString +
                       qrAuxiliar.FieldByName('DataLimiteDeUso').asString, 10 ) Then
          begin
            vFechaSplash := True;
            MensagemDlg('Tabela de sistemas autorizados violada. Não será possível carregar o sistema.', mtErro, mbOk );
            dbBgm.Connected := False;
            Result          := False;
            vEncerraApl     := True;
            vcEncerraApl     := True;
            Exit;
          end;
          qrAuxiliar.Next;
        end;
      end;
      qrAuxiliar.Close;
    except
      vFechaSplash := True;
      MensagemDlg('Não foi criada a tabela de autorização de sistemas.', mtErro, mbOk );
      dbBgm.Connected := False;
      Result          := False;
      vEncerraApl     := True;
      vcEncerraApl     := True;
      Exit;
    end;
  end;

  { Não controla licenças do Globus Report }
  If Not LicencaValida Then
  Begin
    vFechaSplash := True;
    dbBgm.Connected := False;
    Result := False;
    vEncerraApl := True;
    vcEncerraApl := True;
    Exit;
  End;

  If ModuloJaRodandoNestaEstacao Then
  Begin
    If vcUsuarioManagerComSenhaUm Then
      LimpaAcessoPorEstacao
    Else
    Begin
      GravaLog(vcSistema, 'GLOBUS', Now, 'O sistema ja esta sendo executado por esta estacao. (Tente novamente caso tenha ocorrido fechamento anormal). Em: ' + WinLogin + '/' + TrazNomeDoComputador + '.');
      MensagemDlg('O sistema já está sendo executado por esta estação. (Tente novamente caso tenha ocorrido fechamento anormal).', mtErro, mbOk );
      LimpaAcessoPorEstacao;
      vFechaSplash := True;
      dbBgm.Connected := False;
      Result := False;
      vEncerraApl := True;
      vcEncerraApl := True;
      Exit;
    End ;
  End;

(*
  With qrAuxiliar Do
  begin
    { Testa a permissão de acesso, exceto para SEGURANÇA e CONTROLE }
    If ( vcSistema <> 'SEG' ) And
       ( vcSistema <> 'CTR' ) And
       ( vcSistema <> 'GRP' ) Then
    Begin
      vRetorno := CAc_CriaTabelaDeAcessoEConsitemAcesso(vQtdAces, vAcesTot, vcServerName);
      Case vRetorno Of
        0 : Begin
              dm.DbBGM.StartTransaction;
              GravaLog(vcSistema, 'GLOBUS', Now, 'O sistema ja esta sendo executado por esta estacao. (Tente novamente caso tenha ocorrido fechamento anormal). Em: ' + WinLogin + '/' + TrazNomeDoComputador + '.');
              dm.DbBGM.Commit;
              MensagemDlg('O sistema já está sendo executado por esta estação. (Tente novamente caso tenha ocorrido fechamento anormal).', mtErro, mbOk );
            End;
        1 : Begin
              dm.DbBGM.StartTransaction;
              GravaLog(vcSistema, 'GLOBUS', Now, 'Excedeu conexoes.');
              dm.DbBGM.Commit;
              MensagemDlg('Excedeu o número máximo de conexões. (Tente novamente caso tenha ocorrido algum fechamento anormal).', mtErro, mbOk );
            End;
        2 : MensagemDlg('Problemas no acesso ao sistema.'                                   , mtInformacao, mbOk );
        3 : MensagemDlg('Não foi definido um servidor no Globus.INI.'                       , mtInformacao, mbOk );
        4 : MensagemDlg('Não foi possível criar a tabela Tbl_Acesso.Db no local: ' + vDriveTemp, mtInformacao, mbOk );
        5 : MensagemDlg('Não foi possível abrir a tabela Tbl_Acesso.Db.'                    , mtInformacao, mbOk );
      end;
      { Caso o retorno esteja entre 0 e 5, fecha o sistema }
      If (vRetorno <= 5) And (vRetorno <> 1)Then
      begin
        vFechaSplash := True;
        { Remove dados da estação. Se a aplicação for encerrada de forma irregular, os dados
          da estação ficarão no controle, então esta limpeza permitirá que o sistema entre
          normalmente na execução seguinte. }
        LimpaAcessoPorEstacao;
        { Fecha a tabela de acesso antes de encerrar o sistema }
        dbBgm.Connected := False;
        Result          := False;
        vEncerraApl     := True;
        vcEncerraApl     := True;
        Exit;
      End;
    End;
  End;*)

  { Seta as variaveis do menu principal }
  With frmMenuPrincipal Do
  begin
    vDirRptSeg := vDriveDir + '\Globus\Sistemas\Seguranca\Report\';
    vDirRptCtr := vDriveDir + '\Globus\Sistemas\Controle\Report\';
    vDirRptFrt := vDriveDir + '\Globus\Sistemas\Frota\Report\';
    vDirRptAba := vDriveDir + '\Globus\Sistemas\Abastecimento\Report\';
    vDirRptMan := vDriveDir + '\Globus\Sistemas\Manutencao\Report\';
    vDirRptCpn := vDriveDir + '\Globus\Sistemas\Componente\Report\';
    vDirRptPne := vDriveDir + '\Globus\Sistemas\Pneus\Report\';
    vDirRptMot := vDriveDir + '\Globus\Sistemas\Motor\Report\';
    vDirRptEst := vDriveDir + '\Globus\Sistemas\Estoque\Report\';
    vDirRptFlp := vDriveDir + '\Globus\Sistemas\Folha\Report\';
    vDirRptBco := vDriveDir + '\Globus\Sistemas\Bancos\Report\';
    vDirRptCpg := vDriveDir + '\Globus\Sistemas\ContasPagar\Report\';
    vDirRptCrc := vDriveDir + '\Globus\Sistemas\ContasReceber\Report\';
    vDirRptCtb := vDriveDir + '\Globus\Sistemas\Contabilidade\Report\';
    vDirRptAtf := vDriveDir + '\Globus\Sistemas\Ativo\Report\';
    vDirRptEsc := vDriveDir + '\Globus\Sistemas\Escala\Report\';
    vDirRptDvs := vDriveDir + '\Globus\Sistemas\DVS\Report\';
    vDirRptEsf := vDriveDir + '\Globus\Sistemas\Escrituracao\Report\';
    vDirRptAss := vDriveDir + '\Globus\Sistemas\Associacao\Report\';
    vDirRptCpr := vDriveDir + '\Globus\Sistemas\Compras\Report\';
    vDirRptArr := vDriveDir + '\Globus\Sistemas\Arrecadacao\Report\';
    vDirRptFre := vDriveDir + '\Globus\Sistemas\Fretamento\Report\';
    vDirRptTur := vDriveDir + '\Globus\Sistemas\Turismo\Report\';
    vDirRptPas := vDriveDir + '\Globus\Sistemas\Passes\Report\';
    vDirRptPrg := vDriveDir + '\Globus\Sistemas\ProgramacaoLinhas\Report\';
    vDirRptApt := vDriveDir + '\Globus\Sistemas\Frequencia\Report\';
    vDirRptTra := vDriveDir + '\Globus\Sistemas\Trafego\Report\';
    vDirRptSRH := vDriveDir + '\Globus\Sistemas\RecursosHumanos\Report\';
    vDirRptPLT := vDriveDir + '\Globus\Sistemas\Plantao\Report\';
    vDirRptAcd := vDriveDir + '\Globus\Sistemas\Acidentes\Report\';
    vDirRptTer := vDriveDir + '\Globus\Sistemas\Terminal\Report\';
    vPathRels  := vDriveDir;
  end;
  { Seta parâmetros para o Componente do Crystal Reports }
  { Conexão com o Banco }
  With frmMenuPrincipal.CrRpt Do
  begin
    Connect.ServerName := vcServerName;
    Connect.UserID     := vcUserName;
    Connect.Password   := vcUserSenha;
    DiscardSavedData   := True; // Para evitar que algum módulo fique com false; Silvio.
  end;
(*  { Define o nome do concedente para os Relatorios e no titulo do formulário }
  With qrCtr_Concedente Do
  begin
    Open;
    First;
    frmMenuPrincipal.MSOfficeCaption1.CompanyText.Caption := FieldByName('NomeConcedente').asString;
    frmMenuPrincipal.vConcedente                          := FieldByName('NomeConcedente').asString;
    frmMenuPrincipal.vCodigoCliente                       := FieldByName('CodigoCliente' ).AsInteger;
    vcCodigoCliente := frmMenuPrincipal.vCodigoCliente;
    { Habilita menus usando o codigo do cliente }
    FrmMenuPrincipal.HabilitaMenusPorCliente;
    Close;
  end;*)

  If Not UtilizaLogotipoPadrao Then
  Begin
    frmMenuPrincipal.Image1.Visible := False; // Desativa o bitmap padrão e
    frmMenuPrincipal.Image2.Visible := True;  // ativa o bitmap sem referência a transportes.
  End;

  { Atualiza a linha de mensagem }
  Msg;

  { Verifica e, se necessário, cria o sistema na tabela de sistemas,
    para não dar erro na rotina que ajusta os menus }
  VerificaCriaSistemas;
  { Atualiza Menus }
  qrCtr_MenusDoSistema.Close;
  // Não roda para cargas, pois deleta coisas do Dataflex. Silvio.
  //If vcSistema <> 'CGS' Then
  frmMenuPrincipal.ContSenhaBgm.GeraTabelaAPartirDoMenu;
  frmMenuPrincipal.ContSenhaBgm.DesabilitaMenus;
  { Habilita novamente o timer }
  frmMenuPrincipal.Timer1.Enabled := True;

  { Grava os dados da estacao na tabela de controle de acesso, }
  { exceto para SEGURANÇA e CONTROLE }
  If ( vcSistema <> 'SEG' ) And
     ( vcSistema <> 'CTR' ) and
     ( vcSistema <> 'GRP' ) Then
  Begin
    With qrAuxiliar Do
    Begin
      If dm.DbBGM.InTransaction Then dm.DbBGM.Rollback;
      dm.DbBGM.StartTransaction;
      Close;
      Sql.Clear;
//      Sql.Add('Insert Into CTR_AcessoPorEstacao (Aplicacao, Estacao, DataHora, UsuarioWin) Values (:P0, :P1, SysDate, :P2)');

      // If dm.vBancoDeDados = 'ORACLE' Then
      If vcBancoDeDados = 'ORACLE' Then
        Sql.Add('Insert Into ' + cTabelaDeLicencas + ' (Aplicacao, Estacao, DataHora, UsuarioWin, Sistema, VALIDA_SESSAO) Values (:P0, :P1, SysDate, :P2, :P3, Sysdate)')
      else
        Sql.Add('Insert Into ' + cTabelaDeLicencas + '(Aplicacao, Estacao, DataHora, UsuarioWin, Sistema, VALIDA_SESSAO) Values (:P0, :P1, Cast(Current_TimeStamp As Date), :P2, :P3, Cast(Current_TimeStamp As Date) )');
      Params[0].AsString := Application.Title; // RetornaNomeDoExecutavel;
      Params[1].AsString := TrazNomeDoComputador;
      Params[2].AsString := AnsiUpperCase(WinLogin);
      Params[3].AsString := vcSistema;
      GetSql(qrAuxiliar);
      ExecSql;
      Close;
      { Grava um LOG para sabermos quantas conexões estão ativas - incluindo esta
        e também a qtd de módulos em uso }
      Sql.Clear;
      Sql.Add(' Select (Select Count(Distinct Estacao || UsuarioWin) From ' + cTabelaDeLicencas + ') UA,');
      Sql.Add('        (Select Count(*) From ' + cTabelaDeLicencas + ') MA');
      Sql.Add(' From Dual');
      Open;
      GravaLog(vcSistema, 'GLOBUS', Now, 'Usuarios ativos = ' + FieldByName('UA').AsString +
                                         ' / Modulos ativos = ' + FieldByName('MA').AsString);
      dm.DbBGM.Commit;
    End;
  End;

  If ( vcSistema <> 'GRP' ) Then
    { Grava um log informando a abertura do módulo }
    GravaLog(vcSistema, 'GLOBUS', Now, 'Abriu o modulo: ' + WinLogin + '/' + TrazNomeDoComputador + '. (' + FrmSetupRD.Edit1.Text + ')');

  { Ajusta a variável "vFazTraducaoDeInterface", de acordo com a configuração }
  With qrAuxiliar Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add('Select UsarPortuguesPadrao From Ctr_Parametros');
    Open;
    frmMenuPrincipal.vFazTraducaoDeInterface := IsEmpty Or (FieldByName('UsarPortuguesPadrao').AsString = 'N');
    vcFazTraducaoDeInterface := frmMenuPrincipal.vFazTraducaoDeInterface;
    Close;
  End;

  { Verifica se a data da estação está diferente do Oracle }
  With qrAuxiliar Do
  Begin
    Close;
    Sql.Clear;
    // If dm.vBancoDeDados = 'ORACLE' Then
    If vcBancoDeDados = 'ORACLE' Then
      Sql.Add(' Select SysDate From Dual ')
    Else // Interbase
      Sql.Add('Select Cast(Current_TimeStamp As Date) SysDate From CTR_ACESSO');
    Open;
    If Abs(FieldByName( 'SysDate' ).AsDateTime - Now) > 2 Then
    Begin
      vSystemTimeOld := DateTimeToStr(Now);
      GetLocalTime(vSystemTime);
      // DateTimeToStr retorna "dd/mm/yyyy hh:mm:ss"
      //                        0000000001111111111
      //                        1234567890123456789
      vSystemTime.wYear   := StrToInt(Copy(DateTimeToStr(FieldByName( 'SysDate' ).AsDateTime),  7 , 4));
      vSystemTime.wMonth  := StrToInt(Copy(DateTimeToStr(FieldByName( 'SysDate' ).AsDateTime),  4 , 2));
      vSystemTime.wDay    := StrToInt(Copy(DateTimeToStr(FieldByName( 'SysDate' ).AsDateTime),  1 , 2));
      vSystemTime.wHour   := StrToInt(Copy(DateTimeToStr(FieldByName( 'SysDate' ).AsDateTime), 12 , 2));
      vSystemTime.wMinute := StrToInt(Copy(DateTimeToStr(FieldByName( 'SysDate' ).AsDateTime), 15 , 2));
      vSystemTime.wSecond := StrToInt(Copy(DateTimeToStr(FieldByName( 'SysDate' ).AsDateTime), 18 , 2));
      SetLocalTime(vSystemTime);
      vFechaSplash := True;
      MensagemDlg('O calendário da estação estava definido como ' + vSystemTimeOld +
                  '. Foi ajustado para ' + DateTimeToStr(FieldByName( 'SysDate' ).AsDateTime) +
                  '. Verificar possíveis problemas com a estação.', mtInformacao, mbOk);
    End;
    Close;
  End;

  { Temporariamente compila a procedure, que esporadicamente apresenta problemas - Silvio
    O erro é o ORA-06502, que parece ser bug do Oracle 8.1.6. }

  { Retirei novamente em 04/06/2003 - Silvio, pois estava travando na Áurea }

  { Voltei a recompilação, mas apenas para a contabilidade - Silvio 11/12/2003
    Isto já havia sido feito em 31/07/2003, mas "sumiu" do fonte }
  If vcSistema = 'CTB' Then
  Begin
    With qrAuxiliar Do
    Begin
      Msg('Compilando a procedure PR_CTB_GravaLanc ...');
      Close;
      Sql.Clear;
      Sql.Add(' ALTER PROCEDURE PR_CTB_GRAVALANC COMPILE ');
      Try
        ExecSql;
      Except
      End;
      Close;
      Msg;
    End;
  End;

  vFechaSplash := True;

  { Avisa quando a aplicação está rodando em um drive diferente do drive dos relatórios, pois pode estar incorreto }
  If //(frmMenuPrincipal.vCodigoCliente <> 9999) And
     (Copy(ParamStr(0), 1, 2) <> vDriveDir) And
     (Not vcUsuarioManagerComSenhaUm) Then
    MensagemDlg('Atenção: O sistema está sendo executado a partir do drive "' +
    Copy(ParamStr(0), 1, 2) + '" e o drive dos relatórios é "' + vDriveDir + '".', mtAtencao, mbOk);

  { Avisa quando está com o drive dos relatórios em C:, pois pode estar incorreto }
//  If (frmMenuPrincipal.vCodigoCliente <> 9999) And (vDriveDir = 'C:') Then
//    MensagemDlg('Atenção: Os relatórios serão lidos a partir do drive "C:".', mtInformacao, mbOk);

  { Verifica se o seguranca.exe está na máquina e se é anterior a 01/02/2002. Se for, remove-o }
  Try
    vFileName := {vDriveDir +} '\Globus\Sistemas\Seguranca\Seguranca.exe';
    vFileHandle := FileOpen(vFileName , fmShareDenyNone );
//    If FileGetDate(vFileHandle) > 742282952 Then // 30/1/2002-10:54
//    If FileGetDate(vFileHandle) >= 750607109 Then // 29/5/2002-11:24 - Silvio
    If FileGetDate(vFileHandle) >= 751595620 Then // 12/6/2002-14:14 - Silvio
       FileClose(vFileHandle)
    Else
    Begin
      FileClose(vFileHandle);
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS OFF}
  {$ENDIF}
      vFileAttr := FileGetAttr(vFileName);
      If (vFileAttr >= 0) And ((vFileAttr And $00000001{faReadOnly}) <> 0) Then
        FileSetAttr(vFileName, vFileAttr And Not $00000001{faReadOnly});
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS ON}
  {$ENDIF}
      DeleteFile(vFileName);
    End;
  Except;
  End; // Try

End;

/// No momento em que é fechado o sistema, fecha a tabela auxiliar de acesso

procedure TDm.FazLogin;
begin
  { Cria o form }
  vForm := TForm.Create(Application);
  With vForm Do
  begin
    Caption     := 'Globus - Login do sistema';
    Position    := poScreenCenter;
    Height      := 180;
    Width       := 270;
    BorderStyle := bsSingle;
    BorderIcons := [biSystemMenu];
    { Cria os componentes do form }
    vEServerName := TEdit.Create(Self);
    vEUserName   := TEdit.Create(Self);
    vEPassword   := TEdit.Create(Self);
    vEDrive      := TDriveComboBox.Create(Self);
    vEServer     := TEdit.Create(Self);
    vLServerName := TLabel.Create(Self);
    vLUserName   := TLabel.Create(Self);
    vLPassword   := TLabel.Create(Self);
    vLDrive      := TLabel.Create(Self);
    vLServer     := TLabel.Create(Self);
    vBotao       := TBitBtn.Create(Self);
    { Seta parametros para os componentes }
    vEServerName.Parent     := vForm;
    vEUserName.Parent       := vForm;
    vEPassword.Parent       := vForm;
    vEDrive.Parent          := vForm;
    vEServer.Parent         := vForm;
    vLServerName.Parent     := vForm;
    vLUserName.Parent       := vForm;
    vLPassword.Parent       := vForm;
    vLDrive.Parent          := vForm;
    vLServer.Parent         := vForm;
    vBotao.Parent           := vForm;
    vLServerName.Top        := 12;
    vLServerName.Left       := 10;
    vLServerName.Caption    := 'Server name: ';
    vLUserName.Top          := 32;
    vLUserName.Left         := 10;
    vLUserName.Caption      := 'User name: ';
    vLPassword.Top          := 52;
    vLPassword.Left         := 10;
    vLPassword.Caption      := 'Password:';
    vLDrive.Top             := 72;
    vLDrive.Left            := 10;
    vLDrive.Caption         := 'Drive dos relatórios: ';
    vLServer.Top            := 90;
    vLServer.Left           := 10;
    vLServer.Caption        := 'Drive temporário: ';
    vEServerName.Top        := 10;
    vEServerName.Left       := 105;
    vEServerName.Width      := vEDrive.Width;
    vEServerName.CharCase   := ecUpperCase;
    vEServerName.Text       := 'GLOBUSSERVER';
    vEUserName.Top          := 30;
    vEUserName.Left         := 105;
    vEUserName.Width        := vEDrive.Width;
    vEUserName.CharCase     := ecUpperCase;
    vEUserName.Text         := 'GLOBUS';
    vEPassword.Top          := 50;
    vEPassword.Left         := 105;
    vEPassword.PasswordChar := '#';
    vEPassword.Width        := vEDrive.Width;
    vEDrive.Top             := 70;
    vEDrive.Left            := 105;
    vEServer.Top            := 88;
    vEServer.Left           := 105;
    vEServer.Width          := vEDrive.Width;
    vEServer.Text           := 'C:';
    vBotao.Top              := 119;
    vBotao.Left             := ( Width - vBotao.Width ) Div 2;
    vBotao.Kind             := bkOK;
    vBotao.ModalResult      := mrNone;
    vBotao.OnClick          := pConfirma;
    { Abre o formulario }
    ShowModal;
  end;
  { Limpa o formulario da memoria }
  vForm.Free;
end;

procedure TDm.pConfirma(Sender:TObject);
begin
  { Seta os parametros }
  dbBgm.Connected := False;
  dbBgm.Params.Clear;
  dbBgm.AliasName := Trim(vEServerName.Text);
  dbBgm.Params.Add('USER NAME='+Trim(vEUserName.Text));
  dbBgm.Params.Add('PASSWORD='+Trim(vEPassword.Text));
  frmMenuPrincipal.vServerName := Trim(vEServerName.Text);
  frmMenuPrincipal.vUserName   := Trim(vEUserName.Text);
  frmMenuPrincipal.vUserSenha  := Trim(vEPassword.Text);

  vcServerName := Trim(vEServerName.Text);
  vcUserName   := Trim(vEUserName.Text);
  vcUserSenha  := Trim(vEPassword.Text);


  vDriveDir  := Copy(Trim(vEDrive.Text),1,1) + ':';
  vDriveTemp := Trim(vEServer.Text);
  { Connecta com o banco de dados }
  try
    dbBgm.Connected := True;
    vForm.Close;
  except
    On E:EDBEngineError Do
    Begin
      dbBgm.Connected := False;
      ShowMessage('Não foi possível fazer a conexão com o banco.' + Chr(13) + #13 +
                  'Erro: ' + E.Errors[1].Message);
    end;
  end;
end;

procedure Tdm.QrCtr_VigenciaMovtoAfterClose(DataSet: TDataSet);
begin
  with QrCtr_VigenciaMovto do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CTR_VIGENCIAMOVTO WHERE CODIGOEMPRESA = :P_CODIGOEMPRESA AND CODIGOFL = :P_CODIGOFL AND SISTEMA = :P_SISTEMA AND MESANOVIGENCIA = :P_MESANOVIGENCIA');
      Params[0].Datatype  := ftInteger;
      Params[0].ParamType := ptInput;
      Params[0].Value     := 'Integer';
      Params[1].Datatype  := ftInteger;
      Params[1].ParamType := ptInput;
      Params[1].Value     := 'Integer';
      Params[2].Datatype  := ftString;
      Params[2].ParamType := ptInput;
      Params[2].Value     := 'String';
      Params[3].Datatype  := ftDateTime;
      Params[3].ParamType := ptInput;
      Params[3].Value     := 'Date';
    end;
end;

procedure Tdm.qrCtr_IdiomaNacionalAfterClose(DataSet: TDataSet);
begin
  With qrCtr_IdiomaNacional Do
  begin
    Sql.Clear;
    Sql.Add('SELECT'                                   );
    Sql.Add('  CTR_IDIOMANACIONAL.PALAVRA_FRASEIDNAC,' );
    Sql.Add('  CTR_IDIOMANACIONAL.SEQUENCIAIDNAC '     );
    Sql.Add('FROM '                                    );
    Sql.Add('  CTR_IDIOMANACIONAL '                    );
    Sql.Add('ORDER BY '                                );
    Sql.Add('  PALAVRA_FRASEIDNAC '                    );
  end;
end;

////////////////////////////////////////////////////////////////////////////////

{ Rotina para atulizar os scripts no banco de dados }

function Tdm.AtualizaBaseDeDados(pDrive:String):Boolean;
Var
  vContinue       : Boolean;
  vAnterior,i,vTotal : Integer;

  qrAux,
  qrStp,
  qrInter         : TQuery;
  stpAux          : TStoredProc;
  vDir            : TDirectoryListBox;
  vArq            : TFileListBox;

  vCont,
  vNArq           : Integer;

  vArqLog, vArqLogE, vArqAcessoMenu, vArqNovidades  : TextFile;

  vfrmExibicao    : TForm;
  vEdit           : TEdit;
  vMemo           : TRichEdit;
  vLbl, Status, Status2, Status3 : TLabel;
  ProgressBar     : TGauge;
  ProgressBar2    : TGauge;
  ProgressBar3    : TGauge;

  vPodeGravarLog,
  vProcCriaTab,
  vTemErro        : Boolean;
  t,
  vNomeArqLog, vLocalArq, vLinha, vDirNov,
  vNomeArqMenu    : String;
  { Define os sistemas que serão processados }
  Const vSistemas : Array[1..36,1..2] Of String = (
                                             ('Abastecimento'           ,'ABA'), // 01
                                             ('Arrecadacao'             ,'ARR'), // 02
                                             ('Ativo'                   ,'ATF'), // 03
                                             ('Bancos'                  ,'BCO'), // 04
                                             ('Componente'              ,'CPN'), // 05
                                             ('Compras'                 ,'CPR'), // 06
                                             ('Contabilidade'           ,'CTB'), // 07
                                             ('ContasPagar'             ,'CPG'), // 08
                                             ('ContasReceber'           ,'CRC'), // 09
                                             ('Controle'                ,'CTR'), // 10
                                             ('DVS'                     ,'DVS'), // 11
                                             ('Escala'                  ,'ESC'), // 12
                                             ('Escrituracao'            ,'ESF'), // 13
                                             ('Estoque'                 ,'EST'), // 14
                                             ('Folha'                   ,'FLP'), // 15
                                             ('Frequencia'              ,'FRQ'), // 16
                                             ('Fretamento'              ,'FRE'), // 17
                                             ('Frota'                   ,'FRT'), // 18
                                             ('Manutencao'              ,'MAN'), // 19
                                             ('Motor'                   ,'MOT'), // 20
                                             ('Passes'                  ,'PAS'), // 21
                                             ('Pneus'                   ,'PNE'), // 22
                                             ('RecursosHumanos'         ,'RHU'), // 23
                                             ('Seguranca'               ,'SEG'), // 24
                                             ('Trafego'                 ,'TRF'), // 25
                                             ('Turismo'                 ,'TUR'), // 26
                                             ('Plantao'                 ,'PLT'), // 27
                                             ('Acidentes'               ,'ACI'), // 28
                                             ('Terminal'                ,'TER'), // 29
                                             ('Passes e Vales-Transporte','PVT'),// 30
                                             ('Cargas'                  ,'CGS'), // 31
                                             ('EscalaRodoviaria'        ,'ROD'), // 32
                                             ('TRR'                     ,'TRR'), // 33
                                             ('Terceiros'               ,'CTE'), // 34
                                             ('Crachas'                 ,'CRA'), // 35
                                             ('Retaguarda'              ,'RET')  // 36
                                                   );
  { Cria function para encontrar a palavra no texto }
  function TemPalavraChave(pPalavra,pTexto:String;pInicio:Boolean=True): Boolean;
  begin
    Result := False;
    { Caso a palavra tenha que estar no inicio }
    If pInicio Then
      begin
        If ( Pos(pPalavra,pTexto) > 0                           ) And
           ( Trim( Copy(pTexto,1,Pos(pPalavra,pTexto)-1) ) = '' ) Then
         Result := True;
      end
    else
      If Pos(pPalavra,pTexto) > 0 Then Result := True;
  end;

  { Cria procedure para atualizar os scripts no banco }
  procedure FazAtualizacaoDoSql(pSis:String);
  Var
    I,I1     : Integer;
    vArquivo,
    vDtCpAtu,
    vDtCpArq : String;
    vTexto   : TextFile;
    vPesqDHA : TSearchRec;
    vDataA   : TDateTime;
    vHoraA   : String;
    vTmArq,
    vLinSql  : Integer;
    vExeSql,             // Executa Sql
    vFechaB,             // Fecha com Barra
    vInicio,             // Inicio do comando
    vTiraPV,             // Tira ponto e virgula
    vComent,
    vTemDt   : Boolean;  // Verifica se o arquivo tem a data definida
  begin
    vDataA := 0;       // Só para não dar Warning
    vExeSql := False;  //

    AtualizaProgress(ProgressBar,Status,0,1,pSis + IIF(pSis = 'CTR','- Executando upt´s no banco...','- Executando script´s no banco...'));

    For I := 0 To vArq.Items.Count-1 Do
    begin

      AtualizaProgress(ProgressBar,Status,i,vArq.Items.Count-1,pSis + IIF(pSis = 'CTR','- Executando upt´s no banco...','- Executando script´s no banco...'));

      { Armazena o caminho + nome do arquivo na variavel, para poder abri-lo }
      vArquivo := vDir.Directory + '\' + vArq.Items.Strings[I];
      { Exibe o nome do arquivo no edit do form }
      Inc(vNArq);
      vEdit.Text   := vArq.Items.Strings[I];
      vLbl.Caption := Copy(vLbl.Caption,1,28) + ' ' + IntToStr(vNArq);
      vLbl.Update;
      vEdit.Update;
      { Verifica se já foi processado o arquivo CriaTabelasEProcGlobus40 }
      If ( Not vProcCriaTab                                             ) And
         ( UpperCase(vArq.Items.Strings[I]) = 'CRIATABELASGLOBUS40.SQL' ) Then
        vProcCriaTab := True
      else If ( vProcCriaTab                                                 ) And
              ( UpperCase(vArq.Items.Strings[I]) = 'CRIATABELASGLOBUS40.SQL' ) Then
        Continue;
      { Abre o arquivo para leitura e encontra a data e hora de atualização }
      FindFirst(vArquivo,faAnyFile,vPesqDHA);
//      vDataA := FileDateToDateTime(vPesqDHA.Time);
//      vHoraA := Copy( TimeToStr(FileDateToDateTime(vPesqDHA.Time)), 1, 5 );
      vTmArq := vPesqDHA.Size;
      FindClose(vPesqDHA);
      { Caso o arquivo seja um Upt, não precisa pesquisar a data, pois esta
        informação já esta embutida no nome do mesmo }
      If UpperCase(Copy(vArq.Items.Strings[I],1,3)) = 'UPT' Then
      Begin

        { Arquivo inválido ? O Formato deve ser UPT_AAAAMMDD_SSS.SQL }
        If (Copy(vArq.Items.Strings[I],04,1) <> '_') Or
           (Copy(vArq.Items.Strings[I],13,1) <> '_') Or
           (Uppercase(Copy(vArq.Items.Strings[I],17,4)) <> '.SQL') Or
           (Length(vArq.Items.Strings[I]) <> 20) Then
        begin
          WriteLn(vArqLoge,'');
          WriteLn(vArqLoge,'------ ARQUIVO UPT INVÁLIDO (Nome): ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
          WriteLn(vArqLoge,'');
          vTemErro := True;
          Continue;
        end;

        { A partir da versão de 16/6/2004, não roda os UPTs de CGS nos clientes que usam Dataflex - Silvio - 15/6 }
        If (Pos('CGS', UpperCase(vArq.Items.Strings[I])) > 0) And
           (
//           (vcCodigoCliente = cCodCli_1001)             Or 12/09/2007 - Passa a Usar a Versão do Globus Delphi
//           (vcCodigoCliente = cCodCli_Teresopolis)      Or
             (vcCodigoCliente = cCodCli_LogConsult)       Or
             (vcCodigoCliente = cCodCli_NPimenta)         Or
             (vcCodigoCliente = cCodCli_Catarinense)      Or
             (vcCodigoCliente = cCodCli_Hess)             Or
             (vcCodigoCliente = cCodCli_Cajumar)          Or
             (vcCodigoCliente = cCodCli_Maringa)          Or
             (vcCodigoCliente = cCodCli_SUT)              Or
             (vcCodigoCliente = cCodCli_Caxiense)         or
             (vcCodigoCliente = cCodCli_Transalvini)      or
             (vcCodigoCliente = cCodCli_CargoSoft)        or
             (vcCodigoCliente = cCodCli_TransTestoni)     or
             (vcCodigoCliente = cCodCli_VerdiLogistica)   or
             (vcCodigoCliente = cCodCli_MirimdoSulTransp)
           ) Then
        begin
          WriteLn(vArqLoge,'');
          WriteLn(vArqLoge,'------ ARQUIVO IGNORADO (CGS-DFX): ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
          WriteLn(vArqLoge,'');
          vTemErro := True;
          Continue;
        end;

        { Caso não consiga pegar a data do arquivo pelo nome, é que o nome esta
          definido de forma errada }
        try
          vDataA := StrToDate( Copy(vArq.Items.Strings[I],11,02) + '/' +
                               Copy(vArq.Items.Strings[I],09,02) + '/' +
                               Copy(vArq.Items.Strings[I],05,04)        );
        except
          { Arquivo inválido. O Formato deve ser UPT_AAAAMMDD_SSS.SQL }
          begin
            WriteLn(vArqLoge,'');
            WriteLn(vArqLoge,'------ ARQUIVO UPT INVÁLIDO (Data): ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
            WriteLn(vArqLoge,'');
            vTemErro := True;
            Continue;
          end;
        end;

        { Não roda os UPTs anteriores a 01/07/2004 }
        If vDataA < StrToDate('01/01/2005') Then
        Begin
          WriteLn(vArqLoge,'');
          WriteLn(vArqLoge,'------ ARQUIVO UPT ANTIGO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
          WriteLn(vArqLoge,'');
          vTemErro := True;
          Continue;
        End;
      End // UPT
      else
        begin
          { Abre o arquivo para leitura }
          {$I-}
          AssignFile(vTexto,vArquivo);
          FileMode := 0;  //( Set file access to read only }
          Reset(vTexto);
          {$I+}
          { Seta a variavel }
          vTemDt := False;
          { Faz um While do arquivo para encontrar data e hora (Definição) }
          While Not Eof(vTexto) Do
          begin
            { Le uma linha do arquivo }
            ReadLn(vTexto,vArquivo);
            {
              Obs: A primeira linha do texto dever ser:
              Rem Data: 01/01/2001 Hora: 08:00
              12345678901234567890123456789012
                       1         2         3
            }
            If UpperCase(Copy(vArquivo,5,5)) = 'DATA:' Then
            begin
              try
                vDataA := StrToDate(Copy(vArquivo,11,10));
                vHoraA := Copy(vArquivo,28,5);
                vTemDt := True;
              except
                { Caso tenha dado erro é porque a data está errada,
                  não processa o arquivo. }
                vTemDt := False;
              end;
              Break;
            end;
          end; // Eof
          { Fecha o arquivo para poder fazer a leitura deste o inicio }
          CloseFile(vTexto);
          { Caso não tenha a data definida, não processa o arquivo }
          If Not vTemDt Then
          begin
            { Grava o nome do arquivo que não será processado }
            WriteLn(vArqLoge,'');
            WriteLn(vArqLoge,'------ ARQUIVO NÃO PROCESSADO, FALTA "Rem Data: DD/MM/AAAA Hora: HH:MM" : ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
            WriteLn(vArqLoge,'');
            vTemErro := True;
            Continue;
          end;
          { Testa se a Data e Hora estão corretas }
          try
            // Converte Hora (String) para (Time)
            vHoraA := Copy( TimeToStr( StrToTime(vHoraA) ), 1, 5 );
          except
            { Grava o nome do arquivo que não será processado }
            WriteLn(vArqLoge,'');
            WriteLn(vArqLoge,'------ ARQUIVO NÃO PROCESSADO, DEFINIÇÃO ERRADA DE "Rem Data: DD/MM/AAAA Hora: HH:MM" : ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
            WriteLn(vArqLoge,'');
            vTemErro := True;
            Continue;
          end;
        end; // If UpperCase(Copy(vArq.Items.Strings[I],1,3)) = 'UPT' Then
      { Verifica se o arquivo existe na tabela Ctr_Scripts e se existir
        verifica se houve alguma atualização. }
      { Caso não encontre o arquivo, faz a inclusão }
      qrStp.Close;
//      vExeSql          := False;
      qrStp.ParamCheck := True;

      If (Not qrAux.Locate('Arquivo',pSis+'_'+vArq.Items.Strings[I],[loCaseInsensitive])) Then
        begin
          { Seta o vExeSql para True, faz a atualização do arquivo }
          vExeSql := True;
          { Grava na tabela Ctr_Scripts o arquivo }
          With qrStp Do
          begin
            { Faz o comando insert }
            Close;
            Sql.Clear;
            Sql.Add('Insert Into Ctr_Scripts '         );
            Sql.Add('( '                               );
            Sql.Add('  SISTEMA,'                       );
            Sql.Add('  ARQUIVO,'                       );
            Sql.Add('  CAMINHO,'                       );
            Sql.Add('  DATAATU,'                       );
            Sql.Add('  HORAATU,'                       );
            Sql.Add('  TMARQUI '                       );
            Sql.Add(') '                               );
            Sql.Add('Values '                          );
            Sql.Add('( '                               );
            Sql.Add('  :pSISTEMA,'                     );
            Sql.Add('  :vArqUIVO,'                     );
            Sql.Add('  :pCAMINHO,'                     );
            Sql.Add('  :pDATAATU,'                     );
            Sql.Add('  TO_DATE(:pHORAATU,''HH24:MI''),');
            Sql.Add('  :pTMARQUI '                     );
            Sql.Add(') '                               );
            ParamByName('pSISTEMA').asString   := pSis;
            ParamByName('vArqUIVO').asString   := pSis + '_' + vArq.Items.Strings[I];
            ParamByName('pCAMINHO').asString   := vDir.Directory;
            ParamByName('pDATAATU').asDateTime := vDataA;
            ParamByName('pHORAATU').asString   := vHoraA;
            ParamByName('pTMARQUI').asFloat    := vTmArq;
            ExecSQL;
          end; // With qrStp
        end //  Locate
      else // Not Locate
        begin
          { Caso já contenha o arquivo CriaTabelasGlobus40, ignora a atualização }
          If ( UpperCase(vArq.Items.Strings[I]) = 'CRIATABELASGLOBUS40.SQL' ) Then
            Continue;
          { Seta variavies apenas para o teste }
          vDtCpAtu := Copy(DateToStr(vDataA),7,4) + Copy(DateToStr(vDataA),4,2) + Copy(DateToStr(vDataA),1,2);
          vDtCpArq := Copy(qrAux.FieldByName('DATAATU').asString,7,4) +
                      Copy(qrAux.FieldByName('DATAATU').asString,4,2) +
                      Copy(qrAux.FieldByName('DATAATU').asString,1,2) ;
          { Testa se o arquivo foi alterado, caso seja Upt, verifica apenas
            a data não consiste a hora. }
          vExeSql := False;
          If UpperCase(Copy(vArq.Items.Strings[I],1,3)) = 'UPT' Then
            begin
// Estava processando UPTs que tinham data do arquivo inferior ao do nome do UPT. Silvio - 29/10/2003
//              If vDtCpAtu > vDtCpArq Then // Nunca roda novamente um UPT. Silvio 27/08/2003.
//                vExeSql := True;
            end
          else
            begin
              { Testa se a data do arquivo é maior que o que está no banco ou
                Tamanho seja diferente ou
                Data = e hora maior }
              If   ( vDtCpAtu > vDtCpArq                               ) Or
//                   ( vTmArq  <> qrAux.FieldByName('TMARQUI').asInteger ) Or
                 (
                   (
                     vDtCpAtu = vDtCpArq
                   )
                     And
                   (
                     Copy(vHoraA,1,2)+Copy(vHoraA,4,2) >
                     Copy(TimeToStr(qrAux.FieldByName('HORAATU').asDateTime),1,2)+Copy(TimeToStr(qrAux.FieldByName('HORAATU').asDateTime),4,2)
                   )
                 ) Then
                vExeSql := True;
            end;
          If vExeSql Then
            begin
              { Atualiza o arquivo na Ctr_Scripts }
              With qrStp Do
              begin
                Close;
                Sql.Clear;
                Sql.Add('Update Ctr_Scripts '                      );
                Sql.Add('Set '                                     );
                Sql.Add('  CAMINHO=:pCAMINHO,'                     );
                Sql.Add('  DATAATU=:pDATAATU,'                     );
                Sql.Add('  HORAATU=TO_DATE(:pHORAATU,''HH24:MI''),');
                Sql.Add('  TMARQUI=:pTMARQUI '                     );
                Sql.Add('Where '                                   );
                Sql.Add('  SISTEMA=:pSISTEMA And'                  );
                Sql.Add('  ARQUIVO=:vArqUIVO'                      );
                ParamByName('pSISTEMA').asString   := pSis;
                ParamByName('vArqUIVO').asString   := pSis + '_' + vArq.Items.Strings[I];
                ParamByName('pCAMINHO').asString   := vDir.Directory;
                ParamByName('pDATAATU').asDateTime := vDataA;
                ParamByName('pHORAATU').asString   := vHoraA;
                ParamByName('pTMARQUI').asFloat    := vTmArq;
                ExecSQL;
              end; // With
            end; // Endif Atualiza
        end; // Endif Locate

      { Caso seja para atualizar o banco, abre o arquivo texto e interpreta
        os camandos atribuindo-os para uma query e executa. }
      If vExeSql Then
      begin
        { Atribui novamente o arquivo da variavel vArquivo, pois perdeu o seu
          conteudo nos procedimentos anteriores }
        vArquivo := vDir.Directory + '\' + vArq.Items.Strings[I];
        {$I-}
        AssignFile(vTexto,vArquivo);
        FileMode := 0;  //( Set file access to read only }
        Reset(vTexto);
        {$I+}
        { Inicia variaveis }
        vInicio := True;
        vFechaB := False;
        vTiraPV := True;
        vLinSql := 0;
        vComent := False;
        { Desabilita a checagem de parametros para a query
          Isto fazia com que ocorrece erros ao criar storedprocedure que
          cotinham :=. Limpa o comando Sql da query }
        qrStp.Close;
        qrStp.ParamCheck := False;
        qrStp.Params.Clear;
        qrStp.Sql.Clear;
        { Faz um loop do arquivo }
        While Not Eof(vTexto) Do
        begin
          { Para não aparentar congelamento }
          Application.ProcessMessages;
          { Le uma linha do arquivo }
          ReadLn(vTexto,vArquivo);
//          vArquivo := UpperCase(vArquivo);
          { Caso a linha esteja em brando ou Tiver o comando @ (pois é chamada
            à outro script), ou tiver um Rem ou // ou /* (que é comentário)
            ignora a linha }

          If ( vInicio                            )  And
             (( Trim(vArquivo) = ''               )  Or
              ( TemPalavraChave('@'    ,vArquivo) )  Or
              ( TemPalavraChave('REM'  ,UpperCase(vArquivo)) )  Or
              ( TemPalavraChave('SET'  ,UpperCase(vArquivo)) )  Or
//              ( TemPalavraChave('--'   ,vArquivo) )  Or
              ( TemPalavraChave('SPOOL',UpperCase(vArquivo)) )) Then
          Continue;

          // Rotina para Ignorar comentário somente se for no inicio do SQL

          // Se encontrou abertura de comentário, e não encontrou fechamento,
          // ignora a linha até encontrar o fechamento.
          If vInicio then
          begin
            If ( Pos('/*',vArquivo) > 0 ) And
               ( Pos('*/',vArquivo) = 0 ) Then
              begin
                vComent := True;
                Continue;
              end
            //   Caso tenha aberto comentário e fechado na mesma linha, deleta o
            // pedaço da linha.
            else If ( Pos('/*',vArquivo) > 0 ) And
                    ( Pos('*/',vArquivo) > 0 ) Then
              begin
                Delete(vArquivo,Pos('/*',vArquivo),(Pos('*/',vArquivo)-Pos('/*',vArquivo))+2);
                vComent := False;
              end;
            //   Caso tenha aberto comentário e encontrou fechamento, ignora a linha
            // e faz um loop
            If (vComent) And (Pos('*/',vArquivo) > 0) Then
            begin
              vComent := False;
              Continue;
            end;

            //   Caso a variável vComent esteja = True, é porque ainda não encontrou
            // o fechamento do comentário.
            If vComent Then
              Continue; // Caso seja comentário, ignora a linha
          end;

          // Caso o comentário seja no final da linha, delete-o da linha
          If Pos('//',vArquivo) > 0 Then
            Delete(vArquivo,Pos('//',vArquivo),Length(vArquivo));
          // Caso a linha esteja vazia, ignora

          If Trim(vArquivo) = '' Then
            Continue;

          { Caso seja um Select direto, deve interpretar estes comandos
            pois deve ser gerado em um arquivo Spool. }
          If ( vInicio                            ) And
             ( TemPalavraChave('SELECT',UpperCase(vArquivo)) ) Then
            begin
              qrInter.Close;
              qrInter.Sql.Clear;
              vTiraPV := False;
              vLinSql := 0;
              qrInter.Sql.Add(vArquivo);
              { Faz um Loop até o final do comando }
              While True Do
              begin
                { Testa se passou pelo From para poder habilitar o tira ; }
                If Pos('FROM' ,UpperCase(vArquivo)) > 0 Then vTiraPV := True;
                { Testa se tem ; ou / e encerra o loop }
                If ( vTiraPV                 )  And
                   (( Pos(';' ,vArquivo) > 0 )  Or
                    ( Pos('/' ,vArquivo) > 0 )) Then
                  Break;
                { Le uma linha do arquivo }
                ReadLn(vTexto,vArquivo);
//                vArquivo := UpperCase(vArquivo);
                Inc(vLinSql);
                qrInter.Sql.Add(vArquivo);
              end; // While True
              { Elimina o ';' ou '/' do comando Sql }
              I1 := Length(qrInter.Sql.Strings[vLinSql]);
              While I1 >= 1 Do
              begin
                If ( Copy(qrInter.Sql.Strings[vLinSql],I1,1) = ';' ) Or
                   ( Copy(qrInter.Sql.Strings[vLinSql],I1,1) = '/' ) Then
                  Break;
                Dec(I1);
              end;
              qrInter.Sql.Strings[vLinSql] := Copy(qrInter.Sql.Strings[vLinSql],1,I1-1);
              { Abre a query e executa os comandos }
              try
                qrInter.Open;
                While Not qrInter.Eof Do
                begin
                  { Limpa o Sql e Atribui o campo encontrado na query auxiliar e
                    executa-o }
                  vArquivo := qrInter.Fields[0].asString;
                  Delete(vArquivo,Pos(';',vArquivo),1);
                  qrStp.Close;
                  qrStp.Sql.Clear;
                  qrStp.Sql.Add(vArquivo);
                  try
                    qrStp.ExecSQL;
                    { Se não correr erro, exibe OK }
                    WriteLn(vArqLog,Replicate('-',80));
                    WriteLn(vArqLog,'** ARQUIVO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
                    WriteLn(vArqLog,'   * Executando o comando: ' + qrStp.Sql.Text);
                    WriteLn(vArqLog,'   * Executado com sucesso.' );
                  except
                    On E:EDBEngineError Do
                    begin
                      { Caso ocorra erro, exibe a mensagem de erro no arquivo }
                      WriteLn(vArqLoge,Replicate('-',80));
                      WriteLn(vArqLoge,'** ARQUIVO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
                      WriteLn(vArqLoge,'   * Executando o comando: ' + qrStp.Sql.Text);
                      WriteLn(vArqLoge,'   * Executado com erro: ' + Trim(IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message) );
                      vTemErro := True;
                      // Apaga registro no CTR_Scripts caso haja erro na geração
                      qrAuxiliar.Close;
                      qrAuxiliar.sql.Clear;
                      qrAuxiliar.sql.Add('delete from ctr_scripts where arquivo = :parquivo');
                      qrAuxiliar.ParamByName('pArquivo').AsString := pSis+'_'+vArq.Items.Strings[I];
                      qrAuxiliar.ExecSQL;
                    end;
                  end;
                  qrInter.Next;
                end; // While Not eof
              except
                On E:EDBEngineError Do
                begin
                  { Caso ocorra erro, exibe a mensagem de erro no arquivo }
                  WriteLn(vArqLoge,Replicate('-',80));
                  WriteLn(vArqLoge,'** ARQUIVO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
                  WriteLn(vArqLoge,'   * Executando o comando: ' + qrInter.Sql.Text);
                  WriteLn(vArqLoge,'   * Executado com erro: ' + Trim(IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message) );
                  vTemErro := True;
                  // Apaga registro no CTR_Scripts caso haja erro na geração
                  qrAuxiliar.Close;
                  qrAuxiliar.sql.Clear;
                  qrAuxiliar.sql.Add('delete from ctr_scripts where arquivo = :parquivo');
                  qrAuxiliar.ParamByName('pArquivo').AsString := pSis+'_'+vArq.Items.Strings[I];
                  qrAuxiliar.ExecSQL;
                end;
              end;
              { Fecha a query, limpa os parametros e vai para o próximo Sql. }
              qrStp.Close;
              qrStp.ParamCheck := False;
              qrStp.Params.Clear;
              qrStp.Sql.Clear;
              vLinSql := -1;
              { Volta a variavel ao original }
              vTiraPV := True;
              vInicio := True;
              { Vai para o While }
              Continue;
            end; // If Copy(vArquivo,1,6) = 'SELECT'
          { Sempre mantem esta variavel como false, pois true executa o comando }
          vExeSql := False;
          { Testa qual o comando a ser executado, caso seja inicio de comando }
          If vInicio Then
            begin
              { O Drop fica separado, pois não pode ter o ; e pode ser feito
                tanto para Table como para procedure, e ai ocasiona erro se
                deixar entrar no if da procedure }
              If TemPalavraChave('DROP',UpperCase(vArquivo)) Then
                begin
                  vFechaB := False; // Variavel para saber se fecha com barra ou ;
                  vInicio := False;
                  vTiraPV := True;
                  vLinSql := -1;
                end
                { Estes comandos devem estar no inicio da linha e não pode ter
                  sido iniciado o comando. }
              else If ( TemPalavraChave('UPDATE' ,UpperCase(vArquivo)) ) Or
                      ( TemPalavraChave('INSERT' ,UpperCase(vArquivo)) ) Or
                      ( TemPalavraChave('DELETE' ,UpperCase(vArquivo)) ) Then
                begin
                  vFechaB := False; // Variavel para saber se fecha com barra ou ;
                  vInicio := False;
                  vTiraPV := True;
                  vLinSql := -1;
                end
              else If ( TemPalavraChave('PROCEDURE',UpperCase(vArquivo),False) ) Or
                      ( TemPalavraChave('FUNCTION' ,UpperCase(vArquivo),False) ) Or
                      ( TemPalavraChave('TRIGGER'  ,UpperCase(vArquivo),False) ) Or
                      ( TemPalavraChave('PACKAGE'  ,UpperCase(vArquivo),False) ) Then
                begin
                  vFechaB := True; // Variavel para saber se fecha com barra ou ;
                  vInicio := False;
                  vTiraPV := False;
                  vLinSql := -1;
                end
              else If ( TemPalavraChave('VIEW'    ,UpperCase(vArquivo),False) ) Or
                      ( TemPalavraChave('TABLE'   ,UpperCase(vArquivo),False) ) Or
                      ( TemPalavraChave('INDEX'   ,UpperCase(vArquivo),False) ) Or
                      ( TemPalavraChave('SEQUENCE',UpperCase(vArquivo),False) ) Then
                begin
                  vFechaB := False; // Variavel para saber se fecha com barra ou ;
                  vInicio := False;
                  vTiraPV := True;
                  vLinSql := -1;
                end;
            end; // If vInicio
          { Testa se o comando é um execute, caso sim, atribui o nome da stored
            ao componente TStoredProc e o executa }
        If ( vInicio ) And ( TemPalavraChave('EXECUTE',UpperCase(vArquivo)) ) Then
          begin
            { Isola apenas o nome da procedure }
            Delete(vArquivo,1,Pos(' ',vArquivo));
            Delete(vArquivo,Pos(';',vArquivo),1);
            { Atribui o nome ao componente stored e executa }
            stpAux.StoredProcName := UpperCase(vArquivo);
            try
              stpAux.ExecProc;
              { Se não correr erro, exibe OK }
              WriteLn(vArqLog,Replicate('-',80));
              WriteLn(vArqLog,'** ARQUIVO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
              WriteLn(vArqLog,'   * Executando o comando: ' + vArquivo + ';');
              WriteLn(vArqLog,'   * Executado com sucesso.' );
            except
              On E:EDBEngineError Do
              begin
                { Caso ocorra erro, exibe a mensagem de erro no arquivo }
                WriteLn(vArqLoge,Replicate('-',80));
                WriteLn(vArqLoge,'** ARQUIVO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
                WriteLn(vArqLoge,'   * Executando o comando: ' + vArquivo + ';');
                WriteLn(vArqLoge,'   * Executado com erro: ' + Trim(IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message) );
                vTemErro := True;
                // Apaga registro no CTR_Scripts caso haja erro na geração
                qrAuxiliar.Close;
                qrAuxiliar.sql.Clear;
                qrAuxiliar.sql.Add('delete from ctr_scripts where arquivo = :parquivo');
                qrAuxiliar.ParamByName('pArquivo').AsString := pSis+'_'+vArq.Items.Strings[I];
                qrAuxiliar.ExecSQL;
              end;
            end;
            { Atribui Tru a variavel vInicio }
            vInicio := True;
            { Vai para a proxima linha }
            Continue;
          end;
          { Caso esteja procurando a palavra chave para inicio, ignora }
          If vInicio Then Continue;
          { Testa se a linha contem o caractere de fechamento do comando / ou ;.
            tem que tomar cuidado com a / pois pode ser uma divisão e não um
            fechamento de comando. }
          { Testa se tem comandos após a barra }
          If Trim(vArquivo) = '/' Then
            vExeSql := True
          else If Not vFechaB Then
            begin
              If ( ( Pos('/',vArquivo) > 0 ) And ( Trim( Copy(vArquivo,Pos('/',vArquivo)+1,Length(vArquivo)) ) = '' ) And ( Trim( Copy(vArquivo,Pos('/',vArquivo)-1,1) ) <> '*' ) ) Or
                 ( ( Pos(';',vArquivo) > 0 )                                                                                                                                      ) Then
                vExeSql := True
            end;
          { Caso não contenha / na linha, a adiciona do Sql }
          If ( Not vExeSql ) Or ( Pos('/',vArquivo) <= 0 ) Then
            begin
              qrStp.Sql.Add(vArquivo);
              // Para não pular linha
              //qrStp.Sql.Text := qrStp.Sql.Text + vArquivo;
              Inc(vLinSql);
            end;
          { Caso seja para executar o comando Sql, executa limpa o sql e vInicio = True}
          If vExeSql Then
            begin
              { Antes de executar o comando, tira o ; ou / }
              vArquivo := qrStp.Sql.Strings[vLinSql];
              If vTiraPV Then
                begin
                  If Pos(';',vArquivo) > 0 Then
                    Delete(vArquivo,Pos(';',vArquivo),1)
                  else
                    Delete(vArquivo,Pos('/',vArquivo),1);
                end;
              qrStp.Sql.Strings[vLinSql] := vArquivo;
              { Grava uma linha em branco, para o arquivo não ficar tão poluido }
              //WriteLn(vArqLog,'');
              { Executa o comando }
              try
                qrStp.ExecSQL;
                { Se não correr erro, exibe OK }
                WriteLn(vArqLog,Replicate('-',80));
                WriteLn(vArqLog,'** ARQUIVO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
                WriteLn(vArqLog,'   * Executando o comando: ' + qrStp.Sql.Text);
                WriteLn(vArqLog,'   * Executado com sucesso.' );
              except
                On E:EDBEngineError Do
                begin
                  { Caso ocorra erro, exibe a mensagem de erro no arquivo }
                  WriteLn(vArqLoge,Replicate('-',80));
                  WriteLn(vArqLoge,'** ARQUIVO: ' + vDir.Directory + '\' + vArq.Items.Strings[I] + '------');
                  WriteLn(vArqLoge,'   * Executando o comando: ' + qrStp.Sql.Text);
                  WriteLn(vArqLoge,'   * Executado com erro: ' + Trim(IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message) );
                  vTemErro := True;
                  // Apaga registro no CTR_Scripts caso haja erro na geração
                  qrAuxiliar.Close;
                  qrAuxiliar.sql.Clear;
                  qrAuxiliar.sql.Add('delete from ctr_scripts where arquivo = :parquivo');
                  qrAuxiliar.ParamByName('pArquivo').AsString := pSis+'_'+vArq.Items.Strings[I];
                  qrAuxiliar.ExecSQL;
                end;
              end;
              { Fecha a query, limpa os parametros e vai para o próximo Sql. }
              qrStp.Close;
              qrStp.ParamCheck := False;
              qrStp.Params.Clear;
              qrStp.Sql.Clear;
              vInicio := True;
            end; // If vExecSql
        end; // Eof do arquivo
        { Fecha o arquivo }
        CloseFile(vTexto);
      end; // If vExeSql (Executa o sql)
    end; // For I To Numero de arquivos

    AtualizaProgress(ProgressBar,Status,0,1,''); 

  end; // Begin da procedure
begin
  { Seta o valor de retorno como True }
  Result := True;
  vEnviaEMailLog := False;
    
  { Testa se o arquivo Glb_Atu_Bco_Dados.txt existe. Caso não exista, não
    faz o processamento. }
  { Caso exista o arquivo, dá uma mensagem que fará a atualização do banco
    de dados, e se deseja proceguir }
  If Not FileExists(pDrive + '\Globus\Glb_Atu_Bco_Dados.txt') Then Exit; // Não fazer a atualização automática.
  { Verifica se o sistema está sendo atualizado por outra estação }
  { Abre e fecha a transação para que outras estações vejam a inserção do registro }

  If ParamStr(1) <> 'ATUALIZACAO' Then
  Begin
    dbBgm.StartTransaction;
    If Not AtualizarBaseDeDados Then
    begin
      dbBgm.RollBack;
      Application.Terminate;
    end;
    dbBgm.Commit;
    // Dá mensagem que o sistema será atualizado.
    If MessageDlg('O sistema irá fazer a ATUALIZAÇÃO DO BANCO DE DADOS. Você está conectado em ' +
                   Trim(vcServerName) + '/' + Trim(vcUserName) + '/' +
                   UpperCase(vDriveDir) + IIf(QtdDeUsuariosConectados = 0,'','. Existe(m) ' +
                   IntToStr(QtdDeUsuariosConectados) + ' usuário(s) conectado(s)') + '. Deseja continuar?',
       mtConfirmation, [mbYes, mbNo], 0 ) = mrNo Then
    begin
      // Limpa a tabela referente a atualização do globus
      With qrAuxiliar Do
      begin
        // Abre transação
        dbBgm.StartTransaction;
        // Executa o comando
        Close;
        Sql.Clear;
        Sql.Add('Delete Ctr_AtualizaBase');
        try
          ExecSQL;
          dbBgm.Commit;
        except
          dbBgm.RollBack;
        end;
      end;
      // Retorna false
      Result := False;
      Exit;
    end;
  End ; // If ParamStr(1) <> 'ATUALIZACAO' Then

  With qrAuxiliar Do
  begin
    // Executa o comando
    Close;
    Sql.Clear;
    Sql.Add('SELECT COUNT(*) pPrivilege FROM TABLE_PRIVILEGES WHERE TABLE_NAME = ''V_$SESSION'' AND GRANTEE = SYS_CONTEXT(''USERENV'',''CURRENT_USER'')');
    Open;
    If FieldByName('pPrivilege').AsInteger <= 0 Then
    begin
      // Retorna false
      MessageDlg('Esta versão do GLOBUS exige que o usuário ' + Trim(vcUserName) + ' tenha privilégios de leitura (SELECT) sobre a view de sistema V$SESSION. Entre em contato com seu Administrador de Banco de Dados.',
                 mtWarning,
                 [mbAbort],
                 0);
      Result := False;
      Exit;
    end;
    Close;
  end;

  { Cria as querys auxiliares }
  qrAux   := TQuery.Create(Application);
  qrStp   := TQuery.Create(Application);
  qrInter := TQuery.Create(Application);
  stpAux  := TStoredProc.Create(Application);
  qrAux.DatabaseName   := 'dbBgm';
  qrStp.DatabaseName   := 'dbBgm';
  qrInter.DatabaseName := 'dbBgm';
  stpAux.DatabaseName  := 'dbBgm';
  { Cria um formulario para exibir as informações de atualização }
  vfrmExibicao := TForm.Create(Application);
  vLbl         := TLabel.Create(Application);
  vEdit        := TEdit.Create(Application);
  vMemo        := TRichEdit.Create(Application);
  Status       := TLabel.Create(Application);
  Status2      := TLabel.Create(Application);
  Status3      := TLabel.Create(Application);
  ProgressBar  := TGauge.Create(Application);
  ProgressBar2 := TGauge.Create(Application);
  ProgressBar3 := TGauge.Create(Application);


  With vfrmExibicao Do
  begin
    Height      := 187;
    Width       := 582;
    Name        := 'fExibeAtu';
    BorderIcons := [];
    BorderStyle := bsSingle;
    Caption     := 'Globus - (' +
                   Trim(vcServerName) + '/' +
                   Trim(vcUserName)   + '/' +
                   IIf(vcCodigoCliente <> 0,
                       IntToStr(vcCodigoCliente) + '/', '') +
                   UpperCase(vDriveDir)               + ') ' ;
    Color       := clTeal;
    Position    := poScreenCenter;
  end;

  With vLbl Do
  begin
    Parent     := vfrmExibicao;
    Name       := 'lblAtu';
    Caption    := 'Atualizando o banco de dados: ';
    Font.Color := clAqua; // Não altere esta linha
    Font.Size  := 14;
    Font.Style := [fsBold];
    Height     := 20;
    Left       := 10;
    Top        := 8;
    Width      := 254;
  end;
  With vEdit Do
  begin
    Parent := vfrmExibicao;
    Color  := clTeal;
    Name   := 'edt';
    Font.Color := clBtnText;
    Font.Style := [fsBold];    
    Height := 21;
    Left   := 11;
    Top    := 130;
    Width  := 552;
    Text   := '';
  end;
  With vMemo Do
  begin
    Parent  := vfrmExibicao;
    Name    := 'memErro';
    Visible := False;
    Clear;
  end;

  With ProgressBar do
  Begin
    Parent := vfrmExibicao;
    Left := 11;
    Top := 42;
    Width := 552;
    Height := 22;
    Color := clWhite;
    ForeColor := 16744448;
    ParentColor := False;
    ParentShowHint := False;
    Progress := 0;
    ShowHint := False;
    ShowText := False;
  end;

  With ProgressBar2 do
  Begin
    Parent := vfrmExibicao;
    Left := 12;
    Top := 71;
    Width := 552;
    Height := 22;
    Color := clWhite;
    ForeColor := 16744448;
    ParentColor := False;
    ParentShowHint := False;
    Progress := 0;
    ShowHint := False;
    ShowText := False;
  end;

  With ProgressBar3 do
  Begin
    Parent := vfrmExibicao;
    Left := 12;
    Top := 101;
    Width := 552;
    Height := 22;
    Color := clWhite;
    ForeColor := 16744448;
    ParentColor := False;
    ParentShowHint := False;
    Progress := 0;
    ShowHint := False;
    ShowText := False;
  end;

  With Status do
  Begin
    Parent := vfrmExibicao;
    Left := 19;
    Top := 46;
    Width := 530;
    Height := 13;
    Alignment := taCenter;
    AutoSize := False;
    Color := clWhite;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentColor := False;
    ParentFont := False;
    Transparent := True;
  End;

  With Status2 do
  Begin
    Parent := vfrmExibicao;
    Left := 19;
    Top := 76;
    Width := 530;
    Height := 13;
    Alignment := taCenter;
    AutoSize := False;
    Color := clWhite;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentColor := False;
    ParentFont := False;
    Transparent := True;
  End;

  With Status3 do
  Begin
    Parent := vfrmExibicao;
    Left := 19;
    Top := 105;
    Width := 530;
    Height := 13;
    Alignment := taCenter;
    AutoSize := False;
    Color := clWhite;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentColor := False;
    ParentFont := False;
    Transparent := True;
  End;

  { Exibe o formulario }
  vfrmExibicao.Show;
  { Cria componentes de diretorios }
  vDir          := TDirectoryListBox.Create(Self);
  vArq          := TFileListBox.Create(Self);
  vDir.FileList := vArq;
  vDir.Parent   := vfrmExibicao;
  vDir.Visible  := False;
  vArq.Mask     := '*.Sql';
  vArq.Parent   := vfrmExibicao;
  vArq.Visible  := False;
  { Inicia uma transação }
  dbBgm.StartTransaction;
  { Utiliza a qrAux como padrão }
  With qrAux Do
  begin
    { Verifica se existe a tabela CTR_Scripts, caso ocorra erro no momento
      de abrir a tabela cria-a }
    Close;
    Sql.Clear;
    Sql.Add('Select * From Ctr_Scripts Order By Arquivo');
    try
      Open;
    except
      { Cria a tablea Ctr_Scripts }
      Close;
      Sql.Clear;
      Sql.Add('CREATE TABLE CTR_SCRIPTS '         );
      Sql.Add('( '                                );
      Sql.Add('  SISTEMA VARCHAR2(3) NOT NULL,'   );
      Sql.Add('  ARQUIVO VARCHAR2(255) NOT NULL,' );
      Sql.Add('  CAMINHO VARCHAR2(255) NOT NULL,' );
      Sql.Add('  DATAATU DATE,'                   );
      Sql.Add('  HORAATU DATE,'                   );
      Sql.Add('  TMARQUI NUMBER(10) '             );
      Sql.Add(') '                                );
      Sql.Add('TABLESPACE GLOBUS_TABLE'           );
      ExecSQL;
      Close;
      Sql.Clear;
      Sql.Add('ALTER TABLE CTR_SCRIPTS '                                     );
      Sql.Add('ADD ( CONSTRAINT PK_CTR_SCRIPTS_SISARQ PRIMARY KEY (ARQUIVO) ');
      Sql.Add('USING INDEX TABLESPACE GLOBUS_INDEX )'                        );
      ExecSQL;
      { Abre a tablela novamente }
      Close;
      Sql.Clear;
      Sql.Add('Select * From Ctr_Scripts Order By Arquivo');
      Open;
    end;

    { Grava o log de quem está fazendo esta atualização }
    { Só pode gravar log quando for alteração de banco. No caso de estar criando, a
      tabela ainda não existirá neste ponto }
    vPodeGravarLog := True;
    With qrStp Do // Verifica se existe a tabela CTR_LOG
    begin
      Close;
      Sql.Clear;
      Sql.Add('Select Count(*) From Ctr_Log');
      try
        Open;
      except
        vPodeGravarLog := False;
      end; // Try
      { Fecha a query }
      Close;
    end; // With qrStp
    With qrStp Do // Verifica se existe o sistema
    begin
      Close;
      Sql.Clear;
      Sql.Add( ' Select * From Ctr_CadastroSistemas ' );
      Sql.Add( ' Where Sistema = :P0                ' );
      Params[0].AsString := vcSistema;
      try
        Open;
        vPodeGravarLog := vPodeGravarLog And (RecordCount = 1);
      except
        vPodeGravarLog := False;
      end; // Try
      { Fecha a query }
      Close;
    end; // With qrStp
    With qrStp Do // Verifica se existe o usuário GLOBUS
    begin
      Close;
      Sql.Clear;
      Sql.Add('Select * From Ctr_CadastroDeUsuarios Where Usuario = ''GLOBUS''');
      try
        Open;
        vPodeGravarLog := vPodeGravarLog And (RecordCount = 1);
      except
        vPodeGravarLog := False;
      end; // Try
      { Fecha a query }
      Close;
    end; // With qrStp
    If vPodeGravarLog Then
      GravaLog(vcSistema,'GLOBUS',Now,'Atualizacao dos scripts atraves da estacao: ' + TrazNomeDoComputador + ', com a seguinte configuracao: (' + Trim(vcServerName) + '/' + Trim(vcUserName) + '/' + UpperCase(vDriveDir) + ')');
    { Abre o arquivo de Log para gravação }
    vNomeArqLog := pDrive + '\Globus\Log_Atu_Banco_' + Copy(DateToStr(Now),7,4)+Copy(DateToStr(Now),4,2)+Copy(DateToStr(Now),1,2) + '_' + Copy(TimeToStr(Now),1,2) + Copy(TimeToStr(Now),4,2);
    AssignFile(vArqLog,vNomeArqLog+'.txt');
    ReWrite(vArqLog);
    AssignFile(vArqLoge,vNomeArqLog+'e.txt');
    ReWrite(vArqLoge);
    WriteLn(vArqLog,'--- LOG INICIADO EM ' + FormatDateTime('dd/mm/yyyy' + ''' AS ''' + 'hh:mm:ss', now)
                     + ' ' + Trim(vcServerName)
                     + '/' + Trim(vcUserName)
                     + '/' + IIf(vcCodigoCliente <> 0,
                             IntToStr(vcCodigoCliente) + '/', '')
                     +       UpperCase(vDriveDir)
                     + '/(' + FrmSetupRD.Edit1.Text
                     + ') ---');

    WriteLn(vArqLog,'');
    WriteLn(vArqLoge,'--- LOG INICIADO EM ' + FormatDateTime('dd/mm/yyyy' + ''' AS ''' + 'hh:mm:ss', now)
                     + ' ' + Trim(vcServerName)
                     + '/' + Trim(vcUserName)
                     + '/' + IIf(vcCodigoCliente <> 0,
                             IntToStr(vcCodigoCliente) + '/', '')
                     +       UpperCase(vDriveDir)
                     + '/(' + FrmSetupRD.Edit1.Text
                     + ') ---');
    WriteLn(vArqLoge,'');
    vTemErro := False;
    { Variaveis auxiliares }
    vCont := 1000;
    vNArq := 0;
    { Variavel para saber se já processou o script CriaTabelasEProcGlobus40,
      pois se for a primeira vez, inicia o processamento no Upt_1000 e encontra
      também no Upt_2000 e dá erro. }
    vProcCriaTab := False;
    { Verifica se é a instalação do Globus. Caso seja, ao invés de iniciar o
      processamento no Upt_1000, inicia no ultimo que tiver.
      Caso não seja instalação, verifica em que diretorio Upt iniciou a insta-
      lação desta versão e a atualização é feita a partir daí. }
    With qrStp Do
    begin
      { Verifica se é instalação, fazendo um Select na tabela Ctr_Concedente,
        caso ocorra erro é sinal que não existe nenhuma tabela criada }
      Close;
      Sql.Clear;
      Sql.Add('Select * From Ctr_Concedente');
      try
        { Tem a tabela, deve-se verificar agora em qual diretorio iniciou a
          intalação do Globus }
        Open;
        { Encontra o arquivo CriaTabelasGlobus40.Sql e verifica qual o diretorio
          em que foi gravado na tabela Ctr_Scripts, caso não encontre, inicia
          no Upt_1000 }
        Close;
        Sql.Clear;
        Sql.Add('Select Caminho From Ctr_Scripts Where Upper(Arquivo) = ''CTR_CRIATABELASGLOBUS40.SQL''');
        Open;
        If Not IsEmpty Then
          vCont := StrToInt(Copy(FieldByName('Caminho').asString,Length(FieldByName('Caminho').asString)-3,4));
        Close;
      except
        { Encontra qual o ultimo diretorio de atualização Upt }
        vCont := 9000;
        While vCont >= 1000 Do
        begin
          { Caso não ocorra erro, o diretorio existe e é a partir dele que
            serão criadas as tabelas, pois esta sendo feito um While
            decrescente. }
          try
            vDir.Directory := pDrive + '\Globus\Clientes\Upt_' + IntToStr(vCont);
            vLocalArq      := vDir.Directory;
            Break;
          except
            Dec(vCont,1000);
          end;
        end; // While
      end; // Try
      { Fecha a query }
      Close;
    end; // With qrStp

    { Faz a leitura dos arquivos Upts para executá-los }
    While vCont <= 9000 Do
    begin
      try
        vDir.Directory := pDrive + '\Globus\Clientes\Upt_' + IntToStr(vCont);
        vLocalArq      := vDir.Directory;
      except
        Inc(vCont,1000);
        Continue;
      end;
      { Processa scripts }
      FazAtualizacaoDoSql('CTR');
      Inc(vCont,1000);
    end; // While I <= 9000

    { Faz a leitura dos arquivos Sql de criação de Procedures, View, Triggers
      Packages e Sequences para os sistemas }
    For vCont := 1 To High(vSistemas) Do
    begin
      { Vai para o diretorio correspondente ao sistema, caso não exista
        ignora }
      try
        vDir.Directory := pDrive + '\Globus\Sistemas\' + vSistemas[vCont,1] + '\Scripts';
      except
//        WriteLn(vArqLog,'------ Nenhum script para o sistema: ' + vSistemas[vCont,1] + ' ------' );
        Continue;
      end;
      { Processa scripts }
      FazAtualizacaoDoSql(vSistemas[vCont,2]);
    end; // For

    AtualizaProgress(ProgressBar,Status,1,1,'100 %');    

    { Monta o comando para trazer os objetos invalidos }
    Close;
    Sql.Clear;
    Sql.Add('SELECT '                                         );
    Sql.Add('  OBJECT_TYPE,'                                  );
    Sql.Add('  OWNER,'                                        );
    Sql.Add('  OBJECT_NAME '                                  );
    Sql.Add('FROM '                                           );
    Sql.Add('  ALL_OBJECTS '                                  );
    Sql.Add('WHERE '                                          );
    Sql.Add('  STATUS = ''INVALID'' AND '                     );
//    Sql.Add('  Owner  = (Select Distinct User From v$Session)');
    Sql.Add('  Owner  = ''' + frmMenuPrincipal.vUserName + '''' );
    { Recria objetos inválidos }

    vAnterior := -1;  
    vContinue := True;


    While vContinue do
    begin
      Close;
      Open;

      If (vAnterior = RecordCount) Then
        vContinue := False;

      { Fecha e abre a query, pois pode ser alterado o numero de registros re-
        tornados devido a compilação dos mesmos no procedimento a seguir. }

      AtualizaProgress(ProgressBar2,Status2,0,1,'Recompilando os objetos inválidos...');
      I := 0;
      vTotal := RecordCount;
      { Processa todos os registros encontrados }
      While Not Eof Do
      begin

        AtualizaProgress(ProgressBar2,Status2,i,vTotal,'Recompilando os objetos inválidos...');

        { Monta o comando de compilação e executa a query }
        qrStp.Close;
        qrStp.Sql.Clear;

        If FieldByName('OBJECT_TYPE').asString <> 'PACKAGE BODY' Then
          qrStp.Sql.Add('ALTER ' + FieldByName('OBJECT_TYPE').asString + ' ' +
                                   FieldByName('OWNER').asString       + '.' +
                                   FieldByName('OBJECT_NAME').asString + ' COMPILE')
        else
          qrStp.Sql.Add('ALTER PACKAGE ' +
                        FieldByName('OWNER').asString       + '.' +
                        FieldByName('OBJECT_NAME').asString + ' COMPILE BODY');

        { Exibe o comando na tela }
        vEdit.Text := qrStp.Sql.Strings[0];
        vLbl.Update;
        vEdit.Update;
        { Executa o comando }
        try
          qrStp.ExecSQL;
          { Caso seja o ultimo For, grava no arquivo de log }
          If NOT vContinue Then
             WriteLn(vArqLoge,'Objeto inválido: ' + qrStp.Sql.Strings[0]);
        except
          On E:EDBEngineError Do
            { Caso ocorra erro, exibe a mensagem de erro no arquivo }
            If NOT vContinue Then
            begin
              WriteLn(vArqLoge,'Erro: ' + IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message + ' ao executar: ' + qrStp.Sql.Strings[0] );
              vTemErro := True;
            end;
        end;
        { Vai para o proximo registro (Objeto) }
        Next;
        Inc(i);
      end; // While
      AtualizaProgress(ProgressBar2,Status2,0,1,'');

      vAnterior := RecordCount;
    end; // For
    AtualizaProgress(ProgressBar2,Status2,1,1,'100 %');
    { Fecha o arquivo de log }

    t:= criptografouSenhaEmail;

    if t <> '' then
    begin
      WriteLn(vArqLog,'');
      WriteLn(vArqLog, t);
    end;

    WriteLn(vArqLog,'');
    WriteLn(vArqLog,'--- LOG ENCERRADO EM ' + FormatDateTime('dd/mm/yyyy' + ''' AS ''' + 'hh:mm:ss', now) + ' ---' );
    CloseFile(vArqLog);
    If Not vTemErro Then WriteLn(vArqLogE,'NENHUM ERRO ENCONTRADO.');
    WriteLn(vArqLogE,'');
    WriteLn(vArqLogE,'--- LOG ENCERRADO EM ' + FormatDateTime('dd/mm/yyyy' + ''' AS ''' + 'hh:mm:ss', now) + ' ---' );
    CloseFile(vArqLoge);
  end; // With qrAux

  // Importação das Novidades dos modulos
  vDirNov := vLocalArq;
  vLocalArq := vDirNov + '\SII_INF_PUBLIC.txt';
  If FileExists(vLocalArq) then
  begin
    AtualizaProgress(ProgressBar3,Status3,0,1,'Importando novidades dos módulos ...');
    EnDecryptFile( vLocalArq, vLocalArq, 12 );

    AssignFile ( vArqNovidades, vLocalArq);
    Reset ( vArqNovidades );

    i := 0;
    vTotal := 0;

    While not EOF (vArqNovidades) do
    begin
      ReadLn( vArqNovidades, vLinha );
      If Trim(vLinha) <> '' Then
        Inc(vTotal);
    end;

    CloseFile ( vArqNovidades);

    Try
      AssignFile ( vArqNovidades, vLocalArq);
    except
    end;

    Reset ( vArqNovidades );

    While not EOF (vArqNovidades) do
    begin
      AtualizaProgress(ProgressBar3,Status3,i,vTotal,'Importando novidades dos módulos ...');
      ReadLn( vArqNovidades, vLinha );

      If Trim(vLinha) = '' Then
        Continue;

      Try
        StrToDate(Trim(Copy(vLinha,560,10))) ;
      Except
        Continue ;
      End ; // Try - Except

      With qrAux Do
      begin
        Close;
        Sql.Clear;
        Sql.Add('Insert Into Ctr_Novidades');
        Sql.Add('( codnovidade, sistema, data, topico, assunto, concedente )');
        Sql.Add('Values( (Select Nvl(Max(codNovidade),0) + 1 From ctr_novidades )');
        Sql.Add(', :pSistema, :pData, :pTopico, :pAssunto, :pConcedente)');
        ParamByName('pSistema'   ).AsString   := Trim(IIF(Copy(vLinha,1,3) = 'ATV','ATF',Copy(vLinha,1,3)));
        ParamByName('pTopico'    ).AsString   := Trim(Copy(vLinha,6,50));
        ParamByName('pAssunto'   ).AsString   := Trim(Copy(vLinha,57,500));
        ParamByName('pData'      ).AsDateTime := StrToDate(Trim(Copy(vLinha,560,10)));
        ParamByName('pConcedente').AsString   := Trim(Copy(vLinha,571,5));
        Try
          ExecSql;
        Except
        End;
        Close;
      end;
    end;
    CloseFile ( vArqNovidades);

//    RenameFile( vDirNov + '\SII_INF_PUBLIC.txt', vDirNov + '\SII_INF_PUBLIC.Proc');
//    vLocalArq := vDirNov + '\SII_INF_PUBLIC.Proc';
//    EnDecryptFile( vLocalArq, vLocalArq, 12 ) ;

    If FileExists(vDirNov + '\SII_INF_PUBLIC.txt') Then
      DeleteFile(vDirNov + '\SII_INF_PUBLIC.txt') ;

    AtualizaProgress(ProgressBar,Status,1,1,'100 %');
  end;
  
  //Cria arquivo de LOG - acessos ao menus
  With qrAux Do
  begin
    { Verifica se existe a tabela ctr_ultimoacessomenu }
    Close;
    Sql.Clear;
    Sql.Add('SELECT usuario,                          ');
    Sql.Add('  sistema,                               ');
    Sql.Add('  indicemenu,nome,caption, ultimoacesso  ');
    Sql.Add('FROM ctr_ultimoacessomenu                ');
    Sql.Add('Order By usuario                         ');
    Try
      Open;
      If Not IsEmpty then
      Begin
        vNomeArqMenu := pDrive + '\Globus\Log_AcessoMenu_' + Copy(DateToStr(Now),7,4)+Copy(DateToStr(Now),4,2)+Copy(DateToStr(Now),1,2) + '_' + Copy(TimeToStr(Now),1,2) + Copy(TimeToStr(Now),4,2);
        AssignFile(vArqAcessoMenu,vNomeArqMenu+'.txt');
        ReWrite(vArqAcessoMenu);

        AtualizaProgress(ProgressBar3,Status3,0,1,'Criando Log de acesso a menus...');
        i := 0;
        vTotal := RecordCount;

        First;
        While not Eof do
        Begin

          AtualizaProgress(ProgressBar3,Status3,i,vTotal,'Criando Log de acesso a menus...');

          WriteLn(vArqAcessoMenu,Criptografa(IIf(vcCodigoCliente <> 0,StrZero(vcCodigoCliente,4),'0000') + ' '+
                                          Pad(FieldByName('USUARIO'   ).AsString,15,'E') + ' ' +
                                          Pad(FieldByName('SISTEMA'   ).AsString,03,'E') + ' ' +
                                          Pad(FieldByName('INDICEMENU').AsString,06,'E') + ' ' +
                                          Pad(FieldByName('NOME'      ).AsString,30,'E') + ' ' +
//                                          Pad(FieldByName('CAPTION'   ).AsString,50,'E') + ' ' +
                                          IIf(FieldByName('ULTIMOACESSO').AsString = '', Pad(' ',19,'E'),
                                              FormatDateTime('DD/MM/YYYY HH:NN:SS',FieldByName('ULTIMOACESSO').AsDateTime))+ ' '+
                                          FormatDateTime('DD/MM/YYYY',Date)));

          Inc(i);
          Next;
        End;

        AtualizaProgress(ProgressBar,Status,1,1,'100 %');

        //Cria os menus do cliente e modulo
        WriteLn(vArqAcessoMenu,Criptografa('*****')); //marca o texto para inicia da gravação dos menus
        Close;
        Sql.Clear;
        Sql.Add('SELECT sistema,                       ');
        Sql.Add('  indicemenu, nome, caption           ');
        Sql.Add('FROM  ctr_menusdosistema              ');
        Sql.Add('WHERE MENUVALIDO = ''S''              ');
        Sql.Add('Order By sistema, indicemenu          ');
        Open;
        While not Eof do
        Begin
          WriteLn(vArqAcessoMenu,Criptografa(IIf(vcCodigoCliente <> 0,StrZero(vcCodigoCliente,4),'0000') + ' '+
                                          Pad(FieldByName('SISTEMA'   ).AsString,03,'E') + ' ' +
                                          Pad(FieldByName('INDICEMENU').AsString,06,'E') + ' ' +
                                          Pad(FieldByName('NOME'      ).AsString,30,'E') + ' ' +
                                          Pad(FieldByName('CAPTION'   ).AsString,50,'E') + ' ' +
                                          FormatDateTime('DD/MM/YYYY',Date)));

          Next;
        End;

        CloseFile(vArqAcessoMenu);
      End;
    Except
    End;
  End;

  { Caso tenha ocorrido erro, exibe o arquivo de Log. }
  If vTemErro And (ParamStr(1) <> 'ATUALIZACAO') Then
  begin
    With vfrmExibicao Do
    begin
      WindowState      := wsMaximized;
      BorderIcons      := [biSystemMenu];
      Position         := poScreenCenter;
      Caption          := 'Análise do Log de atualização do sistema';
      vLbl.Align       := alTop;
      vLbl.Caption     := 'Arquivo: ' + vNomeArqLog + 'e.txt';
      vEdit.Visible    := False;
      vMemo.Align      := alClient;
      vMemo.Visible    := True;
      vMemo.ReadOnly   := True;
      vMemo.ScrollBars := ssVertical;
      vMemo.Lines.LoadFromFile(vNomeArqLog + 'e.txt');
      vMemo.SetFocus;
      // Exibe-o na tela
      Close;
      ShowModal;
    end;
  end; // If vTemErro Then
  { Limpa os componentes criados para execução desta procedure }
  qrStp.Free;
  stpAux.Free;
  vDir.Free;
  vArq.Free;
  vLbl.Free;
  vEdit.Free;
  vMemo.Free;
  vfrmExibicao.Close;
  vfrmExibicao.Free;
  { Fecha a transação }
  dbBgm.Commit;
  dbBgm.StartTransaction;
  // Limpa a tabela referente a atualização do globus
  With qrAuxiliar Do
  begin
    Close;
    Sql.Clear;
    Sql.Add('Delete Ctr_AtualizaBase');
    ExecSQL;
  end;
  { Fecha a transação }
  dbBgm.Commit;
  { Antes de apagar o arquivo Glb_Atu_Bco_Dados.txt, tira o atributo de ReadOnly }
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS OFF}
  {$ENDIF}
  If FileExists(pDrive + '\Globus\Glb_Atu_Bco_Dados.txt') Then
    FileSetAttr(pDrive + '\Globus\Glb_Atu_Bco_Dados.txt',faArchive);
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS ON}
  {$ENDIF}
  If Not DeleteFile(pDrive + '\Globus\Glb_Atu_Bco_Dados.txt') Then
    ShowMessage('Problemas ao excluir o arquivo: ' + pDrive + '\Globus\Glb_Atu_Bco_Dados.txt');

  If ParamStr(1) = 'ATUALIZACAO' Then
  Begin
    GravaArqIni('ULTIMAATUALIZACAO'
               ,''       + ParamStr(2)
               ,'ERRO='  + IIf(vTemErro ,'S','N')
               +',LOG='  + vNomeArqLog  + 'e.txt'
               +',LOGE=' + vNomeArqLog  + '.txt'
               +',MENU=' + vNomeArqMenu + '.txt'
               +',USU='  + ParamStr(3)
               +',TP='   + ParamStr(4)
               +',SIS='  + ParamStr(5)
               ,''
               ,'ATUALIZACAO') ;
    Result := False ;
  End Else // If ParamStr(1) = 'ATUALIZACAO' Then
    If Not vTemErro Then MensagemDlg('Nenhum erro encontrado durante a atualização.', mtInformacao, mbOk);

  CompactaArquivo(vNomeArqLog  + 'e.txt') ;
  CompactaArquivo(vNomeArqLog  + '.txt') ;
  CompactaArquivo(vNomeArqMenu + '.txt') ;

  qrAux.Free;
  qrInter.Free;

  //E-mail com log(s)...
  If (not vcUsuarioManagerComSenhaUm) And (ParamStr(1) <> 'ATUALIZACAO') then
  Begin
    vAtualizouBase := True;
    If MensagemDlg('Deseja enviar e-mail do(s) Log(s) para ' + vcConcedente + '?', mtConfirmacao, mbSim+mbNao ) = mrSim then
    Begin
      vEnviaEMailLog := True;
      MensagemDlg('Para o e-mail ser enviado automaticamente, informe USUÁRIO e SENHA no módulo Controle.', mtAtencao, mbOk);
      vcArquivoAcessoMenu := vNomeArqMenu+'.txt';
      vcArquivoLog     := vNomeArqLog+'.txt';
      vcArquivoLoge    := vNomeArqLog+'e.txt';
    End;
  End;   

end;

function Tdm.AtualizarBaseDeDados:Boolean;
Var
  vMsg : String;
begin
  // Padrão de retorno
  Result := True;
  vMsg := '';
  // Verifica se a tabela Ctr_AtualizaBase já existe
  With qrAuxiliar Do
  begin
    Close;
    Sql.Clear;
    Sql.Add('Select * From Ctr_AtualizaBase');
    try
      // Caso dê erro ao abrir a query é sinal que não existe a tabela.
      Open;
    except
      // Cria a tabela
      Close;
      Sql.Clear;
      Sql.Add('Create Table Ctr_AtualizaBase'                             );
      Sql.Add(' (nReg Number(1) Not Null, WinLogin VarChar2(80) Not Null)');
      Sql.Add('TableSpace Globus_Table'                                   );
      ExecSQL;
      Sql.Clear;
      Sql.Add('Alter Table Ctr_AtualizaBase'                            );
      Sql.Add('Add ( Constraint PK_Ctr_AtualizaBase Primary Key (nReg) ');
      Sql.Add('Using Index TableSpace Globus_Index )'                   );
      ExecSQL;
      Close;
    end;
    // Se a tabela não estiver aberta ou vazia, é que não há ninguém fazendo
    // a atualização, grava um registro e inicia o processo.
    If (Not Active) Or (IsEmpty) Then
      begin
        Close;
        Sql.Clear;
        Sql.Add('Insert Into Ctr_AtualizaBase (nReg,WinLogin)');
        Sql.Add('Values (:pnReg,:pWinLogin)'                  );
        ParamByName('pnReg'    ).asInteger := 1;
        ParamByName('pWinLogin').asString := AnsiUpperCase(TrazNomeDoComputador + '/' + WinLogin);
        try
          // Caso ocorra erro ao inserir registro, é sinal que outra máquina iniciou
          // a atualização.
          ExecSQL;
        except
          Result := False;
        end;
      end
    else
      begin
        // Verifica se o usuário que está gravado na tabela é # do que está tentando
        // se conectar agora.
        Result := FieldByName('WinLogin').AsString = AnsiUpperCase(TrazNomeDoComputador + '/' + WinLogin);
        vMsg := FieldByName('WinLogin').AsString;
      end;
    // Fecha a query
    Close;
  end; // With qrAuxiliar Do
  // Se result for false, não deve-se atualizar o sistema por esta estação.
  If Not Result Then
    If vcUsuarioManagerComSenhaUm Then
      Result := MensagemDlg('O Globus está sendo atualizado por (Usuário/Estação) "' + vMsg + '". . Deseja continuar?',mtConfirmacao, mbSim+mbNao ) = mrSim
    Else
      MensagemDlg('O Globus está sendo atualizado por (Usuário/Estação) "' + vMsg + '". Aguarde alguns instantes e tente novamente.', mtInformacao, mbOk );
end;

procedure Tdm.qrCtr_CadLocalAfterClose(DataSet: TDataSet);
begin
  with qrCtr_CadLocal do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CTR_CADLOCAL WHERE CODIGOLOCAL = :PCODIGOLOCAL');
    Params[0].Datatype  := ftInteger;
    Params[0].ParamType := ptInput;
    Params[0].Value     := 'Integer';
  end;
end;

procedure Tdm.MudaCor(Sender:TObject);
var S : string;
begin
  { Busca Cores definidas pelo usuário }
  vSecao := 'Cores_' + AnsiUpperCase(WinLogin + '/' + TrazNomeDoComputador);

  s := LeArqIni(vSecao,'CorEdicao', '','DIV');
  if Trim(s) = '' then
  begin
    vCorEdicao := $00D0FDFA;
    vCorOpcao  := clTeal;
    vCorFonteEdicao := clBlack;
    vCorFonteopcao  := clBlack;
  end
  else
  begin
    vCorEdicao      := StringToColor( LeArqIni(vSecao,'CorEdicao', '','DIV'));
    vCorFonteEdicao := StringToColor( LeArqIni(vSecao,'FonteEdicao', '','DIV'));
    vCorOpcao       := StringToColor( LeArqIni(vSecao,'CorOpcoes', '','DIV'));
    vCorFonteopcao  := StringToColor( LeArqIni(vSecao,'FonteOpcoes', '','DIV'));
  end;

  { Salva a cor }
  if assigned(CompoAnt1) then
  begin
    CompoAnt1.Color      := cColorAnt;
    CompoAnt1.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt2) then
  begin
    CompoAnt2.Color      := cColorAnt;
    CompoAnt2.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt3) then
  begin
    CompoAnt3.Color      := cColorAnt;
    CompoAnt3.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt4) then
  begin
    CompoAnt4.Color      := cColorAnt;
    CompoAnt4.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt5) then
  begin
    CompoAnt5.Color      := cColorAnt;
    CompoAnt5.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt6) then
  begin
    CompoAnt6.Color      := cColorAnt;
    CompoAnt6.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt7) then
  begin
    CompoAnt7.Color      := cColorAnt;
    CompoAnt7.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt8) then
  begin
    CompoAnt8.Color      := cColorAnt;
    CompoAnt8.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt9) then
  begin
    CompoAnt9.Color      := cColorAnt;
    CompoAnt9.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt10) then
  begin
    CompoAnt10.Color      := cColorAnt;
    CompoAnt10.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt11) then
  begin
    CompoAnt11.Color      := cColorAnt;
    CompoAnt11.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt12) then
  begin
    CompoAnt12.Color      := cColorAnt;
    CompoAnt12.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt13) then
  begin
    CompoAnt13.Color      := cColorAnt;
    CompoAnt13.Font.Color := cFontAnt;
    // A linha seguinte pode dar erro caso o form dono do CompoAnt13
    // não estiver visível. 
    try  // SIM 9568 - Sila
      CompoAnt13.SelStart   := 0; { para não ficar selecionado o item escolhido }
    except
    end; 
  end;
  if assigned(CompoAnt14) then
  begin
    CompoAnt14.Color      := cColorAnt;
    CompoAnt14.Font.Color := cFontAnt;
  end;
  if assigned(CompoAnt15) then { checklistbox }
  begin
    CompoAnt15.Color      := cColorAnt;
    CompoAnt15.Font.Color := cFontAnt;
  end;

{$IFDEF Cores}
  { Muda para nova cor para tela }
  Try
    if (screen.ActiveForm.ActiveControl is TEdit) then
    begin
      cColorAnt := TEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TEdit(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TEdit(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt1 := TEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt1 := nil;

    if (screen.ActiveForm.ActiveControl is TDBEdit) then
    begin
      cColorAnt := TDBEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDBEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TDBEdit(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TDBEdit(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt2 := TDBEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt2 := nil;

    if (screen.ActiveForm.ActiveControl is TMaskEdit) then
    begin
      cColorAnt := TMaskEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TMaskEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TMaskEdit(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TMaskEdit(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt3 := TMaskEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt3 := nil;

    if (screen.ActiveForm.ActiveControl is TDateEdit) then
    begin
      cColorAnt := TDateEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDateEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TDateEdit(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TDateEdit(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt4 := TDateEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt4 := nil;

    if (screen.ActiveForm.ActiveControl is TTimeEdit) then
    begin
      cColorAnt := TTimeEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TTimeEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TTimeEdit(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TTimeEdit(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt5 := TTimeEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt5 := nil;

    if (screen.ActiveForm.ActiveControl is TNumEdit) then
    begin
      cColorAnt := TNumEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TNumEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TNumEdit(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TNumEdit(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt6 := TNumEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt6 := nil;

    if (screen.ActiveForm.ActiveControl is TDbMemo) then
    begin
      cColorAnt := TDbMemo(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDbMemo(screen.ActiveForm.ActiveControl).Font.Color;
      TDbMemo(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TDbMemo(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt7 := TDbMemo(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt7 := nil;

    if (screen.ActiveForm.ActiveControl is TDBCheckBox) then
    begin
      cColorAnt := TDBCheckBox(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDBCheckBox(screen.ActiveForm.ActiveControl).Font.Color;
      TDBCheckBox(screen.ActiveForm.ActiveControl).color      := vCorOpcao;
      TDBCheckBox(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteopcao;
      CompoAnt8 := TDBCheckBox(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt8 := nil;

    if (screen.ActiveForm.ActiveControl is TDBRadioGroup) then
    begin
      cColorAnt := TDBRadioGroup(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDBRadioGroup(screen.ActiveForm.ActiveControl).Font.Color;
      TDBRadioGroup(screen.ActiveForm.ActiveControl).Color := vCorOpcao;
      TDBRadioGroup(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteopcao;
      CompoAnt9 := TDBRadioGroup(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt9 := nil;

    if (screen.ActiveForm.ActiveControl is TRadioButton) then
    begin
      cColorAnt := TRadioButton(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TRadioButton(screen.ActiveForm.ActiveControl).Font.Color;
      TRadioButton(screen.ActiveForm.ActiveControl).Color := vCorOpcao;
      TRadioButton(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteopcao;
      CompoAnt10 := TRadioButton(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt10 := nil;

    if (screen.ActiveForm.ActiveControl is TCheckBox) then
    begin
      cColorAnt := TCheckBox(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TCheckBox(screen.ActiveForm.ActiveControl).Font.Color;
      TCheckBox(screen.ActiveForm.ActiveControl).color      := vCorOpcao;
      TCheckBox(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteopcao;
      CompoAnt11:= TCheckBox(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt11 := nil;

    if (screen.ActiveForm.ActiveControl is TDBNumEdit) then
    begin
      cColorAnt  := TDBNumEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TDBNumEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TDBNumEdit(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TDBNumEdit(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt12 := TDBNumEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt12 := nil;

    if (screen.ActiveForm.ActiveControl is TComboBox) then
    begin
      cColorAnt  := TComboBox(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TComboBox(screen.ActiveForm.ActiveControl).Font.Color;
      TComboBox(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TComboBox(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt13 := TComboBox(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt13 := nil;

    if (screen.ActiveForm.ActiveControl is TMemo) then
    begin
      cColorAnt  := TMemo(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TMemo(screen.ActiveForm.ActiveControl).Font.Color;
      TMemo(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TMemo(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt14 := TMemo(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt14 := nil;
  except
  end;
  { Temporariamente sem

    if (screen.ActiveForm.ActiveControl is TCheckListBox) then
    begin
      cColorAnt  := TCheckListBox(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TCheckListBox(screen.ActiveForm.ActiveControl).Font.Color;
      TCheckListBox(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TCheckListBox(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt15 := TCheckListBox(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt15 := nil;

    if (screen.ActiveForm.ActiveControl is TDBGrid) then
    begin
      cColorAnt  := TDBGrid(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TDBGrid(screen.ActiveForm.ActiveControl).Font.Color;
      TDBGrid(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TDBGrid(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt16 := TDBGrid(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt16 := nil;}

  {$ELSE}
  try
    if (screen.ActiveForm.ActiveControl is TEdit) then
    begin
      cColorAnt := TEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TEdit(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TEdit(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt1 := TEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt1 := nil;

    if (screen.ActiveForm.ActiveControl is TDBEdit) then
    begin
      cColorAnt := TDBEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDBEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TDBEdit(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TDBEdit(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt2 := TDBEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt2 := nil;

    if (screen.ActiveForm.ActiveControl is TMaskEdit) then
    begin
      cColorAnt := TMaskEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TMaskEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TMaskEdit(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TMaskEdit(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt3 := TMaskEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt3 := nil;

    if (screen.ActiveForm.ActiveControl is TDateEdit) then
    begin
      cColorAnt := TDateEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDateEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TDateEdit(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TDateEdit(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt4 := TDateEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt4 := nil;

    if (screen.ActiveForm.ActiveControl is TTimeEdit) then
    begin
      cColorAnt := TTimeEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TTimeEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TTimeEdit(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TTimeEdit(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt5 := TTimeEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt5 := nil;

    if (screen.ActiveForm.ActiveControl is TNumEdit) then
    begin
      cColorAnt := TNumEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TNumEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TNumEdit(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TNumEdit(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt6 := TNumEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt6 := nil;

    if (screen.ActiveForm.ActiveControl is TDbMemo) then
    begin
      cColorAnt := TDbMemo(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDbMemo(screen.ActiveForm.ActiveControl).Font.Color;
      TDbMemo(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TDbMemo(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt7 := TDbMemo(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt7 := nil;

    if (screen.ActiveForm.ActiveControl is TDBCheckBox) then
    begin
      cColorAnt := TDBCheckBox(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDBCheckBox(screen.ActiveForm.ActiveControl).Font.Color;
      TDBCheckBox(screen.ActiveForm.ActiveControl).color      := $00B00000;
      TDBCheckBox(screen.ActiveForm.ActiveControl).Font.Color := clWhite;
      CompoAnt8 := TDBCheckBox(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt8 := nil;

    if (screen.ActiveForm.ActiveControl is TDBRadioGroup) then
    begin
      cColorAnt := TDBRadioGroup(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TDBRadioGroup(screen.ActiveForm.ActiveControl).Font.Color;
      TDBRadioGroup(screen.ActiveForm.ActiveControl).Color := $00B00000;
      TDBRadioGroup(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt9 := TDBRadioGroup(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt9 := nil;

    if (screen.ActiveForm.ActiveControl is TRadioButton) then
    begin
      cColorAnt := TRadioButton(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TRadioButton(screen.ActiveForm.ActiveControl).Font.Color;
      TRadioButton(screen.ActiveForm.ActiveControl).Color := $00B00000;
      TRadioButton(screen.ActiveForm.ActiveControl).Font.Color := clWhite;
      CompoAnt10 := TRadioButton(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt10 := nil;

    if (screen.ActiveForm.ActiveControl is TCheckBox) then
    begin
      cColorAnt := TCheckBox(screen.ActiveForm.ActiveControl).color;
      cFontAnt  := TCheckBox(screen.ActiveForm.ActiveControl).Font.Color;
      TCheckBox(screen.ActiveForm.ActiveControl).color      := $00B00000;
      TCheckBox(screen.ActiveForm.ActiveControl).Font.Color := clWhite;
      CompoAnt11:= TCheckBox(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt11 := nil;

    if (screen.ActiveForm.ActiveControl is TDBNumEdit) then
    begin
      cColorAnt  := TDBNumEdit(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TDBNumEdit(screen.ActiveForm.ActiveControl).Font.Color;
      TDBNumEdit(screen.ActiveForm.ActiveControl).color      := $00D0FDFA;
      TDBNumEdit(screen.ActiveForm.ActiveControl).Font.Color := clBlack;
      CompoAnt12 := TDBNumEdit(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt12 := nil;
    if (screen.ActiveForm.ActiveControl is TComboBox) then
    begin
      cColorAnt  := TComboBox(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TComboBox(screen.ActiveForm.ActiveControl).Font.Color;
      TComboBox(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TComboBox(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt13 := TComboBox(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt13 := nil;

    if (screen.ActiveForm.ActiveControl is TMemo) then
    begin
      cColorAnt  := TMemo(screen.ActiveForm.ActiveControl).color;
      cFontAnt   := TMemo(screen.ActiveForm.ActiveControl).Font.Color;
      TMemo(screen.ActiveForm.ActiveControl).color      := vCorEdicao;
      TMemo(screen.ActiveForm.ActiveControl).Font.Color := vCorFonteEdicao;
      CompoAnt14 := TMemo(screen.ActiveForm.ActiveControl);
    end
    else
      CompoAnt14 := nil;
  Except
  End;
{$ENDIF}
end;

Procedure TDm.LimpaAcessoPorEstacao;
Begin
  { Remove os dados de acesso da estacao }
  If Not dm.DbBGM.Connected Then Exit; // Qdo se responde N à execução automática de scripts, o DbBGM é desconectado.
  With dm.qrAuxiliar Do
  Begin
    If dm.DbBGM.InTransaction Then dm.DbBGM.Rollback;
    dm.DbBGM.StartTransaction;
    Close;
    Sql.Clear;
//    Sql.Add('Delete CTR_AcessoPorEstacao Where Aplicacao = :P0 And Estacao = :P1 And UsuarioWin = :P2');
    Sql.Add('Delete ' + cTabelaDeLicencas + ' Where Aplicacao = :P0 And Estacao = :P1 And Upper(UsuarioWin) = :P2');
    Params[0].AsString := Application.Title;
    Params[1].AsString := TrazNomeDoComputador;
    Params[2].AsString := AnsiUpperCase(WinLogin);
    Try
      ExecSql;
    Except;
//      MensagemDlg('Falhou na limpeza do controle de acesso', mtErro, mbOk);
    End;
    Close;
    If Trim(vcUsuario) <> '' then
      GravaLog(vcSistema, vcUsuario,
             Now, 'Fechou o modulo: ' + WinLogin + '/' + TrazNomeDoComputador + '. (' + FrmSetupRD.Edit1.Text + ')')
    else
      GravaLog(vcSistema, 'GLOBUS', Now, 'Fechou o modulo: ' + WinLogin + '/' + TrazNomeDoComputador + '. (' + FrmSetupRD.Edit1.Text + ')');
    dm.DbBGM.Commit;
  End;
End;

Procedure TDm.ValidaNomeDoEXE;
Var
  a : Integer;
  vAchou : Boolean;
  vNomeDoExe : String;
Begin
  // Não valida para os módulos light
  If Right(UpperCase(ExtractFileName(Application.ExeName)),9) = 'LIGHT.EXE' Then Exit;
  vAchou     := False;
  for a := 1 To Length(cSiglasDosSistemas) Do
  begin
    if cSiglasDosSistemas[a] = vcSistema Then
    begin
      vAchou := True;
      vNomeDoExe := cNomesDosExecutaveis[a];
      Break;
    end;
  end;
  if Not vAchou Then
  begin
    ShowMessage('Falta o nome deste sistema em "ValidaNomeDoEXE". Corrigir.');
    Exit;
  end;
  // Não valida para o segurança, que pode estar utilizando um nome "falso".
  If vNomeDoExe = 'SEGURANCA' Then Exit;
  if UpperCase(ExtractFileName(Application.ExeName)) <> vNomeDoExe + '.EXE' Then
    ShowMessage('Atenção: Está sendo executado o arquivo "'
    + UpperCase(ExtractFileName(Application.ExeName))
    + '" que difere do original "' + vNomeDoExe + '.EXE". Verificar.');
end;

Procedure TDm.VerificaCriaSistemas;
Var
  a : Integer;
Begin
  For a := 1 To Length(cSiglasDosSistemas) Do
  Begin
    With qrAuxiliar Do
    Begin
      Close;
      Sql.Clear;
      Sql.Add(' Select Sistema From CTR_CadastroSistemas Where Sistema = :P0 ');
      Params[0].AsString := cSiglasDosSistemas[a];
      Open;
      { Se não existe o sistema, cria-o a partir da tabela padrão }
      If FieldByName('Sistema').AsString <> cSiglasDosSistemas[a] Then
      Begin
        Close;
        Sql.Clear;
        Sql.Add(' Insert Into CTR_CadastroSistemas (Sistema, NomeDoSistema ) Values (:P0, :P1)');
        Params[0].AsString := cSiglasDosSistemas[a];
        Params[1].AsString := cNomesDosSistemas[a];
        ExecSql;
      End;
      Close;
    End;
  End;
End;

Function TDm.DeletaArquivo(pArquivo: String) : String;
Var
  vFileAttr : Integer;
begin
  If Not FileExists(pArquivo) Then
  Begin
    Result := 'O arquivo ' + pArquivo + ' não existe.';
  End
  Else
  Begin
    { Verifica se o arquivo está readonly, então elimina o atributo para então deletá-lo }
    Try
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS OFF}
  {$ENDIF}
      vFileAttr := FileGetAttr(pArquivo);
      If (vFileAttr >= 0) And ((vFileAttr And $00000001{faReadOnly}) <> 0) Then
          FileSetAttr(pArquivo, vFileAttr And Not $00000001{faReadOnly});
  {$IFDEF VER150} // Delphi 7
  {$WARNINGS ON}
  {$ENDIF}
      DeleteFile(pArquivo);
      Result := '';
    Except;
      Result := 'Falhou ao excluir o arquivo ' + pArquivo + '.';
    End; // Try
  End;
end;

Procedure TDm.VerificaCriaTabelaDeLicencas;
Var
  vQryAux : TQuery;
Begin
  vQryAux := TQuery.Create(Application);
  With vQryAux Do
  Begin
    { Faz conexão }
    DatabaseName := cDatabaseName;

    { Se não existir, cria a tabela de controle de acesso }
    Close;
    Sql.Clear;
    Sql.Add('Select Count(*) From ' + cTabelaDeLicencas);
    Try
      Open;
    Except
      Begin
        Close;
        Sql.Clear;
        If vcBancoDeDados = 'ORACLE' then
          Sql.Add(' Create Table ' + cTabelaDeLicencas + ' (Aplicacao VarChar2(40), Estacao VarChar2(40)) Tablespace Globus_Table ')
        else
          Sql.Add(' Create Table ' + cTabelaDeLicencas + ' (Aplicacao VarChar(40), Estacao VarChar(40)) ');
        Try
          ExecSql;
        Except;
          MensagemDlg('Erro ao criar a tabela ' + cTabelaDeLicencas, mtErro, mbOk);
        End;
      End;
    End;

    { Valida a coluna DataHora == Upt_X.Sql }
    Close;
    SQL.Clear;
    SQL.Add( 'Select DataHora From ' + cTabelaDeLicencas );
    Try
      Open;
    Except On E:EDBEngineError Do
      Begin
        Close;
        SQL.Clear;
        If vcBancoDeDados = 'ORACLE' Then
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add (DataHora Date)')
        else
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add DataHora TimeStamp');
        Try
          ExecSQL;
        Except On E:EDBEngineError Do
          Begin
            { Caso ocorra erro, exibe a mensagem de erro no arquivo }
            MensagemDLG('Erro: ' + IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message, mtInformacao, mbOk );
          End; // Begin
        End; // Try
        Close;
      End; // Begin
    End; // Try
    Close;
    SQL.Clear;
    SQL.Add( 'Select UsuarioWin From ' + cTabelaDeLicencas );
    Try
      Open;
    Except On E:EDBEngineError Do
      Begin
        Close;
        SQL.Clear;
        If vcBancoDeDados = 'ORACLE' Then
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add (UsuarioWin VarChar2(30))')
        else
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add UsuarioWin VarChar(30)');
        Try
          ExecSQL;
        Except On E:EDBEngineError Do
        Begin
          { Caso ocorra erro, exibe a mensagem de erro no arquivo }
          MensagemDLG('Erro: ' + IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message, mtInformacao, mbOk );
        End; // Begin
        End; // Try
        Close;
      End; // Begin
    End; // Try

    Close;
    SQL.Clear;
    SQL.Add( 'Select UsuarioGlobus From ' + cTabelaDeLicencas );
    Try
      Open;
    Except On E:EDBEngineError Do
      Begin
        Close;
        SQL.Clear;
        If vcBancoDeDados = 'ORACLE' Then
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add (UsuarioGlobus VarChar2(15))')
        else
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add UsuarioGlobus VarChar(15)');
        Try
          ExecSQL;
        Except On E:EDBEngineError Do
        Begin
          { Caso ocorra erro, exibe a mensagem de erro no arquivo }
          MensagemDLG('Erro: ' + IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message, mtInformacao, mbOk );
        End; // Begin
        End; // Try
        Close;
      End; // Begin
    End; // Try
    Close;
    SQL.Clear;
    SQL.Add( 'Select Sistema From ' + cTabelaDeLicencas );
    Try
      Open;
    Except On E:EDBEngineError Do
      Begin
        Close;
        SQL.Clear;
        If vcBancoDeDados = 'ORACLE' Then
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add (Sistema VarChar2(3))')
        else
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add Sistema VarChar(3)');
        Try
          ExecSQL;
        Except On E:EDBEngineError Do
        Begin
          { Caso ocorra erro, exibe a mensagem de erro no arquivo }
          MensagemDLG('Erro: ' + IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message, mtInformacao, mbOk );
        End; // Begin
        End; // Try
        Close;
      End; // Begin
    End; // Try
    Close;
    SQL.Clear;
    SQL.Add( 'Select Valida_Sessao From ' + cTabelaDeLicencas );
    Try
      Open;
    Except On E:EDBEngineError Do
      Begin
        Close;
        SQL.Clear;
        If vcBancoDeDados = 'ORACLE' Then
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add (Valida_Sessao Date)')
        else
          SQL.Add( 'Alter Table ' + cTabelaDeLicencas + ' Add Valida_Sessao TimeStamp');
        Try
          ExecSQL;
        Except On E:EDBEngineError Do
        Begin
          { Caso ocorra erro, exibe a mensagem de erro no arquivo }
          MensagemDLG('Erro: ' + IntToStr(E.Errors[1].ErrorCode) + ' - ' + E.Errors[1].Message, mtInformacao, mbOk );
        End; // Begin
        End; // Try
        Close;
      End; // Begin
    End; // Try
    Free;
  End; // With
End;

Function TDm.LicencaValida : Boolean;
Var
  vQtdeTotal, vQtdeModulo, vSomaQtdeAcesso : Integer;
  vQuery : TQuery;
Begin
  If Pos(vcSistema, 'SEG_CTR_GRP') > 0 Then
  Begin
    Result := True;
    Exit;
  End;
  vQuery := TQuery.Create(Application);
  vQuery.DatabaseName := cDatabaseName;
  { Faz teste para saber se esta conexao é valida. }
  With vQuery Do
  begin
    { Verifica a qtd de acessos globais }
    Close;
    Sql.Clear;
    Sql.Add('Select CheckSumActot, QtdeTotal From Ctr_AcessoTotal');
    Open;
    If Not IsEmpty Then
    begin
      { Testa o checkSum, se não estiver correto aborta o carregamento do sistema }
      If FieldByName('CheckSumActot').asString <> Encripta( '1' + FieldByName('QtdeTotal').asString, 10 ) Then
      begin
        MensagemDlg('Tabela de controle de acesso (G) violada. Não será possível carregar o sistema.', mtInformacao, mbOk );
        Result := False;
        vQuery.Free;
        Exit;
      end;
    end;
    vQtdeTotal := FieldByName('QtdeTotal').asInteger;

    Close;
    Sql.Clear;
    Sql.Add('SELECT CheckSumAcesso, Sistema, QtdeAcesso FROM CTR_ACESSO WHERE SISTEMA = :PSISTEMA');
    ParamByName('PSISTEMA').asString := vcSistema;
    Open;
    If (Not IsEmpty) And (FieldByName('CheckSumAcesso').asString <> Encripta( FieldByName('Sistema').asString + FieldByName('QtdeAcesso').asString, 10 )) Then
    begin
      MensagemDlg('Tabela de controle de acesso (M) violada. Não será possível carregar o sistema', mtErro, mbOk );
      Result := False;
      vQuery.Free;
      Exit;
    end;
    vQtdeModulo := FieldByName('QtdeAcesso').asInteger;

    {Quando o módulo possui quantidade informada, não considera da qtd global}
    If vQtdeModulo > 0 Then
    Begin
      Close;
      Sql.Clear;
      Sql.Add('Select Count(*) Qtd From ' + cTabelaDeLicencas + ' Where Sistema = :pSistema');
      ParamByName('pSistema').asString := vcSistema;
      Open;
      If FieldByName('Qtd').AsInteger >= vQtdeModulo Then
      Begin
        GravaLog(vcSistema, 'GLOBUS', Now, 'Excedeu a quantidade de licencas para este modulo.');
        MensagemDlg('Excedeu a quantidade de licenças para este módulo. (Tente novamente caso tenha ocorrido algum fechamento anormal).', mtErro, mbOk );
        Result := False;
        vQuery.Free;
        Exit;
      End;
      Result := True; // Acesso autorizado
      vQuery.Free;
      Exit;
    End;

    {Quando o módulo não possui quantidade informada, considera da global. Os módulos que trabalham
     com quantidades individuais têm que ser subtraídos da quantidade global}
    If vQtdeTotal > 0 Then
    Begin
      Close;
      Sql.Clear;
      { Calcula quantas licenças são tratadas por módulo }
      Sql.Add('Select Sum(QtdeAcesso) Qtd From Ctr_Acesso');
      //GetSql(vQuery);
      Open;
      vSomaQtdeAcesso := FieldByName('Qtd').AsInteger;
      { Calcula quantas licenças globais estão em uso, desconsiderando as dos módulos individuais }
      Close;
      Sql.Clear;
      Sql.Add('Select Distinct Estacao || UsuarioWin From ' + cTabelaDeLicencas);
      Sql.Add('Where Estacao || UsuarioWin <> :P0 And Sistema Not In (Select Sistema From CTR_Acesso Where QtdeAcesso > 0)');
      Params[0].AsString := TrazNomeDoComputador + AnsiUpperCase(WinLogin);
      //GetSql(vQuery);
      Open;
      If ((IsEmpty And (vQtdeTotal - vSomaQtdeAcesso <= 0))) Or
         ((Not IsEmpty And (vQtdeTotal - vSomaQtdeAcesso - RecordCount <= 0))) Then
      Begin
        GravaLog(vcSistema, 'GLOBUS', Now, 'Excedeu a quantidade de licencas.');
        MensagemDlg('Excedeu a quantidade de licenças. (Tente novamente caso tenha ocorrido algum fechamento anormal).', mtErro, mbOk );
        Result := False;
        vQuery.Free;
        Exit;
      End;
      Result := True; // Acesso autorizado
      vQuery.Free;
      Exit;
    End;

    { Quando o módulo não possui quantidade informada e não existe acesso global }
    If (vQtdeModulo = 0) And (vQtdeTotal = 0) Then
    Begin
      GravaLog(vcSistema, 'GLOBUS', Now, 'Modulo nao autorizado (M/G).');
      MensagemDlg('Módulo não autorizado (M/G).', mtErro, mbOk);
      Result := False;
      vQuery.Free;
      Exit;
    End;

    Close;
    Result := False; // Acesso não autorizado.
    vQuery.Free;
  End;
End;

function Tdm.criptografouSenhaEmail: string;
var
  i: integer;
  qrSQL1, qrSQL2: TQuery;
begin

  qrSQL1:= TQuery.create(Application);
  qrSQL2:= TQuery.create(Application);

  qrSQL1.DatabaseName:= 'dbBgm';
  qrSQL2.DatabaseName:= 'dbBgm';

  result:= '';

  {********************************************************************************
   * 13/11/2006 - LUIS: criptografa a senha do email informada no cadastro de     *
   *                    usuário                                                   *
   ********************************************************************************}

  // verifica se já não foi criptografada
  if  LeArqIni('ATUALIZACAO', 'OPRCRIP', 'CTR')= '' then
  begin

    with qrSQL1 do
    begin
      close;
      sql.clear;
      sql.add(' UPDATE CTR_CADASTRODEUSUARIOS SET SENHASNAP=:PSENHA ');
      sql.add(' WHERE USUARIO=:PUSUARIO ');
    end;// with qrSQL1 do

    with qrSQL2 do
    begin
      close;
      sql.clear;
      sql.add(' SELECT                    ');
      sql.add('  A.USUARIO, A.SENHASNAP   ');
      sql.add('FROM                       ');
      sql.add('  CTR_CADASTRODEUSUARIOS A ');
      sql.add('WHERE                      ');
      sql.add('  A.SENHASNAP IS NOT NULL  ');
      open;
      i :=1;
      if not isempty then
      begin

        while not eof do
        begin
          qrSQL1.parambyname('PUSUARIO').asString:= fieldbyname('USUARIO').asString;
          qrSQL1.parambyname('PSENHA').asString:=   Criptografa(fieldbyname('SENHASNAP').asString);
          try
            getSQL(qrSQL1);
            qrSQL1.execsql;
            i:= 1;
          except
            i:= -1;
          end;
          next;
        end;// while not eof do

        if i=1 then
        begin
          GravaArqIni('ATUALIZACAO','OPRCRIP' , formatDateTime('dd/mm/yyyy', now), 'CTR');
          result:= '-> CTR CRIPTO OK';
        end;

      end;// if not isempty then

      close;
    end;// with qrSQL2 do

  end;// if  LeArqIni('ATUALIZACAO', 'OPRCRIP', 'CTR') <> '' then

  qrSQL1.free;
  qrSQL2.free;

end;


procedure Tdm.AtualizaProgress(pProgressBar : TGauge; pStatus : TLabel; pPos,pTotal: Integer; pString: String);
begin
  If pProgressBar.MaxValue <> pTotal then
    pProgressBar.MaxValue := pTotal;
  If pStatus.Caption <> pString Then
    pStatus.Caption := pString;
  pProgressBar.Progress := pPos;

  If pString = '100 %' then
    pProgressBar.ForeColor := clGray;
  Application.ProcessMessages;
end;

procedure Tdm.GravaLogDasExcecoes(Sender: TObject; E: Exception);
var
  vNomeComp,
  vNomeArq : String ;
  vArquivo : TextFile ;
begin
  vNomeArq := ChangeFileExt(Application.Exename, '.Err') ;
  AssignFile(vArquivo, vNomeArq) ;

  Try
    vNomeComp := TComponent(Sender).Name ;
  Except
    vNomeComp := '' ;
  End ; // Try - Except

  If FileExists(vNomeArq) Then
    Append(vArquivo)
  Else // If FileExists(NomeArq) Then
  Begin
    ReWrite(vArquivo);
    WriteLn(vArquivo,'   Data      Hora   Usuários        Tela                                     Componenete          Erro');
    WriteLn(vArquivo,'---------- -------- --------------- ---------------------------------------- -------------------- ------------------------------------------------------------') ;
    //                99/99/9999 99:99:99 123456789012345 1234567890123456789012345678901234567890 12345678901234567890 123456789012345678901234567890123456789012345678901234567890
    //                12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
    //                         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5
  End ; // Else // If FileExists(NomeArq) Then

  Try
    WriteLn(vArquivo, FormatDateTime('DD/MM/YYYY HH:MM:NN', now)
                +' '+ Pad(vcUsuario,15)
                +' '+ Pad(Screen.ActiveForm.Name,40)
                +' '+ Pad(vNomeComp,20)
                +' '+ StringReplace(E.Message
                                   ,Chr(13) + Chr(10)
                                   ,Chr(13) + Chr(10) + Space(98)
                                   ,[rfReplaceAll,rfIgnoreCase])) ;
    Application.ShowException(E) ;
  Finally
  End ; // Try - Finally
  CloseFile(vArquivo) ;
end;


end.



