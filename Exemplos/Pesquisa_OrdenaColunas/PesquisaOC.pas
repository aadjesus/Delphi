unit PesquisaOC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGrids, DBTables, Db, RxMemDS, Menus, StdCtrls,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt} ;

type
  TFrmPesquisaOC = class(TForm)
    Panel1: TPanel;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData2: TRxMemoryData;
    RxMemoryData3: TRxMemoryData;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Query1: TQuery;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    PopupMenu1: TPopupMenu;
    N11: TMenuItem;
    PopupMenu2: TPopupMenu;
    N12: TMenuItem;
    N22: TMenuItem;
    N31: TMenuItem;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    DBGrid3: TDBGrid;
    Panel4: TPanel;
    DBGrid2: TDBGrid;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DBGrid3TitleClick(Column: TColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesquisaOC: TFrmPesquisaOC;

implementation

uses      {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.DFM}

procedure TFrmPesquisaOC.FormShow(Sender: TObject);
begin
  With Query1 do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT * FROM BGM_CLIENTE     WHERE CODCLI       <= 100') ;
    Open ;
    RxMemoryData1.LoadFromDataSet(Query1,0,lmCopy) ;

    Sql.Clear ;
    Sql.Add(' SELECT * FROM FRT_CADVEICULOS WHERE CODIGOVEIC   <= 100') ;
    Open ;
    RxMemoryData2.LoadFromDataSet(Query1,0,lmCopy) ;

    Sql.Clear ;
    Sql.Add(' SELECT * FROM EST_CADMATERIAL WHERE CODIGOMATINT <= 100') ;
    Open ;
    RxMemoryData3.LoadFromDataSet(Query1,0,lmCopy) ;
  End ; // with Query1 do
end;

procedure TFrmPesquisaOC.DBGrid3TitleClick(Column: TColumn);
begin
  OrdenaColunas(Column) ;
end;

procedure TFrmPesquisaOC.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

end.
