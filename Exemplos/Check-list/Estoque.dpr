program Estoque;

uses
  Forms,
  MenuPrincipal in 'MenuPrincipal.pas' {FrmMenuPrincipal},
  Checklist in 'Checklist.pas' {FrmCheckList},
  Tela1 in 'Tela1.pas' {FrmTela1},
  Tela2 in 'Tela2.pas' {FrmTela2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMenuPrincipal, FrmMenuPrincipal);
  Application.CreateForm(TFrmCheckList, FrmCheckList);
  Application.CreateForm(TFrmTela1, FrmTela1);
  Application.CreateForm(TFrmTela2, FrmTela2);
  Application.Run;
end.
