program desenhando;

uses
  Forms,
  udesenhando in 'udesenhando.pas' {FrmCTR_EnviarEMailDaTela};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCTR_EnviarEMailDaTela, FrmCTR_EnviarEMailDaTela);
  Application.Run;
end.
