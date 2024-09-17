unit CTR_CaixaDeSaida;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, ImgList, DBTables, StdCtrls, RXSpin, Mask, ToolEdit, Grids,
  DBGrids, ExtCtrls, RxMemDS, Buttons, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_CaixaDeSaida = class(TForm)
    PnlEMail: TPanel;
    DBGridEMail: TDBGrid;
    QryPesquisa: TQuery;
    ImageList1: TImageList;
    DSEMail: TDataSource;
    MDEMail: TRxMemoryData;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    pnlBotoes: TPanel;
    btnConfirma: TBitBtn;
    MDArquivo: TRxMemoryData;
    DSArquivo: TDataSource;
    PMenuGeral: TPopupMenu;
    IMenuMarcaDesmarca: TMenuItem;
    IMenuExcluir: TMenuItem;
    Panel2: TPanel;
    MemoTexto: TMemo;
    PnlArquivos: TPanel;
    DBGridArquivo: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure DBGridEMailDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridEMailKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEMailTitleClick(Column: TColumn);
    procedure MDEMailAfterScroll(DataSet: TDataSet);
    procedure MDArquivoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure PMenuGeralPopup(Sender: TObject);
    procedure IMenuMarcaDesmarcaClick(Sender: TObject);
    procedure MDEMailFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    Procedure HabilitaBotoes ;
  public
    { Public declarations }
  end;

var
  FrmCTR_CaixaDeSaida: TFrmCTR_CaixaDeSaida;

implementation

uses Bgm_Tela,
     Bgm_String,
     MenuPrincipal,
     CTR_CAD_Classes,
     Tur_Funcoes,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.DFM}

procedure TFrmCTR_CaixaDeSaida.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree ;
end;

procedure TFrmCTR_CaixaDeSaida.FormKeyPress(Sender: TObject; var Key: Char);
begin
  HabilitaBotoes ;
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt}
end;

procedure TFrmCTR_CaixaDeSaida.FormShow(Sender: TObject);
Var
  i : Integer ;
begin
  PosicionaBotoes(pnlBotoes) ;
  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt }
end;

procedure TFrmCTR_CaixaDeSaida.Sada1Click(Sender: TObject);
Var i : Integer ;
begin
  If MDEMail.Locate('ENVIAR',2,[LocaseInsensitive]) Then
  Begin
    If vcDataBase.InTransaction then
      vcDataBase.Rollback ;
    vcDataBase.StartTransaction ;

    MDEMail.First ;
    While Not MDEMail.Eof do
    Begin
      If MDEMail.FieldByName('ENVIAR').AsInteger = 2 Then
      Begin
        With QryPesquisa do
        Begin
          Close ;
          For i := 1 to 2 do
          Begin
            SQL.Clear ;
            SQL.Add(' DELETE FROM'+
                    ' CTR_EMAIL' + IIf(i=1,'ARQ','') ) ;
            SQL.Add(' WHERE'+
                    ' CODEMAIL = :P_CODEMAIL') ;
            ParamByName('P_CODEMAIL').AsInteger := MDEMail.FieldByName('CODEMAIL').AsInteger ;
            ExecSQL ;
          End ; // For i := 1 to 2 do
        End ; // With QryPesquisa do
      End ; // If MDEMail.FieldByName('ENVIAR').AsInteger = 2 Then
      MDEMail.Next ;
    End ; // While Not Eof do
    vcDataBase.Commit ;
  End ; // If MDEMail.Locate('ENVIAR',2,[LocaseInsensitive]) Then
  Close ;
end;

procedure TFrmCTR_CaixaDeSaida.DBGridEMailDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
Var
  vPriA,
  vPriB : Boolean ;
begin
  vPriA := MDEMail.FieldByName('PRIORIDADE').AsString = 'A' ;
  vPriB := MDEMail.FieldByName('PRIORIDADE').AsString = 'B' ;

  If Column.Field.FieldName = 'ENVIAR' Then
  Begin
    DBGridEMail.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridEMail.Canvas
                   ,Rect.Left+1
                   ,Rect.Top+1
                   ,MDEMail.FieldByName('ENVIAR').AsInteger  ) ;
  End Else // If Column.Field.FieldName = 'ENVIAR' Then
  If Column.Field.FieldName = 'PRIORIDADE' Then
  Begin
    DBGridEMail.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridEMail.Canvas
                   ,Rect.Left+1
                   ,Rect.Top+1
                   ,IIf(vPriA,3,
                    IIf(vPriB,4,5))
                    ) ;
  End Else // If Column.Field.FieldName = 'PRIORIDADE' Then
  If Column.Field.FieldName = 'QTDEARQ' Then
  Begin
    DBGridEMail.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridEMail.Canvas
                   ,Rect.Left+1
                   ,Rect.Top+1
                   ,IIf(MDEMail.FieldByName('QTDEARQ').AsInteger=1,-1,2) ) ;

    If gdSelected in State then
    Begin
      PnlArquivos.Visible := MDEMail.FieldByName('QTDEARQ').AsInteger <> 0 ;
      PnlArquivos.SetBounds(68
                           ,PnlEMail.Top + Rect.Top + 22
                           ,500 //PnlArquivos.Width
                           ,94)

    End ; // If gdSelected in State then
  End Else // If Column.Field.FieldName = 'QTDEARQ' Then
    MudaACorDoGrid(Sender,Rect,DataCol,State,vPriA Or vPriB, IIf(vPriA,clRed,
                                                             IIf(vPriB,clBlue
                                                                      ,clBlack)) );


end;

procedure TFrmCTR_CaixaDeSaida.DBGridEMailKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #32 Then // Tecla ESPACO
    IMenuMarcaDesmarcaClick(IMenuMarcaDesmarca) ;
end;

procedure TFrmCTR_CaixaDeSaida.DBGridEMailTitleClick(Column: TColumn);
begin
  OrdenaColunas(Column) ;
end;

procedure TFrmCTR_CaixaDeSaida.MDEMailAfterScroll(DataSet: TDataSet);
Var
  vCodEmail : Integer ;
begin
  vCodEmail := MDEMail.FieldByName('CODEMAIL').AsInteger ;

  If vCodEmail = 0 Then Exit ;

  MemoTexto.Text := MDEMail.FieldByName('TEXTO').AsString ;
  If MDArquivo.Active Then
  Begin
    MDArquivo.First ;
    If MDArquivo.Locate('CODEMAIL',vCodEmail,[LocaseInsensitive]) Then
    Begin
      MDArquivo.Filtered := False ;
      MDArquivo.Filtered := True ;
      Exit ;
    End ; // If MDArquivo.Locate(...
  End ; // If MDArquivo.Active Then

  With QryPesquisa do
  Begin
    Close ;
    SQL.Clear ;
    SQL.Add(' SELECT'+
            '  CODEMAIL'+
            ' ,ARQUIVO'+
            '') ;
    SQL.Add(' FROM'+
            ' CTR_EMAILARQ') ;
    SQL.Add(' WHERE'+
            ' CODEMAIL = :P_CODEMAIL'+
            '') ;
    ParamByName('P_CODEMAIL').AsInteger := vCodEmail ;
    Open ;
    MDArquivo.LoadFromDataSet(QryPesquisa,0,IIf(MDArquivo.RecordCount = 0,lmCopy, lmAppend)) ;
    MDArquivo.First ;
    MDArquivo.Filtered := False ;
    MDArquivo.Filtered := True ;
  End ; // With QryPesquisa do
end;

procedure TFrmCTR_CaixaDeSaida.MDArquivoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := MDArquivo.FieldByName('CODEMAIL').AsInteger = MDEMail.FieldByName('CODEMAIL').AsInteger ;
end;

procedure TFrmCTR_CaixaDeSaida.PMenuGeralPopup(Sender: TObject);
begin
  IMenuMarcaDesmarca.Visible := Not MDEMail.IsEmpty ;
  IMenuExcluir.Visible       := IMenuMarcaDesmarca.Visible ;
end;

procedure TFrmCTR_CaixaDeSaida.IMenuMarcaDesmarcaClick(Sender: TObject);
begin
  PMenuGeralPopup(Sender) ; // Apenas p/ atualizar os itens do menu
  If Not TMenuItem(Sender).Visible Then Exit ;

  MDEMail.Edit ;
  MDEMail.FieldByName('ENVIAR').AsInteger := IIf(TMenuItem(Sender).Name = 'IMenuMarcaDesmarca',IIf(MDEMail.FieldByName('ENVIAR').AsInteger = 0,1,0)
                                                                                              ,2) ;
  MDEMail.Post ;

  If TMenuItem(Sender).Name = 'IMenuExcluir' Then
  Begin
    MDEMail.Filtered := False ;
    MDEMail.Filtered := True ;
  End ; // If TMenuItem(Sender).Name = 'IMenuExcluir' Then
  HabilitaBotoes ;
end;

procedure TFrmCTR_CaixaDeSaida.MDEMailFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := MDEMail.FieldByName('ENVIAR').AsInteger <> 2 ;
end;

procedure TFrmCTR_CaixaDeSaida.btnConfirmaClick(Sender: TObject);
Var
  vUsuario : TUsuario ;
  Function EnvioEMail : Boolean ;
  Begin
    Result := True ;
    With IdSmtp1 do
    Begin
      AuthenticationType := AtLogin ;

      Host     := Trim(vUsuario.Servidorsmtp) ;
      Port     := StrToInt(Trim(vUsuario.Portaenvio)) ;

      Username := vUsuario.Email ;
      Password := '9251ajic' ; // vUsuario.Senhasnap ;

      With IdMessage1 do
      Begin
        Clear ;
        From.Text              := IIf(MDEMail.FieldByName('DE').AsString='',vUsuario.Email,MDEMail.FieldByName('DE').AsString) ;
        Recipients.Add.Address := MDEMail.FieldByName('PARA').AsString ;

        If Trim(MDEMail.FieldByName('CC').AsString) <> '' Then
          CCList.Add.Address   := MDEMail.FieldByName('CC').AsString ;

        Subject  := MDEMail.FieldByName('ASSUNTO').AsString ;
        Priority := IIf(MDEMail.FieldByName('PRIORIDADE').AsString='A',mpHigh,
                    IIf(MDEMail.FieldByName('PRIORIDADE').AsString='N',mpNormal
                                                                      ,mpLow)) ;
        MDArquivo.Filtered := False ;
        MDArquivo.Filtered := True ;
        While Not MDArquivo.Eof do
        Begin
          TIdAttachment.Create(IdMessage1.MessageParts,MDArquivo.FieldByName('ARQUIVO').AsString) ;
          MDArquivo.Next ;
        End ; // While Not Eof do
      End ; // With IdMessage1 do

      IdMessage1.Body.Add(MDEMail.FieldByName('TEXTO').AsString) ;

      Try
        Msg('Conectando à internet ...') ;
        Connect ;
      Except
        Disconnect ;
        DisconnectSocket ;
        MensagemDlg('Erro de conexão.' + #13 +
                    'Verifique a conexão com a internet.',MtInformacao,MbOk) ;
        Result := False ;
      End ;

      If Result Then
      Begin
        Msg('Enviando e-mail ...') ;
        Try
          Send(IdMessage1) ;
          Disconnect ;
          DisconnectSocket ;
        Except
          Disconnect ;
          DisconnectSocket ;
          MensagemDlg('Erro de conexão.' + #13 +
                      'Verifique as configurações de e-mail no cadastro do usuário.',mtinformacao,mbOk) ;
          Result := False ;
        End ;
      End ; // If Result Then
    End ; // With IdSmtp1 do
    Msg ;
  End ; // Function EnvioEMail : Boolean ;
begin
  btnConfirma.Enabled := False ;
  With MDEMail do
  Begin
    First ;
    Screen.Cursor := crHourGlass ;
    vUsuario      := TUsuario.Create ;
    vUsuario.Pesquisar(vcUsuario) ;

    If (Trim(vUsuario.Servidorsmtp) = '') Or
       (Trim(vUsuario.Portaenvio)   = '') Or
       (Trim(vUsuario.Email)        = '') Or
       (Trim(vUsuario.Senhasnap)    = '') Then
      MensagemDlg('Não cadatrada configurações de e-mail no cadastro do usuário.',MtInformacao,MbOk)
    Else
      While Not Eof do
      Begin
        If (MDEMail.FieldByName('ENVIAR').AsInteger = 0) And EnvioEMail Then
        Begin
          MDEMail.Edit ;
          MDEMail.FieldByName('ENVIAR').AsInteger := 2 ;
          MDEMail.Post ;
        End ; // If (MDEMail.FieldByName('ENVIAR').AsInteger = 0) And ...
        Next ;
      End ; // While Not Eof do

    BarraDeProgresso(3,0,0) ;
    btnConfirma.Enabled := True ;
    Screen.CurSor := CrDefault ;
    vUsuario.Free ;
  End ; // With MDEMail do

  Sada1.Click ;
end;

procedure TFrmCTR_CaixaDeSaida.HabilitaBotoes ;
Var
  vRegAtual  : TBookmark ;
begin
  vRegAtual := MDEMail.GetBookmark ;
  btnConfirma.Enabled := MDEMail.Locate('ENVIAR',0,[LocaseInsensitive]) ;
  MDEMail.GotoBookmark(vRegAtual) ;
end;

end.
