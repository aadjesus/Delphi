unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RxMemDS, Db, DBTables, Grids, DBGrids, ImgList, ExtCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Query1: TQuery;
    DataSource1: TDataSource;
    RxMemoryData1: TRxMemoryData;
    DataSource2: TDataSource;
    RxMemoryData2: TRxMemoryData;
    db1: TDatabase;
    ImageList1: TImageList;
    DBGrid2: TDBGrid;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure RxMemoryData1AfterScroll(DataSet: TDataSet);
    procedure RxMemoryData2FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  With Query1 Do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add('SELECT ''N'' AS ABRE,A.*  FROM EST_CADMATERIAL A WHERE A.CODIGOMATINT <= 50');
    Open ;
    RxMemoryData1.LoadFromDataSet(Query1,0,lmCopy) ;

    Sql.Clear ;
    Sql.Add('SELECT  A.CODIGOMATINT,B.* FROM EST_MATMARCA A, EST_MARCAMATERIAL B WHERE A.CODIGOMARCAMAT = B.CODIGOMARCAMAT AND A.CODIGOMATINT <= 50');
    Open ;
    RxMemoryData2.LoadFromDataSet(Query1,0,lmCopy) ;
    RxMemoryData2.Filtered := False ;
    RxMemoryData2.Filtered := True ;
  End ; // With Query1 Do
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  If (Not DBGrid2.Visible) And (RxMemoryData1.FieldByName('ABRE').AsString =  'S') Then
    DBGrid2.Visible := True ;

  If Column.Field.FieldName = 'ABRE' Then
  Begin

    If Column.Width <> 17 Then Column.Width := 17 ;

    DBGrid1.Canvas.FillRect(Rect) ;
    If RxMemoryData1.FieldByName('ABRE').AsString =  'S' Then
      ImageList1.Draw(DBGrid1.Canvas,Rect.Left,Rect.Top,0)
    Else
      ImageList1.Draw(DBGrid1.Canvas,Rect.Left,Rect.Top,1) ;

    If gdFocused In State Then
      If RxMemoryData1.FieldByName('ABRE').AsString =  'S' Then
        DBGrid2.SetBounds(Rect.Left+22,Rect.Top+20,Width-100,Height-200)
      Else
        DBGrid2.SetBounds(0,0,0,0) ;
  End ;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  If Column.Field.FieldName = 'ABRE' Then
  Begin
    RxMemoryData1.Edit ;
    If RxMemoryData1.FieldByName('ABRE').AsString =  'N' Then
      RxMemoryData1.FieldByName('ABRE').AsString := 'S'
    Else
      RxMemoryData1.FieldByName('ABRE').AsString := 'N' ;
    RxMemoryData1.Post ;
  End ;
end;

procedure TForm1.RxMemoryData1AfterScroll(DataSet: TDataSet);
begin
  RxMemoryData2.Filtered := False ;
  RxMemoryData2.Filtered := True ;
end;

procedure TForm1.RxMemoryData2FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := RxMemoryData1.FieldByName('CODIGOMATINT').AsInteger = RxMemoryData2.FieldByName('CODIGOMATINT').AsInteger ;
end;

end.



