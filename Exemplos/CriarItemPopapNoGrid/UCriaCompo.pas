unit UCriaCompo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Menus, DBTables, Db, RxMemDS, ExtCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    B1: TMenuItem;
    db1: TDatabase;
    Query1: TQuery;
    RxMemoryData1: TRxMemoryData;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edUsuario: TEdit;
    edSenha: TEdit;
    edServidor: TEdit;
    ButtonRX: TButton;
    Button1: TButton;
    RxMemoryData2: TRxMemoryData;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ButtonRXClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

Uses
 UCriaCompoFunc ;

{$R *.DFM}

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  OrdenaColunas(Column) ;
end;

procedure TForm1.ButtonRXClick(Sender: TObject);
begin
  Try
    db1.Connected := False ;
    db1.Params.Clear;
    db1.AliasName := edServidor.Text;
    db1.Params.Add('USER NAME=' + edUsuario.Text);
    db1.Params.Add('PASSWORD=' + edSenha.Text);
    db1.Connected := True ;
  Except
    db1.Connected := False ;
    ShowMessage('Falhou na conexão');
    Exit;
  End;

  Query1.Close;
  Query1.Sql.Clear ;
  Query1.Sql.Add('SELECT * FROM BGM_CLIENTE WHERE CODCLI <= 500') ;
  RxMemoryData1.Close ;

  Query1.Open ;
  RxMemoryData1.LoadFromDataSet(Query1,0,lmCopy) ;
  RxMemoryData2.LoadFromDataSet(Query1,0,lmCopy) ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(' 1:' + inttostr(RxMemoryData1.RecordCount) +' 2:' + inttostr(RxMemoryData2.RecordCount)) ;
end;

procedure TForm1.RxMemoryData2FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := RxMemoryData2.FieldByName('CODCLI').AsInteger <= 300 ;
end;

end.
