unit UnitAtualizaModulo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBTables, Db, FileCtrl, ComCtrls;

type
  TFrmAtualizaModulo = class(TForm)
    PnlTela: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    vQryPesquisa: TQuery;
    DTB_SII: TDatabase;
    RGroupTpSolic: TRadioGroup;
    MEdtCodigo: TMaskEdit;
    EdtModulo: TEdit;
    RGroupTpExec: TRadioGroup;
    BitBtnExecutar: TBitBtn;
    DriveComboBox: TDriveComboBox;
    Label3: TLabel;
    PnlMsg: TPanel;
    EdtCodModulo: TEdit;
    procedure MEdtCodigoChange(Sender: TObject);
    procedure MEdtCodigoExit(Sender: TObject);
    procedure SButCodigoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnExecutarClick(Sender: TObject);
  private
    { Private declarations }
    vEsc,
    vAbandonaExit,
    vPassaFoco   : Boolean ;
    Nome_Exe,
    Nome_Pasta,
    vArquivoIni  : String ;
    function StrZero( nNum : Real; iTam : Byte; iPrec : Byte = 0): String;
    function IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant ;
  public
    { Public declarations }
  end;

var
  FrmAtualizaModulo: TFrmAtualizaModulo;

implementation

Uses inifiles ;

{$R *.DFM}

procedure TFrmAtualizaModulo.MEdtCodigoChange(Sender: TObject);
begin
  If Trim(MEdtCodigo.Text) = '' Then
    EdtModulo.Clear ;
end;

procedure TFrmAtualizaModulo.MEdtCodigoExit(Sender: TObject);
begin
  If vEsc Then
  Begin
    MEdtCodigo.Clear ;
    TRadioGroup(RGroupTpSolic.Controls[RGroupTpSolic.ItemIndex]).SetFocus ;
    vEsc := False ;
    Exit ;
  End ; // If vEsc Then

  If Trim(MEdtCodigo.Text) = '' Then
  Begin
    MEdtCodigo.SetFocus ;
    Exit ;
  End ; // If Trim(MEdtCodigo.Text) = '' Then

  Try
    MEdtCodigo.Text := StrZero(StrToInt(Trim(MEdtCodigo.Text)),08) ;
  Except
  End ; // Try - Except

  If Not DTB_SII.Connected Then
  Begin
    PnlMsg.Caption := 'Conectando!!!' ;
    DTB_SII.Connected := False ;
  End ; // If Not DTB_SII.Connected Then
  PnlMsg.Caption := '' ;

  If Trim(MEdtCodigo.Text) <> '' Then
  Begin
    With vQryPesquisa do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add(' SELECT'+
              '  M.CODMODULO'+
              ' ,M.DESCRICAOMODULO') ;
      Sql.Add(' FROM'+
              '  SII_SAS     S'+
              ' ,SII_SISTEMA I'+
              ' ,SII_MODULO  M') ;
      Sql.Add(' WHERE'+
              '     S.CODMODULO  = M.CODMODULO'+
              ' AND S.CODSISTEMA = M.CODSISTEMA'+
              ' AND S.CODSISTEMA = I.CODSISTEMA'+
              ' AND I.CODSISTEMA = ''GLB'''+
              ' AND S.TIPOSASSIM = :P_TIPOSASSIM'+
              ' AND S.CODIGOSAS  = :P_CODIGOSAS') ;
      ParamByName('P_TIPOSASSIM').AsInteger := RGroupTpSolic.ItemIndex ;
      ParamByName('P_CODIGOSAS' ).AsInteger := StrToInt(Trim(MEdtCodigo.Text)) ;
      Open ;
      If IsEmpty Then
      Begin
        ShowMessage('Solicitação não cadastrada.') ;
        MEdtCodigo.SetFocus ;
        Exit ;
      End ; // If IsEmpty Then
      EdtCodModulo.Text := FieldByName('CODMODULO'      ).AsString ;
      EdtModulo.Text    := FieldByName('DESCRICAOMODULO').AsString ;

      Nome_Exe          := IIf(Trim(EdtCodModulo.Text)='CPG','CPAGAR',
                           IIf(Trim(EdtCodModulo.Text)='CRC','CRECEBER',
                           IIf(Trim(EdtCodModulo.Text)='SRH','RECURSOSHUMANOS',
                           IIf(Trim(EdtCodModulo.Text)='COT','ECOMPRAS',EdtModulo.Text)))) ;
      Nome_Pasta        := IIf(Trim(EdtCodModulo.Text)='CPG','CONTASPAGAR',
                           IIf(Trim(EdtCodModulo.Text)='CRC','CONTASRECEBER',
                           IIf(Trim(EdtCodModulo.Text)='SRH','RECURSOSHUMANOS',
                           IIf(Trim(EdtCodModulo.Text)='COT','E-COMPRAS',EdtModulo.Text)))) ;
    End ; // With vQryPesquisa do
  End ; // If Trim(MEdtCodigo.Text) = '' Then
end;

procedure TFrmAtualizaModulo.SButCodigoClick(Sender: TObject);
begin
  PerForm(WM_NEXTDLGCTL,0,0) ;
end;


procedure TFrmAtualizaModulo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree ;
end;

procedure TFrmAtualizaModulo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmAtualizaModulo.FormCreate(Sender: TObject);
Var
  IniFile : TIniFile;
begin
  vPassaFoco  := True ;
  vArquivoIni := ExtractFilePath(Application.ExeName) + 'AtualizaModulo.Ini' ;

  IniFile := TIniFile.Create(vArquivoIni);
  Try
    DriveComboBox.Drive := IniFile.ReadString('CONFIGURACOES','DRIVE TRABALHO','')[1] ;
  Except
  End ; // Try - Except

  IniFile.Free ;
end;

function TFrmAtualizaModulo.StrZero( nNum : Real; iTam : Byte; iPrec : Byte = 0): String;
var I    : Byte;
    sAux : String;
Begin
  Str( nNum:iTam:iPrec, sAux );
  I := 1;
  While sAux[I] = ' ' Do
  Begin
    sAux[I] := '0';
    Inc( I );
  End;
  Result := sAux;
End;

function TFrmAtualizaModulo.IIf( pCondicao : Boolean; pResultTrue, pResultFalse : Variant) : Variant;
Begin
  If pCondicao Then
    Result := pResultTrue
  else
    Result := pResultFalse;
End;

procedure TFrmAtualizaModulo.BitBtnExecutarClick(Sender: TObject);
Var
  vDir,
  vOrigem,
  vDestino : String ;
  IniFile  : TIniFile ;
begin
  If Trim(EdtModulo.Text) = '' Then
  Begin
    MEdtCodigo.SetFocus ;
    Exit ;
  End ; // If Trim(EdtModulo.Text) = '' Then

  vDir := 'O:\VALIDACAO\' + RGroupTpSolic.Items[RGroupTpSolic.ItemIndex] +'\'+ MEdtCodigo.Text ;
  If RGroupTpExec.ItemIndex = 0 Then
  Begin
    vOrigem  := DriveComboBox.Drive + ':\GLOBUS\SISTEMAS\' + Nome_Pasta +'\'+ Nome_Exe + '.Exe' ;
    vDestino := vDir + '\' ;  
    If Not FileExists(vOrigem) Then
    Begin
      ShowMessage('Arquivo não encontrado, ' + vOrigem ) ;
      Exit ;
    End ; // If Not FileExists(vOrigem) Then

    PnlMsg.Caption := 'Criando pastas.' ;
    Application.ProcessMessages ;
    ForceDirectories(vDir) ; // Cria o diretorio
    If Not DirectoryExists(vDir) Then
    Begin
      ShowMessage('Não foi possível criar a pasta, ' + vDir ) ;
      Exit ;
    End ; // If Not FileExists(vOrigem) Then

    PnlMsg.Caption := 'Copiando, ' + Nome_Exe + '.Exe' ;
    Application.ProcessMessages ;
    CopyFile(PChar(vOrigem), PChar(vDestino + Nome_Exe + '.Exe') , False) ;
    If Not FileExists(vDestino + Nome_Exe + '.Exe') Then
    Begin
      ShowMessage('O foi possível copiar o arquivo, ' + Nome_Exe + '.Exe' + #13+
                  'para a pasta, ' + vDestino ) ;
      Exit ;
    End ; // If Not FileExists(vDestino + Nome_Exe + '.Exe') Then

    If FileExists('C:\Program Files\ASPack\ASPack.exe') Then
    Begin
      PnlMsg.Caption := 'Campactando, ' + Nome_Exe + '.Exe' ;
      Application.ProcessMessages ;
      WinExec(PChar('C:\Program Files\ASPack\ASPack.exe ' + vDestino + Nome_Exe + '.Exe ' + vOrigem + ' /B- /Q'),SW_HIDE) ;
      While FileExists(UpperCase(vDestino + 'ASP*.tmp')) do 
        Application.ProcessMessages ;

    End ; // If FileExists('C:\Program Files\ASPack\ASPack.exe') Then

  End Else
  Begin
    vOrigem  := vDir + '\'+ Nome_Exe + '.Exe' ;
    vDestino := DriveComboBox.Drive + ':\GLOBUS\SISTEMAS\' + Nome_Pasta +'\'+ Nome_Exe  ;

    If FileExists(vDestino + '.Exe') Then
    Begin
      PnlMsg.Caption := 'Renomeando ' + Nome_Exe + '.Exe, para' + Nome_Exe + '_'+ DateTimeToStr(Now) +'.Exe' ;
      Application.ProcessMessages ;
      RenameFile(vDestino + '.Exe',vDestino + '_'+ DateTimeToStr(Now) +'.Exe') ;
    End ; // If FileExists(vDestino + '.Exe') Then

    If Not FileExists(vOrigem) Then
    Begin
      ShowMessage('Arquivo não encontrado, ' + vDir ) ;
      Exit ;
    End ; // If Not FileExists(vOrigem) Then

    PnlMsg.Caption := 'Copiando, ' + Nome_Exe + '.Exe' ;
    Application.ProcessMessages ;
    CopyFile(PChar(vOrigem), PChar(vDestino + '.Exe'), False) ;
  End ; // If RGroupTpExec.ItemIndex = 0 Then
  PnlMsg.Caption := '' ;
  MEdtCodigo.Clear ;
  MEdtCodigo.SetFocus ;
  Try
    IniFile := TIniFile.Create(vArquivoIni) ;
    IniFile.WriteString('CONFIGURACOES','DRIVE TRABALHO',DriveComboBox.Text) ;
    IniFile.Free ;
  Except
  End ; // Try - Except

  Application.ProcessMessages ;
  ShowMessage('Módulo atualizado com êxito.') ;
end;

end.
