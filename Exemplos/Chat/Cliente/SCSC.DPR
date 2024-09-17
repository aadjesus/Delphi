program ScsC;

uses
  Forms,
  Unit_Client_Main in 'Unit_Client_Main.pas' {Form_Client_Main};

{$E exe}

{$R *.RES}

begin
   Application.Initialize;
   Application.Title := 'LMChat - Versão Cliente Ativa';
  Application.CreateForm(TForm_Client_Main, Form_Client_Main);
  Application.Run;
end.
