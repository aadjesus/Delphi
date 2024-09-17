unit UnitLe_Query;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Okk, DBTables, Grids, DBGrids, ExtCtrls, Db, RxMemDS,
  Mask, TimeEdit, MemTable;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    db1: TDatabase;
    Query1: TQuery;
    DataSource1: TDataSource;
    Panel3: TPanel;
    ButtonQuery: TButton;
    DataSource2: TDataSource;
    Panel1: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DataSource3: TDataSource;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Button1: TButton;
    Button2: TButton;
    procedure LeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    vMTLog     : TMemoryTable ;
    
    Procedure GravaLog(pReferencia : String ; pQuery : TQuery = Nil) ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.GravaLog(pReferencia : String ; pQuery : TQuery = Nil) ;
Var
  i : Integer ;
  vQueryLog  : TQuery ;

begin
  If (pQuery = Nil) And (vMTLog <> Nil) And (vMTLog.Locate('REFERENCIA',pReferencia,[LocaseInsensitive])) Then
  Begin
    vQueryLog  := TQuery.Create(Screen) ;
    vQueryLog.DatabaseName := db1.DatabaseName ;

    With vQueryLog do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add(vMTLog.FieldByName('SQL').AsString) ;
      vMTLog.First ;
      vMTLog.Locate('REFERENCIA',pReferencia,[LocaseInsensitive]) ;
      While (vMTLog.FieldByName('REFERENCIA').AsString = pReferencia) And (Not vMTLog.Eof) do
      Begin
        ParamByName(vMTLog.FieldByName('PARAMETRO').AsString).AsString := vMTLog.FieldByName('VALPARAMETRO').AsString ;
        vMTLog.Next ;
      End ;
      Open ;
      DataSource3.DataSet := vQueryLog ;
    End ; // With vQueryLog do
  End Else // If (pQuery = Nil) And (...
  Begin
    If (vMTLog = Nil) Then
      vMTLog := TMemoryTable.Create(Screen) ;

    With vMTLog Do
    Begin
      If vMTLog.FieldCount = 0 Then
      Begin
        Name := 'vMTLog' ;
        FieldDefs.Clear ;
        FieldDefs.Add('REFERENCIA',  ftString,    30,False) ;
        FieldDefs.Add('SQL',         ftString,  4000,False) ;
        FieldDefs.Add('PARAMETRO',   ftString,    50,False) ;
        FieldDefs.Add('VALPARAMETRO',ftString,    40,False) ;
        CreateTable ;
        Open ;
      End ; // If vMTLog.FieldCount = 0 Then

      While Locate('REFERENCIA',pReferencia,[LocaseInsensitive]) do
        Delete ;

      For i := 0 to pQuery.ParamCount-1 do
      Begin
        Append ;
        FieldByName('REFERENCIA'  ).AsString := pReferencia ;
        FieldByName('SQL'         ).AsString := pQuery.SQL.Text ;
        FieldByName('PARAMETRO'   ).AsString := pQuery.Params.Items[i].Name ;
        FieldByName('VALPARAMETRO').AsString := pQuery.Params.Items[i].Text ;
        Post ;
      End ; // For i := 0 to pQuery.ParamCount-1 do
    End ; // With vMTLog Do
    DataSource2.DataSet := vMTLog ;
  End ; // End Else // If (pQuery = Nil) And (...
end;

procedure TForm1.LeClick(Sender: TObject);
Var
  i : Integer ;
begin
  db1.Connected := True ;

  With Query1 do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT') ;
    Sql.Add(' A.CODINTPEDIDO,') ;
    Sql.Add(' LPAD(A.NUMEROPEDI,10,0) AS NUMEROPEDI,') ;
    Sql.Add(' A.DATAPEDI,') ;
    Sql.Add(' A.STATUSPEDI,') ;
    Sql.Add(' A.PERCURSONFPEDI') ;
    Sql.Add(' FROM') ;
    Sql.Add(' TUR_PEDIDO     A,') ;
    Sql.Add(' TUR_ITEMPEDIDO B,') ;
    Sql.Add(' T_TRF_AGENCIA  C,') ;
    Sql.Add(' BGM_CLIENTE    D,') ;
    Sql.Add(' TUR_CIDADE     E') ;
    Sql.Add(' WHERE') ;
    Sql.Add(' A.CODINTPEDIDO    = B.CODINTPEDIDO    AND') ;
    Sql.Add(' A.COD_SEQ_AGENCIA = C.COD_SEQ_AGENCIA AND') ;
    Sql.Add(' A.CODCLI          = D.CODCLI          AND') ;
    Sql.Add(' B.CODIGOCIDADE    = E.CODIGOCIDADE    AND') ;
    Sql.Add(' C.COD_AGENCIA  BETWEEN :P_AGENCIAINI   AND :P_AGENCIAFIN AND') ;
    Sql.Add(' A.NUMEROPEDI   BETWEEN :P_PEDIDOINI    AND :P_PEDIDOFIN  AND') ;
    Sql.Add(' D.NRCLI        BETWEEN :P_CLIENTEINI   AND :P_CLIENTEFIN AND') ;
    Sql.Add(' B.CODIGOCIDADE BETWEEN :P_CIDADEINI    AND :P_CIDADEFIN  AND') ;
    Sql.Add(' B.CODIGOAGRUP  BETWEEN :P_MODCARROCINI AND :P_MODCARROCFIN' ) ;
    ParamByName('P_AGENCIAINI'  ).AsString   := '!' ;
    ParamByName('P_AGENCIAFIN'  ).AsString   := 'zzzzzz' ;
    ParamByName('P_PEDIDOINI'   ).AsFloat    := 0 ;
    ParamByName('P_PEDIDOFIN'   ).AsFloat    := 9999999999 ;
    ParamByName('P_CLIENTEINI'  ).AsString   := '!' ;
    ParamByName('P_CLIENTEFIN'  ).AsString   := 'zzzzzzz' ;
    ParamByName('P_CIDADEINI'   ).AsString   := '!' ;
    ParamByName('P_CIDADEFIN'   ).AsString   := 'zzzzzzz' ;
    ParamByName('P_MODCARROCINI').AsInteger  := 0 ;
    ParamByName('P_MODCARROCFIN').AsInteger  := 999 ;
    Open ;
  End ; // While Query1 do
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  GravaLog('QueryPrincipal',Query1) ;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GravaLog('QueryPrincipal') ;
end;

end.
