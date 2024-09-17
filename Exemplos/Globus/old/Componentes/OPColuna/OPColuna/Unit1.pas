unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, OPColuna, DB, RxMemDS,
  DBTables ;

type
  TForm1 = class(TForm)
    PnlPesq: TPanel;
    PnlPesqTitulo: TPanel;
    PnlPesqTela: TPanel;
    EdtPesquisa: TEdit;
    LblPesquisa: TLabel;
    ImageGlobus: TImage;
    DBGrid1: TDBGrid;
    OPColuna1: TOPColuna;
    RxMemoryData1: TRxMemoryData;
    DataSource1: TDataSource;
    RxMemoryData2: TRxMemoryData;
    Query1: TQuery;
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
OPColuna1.OrdenaColunas(Column);
end;

end.
