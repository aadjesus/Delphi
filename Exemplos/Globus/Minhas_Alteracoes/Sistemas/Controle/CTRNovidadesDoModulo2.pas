unit CTRNovidadesDoModulo2 ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Grids, DBGrids, Menus, ExtCtrls, StdCtrls, RxGIF, DBCtrls,
  DBTables, Db, ImgList, RxMemDS, jpeg, RxQuery, ComCtrls,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt} ;

type
  TFrmCTRNovidadesDoModulo2 = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    DBGridNovidades: TDBGrid;
    DSNovidades: TDataSource;
    ImageList1: TImageList;
    PMenuGeral: TPopupMenu;
    IMenuLido: TMenuItem;
    IMenuNaoLido: TMenuItem;
    IMenuTodasLido: TMenuItem;
    IMenuTodasNaoLido: TMenuItem;
    IMenuLer: TMenuItem;
    N1: TMenuItem;
    MDataNovidades: TRxMemoryData;
    Panel3: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Panel4: TPanel;
    DBMemoTexto: TDBMemo;
    PnlSaidaTextImpress: TPanel;
    PnlSaida: TPanel;
    PnlTitulo: TPanel;
    ImageGlobus: TImage;
    Panel6: TPanel;
    Label20: TLabel;
    Panel7: TPanel;
    DBNavigator1: TDBNavigator;
    MDataNovidadesMARCO: TStringField;
    MDataNovidadesPRIORIDADE: TIntegerField;
    MDataNovidadesDATANOVIDADE: TDateTimeField;
    MDataNovidadesASSUNTO: TStringField;
    MDataNovidadesTOPICO: TStringField;
    MDataNovidadesTEXTO: TStringField;
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
    procedure DBGridNovidadesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridNovidadesDblClick(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure PMenuGeralPopup(Sender: TObject);
    procedure DBGridNovidadesKeyPress(Sender: TObject; var Key: Char);
    procedure IMenuLerClick(Sender: TObject);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCTRNovidadesDoModulo2: TFrmCTRNovidadesDoModulo2;

implementation

Uses {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt},
     BGM_Tela ;

{$R *.DFM}

procedure TFrmCTRNovidadesDoModulo2.FormShow(Sender: TObject);
Var
  QryJaGravados : TQuery ;
begin
  Caption           := vcSistema + ' - Novidades do módulo   (' + Edit1.Text + ')';
  PnlTitulo.Caption := '     ' + vcSistema + ' - Descrição' ;

  QryJaGravados := TQuery.Create(Nil) ;
  With QryJaGravados do
  Begin
    DatabaseName := cDatabaseName ;
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT'+
            '  A.*'+
            ' ,''S'' AS MARCO'+
            ' ,0     AS PRIORIDADE'+
            '') ;
    Sql.Add(' FROM'+
            ' CTR_NOVIDADESDOSMODULOS A'+
            '') ;
    Sql.Add(' WHERE'+
            '     A.MODULO  = :P_MODULO'+
            ' AND A.USUARIO = :P_USUARIO'+
            '') ;
    ParamByName('P_MODULO' ).AsString := vcSistema ;
    ParamByName('P_USUARIO').AsString := vcUsuario ;
    AbrirQuery(QryJaGravados,'PesqNovidades') ;

    MDataNovidades.LoadFromDataSet(QryJaGravados,0,lmAppend) ;
    Free ;
  End ; // With QryJaGravados do
  {
  With MDataNovidades do
  Begin
    Append ;
    MDataNovidadesMARCO        := 'N' ;
    MDataNovidadesPRIORIDADE   := 0 ;
    MDataNovidadesTOPICO       := Trim(Copy(RichEdit1.Lines[i], 1, cTamanhoTopico));
    MDataNovidadesASSUNTO      := Trim(Copy(RichEdit1.Lines[i], cInicialAssunto, cTamanhoAssunto));
    MDataNovidadesDATANOVIDADE := Trim(Copy(RichEdit1.Lines[i], cInicialData, cTamanhoData));
    MDataNovidadesTEXTO        := Copy(RichEdit1.Lines[i], cInicialTexto, Length(RichEdit1.Lines[i]) - cInicialTexto + 1) ;
    Post ;
  End ; // With MDataNovidades do
  }

  {$INCLUDE \GLOBUS\SISTEMAS\DATAHORA.TXT}
end;

procedure TFrmCTRNovidadesDoModulo2.DBGridNovidadesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  vPrio : Integer ;
begin
  vPrio := MDataNovidades.FieldByName('PRIORIDADE').AsInteger ;
  If Column.Field.FieldName = 'MARCO' Then
  Begin
    If Column.Width <> 17 Then
      Column.Width := 17 ;
    DBGridNovidades.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridNovidades.Canvas,Rect.Left+1,Rect.Top+1,IIf(MDataNovidades.FieldByName('MARCO').AsString='S',1,0)) ;
  End Else // If Column.Field.FieldName = 'MARCO' Then
  If Column.Field.FieldName = 'PRIORIDADE' Then
  Begin
    If Column.Width <> 17 Then
      Column.Width := 17 ;
    DBGridNovidades.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridNovidades.Canvas,Rect.Left+1,Rect.Top+1,IIf(vPrio=1,2,
                                                          IIf(vPrio=2,3,
                                                          IIf(vPrio=3,4,-1)))) ;
  End ; // If Column.Field.FieldName = 'PRIORIDADE' Then

  DBGridNovidades.ShowHint := True ;
  DBGridNovidades.Hint     := IIf(vPrio=1,'Prioridade alta',
                      IIf(vPrio=2,'Prioridade baixa',
                      IIf(vPrio=3,'Entra em contado'
                                 ,'Prioridade normal'))) ;
end;

procedure TFrmCTRNovidadesDoModulo2.DBGridNovidadesDblClick(Sender: TObject);
begin
  DBGridNovidades.Enabled := False ;
  Panel2.Visible  := True ;
  Panel2.Top      := Trunc((DBGridNovidades.Height-Panel2.Height) / 2) ;
  Panel2.Left     := Trunc((DBGridNovidades.Width -Panel2.Width)  / 2) ;
end;

procedure TFrmCTRNovidadesDoModulo2.Label20Click(Sender: TObject);
begin
  DBGridNovidades.Enabled := True ;
  Panel2.Visible  := False ;
  IMenuLerClick(DBNavigator1) ;
end;

procedure TFrmCTRNovidadesDoModulo2.Sada1Click(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCTRNovidadesDoModulo2.PMenuGeralPopup(Sender: TObject);
Var
  vRegAtual : TBookmark ;
begin
  IMenuLido.Enabled    := (MDataNovidades.FieldByName('MARCO'     ).AsString  = 'N') And
                          (MDataNovidades.FieldByName('PRIORIDADE').AsInteger <> 1)  ; // Prioridade alta tem q ser lida
  IMenuNaoLido.Enabled := (MDataNovidades.FieldByName('MARCO'     ).AsString  = 'S') ;

  MDataNovidades.DisableControls ;
  vRegAtual := MDataNovidades.GetBookmark ;

  IMenuTodasLido.Enabled    := MDataNovidades.Locate('MARCO','N',[loCaseInsensitive]) And
                               IMenuLido.Enabled ;
  IMenuTodasNaoLido.Enabled := MDataNovidades.Locate('MARCO','S',[loCaseInsensitive]) ;

  MDataNovidades.GotoBookmark(vRegAtual) ;
  MDataNovidades.EnableControls ;
end;

procedure TFrmCTRNovidadesDoModulo2.DBGridNovidadesKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #32 Then // Tecla ESPACO
    If MDataNovidades.FieldByName('MARCO').AsString = 'N' Then
      IMenuLerClick(IMenuLido)
    Else
      IMenuLerClick(IMenuNaoLido) ;
end;

procedure TFrmCTRNovidadesDoModulo2.IMenuLerClick(Sender: TObject);
Var
  vTodos : Boolean ;
  vRegAtual : TBookmark ;
begin
  PMenuGeralPopup(Sender) ;
  If Not TMenuItem(Sender).Enabled Then Exit ;


  If TMenuItem(Sender).Name = 'IMenuLer' Then
    DBGridNovidadesDblClick(Sender)
  Else
  Begin
    With MDataNovidades do
    Begin
      vRegAtual := GetBookmark ;
      DisableControls ;

      vTodos := Pos('Todas',TMenuItem(Sender).Name) > 0 ;
      If vTodos Then
        First ;

      While Not Eof do
      Begin
        Edit ;
        FieldByName('MARCO').AsString := IIf((FieldByName('PRIORIDADE').AsInteger = 1) And
                                             (TMenuItem(Sender).Name <> 'DBNavigator1'),'N',
                                         IIf(Pos('NaoLido',TMenuItem(Sender).Name) > 0,'N','S'))  ;
        Post ;

        If vTodos Then
          Next
        Else
          Break ;
      End ; // While Not Eof do
      
      EnableControls ;
      GotoBookmark(vRegAtual) ;
    End ; // With MDataNovidades do
  End ;
end;

procedure TFrmCTRNovidadesDoModulo2.DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
begin
  IMenuLerClick(Sender) ;
end;

end.
