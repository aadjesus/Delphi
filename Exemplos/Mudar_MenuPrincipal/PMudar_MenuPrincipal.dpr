program PMudar_MenuPrincipal;

uses
  Forms,
  UMudar_MenuPrincipal in 'UMudar_MenuPrincipal.pas' {Form1},
  UMudar_MenuPrincipalTela1 in 'UMudar_MenuPrincipalTela1.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
