program Project1;

uses
  Forms,
  Tela_de_Alteracoes in 'Tela_de_Alteracoes.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
