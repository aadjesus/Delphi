program Project1;

uses
  Forms,
  TESTE in 'TESTE.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
