unit CTR_NovidadesDoModulo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Grids, DBGrids, Menus, ExtCtrls, StdCtrls, RxGIF, DBCtrls,
  DBTables, Db, ImgList, RxMemDS, jpeg, RxQuery, ComCtrls, Gradient,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_NovidadesDoModulo = class(TForm)
    PnlNovidades: TPanel;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    DBGridNovidades: TDBGrid;
    DSNovidades: TDataSource;
    QryPesquisa: TQuery;
    ImageList1: TImageList;
    PMenuGeral: TPopupMenu;
    IMenuLida: TMenuItem;
    IMenuNaoLida: TMenuItem;
    IMenuTodasLida: TMenuItem;
    IMenuTodasNaoLida: TMenuItem;
    IMenuLer: TMenuItem;
    N1: TMenuItem;
    RMDNovidades: TRxMemoryData;
    PnlTelaDescicao: TPanel;
    Panel4: TPanel;
    DBMemoAssunto: TDBMemo;
    PnlSaidaTextImpress: TPanel;
    PnlSaida: TPanel;
    PnlTitulo: TPanel;
    ImageGlobus: TImage;
    Panel6: TPanel;
    Label20: TLabel;
    Panel7: TPanel;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure DBGridNovidadesDblClick(Sender: TObject);
    procedure DBGridNovidadesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridNovidadesKeyPress(Sender: TObject; var Key: Char);
    procedure PMenuGeralPopup(Sender: TObject);
    procedure IMenuLerClick(Sender: TObject);
    procedure PnlSaidaClick(Sender: TObject);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCTR_NovidadesDoModulo: TFrmCTR_NovidadesDoModulo;

implementation

uses MenuPrincipal,
     BGM_String,
     BGM_Tela,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.DFM}

procedure TFrmCTR_NovidadesDoModulo.FormClose(Sender: TObject; var Action: TCloseAction);
Var vIncluir, vApagar : Boolean ;
begin
  RMDNovidades.First ;
  While RMDNovidades.Locate('JALIDA;LIDA',VarArrayOf([0,1]),[loCaseInsensitive]) Or
        RMDNovidades.Locate('JALIDA;LIDA',VarArrayOf([1,0]),[loCaseInsensitive]) do
  Begin
    With QryPesquisa do
    Begin
      Close ;
      Sql.Clear ;
      vIncluir := (RMDNovidades.FieldByName('JALIDA').AsInteger = 0) And (RMDNovidades.FieldByName('LIDA').AsInteger = 1) ;
      vApagar  := (RMDNovidades.FieldByName('JALIDA').AsInteger = 1) And (RMDNovidades.FieldByName('LIDA').AsInteger = 0) ;
      If vIncluir Then
      Begin
        Sql.Add('INSERT INTO CTR_NOVIDADESLIDAS(CODNOVIDADE') ;
        Sql.Add('                              ,USUARIO') ;
        Sql.Add('                              ,DATALEITURA') ;
        Sql.Add(')VALUES(:P_CODNOVIDADE') ;
        Sql.Add('       ,:P_USUARIO') ;
        Sql.Add('       ,:P_DATALEITURA') ;
        Sql.Add('       )') ;
        ParamByName('P_USUARIO'    ).AsString   := vcUsuario ;
        ParamByName('P_DATALEITURA').AsDateTime := Now ;
      End Else // If vIncluir Then
      If vApagar Then
      Begin
        Sql.Add('DELETE CTR_NOVIDADESLIDAS') ;
        Sql.Add(' WHERE CODNOVIDADE = :P_CODNOVIDADE') ;
      End ; // If vApagar Then

      If vIncluir Or vApagar Then
      Begin
        ParamByName('P_CODNOVIDADE').AsInteger  := RMDNovidades.FieldByName('CODNOVIDADE').AsInteger ;
        Try
          ExecSql ;
        Except on E:EDBEngineError do
        End ;
      End ; // If vIncluir Or vApagar Then

      RMDNovidades.Edit ;
      RMDNovidades.FieldByName('JALIDA').AsInteger := IIf(RMDNovidades.FieldByName('JALIDA').AsInteger=0,1,RMDNovidades.FieldByName('JALIDA').AsInteger) ;
      RMDNovidades.FieldByName('LIDA'  ).AsInteger := IIf(RMDNovidades.FieldByName('LIDA'  ).AsInteger=0,1,RMDNovidades.FieldByName('LIDA'  ).AsInteger) ;
      RMDNovidades.Post ;
    End ; // With QryPesquisa do
  End ; // While not RMDNovidades.Eof do
  Action := caFree ;
end;

procedure TFrmCTR_NovidadesDoModulo.FormCreate(Sender: TObject);
begin
  With QryPesquisa Do
  begin
    Close ;
    sql.Clear ;
    Sql.Add('SELECT A.CODNOVIDADE') ;
    Sql.Add('     , A.TOPICO') ;
    Sql.Add('     , A.DATA AS DATA_NOVIDADE') ;
    Sql.Add('     , A.ASSUNTO') ;
    Sql.Add('     , B.DATALEITURA AS DATA_LEITURA') ;
    Sql.Add('     , DECODE(B.CODNOVIDADE,NULL,0,1) AS LIDA') ;
    Sql.Add('     , DECODE(B.CODNOVIDADE,NULL,0,1) AS JALIDA') ;
    Sql.Add('     , 2 AS PRIORIDADE') ;
    Sql.Add('  FROM CTR_NOVIDADES      A') ;
    Sql.Add('     , CTR_NOVIDADESLIDAS B') ;
    Sql.Add(' WHERE A.CODNOVIDADE = B.CODNOVIDADE(+)') ;
    Sql.Add('   AND B.USUARIO(+)  = :P_USUARIO') ;
    Sql.Add('   AND A.SISTEMA     = :P_SISTEMA') ;
    Sql.Add('   AND (A.CONCEDENTE = :P_CONCEDENTE OR A.CONCEDENTE IS NULL)') ;
    ParamByName('P_USUARIO'   ).AsString  := vcUsuario ;
    ParamByName('P_SISTEMA'   ).AsString  := vcSistema ;
    ParamByName('P_CONCEDENTE').AsInteger := vcCodigoCliente ;
    AbrirQuery(QryPesquisa,'PesqNovi') ;
    RMDNovidades.LoadFromDataSet(QryPesquisa,0,lmCopy) ;
  End ; // With QryPesquisa Do
end;

procedure TFrmCTR_NovidadesDoModulo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmCTR_NovidadesDoModulo.FormShow(Sender: TObject);
var
  i : integer;
begin
  RMDNovidades.First ;
  i := 0 ;
  While Not RMDNovidades.Eof do
  Begin
    If RMDNovidades.FieldByName('LIDA').AsInteger = 0 Then
      Inc(i) ;
    RMDNovidades.Next ;
  End ; // While Not Eof do
  StatusBar1.Panels[0].Text := IntToStr(RMDNovidades.RecordCount) + ', mensagem(ns), '+ IntToStr(i) +' não lida(s)' ;

  RMDNovidades.SortOnFields('LIDA;DATA_NOVIDADE') ;
  RMDNovidades.First ;

  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt}
end;

procedure TFrmCTR_NovidadesDoModulo.Sada1Click(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCTR_NovidadesDoModulo.DBGridNovidadesDblClick(Sender: TObject);
begin
  DBGridNovidades.Enabled := False ;
  PnlTelaDescicao.Visible := True ;
  PnlTelaDescicao.Top     := Trunc((DBGridNovidades.Height-PnlTelaDescicao.Height) / 2) ;
  PnlTelaDescicao.Left    := Trunc((DBGridNovidades.Width -PnlTelaDescicao.Width)  / 2) ;
end;

procedure TFrmCTR_NovidadesDoModulo.DBGridNovidadesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
Var
  vPrioridade : Integer ;
begin
  vPrioridade := RMDNovidades.FieldByName('PRIORIDADE').AsInteger ;

  If Column.Field.FieldName = 'LIDA' Then
  Begin
    DBGridNovidades.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridNovidades.Canvas
                   ,Rect.Left+1
                   ,Rect.Top+1
                   ,RMDNovidades.FieldByName('LIDA').AsInteger) ;
  End Else // If Column.Field.FieldName = 'LIDA' Then
  If Column.Field.FieldName = 'PRIORIDADE' Then
  Begin
    DBGridNovidades.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridNovidades.Canvas
                   ,Rect.Left+1
                   ,Rect.Top+1
                   ,IIf(vPrioridade=1,2,
                    IIf(vPrioridade=2,3,
                    IIf(vPrioridade=3,4,-1)))) ;

  End ; // If Column.Field.FieldName = 'PRIORIDADE' Then

  DBGridNovidades.ShowHint := True ;
  DBGridNovidades.Hint     := IIf(vPrioridade=1,'Prioridade alta',
                              IIf(vPrioridade=2,'Prioridade baixa',
                              IIf(vPrioridade=3,'Entra em contado'
                                               ,'Prioridade normal'))) ;
end;

procedure TFrmCTR_NovidadesDoModulo.DBGridNovidadesKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #32 Then // Tecla ESPACO
    If RMDNovidades.FieldByName('LIDA').AsInteger = 0 Then
      IMenuLerClick(IMenuLida)
    Else
      IMenuLerClick(IMenuNaoLida) ;
end;

procedure TFrmCTR_NovidadesDoModulo.PMenuGeralPopup(Sender: TObject);
Var
  vRegAtual : TBookmark ;
begin
  IMenuLida.Enabled    := (RMDNovidades.FieldByName('LIDA'      ).AsInteger =  0) And
                          (RMDNovidades.FieldByName('PRIORIDADE').AsInteger <> 1)  ; // Prioridade alta tem q ser lida
  IMenuNaoLida.Enabled := (RMDNovidades.FieldByName('LIDA'      ).AsInteger =  1) ;

  RMDNovidades.DisableControls ;
  vRegAtual := RMDNovidades.GetBookmark ;

  IMenuTodasLida.Enabled    := RMDNovidades.Locate('LIDA',0,[loCaseInsensitive]) And
                               IMenuLida.Enabled ;
  IMenuTodasNaoLida.Enabled := RMDNovidades.Locate('LIDA',1,[loCaseInsensitive]) ;

  RMDNovidades.GotoBookmark(vRegAtual) ;
  RMDNovidades.FreeBookmark(vRegAtual) ;
  RMDNovidades.EnableControls ;
end;

procedure TFrmCTR_NovidadesDoModulo.IMenuLerClick(Sender: TObject);
Var
  vTodos    : Boolean ;
  vRegAtual : TBookmark ;
begin
  PMenuGeralPopup(Sender) ;
  If Not TMenuItem(Sender).Enabled Then Exit ;

  If TMenuItem(Sender).Name = 'IMenuLer' Then
    DBGridNovidadesDblClick(Sender)
  Else // If TMenuItem(Sender).Name = 'IMenuLer' Then
  Begin
    With RMDNovidades do
    Begin
      vRegAtual := GetBookmark ;
      DisableControls ;

      vTodos := Pos('Todas',TMenuItem(Sender).Name) > 0 ;
      If vTodos Then
        First ;

      While Not Eof do
      Begin
        Edit ;
        FieldByName('LIDA').AsInteger := IIf((FieldByName('PRIORIDADE').AsInteger = 1) And (Sender <> DBNavigator1),'N',TMenuItem(Sender).Tag)  ;
        If FieldByName('JALIDA').AsInteger = 0 Then
          FieldByName('DATA_LEITURA').AsDateTime := Now ;
        Post ;

        If vTodos Then
          Next
        Else
          Break ;
      End ; // While Not Eof do

      EnableControls ;
      GotoBookmark(vRegAtual) ;
      FreeBookmark(vRegAtual) ;
    End ; // With RxMemoryData1 do
  End ; // Else // If TMenuItem(Sender).Name = 'IMenuLer' Then
end;

procedure TFrmCTR_NovidadesDoModulo.PnlSaidaClick(Sender: TObject);
begin
  PnlTelaDescicao.Visible  := False ;
  DBGridNovidades.Enabled  := True ;
  DBGridNovidades.SetFocus ;
end;

procedure TFrmCTR_NovidadesDoModulo.DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
begin
  If RMDNovidades.FieldByName('LIDA').AsInteger = 0 Then
    IMenuLerClick(IMenuLida) ;
end;

end.
