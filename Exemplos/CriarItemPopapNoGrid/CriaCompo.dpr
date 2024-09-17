program CriaCompo;

uses
  Forms,
  UCriaCompo in 'UCriaCompo.pas' {Form1},
  UCriaCompoFunc in 'UCriaCompoFunc.pas',
  MenuItemPesquisa in 'MenuItemPesquisa.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
