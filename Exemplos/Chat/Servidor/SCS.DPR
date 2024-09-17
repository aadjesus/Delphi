program Scs;

uses
  Forms,
  Unit_Server_Main in 'Unit_Server_Main.pas' {Form_Server_Main};

{$E exe}

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TForm_Server_Main, Form_Server_Main);
  Application.Run;
end.
