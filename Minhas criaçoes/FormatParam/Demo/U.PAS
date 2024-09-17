unit U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ComCtrls, ToolWin, Mask, ToolEdit, FormatParam;

type
  TForm1 = class(TForm)
    Query1: TQuery;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    FormatParam1: TFormatParam;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
Var
  FormatParam2 : TFormatParam ;
begin
  FormatParam2:= TFormatParam.Create(self) ;
  Query1.SQL.Clear ;
  FormatParam2.Query := Query1 ;

  FormatParam2.Parametros.Add ;
  FormatParam2.Parametros.Items[0] ;
  FormatParam2.Parametros.Items[0].NomeCampo := 'A.CAMPO1' ;
  FormatParam2.Parametros.Items[0].CampoIni  := Edit1 ;
  FormatParam2.Parametros.Items[0].CampoFin  := Edit2 ;
  FormatParam2.Parametros.Items[0].TextoLog  := 'Campo-1' ;
  FormatParam2.Parametros.Items[0].TipoCampo := tpString ;

  FormatParam2.Parametros.Add ;
  FormatParam2.Parametros.Items[1] ;
  FormatParam2.Parametros.Items[1].NomeCampo := 'A.CAMPO2' ;
  FormatParam2.Parametros.Items[1].CampoIni  := DateEdit1 ;
  FormatParam2.Parametros.Items[1].CampoFin  := DateEdit2 ;
  FormatParam2.Parametros.Items[1].TextoLog  := 'Periodo campo-2,Data campo-2' ;
  FormatParam2.Parametros.Items[1].TipoCampo := tpDate ;

  FormatParam2.Parametros.Add ;
  FormatParam2.Parametros.Items[2] ;
  FormatParam2.Parametros.Items[2].NomeCampo := 'A.CAMPO3' ;
  FormatParam2.Parametros.Items[2].CampoIni  := MaskEdit1 ;
  FormatParam2.Parametros.Items[2].CampoFin  := MaskEdit2 ;
  FormatParam2.Parametros.Items[2].TextoLog  := 'Campo-3' ;
  FormatParam2.Parametros.Items[2].TipoCampo := tpInteger ;

  FormatParam2.Execute ;
  Memo1.Text := Query1.Text ;
  Memo2.Text := FormatParam2.TextoLog ;
  FormatParam2.Free ;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Query1.SQL.Clear ;
  FormatParam1.Execute ;
  Memo1.Text := Query1.Text ;
  Memo2.Text := FormatParam1.TextoLog ;
end;

end.
