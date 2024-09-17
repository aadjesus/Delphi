unit TelaPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, TabNotBk, Gradient, StdCtrls, Buttons, ComCtrls, ExtCtrls, Grids,
  DBGrids, FileCtrl, jpeg, DB, RxMemDS, NumEdit, DBTables, IdMessageClient,
  IdSMTP, IdMessage, ImgList, Menus, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFTP, ZipMstr, IdFTPCommon, IdFTPList,
  SakMsg, SakSMTP, DBCtrls, RxGIF,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

Type
  TUltimaAtu = Record
    Achou    : Boolean ;
    Data     : TDateTime ;
    Tipo     : String ;
    DescTipo : String ;
    Sistemas : String ;
    Usuario  : String ;
  End ; // TUltimaAtu = Record

  TInfoArq = Record
    Sigla : String ;
    Pasta : String ;
    Exe   : String ;
    Achou : Boolean ;
  End ; // TInfoArq : Record

type
  TFrmTelaPrincipal = class(TForm)
    PnlTitulos: TPanel;
    PnlAtualizacao: TPanel;
    PnlBotoes: TPanel;
    PageControl1: TPageControl;
    TabSInfoParaAtu: TTabSheet;
    TabSTipo: TTabSheet;
    TabSDestUsus: TTabSheet;
    TabSSistemas: TTabSheet;
    BitBtnCancelar: TBitBtn;
    BitBtnAvaAtu: TBitBtn;
    BitBtnVoltar: TBitBtn;
    PnlInfoParaAtu: TPanel;
    PnlTipo: TPanel;
    PnlDestUsus: TPanel;
    PnlSistemas: TPanel;
    TabSInfoDaAtu: TTabSheet;
    PnlInfoDaAtu: TPanel;
    TabSFim: TTabSheet;
    TabSBarras: TTabSheet;
    PnlBarras: TPanel;
    PnlBarra1: TPanel;
    PBarra1: TProgressBar;
    Panel39: TPanel;
    PnlTituloBar1: TPanel;
    PnlBarra2: TPanel;
    PnlTituloBar2: TPanel;
    PBarra2: TProgressBar;
    Panel41: TPanel;
    PnlBarra3: TPanel;
    PnlTituloBar3: TPanel;
    PBarra3: TProgressBar;
    Panel44: TPanel;
    Panel20: TPanel;
    TabSheet1: TTabSheet;
    TabSParametros: TTabSheet;
    TabSUsuConect: TTabSheet;
    PnlUsuConect: TPanel;
    Panel40: TPanel;
    DBGridUsuarios: TDBGrid;
    Panel42: TPanel;
    BitBFinalizar: TBitBtn;
    BitBContinuar: TBitBtn;
    Panel36: TPanel;
    ZipMaster1: TZipMaster;
    IdFTP1: TIdFTP;
    Timer2: TTimer;
    IListSistemas: TImageList;
    DSUsuarios: TDataSource;
    dbBgm: TDatabase;
    QryPesquisa: TQuery;
    DSSistemas: TDataSource;
    PnlInfoAtu: TPanel;
    GradientInfo: TGradient;
    LblInfoAtualizacao: TLabel;
    Label28: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    LblSepText1: TLabel;
    PnlParan: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Label12: TLabel;
    GBoxFTP: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EdtHostFTP: TEdit;
    EdtUsuFTP: TEdit;
    EdtSenFTP: TEdit;
    GBoxConta: TGroupBox;
    Label23: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    EdtEMailOrigem: TEdit;
    EdtServSMTP: TEdit;
    NEdtPorta: TNumEdit;
    EdtSenhaEMail: TEdit;
    EdtEMailDest: TEdit;
    EdtIgSiglas: TEdit;
    Panel2: TPanel;
    BitBConfirmaFTP: TBitBtn;
    MemoInfDaAtu: TMemo;
    PnlFim: TPanel;
    PnlInfoFim: TPanel;
    GradientInfoFim: TGradient;
    Panel11: TPanel;
    Panel12: TPanel;
    PnlCompleta: TPanel;
    Image2: TImage;
    Label4: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel16: TPanel;
    PnlParcial: TPanel;
    Image3: TImage;
    Label6: TLabel;
    Panel17: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PnlTotais: TPanel;
    Panel5: TPanel;
    LblQtdeArq: TLabel;
    Label13: TLabel;
    Panel6: TPanel;
    LblTotTaman: TLabel;
    Label14: TLabel;
    Panel15: TPanel;
    LblTamanDispo: TLabel;
    Label15: TLabel;
    SBarMsg: TStatusBar;
    Panel3: TPanel;
    GBoxGlobus: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EdtUsuGlobus: TEdit;
    BitBConfirmaGlobus: TBitBtn;
    EdtSenhaGlobus: TEdit;
    GroupBox1: TGroupBox;
    DriveComboBox: TDriveComboBox;
    Panel1: TPanel;
    Panel10: TPanel;
    Label24: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel4: TPanel;
    ImageAva: TImage;
    ImageAtu: TImage;
    BitCancelarParam: TBitBtn;
    PMenuGeral: TPopupMenu;
    IMenuMarcaDesmarca: TMenuItem;
    IMenuMarcaTodos: TMenuItem;
    IMenuDesMarcarTodos: TMenuItem;
    IMenuLegenda: TMenuItem;
    PnlLegenda: TPanel;
    Panel45: TPanel;
    Panel35: TPanel;
    Panel49: TPanel;
    Image6: TImage;
    Label5: TLabel;
    Panel48: TPanel;
    Image5: TImage;
    Label21: TLabel;
    Panel47: TPanel;
    Image7: TImage;
    Label22: TLabel;
    Panel46: TPanel;
    Image8: TImage;
    Label25: TLabel;
    Panel43: TPanel;
    Image9: TImage;
    ButLogAtu: TButton;
    Panel7: TPanel;
    Image10: TImage;
    PnlImgGlobus: TPanel;
    Panel28: TPanel;
    Image4: TImage;
    BitBtnGeraINI: TBitBtn;
    Panel22: TPanel;
    Gradient1: TGradient;
    LblCabTitulo: TLabel;
    LblInfoTitulo: TLabel;
    Label20: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label34: TLabel;
    SakMsg1: TSakMsg;
    SakSMTP1: TSakSMTP;
    DSOutros: TDataSource;
    MDOutros: TRxMemoryData;
    Label30: TLabel;
    EdtDirFTP: TEdit;
    MDOutrosSIGLA: TStringField;
    MDOutrosNOMEDOSISTEMA: TStringField;
    MDOutrosDESCRICAODOSISTEMA: TStringField;
    MDOutrosPASTA: TStringField;
    MDOutrosNOMEEXE: TStringField;
    MDOutrosNOMEARQNOFTP: TStringField;
    MDOutrosATUALIZA: TStringField;
    MDOutrosTAMANHOEXE: TFloatField;
    MDOutrosDOWJAEXISTE: TStringField;
    MDOutrosARQZIP: TStringField;
    MDOutrosCONTINUAANT: TStringField;
    MDOutrosPODEDESMARC: TStringField;
    TabSOutros: TTabSheet;
    PnlOutros: TPanel;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel33: TPanel;
    DBGridOutros: TDBGrid;
    BitBtn2: TBitBtn;
    SButOutros: TSpeedButton;
    DBGridSistemas: TDBGrid;
    MDOutrosDATAARQ: TDateTimeField;
    IMenoNovImp: TMenuItem;
    MDSistemas: TRxMemoryData;
    MDNovImp: TRxMemoryData;
    TabSNovImp: TTabSheet;
    PnlNovImp: TPanel;
    PnlTituloNovImp: TPanel;
    Panel37: TPanel;
    DSNovImp: TDataSource;
    ImageGlobus: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Panel52: TPanel;
    Panel53: TPanel;
    Panel54: TPanel;
    Panel55: TPanel;
    Panel56: TPanel;
    PnlSaiNovImp: TPanel;
    Label29: TLabel;
    Panel58: TPanel;
    Panel79: TPanel;
    Panel80: TPanel;
    Panel81: TPanel;
    Panel82: TPanel;
    Panel83: TPanel;
    Panel84: TPanel;
    Label41: TLabel;
    Panel85: TPanel;
    DBGridNovImp: TDBGrid;
    MDNovImpTOPICO: TStringField;
    MDNovImpASSUNTO: TStringField;
    MDNovImpDATA: TDateField;
    DBMemoNovImp: TDBMemo;
    Label26: TLabel;
    MDNovImpSIGLA: TStringField;
    Panel38: TPanel;
    Panel34: TPanel;
    EdtArqNovid: TEdit;
    Label35: TLabel;
    Label39: TLabel;
    EdtArqImple: TEdit;
    Panel23: TPanel;
    Panel50: TPanel;
    Panel51: TPanel;
    Panel57: TPanel;
    Panel59: TPanel;
    PnlLocModulo: TPanel;
    Label40: TLabel;
    Panel60: TPanel;
    LblLocModulo: TLabel;
    Panel61: TPanel;
    MDNovImpLOCMODULO: TStringField;
    MDNovImpTIPO: TStringField;
    Panel62: TPanel;
    DBNavigator1: TDBNavigator;
    PnlEnvEmaiUsu: TPanel;
    CBoxEnvEmaiUsu: TCheckBox;
    GroupBox2: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    EdtEMailLog: TEdit;
    EdtNFantasia: TEdit;
    procedure PnlCompletaClick(Sender: TObject);
    procedure PnlParcialClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnAvaAtuClick(Sender: TObject);
    procedure BitBtnVoltarClick(Sender: TObject);
    procedure BitBConfirmaGlobusClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DriveComboBoxChange(Sender: TObject);
    procedure DBGridSistemasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBConfirmaFTPClick(Sender: TObject);
    procedure BitCancelarParamClick(Sender: TObject);
    procedure BitBtnGeraINIClick(Sender: TObject);
    procedure DBGridSistemasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IMenuMarcaDesmarcaClick(Sender: TObject);
    procedure PMenuGeralPopup(Sender: TObject);
    procedure IMenuLegendaClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
    procedure IdFTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure ZipMaster1Progress(Sender: TObject; ProgrType: ProgressType;
      Filename: String; FileSize: Integer);
    procedure MDSistemasAfterOpen(DataSet: TDataSet);
    procedure PnlLegendaExit(Sender: TObject);
    procedure ButLogAtuClick(Sender: TObject);
    procedure SakSMTP1Connect(Sender: TObject);
    procedure SakSMTP1SendProgress(Sender: TObject; Percent: Word);
    procedure SButOutrosClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBContinuarClick(Sender: TObject);
    procedure IMenoNovImpClick(Sender: TObject);
    procedure PnlSaiNovImpClick(Sender: TObject);
    procedure MDNovImpFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure MDSistemasAfterScroll(DataSet: TDataSet);
    procedure MDNovImpAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    vUsuarioManagerComSenhaUm,
    vConectoGlobus,
    vConectoFTP,
    vContinuaAnt,
    vArqIniOk,
    vSaiDaTelaIni  : Boolean ;
    vNPanel        : Integer ;
    vBytesTransf   : LongWord ;
    STime          : TDateTime;
    vUltimaAtu     : TUltimaAtu ;
    vAWorkCountAnt : Integer ;
    STimeTot,
    vDataHoraAtu,
    TotalTimeTot   : TDateTime ;
    HTot,
    MTot,
    SecTot,
    MSTot          : Word ;
    vEmailUsu,
    vSenhaUsu,
    vPortaUsu,
    vServidorUsu,
    vTpAtualizacao,
    vSisAtu,
    vDriveDir,
    vDriveTemp     : String ;
    Procedure MudaPanel(pPanel: TPanel);
    Procedure HabilitaBotoes ;
    Function  Encripta(sCampo : String; iQtdChar : Byte ; Posicional : Boolean = False ) : String;
    function  IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant ;
    Procedure Totais ;
    Procedure GravaLog(pTextoLog : String) ;
    Function ConectaUsuarioAoFTP(pPassive : Boolean = True) : Boolean ;
    Procedure MostraMsg(pMsg : String) ;
    Function LocalisaInfoArq(pArquivo : String) : TInfoArq ;
    Function WinLogin: String ;
    Function TrazNomeDoComputador: String ;
  public
    { Public declarations }
  end;

var
  FrmTelaPrincipal: TFrmTelaPrincipal;

implementation

Uses ShellApi, IniFiles, Math, ZLib;

Var
  AverageSpeed: Double = 0;
  AverageSpeedTot: Double = 0;
  {$INCLUDE \Globus\Utilitarios\Bgm_StrZero.txt}
  {$INCLUDE \Globus\Utilitarios\Bgm_CriptoDescripto.txt}

{$R *.dfm}
{$R DLLsAtu.RES}

procedure TFrmTelaPrincipal.MudaPanel(pPanel: TPanel);
Var
  vAvanca : Boolean ;
begin
  If pPanel.Parent = PnlAtualizacao Then
    pPanel.Parent := TabSheet1
  Else // If PnlRecebePanel.Visible Then
    pPanel.Parent := PnlAtualizacao ;

  BitBtnAvaAtu.Visible := (PnlFim.Parent         <> PnlAtualizacao) ;
  PnlTitulos.Visible   := (PnlInfoParaAtu.Parent <> PnlAtualizacao) And BitBtnAvaAtu.Visible ;
  BitBtnVoltar.Visible := PnlTitulos.Visible And (BitBtnAvaAtu.Visible) ;

  If PnlInfoParaAtu.Parent = PnlAtualizacao Then
  Begin
    GradientInfo.Height := PnlInfoAtu.Height ;
    GradientInfo.Width  := PnlInfoAtu.Width ;
    PnlImgGlobus.Parent := PnlInfoParaAtu ;
    BitBtnAvaAtu.SetFocus
  End Else
  If PnlDestUsus.Parent = PnlAtualizacao Then
  Begin
    LblCabTitulo.Caption  := 'Conectando ao sistema'  ;
    LblInfoTitulo.Caption := '' ;
    DriveComboBox.SetFocus ;
  End Else
  If PnlTipo.Parent = PnlAtualizacao Then
  Begin
    LblCabTitulo.Caption  := 'Tipo de atualização' ;
    LblInfoTitulo.Caption := 'Selecione o tipo de atualização.' ;

    PnlCompleta.SetFocus ;
  End Else
  If PnlSistemas.Parent = PnlAtualizacao Then
  Begin
    LblCabTitulo.Caption  := 'Módulos disponíveis para atualização' ;
    LblInfoTitulo.Caption := IIf(vTpAtualizacao='C','','Selecione os módulos que serão atualizados.') ;

    MDOutros.First ;
    While Not MDOutros.Eof do
    Begin
      If (Not MDSistemas.Locate('NOMEARQNOFTP',MDOutros.FieldByName('NOMEARQNOFTP').AsString,[loCaseInsensitive])) And
         (Trim(MDOutros.FieldByName('NOMEDOSISTEMA').AsString) <> '') And
         (Trim(MDOutros.FieldByName('PASTA'        ).AsString) <> '') Then
         MDSistemas.LoadFromDataSet(MDOutros,1,lmAppend) ;
      MDOutros.Next ;
    End ; // While Not MDOutros.Eof do

    If (vTpAtualizacao = 'P') And MDSistemas.Locate('SIGLA','SQL',[loCaseInsensitive]) Then
      MDSistemas.Delete ;

    MDSistemas.SortOnFields('ATUALIZA;SIGLA') ;
    MDSistemas.First ;

    Totais ;
    MDSistemas.First ;

    BitBtnAvaAtu.SetFocus ;
  End Else
  If PnlInfoDaAtu.Parent = PnlAtualizacao Then
  Begin
    LblCabTitulo.Caption  := 'Pronto para atualização' ;
    LblInfoTitulo.Caption := 'O sistema está pronto para atualizar os módulos ' + IIf(vTpAtualizacao='C','disponíveis e o banco de dados','selecionados') +'.';

    BitBtnAvaAtu.Caption  := 'Atualizar' ;
    BitBtnAvaAtu.Glyph    := ImageAtu.Picture.Bitmap ;

    MemoinfDaAtu.Clear ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('') ;

    If vUltimaAtu.Achou Then
    Begin
      MemoInfDaAtu.Lines.Add('     Útima atualização') ;
      MemoInfDaAtu.Lines.Add('     Usuário   : ' + vUltimaAtu.Usuario ) ;
      MemoInfDaAtu.Lines.Add('     Data      : ' + FormatDateTime('dd/mm/yyyy " as " hh:mm', vUltimaAtu.Data)) ;
      MemoInfDaAtu.Lines.Add('     Tipo      : ' + vUltimaAtu.DescTipo) ;
      MemoInfDaAtu.Lines.Add('     Sistemas  : ' + Copy(vUltimaAtu.Sistemas,1,56)) ;
    If Copy(vUltimaAtu.Sistemas,57,56) <> '' Then
      MemoInfDaAtu.Lines.Add('                 ' + Copy(vUltimaAtu.Sistemas,57,56)) ;
    If Copy(vUltimaAtu.Sistemas,109,56) <> '' Then
      MemoInfDaAtu.Lines.Add('                 ' + Copy(vUltimaAtu.Sistemas,109,56)) ;
    End ; // If vUltimaAtu.Achou Then
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('     Destino do(s) arquivo(s) de download(s)') ;
    MemoInfDaAtu.Lines.Add('     ' + DriveComboBox.Drive + ':\Globus\Download') ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('     Drive Globus') ;
    MemoInfDaAtu.Lines.Add('     ' + vDriveDir + '\' ) ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('     Atualização') ;
    MemoInfDaAtu.Lines.Add('     Usuário   : ' + EdtUsuGlobus.Text ) ;
    MemoInfDaAtu.Lines.Add('     Data      : ' + FormatDateTime('dd/mm/yyyy " as " hh:mm', Now )) ;
    MemoInfDaAtu.Lines.Add('     Tipo      : ' + IIf(vTpAtualizacao='C','Completa','Parcial')) ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('') ;
    MemoInfDaAtu.Lines.Add('     Módulos que serão atualizados') ;
    If vTpAtualizacao = 'C' Then
      MemoInfDaAtu.Lines.Add('     Todos')
    Else // If vTpAtualizacao = 'C' Then
    Begin
      MDSistemas.DisableControls ;
      MDSistemas.First ;
      While Not MDSistemas.Eof do
      Begin
        If Pos(MDSistemas.FieldByName('ATUALIZA').AsString,'1_3') > 0 Then
          MemoInfDaAtu.Lines.Add('     '+ MDSistemas.FieldByName('NOMEDOSISTEMA').AsString )  ;

        MDSistemas.Next ;
      End ; // While Not Eof do
      MDSistemas.EnableControls ;
    End ; // Else // If vTpAtualizacao = 'C' Then

    MemoInfDaAtu.SelStart  := 0;
    MemoInfDaAtu.SelLength := 2;

    BitBtnAvaAtu.SetFocus ;
  End Else
  If PnlFim.Parent = PnlAtualizacao Then
  Begin
    GradientInfoFim.Height := PnlInfoFim.Height ;
    GradientInfoFim.Width  := PnlInfoFim.Width ;

    PnlImgGlobus.Parent := PnlFim ;

    ButLogAtu.Top := PnlInfoFim.Height - 50 ;
    BitBtnCancelar.Caption  := 'Finalizar' ;
    BitBtnCancelar.SetFocus ;
  End ;

  vAvanca := (PnlInfoParaAtu.Parent = PnlAtualizacao) Or
             (PnlDestUsus.Parent    = PnlAtualizacao) Or
             (PnlTipo.Parent        = PnlAtualizacao) Or
             (PnlSistemas.Parent    = PnlAtualizacao) ;

  If vAvanca Then
  Begin
    BitBtnAvaAtu.Caption := 'Avançar' ;
    BitBtnAvaAtu.Glyph   := ImageAva.Picture.Bitmap ;
  End ; // If vAvanca Then

  HabilitaBotoes ;
end;

procedure TFrmTelaPrincipal.PnlCompletaClick(Sender: TObject);
begin
  PnlCompleta.BevelOuter := bvLowered ;
  PnlParcial.BevelOuter  := bvRaised ;
  vTpAtualizacao         := 'C' ;
  HabilitaBotoes ;
end;

procedure TFrmTelaPrincipal.PnlParcialClick(Sender: TObject);
begin
  PnlCompleta.BevelOuter := bvRaised ;
  PnlParcial.BevelOuter  := bvLowered ;
  vTpAtualizacao         := 'P' ;
  HabilitaBotoes ;
end;

procedure TFrmTelaPrincipal.FormShow(Sender: TObject);
var
  ServerIni : TIniFile;
  i : Integer ;
  Procedure RestauraDLL(pNomeDLL, pNomeTp : String ) ;
  Var
    vArquivo :String ;
    Res : TResourceStream ;
  Begin
    vArquivo := ExtractFilePath(Application.ExeName) + '\' + pNomeDLL + '.dll' ;
    If not FileExists(vArquivo) Then
    Begin
      Res := TResourceStream.Create (Hinstance, 'ZIPMASTER', PChar(pNomeTp) );
      Try
        Res.SavetoFile(vArquivo) ;
      Finally
        Res.Free ;
      End;
    End ; // If not FileExists(vArquivo) Then

    vSaiDaTelaIni := FileExists(vArquivo) ;
    If Not vSaiDaTelaIni Then
      MessageDlg('Arquivo '+ pNomeDLL +'.dll não encontrado.', mtError, [mbOk], 0 ) ;
  End ; // Procedure RestauraDLL(pNomeDLL, pNomeTp : String ) ;

  Function LendoGlobusIni : Boolean ;
  Var
    I      : Integer ;
    vTexto : TextFile ;
    vStr   : String ;
  Begin
    Result := True ;
    MostraMsg('Lendo GLOBUS.INI') ;
    If Not ( ((Not FileExists('\GLOBUS\GLOBUS.INI') ) And
             ( Not FileExists('GLOBUS.INI'        ) )) Or
             ( UpperCase(ParamStr(1)) = '/LOGIN' ) ) Then
    Begin
      { Abre o arquivo Globus.INI e seta os parametros }
      If FileExists('GLOBUS.INI') Then
        AssignFile(vTexto,'GLOBUS.INI')
      Else
        AssignFile(vTexto,'\GLOBUS\GLOBUS.INI') ;
      Reset(vTexto) ;

      I := 1 ;
      While Not Eof(vTexto) Do
      Begin
        Readln(vTexto,vStr) ;

        If vStr <> '' Then
          Case I Of
            1 : vcServerName := DesCriptografa(vStr);
            2 : vcUserName   := DesCriptografa(vStr);
            3 : vcUserSenha  := DesCriptografa(vStr);
            4 : vDriveDir    := Copy(DesCriptografa(vStr),1,1) + ':' ;
            5 : vDriveTemp   := DesCriptografa(vStr);
          End ; // Case I Of
        Inc(I) ;
      End ; // While Not Eof(vTexto) Do
      CloseFile(vTexto) ;
    End Else
    Begin
      MessageDlg('Arquivo GLOBUS.INI não encontrado.', mtError, [mbOk], 0 );
      Result := False ;
    End ;
    MostraMsg('') ;
  End ; // Function LendoGlobusIni : Boolean ;
begin
  MudaPanel(PnlInfoParaAtu) ;
  vConectoGlobus := False ;
  vConectoFTP    := False ;
  vTpAtualizacao := '' ;
  vNPanel := 0 ;
  vPassaFoco      := True ;
  vAbandonaExit   := False ;
  vEsc            := False ;
  EdtHostFTP.Clear ;
  EdtUsuFTP.Clear ;
  EdtSenFTP.Clear ;
  EdtDirFTP.Clear ;

  LblSepText1.Height := 35 ;
  MDOutros.Open ;
  If FileExists('Config.Ini') Then
  Begin
    Try
      ServerIni           := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini') ;
      EdtHostFTP.Text     := Descriptografa(ServerIni.ReadString('FTP',   'HOST',      '' ) ) ;  // 200.234.200.53
      EdtUsuFTP.Text      := Descriptografa(ServerIni.ReadString('FTP',   'USUARIO',   '' ) ) ;  // bgminformatica1
      EdtSenFTP.Text      := Descriptografa(ServerIni.ReadString('FTP',   'SENHA',     '' ) ) ;  // globus0703
      EdtDirFTP.Text      := Descriptografa(ServerIni.ReadString('FTP',   'DIRETORIO', '' ) ) ;  // globus
      EdtEMailOrigem.Text := Descriptografa(ServerIni.ReadString('CONTA', 'EMAILORIG', '' ) ) ;  // bgmrodotec.sp@bgmrodotec.com.br
      EdtServSMTP.Text    := Descriptografa(ServerIni.ReadString('CONTA', 'SMTP',      '' ) ) ;  // 200.234.205.143
      NEdtPorta.Text      := Descriptografa(ServerIni.ReadString('CONTA', 'PORTA',     '' ) ) ;  // 25
      EdtSenhaEMail.Text  := Descriptografa(ServerIni.ReadString('CONTA', 'SENHAEMAIL','' ) ) ;  // globus1104
      EdtEMailDest.Text   := Descriptografa(ServerIni.ReadString('CONTA', 'EMAILDEST', '' ) ) ;  // atendimento.sp@bgmrodotec.com.br
      EdtIgSiglas.Text    := Descriptografa(ServerIni.ReadString('NMSIS', 'SIGLAS',    '' ) ) ;  //
      EdtArqNovid.Text    := Descriptografa(ServerIni.ReadString('ARQ',   'NOVID',     '' ) ) ;  //
      EdtArqImple.Text    := Descriptografa(ServerIni.ReadString('ARQ',   'IMPLE',     '' ) ) ;  //
      EdtEMailLog.Text    := Descriptografa(ServerIni.ReadString('LOG',   'EMAIL',     '' ) ) ;  //
      EdtNFantasia.Text   := Descriptografa(ServerIni.ReadString('LOG',   'NFANTASIA', '' ) ) ;  //

      For i := 1 to 100 do
      Begin
        If Trim(Descriptografa(ServerIni.ReadString('OUTROS', 'ARQ' + IntToStr(i),'' ) )) <> '' Then
        Begin
          MDOutros.Append ;
          MDOutros.FieldByName('NOMEARQNOFTP' ).AsString := Descriptografa(ServerIni.ReadString('OUTROS', 'ARQ'   + IntToStr(i),'' ) ) ;
          MDOutros.FieldByName('NOMEDOSISTEMA').AsString := Descriptografa(ServerIni.ReadString('OUTROS', 'NOME'  + IntToStr(i),'' ) ) ;
          MDOutros.FieldByName('SIGLA'        ).AsString := Descriptografa(ServerIni.ReadString('OUTROS', 'SIGLA' + IntToStr(i),'' ) ) ;
          MDOutros.FieldByName('PASTA'        ).AsString := Descriptografa(ServerIni.ReadString('OUTROS', 'PASTA' + IntToStr(i),'' ) ) ;
          MDOutros.Post ;
        End Else
          Break ;
      End ; // For i := 0 to 100 do

      ServerIni.Free ;
    Except
    End ; // Try - Except
  End ; // If FileExists('Config.Ini') Then

  EdtEMailLog.Hint  := EdtEMailLog.Text ;
  EdtNFantasia.Hint := EdtNFantasia.Text ;

  If Trim(EdtDirFTP.Text) = '' Then
    EdtDirFTP.Text := 'globus' ;

  vArqIniOk := (Trim(EdtHostFTP.Text)     <> '') And
               (Trim(EdtUsuFTP.Text)      <> '') And
               (Trim(EdtSenFTP.Text)      <> '') And
               (Trim(EdtDirFTP.Text)      <> '') And
               (Trim(EdtEMailOrigem.Text) <> '') And
               (Trim(EdtServSMTP.Text)    <> '') And
               (NEdtPorta.Value           <> 0 ) And
               (Trim(EdtSenhaEMail.Text)  <> '') And
               (Trim(EdtEMailDest.Text)   <> '') ;
  If Not vArqIniOk Then
    MessageDlg('Arquivo Config.Ini não encontrado ou arquivo invalido.', mtError, [mbOk], 0 ) ;

  RestauraDLL('ZipDLL','COMPZIP') ;
  If vSaiDaTelaIni Then
    RestauraDLL('UnzDLL','DESCZIP') ;

  If vSaiDaTelaIni Then
    vSaiDaTelaIni := LendoGlobusIni ;

  HabilitaBotoes ;

  LblInfoAtualizacao.Caption := StringReplace(LblInfoAtualizacao.Caption,'[Drive]', vDriveDir,[] ) ;
  LblInfoAtualizacao.Caption := StringReplace(LblInfoAtualizacao.Caption,'[email]', EdtEMailDest.Text,[] ) ;
end;

procedure TFrmTelaPrincipal.BitBtnAvaAtuClick(Sender: TObject);
Type
  TResultControle = Record
    Erro       : Boolean ;
    ArqLog     : String ;
    ArqLoge    : String ;
    ArqMenu    : String ;
    AtuBase    : Boolean ;
    EnviaEmail : Boolean ;
  End ; // TResultControle = Record
var
  vErro,
  vRegistro,
  vTotalReg       : Integer ;
  vResultControle : TResultControle ;
  Function IncInt(Var pVlr: Integer) : Integer;
  Begin
    Inc(pVlr);
    Result := pVlr;
  End ; // Function IncInt(Var pVlr: Integer) : Integer;

  procedure BarraDeProgesso(pProcesso : Integer=0 ; pBarra: Integer=0 ; pTotal : Integer=0; pAtual : Integer=0; pInfo : String='' ) ;
  Const
    vCaptions : Array [1..6,1..3] Of String = (('Download',                  'NOMEARQNOFTP', 'fazendo download dos módulos.')
                                              ,('Backup',                    'NOMEDOSISTEMA','fazendo backup dos módulos.')
                                              ,('Apagando',                  'NOMEDOSISTEMA','apagando os módulos.')
                                              ,('Descompactando',            'NOMEARQNOFTP', 'descompactando os módulos para a atualização.')
                                              ,('Atualizando banco de dados','',             'atualizando banco de dados.')
                                              ,('Enviando e-Mail',           '',             'enviando e-mail dos arquivos de log gerados na atualização.')
                                              ) ;
  begin
    If pProcesso = 0 Then
    Begin
      LblCabTitulo.Caption  := '' ;
      LblInfoTitulo.Caption := '' ;

      PnlTituloBar1.Caption := '' ;
      PBarra1.Position      := 0 ;
      PBarra1.Max           := 0 ;
      PnlTituloBar2.Caption := '' ;
      PBarra2.Position      := 0 ;
      PBarra2.Max           := 0 ;
      PnlTituloBar3.Caption := '' ;
      PBarra3.Position      := 0 ;
      PBarra3.Max           := 0 ;
      PnlBarra1.Visible     := True ;
      PnlBarra2.Visible     := True ;
      PnlBarra3.Visible     := True ;
    End Else // If pProcesso = 0 Then
    If pAtual = 0 Then
    Begin
      PnlBarra1.Visible := pProcesso < 5 ;
      PnlBarra2.Visible := pProcesso < 5 ;
      PnlBarra3.Visible := Pos(IntToStr(pProcesso),'1_6') > 0 ;

      LblCabTitulo.Caption  := vCaptions[pProcesso,1] ;
      LblInfoTitulo.Caption := 'Aguarde...'      + #13 +
                               'O sistema está ' + vCaptions[pProcesso,3] ;

      If pBarra <> 0 Then
      Begin
        TPanel(      FindComponent('PnlTituloBar' + IntToStr(pBarra) ) ).Caption  := '' ;
        TProgressBar(FindComponent('PBarra'       + IntToStr(pBarra) ) ).Max      := pTotal ;
        TProgressBar(FindComponent('PBarra'       + IntToStr(pBarra) ) ).Position := 0 ;
      End ; // If pBarra <> 0 Then
    End Else // If (pBarra<>0) And (...
    If pAtual <> 0 Then
    Begin
      TProgressBar(FindComponent('PBarra' + IntToStr(pBarra) ) ).Position := pAtual ;
      If pBarra = 1 Then
        PnlTituloBar1.Caption  := MDSistemas.FieldByName(vCaptions[pProcesso,2]).AsString
      Else
        TPanel(FindComponent('PnlTituloBar' + IntToStr(pBarra) ) ).Caption  := pInfo ;
    End ; // If pAtual <> 0 Then

    Application.ProcessMessages ;
  End ; // procedure BarraDeProgesso(pProcesso, pBarra, pTotal : Integer; pAtual : Integer=0; pInfo : String='' ) ;

  Function DownloadDosArquivos : Integer ;
  Begin
    Result := 0 ;
    CreateDir('DOWNLOAD') ;

    AverageSpeedTot  := 0 ;
    vAWorkCountAnt   := 0 ;
    STimeTot         := Now ;
    TotalTimeTot     := 0 ;
    HTot             := 0 ;
    MTot             := 0 ;
    SecTot           := 0 ;
    MSTot            := 0 ;
    PBarra1.Position := 0 ;

    vRegistro  := 0 ;
    BarraDeProgesso ;
    BarraDeProgesso(1,1,vTotalReg) ;
    MDSistemas.First ;
    While Not MDSistemas.Eof do
    Begin
      If MDSistemas.FieldByName('ATUALIZA').AsInteger = 1 Then
      Begin
        PnlTituloBar1.Caption := MDSistemas.FieldByName('NOMEARQNOFTP').AsString ;

        If IdFTP1.Connected Then
        Begin
          Try
            IdFTP1.TransferType := ftBinary ;
            vBytesTransf        := MDSistemas.FieldByName('TAMANHOEXE').AsInteger ;
            IdFTP1.Get(MDSistemas.FieldByName('NOMEARQNOFTP').AsString
                      ,DriveComboBox.Drive + ':\GLOBUS\DOWNLOAD\' + MDSistemas.FieldByName('NOMEARQNOFTP').AsString
                      ,True ) ;
          Except
            DeleteFile(DriveComboBox.Drive + ':\GLOBUS\DOWNLOAD\' + MDSistemas.FieldByName('NOMEARQNOFTP').AsString) ;
            Result := 1 ;
            Break ;
          End ; // Try - Except
        End Else // If IdFTP1.Connected Then
        Begin
          Result := 2 ;
          Break ;
        End ; // End Else // If IdFTP1.Connected Then

        BarraDeProgesso(1,1,vTotalReg,IncInt(vRegistro)) ;
      End ; // If MDSistemas.FieldByName('ATUALIZA').AsInteger = 1 Then

      MDSistemas.Next ;
    End ; // While Not MDSistemas.Eof do
  End ; // Function DownloadDosArquivos : Integer ;

  Function BackupDosArquivos(pBackup : Boolean = True ) : Integer ;
  Var
    vArq,
    vTotalArq,
    l,h,i,p   : Integer ;
    SR        : TSearchRec ;
    vOrigem,
    vArquivos : String ;
    vTamArqs  : Integer ;
  const
    vTpArq : Array[0..4] of String = ('RPT','SQL','EXE','DLL','TXT') ;
    vDir   : Array[0..2] of String = ('\REPORT','\SCRIPTS','') ;
  Begin
    Result := 0 ;

    If Not FileExists(ExtractFilePath(Application.ExeName) + '\ZipDLL.dll') Then
    Begin
      Result := 13 ;
      Exit ;
    End ; // If Not FileExists(...

    If pBackup Then
    Begin
      CreateDir('BACKUP') ;
      ZipMaster1.ZipFileName := DriveComboBox.Drive + ':\GLOBUS\BACKUP\Globus_' + FormatDateTime('DDMMYYYY_HHNN',vDataHoraAtu) + '.Zip' ;
      ZipMaster1.FSpecArgs.Clear ;
    End ; // If pBackup Then

    vRegistro := 0 ;
    vTamArqs  := 0 ;
    p := IIf(pBackup,2,3) ;

    BarraDeProgesso ;
    BarraDeProgesso(p,1,vTotalReg ) ;

    MDSistemas.First ;
    While Not MDSistemas.Eof do
    Begin
      If (MDSistemas.FieldByName('ATUALIZA').AsInteger = 1) Or
         ((MDSistemas.FieldByName('ATUALIZA').AsInteger = 3) And (MDSistemas.FieldByName('CONTINUAANT').AsString = 'N')) Then
      Begin
        PnlTituloBar1.Caption := MDSistemas.FieldByName('NOMEDOSISTEMA').AsString ;
        For l := 2 downto 0 do // Diretorio do sistema e sub-diretorios
        Begin
          vOrigem  := vDriveDir + MDSistemas.FieldByName('PASTA').AsString + vDir[l] ;
          For h := 4 downto 0 do // Tipos de arquivos
          Begin
            vArquivos := vOrigem + '\*.' + vTpArq[h] ;
            I := FindFirst(vArquivos  , faAnyFile, SR);

            vTotalArq := 0 ;
            vArq      := 0 ;
            While I = 0 do
            Begin
              I := FindNext(SR) ;
              Inc(vTotalArq) ;
            End ; // While I = 0 do
            BarraDeProgesso(p,2,vTotalArq) ;

            I := FindFirst(vArquivos  , faAnyFile, SR);
            While I = 0 do
            begin
              BarraDeProgesso(p,2,vTotalArq,IncInt(vArq), SR.Name) ;
              If FileExists(vOrigem +'\'+ SR.Name) Then
              Begin
                If pBackup Then
                  ZipMaster1.FSpecArgs.Add(vOrigem +'\'+ SR.Name)
                Else // If pBackup Then
                Begin

                  FileSetAttr(vOrigem +'\'+ SR.Name,0) ;
                  If Not DeleteFile(vOrigem +'\'+ SR.Name) Then
                  Begin
                    Result := 5 ;
                    Exit ;
                  End ; // If Not DeleteFile(...

                End ; // Else // If pBackup Then
                vTamArqs := vTamArqs + SR.Size ;
              End ; // If FileExists(
              I := FindNext(SR) ;
            End ; // While I = 0 do
            FindClose(SR) ;
          End ; // For h := 4 downto 0 do
        End ; // For l := 2 downto 0 do

        BarraDeProgesso(p,1,vTotalReg,IncInt(vRegistro)) ;
      End ; // If (MDSistemas.FieldByName('ATUALIZA').AsInteger = 1) Or (...

      MDSistemas.Next ;
    End ; // While Not MDSistemas.Eof do

    If pBackup And (ZipMaster1.FSpecArgs.Count <> 0) Then
    Begin
      PnlTituloBar1.Caption := 'Gerando arquivo: ' + ZipMaster1.ZipFileName ;
      PBarra1.Tag      := 1 ;
      PBarra1.Max      := ZipMaster1.FSpecArgs.Count ;
      PBarra2.Max      := vTamArqs ;
      PBarra1.Position := 0 ;
      PBarra2.Position := 0 ;
      ZipMaster1.Add  ;
    End ; // If pBackup And (...
  End ; // Function BackupDosArquivos(pBackup : Boolean = True ) : Integer ;

  Function ApagasOsArquivosAtuais : Integer ;
  Begin
    Result := BackupDosArquivos(False) ;
  End ; // Function ApagasOsArquivosAtuais : Boolean ;

  Function DescompacataOsDownload : Integer ;
  Var
    vOrigem,
    vDestino : String ;   
  Begin
    Result := 0 ;

    If Not FileExists(ExtractFilePath(Application.ExeName) + '\UnzDLL.dll') Then
    Begin
      Result := 14 ;
      Exit ;
    End ; // If Not FileExists(...

    vRegistro := 0 ;
    BarraDeProgesso ;
    BarraDeProgesso(4,1,vTotalReg) ;

    MDSistemas.First ;
    ZipMaster1.ExtrBaseDir := vDriveDir + '\' ;
    While Not MDSistemas.Eof do
    Begin
      If Pos(MDSistemas.FieldByName('ATUALIZA').AsString,'1_3') > 0 Then
      Begin
        PnlTituloBar1.Caption := MDSistemas.FieldByName('NOMEARQNOFTP').AsString ;

        vOrigem := DriveComboBox.Drive + ':\GLOBUS\DOWNLOAD\' + MDSistemas.FieldByName('NOMEARQNOFTP').AsString ;
        If FileExists(vOrigem) Then
        Begin
          If MDSistemas.FieldByName('ARQZIP').AsString='S' Then
          Begin
            ZipMaster1.ZipFileName := vOrigem ;
            If FileExists(ZipMaster1.ZipFileName) Then // Se houver algum erro no arquivo a propriedade ZipFileName e zerada
            Begin
              PBarra1.Tag      := 0 ;
              PBarra2.Max      := ZipMaster1.ZipFileSize ;
              PBarra2.Position := 0 ;
              ZipMaster1.Extract ;
            End Else
              Result := 7 ;
          End Else // If MDSistemas.FieldByName('ARQZIP').AsString='S' Then
          Begin
            vDestino := vDriveDir + MDSistemas.FieldByName('PASTA').AsString +'\'+ MDSistemas.FieldByName('NOMEARQNOFTP').AsString ;

            If Not DirectoryExists(vDriveDir + MDSistemas.FieldByName('PASTA').AsString) then
              ForceDirectories(vDriveDir + MDSistemas.FieldByName('PASTA').AsString) ;

            If FileExists(vDestino) Then
              FileSetAttr(vDestino,0) ;

            CopyFile(PChar(vOrigem),PChar(vDestino),True);
          End ; // End Else // If MDSistemas.FieldByName('ARQZIP').AsString='S' Then
        End ; // If FileExists(vOrigem) Then

        BarraDeProgesso(4,1,vTotalReg,IncInt(vRegistro), MDSistemas.FieldByName('NOMEARQNOFTP').AsString) ;
      End ; // If Pos(MDSistemas.FieldByName('ATUALIZA').AsString,'1_3') > 0 Then

      MDSistemas.Next ;
    End ; // While Not MDSistemas.Eof do
  End ; // Function DescompacataOsDownload : Integer ;

  Function BloqueiBaseDeDados : Integer ;
  begin
    With QryPesquisa Do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Clear ;
      Sql.Add('INSERT INTO CTR_ATUALIZABASE (NREG,WINLOGIN)') ;
      Sql.Add('VALUES (:PNREG,:PWINLOGIN)'                  ) ;
      ParamByName('PNREG'    ).AsInteger := 1 ;
      ParamByName('PWINLOGIN').AsString  := AnsiUpperCase(TrazNomeDoComputador + '/' + WinLogin) ;
      Try
        ExecSQL ;
        Result := 0 ;
      Except
        Result := 14 ;
      End ; // Try - Except
    End ; // With qrAuxiliar Do
  End ; // Function BloqueiBaseDeDados : Integer ;

  Function AbreModuloDeControle : Integer ;
  var
    vProg : HWnd ;
    vControleExe : String ;
    Function ExecutaControle : Cardinal ;
    var
      Programa : array [0..512] of char;
      CurDir : array [0..255] of char;
      WorkDir : String;
      StartupInfo : TStartupInfo;
      ProcessInfo : TProcessInformation;
    Begin
      StrPCopy (Programa, vControleExe
                        + ' ' + 'ATUALIZACAO'
                        + ' ' + FormatDateTime('DDMMYYYY_HHNN',vDataHoraAtu)
                        + ' ' + EdtUsuGlobus.Text
                        + ' ' + vTpAtualizacao
                        + ' ' + vSisAtu) ;

      GetDir (0, WorkDir);
      StrPCopy (CurDir, WorkDir);
      FillChar (StartupInfo, Sizeof (StartupInfo), #0);
      StartupInfo.cb := sizeof (StartupInfo);
      StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
      StartupInfo.wShowWindow := SW_SHOWNORMAL ;
      if not CreateProcess(nil, Programa, nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
        Result := StrToInt('-1')
      Else
      begin
        WaitForSingleObject (ProcessInfo.hProcess, Infinite);
        GetExitCodeProcess (ProcessInfo.hProcess, Result );
      End ;
    End ; // Function ExecutaControle : Cardinal ;

    Function VerificaResultControle : TResultControle ;
    Var
      vValor : String ;
      vPos   : Integer ;
    Begin
      With QryPesquisa Do
      Begin
        Close ;
        Sql.Clear ;
        Sql.Add('SELECT VALOR') ;
        Sql.Add('  FROM CTR_DADOS_INI') ;
        Sql.Add(' WHERE MODULO = :P_MODULO') ;
        Sql.Add('   AND SECAO  = :P_SECAO') ;
        Sql.Add('   AND CHAVE  = :P_CHAVE') ;
        ParamByName('P_MODULO').AsString := 'ATUALIZACAO' ;
        ParamByName('P_SECAO' ).AsString := 'ULTIMAATUALIZACAO' ;
        ParamByName('P_CHAVE' ).AsString := FormatDateTime('DDMMYYYY_HHNN',vDataHoraAtu) ;
        Open ;
        Result.AtuBase    := Not IsEmpty ;
        vValor            := FieldByName('VALOR').AsString ;
        vPos              := Pos('ERRO=',vValor)+5 ;
        Result.Erro       := Copy(vValor,vPos ,01) = 'S' ;
        vPos              := Pos('LOG=' ,vValor)+4 ;
        Result.ArqLog     := Copy(vValor,vPos,Pos(',LOGE=',vValor)-vPos) ;
        vPos              := Pos('LOGE=',vValor)+5 ;
        Result.ArqLoge    := Copy(vValor,vPos,Pos(',MENU=',vValor)-vPos) ;
        vPos              := Pos('MENU=',vValor)+5 ;
        Result.ArqMenu    := Copy(vValor,vPos,Pos(',USU=', vValor)-vPos) ;
        Result.EnviaEmail := FileExists(Trim(Result.ArqLog)) Or
                             FileExists(Trim(Result.ArqLoge)) Or
                             FileExists(Trim(Result.ArqMenu)) ;
        ButLogAtu.Visible := Result.Erro And FileExists(Trim(Result.ArqLoge)) ;
        ButLogAtu.Hint    := Result.ArqLoge ;
      End ; // With QryPesquisa Do
    End ; // Function VerificaResultControle : TResultControle ;
  Begin
    BarraDeProgesso(5) ;
    ChDir(vDriveDir) ;
    vControleExe := vDriveDir + '\Globus\Sistemas\Controle\Controle.exe' ;
    If FileExists(vControleExe) Then
    Begin
      If FileExists(vDriveDir + '\Globus\Glb_Atu_Bco_Dados.txt') Then
      Begin
        WindowState := wsMinimized ;
        vProg := FindWindow(Nil,'Atualizacao') ;
        If vProg > 0 Then
          ShowWindow(vProg,SW_HIDE) ; // Esconde o icone da barra iniciar

        ExecutaControle ;
        If vProg > 0 Then
          ShowWindow(vProg,SW_SHOWNORMAL) ;

        WindowState := wsNormal ;

        vResultControle := VerificaResultControle ;
        Result := IIf(vResultControle.AtuBase,0,10) ;
      End Else // If FileExists(...
        Result := 12 ;
    End Else // If FileExists(...
      Result := 11 ;

    ChDir(DriveComboBox.Drive + ':') ;
  End ; // Function AbreModuloDeControle : Integer ;

  Function EnviarEMail(pUsaContaUsu : Boolean = False ) : Integer ;
  Var
    vServdor,
    vEMailOrigem,
    vSenha,
    vPorta : String ;
  Begin
    Result := 0 ;
    BarraDeProgesso(6,1,3) ;

    vServdor     := Trim(IIf(pUsaContaUsu, vServidorUsu, EdtServSMTP.Text)) ;
    vEMailOrigem := Trim(IIf(pUsaContaUsu, vEmailUsu,    EdtEMailOrigem.Text)) ;
    vSenha       := Trim(IIf(pUsaContaUsu, vSenhaUsu,    EdtSenhaEMail.Text)) ;
    vPorta       := Trim(IIf(pUsaContaUsu, vPortaUsu,    NEdtPorta.Text)) ;

    With SakMsg1 do
    Begin
      ClearRawMail ;
      SendToList.Clear ;
      BCCList.Clear ;
      UserName := Copy(vEMailOrigem,1,(Pos(vEMailOrigem,'@')-1)) ;      
      From     := EdtEMailOrigem.Text ;
      SendTo   := EdtEMailDest.Text ;
      CC       := EdtEMailLog.Text ; // vEmailUsu ;

      BCC      := '' ;
      Subject  := 'Log(s) da Atualização do Globus do cliente ' + Trim(EdtNFantasia.Text) +' - '+ StrZero(vcCodigoCliente,4) ;

      HTML.Clear ;
      HTML.Add('<html>'
              + '  <head><title>Envio automático de Log</title></head>'
              + '  <body>'
              + '    <table width="882" align="center" border="0">'
              + '      <tr style="font-size: 12pt; font-family: Verdana, Arial, Helvetica, sans-serif; border: 1px solid #ffffff" align="middle" width="90%">'
              + '        <td width="874" colSpan="2">'
              + '        <p align="left"><b>Envio automático de Log (s) via Atualização GLOBUS</b></td>'
              + '      </tr>'
              + '      <tr>'
              + '        <td width="874" colSpan="2"><hr></td>'
              + '      </tr>'
              + '      <tr style="font-size: 10pt; font-family: Verdana, Arial, Helvetica, sans-serif; border: 1px solid #ffffff" align="left" width="90%">'
              + '        <td width="874" colSpan="2">Prezado atendimento '+ vcConcedente +',<br>'
              + '        <br>'
              + '        Estou enviando em anexo o(s) log(s) gerados pela atualização efetuada em <b>'+ FormatDateTime('dd/mm/yyyy hh:mm',vDataHoraAtu) +'</b>'
              + '        .<p><br>'
              + '        Sem mais,</p>'
              + '        <p><b>'+ EdtUsuGlobus.Text +'</b></p>'
              + '        </td>'
              + '      </tr>'
              + '    </table>'
              + '    <p>&nbsp;</p>'
              + '  </body>'
              + '</html>') ;
      If FileExists(vResultControle.ArqLog) Then
        AttachedFiles.Add(vResultControle.ArqLog) ;
      If FileExists(vResultControle.ArqLoge) Then
        AttachedFiles.Add(vResultControle.ArqLoge) ;
      If FileExists(vResultControle.ArqMenu) Then
        AttachedFiles.Add(vResultControle.ArqMenu) ;
    End ; // With SakMsg1 do

    With SakSMTP1 do
    Begin
      Host       := vServdor ;
      UserID     := vEMailOrigem ;
      UserPasswd := vSenha ;
      Port       := vPorta ;
      Try
        Connect ;
        If Login And (Not SMTPError) then
          SendTheMessage(SakMsg1)
        Else
          Result := 09 ;
        Disconnect ;
      Except
        Result := 09 ;
      End ; // Try - Except
    End ; // With vSakSMTP1 do
  End ; // Function EnviarEMail(pUsaContaUsu : Boolean = False ) : Integer ;

  Function MsgErro(pErro : Integer) : String ;
  Begin
    Result := '' ;
    Case pErro of
      01 : Result := 'Não foi possível fazer o download dos arquivos' ;
      02 : Result := 'Falha na conexão com FTP' ;
      03 : Result := 'Não foi possível fazer o backup dos arquivos' ;
      04 : Result := 'Não foi possível gerar o backup' ;
      05 : Result := 'Ao apagar os arquivos' ;
      06 : Result := 'Ao descompactar o download' ;
      07 : Result := 'Arquivo do download não encontrado' ;
      08 : Result := 'De conexão com a internet' ;
      09 : Result := 'Usuario \ Senha invalido para enviar o e-mail dos logs' ;
      10 : Result := 'Erro na atualização do Banco de dados' ;
      11 : Result := 'Controle.exe não encontrado' ;
      12 : Result := 'Arquivo Glb_Atu_Bco_Dados.txt não encontrado' ;
      13 : Result := 'Arquivo ZipDLL.dll para compactar os arquivos não encontrado' ;
      14 : Result := 'Arquivo UnzDLL.dll para descompactar os arquivos não encontrado' ;
      15 : Result := 'O Globus já está sendo atualizado' ;
    End ; // Else // Case pErro of
    Result := 'Erro: ' + Result + '.' ;
  End ; // Procedure MsgErro(pErro : Integer) ;

  Function VerificaOsUsuConect : Boolean ;
  Begin
    Timer2Timer(Sender) ;
    Result := PnlUsuConect.Parent = PnlAtualizacao ;
  End ; // Function VerificaOsUsuConect : Boolean ;

  Procedure ApagaDadosIniAtuInt(pSecao : String ) ;
  Begin
    With QryPesquisa Do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add('DELETE CTR_DADOS_INI') ;
      Sql.Add(' WHERE MODULO = :P_MODULO') ;
      Sql.Add('   AND SECAO  = :P_SECAO' ) ;
      Sql.Add('   AND CHAVE  = :P_CHAVE' ) ;
      ParamByName('P_MODULO').AsString := 'ATUALIZACAO' ;
      ParamByName('P_SECAO' ).AsString := pSecao ;
      ParamByName('P_CHAVE' ).AsString := IIf(pSecao = 'INTERROMPIDA','INTERROMPIDA',FormatDateTime('DDMMYYYY_HHNN',vDataHoraAtu)) ;
      Try
        ExecSQL ;
      Except
      End ;

      Sql.Clear ;
      Sql.Add('DELETE CTR_ATUALIZABASE') ;
      Try
        ExecSQL ;
      Except
      End ;
    End ; // With QryPesquisa Do
  End ; // Procedure ApagaDadosIniAtuInt(pSecao : String ) ;
begin
  If BitBtnAvaAtu.Caption = 'Avançar' Then
  Begin
    If PnlInfoParaAtu.Parent = PnlAtualizacao Then
    Begin
      MudaPanel(PnlInfoParaAtu) ;
      MudaPanel(PnlDestUsus) ;
    End Else // If PnlInfoParaAtu.Parent = PnlAtualizacao Then
    If PnlDestUsus.Parent = PnlAtualizacao Then
    Begin
      MudaPanel(PnlDestUsus) ;
      If vUltimaAtu.Achou Then
        MudaPanel(PnlTipo)
      Else
        MudaPanel(PnlSistemas) ;
    End Else // If PnlDestUsus.Parent = PnlAtualizacao Then
    If PnlTipo.Parent = PnlAtualizacao Then
    Begin
      MudaPanel(PnlTipo) ;
      MudaPanel(PnlSistemas) ;
    End Else // If PnlTipo.Parent = PnlAtualizacao Then
    If PnlSistemas.Parent = PnlAtualizacao Then
    Begin
      MudaPanel(PnlSistemas) ;
      MudaPanel(PnlInfoDaAtu) ;
    End Else // If PnlSistemas.Parent = PnlAtualizacao Then
    If PnlInfoDaAtu.Parent = PnlAtualizacao Then
    Begin
      MudaPanel(PnlInfoDaAtu) ;
      MudaPanel(PnlFim) ;
    End ; // If PnlInfoDaAtu.Parent = PnlAtualizacao Then
  End Else // If BitBtnAvaAtu.Caption = 'Avançar' Then
  Begin
    If (EdtEMailLog.Hint  <> EdtEMailLog.Text) Or
       (EdtNFantasia.Hint <> EdtNFantasia.Text) Then
      BitBConfirmaFTPClick(Sender) ;

    vTotalReg := StrToInt(Trim(LblQtdeArq.Caption)) ;
    If Sender = BitBContinuar Then
    Begin
      vErro := 0 ;
    End Else // If Sender = BitBContinuar Then
    Begin
      MudaPanel(PnlInfoDaAtu) ;
      MudaPanel(PnlBarras) ;

      Screen.Cursor := crHourGlass ;
      ChDir(DriveComboBox.Drive + ':') ;
      CreateDir('\GLOBUS') ;

      ChDir(DriveComboBox.Drive + ':\GLOBUS\') ;

      MDSistemas.DisableControls ;

      vErro := DownloadDosArquivos ;
      If vErro = 0 Then
        vErro := BackupDosArquivos ;
    End ; // End Else // If Sender = BitBContinuar Then

    If VerificaOsUsuConect Then Exit ;

    If (vErro = 0) And (vTpAtualizacao = 'C') Then
      vErro := BloqueiBaseDeDados ;

    If vErro = 0 Then
      vErro := ApagasOsArquivosAtuais ;
    If vErro = 0 Then
      vErro := DescompacataOsDownload ;

    If vErro = 0 Then
    Begin
      If vTpAtualizacao = 'C' Then
      Begin
        vErro := AbreModuloDeControle ;

        If (vErro = 0) And vResultControle.EnviaEmail Then
        Begin
          vErro := EnviarEMail ;
          If vErro <> 0 Then
          Begin
            vErro := EnviarEMail(True) ;
            If vErro <> 0 Then
              MessageDlg(MsgErro(vErro), mtError, [mbOk], 0 ) ;
          End ; // If vErro <> 0 Then

          vErro := 0 ;
        End ; // If (vErro = 0) And ....
      End Else // If vTpAtualizacao = 'C' Then
      Begin
        With QryPesquisa Do
        Begin
          Close ;
          Sql.Clear ;
          Sql.Add('INSERT INTO CTR_DADOS_INI (MODULO, SECAO, CHAVE, VALOR, DATA, ITEM)') ;
          Sql.Add('VALUES (:P_MODULO, :P_SECAO, :P_CHAVE, :P_VALOR, :P_DATA, :P_ITEM)' );
          ParamByName('P_ITEM'  ).AsInteger := 1 ;
          ParamByName('P_MODULO').AsString  := 'ATUALIZACAO' ;
          ParamByName('P_SECAO' ).AsString  := 'ULTIMAATUALIZACAO' ;
          ParamByName('P_CHAVE' ).AsString  := FormatDateTime('DDMMYYYY_HHNN',vDataHoraAtu) ;
          ParamByName('P_VALOR' ).AsString  := 'USU='  + EdtUsuGlobus.Text
                                             + ',TP='  + 'P'
                                             + ',SIS=' + vSisAtu ;
          ParamByName('P_DATA'  ).AsDateTime := Now ;
          Try
            ExecSQL ;
          Except
          End ;
        End ; // With QryPesquisa Do
      End ; // If vTpAtualizacao = 'C' Then
    End ; // If vErro = 0 Then
    MDSistemas.EnableControls ;

    HabilitaBotoes ;
    If vErro = 0 Then
    Begin
      MudaPanel(PnlBarras) ;
      MudaPanel(PnlFim) ;

      ApagaDadosIniAtuInt('INTERROMPIDA') ;
      GravaLog('Atualizacao do(s) modulo(s): ' + vSisAtu) ;
    End Else // If vErro = 0 Then
    Begin
      GravaLog(MsgErro(vErro)) ;
      MessageDlg(MsgErro(vErro), mtError, [mbOk], 0 ) ;

      MudaPanel(PnlBarras) ;
      MudaPanel(PnlDestUsus) ;

      ApagaDadosIniAtuInt('ULTIMAATUALIZACAO') ;

      MDSistemas.EmptyTable ;
      Totais ; // Apenas p/ atualizar a tela
      vConectoGlobus := False ;
      vConectoFTP    := False ;
      BitBtnVoltar.Enabled := True ;
      HabilitaBotoes ;
    End ; // End Else // If vErro = 0 Then

    Screen.Cursor := crDefault ;
  End ; // End Else // If BitBtnAvaAtu.Caption = 'Avançar' Then

end;

procedure TFrmTelaPrincipal.BitBtnVoltarClick(Sender: TObject);
begin
  If PnlDestUsus.Parent = PnlAtualizacao Then
  Begin
    MudaPanel(PnlDestUsus) ;
    MudaPanel(PnlInfoParaAtu) ;
  End Else // If PnlDestUsus.Parent = PnlAtualizacao Then
  If PnlTipo.Parent = PnlAtualizacao Then
  Begin
    MudaPanel(PnlTipo) ;
    MudaPanel(PnlDestUsus) ;
  End Else // If PnlTipo.Parent = PnlAtualizacao Then
  If PnlSistemas.Parent = PnlAtualizacao Then
  Begin
    MudaPanel(PnlSistemas) ;
    If vUltimaAtu.Achou Then
      MudaPanel(PnlTipo)
    Else
      MudaPanel(PnlDestUsus) ;
  End Else // If PnlSistemas.Parent = PnlAtualizacao Then
  If PnlInfoDaAtu.Parent = PnlAtualizacao Then
  Begin
    MudaPanel(PnlInfoDaAtu) ;
    MudaPanel(PnlSistemas) ;    
  End Else // If PnlInfoDaAtu.Parent = PnlAtualizacao Then
  If PnlFim.Parent = PnlAtualizacao Then
  Begin
    MudaPanel(PnlFim) ;
    MudaPanel(PnlInfoDaAtu) ;
  End ; // If PnlFim.Parent = PnlAtualizacao Then
end;

procedure TFrmTelaPrincipal.HabilitaBotoes;
Var
  vRegAtual : TBookmark ;
begin
  BitBtnAvaAtu.Enabled := ((PnlInfoParaAtu.Parent = PnlAtualizacao) And vSaiDaTelaIni) Or
                          ((PnlDestUsus.Parent    = PnlAtualizacao) And vConectoGlobus And vConectoFTP And vArqIniOk And (Trim(EdtEMailLog.Text) <> '') And (Trim(EdtNFantasia.Text) <> '') ) Or
                          ((PnlTipo.Parent        = PnlAtualizacao) And ( vTpAtualizacao <> '' )) Or
                          ((PnlSistemas.Parent    = PnlAtualizacao) And (Not MDSistemas.IsEmpty)  ) Or

                          ((PnlInfoParaAtu.Parent <> PnlAtualizacao) And
                           (PnlTipo.Parent        <> PnlAtualizacao) And
                           (PnlDestUsus.Parent    <> PnlAtualizacao) And
                           (PnlSistemas.Parent    <> PnlAtualizacao)) ;

  If PnlBarras.Parent = PnlAtualizacao Then
  Begin
    BitBtnVoltar.Enabled   := False ;
    BitBtnAvaAtu.Enabled   := False ;
    BitBtnCancelar.Enabled := False ;
  End Else // If PnlBarras.Parent = PnlAtualizacao Then
    BitBtnCancelar.Enabled := True ;

  If (vTpAtualizacao = 'P') And (PnlSistemas.Parent = PnlAtualizacao) And (BitBtnAvaAtu.Enabled) Then
  Begin
    vRegAtual := MDSistemas.GetBookmark ;
    BitBtnAvaAtu.Enabled := MDSistemas.Locate('ATUALIZA','1',[loCaseInsensitive]) Or MDSistemas.Locate('ATUALIZA','3',[loCaseInsensitive]) ;

    MDSistemas.GotoBookmark(vRegAtual) ;
    MDSistemas.FreeBookmark(vRegAtual) ;
  End ;
end;

procedure TFrmTelaPrincipal.BitBConfirmaGlobusClick(Sender: TObject);
  Procedure MostraMsg(pMsg : String) ;
  Begin
    SBarMsg.Panels[0].Text := pMsg ;
    FrmTelaPrincipal.Refresh ;
  End ; // Procedure MostraMsg(pMsg : String) ;

  Function ConectaUsuarioAoGlobus : Boolean ;
  Var
    i : Integer ;
  Begin
    Result := False ;

    dbBgm.Connected := False ;
    dbBgm.Params.Clear ;
    dbBgm.AliasName := vcServerName ;
    dbBgm.Params.Add('USER NAME='+ vcUserName);
    dbBgm.Params.Add('PASSWORD='+  vcUserSenha);

    MostraMsg('Conectando ao Banco de Dados...') ;
    Try
      dbBgm.Connected := True ;
    Except
      Begin
        MessageDlg('Erro ao conectar no Banco de Dados.' , mtError, [mbOk], 0 ) ;
        Exit ;
      End ;
    End ; // Try - Except

    Try
      With QryPesquisa Do
      Begin
        Close ;
        Sql.Clear ;
        Sql.Add('SELECT WINLOGIN') ;
        Sql.Add('  FROM CTR_ATUALIZABASE') ;
        Try
          Open ;
          If Not IsEmpty Then
          Begin
            MessageDlg('O Globus já está sendo atualizado por (Usuário/Estação) "' + FieldByName('WINLOGIN').AsString + '".Aguarde alguns instantes e tente novamente.' , mtError, [mbOk], 0 );
            Exit ;
          End ; // If Not IsEmpty Then
        Except
          Close ;
          Sql.Clear ;
          Sql.Add('CREATE TABLE CTR_ATUALIZABASE'                             ) ;
          Sql.Add(' (NREG NUMBER(1) NOT NULL, WINLOGIN VARCHAR2(80) NOT NULL)') ;
          Sql.Add('TABLESPACE GLOBUS_TABLE'                                   ) ;
          ExecSQL;
          Sql.Clear;
          Sql.Add('ALTER TABLE CTR_ATUALIZABASE'                            ) ;
          Sql.Add('ADD ( CONSTRAINT PK_CTR_ATUALIZABASE PRIMARY KEY (NREG) ') ;
          Sql.Add('USING INDEX TABLESPACE GLOBUS_INDEX )'                   ) ;
          ExecSQL ;
          Close ;
        End ; // Try - Except

        Sql.Clear ;
        Sql.Add('  SELECT CODIGOCLIENTE') ;
        Sql.Add('       , CHAVECLIENTE') ;
        Sql.Add('       , NOMECONCEDENTE') ;
        Sql.Add('    FROM CTR_CONCEDENTE') ;
        MostraMsg('Verificando concedente...') ;
        Open ;
        vcCodigoCliente           := FieldByName('CODIGOCLIENTE').AsInteger ;
        vUsuarioManagerComSenhaUm := Descriptografa(FieldByName('ChaveCliente').AsString) = '1' ;
        vcConcedente              := FieldByName('NOMECONCEDENTE').AsString ;

        Sql.Clear ;
        Sql.Add('SELECT ADMINISTRADOR') ;
        Sql.Add('     , SENHA') ;
        Sql.Add('     , ATIVO') ;
        Sql.Add('     , EMAIL') ;
        Sql.Add('     , SENHASNAP') ;
        Sql.Add('     , PORTAENVIO') ;
        Sql.Add('     , SERVIDORSMTP') ;
        Sql.Add('  FROM CTR_CADASTRODEUSUARIOS') ;
        Sql.Add(' WHERE USUARIO = :P_USUARIO') ;
        ParamByName('P_USUARIO').AsString := Trim(EdtUsuGlobus.Text) ;
        MostraMsg('Verificando se o usuário tem permissão para atualizar o sistemas...') ;
        Open ;
        Result := (FieldByName('SENHA').AsString = Encripta(Trim(EdtSenhaGlobus.Text), 10, True)) Or
                  (FieldByName('SENHA').AsString = Encripta(Trim(EdtSenhaGlobus.Text), 10, False)) ;
        If Not Result Then
        Begin
          MessageDlg('Senha inválida.', mtError, [mbOk], 0 ) ;
          If Not vUsuarioManagerComSenhaUm Then
            Exit ;
        End ; // If Not Result Then

        vEmailUsu    := FieldByName('EMAIL'       ).AsString ;
        vSenhaUsu    := Descriptografa(FieldByName('SENHASNAP').AsString) ;
        vPortaUsu    := FieldByName('PORTAENVIO'  ).AsString ;
        vServidorUsu := FieldByName('SERVIDORSMTP').AsString ;
        If IsEmpty Or
           (FieldByName('ADMINISTRADOR').AsString = 'N') Or
           (FieldByName('ATIVO').AsString = 'N') Then
        Begin
          MessageDlg('Usuário ' + IIf(IsEmpty,'não encontrado',
                                  IIf(FieldByName('ADMINISTRADOR').AsString = 'N','sem permissão para atualiza os sistemas'
                                                                                 ,'inativo. Consulte o administrador')) + '.', mtError, [mbOk], 0 );
          If Not vUsuarioManagerComSenhaUm Then
            Exit ;
        End ; // If IsEmpty Then

        Sql.Clear ;
        Sql.Add('SELECT SYSDATE') ;
        Sql.Add('  FROM DUAL') ;
        MostraMsg('Verificando data do sistema...') ;
        Open ;
        vDataHoraAtu := FieldByName('SYSDATE').AsDateTime ;

        Sql.Clear ;
        Sql.Add('SELECT VALOR') ;
        Sql.Add('  FROM CTR_DADOS_INI') ;
        Sql.Add(' WHERE MODULO = :P_MODULO') ;
        Sql.Add('   AND SECAO  = :P_SECAO' ) ;
        Sql.Add('   AND CHAVE  LIKE :P_CHAVE' ) ;
        ParamByName('P_MODULO').AsString := 'ATUALIZACAO' ;
        ParamByName('P_SECAO' ).AsString := 'INTERROMPIDA' ;
        ParamByName('P_CHAVE' ).AsString := 'INTERROMPIDA' ;
        MostraMsg('Verificando se a atualização anterior foi interrompida...') ;
        Open ;
        vSisAtu      := FieldByName('VALOR').AsString ;
        vContinuaAnt := False ;
        If Not IsEmpty Then
          vContinuaAnt := MessageDlg('Continua a atualização a partir do ponto da tentativa anterior?',mtConfirmation, [mbYes, mbNo], 0) = mrYes ;

        Sql.Clear ;
        Sql.Add('SELECT A.VALOR') ;
        Sql.Add('     , A.DATA AS DATAULTIMA') ;
        Sql.Add('  FROM CTR_DADOS_INI A') ;
        Sql.Add('     , (SELECT MAX(B.DATA) AS ULTIMAATU') ;
        Sql.Add('          FROM CTR_DADOS_INI B') ;
        Sql.Add('         WHERE MODULO = :P_MODULO') ;
        Sql.Add('           AND SECAO  = :P_SECAO' ) ;
        Sql.Add('       ) C') ;
        Sql.Add(' WHERE A.DATA = C.ULTIMAATU') ;
        Sql.Add('   AND MODULO = :P_MODULO' ) ;
        Sql.Add('   AND SECAO  = :P_SECAO' ) ;
        ParamByName('P_MODULO').AsString := 'ATUALIZACAO' ;
        ParamByName('P_SECAO' ).AsString := 'ULTIMAATUALIZACAO' ;
        MostraMsg('Verificando a ultima atualização...') ;
        Open ;
        vUltimaAtu.Achou := Not IsEmpty ;
        If vUltimaAtu.Achou Then
        Begin
          vUltimaAtu.Data     := FieldByName('DATAULTIMA').AsDateTime ;
          I := Pos('USU=',FieldByName('VALOR').AsString) ;
          If I > 0 Then
            vUltimaAtu.Usuario  := Copy(FieldByName('VALOR').AsString,I+4,Pos(',TP=' ,FieldByName('VALOR').AsString)-I-4) ;

          I := Pos('TP=' ,FieldByName('VALOR').AsString) ;
          If I > 0 Then
          Begin
            vUltimaAtu.Tipo     := Copy(FieldByName('VALOR').AsString,I+3,Pos(',SIS=',FieldByName('VALOR').AsString)-i-3) ;
            vUltimaAtu.DescTipo := IIf(vUltimaAtu.Tipo='C','Completa','Parcial') ;
          End ; // If I > 0 Then

          I := Pos('SIS=',FieldByName('VALOR').AsString) ;
          If I > 0 Then
            vUltimaAtu.Sistemas := Copy(FieldByName('VALOR').AsString,I+4,100) ;

        End Else // If vUltimaAtu.Achou Then
          PnlCompletaClick(PnlCompleta) ;

        Sql.Clear ;
        Sql.Add('  SELECT A.SISTEMA AS SIGLA') ;
        Sql.Add('       , B.NOMEDOSISTEMA') ;
        Sql.Add('       , B.DESCRICAODOSISTEMA') ;
        Sql.Add('       , B.NOMEDOSISTEMA AS PASTA') ;
        Sql.Add('       , B.NOMEDOSISTEMA AS NOMEEXE') ;
        Sql.Add('       , B.NOMEDOSISTEMA AS NOMEARQNOFTP') ;
        Sql.Add('       , SYSDATE AS DATAARQ') ;
        Sql.Add('       , 9 AS ATUALIZA') ;
        Sql.Add('       , 0 AS TAMANHOEXE') ;
        Sql.Add('       , ''N'' AS DOWJAEXISTE') ;
        Sql.Add('       , ''N'' AS ARQZIP') ;
        Sql.Add('       , ''N'' AS CONTINUAANT') ;
        Sql.Add('       , ''N'' AS PODEDESMARC') ;
        Sql.Add('       , -1 AS NOV_IMP') ;
        Sql.Add('    FROM CTR_AUTORIZACAOSISTEMAS A') ;
        Sql.Add('       , CTR_CADASTROSISTEMAS    B') ;
        Sql.Add('   WHERE A.SISTEMA          = B.SISTEMA') ;
        Sql.Add('     AND A.DATALIMITEDEUSO  > SYSDATE') ;
        If Trim(EdtIgSiglas.Text) <> '' Then
          Sql.Add('     AND A.SISTEMA NOT IN('+ EdtIgSiglas.Text +') ') ;
        Sql.Add('GROUP BY A.SISTEMA') ;
        Sql.Add('       , B.NOMEDOSISTEMA') ;
        Sql.Add('       , B.DESCRICAODOSISTEMA') ;
        MostraMsg('Verificando os sistemas disponíveis...') ;
        Open ;
        If IsEmpty Then
        Begin
          MessageDlg('Data além do limite de uso.', mtError, [mbOk], 0 ) ;
          If Not vUsuarioManagerComSenhaUm Then
            Exit ;
        End ; // If IsEmpty Then
        MDSistemas.LoadFromDataSet(QryPesquisa,0,lmCopy) ;

        Result := True ;
      End ; // With QryPesquisa Do
    Except On E:EDBEngineError do
      Begin
        If MessageDlg('Erro: Deseja ver o erro?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          MessageDlg(E.Errors[1].message, mtError, [mbOk], 0 ) ;
        Result := vUsuarioManagerComSenhaUm ;
      End ;
    End ; // Try
  End ; // Function ConectaUsuarioAoGlobus : Boolean ;

  Function DownloadJaExiste(pArquivo : String ; pData : TDateTime ; pZip : Boolean) : Boolean ;
  var
    SR : TSearchRec ;
    vArquivo : String ;
  Begin
    vArquivo := DriveComboBox.Drive + ':\GLOBUS\DOWNLOAD\' + pArquivo ;
    Result   := (FindFirst( vArquivo , faAnyFile, SR) = 0) And
                (pData < FileDateToDateTime(FileAge(vArquivo))) ;
    If Result And pZip Then
    Begin
      ZipMaster1.ZipFileName := vArquivo ;
      Result := ZipMaster1.ZipFileName <> '' ;
    End ; // If Result And ...
  End ; // Function DownloadJaExiste : Boolean ;

  Procedure AtualizaMDSistemas ;
  Var
    i        : Integer ;
    vInfoArq : TInfoArq ;
  Begin
    MDSistemas.DisableControls ;
    For i := 0 to IdFTP1.DirectoryListing.Count-1 do
      If IdFTP1.DirectoryListing.Items[i].ItemType <> ditDirectory then
      Begin
        vInfoArq := LocalisaInfoArq(Copy(IdFTP1.DirectoryListing.Items[i].FileName,1, Pos('.',IdFTP1.DirectoryListing.Items[i].FileName)-1 )) ;
        If vInfoArq.Achou And MDSistemas.Locate('SIGLA',vInfoArq.Sigla,[loCaseInsensitive]) Then
        Begin
          MDSistemas.Edit ;
          If MDSistemas.FieldByName('ATUALIZA').AsInteger = 9 Then
          Begin
            MDSistemas.FieldByName('PASTA'      ).AsString   := vInfoArq.Pasta ;
            MDSistemas.FieldByName('NOMEEXE'    ).AsString   := vInfoArq.Exe ;
            MDSistemas.FieldByName('ATUALIZA'   ).AsInteger  := IIf(vContinuaAnt,0,1) ;
            MDSistemas.FieldByName('PODEDESMARC').AsString   := 'S' ;
          End ; // If MDSistemas.FieldByName('ATUALIZA').AsInteger = 9 Then
          MDSistemas.FieldByName('NOMEARQNOFTP' ).AsString   := IdFTP1.DirectoryListing.Items[i].FileName ;

          MDSistemas.FieldByName('ARQZIP'       ).AsString   := IIf(Pos('.ZIP',UpperCase(IdFTP1.DirectoryListing.Items[i].FileName)) > 0,'S','N') ;
          MDSistemas.FieldByName('TAMANHOEXE'   ).AsFloat    := IdFTP1.DirectoryListing.Items[i].Size ;
          MDSistemas.FieldByName('DATAARQ'      ).AsDateTime := IdFTP1.DirectoryListing.Items[i].ModifiedDate ;
          If DownloadJaExiste(MDSistemas.FieldByName('NOMEARQNOFTP' ).AsString
                             ,MDSistemas.FieldByName('DATAARQ'      ).AsDateTime
                             ,MDSistemas.FieldByName('ARQZIP'       ).AsString = 'S') Then
          Begin
            MDSistemas.FieldByName('DOWJAEXISTE').AsString   := 'S' ;
            MDSistemas.FieldByName('ATUALIZA'   ).AsInteger  := 3 ;
            MDSistemas.FieldByName('CONTINUAANT').AsString   := IIf(vContinuaAnt And (Pos(MDSistemas.FieldByName('SIGLA').AsString,vSisAtu) > 0),'S','N') ;
          End ; // If DownloadJaExiste(...
          MDSistemas.Post ;
        End Else // If vInfoArq.Achou And ...
        If Pos(EdtArqNovid.Text,IdFTP1.DirectoryListing.Items[i].FileName) > 0 Then
        Begin
          If IdFTP1.Connected Then
          Begin
            Try
              IdFTP1.Get(IdFTP1.DirectoryListing.Items[i].FileName
                        ,ExtractFilePath(Application.ExeName) + EdtArqNovid.Text
                        ,True ) ;
            Except
            End ; // Try - Except
          End ;
        End Else // If Pos(EdtArqNovid.Text,...
        If Pos(EdtArqImple.Text,IdFTP1.DirectoryListing.Items[i].FileName) > 0 Then
        Begin
          If IdFTP1.Connected Then
          Begin
            Try
              IdFTP1.Get(IdFTP1.DirectoryListing.Items[i].FileName
                        ,ExtractFilePath(Application.ExeName) + EdtArqImple.Text
                        ,True ) ;
            Except
            End ; // Try - Except
          End ;
        End Else // If Pos(EdtArqImple.Text,...
        If (Not vInfoArq.Achou) And
           (Not MDSistemas.Locate('SIGLA',vInfoArq.Sigla,[loCaseInsensitive])) Then
        Begin
          If Not MDOutros.Locate('NOMEARQNOFTP',IdFTP1.DirectoryListing.Items[i].FileName,[loCaseInsensitive]) Then
            MDOutros.Append
          Else
            MDOutros.Edit ;
          MDOutros.FieldByName('NOMEARQNOFTP').AsString   := IdFTP1.DirectoryListing.Items[i].FileName ;
          MDOutros.FieldByName('TAMANHOEXE'  ).AsFloat    := IdFTP1.DirectoryListing.Items[i].Size ;
          MDOutros.FieldByName('DATAARQ'     ).AsDateTime := IdFTP1.DirectoryListing.Items[i].ModifiedDate ;
          MDOutros.FieldByName('ATUALIZA'    ).AsInteger  := 1 ;
          MDOutros.FieldByName('ATUALIZA'    ).AsInteger  := IIf(vContinuaAnt,0,1) ;
          MDOutros.FieldByName('ARQZIP'      ).AsString   := IIf(Pos('.ZIP',UpperCase(IdFTP1.DirectoryListing.Items[i].FileName)) > 0,'S','N') ;
          If DownloadJaExiste(MDOutros.FieldByName('NOMEARQNOFTP').AsString
                             ,MDOutros.FieldByName('DATAARQ'     ).AsDateTime
                             ,MDOutros.FieldByName('ARQZIP'      ).AsString = 'S') Then
          Begin
            MDOutros.FieldByName('DOWJAEXISTE').AsString  := 'S' ;
            MDOutros.FieldByName('ATUALIZA'   ).AsInteger := 3 ;
            MDOutros.FieldByName('CONTINUAANT').AsString  := IIf(vContinuaAnt And (Pos(MDOutros.FieldByName('SIGLA').AsString,vSisAtu) > 0),'S','N') ;
          End ; // If DownloadJaExiste(...
          MDOutros.Post ;
        End ; // If (Not vInfoArq.Achou) And (...

      End ; // If IdFTP1.DirectoryListing.Items[i].ItemType <> ditDirectory then

    MDSistemas.EnableControls ;
  End ; // Procedure AtualizaMDSistemas ;

  Procedure AtualizaMDNovImp(pArquivo : TEdit) ;
  Var
    vSigla,
    vLocalArq,
    vLinha      : String ;
    vArqNovImp  : TextFile ;
    vCodCliente : Integer ;
    vDataNov    : TDateTime ;
    Procedure EnDecryptFile( INFName, OutFName : String; Chave : Word ) ;
    Var InMS, OutMS: TMemoryStream ;
        I    : Integer;
        C    : Byte;
    Begin
      InMS  := TMemoryStream.Create ;
      OutMS := TMemoryStream.Create ;

      Try
        InMS.LoadFromFile( INFName ) ;
        InMS.Position := 0 ;

        For I := 0 To InMS.Size - 1 Do
        Begin
          InMS.Read( C, 1 ) ;
          C := ( C Xor Not( Ord( Chave Shr I ))) ;
          OutMS.Write(C,1) ;
        End ;  // For I := 0 To InMS.Size - 1 Do

        OutMS.SaveToFile( OutFName ) ;

      Finally
        InMS.Free ;
        OutMS.Free ;
      End ; // Try - Finally
    End ; // EnDecryptFile
  Begin
    vLocalArq := ExtractFilePath(Application.ExeName) + TEdit(pArquivo).Text ;
    If FileExists(vLocalArq) then
    Begin
      MostraMsg('Verificando as '+ IIf(pArquivo = EdtArqImple,'implementações','novidades') + '...') ;
      EnDecryptFile(vLocalArq, vLocalArq, 12 ) ;
      Try
        AssignFile(vArqNovImp, vLocalArq) ;
      Except
        Exit ;
      End ;
      Reset(vArqNovImp) ;

      If Not MDNovImp.Active Then
        MDNovImp.Open ;

      MDSistemas.AfterScroll := Nil ;
      MDNovImp.Filtered      := False ;
      While not EOF (vArqNovImp) do
      Begin
        ReadLn( vArqNovImp, vLinha ) ;
        vSigla := Trim(IIF(Copy(vLinha,1,3) = 'ATV','ATF',Copy(vLinha,1,3))) ;
        Try
          vDataNov := StrToDate(Trim(Copy(vLinha,560,10))) ;
        Except
          vDataNov := Date ;
        End ; // Try - Except

        Try
          vCodCliente := StrToIntDef(Trim(Copy(vLinha,571,5)),0) ;
        Except
          vCodCliente := 0 ;
        End ; // Try - Except

        If MDSistemas.Locate('SIGLA',vSigla,[loCaseInsensitive]) And
           ((vCodCliente = 0) Or (vCodCliente <> vcCodigoCliente)) Then
        Begin
          MDNovImp.Append ;
          MDNovImp.FieldByName('SIGLA'  ).AsString   := vSigla ;
          MDNovImp.FieldByName('TOPICO' ).AsString   := Trim(Copy(vLinha,06,050)) ;
          MDNovImp.FieldByName('ASSUNTO').AsString   := Trim(Copy(vLinha,57,500)) ;
          MDNovImp.FieldByName('DATA'   ).AsDateTime := vDataNov ;
          MDNovImp.FieldByName('TIPO'   ).AsString   := IIf(pArquivo = EdtArqImple,'I','N') ;
          If pArquivo = EdtArqImple Then
            MDNovImp.FieldByName('LOCMODULO' ).AsString := Trim(Copy(vLinha,06,050)) ;

          MDNovImp.Post ;

          MDSistemas.Edit ;
          MDSistemas.FieldByName('NOV_IMP').AsInteger := 4 ;
          MDSistemas.Post ;
        End ;
      End ; // While not EOF (vArqNovImp) do
      CloseFile(vArqNovImp) ;

      PnlEnvEmaiUsu.Visible := MDNovImp.Locate('TIPO','I',[loCaseInsensitive]) ;

      MDSistemas.AfterScroll := MDSistemasAfterScroll ;
      MDNovImp.SortOnFields('TIPO;SIGLA') ;

      If FileExists(vLocalArq) Then
        DeleteFile(vLocalArq) ;
    End ; // If FileExists(vLocalArq) then
  End ; // Procedure AtualizaMDNovImp ;
begin
  If (Trim(EdtUsuGlobus.Text) = '') Or (Trim(EdtSenhaGlobus.Text) = '') Then
  Begin
    EdtUsuGlobus.SetFocus ;
    Exit ;
  End ; // If (Trim(EdtUsuGlobus.Text) = '') Or (...

  MDNovImp.EmptyTable ;
  MDSistemas.EmptyTable ;

  SBarMsg.Visible := True ;
  MostraMsg('') ;
  Screen.Cursor := crHourGlass ;

  vConectoGlobus := ConectaUsuarioAoGlobus ;
  If vConectoGlobus Or vUsuarioManagerComSenhaUm Then
  Begin
    If vArqIniOk And (Not vConectoFTP) Then
    Begin
      vConectoFTP := ConectaUsuarioAoFTP ;
      vArqIniOk   := vConectoFTP ;
    End ; // If vArqIniOk And (...

    BitBtnGeraINI.Visible := vUsuarioManagerComSenhaUm ;
    If vUsuarioManagerComSenhaUm Then
    Begin
      If Not vArqIniOk Then
      Begin
        Screen.Cursor := crDefault ;
        BitBtnGeraINIClick(Sender) ;
        Exit ;
      End Else // If Not vArqIniOk Then
      If Not vConectoFTP Then
        vConectoFTP := ConectaUsuarioAoFTP ;
    End ; // If vUsuarioManagerComSenhaUm Then

    MostraMsg('Verificando se existe usuários conectados...') ;
    Timer2Timer(Sender) ;

    MostraMsg('Verificando os módulos disponíveis para atualização...') ;
    AtualizaMDSistemas ;

    AtualizaMDNovImp(EdtArqNovid) ;
    AtualizaMDNovImp(EdtArqImple) ;
    Totais ;

    HabilitaBotoes ;
    If BitBtnAvaAtu.CanFocus Then
      BitBtnAvaAtu.SetFocus ;
  End ; // If vConectoGlobus Or ...

  SBarMsg.Visible := vUsuarioManagerComSenhaUm ;
  SBarMsg.Panels[0].Text := '('+ vcServerName +'/'+ vcUserName + '/'+ UpperCase(vDriveDir) + ')' ;

  Screen.Cursor := crDefault ;

  HabilitaBotoes ;
end;

function TFrmTelaPrincipal.Encripta(sCampo: String; iQtdChar: Byte; Posicional: Boolean): String;
Var I          : Byte;
    iAux       : LongInt;
    oRes, nRes : String;
Begin
  iAux := 0;
  sCampo := AnsiUpperCase( sCampo ) ;
  { Adiciona 32 ao código ASCII de cada caracter da string e
    acumula seus respectivos códigos em um somador }
  For I := 1 To Length( sCampo ) Do
  Begin
    If Posicional Then
      Inc( iAux, Ord( sCampo[I] ) * I)
    Else
      Inc( iAux, Ord( sCampo[I] ) + 32 );
  End;
  { Retorna as 10 primeiras posições do resultado da divisão
    do somador por 357 }
  oRes := Copy( FloatToStr(iAux / 357), 1, iQtdChar );
  nRes := '';
  For I := 1 To Length(oRes) Do
  begin
    If Copy(oRes,I,1) = ',' Then
      nRes := nRes + '.'
    else
      nRes := nRes + Copy(oRes,I,1);
  end;
  Result := nRes;
end;

function TFrmTelaPrincipal.IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant;
begin
  If pCondicao Then
    Result := pResultTrue
  else
    Result := pResultFalse;
end;

procedure TFrmTelaPrincipal.Totais ;
Var
  vRegAtual : TBookmark ;
  vTotTaman : Real ;
  vQtdeArq  : Integer ;
begin
  With MDSistemas do
  Begin
    DisableControls ;
    vRegAtual := GetBookmark ;
    vTotTaman := 0 ;
    vQtdeArq  := 0 ;
    vSisAtu   := '' ;
    First ;
    While Not Eof do
    Begin
      If (Pos(MDSistemas.FieldByName('ATUALIZA').AsString,'1_3') > 0) And (Trim(FieldByName('SIGLA').AsString) <> '') Then
      Begin
        vTotTaman := vTotTaman + FieldByName('TAMANHOEXE').AsFloat ;
        vSisAtu   := vSisAtu   + FieldByName('SIGLA'     ).AsString + ',' ;
        Inc(vQtdeArq) ;
      End ; // If (Pos(MDSistemas.FieldByName('ATUALIZA').AsString,'1_3') > 0) And (...
      Next
    End ; // While Not pMD.Eof do
    GotoBookmark(vRegAtual) ;
    FreeBookmark(vRegAtual) ;
    EnableControls ;

    vSisAtu             := Copy(vSisAtu,1,Length(vSisAtu)-1) ;
    LblQtdeArq.Caption  := FormatFloat('#',vQtdeArq) ;
    LblTotTaman.Caption := FormatFloat('#',vTotTaman) ;
  End ; // With MDSistemas do

  HabilitaBotoes ;
end;

procedure TFrmTelaPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
  HabilitaBotoes ;
end;

procedure TFrmTelaPrincipal.DriveComboBoxChange(Sender: TObject);
begin
  Try
    LblTamanDispo.Caption := FormatFloat('#',DiskFree( ord( DriveComboBox.Drive )-64 )) ;
  Except
  End;
end;

procedure TFrmTelaPrincipal.DBGridSistemasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  If Column.Field.FieldName = 'ATUALIZA' Then
  Begin
    TDBGrid(Sender).Canvas.FillRect(Rect) ;
    IListSistemas.Draw(TDBGrid(Sender).Canvas
                      ,Rect.Left+1
                      ,Rect.Top+1
                      ,IIf(MDSistemas.IsEmpty,-1, IIf(MDSistemas.FieldByName('ATUALIZA').AsInteger = 9,2
                                                                                                      ,MDSistemas.FieldByName('ATUALIZA').AsInteger))
                      ) ;
  End Else // If Column.Field.FieldName = 'ATUALIZA' Then
  If Column.Field.FieldName = 'NOV_IMP' Then
  Begin
    TDBGrid(Sender).Canvas.FillRect(Rect) ;
    IListSistemas.Draw(TDBGrid(Sender).Canvas
                      ,Rect.Left+1
                      ,Rect.Top+1
                      ,IIf(MDSistemas.IsEmpty,-1, IIf(MDSistemas.FieldByName('NOV_IMP').AsInteger=4,4,-1))
                      ) ;
  End Else // If Column.Field.FieldName = 'NOV_IMP' Then
  If Column.Field.FieldName = 'TIPO' Then
  Begin
    TDBGrid(Sender).Canvas.FillRect(Rect) ;
    IListSistemas.Draw(TDBGrid(Sender).Canvas
                      ,Rect.Left+1
                      ,Rect.Top+1
                      ,IIf(MDNovImp.IsEmpty,-1, IIf(MDNovImp.FieldByName('TIPO').AsString='I',5,6) )
                      ) ;
  End ; // If Column.Field.FieldName = 'TIPO' Then
end;

procedure TFrmTelaPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  Procedure GravaDados_Ini ;
  begin
    With QryPesquisa do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add('SELECT VALOR') ;
      Sql.Add('  FROM CTR_DADOS_INI') ;
      Sql.Add(' WHERE MODULO = :P_MODULO') ;
      Sql.Add('   AND SECAO  = :P_SECAO' ) ;
      Sql.Add('   AND CHAVE  = :P_CHAVE' ) ;
      ParamByName('P_MODULO').AsString := 'ATUALIZACAO' ;
      ParamByName('P_SECAO' ).AsString := 'INTERROMPIDA' ;
      ParamByName('P_CHAVE' ).AsString := 'INTERROMPIDA' ;
      Open ;
      If IsEmpty Then
      Begin
        Sql.Clear ;
        Sql.Add('INSERT INTO CTR_DADOS_INI (MODULO, SECAO, CHAVE, VALOR, DATA, ITEM)') ;
        Sql.Add('VALUES (:P_MODULO, :P_SECAO, :P_CHAVE, :P_VALOR, :P_DATA, :P_ITEM)' );
        ParamByName('P_ITEM'  ).AsInteger := 1 ;
      End Else // If IsEmpty Then
      Begin
        Sql.Clear ;
        Sql.Add('UPDATE CTR_DADOS_INI');
        Sql.Add('   SET VALOR  = :P_VALOR');
        Sql.Add('     , DATA   = :P_DATA');
        Sql.Add(' WHERE MODULO = :P_MODULO') ;
        Sql.Add('   AND SECAO  = :P_SECAO' ) ;
        Sql.Add('   AND CHAVE  = :P_CHAVE' ) ;
      End ; // End Else // If IsEmpty Then
      ParamByName('P_MODULO').AsString   := 'ATUALIZACAO' ;
      ParamByName('P_SECAO' ).AsString   := 'INTERROMPIDA' ;
      ParamByName('P_CHAVE' ).AsString   := 'INTERROMPIDA' ;
      ParamByName('P_DATA'  ).AsDateTime := Now ;
      ParamByName('P_VALOR' ).AsString   := 'USU='  + EdtUsuGlobus.Text
                                          + ',TP='  + vTpAtualizacao
                                          + ',SIS=' + vSisAtu ;
      Try
        ExecSQL ;
      Except
      End ;
    End ; // With QryPesquisa do
  End ; // Procedure GravaDados_Ini ;
begin
  If (PnlBarras.Parent = PnlAtualizacao) And (PnlUsuConect.Parent <> PnlAtualizacao) Then
  Begin
    CanClose := False ;
    MessageDlg('A atualização não pode ser interrompida!', mtInformation, [mbOk], 0 );
  End Else // If PnlBarras.Parent = PnlAtualizacao Then
  If PnlFim.Parent <> PnlAtualizacao then 
    CanClose := MessageDlg('Deseja realmente sair da atualização?',mtConfirmation, [mbYes, mbNo], 0) = mrYes ;

  If CanClose And vConectoGlobus Then
  Begin
    Try
      If IdFTP1.Connected then
      try
        IdFTP1.Quit ;
      Finally
      End ; // Try - Except

      If (PnlBarras = PnlAtualizacao) And (PnlUsuConect.Parent = PnlAtualizacao) Then
      Begin
        GravaDados_Ini ;
        GravaLog('Atualizacao interropida. Usuario(s) conectado no(s) modulo(s)') ;
      End ; // If (PnlBarras = PnlAtualizacao) And (...

      With QryPesquisa do
      Begin
        Sql.Clear ;
        Sql.Add('DELETE CTR_ATUALIZABASE') ;
        Try
          ExecSQL ;
        Except
        End ;
      End ; // With QryPesquisa do

      DbBgm.Connected := False ;
    Except
      Application.Terminate ;
    End ;
  End ; // If CanClose And ...
end;

procedure TFrmTelaPrincipal.GravaLog(pTextoLog: String);
Var
  vDataHora : String ;
  vCodLog   : Integer ;
Begin
  With QryPesquisa Do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add('SELECT MAX(CODIGOLOG) CODIGOLOG') ;
    Sql.Add('  FROM CTR_LOG');
    Open ;
    vCodLog := FieldByName('CODIGOLOG').AsInteger ;

    Sql.Clear ;
    Sql.Add('SELECT SQCTR_LOG.NEXTVAL - 1 AS CODIGOLOG') ;
    Sql.Add('  FROM DUAL') ;
    Open ;
    While FieldByName('CODIGOLOG').AsInteger < vCodLog do
    Begin
      Close ;
      Open ;
    End ; // While FieldByName('CODIGOLOG').AsInteger < vCodLog do

    vCodLog := IIf(IsEmpty,1, FieldByName('CodigoLog').asInteger + 1) ;

    Sql.Clear ;
    Sql.Add('SELECT TO_CHAR(SYSDATE,''DD/MM/YYYY HH24:MI:SS'') AS DATAHORA') ;
    Sql.Add('  FROM DUAL') ;
    Open ;
    vDataHora  := FieldByName('DATAHORA').AsString ;
    Sql.Clear ;
    Sql.Add('INSERT INTO CTR_LOG (CODIGOLOG, SISTEMA, USUARIO, DATALOG, HORALOG, TEXTOLOG, CHECKSUMLOG)') ;
    Sql.Add('Values (:P_CODIGOLOG, :P_SISTEMA, :P_USUARIO, :P_DATALOG, :P_HORALOG, :P_TEXTOLOG, :P_CHECKSUMLOG)' );
    ParamByName('P_CODIGOLOG'  ).AsInteger  := vCodLog ;
    ParamByName('P_SISTEMA'    ).AsString   := 'CTR' ;
    ParamByName('P_USUARIO'    ).AsString   := EdtUsuGlobus.Text ;
    ParamByName('P_DATALOG'    ).AsDate     := Date ;
    ParamByName('P_HORALOG'    ).AsDateTime := Now ;
    ParamByName('P_TEXTOLOG'   ).AsString   := pTextoLog ;
    ParamByName('P_CHECKSUMLOG').AsString   := Encripta('CTR' + EdtUsuGlobus.Text + vDataHora + pTextoLog, 10) ;
    Try
      ExecSQL ;
    Except
    End ;
  End ; // With QryPesquisa Do
End ; // Procedure GravaLog ;

procedure TFrmTelaPrincipal.BitBConfirmaFTPClick(Sender: TObject);
var
  ServerIni : TIniFile ;
  i : Integer ;
begin
  BitBConfirmaFTP.Enabled := False ;

  ServerIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini') ;
  If FileExists(ServerIni.FileName) Then
    DeleteFile(ServerIni.FileName) ;
  ServerIni.WriteString('FTP',   'HOST',      Criptografa(EdtHostFTP.Text) );
  ServerIni.WriteString('FTP',   'USUARIO',   Criptografa(EdtUsuFTP.Text) ) ;
  ServerIni.WriteString('FTP',   'SENHA',     Criptografa(EdtSenFTP.Text) ) ;
  ServerIni.WriteString('FTP',   'DIRETORIO', Criptografa(EdtDirFTP.Text) ) ;
  ServerIni.WriteString('CONTA', 'EMAILORIG', Criptografa(EdtEMailOrigem.Text) ) ;
  ServerIni.WriteString('CONTA', 'SMTP',      Criptografa(EdtServSMTP.Text) ) ;
  ServerIni.WriteString('CONTA', 'PORTA',     Criptografa(NEdtPorta.Text) ) ;
  ServerIni.WriteString('CONTA', 'SENHAEMAIL',Criptografa(EdtSenhaEMail.Text) );
  ServerIni.WriteString('CONTA', 'EMAILDEST', Criptografa(EdtEMailDest.Text) ) ;
  ServerIni.WriteString('NMSIS', 'SIGLAS',    Criptografa(EdtIgSiglas.Text) ) ;
  ServerIni.WriteString('ARQ',   'NOVID',     Criptografa(EdtArqNovid.Text) ) ;
  ServerIni.WriteString('ARQ',   'IMPLE',     Criptografa(EdtArqImple.Text) ) ;
  ServerIni.WriteString('LOG',   'EMAIL',     Criptografa(EdtEMailLog.Text ) ) ;
  ServerIni.WriteString('LOG',   'NFANTASIA', Criptografa(EdtNFantasia.Text) ) ;
  i := 0 ;
  MDOutros.First ;
  While Not MDOutros.Eof do
  Begin
    If (Trim(MDOutros.FieldByName('NOMEDOSISTEMA').AsString) <> '') And
       (Trim(MDOutros.FieldByName('PASTA'        ).AsString) <> '') Then
    Begin
      Inc(i) ;
      ServerIni.WriteString('OUTROS', 'ARQ'   + IntToStr(i), Criptografa(MDOutros.FieldByName('NOMEARQNOFTP' ).AsString) ) ;
      ServerIni.WriteString('OUTROS', 'NOME'  + IntToStr(i), Criptografa(MDOutros.FieldByName('NOMEDOSISTEMA').AsString) ) ;
      ServerIni.WriteString('OUTROS', 'SIGLA' + IntToStr(i), Criptografa(MDOutros.FieldByName('SIGLA'        ).AsString) ) ;
      ServerIni.WriteString('OUTROS', 'PASTA' + IntToStr(i), Criptografa(MDOutros.FieldByName('PASTA'        ).AsString) ) ;
    End ; // If (Trim(MDOutros.FieldByName('NOMEDOSISTEMA').AsString) <> '') And (...
    MDOutros.Next ;
  End ; // While Not MDOutros.Eof do

  ServerIni.UpdateFile ;
  ServerIni.Free ;

  If Sender = BitBtnAvaAtu Then
    Exit ;

  If IdFTP1.Connected then
  Begin
    try
      IdFTP1.Abort ;
      IdFTP1.Quit ;
    Finally
    End // Try - Except
  End ; // If IdFTP1.Connected then

  vConectoFTP := ConectaUsuarioAoFTP ;
  vArqIniOk   := vConectoFTP ;
  BitBConfirmaFTP.Enabled := True ;
  If vConectoFTP Then
  Begin
    PnlDestUsus.Enabled  := True ;
    PnlBotoes.Enabled    := True ;
    PnlParan.Parent      := TabSParametros ;
    BitBConfirmaGlobusClick(Sender) ;
  End Else // If vConectoFTP Then
    EdtHostFTP.SetFocus ;
end;

function TFrmTelaPrincipal.ConectaUsuarioAoFTP(pPassive : Boolean = True) : Boolean ;
Var
  LS : TStringList ;
Begin
  Result := True ;
  Try
    If IdFTP1.Connected then
      try
        IdFTP1.Abort ;
        IdFTP1.Quit ;
      Finally
      End // Try - Except
    Else // If IdFTP1.Connected then
    Begin
      MostraMsg('Conectando na área de FTP...') ;
      With IdFTP1 do
      Try
        Username := EdtUsuFTP.Text ;
        Password := EdtSenFTP.Text ;
        Host     := EdtHostFTP.Text ;
        Passive  := pPassive ;
        Connect ;
      Except
        Result := False ;
      End ; // Try - Except

      If Result Then
      Begin
        MostraMsg('Pesquisando arquivos disponíveis na área de FTP...') ;
        LS := TStringList.Create ;
        Try
          IdFTP1.ChangeDir(EdtDirFTP.Text) ;
          IdFTP1.TransferType := ftASCII ;
          IdFTP1.List(LS) ;
          Result := IdFTP1.DirectoryListing.Count-1 <> 0 ;
        Except
          Result := False ;
        End ; // Try - Except
        LS.Free ;
      End ;

    End ; // Else // If IdFTP1.Connected then
    MostraMsg('') ;
  Except
    Result := False ;
  End ; // Try - Except

  If Not Result Then
  Begin
    If IdFTP1.Connected then
    Begin
      try
        IdFTP1.Abort ;
        IdFTP1.Quit ;
      Finally
      End // Try - Except
    End ; // If IdFTP1.Connected then

    If Not pPassive Then
      ConectaUsuarioAoFTP(False)
    Else
      MessageDlg('Não foi possivel conectar na área de FTP da BgmRodotec.', mtError, [mbOk], 0 ) ;
  End ; // If Not Result Then
end;

procedure TFrmTelaPrincipal.MostraMsg(pMsg: String);
begin
  SBarMsg.Panels[0].Text := pMsg ;
  FrmTelaPrincipal.Refresh ;
end;

procedure TFrmTelaPrincipal.BitCancelarParamClick(Sender: TObject);
begin
  PnlDestUsus.Enabled  := True ;
  PnlBotoes.Enabled    := True ;
  PnlParan.Parent      := TabSParametros ;
  BitBConfirmaGlobus.SetFocus ;
end;

procedure TFrmTelaPrincipal.BitBtnGeraINIClick(Sender: TObject);
begin
  PnlDestUsus.Enabled := False ;
  PnlBotoes.Enabled   := False ;
  PnlParan.Parent     := PnlAtualizacao ;
  PnlParan.Top        := Trunc((PnlAtualizacao.Height - PnlParan.Height) / 2 ) ;
  PnlParan.Left       := Trunc((PnlAtualizacao.Width  - PnlParan.Width)  / 2 ) ;
  SButOutros.Enabled  := vConectoFTP And (Not MDOutros.IsEmpty);
  EdtHostFTP.SetFocus ;
end;

procedure TFrmTelaPrincipal.DBGridSistemasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key  = vk_Space Then
    IMenuMarcaDesmarcaClick(IMenuMarcaDesmarca) ;
end;

procedure TFrmTelaPrincipal.IMenuMarcaDesmarcaClick(Sender: TObject);
Var
  vRegAtual : TBookmark ;
  vTodos    : Boolean ;
  vAtualiza : Integer ;
begin
  PMenuGeralPopup(Sender) ;

  If TMenuItem(Sender).Visible And (vTpAtualizacao = 'P') Then
  Begin
    With MDSistemas do
    Begin
      DisableControls ;
      vRegAtual := GetBookmark ;
      vTodos    := Pos('Todos',TMenuItem(Sender).Name) > 0 ;

      If vTodos Then First ;
      While Not Eof do
      Begin
        vAtualiza := IIf(MDSistemas.FieldByName('PODEDESMARC').AsString = 'N',MDSistemas.FieldByName('ATUALIZA').AsInteger
                                                                             ,IIf(vTodos,TMenuItem(Sender).Tag
                                                                                        ,IIf(FieldByName('ATUALIZA').AsInteger=0,1,0))) ;
        If FieldByName('DOWJAEXISTE').AsString='S' Then
          vAtualiza := IIf(vAtualiza<>0,3,0) ;
        Edit ;
        FieldByName('ATUALIZA').AsInteger := vAtualiza ;
        Post ;
        If vTodos Then
           Next
        Else
          Break ;
      End ; // While Not pMD.Eof do

      GotoBookmark(vRegAtual) ;
      FreeBookmark(vRegAtual) ;
      EnableControls ;
    End ; // With MDSistemas do
    Totais ;

    HabilitaBotoes ;
  End ; // If TMenuItem(Sender).Visible And (...
end;

procedure TFrmTelaPrincipal.PMenuGeralPopup(Sender: TObject);
begin
  IMenuLegenda.Visible        := True ;
  IMenuMarcaDesmarca.Visible  := vTpAtualizacao = 'P' ;
  IMenuMarcaTodos.Visible     := IMenuMarcaDesmarca.Visible ;
  IMenuDesMarcarTodos.Visible := IMenuMarcaDesmarca.Visible ;
  IMenoNovImp.Visible         := MDSistemas.FieldByName('NOV_IMP').AsInteger = 4 ;
end;

procedure TFrmTelaPrincipal.IMenuLegendaClick(Sender: TObject);
begin
  If IMenuLegenda.Visible Then
  Begin
    PnlLegenda.Parent := PnlAtualizacao ;
    PnlLegenda.Top    := Trunc((PnlAtualizacao.Height - PnlLegenda.Height) / 2 ) ;
    PnlLegenda.Left   := Trunc((PnlAtualizacao.Width  - PnlLegenda.Width)  / 2 ) ;
    PnlLegenda.SetFocus ;
  End ; // If IMenuLegenda.Visible Then
end;

procedure TFrmTelaPrincipal.PnlLegendaExit(Sender: TObject);
begin
  PnlLegenda.Parent := TabSParametros ;
  DBGridSistemas.SetFocus ;
end;

procedure TFrmTelaPrincipal.BitBtnCancelarClick(Sender: TObject);
begin
  Close ;
end;

procedure TFrmTelaPrincipal.Timer2Timer(Sender: TObject);
Var
  vSistemas : String ;
begin
  If DbBGM.Connected Then
    With QryPesquisa Do
    Begin
      vSistemas := '' ;
      If vTpAtualizacao = 'P' Then
      Begin
        MDSistemas.First ;
        While Not MDSistemas.Eof do
        Begin
          If (Pos(MDSistemas.FieldByName('ATUALIZA').AsString,'1_3') > 0) And (Trim(MDSistemas.FieldByName('SIGLA').AsString) <> '') Then
            vSistemas := vSistemas + QuotedStr( MDSistemas.FieldByName('SIGLA').AsString  ) ;
          MDSistemas.Next ;
          If (Trim(vSistemas) <> '') And (Pos(MDSistemas.FieldByName('ATUALIZA').AsString,'1_3') > 0) And (Trim(MDSistemas.FieldByName('SIGLA').AsString) <> '') And (Not MDSistemas.Eof) Then
            vSistemas := vSistemas + ','
        End ; // While Not Eof do
      End ; // If vTpAtualizacao = 'P' Then
      Close ;
      Sql.Clear ;
      Sql.Add('SELECT A.USUARIOGLOBUS') ;
      Sql.Add('     , A.SISTEMA') ;
      Sql.Add('     , A.ESTACAO') ;
      Sql.Add('     , B.NOMEDOSISTEMA') ;
      Sql.Add('  FROM '+ cTabelaDeLicencas +' A') ;
      Sql.Add('     , CTR_CADASTROSISTEMAS B') ;
      Sql.Add(' WHERE A.SISTEMA = B.SISTEMA') ;
      If vSistemas <> '' Then
        Sql.Add('   AND A.SISTEMA IN ('+ vSistemas +')' );
      Try
        Open ;
      Except
      End ; // Try - Except
      Timer2.Enabled        := (Not IsEmpty) And (PnlBarras.Parent = PnlAtualizacao) ;
      BitBContinuar.Enabled := IsEmpty Or (PnlDestUsus.Parent = PnlAtualizacao) ;
      If (Not IsEmpty) And (PnlUsuConect.Parent = TabSUsuConect) Then
      Begin
        PnlUsuConect.Parent := PnlAtualizacao ;
        PnlUsuConect.Top    := Trunc((PnlAtualizacao.Height - PnlUsuConect.Height) / 2 ) ;
        PnlUsuConect.Left   := Trunc((PnlAtualizacao.Width  - PnlUsuConect.Width)  / 2 ) ;
        DBGridUsuarios.SetFocus ;
        PnlBotoes.Enabled   := False ;
      End ; // If (Not IsEmpty) And (...
    End ; // With QryPesquisa Do
end;

procedure TFrmTelaPrincipal.IdFTP1Status(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: String);
begin
  SBarMsg.Panels[0].Text := AStatusText ;
end;

procedure TFrmTelaPrincipal.IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
Var
  S: String ;
  TotalTime : TDateTime ;
  H, M, Sec, MS: Word ;
  DLTime : Double ;
  vAWorkCount : Integer ;
begin
  vAWorkCount  := vAWorkCountAnt + AWorkCount ;
  TotalTimeTot := Now - STimeTot ;

  DecodeTime(TotalTimeTot, HTot, MTot, SecTot, MSTot) ;
  SecTot := SecTot + MTot * 60 + HTot * 3600 ;
  DLTime := SecTot + MSTot / 1000 ;
  If DLTime > 0 then
    AverageSpeedTot := (vAWorkCount / 1024) / DLTime ;

  If AverageSpeedTot > 0 then
  Begin
    SecTot := Trunc(((PBarra2.Max - vAWorkCount) / 1024) / AverageSpeedTot) ;
    S      := Format('%2d:%2d:%2d', [SecTot div 3600, (SecTot div 60) mod 60, SecTot mod 60]) ;
    S      := 'Tempo restante : ' + S ;
  End Else
    S := '' ;

  PnlTituloBar2.Caption := 'KB Transferidos: ' + FormatFloat('0.00 KB/s', AverageSpeedTot) + ', ' + S ;
  PBarra2.Position := vAWorkCount ;

  TotalTime :=  Now - STime ;
  DecodeTime(TotalTime, H, M, Sec, MS) ;
  Sec := Sec + M * 60 + H * 3600 ;
  DLTime := Sec + MS / 1000 ;
  If DLTime > 0 then
    AverageSpeed := (AWorkCount / 1024) / DLTime ;

  If AverageSpeed > 0 then
  Begin
    Sec := Trunc(((PBarra3.Max - AWorkCount) / 1024) / AverageSpeed) ;
    S   := Format('%2d:%2d:%2d', [Sec div 3600, (Sec div 60) mod 60, Sec mod 60]) ;
    S   := 'Tempo restante : ' + S ;
  End Else
    S := '' ;

  PnlTituloBar3.Caption := 'KB Transferidos: ' + FormatFloat('0.00 KB/s', AverageSpeed) + ', ' + S ;
  PBarra3.Position := AWorkCount ;

  Application.ProcessMessages ;
end;

procedure TFrmTelaPrincipal.IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  STime := Now ;

  If AWorkCountMax > 0 then
  Begin
    PBarra2.Max := AWorkCountMax ;
    PBarra3.Max := AWorkCountMax ;
  End Else // If AWorkCountMax > 0 then
  Begin
    PBarra2.Max := StrToInt(Trim(LblTotTaman.Caption)) ;
    PBarra3.Max := vBytesTransf ;
  End ; // End Else // If AWorkCountMax > 0 then
  AverageSpeed := 0 ;
end;

procedure TFrmTelaPrincipal.IdFTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  PnlTituloBar3.Caption := 'Download completado' ;
  vBytesTransf          := 0 ;
  PBarra3.Position      := 0 ;
  vAWorkCountAnt        := PBarra2.Position ;
  AverageSpeed          := 0 ;
end;

procedure TFrmTelaPrincipal.ZipMaster1Progress(Sender: TObject; ProgrType: ProgressType; Filename: String; FileSize: Integer);
begin
  If Trim(Filename) <> '' Then
  Begin
    If PBarra1.Tag = 1 Then
      PBarra1.Position    := PBarra1.Position + 1 ;
    PnlTituloBar2.Caption := Filename ;
    PBarra2.Position      := FileSize ;
  End ; // If Trim(Filename) <> '' Then
end;

procedure TFrmTelaPrincipal.MDSistemasAfterOpen(DataSet: TDataSet);
begin
 (MDSistemas.FieldByName('DATAARQ') As TDateTimeField).DisplayFormat := 'DD/MM/YYYY HH:NN:SS' ;
end;

procedure TFrmTelaPrincipal.ButLogAtuClick(Sender: TObject);
Var
  vfrmExibicao : TForm ;
  vLbl         : TLabel ;
  vMemo        : TRichEdit ;
  Function DesCompactaArquivo(pArquivo : String) : Boolean ;
  var
    i: Integer;
    vBuf  : array[0..1023] of Byte ;
    vArqMenuIni,
    vArqMenuOut     : TFileStream ;
    vDesCompacta    : TDecompressionStream ;
    vArquivoDestino : String ;
  begin
    Result := False ;
    If Not FileExists(pArquivo) Then
    Begin
      MessageDlg('Arquivo (' + pArquivo + ') não encontrado.', mtError, [mbOk], 0 ) ;
      Exit ;
    End ; // If Not FileExists(pArquivo) Then

    vArquivoDestino := pArquivo + '2' ;
    Try
      vArqMenuIni  := TFileStream.Create(pArquivo,        fmOpenRead and fmShareExclusive);
      vArqMenuOut  := TFileStream.Create(vArquivoDestino, fmCreate   or  fmShareExclusive);
      vDesCompacta := TDecompressionStream.Create(vArqMenuIni) ;
      Repeat
        i := vDesCompacta.Read(vBuf, SizeOf(vBuf));
        If i <> 0 then
          vArqMenuOut.Write(vBuf, i);
      Until i <= 0 ;
      vDesCompacta.Free ;
      vArqMenuOut.Free ;
      vArqMenuIni.Free ;
    Except
      Begin
        MessageDlg('Erro na compactação do arquivo.', mtError, [mbOk], 0 ) ;
        Exit ;
      End ;
    End ; // Try - Except

    FileSetAttr(vArquivoDestino,1) ;
    FileSetAttr(pArquivo,0) ;

    ButLogAtu.Hint := vArquivoDestino ;
    Result := True ;
  End ; // Function DesCompactaArquivo(pArquivo : String) : Boolean ;
begin
  If Not DesCompactaArquivo(ButLogAtu.Hint) Then
    Exit ;

  vfrmExibicao := TForm.Create(Application);
  With vfrmExibicao Do
  begin
    BorderIcons  := [];
    BorderStyle  := bsSingle ;
    Color        := clTeal ;
    Position     := poScreenCenter ;
    WindowState  := wsMaximized;
    BorderIcons  := [biSystemMenu];
    Position     := poScreenCenter;
    Caption      := 'Análise do Log de atualização do sistema';

    vLbl := TLabel.Create(Application) ;
    With vLbl do
    Begin
      Parent     := vfrmExibicao;
      Name       := 'lblAtu';
      Font.Color := clAqua; // Não altere esta linha
      Font.Size  := 14;
      Font.Style := [fsBold];
      Height     := 20;
      Align      := alTop;
      Caption    := 'Arquivo: ' + ButLogAtu.Hint ;
    End ; // With vLbl do

    vMemo := TRichEdit.Create(Application);
    With vMemo Do
    Begin
      Parent     := vfrmExibicao ;
      Name       := 'memErro' ;
      Align      := alClient ;
      ReadOnly   := True ;
      ScrollBars := ssVertical ;
      Lines.LoadFromFile(ButLogAtu.Hint) ;
    End ; // With vMemo Do
    ShowModal ;
    Free ;
  End ;
end;

procedure TFrmTelaPrincipal.SakSMTP1Connect(Sender: TObject);
begin
  PnlTituloBar3.Caption := 'Enviar mensagem usando (' + Trim(EdtEMailOrigem.Text) + ')' ;
  PBarra3.Max           := SakSMTP1.InstanceSize ;
  STimeTot              := Now ;
  vAWorkCountAnt        := 0 ;
end;

procedure TFrmTelaPrincipal.SakSMTP1SendProgress(Sender: TObject; Percent: Word);
Var
  S: String ;
  TotalTime    : TDateTime ;
  H, M, Sec, MS: Word ;
  DLTime       : Double ;
  vAWorkCount  : Integer ;
begin
  vAWorkCount  := vAWorkCountAnt + Percent ;
  TotalTime    := Now - STimeTot ;

  DecodeTime(TotalTime, H, M, Sec, MS) ;
  Sec := Sec + M * 60 + H * 3600 ;
  DLTime := Sec + MS / 1000 ;
  If DLTime > 0 then
    AverageSpeedTot := (vAWorkCount / 1024) / DLTime ;

  If AverageSpeedTot > 0 then
  Begin
    Sec := Trunc(((PBarra3.Max - vAWorkCount) / 1024) / AverageSpeedTot) ;
    S   := Format('%2d:%2d:%2d', [Sec div 3600, (Sec div 60) mod 60, Sec mod 60]) ;
    S   := 'Tempo restante : ' + S ;
  End Else
    S := '' ;

  PnlTituloBar3.Caption := 'KB Transferidos: ' + FormatFloat('0.0000 KB/s', AverageSpeedTot) + ', ' + S ;
  PBarra3.Position      := vAWorkCount ;

  Application.ProcessMessages ;
end;

procedure TFrmTelaPrincipal.SButOutrosClick(Sender: TObject);
begin
  PnlOutros.Parent := PnlAtualizacao ;
  PnlOutros.Top    := Trunc((PnlAtualizacao.Height - PnlOutros.Height) / 2 ) ;
  PnlOutros.Left   := Trunc((PnlAtualizacao.Width  - PnlOutros.Width)  / 2 ) ;
  MDOutros.First ;
  DBGridOutros.SetFocus ;
end;

procedure TFrmTelaPrincipal.BitBtn2Click(Sender: TObject);
begin
  PnlOutros.Parent := TabSOutros ;
  BitBConfirmaFTP.SetFocus ;
end;

function TFrmTelaPrincipal.LocalisaInfoArq(pArquivo: String): TInfoArq;
Var
  i : Integer ;
Const
  cSistemas : Array [1..34,1..3] Of String = (('ABA' , 'ABASTECIMENTO'   , 'ABASTECIMENTO'   )
                                             ,('ACD' , 'ACIDENTES'       , 'ACIDENTES'       )
                                             ,('ARR' , 'ARRECADACAO'     , 'ARRECADACAO'     )
                                             ,('ATF' , 'ATIVO'           , 'ATIVO'           )
                                             ,('BCO' , 'BANCOS'          , 'BANCOS'          )
                                             ,('CPN' , 'COMPONENTE'      , 'COMPONENTE'      )
                                             ,('CPR' , 'COMPRAS'         , 'COMPRAS'         )
                                             ,('CTB' , 'CONTABILIDADE'   , 'CONTABILIDADE'   )
                                             ,('CPG' , 'CONTASPAGAR'     , 'CPAGAR'          )
                                             ,('CRC' , 'CONTASRECEBER'   , 'CRECEBER'        )
                                             ,('CTR' , 'CONTROLE'        , 'CONTROLE'        )
                                             ,('DVS' , 'DVS'             , 'DVS'             )
                                             ,('ESC' , 'ESCALA'          , 'ESCALA'          )
                                             ,('ESF' , 'ESCRITURACAO'    , 'ESCRITURACAO'    )
                                             ,('EST' , 'ESTOQUE'         , 'ESTOQUE'         )
                                             ,('FLP' , 'FOLHA'           , 'FOLHA'           )
                                             ,('FRQ' , 'FREQUENCIA'      , 'FREQUENCIA'      )
                                             ,('FRT' , 'FROTA'           , 'FROTA'           )
                                             ,('MAN' , 'MANUTENCAO'      , 'MANUTENCAO'      )
                                             ,('MOT' , 'MOTOR'           , 'MOTOR'           )
                                             ,('PAS' , 'PASSES'          , 'PASSES'          )
                                             ,('PNE' , 'PNEUS'           , 'PNEUS'           )
                                             ,('SRH' , 'RECURSOSHUMANOS' , 'RECURSOSHUMANOS' )
                                             ,('TRF' , 'TRAFEGO'         , 'TRAFEGO'         )
                                             ,('TUR' , 'TURISMO'         , 'TURISMO'         )
                                             ,('PLT' , 'PLANTAO'         , 'PLANTAO'         )
                                             ,('TER' , 'TERMINAL'        , 'TERMINAL'        )
                                             ,('CGS' , 'CARGAS'          , 'CARGAS'          )
                                             ,('FRE' , 'FRETAMENTO'      , 'FRETAMENTO'      )
                                             ,('PVT' , 'PVT'             , 'PVT'             )
                                             ,('GRP' , 'GLOBUSREPORT'    , 'GLOBUSREPORT'    )
                                             ,('TRR' , 'TRR'             , 'TRR'             )
                                             ,('ROD' , 'ROD'             , 'ESCALARODOVIARIA')
                                             ,('CTE' , 'CTE'             , 'TERCEIROS'       )) ;
Begin
  Result.Sigla := '' ;
  Result.Pasta := '' ;
  Result.Exe   := '' ;
  Result.Achou := False ;
  For i := 1 To Length(cSistemas) Do
    If cSistemas[i,1] = pArquivo Then
    Begin
      Result.Sigla := cSistemas[i,1] ;
      Result.Pasta := '\GLOBUS\SISTEMAS\' + cSistemas[i,2] ;
      Result.Exe   := cSistemas[i,3] ;
      Result.Achou := True ;
      Exit ;
    End ; // For i := 1 To Length(cSiglasDosSistemas) Do
end;

function TFrmTelaPrincipal.WinLogin: String;
var
  FComputerName: String;
  FComputerLent: DWord;
begin
  FComputerName:= '';
  FComputerLent:= 80;
  SetLength(FComputerName, FComputerLent);
  If GetUserName(PChar(FComputerName), FComputerLent) Then //AdvApi32.Dll
    SetLength(FComputerName, FComputerLent)
  else
    SetLength(FComputerName, 0);
  If FComputerName = '' Then
    Result := 'Local'
  else
    Result := Trim(FComputerName);
end; // function WinLogin: String;

Function TFrmTelaPrincipal.TrazNomeDoComputador: String;
var
  FComputerName: String;
  FComputerLent: DWord;
  function RemoveCharDifNumEAlfa(pStr:String): String;
  Var I: Integer;
  begin
    { Limpa o Result }
    Result := '';
    { Inicia um loop da string passada }
    For I := 1 To Length(pStr) Do
    begin
      If ( Copy(pStr,I,1) > ' '  ) And
         ( Copy(pStr,I,1) <= 'z' ) Then
        Result := Result + Copy(pStr,I,1);
    end;
  end;
begin
  FComputerName := '';
  FComputerLent := 80;
  SetLength(FComputerName, FComputerLent);
  If GetComputerName(PChar(FComputerName), FComputerLent) Then //AdvApi32.Dll
    SetLength(FComputerName, FComputerLent)
  else
    SetLength(FComputerName, 0);
  If FComputerName = '' Then
    Result := 'Local'
  else
    Result := FComputerName;
  { Ocorreu de em alguns clientes terem sinais (-) no nome do computador, dando erro. }
  Result := Trim(RemoveCharDifNumEAlfa(Result));
End ; // Function TrazNomeDoComputador: String ;

procedure TFrmTelaPrincipal.BitBContinuarClick(Sender: TObject);
begin
  PnlUsuConect.Parent := TabSUsuConect ;
  PnlBotoes.Enabled   := True ;
  If PnlBarras.Parent = PnlAtualizacao Then
    BitBtnAvaAtuClick(BitBContinuar) ;
end;

procedure TFrmTelaPrincipal.IMenoNovImpClick(Sender: TObject);
begin
  PMenuGeralPopup(Sender) ;
  If TMenuItem(Sender).Visible Then
  Begin
    PnlNovImp.Parent := PnlSistemas ;
    PnlNovImp.Height := DBGridSistemas.Height - 40 ;
    PnlNovImp.Width  := DBGridSistemas.Width  - 40 ;

    PnlNovImp.Top    := Trunc((PnlSistemas.Height - PnlNovImp.Height) / 2 ) ;
    PnlNovImp.Left   := Trunc((PnlSistemas.Width  - PnlNovImp.Width)  / 2 ) ;
    MDNovImp.First ;
    DBGridNovImp.SetFocus ;
  End ; // If TMenuItem(Sender).Viaible Then
  DBGridSistemas.Enabled := Not TMenuItem(Sender).Visible ;
  PnlBotoes.Enabled      := DBGridSistemas.Enabled ;
end;

procedure TFrmTelaPrincipal.PnlSaiNovImpClick(Sender: TObject);
begin
  PnlBotoes.Enabled      := True ;
  DBGridSistemas.Enabled := True ;
  PnlNovImp.Parent       := TabSNovImp ;
  DBGridSistemas.SetFocus ;
end;

procedure TFrmTelaPrincipal.MDNovImpFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := DataSet.FieldByName('SIGLA').AsString = MDSistemas.FieldByName('SIGLA').AsString ;
end;

procedure TFrmTelaPrincipal.MDSistemasAfterScroll(DataSet: TDataSet);
begin
  MDNovImp.Filtered       := False ;
  MDNovImp.Filtered       := True ;
  PnlTituloNovImp.Caption := '     '+ MDSistemas.FieldByName('SIGLA').AsString +' - Novidades\implementações' ;
end;

procedure TFrmTelaPrincipal.MDNovImpAfterScroll(DataSet: TDataSet);
begin
  PnlLocModulo.Visible := MDNovImp.FieldByName('LOCMODULO').AsString <> '' ;
  LblLocModulo.Caption := MDNovImp.FieldByName('LOCMODULO').AsString ;
end;

end.




