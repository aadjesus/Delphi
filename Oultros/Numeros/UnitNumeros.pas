unit UnitNumeros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, RxMemDS, Grids, DBGrids, RXSpin;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    RxMemoryData2: TRxMemoryData;
    RxMemoryData2Qtde: TIntegerField;
    DataSource3: TDataSource;
    RxMemoryData3: TRxMemoryData;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    RxMemoryData3Dezena: TStringField;
    RxMemoryData2Dezena: TStringField;
    DBGrid3: TDBGrid;
    Label1: TLabel;
    RxSpinEdit1: TRxSpinEdit;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    RxSpinEdit2: TRxSpinEdit;
    DataSource1: TDataSource;
    RxMemoryData1: TRxMemoryData;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    RxSpinEdit3: TRxSpinEdit;
    RxSpinEdit4: TRxSpinEdit;
    RxSpinEdit5: TRxSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    vOrdem : Boolean  ;
    vColuna : Integer ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
Var
  i,
  vPos    : Integer ;
  vDezena : String ;
begin
  RxMemoryData2.Close ;
  RxMemoryData3.Close ;

  RxMemoryData2.Open ;
  RxMemoryData3.Open ;

  RxMemoryData2.DisableControls ;
  RxMemoryData3.DisableControls ;
  vOrdem  := False ;
  vColuna := 0 ;
  vPos := 1 ;
  For i := 1 to Trunc(Length(Trim(Memo1.Text))/2)  do
  Begin
    vDezena := Copy(Memo1.Text,vPos,2) ;
    Try
      StrToInt(vDezena)
    Except
      Inc(vPos,2) ;
      Continue ;
    End ; // Try - Except

    If Not RxMemoryData2.Locate('Dezena',vDezena,[loCaseInsensitive]) Then
      RxMemoryData2.Append ;
    RxMemoryData2.Edit ;
    RxMemoryData2.FieldByName('Dezena').AsString  := vDezena ;
    RxMemoryData2.FieldByName('Qtde'  ).AsInteger := RxMemoryData2.FieldByName('Qtde'  ).AsInteger + 1 ;
    RxMemoryData2.Post ;
    Inc(vPos,2) ;
  End ; // For i := 1 to Trunc(Length(Trim(Memo1.Text))/2)  do

  For i := 1 to 59 do
  Begin
    vDezena :=FormatFloat('00',i) ;
    If Not RxMemoryData2.Locate('Dezena', vDezena,[loCaseInsensitive]) Then
    Begin
      RxMemoryData3.Append ;
      RxMemoryData3.FieldByName('Dezena').AsString  := vDezena ;
      RxMemoryData3.Post ;
    End ;
  End ; // For i := 1 to 59 do
  RxMemoryData2.SortOnFields('Dezena') ;
  RxMemoryData2.First ;
  RxMemoryData3.First ;

  RxMemoryData2.EnableControls ;
  RxMemoryData3.EnableControls ;
end;

procedure TForm1.DBGrid2TitleClick(Column: TColumn);
begin
  vOrdem  := (vColuna = Column.Index) And (Not vOrdem);
  vColuna := Column.Index ;

  TRxMemoryData(TDBGrid(Column.Grid).DataSource.DataSet).SortOnFields(Column.FieldName,True,vOrdem) ;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  If Not RxMemoryData2.Locate('Concurso;Dezena',VarArrayOf([RxSpinEdit1.Value,RxSpinEdit2.Value]),[loCaseInsensitive]) Then
    RxMemoryData1.Append ;
  RxMemoryData1.Edit ;
  RxMemoryData1.FieldByName('Concurso').AsFloat := RxSpinEdit1.Value ;
  RxMemoryData1.FieldByName('Dezena'  ).AsFloat := RxSpinEdit2.Value ;
  RxMemoryData1.Post ;
  

end;

end.


