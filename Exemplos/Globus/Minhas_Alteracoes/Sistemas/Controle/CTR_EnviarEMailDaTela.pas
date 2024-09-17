unit CTR_EnviarEMailDaTela;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Menus, ExtCtrls, StdCtrls, Buttons, Mask, ToolEdit, RxRichEd,
  IdMessage, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, DB, RxMemDS, jpeg, Confirma, OleCtnrs, SakMsg,
  SakSMTP, 
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_EnviarEMailDaTela = class(TForm)
    PnlAssunto: TPanel;
    PnlTela: TPanel;
    PnlBotoes: TPanel;
    LabAssunto: TLabel;
    EdtAssunto: TEdit;
    PnlTexto: TPanel;
    BBtnEnviar: TBitBtn;
    PopupMenuGeral: TPopupMenu;
    IMenuAlta: TMenuItem;
    IMenuNormal: TMenuItem;
    IMenuBaixa: TMenuItem;
    OpenDialogAnexar: TOpenDialog;
    IMenuMostraArqivos: TMenuItem;
    PnlArquivos: TPanel;
    ListBoxArquivos: TListBox;
    IMenuApagaArquivos: TMenuItem;
    MainMenu1: TMainMenu;
    Saida: TMenuItem;
    REdtTexto: TRxRichEdit;
    Panel1: TPanel;
    ImagePrioridadeA: TImage;
    ImagePrioridadeB: TImage;
    ImagePrioridadeN: TImage;
    PnlTelaImagem1: TPanel;
    PnlBotoesEmail: TPanel;
    SButPrioridades: TSpeedButton;
    SButAnexar: TSpeedButton;
    PnlTpEmail: TPanel;
    CBoxTipoEMail: TComboBox;
    Label1: TLabel;
    Panel2: TPanel;
    OleContainerImagem: TOleContainer;
    Memo1: TMemo;
    Splitter1: TSplitter;
    SakSMTP1: TSakSMTP;
    SakMsg1: TSakMsg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure SButPrioridadesClick(Sender: TObject);
    procedure PopupMenuGeralPopup(Sender: TObject);
    procedure SButAnexarClick(Sender: TObject);
    procedure IMenuAltaClick(Sender: TObject);
    procedure SaidaClick(Sender: TObject);
    procedure BBtnEnviarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxArquivosExit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure SakSMTP1Connect(Sender: TObject);
    procedure SakSMTP1SendProgress(Sender: TObject; Percent: Word);
  private
    { Private declarations }
  public
    { Public declarations }
    vNomeTela    : String ;
    vNomeForm    : String ;
    vNomeArquivo : String ;
  end;

var
  FrmCTR_EnviarEMailDaTela: TFrmCTR_EnviarEMailDaTela;

implementation

uses MenuPrincipal,
     BGM_String,
     BGM_Tela,
     BGM_Dados,
     CTR_CAD_Classes,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.DFM}

procedure TFrmCTR_EnviarEMailDaTela.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmCTR_EnviarEMailDaTela.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
  BBtnEnviar.Enabled         := (Trim(EdtAssunto.Text) <> '') And (Trim(CBoxTipoEMail.Text) <> '') ;
  OleContainerImagem.Enabled := BBtnEnviar.Enabled ;
end;

procedure TFrmCTR_EnviarEMailDaTela.FormShow(Sender: TObject);
var
  I: integer;
begin
  OleContainerImagem.CreateObjectFromFile(vNomeArquivo, False);
//  ObjectFileName := vNomeArquivo ;
  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt}
end;

procedure TFrmCTR_EnviarEMailDaTela.SButPrioridadesClick(Sender: TObject);
begin
  PopupMenuGeral.PopupComponent := SButPrioridades ;
  PopupMenuGeral.Popup(SButPrioridades.ClientOrigin.x+SButPrioridades.Width ,SButPrioridades.ClientOrigin.y+SButPrioridades.Height ) ;
end;

procedure TFrmCTR_EnviarEMailDaTela.PopupMenuGeralPopup(Sender: TObject);
begin
  IMenuAlta.Visible          := PopupMenuGeral.PopupComponent = SButPrioridades ;
  IMenuNormal.Visible        := IMenuAlta.Visible ;
  IMenuBaixa.Visible         := IMenuAlta.Visible ;
  IMenuMostraArqivos.Visible := (PopupMenuGeral.PopupComponent = SButAnexar) And (ListBoxArquivos.Items.Count > 0) ;
  IMenuApagaArquivos.Visible := IMenuMostraArqivos.Visible ;
end;

procedure TFrmCTR_EnviarEMailDaTela.SButAnexarClick(Sender: TObject);
begin
  If OpenDialogAnexar.Execute Then
    ListBoxArquivos.Items.Add(OpenDialogAnexar.FileName) ;
end;

procedure TFrmCTR_EnviarEMailDaTela.IMenuAltaClick(Sender: TObject);
begin
  If Not TMenuItem(Sender).Visible then
    Exit ;

  If PopupMenuGeral.PopupComponent = SButPrioridades Then
  Begin
    IMenuAlta.Checked     := Sender = IMenuAlta ;
    IMenuNormal.Checked   := Sender = IMenuNormal ;
    IMenuBaixa.Checked    := Sender = IMenuBaixa ;
    SButPrioridades.Glyph := TImage( FindComponent('ImagePrioridade' + Copy(TMenuItem(Sender).Name,6,1) ) ).Picture.Bitmap ;
  End Else // If PopupMenuGeral.PopupComponent = SButPrioridades Then
  If PopupMenuGeral.PopupComponent = SButAnexar Then
  Begin
    If Sender = IMenuMostraArqivos Then
    Begin
      PnlArquivos.Height  := 100 ;
      PnlArquivos.Top     := SButAnexar.Top  + SButAnexar.Height + 2 ;
      PnlArquivos.Width   := 364 ;
      PnlArquivos.Left    := (PnlBotoesEmail.Left + SButAnexar.Width) - PnlArquivos.Width ;

      PnlArquivos.Visible := True ;
      ListBoxArquivos.SetFocus ;
    End Else // If Sender = IMenuMostraArqivos Then
      ListBoxArquivos.Clear ;
  End ; // If PopupMenuGeral.PopupComponent = SButAnexar Then
end;

procedure TFrmCTR_EnviarEMailDaTela.SaidaClick(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCTR_EnviarEMailDaTela.BBtnEnviarClick(Sender: TObject);
Var
  vEnvio     : Boolean ;
  vAssunto,
  vDe,
  vPara,
  vCC        : String ;
  vUsuario   : TUsuario ;
  vArquivos  : Array of String ;
  Function EnviarEMail(pUsaContaUsu : Boolean = False ) : Boolean ;
  Var i,
      vQtdeArq     : Integer ;
      vServidor,
      vEMailOrigem,
      vSenha,
      vPorta       : String ;
      Imagem_BMP   : TBitmap ;
      Imagem_JPG   : TJPEGImage ;

  Begin
    Result        := True ;
    Imagem_BMP := TBitmap.Create ;
    Imagem_BMP.LoadFromFile(vNomeArquivo);

    OleContainerImagem.SaveToFile(vNomeArquivo) ;
    Imagem_JPG := TJPEGImage.Create ;
    Try
      Imagem_JPG.CompressionQuality := 100 ;
      Imagem_JPG.Assign(Imagem_BMP) ;
      Imagem_JPG.Compress ;
      Imagem_JPG.SaveToFile(vNomeArquivo);
    Except
    End ; // Try - Except
    Imagem_JPG.Free ;
    Imagem_BMP.Free ;

    vUsuario := TUsuario.Create ;
    vUsuario.Pesquisar(vcUsuario) ;

    vAssunto :=        vcSistema
               + '\' + vNomeTela
               + '\' + EdtAssunto.Text
               + '\' + CBoxTipoEMail.Text
               + '\' + StrZero(vcCodigoCliente,4) ;

    vDe      := vUsuario.Email ;
    vPara    := vUsuario.Email ;
    vCC      := vUsuario.Email ;

    vQtdeArq := ListBoxArquivos.Items.Count ;
    SetLength( vArquivos, vQtdeArq+1 );

    vArquivos[0] := vNomeArquivo ;
    For i := 0 to vQtdeArq-1 do
      vArquivos[i+1] := ListBoxArquivos.Items[I] ;

    vServidor    := Trim(IIf(pUsaContaUsu, vUsuario.Servidorsmtp, '200.234.205.143')) ;
    vEMailOrigem := Trim(IIf(pUsaContaUsu, vUsuario.Email,        'alessandro.augusto@bgmrodotec.com.br')) ;
    vSenha       := Trim(IIf(pUsaContaUsu, vUsuario.Senhasnap,    '9251ajic')) ;
    vPorta       := Trim(IIf(pUsaContaUsu, vUsuario.Portaenvio,   '587')) ;

    With SakMsg1 do
    Begin
      ClearRawMail ;
      SendToList.Clear ;
      BCCList.Clear ;
      CCList.Clear ;
      UserName := Copy(vEMailOrigem,1,(Pos(vEMailOrigem,'@')-1)) ;
      From     := vEMailOrigem ;
      SendTo   := vEMailOrigem ; 
//      CC       :=  ;
      Subject  := vAssunto ;

      If Trim(REdtTexto.Text) <> '' Then
      Begin
        HTML.Clear ;
        HTML.Add('<html>' + Trim(REdtTexto.Text) + '</html>') ;
      End ; // If Trim(REdtTexto.Text) <> '' Then

      AttachedFiles.Clear ;
      For i := 0 to Length(vArquivos)-1 do
        AttachedFiles.Add(vArquivos[i]) ;
    End ; // With SakMsg1 do

    With SakSMTP1 do
    Begin
      Host       := vServidor ;
      UserID     := vEMailOrigem ;
      UserPasswd := vSenha ;
      Port       := vPorta ;
      Try
        Connect ;
        If Login And (Not SMTPError) then
          SendTheMessage(SakMsg1)
        Else
        Begin
          Result := False ;
          If pUsaContaUsu Then
            MensagemDlg('Erro de conexão.' + #13 +
                        'Verifique as configurações de e-mail no cadastro do usuário.',mtErro,mbOk) ;
        End ;
        Disconnect ;
      Except
       Result := False ;
       If pUsaContaUsu Then
         MensagemDlg('Erro de conexão.' + #13 +
                      'Verifique a conexão com a Internet.',mtErro,MbOk) ;
      End ; // Try - Except
    End ; // With vSakSMTP1 do

    Msg ;
  End ; // Function EnviarEMail : Boolean ;
begin
  BBtnEnviar.Enabled := False ;
  Screen.Cursor := crHourGlass ;

  vEnvio := EnviarEMail ;
  If Not vEnvio Then
    vEnvio := EnviarEMail(True) ;

  If vEnvio Then
  Begin
    MensagemDlg('E-mail enviado com sucesso.',MtInformacao,MbOk) ;
    If FileExists(vNomeArquivo) Then
      DeleteFile(vNomeArquivo) ;
  End Else // If vEnvio Then
    SalvaEMailNaCaixaDeSaida(vDe
                            ,vPara
                            ,vCC
                            ,vAssunto
                            ,REdtTexto.Text
                            ,vArquivos
                            ,IIf(IMenuAlta.Checked,tpAlta
                                                  ,IIf(IMenuBaixa.Checked,tpBaixa
                                                                         ,tpNormal)) ) ;

  BBtnEnviar.Enabled := True ;
  Screen.CurSor := CrDefault ;
  vUsuario.Free ;
  Saida.Click ;
end;

procedure TFrmCTR_EnviarEMailDaTela.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If shIft = [ssalt] Then
    vabandonaExit := Key in [45,101,71,103] ; {E,e,G,g}
end;

procedure TFrmCTR_EnviarEMailDaTela.ListBoxArquivosExit(Sender: TObject);
begin
  PnlArquivos.Visible := False ;
end;

procedure TFrmCTR_EnviarEMailDaTela.FormResize(Sender: TObject);
begin
  PosicionaBotoes(PnlBotoes) ;
  EdtAssunto.Width := PnlAssunto.Width - PnlTpEmail.Width - PnlBotoesEmail.Width - 10 ;
  Splitter1Moved(Sender) ;
end;

procedure TFrmCTR_EnviarEMailDaTela.Splitter1Moved(Sender: TObject);
begin
   PnlTexto.Height := IIf(PnlTexto.Height <= 80, 80
                                              ,IIf(PnlTelaImagem1.Height <= 80, PnlTela.Height - 80 - Splitter1.Height
                                              ,PnlTexto.Height))
end;

procedure TFrmCTR_EnviarEMailDaTela.SakSMTP1Connect(Sender: TObject);
begin
  BarraDeProgresso(1,1,SakSMTP1.InstanceSize,'Conectando...','E');
end;

procedure TFrmCTR_EnviarEMailDaTela.SakSMTP1SendProgress(Sender: TObject; Percent: Word);
begin
  BarraDeProgresso(1,Percent,SakSMTP1.InstanceSize,'Enviando e-mial...','E');
end;

end.
