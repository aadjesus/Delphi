program Psalvajanelativa4;

uses
  Forms,
  salvajanela in 'salvajanela.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
