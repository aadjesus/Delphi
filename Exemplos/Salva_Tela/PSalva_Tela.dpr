program PSalva_Tela;

uses
  Forms,
  USalva_Tela in 'USalva_Tela.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
