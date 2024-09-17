program AtualizaModulo;

uses
  Forms,
  UnitAtualizaModulo in 'UnitAtualizaModulo.pas' {FrmAtualizaModulo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmAtualizaModulo, FrmAtualizaModulo);
  Application.Run;
end.
