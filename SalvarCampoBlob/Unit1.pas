unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    DB: TDatabase;
    Query1: TQuery;
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

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   m : TQuery;
begin

end;
procedure TForm1.Button2Click(Sender: TObject);
var
   m : TQuery;
begin
     if OpenDialog1.Execute then
     begin
          DB.Connected := False ;
          DB.Connected := True ;
          try
             Query1.ParamByName('p_CAMPO_BLOB').LoadFromFile(OpenDialog1.FileName,ftBlob);
             Query1.ExecSQL;
          except
               on e:exception do
               begin
                    ShowMessage(e.message);
               end;
          end;
     end;
end;

end.
