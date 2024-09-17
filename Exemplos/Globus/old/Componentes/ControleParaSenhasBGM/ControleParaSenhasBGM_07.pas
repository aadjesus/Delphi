{$Include \Globus\sistemas\Defines.txt}

{
20/09/2005 - Verônica - SIM 12360 - Alterado a forma de ler o CheckSum do menu especifico. Passa a fazer o checkSum usando
                        Sistema + Caption + Nome + "N". Antes no lugar do Caption usava o Indice, mas quando o item de menu
                        tinha a posição alterada, perdia a autorização do menu especifico.
01/10/2004 - Sila   - Colocada atribuição à variável comum vcUsuarioManagerComSenhaUm
26/08/2004 - Silvio - Passa a gravar no log de "Informou senha", o login do Windows e a máquina.
                      Só fazia para usuários administradores, GLOBUS e MANAGER.
06/07/2004 - Verônica - SIM 7517 - Incluida funções para envio de email para o CGS.
03/02/2004 - Silvio - Mudança na senha do GLOBUS, a partir de 18/2/4.
24/11/2003 - Sila   - Inclusão do evento AfterLog e da propriedade CodIntFunc
             Silvio - Controle de senha posicional - SenhaUsuarioPosicional na Global
19/04/2002 - Silvio - Controla por data/hora quando reorganizar os menus do sistema.
18/08/2000 - Silvio - Limpa a senha, para que ela tenha que ser reinformada no caso do
                      pressionamento do F4.
}
unit ControleParaSenhasBgm;

interface

uses
  GlbComum, SysUtils, Classes, Controls, ExtCtrls, Buttons, WinTypes, Forms,
  Graphics, StdCtrls, Dialogs, DbTables, Menus, Bgm_String, comctrls,
  ToolWin, DB, dmControle, Bgm_Dados, Global, BGM_Utils, CTRTrocaSenhaDeUsuario,
  RxMemDS, Messages, ImgList ;

type
  TOCHDefault = (bdNone,bdOK,bdCancel,bdHelp);
  TContSenhaBgm = class(TCustomPanel)
  private
    { Primeira vez que entra no Controle }
    vFirstControle : Boolean;
    { Define tipos de Componentes Utilizados }
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    LbUsuario: TLabel;
    LbSenha: TLabel;
    LbNomeUsuario: TLabel;
    EdUsuario: TEdit;
    EdSenha: TEdit;
    FCancel: boolean;
    FDefault: TOCHDefault;
    FTabStop: boolean;
    FButtonsHeight: integer;
    FButtonsWidth: integer;
    FButtonsSpacing: integer;
    {Define as tabelas e menus}
    vConcedente: TQuery;
    vCadastroDeUsuarios: TQuery;
    vMenusDoSistema: TQuery;
    vMenusAoUsuario: TQuery;
    vSistema: String;
    vMenu: TMainMenu;
    vStatusBar : TStatusBar;
    vUsuario : String;
    vToolBar : TToolBar;
    vCodIntFunc: Integer;
    FAfterLog : TNotifyEvent;

    FFrmTelaTeclas   : TForm ;
    FPMenuTeclas     : TPopupMenu ;
    FIMenuTeclas     : TMenuItem ;
    FEdtTecla        : TEdit ;
    FQryPesquisa     : TQuery ;
    FTViewMenuTeclas : TTreeView ;

    procedure pConcedente(const Value: TQuery);
    procedure pCadastroDeUsuarios(const Value: TQuery);
    procedure pMenusDoSistema(const Value: TQuery);
    procedure pMenusAoUsuario(const Value: TQuery);
    procedure pSistema(const Value: String);
    procedure pMenu(const Value: TMainMenu);
    procedure pStatusBar(const Value: TStatusBar);
    procedure pUsuario(const Value: String );
    procedure pCodCliente (const Value: Integer );
    procedure SetTabStop(const Value: boolean);
    procedure SetCancel(const Value: boolean);
    procedure SetDefault(const Value: TOCHDefault);
    procedure SetButtonsHeight(const Value: integer);
    procedure SetButtonsWidth(const Value: integer);
    procedure SetButtonsSpacing(const Value: integer);
    procedure pToolBar(const Value: TToolBar);
    procedure RedrawPanel;
    procedure PResize(Sender: TObject);
    procedure OnClickOk(Sender: TObject);
    procedure OnClickCancel(Sender: TObject);
    procedure ChecaUsuarioSenha;
    procedure HabilitaMenusParaAdministrador;
    procedure TestaCodigoClienteEColocaSenha(Sender: TObject);
    procedure FazHabilitacaoMenus;
    function  VerificaSeUsuarioeAdministrador: Boolean;
    procedure Alteratabela;
    procedure GravaNaTabelaCTR_Cadsis(Indice, Nome, Caption: String; pTag : Integer);
    procedure OnChangeUsuario(Sender: TObject);
    procedure pCodIntFunc (const Value: Integer );
    Function  BuscaMenusLimitados(vsistema,Vcod:String): Boolean;
    Function BuscaShortCuts(vIndice: String): String;
    Procedure GravaShortCuts(vIndice, vShortCut: String);

    Procedure FIMenuTeclasClick(Sender: TObject) ;
    procedure FFrmTelaTeclasFormClose(Sender: TObject; var Action: TCloseAction);
    procedure FFrmTelaTeclasFormKeyPress(Sender: TObject; var Key: Char);
    procedure FFrmTelaTeclasFormShow(Sender: TObject);
    procedure FMainMenuSaidaClick(Sender: TObject);
    procedure FTViewMenuTeclasChange(Sender: TObject; Node: TTreeNode);
    procedure FTViewMenuTeclasExit(Sender: TObject);
    procedure FEdtTeclaExit(Sender: TObject);
    procedure FEdtTeclaKeyPress(Sender: TObject; var Key: Char);
    procedure FEdtTeclaKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure FSButExpandeClick(Sender: TObject);
    procedure FSButCopiarClick(Sender: TObject);
  public
    vCodCliente : Integer;
    vIndiceMenu: array[1..109] of string ;
    vShortCuts: String;

    vMDTeclas : TRxMemoryData ;

    procedure LimitaMenus;
    constructor Create(AOwner:TComponent); override;
    procedure DesabilitaMenus;
    procedure DesabilitaNivelSeNaoTiverNivelInferior;
    procedure GeraTabelaAPartirDoMenu;
    procedure LimpaUsuario;

  published
    property Align;
    property Font;
    property ParentFont;
    property BevelOuter;
    property BevelInner;
    property Cancel            : boolean     read FCancel             write SetCancel;
    property Default           : TOCHDefault read FDefault            write SetDefault default bdNone;
    property ButtonsHeight     : integer     read FButtonsHeight      write SetButtonsHeight;
    property ButtonsWidth      : integer     read FButtonsWidth       write SetButtonsWidth;
    property ButtonsSpacing    : integer     read FButtonsSpacing     write SetButtonsSpacing;
    property TabStop           : boolean     read FTabStop            write SetTabStop;
    property Concedente        : TQuery      read vConcedente         write pConcedente;
    property CadastroDeUsuarios: TQuery      read vCadastroDeUsuarios write pCadastroDeUsuarios;
    property MenusDoSistema    : TQuery      read vMenusDoSistema     write pMenusDoSistema;
    property MenusAoUsuario    : TQuery      read vMenusAoUsuario     write pMenusAoUsuario;
    property Sistema           : String      read vSistema            write pSistema;
    property Menu              : TMainMenu   read vMenu               write pMenu;
    property StatusBar         : TStatusBar  read vStatusBar          write pStatusBar;
    property Usuario           : String      read vUsuario            write pUsuario;
    property CodCliente        : Integer     read vCodCliente         write pCodCliente;
    property ToolBar           : TToolBar    read vToolBar            write pToolBar;
    property CodIntFunc        : Integer     read vCodIntFunc         write pCodIntFunc;
    property AfterLog          : TNotifyEvent read FAfterLog          write FAfterLog;
end;

procedure Register;

implementation

Uses Bgm_Tela ;

{$R ControleParaSenhasBgm.res}

Const
  DiasDaSemana : Array [1..7] Of String = ('DOM','SEG','TER','QUA','QUI','SEX','SAB');

var vAcessatodasOpcoes : String[1] = 'N';
    vTemMenusEspecificosNaoAutorizados, vtemMenuparaoSistema, vValidaoMenuNovamente : boolean;
    vTagSN, vUsuarioDB : String;
    vContNivel2, vContNivel1 : Integer;
{______________________________________________________________________________}
procedure Register;
begin
  RegisterComponents('BGM', [TContSenhaBgm]);
end;

{______________________________________________________________________________}
constructor TContSenhaBgm.Create (AOwner:TComponent);
begin

  inherited Create(AOwner);

  { Set a variavel vFirstControle }

  vFirstControle := True;

  BevelInner := bvLowered;
  BevelOuter := bvRaised;

  ControlStyle    := [csOpaque];
  Font.Name       := 'MS Sans Serif';
  Font.Style      := [fsBold];
  Font.Size       := 8;
  FButtonsSpacing := 4;
  FDefault        := bdNone;
  FButtonsHeight  := 28;
  FButtonsWidth   := 93;
  FTabStop        := True;
  Align           := alBottom;
  Height          := 110;

  {Cria as Label´s}

  LbUsuario            := TLabel.Create(self);
  LbUsuario.Caption    := 'Usuário:';
  LbUsuario.Parent     := Self;
  LbUsuario.Top        := 10;
  LbUsuario.Left       := 10;

  EdUsuario           := TEdit.Create(self);
  EdUsuario.Text      := '';
  EdUsuario.Parent    := Self;
  EdUsuario.Top       := LbUsuario.Top + LbUsuario.Height + 2;
  EdUsuario.Left      := 10;
  EdUsuario.MaxLength := 15;
  EdUsuario.CharCase  := ecUpperCase;
  EdUsuario.Width     := 150;
  EdUsuario.TabOrder  := 0;
  EdUsuario.OnChange  := OnChangeUsuario;

  LbNomeUsuario            := TLabel.Create(self);
  LbNomeUsuario.Caption    := '';
  LbNomeUsuario.Parent     := Self;
  LbNomeUsuario.AutoSize   := True;
  LbNomeUsuario.Top        := LbUsuario.Top + LbUsuario.Height + 7;
  LbNomeUsuario.Left       := EdUsuario.Left + EdUsuario.Width + 10;

  LbSenha            := TLabel.Create(self);
  LbSenha.Caption    := 'Senha:';
  LbSenha.Parent     := Self;
  LbSenha.Top        := EdUsuario.Top + EdUsuario.Height + 5;
  LbSenha.Left       := 10;

  EdSenha              := TEdit.Create(self);
  EdSenha.Text         := '';
  EdSenha.Parent       := Self;
  EdSenha.Top          := LbSenha.Top + LbSenha.Height + 2;
  EdSenha.Left         := 10;
  EdSenha.CharCase     := ecUpperCase;
  EdSenha.Width        := 150;
  EdSenha.TabOrder     := 1;
  EdSenha.PasswordChar := '#';

  {Cria o Botao Ok}
  BitBtnOK := TBitBtn.Create(self);
  OnResize := PResize;
  OnEnter  := TestaCodigoClienteEColocaSenha;

  with BitBtnOK do begin
    Kind := bkOK;
    Caption := 'Confirma';
    Default := True;
    Parent := Self;
    ModalResult := mrNone;
    OnClick := OnClickOk;
    TabOrder := 2;
  end;

  {Cria o Botao Cancela}
  BitBtnCancel := TBitBtn.Create(self);
  with BitBtnCancel do begin
    Tag := 1;
    Kind := bkCancel;
    Caption := 'Cancela';
    Cancel := False;
    Parent := Self;
    OnClick := OnClickCancel;
    TabOrder := 3;
  end;

  FPMenuTeclas := TPopupMenu.Create(Self) ;
  FPMenuTeclas.Name := 'FPMenuTeclas' ;

  FIMenuTeclas         := TMenuItem.Create(Self) ;
  FIMenuTeclas.Name    := 'FIMenuCadastroDeAtalhos' ;
  FIMenuTeclas.Caption := 'Cadastro de Atalhos' ;
  FPMenuTeclas.Items.Insert(0,FIMenuTeclas) ;
  FPMenuTeclas.Items[0].OnClick := FIMenuTeclasClick ;

  vMDTeclas := TRxMemoryData.Create(AOwner) ;

  SetButtonsHeight(FButtonsHeight);
  SetButtonsWidth(FButtonsWidth);

  RedrawPanel;
end;

procedure TContSenhaBgm.PResize(Sender: TObject);
begin
  RedrawPanel;
end;

{ Propriedades }

procedure TContSenhaBgm.pConcedente(const Value: TQuery);
begin
  vConcedente := Value;
end;

procedure TContSenhaBgm.pCadastroDeUsuarios(const Value: TQuery);
begin
  vCadastroDeUsuarios := Value;
end;

procedure TContSenhaBgm.pMenusDoSistema(const Value: TQuery);
begin
  vMenusDoSistema := Value;
end;

procedure TContSenhaBgm.pMenusAoUsuario(const Value: TQuery);
begin
  vMenusAoUsuario := Value;
end;

procedure TContSenhaBgm.pSistema(const Value: String);
begin
  vSistema := UpperCase(Value);
  vcSistema := UpperCase(Value);
end;

procedure TContSenhaBgm.pMenu(const Value: TMainMenu);
begin
  vMenu := Value;
end;

procedure TContSenhaBgm.pStatusBar(const Value: TStatusBar);
begin
  vStatusBar := Value;
end;

procedure TContSenhaBgm.pToolBar(const Value: TToolBar);
begin
  vToolBar := Value;
end;

procedure TContSenhaBgm.pUsuario(const Value: String);
begin
  vUsuario := Value;
  vcUsuario := Value;

  if Assigned(FAfterLog) then
    FAfterLog(Self);
end;

procedure TContSenhaBgm.pCodIntFunc(const Value: Integer);
begin
  vCodIntFunc := Value;
end;


procedure TContSenhaBgm.pCodCliente(const Value: Integer);
begin
  vCodCliente := Value;
  vcCodigoCliente := Value;
end;

{______________________________________________________________________________}
procedure TContSenhaBgm.SetTabStop(const Value: boolean);
begin
  FTabStop := Value;
  BitBtnOK.TabStop := Value;
  BitBtnCancel.TabStop := Value;
end;

{______________________________________________________________________________}
 procedure TContSenhaBgm.SetButtonsWidth(const Value: integer);
 begin
   FButtonsWidth := value;
   BitBtnOK.Width := FButtonsWidth;
   BitBtnCancel.Width := FButtonsWidth;
   RedrawPanel;
 end;

 {______________________________________________________________________________}
 procedure TContSenhaBgm.SetButtonsHeight(const Value: integer);
 begin
   FButtonsHeight := value;
   BitBtnOK.Height := FButtonsHeight;
   BitBtnCancel.Height := FButtonsHeight;
   RedrawPanel;
 end;

{______________________________________________________________________________}
procedure TContSenhaBgm.SetButtonsSpacing(const Value: integer);
begin
  FButtonsSpacing := value;
  RedrawPanel;
end;

{______________________________________________________________________________}
procedure TContSenhaBgm.SetCancel(const Value: boolean);
begin
  FCancel := Value;
  BitBtnCancel.Cancel := Value;
end;

{______________________________________________________________________________}
procedure TContSenhaBgm.SetDefault(const Value: TOCHDefault);
begin
  FDefault := Value;
  BitBtnOk.Default := false;
  BitBtnCancel.Default := false;
  case Value of
    bdOK:     BitBtnOk.Default := true;
    bdCancel: BitBtnCancel.Default := true;
  end;
end;

{______________________________________________________________________________}
procedure TContSenhaBgm.RedrawPanel;
Var Espaco : Integer;
begin
  Espaco := ( ( Height - ( BitBtnOk.Height + BitBtnCancel.Height ) ) Div 3 );
  BitBtnOk.Left     := Width - BitBtnOk.Width - 5;
  BitBtnCancel.Left := Width - BitBtnCancel.Width - 5;
  BitBtnOk.Top      := Espaco;
  BitBtnCancel.Top  := Espaco + BitBtnOk.Height + Espaco;
end;

procedure TContSenhaBgm.TestaCodigoClienteEColocaSenha(Sender: TObject);
Var
  a, b : Integer;
  c: String;
begin
  With Concedente Do
  begin
    Open;
    First;
    If ( FieldByName('CodigoCliente').asInteger = 9999 ) And
       ( Sistema <> 'SEG'                              ) And // Não coloca automaticamente para o segurança
       ( vFirstControle                                ) Then
    begin
      edUsuario.Text := 'GLOBUS';
//          edSenha.Text   := 'GLB' + Copy(TimeToStr(Time),4,2) + Copy(TimeToStr(Time),1,2) + 'SENHA';
//      edSenha.Text   := 'GLB' + DiasDaSemana[DayOfWeek(Now)] + Copy(DateToStr(Now),1,2);
//      edSenha.Text   := '5.95238095238095';
      If Now >= StrToDate('18/02/2004') Then // Silvio
        edSenha.Text := '4.18767507002801'
      Else
        edSenha.Text := '5.95238095238095';
      Close;
      FazHabilitacaoMenus;
      vFirstControle := False;
      Exit;
    End
    { Passaredo - Conexão via menuzão "/AUTOLOGIN_U_=<usuario>_S_=<senha>_AUTOLOGIN/"}
    Else If (Copy(ParamStr(1),1,11)='/AUTOLOGIN_') And
            (Copy(ParamStr(1),Length(ParamStr(1))-10,11)='_AUTOLOGIN/') And
            (Pos('_U_=', ParamStr(1)) > 0) And
            (Pos('_S_=', ParamStr(1)) > 0) And
            vFirstControle And (Sistema <> 'SEG') Then
    Begin
      a := Pos('_U_=', ParamStr(1));
      c := '';
      For b := a + 4 To Length(ParamStr(1)) Do
        If Copy(ParamStr(1),b,4) = '_S_=' Then Break Else c := c + Copy(ParamStr(1),b,1);
      edUsuario.Text := c;
      a := Pos('_S_=', ParamStr(1));
      c := '';
      For b := a + 4 To Length(ParamStr(1)) Do
        If Copy(ParamStr(1),b,11) = '_AUTOLOGIN/' Then Break Else c := c + Copy(ParamStr(1),b,1);
      edSenha.Text   := c;
      Close;
      FazHabilitacaoMenus;
      vFirstControle := False;
      Exit;
    End // Menuzão

//    Else If (Descriptografa(FieldByName('ChaveCliente').asString) = '1') And vFirstControle And (Sistema <> 'SEG') Then
    Else If vcUsuarioManagerComSenhaUm And vFirstControle And (Sistema <> 'SEG') Then
    Begin
//      dm.vUsuarioManagerComSenhaUm := True;
//      vcUsuarioManagerComSenhaUm := True;
      edUsuario.Text := 'MANAGER';
      edSenha.SetFocus;
    End
    Else
      edUsuario.SetFocus;

    If Pos('/LOGGETSQL', UpperCase(ParamStr(1))) <> 0 then
    Begin
      (*
      s := ParamStr(1);
      c := '/LOGGETSQL';
      a := Pos(c, UpperCase(s));
      c := Copy(s, a + Length(c), Length(s));
      *)
      vcArquivoRastreioSQL := Trim(ParamStr(2));
    End; // GetSQL

    Close;
  End;
  vFirstControle := False;
end;

procedure TContSenhaBgm.OnClickOk;
begin
  If edUsuario.Text = '' Then
  Begin
    edUsuario.SetFocus;
    Exit;
  End;
  FazHabilitacaoMenus;
end;

procedure TContSenhaBgm.FazHabilitacaoMenus;
Var
  vSenhaOk : Boolean;
  vSenhaSEG, vSenhaGLOBUS : String;
  I, J, K : Integer;
begin
  vAcessatodasOpcoes := 'N';
  { Desabilita menus }
  DesabilitaMenus;
  { preenche variavel vAcessatodasOpcoes para ver se o usuario tem acesso a todos os
  itens de menu, caso o usuário já tenha acesso a algum item de menu, o sistema irá
  habilitar todos os itens, se o usuario não tiver acesso a a nenhum item não habilitará
  nada mesmo que tenha acesso a todas opções. Esta Opção foi criada para evitar o problema
  de criar um item de menu novo e não aparecer para o usuário }
  VerificaSeUsuarioeAdministrador;
  { Só o usuário GLOBUS pode utilizar o SEGURANÇA e só o GLOBUS ou MANAGER podem
    utilizar o CONTROLE }
  If ( ( Sistema = 'SEG' ) And ( edUsuario.Text <> 'GLOBUS' ) ) Or
       ( ( Sistema = 'CTR' ) And ( edUsuario.Text <> 'GLOBUS' ) And ( edUsuario.Text <> 'MANAGER' ) and
       ( not VerificaSeUsuarioeAdministrador)) Then  // também habilita o controle para o usuário definido como administrador
  begin
    MensagemDlg('Usuário sem permissão a utilizar este módulo.', mtErro, mbOk );
    edUsuario.Clear;
    edUsuario.SetFocus;
    Exit;
  end;
  { Testa se o usuário digitado é o Adminstrador ou BGM, caso seja, habilita todos
    os menus se a senha estiver correta. Para o adminstrador, checa a senha que
    estiver gravada na tabela de Concedente. }
  If ( edUsuario.Text = 'GLOBUS'  ) Or
     ( edUsuario.Text = 'MANAGER' ) Or (vtemMenuparaoSistema and (vAcessatodasOpcoes = 'S')) Then
  begin
    If edSenha.Text = '' Then
    begin
      edSenha.SetFocus;
      Exit;
    end;
    If ( edUsuario.Text <> 'GLOBUS' ) and ( edUsuario.Text <> 'MANAGER' ) and
       (vtemMenuparaoSistema and (vAcessatodasOpcoes = 'S')) Then
      vValidaoMenuNovamente := True;
    { Testa o usuario BGM }
    If ( edUsuario.Text = 'GLOBUS' ) Then
    begin
    { Se a senha for diferente da hora, não habilita, caso contrário habilita
      todos os menus }
//          If Not PesquisaString( edSenha.Text, 'GLB' + Copy(TimeToStr(Time),4,2) + Copy(TimeToStr(Time),1,2) + 'SENHA' ) Then
//          If Not PesquisaString( edSenha.Text, + IIf(Sistema='SEG', 'SEG', '') + 'GLB' + DiasDaSemana[DayOfWeek(Now)] + Copy(DateToStr(Now),1,2) ) Then
      If Now >= StrToDate('18/02/2004') Then // Silvio
      Begin
        vSenhaGLOBUS := '4.18767507002801';
        vSenhaSEG    := '3.10364145658263';
      End
      Else
      Begin
        vSenhaGLOBUS := '5.95238095238095';
        vSenhaSEG    := '3.46778711484594';
      End; // If Now
        vSenhaOk := (( vCodCliente = 9999 ) And ( Sistema <> 'SEG') And ( vFirstControle ) and
            (edSenha.Text = vSenhaGLOBUS));

        If ((Sistema = 'SEG') And (Encripta(edSenha.Text, 20, True) <> vSenhaSEG)) Or
           ((Not vSenhaOk) and
            (Sistema <> 'SEG') And (Encripta(edSenha.Text,20, True) <> vSenhaGLOBUS)) then //Verônica 16/04/2003
  //         'GLB' + DiasDaSemana[DayOfWeek(Now)] + Copy(DateToStr(Now),1,2) )) Then // Silvio 12/6/2002
        Begin
          MensagemDlg('Senha inválida para GLOBUS', mtErro, mbOk );
          edSenha.SetFocus;
          Exit;
        End
      else
      begin
        HabilitaMenusParaAdministrador;
        Exit;
      end;
    end
    else
    begin
      If (( edUsuario.Text <> 'GLOBUS'  ) Or
          ( edUsuario.Text <> 'MANAGER' )) and (vtemMenuparaoSistema and (vAcessatodasOpcoes = 'S')) Then
        HabilitaMenusParaAdministrador
      else
      { Abre a tabela de concedente e testa a senha encriptada }
      With Concedente Do
      begin
        Open;
        First;
        If Descriptografa(FieldByName('ChaveCliente').asString) = edSenha.Text Then
          HabilitaMenusParaAdministrador
        else
        begin
          MensagemDlg('Senha inválida para ADMINISTRADOR', mtErro, mbOk );
          edSenha.SetFocus;
        end;
        Close;
      end;
    end;
  end
  else
  vValidaoMenuNovamente := True;
  While vValidaoMenuNovamente do
    ChecaUsuarioSenha;
  DesabilitaNivelSeNaoTiverNivelInferior;

  { Precisei colocar aqui por tem que enviar o email sem a intervensão do usuário, e não encontrei outro lugar - Verônica  06/07/2004 }
  If (usuario <> '') and (usuario <> 'MANAGER') and (usuario <> 'GLOBUS') and (sistema = 'CGS')  then
    VerificaSeEnviaEmail(usuario,True);

  If Not Visible Then // Faz quando invisível, pois passa por aqui 2 vezes e só pode atuar na segunda
  Begin
    // GRAVANDO AS SHORTCUTS DEFAULTS
    If vShortCuts = '' Then
    begin
      For i := 0 To Menu.Items.Count -1 Do { menu principal }
      begin
        If Menu.Items[i].ShortCut <> TextToShortCut('(none)') Then
          GravaShortCuts(FormatFloat('000',i),ShortCutToText(Menu.Items[i].ShortCut));
        For j := 0 To Menu.Items[i].Count -1 Do { Primeiro submenus }
        begin
          If Menu.Items[i].Items[j].ShortCut <> TextToShortCut('(none)') Then
            GravaShortCuts(FormatFloat('000',i) + FormatFloat('000',j),ShortCutToText(Menu.Items[i].Items[j].ShortCut));
          For k := 0 To Menu.Items[i].Items[j].Count -1 Do { segundo submenus }
            If Menu.Items[i].Items[j].Items[k].ShortCut <> TextToShortCut('(none)') Then
              GravaShortCuts(FormatFloat('000',i) + FormatFloat('000',j) + FormatFloat('000',k),ShortCutToText(Menu.Items[i].Items[j].Items[k].ShortCut));
        End;
      End;
    End;

    // RESGATANDO OU RETIRANDO AS SHORTCUTS
    For i := 0 To Menu.Items.Count -1 Do { menu principal }
    begin
      If NOT Menu.Items[i].Visible Then
        Menu.Items[i].ShortCut := TextToShortCut('(none)')
      Else
        Menu.Items[i].ShortCut := TextToShortCut(BuscaShortCuts(FormatFloat('000',i)));
      For j := 0 To Menu.Items[i].Count -1 Do { Primeiro submenus }
      begin
        If NOT Menu.Items[i].Items[j].Visible Then
          Menu.Items[i].Items[j].ShortCut := TextToShortCut('(none)')
        Else
          Menu.Items[i].Items[j].ShortCut := TextToShortCut(BuscaShortCuts(FormatFloat('000',i) + FormatFloat('000',j)));

        If (vMDTeclas.FindField('TECLAS') <> Nil) And
           (Not vMDTeclas.IsEmpty) Then
        Begin
          If Menu.Items[i].Items[j].Name = 'FIMenuCadastroDeAtalhos' Then
            Menu.Items[i].Items[j].Visible := True
          Else
          If UpperCase(Menu.Items[i].Items[j].Name) = 'AJUDADOMODULO' Then
          Begin
            Try
            Menu.Items[i].Insert(Menu.Items[i].Items[j].Count,FIMenuTeclas) ;
            Menu.Items[i].Items[Menu.Items[i].Items[j].Count].OnClick := FIMenuTeclasClick ;
            Except
            End ; // Try - Except
          End ; // If UpperCase(Menu.Items[i].Items[j].Name) = 'AJUDADOMODULO' Then
        End ; // If (vMDTeclas.FindField('TECLAS') <> Nil) And (...

        For k := 0 To Menu.Items[i].Items[j].Count -1 Do { segundo submenus }
          If NOT Menu.Items[i].Items[j].Items[k].Visible Then
            Menu.Items[i].Items[j].Items[k].ShortCut := TextToShortCut('(none)')
          Else
            Menu.Items[i].Items[j].Items[k].ShortCut := TextToShortCut(BuscaShortCuts(FormatFloat('000',i) + FormatFloat('000',j) + FormatFloat('000',k)));
      End;
    End;
  End;

  If (vMDTeclas.FindField('TECLAS') <> Nil) And (Not vMDTeclas.IsEmpty) Then
    TForm(Self.Parent).PopupMenu := FPMenuTeclas ;

(* Não deu certo, pois ao pedir para trocar de usuário, todos os itens ficaram disabled

  { Ajusta os itens de menus, tornando Enable = Visible. Desta forma os itens invisíveis ficarão desabilitados,
    para não funcionarem indevidamente os shortcuts - Silvio - 07/06/2004 }
  If Not Visible Then // Faz quando invisível, pois passa por aqui 2 vezes e só pode atuar na segunda
  Begin
    For i := 0 To Menu.Items.Count -1 Do { menu principal }
    begin
      Menu.Items[i].Enabled := Menu.Items[i].Visible;
      For j := 0 To Menu.Items[i].Count -1 Do { Primeiro submenus }
      begin
        Menu.Items[i].Items[j].Enabled := Menu.Items[i].Items[j].Visible;
        For k := 0 To Menu.Items[i].Items[j].Count -1 Do { segundo submenus }
          Menu.Items[i].Items[j].Items[k].Enabled := Menu.Items[i].Items[j].Items[k].Visible;
      End;
    End;
  End; *)
end;

procedure TContSenhaBgm.OnClickCancel;
begin
  StatusBar.Panels[2].Text := '';
  DesabilitaMenus;
  EdUsuario.Text        := '';
  EdSenha.Text          := '';
  LbNomeUsuario.Caption := '';
  DesabilitaMenus;
  EdUsuario.SetFocus;
end;

procedure TContSenhaBgm.HabilitaMenusParaAdministrador;
Var t, M, I, S : Integer;
    Qry     : TQuery;
begin
  { Cria um componente do Tipo TQuery para poder inserir um registro na tabela
    de usuario, caso o usuario seja GLOBUS ou MANAGER }

  Qry := TQuery.Create(Self);
  Qry.DatabaseName := 'dbBgm';

{$IfDef UsaDireitosNosHints} // Silvio
  { Preenche nos hints dos itens de menu do menu principal, os direitos do usuário }
  If (edUsuario.Text <> 'GLOBUS') And (edUsuario.Text <> 'MANAGER' ) Then
  Begin
    With Qry Do
    Begin
      DatabaseName := vConcedente.DatabaseName;
      Close;
      Sql.Clear;
      Sql.Add('Select * From CTR_MENUSAOUSUARIO');
      Sql.Add('Where Usuario = :pUsuario And Sistema = :pSistema');
      ParamByName('pUsuario').AsString := edUsuario.Text;
      ParamByName('pSistema').AsString := Sistema;
      Open;
      While Not Eof Do
      Begin
        For M := 0 To Menu.Items.Count - 1 Do
        Begin
          If FieldByName('Nome').AsString = (Menu.Items[M]).Name Then
          Begin
            Menu.Items[M].Hint := FieldByName('TemDireitoInclusaoMenu').AsString +
                                  FieldByName('TemDireitoAlteracaoMenu').AsString +
                                  FieldByName('TemDireitoExclusaoMenu').AsString;
          End;
          For I := 0 To Menu.Items[M].Count - 1 Do
          Begin
            If FieldByName('Nome').AsString = Menu.Items[M].Name Then
            Begin
                Menu.Items[M].Items[I].Hint := FieldByName('TemDireitoInclusaoMenu').AsString +
                                               FieldByName('TemDireitoAlteracaoMenu').AsString +
                                               FieldByName('TemDireitoExclusaoMenu').AsString;
            End;
            For S := 0 To Menu.Items[M].Items[I].Count - 1 Do
            Begin
              If FieldByName('Nome').AsString = Menu.Items[M].Items[I].Items[S].Name Then
              Begin
                Menu.Items[M].Items[I].Items[S].Hint := FieldByName('TemDireitoInclusaoMenu').AsString +
                                                        FieldByName('TemDireitoAlteracaoMenu').AsString +
                                                        FieldByName('TemDireitoExclusaoMenu').AsString;
              End;
            End;
          End;
        End;
        Next;
      End;
    End;
  End;
{$EndIf}

  If ( edUsuario.Text = 'GLOBUS'  ) Or
     ( edUsuario.Text = 'MANAGER' ) Then
  begin
    With Qry Do
    begin
      DatabaseName := vConcedente.DatabaseName;
      { Checa se existe um departamento e um grupo com código zero }
      { Checa o Departamento }
      Close;
      Sql.Clear;
      Sql.Add('SELECT CodDepto FROM FLP_DEPTO WHERE CODDEPTO=1');
      Open;
      If IsEmpty Then
      begin
        Close;
        Sql.Clear;
        Sql.Add('INSERT INTO FLP_DEPTO (CODDEPTO,DESCDEPTO) VALUES (1,' + '''' + 'GERAL' + '''' + ')');
        ExecSQL;
      end;
      { Checa o Grupo }
      Close;
      Sql.Clear;
      Sql.Add('SELECT CodigoGrpUsu FROM CTR_GRUPOUSUARIOS WHERE CODIGOGRPUSU=1'); // aqui
      Open;
      If IsEmpty Then
      begin
        Close;
        Sql.Clear;
        Sql.Add('INSERT INTO CTR_GRUPOUSUARIOS (CODIGOGRPUSU,CODDEPTO,DESCRICAOGRPUSU) VALUES (1,1,' + '''' + 'GERAL' + '''' + ')');
        ExecSQL;
      end;


      { Checa o Usuario MANAGER ou GLOBUS e inclui se não existir }
      Close;
      Sql.Clear;
      Sql.Add('Select Usuario From CTR_CadastroDeUsuarios Where Usuario = :pUsuario');
      ParamByName('pUsuario').AsString := Trim(edUsuario.Text);
      Open;
      If IsEmpty Then
      begin
        Close;
        Sql.Clear;
        { Insere na tabela de Cadastro de Usuarios }
        Sql.Add('INSERT INTO CTR_CADASTRODEUSUARIOS (USUARIO, CODIGOGRPUSU, SENHA) VALUES ('+''''+Trim(edUsuario.Text)+''''+',1,'+''''+'0.00000000'+''''+')');
        ExecSQL;
      end;
      Close;
    end;
  end;

  { Colocado porque antes não estava validado a senha de um usuario adiministrador }
  If (( edUsuario.Text <> 'GLOBUS'  ) Or
      ( edUsuario.Text <> 'MANAGER' )) and (vtemMenuparaoSistema and (vAcessatodasOpcoes = 'S')) Then
  begin
    { Checa se existe o usuario e consiste a senha }
    With CadastroDeUsuarios Do
    begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT * FROM CTR_CADASTRODEUSUARIOS WHERE USUARIO = :PUSUARIO');
      ParamByName('PUSUARIO').DataType  := ftString;
      ParamByName('PUSUARIO').ParamType := ptInput;
      ParamByName('PUSUARIO').asString  := EdUsuario.Text;
      Open;
      If IsEmpty Then
      begin
        MensagemDlg('Usuário não encontrado.', mtErro, mbOk );
        Close;
        edUsuario.SetFocus;
        Exit;
      end;
      vCodIntFunc := FieldByName('CODINTFUNC').AsInteger;
      LbNomeUsuario.Caption    := FieldByName('NOMEUSUARIO').AsString;
      StatusBar.Panels[2].Text := FieldByName('NOMEUSUARIO').AsString;

      If edSenha.Text = '' Then
      begin
        edSenha.SetFocus;
        Exit;
      end;
      If FieldByName('Senha').asString <> Encripta( edSenha.Text, 10, SenhaUsuarioPosicional) Then
      begin
        MensagemDlg('Senha inválida.', mtErro, mbOk );
        edSenha.SetFocus;
        Close;
        Exit;
      end;
    end;
  end;

  { Encontra no itens de menu o registro atual MenusdoSistema que não está autorizado e deixo o enabled = false }
  With Qry do
  begin
    close;
    sql.Clear;
    Sql.Add('SELECT A.*,0 AS ABSOLUTEINDEX,''N'' AS GRAVATECLAS,TECLAS AS COPIATECLAS FROM CTR_MENUSDOSISTEMA A WHERE SISTEMA = :PSIS ORDER BY SISTEMA,INDICEMENU,CAPTION');
    ParamByName('PSIS').AsString := Sistema;
    Open;
    vTemMenusEspecificosNaoAutorizados := False;
    Visible := False;

    vMDTeclas.LoadFromDataSet(Qry,0,lmCopy) ;
    While not eof do
    begin
      If ( Encripta( FieldByName('sistema').AsString + FieldByName('Caption').AsString + FieldByName('Nome').AsString + 'N',10) = Trim(FieldByName('CheckSumMenu').AsString) ) or
         ( Trim(FieldByName('CheckSumMenu').AsString) = '') or
         ( Encripta( FieldByName('sistema').AsString + FieldByName('IndiceMenu').AsString + FieldByName('Nome').AsString + 'N',10) = Trim(FieldByName('CheckSumMenu').AsString) ) then
      Begin
        vTemMenusEspecificosNaoAutorizados := True;
{        ShowMessage('Item de menu ' + FieldByName('Nome').AsString + ' "' +
        Encripta( FieldByName('sistema').AsString + FieldByName('IndiceMenu').AsString +
        FieldByName('Nome').AsString,10) +'"'+
        FieldByName('CheckSumMenu').AsString);
}
        For M := 0 To Menu.Items.Count -1 Do
        begin
          For I := 0 To Menu.Items[M].Count -1 Do
          begin
            For S := 0 To Menu.Items[M].Items[I].Count -1 Do
            begin
              If FieldByName('Nome').asString = Menu.Items[M].Items[I].Items[S].Name Then
              begin
                Menu.Items[M].Items[I].Items[S].Enabled := False;
                { Habilita ToolBar }
                If ToolBar <> Nil Then
                  For T := 0 To ToolBar.ButtonCount-1 Do
                    If UpperCase(ToolBar.Buttons[T].Name) = UpperCase('tb' + Menu.Items[M].Items[I].Items[S].Name ) Then
                      ToolBar.Buttons[T].Enabled := False;
              end;
            end;
            If FieldByName('Nome').asString = Menu.Items[M].Items[I].Name Then
            begin
              Menu.Items[M].Items[I].Enabled := False;
              { Habilita ToolBar }
              If ToolBar <> Nil Then
                For T := 0 To ToolBar.ButtonCount-1 Do
                  If UpperCase(ToolBar.Buttons[T].Name ) = UpperCase( 'tb' + Menu.Items[M].Items[I].Name ) Then
                    ToolBar.Buttons[T].Enabled := false;;
            end;
          end;
          If FieldByName('Nome').asString = (Menu.Items[M]).Name Then
          begin
            Menu.Items[M].Enabled := false;
            { Habilita ToolBar }
            If ToolBar <> Nil Then
              For T := 0 To ToolBar.ButtonCount-1 Do
                If UpperCase(ToolBar.Buttons[T].Name ) = UpperCase( 'tb' + Menu.Items[M].Name ) Then
                  ToolBar.Buttons[T].Enabled := false;
          end;
        end;
      end;
      Next;
    end;
  end;
  { Habilita Menu }
  { Faz um AND com a propriedade ENABLED e Usuario MANAGER, para só habilitar as opções realmente válidas }

  For M := 0 To Menu.Items.Count -1 Do
  begin
    For I := 0 To Menu.Items[M].Count -1 Do
    begin
      For S := 0 To Menu.Items[M].Items[I].Count -1 Do
      begin
        If (edUsuario.Text = 'GLOBUS') and (not vTemMenusEspecificosNaoAutorizados) Then
          Menu.Items[M].Items[I].Items[S].Visible := True
        else
          Menu.Items[M].Items[I].Items[S].Visible := True And Menu.Items[M].Items[I].Items[S].Enabled;
      end;
      If (edUsuario.Text = 'GLOBUS') and (not vTemMenusEspecificosNaoAutorizados) then
        Menu.Items[M].Items[I].Visible := True
      else
        Menu.Items[M].Items[I].Visible := True And Menu.Items[M].Items[I].Enabled;
    end;
    If (edUsuario.Text = 'GLOBUS') and (not vTemMenusEspecificosNaoAutorizados) then
      Menu.Items[M].Visible := True
    else
      Menu.Items[M].Visible := True And Menu.Items[M].Enabled;
  end;
  { Habilita ToolBar }
  Qry.Free;

  If ToolBar <> Nil Then
    For I := 0 To ToolBar.ButtonCount-1 Do
      ToolBar.Buttons[I].Visible := True;

  { Iguala Usuario ao Status Bar }

  If edUsuario.Text = 'GLOBUS' Then
  begin
    With Concedente Do
    begin
      Open;
      First;
      LbNomeUsuario.Caption    := FieldByName('NomeConcedente').asString;
      StatusBar.Panels[2].Text := FieldByName('NomeConcedente').asString;
      Close;
    end;
  end
  else
  If edUsuario.Text = 'MANAGER' Then
  begin
    LbNomeUsuario.Caption    := 'MANAGER';
    StatusBar.Panels[2].Text := 'MANAGER';
  end;
  { grava log para saber quando o usuário entrou no sistema }
  GravaLog(Sistema, EdUsuario.Text, Now, 'Informou senha em: ' + WinLogin + '/' + TrazNomeDoComputador + '.');
  Usuario := edUsuario.Text;
end;

procedure TContSenhaBgm.ChecaUsuarioSenha;
Var M, I, S, T : Integer;
Qry     : TQuery;
begin
  vValidaoMenuNovamente := False;
  { Checa se existe o usuario e consiste a senha }
  With CadastroDeUsuarios Do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_CADASTRODEUSUARIOS WHERE USUARIO = :PUSUARIO');
    ParamByName('PUSUARIO').DataType  := ftString;
    ParamByName('PUSUARIO').ParamType := ptInput;
    ParamByName('PUSUARIO').asString  := EdUsuario.Text;
    Open;
    If IsEmpty Then
    begin
      MensagemDlg('Usuário não encontrado.', mtErro, mbOk );
      Close;
      edUsuario.SetFocus;
      Exit;
    end;
    vCodIntFunc := FieldByName('CODINTFUNC').AsInteger;
    LbNomeUsuario.Caption := FieldByName('NOMEUSUARIO').AsString;
    If edSenha.Text = '' Then
    begin
      edSenha.SetFocus;
      Exit;
    end;
    If FieldByName('Ativo').AsString = 'N' Then
    Begin
      Close;
      MensagemDlg('Usuário inativo. Consulte o administrador.', mtErro, mbOk );
      edUsuario.SetFocus;
      Exit;
    End;
    If FieldByName('Senha').asString <> Encripta( edSenha.Text, 10, SenhaUsuarioPosicional ) Then
    begin
      Close;
      MensagemDlg('Senha inválida.', mtErro, mbOk );
      edSenha.SetFocus;
      Exit;
    end;
    if vCodCliente = 14 then
    begin
      If (FieldByName('DataSenha').AsString <> '') And
         (Abs(FieldByName('DataSenha').AsDateTime - Now) >= 50) and
         (Abs(FieldByName('DataSenha').AsDateTime - Now) < 60)Then
      Begin
        GravaLog(Sistema, edUsuario.Text, Now, 'Senha superior ou igual a 50 dias.');
        MensagemDlg('Sua senha deve ser trocada. Se não souber como trocá-la, consulte o administrador.', mtInformacao,mbOK) ;
      End;
      If (FieldByName('DataSenha').AsString <> '') And
         (Abs(FieldByName('DataSenha').AsDateTime - Now) >= 60)Then
      Begin
        GravaLog(Sistema, edUsuario.Text, Now, 'Senha superior ou igual a 60 dias, acesso bloqueado.');
        MensagemDlg('Acesso ao módulo bloqueado. Troque sua senha.', mtInformacao,mbOK) ;
        Usuario := edUsuario.Text;
        edSenha.Clear;
        EdSenha.SetFocus;
        With TfrmCTRTrocaSenhaDeUsuario.Create( Application ) do
        Begin
          vChamadoPor := 'S';
          ShowModal;
          Free;
        end;
        exit;
      End;
    end
    else
    begin
      { Verifica se a senha não é trocada a mais de 30 dias }
      If (FieldByName('DataSenha').AsString <> '') And
         (Abs(FieldByName('DataSenha').AsDateTime - Now) > 30) Then
      Begin
        GravaLog(Sistema, edUsuario.Text, Now, 'Senha superior a 30 dias.');
        MensagemDlg('Sua senha não é trocada há mais de 30 dias. Se não souber como trocá-la, consulte o administrador.', mtInformacao,mbOK) ;
      End;
    end;

    { Verifica se a senha é a padrão }
    If FieldByName('Senha').asString = Encripta( '123', 10, SenhaUsuarioPosicional ) then
      MensagemDlg('Sua senha está como padrão. Precisa ser mudada. Se não souber como trocá-la, consulte o administrador.', mtInformacao,mbOK) ;

    If dm.DbBGM.InTransaction Then dm.DbBGM.Rollback;
    dm.DbBGM.StartTransaction;
    { grava log para saber quando o usuário entrou no sistema }
//      GravaLog(Sistema, EdUsuario.Text, Now, 'Informou senha.');
      GravaLog(Sistema, EdUsuario.Text, Now, 'Informou senha em: ' + WinLogin + '/' + TrazNomeDoComputador + '.');
    dm.DbBGM.Commit;

  end;
  LbNomeUsuario.Caption    := CadastroDeUsuarios.FieldByName('NomeUsuario').asString;
  StatusBar.Panels[2].Text := CadastroDeUsuarios.FieldByName('NomeUsuario').asString;

  { reconecta no banco com o usuario_DB informado no cadastro de usuário }
  If (Trim(CadastroDeUsuarios.FieldByName('USUARIO_DB').asString) <> '') and
     (Trim(CadastroDeUsuarios.FieldByName('SENHA_DB').asString) <> '') Then
  begin
    vUsuarioDB := Trim(CadastroDeUsuarios.FieldByName('USUARIO_DB').asString);
    If not ReconectaBanco(Trim(CadastroDeUsuarios.FieldByName('USUARIO_DB').asString),
                   Trim(CadastroDeUsuarios.FieldByName('SENHA_DB').asString)) then
    begin
      Exit;
    end;
  end;
  Visible := False;
  If ( edUsuario.Text <> 'GLOBUS' ) and ( edUsuario.Text <> 'MANAGER' ) and
     (vAcessatodasOpcoes = 'N') Then
  begin
    { Habilita os menus autorizados para o usuario }
    With MenusAoUsuario Do
    begin
      { Fecha a tabela e seta os parametros }
      Close;
      Sql.Clear;
      Sql.Add('SELECT * FROM CTR_MENUSAOUSUARIO WHERE USUARIO = :PUSUARIO AND SISTEMA = :PSISTEMA');
      ParamByName('PUSUARIO').asString := Trim(EdUsuario.Text);
      ParamByName('PSISTEMA').asString := Trim(Sistema);
      Open;

      Qry := TQuery.Create(Self) ;
      Qry.DatabaseName := 'dbBgm' ;

      Qry.Close;
      Qry.Sql.Clear ;
      Qry.Sql.Add(' SELECT A.*,0 AS ABSOLUTEINDEX,''N'' AS GRAVATECLAS,TECLAS AS COPIATECLAS FROM CTR_MENUSAOUSUARIO A WHERE USUARIO = :PUSUARIO AND SISTEMA = :PSISTEMA');
      Qry.ParamByName('PUSUARIO').asString := Trim(EdUsuario.Text);
      Qry.ParamByName('PSISTEMA').asString := Trim(Sistema);
      Qry.Open;
      vMDTeclas.LoadFromDataSet(Qry,0,lmCopy) ;
      Qry.Free ;

      First;
      { Faz um loop }
      While Not Eof Do
      begin
        { Verifica se o checksum está correto }
        If FieldByName('CHECKSUMMENU').asString <> Encripta( FieldByName('USUARIO'   ).asString +
                                                             FieldByName('SISTEMA'   ).asString +
                                                             FieldByName('INDICEMENU').asString +
                                                             FieldByName('NOME'      ).asString +
                                                             FieldByName('CAPTION'   ).asString , 10 ) Then
        begin
          { Se for diferente verifica tirando os acentos, se também for diferente ignoro o menu }
          If FieldByName('CHECKSUMMENU').asString <> Encripta( FieldByName('USUARIO'   ).asString +
                                                             FieldByName('SISTEMA'   ).asString +
                                                             FieldByName('INDICEMENU').asString +
                                                             FieldByName('NOME'      ).asString +
                                                             RemoveCaractersDiferentedeAlfa(FieldByName('CAPTION').asString) , 10 ) Then
          begin
            GravaNaTabelaCTR_Cadsis( FieldByName('INDICEMENU').asString
                                   , FieldByName('NOME'      ).asString
                                   , RemoveCaractersDiferentedeAlfa(FieldByName('CAPTION').asString)
                                   ,999); {999 por se tratar do Menusaousuario}
            vValidaoMenuNovamente := True;
            Next;
            Continue;
          end;
        end;
        { Encontra no itens de menu o registro atual MenusAoUsuario }
        For M := 0 To Menu.Items.Count -1 Do
        begin
          For I := 0 To Menu.Items[M].Count -1 Do
          begin
            For S := 0 To Menu.Items[M].Items[I].Count -1 Do
              If FieldByName('Nome').asString = Menu.Items[M].Items[I].Items[S].Name Then
              begin
                Menu.Items[M].Items[I].Items[S].Visible := True And Menu.Items[M].Items[I].Items[S].Enabled;
                { Habilita ToolBar }
                If ToolBar <> Nil Then
                  For T := 0 To ToolBar.ButtonCount-1 Do
                    If UpperCase(ToolBar.Buttons[T].Name) = UpperCase('tb' + Menu.Items[M].Items[I].Items[S].Name ) Then
                      ToolBar.Buttons[T].Visible := True And Menu.Items[M].Items[I].Items[S].Enabled;
              end;
            If FieldByName('Nome').asString = Menu.Items[M].Items[I].Name Then
            begin
              Menu.Items[M].Items[I].Visible := True And Menu.Items[M].Items[I].Enabled;
              { Habilita ToolBar }
              If ToolBar <> Nil Then
                For T := 0 To ToolBar.ButtonCount-1 Do
                  If UpperCase(ToolBar.Buttons[T].Name ) = UpperCase( 'tb' + Menu.Items[M].Items[I].Name ) Then
                    ToolBar.Buttons[T].Visible := True And Menu.Items[M].Items[I].Enabled;
            end;
          end;
          If FieldByName('Nome').asString = (Menu.Items[M]).Name Then
          begin
            Menu.Items[M].Visible := True And Menu.Items[M].Enabled;
            { Habilita ToolBar }
            If ToolBar <> Nil Then
              For T := 0 To ToolBar.ButtonCount-1 Do
                If UpperCase(ToolBar.Buttons[T].Name ) = UpperCase( 'tb' + Menu.Items[M].Name ) Then
                  ToolBar.Buttons[T].Visible := True And Menu.Items[M].Enabled;
          end;
        end;
        Next;
      end;
    end;
    { Habilita os Itens que são divisão (-) }
    For M := 0 To Menu.Items.Count -1 Do
    begin
      For I := 0 To Menu.Items[M].Count -1 Do
      begin
        For S := 0 To Menu.Items[M].Items[I].Count -1 Do
          If Menu.Items[M].Items[I].Items[S].Caption = '-' Then
            Menu.Items[M].Items[I].Items[S].Visible := True;
        If Menu.Items[M].Items[I].Caption = '-' Then
          Menu.Items[M].Items[I].Visible := True;
      end;
      If Menu.Items[M].Caption = '-' Then
        Menu.Items[M].Visible := True
    end;
  end;
  { Fecha as tabelas }
  CadastroDeUsuarios.Close;
  MenusAoUsuario.Close;
  { Iguala variaveis }
  Usuario := edUsuario.Text;
  If not vValidaoMenuNovamente then //If vValidaoMenuNovamente = False then
  begin
    Visible := False;
    edSenha.Text := ''; // Silvio
  end;
end;

procedure TContSenhaBgm.DesabilitaMenus;
Var I, iModulo, iItem, iSubItem: Integer;
begin
  { Desabilita Menus }
  For iModulo := Menu.Items.Count-1 DownTo 0 Do
  begin
    For iItem := Menu.Items[iModulo].Count-1 DownTo 0 Do
    begin
      For iSubItem := Menu.Items[iModulo].Items[iItem].Count-1 DownTo 0 Do
        If UpperCase(Copy(Menu.Items[iModulo].Items[iItem].Items[iSubItem].Name,1,5)) <> 'AJUDA' Then
          Menu.Items[iModulo].Items[iItem].Items[iSubItem].Visible := False;
      If UpperCase(Copy(Menu.Items[iModulo].Items[iItem].Name,1,5)) <> 'AJUDA' Then
        Menu.Items[iModulo].Items[iItem].Visible := False;
    end;
    If ( UpperCase(Menu.Items[iModulo].Name) <> 'SAIDA'           ) And
       ( UpperCase(Copy(Menu.Items[iModulo].Name,1,5)) <> 'AJUDA' ) Then
      Menu.Items[iModulo].Visible := False;
  end;
  { Desabilita ToolBar }
  If ToolBar <> Nil Then
    For I := 0 To ToolBar.ButtonCount-1 Do
      ToolBar.Buttons[I].Visible := False;

  vMDTeclas.Close ;
end;

Procedure TContSenhaBgm.GeraTabelaAPartirDoMenu;
Var cModulo, cItem, cSubItem : Integer;
    qrAux, qrAux1   : TQuery;
    Edit1 : TEdit;
begin
  { Cria o componente query }
  qrAux  := TQuery.Create(Self);
  qrAux1 := TQuery.Create(Self);
  qrAux.DatabaseName  := 'dbBgm';
  qrAux1.DatabaseName := 'dbBgm';
  Msg('Verificando menus ...');
  Edit1 := TEdit.Create(Self);
  {$Include \globus\sistemas\datahora.txt} // Aproveita a mesma informação da tela de ajuda,
                                           // onde Edit1.Text := DD/MM/AAAA HH:MM
  { Verifica se deve validar os menus }
  Try
    With qrAux Do
    begin
      Close;
      Sql.Clear;
      Sql.Add('Select DataHoraMenus From Ctr_CadastroSistemas ');
      Sql.Add('Where Sistema = :pSistema '                       );
      ParamByName('pSistema').asString := Sistema;
      Open;
      If StrToDateTime(FieldByName('DataHoraMenus').AsString) >= StrToDateTime(Edit1.Text) Then
      Begin
        If StrToDateTime(FieldByName('DataHoraMenus').AsString) > StrToDateTime(Edit1.Text) Then
          ShowMessage('Atenção: Esta versão pode não ser a mais nova. Use com cautela. Na dúvida, fale com o administrador.');
        qrAux.Close;
        qrAux1.Close;
        qrAux.Free;
        qrAux1.Free;
        Edit1.Free;
        Msg;
        Exit; // Retorna daqui
      End;
    End;
  Except
  End;

  Msg('Verificando / ajustando a estrutura dos menus ...');

  { Abre uma transação }
  If dm.DbBGM.InTransaction Then dm.DbBGM.Rollback;
  dm.DbBGM.StartTransaction;
  { Faz abertura da tabela Ctr_MenusDoSistema for Update }
  With qrAux Do
  begin
    Close;
    Sql.Clear;
    Sql.Add('Select * From Ctr_MenusDoSistema ');
    Sql.Add('Where Sistema=:pSistema '         );
    Sql.Add('For Update'                       );
    ParamByName('pSistema').asString := Sistema;
    Open;
  end;
  { Caso não exista a coluna MenuValido na tabela Ctr_MenusDoSistema a cria }
  With qrAux Do
  begin
    { Verifica se a coluna existe }
    Close;
    Sql.Clear;
    Sql.Add('Select MenuValido From Ctr_MenusDoSistema Where Sistema=:pSistema');
    ParamByName('pSistema').DataType := ftString;
    ParamByName('pSistema').asString := Sistema;
    try
      Open;
    except
      { Cria a coluna }
      Close;
      Sql.Clear;
      Sql.Add('Alter Table Ctr_MenusDoSistema Add ( MenuValido VarChar2(1) )');
      ExecSQL;
    end;
    { Verifica se a coluna existe }
    Close;
    Sql.Clear;
    Sql.Add('Select CheckSumMenu From Ctr_MenusDoSistema Where Sistema=:pSistema');
    ParamByName('pSistema').DataType := ftString;
    ParamByName('pSistema').asString := Sistema;
    try
      Open;
    except
      { Cria a coluna }
      Close;
      Sql.Clear;
      Sql.Add('Alter Table Ctr_MenusDoSistema Add ( CheckSumMenu VarChar2(10) )');
      ExecSQL;
    end;

    { Grava N na coluna MenuValido para todos os itens do sistema }
    Close;
    Sql.Clear;
    Sql.Add('Update Ctr_MenusDoSistema Set MenuValido = ''N'' ');
    Sql.Add('Where Sistema=:pSistema'                          );
    ParamByName('pSistema').DataType := ftString;
    ParamByName('pSistema').asString := Sistema;
    ExecSQL;
    Close;
  end;
  { Inicia armazenamento na tabela conforme itens do menu }
  For cModulo := 0 To Menu.Items.Count-1 Do
  begin
    If (Usuario = 'GLOBUS' ) Or
       (Menu.Items[cModulo].Visible) then
    Begin
      GravaNaTabelaCTR_Cadsis( StrZero(cModulo,2,0)
                             , Menu.Items[cModulo].Name
                             , Menu.Items[cModulo].Caption
                             , Menu.Items[cModulo].Tag );
      For cItem := 0 To Menu.Items[cModulo].Count-1 Do
      begin
        If (Usuario = 'GLOBUS' ) Or
           (Menu.Items[cModulo].Items[cItem].Visible) then
        begin
          GravaNaTabelaCTR_Cadsis( StrZero(cModulo,2,0) + StrZero(cItem,2,0)
                                 , Menu.Items[cModulo].Items[cItem].Name
                                 , Menu.Items[cModulo].Items[cItem].Caption
                                 , Menu.Items[cModulo].Items[cItem].tag );
          For cSubItem := 0 To Menu.Items[cModulo].Items[cItem].Count-1 Do
          begin
            If (Usuario = 'GLOBUS' ) Or
               (Menu.Items[cModulo].Items[cItem].Items[cSubItem].Visible) then
              GravaNaTabelaCTR_Cadsis( StrZero(cModulo,2,0) + StrZero(cItem,2,0) + StrZero(cSubItem,2,0)
                                     , Menu.Items[cModulo].Items[cItem].Items[cSubItem].Name
                                     , Menu.Items[cModulo].Items[cItem].Items[cSubItem].Caption
                                     , Menu.Items[cModulo].Items[cItem].Items[cSubItem].Tag );
          end;
        end;
      end;
    End;
  end;
  { Exclui todos os itens de menus que ficaram como MenuValido = 'N' }
  With qrAux Do
  begin
    { Limpa da tabela Ctr_MenusAoGrupo e Ctr_MenusAoUsuario }
    Close;
    Sql.Clear;
    Sql.Add('Select * From Ctr_MenusDoSistema '             );
    Sql.Add('Where Sistema=:pSistema And MenuValido = ''N''');
    ParamByName('pSistema').DataType := ftString;
    ParamByName('pSistema').asString := Sistema;
    Open;
    While Not Eof Do
    begin
      { Limpa da tabela Ctr_MenusAoGrupo }
      qrAux1.Close;
      qrAux1.Sql.Clear;
      qrAux1.Sql.Add('Delete From Ctr_MenusAoGrupo '            );
      qrAux1.Sql.Add('Where Sistema    = :pSistema    And ');
      qrAux1.Sql.Add('      IndiceMenu = :pIndiceMenu And ');
      qrAux1.Sql.Add('      Nome       = :pNome '          );
      qrAux1.ParamByName('pSistema'   ).asString := FieldByName('Sistema'   ).asString;
      qrAux1.ParamByName('pIndiceMenu').asString := FieldByName('IndiceMenu').asString;
      qrAux1.ParamByName('pNome'      ).asString := FieldByName('Nome'      ).asString;
      qrAux1.ExecSQL;
      { Limpa da tabela Ctr_MenusAoGrupo }
      qrAux1.Close;
      qrAux1.Sql.Clear;
      qrAux1.Sql.Add('Delete From Ctr_MenusAoUsuario '          );
      qrAux1.Sql.Add('Where Sistema    = :pSistema    And ');
      qrAux1.Sql.Add('      IndiceMenu = :pIndiceMenu And ');
      qrAux1.Sql.Add('      Nome       = :pNome '          );
      qrAux1.ParamByName('pSistema'   ).asString := FieldByName('Sistema'   ).asString;
      qrAux1.ParamByName('pIndiceMenu').asString := FieldByName('IndiceMenu').asString;
      qrAux1.ParamByName('pNome'      ).asString := FieldByName('Nome'      ).asString;
      qrAux1.ExecSQL;
      Next;
    end;
    { Limpa da tabela Ctr_MenusDoSistema }
    Close;
    Sql.Clear;
    Sql.Add('Delete From Ctr_MenusDoSistema '                    );
    Sql.Add('Where Sistema=:pSistema And MenuValido = ''N''');
    ParamByName('pSistema').DataType := ftString;
    ParamByName('pSistema').asString := Sistema;
    ExecSQL;
    Close;
  end;
  { Atualiza data e hora da verificacao dos menus }
  Try
    With qrAux Do
    begin
      Close;
      Sql.Clear;
      Sql.Add( 'Update Ctr_CadastroSistemas '    );
      Sql.Add( 'Set DataHoraMenus = :pDataHora ' );
      Sql.Add( 'Where Sistema = :pSistema '      );
      ParamByName('pDataHora').asString := Edit1.Text;
      ParamByName('pSistema').asString := Sistema;
      ExecSql;
      Close;
    End;
  Except
  End;
  { Fecha a transação }
  dm.DbBGM.Commit;
  Msg;
  { Limpa o componente }
  qrAux.Close;
  qrAux1.Close;
  qrAux.Free;
  qrAux1.Free;
  Edit1.Free;
end;

Function TContSenhaBgm.VerificaSeUsuarioeAdministrador : Boolean;
var   qrAux : TQuery;
begin
  { Cria o componente query }
  qrAux  := TQuery.Create(Self);
  qrAux.DatabaseName  := 'dbBgm';

  AlteraTabela;
  With CadastroDeUsuarios Do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT * FROM CTR_CADASTRODEUSUARIOS WHERE USUARIO = :PUSUARIO');
    ParamByName('PUSUARIO').DataType  := ftString;
    ParamByName('PUSUARIO').ParamType := ptInput;
    ParamByName('PUSUARIO').AsString  := EdUsuario.Text;
    Open;
    Result := FieldByName('ADMINISTRADOR').AsString = 'S';
    { Não permite acesso completo ao controle }
    If Sistema = 'CTR' Then
      vAcessaTodasOpcoes := 'N'
    Else
      vAcessaTodasOpcoes := FieldByName('ACESSATODASOPCOES').AsString;
  end;
  With qrAux Do
  begin
    { Se não existir, o campo administrador e acessatodasopcoes, altera a tabela de
      cadastrodeusuarios adicionando os campos }
    Close;
    Sql.Clear;
    if DM.vBancoDeDados = 'ORACLE' then
      Sql.Add('SELECT COUNT(*) QTD FROM CTR_MENUSAOUSUARIO')
    else
      Sql.Add('SELECT COUNT(*) AS QTD FROM CTR_MENUSAOUSUARIO');

    Sql.Add('WHERE SISTEMA    = :PSISTEMA    AND ');
    Sql.Add('      USUARIO    = :PNOME '          );
    ParamByName('pSistema'   ).asString := vSistema;
    ParamByName('pNome'      ).asString := EdUsuario.Text;
    Open;
    vTemMenuParaoSistema := FieldByName('QTD').AsInteger > 1;
  end;
  qrAux.Close;
  qrAux.Free;
end;

Procedure TContSenhaBgm.Alteratabela;
var   qrAux : TQuery;
begin
  { Cria o componente query }
  qrAux  := TQuery.Create(Self);
  qrAux.DatabaseName  := 'dbBgm';

  With qrAux Do
  begin
    { Se não existir, o campo administrador e acessatodasopcoes, altera a tabela de
      cadastrodeusuarios adicionando os campos }
    Close;
    Sql.Clear;
    Sql.Add('SELECT ADMINISTRADOR FROM CTR_CADASTRODEUSUARIOS');
    Try
      Open;
    Except
      Begin
        Close;
        Sql.Clear;
        Sql.Add(' ALTER TABLE CTR_CADASTRODEUSUARIOS ADD (ADMINISTRADOR VARCHAR2(1) DEFAULT ''N'', ');
        Sql.Add(' ACESSATODASOPCOES VARCHAR2(1) DEFAULT ''N'') ');;
        Try
          ExecSql;
          Except On E:EDBEngineError Do
          Begin
            { Caso ocorra erro, exibe a mensagem de erro no arquivo }
            MensagemDlg('Erro: ' + IntToStr(E.Errors[1].ErrorCode) + E.Errors[1].Message,mtErro, mbOk );
          end;
        End;
      End;
    End;
    Close;
    Sql.Clear;
    Sql.Add('UPDATE CTR_CADASTRODEUSUARIOS SET ADMINISTRADOR = ''N'' WHERE ADMINISTRADOR IS NULL');
    ExecSql;
    Sql.Clear;
    Sql.Add('UPDATE CTR_CADASTRODEUSUARIOS SET ACESSATODASOPCOES = ''N'' WHERE ACESSATODASOPCOES IS NULL');
    ExecSql;
    Close;
  end;
  qrAux.Close;
  qrAux.Free;
end;

{Rotina para gravar na tabela}
procedure TContSenhaBgm.GravaNaTabelaCTR_Cadsis(Indice,Nome,Caption:String; pTag : Integer);
Var vIndice: String;
    qrAux, qrAux1   : TQuery;
begin
  { Cria o componente query }
  qrAux  := TQuery.Create(Self);
  qrAux1 := TQuery.Create(Self);
  qrAux.DatabaseName  := 'dbBgm';
  qrAux1.DatabaseName := 'dbBgm';
  Limitamenus;
  { Remove o & do caption }
  Delete(Caption,Pos('&',Caption),1);
  { Caso o caption tenha o length > 30, trunca }
  If Length(Caption) > 50 Then Caption := Copy(Caption,1,50);
  { Caso algum destes atributos estejam em branco, ignora }
  If ( Length(Sistema)=0 ) Or
     ( Length(Indice)=0  ) Or
     ( Length(Nome)=0    ) Then
  begin
    GravaLog(Sistema,'GLOBUS',Now,'Menu sem atributo, Indice/Nome/Caption: ' + Indice + '/' + Nome + '/' + Caption );
    Exit;
  end;
  If ( Length(Sistema) >  3 ) Or
     ( Length(Indice)  >  6 ) Or
     ( Length(Nome)    > 30 ) Then
  begin
    ShowMessage('Um destes atributos tem o length maior que o definido na tabela: ' + Chr(13) +
                'Sistema: ' + Sistema + ' Tm: ' + IntToStr(Length(Sistema)) + ', limite:  3' + Chr(13) +
                'Indice.: ' + Indice  + ' Tm: ' + IntToStr(Length(Indice )) + ', limite:  6' + Chr(13) +
                'Nome...: ' + Nome    + ' Tm: ' + IntToStr(Length(Nome   )) + ', limite: 30' + Chr(13) +
                'Caption: ' + Caption + ' Tm: ' + IntToStr(Length(Caption)) + ', limite: 50' + Chr(13) );
    Exit;
  end;
  { Executa os procedimentos }
  With qrAux Do
  begin
    { Se existir os dados na tabela, atualiza o caption }
    Close;
    Sql.Clear;
    Sql.Add('Select * From Ctr_MenusDoSistema');
    Sql.Add('Where Sistema    = :pSistema    ');
    Sql.Add('  And IndiceMenu = :pIndiceMenu ');
    Sql.Add('  And Nome       = :pNome '      );
    ParamByName('pSistema'   ).asString := Sistema;
    ParamByName('pIndiceMenu').asString := Indice;
    ParamByName('pNome'      ).asString := Nome;
    Open;
    { Já existe, atualiza o caption }
    If Not IsEmpty Then
    begin
      With qrAux1 Do
      begin
        Close;
        Sql.Clear;
        Sql.Add('Update Ctr_MenusDoSistema '        );
        Sql.Add('Set Caption = :pCaption'           );
        Sql.Add('  , MenuValido=''S'''              );
        Sql.Add('  , CheckSumMenu = :pCheckSumMenu ');
        Sql.Add('Where Sistema    = :pSistema    '  );
        Sql.Add('  And IndiceMenu = :pIndiceMenu '  );
        Sql.Add('  And Nome       = :pNome '        );
        ParamByName('pSistema'   ).asString := Sistema;
        ParamByName('pIndiceMenu').asString := Indice;
        ParamByName('pNome'      ).asString := Nome;
        ParamByName('pCaption'   ).asString := Caption;

        vTagSN := 'I'; { Default para itens de menus não controlados }
        If (pTag = 1) then
        begin
          vTagSN := 'N'; { Default para todos os casos, exceto S }
          If (Trim(qrAux.FieldByName('CheckSumMenu').AsString) = Encripta( Sistema + Caption + Nome + 'S',10)) or
             (Trim(qrAux.FieldByName('CheckSumMenu').AsString) = Encripta( Sistema + Indice + Nome + 'S',10)) then
            vTagSN := 'S' { para não mudar }
        end;

        ParamByName('pCheckSumMenu'  ).asString := Encripta( Sistema + Caption + Nome + vTagSN,10 );
        ExecSQL;
        If Trim(edUsuario.Text) <> '' then //Só se já tiver informado o Usuário
        begin ///{ Monta o comando Sql para fazer um update na tabela Ctr_MenusAoUsuario }
          Close;
          Sql.Clear;
          Sql.Add('Update Ctr_MenusAoUsuario '          );
          Sql.Add('Set Caption      = :pCaption '       );
          Sql.Add('  , CheckSumMenu = :pCheckSumMenu '  );
          Sql.Add('Where Usuario    = :pUsuario        ');
          Sql.Add('  And Sistema    = :pSistema        ');
          Sql.Add('  And IndiceMenu = :pIndiceMenu     ');
          Sql.Add('  And Nome       = :pNome '          );
          ParamByName('pUsuario'       ).asString := edUsuario.Text;
          ParamByName('pSistema'       ).asString := Sistema;
          ParamByName('pNome'          ).asString := Nome;
          ParamByName('pCaption'       ).asString := Caption;
          ParamByName('pIndiceMenu'    ).asString := Indice;
          ParamByName('pCheckSumMenu'  ).asString := Encripta( edUsuario.Text +
                                                               Sistema +
                                                               Indice  +
                                                               Nome    +
                                                               RemoveCaractersDiferentedeAlfa(Caption) , 10 );
          ExecSQL;
        end;
      end;
    end
    else
    begin
      { Verifica se o Indice foi alterado }
      Close;
      Sql.Clear;
      Sql.Add('Select * From Ctr_MenusDoSistema ');
      Sql.Add('Where Sistema = :pSistema And '   );
      Sql.Add('      Nome    = :pNome '          );
      ParamByName('pSistema'   ).asString := Sistema;
      ParamByName('pNome'      ).asString := Nome;
      Open;
      { Caso tenha sido alterado o indice, cria o item e altera nas tabelas
        Ctr_MenusAoUsuario e Ctr_MenusAoGrupo e depois apaga. }
      If ( Not IsEmpty ) And ( FieldByName('IndiceMenu').asString <> Indice ) Then
      begin                                                    
        { Armazena o indice anterior }
        vIndice := FieldByName('IndiceMenu').asString;
        { Cria um registro para o novo indice com o mesmo checkSum do anterior }
        With qrAux1 Do
        begin
          Close;
          Sql.Clear;
          Sql.Add('Insert Into Ctr_MenusDoSistema ');
          Sql.Add('(Sistema, IndiceMenu, Nome, Caption, MenuValido, CheckSumMenu)');
          Sql.Add('Values (:pSistema, :pIndiceMenu, :pNome, :pCaption, ''S'', :pCheckSumMenu)');
          ParamByName('pSistema'   ).asString := Sistema;
          ParamByName('pIndiceMenu').asString := Indice;
          ParamByName('pNome'      ).asString := Nome;
          ParamByName('pCaption'   ).asString := Caption;
          ParamByName('pCheckSumMenu'  ).asString := qrAux.FieldByName('CheckSumMenu'  ).asString;//Encripta( Sistema + Caption + Nome + vTagSN, 10 );
          ExecSQL;
        end;
  //////////////{ Monta o comando Sql para fazer um update na tabela Ctr_MenusAoUsuario }
          Close;
          Sql.Clear;
          Sql.Add('Update Ctr_MenusAoUsuario '              );
          Sql.Add('Set Caption      = :pCaption, '          );
          Sql.Add('    IndiceMenu   = :pIndiceMenu, '       );
          Sql.Add('    CheckSumMenu = :pCheckSumMenu '      );
          Sql.Add('Where Usuario    = :pUsuario        And ');
          Sql.Add('      Sistema    = :pSistema        And ');
          Sql.Add('      IndiceMenu = :pIndiceAnterior And ');
          Sql.Add('      Nome       = :pNome '              );
          { Faz um loop na tabela Ctr_MenusAoUsuario para o Sistema Indice anterior e Nome }
          qrAux1.Close;
          qrAux1.Sql.Clear;
          qrAux1.Sql.Add('Select * From Ctr_MenusAoUsuario '   );
          qrAux1.Sql.Add('Where Sistema    = :pSistema    And ');
          qrAux1.Sql.Add('      IndiceMenu = :pIndiceMenu And ');
          qrAux1.Sql.Add('      Nome       = :pNome'           );
          qrAux1.ParamByName('pSistema'   ).asString := Sistema;
          qrAux1.ParamByName('pIndiceMenu').asString := vIndice;
          qrAux1.ParamByName('pNome'      ).asString := Nome;
          qrAux1.Open;
          While Not qrAux1.Eof Do
          begin
            ParamByName('pUsuario'       ).asString := qrAux1.FieldByName('USUARIO').asString;
            ParamByName('pSistema'       ).asString := Sistema;
            ParamByName('pIndiceAnterior').asString := vIndice;
            ParamByName('pNome'          ).asString := Nome;
            ParamByName('pCaption'       ).asString := Caption;
            ParamByName('pIndiceMenu'    ).asString := Indice;
            ParamByName('pCheckSumMenu'  ).asString := Encripta( qrAux1.FieldByName('USUARIO').asString +
                                                                 Sistema +
                                                                 Indice  +
                                                                 Nome    +
                                                                 RemoveCaractersDiferentedeAlfa(Caption) , 10 );
            ExecSQL;
            qrAux1.Next;
          end; // While Not Eof
  //////////////{ Monta o comando Sql para fazer um update na tabela Ctr_MenusAoGrupo }
          Close;
          Sql.Clear;
          Sql.Add('Update Ctr_MenusAoGrupo'                   );
          Sql.Add('Set Caption         = :pCaption, '         );
          Sql.Add('    IndiceMenu      = :pIndiceMenu, '      );
          Sql.Add('    CheckSumGrpMenu = :pCheckSumGrpMenu '  );
          Sql.Add('Where CodigoGrpUsu = :pCodigoGrpUsu   And ');
          Sql.Add('      Sistema      = :pSistema        And ');
          Sql.Add('      IndiceMenu   = :pIndiceAnterior And ');
          Sql.Add('      Nome         = :pNome '              );
          { Faz um loop na tabela Ctr_MenusAoGrupo para o Sistema Indice anterior e Nome }
          qrAux1.Close;
          qrAux1.Sql.Clear;
          qrAux1.Sql.Add('Select * From Ctr_MenusAoGrupo '     );
          qrAux1.Sql.Add('Where Sistema    = :pSistema    And ');
          qrAux1.Sql.Add('      IndiceMenu = :pIndiceMenu And ');
          qrAux1.Sql.Add('      Nome       = :pNome'           );
          qrAux1.ParamByName('pSistema'   ).asString := Sistema;
          qrAux1.ParamByName('pIndiceMenu').asString := vIndice;
          qrAux1.ParamByName('pNome'      ).asString := Nome;
          qrAux1.Open;
          While Not qrAux1.Eof Do
          begin
            ParamByName('pCodigoGrpUsu'   ).asString := qrAux1.FieldByName('CodigoGrpUsu').asString;
            ParamByName('pSistema'        ).asString := Sistema;
            ParamByName('pIndiceAnterior' ).asString := vIndice;
            ParamByName('pNome'           ).asString := Nome;
            ParamByName('pCaption'        ).asString := Caption;
            ParamByName('pIndiceMenu'     ).asString := Indice;
            ParamByName('pCheckSumGrpMenu').asString := Encripta( qrAux1.FieldByName('CodigoGrpUsu').asString +
                                                                  Sistema +
                                                                  Indice  +
                                                                  Nome    +
                                                                  RemoveCaractersDiferentedeAlfa(Caption) , 10 );
            ExecSQL;
            qrAux1.Next;
          end; // While Not Eof
  //////////////{ Exclui o indice anterior da tabela Ctr_MenusDoSistema }
          Close;
          Sql.Clear;
          Sql.Add('Delete From Ctr_MenusDoSistema '          );
          Sql.Add('Where Sistema    = :pSistema    And ');
          Sql.Add('      IndiceMenu = :pIndiceMenu And ');
          Sql.Add('      Nome       = :pNome '          );
          ParamByName('pSistema'   ).asString := Sistema;
          ParamByName('pIndiceMenu').asString := vIndice;
          ParamByName('pNome'      ).asString := Nome;
          ExecSQL;
      end // Begin
      else // ( Not IsEmpty ) And ( FieldByName('IndiceMenu').asString <> Indice )
        { Não existe o registro, cria um novo }
        If IsEmpty Then
        begin
          If (vCodCliente <> 0121) or (BuscaMenusLimitados(Sistema,Nome)) then // tribunal de Justica SAndre
          Begin
            Close;
            Sql.Clear;
            Sql.Add('Insert Into Ctr_MenusDoSistema (Sistema,IndiceMenu,Nome,Caption,MenuValido,CheckSumMenu) ');
            Sql.Add('Values (:pSistema,:pIndiceMenu,:pNome,:pCaption,''S'',:pCheckSumMenu)');
            ParamByName('pSistema'   ).asString := Sistema;
            ParamByName('pIndiceMenu').asString := Indice;
            ParamByName('pNome'      ).asString := Nome;
            ParamByName('pCaption'   ).asString := Caption;
            vTagSN := IIf(pTag = 1,'N','I');
            ParamByName('pCheckSumMenu'  ).asString := Encripta( Sistema + Caption + Nome + vTagSN,10);
            ExecSQL;
          end;
        end;
    end; // If Not Empty
  end; // With qrAux Do
end; // Procedure

procedure TContSenhaBgm.OnChangeUsuario(Sender: TObject);
begin
  If Trim(EdUsuario.Text) = '' then
  begin
    DesabilitaMenus;
    StatusBar.Panels[2].Text := '';
    LbNomeUsuario.Caption := '';
    EdSenha.Clear;
  end;
end;

procedure TContSenhaBgm.LimpaUsuario;
begin
  EdUsuario.Clear;
end;

procedure TContSenhaBgm.DesabilitaNivelSeNaoTiverNivelInferior;
var I, j, k : Integer;
    vBreakNivel2: boolean;
begin
  vBreakNivel2 := True;
  vContNivel2  := 0;

  For i := 0 To Menu.Items.Count -1 Do { menu principal - cadastros }
  begin
    vContNivel1  := 0;
    For j := 0 To Menu.Items[i].Count -1 Do { Primeiro submenus }
    begin
      For k := 0 To Menu.Items[i].Items[j].Count -1 Do { segundo submenus }
      begin
        vBreakNivel2 := False;
        If Menu.Items[i].Items[j].Items[k].Visible then
        begin
          Inc(vContNivel2);
          vBreakNivel2 := True;
          break;
        end;
      end; // For k := 0 To Menu.Items[i].Items[j].Count -1 Do { segundo submenus }

      If (not vBreakNivel2) then
      begin
        Menu.Items[i].Items[j].Visible := False;
        vBreakNivel2 := True;
      end;
      If (Menu.Items[i].Items[j].Visible) and (Menu.Items[i].Items[j].Caption <> '-') then
        inc(vContNivel1);

      If (Menu.Items[i].Items[j].Count = 0) and (not Menu.Items[i].Items[j].Visible) then
      begin
        Menu.Items[i].Items[j].Visible := False;
        //If vContNivel1 > 0 then Dec(vContNivel1);
      end;
    end; // For j := 0 To Menu.Items[i].Count -1 Do { Primeiro submenus }
    If (vContNivel1 = 0) and (UpperCase(Menu.Items[i].Name) <> 'SAIDA') then
      Menu.Items[i].Visible := False;
    vContNivel2  := 0;
  end; // For i := 0 To Menu.Items.Count -1 Do { menu principal - cadastros }

  { Desabilita - divisão quando não encontrar item acima ou abaixo }
  For i := 0 To Menu.Items.Count -1 Do { menu principal - cadastros }
  begin
    If Menu.Items[i].Caption = '-' then
    begin
      If (not Menu.Items[i-1].Visible) or
         (not Menu.Items[i+1].Visible) then
        Menu.Items[i].Visible := False;
    end;
    For j := 0 To Menu.Items[i].Count -1 Do { Primeiro submenus }
    begin
      If Menu.Items[i].Items[j].Caption = '-' then
      begin
        If (not Menu.Items[i].Items[j-1].Visible) or
           (not Menu.Items[i].Items[j+1].Visible) then
          Menu.Items[i].Items[j].Visible := False;
      end;
      For k := 0 To Menu.Items[i].Items[j].Count -1 Do { segundo submenus }
      begin
        If Menu.Items[i].Items[j].Items[k].Caption = '-' then
        begin
          If (not Menu.Items[i].Items[j].Items[k-1].Visible) or
             (not Menu.Items[i].Items[j].Items[k+1].Visible) then
            Menu.Items[i].Items[j].Items[k].Visible := False;
        end;
      end; // For k := 0 To Menu.Items[i].Items[j].Count -1 Do { segundo submenus }
    end; // For j := 0 To Menu.Items[i].Count -1 Do { Primeiro submenus }
  end; // For i := 0 To Menu.Items.Count -1 Do { menu principal - cadastros }
end;

procedure TContSenhaBgm.LimitaMenus;
Begin
// Criado em 01/12/2003 para o Forum de Sto Andre acessar apenas esse itens de
// Menu da Frequencia.

  vIndiceMenu[001] := 'Cadastros1';                    // Cadastros
  vIndiceMenu[002] := 'Frequncia1';                    // Freqüência
  vIndiceMenu[003] := 'Ocorrncias1';                   // Ocorrências
  vIndiceMenu[004] := 'N4';                            // -
  vIndiceMenu[005] := 'OcorrenciaInterna1';            // Ocorrência Interna
  vIndiceMenu[006] := 'ValoresAdicionais1';            // Valores Adicionais
  vIndiceMenu[007] := 'FolgaCompensada1';              // Folga Compensada (D.C.)
  vIndiceMenu[008] := 'TransferenciadeFaltas1';        // Transferência de Faltas
  vIndiceMenu[009] := 'HorasaCompensar1';              // Horas a Compensar
  vIndiceMenu[010] := 'FrmulasdeClculo1';              // Fórmulas de Cálculos
  vIndiceMenu[011] := 'N6';                            // -
  vIndiceMenu[012] := 'CID1';                          // CID
  vIndiceMenu[013] := 'OrigemdasOcorrncias1';          // Origem das Ocorrências
  vIndiceMenu[014] := 'GrupodeOcorrncias1';            // Grupo de Ocorrências
  vIndiceMenu[015] := 'CdigosdePunio1';                // Códigos de Punição
  vIndiceMenu[016] := 'N20';                           // -
  vIndiceMenu[017] := 'Horrios1';                      // Horários
  vIndiceMenu[018] := 'Escala1';                       // Escala
  vIndiceMenu[019] := 'Escalaeventual1';               // Escala eventual
  vIndiceMenu[020] := 'Funcionarios1';                 // Funcionarios
  vIndiceMenu[021] := 'N3';                            // -
  vIndiceMenu[022] := 'Parmetros1';                    // Parâmetros
  vIndiceMenu[023] := 'Cadastro1';                     // Cadastro
  vIndiceMenu[024] := 'AgrupParmetros1';               // Agrupamento
  vIndiceMenu[025] := 'N24';                           // -
  vIndiceMenu[026] := 'EmpresaFilial1';                // Empresa/Filial
  vIndiceMenu[027] := 'N27';                           // -
  vIndiceMenu[028] := 'RestriodeUsurios1';             // Restrição de Usuários
  vIndiceMenu[029] := 'N28';                           // -
  vIndiceMenu[030] := 'Tabelaprogressiva1';            // Tabela progressiva
  vIndiceMenu[031] := 'Feriados1';                     // Feriados
  vIndiceMenu[032] := 'Feriados2';                     // Feriados
  vIndiceMenu[033] := 'FeriadosEmpresaFilial1';        // Feriados Empresa/Filial
  vIndiceMenu[034] := 'ManutenodoCheklist1';           // Manutenção do CheckList
  vIndiceMenu[035] := 'N30';                           // -
  vIndiceMenu[036] := 'Agenda1';                       // Agenda
  vIndiceMenu[037] := 'FolhaRH1';                      // Folha / RH
  vIndiceMenu[038] := 'Cadastrodeeventos1';            // Cadastro de eventos
  vIndiceMenu[039] := 'Cadastromovitodedesligamento1'; // Cadastro motivo de desligamento
  vIndiceMenu[040] := 'Cadastrodequitao1';             // Cadastro de quitação
  vIndiceMenu[041] := 'Cadastrodefrias1';              // Cadastro de férias
  vIndiceMenu[042] := 'Fichadeconduta1';               // Ficha de conduta
  vIndiceMenu[043] := 'Listagemdafichadeconduta1';     // Listagem da ficha de conduta
  vIndiceMenu[044] := 'Movimentao1';                   // Movimentação
  vIndiceMenu[045] := 'Digitaodiria1';                 // Digitação diária
  vIndiceMenu[046] := 'N7';                            // -
  vIndiceMenu[047] := 'DigitaoporPerodo1';             // Digitação por Período
  vIndiceMenu[048] := 'MovimentaoColetiva1';           // Movimentação Coletiva
  vIndiceMenu[049] := 'N2';                            // -
  vIndiceMenu[050] := 'Fechamentodadigitao1';          // Fechamento da digitação
  vIndiceMenu[051] := 'FechamentoSemanal1';            // Fechamento Semanal
  vIndiceMenu[052] := 'FechamentoSemanalGeral1';       // Fechamento Semanal (Geral)
  vIndiceMenu[053] := 'AlteraodeOcorrncias2';          // Troca de Ocorrências
  vIndiceMenu[054] := 'N12';                           // -
  vIndiceMenu[055] := 'Acumulado1';                    // Acumulado
  vIndiceMenu[056] := 'FechamentoJudicirios1';         // Fechamento Servidores Judiciários
  vIndiceMenu[057] := 'N26';                           // -
  vIndiceMenu[058] := 'TicketeCestaBsica1';            // Vale Refeição e Cesta Básica
  vIndiceMenu[059] := 'DireitosaValeReiefeio1';        // Direitos a Vale Refeição
  vIndiceMenu[060] := 'N8';                            // -
  vIndiceMenu[061] := 'GeravariveisparaaFOLHA1';       // Gera variáveis para a FOLHA (Texto)
  vIndiceMenu[062] := 'Listagem';                      // Listagem
  vIndiceMenu[063] := 'ListagemDiaria1';               // Listagem Diaria
  vIndiceMenu[064] := 'ListagemMovimentos2';           // Listagem Movimentos
  vIndiceMenu[065] := 'ListagemMovimentos1';           // Listagem Movimentos (Acumulado)
  vIndiceMenu[066] := 'ListagemFolgaCompensada1';      // Listagem Folga Compensada
  vIndiceMenu[067] := 'N10';                           // -
  vIndiceMenu[068] := 'AnlisePorOcorrncia1';           // Análise por Ocorrência
  vIndiceMenu[069] := 'AnliseporJornada1';             // Análise por Jornada
  vIndiceMenu[070] := 'N22';                           // Duplicidade de informações
  vIndiceMenu[071] := 'N9';                            // -
  vIndiceMenu[072] := 'MapadeMovimentos1';             // Mapa de Movimentos
  vIndiceMenu[073] := 'MapadeMovimentosII1';           // Mapa de Movimentos II
  vIndiceMenu[074] := 'MapaSemanal1';                  // Mapa Semanal
  vIndiceMenu[075] := 'MapadeHorasExtras1';            // Mapa de Horas Extras
  vIndiceMenu[076] := 'N17';                           // -
  vIndiceMenu[077] := 'CID2';                          // CID
  vIndiceMenu[078] := 'OrigemdasOcorrncias2';          // Origem das Ocorrências
  vIndiceMenu[079] := 'ValoresAdicionais';             // Valores Adicionais
  vIndiceMenu[080] := 'N18';                           // -
  vIndiceMenu[081] := 'ListagemGenerica1';             // Listagem Genérica
  vIndiceMenu[082] := 'Construtor1';                   // Construtor
  vIndiceMenu[083] := 'Impresso1';                     // Impressão
  vIndiceMenu[084] := 'Importar1';                     // Importar
  vIndiceMenu[085] := 'Exportar1';                     // Exportar
  vIndiceMenu[086] := 'ProcedimentosAuxiliares1';      // Procedimentos Auxiliares
  vIndiceMenu[087] := 'ImportaRelgiodePonto1';         // Importa Relógio de Ponto
  vIndiceMenu[088] := 'ExportaDigitaoDiaria1';         // Exporta Digitação Diária
  vIndiceMenu[089] := 'N14';                           // -
  vIndiceMenu[090] := 'RecalculaPerododeFrias1';       // Recalcula Período de Férias
  vIndiceMenu[091] := 'ReCalcTodosRegsdoAcumdeDigit1'; // Recalcula Movimentação
  vIndiceMenu[092] := 'Trocasenhadousurio1';           // Troca senha do usuário
  vIndiceMenu[093] := 'Saida';                         // Saida
  vIndiceMenu[094] := 'Ajuda1';                        // Ajuda
  vIndiceMenu[095] := 'AjudaDoModulo';                 // Ajuda do módulo
  vIndiceMenu[096] := 'N1';                            // -
  vIndiceMenu[097] := 'AjudaSobreSistema';             // Sobre o Sistema
  vIndiceMenu[098] := 'Condio1';
  vIndiceMenu[099] := 'Bancos1';
  vIndiceMenu[100] := 'Agncias1';
  vIndiceMenu[101] := 'Funcao1';
  vIndiceMenu[102] := 'Sindiocatos1';
  vIndiceMenu[103] := 'rea1';
  vIndiceMenu[104] := 'Departamento1';
  vIndiceMenu[105] := 'Setor1';
  vIndiceMenu[106] := 'Seo1';
  vIndiceMenu[107] := 'UF1';
  vIndiceMenu[108] := 'RegioGoegrfica1';
  vIndiceMenu[109] := 'Historico';
end;

Function TContSenhaBgm.BuscaMenusLimitados(vsistema,Vcod:String): Boolean;
Var i:Integer;
Begin
  If vsistema <> 'FRQ' then
  Begin
    Result := false;
    exit;
  end;

  Result := False;

  For i:=1 to 109 do
  Begin
    If vIndiceMenu[i] = Vcod then
      Begin
        Result:=True;
        Break;
      end;
  end;
end;

function TContSenhaBgm.BuscaShortCuts(vIndice: String): String;
Var
  vPos: Integer;
begin
  Result := '';
  If vShortCuts <> '' Then
  begin
    vPos := Pos(vIndice + '|',vShortCuts);
    If vPos > 0 Then
    begin
      Result := Copy(vShortCuts,vPos + 10,Length(vShortCuts) - (vPos + 11));
      Result := Trim(Copy(Result,1,Pos(',',Result)-1));
    end;
  end;
end;

procedure TContSenhaBgm.GravaShortCuts(vIndice, vShortCut: String);
begin
  vShortCuts := vShortCuts + vIndice + '|' + vShortCut + ',';
end;

procedure TContSenhaBgm.FIMenuTeclasClick(Sender: TObject);
begin
  FFrmTelaTeclas := TForm.Create(Nil) ;
  Try
    With FFrmTelaTeclas Do
    Begin
      Name        := 'FFrmTelaTeclas' ;
      Caption     := vcSistema + ' - ' + 'Cadastro de atalhos' ;      
      Width       := 650 ;
      Height      := 300 ;
      BorderIcons := [biSystemMenu] ;
      BorderStyle := bsSingle ;
      KeyPreview  := True ;
      Position    := poScreenCenter ;
      OnClose     := FFrmTelaTeclasFormClose ;
      OnKeyPress  := FFrmTelaTeclasFormKeyPress ;
      OnShow      := FFrmTelaTeclasFormShow ;
      ShowModal ;
    End ; // With FFrmTelaTeclas Do
  Finally
    FFrmTelaTeclas.Release ;
    FFrmTelaTeclas := Nil ;
  End ; // Try - Finally
end;

procedure TContSenhaBgm.FFrmTelaTeclasFormClose(Sender: TObject; var Action: TCloseAction);
begin
  FEdtTecla.Free ;
  FQryPesquisa.Free ;
  FTViewMenuTeclas.Free ;
  FEdtTecla        := Nil ;
  FQryPesquisa     := Nil ;
  FTViewMenuTeclas := Nil ;
end;

procedure TContSenhaBgm.FFrmTelaTeclasFormKeyPress(Sender: TObject; var Key: Char);
begin
  vAbandonaExit := False ;
  vEsc          := False ;
  If key = #13 Then // ENTER
  Begin
    Key := #0 ;
    FFrmTelaTeclas.Perform(WM_NextDlgCtl,0,0) ;
  End ; // If key = #13 Then

  If vPassaFoco And (Key = #27) Then // ESC
  Begin
    Key  := #0 ;
    vEsc := True ;
    FFrmTelaTeclas.Perform(WM_NextDlgCtl,1,0) ;
  End ; // If vPassaFoco And (...
end;

procedure TContSenhaBgm.FFrmTelaTeclasFormShow(Sender: TObject);
Var
  FMainMenu         : TMainMenu ;
  FSaida            : TMenuItem ;
  FPanelTitulo,
  FPanelMenus,
  FPanelTeclas      : TPanel ;
  FLabelTecla       : TLabel ;
  FDSMenuTeclas     : TDataSource ;
  FSButExpande,
  FSButCompacta,
  FSButCopiar,
  FSButLimpar       : TSpeedButton ;
  Nivel0,
  Nivel1            : TTreeNode ;
  FEdtFoco          : TEdit ;
  vCaption          : String ;
begin
  FMainMenu := TMainMenu.Create(FFrmTelaTeclas) ;

  FSaida         := TMenuItem.Create(FMainMenu) ;
  FSaida.Name    := 'FSaida' ;
  FSaida.Caption := '&Saída' ;
  FMainMenu.Items.Insert(0,FSaida) ;
  FMainMenu.Items[0].OnClick := FMainMenuSaidaClick ;

  FQryPesquisa := TQuery.Create(FFrmTelaTeclas) ;
  FQryPesquisa.DatabaseName := 'dbBgm' ;

  FDSMenuTeclas := TDataSource.Create(FFrmTelaTeclas) ;
  FDSMenuTeclas.DataSet := vMDTeclas ;

  FPanelMenus := TPanel.Create(FFrmTelaTeclas) ;
  With FPanelMenus Do
  Begin
    Name       := 'FPanelMenus' ;
    Parent     := FFrmTelaTeclas ;
    Align      := alClient ;
    BevelInner := bvLowered ;

    FPanelTitulo  := TPanel.Create(FFrmTelaTeclas) ;
    With FPanelTitulo do
    Begin
      Name       := 'FPanelTitulo'  ;
      Parent     := FPanelMenus ;
      Height     := 21 ;
      Align      := alTop ;
      BevelOuter := bvNone ;
      Alignment  := taLeftJustify ;
      Caption    := '  Menu(s) do sistema' ;

      FSButExpande := TSpeedButton.Create(FFrmTelaTeclas) ;
      With FSButExpande do
      Begin
        Name      := 'FSButExpande' ;
        Parent    := FPanelTitulo ;
        Caption   := '' ;
        Top       := 2 ;
        Width     := 18 ;
        Height    := 18 ;
        Hint      := 'Expande...' ;
        ShowHint  := True ;
        NumGlyphs := 2 ;
        Try
          Glyph.LoadFromResourceName(HInstance,'ZOOMIN') ;
        Except
        End ; // Try - Except
        OnClick := FSButExpandeClick ;
      End ; // With FSButExpande do

      FSButCompacta := TSpeedButton.Create(FFrmTelaTeclas) ;
      With FSButCompacta do
      Begin
        Name      := 'FSButCompacta' ;
        Parent    := FPanelTitulo ;
        Caption   := '' ;
        Top       := 2 ;
        Width     := 18 ;
        Height    := 18 ;
        Hint      := 'Compacta...' ;
        ShowHint  := True ;
        NumGlyphs := 2 ;
        Try
          Glyph.LoadFromResourceName(HInstance,'ZOOMOUT') ;
        Except
        End ; // Try - Except
        OnClick   := FSButExpandeClick ;
      End ; // With FSButCompacta do
    End ; // With FPanelTitulo do

    FTViewMenuTeclas := TTreeView.Create(FFrmTelaTeclas) ;
    With FTViewMenuTeclas do
    Begin
      Name          := 'FTViewMenuTeclas' ;
      Parent        := FPanelMenus ;
      Align         := alClient ;
      Font.Charset  := ANSI_CHARSET ;
      Font.Name     := 'Courier New' ;
      Font.Style    := [fsBold] ;
      Font.Size     := 9 ;
      ReadOnly      := True ;
      HideSelection := False ;
      OnChange      := FTViewMenuTeclasChange ;
      OnExit        := FTViewMenuTeclasExit ;
    End ; // With FTViewMenuTeclas do
  End ; // With FPanelMenus Do

  FPanelTeclas := TPanel.Create(FFrmTelaTeclas) ;
  With FPanelTeclas Do
  Begin
    Name       := 'FPanelTeclas' ;
    Parent     := FFrmTelaTeclas ;
    Width      := 60 ;
    Align      := alRight ;
    BevelInner := bvLowered ;
    Caption    := '' ;

    FLabelTecla := TLabel.Create(FFrmTelaTeclas) ;
    With FLabelTecla Do
    Begin
      Name       := 'FLabelTecla' ;
      Parent     := FPanelTeclas ;
      Left       := 6 ;
      Caption    := 'Teclas' ;
      Font.Style := [fsBold] ;
    End ; // With FLabelTecla Do

    FEdtTecla := TEdit.Create(FFrmTelaTeclas) ;
    With FEdtTecla Do
    Begin
      Name       := 'FEdtTecla' ;
      Parent     := FPanelTeclas ;
      Left       := 6 ;
      Width      := 48 ;
      MaxLength  := 7 ;
      Text       := '' ;
      OnExit     := FEdtTeclaExit ;
      OnKeyPress := FEdtTeclaKeyPress ;
      OnKeyUp    := FEdtTeclaKeyUp;
    End ; // With FEdtTecla Do

    FEdtFoco := TEdit.Create(FFrmTelaTeclas) ;
    With FEdtFoco Do
    Begin
      Name   := 'FEdtFoco' ;
      Parent := FPanelTeclas ;
      Top    := FEdtTecla.Top ;
      Left   := FEdtTecla.Top ;
      Width  := 1 ;
      Text   := '' ;
    End ; // With FEdtFoco Do

    FSButCopiar := TSpeedButton.Create(FFrmTelaTeclas) ;
    With FSButCopiar Do
    Begin
      Name      := 'FSButCopiar' ;
      Parent    := FPanelTeclas ;
      Left      := FEdtTecla.Left ;
      Width     := 25 ;
      Height    := 22 ;
      Hint      := 'Copia todos os atalhos cadastrados pelo administrador.' ;
      ShowHint  := True ;
      Enabled   := vMDTeclas.FindField('USUARIO') <> Nil ;
      NumGlyphs := 2 ;
      Try
        Glyph.LoadFromResourceName(HInstance,'COPY') ;
      Except
      End ; // Try - Except
      OnClick  := FSButCopiarClick ;
    End ; // With FSButCopiar Do

    FSButLimpar := TSpeedButton.Create(FFrmTelaTeclas) ;
    With FSButLimpar Do
    Begin
      Name      := 'FSButLimpar' ;
      Parent    := FPanelTeclas ;
      Left      := FSButCopiar.Left + 1 + FSButCopiar.Width ;
      Width     := 25 ;
      Height    := 22 ;
      Hint      := 'Limpa todos os atalhos cadastrados.' ;
      ShowHint  := True ;
      NumGlyphs := 2 ;
      Try
        Glyph.LoadFromResourceName(HInstance,'TRASH') ;
      Except
      End ; // Try - Except
      OnClick  := FSButCopiarClick ;
    End ; // With FSButLimpar Do
  End ; // With FPanelTeclas Do

  FSButExpande.Left  := FPanelTitulo.Width  - FSButExpande.Width - 3 -FSButCompacta.Width ;
  FSButCompacta.Left := FSButExpande.Left   + 1 + FSButExpande.Width ;

  FLabelTecla.Top    := FPanelTeclas.Height - FLabelTecla.Height - 5 - FEdtTecla.Height - 3 - FSButCopiar.Height - 3 ;
  FEdtTecla.Top      := FLabelTecla.Top     + 3 + FLabelTecla.Height ;

  FSButCopiar.Top    := FEdtTecla.Top       + 3 + FEdtTecla.Height ;
  FSButLimpar.Top    := FSButCopiar.Top ;

  Nivel0 := Nil ;
  Nivel1 := Nil ;
  With vMDTeclas do
  Begin
    SortOnFields('INDICEMENU') ;
    DisableControls ;
    First ;
    While Not Eof do
    Begin
      If (Pos(UpperCase(FieldByName('CAPTION').AsString),'-'
                                                        +'SOBRE O SISTEMA')   > 0) Or
         (Pos(UpperCase(FieldByName('NOME'   ).AsString),'SAIDA'
                                                        +'AJUDA1'
                                                        +'AJUDADOMODULO'
                                                        +'AJUDASOBRESISTEMA') > 0) Then
      Begin
        Next ;
        Continue ;
      End ; // If (Pos(UpperCase(FieldByName('CAPTION').AsString),...

      vCaption := Pad(FieldByName('CAPTION').AsString,62 + IIf(Length(FieldByName('INDICEMENU').AsString) = 2,6,
                                                           IIf(Length(FieldByName('INDICEMENU').AsString) = 4,3,0)) ) + 
                  Pad(FieldByName('TECLAS' ).AsString,7) ;

      If Length(FieldByName('INDICEMENU').AsString) = 2 Then
        Nivel0 := FTViewMenuTeclas.Items.Add(Nil,vCaption)
      Else
      If Length(FieldByName('INDICEMENU').AsString) = 4 Then
        Nivel1 := FTViewMenuTeclas.Items.AddChild(Nivel0,vCaption)
      Else
        FTViewMenuTeclas.Items.AddChild(Nivel1,vCaption) ;

      Edit ;
      FieldByName('ABSOLUTEINDEX').AsInteger := FTViewMenuTeclas.Items[FTViewMenuTeclas.Items.Count-1].AbsoluteIndex ;
      Post ;
      Next ;
    End ; // While Not Eof do

    First ;
    EnableControls ;
  End ; // With vMDTeclas do

  FTViewMenuTeclas.SetFocus ;
end;

procedure TContSenhaBgm.FMainMenuSaidaClick(Sender: TObject);
Var
  vGravar : Boolean ;
begin
  FFrmTelaTeclas.Close ;

  vMDTeclas.SortOnFields('GRAVATECLAS') ;
  vMDTeclas.First ;
  If vMDTeclas.Locate('GRAVATECLAS','S',[LocaseInsensitive]) Then
    vGravar := MensagemDlg('Confirma a gravação dos atalhos cadastrados',mtConfirmacao,mbSim+mbNao) = mbSim
  Else
    Exit ;

  If vGravar Then
  Begin
    If dm.DbBGM.InTransaction Then dm.DbBGM.Rollback ;
    dm.DbBGM.StartTransaction ;

    With FQryPesquisa Do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add(' UPDATE CTR_MENUS' + IIf(vMDTeclas.FindField('USUARIO') <> Nil,'AOUSUARIO','DOSISTEMA') + ' SET'+
              ' TECLAS = :P_TECLAS') ;
      Sql.Add(' WHERE'+
              '     SISTEMA    = :P_SISTEMA'+
              ' AND INDICEMENU = :P_INDICEMENU'+
              ' AND NOME       = :P_NOME') ;
      If vMDTeclas.FindField('USUARIO') <> Nil Then
      Begin
        Sql.Add(' AND USUARIO = :P_USUARIO') ;
        ParamByName('P_USUARIO' ).AsString := vMDTeclas.FieldByName('USUARIO').AsString ;
      End ; // If FindField('USUARIO') <> Nil Then
      ParamByName('P_SISTEMA'   ).AsString := Sistema ;
    End ; // With FQryPesquisa Do
  End ; // If vGravar Then

  While (Not vMDTeclas.Eof) And
        (vMDTeclas.FieldByName('GRAVATECLAS').AsString = 'S') do
  Begin
    If vGravar Then
    Begin
      FQryPesquisa.ParamByName('P_INDICEMENU').AsString := vMDTeclas.FieldByName('INDICEMENU').AsString ;
      FQryPesquisa.ParamByName('P_NOME'      ).AsString := vMDTeclas.FieldByName('NOME'      ).AsString ;
      FQryPesquisa.ParamByName('P_TECLAS'    ).AsString := vMDTeclas.FieldByName('TECLAS'    ).AsString ;
      FQryPesquisa.ExecSql ;
    End ; // If vGravar Then

    vMDTeclas.Edit ;
    vMDTeclas.FieldByName('GRAVATECLAS').AsString := 'N' ;
    If Not vGravar Then
      vMDTeclas.FieldByName('TECLAS'   ).AsString := vMDTeclas.FieldByName('COPIATECLAS').AsString ;
    vMDTeclas.Post ;
    vMDTeclas.Next ;
  End ; // While (Not vMDTeclas.Eof) And (...

  If vGravar Then
    dm.DbBGM.Commit ;
end;

procedure TContSenhaBgm.FEdtTeclaExit(Sender: TObject);
begin
  If (vEsc) Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If (vEsc) Or (...

  If Trim(FEdtTecla.Text) <> '' Then
  Begin
    If (vMDTeclas.Locate('TECLAS',FEdtTecla.Text,[LocaseInsensitive])) And
       (vMDTeclas.FieldByName('ABSOLUTEINDEX').AsInteger <> FTViewMenuTeclas.Selected.AbsoluteIndex) Then
    Begin
      MensagemDlg('Teclas já cadastradas.',mtInformacao,mbOK) ;
      FEdtTecla.Clear ;
      FEdtTecla.SetFocus ;
      Exit ;
    End ; // If (vMDTeclas.Locate('TECLAS',FEdtTecla.Text ,[LocaseInsensitive])) And (...
  End ; // If Trim(FEdtTecla.Text) <> '' Then

  vMDTeclas.Edit ;
  vMDTeclas.FieldByName('TECLAS'     ).AsString := FEdtTecla.Text ;
  vMDTeclas.FieldByName('GRAVATECLAS').AsString := 'S' ;
  vMDTeclas.Post ;

  FTViewMenuTeclas.Items[FTViewMenuTeclas.Selected.AbsoluteIndex].Text := Pad(vMDTeclas.FieldByName('CAPTION').AsString,62 + IIf(Length(vMDTeclas.FieldByName('INDICEMENU').AsString) = 2,6,
                                                                                                                             IIf(Length(vMDTeclas.FieldByName('INDICEMENU').AsString) = 4,3,0)) ) + 
                                                                          Pad(vMDTeclas.FieldByName('TECLAS' ).AsString,7) ;
  FTViewMenuTeclas.Refresh ;
  FTViewMenuTeclas.SetFocus ;
end;

procedure TContSenhaBgm.FEdtTeclaKeyPress(Sender: TObject; var Key: Char);
begin
  If Not (Key In ['0'..'9','A'..'Z']) Then Key := #0 ;
end;

procedure TContSenhaBgm.FEdtTeclaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If ((Shift = [ssShift])  Or
      (Shift = [ssCtrl] )) And
      (Chr(Key) In ['0'..'9','A'..'Z',#8])  Then   // #8 = BackSpace
  Begin
    If Shift = [ssCtrl] Then
      FEdtTecla.Text := 'Ctrl+'  + Chr(Key)
    Else
      FEdtTecla.Text := 'Shift+' + Chr(Key) ;
  End Else // If ((Shift = [ssShift]) Or (...
  If (Key = 8) Or
     (Key = 46) Or
     (Pos(Copy(FEdtTecla.Text,1,Length(FEdtTecla.Text)-1),'Shift+Ctrl+') = 0) Then
    FEdtTecla.Clear ;
end;

procedure TContSenhaBgm.FTViewMenuTeclasChange(Sender: TObject; Node: TTreeNode);
begin
  If Trim(FEdtTecla.Name) <> '' Then
  Begin
    vMDTeclas.Locate('ABSOLUTEINDEX',IntToStr(Node.AbsoluteIndex),[LocaseInsensitive]) ;
    FEdtTecla.Text    := vMDTeclas.FieldByName('TECLAS').AsString ;
    FEdtTecla.Enabled := FTViewMenuTeclas.Items.Item[Node.AbsoluteIndex].Count = 0 ;
    FEdtTecla.Color   := IIf(FEdtTecla.Enabled,clWindow,clMenu) ;
  End ; // If Trim(FEdtTecla.Name) <> '' Then
end;

procedure TContSenhaBgm.FTViewMenuTeclasExit(Sender: TObject);
begin
  If (vEsc) Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) And (vTAB)) Or (Not FEdtTecla.Enabled) Then
  Begin
    vEsc := False ;
    FTViewMenuTeclas.SetFocus ;
  End ; // If (vEsc) Or (...
end;

procedure TContSenhaBgm.FSButExpandeClick(Sender: TObject);
begin
  With FTViewMenuTeclas Do
  Begin
    Items.BeginUpdate ;

    If TSpeedButton(Sender).Name = 'FSButExpande' Then
    Begin
      FullExpand ;
      Items.Item[Items.Count-1].Selected := True ;
    End Else // If TSpeedButton(Sender).Name = 'FSButExpande' Then
      FullCollapse ;
    Items.EndUpdate ;
    Items.Item[0].Selected := True ;
  End ; // With FTViewMenuTeclas Do
end;

procedure TContSenhaBgm.FSButCopiarClick(Sender: TObject);
Var
  i : Integer ;
  vTeclas,
  vCaption : String ;
begin
  vMDTeclas.DisableControls ;
  vMDTeclas.First ;

  If TSpeedButton(Sender).Name = 'FSButCopiar' Then
  Begin
    With FQryPesquisa do
    Begin
      Close ;
      Sql.Clear;
      Sql.Add(' SELECT'+
              '  INDICEMENU'+
              ' ,TECLAS'+
              '') ;
      Sql.Add(' FROM'+
              ' CTR_MENUSDOSISTEMA'+
              '') ;
      Sql.Add(' WHERE'+
              '     SISTEMA = :P_SISTEMA'+
              ' AND NOT TECLAS IS NULL'+
              '') ;
      Sql.Add(' ORDER BY'+
              '  SISTEMA'+
              ' ,INDICEMENU'+
              ' ,CAPTION'+
              '') ;
      ParamByName('P_SISTEMA').AsString := Sistema ;
      Open ;
      While Not Eof do
      Begin
        If vMDTeclas.Locate('INDICEMENU',FieldByName('INDICEMENU').AsString,[LocaseInsensitive]) Then
        Begin
          vMDTeclas.Edit ;
          vMDTeclas.FieldByName('COPIATECLAS').AsString := vMDTeclas.FieldByName('TECLAS').AsString ;
          vMDTeclas.FieldByName('TECLAS'     ).AsString := FieldByName('TECLAS').AsString ;
          vMDTeclas.FieldByName('GRAVATECLAS').AsString := 'S' ;
          vMDTeclas.Post ;
        End ; // If vMDTeclas.Locate(...
        Next ;
      End ; // While Not Eof do
    End ; // With FQryPesquisa do
  End Else // If TSpeedButton(Sender).Name = 'FSButCopiar' Then
  Begin
    While Not vMDTeclas.Eof Do
    Begin
      vMDTeclas.Edit ;
      vMDTeclas.FieldByName('GRAVATECLAS').AsString := IIf(Trim(vMDTeclas.FieldByName('TECLAS').AsString)='','N','S') ;
      vMDTeclas.FieldByName('COPIATECLAS').AsString := vMDTeclas.FieldByName('TECLAS').AsString ;
      vMDTeclas.FieldByName('TECLAS'     ).AsString := '' ;
      vMDTeclas.Post ;
      vMDTeclas.Next ;
    End ; // While Not vMDTeclas.Eof Do
  End ; // End Else // If TSpeedButton(Sender).Name = 'FSButCopiar' Then

  FTViewMenuTeclas.Items.BeginUpdate ;
  For i := 0 to FTViewMenuTeclas.Items.Count-1 do
  Begin
    vCaption := Pad(FTViewMenuTeclas.Items[i].Text,62) ;

    If TSpeedButton(Sender).Name = 'FSButCopiar' Then
    Begin
      vMDTeclas.Locate('ABSOLUTEINDEX',IntToStr(FTViewMenuTeclas.Items[i].AbsoluteIndex),[LocaseInsensitive]) ;
      vTeclas := vMDTeclas.FieldByName('TECLAS').AsString ;
    End Else // If TSpeedButton(Sender).Name = 'FSButCopiar' Then
      vTeclas := '' ;

    FTViewMenuTeclas.Items[i].Text := Pad(vCaption,62 + IIf(FTViewMenuTeclas.Items[i].Level = 0,6,
                                                        IIf(FTViewMenuTeclas.Items[i].Level = 1,3,0))) +
                                      Pad(vTeclas,7) ;
  End ; // For i := 0 to FTViewMenuTeclas.Items.Count-1 do

  FTViewMenuTeclas.FullCollapse ;
  FTViewMenuTeclas.Items.EndUpdate ;
  FTViewMenuTeclas.Items.Item[0].Selected := True ;

  vMDTeclas.EnableControls ;

  FTViewMenuTeclas.SetFocus ;
end;

end.

