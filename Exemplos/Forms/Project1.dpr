program Project1;

uses
  Forms,
  fprincipal in 'fprincipal.pas' {FormPrincipal},
  tela1 in 'tela1.pas' {Form2},
  tela2 in 'tela2.pas' {Form3},
  tela3 in 'tela3.pas' {Form4},
  about in 'about.pas' {FormAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
