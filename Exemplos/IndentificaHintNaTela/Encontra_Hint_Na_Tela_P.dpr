program Encontra_Hint_Na_Tela_P;

uses
  Forms,
  Encontra_Hint_Na_Tela_U in 'Encontra_Hint_Na_Tela_U.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
