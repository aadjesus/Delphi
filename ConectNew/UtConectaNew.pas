unit UtConectaNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, Grids, DBGrids, Buttons, ExtCtrls, DB,
  RxMemDS, Menus, IniFiles, ShellAPI ;

const
  wm_IconMessage = wm_User;
  
type
  TFrmConectaNew = class(TForm)
    MDAlias: TRxMemoryData;
    DSAlias: TDataSource;
    MDAliasALIAS: TStringField;
    PopupMenu1: TPopupMenu;
    a1: TMenuItem;
    N21: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    vConectaNew : TIniFile;
     procedure IconTray (var Msg: TMessage); message wm_IconMessage;
     procedure WMNCHitTest(var Msg: TMessage); message WM_NCHitTest;
  public
    { Public declarations }
    nid : TNotifyIconData ;
  end;

var
  FrmConectaNew: TFrmConectaNew;

implementation

{$R *.dfm}

procedure TFrmConectaNew.FormShow(Sender: TObject);
Var i : Integer ;
   vApli : HWnd ;
begin
  // retira da barra iniciar
  vApli := FindWindow(Nil,'ConectaNew') ;
  If vApli <> 0 Then ShowWindow(vApli,SW_HIDE) ;

  // carrega o ícone inicial
  Icon.Handle := LoadIcon(HInstance,'MAINICON');

  // preenche os dados da estrutura NotifyIcon
  Nid.cbSize := sizeof(nid) ;
  Nid.wnd    := Handle ;
  Nid.uID    := 1 ; // Identificador do ícone
  Nid.uCallBAckMessage := wm_IconMessage ;
  Nid.hIcon := Icon.Handle ;
  Nid.szTip := 'Conecta' ;
  Nid.uFlags := nif_Message or Nif_Icon or nif_Tip ;
  Shell_NotifyIcon(NIM_ADD, @nid) ;

  MDAlias.Open ;
  If FileExists(vConectaNew.FileName) Then
  Begin
    Try
      DriveTrab.Drive := vConectaNew.ReadString('PAR','DRIVE','')[1] ;
      For i := 1 to 100 do
      Begin
        If Trim(vConectaNew.ReadString('SERV', 'ALIAS' + IntToStr(i),'' )) <> '' Then
        Begin
          MDAlias.Append ;
          MDAlias.FieldByName('ALIAS' ).AsString := vConectaNew.ReadString('SERV', 'ALIAS' + IntToStr(i),'' )  ;
          MDAlias.Post ;
        End Else
          Break ;
      End ; // For i := 0 to 100 do
    Except
    End ; // Try - Except
    
    MDAlias.First ;
  End ; // If FileExists('ConectaNew.Ini') Then
  Application.ShowMainForm := False ;
  Left := -500 ;
end;

procedure TFrmConectaNew.FormCreate(Sender: TObject);
begin
  vConectaNew := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'ConectaNew.Ini') ;
end;

procedure TFrmConectaNew.FormClose(Sender: TObject; var Action: TCloseAction);
Var i : Integer ;
begin
  If FileExists(vConectaNew.FileName) Then
    DeleteFile(vConectaNew.FileName) ;

  vConectaNew.WriteString('PAR','DRIVE', DriveTrab.Drive ) ;
  MDAlias.First ;
  i := 0 ;
  While Not MDAlias.Eof do
  Begin
    Inc(i) ;
    vConectaNew.WriteString('SERV', 'ALIAS' + IntToStr(i), MDAlias.FieldByName('ALIAS').AsString ) ;
    MDAlias.Next ;
  End ; // While Not MDAlias.Eof do
  vConectaNew.UpdateFile ;

  vConectaNew.Free ;

  nid.uFlags := 0 ;
  Shell_NotifyIcon (NIM_DELETE, @nid);
end;


procedure TFrmConectaNew.IconTray(var Msg: TMessage);
var
  Pt: TPoint ;
begin
  If Msg.lParam = wm_rbuttondown then
  Begin
    GetCursorPos(Pt) ;
    PopupMenu1.Popup(Pt.x, Pt.y);
  End;
end;

procedure TFrmConectaNew.WMNCHitTest(var Msg: TMessage);
begin
  DefaultHandler(Msg);
end;

end.
