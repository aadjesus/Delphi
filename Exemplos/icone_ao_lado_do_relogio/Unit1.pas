unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI;

const
  wm_IconMessage = wm_User;

type
  TForm1 = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
     procedure IconTray (var Msg: TMessage); message wm_IconMessage;
     procedure WMNCHitTest(var Msg: TMessage); message WM_NCHitTest;
     Procedure MudaLayOutTela(pNormal : Boolean = True ) ;
  public
    { Public declarations }
     nid : TNotifyIconData ;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.IconTray(var Msg: TMessage);
var
  Pt: TPoint ;
begin
  If Msg.lParam = wm_rbuttondown then
  Begin
    GetCursorPos(Pt) ;
//    PopupMenu1.Popup(Pt.x, Pt.y);
  End;
end;

procedure TForm1.MudaLayOutTela(pNormal: Boolean);
Var
  vApli : HWnd ;
begin

  If pNormal Then
  Begin
    BorderStyle := bsSingle ;
    FormStyle   := fsNormal ;
    Nid.uFlags := 0 ;
    Shell_NotifyIcon (NIM_DELETE, @nid) ;
  End Else // If pNormal Then
  Begin
    Height := 0 ;
    Width  := 0 ;

//    BorderStyle := bsNone ;
//    FormStyle   := fsStayOnTop ;

    // retira da barra iniciar
    vApli := FindWindow(Nil,'Project1') ;
    If vApli <> 0 Then ShowWindow(vApli,SW_HIDE) ;

    // carrega o ícone inicial
    Icon.Handle := LoadIcon(HInstance,'MAINICON');

    // preenche os dados da estrutura NotifyIcon
    Nid.cbSize := sizeof(nid) ;
    Nid.wnd    := Handle ;
    Nid.uID    := 1 ; // Identificador do ícone
    Nid.uCallBAckMessage := wm_IconMessage ;
    Nid.hIcon := Icon.Handle ;
    Nid.szTip := 'teste' ;
    Nid.uFlags := nif_Message or Nif_Icon or nif_Tip ;
    Shell_NotifyIcon(NIM_ADD, @nid) ;
  End ; // End Else // If pNormal Then
end;

procedure TForm1.WMNCHitTest(var Msg: TMessage);
begin
  DefaultHandler(Msg);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  MudaLayOutTela(False);
end;

end.
