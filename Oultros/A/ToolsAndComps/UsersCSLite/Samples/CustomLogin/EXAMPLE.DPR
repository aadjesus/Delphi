program example;

uses
  Forms,
  main in 'main.pas' {Form1},
  custom_login in 'custom_login.pas' {frmCustomLogin};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
