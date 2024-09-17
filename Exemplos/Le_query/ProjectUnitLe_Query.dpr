program ProjectUnitLe_Query;

uses
  Forms,
  UnitLe_Query in 'UnitLe_Query.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
