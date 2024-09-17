unit UnitLoat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Okk, DBTables, Grids, DBGrids, ExtCtrls, Db, RxMemDS,
  Mask, TimeEdit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    db1: TDatabase;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edUsuario: TEdit;
    edSenha: TEdit;
    edServidor: TEdit;
    RxMemoryData1: TRxMemoryData;
    Query1: TQuery;
    DataSource1: TDataSource;
    Panel3: TPanel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TEdtMDInicial: TTimeEdit;
    TEdtMDFinal: TTimeEdit;
    TEdtMDTotal: TTimeEdit;
    ButtonRX: TButton;
    TEdtQyInicial: TTimeEdit;
    TEdtQyFinal: TTimeEdit;
    TEdtQyTotal: TTimeEdit;
    ButtonQuery: TButton;
    Label8: TLabel;
    EdtTabela: TEdit;
    Label9: TLabel;
    EdtOrderBy: TEdit;
    procedure ButtonRXClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

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

  Query1.Close ;
  Query1.Sql.Clear ;

  Query1.Sql.Add('SELECT * FROM ' + Trim(EdtTabela.Text) ) ;
  Try
    Begin

      If TButton(Sender).Name = 'ButtonRX' Then
      Begin
        TEdtMDInicial.TimeValue := Time ;
        Query1.Open ;
        RxMemoryData1.LoadFromDataSet(Query1,0,lmCopy) ;
        RxMemoryData1.SortOnFields( StringReplace(Trim(EdtOrderBy.Text),',',';',[rfReplaceAll,rfIgnoreCase])) ;
        DataSource1.DataSet   := RxMemoryData1 ;
        TEdtMDFinal.TimeValue := Time ;
        TEdtMDTotal.TimeValue := (TEdtMDFinal.TimeValue - TEdtMDInicial.TimeValue) ;
      End Else // If TButton(Sender).Name = 'ButtonRX' Then
      Begin
        TEdtQyInicial.TimeValue := Time ;
        Query1.Sql.Add('ORDER BY '+ Trim(EdtOrderBy.Text)) ;
        Query1.Open ;
        DataSource1.DataSet   := Query1 ;
        TEdtQyFinal.TimeValue := Time ;
        TEdtQyTotal.TimeValue := (TEdtQyFinal.TimeValue - TEdtQyInicial.TimeValue) ;
      End ; // End Else // If TButton(Sender).Name = 'ButtonRX' Then

      {
      TEdtMDInicial.TimeValue := Time ;
      If TButton(Sender).Name = 'ButtonRX' Then
        Query1.Open ;
//      Else
//        TUpdateSQL(Query1.Active) ;
      }
      DataSource1.DataSet   := Query1 ;
      TEdtMDFinal.TimeValue := Time ;
      TEdtMDTotal.TimeValue := (TEdtMDFinal.TimeValue - TEdtMDInicial.TimeValue) ;


      Query1.Sql.SaveToFile(ExtractFilePath(Application.Exename)+ 'SQL_'+ TButton(Sender).Caption +'.SQL');
    End ;
  Except
    ShowMessage('ERRO') ;
  End ; // Try - Except
end;

end.
