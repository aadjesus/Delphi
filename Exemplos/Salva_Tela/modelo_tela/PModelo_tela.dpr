program PModelo_tela;

uses
  Forms,
  CTREnviarEMailDaTela in 'CTREnviarEMailDaTela.pas' {FrmCTREnviarEMailDaTela};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCTREnviarEMailDaTela, FrmCTREnviarEMailDaTela);
  Application.Run;
end.
