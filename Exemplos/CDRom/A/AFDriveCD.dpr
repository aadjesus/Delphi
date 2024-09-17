program AFDriveCD;

uses
  Forms, Dialogs, Windows ;

Var
  vApli : HWnd ;
  
{$R *.res}

begin
  Application.Initialize ;


    // retira da barra iniciar
    vApli := FindWindow(Nil,'AFDriveCD') ;
    If vApli <> 0 Then ShowWindow(vApli,SW_HIDE) ;

    // carrega o ícone inicial
    Icon.Handle := LoadIcon(HInstance,'MAINICON');

    // preenche os dados da estrutura NotifyIcon
    Nid.cbSize := sizeof(nid) ;
    Nid.wnd    := Handle ;
    Nid.uID    := 1 ; // Identificador do ícone
    Nid.uCallBAckMessage := wm_IconMessage ;
    Nid.hIcon := Icon.Handle ;
    Nid.szTip := 'LloydSoft' ;
    Nid.uFlags := nif_Message or Nif_Icon or nif_Tip ;
    Shell_NotifyIcon(NIM_ADD, @nid) ;


  showmessage('teste') ;



  Application.Run;
end.
