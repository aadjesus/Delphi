unit Tela_de_Alteracoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Grids, DBGrids, Menus, ExtCtrls, StdCtrls, RxGIF, DBCtrls,
  DBTables, Db, ImgList, RxMemDS, jpeg, RxQuery;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Query2: TQuery;
    DB: TDatabase;
    ImageList1: TImageList;
    PMenuGeral: TPopupMenu;
    IMenuLido: TMenuItem;
    IMenuNaoLido: TMenuItem;
    IMenuTodasLido: TMenuItem;
    IMenuTodasNaoLido: TMenuItem;
    IMenuLer: TMenuItem;
    N1: TMenuItem;
    RxMemoryData1: TRxMemoryData;
    Panel3: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Panel4: TPanel;
    DBMemo1: TDBMemo;
    PnlSaidaTextImpress: TPanel;
    PnlSaida: TPanel;
    PnlTitulo: TPanel;
    ImageGlobus: TImage;
    Panel6: TPanel;
    Label20: TLabel;
    Panel7: TPanel;
    DBNavigator1: TDBNavigator;
    Query1: TRxQuery;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure PMenuGeralPopup(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure IMenuLerClick(Sender: TObject);
    procedure DBNavigator1BeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    function IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
  db.Connected := False ;
  db.Connected := True ;

  Query1.Close ;
  Query1.Sql.Clear ;
  Query1.Sql.Add(' SELECT'+
                 '  A.*'+
                 ' ,''N'' AS MARCO'+
//                 ' ,''N'' AS %TESTE'+
//                 ' ,%MODULO AS'+
                 ' ,DECODE(ROWNUM,4,1,DECODE(ROWNUM,6,2,DECODE(ROWNUM,8,2,DECODE(ROWNUM,7,3,DECODE(ROWNUM,9,3,DECODE(ROWNUM,10,3,0)))))) AS PRIORIDADE') ;
  Query1.Sql.Add(' FROM'+
                 ' CTR_NOVIDADESDOSMODULOS A') ;
//  Query1.MacroByName('TESTE').AsString := 'MARCO' ;

  Query1.Open ;
  RxMemoryData1.LoadFromDataSet(Query1,0,lmCopy) ;
  Caption := Query1.FieldByName('MODULO').AsString +' - Novidades do módulo (17/01/2006 14:00)' ;
  PnlTitulo.Caption := '     ' + Query1.FieldByName('MODULO').AsString +' - Descrição' ;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  vPrio : Integer ;
begin
  vPrio := RxMemoryData1.FieldByName('PRIORIDADE').AsInteger ;
  If Column.Field.FieldName = 'MARCO' Then
  Begin
    If Column.Width <> 17 Then
      Column.Width := 17 ;
    DBGrid1.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGrid1.Canvas,Rect.Left+1,Rect.Top+1,IIf(RxMemoryData1.FieldByName('MARCO').AsString='S',1,0)) ;
  End Else // If Column.Field.FieldName = 'MARCO' Then
  If Column.Field.FieldName = 'PRIORIDADE' Then
  Begin
    If Column.Width <> 17 Then
      Column.Width := 17 ;
    DBGrid1.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGrid1.Canvas,Rect.Left+1,Rect.Top+1,IIf(vPrio=1,2,
                                                          IIf(vPrio=2,3,
                                                          IIf(vPrio=3,4,-1)))) ;
  End ; // If Column.Field.FieldName = 'PRIORIDADE' Then

  DBGrid1.ShowHint := True ;
  DBGrid1.Hint     := IIf(vPrio=1,'Prioridade alta',
                      IIf(vPrio=2,'Prioridade baixa',
                      IIf(vPrio=3,'Entra em contado'
                                 ,'Prioridade normal'))) ;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  DBGrid1.Enabled := False ;
  Panel2.Visible  := True ;
  Panel2.Top      := Trunc((DBGrid1.Height-Panel2.Height) / 2) ;
  Panel2.Left     := Trunc((DBGrid1.Width -Panel2.Width)  / 2) ;
end;

procedure TForm1.Label20Click(Sender: TObject);
begin
  DBGrid1.Enabled := True ;
  Panel2.Visible  := False ;
  IMenuLerClick(DBNavigator1) ;
end;

procedure TForm1.Sada1Click(Sender: TObject);
begin
  Close ;
end;

procedure TForm1.PMenuGeralPopup(Sender: TObject);
Var
  vRegAtual : TBookmark ;
begin
  IMenuLido.Enabled    := (RxMemoryData1.FieldByName('MARCO'     ).AsString  = 'N') And
                          (RxMemoryData1.FieldByName('PRIORIDADE').AsInteger <> 1)  ; // Prioridade alta tem q ser lida
  IMenuNaoLido.Enabled := (RxMemoryData1.FieldByName('MARCO'     ).AsString  = 'S') ;

  RxMemoryData1.DisableControls ;
  vRegAtual := RxMemoryData1.GetBookmark ;

  IMenuTodasLido.Enabled    := RxMemoryData1.Locate('MARCO','N',[loCaseInsensitive]) And
                               IMenuLido.Enabled ;
  IMenuTodasNaoLido.Enabled := RxMemoryData1.Locate('MARCO','S',[loCaseInsensitive]) ;

  RxMemoryData1.GotoBookmark(vRegAtual) ;
  RxMemoryData1.EnableControls ;
end;

function TForm1.IIf(pCondicao: Boolean; pResultTrue,pResultFalse: Variant): Variant;
begin
  If pCondicao Then
    Result := pResultTrue
  else
    Result := pResultFalse;
end;

procedure TForm1.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #32 Then // Tecla ESPACO
    If RxMemoryData1.FieldByName('MARCO').AsString = 'N' Then
      IMenuLerClick(IMenuLido)
    Else
      IMenuLerClick(IMenuNaoLido) ;
end;

procedure TForm1.IMenuLerClick(Sender: TObject);
Var
  vTodos : Boolean ;
  vRegAtual : TBookmark ;
begin
  PMenuGeralPopup(Sender) ;
  If Not TMenuItem(Sender).Enabled Then Exit ;

  If TMenuItem(Sender).Name = 'IMenuLer' Then
    DBGrid1DblClick(Sender)
  Else
  Begin
    With RxMemoryData1 do
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
    End ; // With RxMemoryData1 do
  End ;
end;

procedure TForm1.DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
begin
  IMenuLerClick(Sender) ;
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  OrdenaColunas(Column) ;
end;

end.
