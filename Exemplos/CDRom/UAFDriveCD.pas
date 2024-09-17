unit UAFDriveCD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, Menus, StdCtrls, ShellAPI ;

const
  wm_IconMessage = wm_User;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    IMenuOpen: TMenuItem;
    IMenuClosed: TMenuItem;
    IMenuSair: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IMenuSairClick(Sender: TObject);
    procedure IMenuOpenClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    { Private declarations }
     procedure IconTray (var Msg: TMessage); message wm_IconMessage;
     procedure WMNCHitTest(var Msg: TMessage); message WM_NCHitTest;
  public
    { Public declarations }
    nid : TNotifyIconData ;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
Var
  vApli : HWnd ;
begin
  vApli := FindWindow(Nil,'PAFDriveCD') ;
  If vApli <> 0 Then ShowWindow(vApli,SW_HIDE) ;

  Height := 0 ;
  Width  := 0 ;

  // carrega o ícone inicial
//  Icon.Handle := LoadIcon(HInstance,'CD');

  // preenche os dados da estrutura NotifyIcon
  Nid.cbSize := sizeof(nid) ;
  Nid.wnd    := Handle ;
  Nid.uID    := 1 ; // Identificador do ícone
  Nid.uCallBAckMessage := wm_IconMessage ;
  Nid.hIcon := Icon.Handle ;
  Nid.szTip := 'Abre ou fecha a drive de CD' ;
  Nid.uFlags := nif_Message or Nif_Icon or nif_Tip ;
  Shell_NotifyIcon(NIM_ADD, @nid) ;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  nid.uFlags := 0 ;
  Shell_NotifyIcon(NIM_DELETE, @nid);
end;

procedure TForm1.IconTray(var Msg: TMessage);
var
  Pt: TPoint ;
begin
  If Msg.lParam = wm_rbuttondown then
  Begin
    GetCursorPos(Pt) ;
    PopupMenu1.Popup(Pt.x, Pt.y);
  End;
end;

procedure TForm1.WMNCHitTest(var Msg: TMessage);
begin
  DefaultHandler(Msg);
end;

procedure TForm1.IMenuSairClick(Sender: TObject);
begin
  Close ;
end;

procedure TForm1.IMenuOpenClick(Sender: TObject);
begin
//  mciSendString('Set cdaudio door ' + Copy(TMenuItem(Sender).Name,6,8) + ' wait', nil, 0, handle)
  ShowMessage(Copy(TMenuItem(Sender).Name,6,8))  ;

  IMenuOpen.Visible   := TMenuItem(Sender).Name = 'IMenuClosed' ;
  IMenuClosed.Visible := TMenuItem(Sender).Name = 'IMenuOpen' ;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  IMenuOpen.Visible   := Not IMenuClosed.Visible ;
  IMenuClosed.Visible := Not IMenuOpen.Visible;
end;

end.
