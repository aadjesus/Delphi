program MovimentaSelecao2;

uses
  Forms,
  unMovimentaSelecao2 in 'unMovimentaSelecao2.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
